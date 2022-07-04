//
//  FilledCheckSheetListVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/21/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class FilledCheckSheetListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate, CreateUpdateDelegate,viewModelDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var addNewJobButton: UIButton!
    @IBOutlet var loationButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var addNewFormButton: UIButton!
    @IBOutlet var formFilledTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let menudropDown = DropDown()
    var dropDownString = String()
    var checkSheetVM = checkSheetViewModel()
    var filledCheckSheetList = Array<FormResponseCaptureModel>()
    var selectedCheckSheet = FormAssignDataModel()
    var isFrom = String()
    var navHeaderView = CustomNavHeader_iPhone()
    var createUpdateDelegate : CreateUpdateDelegate?

    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        checkSheetVM.woAssigmentType = WORKORDER_ASSIGNMENT_TYPE
        checkSheetVM.formAssignmentType = FORM_ASSIGNMENT_TYPE
        checkSheetVM.orderTypeFeatureDict = orderTypeFeatureDict
        checkSheetVM.delegate = self
        checkSheetVM.woObj = singleWorkOrder
        checkSheetVM.oprObj = singleOperation
        checkSheetVM.userID = strUser.uppercased()
        
        let titleString = "\(selectedCheckSheet.FormID.replacingOccurrences(of: "_", with: " "))"
        if DeviceType == iPhone{
            navHeaderView = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: titleString , NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"Back")
            self.view.addSubview(navHeaderView)
            if flushStatus == true{
                navHeaderView.refreshBtn.showSpin()
            }
            navHeaderView.delegate = self
        }else{
            setAppfeature()
            self.headerLabel.text = "\(titleString)"
        }
        self.setBasicView()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownString == "Menu"{
                if item == "Work_Orders".localized(){
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        currentMasterView = "WorkOrder"
                        let splitVC = ScreenManager.getListSplitScreen()
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }
                }else if item == "Notifications".localized() {
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        currentMasterView = "Notification"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
                        let splitVC = ScreenManager.getListSplitScreen()
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }
                }else if item == "Time_Sheet".localized() {
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        let timeSheetVC = ScreenManager.getTimeSheetScreen()
                        self.appDeli.window?.rootViewController = timeSheetVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }
                }else if item == "Master_Data_Refresh".localized() {
                    DispatchQueue.main.async {
                        mJCLoader.startAnimating(status: "Uploading".localized())
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                        })
                    }
                }else if item == "Asset_Map".localized(){
                    ASSETMAP_TYPE = "ESRIMAP"
                    assetmapVC.openmappage(id: "")
                }else if item == "Settings".localized() {
                    DispatchQueue.main.async {
                        let settingsVC = ScreenManager.getSettingsScreen()
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: false, completion: nil)
                    }
                }else if item == "Log_Out".localized() {
                    myAssetDataManager.uniqueInstance.logOutApp()
                }else if item == "Error_Logs".localized() {
                    myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }else if DeviceType == iPhone{
                self.navHeaderView.refreshBtn.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setAppfeature(){
        if applicationFeatureArrayKeys.contains("FORM_ADD_NEW_FORM_OPTION"){
            addNewFormButton.isHidden = false
        }else{
            addNewFormButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setBasicView(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(FilledCheckSheetListVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            self.addNewFormButton.layer.cornerRadius = self.addNewFormButton.frame.height / 2
            self.addNewFormButton.layer.masksToBounds = true
            self.formFilledTableView.separatorStyle = .none
            self.formFilledTableView.estimatedRowHeight = 150
            self.formFilledTableView.rowHeight = UITableView.automaticDimension
            ScreenManager.registerFormFilledCell(tableView: self.formFilledTableView)
            if self.isFrom == "Supervisor" {
                self.addNewFormButton.isHidden = true
            }else{
                self.addNewFormButton.isHidden = false
            }
            if self.filledCheckSheetList.count > 0{
                self.noDataLabel.isHidden = true
                self.formFilledTableView.reloadData()
            }else{
                self.noDataLabel.isHidden = false
                self.noDataLabel.text = "No_Data_Available".localized()
            }
            self.formFilledTableView.backgroundColor = UIColor.clear
            if self.formFilledTableView.contentSize.height > self.formFilledTableView.frame.height {
                self.formFilledTableView.isScrollEnabled = true
            }else {
                self.formFilledTableView.isScrollEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func deleteSavedDraftChecksheet(index:Int){
        if self.filledCheckSheetList.indices.contains(index){
            let entity = self.filledCheckSheetList[index].entity
            FormResponseCaptureModel.deleteResponseCaptureEntry(entity: entity, options: nil) { (response, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        self.filledCheckSheetList.remove(at: index)
                        self.checkSheetVM.getFilledCheckSheetList(formClass: self.selectedCheckSheet)
                    }
                }
            }
        }
    }
    func formFilledCellEditButtonAction(tagValue: Int) {
        mJCLogger.log("Starting", Type: "info")
        if self.filledCheckSheetList.indices.contains(tagValue){
            let formResponseCaptureClass = self.filledCheckSheetList[tagValue]
            let newformsVC = ScreenManager.getCheckSheetViewerScreen()
            newformsVC.formClass = self.selectedCheckSheet
            newformsVC.formResponseCaptureClass = formResponseCaptureClass
            newformsVC.isFromEditScreen = true
            newformsVC.createUpdateDelegate = self
            if isFrom == "Supervisor" {
                newformsVC.fromScreen = "Supervisor"
            }else{
                newformsVC.fromScreen = ""
            }
            newformsVC.modalPresentationStyle = .fullScreen
            self.present(newformsVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Delegate And Notification Methods
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }else{
            self.navHeaderView.refreshBtn.stopSpin()
        }
        mJCLogger.log("Store Flush And Refresh Done..".localized(), Type: "")
    }
    func EntityCreated(){
        if isFrom == "GeneralCheckList"{
            self.checkSheetVM.getFilledGeneralCheckSheetData(formClass: selectedCheckSheet)
        }else{
            self.checkSheetVM.getFilledCheckSheetList(formClass: selectedCheckSheet)
        }
    }
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "filledCheckSheetData"{
            self.filledCheckSheetList = checkSheetVM.formRespArray
            DispatchQueue.main.async {
                self.formFilledTableView.reloadData()
            }
        }else if type == "filledGeneralCheckSheetData"{
            self.filledCheckSheetList = checkSheetVM.generalFormRespArray
            DispatchQueue.main.async {
                self.formFilledTableView.reloadData()
            }
        }
    }
    //MARK: - TableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filledCheckSheetList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formFilledCell = ScreenManager.getFormFilledCell(tableView: tableView)
        formFilledCell.indexpath = indexPath
        formFilledCell.filledCSVC = self
        formFilledCell.woFormFilledModelClass = self.filledCheckSheetList[indexPath.row]
        return formFilledCell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            DispatchQueue.main.async {
                let params = Parameters(
                    title: alerttitle,
                    message: "Are_you_sure_you_want_to_delete".localized(),
                    cancelButton: "Cancel".localized(),
                    otherButtons: [okay]
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: break
                    case 1: self.deleteSavedDraftChecksheet(index: indexPath.row)
                    default: break
                    }
                }
            }
        }
        deleteAction.backgroundColor =  UIColor(red: 233.0/255.0, green: 79.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.filledCheckSheetList[indexPath.row].IsDraft == "X" && applicationFeatureArrayKeys.contains("DELETE_DRAFT_CHECKSHEET"){
            return true
        }else{
            return false
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK: - Button Action..
    @IBAction func addNewFormButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isFrom == "GeneralCheckList"{
            let newformsVC = ScreenManager.getCheckSheetViewerScreen()
            newformsVC.formClass = self.selectedCheckSheet
            newformsVC.createUpdateDelegate = self
            newformsVC.fromScreen = isFrom
            newformsVC.modalPresentationStyle = .fullScreen
            self.present(newformsVC, animated: false) {}
        }else{
            if self.selectedCheckSheet.MultipleSub == "X" && Int(self.selectedCheckSheet.Occur) ?? 0 == 0{
                let newformsVC = ScreenManager.getCheckSheetViewerScreen()
                newformsVC.formClass = self.selectedCheckSheet
                newformsVC.createUpdateDelegate = self
                newformsVC.modalPresentationStyle = .fullScreen
                self.present(newformsVC, animated: false) {}
            }else if self.selectedCheckSheet.MultipleSub == "X" {
                if self.selectedCheckSheet.filledFormCount == Int(self.selectedCheckSheet.Occur) ?? 0 {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_already_reached_the_maximum_submissions_possible".localized(), button: okay)
                }else {
                    let newformsVC = ScreenManager.getCheckSheetViewerScreen()
                    newformsVC.createUpdateDelegate = self
                    newformsVC.formClass = self.selectedCheckSheet
                    newformsVC.modalPresentationStyle = .fullScreen
                    self.present(newformsVC, animated: false) {}
                }
            }else  {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_already_reached_the_maximum_submissions_possible".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - HeaderView Button Action ..
    @IBAction func backButtonAction(sender: AnyObject) {
        self.createUpdateDelegate?.EntityCreated?()
        self.dismiss(animated: false){}
    }
    @IBAction func HomeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        singleWorkOrder = WoHeaderModel()
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
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
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func loationButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "MapSplitViewController"
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        ASSETMAP_TYPE = ""
        let mapSplitVC = ScreenManager.getMapSplitScreen()
        self.appDeli.window?.rootViewController = mapSplitVC
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func menuButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(), "Error_Logs".localized(),"Settings".localized(),"Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
        }else{
            menuarr = ["Work_Orders".localized(),"Notifications".localized(),"Master_Data_Refresh".localized(),"Asset_Map".localized(), "Error_Logs".localized(),"Settings".localized(),"Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
        }
        menudropDown.dataSource = menuarr
        self.customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender as! UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        self.dropDownString = "Menu"
        menudropDown.show()
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
    //MARK: - Custom Navigation iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        self.dismiss(animated: false, completion: nil)
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        self.addNewJobButtonAction(sender: UIButton())
    }
    func refreshButtonClicked(_ sender: UIButton?){
        self.refreshButtonAction(sender: UIButton())
    }
}
