//
//  AttachmentsVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
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

class WorkOrderAttachmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UITextFieldDelegate {
    
    //MARK:- attachmentView Outlet..
    @IBOutlet var attachmentView: UIView!
    @IBOutlet var attachmentHeaderView: UIView!
    @IBOutlet var attachmentHeaderLabel: UILabel!
    @IBOutlet var attachmentTableView: UITableView!
    @IBOutlet var noAttachmentFoundLabel: UILabel!
    
    //MARK:- uploadedView Outlet..
    @IBOutlet var uploadedView: UIView!
    @IBOutlet var uploadedHeaderView: UIView!
    @IBOutlet var uploadedHeaderLabel: UILabel!
    @IBOutlet var uploadedTableView: UITableView!
    @IBOutlet var noUploadedAttachmentFoundLabel: UILabel!
    @IBOutlet var viewOptionsHolder: UIStackView!
    @IBOutlet var takePhotoButton: UIButton!
    @IBOutlet var takeVideoButton: UIButton!
    @IBOutlet var openGalleryButton: UIButton!
    @IBOutlet var openFileButton: UIButton!
    @IBOutlet weak var attachmentSegment: UISegmentedControl!
    
    // Mark: UrlView Constraints
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var uploadUrlViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var urlDescriptionTextField: UITextField!
    @IBOutlet weak var urlPasteButton: UIButton!
    @IBOutlet weak var urlDescriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var urlUploadButton: UIButton!
    @IBOutlet weak var urlPreviewButton: UIButton!
    @IBOutlet weak var urlCloseButton: UIButton!
    @IBOutlet weak var openUrlButton: UIButton!
    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var demoView: UIView!
    
