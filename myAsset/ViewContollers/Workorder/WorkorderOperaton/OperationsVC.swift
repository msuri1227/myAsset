//
//  OperationsVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/28/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import AVFoundation

class OperationsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,CustomNavigationBarDelegate,CreateUpdateDelegate,operationCreationDelegate,listSelectionDelegate{

    //MARK:- Outlets..
    @IBOutlet var totalCountTableView: UITableView!
    @IBOutlet var operationTableView: UITableView!
    @IBOutlet var totalOperationCount: UILabel!
    @IBOutlet var operationButtonView: UIView!
    @IBOutlet var addNewNoteButton: UIButton!
    @IBOutlet var EditOperationButton: UIButton!
    @IBOutlet var addOperationButton: UIButton!
    @IBOutlet var saveOperationButton: UIButton!
    @IBOutlet var selectAllOperationCheckBox: UIButton!
    @IBOutlet var sideView: UIView!
    @IBOutlet var saveOperationButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var addOperationHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var operationTableWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var OperationTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var incompleteOperation: UIButton!
    @IBOutlet var transferButton: UIButton!
    @IBOutlet var noOperationView: UIView!
    @IBOutlet var followonWoCreateButton: UIButton!
    @IBOutlet weak var capacityButton: UIButton!
    @IBOutlet var manualCheckSheetButton: UIButton!
    @IBOutlet var checkSheetApproveButton: UIButton!
    @IBOutlet var onlineJobAuditButton: UIButton!
    
    //MARK:- Declared Variable..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var confirmOperationList = [String]()
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
    var isfromsup = String()
    var selectedIndexOp = Int()
    var oprWorkOrderDetails = WoHeaderModel()
    var responsiblePerson = String()
    var AllowedFollOnObjTypArray = Array<AllowedFollowOnObjectTypeModel>()
    var selectedOprNum = String()
    var property = NSMutableArray()
    let remainsTaskTextArray = NSMutableArray()
    var operationVCModel = OperationOverViewModel()
    let menudropDown = DropDown()
    var selectedOperation = WoOperationModel()
    

