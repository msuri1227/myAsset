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
    @IBOutlet var iPhoneHeader: UIView!
    
    //MARK:- Declared Variable..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var calendarManager = JTCalendarManager()
    var dateSelected = Date()
    var eventsByDate = [NSObject : AnyObject]()
    let previosDayView = JTCalendarDayView()
    var timeSheetDictionary = NSMutableDictionary()
    var totalHours = Float()
    var isfromSupervisor = Bool()
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
        ODSUIHelper.setCircleButtonLayout(button: self.addtimeSheetButton)
        
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
            setAppfeature()
        }else{
            if isfromSupervisor == false{
                let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Time_Sheet".localized(), NewJobButton: true,  refresButton: true, threedotmenu: false, leftMenuType: "")
                self.iPhoneHeader.addSubview(view)
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
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Work_Orders".localized(),"Notifications".localized(),"Job_Location".localized(),"Supervisor_View".localized(),"Team".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }else{
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Work_Orders".localized(),"Notifications".localized(),"Job_Location".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
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
        menuDataModel.uniqueInstance.presentMenu(menuArr: menuarr, imgArr: imgArray, sender: sender, vc: self)
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
        menuDataModel.uniqueInstance.presentMapSplitScreen()
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
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
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    
    //MARK:- Footer Button Action
    @IBAction func addtimeSheetButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_TIME", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateTimeSheetScreen(vc: self, isFromScrn: "AddTimeSheet", delegateVC: self)
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
 
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Work_Orders".localized() {
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "Main")
        }else if title == "Notifications".localized(){
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "Main")
        }else if title == "Job_Location".localized(){
            ASSETMAP_TYPE = ""
            currentMasterView = "MapSplitViewController"
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            let mainViewController = ScreenManager.getMapDeatilsScreen()
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "Main")
        }else if title == "Supervisor_View".localized(){
            let mainViewController = ScreenManager.getSupervisorMasterListScreen()
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "Main")
        }else if title == "Team".localized(){
            currentMasterView = "Team"
            let mainViewController = ScreenManager.getTeamMasterScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "Main")
        }else if title == "Asset_Map".localized(){
            if DeviceType == iPad{
               assetmapVC.openmappage(id: "")
            }else{
                currentMasterView = "WorkOrder"
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                self.present(assetMapDeatilsVC, animated: true, completion: nil)
            }
        }else if title == "Settings".localized(){
            menuDataModel.uniqueInstance.presentSettingsScreen(vc: self)
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
