//
//  WOListDetailVC.swift
//  myJobCard
//
//  Created by Navdeep Singla on 17/03/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import AVFoundation

class FlocEquipDetialsVC: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,TabCellDelegate,PageViewParent, viewModelDelegate,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate {

    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var selectedBar: UIView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var statusbarView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var addNewJobButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!

    public var initialIndex: Int = 0
    public lazy var pageViewController = PageViewController(transitionStyle: .scroll,
                                                            navigationOrientation: .horizontal,
                                                            options: nil)
    private var initialized: Bool = false
    // Page Swipe Inputs End

    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let menudropDown = DropDown()
    var dropDownString = String()

    var tabItemArray = Array<TabItem>()
    var tabVCArray = [UIViewController]()
    var flocEquipObjType = String()
    var flocEquipObjText = String()
    var classificationType = String()
    var navHeaderView = CustomNavHeader_iPhone()
    var flocEquipOverviewVC : FlocEquipOverviewVC?
    override func viewDidLoad() {
        
        super.viewDidLoad()

        initialIndex = 0
        selectedIndex = 0
        pageViewController.parentVC = self
        self.setupCell()
        self.setupPageView()
        if DeviceType == iPhone{
            selectedBar.isHidden = true
        }else{
            selectedBar.isHidden = false
        }
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self

        if DeviceType == iPad {
            if flocEquipObjType == "Floc" {
                headerTitleLabel.text = "Functional_Location".localized() + ": " + "\(flocEquipObjText)"
            }else{
                headerTitleLabel.text = "Equipment_No".localized() + ": \(flocEquipObjText)"
            }
            setAppFeature()
            menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                if self.dropDownString == "Menu"{
                    if item == "Work_Orders".localized() {
                        selectedworkOrderNumber = ""
                        currentMasterView = "WorkOrder"
                        let splitVC = ScreenManager.getListSplitScreen()
                        let detailVc = ScreenManager.getMasterListDetailScreen()
                        let master = (splitVC.viewControllers.first as! UINavigationController).viewControllers.first as? MasterListVC
                        master?.delegate = detailVc
                        splitVC.showDetailViewController(detailVc, sender: splitVC)
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }else if item == "Notifications".localized() {
                        selectedworkOrderNumber = ""
                        currentMasterView = "Notification"
                        let splitVC = ScreenManager.getListSplitScreen()
                        let detailVc = ScreenManager.getMasterListDetailScreen()
                        let master = (splitVC.viewControllers.first as! UINavigationController).viewControllers.first as? MasterListVC
                        master?.delegate = detailVc
                        splitVC.showDetailViewController(detailVc, sender: splitVC)
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }else if item == "Time_Sheet".localized() {
                        selectedworkOrderNumber = ""
                        DispatchQueue.main.async {
                            currentMasterView = "TimeSheet"
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
                    }else if item == "Asset_Map".localized() {
                        ASSETMAP_TYPE = "ESRIMAP"
                        assetmapVC.openmappage(id: "")
                    }else if item == "Settings".localized() {
                        let settingsVC = ScreenManager.getSettingsScreen()
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: false, completion: nil)
                    }else if item == "Log_Out".localized() {
                        myAssetDataManager.uniqueInstance.logOutApp()
                    }
                }
            }
        }else{
            navHeaderView = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "\(flocEquipObjText)", NewJobButton: true, refresButton: true, threedotmenu: true, leftMenuType: "Menu")
            self.view.addSubview(navHeaderView)
            if flushStatus == true{
                self.navHeaderView.refreshBtn.showSpin()
            }
            self.updateSlideMenu()
            self.navHeaderView.delegate = self
            self.viewWillAppear(true)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(FlocEquipDetialsVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FlocEquipDetialsVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"Reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FlocEquipDetialsVC.loadList(notification:)), name:NSNotification.Name(rawValue:"Reload"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true {
            if DeviceType == iPad {
                self.refreshButton.showSpin()
            }
        }
        pageViewController.setTabItem(tabItems())
        defer { initialized = true }
        guard !initialized else { super.viewWillAppear(animated);
            return }
        pageViewController.pageView = self.pageView
        pageViewController.selectedBar = self.selectedBar
        setupPageComponent()
        pageViewController.setupAnimator()
        setPages(viewControllers())
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    deinit {
        UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
        NotificationCenter.default.removeObserver(self)
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Equipment"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        var sideMenuArrray = [String]()
        var sideMenuArrrayImages = [UIImage]()
        sideMenuArrray = ["Home".localized(),"Overview".localized(),"Installed_Equipments".localized(),"Classification".localized(),"Attachments".localized(),"BreakDown_Report".localized()]
        sideMenuArrrayImages = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "Components"),#imageLiteral(resourceName: "Objects"),#imageLiteral(resourceName: "AttachementsNF"),#imageLiteral(resourceName: "BreakdownReport_Black")]
        if applicationFeatureArrayKeys.contains("EQUIP_INSTALEQUIP_TAB"){
            if let index =  sideMenuArrray.firstIndex(of: "Installed_Equipments".localized()){
                sideMenuArrray.remove(at: index)
                sideMenuArrrayImages.remove(at: index)
            }
        }
        if applicationFeatureArrayKeys.contains("EQUIP_CLASSIFICATIONS_TAB"){
            if let index =  sideMenuArrray.firstIndex(of: "Classification".localized()){
                sideMenuArrray.remove(at: index)
                sideMenuArrrayImages.remove(at: index)
            }
        }
        if applicationFeatureArrayKeys.contains("EQUIP_ATTACHMENTS_TAB"){
            if let index =  sideMenuArrray.firstIndex(of: "Attachments".localized()){
                sideMenuArrray.remove(at: index)
                sideMenuArrrayImages.remove(at: index)
            }
        }
        if applicationFeatureArrayKeys.contains("EQUIP_BREAKDOWN_TAB"){
            if let index =  sideMenuArrray.firstIndex(of: "BreakDown_Report".localized()){
                sideMenuArrray.remove(at: index)
                sideMenuArrrayImages.remove(at: index)
            }
        }
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = sideMenuArrray
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = sideMenuArrrayImages
        self.SlideMenuSelected(index: 0, title: "Overview".localized(), menuType: "")
      
