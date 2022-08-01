//
//  NotificationTaskVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/9/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotificationTaskVC: UIViewController,UITableViewDataSource,UITableViewDelegate,CustomNavigationBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,taskAttachmentDelegate, CreateUpdateDelegate {

    //MARK:- Outlets..
    @IBOutlet var totalTaskaTableViewHolderView: UIView!
    @IBOutlet var totalTaskLabelHolderView: UIView!
    @IBOutlet var totalTaskCountLabel: UILabel!
    @IBOutlet var totalTaskTableView: UITableView!
    @IBOutlet var totalTaskDescriptionTableView: UITableView!
    @IBOutlet var editTaskButton: UIButton!
    @IBOutlet var createNewTaskButton: UIButton!
    @IBOutlet weak var taskNotesBtn: UIButton!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var galleryButton: UIButton!
    @IBOutlet var videoBtn: UIButton!
    @IBOutlet var documentButton: UIButton!
    @IBOutlet var urlButton: UIButton!
    @IBOutlet weak var taskAttachmentButton: UIButton!
    @IBOutlet weak var totalcountView: UIView!
    @IBOutlet var noDataLAbel: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var lastSyncLabel: UILabel!
    @IBOutlet weak var taskAttachmentsView: UIView!
    @IBOutlet weak var taskOverviewTabView: UIView!
    @IBOutlet weak var taskOverviewButton: UIButton!
    @IBOutlet weak var taskOverviewColorLabel: UILabel!
    @IBOutlet weak var taskAttachmentsButton: UIButton!
    @IBOutlet weak var taskAttachmentsColorLabel: UILabel!
    @IBOutlet weak var taskAttachmentsTabView: UIView!
    @IBOutlet weak var taskAttachmentsCountLabel: UILabel!
    //MARK:- Declared Variables..
    
    var isfromscreen = String()
    var itemNum = String()
    var notificationFrom = String()
    var notificationTaskVC : NotificationTaskVC?
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var statusArray = NSMutableArray()
    var allowedStatusArray = NSMutableArray()
    var statusArr = Array<StatusCategoryModel>()
    var validateCond: Bool = false
    var selectedTaskObjRef = NotificationTaskModel()
    var noAttachmentsVC : NotificationAttachmentVC?
    var notificationTaskViewModel = NotificationTaskViewModel()
    var taskOverView = false
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        notificationTaskViewModel.vc = self
        statusCollectionView.dataSource = self
        statusCollectionView.delegate = self
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"TaskStatusUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationTaskVC.StatusUpdated(notification:)), name:NSNotification.Name(rawValue:"TaskStatusUpdated"), object: nil)
        self.statusCollectionView.backgroundColor = appColor
        if DeviceType == iPad{
            if isSingleNotification == true {
                self.createNewTaskButton.isHidden = true
                self.editTaskButton.isHidden = true
            }
            self.taskAttachmentsCountLabel.layer.cornerRadius = self.taskAttachmentsCountLabel.frame.size.height/2
            self.taskAttachmentsCountLabel.layer.masksToBounds = true
            self.taskAttachmentsCountLabel.backgroundColor = appColor
            self.taskAttachmentsCountLabel.textColor = UIColor.white
            ODSUIHelper.setCircleButtonLayout(button: self.createNewTaskButton, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.editTaskButton, cornerRadius: self.editTaskButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.taskNotesBtn, cornerRadius: self.taskNotesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.cameraButton, cornerRadius: self.cameraButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.galleryButton, cornerRadius: self.galleryButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.videoBtn, cornerRadius: self.videoBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.documentButton, cornerRadius: self.documentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.urlButton, cornerRadius: self.urlButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            totalTaskTableView.dataSource = self
            totalTaskTableView.delegate = self
            totalTaskTableView.separatorStyle = .none
            totalTaskTableView.estimatedRowHeight = 80
            NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
            self.objectSelected()
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationTaskVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        }else{
            notificationTaskViewModel.getSingleTaskData()
            ODSUIHelper.setButtonLayout(button: self.taskNotesBtn, cornerRadius: self.taskNotesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            setAppfeatureForStatusDisplay()
        }
        notificationTaskViewModel.didSelectedCell = 0
        notificationTaskViewModel.did_DeSelectedCell = 0
        notificationTaskViewModel.singleTaskArray.removeAll()
        notificationTaskViewModel.totalTaskArray.removeAll()
        totalTaskDescriptionTableView.dataSource = self
        totalTaskDescriptionTableView.delegate = self
        totalTaskDescriptionTableView.separatorStyle = .none
        totalTaskDescriptionTableView.estimatedRowHeight = 130
        ScreenManager.registerNotificationTaskOverViewCell(tableView: self.totalTaskDescriptionTableView)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            if currentsubView == "Overview".localized(){
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            }
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        setAppfeatureForStatusDisplay()
        if DeviceType == iPad {
            taskAttachmentsView.isHidden = true
            taskOverviewTabView.backgroundColor = .white
            taskOverviewColorLabel.backgroundColor = appColor
            taskOverviewTabView.layer.borderColor = UIColor.lightGray.cgColor
            taskOverviewTabView.layer.borderWidth = 1
            ODSUIHelper.setViewLayout(view: taskOverviewTabView, shadowColor: .lightGray, shadowOffSet: CGSize(width: 0.0, height: 2), opacity: 2.0, radius: 1)
            taskAttachmentsTabView.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            taskAttachmentsColorLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            self.cameraButton.isHidden = true
            self.galleryButton.isHidden = true
            self.videoBtn.isHidden = true
            self.documentButton.isHidden = true
            self.urlButton.isHidden = true
            self.setAppfeature()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        notificationTaskViewModel.getNotificationTasksData()
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        notificationTaskViewModel.getNotificationTasksData()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func StatusUpdated(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        notificationTaskViewModel.getNotificationTasksData()
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
        if  DeviceType == iPhone {
            statusView.isHidden = false
        }
        self.addImagesForStatusArrays(statArray:arr)

        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeatureForStatusDisplay(){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder" {
            if isfromscreen == "ItemTasks" {
                if applicationFeatureArrayKeys.contains("WO_NO_ITEM_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
            }else{
                if applicationFeatureArrayKeys.contains("WO_NO_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
            }
        }else{
            if isfromscreen == "ItemTasks" {
                if applicationFeatureArrayKeys.contains("NO_ITEM_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
            }else{
                if applicationFeatureArrayKeys.contains("NO_TASK_STATUS"){
                    statusView.isHidden = false
                }else{
                    statusView.isHidden = true
                }
            }
        }
        if notificationTaskViewModel.totalTaskArray.count == 0{
            statusView.isHidden = true
        }
        
        if isfromscreen == "ItemCause" || isfromscreen == "ItemActivity" {
            statusView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
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
    func createBatchRequestForAttachmentCount(){
        mJCLogger.log("Starting", Type: "info")
        if itemNum == ""{
            itemNum = "0000"
        }
        let NoUploadList =  "\(uploadNOAttachmentContentSet)?$filter=(Notification eq '\(selectedNotificationNumber)' and Item eq '\(itemNum)' and Task eq '\(selectedTaskObjRef.Task)' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        let objectKey = "\(selectedNotificationNumber)\(itemNum)\(selectedTaskObjRef.Task)"
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
                                mJCLogger.log("Response:\(uploadattacharray.count)", Type: "Debug")
                                NoUploadAttachmentArr = uploadattacharray
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else if resourcePath == "NOAttachmentSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                if(Noattacharray.count > 0) {
                                    mJCLogger.log("Response:\(Noattacharray.count)", Type: "Debug")
                                    NoAttachmentArr = Noattacharray
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }
                    }
                    let count = NoAttachmentArr.count + NoUploadAttachmentArr.count
                    self.updateTaskAttachment(count: count)
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated(){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder"{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"setSingleNotificationTaskCount"), object: "")
        }else{
            NotificationCenter.default.post(name:Notification.Name(rawValue: "setNotificationTaskCount"), object: "")
        }
        DispatchQueue.main.async {
            self.noDataLAbel.isHidden = true
            self.statusView.isHidden = false
            self.notificationTaskViewModel.getNotificationTasksData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- UITableView Delegates And DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == totalTaskTableView){
            return notificationTaskViewModel.totalTaskArray.count
        }else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalTaskTableView) {
            let notificationActivityCell = tableView.dequeueReusableCell(withIdentifier: "NotificationActivityCell") as! NotificationActivityCell
            mJCLogger.log("Response:\(notificationTaskViewModel.totalTaskArray.count)", Type: "Debug")
            notificationActivityCell.indexPath = indexPath
            notificationActivityCell.notificationTaskViewModel = self.notificationTaskViewModel
            notificationActivityCell.NotificationTaskModel = notificationTaskViewModel.totalTaskArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return notificationActivityCell
        }else {
            if notificationTaskViewModel.singleTaskArray.count > 0{
                let notificationTaskOverViewCell = ScreenManager.getNotificationTaskOverViewCell(tableView: tableView)
                mJCLogger.log("Response:\(notificationTaskViewModel.singleTaskArray[0])", Type: "Debug")
                notificationTaskOverViewCell.indexPath = indexPath
                notificationTaskOverViewCell.notificationTaskViewModel = self.notificationTaskViewModel
                notificationTaskOverViewCell.NotificationTaskModel = notificationTaskViewModel.singleTaskArray[0]
                mJCLogger.log("Ended", Type: "info")
                return notificationTaskOverViewCell
            }else {
                let notificationTaskOverViewCell = ScreenManager.getNotificationTaskOverViewCell(tableView: tableView)
                mJCLogger.log("Ended", Type: "info")
                return notificationTaskOverViewCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == totalTaskTableView {
            return UITableView.automaticDimension
        }else {
            if DeviceType == iPad{
                return UITableView.automaticDimension
            }else{
                return 660
            }
        }
    }
    //MARK:- Button Action..
    @IBAction func editTaskButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_NO_TASK", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("editTaskButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    }else if notificationTaskViewModel.singleTaskArray.count == 0{
                        mJCLogger.log("No_Task_Available".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Task_Available".localized(), button: okay)
                    }else{
                        if  isfromscreen == "Tasks"{
                            isItemTask = false
                        }else{
                            isItemTask = true
                        }
                        menuDataModel.presentCreateTaskScreen(vc: self, isFromEdit: true, delegateVC: self, taskCls: notificationTaskViewModel.singleTaskArray[0], itemNum: itemNum)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
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
    @IBAction func createNewTaskButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO_TASK", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("createNewTaskButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    }else {
                        let count = "\(notificationTaskViewModel.totalTaskArray.count+1)"
                        menuDataModel.presentCreateTaskScreen(vc: self, delegateVC: self, sortCount: count, fromWo: notificationFrom)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
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
    @IBAction func taskNotesBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let noteListVC = ScreenManager.getLongTextListScreen()
        noteListVC.fromScreen = "noTask"
        if isActiveNotification == true{
            noteListVC.isAddNewNote = true
        }else{
            noteListVC.isAddNewNote = false
        }
        noteListVC.taskNum = selectedTaskObjRef.Task
        noteListVC.modalPresentationStyle = .fullScreen
        self.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cameraBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            self.noAttachmentsVC?.takePhotoButtonAction(sender: UIButton())
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func galleryBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            self.noAttachmentsVC?.openGalleryButtonAction(sender: UIButton())
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func videoBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            self.noAttachmentsVC?.takeVideoButtonAction(sender: UIButton())
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func documentBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            self.noAttachmentsVC?.openFileButtonAction(sender: UIButton())
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func urlBtnAction(_ sender: Any){
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            self.noAttachmentsVC?.uploadNotifiAttachmentUrlButtonAction(UIButton())
        }else{
            mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Delegate
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
                    self.taskAttachmentsCountLabel.text = "\(count)"
                    self.taskAttachmentsCountLabel.isHidden = false
                }else{
                    self.taskAttachmentsCountLabel.isHidden = true
                    self.taskAttachmentsCountLabel.text = ""
                }
            }
        }
    }
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
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?)
    {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){}
    @IBAction func taskAttachmentButtonAction(_ sender: UIButton) {}
    func getNotificationTasksDataUI(){
        mJCLogger.log("Starting", Type: "info")
        if(notificationTaskViewModel.totalTaskArray.count > 0) {
            mJCLogger.log("Response:\(notificationTaskViewModel.totalTaskArray.count)", Type: "Debug")
            DispatchQueue.main.async {
                self.totalTaskCountLabel.text = "Total".localized() + ": \(self.notificationTaskViewModel.totalTaskArray.count)"
                self.noDataLAbel.isHidden = true
                self.statusView.isHidden = false
                self.taskNotesBtn.isHidden = false
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            DispatchQueue.main.async {
                self.noDataLAbel.isHidden = false
                self.statusView.isHidden = true
                self.taskNotesBtn.isHidden = true
            }
        }
        if DeviceType == iPad{
            DispatchQueue.main.async {
                self.totalTaskTableView.reloadData()
                self.setAppfeature()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleTaskDataUI(){
        mJCLogger.log("Starting", Type: "info")
        self.noDataLAbel.isHidden = true
        if(notificationTaskViewModel.singleTaskArray.count > 0) {
            mJCLogger.log("Response:\(notificationTaskViewModel.singleTaskArray.count)", Type: "Debug")
            DispatchQueue.main.async {
                if DeviceType == iPad{
                    self.totalTaskCountLabel.text = "Total".localized() + ": \(self.notificationTaskViewModel.totalTaskArray.count)"
                }
                self.noDataLAbel.isHidden = true
                self.statusView.isHidden = false
                self.totalTaskDescriptionTableView.isHidden = false
                self.totalTaskDescriptionTableView.reloadData()
                if self.notificationTaskViewModel.singleTaskArray.count > 0{
                    self.selectedTaskObjRef = self.notificationTaskViewModel.singleTaskArray[0]
                    if DeviceType == iPad{
                        DispatchQueue.main.async {
                            if !self.taskAttachmentsView.isHidden {
                                self.taskAttachmentsButtonAction(self.taskAttachmentsButton)
                            }
                        }
                    }
                    self.getAllowedTaskStatus(status: self.selectedTaskObjRef.MobileStatus)
                    self.createBatchRequestForAttachmentCount()
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            DispatchQueue.main.async {
                self.totalTaskDescriptionTableView.isHidden = true
                self.noDataLAbel.isHidden = false
                self.statusView.isHidden = true
            }
        }
        if DeviceType == iPad{
            DispatchQueue.main.async {
                self.totalTaskTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("NO_EDIT_TASK_OPTION") && self.noDataLAbel.isHidden == true{
            self.editTaskButton.isHidden = false
        }else{
            self.editTaskButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_ADD_TASK_OPTION") {
            self.createNewTaskButton.isHidden = false
        }else{
            self.createNewTaskButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func taskOverviewButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        taskAttachmentsView.isHidden = true
        taskOverviewColorLabel.backgroundColor = appColor
        taskOverviewTabView.backgroundColor = .white
        taskOverviewTabView.layer.borderColor = UIColor.lightGray.cgColor
        taskOverviewTabView.layer.borderWidth = 1
        ODSUIHelper.setViewLayout(view: taskOverviewTabView, shadowColor: .lightGray, shadowOffSet: CGSize(width: 0.0, height: 2), opacity: 2.0, radius: 1)
        taskAttachmentsTabView.layer.borderColor = UIColor.white.cgColor
        taskAttachmentsTabView.layer.borderWidth = 0
        taskAttachmentsTabView.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        taskAttachmentsColorLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        self.cameraButton.isHidden = true
        self.galleryButton.isHidden = true
        self.videoBtn.isHidden = true
        self.documentButton.isHidden = true
        self.urlButton.isHidden = true
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func taskAttachmentsButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        taskAttachmentsView.isHidden = false
        taskAttachmentsTabView.backgroundColor = .white
        taskAttachmentsColorLabel.backgroundColor = appColor
        taskAttachmentsTabView.layer.borderColor = UIColor.lightGray.cgColor
        taskAttachmentsTabView.layer.borderWidth = 1
        ODSUIHelper.setViewLayout(view: taskAttachmentsTabView, shadowColor: .lightGray, shadowOffSet: CGSize(width: 0.0, height: 2), opacity: 2.0, radius: 1)
        taskOverviewTabView.layer.borderWidth = 0
        taskOverviewTabView.layer.borderColor = UIColor.white.cgColor
        taskOverviewTabView.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        taskOverviewColorLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        for view in taskAttachmentsView.subviews{
            view.removeFromSuperview()
        }
        self.noAttachmentsVC = ScreenManager.getNotificationAttachmentScreen()
        addChild(noAttachmentsVC!)
        noAttachmentsVC!.objectNum = selectedNotificationNumber
        noAttachmentsVC!.fromScreen = "NOTIFICATIONTASK"
        noAttachmentsVC!.attachDelegate = self
        noAttachmentsVC!.itemNum = itemNum
        noAttachmentsVC!.notificationFrom = notificationFrom
        noAttachmentsVC!.selectedTaskObjRef = selectedTaskObjRef
        noAttachmentsVC!.taskNum = selectedTaskObjRef.Task
        noAttachmentsVC!.view.frame = CGRect(x: 0, y: 0, width: taskAttachmentsView.frame.size.width, height: taskAttachmentsView.frame.size.height)
        taskAttachmentsView.addSubview(noAttachmentsVC!.view)
        noAttachmentsVC?.didMove(toParent: self)
        self.cameraButton.isHidden = false
        self.galleryButton.isHidden = false
        self.videoBtn.isHidden = false
        self.documentButton.isHidden = true
        self.urlButton.isHidden = false
        self.createNewTaskButton.isHidden = true
        self.editTaskButton.isHidden = true
        self.taskNotesBtn.isHidden = false
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
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: validClass.StatusCode, orderType: "X",from: NotificationTaskLevel)
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                screen = workFlowObj.ActionKey
                workflowObject = workFlowObj.ActionType
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
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
        cell.notificationTaskViewModelRef = self.notificationTaskViewModel
        if self.notificationTaskViewModel.singleTaskArray.count > 0{
            cell.notificatonTaskClass = self.notificationTaskViewModel.singleTaskArray[0]
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
    //...End...///
}