    //MARK:- LifeCycle..

    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        
        if DeviceType == iPad{
            self.setIPadBasicButtonView()
            self.totalCountTableView.separatorStyle = .none
            self.totalCountTableView.estimatedRowHeight = 100.0
            self.totalCountTableView.bounces = false
            self.operationTableView.separatorStyle = .none
            self.operationTableView.estimatedRowHeight = 1000.0
            self.operationTableView.rowHeight = UITableView.automaticDimension
            operationVCModel.isfromsup = isfromsup
            addNewNoteButton.tag = 1
            addNewNoteButton.setImage(UIImage(named: "notes"), for: .normal)
        }else{
            self.setIPhoneBasicView()
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3" {
                OperationTableViewTopConstraint.constant = 50.0
            }else {
                OperationTableViewTopConstraint.constant = 0.0
            }
            if onlineSearch == true{
                currentsubView = "Overview"
                addNewNoteButton.tag = 0
                addNewNoteButton.setImage(UIImage(named: "AssignWO"), for: .normal)
            }else{
                addNewNoteButton.tag = 1
                addNewNoteButton.setImage(UIImage(named: "notes"), for: .normal)
            }
            didSelectedCell = selectedIndexOp
            did_DeSelectedCell = selectedIndexOp
            if isfromsup == "Supervisor"{
                self.addNewNoteButton.isHidden = true
            }
        }
        operationVCModel.operationsVC = self
        operationVCModel.getPersonResponsibleList()
        self.operationVCModel.singleOperationArray.removeAll()
        self.confirmOperationList.removeAll()
        if DeviceType == iPad{
            ScreenManager.registerTotalOperationCountCell(tableView: totalCountTableView)
        }
        ScreenManager.registerOperationOverViewCell(tableView: self.operationTableView)
        ScreenManager.registerWoOverViewCell(tableView: self.operationTableView)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        DispatchQueue.main.async{
            self.operationTableView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(OperationsVC.statuschanged(notification:)), name:NSNotification.Name(rawValue:"StatusUpdated"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"objectSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func objectSelected(){
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && isfromsup != "Supervisor"{
            self.selectedOperation = singleOperation
            self.oprWorkOrderDetails = singleWorkOrder
            self.updateUI()
            if DeviceType == iPad{
                self.selectAllOperationCheckBox.isHidden = true
                self.operationTableWidthConstant.constant = 0.0
            }
        }else{
            operationVCModel.getConfirmationOpeartionSet(isfromsup: isfromsup)
            self.setAppfeature()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setIPadBasicButtonView(){
        
        ODSUIHelper.setButtonLayout(button: self.addNewNoteButton, cornerRadius: self.addNewNoteButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.EditOperationButton, cornerRadius: self.EditOperationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.addOperationButton, cornerRadius: self.addOperationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.saveOperationButton, cornerRadius: self.saveOperationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.transferButton, cornerRadius: self.transferButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.incompleteOperation, cornerRadius: self.incompleteOperation.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.followonWoCreateButton, cornerRadius: self.followonWoCreateButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.capacityButton, cornerRadius: self.capacityButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.manualCheckSheetButton, cornerRadius: self.manualCheckSheetButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.checkSheetApproveButton, cornerRadius: self.checkSheetApproveButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if isfromsup == "Supervisor"{
            operationButtonView.isHidden = true
        }else{
            operationButtonView.isHidden = false
        }
    }
    func setIPhoneBasicView(){
        
        ODSUIHelper.setButtonLayout(button: self.addNewNoteButton, cornerRadius: self.addNewNoteButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if isfromsup == "Supervisor" {
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Operation".localized() + ": \(selectedOperationNumber)" , NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"Back")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Operation".localized() + ": \(selectedOperationNumber)" , NewJobButton: true, refresButton: true, threedotmenu: true,leftMenuType:"Back")
                self.view.addSubview(view)
                if flushStatus == true{
                    view.refreshBtn.showSpin()
                }
                view.delegate = self
            }
        }
    }
    func updateUI(){
        if self.selectedOperation.OperationNum != ""{
            self.operationVCModel.singleOperationArray.removeAll()
            self.operationVCModel.singleOperationArray.append(self.selectedOperation)
            DispatchQueue.main.async {
                self.operationTableView.reloadData()
            }
        }
        self.setAppfeature()
    }
    func operation(_ Create: Bool, Update: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if Create == true{
            self.getOpeartionData()
        }else if Update == true{
            DispatchQueue.main.async {
                if DeviceType == iPad{
                    self.getOpeartionData()
                    self.totalCountTableView.reloadData()
                }else{
                    self.operationTableView.reloadData()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.operationTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")

        if DeviceType == iPad{
            DispatchQueue.main.async {
                if applicationFeatureArrayKeys.contains("OPR_EDIT_OPR_OPTION"){
                    if onlineSearch == true{
                        self.EditOperationButton.isHidden = true
                    }else{
                        self.EditOperationButton.isHidden = false
                    }
                }else{
                    self.EditOperationButton.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("OPR_ADD_OPR_OPTION"){
                    if onlineSearch == true{
                        self.addOperationButton.isHidden = true
                    }else{
                        self.addOperationButton.isHidden = false
                    }
                }else{
                    self.addOperationButton.isHidden = true
                }
                if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                    if !applicationFeatureArrayKeys.contains("CompleteOperation"){
                        self.self.saveOperationButton.isHidden = true
                    }else{
                        self.saveOperationButton.isHidden = false
                    }
                }else{
                    self.self.saveOperationButton.isHidden = true
                }

                if !applicationFeatureArrayKeys.contains("InCompleteOperation"){
                    self.incompleteOperation.isHidden = true
                }else{
                    self.incompleteOperation.isHidden = false
                }
                if applicationFeatureArrayKeys.contains("Create_FollowUp_WO"){
                    self.operationVCModel.getAllowedFollowOnObjectType()
                    self.followonWoCreateButton.isHidden = false
                    self.followonWoCreateButton.setImage(UIImage(named: "follwonwo"), for: .normal)
                }else{
                    self.followonWoCreateButton.isHidden = true
                }
                if !applicationFeatureArrayKeys.contains("ACCESS_CAPACITY_DATA"){
                    self.capacityButton.isHidden = true
                }else{
                    self.capacityButton.isHidden = false
                }
                if !applicationFeatureArrayKeys.contains("MANAGE_OPR_MANUAL_CHECKSHEET"){
                    self.manualCheckSheetButton.isHidden = true
                }else{
                    self.manualCheckSheetButton.isHidden = false
                }
                if !applicationFeatureArrayKeys.contains("MANAGE_OPR_CHECKSHEET_APPROVER"){
                    self.checkSheetApproveButton.isHidden = true
                }else{
                    self.checkSheetApproveButton.isHidden = false
                }
                if onlineSearch == true{
                    if applicationFeatureArrayKeys.contains("ONLINE_OPR_ASSIGN"){
                        self.transferButton.isHidden = false
                    }else{
                        self.transferButton.isHidden = true
                    }
                    if applicationFeatureArrayKeys.contains("ONLINE_OPR_NOTES"){
                        self.addNewNoteButton.isHidden = false
                    }else{
                        self.addNewNoteButton.isHidden = true
                    }
                    self.saveOperationButton.isHidden = true
                }else{
                    self.transferButton.isHidden = true
                }
                self.onlineJobAuditButton.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func followonWoCreateAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(operationVCModel.AllowedFollOnObjTypArray.count)", Type: "Debug")
        if operationVCModel.AllowedFollOnObjTypArray.count > 0{
            DispatchQueue.main.async {
                let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                createWorkOrderVC.isFromEdit = false
                createWorkOrderVC.isfromfollowOnWo = true
                createWorkOrderVC.isScreen = "WorkOrder"
                createWorkOrderVC.createUpdateDelegate =  self
                createWorkOrderVC.AllowedFollOnObjTypArray = self.operationVCModel.AllowedFollOnObjTypArray
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
    @IBAction func transferBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let transferVC = ScreenManager.getWorkOrderTransferScreen()
        transferVC.rejectString = "Transfer"
        transferVC.presentPerson = self.responsiblePerson
        transferVC.priorityValue = singleWorkOrder.Priority
        transferVC.modalPresentationStyle = .fullScreen
        self.present(transferVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func statuschanged(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad {
            DispatchQueue.main.async{
                self.totalCountTableView.reloadData()
            }
        }else if DeviceType == iPhone{
            DispatchQueue.main.async{
                self.operationTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DeviceType == iPad{
            if(tableView == totalCountTableView){
                return self.operationVCModel.totalOprationArray.count
            }else {
                if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && isfromsup != "Supervisor" {
                    if self.operationVCModel.singleOperationArray.count > 0{
                        let cls = self.operationVCModel.singleOperationArray[0]
                        if cls.WorkOrderDetailsInfo == true{
                            return 6
                        }else{
                            return 3
                        }
                    }else{
                        return 3
                    }
                }else{
                    return 3
                }
            }
        }else{
            
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if self.operationVCModel.singleOperationArray.count > 0{
                    let cls = self.operationVCModel.singleOperationArray[0]
                    if cls.WorkOrderDetailsInfo == true{
                        return 6
                    }else{
                        return 3
                    }
                }else{
                    return 3
                }
            }else{
                return 3
            }
            
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalCountTableView) {
            let totalOperationCountCell = ScreenManager.getTotalOperationCountCell(tableView: tableView)
            if self.operationVCModel.totalOprationArray.count > 0{
                totalOperationCountCell.operationCompleteImageWidthConstraint.constant = 0.0
                mJCLogger.log("Response :\(self.operationVCModel.totalOprationArray.count)", Type: "Debug")
                let operationClass = self.operationVCModel.totalOprationArray[indexPath.row]
                totalOperationCountCell.indexPath = indexPath
                totalOperationCountCell.totalOprListClass = operationClass
                totalOperationCountCell.operationVCModel = operationVCModel
                if selectedOperationNumber == operationClass.OperationNum {
                    if operationClass.isSelected == true {
                        totalOperationCountCell.transPerantView.isHidden = false
                        self.selectedOprNum = operationClass.OperationNum
                        self.did_DeSelectedCell = indexPath.row
                    }else {
                        totalOperationCountCell.transPerantView.isHidden = true
                    }
                }else {
                    totalOperationCountCell.transPerantView.isHidden = true
                }
                if operationVCModel.selectedOperationArray.contains(operationClass){
                    totalOperationCountCell.selectCheckBoxButton.isSelected = true
                }else{
                    totalOperationCountCell.selectCheckBoxButton.isSelected = false
                }
                if operationVCModel.isfromsup == "Supervisor"{
                    totalOperationCountCell.selectCheckBoxWidthConst.constant = 0.0
                    operationVCModel.operationsVC.selectAllOperationCheckBox.isHidden = true
                }
            }
            mJCLogger.log("Ended", Type: "info")
            return totalOperationCountCell
        }
        if tableView == operationTableView {
            if self.operationVCModel.singleOperationArray.count > 0 {
                let singleOperalClass = self.operationVCModel.singleOperationArray[0]
                if(indexPath.row == 0) {
                    let customerInfoOverViewCell = ScreenManager.getCustomerInfoOverViewCell(tableView: tableView)
                    customerInfoOverViewCell.indexpath = indexPath as IndexPath
                    customerInfoOverViewCell.isCellFrom = "OperationDetails"
                    customerInfoOverViewCell.operationVCModel = operationVCModel
                    customerInfoOverViewCell.woOverViewCustomerInfoModel = self.oprWorkOrderDetails
                    mJCLogger.log("Ended", Type: "info")
                    return customerInfoOverViewCell
                }else if(indexPath.row == 1) {
                    let assetAndDatesCell = ScreenManager.getAssetAndDatesCell(tableView: tableView)
                    assetAndDatesCell.indexpath = indexPath
                    assetAndDatesCell.isCellFrom = "OperationDetails"
                    assetAndDatesCell.operaionViewModel = operationVCModel
                    assetAndDatesCell.woOverViewAssetDatesModel = self.oprWorkOrderDetails
                    mJCLogger.log("Ended", Type: "info")
                    return assetAndDatesCell
                }else if(indexPath.row == 2) {
                    let additionalDataOverViewCell = ScreenManager.getAdditionalDataOverViewCell(tableView: tableView)
                    additionalDataOverViewCell.personRespArray = operationVCModel.personResponsibleArray as! [PersonResponseModel]
                    additionalDataOverViewCell.woAdditionalDataModel = self.oprWorkOrderDetails
                    mJCLogger.log("Ended", Type: "info")
                    return additionalDataOverViewCell
                }else if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && isfromsup != "Supervisor"{
                    if singleOperalClass.WorkOrderDetailsInfo == true{
                        if(indexPath.row == 3){
                            
                        }else if (indexPath.row == 4){
                            let assetAndDatesCell = ScreenManager.getAssetAndDatesCell(tableView: tableView)
                            assetAndDatesCell.indexpath = indexPath
                            assetAndDatesCell.isCellFrom = "OperationDetails"
                            assetAndDatesCell.operaionViewModel = operationVCModel
                            assetAndDatesCell.woOverViewAssetDatesModel = self.oprWorkOrderDetails
                            mJCLogger.log("Ended", Type: "info")
                            return assetAndDatesCell
                        }else if (indexPath.row == 5){
                            let additionalDataOverViewCell = ScreenManager.getAdditionalDataOverViewCell(tableView: tableView)
                            additionalDataOverViewCell.personRespArray = operationVCModel.personResponsibleArray as! [PersonResponseModel]
                            additionalDataOverViewCell.woAdditionalDataModel = self.oprWorkOrderDetails
                            mJCLogger.log("Ended", Type: "info")
                            return additionalDataOverViewCell
                        }
                    }
                }
            }
        }
        return UITableViewCell()
    }
    
    @objc func WorkOrderInforButtonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.operationVCModel.singleOperationArray.count)", Type: "Debug")
        if self.operationVCModel.singleOperationArray.count > 0{
            let operationClass = self.operationVCModel.singleOperationArray[0]
            if operationClass.WorkOrderDetailsInfo == true{
                DispatchQueue.main.async{
                    operationClass.WorkOrderDetailsInfo = false
                    self.operationTableView.reloadData()
                    let indexPath  = IndexPath(row: 0, section: 0)
                    if self.operationTableView.isValidIndexPath(indexPath: indexPath){
                        self.operationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }else{
                DispatchQueue.main.async{
                    if self.operationVCModel.singleOperationArray.count > 0{
                        let operationClass = self.operationVCModel.singleOperationArray[0]
                        operationClass.WorkOrderDetailsInfo = true
                        DispatchQueue.main.async{
                            self.operationTableView.reloadData()
                            let indexPath  = IndexPath(row: 3, section: 0)
                            if self.operationTableView.isValidIndexPath(indexPath: indexPath){
                                self.operationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func selectAllOperations(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        if selectAllOperationCheckBox.isSelected == false{
            selectAllOperationCheckBox.isSelected = true
            let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
            for i in 0..<self.operationVCModel.totalOprationArray.count{
                let singleoperationCls = self.operationVCModel.totalOprationArray[i]
                if !singleoperationCls.OperationNum.contains(find: "L") && !singleoperationCls.SystemStatus.contains(mobStatusCode){
                    operationVCModel.selectedOperationArray.append(singleoperationCls)
                }
            }
        }else{
            selectAllOperationCheckBox.isSelected = false
            operationVCModel.selectedOperationArray.removeAll()
        }
        DispatchQueue.main.async{
            self.totalCountTableView.reloadData()
            self.operationTableView.reloadData()
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
    //MARK:- Operation Button Action..
    @IBAction func addNewNoteButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if operationVCModel.selectedOperationArray.count > 0{
            mJCLogger.log("More_then_one_operation_selected".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: "More_then_one_operation_selected".localized(), button: okay)
            return
        }else if  singleOperation.OperationNum != ""  {
            if sender.tag == 0 {
                mJCLogger.log("Transfer Button Tapped".localized(), Type: "")
                let transferVC = ScreenManager.getWorkOrderTransferScreen()
                transferVC.rejectString = "Transfer"
                transferVC.presentPerson = self.responsiblePerson
                transferVC.priorityValue = singleWorkOrder.Priority
                transferVC.modalPresentationStyle = .fullScreen
                self.present(transferVC, animated: false) {}
            }else{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_OP_NOTES", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        let noteListVC = ScreenManager.getLongTextListScreen()
                        if singleOperation.SystemStatus == "CNF"{
                            noteListVC.isAddNewNote = false
                        }else{
                            noteListVC.isAddNewNote = true
                        }
                        noteListVC.fromScreen = "woOperation"
                        if onlineSearch == true{
                            noteListVC.fromScreen = "woOperationOnline"
                            noteListVC.isAddNewNote = false
                        }
                        noteListVC.modalPresentationStyle = .fullScreen
                        self.present(noteListVC, animated: false) {}
                    }
                }
            }
        }else {
            mJCLogger.log("No_operation_selected".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_operation_selected".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func EditOperationButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true || selectedOperationNumber.contains(find: "L"){
            
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_OP", orderType: "X",from:"WorkOrder")
            
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
                
                if workFlowObj.ActionType == "Screen" {
                    let editOperationVC = ScreenManager.getCreateOperationScreen()
                    editOperationVC.isFromScreen = "Operation"
                    editOperationVC.isFromEdit = true
                    editOperationVC.delegate = self
                    editOperationVC.singleOperationClass = self.operationVCModel.singleOperationArray[0]
                    if self.operationVCModel.singleOperationArray[0].isCompleted == true && (WORKORDER_ASSIGNMENT_TYPE != "2" ||  WORKORDER_ASSIGNMENT_TYPE != "4") {
                        mJCLogger.log("This_Operation_is_already_completed_hence_this_action_is_not_allowed".localized(), Type: "Warn")
                        
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_Operation_is_already_completed_hence_this_action_is_not_allowed".localized(), button: okay)
                        
                        return
                    }
                    editOperationVC.WOOrdertype = singleWorkOrder.OrderType as String
                    editOperationVC.modalPresentationStyle = .fullScreen
                    self.present(editOperationVC, animated: false) {}
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
    
    @IBAction func addOperationButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        
        if isActiveWorkOrder == true || singleWorkOrder.WorkOrderNum.contains(find: "L") {
            
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_OP", orderType: "X",from:"WorkOrder")
            
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
                if workFlowObj.ActionType == "Screen" {
                    let addOperationVC = ScreenManager.getCreateOperationScreen()
                    addOperationVC.isFromScreen = "Operation"
                    addOperationVC.isFromEdit = false
                    addOperationVC.delegate = self
                    addOperationVC.operationNumber = "L\(String.random(length: 3, type: "Number"))"
                    addOperationVC.singleOperationClass =  WoOperationModel()
                    addOperationVC.modalPresentationStyle = .fullScreen
                    self.present(addOperationVC, animated: false) {}
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
    
    @IBAction func saveOperationButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(operationVCModel.selectedOperationArray.count)", Type: "Debug")
        mJCLogger.log("Response :\(self.operationVCModel.singleOperationArray.count)", Type: "Debug")
        
        if isActiveWorkOrder == true{
            
            if operationVCModel.selectedOperationArray.count > 0{
                operationVCModel.completeBulkOperationMethod(count: 0)
            }else{
                if self.operationVCModel.singleOperationArray.count > 0 {
                    let singleOperationClass = self.operationVCModel.singleOperationArray[0]
                    if singleOperationClass.isCompleted == true {
                        mJCLogger.log("This_Operation_is_already_completed".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_Operation_is_already_completed".localized(), button: okay)
                    }
                    else {
                        self.completeOperationMethod()
                    }
                }
                else {
                    mJCLogger.log("No_operation_selected".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_operation_selected".localized(), button: okay)
                }
            }
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCLogger.log(inactiveWorkorderAlertMessage, Type: "Warn")
                
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func incompletButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(operationVCModel.singleOperationArray.count)", Type: "Debug")
        if self.operationVCModel.singleOperationArray.count > 0{
            let singleOperationClass = self.operationVCModel.singleOperationArray[0]
            if singleOperationClass.SystemStatus.contains(find: "CNF"){
                if singleOperationClass.OperationNum.contains(find: "L") {
                    mJCLogger.log("This_is_local_operation_You_can't_Complete_this_operation".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title: errorTitle, message: "This_is_local_operation_You_can't_Complete_this_operation".localized(), button: okay)
                    return
                }else{
                    let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "REL")
                    let params = Parameters(
                        title: alerttitle,
                        message: "Do_you_want_to_mark_this_operation_as_incomplete?".localized(),
                        cancelButton: "NO".localized(),
                        otherButtons: ["YES".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            (singleOperationClass.entity.properties["UserStatus"] as! SODataProperty).value = OPERATION_STATUS_TO_MARK_INCOMPLETE as NSObject
                            (singleOperationClass.entity.properties["MobileStatus"] as! SODataProperty).value = OPERATION_STATUS_TO_MARK_INCOMPLETE as NSObject
                            (singleOperationClass.entity.properties["SystemStatus"] as! SODataProperty).value = mobStatusCode as NSObject
                            (singleOperationClass.entity.properties["MobileObjectType"] as! SODataProperty).value = "X" as NSObject
                            (singleOperationClass.entity.properties["StatusFlag"] as? SODataProperty)?.value = "X" as NSObject
                            WoOperationModel.updateOperationEntity(entity: singleOperationClass.entity, flushRequired: false,options: nil, completionHandler: { (response, error) in
                                if(error == nil) {
                                    mJCLogger.log("Update Done", Type: "Debug")
                                    let operationClass = self.operationVCModel.totalOprationArray[self.did_DeSelectedCell]
                                    operationClass.isCompleted = false
                                    operationClass.UserStatus = OPERATION_STATUS_TO_MARK_INCOMPLETE
                                    operationClass.MobileStatus = OPERATION_STATUS_TO_MARK_INCOMPLETE
                                    operationClass.SystemStatus = mobStatusCode
                                    operationClass.StatusFlag = ""
                                    self.updateoperationConformation(opearion: operationClass)
                                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                                }else {
                                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                                    mJCAlertHelper.showAlert(self, title: errorTitle, message: "Fail_to_update_operation_try_again".localized(), button: okay)
                                }
                            })
                        default: break
                        }
                    }
                }
            }else{
                mJCLogger.log("You_can't_mark_this_operation_as_in_complete".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_can't_mark_this_operation_as_in_complete".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func customerInfoNotesAction() {
        
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("noteListButtonAction".localized(), Type: "")
                let noteListVC = ScreenManager.getLongTextListScreen()
                noteListVC.fromScreen = "woOverViewOnline"
                noteListVC.modalPresentationStyle = .fullScreen
                if isActiveWorkOrder == true || selectedworkOrderNumber.contains(find: "L"){
                    noteListVC.isAddNewNote = true
                }
                self.present(noteListVC, animated: false) {}
            }
        }
    }
    func customerNotificationAction() {
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
    func updateoperationConformation(opearion:WoOperationModel){
        mJCLogger.log("Starting", Type: "info")
        if ENABLE_CANCEL_FINAL_CONFIRMATION == true{
            operationVCModel.updateOperationConformation()
        }else{
            operationVCModel.postOperationConfirmation(partialConfirmation: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getOpeartionData() {
        mJCLogger.log("Starting", Type: "info")
        operationVCModel.getOpeartionData(isfromsup: isfromsup)
        mJCLogger.log("Ended", Type: "info")
    }
    func completeOperationMethod() {
        mJCLogger.log("Starting", Type: "info")
        let singleOperationClass = self.operationVCModel.singleOperationArray[0]
        let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
        if singleOperationClass.OperationNum.contains(find: "L") {
            mJCLogger.log("This_is_local_operation_You_can't_Complete_this_operation".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_local_operation_You_can't_Complete_this_operation".localized(), button: okay)
            return
        }else {
            let params = Parameters(
                title: alerttitle,
                message: "You_are_completing_this_operation_do_you_want_to_continue".localized(),
                cancelButton: "NO".localized(),
                otherButtons: ["YES".localized()]
            )
            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                switch buttonIndex {
                case 0: break
                case 1:
                    (singleOperationClass.entity.properties["SystemStatus"] as! SODataProperty).value = mobStatusCode as NSObject
                    self.operationVCModel.completeOperation(entity: singleOperationClass.entity)
                default: break
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Op Level Changes
    //Notification Button Action..
    @objc func speakaddress(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        ReadAndWriteModelclass.uniqueInstance.ReadText(text: self.oprWorkOrderDetails.Address)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func speakdescription(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        ReadAndWriteModelclass.uniqueInstance.ReadText(text: self.oprWorkOrderDetails.ShortText)
        mJCLogger.log("Ended", Type: "info")
    }
    func customerInfoNotificationAction() {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if self.oprWorkOrderDetails.NotificationNum != ""{
                let singlenotificationVC = ScreenManager.getSingleNotificationScreen()
                currentMasterView = "Notification"
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                selectedNotificationNumber = self.oprWorkOrderDetails.NotificationNum
                isSingleNotification = true
                singlenotificationVC.modalPresentationStyle = .fullScreen
                self.present(singlenotificationVC, animated: false) {}
            }else{
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
            }
        }else{
            let workorderClass = singleWorkOrder
            if workorderClass.NotificationNum != ""{
                currentMasterView = "Notification"
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                selectedNotificationNumber = workorderClass.NotificationNum
                isSingleNotification = true
                isSingleNotifFromOperation = true
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
        mJCLogger.log("Ended", Type: "info")
    }
    //Equipment Button Action..
    @objc func assetEquipmentButtonAction(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
            if DeviceType == iPad{
                let equipmentVC = ScreenManager.getFlocEquipDetialsScreen()
                equipmentVC.flocEquipObjType = "equip"
                equipmentVC.flocEquipObjText = sender.titleLabel?.text ?? ""
                equipmentVC.classificationType = "Workorder"
                equipmentVC.modalPresentationStyle = .fullScreen
                self.present(equipmentVC, animated: false) {}
            }
        }else{
            mJCLogger.log("Equipment_Not_Found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func equipmentmapButtonAction(sener: UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        if self.oprWorkOrderDetails.EquipNum == "" {
            mJCLogger.log("Equipment_Not_Found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
            return
        }
//        if DeviceType == iPad {
//           assetmapVC.openmappage(id: self.oprWorkOrderDetails.EquipNum)
//        }else {
//            currentMasterView = "WorkOrder"
//            selectedNotificationNumber = ""
//            selectedEquipment = self.oprWorkOrderDetails.EquipNum
//            let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//            assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//            self.present(assetMapDeatilsVC, animated: true, completion: nil)
//        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func funlocmapbuttonAction(sender : UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        if self.oprWorkOrderDetails.FuncLocation == "" {
            mJCLogger.log("Functional_Location_Not_Found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
            return
        }
//        if DeviceType == iPad {
//           assetmapVC.openmappage(id: self.oprWorkOrderDetails.FuncLocation)
//        }else {
//            currentMasterView = "WorkOrder"
//            selectedNotificationNumber = ""
//            selectedEquipment = self.oprWorkOrderDetails.FuncLocation
//            let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//            assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//            self.present(assetMapDeatilsVC, animated: true, completion: nil)
//        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func assetFunctionLocationButtonAction(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
            if DeviceType == iPad{
                let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
                flocEquipDetails.flocEquipObjType = "floc"
                flocEquipDetails.flocEquipObjText = sender.titleLabel?.text ?? ""
                flocEquipDetails.classificationType = "Workorder"
                flocEquipDetails.modalPresentationStyle = .fullScreen
                self.present(flocEquipDetails, animated: false) {}
            }
        }else{
            mJCLogger.log("Functional_Location_Not_Found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            if isfromsup == "Supervisor"{
                self.dismiss(animated: false, completion: nil)
            }else{
                openLeft()
            }
        }else{
            self.dismiss(animated: false, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
            if workFlowObj.ActionType == "Screen" {
                let createNewJobVC = ScreenManager.getCreateJobScreen()
                createNewJobVC.isFromEdit = false
                createNewJobVC.isScreen = "WorkOrder"
                createNewJobVC.modalPresentationStyle = .fullScreen
                self.present(createNewJobVC, animated: false) {}
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
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
    
    func threedotmenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            menuarr = ["Edit_Operation".localized(),"Capacity_Data".localized(),"Manage_CheckSheet_Assignment".localized(),"Forms_Approval".localized()]
            imgArray = [#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "Capacity_Data_Black"),#imageLiteral(resourceName: "ic_manualAssign_black"),#imageLiteral(resourceName: "ic_FormApproval_black")]
            
        }else {
            menuarr = ["Edit_Operation".localized(), "Complete_Operation".localized, "InComplete_Operation".localized,"Capacity_Data".localized(),"Manage_CheckSheet_Assignment".localized(),"Forms_Approval".localized()]
            imgArray = [#imageLiteral(resourceName: "editIcon"),#imageLiteral(resourceName: "ic_Check"),#imageLiteral(resourceName: "ic_Close"),#imageLiteral(resourceName: "Capacity_Data_Black"),#imageLiteral(resourceName: "ic_manualAssign_black"),#imageLiteral(resourceName: "ic_FormApproval_black")]
        }
        if !applicationFeatureArrayKeys.contains("OPR_EDIT_OPR_OPTION"){
            
            if let index =  menuarr.firstIndex(of: "Edit_Operation".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("CompleteOperation"){
            if let index =  menuarr.firstIndex(of: "Complete_Operation".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("InCompleteOperation"){
            if let index =  menuarr.firstIndex(of: "InComplete_Operation".localized()){
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
            if item == "Edit_Operation".localized() {
                self.EditOperationButtonAction(sender: UIButton())
            }else if item == "Manage_CheckSheet_Assignment".localized(){
                let manageAssignment = ScreenManager.getManageCheckSheetScreen()
                manageAssignment.modalPresentationStyle = .fullScreen
                self.present(manageAssignment, animated: false) {}
            }else if item == "Forms_Approval".localized(){
                let FromsApprovalVC = ScreenManager.getFormApprovalScreen()
                FromsApprovalVC.modalPresentationStyle = .fullScreen
                self.present(FromsApprovalVC, animated: false) {}
            }else if item == "Complete_Operation".localized() {
                self.saveOperationButtonAction(sender: UIButton())
            }else if item == "InComplete_Operation".localized() {
                self.incompletButtonAction(UIButton())
            }else if item == "Capacity_Data".localized() {
                let capacityVC = ScreenManager.getCapacityAssignmentScreen()
                capacityVC.modalPresentationStyle = .fullScreen
                self.present(capacityVC, animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){}

    func navigateToAssetMap(){
//        mJCLogger.log("Starting", Type: "info")
//        let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//        assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//        self.present(assetMapDeatilsVC, animated: true, completion: nil)
//        mJCLogger.log("Ended", Type: "info")
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
    @IBAction func capacityButtonAction(_ sender: UIButton) {
        
        let capacityVC = ScreenManager.getCapacityAssignmentScreen()
        capacityVC.modalPresentationStyle = .fullScreen
        self.present(capacityVC, animated: false) {}
    }
    //...END...//
}