    var attachmentsViewModel = AttachmentsViewModel()
    var fromScreen = String()
    var objectNum = String()
    weak var attachDelegate: taskAttachmentDelegate?
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        attachmentsViewModel.vc = self
        self.urlView.isHidden = true
        self.noAttachmentFoundLabel.text = "No_attachment_found".localized()
        self.noUploadedAttachmentFoundLabel.text = "No_uploaded_attachment_found".localized()
        if demoModeEnabled == true{
            self.demoView.isHidden = false
            self.view.bringSubviewToFront(self.demoView)
        }else{
            self.demoView.isHidden = true
        }
        if DeviceType == iPad{
            ODSUIHelper.setButtonLayout(button: self.takePhotoButton, cornerRadius: self.takePhotoButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.takeVideoButton, cornerRadius: self.takeVideoButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.openGalleryButton, cornerRadius: self.openGalleryButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.openFileButton, cornerRadius: self.openFileButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.openUrlButton, cornerRadius: self.openUrlButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            attachmentTableView.rowHeight = UITableView.automaticDimension
            attachmentTableView.estimatedRowHeight = 110
            uploadedTableView.rowHeight = UITableView.automaticDimension
            uploadedTableView.estimatedRowHeight = 110
            setAppfeature()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if selectedworkOrderNumber == "" && selectedOperationNumber == ""{
                    takePhotoButton.isHidden = true
                    openGalleryButton.isHidden = true
                    takeVideoButton.isHidden = true
                    openFileButton.isHidden = true
                    openUrlButton.isHidden = true
                }
            }else{
                if selectedworkOrderNumber == ""{
                    takePhotoButton.isHidden = true
                    openGalleryButton.isHidden = true
                    takeVideoButton.isHidden = true
                    openFileButton.isHidden = true
                    openUrlButton.isHidden = true
                }
            }
        }else{
            attachmentTableView.rowHeight = UITableView.automaticDimension
            attachmentTableView.estimatedRowHeight = 128
            uploadedTableView.rowHeight = UITableView.automaticDimension
            uploadedTableView.estimatedRowHeight = 128
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WorkOrderAttachmentVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
        attachmentsViewModel.property.removeAllObjects()
        attachmentsViewModel.attachementArray.removeAll()
        self.attachmentTableView.delegate = self
        self.attachmentTableView.separatorStyle = .none
        self.uploadedTableView.delegate = self
        self.uploadedTableView.separatorStyle = .none
        ScreenManager.registerAttachmentsCell(tableView: self.attachmentTableView)
        ScreenManager.registerAttachmentsCell(tableView: self.uploadedTableView)
        if DeviceType == iPhone {
            self.expandingMenuItems()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(WorkOrderAttachmentVC.saveAttachment(notification:)), name:NSNotification.Name(rawValue:"saveAttachment"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            var title = String()
            if fromScreen == "EQUIPMENT"{
                title = "Equipment" + ": \(objectNum)"
            }else if fromScreen == "FUNCTIONALLOCATION"{
                title = "FL : \(objectNum)"
            }else{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    title =  "\(objectNum)"+"/"+"\(selectedOperationNumber)"
                }else{
                    title =  "\(objectNum)"
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
            }
            attachmentSegment.setTitle("Uploaded".localized(), forSegmentAt: 1)
            attachmentSegment.setTitle("Attachments".localized(), forSegmentAt: 0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
            if attachmentuploadTab == true && currentsubView == "Attachments"{
                self.attachmentView.isHidden = true
                self.uploadedView.isHidden = false
                self.attachmentSegment.selectedSegmentIndex = 1
            }else {
                self.attachmentView.isHidden = false
                self.uploadedView.isHidden = true
                self.attachmentSegment.selectedSegmentIndex = 0
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        if objectNum != ""{
            attachmentsViewModel.getAttachment()
        }else {
            self.noAttachmentFoundLabel.isHidden = false
            self.attachmentTableView.isHidden = true
            self.noUploadedAttachmentFoundLabel.isHidden = false
            self.uploadedTableView.isHidden = true
        }
    }
    //MARK:- Notifications Methods..
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if objectNum != "" {
            attachmentsViewModel.getAttachment()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func expandingMenuItems() {
        let menuButtonSize: CGSize = CGSize(width: 30.0, height: 30.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 40.0, height: 40.0)), image: #imageLiteral(resourceName: "ic_AppColorPlus"), rotatedImage: #imageLiteral(resourceName: "ic_AppColorPlus"))
        menuButton.layer.cornerRadius = menuButton.frame.size.height/2
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 220.0)
        view.addSubview(menuButton)

        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "", image: #imageLiteral(resourceName: "ic_attachcapture"), highlightedImage: #imageLiteral(resourceName: "ic_attachcapture"), backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.takePhotoButtonAction(sender: UIButton())
        })
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "", image: #imageLiteral(resourceName: "ic_Video"), highlightedImage: #imageLiteral(resourceName: "ic_Video"), backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.takeVideoButtonAction(sender: UIButton())
        })
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "", image: #imageLiteral(resourceName: "ic_Photo"), highlightedImage: #imageLiteral(resourceName: "ic_Photo"), backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.openGalleryButtonAction(sender: UIButton())
        })
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "", image: #imageLiteral(resourceName: "ic_File"), highlightedImage: #imageLiteral(resourceName: "ic_File"), backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.openFileButtonAction(sender: UIButton())
        })
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "", image: #imageLiteral(resourceName: "ic_Url"), highlightedImage: #imageLiteral(resourceName: "ic_Url"), backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.uploadWOAttachmentUrlButtonAction(UIButton())
        })
        item1.backgroundColor = appColor
        item1.alpha = 0.2
        item1.layer.cornerRadius = item1.frame.size.height/2
        item2.backgroundColor = appColor
        item2.alpha = 0.2
        item2.layer.cornerRadius = item1.frame.size.height/2
        item3.backgroundColor = appColor
        item3.alpha = 0.2
        item3.layer.cornerRadius = item1.frame.size.height/2
        item4.backgroundColor = appColor
        item4.alpha = 0.2
        item4.layer.cornerRadius = item1.frame.size.height/2
        item5.backgroundColor = appColor
        item5.alpha = 0.2
        item5.layer.cornerRadius = item1.frame.size.height/2
        var menuarr = [item1,item2,item3,item4,item5]
        if !applicationFeatureArrayKeys.contains("WO_ATTCH_CAPTURE_IMG"){
            if let index = menuarr.firstIndex(of: item1){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_ATTCH_CAPTURE_VIDEO"){
            if let index = menuarr.firstIndex(of: item2){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_ATTCH_UPLOAD_IMG"){
            if let index = menuarr.firstIndex(of: item3){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_ATTCH_UPLOAD_VIDEO"){
            if let index = menuarr.firstIndex(of: item4){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_ATTCH_URL"){
            if let index = menuarr.firstIndex(of: item5){
                menuarr.remove(at: index)
            }
        }
        menuButton.addMenuItems(menuarr)
        menuButton.bottomViewColor = UIColor.lightGray
        menuButton.bottomViewAlpha = 0.2
        menuButton.titleTappedActionEnabled = false
        menuButton.expandingDirection = .top
        menuButton.menuTitleDirection = .left
        menuButton.foldingAnimations = .all
    }
    open override var shouldAutorotate: Bool {
        return false
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Save Attachment Notification..
    @objc func saveAttachment(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        attachmentsViewModel.getUploadAttachment()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Tableview Delegate methods..
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        
        if applicationFeatureArrayKeys.contains("WO_ATTCH_CAPTURE_IMG"){
            takePhotoButton.isHidden = false
        }else{
            takePhotoButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("WO_ATTCH_UPLOAD_IMG"){
            openGalleryButton.isHidden = false
        }else{
            openGalleryButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("WO_ATTCH_CAPTURE_VIDEO"){
            takeVideoButton.isHidden = false
        }else{
            takeVideoButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("WO_ATTCH_UPLOAD_VIDEO"){
            openFileButton.isHidden = false
        }else{
            openFileButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("WO_ATTCH_URL"){
            openUrlButton.isHidden = false
        }else{
            openUrlButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == attachmentTableView {
            if attachmentsViewModel.attachementArray.count > 0 {
                return attachmentsViewModel.attachementArray.count
            }else {
                return 0
            }
        }else {
            if attachmentsViewModel.uploadedAttachmentArray.count > 0 {
                return attachmentsViewModel.uploadedAttachmentArray.count
            }else {
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if tableView == attachmentTableView {
            let attachmentsCell = ScreenManager.getAttachmentsCell(tableView: attachmentTableView)
            attachmentsCell.indexPath = indexPath
            attachmentsCell.attachmentsViewModel = self.attachmentsViewModel
            if attachmentsViewModel.attachementArray.indices.contains(indexPath.row){
                attachmentsCell.attachmentModelClass = attachmentsViewModel.attachementArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return attachmentsCell
            
        }else {
            let attachmentsCell = ScreenManager.getAttachmentsCell(tableView: uploadedTableView)
            attachmentsCell.indexPath = indexPath
            attachmentsCell.attachmentsViewModel = self.attachmentsViewModel
            if attachmentsViewModel.uploadedAttachmentArray.indices.contains(indexPath.row){
                attachmentsCell.uploadedAttachmentsModelClass = attachmentsViewModel.uploadedAttachmentArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return attachmentsCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK:- Attachment Button Action..
    @IBAction func takePhotoButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true{
            attachmentsViewModel.selectedbutton = "takePhoto"
            openCamera()
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func takeVideoButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true {
            attachmentsViewModel.selectedbutton = "takeVideo"
            openVideoCamera()
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func openGalleryButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true{
            attachmentsViewModel.selectedbutton = "choosePhoto"
            openPhotoLibrary()
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getUploadAttachmentUI(){
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(attachmentsViewModel.uploadedAttachmentArray.count)", Type: "Debug")
        if attachmentsViewModel.uploadedAttachmentArray.count > 0 {
            DispatchQueue.main.async {
                self.uploadedTableView.isHidden = false
                if self.attachmentsViewModel.uploadedAttachmentArray.count != 0 {
                    self.uploadedTableView.reloadData()
                    isAttachmentDone = true
                }else{
                    self.noUploadedAttachmentFoundLabel.isHidden = false
                    self.uploadedTableView.isHidden = true
                }
            }
        }else{
            DispatchQueue.main.async {
                self.noUploadedAttachmentFoundLabel.isHidden = false
                self.uploadedTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getAttachmentUI(){
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(attachmentsViewModel.attachementArray.count)", Type: "Debug")
        if attachmentsViewModel.attachementArray.count > 0 {
            DispatchQueue.main.async {
                self.noAttachmentFoundLabel.isHidden = true
                self.attachmentTableView.isHidden = false
                self.attachmentTableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.noAttachmentFoundLabel.isHidden = false
                self.attachmentTableView.isHidden = true
            }
        }
        let count = attachmentsViewModel.attachementArray.count + attachmentsViewModel.uploadedAttachmentArray.count
        if attachDelegate != nil{
            attachDelegate?.updateTaskAttachment(count: count)
        }
        if count > 0{
            attchmentCount = "\(count)"
        }else{
            attchmentCount = ""
        }
        attchmentColor = appColor
        mJCLogger.log("Ended", Type: "info")
    }
    func sendnotification(title: String){
        mJCLogger.log("Starting", Type: "info")
        let notificationContent = UNMutableNotificationContent()
        if title == "started"{
            notificationContent.title = "myJobCard_File_Download".localized()
            notificationContent.body = "File_Download_in_Progress".localized()
        }
        if title == "Completed"{
            notificationContent.title = "myJobCard_File_Download".localized()
            notificationContent.body = "File_Download_Completed".localized()
        }
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func openFileButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true{
            openiCloudDrive()
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func segmentAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        if attachmentSegment.selectedSegmentIndex == 0 {
            attachmentSegment.setTitle("Attachments".localized(), forSegmentAt: 0)
            self.attachmentView.isHidden = false
            self.uploadedView.isHidden = true
            attachmentuploadTab = false
        }else if attachmentSegment.selectedSegmentIndex == 1 {
            attachmentSegment.setTitle("Uploaded".localized(), forSegmentAt: 1)
            attachmentuploadTab = true
            self.attachmentView.isHidden = true
            self.uploadedView.isHidden = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Button Action Function..
    //Open Camera..
    func openCamera() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = true
                imagePicker.cameraCaptureMode = .photo
                self.present(imagePicker, animated: false, completion: nil)
            }
        }else {
            mJCLogger.log("There_is_no_camera_available_on_this_device".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func openVideoCamera() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeAVIMovie as String ,kUTTypeVideo as String ,kUTTypeMPEG4 as String]
                imagePicker.allowsEditing = true
                imagePicker.videoQuality = .typeMedium
                self.present(imagePicker, animated: false, completion: nil)
            }
        }else {
            mJCLogger.log("There_is_no_camera_available_on_this_device".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Open PhotoLibrary..
    func openPhotoLibrary() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.modalPresentationStyle = UIModalPresentationStyle.formSheet
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: false, completion: nil)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Open iCloud Drive
    func openiCloudDrive() {
        mJCLogger.log("Starting", Type: "info")
        let importMenuVC = UIDocumentMenuViewController(documentTypes: [kUTTypePNG as String, kUTTypePDF as String, kUTTypeJPEG as String, kUTTypeText as String,kUTTypeMovie as String,kUTTypeSpreadsheet as String,kUTTypePresentation as String], in: .import)
        importMenuVC.delegate = self
        importMenuVC.modalPresentationStyle = .popover
        importMenuVC.popoverPresentationController?.sourceView = self.view
        if DeviceType == iPad{
            if openUrlButton.isHidden == true {
                let sourceRect = CGRect(x: viewOptionsHolder.frame.origin.x, y: viewOptionsHolder.frame.origin.y + viewOptionsHolder.frame.size.height - 20, width: 0, height: 0)
                importMenuVC.popoverPresentationController?.sourceRect = sourceRect
            }else{
                let sourceRect = CGRect(x: viewOptionsHolder.frame.origin.x, y: viewOptionsHolder.frame.origin.y + viewOptionsHolder.frame.size.height - 60, width: 0, height: 0)
                importMenuVC.popoverPresentationController?.sourceRect = sourceRect
            }
            self.present(importMenuVC, animated: true) {}
        }else{
            self.present(importMenuVC, animated: true) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UIImagePickerController Delegate..
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            var arr = NSArray()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
            let dateString = dateFormatter.string(from: NSDate() as Date)
            if attachmentsViewModel.selectedbutton == "takePhoto" || attachmentsViewModel.selectedbutton == "choosePhoto" {
                if attachmentsViewModel.selectedbutton == "takePhoto" {
                    uploadAttachmentVC.fileType = defaultImageType
                }else {
                    let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                    attachmentsViewModel.newFileName = imageURL.lastPathComponent!
                    arr = (attachmentsViewModel.newFileName.components(separatedBy: ".")) as NSArray
                    uploadAttachmentVC.fileType = (arr[1] as! String).lowercased()
                }
                attachmentsViewModel.selectedbutton = ""
                let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                attachmentsViewModel.imagePicked.image = chosenImage
                attachmentsViewModel.imageData = chosenImage.pngData()! as NSData
                uploadAttachmentVC.fileName  = "IMAGE_\(dateString)"
                uploadAttachmentVC.image = chosenImage
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.modalPresentationStyle = .fullScreen
                self.dismiss(animated: false, completion: {
                    self.present(uploadAttachmentVC, animated: false) {}
                })
            }else {
                
                let url1 = NSURL(fileURLWithPath: documentPath)
                let filePath = url1.appendingPathComponent("iCloud")?.path
                do {
                    try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
                }
                catch let error as NSError {
                    print(error.localizedDescription);
                }
                if let newurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
                    attachmentsViewModel.clodeFileName = newurl.lastPathComponent.replacingOccurrences(of: ".\(newurl.pathExtension)", with: "")
                    let tempDocID = String.random(length: 4, type: "Number")
                    attachmentsViewModel.clodeFileName = "Video\(dateString)_\(tempDocID)"
                    let newfilePath: String! = "\(filePath!)/\(attachmentsViewModel.clodeFileName).\(newurl.pathExtension)"
                    do {
                        try myAsset.fileManager.copyItem(atPath: newurl.path, toPath: newfilePath!)
                    }
                    catch let error as NSError {
                        if error.code == NSFileWriteFileExistsError{
                            do {
                                try myAsset.fileManager.removeItem(atPath: newurl.path)
                                print("Existing file deleted.")
                            } catch {
                                print("Failed to delete existing file:\n\((error as NSError).description)")
                            }
                            do{
                                try myAsset.fileManager.copyItem(atPath: newurl.path, toPath: newfilePath!)
                            }catch {
                                print("File not saved:\n\((error as NSError).description)")
                            }
                        }
                        mJCLogger.log(" Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                    }
                    do {
                        let asset = AVURLAsset(url: NSURL(fileURLWithPath: newfilePath) as URL, options: nil)
                        let imgGenerator = AVAssetImageGenerator(asset: asset)
                        imgGenerator.appliesPreferredTrackTransform = true
                        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                        let uiImage = UIImage(cgImage: cgImage)
                        if uiImage != nil {
                            uploadAttachmentVC.imgData = uiImage.png!
                        }
                    } catch let error as NSError {
                        print("Error generating thumbnail: \(error)")
                    }
                    attachmentsViewModel.selectedbutton = ""
                    uploadAttachmentVC.fileName  =  attachmentsViewModel.clodeFileName
                    uploadAttachmentVC.videoLink =  NSURL(string: newfilePath)!
                    uploadAttachmentVC.fileType = "\(newurl.pathExtension)"
                    uploadAttachmentVC.attachmentType = "Video"
                    uploadAttachmentVC.modalPresentationStyle = .fullScreen
                    self.dismiss(animated: false, completion: {
                        self.present(uploadAttachmentVC, animated: false)
                    })
                }
            }
        }else{
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentLowScreen()
            uploadAttachmentVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            uploadAttachmentVC.fileType = attachmentsViewModel.urlDoc.pathExtension!
            var title = attachmentsViewModel.urlDoc.lastPathComponent?.replacingOccurrences(of: ".\(attachmentsViewModel.urlDoc.pathExtension!)", with: "")
            let tempDocID = String.random(length: 4, type: "Number")
            title = "\(title ?? "File")_\(tempDocID).\(attachmentsViewModel.urlDoc.pathExtension!)"

            if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.imageURL = attachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Video"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.videoLink = attachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if attachmentsViewModel.urlDoc.pathExtension! == "pdf" {
                uploadAttachmentVC.attachmentType = "pdf"
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "doc"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "xls"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else{
                uploadAttachmentVC.attachmentType = "other"
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            
            self.present(uploadAttachmentVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    internal func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        mJCLogger.log("Starting", Type: "info")
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .popover
        documentPicker.popoverPresentationController?.sourceView = self.view
        DispatchQueue.main.async {
            if DeviceType == iPad{
                let sourceRect = CGRect(x: self.viewOptionsHolder.frame.origin.x, y: self.viewOptionsHolder.frame.origin.y + self.viewOptionsHolder.frame.size.height - 20, width: 0, height: 0)
                documentPicker.popoverPresentationController?.sourceRect = sourceRect
                self.present(documentPicker, animated: true) {}
            }else{
                self.present(documentPicker, animated: true) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    internal func documentMenuWasCancelled(documentMenu: UIDocumentMenuViewController) {
        self.dismiss(animated: true) {}
    }
    internal func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        mJCLogger.log("Starting", Type: "info")
       
        let url1 = NSURL(fileURLWithPath: documentPath)
        let filePath = url1.appendingPathComponent("iCloud")?.path
        do {
            try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error.localizedDescription);
        }
        attachmentsViewModel.clodeFileName = url.lastPathComponent.replacingOccurrences(of: ".\(url.pathExtension)", with: "")
        let tempDocID = String.random(length: 4, type: "Number")
        attachmentsViewModel.clodeFileName = "\(attachmentsViewModel.clodeFileName )_\(tempDocID)"
        let newfilePath: String! = "\(filePath!)/\(attachmentsViewModel.clodeFileName).\(url.pathExtension)"
        do {
            try myAsset.fileManager.copyItem(atPath: url.path, toPath: newfilePath!)
        }
        catch let error as NSError {
            if error.code == NSFileWriteFileExistsError{
                do {
                    try myAsset.fileManager.removeItem(atPath: url.path)
                } catch {
                    print("Failed to delete existing file:\n\((error as NSError).description)")
                }
                do{
                    try myAsset.fileManager.copyItem(atPath: url.path, toPath: newfilePath!)
                }catch {
                    print("File not saved:\n\((error as NSError).description)")
                }
            }
            mJCLogger.log(" Reason : \(String(describing: error.localizedDescription))", Type: "Error")
        }
        attachmentsViewModel.urlDoc = url as NSURL
        attachmentsViewModel.docPath = newfilePath
        self.perform(#selector(self.presentController), with: nil, afterDelay: 0.1)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func presentController()  {
        mJCLogger.log("Starting", Type: "info")
        print("presentController")
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            uploadAttachmentVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            uploadAttachmentVC.fileType = attachmentsViewModel.urlDoc.pathExtension!

            if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.imageURL = attachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}) {
                uploadAttachmentVC.attachmentType = "Video"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.videoLink = attachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if attachmentsViewModel.urlDoc.pathExtension! == "pdf" {
                uploadAttachmentVC.attachmentType = "pdf"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "doc"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "xls"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else{
                uploadAttachmentVC.attachmentType = "other"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            self.present(uploadAttachmentVC, animated: false) {}
        }else{
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentLowScreen()
            uploadAttachmentVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            uploadAttachmentVC.fileType = attachmentsViewModel.urlDoc.pathExtension!
            var title = attachmentsViewModel.urlDoc.lastPathComponent?.replacingOccurrences(of: ".\(attachmentsViewModel.urlDoc.pathExtension!)", with: "")
            let tempDocID = String.random(length: 4, type: "Number")
            title = "\(title ?? "File")_\(tempDocID).\(attachmentsViewModel.urlDoc.pathExtension!)"

            if imgExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.imageURL = attachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Video"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.videoLink = attachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if attachmentsViewModel.urlDoc.pathExtension! == "pdf" {
                uploadAttachmentVC.attachmentType = "pdf"
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "doc"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(attachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "xls"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
            }else{
                uploadAttachmentVC.attachmentType = "other"
                uploadAttachmentVC.docURL = attachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = attachmentsViewModel.clodeFileName
            }
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            uploadAttachmentVC.isFromScreen = fromScreen
            self.present(uploadAttachmentVC, animated: false) {
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // Called if the user dismisses the document picker without selecting a document (using the Cancel button)
    internal func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.dismiss(animated: true) {}
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        let maxLength = 40
        if textField == urlDescriptionTextField {
            let currentString: NSString = urlDescriptionTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    @IBAction func uploadWOAttachmentUrlButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true{
            self.urlView.isHidden = false
            self.urlPasteButton.isHidden = false
            self.urlUploadButton.isHidden = false
            urlView.layer.cornerRadius = 10
            urlView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            urlView.layer.borderWidth = 1.0
            urlView.layer.borderColor = #colorLiteral(red: 0.337254902, green: 0.5411764706, blue: 0.6784313725, alpha: 1)
            urlView.layer.cornerRadius = 5
            urlTextView.layer.borderWidth = 1.0
            urlTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            urlTextView.isUserInteractionEnabled = true
            urlDescriptionTextField.isUserInteractionEnabled = true
            urlDescriptionTextField.delegate = self
            urlTextView.layer.cornerRadius = 5
            urlDescriptionTextField.layer.cornerRadius = 5
            urlDescriptionTextField.layer.borderWidth = 1.0
            urlDescriptionTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            urlCloseButton.clipsToBounds = true
            urlCloseButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func urlPreviewButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let url = URL(string: self.urlTextView.text ?? "") {
            if  UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Open url : \(success)")
                })
            }else{
                mJCLogger.log("Invalid_Url".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Invalid_Url".localized(), button: okay)
            }
        }else{
            mJCLogger.log("Invalid_Url".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Invalid_Url".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func urlUploadButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if self.urlTextView.text == ""{
            mJCLogger.log("Please_copy_some_URL".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Please_copy_some_URL".localized(), button: okay)
        }else if URL(string: self.urlTextView.text) == nil || !UIApplication.shared.canOpenURL(URL(string: self.urlTextView.text!)!) {
            mJCLogger.log("Invalid_Url".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Invalid_Url".localized(), button: okay)
        }else if self.urlDescriptionTextField.text == ""{
            mJCLogger.log("Please_add_Description_to_URL".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Please_add_Description_to_URL".localized(), button: okay)
        }else{
            attachmentsViewModel.uploadUrlWOAttachment()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func pasteButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let urlString = UIPasteboard.general.string {
            if let url = URL(string: urlString) {
                if  UIApplication.shared.canOpenURL(url){
                    self.urlTextView.text = "\(url)"
                }else{
                    mJCLogger.log("Please_copy_some_valid_Url_to_Uplaod".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title:alerttitle, message: "Please_copy_some_valid_Url_to_Uplaod".localized(), button: okay)
                }
            }else{
                mJCLogger.log("Please_copy_some_valid_Url_to_Uplaod".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Please_copy_some_valid_Url_to_Uplaod".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func urlCloseButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.urlTextView.text = ""
            self.urlDescriptionTextField.text = ""
            self.urlView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
extension WorkOrderAttachmentVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}
