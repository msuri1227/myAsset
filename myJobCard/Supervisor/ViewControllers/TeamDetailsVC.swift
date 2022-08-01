//
//  TeamDetailsVC.swift
//  test
//
//  Created by Rover Software on 06/06/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class TeamDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SlideMenuControllerSelectDelegate, CustomNavigationBarDelegate,TabCellDelegate,PageViewParent  {
    
    @IBOutlet var headerview: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var slideMenu: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var mainholderview: UIView!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var lastSyncLabel: UILabel!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var selectedBar: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet var iPhoneHeader: UIView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var technname = String()
    var techid = String()
    var Selectedview = String()
    var teamDetailViewModel = TeamDetailViewModel()
    public var initialIndex: Int = 0
    public var tabBackgroundColor: UIColor = UIColor(named: "mjcViewBgColor") ?? .white
    public var eachLineSpacing: CGFloat = 5
    public var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    public var selectedBarHeight: CGFloat = 5
    public var pageViewMargin: CGFloat = 1
    public lazy var pageViewController = PageViewController(transitionStyle: .scroll,
                                                            navigationOrientation: .horizontal,
                                                            options: nil)
    public var needBorder: Bool = false {
        didSet {
            borderView.isHidden = !needBorder
        }
    }
    public var boderHeight: CGFloat = 1
    public var borderColor: UIColor = .lightGray {
        didSet {
            borderView.backgroundColor = borderColor
        }
    }
    private var initialized: Bool = false
    private var defaultCellHeight: CGFloat?
    private var itemsFrame: [CGRect] = []
    private var itemsWidths: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJCLogger.log("Starting", Type: "info")
        teamDetailViewModel.vc = self
        if DeviceType == iPad{
            if((UserDefaults.standard.value(forKey:"seletedTab_Wo")) != nil){
                let index = UserDefaults.standard.value(forKey: "seletedTab_Wo") as! Int
                initialIndex = index
                tabSelectedIndex = index
            }else{
                initialIndex = 0
                tabSelectedIndex = 0
            }
            pageViewController.parentVC = self
            setupCell()
            setupPageView()
            self.menuCollectionView.dataSource = self
            self.menuCollectionView.delegate = self
            ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
            if alltechnicianListArray.count == 0 {
                detailView.isHidden = true
            }else {
                detailView.isHidden = false
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(TeamDetailsVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TeamDetailsVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        techid = techid.replacingOccurrences(of: "Techcinian_Id".localized() + " : ", with: "")
        setinitial()
        if DeviceType == iPad{
            titleLabel.text = "Team_Member".localized() + " : " +  "\(technname)"
        }else{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Work_Order_No".localized() + " \(selectedworkOrderNumber)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            self.SlideMenuSelected(index: 0, title: "Overview".localized(), menuType: "d")
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"Reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "Reload"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        
        if DeviceType == iPad{
            defer { initialized = true }
            guard !initialized else { super.viewDidAppear(animated); return }
            setupComponent()
            setupAnimator()
            setPages(viewControllers())
            setupAutoLayout()
        }else{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Work_Order_No".localized() + " \(selectedworkOrderNumber)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            updateSlideMenu()
        }
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func loadList(notification:Notification){
        mJCLogger.log("Starting", Type: "info")
        self.menuCollectionView.reloadData()
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
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.stopAnimating()
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "Team"
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Teams".localized(),"Overview".localized(), "Work_Orders".localized(), "Notifications".localized(), "Asset_Map".localized()]
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "AssetMapSM")]
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Mark:- Munu button Actions
    
    @IBAction func slideMenuButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if UIDevice.current.userInterfaceIdiom ==  UIUserInterfaceIdiom.phone {
            self.navigationController?.popViewController(animated: true)
        }else {
            if isMasterHidden {
                isMasterHidden = false
                splitViewController!.preferredDisplayMode = .automatic
            }else {
                isMasterHidden = true
                splitViewController!.preferredDisplayMode = .primaryHidden
            }
        }
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
    @IBAction func mapButtonAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentMapSplitScreen()
    }
    @IBAction func homeButtonAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    // MARK :- CollectionView Delegate
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        mJCLogger.log("Starting", Type: "info")
        if defaultCellHeight == nil {
            defaultCellHeight = self.menuCollectionView.frame.height
            setTabItem(tabItems())
        }
        mJCLogger.log("Ended", Type: "info")
        return self.teamDetailViewModel.items.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        mJCLogger.log("Starting", Type: "info")
        let index = indexPath.row
        let cell = ScreenManager.getTabCell(collectionView: menuCollectionView,indexPath:indexPath)
        menuCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        guard let tabCell = cell as? TabCell else { return cell }
        tabCell.delegate = self
        tabCell.indexPath = indexPath
        tabCell.tabModelClass = teamDetailViewModel.items[index]
//        tabCell.teamDetViewModel = teamDetailViewModel
        itemsFrame.append(tabCell.frame)
        mJCLogger.log("Ended", Type: "info")
        return tabCell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets()
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        mJCLogger.log("Starting", Type: "info")
        if collectionView == menuCollectionView {
            let width = itemsWidths[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return CGSize(width: width, height: 60)
        }
        mJCLogger.log("Ended", Type: "info")
        return CGSize(width: 0, height: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setinitial(){
        mJCLogger.log("Starting", Type: "info")
        if (UserDefaults.standard.value(forKey:"lastSyncDate") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate),timeZone: .utc,locale: .current))"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func menuclicked(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_POPUP_TEAM", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("menuclicked".localized(), Type: "")
                var menuarr = [String]()
                var imgArray = [UIImage]()
                menuarr = ["Supervisor_View".localized(),"Work_Orders".localized(),"Notifications".localized(), "Time_Sheet".localized(),"Master_Data_Refresh".localized(), "Asset_Map".localized(), "Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "timesht"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
                if !applicationFeatureArrayKeys.contains("Timesheet"){
                    if let index =  menuarr.firstIndex(of: "Time_Sheet".localized()){
                        menuarr.remove(at: index)
                        imgArray.remove(at: index)
                    }
                }
                menuDataModel.uniqueInstance.presentMenu(menuArr: menuarr, imgArr: imgArray, sender: sender, vc: self)
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                mJCLogger.log("WorkFlowError".localized(), Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.refreshButtonAction(sender!)
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Team" {
            if title == "Overview".localized() {
                let chartVC = ScreenManager.getChartScreen()
                addChild(chartVC)
                chartVC.chartType = "bar"
                chartVC.technicianid = techid
                chartVC.TechnicianName = technname
                chartVC.view.frame = CGRect(x: 0, y: 0, width: self.mainholderview.frame.size.width, height: self.mainholderview.frame.size.height)
                self.mainholderview.addSubview(chartVC.view)
                chartVC.didMove(toParent: self)
                currentsubView = "Overview"
            }else if title == "Time_Sheet".localized() {
                let timeSheetVC = ScreenManager.getTimeSheetScreen()
                addChild(timeSheetVC)
                timeSheetVC.isfromSupervisor = true
                timeSheetVC.view.frame = CGRect(x: 0, y: 0, width: self.mainholderview.frame.size.width, height: self.mainholderview.frame.size.height)
                self.mainholderview.addSubview(timeSheetVC.view)
                timeSheetVC.didMove(toParent: self)
                currentsubView = "Time Sheet"
                
            }else if title == "Teams".localized(){
                currentMasterView = "Team"
                let mainViewController = ScreenManager.getTeamMasterScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
                myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                self.appDeli.window?.makeKeyAndVisible()
                myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            }
        }else if title == "Supervisor_View".localized() {
            let mainViewController = ScreenManager.getSupervisorMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Work_Orders".localized() {
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
        }else if title == "Notifications".localized() {
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
        }else if title == "Job_Location".localized() {
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
        }else if title == "Asset_Map".localized() {
            currentMasterView = "WorkOrder"
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
            assetMapDeatilsVC.modalPresentationStyle = .fullScreen
            self.present(assetMapDeatilsVC, animated: true, completion: nil)
        }else if title == "Settings".localized(){
            menuDataModel.uniqueInstance.presentSettingsScreen(vc: self)
        }else if title == "Error_Logs".localized(){
            myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }
    //MARK:- Page Swiper Methods
    
    func tabItems() -> [TabItem] {
        mJCLogger.log("Starting", Type: "info")
        let OverviewTab  = TabItem(title: "Overview".localized(), image: UIImage(named: "overview"))
        let TimesheetTab   = TabItem(title: "Timesheet".localized(), image: UIImage(named: "operations"))
        if DeviceType == iPad{
            self.teamDetailViewModel.tabItemArray.append(contentsOf: [OverviewTab, TimesheetTab])
            return self.teamDetailViewModel.tabItemArray
        }
        mJCLogger.log("Ended", Type: "info")
        return [TabItem()]
    }
    func viewControllers() -> [UIViewController] {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let chartVC = ScreenManager.getChartScreen()
            chartVC.technicianid = techid
            chartVC.TechnicianName = technname
            chartVC.chartType = "bar"
            let timeSheetVC = ScreenManager.getSupervisorTimeSheetScreen()
            timeSheetVC.technicianid = techid
            timeSheetVC.TechnicianName = technname
            mJCLogger.log("Ended", Type: "info")
            return [chartVC, timeSheetVC]
        }
        mJCLogger.log("Ended", Type: "info")
        return []
    }
    private func setupCell() {
        mJCLogger.log("Starting", Type: "info")
         ScreenManager.registerTabCell(collectionView: menuCollectionView)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = (1 / 1366) * eachLineSpacing * view.frame.width
        layout.scrollDirection = .horizontal
        layout.sectionInset = sectionInset
        menuCollectionView.collectionViewLayout = layout
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupPageView() {
        mJCLogger.log("Starting", Type: "info")
        pageViewController.view.frame = pageView.frame
        pageViewController.isPageFrom = ""
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = true
        pageView.addSubview(pageViewController.view)
        pageViewController.initialIndex = initialIndex
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupComponent() {
        mJCLogger.log("Starting", Type: "info")
        menuCollectionView.backgroundColor = tabBackgroundColor
        view.backgroundColor = tabBackgroundColor
        menuCollectionView.scrollsToTop = false
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupAnimator() {
        mJCLogger.log("Starting", Type: "info")
        guard pageViewController.barAnimators.count == 0 else { return }
        var animators: [UIViewPropertyAnimator] = []
        var actions: [() -> Void] = []
        let maxIndex = itemsFrame.count - 2
        
        for index in 0 ... maxIndex {
            let action = {}
            let barAnimator = UIViewPropertyAnimator(duration: pageViewController.barAnimationDuration, curve: .easeInOut, animations: action)
            barAnimator.pausesOnCompletion = true
            animators.append(barAnimator)
            actions.append(action)
        }
        var initialAction: (() -> Void)?
        initialAction = {}
        pageViewController.setAnimators(needSearchTab: false,
                                        animators: animators,
                                        originalActions: actions,
                                        initialAction: initialAction)
        mJCLogger.log("Ended", Type: "info")
    }
    private func setPages(_ viewControllers: [UIViewController]) {
        mJCLogger.log("Starting", Type: "info")
        guard viewControllers.count == self.teamDetailViewModel.items.count else { fatalError("The_number_of_ViewControllers_must_equal_to_the_number_of_TabItems".localized()) }
        pageViewController.setPages(viewControllers)
    }
    private func setupAutoLayout() {
        mJCLogger.log("Starting", Type: "info")
        if let pageView = self.pageView {
            pageView.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                NSLayoutConstraint(item: pageView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .bottom,
                                   multiplier: 1.0,
                                   constant: 0),
                
                NSLayoutConstraint(item: pageView,
                                   attribute: .left,
                                   relatedBy: .equal,
                                   toItem: view.safeAreaLayoutGuide,
                                   attribute: .left,
                                   multiplier: 1.0,
                                   constant: 0),
                
                NSLayoutConstraint(item: pageView,
                                   attribute: .right,
                                   relatedBy: .equal,
                                   toItem: view.safeAreaLayoutGuide,
                                   attribute: .right,
                                   multiplier: 1.0,
                                   constant: 0)
            ])
        }
        if let view = pageViewController.view {
            pageView.addConstraints([
                NSLayoutConstraint(item: view,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: pageView,
                                   attribute: .centerX,
                                   multiplier: 1.0,
                                   constant: 0),
                
                NSLayoutConstraint(item: view,
                                   attribute: .centerY,
                                   relatedBy: .equal,
                                   toItem: pageView,
                                   attribute: .centerY,
                                   multiplier: 1.0,
                                   constant: 0),
                
                NSLayoutConstraint(item: view,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: pageView,
                                   attribute: .width,
                                   multiplier: 1.0,
                                   constant: 0),
                
                NSLayoutConstraint(item: view,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: pageView,
                                   attribute: .height,
                                   multiplier: 1.0,
                                   constant: 0)
            ])
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    private func setTabItem(_ items: [TabItem]) {
        mJCLogger.log("Starting", Type: "info")
        self.teamDetailViewModel.items = items
        for i in 0 ... self.teamDetailViewModel.items.count - 1 {
            let item = self.teamDetailViewModel.items[i]
            var width: CGFloat
            let fontSize = (1 / 1366 * view.frame.width) * self.teamDetailViewModel.items[i].font.pointSize
            self.teamDetailViewModel.items[i].font = item.font.withSize(fontSize)
            width = labelWidth(text: item.title!, font: item.font)
            itemsWidths.append(width)
        }
        itemsWidths = recalculateWidths()
        mJCLogger.log("Ended", Type: "info")
    }
    
    private func recalculateWidths() -> [CGFloat]  {
        mJCLogger.log("Starting", Type: "info")
        var itemsWidths: [CGFloat] = []
        let cellMarginSum = CGFloat(self.teamDetailViewModel.items.count - 1) * eachLineSpacing
        let maxWidth = view.frame.width + 100
        var cellSizeSum: CGFloat = 0
        self.itemsWidths.forEach {
            cellSizeSum += $0
        }
        let extraMargin = maxWidth - (sectionInset.right + sectionInset.left + cellMarginSum + cellSizeSum)
        let distributee = self.teamDetailViewModel.items.count
        guard extraMargin > 0 else {
            self.itemsWidths.removeAll()
            for i in 0 ... self.teamDetailViewModel.items.count - 1 {
                let item = self.teamDetailViewModel.items[i]
                var width: CGFloat = 0
                let fontSize = self.teamDetailViewModel.items[i].font.pointSize * 0.9 // * 0.9, 0.8, 0.7, 0.65, 0.6, 0.5 ...
                self.teamDetailViewModel.items[i].font = item.font.withSize(fontSize)
                width = labelWidth(text: item.title!, font: item.font)
                self.itemsWidths.append(width)
            }
            return recalculateWidths() // recursion
        }
        self.itemsWidths.forEach {
            itemsWidths.append($0 + extraMargin / CGFloat(distributee))
        }
        mJCLogger.log("Ended", Type: "info")
        return itemsWidths
    }
    public func moveTo(index: Int) {
        mJCLogger.log("Starting", Type: "info")
        tabSelectedIndex = index
        pageViewController.moveTo(index: index)
        self.menuCollectionView.reloadData()
        if DeviceType == iPad{
            UserDefaults.standard.set(index, forKey: "seletedTab_Wo")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func labelWidth(text: String, font: UIFont) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text + " AA AA AA "
        label.sizeToFit()
        mJCLogger.log("Ended", Type: "info")
        return label.frame.width
    }
}
