//
//  SupervisorDetailsVC.swift
//  test
//
//  Created by Rover Software on 06/06/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SupervisorDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,UICollectionViewDelegateFlowLayout,CustomNavigationBarDelegate, SlideMenuControllerSelectDelegate,TabCellDelegate,PageViewParent  {

    //MARK:- outlets
    @IBOutlet var headerview: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lastSyncLabel: UILabel!
    @IBOutlet var slideMenuButton: UIButton!
    @IBOutlet var munuButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var HomeButton: UIButton!
    @IBOutlet var centerMenu: UICollectionView!
    @IBOutlet var mainHolder: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet weak var addNewJobButton: UIButton!
    @IBOutlet open weak var menuCollectionView: UICollectionView!
    @IBOutlet open weak var selectedBar: UIView!
    @IBOutlet open weak var pageView: UIView!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet var iPhoneHeader: UIView!
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var Selectedview = String()
    var componentsViewModel = ComponentsViewModel()
    var supDetViewModel = SuperMastDetViewModel()
    public var initialIndex: Int = 0
    public var tabBackgroundColor: UIColor = UIColor(named: "mjcViewBgColor") ?? .white
    public var eachLineSpacing: CGFloat = 5
    public var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    public var selectedBarHeight: CGFloat = 5
    public var selectedBarMargins: (upper: CGFloat, lower: CGFloat) = (1, 2)
    public var pageViewMargin: CGFloat = 1
    public lazy var pageViewController = PageViewController(transitionStyle: .scroll,
                                                            navigationOrientation: .horizontal,
                                                            options: nil)
    // border
    public var needBorder: Bool = false {
        didSet {
            borderView.isHidden = !needBorder
        }
    }
    public var boderHeight: CGFloat = 1
    public var borderColor: UIColor = .black {
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
        initialIndex = 0
        supDetViewModel.vc = self
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
        if DeviceType == iPhone{
            selectedBar.isHidden = true
        }else{
            selectedBar.isHidden = false
        }
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
        setinitial()
        if DeviceType == iPad{
            Selectedview = "OVERVIEW"
            NotificationCenter.default.addObserver(self, selector: #selector(SupervisorDetailsVC.dataSetSuccessfully(notification:)), name:NSNotification.Name(rawValue:"dataSetSuccessfully"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(SupervisorDetailsVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(SupervisorDetailsVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        }else{
            self.SlideMenuSelected(index: 0, title: "Overview".localized(), menuType: "d")
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Work_Order_No".localized() + " \(selectedworkOrderNumber)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"Reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "Reload"), object: nil)
        mJCLogger.log("Ending", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPad{
            if flushStatus == true{
                self.refreshButton.showSpin()
            }
        }else{
            self.updateSlideMenu()
        }
        mJCLogger.log("Ending", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        
        mJCLogger.log("Starting", Type: "info")
        defer { initialized = true }
        guard !initialized else { super.viewDidAppear(animated); return }
        setupComponent()
        setupAnimator()
        setPages(viewControllers())
        setupAutoLayout()
        if DeviceType == iPhone{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Work_Order_No".localized() + " \(selectedworkOrderNumber)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            self.updateSlideMenu()
        }
        mJCLogger.log("Ending", Type: "info")
    }
    private func updateSlideMenu() {
        
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Work_Orders".localized(),"Overview".localized(), "Operations".localized(), "Components".localized(),"CheckLists".localized(), "Readings".localized()]
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "Operations"),#imageLiteral(resourceName: "Components"),#imageLiteral(resourceName: "Forms"),#imageLiteral(resourceName: "RecordPonits")]
        mJCLogger.log("Ending", Type: "info")
    }
    @objc func loadList(notification:Notification){
        mJCLogger.log("Starting", Type: "info")
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func setinitial(){
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if (UserDefaults.standard.value(forKey:"lastSyncDate") != nil) {
                let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate") as! Date
                self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
            }else{
                self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate),timeZone: .utc,locale: .current))"
            }
            if currentMasterView == "Supervisor" {
                let techname = TechnicianName.components(separatedBy: ":") as NSArray
                if techname.count > 1{
                    self.titleLabel.text = "\(techname[1])" + " - " + "Work_Order_No".localized() + " \(selectedworkOrderNumber)"
                }else{
                    self.titleLabel.text = "Work_Order_No".localized() + "\(selectedworkOrderNumber)"
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notifications Methods..
    @objc func dataSetSuccessfully(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        setinitial()
        mJCLogger.log("Ended", Type: "info")
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if flushStatus == true{
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK :- CollectionView Delegate
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        mJCLogger.log("Starting", Type: "info")
        if defaultCellHeight == nil {
            defaultCellHeight = self.menuCollectionView.frame.height
            setTabItem(tabItems())
        }
        mJCLogger.log("Ended", Type: "info")
        return self.supDetViewModel.items.count
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets()
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
//        tabCell.supDetViewModel = supDetViewModel
//        tabCell.supModelClass = self.supDetViewModel.items[index]
        itemsFrame.append(tabCell.frame)
        mJCLogger.log("Ended", Type: "info")
        return tabCell
        
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
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
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
    @IBAction func MenuButtonAction(_ sender: Any)
    {
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if currentMasterView == "Supervisor" {
            menuarr = ["Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(),"Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "timesht"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  menuarr.firstIndex(of: "Time_Sheet".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        menuDataModel.uniqueInstance.presentMenu(menuArr: menuarr, imgArr: imgArray, sender: sender, vc: self)
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        UIView.animate(withDuration: 0.5) {
            mJCLoader.startAnimating(status: "Uploading".localized())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func mapButonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "SupervisorMap"
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        let mapSplitViewController = ScreenManager.getSupervisorMapSplictScreen()
        self.appDeli.window?.rootViewController = mapSplitViewController
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func homeButtonAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    @IBAction func addNewJobAction(_ sender: Any) {
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- UITapGesture Recognizer..
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder" {
            if title == "Overview".localized() {
                var index = self.supDetViewModel.allSuperVisorTabitemArray.firstIndex{$0.title == "Overview".localized()}
                if index == nil{
                    index = 0
                }
                self.moveTo(index: index!)
            }else if title == "Operations".localized() {
                var index = self.supDetViewModel.allSuperVisorTabitemArray.firstIndex{$0.title == "Operations".localized()}
                if index == nil{
                    index = 0
                }
                self.moveTo(index: index!)
            }else if title == "Components".localized() {
                var index = self.supDetViewModel.allSuperVisorTabitemArray.firstIndex{$0.title == "Components".localized()}
                if index == nil{
                    index = 0
                }
                self.moveTo(index: index!)
            }else if title == "Readings".localized() {
                var index = self.supDetViewModel.allSuperVisorTabitemArray.firstIndex{$0.title == "Readings".localized()}
                if index == nil{
                    index = 0
                }
                self.moveTo(index: index!)
            }else if title == "CheckLists".localized() {
                var index = self.supDetViewModel.allSuperVisorTabitemArray.firstIndex{$0.title == "CheckLists".localized()}
                if index == nil{
                    index = 0
                }
                self.moveTo(index: index!)
            }else if title == "Work_Orders".localized() {
                let mainViewController = ScreenManager.getSupervisorMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
                myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                self.appDeli.window?.makeKeyAndVisible()
                myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            }
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
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg:"WorkFlowError".localized())
                mJCLogger.log("WorkFlowError".localized(), Type: "Debug")
            }
        }else{
            mJCLogger.log("No Data",Type: "Debug")
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
    func backButtonClicked(_ sender: UIButton?){
        
        
    }
    //MARK:- Page Swiper Methods
    func tabItems() -> [TabItem] {
        mJCLogger.log("Starting", Type: "info")
        self.supDetViewModel.allSuperVisorTabitemArray = [TabItem(title: "Overview".localized(), image: UIImage(named:"overview")),TabItem(title: "Operations".localized(), image: UIImage(named: "operations")),TabItem(title: "Components".localized(), image: UIImage(named: "components")),TabItem(title: "CheckLists".localized(), image: UIImage(named: "forms")),TabItem(title: "Readings".localized(), image: UIImage(named:"activities"))]
        mJCLogger.log("Ended", Type: "info")
        return self.supDetViewModel.allSuperVisorTabitemArray
    }
    func viewControllers() -> [UIViewController] {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let overViewVC = ScreenManager.getWorkOrderOverViewScreen()
            overViewVC.isfromsup = "Supervisor"
            let operationsVC = ScreenManager.getOperationScreen()
            operationsVC.isfromsup = "Supervisor"
            let componentsVC = ScreenManager.getComponentScreen()
            componentsVC.isfrom = "Supervisor"
            let checkSheetListVC = ScreenManager.getCheckSheetListScreen()
            //checkSheetListVC.formVCModel.isfrom = "Supervisor"
            let readingsVC = ScreenManager.getRecordPointsScreen()
            readingsVC.isfrom = "supervisor"
            return [overViewVC, operationsVC, componentsVC, checkSheetListVC, readingsVC]
        }else{
            let overViewVC = ScreenManager.getWorkOrderOverViewScreen()
            overViewVC.isfromsup = "Supervisor"
            let operationsVC = ScreenManager.getOperationListScreen()
            operationsVC.isfromsup = "Supervisor"
            let componentsVC = ScreenManager.getComponentListScreen()
            componentsVC.isfrom = "Supervisor"
            let checkSheetListVC = ScreenManager.getCheckSheetListScreen()
           // formVCModel.isfrom = "Supervisor"
            let readingsVC = ScreenManager.getRecordPointsScreen()
            readingsVC.isfrom = "supervisor"
            mJCLogger.log("Ended", Type: "info")
            return [overViewVC, operationsVC, componentsVC,checkSheetListVC,readingsVC]
        }
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
        selectedBar.frame = CGRect(x: itemsFrame[0].origin.x,
                                   y: menuCollectionView.frame.origin.y + menuCollectionView.frame.height - 3 + selectedBarMargins.upper,
                                   width: itemsFrame[0].width ,
                                   height: (1 / 768 * view.frame.height) * selectedBarHeight)
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
            let nextFrame = itemsFrame[index + 1]
            let action = {
                let barFrame = self.selectedBar.frame
                self.selectedBar.frame = CGRect(x: nextFrame.origin.x,
                                                y: barFrame.origin.y,
                                                width: nextFrame.width,
                                                height: barFrame.height)
            }
            let barAnimator = UIViewPropertyAnimator(duration: pageViewController.barAnimationDuration, curve: .easeInOut, animations: action)
            barAnimator.pausesOnCompletion = true
            animators.append(barAnimator)
            actions.append(action)
        }
        var initialAction: (() -> Void)?
        pageViewController.setAnimators(needSearchTab: false,
                                        animators: animators,
                                        originalActions: actions,
                                        initialAction: initialAction)
        mJCLogger.log("Ended", Type: "info")
        
    }
    private func setPages(_ viewControllers: [UIViewController]) {
        
        mJCLogger.log("Starting", Type: "info")
        
        guard viewControllers.count == self.supDetViewModel.items.count else {
            mJCLogger.log("Reason :" + "The_number_of_ViewControllers_must_equal_to_the_number_of_TabItems".localized(), Type: "Error")
            fatalError("The_number_of_ViewControllers_must_equal_to_the_number_of_TabItems".localized())
        }
        mJCLogger.log("The_number_of_ViewControllers_must_equal_to_the_number_of_TabItems", Type: "Debug")
        pageViewController.setPages(viewControllers)
        mJCLogger.log("Ended", Type: "info")
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
                                   constant: 0),
                NSLayoutConstraint(item: pageView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: menuCollectionView,
                                   attribute: .bottom,
                                   multiplier: 1.0,
                                   constant: selectedBarMargins.upper + selectedBarMargins.lower + pageViewMargin + selectedBar.frame.height + (needBorder ? boderHeight : 0))
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
        self.supDetViewModel.items = items
        for i in 0 ... self.supDetViewModel.items.count - 1 {
            let item = self.supDetViewModel.items[i]
            var width: CGFloat
            let fontSize = (1 / 1366 * view.frame.width) * self.supDetViewModel.items[i].font.pointSize
            self.supDetViewModel.items[i].font = item.font.withSize(fontSize)
            width = labelWidth(text: item.title!, font: item.font)
            itemsWidths.append(width)
        }
        itemsWidths = recalculateWidths()
        mJCLogger.log("Ended", Type: "info")
    }
    private func recalculateWidths() -> [CGFloat] {
        
        mJCLogger.log("Starting", Type: "info")
        var itemsWidths: [CGFloat] = []
        let cellMarginSum = CGFloat(self.supDetViewModel.items.count - 1) * eachLineSpacing
        let maxWidth = view.frame.width
        var cellSizeSum: CGFloat = 0
        self.itemsWidths.forEach {
            cellSizeSum += $0
        }
        let extraMargin = maxWidth - (sectionInset.right + sectionInset.left + cellMarginSum + cellSizeSum)
        let distributee = self.supDetViewModel.items.count
        guard extraMargin > 0 else {
            self.itemsWidths.removeAll()
            for i in 0 ... self.supDetViewModel.items.count - 1 {
                let item = self.supDetViewModel.items[i]
                var width: CGFloat = 0
                let fontSize = self.supDetViewModel.items[i].font.pointSize * 0.9 // * 0.9, 0.8, 0.7, 0.65, 0.6, 0.5 ...
                self.supDetViewModel.items[i].font = item.font.withSize(fontSize)
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
