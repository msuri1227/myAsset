//
//  WorkOrderOverViewVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/28/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class WorkOrderOverViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate, CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate, CreateUpdateDelegate{
    //MARK:- Outlets..
    @IBOutlet var gotoTableView: UITableView!
    @IBOutlet var overViewTablView: UITableView!
    @IBOutlet var overviewButtonView: UIStackView!
    @IBOutlet var addNotificationButton: UIButton!
    @IBOutlet var editWorkOrderButton: UIButton!
    @IBOutlet var noteListButton: UIButton!
    @IBOutlet var workOrderDeleteButton: UIButton!
    @IBOutlet weak var onlineTransferBtn: UIButton!
    @IBOutlet var followonWoCreateButton: UIButton!
    @IBOutlet var sideTableViewView: UIView!
    @IBOutlet var nodataLabel: UIView!
    @IBOutlet weak var NotesButtoniPhone: UIButton!
    @IBOutlet var manualCheckSheetButton: UIButton!
    @IBOutlet var checkSheetApproveButton: UIButton!
    
    @IBOutlet var tableviewTopConstant: NSLayoutConstraint!
    //MARK:- Declard Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var singleWorkOrderDictionary = NSMutableDictionary()
    var isfromsup = String()
    var notificationArray = NSMutableArray()
    var isTranformHidden = true
    var woOverviewViewModel = WorkOrderOverviewViewModel()
    var selectedWorkorder = WoHeaderModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        woOverviewViewModel.vcOverview = self
        woOverviewViewModel.getWororderDetails()
        if DeviceType == iPad{
            ODSUIHelper.setButtonLayout(button: self.addNotificationButton, cornerRadius: self.addNotificationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.editWorkOrderButton, cornerRadius: self.editWorkOrderButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.noteListButton, cornerRadius: self.noteListButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.workOrderDeleteButton, cornerRadius: self.workOrderDeleteButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.onlineTransferBtn, cornerRadius: self.onlineTransferBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.followonWoCreateButton, cornerRadius: self.followonWoCreateButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.manualCheckSheetButton, cornerRadius: self.manualCheckSheetButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.checkSheetApproveButton, cornerRadius: self.checkSheetApproveButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            self.gotoTableView.separatorStyle = .none
            self.gotoTableView.estimatedRowHeight = 50
            self.gotoTableView.delegate = self
            self.gotoTableView.dataSource = self
            self.gotoTableView.allowsSelection = true
            self.gotoTableView.bounces = false
            if isfromsup == "Supervisor"{
                overviewButtonView.isHidden = true
            }else{
                overviewButtonView.isHidden = false
            }
            if onlineSearch == true {
                self.onlineTransferBtn.isHidden = false
            }else {
                self.onlineTransferBtn.isHidden = true
            }
            self.overViewTablView.estimatedRowHeight = 1000
            overViewTablView.rowHeight = UITableView.automaticDimension
            if !applicationFeatureArrayKeys.contains("Create_FollowUp_WO"){
                self.followonWoCreateButton.isHidden = true
            }else{
                woOverviewViewModel.getAllowedFollowOnObjectType()
                self.followonWoCreateButton.isHidden = false
                self.followonWoCreateButton.setImage(UIImage(named: "follwonwo"), for: .normal)
            }
            if !applicationFeatureArrayKeys.contains("MANAGE_WO_CHECKSHEET_APPROVER"){
                self.checkSheetApproveButton.isHidden = true
            }else{
                self.checkSheetApproveButton.isHidden = false
            }
            if !applicationFeatureArrayKeys.contains("MANAGE_WO_MANUAL_CHECKSHEET"){
                self.manualCheckSheetButton.isHidden = true
            }else{
                self.manualCheckSheetButton.isHidden = false
            }
            if !applicationFeatureArrayKeys.contains("WO_EDIT_WO_OPTION"){
                self.editWorkOrderButton.isHidden = true
            }else{
                self.editWorkOrderButton.isHidden = false
            }

        }else{
            ODSUIHelper.setButtonLayout(button: self.NotesButtoniPhone, cornerRadius: self.NotesButtoniPhone.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            woOverviewViewModel.getNotificationList()
            NotificationCenter.default.addObserver(self, selector: #selector(WorkOrderOverViewVC.StatusUpdated(notification:)), name:NSNotification.Name(rawValue:"StatusUpdated"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            if isfromsup == "Supervisor" {
                self.NotesButtoniPhone.isHidden = true
            }
            tableviewTopConstant.constant = 0.0
        }
        woOverviewViewModel.getPersonResponsibleList()
        woOverviewViewModel.gotoArray = ["Customer_Info_And_Overview".localized(),"Asset_And_Dates".localized(),"Additional_Data".localized()]
        self.overViewTablView.separatorStyle = .none
        overViewTablView.isScrollEnabled = true
        self.overViewTablView.delegate = self
        self.overViewTablView.dataSource = self
        ScreenManager.registerWoOverViewCell(tableView: self.overViewTablView)
        self.viewWillAppear(false)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func StatusUpdated(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        self.overViewTablView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.overViewTablView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityUpdated(){
        DispatchQueue.main.async {
            self.woOverviewViewModel.getWororderDetails()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUI(){
        DispatchQueue.main.async {
            if (selectedworkOrderNumber != "") {
                self.woOverviewViewModel.singleWorkOrderArray.removeAll()
                self.woOverviewViewModel.singleWorkOrderArray.append(self.selectedWorkorder)
            }
            if DeviceType == iPad{
                if selectedworkOrderNumber == ""{
                    self.sideTableViewView.isHidden = true
                    self.overViewTablView.isHidden = true
                    self.nodataLabel.isHidden = false
                    self.overviewButtonView.isHidden = true
                }else{
                    self.overViewTablView.reloadData()
                    self.sideTableViewView.isHidden = false
                    self.overViewTablView.isHidden = false
                    self.nodataLabel.isHidden = true
                }
            }else {
                currentsubView = "Overview"
                self.overViewTablView.isScrollEnabled = true
                self.overViewTablView.delegate = self
                self.overViewTablView.dataSource = self
                self.overViewTablView.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DeviceType == iPad{
            if(tableView == gotoTableView) {
                return woOverviewViewModel.gotoArray.count
            }else {
                return 3
            }
        }else{
            return 3
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == gotoTableView) {
            let overViewGoToCell = tableView.dequeueReusableCell(withIdentifier: "OverViewGoToCell") as! OverViewGoToCell
            overViewGoToCell.indexpath = indexPath
            overViewGoToCell.woOverViewGoToModel = woOverviewViewModel
            mJCLogger.log("Ended", Type: "info")
            return overViewGoToCell
        }else {
            if woOverviewViewModel.singleWorkOrderArray.count > 0 {
                if(indexPath.row == 0) {
                    let customerInfoOverViewCell = ScreenManager.getCustomerInfoOverViewCell(tableView: tableView)
                    customerInfoOverViewCell.woOverviewModel = woOverviewViewModel
                    customerInfoOverViewCell.indexpath = indexPath
                    customerInfoOverViewCell.personRespArray = woOverviewViewModel.personResponsibleArray
                    if self.woOverviewViewModel.singleWorkOrderArray.count > 0{
                        customerInfoOverViewCell.woOverViewCustomerInfoModel = woOverviewViewModel.singleWorkOrderArray[0]
                        mJCLogger.log("Ended", Type: "info")
                        return customerInfoOverViewCell
                    }
                }else if(indexPath.row == 1) {
                    let assetAndDatesCell = ScreenManager.getAssetAndDatesCell(tableView: tableView)
                    assetAndDatesCell.indexpath = indexPath
                    assetAndDatesCell.woAssetDateModel = woOverviewViewModel
                    if self.woOverviewViewModel.singleWorkOrderArray.count > 0{
                        assetAndDatesCell.woOverViewAssetDatesModel = woOverviewViewModel.singleWorkOrderArray[0]
                        mJCLogger.log("Ended", Type: "info")
                        return assetAndDatesCell
                    }
                }else if(indexPath.row == 2) {
                    let additionalDataOverViewCell = ScreenManager.getAdditionalDataOverViewCell(tableView: tableView)
                    additionalDataOverViewCell.personRespArray = woOverviewViewModel.personResponsibleArray
                    if self.woOverviewViewModel.singleWorkOrderArray.count > 0{
                        additionalDataOverViewCell.woAdditionalDataModel = woOverviewViewModel.singleWorkOrderArray[0]
                        mJCLogger.log("Ended", Type: "info")
                        return additionalDataOverViewCell
                    }
                }
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if DeviceType == iPad{
            return UITableView.automaticDimension
        }else{
            if indexPath.row == 0 {
                if isTranformHidden == false{
                    return 1100
                }else{
                    return 1045
                }
            }else {
                return 700.0
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == gotoTableView){
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            self.overViewTablView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- OverView Button Action..
    @IBAction func addNotificationButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_WO_NO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                    createNotificationVC.isFromWorkOrder = true
                    createNotificationVC.isFromEdit = false
                    createNotificationVC.modalPresentationStyle = .fullScreen
                    self.present(createNotificationVC, animated: false) {}
                }
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func followonWoCreateAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(woOverviewViewModel.AllowedFollOnObjTypArray.count)", Type: "Debug")
        if woOverviewViewModel.AllowedFollOnObjTypArray.count > 0{
            DispatchQueue.main.async {
                let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                createWorkOrderVC.isFromEdit = false
                createWorkOrderVC.isfromfollowOnWo = true
                createWorkOrderVC.AllowedFollOnObjTypArray = self.woOverviewViewModel.AllowedFollOnObjTypArray
                createWorkOrderVC.isScreen = "WorkOrder"
                createWorkOrderVC.createUpdateDelegate =  self
                createWorkOrderVC.modalPresentationStyle = .fullScreen
                self.present(createWorkOrderVC, animated: false) {}
            }
        }else{
            DispatchQueue.main.async {
                mJCLogger.log("No_Order_Type_Found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Order_Type_Found".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func editWorkOrderButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if (isActiveWorkOrder == true) || singleWorkOrder.WorkOrderNum.contains(find: "L"){
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_WO", orderType: singleWorkOrder.OrderType,from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
                if workFlowObj.ActionType == "Screen" {
                    let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                    createWorkOrderVC.isFromEdit = true
                    createWorkOrderVC.createUpdateDelegate =  self
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
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func workOrderDeleteButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleWorkOrder.entity) == true && (selectedworkOrderNumber.contains(find: "L") || selectedworkOrderNumber.contains(find: "Temp")){
            if deletionValue == true {
                let params = Parameters(
                    title: alerttitle,
                    message: "Do_you_want_delete_the_Local_Work_Order".localized(),
                    cancelButton: "NO".localized(),
                    otherButtons: ["YES".localized()]
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: break
                    case 1:
                        self.woOverviewViewModel.deleteWorkOrderFromList()
                    default: break
                    }
                }
            }else {
                self.woOverviewViewModel.deleteWorkOrderFromList()
            }
        }else{
            mJCLogger.log("You_cannot_mark_this_workorder_as_deleted".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_cannot_mark_this_workorder_as_deleted".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func manualCheckSheetButtonAction(sender: AnyObject){
        let manageAssignment = ScreenManager.getManageCheckSheetScreen()
        manageAssignment.modalPresentationStyle = .fullScreen
        self.present(manageAssignment, animated: false) {}
    }
    @IBAction func checkSheetApproveButtonAction(sender: AnyObject){
        let formApprovalVc = ScreenManager.getFormApprovalScreen()
        formApprovalVc.modalPresentationStyle = .fullScreen
        self.present(formApprovalVc, animated: false) {}
    }
    // MARK:- Update UI Delete Work Order From List
    func updateUIDeleteWorkOrderFromList() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("\(singleWorkOrder.WorkOrderNum) record deleted : Done", Type: "Debug")
            singleWorkOrder = WoHeaderModel()
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            currentMasterView = "Dashboard"
            let dashboard = ScreenManager.getDashBoardScreen()
            self.appDeli.window?.rootViewController = dashboard
            self.appDeli.window?.makeKeyAndVisible()
            self.appDeli.window?.makeKeyAndVisible()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func noteListButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("noteListButtonAction".localized(), Type: "")
                let noteListVC = ScreenManager.getLongTextListScreen()
                noteListVC.fromScreen = "woOverView"
                noteListVC.modalPresentationStyle = .fullScreen
                if isActiveWorkOrder == true || selectedworkOrderNumber.contains(find: "L"){
                    noteListVC.isAddNewNote = true
                }
                self.present(noteListVC, animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // MARK:-  Update UI - Notification Button Action..
    func updateUICustomerInfoNotificationButton() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if DeviceType == iPad{
                if self.woOverviewViewModel.singleWorkOrderArray.count > 0{
                    let workorderClass = self.woOverviewViewModel.singleWorkOrderArray[0]
                    if workorderClass.NotificationNum != ""{
                        let singlenotificationVC = ScreenManager.getSingleNotificationScreen()
                        currentMasterView = "Notification"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
                        selectedNotificationNumber = workorderClass.NotificationNum
                        isSingleNotification = true
                        singlenotificationVC.modalPresentationStyle = .fullScreen
                        self.present(singlenotificationVC, animated: false) {}
                    }else{
                        mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
                    }
                }
            }else{
                if self.woOverviewViewModel.singleWorkOrderArray.count > 0{
                    let workorderClass = self.woOverviewViewModel.singleWorkOrderArray[0]
                    if workorderClass.NotificationNum != ""{
                        currentMasterView = "Notification"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
                        selectedNotificationNumber = workorderClass.NotificationNum
                        isSingleNotification = true
                        isSingleNotifFromWorkOrder = true
                        let mainViewController = ScreenManager.getMasterListDetailScreen()
                        mainViewController.workorderNotification = true
                        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
                        myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                        myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                        myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                        self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                        self.appDeli.window?.makeKeyAndVisible()
                        myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
                    }else{
                        mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Update UI - Equipment Button Action..
    @objc func updateUIAssetEquipmentButton(equipNo: String) {
        if DeviceType == iPad{
            let equipmentVC = ScreenManager.getFlocEquipDetialsScreen()
            equipmentVC.flocEquipObjType = "equip"
            equipmentVC.flocEquipObjText = equipNo
            equipmentVC.classificationType = "Workorder"
            equipmentVC.modalPresentationStyle = .fullScreen
            self.present(equipmentVC, animated: false) {}
        }else{
            let equipmentVC = ScreenManager.getFlocEquipDetialsScreen()
            equipmentVC.flocEquipObjType = "equip"
            equipmentVC.flocEquipObjText = equipNo
            equipmentVC.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Equipment"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = equipmentVC as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(equipmentVC, animated: true)
        }
    }
    // MARK:- Update UI - Function Location Button Action..
    func updateUIAssetFunctionLocationButton(funcLocNo: String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = "floc"
            flocEquipDetails.flocEquipObjText = funcLocNo
            flocEquipDetails.classificationType = "Workorder"
            flocEquipDetails.modalPresentationStyle = .fullScreen
            self.present(flocEquipDetails, animated: false) {}
        }else{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = "floc"
            flocEquipDetails.flocEquipObjText = funcLocNo
            flocEquipDetails.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Equipment"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = flocEquipDetails as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(flocEquipDetails, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Update UI - Equipment Map Button Action..
    func updateUIEquipmentMapButton() {
        mJCLogger.log("Starting", Type: "info")
        if self.woOverviewViewModel.singleWorkOrderArray.count > 0 {
            let workorderClass = woOverviewViewModel.singleWorkOrderArray[0]
            if workorderClass.EquipNum == "" {
                mJCLogger.log("Equipment_Not_Found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
                return
            }
//            if DeviceType == iPad {
//                assetmapVC.openmappage(id: workorderClass.EquipNum)
//            }else {
//                currentMasterView = "WorkOrder"
//                selectedNotificationNumber = ""
//                selectedEquipment = workorderClass.EquipNum
//                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//                self.present(assetMapDeatilsVC, animated: true, completion: nil)
//            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Update UI - Equipment Map Button Action..
    func updateUIFunlocMapButton() {
        mJCLogger.log("Starting", Type: "info")
        if self.woOverviewViewModel.singleWorkOrderArray.count > 0{
            let workorderClass = woOverviewViewModel.singleWorkOrderArray[0]
            if workorderClass.FuncLocation == "" {
                mJCLogger.log("Functional_Location_Not_Found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
                return
            }
//            if DeviceType == iPad {
//                assetmapVC.openmappage(id: workorderClass.FuncLocation)
//            }else {
//                currentMasterView = "WorkOrder"
//                selectedNotificationNumber = ""
//                selectedEquipment = workorderClass.FuncLocation
//                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//                self.present(assetMapDeatilsVC, animated: true, completion: nil)
//            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Update UI Inspection Lot
    func backButtonClicked(_ sender: UIButton?){
        
    }
    //...END...//
}
