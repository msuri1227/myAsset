//
//  UploadAttachmentLowVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/12/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import AssetsLibrary
import AVFoundation
import ODSFoundation
import mJCLib

class UploadAttachmentLowVC: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var uploadAttachmentHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet var attachmentTypeLabel: UILabel!
    @IBOutlet var attachmentFileNameView: UIView!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var attachmentFileNameTextField: UITextField!
    @IBOutlet var fileSizeLabel: UILabel!
    @IBOutlet var uploadAttachmentbutton: UIButton!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var uploadAttachmentImage : UIImageView!
    @IBOutlet var descriptionTextfieldView: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK:- Declared Variables..
    var attachmentType = String()
    var docData = NSData()
    var docURL = String()
    var fileName = String()
    var fileSize = String()
    var fileType = String()
    var image = UIImage()
    var imgData = NSData()
    var imageURL = NSURL()
    var isfromIcloud = Bool()
    var isFromScreen = String()
    var itemNum = String()
    var taskNum = String()
    var photoUploadEntity: SODataEntity?
    var property = NSMutableArray()
    var videoData = NSData()
    var videoLink = NSURL()
    var objectNum = String()
    
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        editButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 70,bottom: 10,right: 0)
        self.property.removeAllObjects()
        attachmentFileNameTextField.isEnabled = true
        uploadAttachmentImage.image =  UIImage(data: imgData as Data)
        uploadAttachmentImage.contentMode = .scaleAspectFit
        self.uploadAttachmentImage.layer.borderWidth = 2.0
        self.uploadAttachmentImage.layer.borderColor = appColor.cgColor
        self.uploadAttachmentImage.layer.masksToBounds = true
        ODSUIHelper.setBorderToView(view:self.attachmentFileNameView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionTextfieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.descriptionTextField.delegate = self
        self.attachmentFileNameTextField.delegate = self
        self.attachmentFileNameTextField.text = fileName
        self.attachmentTypeLabel.text = fileType
        let tap = UITapGestureRecognizer(target: self, action: #selector(UploadAttachmentLowVC.handleTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
        let dateString = dateFormatter.string(from: NSDate() as Date)
        if attachmentType == "Image" {
            if isfromIcloud == true {
                if myAsset.fileManager.fileExists(atPath: docURL)
                {
                    imgData = myAsset.fileManager.contents(atPath: docURL)! as NSData
                    self.attachmentFileNameTextField.text = "IMAGE".localized() + "_\(dateString)"
                }
            }else {
                if fileType == "PNG" || fileType == "png"  {
                    imgData = image.pngData()! as NSData
                }else if fileType == "JPG" || fileType == "jpg"  {
                    imgData = image.jpegData(compressionQuality: 0.5)! as NSData
                }else {
                    imgData = image.jpegData(compressionQuality: 0.5)! as NSData
                }
            }
            self.uploadAttachmentImage.image = UIImage(data: imgData as Data)
            let size = ((Float((imgData.length))/1024.0)/1024.0)
            fileSize = String(imgData.length)
            fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + " MB"
        }else if attachmentType == "Video" {
            if isfromIcloud == true {
                if myAsset.fileManager.fileExists(atPath: docURL) {
                    videoData = myAsset.fileManager.contents(atPath: docURL)! as NSData
                    let size = ((Float((self.videoData.length))/1024.0)/1024.0)
                    self.fileSize = String(self.videoData.length)
                    self.fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + " MB"
                }
            }else {
                DispatchQueue.main.async{
                    self.videoData = try! NSData(contentsOfFile: "\(self.videoLink)")
                    let size = ((Float((self.videoData.length))/1024.0)/1024.0)
                    self.fileSize = String(self.videoData.length)
                    self.fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + " MB"
                }
            }
            let size = ((Float((videoData.length))/1024.0)/1024.0)
            self.fileSize = String(videoData.length)
            self.fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + " MB"
        }else {
            if myAsset.fileManager.fileExists(atPath: docURL) {
                docData = myAsset.fileManager.contents(atPath: docURL)! as NSData
            }else {
                mJCLogger.log("File_Not_Found".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "File_Not_Found".localized(), button: okay)
            }
            self.uploadAttachmentImage.image = UIImage(named: "ic_Doc")
            let size = ((Float((docData.length))/1024.0)/1024.0)
            fileSize = String(docData.length)
            fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + " MB"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Button Action..
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func editButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Please_uptade_iOS_version_to_13".localized(), Type: "Warn")
        mJCAlertHelper.showAlert(self, title:"Info".localized(), message: "Please_uptade_iOS_version_to_13".localized(), button: okay)
        mJCLogger.log("Ended", Type: "info")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        let maxLength = 40
        if textField == descriptionTextField {
            let currentString: NSString = descriptionTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    @IBAction func saveButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if attachmentFileNameTextField.text == "" {
            mJCLogger.log("Please_select_file".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:MessageTitle, message: "Please_select_file".localized(), button: okay)
        }else if descriptionTextField.text == "" {
            mJCLogger.log("Please_enter_description".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:MessageTitle, message: "Please_enter_description".localized(), button: okay)
            return
        }else if descriptionTextField.text!.count > 40 {
            mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
            return
        }else {
            mJCLoader.startAnimating(status: "Saving".localized())
            sender.isUserInteractionEnabled = false
            if isFromScreen == "WorkOrder" {
                uploadWorkOrderAttachment()
            }else {
                uploadNotificationAttachment()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func uploadAttachmentbuttonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get image from video..
    private func thumbnailForVideoAtURL(url: NSURL) -> UIImage? {
        mJCLogger.log("Starting", Type: "info")
        let asset = AVAsset(url: url as URL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        var time = asset.duration
        time.value = min(time.value, 1)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            mJCLogger.log("Ended", Type: "info")
            return UIImage.init(cgImage: imageRef)
        } catch {
            print("error")
            mJCLogger.log("Ended", Type: "info")
            return nil
        }
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.descriptionTextField.resignFirstResponder()
        self.attachmentFileNameTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Upload Attachment..
    //Upload WorkOrder Attachment
    func uploadWorkOrderAttachment() {
        
        mJCLogger.log("Starting", Type: "info")
        
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "\(descriptionTextField.text!)" as NSObject
        self.property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        if attachmentType == "Image" {
            prop!.value = attachmentFileNameTextField.text! + "." + attachmentTypeLabel.text! as NSObject
        }else if attachmentType == "Video" {
            prop!.value = attachmentFileNameTextField.text! + "." + attachmentTypeLabel.text! as NSObject
        }else {
            prop!.value = attachmentFileNameTextField.text! + "." + attachmentTypeLabel.text! as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value = fileSize as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Line")
        if attachmentType == "Image" {
            let base64String = imgData.base64EncodedString(options: .lineLength64Characters)
            prop!.value = base64String as NSObject
        }else if attachmentType == "Video" {
            let base64String = videoData.base64EncodedString(options: .lineLength64Characters)
            prop!.value = base64String as NSObject
        }else {
            let base64String = docData.base64EncodedString(options: .lineLength64Characters)
            prop!.value = base64String as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        if attachmentType == "Image" {
            prop!.value = "image/jpeg" as NSObject
        }else if attachmentType == "Video" {
            prop!.value = "application/mp4" as NSObject
        }else {
            prop!.value = "application/x-doctype" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        self.property.add(prop!)
        
        if isFromScreen == "EQUIPMENT"{
            prop = SODataPropertyDefault(name: "Equipment")
            prop!.value = objectNum as NSObject
            self.property.add(prop!)
        }else if isFromScreen == "FUNCTIONALLOCATION"{
            prop = SODataPropertyDefault(name: "FuncLocation")
            prop!.value = objectNum as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "TempID")
        if selectedworkOrderNumber.contains(find: "L"){
            prop!.value = selectedworkOrderNumber as NSObject
        }else{
            prop!.value = "" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        self.property.add(prop!)
        
        
        let entity = SODataEntityDefault(type: workOrderAttachmentUploadentity)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            if proper.name != "Line"{
                print("Key : \(proper.name!)")
                mJCLogger.log("Key : \(proper.name)", Type: "Debug")
                print("Value : \(proper.value)")
                mJCLogger.log("Value : \(proper.value)", Type: "Debug")
                print(".......................")
            }
            print("........................")
        }
        photoUploadEntity = entity
        
        UploadedAttachmentsModel.uploadWoAttachmentEntity(entity: photoUploadEntity!, collectionPath: uploadWOAttachmentContentSet, flushRequired: true,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                mJCLogger.log("Attachment Upload successfully".localized(), Type: "Debug")
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    UserDefaults.standard.set(self.descriptionTextField.text, forKey:"NewUploadDesc")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "setAttachmentBadgeIcon"), object: false)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "saveAttachment"), object: true)
                }
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Attachment_upload_fail_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //Upload Notification Attachment..
    func uploadNotificationAttachment() {
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "\(descriptionTextField.text!)" as NSObject
        self.property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        if attachmentType == "Image" {
            prop!.value = attachmentFileNameTextField.text! + "." + attachmentTypeLabel.text! as NSObject
        }else if attachmentType == "Video" {
            prop!.value = attachmentFileNameTextField.text! + "." + attachmentTypeLabel.text! as NSObject
        }else {
            prop!.value = attachmentFileNameTextField.text! + "." + attachmentTypeLabel.text! as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value = fileSize as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Line")
        if attachmentType == "Image" {
            let base64String = imgData.base64EncodedString(options: .lineLength64Characters)
            prop!.value = base64String as NSObject
        }else if attachmentType == "Video" {
            let base64String = videoData.base64EncodedString(options: .lineLength64Characters)
            prop!.value = base64String as NSObject
        }else {
            let base64String = docData.base64EncodedString(options: .lineLength64Characters)
            prop!.value = base64String as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        if attachmentType == "Image" {
            prop!.value = "image/jpeg" as NSObject
        }else if attachmentType == "Video" {
            prop!.value = "application/mp4" as NSObject
        }else {
            prop!.value = "application/x-doctype" as NSObject
        }
        self.property.add(prop!)
        
        if isFromScreen == "EQUIPMENT"{
            prop = SODataPropertyDefault(name: "Equipment")
            prop!.value = objectNum as NSObject
            self.property.add(prop!)
        }else if isFromScreen == "FUNCTIONALLOCATION"{
            prop = SODataPropertyDefault(name: "FuncLocation")
            prop!.value = objectNum as NSObject
            self.property.add(prop!)
        }else if isFromScreen == "NOTIFICATIONTASK"{
            
            prop = SODataPropertyDefault(name: "Item")
            prop!.value = itemNum as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Task")
            prop!.value = taskNum as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = selectedNotificationNumber as NSObject
        self.property.add(prop!)
        
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
            if (entity?.properties[proper.name] as! SODataProperty).name != "Line"{
                print("Key : \((entity?.properties[proper.name] as! SODataProperty).name)")
                mJCLogger.log("Key : \((entity?.properties[proper.name] as! SODataProperty).name)", Type: "Debug")
                print("Value : \((entity?.properties[proper.name] as! SODataProperty).value)")
                mJCLogger.log("Value : \((entity?.properties[proper.name] as! SODataProperty).value)", Type: "Debug")
                print(".......................")
            }else{
                print("Key : \(proper.name!)")
                mJCLogger.log("Key : \(proper.name)", Type: "Debug")
                print("=================")
            }
        }
        photoUploadEntity = entity
        
        UploadedAttachmentsModel.uploadNoAttachmentEntity(entity: photoUploadEntity!, collectionPath: uploadNOAttachmentContentSet, flushRequired: true,options: nil, completionHandler: { (response, error) in
            self.saveButton.isUserInteractionEnabled = true
            if(error == nil) {
                print("Photo Upload successfully")
                mJCLogger.log("Photo Upload successfully".localized(), Type: "Debug")
                UserDefaults.standard.set(self.descriptionTextField.text, forKey:"NewUploadDesc")
                NotificationCenter.default.post(name: Notification.Name(rawValue:"setNotificationAttachmentCount"), object: false)
                NotificationCenter.default.post(name: Notification.Name(rawValue:"saveNOAttachment"), object: false)
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Attachment_upload_fail_try_again".localized(), button: okay)
            }
        })
        mJCLoader.stopAnimating()
        mJCLogger.log("Ended", Type: "info")
    }
    //Encoding video..
    func encodeVideo(videoURL: NSURL,title:String)  {
        
        mJCLogger.log("Starting", Type: "info")
        let avAsset = AVURLAsset(url: videoURL as URL, options: nil)
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough)
        
        exportSession!.outputURL = videoURL as URL
        exportSession!.outputFileType = AVFileType.mp4
        exportSession!.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession!.timeRange = range
        
        exportSession!.exportAsynchronously(completionHandler:{() -> Void in
            switch exportSession!.status {
            case .failed:
                print(exportSession?.error ?? "file error")
            case .cancelled:
                print("Export canceled")
            case .completed:
                print("Successful!")
                self.videoData = NSData(contentsOf: exportSession!.outputURL!)!
                let size = ((Float((self.videoData.length))/1024.0)/1024.0)
                self.fileSize = String(self.videoData.length)
                self.fileSizeLabel.text = String(format: size == floor(size) ? "%.1f" : "%.2f", size) + " MB"
            default:
                break
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Delete file..
    func deleteFile(filePath:NSURL) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("deleteFile start".localized(), Type: "")
        myAsset.fileManager.fileExists(atPath: filePath.path!)
        guard myAsset.fileManager.fileExists(atPath: filePath.path!) else {
            return
        }
        do {
            try myAsset.fileManager.removeItem(atPath: filePath.path!)
            mJCLogger.log("Ended", Type: "info")
            mJCLogger.log("deleteFile Done".localized(), Type: "Debug")
        }catch{
            mJCLogger.log("Unable to delete file".localized(), Type: "Error")
            mJCLogger.log("Ended", Type: "info")
            fatalError("Unable to delete file: \(error) : \(#function).")
        }
    }
}
