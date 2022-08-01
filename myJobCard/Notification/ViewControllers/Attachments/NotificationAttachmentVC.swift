//
//  NotificationAttachmentVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/9/16.
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

class NotificationAttachmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UITextFieldDelegate {

    //MARK:- Attachment View Outlet..
    @IBOutlet var attachmentView: UIView!
    @IBOutlet var attachmentHeaderView: UIView!
    @IBOutlet var attachmentHeaderLabel: UILabel!
    @IBOutlet var attachmentTableView: UITableView!
    @IBOutlet var noAttachmentFoundLabel: UILabel!
    //MARK:- Uploaded View Outlet..
    @IBOutlet var uploadedView: UIView!
    @IBOutlet var uploadedHeaderView: UIView!
    @IBOutlet var uploadedHeaderLabel: UILabel!
    @IBOutlet var uploadedTableView: UITableView!
    @IBOutlet var noUploadedAttachmentFoundLabel: UILabel!
    @IBOutlet var viewOptionsHolder: UIStackView!
    // UploadPotionsView Options
    @IBOutlet var plusTakePhotoButton: UIButton!
    @IBOutlet var plusTakeVideoButton: UIButton!
    @IBOutlet var pluOpenGalleryButton: UIButton!
    @IBOutlet var pluOpenFileButton: UIButton!
    @IBOutlet var pluOpenUrlButton: UIButton!
    // viewOptionsHolder Options
    @IBOutlet var takePhotoButton: UIButton!
    @IBOutlet var takeVideoButton: UIButton!
    @IBOutlet var openGalleryButton: UIButton!
    @IBOutlet var openFileButton: UIButton!
    @IBOutlet var openUrlButton: UIButton!
    @IBOutlet weak var attachmentSegment: UISegmentedControl!
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var urlViewCloseButton: UIButton!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var urlTitleTextField: UITextField!
    @IBOutlet weak var urldescriptionTextField: UITextField!
    @IBOutlet weak var urlPasteButton: UIButton!
    @IBOutlet weak var urlUploadButton: UIButton!
    @IBOutlet weak var urlPreviewButton: UIButton!
    @IBOutlet weak var uploadViewtrailingContraint: NSLayoutConstraint!
    @IBOutlet weak var attachmentViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewOptionsHolderWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var urldescriptionTFHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var urlTitleTFHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadUrlviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var uploadPlusButton: UIButton!
    @IBOutlet weak var uploadOptionsView: UIView!
    @IBOutlet weak var demoView: UIView!
    
