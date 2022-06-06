//
//  TimeSheetVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/31/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class TimeSheetVC: UIViewController,JTCalendarDelegate,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate,timeSheetDelegate {
    
    //MARK:- HeaderView Outlets..
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var addNewJobButton: UIButton!
    @IBOutlet var mainDetailView: UIView!
    @IBOutlet var HomeButton: UIButton!
    @IBOutlet var timeSheetTableView: UITableView!
    @IBOutlet var addtimeSheetButton: UIButton!
    @IBOutlet var totalEntriesLabel: UILabel!
    @IBOutlet var totalHoursLabel: UILabel!
    @IBOutlet var actionLabel: UILabel!
    @IBOutlet var calenderHolderView: UIView!
    @IBOutlet var calendarMenuView: JTCalendarMenuView!
    @IBOutlet var calendarContentView: JTHorizontalCalendarView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK:- Declared Variable..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var calendarManager = JTCalendarManager()
    var dateSelected = Date()
    var eventsByDate = [NSObject : AnyObject]()
    let previosDayView = JTCalendarDayView()
    var timeSheetDictionary = NSMutableDictionary()
    var totalHours = Float()
    var isfromSupervisor = Bool()
    let menudropDown = DropDown()
    var dropDownString = String()
    var timeSheetViewModel = TimeSheetViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.dateSelected = Date()
        timeSheetViewModel.vc = self
        timeSheetViewModel.timeSheetArray.removeAll()
        self.timeSheetDictionary.removeAllObjects()
        self.getTimeSheetData()
        self.addtimeSheetButton.layer.cornerRadius = self.addtimeSheetButton.frame.height / 2
        self.addtimeSheetButton.layer.masksToBounds = true
        
        if DeviceType == iPad{
            self.calendarManager = JTCalendarManager()
            self.calendarManager.delegate = self
            self.calendarMenuView.contentRatio = 0.75
            self.calendarManager.settings.weekDayFormat = .single
            self.calendarManager.dateHelper.calendar()
            calendarManager.menuView = calendarMenuView
            calendarManager.contentView = calendarContentView

            calendarManager.contentView.backgroundColor = appColor
            calendarManager.menuView.backgroundColor = appColor
            calendarManager.setDate(NSDate() as Date?)
            calendarContentView.isScrollEnabled = false
            calendarMenuView.scrollView.isScrollEnabled = false
            menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                if self.dropDownString == "Menu" {
                    if item == "Work_Orders".localized(){
                        DispatchQueue.main.async {
                            selectedworkOrderNumber = ""
                            selectedNotificationNumber = ""
                            currentMasterView = "WorkOrder"
                            UserDefaults.standard.removeObject(forKey: "ListFilter")
                            let splitVC = ScreenManager.getListSplitScreen()
                            self.appDeli.window?.rootViewController = splitVC
                            self.appDeli.window?.makeKeyAndVisible()
                        }
                    }else if item == "Notifications".localized(){
                        DispatchQueue.main.async {
                            selectedworkOrderNumber = ""
                            selectedNotificationNumber = ""
                            currentMasterView = "Notification"
                            UserDefaults.standard.removeObject(forKey: "ListFilter")
                            let splitVC = ScreenManager.getListSplitScreen()
                            self.appDeli.window?.rootViewController = splitVC
                            self.appDeli.window?.makeKeyAndVisible()
                        }
                    }else if item == "Master_Data_Refresh".localized(){
                        mJCLoader.startAnimating(status: "Uploading".localized())
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                        })
                    }else if item == "Asset_Map".localized() {
                        ASSETMAP_TYPE = "ESRIMAP"
                       assetmapVC.openmappage(id: "")
                    }else if item == "Settings".localized() {
                        let settingsVC = ScreenManager.getSettingsScreen()
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: false, completion: nil)
                        
                    }else if item == "Log_Out".localized(){
                        myAssetDataManager.uniqueInstance.logOutApp()
                    }else if item == "Error_Logs".localized() {
                        myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
                    }
                }
            }
            setAppfeature()
        }else{
            if isfromSupervisor == false{
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Time_Sheet".localized(), NewJobButton: true,  refresButton: true, threedotmenu: false, leftMenuType: "")
                self.view.addSubview(view)
                if flushStatus == true{
                    view.refreshBtn.showSpin()
                }
                view.delegate = self
                self.updateSlideMenu()
            }
            dateLabel.text = "Timesheets_of:".localized() +  "\(Date().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))"
        }
        self.timeSheetTableView.bounces = false
        self.timeSheetTableView.delegate = self
        self.timeSheetTableView.dataSource = self
        self.timeSheetTableView.estimatedRowHeight = 140.0
        self.timeSheetTableView.separatorStyle = .none
        ScreenManager.registerTimeSheetsCell(tableView: self.timeSheetTableView)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimeSheetVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimeSheetVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone {
            self.updateSlideMenu()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func timeSheetAdded(statusCategoryCls: StatusCategoryModel) {
        mJCLogger.log("Starting", Type: "info")
        self.getTimeSheetData()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone {
            if isfromSupervisor == false{
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Time_Sheet".localized(), NewJobButton: true, refresButton: true, threedotmenu: false, leftMenuType: "")
                self.view.addSubview(view)
                if flushStatus == true{
                    view.refreshBtn.showSpin()
                }
                view.delegate = self
            }
            self.updateSlideMenu()
        }else{
            if flushStatus == true{
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("TIMESHEET_ADD_TIMESHEET_OPTION"){
            addtimeSheetButton.isHidden = false
        }else{
            addtimeSheetButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "TimeSheet"
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        if isSupervisor == "X"{
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Notifications".localized(),"Job_Location".localized(),"Supervisor_View".localized(),"Team".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }else{
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Notifications".localized(),"Job_Location".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Asset_Map".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_LIST_MAP_NAV"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Job_Location".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Flush Notification..
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        self.getTimeSheetData()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeSheetViewModel.timeSheetArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let timeSheetsCell = ScreenManager.getTimeSheetsCell(tableView: tableView)
        if applicationFeatureArrayKeys.contains("TIMESHEET_EDIT_TIMESHEET_OPTION"){
            timeSheetsCell.timeSheetEditButton.isHidden = false
        }else{
            timeSheetsCell.timeSheetEditButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("TIMESHEET_DEL_TIMESHEET_OPTION"){
            timeSheetsCell.timeSheetDeleteButton.isHidden = false
        }else{
            timeSheetsCell.timeSheetDeleteButton.isHidden = true
        }
        if timeSheetViewModel.timeSheetArray.count > 0{
            let timeSheetClass = timeSheetViewModel.timeSheetArray[indexPath.row]
            timeSheetsCell.indexPath = indexPath as NSIndexPath
            timeSheetsCell.timeSheetVCModel = timeSheetViewModel
            timeSheetsCell.timesheetClass = timeSheetClass
        }
        mJCLogger.log("Ended", Type: "info")
        return timeSheetsCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        if timeSheetViewModel.timeSheetArray.count > 0{
            let timeSheetClass = timeSheetViewModel.timeSheetArray[indexPath.row]
            if DeviceType == iPad{
                if timeSheetClass.isExpand == true {
                    mJCLogger.log("Ended", Type: "info")
                    if  ENABLE_CAPTURE_DURATION == false{
                        return 160.0
                    }else{
                        return 185.0
                    }
                }else {
                    mJCLogger.log("Ended", Type: "info")
                    return 105.0
                }
            }else{
                if timeSheetClass.isExpand == true {
                    if  ENABLE_CAPTURE_DURATION == false{
                        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3" {
                            return 240
                        }else{
                            return 200
                        }
                    }else{
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            return 240
                        }else{
                            return 280
                        }
                    }
                }else {
                    mJCLogger.log("Ended", Type: "info")
                    return 140.0
                }
            }
        }else{
            mJCLogger.log("Ended", Type: "info")
            return 0.0
        }
    }
    //MARK:- HederView Button Action..
    @IBAction func menuButtonAction(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Menu Button Tapped".localized(), Type: "")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        var actionType = ""
        if isSupervisor == "X"{
            menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Error_Logs".localized(), "Settings".localized(), "Log_Out".localized()]
           imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
            
        }else{
            menuarr = ["Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Error_Logs".localized(), "Settings".localized(), "Log_Out".localized()]
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
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_POPUP_TIME", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            actionType =  workFlowObj.ActionType
            if actionType == "Screen" {
                menudropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
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
    @IBAction func locationButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "MapSplitViewController"
        selectedworkOrderNumber = ""
        ASSETMAP_TYPE = ""
        let mapSplitVC = ScreenManager.getMapSplitScreen()
        self.appDeli.window?.rootViewController = mapSplitVC
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let createNewJobVC = ScreenManager.getCreateJobScreen()
                createNewJobVC.isFromEdit = false
                createNewJobVC.isScreen = "WorkOrder"
                createNewJobVC.modalPresentationStyle = .fullScreen
                self.present(createNewJobVC, animated: false) {}
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
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
    
    //MARK:- Footer Button Action
    @IBAction func addtimeSheetButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_TIME", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
                addTimeEntryVC.screenType = "AddTimeSheet"
                addTimeEntryVC.timeSheetDelegate = self
                addTimeEntryVC.modalPresentationStyle = .fullScreen
                self.present(addTimeEntryVC, animated: false) {}
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get TimeSheet Data..
    func getTimeSheetData() {
        mJCLogger.log("Starting", Type: "info")
        timeSheetViewModel.getTimeSheetData()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- JTCalendarManager Delegate..
    //  func calendar(_ calendar: JTCalendarManager!, prepareDayView dayView: UIView!)
    func calendar(_ calendar: JTCalendarManager, prepareDayView dayView: (UIView & JTCalendarDay)){
        mJCLogger.log("Starting", Type: "info")
        let updatedDayView = dayView as! JTCalendarDayView
        updatedDayView.isHidden = false
        if updatedDayView.isFromAnotherMonth {
            updatedDayView.isHidden = true
        }else if calendarManager.dateHelper.date(dateSelected as Date?, isTheSameDayThan: updatedDayView.date!) {
            updatedDayView.circleView.isHidden = false
            updatedDayView.circleView.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
            updatedDayView.dotView.backgroundColor = UIColor.red
            updatedDayView.textLabel!.textColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        }else {
            let date1 = updatedDayView.date as NSDate
            let  compareResult =  date1.isGreaterThanDate(dateToCompare: NSDate())
            if(compareResult) {
                updatedDayView.circleView.isHidden = true
                updatedDayView.dotView.backgroundColor = UIColor.red
                updatedDayView.textLabel!.textColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
                
            }else {
                updatedDayView.circleView.isHidden = true
                updatedDayView.dotView.backgroundColor = UIColor.red
                updatedDayView.textLabel!.textColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            }
        }
        updatedDayView.dotView.isHidden = true;
        mJCLogger.log("Ended", Type: "info")
    }
    func calendar(_ calendar: JTCalendarManager, didTouchDayView dayView: (UIView & JTCalendarDay)){
        
        mJCLogger.log("Starting", Type: "info")
        let updatedDayView = dayView as! JTCalendarDayView
        self.dateSelected = updatedDayView.date!
        let components = NSCalendar.current.dateComponents([.day, .month, .year, .hour], from: self.dateSelected as Date)
        updatedDayView.circleView.transform = updatedDayView.circleView.transform.scaledBy(x: 0.1, y: 0.1)
        UIView.transition(with: dayView, duration: 0.3, options: [], animations: {() -> Void in
            updatedDayView.circleView.transform = CGAffineTransform.identity
            self.calendarManager.reload()
        }, completion: { _ in })
        self.getTimeSheetData()
        if calendarManager.settings.weekModeEnabled {
            return
        }
        if !calendarManager.dateHelper.date(calendarContentView.date!, isTheSameMonthThan: updatedDayView.date!) {
            if calendarContentView.date!.compare(updatedDayView.date!) == .orderedAscending {
                calendarContentView.loadNextPageWithAnimation()
            }else {
                calendarContentView.loadPreviousPageWithAnimation()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func calendar(_ calendar: JTCalendarManager, prepareMenuItemView menuItemView: UIView, date: Date){
        mJCLogger.log("Starting", Type: "info")
        let updatedMenuItemView = menuItemView as! UILabel
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = calendarManager.dateHelper.calendar().locale
        dateFormatter.timeZone! = calendarManager.dateHelper.calendar().timeZone
        dateFormatter.timeZone! = NSTimeZone.local
        updatedMenuItemView.text = dateFormatter.string(from: date as Date)
        mJCLogger.log("Ended", Type: "info")
    }
    func calendarBuildWeekDayView(_ calendar: JTCalendarManager) -> (UIView & JTCalendarWeekDay){
        mJCLogger.log("Starting", Type: "info")
        let view = JTCalendarWeekDayView()
        for label in view.dayViews {
            let lbl = label as! UILabel
           lbl.textColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
           lbl.font = UIFont(name: AppFontName.regular, size: 14)
        }
        mJCLogger.log("Ended", Type: "info")
        return view
    }
    func calendarBuildDayView(_ calendar: JTCalendarManager) -> (UIView & JTCalendarDay){
        mJCLogger.log("Starting", Type: "info")
        let view = JTCalendarDayView()
        view.textLabel!.font = UIFont(name: AppFontName.regular, size: 13)
        view.circleRatio = 0.8
        view.dotRatio = 1.0 / 0.9
        mJCLogger.log("Ended", Type: "info")
        return view
    }
    func dateFormatter() -> DateFormatter {
        mJCLogger.log("Starting", Type: "info")
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        mJCLogger.log("Ended", Type: "info")
        return dateFormatter
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
    @IBAction func DateButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        ODSPicker.selectDate(title: "Select_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, maxDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            let resultdate = selectedDate.dateString(localDateFormate)
            self!.dateLabel.text = "Timesheets_of:".localized + "\(resultdate)"
            let date = ODSDateHelper.getDateFromString(dateString: resultdate, dateFormat: localDateFormate)
            self!.dateSelected = date as Date
            self!.getTimeSheetData()
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func CalendarOkButtonAction(_ sender: Any) {}
    //MARK:- Custom Navigation
    @IBAction func CalendarCancelButtonAction(_ sender: Any) {}
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.addNewJobButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.refreshButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        /*mJCLogger.log("Starting", Type: "info")
        let menudropDown = DropDown()
        var menuarr = [String]()
        var imgArray = [UIImage]()
        imgArray = [#imageLiteral(resourceName: "addIcon")]
        if currentMasterView == "TimeSheet"{
            menuarr = ["Add_Timesheet".localized()]
            if !applicationFeatureArrayKeys.contains("TIMESHEET_ADD_TIMESHEET_OPTION"){
                if let index = menuarr.firstIndex(of: "Add_Timesheet".localized()){
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
            if item == "Add_Timesheet".localized(){
                self.addtimeSheetButtonAction(sender: UIButton())
            }
        }
        mJCLogger.log("Ended", Type: "info")*/
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Work_Orders".localized() {
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Notifications".localized(){
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Job_Location".localized(){
            ASSETMAP_TYPE = ""
            currentMasterView = "MapSplitViewController"
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            let mainViewController = ScreenManager.getMapDeatilsScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Asset_Map".localized(){
//            if DeviceType == iPad{
//               assetmapVC.openmappage(id: "")
//            }else{
//                currentMasterView = "WorkOrder"
//                selectedworkOrderNumber = ""
//                selectedNotificationNumber = ""
//                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//                self.present(assetMapDeatilsVC, animated: true, completion: nil)
//            }
        }else if title == "Settings".localized(){
            let settingsVC = ScreenManager.getSettingsScreen()
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }else if title == "Master_Data_Refresh".localized(){
            mJCLoader.startAnimating(status: "Uploading".localized())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
            })
        }else if title == "Log_Out".localized(){
            myAssetDataManager.uniqueInstance.logOutApp()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func backButtonClicked(_ sender: UIButton?){}
}
