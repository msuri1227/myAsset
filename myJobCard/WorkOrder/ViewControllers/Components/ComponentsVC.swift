//
//  ComponentsVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ComponentsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate, CreateUpdateDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var totalComponentCountLabel: UILabel!
    @IBOutlet var totalComponentCountLabelView: UIView!
    @IBOutlet var componentTotalTableView: UITableView!
    @IBOutlet var componentDetailTableView: UITableView!
    @IBOutlet var selectAllComponentButton: UIButton!
    
    //componetsButtonStackView Outlets..
    @IBOutlet var componetsButtonStackView: UIStackView!
    @IBOutlet var addComponentButton: UIButton!
    @IBOutlet var issueComponentButton: UIButton!
    @IBOutlet var newNotesButton: UIButton!
    @IBOutlet var editComponentButton: UIButton!
    @IBOutlet var sideView: UIView!
    @IBOutlet var noComponentView: UIView!
    @IBOutlet var hisTitleLabel: UILabel!
    @IBOutlet var hisBackButton: UIButton!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var iPhoneHeader: UIView!
    
    var componentsViewModel = ComponentsViewModel()
    var property = NSMutableArray()
    var selectedComponent = String()
    var isfrom = String()
    var singleComponentArray = [WoComponentModel]()
    let menudropDown = DropDown()
    var isFromHistoryScreen = false
    var hisWONum = String()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        self.componentsViewModel.componentsVC = self
        self.componentsViewModel.hisWONum = self.hisWONum
        self.componentsViewModel.isFromHistoryScreen = self.isFromHistoryScreen
        if DeviceType == iPad{
            ODSUIHelper.setButtonLayout(button: self.addComponentButton, cornerRadius: self.addComponentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.issueComponentButton, cornerRadius: self.issueComponentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.editComponentButton, cornerRadius: self.editComponentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            self.componentTotalTableView.separatorStyle = .none
            self.componentTotalTableView.estimatedRowHeight = 150.0
            self.componentDetailTableView.separatorStyle = .none
            self.componentDetailTableView.estimatedRowHeight = 1000.0
            self.componentDetailTableView.rowHeight = UITableView.automaticDimension
            if self.isfrom == "Supervisor" || self.isfrom == "WoHistory"{
                componetsButtonStackView.isHidden = true
            }else{
                componetsButtonStackView.isHidden = false
            }
        }else{
            componentsViewModel.did_DeSelectedCell = componentsViewModel.didSelectedCell
        }
        ODSUIHelper.setButtonLayout(button: self.newNotesButton, cornerRadius: self.newNotesButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ScreenManager.registerComponentOverViewCell(tableView: self.componentDetailTableView)

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"objectSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        self.componentsViewModel.getComponentList()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            if self.isfrom == "Supervisor" {
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Component".localized() + " : \(selectedComponentNumber)", NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"Back")
                self.iPhoneHeader.addSubview(view)
                if flushStatus == true{
                    view.refreshBtn.showSpin()
                }
                view.delegate = self
                self.newNotesButton.isHidden = true
            }else if self.isFromHistoryScreen{
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Component".localized() + " : \(selectedComponentNumber)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"Back")
                self.iPhoneHeader.addSubview(view)
                if flushStatus == true{
                    view.refreshBtn.showSpin()
                }
                self.newNotesButton.isHidden = true
                view.delegate = self
            }else{
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Component".localized() + " : \(selectedComponentNumber)", NewJobButton: true, refresButton: true, threedotmenu: true,leftMenuType:"Back")
                self.view.addSubview(view)
                if flushStatus == true{
                    view.refreshBtn.showSpin()
                }
                view.delegate = self
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if self.isFromHistoryScreen {
                headerHeightConstraint.constant = 64.0
                componetsButtonStackView.isHidden = true
                selectAllComponentButton.isHidden = true
                hisTitleLabel.isHidden = false
                hisBackButton.isHidden = false
            }else{
                headerHeightConstraint.constant = 0.0
                hisTitleLabel.isHidden = true
                hisBackButton.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
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
            if(tableView == componentTotalTableView) {
                return componentsViewModel.componentListArray.count
            }else {
                return 2
            }
        }else{
            return 2
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == componentTotalTableView) {
            let componentTotalCell = tableView.dequeueReusableCell(withIdentifier: "ComponentTotalCell") as! ComponentTotalCell
            componentTotalCell.indexPath = indexPath
            componentTotalCell.componentsViewModel = self.componentsViewModel
            componentTotalCell.componentModel = componentsViewModel.componentListArray[indexPath.row]
            componentTotalCell.componentListArray = self.componentsViewModel.componentListArray
            componentTotalCell.selectedComponentArray = self.componentsViewModel.componentListArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return componentTotalCell
        }else {
            if  self.componentsViewModel.componentListArray.count > 0 {
                if(indexPath.row == 0) {
                    let componentOverViewCell = ScreenManager.getComponentOverViewCell(tableView: componentDetailTableView)
                    if DeviceType == iPad{
                        componentOverViewCell.componentModel = self.componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                    }else{
                        if singleComponentArray.count > 0{
                            if self.componentsViewModel.componentListArray.count > 0 {
                                componentOverViewCell.componentModel = self.componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                                singleComponentArray.removeAll()
                                singleComponentArray.append(self.componentsViewModel.componentListArray[componentsViewModel.didSelectedCell])
                            }
                            self.componentsViewModel.selectedComponentArray = singleComponentArray
                        }
                    }
                    mJCLogger.log("Ended", Type: "info")
                    return componentOverViewCell
                }else {
                    let componentAdditionalDataCell = ScreenManager.getComponentAdditionalDataCell(tableView: tableView)
                    if DeviceType == iPad{
                        componentAdditionalDataCell.componentModel = self.componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                    }else{
                        if singleComponentArray.count > 0{
                            if self.componentsViewModel.componentListArray.count > 0 {
                                componentAdditionalDataCell.componentModel = self.componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                                singleComponentArray.removeAll()
                                singleComponentArray.append(self.componentsViewModel.componentListArray[componentsViewModel.didSelectedCell])
                            }
                            self.componentsViewModel.selectedComponentArray = singleComponentArray
                        }
                    }
                    mJCLogger.log("Ended", Type: "info")
                    return componentAdditionalDataCell
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType == iPad{
            return UITableView.automaticDimension
        }else{
            if indexPath.row == 0 {
                return 840
            }else {
                return 400
            }
        }
    }
    //MARK:- Component Button Action..
    @IBAction func issueComponentButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true {
            if DeviceType == iPhone {
                mJCLogger.log("Response :\(componentsViewModel.componentListArray.count)", Type: "Debug")
                if componentsViewModel.componentListArray.count > 0 {
                    let componentclass = componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        if selectedOperationNumber != componentclass.OperAct && WO_OP_OBJS_DISPLAY == "X"{
                            mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                            return
                        }
                    }
                    let ReservationNum = componentclass.Reservation
                    if ReservationNum == "" {
                        mJCLogger.log("Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title:"Local_Component".localized(), message: "Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), button: okay)
                        return
                    }
                    if componentclass.ReqmtQty != componentclass.WithdrawalQty{
                        menuDataModel.presentIssueComponentScreen(vc: self, cmpntCls: componentclass)
                    }else if componentclass.ReqmtQty == componentclass.WithdrawalQty{
                        mJCLogger.log("This_is_issued_Component_you_can't_issue_this_again".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title:"Local_Component".localized(), message: "This_is_issued_Component_you_can't_issue_this_again".localized(), button: okay)
                    }
                }else {
                    mJCLogger.log("No_part_available".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title:alerttitle, message: "No_part_available".localized(), button: okay)
                }
            }else {
                mJCLogger.log("Response :\(componentsViewModel.selectedComponentArray.count)", Type: "Debug")
                if componentsViewModel.selectedComponentArray.count > 0{
                    componentsViewModel.componentIssueSet(count: 0)
                }else if componentsViewModel.componentListArray.count > 0 {
                    let componentclass = componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        if selectedOperationNumber != componentclass.OperAct && WO_OP_OBJS_DISPLAY == "X"{
                            mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                            return
                        }
                    }
                    let ReservationNum = componentclass.Reservation
                    if ReservationNum == "" {
                        mJCLogger.log("Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title:"Local_Component".localized(), message: "Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), button: okay)
                        return
                    }
                    if componentclass.ReqmtQty != componentclass.WithdrawalQty{
                        menuDataModel.presentIssueComponentScreen(vc: self, cmpntCls: componentclass)
                    }else if componentclass.ReqmtQty == componentclass.WithdrawalQty{
                        mJCLogger.log("This_is_issued_Component_you_can't_issue_this_again".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title:"Local_Component".localized(), message: "This_is_issued_Component_you_can't_issue_this_again".localized(), button: okay)
                    }
                }else {
                    mJCLogger.log("No_part_available".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title:alerttitle, message: "No_part_available".localized(), button: okay)
                }
            }
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func editComponentAction(_ sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_MTRL", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("editComponentButtonAction".localized(), Type: "")
                if isActiveWorkOrder == true {
                    if componentsViewModel.selectedComponentArray.count > 1 && DeviceType == iPad{
                        mJCLogger.log("More_then_one_components_selected".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title:MessageTitle, message: "More_then_one_components_selected".localized(), button: okay)
                        return
                    }else{
                        let componentsClass = componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                        if componentsClass.ReqmtQty == componentsClass.WithdrawalQty{
                            mJCLogger.log("This_is_issued_Component_you_can't_edit_this_component".localized(), Type: "Warn")
                            mJCAlertHelper.showAlert(self, title:MessageTitle, message: "This_is_issued_Component_you_can't_edit_this_component".localized(), button: okay)
                        }else if componentsClass.Reservation == "" {
                            mJCLogger.log("This_is_local_component_You_can't_edit_this_component".localized(), Type: "Warn")
                            mJCAlertHelper.showAlert(self, title:MessageTitle, message: "This_is_local_component_You_can't_edit_this_component".localized(), button: okay)
                        }else{
                            menuDataModel.presentCreateComponentScreen(vc: self, isFromEdit: true, delegateVC: self, selectedCmpnt: componentsClass)
                        }
                    }
                }else {
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                    }else{
                        mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func newNotesButtonAction(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_MTRL_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("newNotesButtonAction".localized(), Type: "")
                if componentsViewModel.selectedComponentArray.count > 1 && DeviceType == iPad{
                    mJCLogger.log("More_then_one_components_selected".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title:MessageTitle, message: "More_then_one_components_selected".localized(), button: okay)
                    return
                }else{
                    let noteListVC = ScreenManager.getLongTextListScreen()
                    if isActiveWorkOrder == true {
                        noteListVC.isAddNewNote = true
                    }
                    let componentsClass = componentsViewModel.componentListArray[componentsViewModel.didSelectedCell]
                    noteListVC.fromScreen = "woComponent"
                    noteListVC.woNum = singleWorkOrder.WorkOrderNum
                    noteListVC.compObj = componentsClass
                    noteListVC.modalPresentationStyle = .fullScreen
                    self.present(noteListVC, animated: false) {}
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func selectAllComponentButtonAction(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        if selectAllComponentButton.isSelected == false{
            selectAllComponentButton.isSelected = true
            for i in 0..<componentsViewModel.componentListArray.count{
                let componentCls = componentsViewModel.componentListArray[i]
                let reqmtQty = Int(truncating: componentCls.ReqmtQty)
                let withdrawalQty = Int(truncating: componentCls.WithdrawalQty)
                if componentCls.ReqmtQty != componentCls.WithdrawalQty && componentCls.Reservation != ""{
                    if reqmtQty > withdrawalQty{
                        if !componentsViewModel.selectedComponentArray.contains(componentCls){
                            componentsViewModel.selectedComponentArray.append(componentCls)
                        }
                    }
                }
            }
        }else{
            selectAllComponentButton.isSelected = false
            componentsViewModel.selectedComponentArray.removeAll()
        }
        mJCLogger.log("Response :\(componentsViewModel.selectedComponentArray.count)", Type: "Debug")
        DispatchQueue.main.async {
            self.componentTotalTableView.reloadData()
            self.componentDetailTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func addComponentButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_MTRL", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateComponentScreen(vc: self, delegateVC: self)
                }
            }
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title:inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title:inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func historyBackButton(_ sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            DispatchQueue.main.async {
                if applicationFeatureArrayKeys.contains("COMP_ADD_COMP_OPTION"){
                    self.addComponentButton.isHidden = false
                }else{
                    self.addComponentButton.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("COMP_EDIT_COMP_OPTION") && self.componentsViewModel.componentListArray.count > 0{
                    self.editComponentButton.isHidden = false
                }else{
                    self.editComponentButton.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("COMP_ISSUE_COMP_OPTION") && self.componentsViewModel.componentListArray.count > 0{
                    self.issueComponentButton.isHidden = false
                    self.selectAllComponentButton.isHidden = false
                }else{
                    self.issueComponentButton.isHidden = true
                    self.selectAllComponentButton.isHidden = false
                }
                if self.componentsViewModel.componentListArray.count > 0{
                    self.newNotesButton.isHidden = false
                }else{
                    self.newNotesButton.isHidden = true
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    public func getComponentListUI(){
        mJCLogger.log("Starting", Type: "info")
        if componentsViewModel.componentListArray.count > 0{
            DispatchQueue.main.async {
                self.totalComponentCountLabel.text = "Total".localized() + ": \( String(describing: self.componentsViewModel.componentListArray.count))"
                self.sideView.isHidden = false
                self.componentTotalTableView.reloadData()
                self.componentDetailTableView.isHidden = false
                self.singleComponentArray.removeAll()
                let cmp = self.componentsViewModel.componentListArray[self.componentsViewModel.didSelectedCell]
                self.singleComponentArray.append(cmp)
                self.componentDetailTableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.sideView.isHidden = true
                self.componentDetailTableView.isHidden = true
                self.componentDetailTableView.reloadData()
            }
        }
        self.setAppfeature()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        self.componentsViewModel.componentsIPhoneVC?.componentsViewModel.getComponentList()
        self.dismiss(animated: false, completion: nil)
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
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
        menuarr = ["Issue_Component".localized(),"Edit_Component".localized()]
        imgArray = [#imageLiteral(resourceName: "addCompomentBlack"),#imageLiteral(resourceName: "issueComponentBlack")]
        if !applicationFeatureArrayKeys.contains("COMP_ISSUE_COMP_OPTION"){
            if let index = menuarr.firstIndex(of: "Issue_Component".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("COMP_EDIT_COMP_OPTION"){
            if let index =  menuarr.firstIndex(of: "Edit_Component".localized()){
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
            if item == "Issue_Component".localized() {
                if singleComponentArray.count > 0{
                    let ReservationNum = singleComponentArray[0].Reservation
                    if ReservationNum == "" {
                        mJCLogger.log("Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title:"Local_Component".localized(), message: "Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), button: okay)
                        return
                    }else{
                        self.issueComponentButtonAction(sender: UIButton())
                    }
                }
            }else if item == "Edit_Component".localized() {
                self.editComponentAction(UIButton())
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){}
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated() {
        self.componentsViewModel.getComponentList()
    }
    //...END...//
}