    var notifiAttachmentsViewModel = NotificationAttachmentViewModel()
    var fromScreen = String()
    var objectNum = String()
    var notificationFrom = String()
    var itemNum = String()
    var taskNum = String()
    var uploadOptionsFlag = false
    weak var attachDelegate: taskAttachmentDelegate?
    var selectedTaskObjRef = NotificationTaskModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        notifiAttachmentsViewModel.vcNotification = self
        self.uploadedTableView.dataSource = self
        self.uploadedTableView.delegate = self
        self.urlView.isHidden = true
        if demoModeEnabled == true{
            self.demoView.isHidden = false
            self.view.bringSubviewToFront(self.demoView)
        }else{
            self.demoView.isHidden = true
        }
        if DeviceType == iPad{
            self.urlTitleTFHeightConstraint.constant = 0.0
            ODSUIHelper.setButtonLayout(button: self.takePhotoButton, cornerRadius: self.takePhotoButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.takeVideoButton, cornerRadius: self.takeVideoButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.openGalleryButton, cornerRadius: self.openGalleryButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.openFileButton, cornerRadius: self.openFileButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.openUrlButton, cornerRadius: self.openUrlButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.plusTakePhotoButton, cornerRadius: self.takePhotoButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.plusTakeVideoButton, cornerRadius: self.takeVideoButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.pluOpenGalleryButton, cornerRadius: self.openGalleryButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.pluOpenFileButton, cornerRadius: self.openFileButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.pluOpenUrlButton, cornerRadius: self.openUrlButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }else{
            NotificationCenter.default.removeObserver(self)
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationAttachmentVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
        notifiAttachmentsViewModel.attachementArray.removeAll()
        attachmentTableView.delegate = self
        attachmentTableView.separatorStyle = .none
        uploadedTableView.delegate = self
        uploadedTableView.separatorStyle = .none
        ScreenManager.registerAttachmentsCell(tableView: self.attachmentTableView)
        ScreenManager.registerAttachmentsCell(tableView: self.uploadedTableView)
        attachmentTableView.rowHeight = UITableView.automaticDimension
        attachmentTableView.estimatedRowHeight = 120
        uploadedTableView.rowHeight = UITableView.automaticDimension
        uploadedTableView.estimatedRowHeight = 120
        if DeviceType == iPhone {
            self.expandingMenuItems()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationAttachmentVC.saveNOAttachment(notification:)), name:NSNotification.Name(rawValue:"saveNOAttachment"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {

        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        DispatchQueue.main.async {
            self.noUploadedAttachmentFoundLabel.isHidden = false
            self.uploadedTableView.isHidden = true
        }
        if fromScreen == "NOTIFICATIONTASK"{
            if DeviceType == iPad {
                viewOptionsHolder.isHidden = true
                uploadOptionsView.isHidden = true
                viewOptionsHolderWidthConstraint.constant = 0
                attachmentViewLeadingConstraint.constant = 0
                uploadViewtrailingContraint.constant = 0
            }
        }else{
            if DeviceType == iPad {
                uploadOptionsView.isHidden = true
                setAppfeature()
            }
        }
        if DeviceType == iPhone{
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
            attachmentSegment.setTitle("Uploaded".localized(), forSegmentAt: 1)
            attachmentSegment.setTitle("Attachments".localized(), forSegmentAt: 0)
        }else{
            if selectedNotificationNumber == ""{
                takePhotoButton.isHidden = true
                openGalleryButton.isHidden = true
                takeVideoButton.isHidden = true
                openFileButton.isHidden = true
                openUrlButton.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        objectNum = singleNotification.Notification
        if objectNum != ""{
            notifiAttachmentsViewModel.getAttachment()
        }else{
            self.noUploadedAttachmentFoundLabel.isHidden = false
            self.uploadedTableView.isHidden = true

            self.noAttachmentFoundLabel.isHidden = false
            self.attachmentTableView.isHidden = true
        }
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func expandingMenuItems() {
        let menuButtonSize: CGSize = CGSize(width: 30.0, height: 30.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 40.0, height: 40.0)), image: UIImage(named: "ic_AppColorPlus")!, rotatedImage: UIImage(named: "ic_AppColorPlus")!)
        menuButton.layer.cornerRadius = menuButton.frame.size.height/2
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 210.0)
        view.addSubview(menuButton)
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "", image: UIImage(named: "ic_attachcapture")!, highlightedImage: UIImage(named: "ic_attachcapture")!, backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.takePhotoButtonAction(sender: UIButton())
        })
        item1.contentMode = .scaleAspectFit
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "", image: UIImage(named: "ic_Video")!, highlightedImage: UIImage(named: "ic_Video")!, backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.takeVideoButtonAction(sender: UIButton())
        })
        item2.contentMode = .scaleAspectFit
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "", image: UIImage(named: "ic_Photo")!, highlightedImage: UIImage(named: "ic_Photo")!, backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.openGalleryButtonAction(sender: UIButton())
        })
        item3.contentMode = .scaleAspectFit
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "", image: UIImage(named: "ic_File")!, highlightedImage: UIImage(named: "ic_File")!, backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.openFileButtonAction(sender: UIButton())
        })
        item4.contentMode = .scaleAspectFit
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "", image: UIImage(named: "ic_Url")!, highlightedImage: UIImage(named: "ic_Url")!, backgroundImage: UIImage(named: ""), backgroundHighlightedImage: UIImage(named: ""),itemTapped: {
            self.uploadNotifiAttachmentUrlButtonAction(UIButton())
        })
        item5.contentMode = .scaleAspectFit
        item1.backgroundColor = appColor
        item1.alpha = 0.2
        item1.layer.cornerRadius = item1.frame.size.height/2
        item2.backgroundColor = appColor
        item1.alpha = 0.2
        item2.layer.cornerRadius = item1.frame.size.height/2
        item3.backgroundColor = appColor
        item1.alpha = 0.2
        item3.layer.cornerRadius = item1.frame.size.height/2
        item4.backgroundColor = appColor
        item1.alpha = 0.2
        item4.layer.cornerRadius = item1.frame.size.height/2
        item5.backgroundColor = appColor
        item1.alpha = 0.2
        item5.layer.cornerRadius = item1.frame.size.height/2
        var menuarr = [item1,item2,item3,item4,item5]
        if !applicationFeatureArrayKeys.contains("NO_ATTCH_CAPTURE_IMG"){
            if let index = menuarr.firstIndex(of: item1){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("NO_ATTCH_CAPTURE_VIDEO"){
            if let index = menuarr.firstIndex(of: item2){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("NO_ATTCH_UPLOAD_IMG"){
            if let index = menuarr.firstIndex(of: item3){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("NO_ATTCH_UPLOAD_VIDEO"){
            if let index = menuarr.firstIndex(of: item4){
                menuarr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("NO_ATTCH_URL"){
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Save Attachment Notification..
    @objc func saveNOAttachment(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        notifiAttachmentsViewModel.getUploadAttachment()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")
        if tableView == attachmentTableView {
            if notifiAttachmentsViewModel.attachementArray.count > 0 {
                return notifiAttachmentsViewModel.attachementArray.count
            }else {
                return 0
            }
        }else {
            if notifiAttachmentsViewModel.uploadedAttachmentArray.count > 0 {
                return notifiAttachmentsViewModel.uploadedAttachmentArray.count
            }else {
                return 0
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        
        mJCLogger.log("Starting", Type: "info")
        let maxLength = 40
        if textField == urldescriptionTextField {
            let currentString: NSString = urldescriptionTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized() , Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        if tableView == attachmentTableView {
            let attachmentsCell = ScreenManager.getAttachmentsCell(tableView: attachmentTableView)
            attachmentsCell.indexPath = indexPath
            attachmentsCell.notifiAttachmentsViewModel = self.notifiAttachmentsViewModel
            if notifiAttachmentsViewModel.attachementArray.indices.contains(indexPath.row){
                attachmentsCell.attachmentModelClass = notifiAttachmentsViewModel.attachementArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return attachmentsCell
        }else {
            let attachmentsCell = ScreenManager.getAttachmentsCell(tableView: uploadedTableView)
            attachmentsCell.indexPath = indexPath
            attachmentsCell.notifiAttachmentsViewModel = self.notifiAttachmentsViewModel
            if notifiAttachmentsViewModel.uploadedAttachmentArray.indices.contains(indexPath.row){
                attachmentsCell.uploadedAttachmentsModelClass = notifiAttachmentsViewModel.uploadedAttachmentArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return attachmentsCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        mJCLogger.log("Starting", Type: "info")
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let btn = UIButton()
        btn.tag = tappedImage.tag
        notifiAttachmentsViewModel.attachmentDownload(index: tappedImage.tag, sender: btn)
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("NO_ATTCH_CAPTURE_IMG"){
            takePhotoButton.isHidden = false
        }else{
            takePhotoButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_ATTCH_UPLOAD_IMG"){
            takeVideoButton.isHidden = false
        }else{
            takeVideoButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_ATTCH_CAPTURE_VIDEO"){
            openGalleryButton.isHidden = false
        }else{
            openGalleryButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_ATTCH_UPLOAD_VIDEO"){
            openFileButton.isHidden = false
        }else{
            openFileButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_ATTCH_URL"){
            openUrlButton.isHidden = false
        }else{
            openUrlButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Button Action..
    @IBAction func takePhotoButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else {
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: selectedTaskObjRef.entity) == true{
                mJCLogger.log("This_is_a_local_Task_You_cannot_add_attachment".localized() , Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_Task_You_cannot_add_attachment".localized(), button: okay)
            }else{
                if isActiveNotification == true{
                    self.openCamera()
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
            notifiAttachmentsViewModel.selectedbutton = "takePhoto"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func takeVideoButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else {
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: selectedTaskObjRef.entity) == true{
                mJCLogger.log("This_is_a_local_Task_You_cannot_add_attachment".localized() , Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_Task_You_cannot_add_attachment".localized(), button: okay)
            }else{
                if isActiveNotification == true{
                    self.openVideoCamera()
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
            notifiAttachmentsViewModel.selectedbutton = "takeVideo"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func openGalleryButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else {
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: selectedTaskObjRef.entity) == true{
                mJCLogger.log("This_is_a_local_Task_You_cannot_add_attachment".localized() , Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_Task_You_cannot_add_attachment".localized(), button: okay)
            }else{
                if isActiveNotification == true{
                    self.openPhotoLibrary()
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
            notifiAttachmentsViewModel.selectedbutton = "choosePhoto"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func openFileButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else {
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: selectedTaskObjRef.entity) == true{
                mJCLogger.log("This_is_a_local_Task_You_cannot_add_attachment".localized() , Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_Task_You_cannot_add_attachment".localized(), button: okay)
            }else{
                if isActiveNotification == true{
                    self.openiCloudDrive()
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func uploadNotifiAttachmentUrlButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else {
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: selectedTaskObjRef.entity) == true{
                mJCLogger.log("This_is_a_local_Task_You_cannot_add_attachment".localized() , Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_Task_You_cannot_add_attachment".localized(), button: okay)
            }else{
                if isActiveNotification == true{
                    self.urlPasteButton.isHidden = false
                    self.urlUploadButton.isHidden = false
                    self.urlView.isHidden = false
                    urlView.layer.cornerRadius = 10
                    urlView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    urlView.layer.borderWidth = 1.0
                    urlView.layer.borderColor = #colorLiteral(red: 0.337254902, green: 0.5411764706, blue: 0.6784313725, alpha: 1)
                    urlView.layer.cornerRadius = 5
                    urlTextView.layer.borderWidth = 1.0
                    urlTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    self.urlTextView.isUserInteractionEnabled = true
                    self.urldescriptionTextField.isUserInteractionEnabled = true
                    urlTextView.layer.cornerRadius = 5.0
                    urldescriptionTextField.delegate = self
                    urldescriptionTextField.layer.cornerRadius = 5
                    urldescriptionTextField.layer.borderWidth = 1.0
                    urldescriptionTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    urlViewCloseButton.clipsToBounds = true
                    urlViewCloseButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func openDownloadItemButtonAction(sender: AnyObject) {}
    @IBAction func segmentAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        if self.attachmentSegment.selectedSegmentIndex == 0 {
            attachmentSegment.setTitle("Attachments".localized(), forSegmentAt: 0)
            self.attachmentView.isHidden = false
            self.uploadedView.isHidden = true
            attachmentuploadTab = false
        }else if self.attachmentSegment.selectedSegmentIndex == 1 {
            attachmentSegment.setTitle("Uploaded".localized(), forSegmentAt: 1)
            self.attachmentView.isHidden = true
            self.uploadedView.isHidden = false
            attachmentuploadTab = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Open Photo Camera ..
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
            mJCLogger.log("There_is_no_camera_available_on_this_device".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Open Photo Library..
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
    func openVideoCamera() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.camera)!
                imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeAVIMovie as String ,kUTTypeVideo as String ,kUTTypeMPEG4 as String]
                imagePicker.allowsEditing = true
                imagePicker.videoQuality = .typeMedium
                self.present(imagePicker, animated: false, completion: nil)
            }
        }else {
            mJCLogger.log("There_is_no_camera_available_on_this_device".localized() , Type: "Debug")
            mJCAlertHelper.showAlert(self, title: sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        mJCLogger.log("Starting", Type: "info")
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            if fromScreen == "NOTIFICATIONTASK"{
                uploadAttachmentVC.itemNum = itemNum
                uploadAttachmentVC.taskNum = taskNum
            }
            var arr = NSArray()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
            let dateString = dateFormatter.string(from: NSDate() as Date)
            isSupportPortait = false
            if notifiAttachmentsViewModel.selectedbutton == "takePhoto" || notifiAttachmentsViewModel.selectedbutton == "choosePhoto" {
                if notifiAttachmentsViewModel.selectedbutton == "takePhoto" {
                    uploadAttachmentVC.fileType = defaultImageType
                }else {
                    let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                    notifiAttachmentsViewModel.newFileName = imageURL.lastPathComponent!
                    arr = (notifiAttachmentsViewModel.newFileName.components(separatedBy: ".")) as NSArray
                    uploadAttachmentVC.fileType = (arr[1] as! String).lowercased()
                }
                notifiAttachmentsViewModel.selectedbutton = ""
                let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                notifiAttachmentsViewModel.imagePicked.image = chosenImage
                notifiAttachmentsViewModel.imageData = chosenImage.pngData()! as NSData
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
                    notifiAttachmentsViewModel.clodeFileName = newurl.lastPathComponent.replacingOccurrences(of: ".\(newurl.pathExtension)", with: "")
                    let tempDocID = String.random(length: 4, type: "Number")
                    notifiAttachmentsViewModel.clodeFileName = "Video\(dateString)_\(tempDocID)"
                    let newfilePath: String! = "\(filePath!)/\(notifiAttachmentsViewModel.clodeFileName).\(newurl.pathExtension)"
                    do {
                        try myAsset.fileManager.copyItem(atPath: newurl.path, toPath: newfilePath!)
                    }
                    catch let error as NSError {
                        if error.code == NSFileWriteFileExistsError{
                            do {
                                try myAsset.fileManager.removeItem(atPath: newurl.path)
                                mJCLogger.log("Existing file deleted.", Type: "Debug")
                            } catch {
                                mJCLogger.log("Failed to delete existing file:\n\((error as NSError).description)", Type: "Error")
                                print("Failed to delete existing file:\n\((error as NSError).description)")
                            }
                            do{
                                try myAsset.fileManager.copyItem(atPath: newurl.path, toPath: newfilePath!)
                            }catch {
                                mJCLogger.log("File not saved:\n\((error as NSError).description)", Type: "Error")
                                print("File not saved:\n\((error as NSError).description)")
                            }
                        }
                        mJCLogger.log("Clode Img error \n \(error.localizedDescription)", Type: "Error")
                    }
                    do {
                        let asset = AVURLAsset(url: NSURL(fileURLWithPath: newfilePath) as URL, options: nil)
                        let imgGenerator = AVAssetImageGenerator(asset: asset)
                        imgGenerator.appliesPreferredTrackTransform = true
                        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                        let uiImage = UIImage(cgImage: cgImage)
                        uploadAttachmentVC.imgData = uiImage.png!
                    } catch let error as NSError {
                        mJCLogger.log("Error generating thumbnail: \(error)", Type: "Error")
                        print("Error generating thumbnail: \(error)")
                    }
                    notifiAttachmentsViewModel.selectedbutton = ""
                    uploadAttachmentVC.fileName  =  notifiAttachmentsViewModel.clodeFileName
                    uploadAttachmentVC.videoLink =  NSURL(string: newfilePath)!
                    uploadAttachmentVC.fileType = "\(newurl.pathExtension)"
                    uploadAttachmentVC.attachmentType = "Video"
                    uploadAttachmentVC.modalPresentationStyle = .fullScreen
                    self.dismiss(animated: false, completion: {
                        self.present(uploadAttachmentVC, animated: false) {}
                    })
                }
            }
        }else{
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentLowScreen()
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            uploadAttachmentVC.itemNum = itemNum
            uploadAttachmentVC.taskNum = taskNum
            var arr = NSArray()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
            let dateString = dateFormatter.string(from: NSDate() as Date)
            isSupportPortait = false
            if notifiAttachmentsViewModel.selectedbutton == "takePhoto" || notifiAttachmentsViewModel.selectedbutton == "choosePhoto" {
                if notifiAttachmentsViewModel.selectedbutton == "takePhoto" {
                    uploadAttachmentVC.fileType = defaultImageType
                } else {
                    let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                    notifiAttachmentsViewModel.newFileName = imageURL.lastPathComponent!
                    arr = (notifiAttachmentsViewModel.newFileName.components(separatedBy: ".")) as NSArray
                    uploadAttachmentVC.fileType = (arr[1] as! String).lowercased()
                }
                notifiAttachmentsViewModel.selectedbutton = ""
                let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                notifiAttachmentsViewModel.imagePicked.image = chosenImage
                notifiAttachmentsViewModel.imageData = chosenImage.pngData()! as NSData
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
                    notifiAttachmentsViewModel.clodeFileName = newurl.lastPathComponent.replacingOccurrences(of: ".\(newurl.pathExtension)", with: "")
                    let tempDocID = String.random(length: 4, type: "Number")
                    notifiAttachmentsViewModel.clodeFileName = "Video\(dateString)_\(tempDocID)"
                    let newfilePath: String! = "\(filePath!)/\(notifiAttachmentsViewModel.clodeFileName).\(newurl.pathExtension)"
                    do {
                        try myAsset.fileManager.copyItem(atPath: newurl.path, toPath: newfilePath!)
                    }
                    catch let error as NSError {
                        if error.code == NSFileWriteFileExistsError{
                            do {
                                try myAsset.fileManager.removeItem(atPath: newurl.path)
                                mJCLogger.log("Existing file deleted.", Type: "Debug")
                                
                            } catch {
                                mJCLogger.log("Existing file deleted.", Type: "Error")
                                print("Failed to delete existing file:\n\((error as NSError).description)")
                            }
                            do{
                                try myAsset.fileManager.copyItem(atPath: newurl.path, toPath: newfilePath!)
                            }catch {
                                mJCLogger.log("File not saved:\n\((error as NSError).description)", Type: "Error")
                                print("File not saved:\n\((error as NSError).description)")
                            }
                        }
                        mJCLogger.log("Clode Img error \n \(error.localizedDescription)", Type: "Error")
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
                        mJCLogger.log("Error generating thumbnail: \(error)", Type: "Error")
                        print("Error generating thumbnail: \(error)")
                    }
                    notifiAttachmentsViewModel.selectedbutton = ""
                    uploadAttachmentVC.fileName  =  notifiAttachmentsViewModel.clodeFileName
                    uploadAttachmentVC.videoLink =  NSURL(string: newfilePath)!
                    uploadAttachmentVC.fileType = "\(newurl.pathExtension)"
                    uploadAttachmentVC.attachmentType = "Video"
                    uploadAttachmentVC.modalPresentationStyle = .fullScreen
                    self.dismiss(animated: false, completion: {
                        self.present(uploadAttachmentVC, animated: false) {}
                    })
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Open iCloud Drive
    func openiCloudDrive(){
        mJCLogger.log("Starting", Type: "info")
        let importMenuVC = UIDocumentMenuViewController(documentTypes: [kUTTypePNG as String, kUTTypePDF as String, kUTTypeJPEG as String, kUTTypeText as String,kUTTypeMovie as String,kUTTypeSpreadsheet as String,kUTTypePresentation as String], in: .import)
        importMenuVC.delegate = self
        importMenuVC.modalPresentationStyle = .popover
        importMenuVC.popoverPresentationController?.sourceView = self.view
        DispatchQueue.main.async {
            if DeviceType == iPad{
                if self.openUrlButton.isHidden == true {
                    let sourceRect = CGRect(x: self.viewOptionsHolder.frame.origin.x, y: self.viewOptionsHolder.frame.origin.y + self.viewOptionsHolder.frame.size.height - 20, width: 0, height: 0)
                    importMenuVC.popoverPresentationController?.sourceRect = sourceRect
                }else{
                    let sourceRect = CGRect(x: self.viewOptionsHolder.frame.origin.x, y: self.viewOptionsHolder.frame.origin.y + self.viewOptionsHolder.frame.size.height - 60, width: 0, height: 0)
                    importMenuVC.popoverPresentationController?.sourceRect = sourceRect
                }
                self.present(importMenuVC, animated: true) {}
            }else{
                self.present(importMenuVC, animated: true) {}
            }
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
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: true) {}
        mJCLogger.log("Ended", Type: "info")
    }
    internal func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL){
        
        mJCLogger.log("Starting", Type: "info")
                let url1 = NSURL(fileURLWithPath: documentPath)
        let filePath = url1.appendingPathComponent("iCloud")?.path
        do {
            try myAsset.fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error.localizedDescription);
        }
        notifiAttachmentsViewModel.clodeFileName = url.lastPathComponent.replacingOccurrences(of: ".\(url.pathExtension)", with: "")
        let tempDocID = String.random(length: 4, type: "Number")
        notifiAttachmentsViewModel.clodeFileName = "\(notifiAttachmentsViewModel.clodeFileName )_\(tempDocID)"
        let newfilePath: String! = "\(filePath!)/\(notifiAttachmentsViewModel.clodeFileName).\(url.pathExtension)"
        do {
            try myAsset.fileManager.copyItem(atPath: url.path, toPath: newfilePath!)
        }
        catch let error as NSError {
            if error.code == NSFileWriteFileExistsError{
                do {
                    try myAsset.fileManager.removeItem(atPath: url.path)
                    mJCLogger.log("Existing file deleted.", Type: "Debug")
                } catch {
                    mJCLogger.log("Failed to delete existing file:\n\((error as NSError).description)", Type: "Error")
                    print("Failed to delete existing file:\n\((error as NSError).description)")
                }
                do{
                    try myAsset.fileManager.copyItem(atPath: url.path, toPath: newfilePath!)
                }catch {
                    mJCLogger.log("File not saved:\n\((error as NSError).description)", Type: "Error")
                    print("File not saved:\n\((error as NSError).description)")
                }
            }
            mJCLogger.log("Clode Img error \n \(error.localizedDescription)", Type: "Error")
        }
        notifiAttachmentsViewModel.urlDoc = url as NSURL
        notifiAttachmentsViewModel.docPath = newfilePath
        self.perform(#selector(self.presentController), with: nil, afterDelay: 0.1)
    }
    @objc func presentController()  {
        mJCLogger.log("Starting", Type: "info")
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            uploadAttachmentVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            uploadAttachmentVC.fileType = notifiAttachmentsViewModel.urlDoc.pathExtension!
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            if fromScreen == "NOTIFICATIONTASK"{
                uploadAttachmentVC.itemNum = itemNum
                uploadAttachmentVC.taskNum = taskNum
            }
            var title = notifiAttachmentsViewModel.urlDoc.lastPathComponent?.replacingOccurrences(of: ".\(notifiAttachmentsViewModel.urlDoc.pathExtension!)", with: "")
            let tempDocID = String.random(length: 4, type: "Number")
            title = "\(title ?? "File")_\(tempDocID).\(notifiAttachmentsViewModel.urlDoc.pathExtension!)"

            if imgExtensions.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.imageURL = notifiAttachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Video"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.videoLink = notifiAttachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }else if notifiAttachmentsViewModel.urlDoc.pathExtension! == "pdf" {
                uploadAttachmentVC.attachmentType = "pdf"
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "doc"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
            }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "xls"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
            }else{
                uploadAttachmentVC.attachmentType = "other"
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            uploadAttachmentVC.isFromScreen = fromScreen
            uploadAttachmentVC.objectNum = objectNum
            self.present(uploadAttachmentVC, animated: false) {
            }
        }else{
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentLowScreen()
            uploadAttachmentVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            uploadAttachmentVC.fileType = notifiAttachmentsViewModel.urlDoc.pathExtension!
            var title = notifiAttachmentsViewModel.urlDoc.lastPathComponent?.replacingOccurrences(of: ".\(notifiAttachmentsViewModel.urlDoc.pathExtension!)", with: "")
            let tempDocID = String.random(length: 4, type: "Number")
            title = "\(title ?? "File")_\(tempDocID).\(notifiAttachmentsViewModel.urlDoc.pathExtension!)"

            if imgExtensions.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.imageURL = notifiAttachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }else if videoExtensios.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "Video"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.videoLink = notifiAttachmentsViewModel.urlDoc
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }else if notifiAttachmentsViewModel.urlDoc.pathExtension! == "pdf" {
                uploadAttachmentVC.attachmentType = "pdf"
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }else if docExtensions.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "doc"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
            }else if excelExtensions.contains(where: {$0.caseInsensitiveCompare(notifiAttachmentsViewModel.urlDoc.pathExtension!) == .orderedSame}){
                uploadAttachmentVC.attachmentType = "xls"
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
            }else{
                uploadAttachmentVC.attachmentType = "other"
                uploadAttachmentVC.docURL = notifiAttachmentsViewModel.docPath
                uploadAttachmentVC.isfromIcloud = true
                uploadAttachmentVC.fileName  = notifiAttachmentsViewModel.clodeFileName
            }
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            uploadAttachmentVC.isFromScreen = fromScreen
            self.present(uploadAttachmentVC, animated: false) {
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    internal func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: true) {}
        mJCLogger.log("Ended", Type: "info")
    }
    open override var shouldAutorotate: Bool {
        return false
    }
    func getUploadAttachmentUI(){
        mJCLogger.log("Starting", Type: "info")
        if notifiAttachmentsViewModel.uploadedAttachmentArray.count > 0 {
            DispatchQueue.main.async {
                self.uploadedTableView.reloadData()
                self.noUploadedAttachmentFoundLabel.isHidden = true
                self.uploadedTableView.isHidden = false
            }
        }else{
            DispatchQueue.main.async {
                self.uploadedTableView.reloadData()
                self.noUploadedAttachmentFoundLabel.isHidden = false
                self.uploadedTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getAttachmentUI(){
        mJCLogger.log("Starting", Type: "info")
        if notifiAttachmentsViewModel.attachementArray.count > 0 {
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
        let count = notifiAttachmentsViewModel.attachementArray.count + notifiAttachmentsViewModel.uploadedAttachmentArray.count
        if attachDelegate != nil{
            attachDelegate?.updateTaskAttachment(count: count)
        }
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
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                mJCLogger.log("Unable to Add Notification Request (\(error), \(error.localizedDescription))", Type: "Error")
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func toAbsolutePath() -> String {
        mJCLogger.log("Starting", Type: "info")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let dirPath = paths.first else {
            mJCLogger.log("Ended", Type: "info")
            return ""
        }
        mJCLogger.log("Ended", Type: "info")
        return dirPath
    }
    
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber != ""{
            notifiAttachmentsViewModel.getAttachment()
        }else{
            DispatchQueue.main.async {
                self.noUploadedAttachmentFoundLabel.isHidden = false
                self.uploadedTableView.isHidden = true
                self.noAttachmentFoundLabel.isHidden = false
                self.attachmentTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func pasteUrlButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let urlString = UIPasteboard.general.string {
            if let url = URL(string: urlString) {
                if  UIApplication.shared.canOpenURL(url){
                    self.urlTextView.text = "\(url)"
                }else{
                    mJCLogger.log("Please_copy_some_valid_Url_to_Uplaod".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_copy_some_valid_Url_to_Uplaod".localized(), button: okay)
                }
            }else{
                mJCLogger.log("Please_copy_some_valid_Url_to_Uplaod".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_copy_some_valid_Url_to_Uplaod".localized(), button: okay)
                self.uploadUrlviewHeightConstraint.constant = 180
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func previewUrlButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let url = URL(string: self.urlTextView.text ?? "") {
            if  UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Open url : \(success)")
                })
            }else{
                mJCLogger.log("Invalid_Url".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Invalid_Url".localized(), button: okay)
            }
        }else{
            mJCLogger.log("Invalid_Url".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Invalid_Url".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func uploadUrlButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if self.urlTextView.text == ""{
            mJCLogger.log("Please_copy_some_URL".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_copy_some_URL".localized(), button: okay)
        }else if URL(string: self.urlTextView.text) == nil || !UIApplication.shared.canOpenURL(URL(string: self.urlTextView.text!)!) {
            mJCLogger.log("Invalid_Url".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Invalid_Url".localized(), button: okay)
        }else if self.urldescriptionTextField.text == ""{
            mJCLogger.log("Please_add_Description_to_URL".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_add_Description_to_URL".localized(), button: okay)
        }else{
            notifiAttachmentsViewModel.uploadUrlNotificationAttachment()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func urlViewCloseButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.urlTextView.text = ""
            self.urldescriptionTextField.text = ""
            self.urlView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func uploadPlusButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if self.uploadOptionsFlag == true{
            self.uploadOptionsFlag = false
            uploadOptionsView.isHidden = true
        }else{
            self.uploadOptionsFlag = true
            uploadOptionsView.isHidden = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
extension NotificationAttachmentVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}

