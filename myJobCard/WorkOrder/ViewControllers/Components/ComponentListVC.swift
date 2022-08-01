//
//  ComponentVC_iPhone.swift
//  myJobCard
//
//  Created by Rover Software on 25/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ComponentListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,CreateUpdateDelegate{
    
    @IBOutlet weak var componentListTable: UITableView!
    @IBOutlet weak var totalComponentLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var nocomponetLabel: UILabel!
    @IBOutlet var selectAllComponentButton: UIButton!
    @IBOutlet var historyHeaderView : UIView!
    @IBOutlet weak var historyHeaderConstraint: NSLayoutConstraint!
    @IBOutlet var addComponentButton: UIButton!

    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
    var isfrom = String()
    var selectedComponent = String()
    var componentCount = String()
    var hisWONum = String()
    var componentsViewModel = ComponentsViewModel()
    var isFromHistoryScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        componentsViewModel.componentsIPhoneVC = self
        componentsViewModel.hisWONum = hisWONum
        if self.isfrom == "WoHistory" {
            componentsViewModel.isFromHistoryScreen = true
        }
        ScreenManager.registerTotalOperationCountCell(tableView: self.componentListTable)
        historyHeaderConstraint.constant = 0.0
        historyHeaderView.isHidden = true
        if isfrom == "WoHistory" {
            historyHeaderConstraint.constant = 40.0
            historyHeaderView.isHidden = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ComponentListVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        self.componentsViewModel.getComponentList()
        if DeviceType == iPad{
            self.setAppfeature()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            currentsubView = "Components"
            if isfrom != "Supervisor"{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            }
        }
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        DispatchQueue.main.async {
            self.selectAllComponentButton.isSelected = false
            self.componentsViewModel.getComponentList()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var title = String()
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            title =  "\(selectedworkOrderNumber)/\(selectedOperationNumber)"
        }else{
            title =  "\(selectedworkOrderNumber)"
        }
        if isfrom == "WoHistory" {
            title = "\(hisWONum)"
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
    }
    func setAppfeature(){
        if applicationFeatureArrayKeys.contains("COMP_ADD_COMP_OPTION"){
            self.addComponentButton.isHidden = false
            ODSUIHelper.setButtonLayout(button: self.addComponentButton, cornerRadius: self.addComponentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }else{
            self.addComponentButton.isHidden = true
        }
    }


    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.componentsViewModel.componentListArray.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let componentTotalCell = ScreenManager.getTotalOperationCountCell(tableView: tableView)
        componentTotalCell.selectOpearettionButton.isHidden = true
        if self.componentsViewModel.componentListArray.count > indexPath.row{
            let componentModeClass = self.componentsViewModel.componentListArray[indexPath.row]
            componentTotalCell.indexPath = indexPath
            componentTotalCell.componentViewModel = componentsViewModel
            componentTotalCell.totalCompListIphoneClass = componentModeClass
            if isfrom == "Supervisor" || isfrom == "WoHistory" {
                componentTotalCell.selectCheckBoxWidthConst.constant = 0.0
                self.selectAllComponentButton.isHidden = true
            }
        }
        return componentTotalCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async{
            let componentsVC = ScreenManager.getComponentScreen()
            let componentTotalCell = ScreenManager.getTotalOperationCountCell(tableView: tableView)
            componentTotalCell.selectOpearettionButton.isHidden = true
            let componentModeClass = self.componentsViewModel.componentListArray[indexPath.row]
            componentModeClass.isSelected = true
            componentTotalCell.indexPath = indexPath
            componentTotalCell.componentViewModel.didSelectedCell = indexPath.row
            selectedComponentNumber = componentModeClass.Item
            componentTotalCell.componentViewModel = self.componentsViewModel
            componentTotalCell.totalCompListIphoneClass = componentModeClass
            componentsVC.selectedComponent = componentModeClass.Item
            self.componentsViewModel.selectedComponentArray.append(componentModeClass)
            componentsVC.singleComponentArray.append(componentModeClass)
            componentsVC.componentsViewModel.componentsIPhoneVC = self.componentsViewModel.componentsIPhoneVC
            componentTotalCell.componentViewModel.didSelectedCell = indexPath.row
            if self.isfrom == "WoHistory" {
                self.isFromHistoryScreen = true
                componentsVC.hisWONum = self.hisWONum
                componentsVC.isFromHistoryScreen = true
            }
            componentsVC.modalPresentationStyle = .fullScreen
            self.present(componentsVC, animated: false) {}
        }
    }
    @IBAction func addComponentButtonAction(_ sender: Any) {
        if isActiveWorkOrder == true {
            menuDataModel.presentCreateComponentScreen(vc: self)
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
    }

    @objc func selectComponentCheckBox(btn:UIButton){
        
        let indexPath = IndexPath(row: btn.tag, section: 0)
        let cell = componentListTable.cellForRow(at: indexPath) as! TotalOperationCountCell
        let componentCls = self.componentsViewModel.componentListArray[btn.tag]
        let reqmtQty = Int(truncating: componentCls.ReqmtQty)
        let withdrawalQty = Int(truncating: componentCls.WithdrawalQty)
        
        if cell.selectCheckBoxButton.isSelected == false{
            if reqmtQty > withdrawalQty{
                cell.selectCheckBoxButton.isSelected = true
                if !self.componentsViewModel.selectedComponentArray.contains(componentCls){
                    if componentCls.ReqmtQty == componentCls.WithdrawalQty{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), button: okay)
                    }else if componentCls.Reservation == ""{
                        cell.selectCheckBoxButton.isSelected = false
                        mJCAlertHelper.showAlert(self, title: "Local_Component".localized(), message: "This_is_a_local_component_you_can't_issue".localized(), button: okay)
                    }else{
                        self.componentsViewModel.selectedComponentArray.append(componentCls)
                        if self.componentsViewModel.selectedComponentArray.count == self.componentsViewModel.componentListArray.count{
                            self.selectAllComponentButton.isSelected = true
                            
                        }
                    }
                }
            }else{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), button: okay)
            }
        }else{
            cell.selectCheckBoxButton.isSelected = false
            if self.componentsViewModel.selectedComponentArray.contains(componentCls){
                if let index = self.componentsViewModel.selectedComponentArray.firstIndex(of: componentCls){
                    self.componentsViewModel.selectedComponentArray.remove(at: index)
                }
                if self.componentsViewModel.selectedComponentArray.count == 0{
                    self.selectAllComponentButton.isSelected = false
                }
            }
        }
        DispatchQueue.main.async {
            self.componentListTable.reloadData()
        }
    }
    @IBAction func selectAllComponentButtonAction(sender: AnyObject){
         
        if selectAllComponentButton.isSelected == false{
            
            selectAllComponentButton.isSelected = true
            for i in 0..<self.componentsViewModel.componentListArray.count{
                let indexPath = IndexPath(row: i, section: 0)
                let cell = componentListTable.cellForRow(at: indexPath) as? TotalOperationCountCell
                if let componentCls = self.componentsViewModel.componentListArray[i] as? WoComponentModel{
                    let reqmtQty = Int(truncating: componentCls.ReqmtQty)
                    let withdrawalQty = Int(truncating: componentCls.WithdrawalQty)
                    if componentCls.ReqmtQty != componentCls.WithdrawalQty && componentCls.Reservation != ""{
                        if reqmtQty > withdrawalQty{
                            if self.componentsViewModel.selectedComponentArray.contains(componentCls) == false{
                                self.componentsViewModel.selectedComponentArray.append(componentCls)
                                selectAllComponentButton.isSelected = true
                            }
                        }
                    }
                }
            }
        }else{
            selectAllComponentButton.isSelected = false
            self.componentsViewModel.selectedComponentArray.removeAll()
        }
        DispatchQueue.main.async {
            self.componentListTable.reloadData()
        }
    }
    @IBAction func historyCancelAction(sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }
    @objc func issueComponentAction(){
        
        mJCLogger.log("issueComponentButtonAction".localized(), Type: "")
        
        if isActiveWorkOrder == true {
            if self.componentsViewModel.selectedComponentArray.count > 0{
                self.componentsViewModel.componentIssueSet(count: 0)
            }else if self.componentsViewModel.componentListArray.count > 0 {
                let componentclass = self.componentsViewModel.componentListArray[did_DeSelectedCell]
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    if selectedOperationNumber != componentclass.OperAct {
                        mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                        return
                    }
                }
                let ReservationNum = componentclass.Reservation
                if ReservationNum == "" {
                    mJCAlertHelper.showAlert(self, title: "Local_Component".localized(), message: "Reservation_number_is_not_available_Please_do_transmit_to_issue_this_component".localized(), button: okay)
                    return
                }
                menuDataModel.presentIssueComponentScreen(vc: self, cmpntCls: self.componentsViewModel.componentListArray[did_DeSelectedCell])
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_part_available".localized(), button: okay)
            }
        } else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
    }
    func getComponentListUI() {
        DispatchQueue.main.async {
            if self.componentsViewModel.componentListArray.count != 0 {
                self.totalView.isHidden = false
                self.componentListTable.isHidden = false
                self.selectAllComponentButton.isHidden = false
                self.nocomponetLabel.isHidden = true
                self.totalComponentLabel.text = "Total_Components".localized() + ": "+"\(self.componentsViewModel.componentListArray.count)"
                DispatchQueue.main.async {
                    self.componentListTable.reloadData()
                }
            }else {
                self.totalView.isHidden = false
                self.componentListTable.isHidden = true
                self.nocomponetLabel.isHidden = false
                self.selectAllComponentButton.isHidden = true
                self.totalComponentLabel.text = "Total_Components".localized() + ":" + "\(self.componentsViewModel.componentListArray.count)"
                self.componentListTable.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func EntityCreated() {
        self.componentsViewModel.getComponentList()
    }
}
