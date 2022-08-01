//
//  NotificationItemVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotificationItemVC: UIViewController,UITableViewDataSource,UITableViewDelegate, CreateUpdateDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var totalItemTableViewHolderView: UIView!
    @IBOutlet var totalItemLabelHolderView: UIView!
    @IBOutlet var totalItemCountLabel: UILabel!
    @IBOutlet var totalItemTableView: UITableView!
    @IBOutlet var totalItemDescriptionTableView: UITableView!
    @IBOutlet var createNewItemButton: UIButton!
    @IBOutlet var editItemButton: UIButton!
    @IBOutlet var itemCauseButton: UIButton!
    @IBOutlet var itemTaskButton: UIButton!
    @IBOutlet var itemActivityButton: UIButton!
    @IBOutlet weak var itemNotesBtn: UIButton!
    @IBOutlet var noDataLabel: UIView!
     
    var notificationFrom = String()
    var notificationItemViewModel = NotificationItemViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        notificationItemViewModel.vc = self
        if DeviceType == iPad{
            self.setViewLayout()
            ODSUIHelper.setButtonLayout(button: self.itemNotesBtn, cornerRadius: self.itemNotesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            totalItemTableView.dataSource = self
            totalItemTableView.delegate = self
            totalItemTableView.separatorStyle = .none
            totalItemTableView.estimatedRowHeight = 80
            totalItemDescriptionTableView.estimatedRowHeight = 130
            setAppfeature()
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationItemVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        }else{
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: "Item_No".localized() + ": \(selectedItem)")
            ODSUIHelper.setButtonLayout(button: self.itemNotesBtn, cornerRadius: self.itemNotesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        notificationItemViewModel.didSelectedCell = 0
        notificationItemViewModel.did_DeSelectedCell = 0
        notificationItemViewModel.singleItemArray.removeAll()
        notificationItemViewModel.totalItemArray.removeAll()
        totalItemDescriptionTableView.dataSource = self
        totalItemDescriptionTableView.delegate = self
        totalItemDescriptionTableView.separatorStyle = .none
        ScreenManager.registerItemOverViewCell(tableView: self.totalItemDescriptionTableView)
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
        self.viewWillAppear(false)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        super.viewWillAppear(animated)
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            currentsubView = "Items"
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
        }else{
            if selectedNotificationNumber == ""{
                createNewItemButton.isHidden = true
                editItemButton.isHidden = true
                itemCauseButton.isHidden = true
                itemTaskButton.isHidden = true
                itemActivityButton.isHidden = true
                itemNotesBtn.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func objectSelected(){
        self.notificationItemViewModel.getNotificationItemsData()
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        notificationItemViewModel.getNotificationItemsData()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func EntityCreated(){
        mJCLogger.log("Starting", Type: "info")
        notificationItemViewModel.getNotificationItemsData()
        if notificationFrom == "FromWorkorder"{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"setSingleNotificationItemCount"), object: "")
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"setNotificationItemCount"), object: "")
        }
    }
    //MARK:- UITableView Delegates And DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DeviceType == iPad{
            if(tableView == totalItemTableView) {
                return notificationItemViewModel.totalItemArray.count
            }else {
                return 3
            }
        }else{
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalItemTableView) {
            let notificationActivityCell = tableView.dequeueReusableCell(withIdentifier: "NotificationActivityCell") as! NotificationActivityCell
            notificationActivityCell.indexPath = indexPath
            notificationActivityCell.notificationItemViewModel = self.notificationItemViewModel
            if notificationItemViewModel.totalItemArray.count  > 0{
                notificationActivityCell.NotificationItemsModel = notificationItemViewModel.totalItemArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return notificationActivityCell
        }else {
            if (notificationItemViewModel.singleItemArray.count > 0) {
                if(indexPath.row == 0) {
                    let itemOverViewCell = ScreenManager.getItemOverViewCell(tableView: tableView)
                    itemOverViewCell.indexPath = indexPath
                    itemOverViewCell.notificationItemViewModel = self.notificationItemViewModel
                    itemOverViewCell.NotificationItemsModel = notificationItemViewModel.singleItemArray[0]
                    mJCLogger.log("Ended", Type: "info")
                    return itemOverViewCell
                }else if(indexPath.row == 1) {
                    let itemPartsDetailsCell = ScreenManager.getItemPartsDetailsCell(tableView: tableView)
                    itemPartsDetailsCell.indexPath = indexPath
                    itemPartsDetailsCell.notificationItemViewModel = self.notificationItemViewModel
                    if notificationItemViewModel.singleItemArray.count > 0{
                        itemPartsDetailsCell.NotificationItemsModel = notificationItemViewModel.singleItemArray[0]
                    }
                    mJCLogger.log("Ended", Type: "info")
                    return itemPartsDetailsCell
                }else if(indexPath.row == 2) {
                    let itemDamageDetailsCell = ScreenManager.getItemDamageDetailsCell(tableView: tableView)
                    itemDamageDetailsCell.indexPath = indexPath
                    itemDamageDetailsCell.notificationItemViewModel = self.notificationItemViewModel
                    if notificationItemViewModel.singleItemArray.count > 0{
                        itemDamageDetailsCell.NotificationItemsModel = notificationItemViewModel.singleItemArray[0]
                    }
                    mJCLogger.log("Ended", Type: "info")
                    return itemDamageDetailsCell
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
            if indexPath.row == 0{
                return 183
            }else if indexPath.row == 1{
                return 246
            }else {
                return 245
            }
        }
    }
    //MARK:- ButtonAction..
    @IBAction func createNewItemButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO_ITEM", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("createNewItemButtonAction".localized(), Type: "")
                    if isSingleNotification == true {
                        let count = "\(notificationItemViewModel.totalItemArray.count+1)"
                        menuDataModel.presentCreateItemScreen(vc: self, delegateVC: self, sortCount: count)
                    }else {
                        if selectedNotificationNumber == "" {
                            mJCLogger.log("You_have_no_selected_notification", Type: "Debug")
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                        }else {
                            let count = "\(notificationItemViewModel.totalItemArray.count+1)"
                            menuDataModel.presentCreateItemScreen(vc: self, delegateVC: self, notificationFrom: notificationFrom, sortCount: count)
                        }
                    }
                }
            }
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemCauseButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_NO_ITEM_CAUSE", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("itemCauseButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    }else {
                        DispatchQueue.main.async {
                            menuDataModel.uniqueInstance.presentNotificationItemCausesScreen(vc: self, isFromScrn: "ItemCause")
                        }
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemTaskButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_NO_ITEM_TASK", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("itemTaskButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    }else {
                        DispatchQueue.main.async {
                            menuDataModel.uniqueInstance.presentNotificationItemCausesScreen(vc: self, isFromScrn: "ItemTask")
                        }
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func editItemButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            if notificationItemViewModel.singleItemArray.count == 0{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Item_Available".localized(), button: okay)
            }else{
                if selectedNotificationNumber == "" {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                }else {
                    let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_NO_ITEM", orderType: "X",from:"WorkOrder")
                    if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                        if workFlowObj.ActionType == "Screen" {
                            if notificationItemViewModel.singleItemArray.count > 0{
                                menuDataModel.presentCreateItemScreen(vc: self, isFromEdit: true, delegateVC: self, selectedItem: notificationItemViewModel.singleItemArray[0])
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func itemActivityButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_NO_ITEM_ACTIVITY", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("itemActivityButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    }else {
                        DispatchQueue.main.async {
                            menuDataModel.uniqueInstance.presentNotificationItemCausesScreen(vc: self, isFromScrn: "ItemActivity")
                        }
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemNotesBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let noteListVC = ScreenManager.getLongTextListScreen()
        noteListVC.fromScreen = "noItem"
        noteListVC.itemNum = selectedItem
        if isActiveNotification == true{
            noteListVC.isAddNewNote = true
        }else{
            noteListVC.isAddNewNote = false
        }
        noteListVC.modalPresentationStyle = .fullScreen
        self.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }

    //MARK:- Set View layout..
    func setViewLayout() {
        
        mJCLogger.log("Starting", Type: "info")
        ODSUIHelper.setButtonLayout(button: self.createNewItemButton, cornerRadius: self.createNewItemButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.editItemButton, cornerRadius: self.editItemButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.itemCauseButton, cornerRadius: self.itemCauseButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.itemTaskButton, cornerRadius: self.itemTaskButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.itemActivityButton, cornerRadius: self.itemActivityButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationItemsDataUI(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.notificationItemViewModel.totalItemArray.count > 0 {
                self.noDataLabel.isHidden = true
                if DeviceType == iPad{
                    self.itemTaskButton.isHidden = false
                    self.itemActivityButton.isHidden = false
                    self.itemCauseButton.isHidden = false
                    self.itemNotesBtn.isHidden = false
                    self.editItemButton.isHidden = false
                }
                if DeviceType == iPad{
                    self.totalItemCountLabel.text = "Total".localized() + ": \(self.notificationItemViewModel.totalItemArray.count)"
                    self.totalItemTableView.reloadData()
                }
                self.totalItemDescriptionTableView.reloadData()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.noDataLabel.isHidden = false
                if DeviceType == iPad{
                    self.itemTaskButton.isHidden = true
                    self.itemActivityButton.isHidden = true
                    self.itemCauseButton.isHidden = true
                    self.itemNotesBtn.isHidden = true
                    self.editItemButton.isHidden = true
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleItemDataUI(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.notificationItemViewModel.singleItemArray.count > 0{
                self.noDataLabel.isHidden = true
                if DeviceType == iPad{
                    self.totalItemCountLabel.text = "Total".localized() + ": \(self.notificationItemViewModel.totalItemArray.count)"
                    self.totalItemTableView.reloadData()
                }
                self.totalItemDescriptionTableView.reloadData()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.noDataLabel.isHidden = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("NO_ADD_ITEM_OPTION"){
            createNewItemButton.isHidden = false
        }else{
            createNewItemButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_EDIT_ITEM_OPTION"){
            editItemButton.isHidden = false
        }else{
            editItemButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
