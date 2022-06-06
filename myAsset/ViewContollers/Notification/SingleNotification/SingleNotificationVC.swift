//
//  SingleNotificationVC.swift
//  myJobCard
//
//  Created by Alphaved on 08/03/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SingleNotificationVC: UIViewController,UIGestureRecognizerDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TabCellDelegate,PageViewParent,UITableViewDelegate,UITableViewDataSource {
    

    //MARK:- Headerview Outlets..
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var workOrderNumberLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var addNewJobButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var attachmentImageVIew: UIImageView!
    @IBOutlet var attachmentWidthConst: NSLayoutConstraint!
    @IBOutlet var locationButtonWidthConst: NSLayoutConstraint!
    @IBOutlet var HomeButton: UIButton!
    @IBOutlet var notificationBottomView: UIView!
    @IBOutlet var lastSyncDateLabel: UILabel!
    
    //MARK:- NSLayoutConstraint Outlets..
    
    @IBOutlet open weak var menuCollectionView: UICollectionView!
    @IBOutlet open weak var selectedBar: UIView!
    @IBOutlet open weak var pageView: UIView!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet var statusView: UIView!
    @IBOutlet var statusCollectionView: UICollectionView!
    @IBOutlet weak var SingleNOCompleteTableView: UITableView!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var notificationNum = NSString()
    var selecteHeaderButton = NSString()
    var statusArray = NSMutableArray()
    var allowedStatusArray = NSMutableArray()
    var attachmentArray = [AttachmentModel]()
    let menudropDown = DropDown()
    var dropDownString = String()
    let remainsTaskTextArray = NSMutableArray()
    var validateCond: Bool = false
    var status = String()
    var singleNoViewModel = SingleNotificationViewModel()
    // MARK: Page Swipe Inputs
    public var items: [TabItem] = []
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
    public var borderColor: UIColor = .lightGray {
        didSet {
            borderView.backgroundColor = borderColor
        }
    }
    private var initialized: Bool = false
    private var defaultCellHeight: CGFloat?
    private var itemsFrame: [CGRect] = []
    private var itemsWidths: [CGFloat] = []
    var tabItemArray = Array<TabItem>()
    // Page Swipe Inputs End
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.statusCollectionView.backgroundColor = appColor
        if DeviceType == iPad{
            self.lastSyncDateLabel.backgroundColor = appColor
            self.lastSyncDateLabel.textColor = .white
        }
        singleNoViewModel.vc = self
        initialIndex = 0
        selectedIndex = 0
        pageViewController.parentVC = self
        setupCell()
        if DeviceType == iPhone{
            selectedBar.isHidden = true
        }else{
            selectedBar.isHidden = false
        }
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.statusCollectionView.delegate = self
        self.statusCollectionView.dataSource = self
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
        SingleNOCompleteTableView.rowHeight = UITableView.automaticDimension
        self.attachmentImageVIew.isHidden = true
        self.attachmentWidthConst.constant = 0.0
        workOrderNumberLabel.text = "Notification_No".localized() + ". \(selectedNotificationNumber)"
        alertImage.layer.cornerRadius =  alertImage.frame.size.height / 2
        alertImage.layer.masksToBounds = true
        attachmentImageVIew.layer.cornerRadius =  alertImage.frame.size.height / 2
        attachmentImageVIew.layer.masksToBounds = true
        self.selecteHeaderButton = "OverView"
        let tap = UITapGestureRecognizer(target: self, action: #selector(SingleNotificationVC.handleTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        if (UserDefaults.standard.value(forKey:"lastSyncDate") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate") as! Date
            self.lastSyncDateLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncDateLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate),timeZone: .utc,locale: .current))"
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"setSingleNotificationItemCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.setSingleNotificationItemCount(notification:)), name:NSNotification.Name(rawValue:"setSingleNotificationItemCount"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"setSingleNotificationTaskCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.setSingleNotificationTaskCount(notification:)), name:NSNotification.Name(rawValue:"setSingleNotificationTaskCount"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"setSingleNotificationActivityCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.setSingleNotificationActivityCount(notification:)), name:NSNotification.Name(rawValue:"setSingleNotificationActivityCount"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"setNotificationAttachmentCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.setNotificationAttachmentCount(notification:)), name:NSNotification.Name(rawValue:"setNotificationAttachmentCount"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"StatusUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.StatusUpdated(notification:)), name:NSNotification.Name(rawValue:"StatusUpdated"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingleNotificationVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownString == "Menu" {
                if item == "Work_Orders".localized() {
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        currentMasterView = "WorkOrder"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
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
                }else if item == "Master_Data_Refresh".localized() {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5) {
                            self.SingleNOCompleteTableView.isHidden = true
                            mJCLoader.startAnimating(status: "Uploading".localized())
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                            })
                        }
                    }
                }else if item == "Asset_Map".localized() {
                    ASSETMAP_TYPE = "ESRIMAP"
                   assetmapVC.openmappage(id: "")
                }else if item == "Settings"{
                    let settingsVC = ScreenManager.getSettingsScreen()
                    settingsVC.modalPresentationStyle = .fullScreen
                    self.present(settingsVC, animated: false, completion: nil)
                }else if item == "Log_Out".localized() {
                    myAssetDataManager.uniqueInstance.logOutApp()
                }else if item == "Error_Logs".localized() {
                    myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
                }
            }
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"Reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "Reload"), object: nil)
        self.SingleNOCompleteTableView.delegate = self
        self.SingleNOCompleteTableView.dataSource = self
        self.SingleNOCompleteTableView.layer.borderColor = UIColor.darkGray.cgColor
        self.SingleNOCompleteTableView.layer.borderWidth = 2
        self.SingleNOCompleteTableView.layer.cornerRadius = 15
        self.SingleNOCompleteTableView.layer.masksToBounds = true
        self.SingleNOCompleteTableView.isHidden = true
        self.setSingleNOCompleteTableViewLayout()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        self.singleNoViewModel.getNotificationList()
        defer { initialized = true }
        guard !initialized else { super.viewDidAppear(animated); return }
        setupComponent()
        setupPageView()
        setupAnimator()
        setPages(viewControllers())
        setupAutoLayout()
        mJCLogger.log("Ended", Type: "info")
    }
    func setSingleNOCompleteTableViewLayout()  {
        mJCLogger.log("Starting", Type: "info")
        self.SingleNOCompleteTableView.layer.shadowColor =  UIColor.red.cgColor
        self.SingleNOCompleteTableView.layer.shadowOffset = CGSize(width: -2.0, height: 2.0)
        self.SingleNOCompleteTableView.layer.shadowRadius = 3.0
        
        self.SingleNOCompleteTableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.SingleNOCompleteTableView.bounces = false
        self.SingleNOCompleteTableView.layer.cornerRadius = 2.0
        self.SingleNOCompleteTableView.layer.masksToBounds = true
        self.SingleNOCompleteTableView.estimatedRowHeight = 50
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func loadList(notification:Notification){
        mJCLogger.log("Starting", Type: "info")
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.stopAnimating()
        mJCLogger.log("Store Flush And Refresh Done..".localized(), Type: "")
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        self.singleNoViewModel.getNotificationList()
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Notification Attachment Count..
    @objc func setNotificationAttachmentCount(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.singleNoViewModel.getNOAttachmentSet()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TableView Delegate and DataSource..
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.remainsTaskTextArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let completeWOStatusCell = tableView.dequeueReusableCell(withIdentifier: "CompleteWorkorderStatusCell") as! CompleteWorkorderStatusCell
        completeWOStatusCell.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tableView.separatorStyle = .none
        mJCLogger.log("Response:\(self.remainsTaskTextArray.count)", Type: "Debug")
        completeWOStatusCell.remainsStatusLabel?.text = self.remainsTaskTextArray[indexPath.row] as? String
        completeWOStatusCell.alertLabel.layer.cornerRadius = completeWOStatusCell.alertLabel.frame.height / 2
        completeWOStatusCell.alertLabel.layer.masksToBounds = true
        mJCLogger.log("Ended", Type: "info")
        return completeWOStatusCell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //Mark:- Collection View delegate & Data source
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == menuCollectionView{
            if defaultCellHeight == nil {
                defaultCellHeight = self.menuCollectionView.frame.height
                setTabItem(tabItems())
            }
            return items.count
        }else{
            return statusArray.count
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        mJCLogger.log("Starting", Type: "info")
        if collectionView == menuCollectionView{
            let index = indexPath.row
            let cell = ScreenManager.getTabCell(collectionView: menuCollectionView,indexPath:indexPath)
            menuCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            guard let tabCell = cell as? TabCell else { return cell }
            tabCell.delegate = self
            tabCell.index = index
            tabCell.countLabel.layer.cornerRadius = tabCell.countLabel.frame.size.height/2
            tabCell.countLabel.layer.masksToBounds = true
            tabCell.titleLabel.textColor = appColor
            tabCell.titleLabel.font = items[index].font
            tabCell.imageView.image = items[index].image
            tabCell.titleLabel.isHidden = false
            tabCell.titleLabel.text = items[index].title
            tabCell.titleLabel.font = .systemFont(ofSize: 16)
            tabCell.selectedView.tag = indexPath.row
            tabCell.isUserInteractionEnabled = true
            if selectedIndex == indexPath.row{
                tabCell.selectedView.backgroundColor = appColor
            }else{
                tabCell.selectedView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            tabCell.countLabel.isHidden = true
            if currentMasterView == "Notification"{
                if tabCell.titleLabel.text == "Items".localized() {
                    if ItemCount != ""{
                        tabCell.countLabel.text = ItemCount
                        tabCell.countLabel.isHidden = false
                        tabCell.countLabel.backgroundColor = appColor
                    }
                }
                if tabCell.titleLabel.text == "Activities".localized(){
                    if ActvityCount != ""{
                        tabCell.countLabel.text = ActvityCount
                        tabCell.countLabel.isHidden = false
                        tabCell.countLabel.backgroundColor = appColor
                    }
                }
                if tabCell.titleLabel.text == "Tasks".localized() {
                    if TaskCount != ""{
                        tabCell.countLabel.text = TaskCount
                        tabCell.countLabel.isHidden = false
                        tabCell.countLabel.backgroundColor = appColor
                    }
                }
                if tabCell.titleLabel.text == "Attachments".localized() {
                    if noAttchmentCount != ""{
                        tabCell.countLabel.text = noAttchmentCount
                        tabCell.countLabel.isHidden = false
                        tabCell.countLabel.backgroundColor = appColor
                    }
                }
                if tabCell.titleLabel.text == "Histoty_Pending".localized() || title == "Overview".localized(){
                    tabCell.countLabel.isHidden = true
                }
            }
            itemsFrame.append(tabCell.frame)
            mJCLogger.log("Ended", Type: "info")
            return tabCell
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCollectionCell", for: indexPath as IndexPath) as! StatusCollectionCell
            let validStatusClass = statusArray[indexPath.row] as! StatusCategoryModel
            cell.indexpath = indexPath
            cell.singleNotifViewModel = singleNoViewModel
            cell.singleViewNotificationClass = singleNotification
            cell.StatuButton.setImage(UIImage(named:validStatusClass.ImageResKey), for: .normal)
            cell.statusTitle.text = validStatusClass.StatusDescKey
            cell.StatuButton.tag = indexPath.row
            cell.tintColor = .white
            cell.statusTitle.textColor = .white
            mJCLogger.log("Ended", Type: "info")
            return cell
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        mJCLogger.log("Starting", Type: "info")
        if collectionView == statusCollectionView{
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
        }else{
            mJCLogger.log("Ended", Type: "info")
            return UIEdgeInsets()
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = indexPath.row
        if collectionView == menuCollectionView{
            width = Int(itemsWidths[indexPath.row])
            return CGSize(width: width, height: 60)
        }else{
            return CGSize(width: 200, height: 60)
        }
    }
    //MARK:- Set Label Layout..
    func setLabelLayout(label : UILabel) {
        mJCLogger.log("Starting", Type: "info")
        label.layer.cornerRadius = label.frame.width/2
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.red
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        UIView.animate(withDuration: 0.5) {
            self.SingleNOCompleteTableView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getWorkFlowSet(validClass:StatusCategoryModel,from:String) {
        
        mJCLogger.log("Starting", Type: "info")
        var screenKey = ""
        var workFlowObj = ""
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: validClass.StatusCode, orderType: "X",from:"NOTIFICATIONLEVEL")
        if let workflowObj = workFlowResp as? LtWorkFlowModel {
            screenKey = workflowObj.ActionKey
            workFlowObj = workflowObj.ActionType
        }
        if workFlowObj == "Screen" {
            if screenKey == "key_NO_SC_REJC"{
                DispatchQueue.main.async {
                    let rejectVC = ScreenManager.getWorkOrderTransferScreen()
                    rejectVC.rejectString = "Reject"
                    rejectVC.screenfrom = "Notification"
                    rejectVC.statusCategoryCls = validClass
                    rejectVC.modalPresentationStyle = .fullScreen
                    self.present(rejectVC, animated: false) {}
                }
            }else if screenKey == "key_NO_SC_COMP"{
                if validClass.PreCheck == 1 {
                    self.setRemainsTaskText()
                }
                UIView.animate(withDuration: 10.0) {
                    if self.remainsTaskTextArray.count > 0 {
                        if DeviceType == iPad{
                            DispatchQueue.main.async {
                                self.SingleNOCompleteTableView.isHidden = false
                                self.SingleNOCompleteTableView.reloadData()
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            let transferVC = ScreenManager.getWorkOrderTransferScreen()
                            transferVC.rejectString = "Complete"
                            transferVC.screenfrom = "Notification"
                            transferVC.statusCategoryCls = validClass
                            transferVC.modalPresentationStyle = .fullScreen
                            self.present(transferVC, animated: false) {}
                        }
                    }
                }
            }else{
                WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleNotification,flushRequired: true)
            }
        }else if workFlowObj == "Action" {
            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: "", objStatus: validClass.StatusCode,objClass: singleNotification,flushRequired: true)
        }else if workFlowObj == "FORM" || workFlowObj == "Form"{
            myAssetDataManager.uniqueInstance.getFormsPage(formDetails: screenKey, screen: self, statusCategoryCls: validClass, formFrom: from)
        }else {
            myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setRemainsTaskText() {
        mJCLogger.log("Starting", Type: "info")
        self.remainsTaskTextArray.removeAllObjects()
        var orderType = String()
        orderType = singleNotification.NotificationType
        if let featurs =  orderTypeFeatureDict.value(forKey: orderType) as? NSArray{
            if let featureDict = featurs[0] as? NSMutableDictionary {
                if featureDict.allKeys.count > 0 {
                    let featurelist = featureDict.allKeys as NSArray
                    if (featurelist.contains("NOTIFICATION") || featurelist.contains("ITEMCAUSE") || featurelist.contains("ITEM")) && singleNotification.Notification != ""{
                        if  let notififeatures = orderTypeFeatureDict.value(forKey: singleNotification.NotificationType) as? NSMutableArray{
                            if NOItemCount == 0 && notififeatures.contains("ITEM"){
                                let recordText = "It_is_mandatory_to_have_Atleast_One_Notification_Item".localized()
                                self.remainsTaskTextArray.add(recordText)
                            }
                            if NOItemCauseCount == 0 && notififeatures.contains("ITEMCAUSE")
                            {
                                let recordText = "It_is_mandatory_to_have_Atleast_One_Notification_Item_Cause".localized()
                                self.remainsTaskTextArray.add(recordText)
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        if singleNotification.Breakdown == "X" && (singleNotification.MalfunctEnd == nil || (singleNotification.MalfunctEndTime.hours == 0 && singleNotification.MalfunctEndTime.minutes == 0 && singleNotification.MalfunctEndTime.seconds == 0)){
            let recordText = "Pleas_provide_the_malfunction_end_date_time_as_the_breakdown_is_notified_for_the_notification".localized()
            self.remainsTaskTextArray.add(recordText)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- HeaderView Button Actions..
    @IBAction func menuButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "WorkOrder"
        singleNotification =  NotificationModel()
        selectedNotificationNumber = ""
        self.dismiss(animated: false)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func moreButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }else{
            menuarr = ["Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
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
    @IBAction func refreshButtonButton(sender: AnyObject) {
        
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
        singleNotification =  NotificationModel()
        selectedNotificationNumber = ""
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
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
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
    //MARK:- More button View Actions..
    @IBAction func notificationsButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        singleNotification =  NotificationModel()
        selectedNotificationNumber = ""
        if currentMasterView == "Notification" {
            DispatchQueue.main.async {
                currentMasterView = "WorkOrder"
                let splitVC = ScreenManager.getListSplitScreen()
                self.appDeli.window?.rootViewController = splitVC
                self.appDeli.window?.makeKeyAndVisible()
            }
        }else if currentMasterView == "WorkOrder" {
            DispatchQueue.main.async {
                currentMasterView = "Notification"
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                let splitVC = ScreenManager.getListSplitScreen()
                self.appDeli.window?.rootViewController = splitVC
                self.appDeli.window?.makeKeyAndVisible()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func timeSheetButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            singleNotification =  NotificationModel()
            selectedNotificationNumber = ""
            let timeSheetVC = ScreenManager.getTimeSheetScreen()
            self.appDeli.window?.rootViewController = timeSheetVC
            self.appDeli.window?.makeKeyAndVisible()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func masterRefreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func logoutButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.logOutApp()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func StatusUpdated(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        status = singleNotification.UserStatus
        isActiveNotification = WorkOrderDataManegeClass.uniqueInstance.getConsidereAsActive(status: singleNotification.UserStatus, from: "Notification")
        self.singleNoViewModel.getAllowedStatus(status: status)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func backGroundSyncStarted(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Notification Item Count
    @objc func setSingleNotificationItemCount(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.singleNoViewModel.setNotificationItemBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Notification Item Count
    @objc func setSingleNotificationTaskCount(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.singleNoViewModel.setNotificationTaskBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Notification Item Count
    @objc func setSingleNotificationActivityCount(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.singleNoViewModel.setNotificationActivityBadgeCount()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Page Swiper Methods
    func tabItems() -> [TabItem] {
        
        mJCLogger.log("Starting", Type: "info")
        let OverviewTab  = TabItem(title: "Overview".localized(), image: UIImage(named: "overview"))
        let HAndPTab       = TabItem(title: "History_Pending".localized(), image: UIImage(named: "history_pending"))
        let NoItemTab      =  TabItem(title: "Items".localized(), image: UIImage(named: "items"))
        let NoActivityTab  =  TabItem(title: "Activities".localized(), image: UIImage(named: "activities"))
        let NoTaskTab      =  TabItem(title: "Tasks".localized(), image: UIImage(named: "tasks"))
        let NoAttchmentTab =  TabItem(title: "Attachments".localized(), image: UIImage(named: "attachment"))
        tabItemArray.append(OverviewTab)
        if applicationFeatureArrayKeys.contains("WoNoItems"){
            tabItemArray.append(NoItemTab)
        }
        if applicationFeatureArrayKeys.contains("WoNoActivities"){
            tabItemArray.append(NoActivityTab)
        }
        if applicationFeatureArrayKeys.contains("WoNoTasks"){
            tabItemArray.append(NoTaskTab)
        }
        if applicationFeatureArrayKeys.contains("WoNoAttachments"){
            tabItemArray.append(NoAttchmentTab)
        }
        if applicationFeatureArrayKeys.contains("WoNoHistPend"){
            tabItemArray.append(HAndPTab)
        }
        
        mJCLogger.log("Ended", Type: "info")
        return tabItemArray
        
    }
    func viewControllers() -> [UIViewController] {
        
        mJCLogger.log("Starting", Type: "info")
        let notificationOverViewVC = ScreenManager.getNotificationOverViewScreen()
        var array = [notificationOverViewVC]
        mJCLogger.log("Ended", Type: "info")
        return array
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
        mJCLogger.log("Reason : " + "The number of ViewControllers must equal to the number of TabItems.", Type: "Error")
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
        self.items = items
        for i in 0 ... self.items.count - 1 {
            let item = self.items[i]
            var width: CGFloat
            let fontSize = (1 / 1366 * view.frame.width) * self.items[i].font.pointSize
            self.items[i].font = item.font.withSize(fontSize)
            //                    width = labelWidth(text: item.title!, font: item.font)
            width = item.cellWidth == nil ? defaultCellHeight! : item.cellWidth!
            itemsWidths.append(width)
        }
        itemsWidths = recalculateWidths()
        mJCLogger.log("Ended", Type: "info")
    }
    private func recalculateWidths() -> [CGFloat]  {
        
        mJCLogger.log("Starting", Type: "info")
        var itemsWidths: [CGFloat] = []
        let cellMarginSum = CGFloat(items.count - 1) * eachLineSpacing
        let maxWidth = CGFloat(items.count) * 130.0 // view.frame.width
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
        selectedIndex = index
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
        label.text = text + " AA AA AA "
        label.sizeToFit()
        mJCLogger.log("Ended", Type: "info")
        return label.frame.width
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
}

