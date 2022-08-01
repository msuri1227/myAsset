//
//   swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/26/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//



import UIKit
import AssetsLibrary
import MediaPlayer
import AVKit
import MobileCoreServices
import AVFoundation
import UserNotifications
import ODSFoundation
import mJCLib

class AttachmentsCell: UITableViewCell {
    
    @IBOutlet var fileImage: UIImageView!
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var fileSizeLabel: UILabel!
    @IBOutlet var fileDescriptionLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet weak var downloadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var attachmentClickButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    var attachmentModelClass:AttachmentModel?{
        didSet{
            configureAttachmentsCell()
        }
    }
    var uploadedAttachmentsModelClass:UploadedAttachmentsModel?{
        didSet{
            configureUploadedAttachmentsCell()
        }
    }
    var indexPath = IndexPath()
    var attachmentsViewModel = AttachmentsViewModel()
    var notifiAttachmentsViewModel = NotificationAttachmentViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureAttachmentsCell(){
        mJCLogger.log("Starting", Type: "info")
        if let attachmentClass = attachmentModelClass{
            if currentMasterView == "WorkOrder"{
                if attachmentsViewModel.attachementArray.indices.contains(indexPath.row){
                    mJCLogger.log("Response:\(attachmentsViewModel.attachementArray.count)", Type: "Debug")
                    let attachmentClass = attachmentsViewModel.attachementArray[indexPath.row]
                    fileNameLabel.text = attachmentClass.CompID
                    deleteButton.isHidden = false
                    if attachmentClass.CompSize != "" {

                        let size = ((Float(attachmentClass.CompSize)!/1024.0)/1024.0)
                        fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + "MB"
                    }else {
                        fileSizeLabel.text = "0 " + "MB"
                    }
                    fileDescriptionLabel.text = attachmentClass.PropValue
                    if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                        fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeJPG")
                    }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                        fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeVideo")
                    }else if attachmentClass.Extension.containsIgnoringCase(find: "pdf") {
                        fileImage.image = UIImage(imageLiteralResourceName: "pdf_icon")
                    }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                        fileImage.image = UIImage(imageLiteralResourceName: "doc_icon")
                    }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                        fileImage.image = UIImage(imageLiteralResourceName: "xls_icon")
                    }else{
                        fileImage.image = UIImage(imageLiteralResourceName: "file_icon")
                    }
                    if attachmentClass.isDownload {
                        downloadIndicator.isHidden = false
                        downloadIndicator.startAnimating()
                    }else {
                        downloadIndicator.isHidden = true
                        downloadIndicator.stopAnimating()
                    }
                    attachmentClickButton.tag = indexPath.row
                    attachmentClickButton.addTarget(self, action: #selector( attachmentClick(sender:)), for: .touchUpInside)
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                if DeviceType == iPhone {
                    bgView.layer.cornerRadius = 3.0
                    bgView.layer.shadowOffset = CGSize(width: 3, height: 3)
                    bgView.layer.shadowOpacity = 0.2
                    bgView.layer.shadowRadius = 2
                    bgView.backgroundColor = UIColor(named: "mjcViewBgColor")
                }
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( imageTapped(tapGestureRecognizer:)))
                fileImage.isUserInteractionEnabled = true
                fileImage.addGestureRecognizer(tapGestureRecognizer)
                fileImage.tag = indexPath.row
                deleteButton.tag = indexPath.row
                deleteButton.addTarget(self, action: #selector( deleteAttachment(sender:)), for: .touchUpInside)
            }else{
                if DeviceType == iPhone {
                    bgView.layer.cornerRadius = 3.0
                    bgView.layer.shadowOffset = CGSize(width: 3, height: 3)
                    bgView.layer.shadowOpacity = 0.2
                    bgView.layer.shadowRadius = 2
                    bgView.backgroundColor = UIColor(named: "mjcViewBgColor")
                }
                fileNameLabel.text = attachmentClass.CompID
                if attachmentClass.CompSize != "" {

                    let size = ((Float(attachmentClass.CompSize)!/1024.0)/1024.0)
                    fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + "MB"
                }else {
                    fileSizeLabel.text = "0 " + "MB"
                }
                fileDescriptionLabel.text = attachmentClass.PropValue
                if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeJPG")
                }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeVideo")
                }else if attachmentClass.Extension.containsIgnoringCase(find: "pdf") {
                    fileImage.image = UIImage(imageLiteralResourceName: "pdf_icon")
                }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "doc_icon")
                }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "xls_icon")
                }else{
                    fileImage.image = UIImage(imageLiteralResourceName: "file_icon")
                }
                if attachmentClass.isDownload == true {
                    downloadIndicator.isHidden = false
                    downloadIndicator.startAnimating()
                }else {
                    downloadIndicator.isHidden = true
                    downloadIndicator.stopAnimating()
                }
                attachmentClickButton.tag = indexPath.row
                attachmentClickButton.addTarget(self, action: #selector(attachmentClick(sender:)), for: .touchUpInside)
                deleteButton.isHidden = false
                deleteButton.tag = indexPath.row
                deleteButton.addTarget(self, action: #selector(deleteAttachment(sender:)), for: .touchUpInside)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                fileImage.isUserInteractionEnabled = true
                fileImage.addGestureRecognizer(tapGestureRecognizer)
                fileImage.tag = indexPath.row
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func configureUploadedAttachmentsCell(){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder"{
            deleteButton.isHidden = false
            if attachmentsViewModel.uploadedAttachmentArray.count != 0 {
                mJCLogger.log("Response:\(attachmentsViewModel.uploadedAttachmentArray.count)", Type: "Debug")
                let uploadedAttachmentsclass = attachmentsViewModel.uploadedAttachmentArray[indexPath.row]
                if DeviceType == iPhone {
                    bgView.layer.cornerRadius = 3.0
                    bgView.layer.shadowOffset = CGSize(width: 3, height: 3)
                    bgView.layer.shadowOpacity = 0.2
                    bgView.layer.shadowRadius = 2
                    bgView.backgroundColor = UIColor(named: "mjcViewBgColor")
                }
                if uploadedAttachmentsclass.FILE_NAME == "" {
                    fileNameLabel.text = "File_Name".localized()
                }else {
                    fileNameLabel.text = uploadedAttachmentsclass.FILE_NAME
                }
                if uploadedAttachmentsclass.FILE_SIZE != "" {
                    DispatchQueue.main.async {
                        let size = ((Float(uploadedAttachmentsclass.FILE_SIZE)!/1024.0)/1024.0)
                        self.fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + "MB"
                    }
                }else {
                    fileSizeLabel.text = "0 " + "MB"
                }
                fileDescriptionLabel.text = uploadedAttachmentsclass.Description
                if imgExtensions.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeJPG")
                }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeVideo")
                }
                //                    else if attachmentClass.Extension.containsIgnoringCase(find: "pdf") {
                //                        fileImage.image = UIImage(imageLiteralResourceName: "pdf_icon")
                //                    }
                else if docExtensions.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "doc_icon")
                }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "xls_icon")
                }else{
                    fileImage.image = UIImage(imageLiteralResourceName: "file_icon")
                }

                downloadIndicator.isHidden = true
                deleteButton.tag = indexPath.row
                deleteButton.addTarget(self, action: #selector( deleteUploadedAttachment(sender:)), for: .touchUpInside)
                attachmentClickButton.tag = indexPath.row
                attachmentClickButton.addTarget(self, action: #selector( uploadClick(sender:)), for: .touchUpInside)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( uploadimageTapped(tapGestureRecognizer:)))
                fileImage.isUserInteractionEnabled = true
                fileImage.addGestureRecognizer(tapGestureRecognizer)
                fileImage.tag = indexPath.row

            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            if notifiAttachmentsViewModel.uploadedAttachmentArray.indices.contains(indexPath.row) {
                mJCLogger.log("Response:\(notifiAttachmentsViewModel.uploadedAttachmentArray.count)", Type: "Debug")
                let uploadedAttachmentsclass = notifiAttachmentsViewModel.uploadedAttachmentArray[indexPath.row]
                if DeviceType == iPhone {
                    bgView.layer.cornerRadius = 3.0
                    bgView.layer.shadowOffset = CGSize(width: 3, height: 3)
                    bgView.layer.shadowOpacity = 0.2
                    bgView.layer.shadowRadius = 2
                    bgView.backgroundColor = UIColor(named: "mjcViewBgColor")
                }
                if uploadedAttachmentsclass.FILE_NAME == "" {
                    fileNameLabel.text = "File_Name".localized()
                }else {
                    fileNameLabel.text = uploadedAttachmentsclass.FILE_NAME
                }
                if uploadedAttachmentsclass.FILE_SIZE != "" {
                    DispatchQueue.main.async {
                        let size = ((Float(uploadedAttachmentsclass.FILE_SIZE)!/1024.0)/1024.0)
                        self.fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + "MB"
                    }
                }else {
                    fileSizeLabel.text = "0 " + "MB"
                }
                fileDescriptionLabel.text = uploadedAttachmentsclass.Description
                if imgExtensions.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeJPG")
                }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "ic_ImageTypeVideo")
                }
                //                    else if attachmentClass.Extension.containsIgnoringCase(find: "pdf") {
                //                        fileImage.image = UIImage(imageLiteralResourceName: "pdf_icon")
                //                    }
                else if docExtensions.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "doc_icon")
                }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(uploadedAttachmentsclass.MIMETYPE) == .orderedSame}){
                    fileImage.image = UIImage(imageLiteralResourceName: "xls_icon")
                }else{
                    fileImage.image = UIImage(imageLiteralResourceName: "file_icon")
                }
                downloadIndicator.isHidden = true
                deleteButton.isHidden = false
                deleteButton.tag = indexPath.row
                deleteButton.addTarget(self, action: #selector(deleteUploadedAttachment(sender:)), for: .touchUpInside)
                attachmentClickButton.tag = indexPath.row
                attachmentClickButton.addTarget(self, action: #selector(uploadClick(sender:)), for: .touchUpInside)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadimageTapped(tapGestureRecognizer:)))
                fileImage.isUserInteractionEnabled = true
                fileImage.addGestureRecognizer(tapGestureRecognizer)
                fileImage.tag = indexPath.row
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        mJCLogger.log("Starting", Type: "info")
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(tappedImage.tag)
        let btn = UIButton()
        btn.tag = tappedImage.tag
        self.attachmentClick(sender: btn)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func uploadimageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        mJCLogger.log("Starting", Type: "info")
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(tappedImage.tag)
        let btn = UIButton()
        btn.tag = tappedImage.tag
        self.uploadClick(sender: btn)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Attachment Delete Button Action..
    @objc func deleteAttachment(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder"{
            if isActiveWorkOrder == true{
                if deletionValue == true {
                    let params = Parameters(
                        title: alerttitle,
                        message: "Are_you_sure_you_want_to_delete".localized(),
                        cancelButton: "Cancel".localized(),
                        otherButtons: [okay]
                    )
                    mJCAlertHelper.showAlertWithHandler(attachmentsViewModel.vc!, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            mJCLogger.log("deleteAttachment".localized(), Type: "Debug")
                            self.attachmentsViewModel.deleteUploadedAttachmentRecord(tag: self.indexPath.row, from: "")
                        default: break
                        }
                    }
                }else {
                    attachmentsViewModel.deleteUploadedAttachmentRecord(tag:indexPath.row, from: "")
                }
            }else {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    mJCAlertHelper.showAlert(attachmentsViewModel.vc!, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                }else{
                    mJCAlertHelper.showAlert(attachmentsViewModel.vc!, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                }
            }
        }else{
            mJCLogger.log("deleteAttachment".localized(), Type: "Debug")
            if deletionValue == true {
                let params = Parameters(
                    title: alerttitle,
                    message: "Are_you_sure_you_want_to_delete".localized(),
                    cancelButton: "Cancel".localized(),
                    otherButtons: [okay]
                )
                mJCAlertHelper.showAlertWithHandler(notifiAttachmentsViewModel.vcNotification!, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: break
                    case 1:
                        self.notifiAttachmentsViewModel.deleteUploadedAttachmentRecord(tag: self.indexPath.row, from: "")
                    default: break
                    }
                }
            }else{
                notifiAttachmentsViewModel.deleteUploadedAttachmentRecord(tag: indexPath.row, from: "")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func deleteUploadedAttachment(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder"{
            if isActiveWorkOrder == true{
                if deletionValue == true {
                    let params = Parameters(
                        title: alerttitle,
                        message: "Are_you_sure_you_want_to_delete".localized(),
                        cancelButton: "Cancel".localized(),
                        otherButtons: [okay]
                    )
                    mJCAlertHelper.showAlertWithHandler(attachmentsViewModel.vc!, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            mJCLogger.log("deleteUploadedAttachment".localized(), Type: "Debug")
                            self.attachmentsViewModel.deleteUploadedAttachmentRecord(tag: self.indexPath.row, from: "Upload")
                        default: break
                        }
                    }
                }else {
                    attachmentsViewModel.deleteUploadedAttachmentRecord(tag: indexPath.row, from: "Upload")
                }
            }else {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    mJCAlertHelper.showAlert(attachmentsViewModel.vc!, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                }else{
                    mJCAlertHelper.showAlert(attachmentsViewModel.vc!, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                }
            }
        }else{
            mJCLogger.log("deleteUploadedAttachment".localized(), Type: "")
            if deletionValue == true {
                let params = Parameters(
                    title: alerttitle,
                    message: "Are_you_sure_you_want_to_delete".localized(),
                    cancelButton: "Cancel".localized(),
                    otherButtons: [okay]
                )
                mJCAlertHelper.showAlertWithHandler(notifiAttachmentsViewModel.vcNotification!, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: break
                    case 1:
                        self.notifiAttachmentsViewModel.deleteUploadedAttachmentRecord(tag: self.indexPath.row, from: "Upload")
                    default: break
                    }
                }
            }else {
                notifiAttachmentsViewModel.deleteUploadedAttachmentRecord(tag: indexPath.row, from: "Upload")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func attachmentClick(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder"{
            let attachmentClass = attachmentsViewModel.attachementArray[indexPath.row]
            
            let url = NSURL(fileURLWithPath: documentPath)
            var filePath : String?
            if demoModeEnabled == true{
                filePath = url.appendingPathComponent("DemoStores/Download")?.path
            }else{
                filePath = url.appendingPathComponent("Download")?.path
            }
            mJCLogger.log("Response:\(String(describing: filePath))", Type: "Debug")
            
            do {
                try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                print(error.localizedDescription);
            }
            mJCLogger.log("Downloading_is_in_progress".localized(), Type: "Debug")
            if attachmentClass.isDownload
            {
                let params = Parameters(
                    title: "Please_Wait".localized(),
                    message: "Downloading_is_in_progress".localized(),
                    cancelButton: "Cancel".localized()
                )
                mJCAlertHelper.showAlertWithHandler(attachmentsViewModel.vc!, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: break
                    default: break
                    }
                }
            }else{
                
                let url = NSURL(fileURLWithPath: documentPath)
                var filePath : String?
                if demoModeEnabled == true{
                    filePath = url.appendingPathComponent("DemoStores/Download/\(String(describing: attachmentsViewModel.vc!.objectNum))")?.path
                }else{
                    filePath = url.appendingPathComponent("Download/\(String(describing: attachmentsViewModel.vc!.objectNum))")?.path
                }
                mJCLogger.log("Response:\(String(describing: filePath))", Type: "Debug")
                if !myAsset.fileManager.fileExists(atPath: filePath!){
                    
                    let documentsDirectory: AnyObject = documentPath as AnyObject
                    let folderName = attachmentsViewModel.vc!.objectNum.replacingOccurrences(of: "/", with: "_")
                    filePath = documentsDirectory.appendingPathComponent("Download/\(folderName)")
                    do {
                        try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
                    }
                    catch let error as NSError {
                        mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                        print(error.localizedDescription);
                        
                    }
                }
                let newfilePath: String! = "\(filePath!)/\(attachmentClass.CompID)"
                mJCLogger.log("Response:\(String(describing: newfilePath))", Type: "Debug")
                if (attachmentClass.CompID != "") {
                    if myAsset.fileManager.fileExists(atPath: newfilePath) {
                        if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}) || imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.MimeType) == .orderedSame}){
                            let pnggetdata = NSData(contentsOfFile: newfilePath)
                            let getimage = UIImage(data: pnggetdata! as Data)
                            if getimage != nil {
                                menuDataModel.uniqueInstance.presentAttachmentViewerScreen(vc: attachmentsViewModel.vc!, attachmentImage: getimage!)
                            }else{
                                mJCLogger.log("Something_went_wrong_please_try_again".localized(), Type: "Error")
                                mJCAlertHelper.showAlert(attachmentsViewModel.vc!, title:errorTitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
                            }
                        }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}) || attachmentClass.CompID.containsIgnoringCase(find: ".MOV"){
                            DispatchQueue.main.async {
                                let url : NSURL = NSURL(fileURLWithPath: newfilePath)
                                let player = AVPlayer(url: url as URL)
                                let playerViewController = AVPlayerViewController()
                                playerViewController.player = player
                                self.attachmentsViewModel.vc!.present(playerViewController, animated: true) {
                                    playerViewController.player!.play()
                                }
                            }
                        }else if attachmentClass.Extension.containsIgnoringCase(find:"pdf") || docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}) || excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentClass.Extension) == .orderedSame}){
                            let url2 = NSURL(fileURLWithPath: newfilePath)
                            menuDataModel.uniqueInstance.presentAttachmentViewerScreen(vc: attachmentsViewModel.vc!, attachmentType: "pdf", pdfUrl: url2)
                        }else{
                            let url : NSURL = NSURL(fileURLWithPath: newfilePath)
                            attachmentsViewModel.documentController = UIDocumentInteractionController(url: url as URL)
                            attachmentsViewModel.documentController.presentOptionsMenu(from: sender.frame, in:attachmentsViewModel.vc!.view, animated:true)
                        }
                    }else {
                        mJCLoader.startAnimating(status: "Please_Wait".localized())
                        let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                        dispatchQueue.async{
                            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                            if result == "ServerUp"{
                                self.attachmentsViewModel.vc!.sendnotification(title: "started")
                                attachmentClass.isDownload = true
                                let httpConvMan1 = HttpConversationManager.init()
                                let commonfig1 = CommonAuthenticationConfigurator.init()
                                if authType == "Basic"{
                                    commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                                }else if authType == "SAML"{
                                    commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                                }
                                commonfig1.configureManager(httpConvMan1)
                                var objcetKey = String()
                                if "\(self.attachmentsViewModel.vc!.fromScreen)" == "FUNCTIONALLOCATION"{
                                    objcetKey = "''"
                                }else{
                                    objcetKey = "\(self.attachmentsViewModel.vc!.objectNum)"
                                }
                                let workorderDict = attachmentContentModel.downloadWoAttachmentContent(DocID: "\(attachmentClass.DocId)", objectNum: "\(objcetKey)", httpConvManager: httpConvMan1!)
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
                                                        self.attachmentsViewModel.vc!.urlView.isHidden = false
                                                        self.attachmentsViewModel.vc!.urlTextView.text = line
                                                        self.attachmentsViewModel.vc!.urlTextView.isUserInteractionEnabled = false
                                                        self.attachmentsViewModel.vc!.urlDescriptionTextField.isUserInteractionEnabled = false
                                                        self.attachmentsViewModel.vc!.urlUploadButton.isHidden = true
                                                        self.attachmentsViewModel.vc!.urlPasteButton.isHidden = true
                                                    }
                                                }else{
                                                    let line = att.Line
                                                    let binaryData = line.dataFromHexadecimalString()
                                                    do {
                                                        try binaryData?.write(to: URL(fileURLWithPath: newfilePath), options: .atomic)
                                                        self.attachmentsViewModel.vc!.sendnotification(title: "Completed")
                                                        attachmentClass.isDownload = false
                                                        DispatchQueue.main.async{
                                                            self.attachmentsViewModel.vc!.attachmentTableView.reloadData()
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
                                        mJCAlertHelper.showAlert(self.attachmentsViewModel.vc!, title:alerttitle, message: "\(workorderDict["Error"] as? String ?? "Something_went_wrong_please_try_again".localized())", button: okay)
                                    }
                                }
                            }else if result == "ServerDown"{
                                mJCLogger.log("Unable_to_connect_with_server".localized(), Type: "Debug")
                                mJCAlertHelper.showAlert(self.attachmentsViewModel.vc!, title:alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
                            }else{
                                mJCLogger.log("The_Internet_connection_appears_to_be_offline".localized(), Type: "Debug")
                                mJCAlertHelper.showAlert(self.attachmentsViewModel.vc!, title:alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
                            }
                            mJCLoader.stopAnimating()
                        }
                    }
                }
                attachmentsViewModel.vc!.attachmentTableView.reloadData()
            }
        }else{
            notifiAttachmentsViewModel.attachmentDownload(index: indexPath.row, sender: sender)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func uploadClick(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder" {
            let uploadedAttachmentsclass = attachmentsViewModel.uploadedAttachmentArray[indexPath.row]
            if uploadedAttachmentsclass.URL != "" {
                DispatchQueue.main.async{
                    self.attachmentsViewModel.vc!.urlView.isHidden = false
                    self.attachmentsViewModel.vc!.urlTextView.text = uploadedAttachmentsclass.URL
                    self.attachmentsViewModel.vc!.urlTextView.isUserInteractionEnabled = false
                    self.attachmentsViewModel.vc!.urlDescriptionTextField.isUserInteractionEnabled = false
                    self.attachmentsViewModel.vc!.urlUploadButton.isHidden = true
                    self.attachmentsViewModel.vc!.urlPasteButton.isHidden = true
                    if DeviceType == iPad {
                        self.attachmentsViewModel.vc!.urlDescriptionHeightConstraint.constant = 0
                    }
                }
            }
            if let decodedImageData = Data(base64Encoded: uploadedAttachmentsclass.Line, options: .ignoreUnknownCharacters) {
                if uploadedAttachmentsclass.MIMETYPE == "image/jpeg" {
                    let getimage = UIImage(data: decodedImageData)
                    if getimage != nil {
                        menuDataModel.uniqueInstance.presentAttachmentViewerScreen(vc: attachmentsViewModel.vc!, attachmentImage: getimage!)
                    }else{
                        mJCLogger.log("Something_went_wrong_please_try_again".localized(), Type: "Error")
                        mJCAlertHelper.showAlert(attachmentsViewModel.vc!, title:errorTitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
                    }
                }else if uploadedAttachmentsclass.MIMETYPE == "application/x-doctype" {
                    
                    var filePath = String()
                    
                    let url1 = NSURL(fileURLWithPath: documentPath)
                    if uploadedAttachmentsclass.Description.contains(find: "Form_"){
                        filePath = url1.appendingPathComponent("Forms")!.path
                        var nameArray = uploadedAttachmentsclass.FILE_NAME.components(separatedBy: "_")
                        if nameArray.count > 0 {
                            nameArray.removeLast()
                            var str = ""
                            for item in nameArray{
                                str = str + item + "_"
                            }
                            str.removeLast()
                            filePath = filePath.appending("/\(str).pdf")
                        }
                    }else{
                        filePath = url1.appendingPathComponent("iCloud")!.path
                        filePath = filePath.appending("/\(uploadedAttachmentsclass.FILE_NAME)")
                    }
                    let url = NSURL(fileURLWithPath: filePath)
                    let pdfViewerVC = ScreenManager.getPDFViewerScreen()
                    pdfViewerVC.pdfURL = url
                    pdfViewerVC.pdfHeaderName = uploadedAttachmentsclass.FILE_NAME as NSString
                    pdfViewerVC.modalPresentationStyle = .fullScreen
                    attachmentsViewModel.vc!.present(pdfViewerVC, animated: false){}
                }else if uploadedAttachmentsclass.MIMETYPE == "mp4" || uploadedAttachmentsclass.MIMETYPE == "application/mp4" {
                    
                    let url1 = NSURL(fileURLWithPath: documentPath)
                    var filePath = url1.appendingPathComponent("iCloud")?.path
                    filePath = filePath?.appending("/\(uploadedAttachmentsclass.FILE_NAME)")
                    let url : NSURL = NSURL(fileURLWithPath: filePath ?? "Video")
                    print ("Video  URL== ",url)
                    let player = AVPlayer(url: url as URL)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    attachmentsViewModel.vc!.present(playerViewController, animated: true) {
                        playerViewController.player!.play()
                    }
                }else if uploadedAttachmentsclass.URL != "" && uploadedAttachmentsclass.Line == ""{
                    DispatchQueue.main.async{
                        self.attachmentsViewModel.vc!.urlView.isHidden = false
                        self.attachmentsViewModel.vc!.urlTextView.text = uploadedAttachmentsclass.URL
                        self.attachmentsViewModel.vc!.urlTextView.isUserInteractionEnabled = false
                        self.attachmentsViewModel.vc!.urlDescriptionTextField.isUserInteractionEnabled = false
                        self.attachmentsViewModel.vc!.urlUploadButton.isHidden = true
                        self.attachmentsViewModel.vc!.urlPasteButton.isHidden = true
                    }
                }else{
                    let url1 = NSURL(fileURLWithPath: documentPath)
                    var filePath = url1.appendingPathComponent("iCloud")?.path
                    filePath = filePath?.appending("/\(uploadedAttachmentsclass.FILE_NAME)")
                    let url : NSURL = NSURL(fileURLWithPath: filePath!)
                    attachmentsViewModel.documentController = UIDocumentInteractionController(url: url as URL)
                    attachmentsViewModel.documentController.presentOptionsMenu(from: sender.frame, in:attachmentsViewModel.vc!.view, animated:true)
                }
            }
        }else{
            let uploadedAttachmentsclass = notifiAttachmentsViewModel.uploadedAttachmentArray[indexPath.row]
            if let decodedImageData = Data(base64Encoded: uploadedAttachmentsclass.Line, options: .ignoreUnknownCharacters) {
                if uploadedAttachmentsclass.MIMETYPE == "image/jpeg" || uploadedAttachmentsclass.MIMETYPE == "image/png" {
                    let getimage = UIImage(data: decodedImageData)
                    if getimage != nil {
                        menuDataModel.uniqueInstance.presentAttachmentViewerScreen(vc: notifiAttachmentsViewModel.vcNotification!, attachmentImage: getimage!)
                    }else{
                        mJCLogger.log("Something_went_wrong_please_try_again".localized(), Type: "Error")
                        mJCAlertHelper.showAlert(notifiAttachmentsViewModel.vcNotification!, title: errorTitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
                    }
                }else if uploadedAttachmentsclass.MIMETYPE == "application/x-doctype" {
                    let url1 = NSURL(fileURLWithPath: documentPath)
                    var filePath = url1.appendingPathComponent("iCloud")?.path
                    filePath = filePath?.appending("/\(uploadedAttachmentsclass.FILE_NAME)")
                    let url = NSURL(fileURLWithPath: filePath!)
                    let pdfViewerVC = ScreenManager.getPDFViewerScreen()
                    pdfViewerVC.pdfURL = url
                    pdfViewerVC.pdfHeaderName = uploadedAttachmentsclass.FILE_NAME as NSString
                    pdfViewerVC.modalPresentationStyle = .fullScreen
                    notifiAttachmentsViewModel.vcNotification!.present(pdfViewerVC, animated: false){}
                }else if uploadedAttachmentsclass.MIMETYPE == "mp4" || uploadedAttachmentsclass.MIMETYPE == "application/mp4" || uploadedAttachmentsclass.MIMETYPE == "MOV" {
                    let url1 = NSURL(fileURLWithPath: documentPath)
                    var filePath = url1.appendingPathComponent("iCloud")?.path
                    filePath = filePath?.appending("/\(uploadedAttachmentsclass.FILE_NAME)")
                    let url : NSURL = NSURL(fileURLWithPath: filePath ?? "Video")
                    print ("Video  URL== ",url)
                    let player = AVPlayer(url: url as URL)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    notifiAttachmentsViewModel.vcNotification!.present(playerViewController, animated: true) {
                        playerViewController.player!.play()
                    }
                }else if uploadedAttachmentsclass.URL != "" && uploadedAttachmentsclass.Line == ""{
                    DispatchQueue.main.async{
                        self.notifiAttachmentsViewModel.vcNotification!.urlView.isHidden = false
                        self.notifiAttachmentsViewModel.vcNotification!.urlTextView.text = uploadedAttachmentsclass.URL
                        self.notifiAttachmentsViewModel.vcNotification!.urlTextView.isUserInteractionEnabled = false
                        self.notifiAttachmentsViewModel.vcNotification!.urldescriptionTextField.isUserInteractionEnabled = false
                        self.notifiAttachmentsViewModel.vcNotification!.urlUploadButton.isHidden = true
                        self.notifiAttachmentsViewModel.vcNotification!.urlPasteButton.isHidden = true
                    }
                }else{
                    let url1 = NSURL(fileURLWithPath: documentPath)
                    var filePath = url1.appendingPathComponent("iCloud")?.path
                    filePath = filePath?.appending("/\(uploadedAttachmentsclass.FILE_NAME)")
                    let url : NSURL = NSURL(fileURLWithPath: filePath!)
                    notifiAttachmentsViewModel.documentController = UIDocumentInteractionController(url: url as URL)
                    notifiAttachmentsViewModel.documentController.presentOptionsMenu(from: sender.frame, in:notifiAttachmentsViewModel.vcNotification!.view, animated:true)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
