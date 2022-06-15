//
//  MasterListDetailVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/27/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import AVFoundation
class MasterListDetailVC: UIViewController,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TabCellDelegate,PageViewParent,CLLocationManagerDelegate,formSaveDelegate,timeSheetDelegate,CreateUpdateDelegate, operationCreationDelegate,listSelectionDelegate,viewModelDelegate{
    
    //MARK:- Headerview Outlets..
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var workOrderNumberLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var addNewJobButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var mainHolderView: UIView!
    @IBOutlet var attachmentImageVIew: UIImageView!
    @IBOutlet weak var workOrderSearchBtn: UIButton!
    @IBOutlet var lineview: UIView!
    @IBOutlet var HomeButton: UIButton!
    @IBOutlet var WorkorderCompleteTableView: UITableView!
    //MARK:- headerButtonScrollView Outlets for workOrder..
    @IBOutlet var headerButtonScrollView: UIScrollView!
    @IBOutlet var footerviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var headerview: UIView!
    //MARK:- headerButtonScrollView Outlets for Notification..
    @IBOutlet var notificationButtonScrollView: UIScrollView!
    @IBOutlet var notificationscrollViewBottonView: UIView!
    @IBOutlet var notificationBottomView: UIView!
    //FooterView Outlets..
    @IBOutlet var lastSyncDateLabel: UILabel!
    @IBOutlet weak var pendingTaskView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet  var mainHolderView_phone: UIView!
    @IBOutlet weak var StatusCollectionView: UICollectionView!
    //MARK:- Width constants for Application Featureset
    @IBOutlet open weak var menuCollectionView: UICollectionView!
    @IBOutlet open weak var selectedBar: UIView!
    @IBOutlet open weak var pageView: UIView!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet weak var statusViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet var statusViewTopConstant: NSLayoutConstraint!
    @IBOutlet var statusViewBottomConstant: NSLayoutConstraint!

    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var selectedButtonView = UIView()
    var splitViewControllerVC : UISplitViewController?
    var tempMoreValueArray = NSArray()
    var property = NSMutableArray()
    var curentReadingArray1 = NSMutableArray()
    var recordPointArray = NSMutableArray()
    var useracceptstatu = Bool()
    let menudropDown = DropDown()
    var dropDownString = String()
    var woOverviewVC : WorkOrderOverViewVC?
    var woOperationsVC : OperationListVC?
    var attachmentsVC : WorkOrderAttachmentVC?
    var notificationOverViewVC :  NotificationOverViewVC?
    var operationsVC_OverView : OperationsVC?
    var workorderNotification = Bool()
    var assetDetailsVC : AssetDetailsVC?
//    var workOrderObjVM : WorkOrderObjectsViewModel?
    
    // MARK: Page Swipe Inputs
    public var initialIndex: Int = 0
    public lazy var pageViewController = PageViewController(transitionStyle: .scroll,
                                                            navigationOrientation: .horizontal,
                                                            options: nil)
    private var initialized: Bool = false
    // Page Swipe Inputs End
    var tabItemArray = Array<TabItem>()
    var locationManager: CLLocationManager = CLLocationManager()
    var AllowedFollOnObjTypArray = Array<AllowedFollowOnObjectTypeModel>()
    var operationArray = Array<WoOperationModel>()
    var tabVCArray = [UIViewController]()
    var detailViewModel = DetailViewModel()
    var checkSheetVM = checkSheetViewModel()
    var noDetailVM = NotificationDetailModel()
    var woDetailVM = WorkorderDetailModel()

