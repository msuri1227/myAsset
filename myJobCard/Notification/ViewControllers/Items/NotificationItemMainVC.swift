//
//  NotificationItemMainVC.swift
//  myJobCard
//
//  Created by Rover Software on 05/05/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class NotificationItemMainVC: UIViewController,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate{
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet var iPhoneHeader: UIView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var notificationItemVC : NotificationItemVC?
    var notificationFrom = String()
    var isfromItem = Bool()
    var isfrom = String()
    var itemActivityArray = [NotificationActivityModel]()
    var itemTaskArray = [NotificationTaskModel]()
    var itemCausesArray = [NotificationItemCauseModel]()
    var headerView = CustomNavHeader_iPhone()
    let menudropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType == iPhone {
            headerView = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Notification_No".localized() + ". \(selectedNotificationNumber))", NewJobButton: false, refresButton: true, threedotmenu: true,leftMenuType:"")
            self.iPhoneHeader.addSubview(headerView)
            if flushStatus == true{
                headerView.refreshBtn.showSpin()
            }
            headerView.delegate = self
            self.SlideMenuSelected(index: 1, title: "Overview".localized() ,menuType: "")
            self.createBatchRequestForTransactionCount()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            headerView.refreshBtn.showSpin()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    func createBatchRequestForTransactionCount(){
        var itemActivityQuery = String()
        var itemTaskQuery = String()
        var itemCaseQuery = String()
        if notificationFrom == "FromWorkorder"{
            itemActivityQuery = "\(woNotificationActivityCollection)?$filter=(Notification%20eq%20%27\(selectedNotificationNumber)%27 and Item eq '\(selectedItem)')&$orderby=Activity"
            itemTaskQuery = "\(woNotificationTaskCollection)?$filter=(Notification%20eq%20%27\(selectedNotificationNumber)%27 and Item eq '\(selectedItem)')&$orderby=Task"
            itemCaseQuery =  "\(woNotificationItemCausesCollection)?$filter=Notification eq '\(selectedNotificationNumber)' and Item eq '\(selectedItem)'&$orderby=Cause"
        }else{
            itemActivityQuery = "\(notificationActivitySet)?$filter=(Notification%20eq%20%27\(selectedNotificationNumber)%27 and Item eq '\(selectedItem)')&$orderby=Activity"
            itemTaskQuery = "\(notificationTaskSet)?$filter=(Notification%20eq%20%27\(selectedNotificationNumber)%27 and Item eq '\(selectedItem)')&$orderby=Task"
            itemCaseQuery =  "\(notificationItemCauseSet)?$filter=Notification eq '\(selectedNotificationNumber)' and Item eq '\(selectedItem)'&$orderby=Cause"
        }
        let batchArr = NSMutableArray()
        batchArr.add(itemActivityQuery)
        batchArr.add(itemTaskQuery)
        batchArr.add(itemCaseQuery)
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
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == "NotificationActivitySet" {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                            if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                if NoActivityArr.count > 0{
                                    ItemActvityCount = "\(NoActivityArr.count)"
                                }else{
                                    ItemActvityCount = ""
                                }
                            }
                        }else if resourcePath == "NotificationTaskSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                if NoTaskArr.count > 0{
                                    ItemTaskCount = "\(NoTaskArr.count)"
                                }else{
                                    ItemTaskCount = ""
                                }
                            }
                        }else if resourcePath == notificationItemCauseSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemCauseModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationItemCauseModel]{
                                if NoTaskArr.count > 0{
                                    ItemCauseCount = "\(NoTaskArr.count)"
                                }else{
                                    ItemCauseCount = ""
                                }
                            }
                        }else if resourcePath == "WONotificationActivityCollection" {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                            if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                if NoActivityArr.count > 0{
                                    ItemActvityCount = "\(NoActivityArr.count)"
                                }else{
                                    ItemActvityCount = ""
                                }
                            }
                        }else if resourcePath == "WONotificationTaskCollection"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                if NoTaskArr.count > 0{
                                    ItemTaskCount = "\(NoTaskArr.count)"
                                }else{
                                    ItemTaskCount = ""
                                }
                            }
                        }else if resourcePath == woNotificationItemCausesCollection{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemCauseModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationItemCauseModel]{
                                if NoTaskArr.count > 0{
                                    ItemCauseCount = "\(NoTaskArr.count)"
                                }else{
                                    ItemCauseCount = ""
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func SlideMenuSelected(index: Int, title: String,menuType: String){
        if title == "Overview".localized() {
            DispatchQueue.main.async {
                self.notificationItemVC = ScreenManager.getNotificationItemScreen()
                self.notificationItemVC?.notificationFrom = self.notificationFrom
                self.addChild(self.notificationItemVC!)
                for view in self.self.mainHolderView.allSubviews{
                    view.removeFromSuperview()
                }
                self.notificationItemVC?.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
                self.mainHolderView.addSubview(self.notificationItemVC!.view)
                self.notificationItemVC?.didMove(toParent: self)
                self.viewWillAppear(false)
            }
        }else if title == "Activities".localized() {
            let operationsVC = ScreenManager.getNotificationItemListScreen()
            addChild(operationsVC)
            for view in self.self.mainHolderView.allSubviews{
                view.removeFromSuperview()
            }
            if isfromItem == true{
                isItemActivity = true
                operationsVC.isfrom = "ItemActivities"
                operationsVC.isfromItem = isItemActivity
                self.isfrom = "ItemActivities"
            }else{
                isItemActivity = false
                operationsVC.isfrom = "Activities"
            }
            operationsVC.notifListViewModel.notificationFrom = notificationFrom
            operationsVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(operationsVC.view)
            operationsVC.didMove(toParent: self)
        }else if title == "Tasks".localized() {
            let operationsVC = ScreenManager.getNotificationItemListScreen()
            addChild(operationsVC)
            for view in self.self.mainHolderView.allSubviews{
                view.removeFromSuperview()
            }
            if isfromItem == true{
                operationsVC.isfrom = "ItemTasks"
                self.isfrom = "ItemTasks"
                isItemTask = true
                operationsVC.isfromItem = isItemTask
            }else{
                isItemTask = false
                operationsVC.isfrom = "Tasks"
            }
            operationsVC.notifListViewModel.notificationFrom = notificationFrom
            operationsVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(operationsVC.view)
            operationsVC.didMove(toParent: self)
        }else if title == "Causes".localized() {
            let notificationItemListVC = ScreenManager.getNotificationItemListScreen()
            addChild(notificationItemListVC)
            for view in self.self.mainHolderView.allSubviews{
                view.removeFromSuperview()
            }
            notificationItemListVC.isfrom = "ItemCauses"
            self.isfrom = "ItemCauses"
            isItemCause = true
            notificationItemListVC.notifListViewModel.notificationFrom = notificationFrom
            notificationItemListVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(notificationItemListVC.view)
            notificationItemListVC.didMove(toParent: self)
        }
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        openLeft()
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateNotificationScreen(vc: self)
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
            }
        }
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if self.isfrom == "ItemActivities"{
            menuarr = ["Create_Item_Activity".localized()]
            imgArray = [#imageLiteral(resourceName: "addIcon")]
        }else if self.isfrom == "ItemTasks"{
            menuarr = ["Create_Item_Task".localized()]
            imgArray = [#imageLiteral(resourceName: "addIcon")]
        }else if self.isfrom == "ItemCauses"{
            menuarr = ["Create_Item_Causes".localized()]
            imgArray = [#imageLiteral(resourceName: "addIcon")]
        }else{
            menuarr = ["Edit_Item".localized()]
            imgArray = [#imageLiteral(resourceName: "editIcon")]
            if !applicationFeatureArrayKeys.contains("NO_EDIT_ITEM_OPTION"){
                if let index =  menuarr.firstIndex(of: "Edit_Item".localized()){
                    menuarr.remove(at: index)
                    imgArray.remove(at: index)
                }
            }
        }
        if menuarr.count == 0{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Options_Available".localized(), button: okay)
        }
        menudropDown.dataSource = menuarr
        self.customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Edit_Item".localized() {
                if isActiveNotification == true{
                    self.notificationItemVC?.editItemButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Create_Item_Activity".localized() {
                if isActiveNotification == true{
                    let count = "\(self.itemActivityArray.count+1)"
                    menuDataModel.presentCreateActivityScreen(vc: self, sortCount: count, itemActivity: true)
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Create_Item_Task".localized() {
                if isActiveNotification == true{
                    let count = "\(self.itemTaskArray.count+1)"
                    menuDataModel.presentCreateTaskScreen(vc: self, sortCount: count, itemTask: true)
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Create_Item_Causes".localized() {
                if isActiveNotification == true{
                    let count = "\(self.itemCausesArray.count+1)"
                    menuDataModel.presentCreateItemCauseScreen(vc: self, sortCount: count, itemCause: true)
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
        }
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
    func createBatchRequestForTransactionCount1(){
        let batchArr = NSMutableArray()
        if isSingleNotification == true{
            let itemList  = DefineRequestModelClass.uniqueInstance.getNotificationItems(type: "List", notificationNum: selectedNotificationNumber, itemNum: "", notificationFrom: "FromWorkorder") as String
            let ActivityList = DefineRequestModelClass.uniqueInstance.getNotificationActivity(type: "List", notificationNum: selectedNotificationNumber, activityNum: "",notificationFrom: "FromWorkorder", ItemNum: "0000") as String
            let taskList = DefineRequestModelClass.uniqueInstance.getNotificationTask(type: "List", notificationNum: selectedNotificationNumber, taskNum: "", notificationFrom: "FromWorkorder", ItemNum: "0000") as String
            let NoUploadList = uploadNOAttachmentContentSet + "?$filter=(Notification%20eq%20%27" + (selectedNotificationNumber) + "%27 and BINARY_FLG ne 'N')";
            let NoAttachList = "WONOAttachmentSet" + "?$filter=(endswith(ObjectKey, '\(selectedNotificationNumber)') eq true)"
            batchArr.add(itemList)
            batchArr.add(ActivityList)
            batchArr.add(taskList)
            batchArr.add(NoUploadList)
            batchArr.add(NoAttachList)
        }else{
            let itemList = DefineRequestModelClass.uniqueInstance.getNotificationItems(type: "deleteList", notificationNum: selectedNotificationNumber, itemNum: "", notificationFrom: "") as String
            let ActivityList = DefineRequestModelClass.uniqueInstance.getNotificationActivity(type: "List", notificationNum: selectedNotificationNumber, activityNum: "",notificationFrom: "", ItemNum: "0000") as String
            let taskList = DefineRequestModelClass.uniqueInstance.getNotificationTask(type: "List", notificationNum: selectedNotificationNumber, taskNum: "", notificationFrom: "", ItemNum: "0000") as String
            let NoUploadList = uploadNOAttachmentContentSet + "?$filter=(Notification%20eq%20%27" + (selectedNotificationNumber) + "%27 and BINARY_FLG ne 'N')";
            let NoAttachList = "NOAttachmentSet" + "?$filter=(endswith(ObjectKey, '\(selectedNotificationNumber)') eq true)"
            batchArr.add(itemList)
            batchArr.add(ActivityList)
            batchArr.add(taskList)
            batchArr.add(NoUploadList)
            batchArr.add(NoAttachList)
        }
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
                    var NoCompIdArr = [String]()
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == "NotificationActivitySet" {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                            if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                if NoActivityArr.count > 0{
                                    ActvityCount = "\(NoActivityArr.count)"
                                }else{
                                    ActvityCount = ""
                                }
                            }
                        }else if resourcePath == notificationItemSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                            if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                if NoItemArr.count > 0{
                                    ItemCount = "\(NoItemArr.count)"
                                }else{
                                    ItemCount = ""
                                }
                            }
                        }else if resourcePath == "NotificationTaskSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                if NoTaskArr.count > 0{
                                    TaskCount = "\(NoTaskArr.count)"
                                }else{
                                    TaskCount = ""
                                }
                            }
                        }else if resourcePath == uploadNOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                            if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                
                                if(uploadattacharray.count > 0) {
                                    NoUploadAttachmentArr = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Item == "" && $0.Task == ""}
                                }
                            }
                        }else if resourcePath == "NOAttachmentSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                if(Noattacharray.count > 0) {
                                    NoAttachmentArr = Noattacharray
                                }
                            }
                            if  let NocompIdArr = dict["CompID"] as? [String]{
                                if(NocompIdArr.count > 0) {
                                    NoCompIdArr = NocompIdArr
                                }
                            }
                        }else if resourcePath == "WONotificationActivityCollection" {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                            if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                if NoActivityArr.count > 0{
                                    ActvityCount = "\(NoActivityArr.count)"
                                }else{
                                    ActvityCount = ""
                                }
                            }
                        }else if resourcePath == "WONotificationItemCollection"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                            if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                if NoItemArr.count > 0{
                                    ItemCount = "\(NoItemArr.count)"
                                }else{
                                    ItemCount = ""
                                }
                            }
                        }else if resourcePath == "WONotificationTaskCollection"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                if NoTaskArr.count > 0{
                                    TaskCount = "\(NoTaskArr.count)"
                                }else{
                                    TaskCount = ""
                                }
                            }
                        }else if resourcePath == "WONOAttachmentSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                if(Noattacharray.count > 0) {
                                    NoAttachmentArr = Noattacharray
                                }
                            }
                            if  let NocompIdArr = dict["CompID"] as? [String]{
                                if(NocompIdArr.count > 0) {
                                    NoCompIdArr = NocompIdArr
                                }
                            }
                        }
                    }
                    self.setNoAttachementCount( NoAttachmentArr: NoAttachmentArr, NoUploadAttachmentArr: NoUploadAttachmentArr, NoCompIdArr: NoCompIdArr, fromBatch: false)
                }
            }
        }
    }
    func setNoAttachementCount(NoAttachmentArr:[AttachmentModel],NoUploadAttachmentArr:[UploadedAttachmentsModel],NoCompIdArr:[String],fromBatch:Bool){
        if NoAttachmentArr.count > 0{
            let uploadedAttachementCount = NoUploadAttachmentArr.count
            let totalAttchmentCount = NoAttachmentArr.count + uploadedAttachementCount
            if (totalAttchmentCount > 0) {
                noAttchmentCount = "\(totalAttchmentCount)"
            }else {
                noAttchmentCount = ""
            }
        }else{
            let uploadedAttachementCount = NoUploadAttachmentArr.count
            if (uploadedAttachementCount > 0) {
                noAttchmentCount = "\(uploadedAttachementCount)"
            }else {
                noAttchmentCount = ""
            }
        }
    }
    func backButtonClicked(_ sender: UIButton?){
        selectedItem = ""
        self.createBatchRequestForTransactionCount1()
    }
}
