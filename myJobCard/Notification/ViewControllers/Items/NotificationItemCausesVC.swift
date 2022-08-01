//
//  NotificationItemCausesVC.swift
//  myJobCard
//
//  Created by Alphaved on 11/03/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class NotificationItemCausesVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, taskAttachmentDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var totalItemTableViewHolderView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var totalItemLabelHolderView: UIView!
    @IBOutlet var totalItemCountLabel: UILabel!
    @IBOutlet var totalItemTableView: UITableView!
    @IBOutlet var totalItemDescriptionTableView: UITableView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet var nodataLabel: UILabel!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var createItemActivity: UIButton!
    @IBOutlet weak var editItemActivityButton: UIButton!
    @IBOutlet weak var taskAttachmentButton: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var LastSyncLabel: UILabel!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var galleryButton: UIButton!
    @IBOutlet var videoBtn: UIButton!
    @IBOutlet var documentButton: UIButton!
    @IBOutlet var urlButton: UIButton!
    @IBOutlet weak var itemTaskAttachmentsView: UIView!
    @IBOutlet weak var itemTaskOverviewTabView: UIView!
    @IBOutlet weak var itemTaskOverviewButton: UIButton!
    @IBOutlet weak var itemTaskOverviewColorLabel: UILabel!
    @IBOutlet weak var itemTaskAttachmentsButton: UIButton!
    @IBOutlet weak var itemTaskAttachmentsColorLabel: UILabel!
    @IBOutlet weak var itemTaskAttachmentsTabView: UIView!
    @IBOutlet weak var itemTaskAttachmentsCountLabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var iPhoneHeader: UIView!
    
    var isFromScreen = String()
    var notificationFrom = String()
    var notificationItemCausesViewModel = NotificationItemCausesViewModel()
    var statusArray = NSMutableArray()
    var allowedStatusArray = NSMutableArray()
    var selectedTaskObjRef = NotificationTaskModel()
    var noAttachmentsVC : NotificationAttachmentVC?
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.statusCollectionView.backgroundColor = appColor
        }
        notificationItemCausesViewModel.vc = self
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"TaskStatusUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationItemCausesVC.StatusUpdated(notification:)), name:NSNotification.Name(rawValue:"TaskStatusUpdated"), object: nil)
        if DeviceType == iPad{
            self.itemTaskAttachmentsCountLabel.layer.cornerRadius = self.itemTaskAttachmentsCountLabel.frame.size.height/2
            self.itemTaskAttachmentsCountLabel.layer.masksToBounds = true
            self.itemTaskAttachmentsCountLabel.backgroundColor = appColor
            self.itemTaskAttachmentsCountLabel.textColor = UIColor.white
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationItemCausesVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationItemCausesVC.backGroundSyncStarted(notification:)), name: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func backGroundSyncStarted(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if isFromScreen == "ItemTask" {
            notificationItemCausesViewModel.getNotificationTasksData()
            DispatchQueue.main.async {
                self.headerLabel.text = "Item_Tasks".localized()
            }
        }else if isFromScreen == "ItemCause" {
            notificationItemCausesViewModel.getNotificationItemsCausesData()
            DispatchQueue.main.async {
                self.headerLabel.text = "Item_Causes".localized()
            }
        }else if isFromScreen == "ItemActivity" {
            notificationItemCausesViewModel.getNotificationActivityData()
            DispatchQueue.main.async {
                self.headerLabel.text = "Item_Activities".localized()
            }
        }
        if DeviceType == iPad {
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func StatusUpdated(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if isFromScreen == "ItemTask" {
            notificationItemCausesViewModel.getNotificationTasksData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPad && isFromScreen == "ItemTask" {
            itemTaskAttachmentsView.isHidden = true
            itemTaskOverviewTabView.backgroundColor = .white
            itemTaskOverviewColorLabel.backgroundColor = appColor
            itemTaskOverviewTabView.layer.borderColor = UIColor.lightGray.cgColor
            itemTaskOverviewTabView.layer.borderWidth = 1
            ODSUIHelper.setViewLayout(view: itemTaskOverviewTabView, shadowColor: .lightGray, shadowOffSet: CGSize(width: 0.0, height: 2), opacity: 2.0, radius: 1)
            itemTaskAttachmentsTabView.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            itemTaskAttachmentsColorLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            self.cameraButton.isHidden = true
            self.galleryButton.isHidden = true
            self.videoBtn.isHidden = true
            self.documentButton.isHidden = true
            self.urlButton.isHidden = true
            self.createItemActivity.isHidden = false
            self.editItemActivityButton.isHidden = false
            self.notesBtn.isHidden = false
        }else{
            if DeviceType == iPad{
                itemTaskAttachmentsView.isHidden = true
                itemTaskOverviewTabView.isHidden = true
                itemTaskAttachmentsTabView.isHidden = true
            }
        }
        ODSUIHelper.setButtonLayout(button: self.notesBtn, cornerRadius: self.notesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if DeviceType == iPad {
            if flushStatus == true{
                self.refreshButton.showSpin()
            }
            notificationItemCausesViewModel.didSelectedCell = 0
            notificationItemCausesViewModel.did_DeSelectedCell = 0
            noDataView.isHidden = true
            ODSUIHelper.setButtonLayout(button: self.createItemActivity, cornerRadius: self.createItemActivity.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.editItemActivityButton, cornerRadius: self.editItemActivityButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.cameraButton, cornerRadius: self.cameraButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.galleryButton, cornerRadius: self.galleryButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.videoBtn, cornerRadius: self.videoBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.documentButton, cornerRadius: self.documentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.urlButton, cornerRadius: self.urlButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            notificationItemCausesViewModel.singleItemCausesArray.removeAll()
            notificationItemCausesViewModel.totalItemArray.removeAll()
            totalItemTableView.dataSource = self
            totalItemTableView.delegate = self
            totalItemTableView.separatorStyle = .none
            totalItemTableView.estimatedRowHeight = 80
            totalItemDescriptionTableView.separatorStyle = .none
            totalItemDescriptionTableView.estimatedRowHeight = 130
            if isFromScreen == "ItemTask" {
                statusCollectionView.dataSource = self
                statusCollectionView.delegate = self
                notificationItemCausesViewModel.getNotificationTasksData()
                self.headerLabel.text = "Item_Tasks".localized()
            }else if isFromScreen == "ItemCause" {
                notificationItemCausesViewModel.getNotificationItemsCausesData()
                self.headerLabel.text = "Item_Causes".localized()
            }else if isFromScreen == "ItemActivity" {
                notificationItemCausesViewModel.getNotificationActivityData()
                self.headerLabel.text = "Item_Activities".localized()
            }
            ScreenManager.registerItemCausesOverViewCell(tableView: self.totalItemDescriptionTableView)
            setAppfeatureForStatusDisplay()
            if isFromScreen == "ItemCause" || isFromScreen == "ItemActivity" {
                self.cameraButton.isHidden = true
                self.galleryButton.isHidden = true
                self.videoBtn.isHidden = true
                self.documentButton.isHidden = true
                self.urlButton.isHidden = true
            }
        }else{
            myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
            ScreenManager.registerNotificationItemCausesTableViewCell(tableView: self.totalItemDescriptionTableView)
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: selectedNotificationNumber, NewJobButton: false, refresButton: false, threedotmenu: true,leftMenuType:"Back")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            if isFromScreen == "ItemCause" {
                notificationItemCausesViewModel.getSingleItemCausesData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getAllowedTaskStatus(status:String) {
        
        mJCLogger.log("Starting", Type: "info")
        allowedStatusArray.removeAllObjects()
        let statusArr  = globalStatusArray
        var filteredArray = [WorkOrderStatusModel]()
        filteredArray = statusArr.filter{$0.CurrentStatusCode == "\(status)" && $0.StatusCategory == NotificationTaskLevel && $0.ObjectType == "X"}
        for obj in filteredArray {
            let statclass = obj
            allowedStatusArray.add(statclass.AllowedStatusCode)
        }
        let arr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: NotificationTaskLevel, ObjectType: "X")
        self.addImagesForStatusArrays(statArray:arr)
        statusView.isHidden = false
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeatureForStatusDisplay(){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder" {
            if isFromScreen == "ItemTask" {
                if applicationFeatureArrayKeys.contains("WO_NO_ITEM_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("NO_EDIT_TASK_OPTION"){
                    self.editItemActivityButton.isHidden = false
                }else{
                    self.editItemActivityButton.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("NO_ADD_TASK_OPTION"){
                    self.createItemActivity.isHidden = false
                }else{
                    self.createItemActivity.isHidden = true
                }
            }else{
                if applicationFeatureArrayKeys.contains("WO_NO_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
                if isFromScreen == "ItemCause"{
                    if applicationFeatureArrayKeys.contains("NO_EDIT_ITEM_CAUSE_OPTION"){
                        self.editItemActivityButton.isHidden = false
                    }else{
                        self.editItemActivityButton.isHidden = true
                    }
                    if applicationFeatureArrayKeys.contains("NO_ADD_ITEM_CAUSE_OPTION"){
                        self.createItemActivity.isHidden = false
                    }else{
                        self.createItemActivity.isHidden = true
                    }
                }else if isFromScreen == "ItemActivity"{
                    if applicationFeatureArrayKeys.contains("NO_EDIT_TASK_OPTION"){
                        self.editItemActivityButton.isHidden = false
                    }else{
                        self.editItemActivityButton.isHidden = true
                    }
                    if applicationFeatureArrayKeys.contains("NO_ADD_TASK_OPTION"){
                        self.createItemActivity.isHidden = false
                    }else{
                        self.createItemActivity.isHidden = true
                    }
                }
            }
        }else{
            if isFromScreen == "ItemTask" {
                if applicationFeatureArrayKeys.contains("WO_NO_ITEM_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("NO_EDIT_TASK_OPTION"){
                    self.editItemActivityButton.isHidden = false
                }else{
                    self.editItemActivityButton.isHidden = true
                }
                if applicationFeatureArrayKeys.contains("NO_ADD_TASK_OPTION"){
                    self.createItemActivity.isHidden = false
                }else{
                    self.createItemActivity.isHidden = true
                }
            }else{
                if applicationFeatureArrayKeys.contains("WO_NO_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
                if isFromScreen == "ItemCause"{
                    if applicationFeatureArrayKeys.contains("NO_EDIT_ITEM_CAUSE_OPTION"){
                        self.editItemActivityButton.isHidden = false
                    }else{
                        self.editItemActivityButton.isHidden = true
                    }
                    if applicationFeatureArrayKeys.contains("NO_ADD_ITEM_CAUSE_OPTION"){
                        self.createItemActivity.isHidden = false
                    }else{
                        self.createItemActivity.isHidden = true
                    }
                }else if isFromScreen == "ItemActivity"{
                    if applicationFeatureArrayKeys.contains("NO_EDIT_ACTIVITY_OPTION"){
                        self.editItemActivityButton.isHidden = false
                    }else{
                        self.editItemActivityButton.isHidden = true
                    }
                    if applicationFeatureArrayKeys.contains("NO_ADD_ACTIVITY_OPTION"){
                        self.createItemActivity.isHidden = false
                    }else{
                        self.createItemActivity.isHidden = true
                    }
                }
            }
        }
        if isFromScreen == "ItemCause" || isFromScreen == "ItemActivity" || notificationItemCausesViewModel.totalTaskArray.count == 0{
            if DeviceType == iPad{
                statusView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func addImagesForStatusArrays(statArray: Array<StatusCategoryModel>) {
        mJCLogger.log("Starting", Type: "info")
        self.statusArray.removeAllObjects()
        for obj in statArray {
            let woStatus = obj
            for obj1 in globalStatusArray {
                let statObj = obj1
                if statObj.AllowedStatusCode == woStatus.StatusCode {
                    self.statusArray.add(woStatus)
                    break
                }
            }
        }
        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"Sequence", ascending : true)
        let sortedArray:NSArray = (self.statusArray.sortedArray(using : [descriptor]) as NSArray)
        if DeviceType == iPhone{
            self.statusArray.removeAllObjects()
            let statusPredicat = NSPredicate(format: "StatusCode IN %@", self.allowedStatusArray)
            let finalStatuses = sortedArray.filtered(using: statusPredicat)
            self.statusArray.addObjects(from: finalStatuses )
            
        }else{
            self.statusArray.removeAllObjects()
            self.statusArray.addObjects(from: sortedArray as! [Any])
        }
        DispatchQueue.main.async {
            self.statusCollectionView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getWorkFlowSet(validClass:StatusCategoryModel,from:String) {
        mJCLogger.log("Starting", Type: "info")
        var screen = ""
        var workflowObject = ""
        if from == "WorkOrder"{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: validClass.StatusCode, orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                screen = workFlowObj.ActionKey
                workflowObject = workFlowObj.ActionType
            }
        }else{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: validClass.StatusCode, orderType: "X",from:NotificationTaskLevel)
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                screen = workFlowObj.ActionKey
                workflowObject = workFlowObj.ActionType
            }
        }
        if workflowObject == "Screen" {
            
            
        }else if workflowObject == "Action" {
            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: selectedTaskObjRef,flushRequired: true)
        }else{
            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: selectedTaskObjRef,flushRequired: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegates And DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalItemTableView){
            if isFromScreen == "ItemTask" {
                return notificationItemCausesViewModel.totalTaskArray.count
            }else if isFromScreen == "ItemCause" {
                return notificationItemCausesViewModel.totalItemArray.count
            }else if isFromScreen == "ItemActivity" {
                return notificationItemCausesViewModel.totalActivityArray.count
            }
            return 0
        }else {
            if isFromScreen == "ItemTask" {
                return 1
            }else if isFromScreen == "ItemCause" {
                return 1
            }else if isFromScreen == "ItemActivity" {
                return 1
            }
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalItemTableView) {
            let notificationActivityCell = tableView.dequeueReusableCell(withIdentifier: "NotificationActivityCell") as! NotificationActivityCell
            notificationActivityCell.backGroundView.layer.cornerRadius = 3.0
            notificationActivityCell.backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
            notificationActivityCell.backGroundView.layer.shadowOpacity = 0.2
            notificationActivityCell.backGroundView.layer.shadowRadius = 2
            if isFromScreen == "ItemTask" {
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notificationItemCausesViewModel = self.notificationItemCausesViewModel
                notificationActivityCell.NotificationTaskModel = notificationItemCausesViewModel.totalTaskArray[indexPath.row]
            }else if isFromScreen == "ItemCause" {
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notificationItemCausesViewModel = self.notificationItemCausesViewModel
                if self.notificationItemCausesViewModel.totalItemArray.count > 0 {
                    notificationActivityCell.notifItemCauseModelClass =
                        self.notificationItemCausesViewModel.totalItemArray[indexPath.row]
                }
            }else if isFromScreen == "ItemActivity" {
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notificationItemCausesViewModel = self.notificationItemCausesViewModel
                notificationActivityCell.notificationActivityModel = notificationItemCausesViewModel.totalActivityArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return notificationActivityCell
        }else {
            if isFromScreen == "ItemTask" {
                if (notificationItemCausesViewModel.singleTaskArray.count > 0) {
                    let notificationTaskOverViewCell = ScreenManager.getNotificationTaskOverViewCell(tableView: tableView)
                    notificationTaskOverViewCell.indexPath = indexPath
                    notificationTaskOverViewCell.notificationItemCausesViewModel = self.notificationItemCausesViewModel
                    notificationTaskOverViewCell.NotificationTaskModel = notificationItemCausesViewModel.singleTaskArray[0]
                    mJCLogger.log("Ended", Type: "info")
                    return notificationTaskOverViewCell
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else if isFromScreen == "ItemCause" {
                if (notificationItemCausesViewModel.singleItemCausesArray.count > 0) {
                    if(indexPath.row == 0) {
                        let itemOverViewCell = ScreenManager.getNotificationItemCausesTableViewCell(tableView: tableView)
                        itemOverViewCell.indexPath = indexPath
                        itemOverViewCell.notificationItemCausesViewModel = self.notificationItemCausesViewModel
                        itemOverViewCell.NotificationItemCauseModel = notificationItemCausesViewModel.singleItemCausesArray[0]
                        mJCLogger.log("Ended", Type: "info")
                        return itemOverViewCell
                    }
                }
            }else if isFromScreen == "ItemActivity" {
                if(notificationItemCausesViewModel.singleActivityArray.count > 0) {
                    let notificationActivityOverViewCell = ScreenManager.getNotificationActivityOverViewCell(tableView: tableView)
                    notificationActivityOverViewCell.indexPath = indexPath
                    notificationActivityOverViewCell.notificationItemCausesViewModel = self.notificationItemCausesViewModel
                    notificationActivityOverViewCell.NotificationActivityModel = notificationItemCausesViewModel.singleActivityArray[0]
                    mJCLogger.log("Ended", Type: "info")
                    return notificationActivityOverViewCell
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType == iPhone{
            if isFromScreen == "ItemCause"{
                return 440
            }
        }else {
            if tableView == totalItemTableView {
                return 76
            }else {
                if isFromScreen == "ItemCause" {
                    return UITableView.automaticDimension
                }else if isFromScreen == "ItemTask" {
                    if DeviceType == iPad{
                        if indexPath.row == 1{
                            return 500
                        }
                    }
                    return UITableView.automaticDimension
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalItemTableView) {
            let notificationActivityCell = tableView.dequeueReusableCell(withIdentifier: "NotificationActivityCell") as! NotificationActivityCell
            notificationActivityCell.backGroundView.layer.cornerRadius = 3.0
            notificationActivityCell.backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
            notificationActivityCell.backGroundView.layer.shadowOpacity = 0.2
            notificationActivityCell.backGroundView.layer.shadowRadius = 2
            if isFromScreen == "ItemTask" {
                notificationItemCausesViewModel.taskClass = notificationItemCausesViewModel.totalTaskArray[indexPath.row]
            }else if isFromScreen == "ItemCause" {
                notificationItemCausesViewModel.causeClass = notificationItemCausesViewModel.totalItemArray[indexPath.row]
            }else if isFromScreen == "ItemActivity" {
                notificationItemCausesViewModel.activityClass = notificationItemCausesViewModel.totalActivityArray[indexPath.row]
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func notesBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let noteListVC = ScreenManager.getLongTextListScreen()
        noteListVC.itemNum = selectedItem
        if  isSingleNotification == true{
            if isFromScreen == "ItemTask" {
                noteListVC.taskNum = notificationItemCausesViewModel.selectedTask
                noteListVC.fromScreen = "woNoItemTask"
            }else if isFromScreen == "ItemActivity" {
                noteListVC.activityNum = notificationItemCausesViewModel.selectedActivity
                noteListVC.fromScreen = "woNoItemActivity"
            }else if isFromScreen == "ItemCause" {
                noteListVC.itemCause = notificationItemCausesViewModel.selectedItemCauses
                noteListVC.fromScreen = "woNoItemCause"
            }
        }else{
            if isFromScreen == "ItemTask" {
                noteListVC.taskNum = notificationItemCausesViewModel.selectedTask
                noteListVC.fromScreen = "noItemTask"
            }else if isFromScreen == "ItemActivity" {
                noteListVC.activityNum = notificationItemCausesViewModel.selectedActivity
                noteListVC.fromScreen = "noItemActivity"
            }else if isFromScreen == "ItemCause" {
                noteListVC.itemCause = notificationItemCausesViewModel.selectedItemCauses
                noteListVC.fromScreen = "noItemCause"
            }
        }
        noteListVC.isAddNewNote = true
        noteListVC.modalPresentationStyle = .fullScreen
        self.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func createNewItemActivityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if selectedNotificationNumber == "" {
            mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
        }else {
            if isFromScreen == "ItemTask" {
                let count = "\((Int(notificationItemCausesViewModel.totalTaskArray.count)) + 1)"
                menuDataModel.presentCreateTaskScreen(vc: self, sortCount: count, fromWo: self.notificationFrom, itemTask: true, itemNum: selectedItem)
            }else if isFromScreen == "ItemCause" {
                let count = "\((Int(notificationItemCausesViewModel.totalItemArray.count)) + 1)"
                menuDataModel.presentCreateItemCauseScreen(vc: self, sortCount: count, notificationFrom: self.notificationFrom, itemCause: true)
            }else if isFromScreen == "ItemActivity" {
                let count = "\(notificationItemCausesViewModel.totalActivityArray.count+1)"
                menuDataModel.presentCreateActivityScreen(vc: self, sortCount: count, notificationFrom: self.notificationFrom, itemNumber: true, itemActivity: true)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func editItemActivityButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if selectedItem == "" {
            mJCLogger.log("No_items_to_edit".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_items_to_edit".localized(), button: okay)
        }else {
            if isFromScreen == "ItemTask" {
                if notificationItemCausesViewModel.singleTaskArray.count == 1{
                    menuDataModel.presentCreateTaskScreen(vc: self, isFromEdit: true, taskCls: notificationItemCausesViewModel.singleTaskArray[0], fromWo: self.notificationFrom, itemTask: true, itemNum: selectedItem)
                }
            }
            else if isFromScreen == "ItemCause" {
                var causeCls = NotificationItemCauseModel()
                if DeviceType == iPhone {
                    if (notificationItemCausesViewModel.singleItemCausesArray.count > 0) {
                        causeCls = notificationItemCausesViewModel.singleItemCausesArray[0]
                    }
                }else {
                    causeCls = notificationItemCausesViewModel.causeClass
                }
                menuDataModel.presentCreateItemCauseScreen(vc: self, isFromEdit: true, causeCls: causeCls, notificationFrom: self.notificationFrom, itemCause: true)
            }else if isFromScreen == "ItemActivity" {
                menuDataModel.presentCreateActivityScreen(vc: self, isFromEdit: true, activityCls: notificationItemCausesViewModel.activityClass, notificationFrom: self.notificationFrom, itemNumber: true, itemActivity: true)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cameraBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        self.noAttachmentsVC?.takePhotoButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func galleryBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        self.noAttachmentsVC?.openGalleryButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func videoBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        self.noAttachmentsVC?.takeVideoButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func documentBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        self.noAttachmentsVC?.openFileButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func urlBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        self.noAttachmentsVC?.uploadNotifiAttachmentUrlButtonAction(UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Back Button Action..
    @IBAction func backbuttonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){}
    func threedotmenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let menudropDown = DropDown()
        var menuarr = [String]()
        if isItemCause == true {
            menuarr = ["Edit_Item_Cause".localized()]
        }
        if !applicationFeatureArrayKeys.contains("NO_EDIT_ITEM_CAUSE_OPTION"){
            if let index =  menuarr.firstIndex(of: "Edit_Item_Cause".localized()) {
                menuarr.remove(at: index)
            }
        }
        if menuarr.count == 0{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Options_Available".localized(), button: okay)
        }
        menudropDown.dataSource = menuarr
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Edit_Item_Cause".localized() {
                if isActiveNotification == true{
                    self.editItemActivityButtonAction(UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){}
    func getSingleItemCausesDataUI(){
        mJCLogger.log("Starting", Type: "info")
        self.totalItemDescriptionTableView.dataSource = self
        self.totalItemDescriptionTableView.delegate = self
        self.totalItemDescriptionTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationActivityDataUI(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.singleActivityArray.count > 0{
            self.totalItemCountLabel.text = "Total".localized() + ": \(self.notificationItemCausesViewModel.totalActivityArray.count)"
            self.totalItemTableView.reloadData()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            self.noDataView.isHidden = false
            self.nodataLabel.text = "Item_Activity_Not_Available".localized()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleActivityDataUI(){
        mJCLogger.log("Starting", Type: "info")
        self.totalItemDescriptionTableView.dataSource = self
        self.totalItemDescriptionTableView.delegate = self
        self.totalItemDescriptionTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationTasksDataUI(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.totalTaskArray.count > 0 {
            self.totalItemCountLabel.text = "Total".localized() + ": \(self.notificationItemCausesViewModel.totalTaskArray.count)"
            self.totalItemTableView.reloadData()
        }else{
            self.noDataView.isHidden = false
            self.nodataLabel.text = "Item_Tasks_Not_Available".localized()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleTaskDataUI(){
        
        mJCLogger.log("Starting", Type: "info")
        self.totalItemDescriptionTableView.dataSource = self
        self.totalItemDescriptionTableView.delegate = self
        self.totalItemDescriptionTableView.reloadData()
        if self.notificationItemCausesViewModel.singleTaskArray.count > 0{
            self.selectedTaskObjRef = self.notificationItemCausesViewModel.singleTaskArray[0]
            if !self.itemTaskAttachmentsView.isHidden {
                self.itemTaskAttachmentsButtonAction(self.itemTaskAttachmentsButton)
            }
            self.getAllowedTaskStatus(status: self.selectedTaskObjRef.MobileStatus)
            self.createBatchRequestForAttachmentCount()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createBatchRequestForAttachmentCount(){
        
        mJCLogger.log("Starting", Type: "info")
        let NoUploadList =  "\(uploadNOAttachmentContentSet)?$filter=(Notification eq '\(selectedNotificationNumber)' and Item eq '\(selectedItem)' and Task eq '\(selectedTaskObjRef.Task)' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        let objectKey = "\(selectedNotificationNumber)\(selectedItem)\(selectedTaskObjRef.Task)"
        let NoAttachList = "NOAttachmentSet?$filter=(endswith(ObjectKey, '" + objectKey + "') eq true)&$orderby=DocCount"
        let batchArr = NSMutableArray()
        batchArr.add(NoUploadList)
        batchArr.add(NoAttachList)
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
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == uploadNOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                            if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                NoUploadAttachmentArr = uploadattacharray
                            }
                        }else if resourcePath == "NOAttachmentSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                if(Noattacharray.count > 0) {
                                    NoAttachmentArr = Noattacharray
                                }
                            }
                        }
                    }
                    let count = NoAttachmentArr.count + NoUploadAttachmentArr.count
                    self.updateTaskAttachment(count: count)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateTaskAttachment(count: Int) {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if count != 0{
                attchmentCount = "\(count)"
            }else{
                attchmentCount = ""
            }
            if DeviceType == iPad{
                if count != 0{
                    self.itemTaskAttachmentsCountLabel.text = "\(count)"
                    self.itemTaskAttachmentsCountLabel.isHidden = false
                    
                }else{
                    self.itemTaskAttachmentsCountLabel.isHidden = true
                    self.itemTaskAttachmentsCountLabel.text = ""
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationItemsCausesDataUI(){
        
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.totalItemArray.count > 0{
            self.totalItemCountLabel.text = "Total".localized() + ": \(self.notificationItemCausesViewModel.totalItemArray.count)"
            self.totalItemTableView.reloadData()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            self.nodataLabel.text = "Item_Causes_Not_Available".localized()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func taskAttachmentButtonAction(_ sender: UIButton) {}
    @IBAction func itemTaskOverviewButtonAction(_ sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        itemTaskAttachmentsView.isHidden = true
        itemTaskAttachmentsTabView.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        itemTaskAttachmentsColorLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        itemTaskOverviewColorLabel.backgroundColor = appColor
        itemTaskOverviewTabView.layer.borderColor = UIColor.lightGray.cgColor
        itemTaskOverviewTabView.layer.borderWidth = 1
        ODSUIHelper.setViewLayout(view: itemTaskOverviewTabView, shadowColor: .lightGray, shadowOffSet: CGSize(width: 0.0, height: 2), opacity: 2.0, radius: 1)
        itemTaskAttachmentsTabView.layer.borderColor = UIColor.white.cgColor
        itemTaskAttachmentsTabView.layer.borderWidth = 0
        itemTaskOverviewTabView.backgroundColor = .white
        self.cameraButton.isHidden = true
        self.galleryButton.isHidden = true
        self.videoBtn.isHidden = true
        self.documentButton.isHidden = true
        self.urlButton.isHidden = true
        self.createItemActivity.isHidden = false
        self.editItemActivityButton.isHidden = false
        self.notesBtn.isHidden = false
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemTaskAttachmentsButtonAction(_ sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        itemTaskAttachmentsView.isHidden = false
        itemTaskOverviewTabView.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        itemTaskOverviewColorLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        itemTaskAttachmentsColorLabel.backgroundColor = appColor
        itemTaskAttachmentsTabView.layer.borderColor = UIColor.lightGray.cgColor
        itemTaskAttachmentsTabView.layer.borderWidth = 1
        ODSUIHelper.setViewLayout(view: itemTaskAttachmentsTabView, shadowColor: .lightGray, shadowOffSet: CGSize(width: 0.0, height: 2), opacity: 2.0, radius: 1)
        itemTaskOverviewTabView.layer.borderWidth = 0
        itemTaskOverviewTabView.layer.borderColor = UIColor.white.cgColor
        itemTaskAttachmentsTabView.backgroundColor = .white
        for view in itemTaskAttachmentsView.subviews{
            view.removeFromSuperview()
        }
        self.noAttachmentsVC = ScreenManager.getNotificationAttachmentScreen()
        addChild(self.noAttachmentsVC!)
        noAttachmentsVC!.objectNum = selectedNotificationNumber
        self.noAttachmentsVC!.fromScreen = "NOTIFICATIONTASK"
        self.noAttachmentsVC!.attachDelegate = self
        self.noAttachmentsVC!.itemNum = selectedItem
        self.noAttachmentsVC!.taskNum = selectedTaskObjRef.Task
        self.noAttachmentsVC!.notificationFrom = notificationFrom
        self.noAttachmentsVC!.selectedTaskObjRef = selectedTaskObjRef
        self.noAttachmentsVC!.view.frame = CGRect(x: 0, y: 0, width: itemTaskAttachmentsView.frame.size.width, height: itemTaskAttachmentsView.frame.size.height)
        itemTaskAttachmentsView.addSubview(self.noAttachmentsVC!.view)
        self.noAttachmentsVC!.didMove(toParent: self)
        self.cameraButton.isHidden = false
        self.galleryButton.isHidden = false
        self.videoBtn.isHidden = false
        self.documentButton.isHidden = true
        self.urlButton.isHidden = false
        self.createItemActivity.isHidden = true
        self.editItemActivityButton.isHidden = true
        self.notesBtn.isHidden = true
        mJCLogger.log("Ended", Type: "info")
    }
    // Collection View Methods
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statusArray.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCollectionCell", for: indexPath as IndexPath) as! StatusCollectionCell
        cell.indexpath = indexPath
        cell.tintColor = .white
        cell.statusTitle.textColor = .white
        cell.notificationItemCausesViewRef = self.notificationItemCausesViewModel
        if self.notificationItemCausesViewModel.singleTaskArray.count > 0{
            cell.notificatonItemTaskClass = self.notificationItemCausesViewModel.singleTaskArray[0]
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        mJCLogger.log("Starting", Type: "info")
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
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 50, height: 50)
    }
    //...END...//
}
