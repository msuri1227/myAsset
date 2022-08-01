//
//  WorkOrderSuspendVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import AssetsLibrary

    
class WorkOrderSuspendVC: UIViewController, CustomNavigationBarDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PageViewParent,TabCellDelegate{

    //MARK:- HeaderView Outlets..
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var addNewJobButton: UIButton!
    @IBOutlet weak var botttomView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet open weak var selectedBar: UIView!
    @IBOutlet open weak var pageView: UIView!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet var iPhoneHeader: UIView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var refNum = String()
    var statusCategoryCls = StatusCategoryModel()
    var statusLogset = StatusChangeLogModel()
    var isFromScreen = String()
    var dropDown = DropDown()
    var selectedIndex = Int()
    var suspendViewModel = SuspendViewModel()
    
    // MARK: Page Swipe Inputs
    public var items: [TabItem] = []
    public var initialIndex: Int = 0
    public var tabBackgroundColor: UIColor = appColor
    public var eachLineSpacing: CGFloat = 0
    public var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var selectedBarHeight: CGFloat = 5
    public var selectedBarMargins: (upper: CGFloat, lower: CGFloat) = (1, 2)
    public var pageViewMargin: CGFloat = 0
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
    public var borderColor: UIColor = .lightGray {
        didSet {
            borderView.backgroundColor = borderColor
        }
    }
    private var initialized: Bool = false
    private var defaultCellHeight: CGFloat?
    private var itemsFrame: [CGRect] = []
    private var itemsWidths: [CGFloat] = []
    
