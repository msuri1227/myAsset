//
//  NotificationMainTaskVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 18/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation


class NotificationMainTaskVC: UIViewController,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate {
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet var iPhoneHeader: UIView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var notificationTaskVC : NotificationTaskVC?
    var noAttachmentsVC : NotificationAttachmentVC?
    var notificationFrom = String()
    var selectedTaskNum = String()
    var itemNum = String()
    var isFromScreen = String()
    var notificationTaskViewModel = NotificationTaskViewModel()
    var headerView : CustomNavHeader_iPhone?
    let menudropDown = DropDown()
    var taskOverView = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone {
            headerView = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Notification_No".localized() + ". \(selectedNotificationNumber)", NewJobButton: false, refresButton: true, threedotmenu: true,leftMenuType:"")
            self.iPhoneHeader.addSubview(headerView!)
            if flushStatus == true{
                headerView!.refreshBtn.showSpin()
            }
            headerView!.delegate = self
            taskOverView = true
            self.SlideMenuSelected(index: 1, title: "Overview".localized() ,menuType: "")
            self.createBatchRequestForAttachmentCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            if flushStatus == true{
                headerView!.refreshBtn.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func SlideMenuSelected(index: Int, title: String,menuType: String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Overview".localized() {
            notificationTaskVC = ScreenManager.getNotificationTaskScreen()
            notificationTaskVC?.notificationFrom = notificationFrom
            notificationTaskVC?.isfromscreen = isFromScreen
            notificationTaskVC?.itemNum = self.itemNum
            notificationTaskVC?.notificationTaskViewModel.selectedTask = selectedTaskNum
            addChild(notificationTaskVC!)
            for view in self.mainHolderView.subviews{
                view.removeFromSuperview()
            }
            notificationTaskVC?.taskOverView = taskOverView
            self.mainHolderView.frame.origin.y = 104
            if screenHeight <= 667{
                if taskOverView == true{
                    notificationTaskVC?.view.frame = CGRect(x: 0, y: 20, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
                }else{
                    notificationTaskVC?.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height + 20)
                }
            }else{
                if taskOverView == true{
                    notificationTaskVC?.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height + 8)
                }else{
                    notificationTaskVC?.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height + 50)
                }
            }
            self.mainHolderView.addSubview(notificationTaskVC!.view)
            taskOverView = false
            notificationTaskVC?.didMove(toParent: self)
        }else if title == "Attachments".localized() {
            noAttachmentsVC = ScreenManager.getNotificationAttachmentScreen()
            addChild(noAttachmentsVC!)
            noAttachmentsVC!.objectNum = selectedNotificationNumber
            noAttachmentsVC!.fromScreen = "NOTIFICATIONTASK"
            noAttachmentsVC!.itemNum = itemNum
            notificationTaskVC?.notificationFrom = notificationFrom
            noAttachmentsVC!.selectedTaskObjRef = notificationTaskVC!.selectedTaskObjRef
            noAttachmentsVC!.taskNum = selectedTaskNum
            noAttachmentsVC?.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(noAttachmentsVC!.view)
            noAttachmentsVC?.didMove(toParent: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createBatchRequestForAttachmentCount(){
        mJCLogger.log("Starting", Type: "info")
        let NoUploadList =  "\(uploadNOAttachmentContentSet)?$filter=(Notification eq '\(selectedNotificationNumber)' and Item eq '\(itemNum)' and Task eq '\(selectedTaskNum)' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        let objectKey = "\(selectedNotificationNumber)\(itemNum)\(selectedTaskNum)"
        let NoAttachList = "NOAttachmentSet?$filter=(endswith(ObjectKey, '" + objectKey + "') eq true)&$orderby=DocCount"
        let batchArr = NSMutableArray()
        batchArr.add(NoUploadList)
        batchArr.add(NoAttachList)
        let batchRequest = SODataRequestParamBatchDefault.init()
        for obj in batchArr {
            let str = obj as! String
            let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
            reqParam?.customTag = str
            batchRequest.batchItems.add(reqParam!)
        }
        BatchRequestModel.getExecuteTransactionBatchRequest(batchRequest: batchRequest){ (response, error)  in
            if error == nil {
                if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                    let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                    var NoAttachmentArr = Array<AttachmentModel>()
                    var NoUploadAttachmentArr =  Array<UploadedAttachmentsModel>()
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == uploadNOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                            if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                mJCLogger.log("Response:\(uploadattacharray.count)", Type: "Debug")
                                NoUploadAttachmentArr = uploadattacharray
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else if resourcePath == "NOAttachmentSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                if(Noattacharray.count > 0) {
                                    mJCLogger.log("Response:\(Noattacharray.count)", Type: "Debug")
                                    NoAttachmentArr = Noattacharray
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }
                    }
                    let count = NoAttachmentArr.count + NoUploadAttachmentArr.count
                    attchmentCount = "\(count)"
                    attchmentColor = appColor
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?) {
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isFromScreen == "ItemTasks" {
            if currentsubView == "Attachments"{
                menuarr = ["Capture_Image".localized(),"Capture_Video".localized(),"Upload_Image".localized(),"Upload_Document".localized(),"Upload_Url".localized()]
                imgArray = [#imageLiteral(resourceName: "captureImage"),#imageLiteral(resourceName: "uploadVideo"),#imageLiteral(resourceName: "uploadimage"),#imageLiteral(resourceName: "uploadURL")]
            }else{
                menuarr = ["Edit_Item_Task".localized()]
                imgArray = [#imageLiteral(resourceName: "editIcon")]
                if !applicationFeatureArrayKeys.contains("NO_EDIT_TASK_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Edit_Item_Task".localized()) {
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }
        }else{
            if currentsubView == "Attachments"{
                menuarr = ["Capture_Image".localized(),"Capture_Video".localized(),"Upload_Image".localized(),"Upload_Url".localized()]
                imgArray = [#imageLiteral(resourceName: "captureImage"),#imageLiteral(resourceName: "uploadVideo"),#imageLiteral(resourceName: "uploadimage"),#imageLiteral(resourceName: "uploadURL")]
            }else{
                menuarr = ["Edit_Task".localized()]
                imgArray = [#imageLiteral(resourceName: "editIcon")]
                if !applicationFeatureArrayKeys.contains("NO_EDIT_TASK_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Edit_Task".localized()) {
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }
        }
        if menuarr.count == 0{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Options_Available".localized(), button: okay)
        }
        menudropDown.dataSource = menuarr
        customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Edit_Task".localized() {
                if isActiveNotification == true{
                    self.notificationTaskVC?.editTaskButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Edit_Item_Task".localized() {
                if isActiveNotification == true{
                    self.notificationTaskVC?.editTaskButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item ==  "Capture_Image".localized(){
                if isActiveNotification == true{
                    self.noAttachmentsVC?.takePhotoButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Capture_Video".localized(){
                if isActiveNotification == true{
                    self.noAttachmentsVC?.takeVideoButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Upload_Image".localized(){
                if isActiveNotification == true{
                    self.noAttachmentsVC?.openGalleryButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Upload_Document".localized(){
                if isActiveNotification == true{
                    self.noAttachmentsVC?.openFileButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Upload_Url".localized(){
                if isActiveNotification == true{
                    self.noAttachmentsVC?.uploadNotifiAttachmentUrlButtonAction(UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        selectedTask = ""
        currentsubView = "Items"
        mJCLogger.log("Ended", Type: "info")
    }
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