    //MARK: - LifiCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        detailViewModel.delegate = self
        detailViewModel.statusArray = globalStatusArray
        woDetailVM.orderTypeFeatureDict = orderTypeFeatureDict
        if currentMasterView == "WorkOrder"{
            detailViewModel.assignment = WORKORDER_ASSIGNMENT_TYPE
            checkSheetVM.woAssigmentType = WORKORDER_ASSIGNMENT_TYPE
            checkSheetVM.formAssignmentType = FORM_ASSIGNMENT_TYPE
            checkSheetVM.orderTypeFeatureDict = orderTypeFeatureDict
            checkSheetVM.delegate = self
            checkSheetVM.woObj = singleWorkOrder
            checkSheetVM.oprObj = singleOperation
            checkSheetVM.userID = strUser.uppercased()
            detailViewModel.checkSheetVM = self.checkSheetVM
            woDetailVM.delegate = self
            detailViewModel.woDetailVM = self.woDetailVM
        }else{
            detailViewModel.assignment = NOTIFICATION_ASSIGNMENT_TYPE
            noDetailVM.delegate = self
            detailViewModel.noDetailVM = self.noDetailVM
        }
        self.StatusCollectionView.delegate = self
        self.StatusCollectionView.dataSource = self
        StatusCollectionView.reloadData()
        if ENABLE_POST_DEVICE_LOCATION_NOTES == true{
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
            }
        }
        if((UserDefaults.standard.value(forKey:"seletedTab_Wo")) != nil){
            let index = UserDefaults.standard.value(forKey: "seletedTab_Wo") as! Int
            initialIndex = index
            selectedIndex = index
        }else{
            initialIndex = 0
            selectedIndex = 0
        }
        pageViewController.parentVC = self
        setupCell()
        setupPageView()
        if DeviceType == iPhone{
            selectedBar.isHidden = true
            self.pendingTaskView.isHidden = true
        }else{
            selectedBar.isHidden = false
        }
        self.addNotificationObservers()
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.WorkorderCompleteTableView.delegate = self
        self.WorkorderCompleteTableView.dataSource = self
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
        if DeviceType == iPad{
            self.setAppfeature()
            alertImage.layer.cornerRadius =  alertImage.frame.size.height / 2
            alertImage.layer.masksToBounds = true
            attachmentImageVIew.layer.cornerRadius =  alertImage.frame.size.height / 2
            attachmentImageVIew.layer.masksToBounds = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(MasterListDetailVC.handleTap(sender:)))
            tap.delegate = self
            self.view.addGestureRecognizer(tap)
            self.setWorkorderCompleteTableViewLayout()
        }else{
            self.listObjectSelected()
            self.viewWillAppear(true)
        }
        if DeviceType == iPhone{
            self.statusViewBottomConstant.constant = IS_IPHONE_XS_MAX ? 34 : 0
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
        if DeviceType == iPhone{
            self.updateSlideMenu()
            setUpHeader()
            if onlineSearch == true {
                self.statusViewTopConstant.constant = 60.0
                self.statusViewHeightConstant.constant = 0.0
            }else {
                self.statusViewHeightConstant.constant = 50.0
            }
//            if screenHeight > 667{
//                self.statusViewBottomConstant.constant = 34
//            }else{
//                self.statusViewBottomConstant.constant = -34
//            }
            if IS_IPHONE_XS_MAX{
                self.statusViewTopConstant.constant = -34
            }
        }
        pageViewController.setTabItem(tabItems())
        defer { initialized = true }
        guard !initialized else { super.viewWillAppear(animated);
            return }
        pageViewController.selectedBar = self.selectedBar
        pageViewController.pageView = self.pageView
        setupPageComponent()
        pageViewController.setupAnimator()
        setPages(viewControllers())
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: Intial Methods
    func addNotificationObservers(){
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcDataSetObserver)
        myAssetDataManager.uniqueInstance.detailVcDataSetObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"dataSetSuccessfully"), object: nil, queue: nil){ notification in
            self.dataSetSuccessfully(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetOprCount)
        myAssetDataManager.uniqueInstance.detailVcSetOprCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setOperationCountNotification"), object: nil, queue: nil){ notification in
            self.setOperationCountNotification(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetInspOprCount)
        myAssetDataManager.uniqueInstance.detailVcSetInspOprCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setInspectionCountNotification"), object: nil, queue: nil){ notification in
            self.setInspectionCountNotification(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetCompCount)
        myAssetDataManager.uniqueInstance.detailVcSetCompCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setComponentBadgeIcon"), object: nil, queue: nil){ notification in
            self.setComponentBadgeIcon(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetAttCount)
        myAssetDataManager.uniqueInstance.detailVcSetAttCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setAttachmentBadgeIcon"), object: nil, queue: nil){ notification in
            self.setAttachmentBadgeIcon(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetRpCount)
        myAssetDataManager.uniqueInstance.detailVcSetRpCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"RecordPointsUpdated"), object: nil, queue: nil){ notification in
            self.setRecordPointCount(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetFormCount)
        myAssetDataManager.uniqueInstance.detailVcSetFormCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setFormCountBadgeIcon"), object: nil, queue: nil){ notification in
            self.setFormCountBadgeIcon(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetNoActCount)
        myAssetDataManager.uniqueInstance.detailVcSetNoActCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setNotificationActivityCount"), object: nil, queue: nil){ notification in
            self.setNotificationActivityCount(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetNoItemCount)
        myAssetDataManager.uniqueInstance.detailVcSetNoItemCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setNotificationItemCount"), object: nil, queue: nil){ notification in
            self.setNotificationItemCount(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetNoTaskCount)
        myAssetDataManager.uniqueInstance.detailVcSetNoTaskCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setNotificationTaskCount"), object: nil, queue: nil){ notification in
            self.setNotificationTaskCount(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetNoAttCount)
        myAssetDataManager.uniqueInstance.detailVcSetNoAttCount = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"setNotificationAttachmentCount"), object: nil, queue: nil){ notification in
            self.setNotificationAttachmentCount(notification: notification)
        }
        if DeviceType == iPad{
            NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailVcSetBgSync)
            myAssetDataManager.uniqueInstance.detailVcSetBgSync = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil, queue: nil){ notification in
                self.backGroundSyncStarted(notification: notification)
            }
            NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailFlushObserver)
            myAssetDataManager.uniqueInstance.detailFlushObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil, queue: nil){ notification in
                self.storeFlushAndRefreshDone(notification: notification)
            }
        }else{
            NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailStatusObserver)
            myAssetDataManager.uniqueInstance.detailStatusObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"StatusUpdated"), object: nil, queue: nil){ notification in
                self.setActiveObjectDetails()
            }
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.taskStatusObserver)
        myAssetDataManager.uniqueInstance.taskStatusObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"TaskStatusUpdated"), object: nil, queue: nil){ notification in
            self.taskStausUpdated(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.detailReloadObserver)
        myAssetDataManager.uniqueInstance.detailReloadObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"Reload"), object: nil, queue: nil){ notification in
            self.loadList(notification: notification)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("WO_LIST_3_DOT_MENU"){
            moreButton.isHidden = false
        }else{
            moreButton.isHidden = false
        }
        if applicationFeatureArrayKeys.contains("WO_LIST_MAP_NAV"){
            locationButton.isHidden = false
        }else{
            locationButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("WO_LIST_POST_JOB_OPTION"){
            addNewJobButton.isHidden = false
        }else{
            addNewJobButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setActiveObjectDetails(){
        var status = String()
        if onlineSearch != true {
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && currentMasterView == "WorkOrder"{
                status =  WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: singleOperation.UserStatus, mobileStatus: singleOperation.MobileStatus, oprClass: singleOperation)
                if singleOperation.SubOperation == ""{
                    isActiveWorkOrder = WorkOrderDataManegeClass.uniqueInstance.getConsidereAsActive(status: status, from: "WorkOrder")
                    self.detailViewModel.getAllowedStatusForCurrentStatus(type: "WorkOrder", currentStatus: status)
                }
            }else{
                if currentMasterView == "WorkOrder"{
                    status =  WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: singleWorkOrder.UserStatus, mobileStatus: singleWorkOrder.MobileObjStatus,woClass: singleWorkOrder)
                    isActiveWorkOrder = WorkOrderDataManegeClass.uniqueInstance.getConsidereAsActive(status: status, from: "WorkOrder")
                    self.detailViewModel.getAllowedStatusForCurrentStatus(type: "WorkOrder", currentStatus: status)
                }else if currentMasterView == "Notification"{
                    self.detailViewModel.getAllowedStatusForCurrentStatus(type: "Notification", currentStatus: singleNotification.MobileStatus)
                    isActiveNotification = WorkOrderDataManegeClass.uniqueInstance.getConsidereAsActive(status: singleNotification.MobileStatus, from: "Notification")
                }
            }
        }
    }
    //MARK: Delegate Methods
    func listObjectSelected() {
        woDetailVM.countDict = [String:Any]()
        detailViewModel.woObj = singleWorkOrder
        detailViewModel.oprObj  = singleOperation
        detailViewModel.noObj = singleNotification
        self.setActiveObjectDetails()
        if DeviceType == iPad{
            self.setScrollViewButton()
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue:"objectSelected"), object: "")
    }
    func formSaved(Save: Bool,statusCategoryCls:StatusCategoryModel,formFrom:String){
        mJCLogger.log("Starting", Type: "info")
        if formFrom == "WorkOrder"{
            if Save == true && statusCategoryCls.StatusCode != ""{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    singleOperation.StatusFlag = "X"
                    singleOperation.MobileStatus = statusCategoryCls.StatusCode
                    singleOperation.MobileObjectType = statusCategoryCls.ObjectType
                    WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: statusCategoryCls.StatusCode,objClass: singleOperation,flushRequired: true)
                }else{
                    singleWorkOrder.StatusFlag = "X"
                    singleWorkOrder.MobileObjStatus = statusCategoryCls.StatusCode
                    singleWorkOrder.MobileObjectType = statusCategoryCls.ObjectType
                    WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: statusCategoryCls.StatusCode,objClass: singleWorkOrder,flushRequired: true)
                }
            }
        }else if formFrom == "Notification"{
            singleNotification.StatusFlag = "X"
            singleNotification.MobileStatus = statusCategoryCls.StatusCode
            singleNotification.MobileObjectType = statusCategoryCls.ObjectType
            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: statusCategoryCls.StatusCode,objClass: singleNotification,flushRequired: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            defer { self.initialized = true }
            guard !self.initialized else { super.viewWillAppear(true); self.setPages(self.viewControllers())
                return }
        }
        self.WorkorderCompleteTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func operation(_ Create: Bool, Update: Bool){
        NotificationCenter.default.post(name: Notification.Name(rawValue:"operationsReload"), object: "")
    }
    func menudropDownSelectionAction(){
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if DeviceType == iPad{
                if self.dropDownString == "Menu" {
                    onlineSearch = false
                    onlineSearchArray.removeAll()
                    if item == "Notifications".localized() {
                        DispatchQueue.main.async {
                            UserDefaults.standard.removeObject(forKey: "ListFilter")
                            currentMasterView = "Notification"
                            UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
                            let splitVC = ScreenManager.getListSplitScreen()
                            self.appDeli.window?.rootViewController = splitVC
                            self.appDeli.window?.makeKeyAndVisible()
                        }
                    }else if item == "Work_Orders".localized() {
                        DispatchQueue.main.async {
                            currentMasterView = "WorkOrder"
                            UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
                            UserDefaults.standard.removeObject(forKey: "ListFilter")
                            let splitVC = ScreenManager.getListSplitScreen()
                            self.appDeli.window?.rootViewController = splitVC
                            self.appDeli.window?.makeKeyAndVisible()
                        }
                    }else if item == "Time_Sheet".localized() {
                        DispatchQueue.main.async {
                            selectedworkOrderNumber = ""
                            selectedNotificationNumber = ""
                            UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
                            let timeSheetVC = ScreenManager.getTimeSheetScreen()
                            self.appDeli.window?.rootViewController = timeSheetVC
                            self.appDeli.window?.makeKeyAndVisible()
                        }
                    }else if item == "Master_Data_Refresh".localized() {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self.WorkorderCompleteTableView.isHidden = true
                                UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
                                mJCLoader.startAnimating(status: "Uploading".localized())
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                    myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                                })
                            }
                        }
                    }else if item == "Asset_Map".localized() {
                        ASSETMAP_TYPE = "ESRIMAP"
                        assetmapVC.openmappage(id: "")
                    }else if item == "Settings".localized() {
                        let settingsVC = ScreenManager.getSettingsScreen()
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: false, completion: nil)
                    }else if item == "Log_Out".localized() {
                        myAssetDataManager.uniqueInstance.logOutApp()
                    }else if item == "Error_Logs".localized() {
                        myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
                    }
                }
            }else{
                if currentMasterView == "WorkOrder"{
                    if item == "Create_Notification".localized() {
                        if isActiveWorkOrder == true {
                            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO", orderType: "X",from:"WorkOrder")
                            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                                if workFlowObj.ActionType == "Screen" {
                                    let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                                    createNotificationVC.isFromEdit = false
                                    createNotificationVC.isFromWorkOrder = true
                                    createNotificationVC.modalPresentationStyle = .fullScreen
                                    self.present(createNotificationVC, animated: false)
                                }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                                    myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                                }else{
                                    myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                                }
                            }
                        }else{
                            mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                        }
                    }else if item == "Edit_Work_Order".localized() {
                        if onlineSearch {
                            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_WO", orderType: singleWorkOrder.OrderType,from:"WorkOrder")
                            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                                if workFlowObj.ActionType == "Screen" {
                                    let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                                    createWorkOrderVC.isFromEdit = true
                                    createWorkOrderVC.createUpdateDelegate = self
                                    createWorkOrderVC.modalPresentationStyle = .fullScreen
                                    self.present(createWorkOrderVC, animated: false)
                                }
                            }
                        }else {
                            if isActiveWorkOrder == true || singleWorkOrder.WorkOrderNum.contains(find: "L"){
                                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_WO", orderType: singleWorkOrder.OrderType,from:"WorkOrder")
                                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                                    if workFlowObj.ActionType == "Screen" {
                                        let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                                        createWorkOrderVC.createUpdateDelegate = self.woOverviewVC
                                        createWorkOrderVC.isFromEdit = true
                                        createWorkOrderVC.modalPresentationStyle = .fullScreen
                                        self.present(createWorkOrderVC, animated: false)
                                    }
                                }
                            }else {
                                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                    mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                                }else{
                                    mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                                }
                            }
                        }
                    }else if item == "Delete_Work_Order".localized() {
                        if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleWorkOrder.entity) == true && (selectedworkOrderNumber.contains(find: "L") || selectedworkOrderNumber.contains(find: "Temp")){
                            let params = Parameters(
                                title: alerttitle,
                                message: "Do_you_want_delete_the_Local_Work_Order".localized(),
                                cancelButton: "YES".localized(),
                                otherButtons: ["NO".localized()]
                            )
                            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                switch buttonIndex {
                                case 0:
                                    DispatchQueue.main.async {
                                        if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleWorkOrder.entity) == true{
                                            WoHeaderModel.deleteWorkorderEntity(entity: singleWorkOrder.entity, options: nil, completionHandler: { (response, error) in
                                                if error == nil {
                                                    DispatchQueue.main.async {
                                                        mJCLogger.log("\(singleWorkOrder.WorkOrderNum) record deleted : Done", Type: "Debug")
                                                        singleWorkOrder = WoHeaderModel()
                                                        selectedworkOrderNumber = ""
                                                        selectedNotificationNumber = ""
                                                        currentMasterView = "Dashboard"
                                                        let dashboard = ScreenManager.getDashBoardScreen()
                                                        self.appDeli.window?.rootViewController = dashboard
                                                        self.appDeli.window?.makeKeyAndVisible()
                                                    }
                                                }else {
                                                    mJCLogger.log("\(singleWorkOrder.WorkOrderNum) record deleted : Fail!", Type: "Error")
                                                }
                                            })
                                        }else {
                                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Can't_delete_Work_Order".localized(), button: okay)
                                        }
                                    }
                                case 1: break
                                default: break
                                }
                            }
                        }else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Can't_delete_Work_Order".localized(), button: okay)
                        }
                    }else if item == "Assign_Work_order".localized(){

                    }else if item == "Manage_CheckSheet_Assignment".localized(){
                        let manageAssignment = ScreenManager.getManageCheckSheetScreen()
                        manageAssignment.modalPresentationStyle = .fullScreen
                        self.present(manageAssignment, animated: false)
                    }else if item == "Forms_Approval".localized(){
                        let FromsApprovalVC = ScreenManager.getFormApprovalScreen()
                        FromsApprovalVC.modalPresentationStyle = .fullScreen
                        self.present(FromsApprovalVC, animated: false)
                    }else if item == "Add_Operation".localized(){
                        if isActiveWorkOrder == true || singleWorkOrder.WorkOrderNum.contains(find: "L") {
                            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_OP", orderType: "X",from:"WorkOrder")
                            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                                if workFlowObj.ActionType == "Screen" {
                                    let addOperationVC = ScreenManager.getCreateOperationScreen()
                                    addOperationVC.isFromScreen = "Operation"
                                    addOperationVC.isFromEdit = false
                                    addOperationVC.delegate = self
                                    addOperationVC.operationNumber = "L\(String.random(length: 3, type: "Number"))"
                                    addOperationVC.singleOperationClass = WoOperationModel()
                                    addOperationVC.modalPresentationStyle = .fullScreen
                                    self.present(addOperationVC, animated: false)
                                }
                            }
                        }else {
                            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                            }else{
                                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                            }
                        }
                    }else if item == "Edit_Operation".localized(){
                        if isActiveWorkOrder == true || selectedOperationNumber.contains(find: "L"){
                            let editOperationVC = ScreenManager.getCreateOperationScreen()
                            editOperationVC.isFromScreen = "Operation"
                            editOperationVC.isFromEdit = true
                            editOperationVC.delegate = self
                            editOperationVC.singleOperationClass = singleOperation
                            editOperationVC.WOOrdertype = singleWorkOrder.OrderType as String
                            editOperationVC.modalPresentationStyle = .fullScreen
                            self.present(editOperationVC, animated: false)
                        }else {
                            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                            }else{
                                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                            }
                        }
                    }else if item == "Complete_All".localized() {
                        if isActiveWorkOrder == true{
                            self.woOperationsVC?.completeBulkOperationMethod(count: 0)
                        }else {
                            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                            }else{
                                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                            }
                        }
                    }else if item == "Capacity_Data".localized() {
                        let capacityVC = ScreenManager.getCapacityAssignmentScreen()
                        capacityVC.modalPresentationStyle = .fullScreen
                        self.present(capacityVC, animated: false)
                    }else if item == "Create_FollowUp_WO".localized() {
                        self.detailViewModel.getAllowedFollowOnObjectType()
                    }else if item == "Capture_Image".localized(){
                        self.attachmentsVC?.takePhotoButtonAction(sender: UIButton())
                    }else if item == "Capture_Video".localized(){
                        self.attachmentsVC?.takeVideoButtonAction(sender: UIButton())
                    }else if item == "Upload_Image".localized(){
                        self.attachmentsVC?.openGalleryButtonAction(sender: UIButton())
                    }else if item == "Upload_Document".localized(){
                        self.attachmentsVC?.openFileButtonAction(sender: UIButton())
                    }else if item == "Upload_Url".localized(){
                        self.attachmentsVC?.uploadWOAttachmentUrlButtonAction(UIButton())
                    }else if item == "Notes".localized(){
                        let noteListVC = ScreenManager.getLongTextListScreen()
                        if onlineSearch == true{
                            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                noteListVC.fromScreen = "woOperationOnline"
                            }else{
                                noteListVC.fromScreen = "woOverViewOnline"
                            }
                            noteListVC.isAddNewNote = false
                        }
                        noteListVC.modalPresentationStyle = .fullScreen
                        self.present(noteListVC, animated: false)
                    }
                    else if item == "Verify".localized(){
                        if (assetDetailsVC?.selectedAssetListArr.count)! > 0{
                            assetDetailsVC?.objmodel.updateVerifyWorkOrder(list: assetDetailsVC!.selectedAssetListArr, status: "I", count: 0)
                        }
                        else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Select at least one object", button: okay)
                        }
                    }
                    else if item == "Write Off".localized(){
                        if (assetDetailsVC?.selectedAssetListArr.count)! > 0{
                            assetDetailsVC?.notesTextView.text = ""
                            assetDetailsVC?.writeOffBgView.isHidden = false
                        }
                        else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Select at least one object", button: okay)
                        }
                    }
                    else if item == "Update Geo Location".localized(){
                        if (assetDetailsVC?.selectedAssetListArr.count)! > 0{
                            
                        }
                        else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Select at least one object", button: okay)
                        }
                    }
                    else if item == "Assets Location".localized(){
                        ASSETMAP_TYPE = "ESRIMAP"
                        let assetLocVc = ScreenManager.getAssetLocationScreen()
                        if assetDetailsVC!.selectedAssetListArr.count > 0{
                            var locArr = [Dictionary<String,Any>]()
//                            for item in assetDetailsVC!.selectedAssetListArr{
//                                locString =  "x:17.429623,y:78.446297"
//                            }
                            var dict = Dictionary<String,Any>()
                            dict["AssetID"] = "10000"
                            dict["AssetDesc"] = "10000 Description"
                            dict["AssetLat"] = "17.429623"
                            dict["AssetLong"] = "78.446297"
                            
                            locArr.append(dict)
                            dict["AssetID"] = "10001"
                            dict["AssetDesc"] = "10001 Description"
                            dict["AssetLat"] = "17.429766"
                            dict["AssetLong"] = "78.445256"
                            locArr.append(dict)
                            dict["AssetID"] = "10002"
                            dict["AssetDesc"] = "10002 Description"
                            dict["AssetLat"] = "17.431097"
                            dict["AssetLong"] = "78.444870"
                            locArr.append(dict)
                            assetLocVc.locations = locArr
                            assetDetailsVC?.present(assetLocVc, animated: false)
                        }else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Select at least one object", button: okay)
                        }

                    }
                }else if currentMasterView == "Notification"{
                    if item == "Create_Work_Order".localized(){
                        if onlineSearch == true{
                            if singleNotification.WorkOrderNum != "" {
                                mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_workorder".localized() + "  \(singleNotification.WorkOrderNum) " + "for_this_notification_already_created".localized(), button: okay)
                            }else if singleNotification.WorkOrderNum == "" {
                                let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                                createWorkOrderVC.isFromEdit = false
                                createWorkOrderVC.isScreen = "NotificationOverView"
                                createWorkOrderVC.notificationNum = singleNotification.Notification
                                createWorkOrderVC.notificationType = singleNotification.NotificationType
                                createWorkOrderVC.modalPresentationStyle = .fullScreen
                                self.present(createWorkOrderVC, animated: false)
                            }
                        }else{
                            self.notificationOverViewVC?.brifcaseButtonAction(sender: UIButton())
                        }
                    }else if item == "Edit_Notification".localized(){
                        if isActiveNotification == true || onlineSearch == true{
                            if selectedNotificationNumber == "" {
                                mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                            }else {
                                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_NO", orderType: singleNotification.NotificationType,from:"WorkOrder")
                                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                                    if workFlowObj.ActionType == "Screen" {
                                        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                                        createNotificationVC.isFromEdit = true
                                        createNotificationVC.createUpdateDelegate = self.notificationOverViewVC
                                        createNotificationVC.notificationClass = singleNotification
                                        createNotificationVC.modalPresentationStyle = .fullScreen
                                        self.present(createNotificationVC, animated: false)
                                    }
                                }
                            }
                        }else{
                            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Warn")
                            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                        }
                    }else if item == "Notes".localized(){
                        let noteListVC = ScreenManager.getLongTextListScreen()
                        DispatchQueue.main.async {
                            noteListVC.isAddNewNote = false
                            noteListVC.fromScreen = "noOverViewOnline"
                            noteListVC.modalPresentationStyle = .fullScreen
                            self.present(noteListVC, animated: false)
                        }
                    }
                }
            }
        }
    }
    //MARK: viewModelDelegate
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "woChildCounts"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                self.woDetailVM.getWorkorderInspectionBadgeCount(woObj: singleWorkOrder,fromBatch: true)
            }else{
                self.woDetailVM.getWorkorderInspectionBadgeCount(woObj: singleWorkOrder, oprNum: selectedOperationNumber, display: WO_OP_OBJS_DISPLAY,fromBatch: true)
            }
        }else if type == "InspCountValue"{
            self.checkSheetVM.getPredefinedCheckSheetDataWithBatchRequest()
        }else if type == "CheckSheetCount"{
            if let objDict = object[0] as? Dictionary<String,Any>{
                if let oprCount = self.woDetailVM.countDict["oprCount"] as? String{
                    OprCount = oprCount
                }
                if let oprCountColor = self.woDetailVM.countDict["oprCountColor"] as? UIColor{
                    OprColor = oprCountColor
                }
                if let componetCount = self.woDetailVM.countDict["componetCount"] as? String{
                    cmpCount = componetCount
                }
                if let componetCountColor = self.woDetailVM.countDict["componetCountColor"] as? UIColor{
                    cmpColor = componetCountColor
                }
                if let inspectionCount = self.woDetailVM.countDict["inspectionCount"] as? String{
                    inspCount = inspectionCount
                }
                if let inspectionCountColor = self.woDetailVM.countDict["inspectionCountColor"] as? UIColor{
                    InspColor = inspectionCountColor
                }
                if let woAttchmentCount = self.woDetailVM.countDict["woAttchmentCount"] as? String{
                    attchmentCount = woAttchmentCount
                }
                if let woAttchmentCountColor = self.woDetailVM.countDict["woAttchmentCountColor"] as? UIColor{
                    attchmentColor = woAttchmentCountColor
                }
                if let badgeCount = self.woDetailVM.countDict["rpCount"] as? String{
                    rpCount = badgeCount
                }
                if let badgeColor = self.woDetailVM.countDict["rpColor"] as? UIColor{
                    rpColor = badgeColor
                }
                if let woObjCount = self.woDetailVM.countDict["woObjCount"] as? String{
                    objectCount = woObjCount
                }
                if let checkSheetCount = objDict["checkSheetCount"] as? String{
                    formCount = checkSheetCount
                }
                if let checkSheetColor = objDict["checkSheetColor"] as? UIColor{
                    formColor = checkSheetColor
                }
            }
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
            }
        }else if type == "noChildCounts"{
            if let objDict = object[0] as? Dictionary<String,Any>{
                if let noItemCount = objDict["noItemCount"] as? String{
                    ItemCount = noItemCount
                }
                if let noActivityCount = objDict["noActivityCount"] as? String{
                    ActvityCount = noActivityCount
                }
                if let noTaskCount = objDict["noTaskCount"] as? String{
                    TaskCount = noTaskCount
                }
                if let noAttachCount = objDict["noAttachCount"] as? String{
                    noAttchmentCount = noAttachCount
                }
            }
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
            }
        }else if type == "MobileStatusList"{
            DispatchQueue.main.async {
                self.StatusCollectionView.reloadData()
            }
        }else if type == "WorkOrderStatusUpdate"{
            if let statusCategoryObj = object[0] as? StatusCategoryModel{
                self.getObjectWorkFlow(validClass: statusCategoryObj, from: "WorkOrder")
            }
        }else if type == "NotificationStatusUpdate"{
            if let statusCategoryObj = object[0] as? StatusCategoryModel{
                self.getObjectWorkFlow(validClass: statusCategoryObj, from: "Notification")
            }
        }else if type == "CreteTimeSheet"{
            if let statusCategoryObj = object[0] as? StatusCategoryModel{
                self.createTimeSheet(statusCategoryObj: statusCategoryObj, diff: object[1] as! DateComponents, StartTime: object[2] as! String, EndTime: object[3] as! String)
            }
        }else if type == "CompletionCheck"{
            print("mk")
        }else if type == "AllowedFollowOnObjectType"{
            //            self.detailVc.AllowedFollOnObjTypArray = responseArr
            //            if self.detailVc.AllowedFollOnObjTypArray.count > 0{
            //                DispatchQueue.main.async {
            //                    let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
            //                    createWorkOrderVC.isFromEdit = false
            //                    createWorkOrderVC.isfromfollowOnWo = true
            //                    createWorkOrderVC.isScreen = "WorkOrder"
            //                    createWorkOrderVC.createUpdateDelegate =  self.detailVc
            //                    createWorkOrderVC.AllowedFollOnObjTypArray = self.detailVc.AllowedFollOnObjTypArray
            //                    createWorkOrderVC.modalPresentationStyle = .fullScreen
            //                    self.detailVc.present(createWorkOrderVC, animated: false)
            //                }
            //            }else{
            //                DispatchQueue.main.async {
            //                    mJCAlertHelper.showAlert(self.alertVC!, title: alerttitle, message: "No_Order_Type_Found".localized(), button: okay)
            //                }
            //            }
        }
    }
    func setBadgeCount(type:String,count:String,badgeColor:UIColor){
        if type == "recordPointCount"{
            self.woDetailVM.getWorkorderChildBadgeCount(woObj: singleWorkOrder)
            self.woDetailVM.countDict["rpCount"] = count
            self.woDetailVM.countDict["rpColor"] = badgeColor
        }
    }
    //MARK: iPhone Methods
    private func setUpHeader() {
        mJCLogger.log("Starting", Type: "info")
        var title = String()
        if currentMasterView == "Notification"{
            title = "Notification_No".localized() + ":\(selectedNotificationNumber)"
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title = "Operation_No".localized() + ":\(selectedworkOrderNumber)"
            }else{
                title = "Work_Order_No".localized() + ":\(selectedworkOrderNumber)"
            }
            title = "Work_Order_No".localized() + ":\(selectedworkOrderNumber)"
        }
        var view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: title, NewJobButton: true, refresButton: true, threedotmenu: true, leftMenuType: "")
        if applicationFeatureArrayKeys.contains("WO_LIST_POST_JOB_OPTION"){
            view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: title, NewJobButton: false, refresButton: true, threedotmenu: true,leftMenuType:"")
        }
        if !applicationFeatureArrayKeys.contains("WO_LIST_POST_JOB_OPTION"){
            view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: title, NewJobButton: false, refresButton: true, threedotmenu: true,leftMenuType:"")
        }
        self.view.addSubview(view)
        if flushStatus == true{
            view.refreshBtn.showSpin()
        }
        view.delegate = self
        mJCLogger.log("Ended", Type: "info")
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        var sideMenuArrray = [String]()
        var sideMenuArrrayImages = [UIImage]()
        
        if  currentMasterView == "Notification"{
            if  onlineSearch == true{
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Overview".localized(), "Items".localized()]
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "OverView"), #imageLiteral(resourceName: "ItemsNF")]
            }else{
                sideMenuArrray =  notificationChildSideMenuArr
                sideMenuArrrayImages = notificationChildSideMenuImgArr
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = sideMenuArrray
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = sideMenuArrrayImages
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Operation"
                if  onlineSearch == true{
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Overview".localized()]
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "OverView")]
                }else{
                    sideMenuArrray =  operationChildSideMenuArr
                    sideMenuArrrayImages = operationChildSideMenuImgArr
                }
            }else{
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
                if onlineSearch == true{
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Overview".localized(), "Operations".localized()]
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "Operations"),]
                }else{
                    sideMenuArrray =  workorderChildSideMenuArr
                    sideMenuArrrayImages = workorderChildSideMenuImgArr
                    if !applicationFeatureArrayKeys.contains("WoOperations"){
                        if let index =  sideMenuArrray.firstIndex(of: "Operations".localized()){
                            sideMenuArrray.remove(at: index)
                            sideMenuArrrayImages.remove(at: index)
                        }
                    }
                }
                if !applicationFeatureArrayKeys.contains("WoAttachments"){
                    if let index =  sideMenuArrray.firstIndex(of: "Attachments".localized()){
                        sideMenuArrray.remove(at: index)
                        sideMenuArrrayImages.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WoForms"){
                    if let index =  sideMenuArrray.firstIndex(of: "Checklists".localized()){
                        sideMenuArrray.remove(at: index)
                        sideMenuArrrayImages.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WoObjects"){
                    if let index =  sideMenuArrray.firstIndex(of: "Objects".localized()){
                        sideMenuArrray.remove(at: index)
                        sideMenuArrrayImages.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WO_LIST_MAP_NAV"){
                    if let index =  sideMenuArrray.firstIndex(of: "Job_Location".localized()){
                        sideMenuArrray.remove(at: index)
                        sideMenuArrrayImages.remove(at: index)
                    }
                }
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = sideMenuArrray
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = sideMenuArrrayImages
            }
        }
        if selectedIndex == 0 {
            if sideMenuArrray.count > 0{
                self.SlideMenuSelected(index: 0, title: "Overview".localized(), menuType: "")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Work_Orders".localized(){
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController, menu: "Main")
        }else if title == "Notifications".localized() {
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController, menu: "Main")
        }else if title == "Overview".localized() {
            sideSelectedMenu = "Overview".localized()
            if currentMasterView == "Notification"{
                currentsubView = "Overview"
                if onlineSearch == false{
                    if workorderNotification == true{
                        self.notificationOverViewVC?.isFromWorkorder = "FromWorkorder"
                    }else{
                        self.notificationOverViewVC?.isFromWorkorder = ""
                    }
                    let index = tabItemArray.firstIndex{$0.title == "Overview".localized()}
                    self.moveTo(index: index ?? 0)
                }else{
                    let index = tabItemArray.firstIndex{$0.title == "Overview".localized()}
                    self.moveTo(index: index ?? 0)
                }
            }else if currentMasterView == "WorkOrder"{
                currentsubView = "Overview"
                let index = tabItemArray.firstIndex{$0.title == "Overview".localized()}
                self.moveTo(index: index ?? 0)
            }
        }else if title == "Operations".localized() {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                sideSelectedMenu = "Operations".localized()
                currentsubView = "Operations"
                let operationClass = singleOperation
                self.operationsVC_OverView?.selectedOprNum = operationClass.OperationNum
                selectedOperationNumber = operationClass.OperationNum
                let title = "\(operationClass.WorkOrderNum)/\(operationClass.OperationNum)"
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: "\(title)")
            }else{
                sideSelectedMenu = "Operations".localized()
                if onlineSearch == false {
                    woOperationsVC?.isfrom = "Operations"
                }
                let index = tabItemArray.firstIndex{$0.title == "Operations".localized()}
                self.moveTo(index: index ?? 0)
            }
        }else if title == "Inspection_Lot".localized() {
            sideSelectedMenu = "Inspection_Lot".localized()
            let index = tabItemArray.firstIndex{$0.title == "Inspection_Lot".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "Components".localized() {
            sideSelectedMenu = "Components".localized()
            let index = tabItemArray.firstIndex{$0.title == "Components".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "Attachments".localized(){
            sideSelectedMenu = "Attachments".localized()
            self.attachmentsVC?.fromScreen = "WORKORDER"
            self.attachmentsVC?.objectNum = selectedworkOrderNumber
            let index = tabItemArray.firstIndex{$0.title == "Attachments".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "Checklists".localized(){
            sideSelectedMenu = "Checklists".localized()
            let index = tabItemArray.firstIndex{$0.title == "Checklists".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "Record_Points".localized(){
            sideSelectedMenu = "Record_Points".localized()
            let index = tabItemArray.firstIndex{$0.title == "Record_Points".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "Objects".localized() {
            sideSelectedMenu = "Objects".localized()
            let index = tabItemArray.firstIndex{$0.title == "Objects".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "Job_Location".localized() {
            ASSETMAP_TYPE = ""
            currentMasterView = "MapSplitViewController"
            selectedNotificationNumber = ""
            let mainViewController = ScreenManager.getMapDeatilsScreen()
            mainViewController.isFromOverView = true
            mainViewController.selectedWONumber = selectedworkOrderNumber
            mainViewController.workOrderArray = detailViewModel.woArray
            mainViewController.workOrderListArray = detailViewModel.woListArray
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController, menu: "Main")
        }else if title == "Error_Logs".localized() {
            myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
        }
        else if title == "Assests"{
            currentsubView = "Asset"
            if DeviceType == iPad{
                
            }
            else{
                let index = tabItemArray.firstIndex{$0.title == "Assets".localized()}
                self.moveTo(index: index ?? 0)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.5){
            self.WorkorderCompleteTableView.isHidden = true
        }
    }
    //MARK: - Notifications Methods..
    @objc func storeFlushAndRefreshDone(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Store Flush And Refresh Done..".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func loadList(notification:Notification){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            if tabItemArray.indices.contains(selectedIndex){
                let tabitem = tabItemArray[selectedIndex]
                sideSelectedMenu = tabitem.title ?? ""
            }else{
                sideSelectedMenu = ""
            }
        }
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func taskStausUpdated(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        // detailViewModel.taskStatusUpdated()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func dataSetSuccessfully(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            DispatchQueue.main.async {
                if notification.object as! String == "DataSetMasterView" {
                    self.workOrderNumberLabel.text = "Work_Order_No".localized() + ". \(selectedworkOrderNumber)"
                    self.setScrollViewButton()
                }else if notification.object as! String == "DataSetMasterViewNotification"{
                    self.workOrderNumberLabel.text = "Notification_No".localized() + ". \(selectedNotificationNumber)"
                    self.setScrollViewButton()
                }
            }
        }else{
            if currentMasterView == "WorkOrder"{
                var status = ""
                if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                    status = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: singleWorkOrder.UserStatus, mobileStatus: singleWorkOrder.MobileObjStatus,woClass: singleWorkOrder)
                }else{
                    status =  WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: singleOperation.UserStatus, mobileStatus: singleOperation.MobileStatus,oprClass: singleOperation)
                }
                self.detailViewModel.getAllowedStatusForCurrentStatus(type: "WorkOrder", currentStatus: status)
            }else{
                if singleNotification.MobileStatus != ""{
                    self.detailViewModel.getAllowedStatusForCurrentStatus(type: "WorkOrder", currentStatus: singleNotification.MobileStatus)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Badge Count
    //TODO: Operation Count
    @objc func setOperationCountNotification(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            self.woDetailVM.getConfirmationOpeartionSet(woNum: selectedworkOrderNumber)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: InspectionLot Count..
    @objc func setInspectionCountNotification(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            self.woDetailVM.getWorkorderInspectionBadgeCount(woObj: singleWorkOrder)
        }else{
            self.woDetailVM.getWorkorderInspectionBadgeCount(woObj: singleWorkOrder, oprNum: selectedOperationNumber, display: WO_OP_OBJS_DISPLAY)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: Component Count..
    @objc func setComponentBadgeIcon(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && WO_OP_OBJS_DISPLAY == "X"{
            self.woDetailVM.getIncompletedComponentCount(woObj: singleWorkOrder, oprNum: selectedOperationNumber, display: WO_OP_OBJS_DISPLAY)
        }else{
            self.woDetailVM.getIncompletedComponentCount(woObj: singleWorkOrder)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: CheckSheet Count..
    @objc func setFormCountBadgeIcon(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: Attachment Badge notification..
    @objc func setAttachmentBadgeIcon(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.getWorkorderAttachmentBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getWorkorderAttachmentBadgeCount()  {
        if selectedworkOrderNumber != ""{
            self.woDetailVM.getAttachment(woObj: singleWorkOrder)
        }
    }
    func setNotificationAttachmentBadgeCount() {
        if selectedNotificationNumber != ""{
            self.self.noDetailVM.getNOAttachmentSet(noObj: singleNotification)
        }
    }
    //TODO: Record Point notification..
    @objc func setRecordPointCount(notification : Notification) {
        self.woDetailVM.setRecordPointCount(woObj: singleWorkOrder, currentRecordPoints: currentRecordPointArray, totalReacordPoints: finalReadingpointsArray)
    }
    //TODO: Notification Activity Count..
    @objc func setNotificationActivityCount(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.noDetailVM.getNotificationActivityBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: Notification Item Count
    @objc func setNotificationItemCount(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.noDetailVM.getNotificationItemBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: Notification Task Count..
    @objc func setNotificationTaskCount(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.noDetailVM.getNotificationTaskBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //TODO: Notification Attachment Count..
    @objc func setNotificationAttachmentCount(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.setNotificationAttachmentBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TableView Delegate and DataSource..
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailViewModel.remainsTaskTextArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let completeWOStatusCell = tableView.dequeueReusableCell(withIdentifier: "CompleteWorkorderStatusCell") as! CompleteWorkorderStatusCell
        completeWOStatusCell.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tableView.separatorStyle = .none
        completeWOStatusCell.remainsStatusLabel?.text = self.detailViewModel.remainsTaskTextArray[indexPath.row]
        completeWOStatusCell.alertLabel.layer.cornerRadius = completeWOStatusCell.alertLabel.frame.height / 2
        completeWOStatusCell.alertLabel.layer.masksToBounds = true
        mJCLogger.log("Ended", Type: "info")
        return completeWOStatusCell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK: - iPad Button Actions...
    @IBAction func menuButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if UIDevice.current.userInterfaceIdiom ==  UIUserInterfaceIdiom.phone {
            self.navigationController?.popViewController(animated: true)
        }else {
            if isMasterHidden {
                isMasterHidden = false
                splitViewController!.preferredDisplayMode = .automatic
            }else {
                isMasterHidden = true
                splitViewController!.preferredDisplayMode = .primaryHidden
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func moreButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            if currentMasterView == "Notification" {
                menuarr = supervisorNoSideMenuArr
                imgArray = supervisorNoSideMenuImgArr
            }else if currentMasterView == "WorkOrder" {
                menuarr = supervisorWoSideMenuArr
                imgArray = supervisorWoSideMenuImgArr
            }
        }else{
            if currentMasterView == "Notification" {
                menuarr = notificationSideMenuArr
                imgArray = notificationSideMenuImgArr
            }else if currentMasterView == "WorkOrder" {
                menuarr = workorderSideMenuArr
                imgArray = workorderSideMenuImgArr
            }
        }
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  menuarr.firstIndex(of: "Time_Sheet".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        menudropDown.dataSource = menuarr
        self.customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender as! UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        self.dropDownString = "Menu"
        menudropDownSelectionAction()
        menudropDown.show()
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
    @IBAction func refreshButtonButton(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func locationButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        ASSETMAP_TYPE = ""
        currentMasterView = "MapSplitViewController"
        selectedNotificationNumber = ""
        let mapSplitVC = ScreenManager.getMapSplitScreen()
        self.appDeli.window?.rootViewController = mapSplitVC
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let createNewJobVC = ScreenManager.getCreateJobScreen()
                createNewJobVC.isFromEdit = false
                createNewJobVC.isScreen = "WorkOrder"
                createNewJobVC.createUpdateDelegate = self
                createNewJobVC.modalPresentationStyle = .fullScreen
                self.present(createNewJobVC, animated: false)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func HomeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        singleWorkOrder = WoHeaderModel()
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Set ScrollView Button..
    func setScrollViewButton() {
        DispatchQueue.main.async {
            if (UserDefaults.standard.value(forKey:"lastSyncDate") != nil) {
                let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate") as! Date
                self.lastSyncDateLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
            }else {
                self.lastSyncDateLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate),timeZone: .utc,locale: .current))"
            }
            if currentMasterView == "Notification" {
                if (selectedNotificationNumber == "") {
                    self.workOrderNumberLabel.text = "Notification_No".localized()
                    self.attachmentImageVIew.isHidden = true
                    self.alertImage.isHidden = true
                }else {
                    self.workOrderNumberLabel.text = "Notification_No".localized() + ". \(selectedNotificationNumber)"
                }
                self.noDetailVM.getNotificationChildBadgeCount(noObj: singleNotification)
                self.alertImage.image = myAssetDataManager.getPriorityImage(priority: singleNotification.Priority)
                if globalNoAttachmentArr.contains(selectedNotificationNumber){
                    self.attachmentImageVIew.isHidden = false
                }else{
                    self.attachmentImageVIew.isHidden = true
                }
            }else if currentMasterView == "WorkOrder" {
                if (selectedworkOrderNumber == "") {
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        self.workOrderNumberLabel.text = "Work_Order_No".localized()+": \(selectedworkOrderNumber)"+"/"+"Operation_No".localized()+":\(selectedOperationNumber)"
                    }else{
                        self.workOrderNumberLabel.text = "Work_Order_No".localized() + ": \(selectedworkOrderNumber)"
                    }
                    self.attachmentImageVIew.isHidden = true
                    self.alertImage.isHidden = true
                    self.lineview.isHidden = true
                }else {
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        self.workOrderNumberLabel.text = "Work_Order_No".localized() + ":\(selectedworkOrderNumber)" + "/" + "Operation_No".localized() + ":\(selectedOperationNumber)"
                    }else{
                        self.workOrderNumberLabel.text = "Work_Order_No".localized() + " :\(selectedworkOrderNumber)"
                    }
                    if globalWoAttachmentArr.contains(selectedworkOrderNumber){
                        self.attachmentImageVIew.isHidden = false
                    }else{
                        self.attachmentImageVIew.isHidden = true
                    }
                    self.alertImage.image = myAssetDataManager.getPriorityImage(priority: singleWorkOrder.Priority)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkorderCompleteTableViewLayout()  {
        self.WorkorderCompleteTableView.layer.shadowColor =  UIColor.red.cgColor
        self.WorkorderCompleteTableView.layer.shadowOffset = CGSize(width: -2.0, height: 2.0)
        self.WorkorderCompleteTableView.layer.shadowRadius = 3.0
        self.WorkorderCompleteTableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.WorkorderCompleteTableView.bounces = false
        self.WorkorderCompleteTableView.layer.cornerRadius = 2.0
        self.WorkorderCompleteTableView.layer.masksToBounds = true
        self.WorkorderCompleteTableView.estimatedRowHeight = 50
        self.WorkorderCompleteTableView.layer.borderColor = UIColor.darkGray.cgColor
        self.WorkorderCompleteTableView.layer.borderWidth = 2
    }
    //MARK: Collection View Delegates
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == menuCollectionView{
            if pageViewController.defaultCellHeight == nil {
                pageViewController.defaultCellHeight = self.menuCollectionView.frame.height
                pageViewController.itemCount = pageViewController.items.count
            }
            return pageViewController.items.count
        }else{
            return self.detailViewModel.allowedStatusCatagoryArray.count
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        mJCLogger.log("Starting", Type: "info")
        if collectionView == menuCollectionView{
            let index = indexPath.row
            let cell = ScreenManager.getTabCell(collectionView: menuCollectionView,indexPath:indexPath)
            menuCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            guard let tabCell = cell as? TabCell else { return cell }
            tabCell.delegate = self
            tabCell.index = index
            tabCell.detailViewModel = DetailViewModel()
            tabCell.indexPath = indexPath
            tabCell.detailModelClass = pageViewController.items[index]
            if selectedIndex == indexPath.row{
                tabCell.selectedView.backgroundColor = appColor
                self.menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }else {
                tabCell.selectedView.backgroundColor = UIColor(named: "mjcViewColor")
            }
            mJCLogger.log("Ended", Type: "info")
            return tabCell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCollectionCell", for: indexPath as IndexPath) as! StatusCollectionCell
            let validStatusClass = self.detailViewModel.allowedStatusCatagoryArray[indexPath.row]
            cell.statusTitle.text = validStatusClass.StatusDescKey
            cell.StatuButton.tag = indexPath.row
            cell.tintColor = .white
            cell.statusTitle.textColor = .white
            if self.detailViewModel.allowedStatusArray.contains(validStatusClass.StatusCode) {
                if currentMasterView == "WorkOrder"{
                    cell.indexpath = indexPath
                    cell.detailViewModel = detailViewModel
                    cell.singleOperationClass = singleOperation
                }else {
                    cell.indexpath = indexPath
                    cell.detailViewModel = detailViewModel
                    cell.singleViewNotificationClass = singleNotification
                }
            }else{
                cell.StatuButton.isEnabled = false
                cell.StatusImg.alpha = 0.5
            }
            if validStatusClass.ImageResKey == "TBC" || validStatusClass.ImageResKey == ""{
                cell.StatuButton.setImage(UIImage(named:"MOBI"), for: .normal)
            }else{
                cell.StatuButton.setImage(UIImage(named:validStatusClass.ImageResKey), for: .normal)
            }
            mJCLogger.log("Ended", Type: "info")
            return cell
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){}
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        mJCLogger.log("Starting", Type: "info")
        if collectionView == StatusCollectionView{
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
                  let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section),
                  dataSourceCount > 0 else {
                return .zero
            }
            let cellCount = CGFloat(dataSourceCount)
            let itemSpacing = flowLayout.minimumInteritemSpacing
            let cellWidth = flowLayout.itemSize.width + itemSpacing
            var insets = flowLayout.sectionInset
            let totalCellWidth = (cellWidth * cellCount) - itemSpacing
            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
            guard totalCellWidth < contentWidth else {
                return insets
            }
            let padding = (contentWidth - totalCellWidth) / 2.0
            insets.left = padding
            insets.right = padding
            mJCLogger.log("Ended", Type: "info")
            return insets
        }else{
            mJCLogger.log("Ended", Type: "info")
            return UIEdgeInsets()
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCollectionView {
            let width = pageViewController.itemsWidths[indexPath.row]
            return CGSize(width: width, height: 60)
        }else{
            return CGSize(width: 50, height: 50)
        }
    }
    //MARK: Status Change Methods
    func timeSheetAdded(statusCategoryCls: StatusCategoryModel){
        self.getObjectWorkFlow(validClass:statusCategoryCls, from: "WorkOrder")
    }
    func createTimeSheet(statusCategoryObj:StatusCategoryModel, diff : DateComponents,StartTime:String,EndTime:String) {
        mJCLogger.log("Starting", Type: "info")
        if statusCategoryObj.DispTimeSheetString == "X" && statusCategoryObj.StatusCode != "COMP"{
            DispatchQueue.main.async {
                let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
                addTimeEntryVC.screenType = "StatusChange"
                addTimeEntryVC.selectedworkOrder = selectedworkOrderNumber
                addTimeEntryVC.timeSheetDelegate = self
                addTimeEntryVC.statusCategoryCls = statusCategoryObj
                addTimeEntryVC.modalPresentationStyle = .fullScreen
                self.present(addTimeEntryVC, animated: false)
            }
        }else{
            var time = String()
            var hours = Float()
            var minutes = Float()
            var totaltime = Float()
            if diff.hour != nil && diff.minute != nil{
                let hour = diff.hour!
                let min = diff.minute!
                hours = Float(hour)
                minutes = Float(min)
                totaltime = Float()
            }else{
                hours = 0
                minutes =  0
            }
            if hours == 0 && minutes < 1{
                totaltime = 0.02
            }else{
                totaltime = hours + minutes / 60
            }
            time = "\(abs(totaltime))"
            
            self.property = NSMutableArray()
            
            var prop : SODataProperty! = SODataPropertyDefault(name: "ActivityType")
            prop!.value = statusCategoryObj.ActivityType as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "AttAbsType")
            prop!.value = "\(ATT_TYPE_HOURS_OF_COSTING)" as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "COArea")
            prop!.value = singleWorkOrder.ControllingArea as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Counter")
            prop!.value = String.random(length: 4, type: "Number") as NSObject as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "CatsHours")
            prop!.value = NSDecimalNumber(string: time)
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Date")
            let datestr = Date().localDate()
            prop!.value = datestr as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "FullDay")
            prop!.value = false as NSObject
            self.property.add(prop!)
            prop = SODataPropertyDefault(name: "LongText")
            prop!.value = false as NSObject
            self.property.add(prop!)
            
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                prop = SODataPropertyDefault(name: "OperAct")
                prop!.value = selectedOperationNumber as NSObject
                self.property.add(prop!)
            }else{
                prop = SODataPropertyDefault(name: "OperAct")
                prop!.value = "" as NSObject
                self.property.add(prop!)
            }
            prop = SODataPropertyDefault(name: "PersonnelNo")
            prop!.value = userPersonnelNo as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Plant")
            prop!.value = singleWorkOrder.Plant as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PreviousDay")
            prop!.value = NSDecimalNumber(string: "0")
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "RecOrder")
            prop!.value = selectedworkOrderNumber as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "RemainingWork")
            prop!.value = NSDecimalNumber(string: "0")
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkCenter")
            prop!.value = singleWorkOrder.MainWorkCtr as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PremiumID")
            prop!.value = DEFAULT_PREMIUM_ID as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PremiumNo")
            prop!.value = DEFAULT_PREMIUM_NO as NSObject
            self.property.add(prop!)
            
            if StartTime != ""{
                prop = SODataPropertyDefault(name: "StartTime")
                let startTime = SODataDuration()
                let startTimeArray = StartTime.components(separatedBy:":")
                startTime.hours = Int(startTimeArray[0])! as NSNumber
                startTime.minutes = Int(startTimeArray[1])! as NSNumber
                startTime.seconds = 0
                prop!.value = startTime
                property.add(prop!)
            }
            if EndTime != ""{
                prop = SODataPropertyDefault(name: "EndTime")
                let endTime = SODataDuration()
                let endTimeArray = EndTime.components(separatedBy:":")
                endTime.hours = Int(endTimeArray[0])! as NSNumber
                endTime.minutes = Int(endTimeArray[1])! as NSNumber
                endTime.seconds = 0
                prop!.value = endTime
                property.add(prop!)
            }
            let entity = SODataEntityDefault(type: catsRecordSetEntity)
            for prop in self.property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name ?? ""] = proper
                print("Key : \(proper.name!)")
                print("Value :\(proper.value!)")
                print("...............")
            }
            let newTimeSheetEntity : SODataEntity?
            newTimeSheetEntity = entity
            TimeSheetModel.createTimeSheetEntity(entity: newTimeSheetEntity!, collectionPath: catRecordSet,flushRequired: false, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    print("TimeSheet Entity Created successfully")
                    mJCLogger.log("TimeSheet Entity Created successfully".localized(), Type: "Debug")
                }else {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Adding_timeSheet_entity_fails".localized(), button: okay)
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
                self.getObjectWorkFlow(validClass:statusCategoryObj, from: "WorkOrder")
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getObjectWorkFlow(validClass:StatusCategoryModel,from:String) {
        mJCLogger.log("Starting", Type: "info")
        var screenKey = ""
        var workFlowObj = ""
        if from == "WorkOrder"{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: validClass.StatusCode, orderType: "X",from:"WorkOrder")
            if let workflowObj = workFlowResp as? LtWorkFlowModel {
                screenKey = workflowObj.ActionKey
                workFlowObj = workflowObj.ActionType
            }
            if workFlowObj == "Screen" {
                DispatchQueue.main.async {
                    if screenKey == "key_WO_SC_HOLD" {
                        let workOrderSuspendVC = ScreenManager.getWorkOrderSuspendScreen()
                        workOrderSuspendVC.isFromScreen = "Hold"
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            workOrderSuspendVC.refNum = selectedOperationNumber
                        }else{
                            workOrderSuspendVC.refNum = "0010"
                        }
                        workOrderSuspendVC.statusCategoryCls = validClass
                        workOrderSuspendVC.modalPresentationStyle = .fullScreen
                        self.present(workOrderSuspendVC, animated: false)
                    }else if screenKey == "key_WO_SC_SUSP" {
                        let workOrderSuspendVC = ScreenManager.getWorkOrderSuspendScreen()
                        workOrderSuspendVC.isFromScreen = "Suspend"
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            workOrderSuspendVC.refNum = selectedOperationNumber
                        }else{
                            workOrderSuspendVC.refNum = "0010"
                        }
                        workOrderSuspendVC.statusCategoryCls = validClass
                        workOrderSuspendVC.modalPresentationStyle = .fullScreen
                        self.present(workOrderSuspendVC, animated: false)
                    }else if screenKey == "key_WO_SC_TRNS" {
                        let transferVC = ScreenManager.getWorkOrderTransferScreen()
                        transferVC.rejectString = "Transfer"
                        transferVC.statusCategoryCls = validClass
                        transferVC.priorityValue = singleWorkOrder.Priority
                        transferVC.modalPresentationStyle = .fullScreen
                        self.present(transferVC, animated: false)
                    }else if screenKey == "key_WO_SC_REJC"{
                        let transferVC = ScreenManager.getWorkOrderTransferScreen()
                        transferVC.rejectString = "Reject"
                        if from == "WorkOrder"{
                            transferVC.screenfrom = "WorkOrder"
                        }else{
                            transferVC.screenfrom = "Notification"
                        }
                        transferVC.statusCategoryCls = validClass
                        transferVC.modalPresentationStyle = .fullScreen
                        self.present(transferVC, animated: false)
                    }else  if screenKey == "key_WO_SC_COMP" {
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4"  || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            self.detailViewModel.remainsTaskTextArray.removeAll()
                            if validClass.PreCheck == 1 {
                                self.detailViewModel.setRemainsTaskText(type: "WorkOrder")
                            }
                            UIView.animate(withDuration: 10.0) {
                                if self.detailViewModel.remainsTaskTextArray.count > 0 {
                                    if DeviceType == iPad{
                                        self.WorkorderCompleteTableView.isHidden = false
                                        self.WorkorderCompleteTableView.reloadData()
                                    }else{
                                        self.pendingTaskView.isHidden = false
                                        self.pendingTaskView.layer.cornerRadius = 4
                                        self.pendingTaskView.layer.borderColor = appColor.cgColor
                                        self.pendingTaskView.layer.borderWidth = 2
                                        self.view.bringSubviewToFront(self.pendingTaskView)
                                    }
                                }else{
                                    let workOrderSuspendVC = ScreenManager.getWorkOrderSuspendScreen()
                                    workOrderSuspendVC.isFromScreen = "Complete"
                                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                        workOrderSuspendVC.refNum = selectedOperationNumber
                                    }else{
                                        workOrderSuspendVC.refNum = "0010"
                                    }
                                    workOrderSuspendVC.statusCategoryCls = validClass
                                    workOrderSuspendVC.modalPresentationStyle = .fullScreen
                                    self.present(workOrderSuspendVC, animated: false)
                                }
                            }
                        }else{
                            if validClass.PreCheck == 1 {
                                self.detailViewModel.setRemainsTaskText(type: "WorkOrder")
                            }
                            UIView.animate(withDuration: 10.0) {
                                if self.detailViewModel.remainsTaskTextArray.count > 0 {
                                    if DeviceType == iPad{
                                        self.WorkorderCompleteTableView.isHidden = false
                                        self.WorkorderCompleteTableView.reloadData()
                                    }else{
                                        self.pendingTaskView.isHidden = false
                                        self.pendingTaskView.layer.cornerRadius = 4
                                        self.pendingTaskView.layer.borderColor = appColor.cgColor
                                        self.pendingTaskView.layer.borderWidth = 2
                                        self.view.bringSubviewToFront(self.pendingTaskView)
                                    }
                                }else{
                                    let workOrderSuspendVC = ScreenManager.getWorkOrderSuspendScreen()
                                    workOrderSuspendVC.isFromScreen = "Complete"
                                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                        workOrderSuspendVC.refNum = selectedOperationNumber
                                    }else{
                                        workOrderSuspendVC.refNum = "0010"
                                    }
                                    workOrderSuspendVC.statusCategoryCls = validClass
                                    workOrderSuspendVC.modalPresentationStyle = .fullScreen
                                    self.present(workOrderSuspendVC, animated: false)
                                }
                            }
                        }
                    }else{
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleOperation,flushRequired: true)
                        }else{
                            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleWorkOrder,flushRequired: true)
                        }
                    }
                }
            }else if workFlowObj == "Action" {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    singleOperation.StatusFlag = "X"
                    singleOperation.MobileStatus = validClass.StatusCode
                    singleOperation.MobileObjectType = validClass.ObjectType
                    WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleOperation,flushRequired: true)
                }else{
                    singleWorkOrder.StatusFlag = "X"
                    singleWorkOrder.MobileObjStatus = validClass.StatusCode
                    singleWorkOrder.MobileObjectType = validClass.ObjectType
                    WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleWorkOrder,flushRequired: true)
                }
            }else if workFlowObj == "FORM" || workFlowObj == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: screenKey, screen: self, statusCategoryCls: validClass, formFrom: from)
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
            }
        }else if from == "Notification"{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: validClass.StatusCode, orderType: "X",from:"NOTIFICATIONLEVEL")
            if let workflowObj = workFlowResp as? LtWorkFlowModel {
                mJCLogger.log("Response :\(workflowObj)", Type: "Debug")
                screenKey = workflowObj.ActionKey
                workFlowObj = workflowObj.ActionType
            }
            if workFlowObj == "Screen" {
                DispatchQueue.main.async {
                    if screenKey == "key_NO_SC_REJC"{
                        let transferVC = ScreenManager.getWorkOrderTransferScreen()
                        transferVC.rejectString = "Reject"
                        transferVC.screenfrom = "Notification"
                        transferVC.statusCategoryCls = validClass
                        transferVC.modalPresentationStyle = .fullScreen
                        self.present(transferVC, animated: false)
                    }else if screenKey == "key_NO_SC_COMP"{
                        if validClass.PreCheck == 1 {
                            self.detailViewModel.setRemainsTaskText(type: "Notification")
                        }
                        UIView.animate(withDuration: 10.0) {
                            if self.detailViewModel.remainsTaskTextArray.count > 0 {
                                if DeviceType == iPad{
                                    self.WorkorderCompleteTableView.isHidden = false
                                    self.WorkorderCompleteTableView.reloadData()
                                }else{
                                    self.pendingTaskView.isHidden = false
                                    self.pendingTaskView.layer.cornerRadius = 4
                                    self.pendingTaskView.layer.borderColor = appColor.cgColor
                                    self.pendingTaskView.layer.borderWidth = 2
                                    self.view.bringSubviewToFront(self.pendingTaskView)
                                }
                            }else{
                                let transferVC = ScreenManager.getWorkOrderTransferScreen()
                                transferVC.rejectString = "Complete"
                                transferVC.screenfrom = "Notification"
                                transferVC.statusCategoryCls = validClass
                                transferVC.modalPresentationStyle = .fullScreen
                                self.present(transferVC, animated: false)
                            }
                        }
                    }else{
                        WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleNotification,flushRequired: true)
                    }
                }
            }else if workFlowObj == "Action" {
                WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleNotification,flushRequired: true)
            }else if workFlowObj == "FORM" || workFlowObj == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: screenKey, screen: self, statusCategoryCls: validClass, formFrom: from)
            }else {
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: iPhone Menu Button Actions
    func backButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        if currentsubView == "Overview" {
            if isSingleNotifFromWorkOrder {
                currentMasterView = "WorkOrder"
                isSingleNotifFromWorkOrder = false
            }else if isSingleNotifFromOperation {
                currentMasterView = "WorkOrder"
                isSingleNotifFromOperation = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func leftMenuButtonClicked(_ sender: UIButton?){
        self.pendingTaskView.isHidden = true
        openLeft()
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        self.addNewJobButtonAction(sender: UIButton())
    }
    func refreshButtonClicked(_ sender: UIButton?){
        self.refreshButtonButton(sender: UIButton())
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if currentMasterView == "Notification"{
            if currentsubView == "Overview"{
                if onlineSearch {
                    menuarr = ["Create_Work_Order".localized(),"Edit_Notification".localized(),"Notes".localized()]
                    imgArray = [#imageLiteral(resourceName: "addIcon"),#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "OverView")]
                    if !applicationFeatureArrayKeys.contains("NO_EDIT_NOTI_OPTION"){
                        if let index =  menuarr.firstIndex(of: "Edit_Notification".localized()){
                            menuarr.remove(at: index)
                            imgArray.remove(at: index)
                        }
                    }
                }else {
                    menuarr = ["Create_Work_Order".localized(),"Edit_Notification".localized()]
                    imgArray = [#imageLiteral(resourceName: "addIcon"),#imageLiteral(resourceName: "editIcon")]
                    if !applicationFeatureArrayKeys.contains("NO_EDIT_NOTI_OPTION"){
                        if let index =  menuarr.firstIndex(of: "Edit_Notification".localized()){
                            menuarr.remove(at: index)
                            imgArray.remove(at: index)
                        }
                    }
                    if !applicationFeatureArrayKeys.contains("NO_CONV_NOTI_TO_WO"){
                        if let index =  menuarr.firstIndex(of: "Create_Work_Order".localized()){
                            menuarr.remove(at: index)
                            imgArray.remove(at: index)
                        }
                    }
                }
            }else if currentsubView == "Items" && !onlineSearch {
                menuarr = ["Add_Item".localized()]
                imgArray = [#imageLiteral(resourceName: "addIcon")]
                if !applicationFeatureArrayKeys.contains("NO_ADD_ITEM_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Add_Item".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }else if currentsubView == "Activities"{
                menuarr = ["Add_Activity".localized()]
                imgArray = [#imageLiteral(resourceName: "addIcon")]
                if !applicationFeatureArrayKeys.contains("NO_ADD_ACTIVITY_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Add_Activity".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }else if currentsubView == "Tasks"{
                menuarr = ["Add_Task".localized()]
                imgArray = [#imageLiteral(resourceName: "addIcon")]
                if !applicationFeatureArrayKeys.contains("NO_ADD_TASK_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Add_Task".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }else if currentsubView == "Attachments" &&  attachmentuploadTab == true{
                menuarr = ["Capture_Image".localized(),"Capture_Video".localized(),"Upload_Image".localized(),"Upload_Url".localized()]
                imgArray = [#imageLiteral(resourceName: "captureImage"),#imageLiteral(resourceName: "uploadVideo"),#imageLiteral(resourceName: "uploadimage"),#imageLiteral(resourceName: "uploadURL")]
                if !applicationFeatureArrayKeys.contains("NO_ATTCH_CAPTURE_IMG"){
                    if let index = menuarr.firstIndex(of: "Capture_Image".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("NO_ATTCH_UPLOAD_IMG"){
                    if let index = menuarr.firstIndex(of: "Upload_Image".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("NO_ATTCH_CAPTURE_VIDEO"){
                    if let index = menuarr.firstIndex(of: "Capture_Video".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("NO_ATTCH_UPLOAD_VIDEO"){
                    if let index =  menuarr.firstIndex(of: "Upload_Document".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("NO_ATTCH_URL"){
                    if let index =  menuarr.firstIndex(of: "Upload_Url".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }
        }else{
            if currentsubView == "Operations"{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    menuarr = ["Add_Operation".localized(),"Edit_Operation".localized(),"Create_FollowUp_WO".localized(),"Capacity_Data".localized(),"Manage_CheckSheet_Assignment".localized(),"Forms_Approval".localized()]
                    imgArray = [#imageLiteral(resourceName: "addIcon"),#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "followOnBlack"),#imageLiteral(resourceName: "Capacity_Data_Black"),#imageLiteral(resourceName: "ic_manualAssign_black"),#imageLiteral(resourceName: "ic_FormApproval_black")]
                }else{
                    menuarr = ["Add_Operation".localized(),"Complete_All".localized(),"Capacity_Data".localized()]
                    imgArray = [#imageLiteral(resourceName: "addIcon"),#imageLiteral(resourceName: "ic_Check"),#imageLiteral(resourceName: "Capacity_Data_Black")]
                }
                if !applicationFeatureArrayKeys.contains("OPR_ADD_OPR_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Add_Operation".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("OPR_EDIT_OPR_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Edit_Operation".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("CompleteOperation"){
                    if let index =  menuarr.firstIndex(of: "Complete_All".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("Create_FollowUp_WO"){
                    if let index =  menuarr.firstIndex(of: "Create_FollowUp_WO".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("ACCESS_CAPACITY_DATA"){
                    if let index =  menuarr.firstIndex(of: "Capacity_Data".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("MANAGE_OPR_CHECKSHEET_APPROVER"){
                    if let index =  menuarr.firstIndex(of: "Forms_Approval".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("MANAGE_OPR_MANUAL_CHECKSHEET"){
                    if let index =  menuarr.firstIndex(of: "Manage_CheckSheet_Assignment".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }else if currentsubView == "Components"{
                menuarr = ["Add_Component".localized(),"Issue_All".localized()]
                imgArray = [#imageLiteral(resourceName: "addCompomentBlack"),#imageLiteral(resourceName: "issueComponentBlack")]
                if !applicationFeatureArrayKeys.contains("COMP_ADD_COMP_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Add_Component".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("COMP_ISSUE_COMP_OPTION"){
                    if let index =  menuarr.firstIndex(of: "Issue_All".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }else if  currentsubView == "Attachments" && attachmentuploadTab == true{
                menuarr = attachmentMenuArr
                imgArray = attachmentMenuImgArr
                if !applicationFeatureArrayKeys.contains("WO_ATTCH_CAPTURE_IMG"){
                    if let index = menuarr.firstIndex(of: "Capture_Image".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WO_ATTCH_UPLOAD_IMG"){
                    if let index = menuarr.firstIndex(of: "Upload_Image".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WO_ATTCH_CAPTURE_VIDEO"){
                    if let index = menuarr.firstIndex(of: "Capture_Video".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WO_ATTCH_UPLOAD_VIDEO"){
                    if let index =  menuarr.firstIndex(of: "Upload_Document".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                if !applicationFeatureArrayKeys.contains("WO_ATTCH_URL"){
                    if let index =  menuarr.firstIndex(of: "Upload_Url".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
            }else if currentsubView == "Overview"{
                if onlineSearch {
                    menuarr = ["Edit_Work_Order".localized(),"Notes".localized()]
                    imgArray = [#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "OverView")]
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        if let index =  menuarr.firstIndex(of: "Edit_Work_Order".localized()){
                            menuarr.remove(at: index)
                            imgArray.remove(at: index)
                        }
                    }
                }else {
                    if selectedworkOrderNumber.contains(find: "L"){
                        menuarr = ["Create_Notification".localized(), "Edit_Work_Order".localized(),"Delete_Work_Order".localized()]
                        imgArray = [#imageLiteral(resourceName: "addnotificaBlack"),#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "delete")]
                        if !applicationFeatureArrayKeys.contains("WO_EDIT_WO_OPTION"){
                            if let index =  menuarr.firstIndex(of: "Edit_Work_Order".localized()){
                                menuarr.remove(at: index)
                                imgArray.remove(at: index)
                            }
                        }
                    }else{
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            menuarr = ["Add_Operation".localized(),"Edit_Operation".localized(),"Create_FollowUp_WO".localized(),"Capacity_Data".localized(),"Manage_CheckSheet_Assignment".localized(),"Forms_Approval".localized()]
                            imgArray = [#imageLiteral(resourceName: "addoperBlack"),#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "followOnBlack"),#imageLiteral(resourceName: "Capacity_Data_Black"),#imageLiteral(resourceName: "ic_manualAssign_black"),#imageLiteral(resourceName: "ic_FormApproval_black")]
                            if applicationFeatureArrayKeys.contains("MANAGE_OPR_CHECKSHEET_APPROVER"){
                                if let index =  menuarr.firstIndex(of: "Forms_Approval".localized()){
                                    menuarr.remove(at: index)
                                    imgArray.remove(at: index)
                                }
                            }
                            if applicationFeatureArrayKeys.contains("MANAGE_OPR_MANUAL_CHECKSHEET"){
                                if let index =  menuarr.firstIndex(of: "Manage_CheckSheet_Assignment".localized()){
                                    menuarr.remove(at: index)
                                    imgArray.remove(at: index)
                                }
                            }
                        }else {
                            menuarr = ["Create_Notification".localized(), "Edit_Work_Order".localized(),"Create_FollowUp_WO".localized(),"Capacity_Data".localized(),"Manage_CheckSheet_Assignment".localized(),"Forms_Approval".localized()]
                            imgArray = [#imageLiteral(resourceName: "addnotificaBlack"),#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "followOnBlack"),#imageLiteral(resourceName: "Capacity_Data_Black"),#imageLiteral(resourceName: "ic_manualAssign_black"),#imageLiteral(resourceName: "ic_FormApproval_black")]
                            if !applicationFeatureArrayKeys.contains("MANAGE_WO_CHECKSHEET_APPROVER"){
                                if let index =  menuarr.firstIndex(of: "Forms_Approval".localized()){
                                    menuarr.remove(at: index)
                                    imgArray.remove(at: index)
                                }
                            }
                            if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                                if let index =  menuarr.firstIndex(of: "Create_Notification".localized()){
                                    menuarr.remove(at: index)
                                    imgArray.remove(at: index)
                                }
                            }
                            if !applicationFeatureArrayKeys.contains("MANAGE_WO_MANUAL_CHECKSHEET"){
                                if let index =  menuarr.firstIndex(of: "Manage_CheckSheet_Assignment".localized()){
                                    menuarr.remove(at: index)
                                    imgArray.remove(at: index)
                                }
                            }
                        }
                        if applicationFeatureArrayKeys.contains("OPR_ADD_OPR_OPTION"){
                            if let index =  menuarr.firstIndex(of: "Add_Operation".localized()){
                                menuarr.remove(at: index)
                                imgArray.remove(at: index)
                            }
                        }
                        if !applicationFeatureArrayKeys.contains("OPR_EDIT_OPR_OPTION"){
                            if let index =  menuarr.firstIndex(of: "Edit_Operation".localized()){
                                menuarr.remove(at: index)
                                imgArray.remove(at: index)
                            }
                        }
                        if !applicationFeatureArrayKeys.contains("WO_EDIT_WO_OPTION"){
                            if let index =  menuarr.firstIndex(of: "Edit_Work_Order".localized()){
                                menuarr.remove(at: index)
                                imgArray.remove(at: index)
                            }
                        }
                        if !applicationFeatureArrayKeys.contains("Create_FollowUp_WO"){
                            if let index =  menuarr.firstIndex(of: "Create_FollowUp_WO".localized()){
                                menuarr.remove(at: index)
                                imgArray.remove(at: index)
                            }
                        }
                        if !applicationFeatureArrayKeys.contains("ACCESS_CAPACITY_DATA"){
                            if let index =  menuarr.firstIndex(of: "Capacity_Data".localized()){
                                menuarr.remove(at: index)
                                imgArray.remove(at: index)
                            }
                        }
                    }
                }
            }
            else if currentsubView == "Asset"{
                menuarr = ["Verify".localized(), "Write Off".localized(), "Update Geo Location".localized(), "Assets Location".localized()]
                imgArray = [#imageLiteral(resourceName: "addnotificaBlack"),#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "followOnBlack"),#imageLiteral(resourceName: "Capacity_Data_Black")]
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
        self.menudropDownSelectionAction()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func CloseButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.pendingTaskView.isHidden = true
        }
    }
    //MARK: - Page Swiper Methods
    func tabItems() -> [TabItem] {
        self.tabItemArray.removeAll()
        mJCLogger.log("Starting", Type: "info")
        let OverviewTab  = TabItem(title: "Overview".localized(), image: UIImage(named: "overview"), cellWidth: 130.0)
        let OperationTab   = TabItem(title: "Operations".localized(), image: UIImage(named: "operations"), cellWidth: 130.0)
        let OperationOverViewTab   = TabItem(title: "Operation_OverView".localized(), image: UIImage(named: "overview"), cellWidth: 130.0)
        let InspectionTab   = TabItem(title: "Inspection_Lot".localized(), image: UIImage(named: "history_pending"), cellWidth: 130.0)
        let ComponentTab   = TabItem(title: "Components".localized(), image: UIImage(named: "components"), cellWidth: 130.0)
        let AttachementTab = TabItem(title: "Attachments".localized(), image: UIImage(named: "attachment"), cellWidth: 130.0)
        let FormTab        = TabItem(title: "Checklists".localized(), image: UIImage(named: "forms"), cellWidth: 130.0)
        let RPointsTab     = TabItem(title: "Record_Points".localized(), image: UIImage(named: "activities"), cellWidth: 130.0)
        let ObjectsTab     = TabItem(title: "Objects".localized(), image: UIImage(named: "objects"), cellWidth: 130.0)
        let HAndPTab       = TabItem(title: "History_Pending".localized(), image: UIImage(named: "history_pending"), cellWidth: 130.0)
        let HistoryTab     = TabItem(title: "History".localized(), image: UIImage(named: "History"), cellWidth: 130.0)
        let PendingTab     = TabItem(title: "Pending".localized(), image: UIImage(named: "PendingNF"), cellWidth: 130.0)
        let NoItemTab      =  TabItem(title: "Items".localized(), image: UIImage(named: "items"), cellWidth: 130.0)
        let NoActivityTab  =  TabItem(title: "Activities".localized(), image: UIImage(named: "activities"), cellWidth: 130.0)
        let NoTaskTab      =  TabItem(title: "Tasks".localized(), image: UIImage(named: "tasks"), cellWidth: 130.0)
        let NoAttchmentTab =  TabItem(title: "Attachments".localized(), image: UIImage(named: "attachment"), cellWidth: 130.0)
        let assetTab =  TabItem(title: "Assets".localized(), image: UIImage(named: "Inspection_Lot"), cellWidth: 130.0)
        if onlineSearch == false {
            if currentMasterView == "WorkOrder"{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    tabItemArray.append(OperationOverViewTab)
                }else{
                    tabItemArray.append(OverviewTab)
                    if applicationFeatureArrayKeys.contains("WoOperations"){
                        tabItemArray.append(OperationTab)
                    }
                }
                tabItemArray.append(assetTab)
                if applicationFeatureArrayKeys.contains("WoAttachments"){
                    tabItemArray.append(AttachementTab)
                }
                if applicationFeatureArrayKeys.contains("WoForms"){
                    tabItemArray.append(FormTab)
                }
                if applicationFeatureArrayKeys.contains("WoObjects"){
                    //tabItemArray.append(ObjectsTab)
                }
            }else if currentMasterView == "Notification"{
                tabItemArray.append(OverviewTab)
            }
            return tabItemArray
        }else{
            if currentMasterView == "WorkOrder"{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    tabItemArray.append(contentsOf: [OverviewTab])
                }else{
                    tabItemArray.append(contentsOf: [OverviewTab, OperationTab])
                }
                return tabItemArray
            }else if currentMasterView == "Notification"{
                tabItemArray.append(contentsOf: [OverviewTab,NoItemTab])
                return tabItemArray
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return [TabItem()]
    }
    func viewControllers() -> [UIViewController] {
        mJCLogger.log("Starting", Type: "info")
        //Workorder
        self.woOverviewVC = ScreenManager.getWorkOrderOverViewScreen()
        let operationsVC = ScreenManager.getOperationScreen()
        self.attachmentsVC = ScreenManager.getWorkOrderAttachmentScreen()
        let checkSheetListVC = ScreenManager.getCheckSheetListScreen()
        let objectsVC = ScreenManager.getObjectScreen()
        self.assetDetailsVC = ScreenManager.searchAssestDetailsScreen()

        var itemVC = UIViewController()
        var activitiesVC = UIViewController()
        var tasksVC = UIViewController()

        if DeviceType == iPhone{
            self.woOperationsVC = ScreenManager.getOperationListScreen()
            self.operationsVC_OverView = ScreenManager.getOperationScreen()
        }else{

        }
        //Notification
        self.notificationOverViewVC = ScreenManager.getNotificationOverViewScreen()
        if currentMasterView == "WorkOrder"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if DeviceType  == iPad{
                    tabVCArray.append(operationsVC)
                }else{
                    tabVCArray.append(self.operationsVC_OverView!)
                }
            }else{
                tabVCArray.append(self.woOverviewVC!)
                if applicationFeatureArrayKeys.contains("WoOperations"){
                    tabVCArray.append(operationsVC)
                }
            }
            tabVCArray.append(self.assetDetailsVC!)
            if applicationFeatureArrayKeys.contains("WoAttachments"){
                tabVCArray.append(self.attachmentsVC!)
                self.attachmentsVC?.objectNum = selectedworkOrderNumber
                self.attachmentsVC?.fromScreen = "WORKORDER"
            }
            if applicationFeatureArrayKeys.contains("WoForms"){
                tabVCArray.append(checkSheetListVC)
            }
            if applicationFeatureArrayKeys.contains("WoObjects"){
               // tabVCArray.append(objectsVC)
            }
        }else{
            tabVCArray.append(self.notificationOverViewVC!)
        }
        return tabVCArray

        mJCLogger.log("Ended", Type: "info")
        return []
    }
    private func setupCell() {
        mJCLogger.log("Starting", Type: "info")
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = (1 / 1366) * pageViewController.eachLineSpacing  * view.frame.width
        layout.scrollDirection = .horizontal
        layout.sectionInset = pageViewController.sectionInset
        menuCollectionView.collectionViewLayout = layout
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupPageView() {
        mJCLogger.log("Starting", Type: "info")
        pageViewController.view.frame = pageView.frame
        pageViewController.isPageFrom = ""
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = true
        pageView.addSubview(pageViewController.view)
        pageViewController.initialIndex = initialIndex
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupPageComponent() {
        mJCLogger.log("Starting", Type: "info")
        menuCollectionView.backgroundColor = pageViewController.tabBackgroundColor
        menuCollectionView.scrollsToTop = false
        mJCLogger.log("Ended", Type: "info")
    }
    private func setPages(_ viewControllers: [UIViewController]) {
        mJCLogger.log("Starting", Type: "info")
        guard viewControllers.count == pageViewController.items.count
        else { fatalError("The number of ViewControllers must equal to the number of TabItems.") }
        pageViewController.setPages(viewControllers)
        mJCLogger.log("Ended", Type: "info")
    }
    public func moveTo(index: Int) {
        mJCLogger.log("Starting", Type: "info")
        selectedIndex = index
        pageViewController.moveTo(index: index)
        self.menuCollectionView.reloadData()
        if DeviceType == iPad{
            UserDefaults.standard.set(index, forKey: "seletedTab_Wo")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mJCLogger.log("Starting", Type: "info")
        if (status == CLAuthorizationStatus.denied) {
            print("The user denied authorization")
            mJCLogger.log("The user denied authorization".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            print("NotDetermined Location")
            mJCLogger.log("NotDeterminedLocation".localized(), Type: "Error")
        }else if (status == CLAuthorizationStatus.restricted) {
            print("Restricted to use Location")
            mJCLogger.log("Restricted to use Location".localized(), Type: "Error")
        }else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            print("AuthorizedWhenInUse")
            mJCLogger.log("AuthorizedWhenInUse".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.authorizedAlways) {
            locationManager.startUpdatingLocation()
            print("AuthorizedAlways")
            mJCLogger.log("AuthorizedAlways".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mJCLogger.log("Starting", Type: "info")
        self.detailViewModel.getLatAndLog(locations: locations)
        self.locationManager.stopUpdatingLocation()
        mJCLogger.log("Ended", Type: "info")
    }
    //...END...//
}
