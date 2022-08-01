//
//  OnlineWorkOrderOverViewVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OnlineWorkOrderOverViewVC: UIViewController , UITableViewDataSource, UITableViewDelegate, CreateUpdateDelegate{
    
    @IBOutlet weak var overViewTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var transferBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var customerInfoCellName = String()
    var otherInfoCellName = String()
    var onlineWoOverviewModel = OnlineSearchWorkOrderOverviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        onlineWoOverviewModel.vcOnlineWoOverview = self
        self.noDataView.isHidden = false
        self.overViewTableView.isHidden = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
        onlineWoOverviewModel.getPersonResponsibleList()
        
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            self.transferBtnHeightConstraint.constant = 0
        }else{
            self.transferBtnHeightConstraint.constant = 40
        }
        ODSUIHelper.setButtonLayout(button: self.transferButton, cornerRadius: self.transferButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if DeviceType == iPad {
            ODSUIHelper.setButtonLayout(button: self.editButton, cornerRadius: self.editButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.notesButton, cornerRadius: self.notesButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            self.overViewTableView.estimatedRowHeight = 1000
            self.setAppfeature()
        }else {
            currentsubView = "Overview"
        }
        ScreenManager.registerOnlineWoOverViewCell(tableView: self.overViewTableView)
        if (selectedworkOrderNumber != "") {
            onlineWoOverviewModel.selecetdWorkOrderDetailsArr.add(singleWorkOrder)
            if onlineWoOverviewModel.selecetdWorkOrderDetailsArr.count != 0{
                mJCLogger.log("Response:\(onlineWoOverviewModel.selecetdWorkOrderDetailsArr.count)", Type: "Debug")
                self.noDataView.isHidden = true
                self.overViewTableView.isHidden = false
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.noDataView.isHidden = false
                self.overViewTableView.isHidden = true
            }
        }
        self.overViewTableView.delegate = self
        self.overViewTableView.dataSource = self
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("ONLINE_ASSIGN_WO"){
            self.transferButton.isHidden = false
        }else{
            self.transferButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("ONLINE_WO_NOTES"){
            self.notesButton.isHidden = false
        }else{
            self.notesButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("ONLINE_WO_EDIT"){
            self.editButton.isHidden = false
        }else{
            self.editButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        DispatchQueue.main.async {
            self.onlineWoOverviewModel.selecetdWorkOrderDetailsArr.removeAllObjects()
            self.onlineWoOverviewModel.selecetdWorkOrderDetailsArr.add(singleWorkOrder)
            if self.onlineWoOverviewModel.selecetdWorkOrderDetailsArr.count > 0 {
                self.noDataView.isHidden = true
                self.overViewTableView.isHidden = false
                self.overViewTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func editButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_WO", orderType: singleWorkOrder.OrderType,from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateWorkorderScreen(vc: self, isFromEdit: true, delegateVC: self)
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func notesButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let noteListVC = ScreenManager.getLongTextListScreen()
        noteListVC.isAddNewNote = false
        noteListVC.fromScreen = "woOverViewOnline"
        noteListVC.modalPresentationStyle = .fullScreen
        self.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- :- UITableView Delegate and Data Source Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            if DeviceType == iPad {
                return UITableView.automaticDimension
            }else {
                if onlineWoOverviewModel.isTranformHidden == false{
                    return 1079
                }else{
                    return 960
                }
            }
        }else {
            if DeviceType == iPad {
                return 471
            }else {
                return 815
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if onlineWoOverviewModel.selecetdWorkOrderDetailsArr.count != 0 {
            if indexPath.row == 0 {
                let customerInfoOverViewCell = ScreenManager.getCustomerInfoOverViewCell(tableView: tableView)
                mJCLogger.log("Response:\(onlineWoOverviewModel.selecetdWorkOrderDetailsArr[0])", Type: "Debug")
                customerInfoOverViewCell.indexpath = indexPath
                customerInfoOverViewCell.personRespArray = onlineWoOverviewModel.personResponsibleArray as! [PersonResponseModel]
                customerInfoOverViewCell.onlineWoOverviewViewModel = onlineWoOverviewModel
                customerInfoOverViewCell.onlineWoCustomerInfoModelClass = onlineWoOverviewModel.selecetdWorkOrderDetailsArr[0] as? WoHeaderModel
                mJCLogger.log("Ended", Type: "info")
                return customerInfoOverViewCell
            }
            else {
                let otherInfoTableViewCell = ScreenManager.getOtherInfoTableViewCell(tableView: tableView)
                mJCLogger.log("Response:\(onlineWoOverviewModel.selecetdWorkOrderDetailsArr[0])", Type: "Debug")
                otherInfoTableViewCell.indexpath = indexPath
                otherInfoTableViewCell.personRespArray = onlineWoOverviewModel.personResponsibleArray as! [PersonResponseModel]
                otherInfoTableViewCell.onlineWoOtherInfoViewModel = onlineWoOverviewModel
                otherInfoTableViewCell.onlineWoOtherInfoModelClass = onlineWoOverviewModel.selecetdWorkOrderDetailsArr[0] as? WoHeaderModel
                mJCLogger.log("Ended", Type: "info")
                return otherInfoTableViewCell
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    
    func updateUIEquipmentMapButton() {
        mJCLogger.log("Starting", Type: "info")
        if onlineWoOverviewModel.selecetdWorkOrderDetailsArr.count > 0{
            let workorderClass = onlineWoOverviewModel.selecetdWorkOrderDetailsArr[0] as! WoHeaderModel
            if workorderClass.EquipNum == "" {
                mJCLogger.log("Equipment_Not_Found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
                return
            }
            if DeviceType == iPad {
                assetmapVC.openmappage(id: workorderClass.EquipNum)
            }else {
                currentMasterView = "WorkOrder"
                selectedNotificationNumber = ""
                selectedEquipment = workorderClass.EquipNum
                DispatchQueue.main.async {
                    let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                    assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                    self.present(assetMapDeatilsVC, animated: true, completion: nil)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func updateUIFunlocMapButton() {
        mJCLogger.log("Starting", Type: "info")
        if onlineWoOverviewModel.selecetdWorkOrderDetailsArr.count > 0{
            let workorderClass = onlineWoOverviewModel.selecetdWorkOrderDetailsArr[0] as! WoHeaderModel
            if workorderClass.FuncLocation == "" {
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
                return
            }
            if DeviceType == iPad {
                assetmapVC.openmappage(id: workorderClass.FuncLocation)
            }else {
                currentMasterView = "WorkOrder"
                selectedNotificationNumber = ""
                selectedEquipment = workorderClass.FuncLocation
                DispatchQueue.main.async {
                    let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                    assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                    self.present(assetMapDeatilsVC, animated: true, completion: nil)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIAssetEquipmentButton(btnTitle: String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            menuDataModel.uniqueInstance.presentFlocEquipDetialsScreen(vc: self, flocOrEquipObjType: "equip", flocOrEquipObjText: btnTitle, classificationType: "Workorder")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIAssetFuncLocButton(btnTitle: String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            menuDataModel.uniqueInstance.presentFlocEquipDetialsScreen(vc: self, flocOrEquipObjType: "floc", flocOrEquipObjText: btnTitle, classificationType: "Workorder")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func EntityCreated(){
        mJCLogger.log("Starting", Type: "info")
        self.overViewTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func transferBtnAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentWorkOrderTransferScreen(vc: self, rejectStr: "Transfer", presentPrsn: onlineWoOverviewModel.responsiblePerson, priorityVal: singleWorkOrder.Priority)
    }
}
