//
//  NotificationActivityVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class NotificationActivityVC: UIViewController,UITableViewDataSource,UITableViewDelegate,CustomNavigationBarDelegate,CreateUpdateDelegate {
     
    //MARK:- Outlets..
    @IBOutlet var totalActivityTableViewHolderView: UIView!
    @IBOutlet var totalActivityLabelHolderView: UIView!
    @IBOutlet var totalActivityCountLabel: UILabel!
    @IBOutlet var totalActivityTableView: UITableView!
    @IBOutlet var totalActivityDescriptionTableView: UITableView!
    @IBOutlet var createNewActivityButton: UIButton!
    @IBOutlet var editActivityButton: UIButton!
    @IBOutlet var noDataLabel: UIView!
    @IBOutlet weak var activityNotesBtn: UIButton!
    @IBOutlet var iPhoneHeader: UIView!
    public var isFrom = ""
    var notificationActivityViewModel = NotificationActivityViewModel()
    var selectedItemNum = String()
    var notificationFrom = String()
    let menudropDown = DropDown()
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        notificationActivityViewModel.vc = self
        notificationActivityViewModel.didSelectedCell = 0
        notificationActivityViewModel.did_DeSelectedCell = 0
        if DeviceType == iPad{
            self.noDataLabel.isHidden = true
            ODSUIHelper.setButtonLayout(button: self.createNewActivityButton, cornerRadius: self.createNewActivityButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.editActivityButton, cornerRadius: self.editActivityButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.activityNotesBtn, cornerRadius: self.activityNotesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            totalActivityTableView.dataSource = self
            totalActivityTableView.delegate = self
            totalActivityTableView.separatorStyle = .none
            totalActivityTableView.estimatedRowHeight = 80
            NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
            self.objectSelected()
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationActivityVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            setAppfeature()
        }else{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Activity_No".localized() + " :\(notificationActivityViewModel.selectedActivity)", NewJobButton: false, refresButton: false, threedotmenu: true, leftMenuType:"Back")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            notificationActivityViewModel.did_DeSelectedCell = notificationActivityViewModel.didSelectedCell
            ODSUIHelper.setButtonLayout(button: self.activityNotesBtn, cornerRadius: self.activityNotesBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            notificationActivityViewModel.getSingleActivityData()
        }
        totalActivityDescriptionTableView.dataSource = self
        totalActivityDescriptionTableView.delegate = self
        totalActivityDescriptionTableView.separatorStyle = .none
        totalActivityDescriptionTableView.estimatedRowHeight = 500
        ScreenManager.registerNotificationActivityOverViewCell(tableView: self.totalActivityDescriptionTableView)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        notificationActivityViewModel.vc = self
        if DeviceType == iPhone{
            currentsubView = "Activities"
        }else{
            if selectedNotificationNumber == ""{
                createNewActivityButton.isHidden = true
                editActivityButton.isHidden = true
                activityNotesBtn.isHidden = true
            }
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        notificationActivityViewModel.getNotificationActivityData()
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        notificationActivityViewModel.getNotificationActivityData()
        mJCLogger.log("Ended", Type: "info")
        
    }
    func EntityCreated() {
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder"{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"setSingleNotificationActivityCount"), object: "")
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"setNotificationActivityCount"), object: "")
        }
        DispatchQueue.main.async {
            self.notificationActivityViewModel.getNotificationActivityData()
            self.noDataLabel.isHidden = true
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
        if DeviceType == iPad{
            if(tableView == totalActivityTableView){
                return notificationActivityViewModel.totalActivityArray.count
            }else {
                return 1
            }
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == totalActivityTableView) {
            let notificationActivityCell = tableView.dequeueReusableCell(withIdentifier: "NotificationActivityCell") as! NotificationActivityCell
            notificationActivityCell.indexPath = indexPath
            notificationActivityCell.notificationActivityViewModel = self.notificationActivityViewModel
            notificationActivityCell.notificationActivityModel = notificationActivityViewModel.totalActivityArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return notificationActivityCell
        }else {
            if(notificationActivityViewModel.singleActivityArray.count > 0) {
                let notificationActivityOverViewCell = ScreenManager.getNotificationActivityOverViewCell(tableView: tableView)
                notificationActivityOverViewCell.indexPath = indexPath
                notificationActivityOverViewCell.notificationActivityViewModel = self.notificationActivityViewModel
                notificationActivityOverViewCell.NotificationActivityModel = notificationActivityViewModel.singleActivityArray[0]
                mJCLogger.log("Ended", Type: "info")
                return notificationActivityOverViewCell
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK:- Button Action.
    @IBAction func createNewActivityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO_ACTIVITY", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("createNewActivityButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    }else{
                        let count = "\(notificationActivityViewModel.totalActivityArray.count+1)"
                        menuDataModel.presentCreateActivityScreen(vc: self, delegateVC: self, sortCount: count, notificationFrom: notificationFrom)
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
    @IBAction func editActivityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isActiveNotification == true{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_NO_ACTIVITY", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("editActivityButtonAction".localized(), Type: "")
                    if selectedNotificationNumber == "" {
                        mJCLogger.log("You_have_no_selected_notification".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "You_have_no_selected_notification".localized(), button: okay)
                    } else if notificationActivityViewModel.singleActivityArray.count == 0{
                        mJCLogger.log("No_activity_Available".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_activity_Available".localized(), button: okay)
                    }else {
                        menuDataModel.presentCreateActivityScreen(vc: self, isFromEdit: true, activityCls: notificationActivityViewModel.singleActivityArray[0], delegateVC: self)
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
    @IBAction func activityNotesBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let noteListVC = ScreenManager.getLongTextListScreen()
        noteListVC.fromScreen = "noActivity"
        if isActiveNotification == true{
            noteListVC.isAddNewNote = true
        }else{
            noteListVC.isAddNewNote = false
        }
        noteListVC.activityNum = notificationActivityViewModel.selectedActivity
        noteListVC.modalPresentationStyle = .fullScreen
        self.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
            currentsubView = "Items"
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
        if isFrom == "ItemActivities" {
            menuarr = ["Edit_Item_Activity".localized()]
            imgArray = [#imageLiteral(resourceName: "editIcon")]
            if !applicationFeatureArrayKeys.contains("NO_EDIT_ACTIVITY_OPTION"){
                if let index =  menuarr.firstIndex(of: "Edit_Item_Activity".localized()){
                    menuarr.remove(at: index)
                    imgArray.remove(at: index)
                }
            }
        }else{
            menuarr = ["Edit_Activity".localized()]
            imgArray = [#imageLiteral(resourceName: "editIcon")]
            if !applicationFeatureArrayKeys.contains("NO_EDIT_ACTIVITY_OPTION"){
                if let index =  menuarr.firstIndex(of: "Edit_Activity".localized()){
                    menuarr.remove(at: index)
                    imgArray.remove(at: index)
                }
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
            
            if item == "Edit_Activity".localized() {
                if isActiveNotification == true{
                    self.editActivityButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }else if item == "Edit_Item_Activity".localized() {
                if isActiveNotification == true{
                    self.editActivityButtonAction(sender: UIButton())
                }else{
                    mJCLogger.log(inactiveNotificationAlertMessage, Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: inactiveNotificationAlertTitle, message: inactiveNotificationAlertMessage, button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
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
    
    func getNotificationActivityDataUI(){
        mJCLogger.log("Starting", Type: "info")
        if(self.notificationActivityViewModel.totalActivityArray.count > 0) {
            DispatchQueue.main.async {
                self.totalActivityCountLabel.text = "Total".localized() + ": \(self.notificationActivityViewModel.totalActivityArray.count)"
                self.noDataLabel.isHidden = true
                self.activityNotesBtn.isHidden = false
                if DeviceType == iPad{
                    self.totalActivityTableView.reloadData()
                    self.setAppfeature()
                }
            }
        }else{
            DispatchQueue.main.async {
                mJCLogger.log("Data not found", Type: "Debug")
                self.noDataLabel.isHidden = false
                self.activityNotesBtn.isHidden = true
                if DeviceType == iPad{
                    self.setAppfeature()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleActivityDataUI(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.totalActivityDescriptionTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("NO_ADD_ACTIVITY_OPTION"){
            createNewActivityButton.isHidden = false
        }else{
            createNewActivityButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("NO_EDIT_ACTIVITY_OPTION") && self.noDataLabel.isHidden == true{
            editActivityButton.isHidden = false
        }else{
            editActivityButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //...END...//
}
