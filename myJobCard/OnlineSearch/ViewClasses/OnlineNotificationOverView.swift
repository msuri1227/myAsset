//
//  OnlineNotificationOverViewVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 19/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OnlineNotificationOverViewVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var overViewTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var createNewWorkOrderBtn: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var overViewCellName = String()
    var otherInfoCellName = String()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var onlineNotiOverviewModel = OnlineSearchNotificationOverviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        onlineNotiOverviewModel.vcOnlineNotiOverview = self
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
        if DeviceType == iPad {
            ODSUIHelper.setButtonLayout(button: self.editButton, cornerRadius: self.editButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.notesButton, cornerRadius: self.notesButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.createNewWorkOrderBtn, cornerRadius: self.createNewWorkOrderBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }else {
            currentsubView = "Overview"
            self.createNewWorkOrderBtn.isHidden = true
        }
        ScreenManager.registerOnlineNotificationOverViewCell(tableView:self.overViewTableView)
        ScreenManager.registerOnlineNotificationOtherInfoCell(tableView: self.overViewTableView)
        if (selectedNotificationNumber != "") {
            onlineNotiOverviewModel.notificationArray.add(singleNotification)
            self.overViewTableView.reloadData()
        }
        if  DeviceType == iPad{
            self.setAppfeature()
        }
        self.overViewTableView.delegate = self
        self.overViewTableView.dataSource = self
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        DispatchQueue.main.async {
            self.onlineNotiOverviewModel.notificationArray.removeAllObjects()
            self.onlineNotiOverviewModel.notificationArray.add(singleNotification)
            if self.onlineNotiOverviewModel.notificationArray.count > 0 {
                self.noDataView.isHidden = true
                self.overViewTableView.isHidden = false
                self.overViewTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("ONLINE_EDIT_NOTIF"){
            self.editButton.isHidden = false
        }else{
            self.editButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("ONLINE_NOTIF_NOTES"){
            self.notesButton.isHidden = false
        }else{
            self.notesButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("ONLINE_CONV_NOTIF_TO_WO"){
            self.createNewWorkOrderBtn.isHidden = false
        }else{
            self.createNewWorkOrderBtn.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func editButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_NO", orderType: singleNotification.NotificationType,from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateNotificationScreen(vc: self, notificationCls: singleNotification, isFromEdit: true)
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func notesButtonAction(sender: AnyObject){
          mJCLogger.log("Starting", Type: "info")
          let noteListVC = ScreenManager.getLongTextListScreen()
              DispatchQueue.main.async{
                noteListVC.isAddNewNote = false
                noteListVC.fromScreen = "noOverViewOnline"
            noteListVC.modalPresentationStyle = .fullScreen
            self.present(noteListVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegate & Data Soruce Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if DeviceType == iPad {
                return 420
            }else {
                return 690
            }
        }else {
            if DeviceType == iPad {
                return 533
            }else {
                return 1033
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if onlineNotiOverviewModel.notificationArray.count > 0 {
            if(indexPath.row == 0) {
                let notificationOverViewCell = ScreenManager.getNotificationOverViewCell(tableView: tableView)
                if onlineNotiOverviewModel.notificationArray.count > 0{
                    mJCLogger.log("Response:\(onlineNotiOverviewModel.notificationArray[0])", Type: "Debug")
                    notificationOverViewCell.indexPath = indexPath
                    notificationOverViewCell.onlineNotiOverviewViewModel = onlineNotiOverviewModel
                    notificationOverViewCell.onlineNotifOverviewModelClass = onlineNotiOverviewModel.notificationArray[0] as? NotificationModel
                    mJCLogger.log("Ended", Type: "info")
                    return notificationOverViewCell
                }
            }else if(indexPath.row == 1) {
                let onlineNotificationOtherInfoCell = ScreenManager.getOnlineNotificationOtherInfoCell(tableView: tableView)
                if onlineNotiOverviewModel.notificationArray.count > 0{
                    mJCLogger.log("Response:\(onlineNotiOverviewModel.notificationArray[0])", Type: "Debug")
                    onlineNotificationOtherInfoCell.onlineNotiOtherInfoViewModel = onlineNotiOverviewModel
                    onlineNotificationOtherInfoCell.onlineNotifOtherinfoModelClass = onlineNotiOverviewModel.notificationArray[0] as? NotificationModel
                    mJCLogger.log("Ended", Type: "info")
                    return onlineNotificationOtherInfoCell
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            if DeviceType == iPad{
                overViewTableView.isHidden = true
                noDataView.isHidden = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    @IBAction func createNewWorkOrderBtnClicked(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else if onlineSearch == false {
            if  myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleNotification.entity) == true{
                mJCLogger.log("This_is_a_local_notification_You_cannot_create_workorder_from_it".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_a_local_notification_You_cannot_create_workorder_from_it".localized(), button: okay)
            }
        }else{
            if singleNotification.WorkOrderNum != "" {
                mJCLogger.log("The_workorder".localized() +  "\(singleNotification.WorkOrderNum)" + "for_this_notification_already_created".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_workorder".localized() +  "\(singleNotification.WorkOrderNum)" + "for_this_notification_already_created".localized(), button: okay)
            }else if singleNotification.WorkOrderNum == "" {
                menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "NotificationOverView", notificationNum: singleNotification.Notification)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
