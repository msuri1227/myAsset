//
//  NotificationOverViewVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotificationOverViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CreateUpdateDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var gotoTableViewHolderView: UIView!
    @IBOutlet var gotoLabelHolderView: UIView!
    @IBOutlet var gotoLabel: UILabel!
    @IBOutlet var gotoTableView: UITableView!
    @IBOutlet var gotoDescriptionTableView: UITableView!
    @IBOutlet var editNotificationButton: UIButton!
    @IBOutlet var brifcaseButton: UIButton!
    @IBOutlet var addNewNoteButton: UIButton!
    @IBOutlet var noDataView: UIView!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    public var isFromWorkorder = String()
    var notiOverviewModel = NotificationOverviewViewModel()
    var selectedNotification = NotificationModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        notiOverviewModel.vcNOOverview = self
        isWOCreated = false
        if DeviceType == iPad{
            if isSingleNotification == true {
                brifcaseButton.isHidden = true
                editNotificationButton.isHidden = true
            }
            ODSUIHelper.setButtonLayout(button: self.editNotificationButton, cornerRadius: self.editNotificationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.brifcaseButton, cornerRadius: self.brifcaseButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            self.gotoTableView.dataSource = self
            self.gotoTableView.delegate = self
            self.gotoTableView.separatorStyle = .none
            self.gotoTableView.estimatedRowHeight = 40
            setAppfeature()
        }else{
            if isFromWorkorder == "FromWorkorder" {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
            }else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationOverViewVC.StatusUpdated(notification:)), name:NSNotification.Name(rawValue:"StatusUpdated"), object: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
        ODSUIHelper.setButtonLayout(button: self.addNewNoteButton, cornerRadius: self.addNewNoteButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        notiOverviewModel.gotoListArray.removeAllObjects()
        notiOverviewModel.gotoListArray = ["Overview".localized(),"Workorder_And_Material".localized(),"Dates".localized(),"Location_And_Contact".localized(),"Additional_Data".localized()]
        self.gotoDescriptionTableView.dataSource = self
        self.gotoDescriptionTableView.delegate = self
        self.gotoDescriptionTableView.separatorStyle = .none
        self.gotoDescriptionTableView.estimatedRowHeight = 500
        ScreenManager.registerNoOverViewCell(tableView: self.gotoDescriptionTableView)
        DispatchQueue.main.async {
            self.gotoDescriptionTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if isWOCreated == true{
            isWOCreated = false
            let indexPath = IndexPath(row: 4, section: 0)
            self.gotoDescriptionTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
            let indexPath1 = IndexPath(row: 1, section: 0)
            self.gotoDescriptionTableView.selectRow(at: indexPath1, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        }
        if DeviceType == iPhone{
            currentsubView = "Overview"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func objectSelected(){
        if (selectedNotificationNumber != "") {
            self.notiOverviewModel.notificationArray.removeAll()
            self.notiOverviewModel.notificationArray.append(singleNotification)
            self.gotoDescriptionTableView.reloadData()
            self.selectedNotification = singleNotification
        }
    }
    @objc func StatusUpdated(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        self.gotoDescriptionTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        self.gotoDescriptionTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegates And DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == gotoTableView){
            return notiOverviewModel.gotoListArray.count
        }else {
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == gotoTableView){
            let notificationGotoCell = tableView.dequeueReusableCell(withIdentifier: "NotificationGotoCell") as! NotificationGotoCell
            notificationGotoCell.indexpath = indexPath
            notificationGotoCell.notiOverViewGoToModelClass = notiOverviewModel
            return notificationGotoCell
        }else {
            if notiOverviewModel.notificationArray.count > 0 {
                mJCLogger.log("Response:\(notiOverviewModel.notificationArray.count)", Type: "Debug")
                gotoDescriptionTableView.isHidden = false
                if DeviceType == iPad{
                    gotoLabelHolderView.isHidden = false
                    noDataView.isHidden = true
                }
                if(indexPath.row == 0) {
                    let notificationOverViewCell = ScreenManager.getNotificationOverViewCell(tableView: tableView)
                    notificationOverViewCell.indexPath = indexPath
                    notificationOverViewCell.notiOverviewViewModel = notiOverviewModel
                    notificationOverViewCell.notifOverviewModelClass = notiOverviewModel.notificationArray[0]
                    return notificationOverViewCell
                }else if(indexPath.row == 1) {
                    let notificationWorkOrderAndMaterialCell = ScreenManager.getNotificationWorkOrderAndMaterialCell(tableView: tableView)
                    notificationWorkOrderAndMaterialCell.notifWOMaterialModelClass = notiOverviewModel.notificationArray[0]
                    return notificationWorkOrderAndMaterialCell
                }else if(indexPath.row == 2) {
                    let notificationDatesCell = ScreenManager.getNotificationDatesCell(tableView: tableView)
                    notificationDatesCell.notifDatesModelClass = notiOverviewModel.notificationArray[0]
                    return notificationDatesCell
                }else if(indexPath.row == 3) {
                    let notificationLocationAndContactCell = ScreenManager.getNotificationLocationAndContactCell(tableView: tableView)
                    notificationLocationAndContactCell.notifLocationContactViewModel = notiOverviewModel
                    notificationLocationAndContactCell.notifLocationContactModelClass = notiOverviewModel.notificationArray[0]
                    return notificationLocationAndContactCell
                }else if(indexPath.row == 4) {
                    let notificationAdditionalDataCell = ScreenManager.getNotificationAdditionalDataCell(tableView: tableView)
                    notificationAdditionalDataCell.notifAdditionalModelClass = notiOverviewModel.notificationArray[0]
                    return notificationAdditionalDataCell
                }
            }else {
                gotoDescriptionTableView.isHidden = true
                if DeviceType == iPad{
                    gotoLabelHolderView.isHidden = true
                    noDataView.isHidden = false
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("NO_CONV_NOTI_TO_WO"){
            if isSingleNotification == true{
                brifcaseButton.isHidden = true
            }else{
                brifcaseButton.isHidden = false
            }
        }else{
            brifcaseButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_EDIT_NOTI_OPTION"){
            editNotificationButton.isHidden = false
        }else{
            editNotificationButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Update UI - Function Location Button Action..
    func updateUINotificationOverviewFunLoc(title: String){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = "floc"
            flocEquipDetails.flocEquipObjText = title
            if isFromWorkorder == "FromWorkorder" {
                flocEquipDetails.classificationType = "WONotification"
            }else{
                flocEquipDetails.classificationType = "Notification"
            }
            flocEquipDetails.modalPresentationStyle = .fullScreen
            self.present(flocEquipDetails, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Update UI - Equipment Button Action..
    func updateUINotificationOverviewEquipement(title: String){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let equipmentVC = ScreenManager.getFlocEquipDetialsScreen()
            equipmentVC.flocEquipObjType = "equip"
            equipmentVC.flocEquipObjText = title
            if isFromWorkorder == "FromWorkorder" {
                equipmentVC.classificationType = "WONotification"
            }else{
                equipmentVC.classificationType = "Notification"
            }
            equipmentVC.modalPresentationStyle = .fullScreen
            self.present(equipmentVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- ButtonAction..
    @IBAction func editNotificationButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            if selectedNotificationNumber == "" {
                mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
            }else {
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_NO", orderType: self.selectedNotification.NotificationType,from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                        createNotificationVC.isFromEdit = true
                        createNotificationVC.notificationClass = self.selectedNotification
                        createNotificationVC.createUpdateDelegate = self
                        createNotificationVC.modalPresentationStyle = .fullScreen
                        self.present(createNotificationVC, animated: false) {
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func brifcaseButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let notiStatus = self.selectedNotification.UserStatus
        let stutusArr = statusCategoryArr.filter{$0.StatuscCategory == "NOTIFICATIONLEVEL" && $0.StatusCode == "\(notiStatus)" && $0.StatusVisible == "X"}
        if stutusArr.count > 0{
            mJCLogger.log("Response:\(stutusArr[0])", Type: "Debug")
            let statusclass = stutusArr[0]
            if statusclass.AllowWoCreate == false{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "We_cann't_convert_to_workorder_with_this_status".localized(), button: okay)
                mJCLogger.log("We_cann't_convert_to_workorder_with_this_status".localized(), Type: "Debug")
                return
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        if selectedNotificationNumber == "" {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
            mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
        }else if selectedNotificationNumber.contains(find: "L") && ENABLE_LOCAL_NO_TO_WO == false{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_notification_You_cannot_create_workorder_from_it".localized(), button: okay)
            mJCLogger.log("This_is_a_local_notification_You_cannot_create_workorder_from_it".localized(), Type: "Debug")
        }else {
            if self.selectedNotification.WorkOrderNum != "" {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_workorder".localized() + "  \(self.selectedNotification.WorkOrderNum) " + "for_this_notification_already_created".localized(), button: okay)
                mJCLogger.log("workorder" + "  \(self.selectedNotification.WorkOrderNum) " + "for this notification already created".localized(), Type: "Debug")
            }else if self.selectedNotification.WorkOrderNum == "" {
                let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                createWorkOrderVC.isFromEdit = false
                createWorkOrderVC.createUpdateDelegate = self
                createWorkOrderVC.isScreen = "NotificationOverView"
                createWorkOrderVC.notificationNum = self.selectedNotification.Notification
                createWorkOrderVC.notificationType = self.selectedNotification.NotificationType
                createWorkOrderVC.modalPresentationStyle = .fullScreen
                self.present(createWorkOrderVC, animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.gotoDescriptionTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityUpdated(){
        DispatchQueue.main.async {
            self.objectSelected()
        }
    }
    @IBAction func addNewNoteButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_NO_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("Add new Note Button Tapped".localized(), Type: "")
                if selectedNotificationNumber == "" {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
                }else{
                    let noteListVC = ScreenManager.getLongTextListScreen()
                    noteListVC.isAddNewNote = true
                    if isSingleNotification == true {
                        noteListVC.fromScreen = "woNoOverView"
                    }else {
                        noteListVC.fromScreen = "noOverView"
                    }
                    noteListVC.modalPresentationStyle = .fullScreen
                    self.present(noteListVC, animated: false) {}
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