        mJCLogger.log("Ended", Type: "info")
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Overview".localized() {
            let index = tabItemArray.firstIndex{$0.title == "Overview".localized()}
            self.moveTo(index: index ?? 0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
        }else if title == "Installed_Equipments".localized() {
            let index = tabItemArray.firstIndex{$0.title == "Installed_Equipments".localized()}
            self.moveTo(index: index ?? 0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }else if title == "Classification".localized() {
            let index = tabItemArray.firstIndex{$0.title == "Classification".localized()}
            self.moveTo(index: index ?? 0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }else if title == "Attachments".localized() {
            let index = tabItemArray.firstIndex{$0.title == "Attachments".localized()}
            self.moveTo(index: index ?? 0)
        }else if title == "BreakDown_Report".localized() {
            let index = tabItemArray.firstIndex{$0.title == "BreakDown_Report".localized()}
            self.moveTo(index: index ?? 0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setAppFeature() {
        mJCLogger.log("Starting", Type: "info")
        if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
            self.addNewJobButton.isHidden = false
        }else{
            self.addNewJobButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("WO_LIST_MAP_NAV"){
            locationButton.isHidden = false
        }else{
            locationButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Notifications Methods..
    @objc func storeFlushAndRefreshDone(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.stopAnimating()
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func loadList(notification: NSNotification){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            if tabItemArray.indices.contains(selectedIndex){
                let tabitem = tabItemArray[selectedIndex]
                sideSelectedMenu = tabitem.title ?? ""
            }else{
                sideSelectedMenu = ""
            }
        }
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func addNewJobButtonAction(_ sender: Any) {
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
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "MapSplitViewController"
        selectedworkOrderNumber = ""
        ASSETMAP_TYPE = ""
        let mapSplitVC = ScreenManager.getMapSplitScreen()
        self.appDeli.window?.rootViewController = mapSplitVC
        self.appDeli.window?.makeKeyAndVisible()
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
    
    @IBAction func homeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("HomeButtonAction".localized(), Type: "")
        singleWorkOrder = WoHeaderModel()
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Settings".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
        }else{
            menuarr = ["Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Settings".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
            
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        menudropDown.dataSource = menuarr
        customizeDropDown(imgArry: imgArray)
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
    private func setupCell() {
        mJCLogger.log("Starting", Type: "info")
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = (1 / 1366) * pageViewController.eachLineSpacing  * view.frame.width
        layout.scrollDirection = .horizontal
        layout.sectionInset = pageViewController.sectionInset
        self.menuCollectionView.collectionViewLayout = layout
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
    //MARK: - Page Swiper Methods
    func tabItems() -> [TabItem] {
        self.tabItemArray.removeAll()
        mJCLogger.log("Starting", Type: "info")
        let OverviewTab  = TabItem(title: "Overview".localized(), image: UIImage(named: "overview"), cellWidth: 130.0)
//        let installedEquipTab  = TabItem(title: "Installed_Equipments".localized(), image: UIImage(named: "components"), cellWidth: 130.0)
//        let classificationTab  = TabItem(title: "Classification".localized(), image: UIImage(named: "items"), cellWidth: 130.0)
//        let breakdownReportTab  = TabItem(title: "Breakdown Report".localized(), image: UIImage(named: "BreakdownReport_Color"), cellWidth: 130.0)
        let attachmentsTab  = TabItem(title: "Attachments".localized(), image: UIImage(named: "attachment"), cellWidth: 130.0)

        tabItemArray.append(OverviewTab)
        if flocEquipObjType == "floc"{
//            if !applicationFeatureArrayKeys.contains("FLOC_INSTALEQUIP_TAB"){
//                tabItemArray.append(installedEquipTab)
//            }
//            if !applicationFeatureArrayKeys.contains("FLOC_CLASSIFICATIONS_TAB"){
//                tabItemArray.append(classificationTab)
//            }
            if !applicationFeatureArrayKeys.contains("FLOC_ATTACHMENTS_TAB"){
                tabItemArray.append(attachmentsTab)
            }
//            if !applicationFeatureArrayKeys.contains("FLOC_BREAKDOWN_TAB"){
//                tabItemArray.append(breakdownReportTab)
//            }
        }else{
//            if !applicationFeatureArrayKeys.contains("EQUIP_INSTALEQUIP_TAB"){
//                tabItemArray.append(installedEquipTab)
//            }
//            if !applicationFeatureArrayKeys.contains("EQUIP_CLASSIFICATIONS_TAB"){
//                tabItemArray.append(classificationTab)
//            }
            if !applicationFeatureArrayKeys.contains("EQUIP_ATTACHMENTS_TAB"){
                tabItemArray.append(attachmentsTab)
            }
//            if !applicationFeatureArrayKeys.contains("EQUIP_BREAKDOWN_TAB"){
//                tabItemArray.append(breakdownReportTab)
//            }
        }
        return tabItemArray
    }
    private func setupPageComponent() {
        mJCLogger.log("Starting", Type: "info")
        menuCollectionView.backgroundColor = pageViewController.tabBackgroundColor
        menuCollectionView.scrollsToTop = false
        mJCLogger.log("Ended", Type: "info")
    }
    func viewControllers() -> [UIViewController] {
        mJCLogger.log("Starting", Type: "info")

        flocEquipOverviewVC = ScreenManager.getFlocEquipOverViewScreen()
        flocEquipOverviewVC?.flocEquipObjType = self.flocEquipObjType
        flocEquipOverviewVC?.flocEquipObjText = self.flocEquipObjText
        //installed equipmengt
        let installedEquipVC = ScreenManager.getInstalledEquipmentScreen()
        installedEquipVC.flocEquipObjType = self.flocEquipObjType
        installedEquipVC.flocEquipObjText = self.flocEquipObjText
        //classification
        let classificationVC = ScreenManager.getClassificationScreen()
        classificationVC.flocEquipObjType = self.flocEquipObjType
        classificationVC.flocEquipObjText = self.flocEquipObjText
        classificationVC.classificationType = classificationType
        //attachment
        var attachmentVc = UIViewController()
        if currentMasterView == "WorkOrder" || currentMasterView == "Supervisor" {
            let attachmentVC = ScreenManager.getWorkOrderAttachmentScreen()
            //attachmentVC.attachDelegate = self
            attachmentVC.objectNum = flocEquipObjText
            if flocEquipObjType == "floc" {
                attachmentVC.fromScreen = "FUNCTIONALLOCATION"
            }else{
                attachmentVC.fromScreen = "EQUIPMENT"
            }
            attachmentVc = attachmentVC
        }
        //breakdown report
        let breakDownReportVC = ScreenManager.getBreakDownReportScreen()
        breakDownReportVC.breakDownObj = flocEquipObjText
        breakDownReportVC.breakDownObjDescription = ""
        if flocEquipObjType == "floc" {
            breakDownReportVC.isFromScreen = "FUNCTIONALLOCATION"
        }else{
            breakDownReportVC.isFromScreen = "EQUIPMENT"
        }
        tabVCArray = [flocEquipOverviewVC!,attachmentVc]
        return tabVCArray
    }
    private func setPages(_ viewControllers: [UIViewController]) {
        mJCLogger.log("Starting", Type: "info")
        guard viewControllers.count == pageViewController.items.count
        else { fatalError("The number of ViewControllers must equal to the number of TabItems.") }
        pageViewController.setPages(viewControllers)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Collection View Delegates
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == menuCollectionView{
            if pageViewController.defaultCellHeight == nil {
                pageViewController.defaultCellHeight = self.menuCollectionView.frame.height
                pageViewController.itemCount = pageViewController.items.count
            }
            return pageViewController.items.count
        }else{
            return 0
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        mJCLogger.log("Starting", Type: "info")
        let index = indexPath.row
        let cell = ScreenManager.getTabCell(collectionView: collectionView,indexPath:indexPath)
        guard let tabCell = cell as? TabCell else { return cell }
        tabCell.index = index
        tabCell.delegate = self
        tabCell.flocEquipModel = pageViewController.items[index]
        tabCell.indexPath = indexPath
        if DeviceType == iPhone{
            tabCell.titleLabel.font = .systemFont(ofSize: 14)
        }
        if selectedIndex == indexPath.row{
            tabCell.selectedView.backgroundColor = appColor
            tabCell.titleLabel.textColor = UIColor.lightText
            self.menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }else {
            tabCell.selectedView.backgroundColor = UIColor.white
            tabCell.titleLabel.textColor = UIColor.white
        }
        return tabCell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){}
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
        return UIEdgeInsets()
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCollectionView {
            let width = pageViewController.itemsWidths[indexPath.row]
            return CGSize(width: width+100, height: 60)
        }else{
            return CGSize(width: 50, height: 50)
        }
    }
    public func moveTo(index: Int) {
        mJCLogger.log("Starting", Type: "info")
        selectedIndex = index
        pageViewController.moveTo(index: index)
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func leftMenuButtonClicked(_ sender: UIButton?){
        openLeft()
    }
    func backButtonClicked(_ sender: UIButton?){
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        self.addNewJobButtonAction(UIButton())
    }
    func refreshButtonClicked(_ sender: UIButton?){
        self.refreshButtonAction(UIButton())
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        var menuarr = [String]()
        menuarr = ["Print_Asset_Tag".localized()]
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
            if item == "Print_Asset_Tag".localized(){
                let selectedEquip = flocEquipOverviewVC?.selectedEquip
                if selectedEquip?.Asset != ""{
                    let img = PrintHelper.createQRCodeView(asseID: selectedEquip!.Asset, assetDesc: selectedEquip?.EquipDescription ?? "")
                    PrintHelper.printQrCode(document: img, assetId: "\(selectedEquip!.Asset)")
                }
            }
        }
    }
}
