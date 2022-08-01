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
    @IBOutlet var iPhoneHeader: UIView!
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
            self.iPhoneHeader.addSubview(navHeaderView)
            if flushStatus == true{
                navHeaderView.refreshBtn.showSpin()
            }
            navHeaderView.delegate = self
        }else{
            setAppfeature()
            self.headerLabel.text = "\(titleString)"
        }
        self.setBasicView()
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
            ODSUIHelper.setCircleButtonLayout(button: self.addNewFormButton)
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
            var fromScrn = String()
            if isFrom == "Supervisor" {
                fromScrn = "Supervisor"
            }else{
                fromScrn = ""
            }
            menuDataModel.uniqueInstance.presentCheckSheetViewerScreen(vc: self, isFromScrn: fromScrn, isFromEdit: true, delegateVC: self, formResponseCaptureCls: formResponseCaptureClass, formCls: self.selectedCheckSheet)
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
            menuDataModel.uniqueInstance.presentCheckSheetViewerScreen(vc: self, isFromScrn: isFrom, delegateVC: self, formCls: self.selectedCheckSheet)
        }else{
            if self.selectedCheckSheet.MultipleSub == "X" && Int(self.selectedCheckSheet.Occur) ?? 0 == 0{
                menuDataModel.uniqueInstance.presentCheckSheetViewerScreen(vc: self, delegateVC: self, formCls: self.selectedCheckSheet)
            }else if self.selectedCheckSheet.MultipleSub == "X" {
                if self.selectedCheckSheet.filledFormCount == Int(self.selectedCheckSheet.Occur) ?? 0 {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_already_reached_the_maximum_submissions_possible".localized(), button: okay)
                }else {
                    menuDataModel.uniqueInstance.presentCheckSheetViewerScreen(vc: self, delegateVC: self, formCls: self.selectedCheckSheet)
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
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
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
    @IBAction func loationButtonAction(sender: AnyObject) {
        menuDataModel.uniqueInstance.presentMapSplitScreen()
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
        menuDataModel.uniqueInstance.presentMenu(menuArr: menuarr, imgArr: imgArray, sender: sender, vc: self)
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
