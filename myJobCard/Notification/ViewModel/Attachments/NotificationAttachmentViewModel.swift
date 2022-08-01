//
//  NotificationAttachmentViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//



import Foundation
import AssetsLibrary
import MediaPlayer
import AVKit
import MobileCoreServices
import AVFoundation
import UserNotifications
import ODSFoundation
import mJCLib

class NotificationAttachmentViewModel{
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var attachementArray = [AttachmentModel]()
    var compIDArray = [String]()
    var docPath = String()
    var imagePicked = UIImageView()
    var imageData = NSData()
    var newFileName = String()
    var vcNotification: NotificationAttachmentVC?
    weak var photoUploadEntity: SODataEntity?
    var property = NSMutableArray()
    var selectedbutton = String()
    var uploadedAttachmentArray = Array<UploadedAttachmentsModel>()
    var urlDoc = NSURL()
    var clodeFileName = String()
    var documentController : UIDocumentInteractionController!
    
    var attachmentType = String()
    
    //MARK:- Get Attachment Data..
    func getUploadAttachment(){
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        
        if vcNotification?.fromScreen == "NOTIFICATION"{
            defineQuery = "$filter=(Notification%20eq%20%27" + (vcNotification!.objectNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        }else if vcNotification?.fromScreen == "EQUIPMENT"{
            defineQuery = "$filter=(Equipment%20eq%20%27" + (vcNotification!.objectNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        }else if vcNotification?.fromScreen == "FUNCTIONALLOCATION"{
            defineQuery = "$filter=(FuncLocation%20eq%20%27" + (vcNotification!.objectNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        }else if vcNotification?.fromScreen == "NOTIFICATIONTASK"{
            if self.vcNotification!.itemNum != "0000"{
                defineQuery = "$filter=(Notification eq '\(vcNotification!.objectNum)' and Item eq '\(self.vcNotification!.itemNum)' and Task eq '\(self.vcNotification!.taskNum)' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
            }else{
                defineQuery = "$filter=(Notification eq '\(vcNotification!.objectNum)'and Task eq '\(self.vcNotification!.taskNum)' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
            }
        }
        
        UploadedAttachmentsModel.getNoUploadAttachmentListWith( filterQuery: defineQuery) { (responseDict, error)  in
            if error == nil{
                self.uploadedAttachmentArray.removeAll()
                if let responseArr = responseDict["data"] as? [UploadedAttachmentsModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        if self.vcNotification?.fromScreen == "NOTIFICATION"{
                            self.uploadedAttachmentArray = responseArr.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Task == "" && $0.Item == ""}
                        }else{
                            self.uploadedAttachmentArray = responseArr
                        }
                        for item in self.uploadedAttachmentArray{
                            if self.compIDArray.contains(item.FILE_NAME) && item.BINARY_FLG != "N" {
                                (item.entity.properties["BINARY_FLG"] as! SODataProperty).value = "N" as NSObject
                                UploadedAttachmentsModel.updateUploadedWoAttachmentEntity(entity: item.entity, flushRequired: true,options: nil){(response, error) in
                                    if error == nil{
                                        if let index = self.uploadedAttachmentArray.index(of: item){
                                            self.uploadedAttachmentArray.remove(at: index)
                                            self.vcNotification?.getUploadAttachmentUI()
                                        }
                                        mJCLogger.log("Update Done", Type: "Debug")
                                    }else{
                                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                                    }
                                }
                            }
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.vcNotification?.getUploadAttachmentUI()
                self.vcNotification?.getAttachmentUI()
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Get Attachment List..
    func getAttachment() {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        var classNameArr = [AttachmentTypeModel]()
        if vcNotification?.fromScreen == "NOTIFICATION"{
            classNameArr = attachmentTypeListArray.filter{$0.ObjectCategory == "\(self.vcNotification!.fromScreen)" && $0.ObjectType == "\(singleNotification.NotificationType)"}
            if classNameArr.count == 0{
                classNameArr = attachmentTypeListArray.filter{$0.ObjectCategory == "\(self.vcNotification!.fromScreen)" && $0.ObjectType == "X"}
            }
        }else{
            classNameArr = attachmentTypeListArray.filter{$0.ObjectCategory == "\(self.vcNotification!.fromScreen)" && $0.ObjectType == "X"}
        }
        var objectKey = String()
        if vcNotification!.fromScreen == "NOTIFICATIONTASK"{
            objectKey = "\(self.vcNotification!.objectNum)\(self.vcNotification!.itemNum)\(self.vcNotification!.taskNum)"
        }else{
            objectKey = "\(self.vcNotification!.objectNum)"
        }
        if classNameArr.count > 0{
            defineQuery = "$filter=(endswith(ObjectKey, '" + objectKey + "') eq true) and ClassName eq '\(classNameArr[0].ClassName)'&$orderby=DocCount"
            
        }else{
            defineQuery = "$filter=(endswith(ObjectKey, '" + objectKey + "') eq true)&$orderby=DocCount"
        }
        if vcNotification!.notificationFrom == "FromWorkorder" {
            AttachmentModel.getWoNoAttachmentList(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [AttachmentModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.attachementArray = responseArr
                        if responseArr.count > 0{
                            self.compIDArray.removeAll()
                            for item in self.attachementArray{
                                self.compIDArray.append(item.CompID)
                            }
                            self.getUploadAttachment()
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            self.getUploadAttachment()
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async{
                            self.getUploadAttachment()
                        }
                    }
                    self.vcNotification?.getAttachmentUI()
                }else {
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else {
            AttachmentModel.getNoAttachmentList(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [AttachmentModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.attachementArray = responseArr
                        if responseArr.count > 0{
                            self.compIDArray.removeAll()
                            for item in self.attachementArray{
                                self.compIDArray.append(item.CompID)
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    DispatchQueue.main.async{
                        self.getUploadAttachment()
                    }
                }else {
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func uploadUrlNotificationAttachment() {
        mJCLogger.log("Starting", Type: "info")
        
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "\(self.vcNotification!.urldescriptionTextField.text!)" as NSObject
        self.property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        prop!.value = "\(self.vcNotification!.urldescriptionTextField.text!)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "URL")
        prop!.value = "\(self.vcNotification!.urlTextView.text ?? "")" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = selectedNotificationNumber as NSObject
        self.property.add(prop!)
        
        if self.vcNotification!.fromScreen == "EQUIPMENT"{
            prop = SODataPropertyDefault(name: "Equipment")
            prop!.value = self.vcNotification!.objectNum as NSObject
            self.property.add(prop!)
        }else if self.vcNotification!.fromScreen == "FUNCTIONALLOCATION"{
            prop = SODataPropertyDefault(name: "FuncLocation")
            prop!.value = self.vcNotification!.objectNum as NSObject
            self.property.add(prop!)
        }
        if self.vcNotification!.fromScreen == "NOTIFICATIONTASK"{
            prop = SODataPropertyDefault(name: "Item")
            prop!.value = self.vcNotification!.itemNum as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Task")
            prop!.value = self.vcNotification!.taskNum as NSObject
            self.property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "TempID")
        if selectedNotificationNumber.contains(find: "L"){
            prop!.value = selectedNotificationNumber as NSObject
        }else{
            prop!.value = "" as NSObject
        }
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: uploadNOAttachmentContentSetEntity)
        
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("vlue: \(proper.value)")
            print("=================")
        }
        
        photoUploadEntity = entity
        
        UploadedAttachmentsModel.uploadNoAttachmentEntity(entity: photoUploadEntity!, collectionPath: uploadNOAttachmentContentSet, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Photo Upload successfully".localized(), Type: "Debug")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setAttachmentBadgeIcon"), object: false)
                DispatchQueue.main.async {
                    self.vcNotification!.urlTextView.text = ""
                    self.vcNotification!.urldescriptionTextField.text = ""
                self.vcNotification!.urlView.isHidden = true
                }
                self.getUploadAttachment()
                NotificationCenter.default.post(name:Notification.Name(rawValue: "setNotificationAttachmentCount"), object: "")
                mJCLoader.stopAnimating()
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func toAbsolutePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let dirPath = paths.first else {
            return ""
        }
        return dirPath
    }
    //MARK:- Delete timeSheet Record..
    func deleteUploadedAttachmentRecord(tag:Int,from:String)  {
        
        mJCLogger.log("Starting", Type: "info")
        var entity = SODataEntityDefault()
        if from == "Upload"{
            let uploadedAttachmentsclass = self.uploadedAttachmentArray[tag]
            entity = uploadedAttachmentsclass.entity
            (entity.properties["BINARY_FLG"] as! SODataProperty).value = "Y" as NSObject
        }else{
            let attachmentModelClass = self.attachementArray[tag]
            entity = attachmentModelClass.entity
        }
        AttachmentModel.deleteNoAttachmentEntity(entity: entity,options: nil, completionHandler: { (response, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if self.uploadedAttachmentArray.count == 0 {
                        self.vcNotification!.noUploadedAttachmentFoundLabel.isHidden = false
                    }else {
                        self.vcNotification!.noUploadedAttachmentFoundLabel.isHidden = true
                    }
                    NotificationCenter.default.post(name:Notification.Name(rawValue: "setNotificationAttachmentCount"), object: "")
                    if from == "Upload"{
                        self.uploadedAttachmentArray.remove(at: tag)
                        self.vcNotification?.getUploadAttachmentUI()
                    }else{
                        self.attachementArray.remove(at: tag)
                        self.vcNotification?.getAttachmentUI()
                    }
                    mJCLogger.log("Notification attachment deleted successfully!", Type: "Debug")
                }
            }else {
                print("record deleted fails!, try again")
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func attachmentDownload(index : Int,sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        
        let attachmentClass = self.attachementArray[index]
        
        let url = NSURL(fileURLWithPath: documentPath)
        var filePath : String?
        if demoModeEnabled == true{
            filePath = url.appendingPathComponent("DemoStores/Download")?.path
        }else{
            filePath = url.appendingPathComponent("Download")?.path
        }
        do {
            try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error.localizedDescription);
        }
        if attachmentClass.isDownload
        {
            let params = Parameters(
                title: "Please_Wait".localized(),
                message: "Downloading_is_in_progress".localized(),
                cancelButton: "Cancel".localized()
            )
            mJCAlertHelper.showAlertWithHandler(vcNotification!, parameters: params) { buttonIndex in
                switch buttonIndex {
                case 0: break
                default: break
                }
            }
        }else{
            let url = NSURL(fileURLWithPath: documentPath)
            
            var filePath : String?
            
            if demoModeEnabled == true{
                filePath = url.appendingPathComponent("DemoStores/Download/\(vcNotification!.objectNum)")?.path
            }else{
                filePath = url.appendingPathComponent("Download/\(vcNotification!.objectNum)")?.path
            }
           
            if !myAsset.fileManager.fileExists(atPath: filePath!){
                
                let documentsDirectory: AnyObject = documentPath as AnyObject
                let folderName = self.vcNotification!.objectNum.replacingOccurrences(of: "/", with: "_")
                filePath = documentsDirectory.appendingPathComponent("Download/\(folderName)")
                do {
                    try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
                }
                catch let error as NSError {
                    print(error.localizedDescription);
                }
            }
            let newfilePath: String! = "\(filePath!)/\(attachmentClass.CompID)"
            print("notification file path ==> \(newfilePath ?? "")")
            mJCLogger.log("notification file path ==> \(newfilePath ?? "")", Type: "Debug")
            if (attachmentClass.CompID != "") {
                if myAsset.fileManager.fileExists(atPath: newfilePath) {
                    if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}) {
                        let pnggetdata = NSData(contentsOfFile: newfilePath)
                        let getimage = UIImage(data: pnggetdata! as Data)
                        if getimage != nil{
                            menuDataModel.uniqueInstance.presentAttachmentViewerScreen(vc: self.vcNotification!, attachmentImage: getimage!)
                        }else{
                            mJCAlertHelper.showAlert(vcNotification!, title: alerttitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
                        }
                    }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                        DispatchQueue.main.async {
                            let url : NSURL = NSURL(fileURLWithPath: newfilePath)
                            print ("Video  URL== ",url)
                            let player = AVPlayer(url: url as URL)
                            let playerViewController = AVPlayerViewController()
                            playerViewController.player = player
                            self.vcNotification!.present(playerViewController, animated: true) {
                                playerViewController.player!.play()
                            }
                        }
                    }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}) || excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}) || attachmentClass.Extension.containsIgnoringCase(find: "pdf"){
                        let url : NSURL = NSURL(fileURLWithPath: newfilePath)
                        documentController = UIDocumentInteractionController(url: url as URL)
                        documentController.presentOptionsMenu(from: sender.frame, in:vcNotification!.view, animated:true)
                    }else{
                        let url : NSURL = NSURL(fileURLWithPath: newfilePath)
                        documentController = UIDocumentInteractionController(url: url as URL)
                        documentController.presentOptionsMenu(from: sender.frame, in:vcNotification!.view, animated:true)
                    }
                }else {
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                        if result == "ServerUp"{
                            self.vcNotification!.sendnotification(title: "started")
                            attachmentClass.isDownload = true
                            let httpConvMan1 = HttpConversationManager.init()
                            let commonfig1 = CommonAuthenticationConfigurator.init()
                            if authType == "Basic"{
                                commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                            }else if authType == "SAML"{
                                commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                            }
                            commonfig1.configureManager(httpConvMan1)
                            var objectNum = String()
                            if self.vcNotification?.fromScreen == "NOTIFICATIONTASK"{
                                objectNum = "\(self.vcNotification!.objectNum)\(self.vcNotification!.itemNum)\(self.vcNotification!.taskNum)"
                            }else if self.vcNotification?.fromScreen == "FUNCTIONALLOCATION"{
                                objectNum = "''"
                            }else{
                                objectNum = "\(self.vcNotification!.objectNum)"
                            }
                            let workorderDict =  attachmentContentModel.downloadNoAttachmentContent(DocID: "\(attachmentClass.DocId)", objectNum: "\(objectNum)", httpConvManager: httpConvMan1!)
                            if let status = workorderDict["Status"] as? String{
                                if status == "Success"{
                                    if let dict = workorderDict["Response"] as? NSMutableDictionary{
                                        let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: attachmentContentModel.self)
                                        if let responseArr = responseDict["data"] as? [attachmentContentModel],responseArr.count > 0{
                                            let att = responseArr[0]
                                            if attachmentClass.Extension == "URL" || attachmentClass.Extension == "url"{
                                                var line = att.Line
                                                line = line.replacingLastOccurrenceOfString("&KEY&", with: "")
                                                attachmentClass.isDownload = false
                                                DispatchQueue.main.async{
                                                    attachmentClass.isDownload = false
                                                    self.vcNotification!.urlView.isHidden = false
                                                    self.vcNotification!.urlTextView.text = line
                                                    self.vcNotification!.urlTextView.isUserInteractionEnabled = false
                                                    self.vcNotification!.urlUploadButton.isHidden = true
                                                    self.vcNotification!.urlPasteButton.isHidden = true
                                                }
                                            }else{
                                                let line = att.Line
                                                let binaryData = line.dataFromHexadecimalString()
                                                do {
                                                    try binaryData?.write(to: URL(fileURLWithPath: newfilePath), options: .atomic)
                                                    self.vcNotification!.sendnotification(title: "Completed")
                                                    attachmentClass.isDownload = false
                                                    DispatchQueue.main.async{
                                                        self.vcNotification!.attachmentTableView.reloadData()
                                                    }
                                                }catch{
                                                    mJCLogger.log("Reason : error downloading file", Type: "Error")
                                                    print("error downloading file")
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    attachmentClass.isDownload = false
                                    mJCAlertHelper.showAlert(self.vcNotification!, title:alerttitle, message: "\(workorderDict["Error"] as? String ?? "Something_went_wrong_please_try_again".localized())", button: okay)
                                }
                            }
                        }else if result == "ServerDown"{
                            mJCLogger.log("Unable_to_connect_with_server".localized(), Type: "Error")
                            mJCAlertHelper.showAlert(self.vcNotification!, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
                        }else{
                            mJCLogger.log("The_Internet_connection_appears_to_be_offline".localized(), Type: "Error")
                            mJCAlertHelper.showAlert(self.vcNotification!, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
                        }
                        mJCLoader.stopAnimating()
                    }
                }
            }
            vcNotification!.attachmentTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