    //MARK:- LifeCycle..
    override func viewDidLoad(){
        
        suspendViewModel.suspendVc = self
        self.menuCollectionView.reloadData()
        pageViewController.parentVC = self
        setupCell()
        selectedIndex = 0
        suspendViewModel.getStausChangeLogSet(validStatus: statusCategoryCls)
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.suspendVcStatusObserver)
        myAssetDataManager.uniqueInstance.suspendVcStatusObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"StatusUpdated"), object: nil, queue: nil){ notification in
            self.StatusUpdated(notification: notification)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        defer { initialized = true }
        guard !initialized else { super.viewDidAppear(animated);
            return }
        setupPageView()
        setupComponent()
        setupAnimator()
        setPages(self.suspendViewModel.setViewControllers())
        setupAutoLayout()
        pageViewController.scrollPageView?.isScrollEnabled = false
        var title = String()
        if isFromScreen == "Complete" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title = "Complete_Operation".localized()
            }else{
                title = "Complete_WorkOrder".localized()
            }
        }else if isFromScreen == "Suspend" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title = "Suspend_Operation".localized()
            }else{
                title = "Suspend_WorkOrder".localized()
            }
        }else if isFromScreen == "Hold"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title = "Hold_Operation".localized()
            }else{
                title = "Hold_WorkOrder".localized()
            }
        }
        
        if DeviceType == iPhone{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "\(title)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"Back")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }else{
            DispatchQueue.main.async {
                self.headerLabel.text = "\(title)"
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Page Swiper Methods
    
    private func setupCell() {
        mJCLogger.log("Starting", Type: "info")
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
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
        pageViewController.isPageFrom = "suspend"
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
        itemsFrame.removeAll()
        for i in 0 ... self.items.count{
            let frame = CGRect(x: i * 130 , y: 0, width: 130, height: 60)
            itemsFrame.append(frame)
        }
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
        let firstCellFrame = itemsFrame[0]
        initialAction = {
            let barFrame = self.selectedBar.frame
            self.selectedBar.frame = CGRect(x: firstCellFrame.origin.x,
                                            y: barFrame.origin.y,
                                            width: firstCellFrame.width,
                                            height: barFrame.height)
        }
        pageViewController.setAnimators(needSearchTab: false,
                                        animators: animators,
                                        originalActions: actions,
                                        initialAction: initialAction)
        mJCLogger.log("Ended", Type: "info")
        
    }
    private func setPages(_ viewControllers: [UIViewController]) {
        
        mJCLogger.log("Starting", Type: "info")
        guard viewControllers.count == items.count
        else { fatalError("The number of ViewControllers must equal to the number of TabItems.") }
        pageViewController.setPages(viewControllers)
        mJCLogger.log("Ended", Type: "info")
        
    }
    private func setupAutoLayout() {
        
    }
    private func setTabItem(_ items: [TabItem]) {
        mJCLogger.log("Starting", Type: "info")
        self.items = items
        if items.count>0{
            for i in 0 ... self.items.count - 1 {
                let item = self.items[i]
                var width: CGFloat
                let fontSize = (1 / 1366 * view.frame.width) * self.items[i].font.pointSize
                self.items[i].font = item.font.withSize(fontSize)
                width = item.cellWidth == nil ? defaultCellHeight! : item.cellWidth!
                itemsWidths.append(width)
            }
            itemsWidths = recalculateWidths()
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func recalculateWidths() -> [CGFloat]  {
        
        mJCLogger.log("Starting", Type: "info")
        var itemsWidths: [CGFloat] = []
        let cellMarginSum = CGFloat(items.count - 1) * eachLineSpacing
        let maxWidth = CGFloat(items.count) * 130.0
        var cellSizeSum: CGFloat = 0
        self.itemsWidths.forEach {
            cellSizeSum += $0
        }
        let extraMargin = maxWidth - (sectionInset.right + sectionInset.left + cellMarginSum + cellSizeSum)
        let distributee = items.count
        guard extraMargin > 0 else {
            self.itemsWidths.removeAll()
            for i in 0 ... items.count - 1 {
                let item = items[i]
                var width: CGFloat = 0
                let fontSize = items[i].font.pointSize * 0.9 // * 0.9, 0.8, 0.7, 0.65, 0.6, 0.5 ...
                items[i].font = item.font.withSize(fontSize)
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
        self.selectedIndex = index
        pageViewController.moveTo(index: index)
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    private func labelWidth(text: String, font: UIFont) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text + "AAAAA"
        label.sizeToFit()
        mJCLogger.log("Ended", Type: "info")
        return label.frame.width
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.suspendVcStatusObserver)
        self.dismiss(animated: true, completion: nil)
    }
    func NewJobButtonClicked(_ sender: UIButton?){
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
    func refreshButtonClicked(_ sender: UIButton?){
        self.refreshButtonAction(sender: sender!)
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        super.viewWillAppear(animated)
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func StatusUpdated(notification : Notification) {
        
        mJCLogger.log("Starting", Type: "info")
        var popUpMsgStr = String()
        mJCLoader.stopAnimating()
        if isFromScreen == "Complete" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                popUpMsgStr = "Operation_Completed_Sucessfully".localized()
            }else{
                popUpMsgStr = "WorkOrder_completed_successfully".localized()
            }
        }else if isFromScreen == "Suspend" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                popUpMsgStr = "Operation_Suspended_successfully".localized()
            }else{
                popUpMsgStr = "WorkOrder_Suspended_successfully".localized()
            }
        }else if isFromScreen == "Hold"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                popUpMsgStr = "Operation_Holded_Sucessfully".localized()
            }else{
                popUpMsgStr = "WorkOrder_Holded_Successfully".localized()
            }
        }else {
            popUpMsgStr = ""
        }
        let params = Parameters(
            title: MessageTitle,
            message: popUpMsgStr,
            cancelButton: okay
        )
        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                DispatchQueue.main.async {
                    NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.suspendVcStatusObserver)
                    if self.statusCategoryCls.PostConfirmations == "X" && !self.suspendViewModel.featurelist.contains("COMPLETIONCONFIRMATION"){
                        if self.statusLogset.StatusChangedTime != nil{
                            let date = self.statusLogset.StatusChangedTime!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: self.statusLogset.StatusTime)
                            let datetime = Date(fromString: "\(date) \(time)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            myAssetDataManager.uniqueInstance.postoperationconformation(changeDate: datetime, toDate: Date().localDate(), statusCategoryObj: self.statusCategoryCls, flushReq: true)
                        }
                    }
                    self.dismiss(animated: false) {}
                }
            default: break
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func dismissViewController() {
        mJCLogger.log("Starting", Type: "info")
        let params = Parameters(
            title: alerttitle,
            message: "Are_you_sure_want_to_quit_The_data_wiil_be_lost".localized(),
            cancelButton: "YES".localized(),
            otherButtons: ["NO".localized()]
        )
        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.suspendVcStatusObserver)
                self.dismiss(animated: false, completion: {})
            case 1: break
            default: break
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- HeaderView Button Outlets..
    @IBAction func backButtonAction(sender: AnyObject) {
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.suspendVcStatusObserver)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func menuButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }else{
            menuarr = ["Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }
        
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        dropDown.dataSource = menuarr
        self.customizeDropDown(imgArry: imgArray)
        dropDown.anchorView = sender as! UIButton
        dropDown.cellHeight = 40.0
        dropDown.width = 200.0
        dropDown.backgroundColor = UIColor.white
        dropDown.textColor = appColor
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Refersh Button Tapped".localized(), Type: "")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
    }
    @IBAction func locationButtonAction(sender: AnyObject) {
        menuDataModel.uniqueInstance.presentMapSplitScreen()
    }
    @IBAction func homeButtonAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.showImage = true
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if defaultCellHeight == nil {
            defaultCellHeight = self.menuCollectionView.frame.height
            setTabItem(suspendViewModel.setTabItems())
            pageViewController.itemCount = items.count
        }
        return items.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let index = indexPath.row
        let cell = ScreenManager.getTabCell(collectionView: collectionView,indexPath:indexPath)
        guard let tabCell = cell as? TabCell else { return cell }
        tabCell.index = index
        tabCell.delegate = self
        tabCell.suspendModel = items[index]
        tabCell.indexPath = indexPath
        tabCell.contentView.backgroundColor = appColor
        tabCell.cellView.backgroundColor = appColor
        if DeviceType == iPhone{
            tabCell.titleLabel.font = .systemFont(ofSize: 14)
        }
        if self.selectedIndex == indexPath.row{
            tabCell.selectedView.backgroundColor = UIColor.white
            tabCell.titleLabel.textColor = UIColor.white
            self.menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }else {
            tabCell.selectedView.backgroundColor = appColor
            tabCell.titleLabel.textColor = UIColor.lightText
        }
        return tabCell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets()
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(self.items.count)
        return CGSize(width: width - 5.0, height: 60)
    }
}

