//
//  MasterViewController.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/27/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import CoreData
import ODSFoundation
import mJCLib

class MasterListVC: UIViewController, NSFetchedResultsControllerDelegate,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UISearchBarDelegate,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate,filterDelegate, CreateUpdateDelegate,viewModelDelegate,barcodeDelegate{

    //MARK: - Outlets..
    @IBOutlet var profileView: UIView!
    @IBOutlet var totalWorkOrderLabel: UILabel!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var filterview: UIView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchInView: UIView!
    @IBOutlet var tableViewSuperView: UIView!
    @IBOutlet var workOrderTableView: UITableView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet var addWorkFormButton: UIButton!
    @IBOutlet var priorityButton: UIButton!
    @IBOutlet var scanButton: UIButton!
    @IBOutlet weak var activeOrderWidthconstant: NSLayoutConstraint!
    @IBOutlet weak var ActiveOrderButton: UIButton!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var iPhoneView: UIView!
    
    //MARK: - Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var showMore = false
    var numberofSection = 2
    var lastContentOffset: CGFloat = 0
    var priortySort : Bool = false
    var dateSort : Bool = false
    var orderSort: Bool = true
    var techIdEquipmentList = [String]()
    var masterViewModel = MasterViewModel()
    var skipvalue = masterDataLoadingItems
    weak var delegate: listSelectionDelegate?

    //MARK: - LifeCycle..
    override func viewDidLoad() {
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        masterViewModel.delegate = self
        searchTextField.delegate = self
        self.workOrderTableView.estimatedRowHeight = 135
        self.registerNotificationObservers()
        self.registerTableViewNibs()
        self.setBasicView()
        self.setListDetails()
        searchTextField.compatibleSearchTextField.backgroundColor = UIColor.white
        searchTextField.setImage(UIImage(), for: .search, state: .normal)
        ODSUIHelper.setBorderToView(view:self.searchInView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        super.viewWillAppear(animated)
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            var title = ""
            if currentMasterView == "Notification"{
                title = "Notifications".localized()
            }else{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5" {
                    title = "Operations".localized()
                }else{
                    title = "Work_Orders".localized()
                }
            }
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: title, NewJobButton: true, refresButton: true, threedotmenu: false, leftMenuType: "")
            self.iPhoneView.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            self.updateSlideMenu()
        }
        mJCLoader.stopAnimating()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: Basic Methods
    func registerNotificationObservers(){
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.masterFlushObserver)
        myAssetDataManager.uniqueInstance.masterFlushObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil, queue: nil){ notification in
            self.storeFlushAndRefreshDone(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.masterStatusObserver)
        myAssetDataManager.uniqueInstance.masterStatusObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"StatusUpdated"), object: nil, queue: nil){ notification in
            self.statusUpdated(notification: notification)
        }
        NotificationCenter.default.removeObserver(myAssetDataManager.uniqueInstance.masterRecordPointObserverr)
        myAssetDataManager.uniqueInstance.masterRecordPointObserverr = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"getRecordPointCount"), object: nil, queue: nil){ notification in
            self.getCurrentReadingNotification(notification: notification)
        }
    }
    func setBasicView(){
        if DeviceType == iPad{
            self.profileNameLabel.text = userDisplayName
            self.profilePetNameLabel.text = userSystemID.lowercased()
            self.searchInView.layer.cornerRadius = 3.0
            self.searchInView.layer.borderWidth = 1.0
            self.searchInView.layer.borderColor = UIColor.lightGray.cgColor
            self.searchInView.layer.masksToBounds = true
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
            self.profileView.layer.masksToBounds = true
        }else{
            self.searchInView.layer.borderWidth = 1.0
            //self.searchInView.layer.borderColor = UIColor.lightGray.cgColor
            self.searchInView.layer.masksToBounds = true
        }
        self.filterCountLabel.layer.cornerRadius = self.filterCountLabel.frame.size.width / 2
        self.filterCountLabel.layer.masksToBounds = true
        self.setAppfeature()
        didSelectedCell = 0
        did_DeSelectedCell = 0
        if onlineSearch == true{
            self.activeOrderWidthconstant.constant = 0.0
            self.ActiveOrderButton.isHidden = true
        }else{
            self.activeOrderWidthconstant.constant = 40.0
            self.ActiveOrderButton.isHidden = false
        }
    }
    func registerTableViewNibs(){
        ScreenManager.registerWorkOrderCell(tableView: self.workOrderTableView)
        ScreenManager.registerLoadingTableViewCell(tableView: self.workOrderTableView)
    }
    func setListDetails(){
        if currentMasterView == "Notification" {
            masterViewModel.setListDetails(assignment: "")
        }else{
            masterViewModel.setListDetails(assignment: WORKORDER_ASSIGNMENT_TYPE)
        }
        dateSort = true
    }
    func navigateToDetailsScreen(selectedIndex:Int){
        if DeviceType == iPad{
            if currentMasterView == "WorkOrder" {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    if masterViewModel.woNoArray.indices.contains(selectedIndex){
                        if let operation = masterViewModel.woNoArray[selectedIndex] as? WoOperationModel{
                            singleOperation = operation
                            if selectedworkOrderNumber != singleOperation.WorkOrderNum && selectedOperationNumber != singleOperation.OperationNum {
                                selectedOperationNumber = ""
                                selectedComponentNumber = ""
                            }
                            selectedworkOrderNumber = singleOperation.WorkOrderNum
                            selectedOperationNumber = singleOperation.OperationNum
                            if onlineSearch == true{
                                if let arr = onlineSearchArray as? [WoHeaderModel]{
                                    let woArray = arr.filter{$0.WorkOrderNum == selectedworkOrderNumber}
                                    if woArray.count > 0{
                                        singleWorkOrder = woArray[0]
                                    }
                                }
                            }else{
                                let woArray = allworkorderArray.filter{$0.WorkOrderNum == singleOperation.WorkOrderNum}
                                if woArray.count > 0{
                                    singleWorkOrder = woArray[0]
                                }
                            }
                        }
                    }else{
                        singleOperation = WoOperationModel()
                        singleWorkOrder = WoHeaderModel()
                        selectedworkOrderNumber = ""
                        selectedOperationNumber = ""
                    }
                    self.delegate?.listObjectSelected!()
                }else{
                    if masterViewModel.woNoArray.indices.contains(selectedIndex){
                        if let workOrder = masterViewModel.woNoArray[selectedIndex] as? WoHeaderModel{
                            singleWorkOrder = workOrder
                            if selectedworkOrderNumber != singleWorkOrder.WorkOrderNum {
                                selectedOperationNumber = ""
                                selectedComponentNumber = ""
                                selectedworkOrderNumber = ""
                            }
                            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                        }else{
                            selectedOperationNumber = ""
                            selectedComponentNumber = ""
                            selectedworkOrderNumber = ""
                        }
                        self.delegate?.listObjectSelected!()
                    }
                }
            }else if currentMasterView == "Notification" {
                if masterViewModel.woNoArray.indices.contains(selectedIndex){
                    if let notification = masterViewModel.woNoArray[selectedIndex] as? NotificationModel{
                        singleNotification = notification
                        if selectedNotificationNumber != singleNotification.Notification {
                            selectedAcitivity = ""
                            selectedItem = ""
                            selectedTask = ""
                        }
                        selectedNotificationNumber = singleNotification.Notification
                    }
                }else{
                    selectedAcitivity = ""
                    selectedItem = ""
                    selectedTask = ""
                }
                self.delegate?.listObjectSelected!()
            }
        }
    }
    func reloadWorkorderTableView(){
        DispatchQueue.main.async{
            self.workOrderTableView.reloadData()
        }
    }
    //MARK: NS Notifications KVO
    @objc func storeFlushAndRefreshDone(notification: Notification) {
        mJCLogger.log("Starting", Type: "info")
        if !isSingleNotification {
            if dashboardFilterDic.count != 0{
                var firstFilterItem = String()
                var secondFilterItem = String()
                var thirdFilterArr = [String]()
                var fourthFilterArr = [String]()
                if let firstFilter = dashboardFilterDic["First"] as? String{
                    firstFilterItem = firstFilter
                }
                if let secondFilter = dashboardFilterDic["Second"] as? String{
                    secondFilterItem = secondFilter
                }
                if let firstFilter = dashboardFilterDic["Third"] as? String{
                    thirdFilterArr = firstFilter.components(separatedBy: ";")
                }
                if let firstFilter = dashboardFilterDic["Fourth"] as? String{
                    fourthFilterArr = firstFilter.components(separatedBy: ";")
                }
                if currentMasterView == "WorkOrder"{
                    if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"){
                        if !applicationFeatureArrayKeys.contains("DASH_OPR_TILE"){
                            let filterDict = WorkOrderFiltersViewModel().applyWoFilter(firstFilterItem: firstFilterItem, secondFilterItem: secondFilterItem, thirdFilterArr: thirdFilterArr, fourthFilterArr: fourthFilterArr, from: "")
                            if let arr = filterDict["List"] as? [WoHeaderModel]{
                                var woListArr = [String]()
                                for item in arr{
                                    if !woListArr.contains(item.WorkOrderNum){
                                        woListArr.append(item.WorkOrderNum)
                                    }
                                }
                                if woListArr.count > 0 {
                                    masterViewModel.woNoListArray = allOperationsArray
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woListArr as [AnyObject])
                                    let array = masterViewModel.woNoListArray.filter{predicate.evaluate(with: $0)}
                                    masterViewModel.woNoArray = array as! [WoOperationModel]
                                }
                            }
                        }else{
                            let filterDict = OperationFiltersViewModel().applyOperationFilter(firstFilterItem: firstFilterItem, secondFilterItem: secondFilterItem, thirdFilterArr: thirdFilterArr, fourthFilterArr: fourthFilterArr, from: "")
                            if let arr = filterDict["List"] as? [WoHeaderModel]{
                                masterViewModel.woNoListArray = allworkorderArray
                                masterViewModel.woNoArray = arr
                            }
                        }
                    }else{
                        let filterDict = WorkOrderFiltersViewModel().applyWoFilter(firstFilterItem: firstFilterItem, secondFilterItem: secondFilterItem, thirdFilterArr: thirdFilterArr, fourthFilterArr: fourthFilterArr, from: "")
                        if let arr = filterDict["List"] as? [WoHeaderModel]{
                            masterViewModel.woNoListArray = allworkorderArray
                            masterViewModel.woNoArray = arr
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func getCurrentReadingNotification(notification: Notification) {
        mJCLogger.log("Starting", Type: "info")
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && onlineSearch == false{
            self.getCurrentReading(objectType: singleOperation)
        }else{
            self.getCurrentReading(objectType: singleWorkOrder)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func statusUpdated(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if DeviceType == iPhone{
                if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5" ) && onlineSearch == false{
                    self.getCurrentReading(objectType: singleOperation)
                }else{
                    self.getCurrentReading(objectType: singleWorkOrder)
                }
            }
            self.workOrderTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func getCurrentReading(objectType : AnyObject) {
        masterViewModel.getCurrentReading(objectType: objectType)
    }
    //MARK: - Tableview Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        numberofSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return masterViewModel.woNoArray.count
        }else if section == 1 && showMore == true{
            return 1
        }else{
            return 0
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        mJCLogger.log("Starting", Type: "info")
        if indexPath.section == 0{
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && (currentMasterView == "WorkOrder"){
                let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
                cell.indexpath = indexPath
                cell.masterViewModel = masterViewModel
                if masterViewModel.woNoArray.indices.contains(indexPath.row){
                    if let  operationClass = masterViewModel.woNoArray[indexPath.row] as? WoOperationModel{
                        cell.operationClass = operationClass
                        if(operationClass.isSelected) {
                            if DeviceType == iPad{
                                self.workOrderTableView.selectRow(at: cell.indexpath, animated: false, scrollPosition: .none)
                            }
                            self.navigateToDetailsScreen(selectedIndex: cell.indexpath.row)
                        }
                    }
                }
                return cell
            }else{
                let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
                cell.selectionStyle = .none
                cell.indexpath = indexPath
                cell.masterViewModel = masterViewModel
                var isSelected = Bool()
                if masterViewModel.woNoArray.indices.contains(indexPath.row){
                    if let workorder = masterViewModel.woNoArray[indexPath.row] as? WoHeaderModel{
                        if currentMasterView == "WorkOrder" {
                            cell.woModelClass = workorder
                            isSelected = workorder.isSelectedCell
                        }
                    }
                }
                if(isSelected) {
                    if DeviceType == iPad {
                        self.workOrderTableView.selectRow(at: cell.indexpath, animated: false, scrollPosition: .none)
                    }
                    self.navigateToDetailsScreen(selectedIndex: cell.indexpath.row)
                }
                mJCLogger.log("Ended", Type: "info")
                return cell
            }
        }else{
            let loaderCell = ScreenManager.getLoadingTableViewCell(tableView: self.workOrderTableView)
            loaderCell.loader.startAnimating()
            mJCLogger.log("Ended", Type: "info")
            return loaderCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            currentRecordPointArray.removeAll()
            finalReadingpointsArray.removeAll()
            didSelectedCell = indexPath.row
            if currentMasterView == "Notification" {
                if let arr = masterViewModel.woNoArray as? [NotificationModel]{
                    if arr.count > 0{
                        let filteredArray = arr.filter{$0.isSelectedCell == true}
                        for NotifItem in filteredArray{
                            NotifItem.isSelectedCell = false
                        }
                        let notificationClass = arr[didSelectedCell]
                        notificationClass.isSelectedCell = true
                        self.reloadWorkorderTableView()
                    }
                }
            }else if currentMasterView == "WorkOrder" {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    for item in 0..<masterViewModel.woNoArray.count {
                        if let cls = masterViewModel.woNoArray[item] as? WoOperationModel{
                            cls.isSelected = false
                            masterViewModel.woNoArray[item] = cls
                        }
                    }
                    if masterViewModel.woNoArray.indices.contains(didSelectedCell){
                        if let oprCls = masterViewModel.woNoArray[didSelectedCell] as? WoOperationModel{
                            if DeviceType == iPad { oprCls.isSelected = true }
                            masterViewModel.woNoArray[didSelectedCell] = oprCls
                            self.reloadWorkorderTableView()
                        }
                    }
                }else{
                    if masterViewModel.woNoArray.indices.contains(didSelectedCell){
                        if let  Wo = masterViewModel.woNoArray as? [WoHeaderModel]{
                            let filteredArray = Wo.filter{$0.isSelectedCell == true}
                            for item in filteredArray { item.isSelectedCell = false }
                            let WorkOrderClass = masterViewModel.woNoArray[didSelectedCell] as! WoHeaderModel
                            singleWorkOrder = WorkOrderClass
                            WorkOrderClass.isSelectedCell = true
                            currentRecordPointArray.removeAll()
                            finalReadingpointsArray.removeAll()
                            self.reloadWorkorderTableView()
                        }
                    }
                }
            }
        }else{
            if currentMasterView == "Notification" {
                singleNotification = masterViewModel.woNoArray[indexPath.row] as! NotificationModel
                selectedNotificationNumber = singleNotification.Notification
            }else if currentMasterView == "WorkOrder" {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    if onlineSearch == false{
                        if masterViewModel.woNoArray.count > 0 {
                            singleOperation = masterViewModel.woNoArray[indexPath.row] as! WoOperationModel
                            selectedOperationNumber = singleOperation.OperationNum
                            selectedworkOrderNumber = singleOperation.WorkOrderNum
                            currentRecordPointArray.removeAll()
                            finalReadingpointsArray.removeAll()
                            self.getCurrentReading(objectType: singleOperation)
                            masterViewModel.getWorkorderDetails(woNumber: singleOperation.WorkOrderNum, showPopUp: false)
                        }
                    }else {
                        if masterViewModel.woNoArray.count > 0 {
                            let array = onlineSearchArray as! [WoHeaderModel]
                            singleOperation = masterViewModel.woNoArray[indexPath.row] as! WoOperationModel
                            selectedworkOrderNumber =
                            singleOperation.WorkOrderNum
                            selectedOperationNumber = singleOperation.OperationNum
                            let filterarr = array.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
                            if filterarr.count > 0{
                                singleWorkOrder = filterarr[0]
                                currentRecordPointArray.removeAll()
                                finalReadingpointsArray.removeAll()
                                self.getCurrentReading(objectType: singleOperation)
                            }
                        }
                    }
                }else{
                    singleWorkOrder = masterViewModel.woNoArray[indexPath.row] as! WoHeaderModel
                    selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                    currentRecordPointArray.removeAll()
                    finalReadingpointsArray.removeAll()
                    self.getCurrentReading(objectType: singleWorkOrder)
                }
            }
            let mainViewController = ScreenManager.getMasterListDetailScreen()
            mainViewController.workorderNotification = false
            if  currentMasterView == "Notification"{
                if  onlineSearch == true{
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Overview".localized()]
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "OverView")]
                }else{
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = notificationChildSideMenuArr
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = notificationChildSideMenuImgArr
                    if let index = myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Overview".localized()){
                        myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                        myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
                    }
                }
            }else{
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
                if onlineSearch == true{
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Overview".localized(), "Operations".localized()]
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "Operations"),]
                }else{
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = workorderChildSideMenuArr
                    myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = workorderChildSideMenuImgArr
                }
            }
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController,menu: "Workorder")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Scroll Delegates
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mJCLogger.log("Starting", Type: "info")
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.height{
            if !showMore{
                let count = masterViewModel.woNoListArray.count
                if count > masterViewModel.woNoArray.count{
                    refreshList()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.searchViewHeightConstraint.constant = 0
                self.searchTextField.isUserInteractionEnabled = false
                self.scanButton.isHidden = true
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.scanButton.isHidden = false
                self.searchViewHeightConstraint.constant = 50
                self.searchTextField.isUserInteractionEnabled = true
            }, completion: nil)
        }
    }
    func refreshList(){
        mJCLogger.log("Starting", Type: "info")
        showMore = true
        if currentMasterView == "Notification" && filteredNotifications.count > 0{
            return
        }else if currentMasterView == "WorkOrder" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if !applicationFeatureArrayKeys.contains("DASH_OPR_TILE"){
                    if filteredWorkorders.count > 0{ return }
                }else{
                    if filteredOperations.count > 0{ return }
                }
            }else{
                if filteredWorkorders.count > 0{ return }
            }
        }
        let WOcount = masterViewModel.woNoListArray.count
        if numberofSection == 2  &&  WOcount > masterViewModel.woNoArray.count{
            self.workOrderTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.skipvalue += masterDataLoadingItems
            if WOcount >= self.skipvalue {
                let newarr = self.masterViewModel.woNoListArray[(self.masterViewModel.woNoArray.count)..<self.skipvalue]
                self.masterViewModel.woNoArray.append(contentsOf: newarr)
                self.showMore = false
                self.workOrderTableView.reloadData()
            }else{
                let count = self.skipvalue - self.masterViewModel.woNoListArray.count
                let newarr = self.masterViewModel.woNoListArray[(self.masterViewModel.woNoArray.count)..<(self.skipvalue - count)]
                self.masterViewModel.woNoArray.append(contentsOf: newarr)
                self.showMore = false
                self.workOrderTableView.reloadData()
            }
            if currentMasterView == "Notification" {
                self.setTitleLabelDetails(type: "Notification")
            }else if currentMasterView == "WorkOrder" {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    self.setTitleLabelDetails(type: "Operation")
                }else{
                    self.setTitleLabelDetails(type: "WorkOrder")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: -  Search Bar delegate..
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchTextField.endEditing(true)
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification" {
            did_DeSelectedCell = 0
            didSelectedCell = 0
            if(searchText == "") {
                self.searchTextField.endEditing(true)
                if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                    let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                    self.setNotificationFilterQuery(dict: dict)
                }else{
                    self.setSelectedNotificationDetails()
                }
            }else {
                if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                    let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                    let filteredArray = masterViewModel.applyNotificationFilter(filterDict: dict, searchText: searchText)
                    if filteredArray.count > 0 {
                        self.masterViewModel.woNoArray = filteredArray
                        self.setSelectedNotificationDetails(noArr: filteredArray)
                        self.setTitleLabelDetails(type: "Notification",filterCount: filteredArray.count, countLbl: false)
                    }else {
                        self.setTitleLabelDetails(type: "Notification",countLbl: false, noData: false)
                        self.navigateToDetailsScreen(selectedIndex: -1)
                    }
                }else{
                    masterViewModel.woNoArray.removeAll()
                    let filteredArray = masterViewModel.applyNotificationFilter(filterDict: [String:Any](), searchText: searchText)
                    if filteredArray.count > 0 {
                        self.masterViewModel.woNoArray = filteredArray
                        self.setSelectedNotificationDetails(noArr: filteredArray)
                        self.setTitleLabelDetails(type: "Notification",filterCount: filteredArray.count,countLbl: false)
                    }else {
                        self.masterViewModel.woNoArray = self.masterViewModel.woNoListArray
                        self.setSelectedNotificationDetails()
                        self.setTitleLabelDetails(type: "Notification",countLbl: false, noData: false)
                        self.navigateToDetailsScreen(selectedIndex: -1)
                    }
                }
            }
            self.reloadWorkorderTableView()
        }else if currentMasterView == "WorkOrder" {
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") {
                DispatchQueue.main.async {
                    self.did_DeSelectedCell = 0
                    self.didSelectedCell = 0
                    if(searchText == "") {
                        self.searchTextField.endEditing(true)
                        if (UserDefaults.standard.value(forKey:"ListFilter") != nil)  {
                            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! NSDictionary
                            self.setOperationFilterQuery(dict: dict as! Dictionary<String, Any>)
                        }else{
                            self.masterViewModel.woNoArray.removeAll()
                            self.masterViewModel.woNoArray.append(contentsOf: self.masterViewModel.woNoListArray)
                            self.setSelectedOperationDetails()
                        }
                    }else {
                        if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                            let filteredArray = self.masterViewModel.applyOperationFilter(filterDict: dict, searchText: searchText)
                            if filteredArray.count > 0 {
                                self.masterViewModel.woNoArray = filteredArray
                                self.setSelectedOperationDetails(oprArr: filteredArray)
                                self.setTitleLabelDetails(type: "Operation",filterCount: filteredArray.count,countLbl: false)
                            }else {
                                self.masterViewModel.woNoArray = self.masterViewModel.woNoListArray
                                self.setSelectedOperationDetails()
                                self.setTitleLabelDetails(type: "Operation",countLbl: false, noData: false)
                                self.navigateToDetailsScreen(selectedIndex: -1)
                            }
                        }else{
                            self.masterViewModel.woNoArray.removeAll()
                            let filteredArray = self.masterViewModel.applyOperationFilter(filterDict: [String:Any](), searchText: searchText)
                            if filteredArray.count > 0 {
                                self.masterViewModel.woNoArray = filteredArray
                                self.setSelectedOperationDetails(oprArr: filteredArray)
                                self.setTitleLabelDetails(type: "Operation",filterCount: filteredArray.count,countLbl: false)
                            }else {
                                self.masterViewModel.woNoArray = self.masterViewModel.woNoListArray
                                self.setSelectedOperationDetails()
                                self.setTitleLabelDetails(type: "Operation",countLbl: false, noData: false)
                                self.navigateToDetailsScreen(selectedIndex: -1)
                            }
                        }
                    }
                    self.workOrderTableView.reloadData()
                }
            }else{
                did_DeSelectedCell = 0
                didSelectedCell = 0
                if(searchText == "") {
                    self.searchTextField.endEditing(true)
                    if (UserDefaults.standard.value(forKey:"ListFilter") != nil)  {
                        let dict = UserDefaults.standard.value(forKey:"ListFilter") as! NSDictionary
                        self.setWorkorderFilterQuery(dict: dict as! Dictionary<String, Any>)
                    }else{
                        self.masterViewModel.woNoArray.removeAll()
                        self.masterViewModel.woNoArray.append(contentsOf: self.masterViewModel.woNoListArray)
                        self.setSelectedWorkorderDetails()
                    }
                }else {
                    if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                        let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                        let filteredArray = self.masterViewModel.applyWorkorderFilter(filterDict: dict, searchText: searchText)
                        if filteredArray.count > 0 {
                            self.masterViewModel.woNoArray = filteredArray
                            self.setSelectedWorkorderDetails(woArr: filteredArray)
                            self.setTitleLabelDetails(type: "Workorder",filterCount: filteredArray.count,countLbl: false)
                        }else {
                            self.masterViewModel.woNoArray = self.masterViewModel.woNoListArray
                            self.setSelectedWorkorderDetails()
                            self.setTitleLabelDetails(type: "Workorder",countLbl: false, noData: false)
                            self.navigateToDetailsScreen(selectedIndex: -1)
                        }
                    }else{
                        self.masterViewModel.woNoArray.removeAll()
                        let filteredArray = self.masterViewModel.applyWorkorderFilter(filterDict: [String:Any](), searchText: searchText)
                        if filteredArray.count > 0 {
                            self.masterViewModel.woNoArray = filteredArray
                            self.setSelectedWorkorderDetails(woArr: filteredArray)
                            self.setTitleLabelDetails(type: "Workorder",filterCount: filteredArray.count, countLbl: false)
                        }else {
                            self.masterViewModel.woNoArray = self.masterViewModel.woNoListArray
                            self.setSelectedWorkorderDetails()
                            self.setTitleLabelDetails(type: "Workorder",countLbl: false, noData: false)
                            self.navigateToDetailsScreen(selectedIndex: -1)
                        }
                    }
                }
                self.reloadWorkorderTableView()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK: - Filter WorkOrder..
    func ApplyFilter() {
        mJCLogger.log("Starting", Type: "info")
        self.techIdEquipmentList.removeAll()
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String, Any>
            if currentMasterView == "Notification" {
                if let array = dict["techID"] as? [String]{
                    if array.count == 0{
                        self.setNotificationFilterQuery(dict: dict)
                    }else{
                        masterViewModel.getEquipmentsFromTechID(list: array , dict: dict, type: currentMasterView )
                    }
                }else{
                    self.setNotificationFilterQuery(dict: dict)
                }
            }else if currentMasterView == "WorkOrder" {
                let dict1 = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    if let array = dict["techID"] as? [String]{
                        if array.count == 0{
                            self.setOperationFilterQuery(dict: dict1)
                        }else{
                            masterViewModel.getEquipmentsFromTechID(list: array, dict: dict1, type: currentMasterView)
                        }
                    }else{
                        self.setOperationFilterQuery(dict: dict1)
                    }
                }else{
                    if let array = dict["techID"] as? [String]{
                        if array.count == 0{
                            self.setWorkorderFilterQuery(dict: dict)
                        }else{
                            masterViewModel.getEquipmentsFromTechID(list: array, dict: dict, type: currentMasterView )
                        }
                    }else{
                        self.setWorkorderFilterQuery(dict: dict)
                    }
                }
            }
        }else{
            self.noDataView.isHidden = false
            self.noDataLabel.text = "No_Data_Available".localized()
            filterCountLabel.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkorderFilterQuery(dict : Dictionary<String,Any>) {
        mJCLogger.log("Starting", Type: "info")
        if dict.keys.count == 0{
            let arr = (masterViewModel.woNoListArray as Array<Any>).prefix(masterDataLoadingItems)
            masterViewModel.woNoArray.append(contentsOf: arr)
            self.setSelectedWorkorderDetails()
            self.setTitleLabelDetails(type: "Workorder")
        }else{
            let filterArray = masterViewModel.applyWorkorderFilter(filterDict: dict,searchText: self.searchTextField.text)
            if filterArray.count > 0 {
                masterViewModel.woNoArray.removeAll()
                masterViewModel.woNoArray = filterArray
                self.setSelectedWorkorderDetails(woArr: filterArray)
                self.setTitleLabelDetails(type: "Workorder",filterCount: filterArray.count,countLbl: false)
            }else {
                self.setTitleLabelDetails(type: "Workorder",countLbl: false, noData: false)
                self.navigateToDetailsScreen(selectedIndex: -1)
            }
            if DeviceType == iPad{
                if selectedworkOrderNumber == ""{
                    self.setSelectedWorkorderDetails()
                }else{
                    let filterarray = (masterViewModel.woNoArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
                    self.setSelectedWorkorderDetails(woArr: filterarray)
                }
            }
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func setSelectedWorkorderDetails(woArr:[WoHeaderModel]? = []){
        for item in 0..<masterViewModel.woNoArray.count {
            let cls = masterViewModel.woNoArray[item] as! WoHeaderModel
            cls.isSelectedCell = false
            masterViewModel.woNoArray[item] = cls
        }
        if woArr?.count ?? 0 > 0{
            let woClass = woArr![0]
            woClass.isSelectedCell = true
            selectedworkOrderNumber = woClass.WorkOrderNum
            singleWorkOrder = woClass
        }else{
            if masterViewModel.woNoArray.count > 0 {
                let woClass = masterViewModel.woNoArray[0] as! WoHeaderModel
                woClass.isSelectedCell = true
                selectedworkOrderNumber = woClass.WorkOrderNum
                singleWorkOrder = woClass
            }
        }
    }
    func setOperationFilterQuery(dict : Dictionary<String,Any>) {
        mJCLogger.log("Starting", Type: "info")
        if dict.keys.count == 0{
            if onlineSearch == true{
                masterViewModel.woNoArray.removeAll()
                masterViewModel.woNoArray.append(contentsOf: masterViewModel.woNoListArray)
            }else{
                let arr = (masterViewModel.woNoListArray as Array<Any>).prefix(masterDataLoadingItems)
                masterViewModel.woNoArray.removeAll()
                masterViewModel.woNoArray.append(contentsOf: arr)
            }
            self.setTitleLabelDetails(type: "Operation")
        }else{
            let filterArray = masterViewModel.applyOperationFilter(filterDict: dict, searchText: self.searchTextField.text)
            if filterArray.count > 0{
                masterViewModel.woNoArray.removeAll()
                masterViewModel.woNoArray.append(contentsOf: filterArray)
                self.setSelectedOperationDetails(oprArr: filterArray)
                self.setTitleLabelDetails(type: "Operation",filterCount: filterArray.count,countLbl: false)
            }else{
                self.setTitleLabelDetails(type: "Notification",countLbl: false, noData: false)
            }
        }
        DispatchQueue.main.async {
            self.workOrderTableView.reloadData()
        }
        if DeviceType == iPad {
            if selectedworkOrderNumber == "" && selectedOperationNumber == ""{
                self.setSelectedOperationDetails()
            }else{
                let filterarray = (masterViewModel.woNoArray as! [WoOperationModel]).filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)" && $0.OperationNum == "\(selectedOperationNumber)"}
                self.setSelectedOperationDetails(oprArr: filterarray)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setSelectedOperationDetails(oprArr:[WoOperationModel]? = []){
        for item in 0..<masterViewModel.woNoArray.count {
            let oprClass = masterViewModel.woNoArray[item] as! WoOperationModel
            oprClass.isSelected = false
            masterViewModel.woNoArray[item] = oprClass
        }
        if oprArr?.count ?? 0 > 0{
            let oprClass = oprArr![0]
            oprClass.isSelected = true
            selectedOperationNumber = oprClass.OperationNum
            singleOperation = oprClass
        }else{
            if masterViewModel.woNoArray.count > 0 {
                let oprClass = masterViewModel.woNoArray[0] as! WoOperationModel
                oprClass.isSelected = true
                selectedOperationNumber = oprClass.OperationNum
                singleOperation = oprClass
            }
        }
    }
    func setNotificationFilterQuery(dict:Dictionary<String,Any>) {
        mJCLogger.log("Starting", Type: "info")
        if dict.keys.count == 0{
            let arr = (masterViewModel.woNoListArray as Array<Any>).prefix(masterDataLoadingItems)
            masterViewModel.woNoArray.append(contentsOf: arr)
            self.setSelectedNotificationDetails()
            self.setTitleLabelDetails(type: "Notification")
        }else{
            let filterArray = masterViewModel.applyNotificationFilter(filterDict: dict)
            if filterArray.count > 0 {
                masterViewModel.woNoArray = filterArray
                self.setSelectedNotificationDetails(noArr: filterArray)
                self.setTitleLabelDetails(type: "Notification",filterCount: filterArray.count,countLbl: false)
            }else {
                self.setTitleLabelDetails(type: "Notification",countLbl: false, noData: false)
                self.navigateToDetailsScreen(selectedIndex: -1)
            }
            if DeviceType == iPad {
                if selectedNotificationNumber == ""{
                    self.setSelectedNotificationDetails()
                }else{
                    let filterarray = (masterViewModel.woNoArray as! [NotificationModel]).filter{$0.Notification == "\(selectedNotificationNumber)"}
                    self.setSelectedNotificationDetails(noArr: filterarray)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setSelectedNotificationDetails(noArr:[NotificationModel]? = []){
        for item in 0..<masterViewModel.woNoArray.count {
            let cls = masterViewModel.woNoArray[item] as! NotificationModel
            cls.isSelectedCell = false
            masterViewModel.woNoArray[item] = cls
        }
        if noArr?.count ?? 0 > 0{
            let noClass = noArr![0]
            noClass.isSelectedCell = true
            selectedNotificationNumber = noClass.Notification
            singleNotification = noClass
        }else{
            if masterViewModel.woNoArray.count > 0 {
                let noClass = masterViewModel.woNoArray[0] as! NotificationModel
                noClass.isSelectedCell = true
                selectedNotificationNumber = noClass.Notification
                singleNotification = noClass
            }
        }
    }
    func setTitleLabelDetails(type:String,filterCount:Int? = 0,totalCount:Int? = 0,countLbl:Bool? = true,noData:Bool? = true){
        DispatchQueue.main.async {
            if countLbl == false{
                self.filterCountLabel.isHidden = false
                self.filterCountLabel.text = "\(filterCount ?? 0)"
            }else{
                self.filterCountLabel.isHidden = true
                self.filterCountLabel.text = ""
            }
            if noData == false && self.masterViewModel.woNoArray.count == 0{
                self.noDataView.isHidden = false
                self.noDataLabel.text = "No_Data_Available".localized()
                if type == "Notification"{
                    selectedNotificationNumber = ""
                    singleNotification = NotificationModel()
                }else if type == "Workorder"{
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                }else if type == "Operation"{
                    selectedOperationNumber = ""
                    singleOperation = WoOperationModel()
                }
            }else{
                self.noDataView.isHidden = true
                self.noDataLabel.text = ""
            }
            if type == "Notification"{
                self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(self.masterViewModel.woNoArray.count)/\(self.masterViewModel.woNoListArray.count)"
            }else if type == "Workorder"{
                self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.masterViewModel.woNoArray.count)/\(self.masterViewModel.woNoListArray.count)"
            }else if type == "Operation"{
                self.totalWorkOrderLabel.text = "Total_Operations".localized() + ": \(self.masterViewModel.woNoArray.count)/\(self.masterViewModel.woNoListArray.count)"
            }
        }
    }
    // MARK: - Barcode scanner
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            self.searchTextField.text = barCode
            self.searchBar(self.searchTextField, textDidChange: barCode)
            self.dismiss(animated: true, completion: nil)
        }
    }
    func setAppfeature(){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification"{
            if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                addWorkFormButton.isHidden = false
            }else{
                addWorkFormButton.isHidden = true
            }
        }else if currentMasterView == "WorkOrder"{
            if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                addWorkFormButton.isHidden = false
            }else{
                addWorkFormButton.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - PhoneView Functions..
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let createNewJobVC = ScreenManager.getCreateJobScreen()
        createNewJobVC.isFromEdit = false
        createNewJobVC.isScreen = "WorkOrder"
        createNewJobVC.createUpdateDelegate = self
        createNewJobVC.modalPresentationStyle = .fullScreen
        self.present(createNewJobVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        myAssetDataManager.uniqueInstance.logOutApp()
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Work_Orders".localized() {
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController)
        }else if title == "Notifications".localized() {
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController,menu: "Main")
        }else if title == "Job_Location".localized() {
            ASSETMAP_TYPE = ""
            currentMasterView = "MapSplitViewController"
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            let mainViewController = ScreenManager.getMapDeatilsScreen()
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController,menu: "Main")
        }else if title == "Time_Sheet".localized() {
            currentMasterView = "TimeSheet"
            let mainViewController = ScreenManager.getTimeSheetScreen()
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: mainViewController,menu: "Main")
        }else if title == "Asset_Map".localized() {
//            ASSETMAP_TYPE = "ESRIMAP"
//            if DeviceType == iPad{
//                assetmapVC.openmappage(id: "")
//            }else{
//                currentMasterView = "WorkOrder"
//                selectedworkOrderNumber = ""
//                selectedNotificationNumber = ""
//                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//                self.present(assetMapDeatilsVC, animated: true, completion: nil)
//            }
        }else if title == "Settings".localized() {
            let settingsVC = ScreenManager.getSettingsScreen()
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }else if title == "Master_Data_Refresh".localized() {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
        }else if title == "Error_Logs".localized() {
            myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
        }else if title == "Log_Out".localized() {
            myAssetDataManager.uniqueInstance.logOutApp()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        if currentMasterView == "WorkOrder" {
            if isSupervisor == "X"{
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = supervisorWoSideMenuArr
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = supervisorWoSideMenuImgArr
            }else{
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = workorderSideMenuArr
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = workorderSideMenuImgArr
            }
        }else if currentMasterView == "Notification" {
            if isSupervisor == "X"{
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = supervisorNoSideMenuArr
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = supervisorNoSideMenuImgArr
            }else{
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = notificationSideMenuArr
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = notificationSideMenuImgArr
            }
        }
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index = myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Time_Sheet".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_LIST_MAP_NAV"){
            if let index = myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Job_Location".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index = myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Asset_Map".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification" {
            currentMasterView = "WorkOrder"
        }else{
            currentMasterView = "Notification"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK: - Button Actions
    @IBAction func priorityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.masterViewModel.applyPrioritySorting(type: currentMasterView, priortySort: priortySort,assignment: WORKORDER_ASSIGNMENT_TYPE)
        priortySort = !priortySort
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func sortButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.masterViewModel.applyOrderSorting(type: currentMasterView, orderSort: orderSort, assignment: WORKORDER_ASSIGNMENT_TYPE)
        orderSort = !orderSort
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func dateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        masterViewModel.applyDateSorting(type: currentMasterView, dateSort: dateSort,assignment: WORKORDER_ASSIGNMENT_TYPE)
        dateSort = !dateSort
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func addWorkFormButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification" {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    if SHOW_CREATEJOB_ON_CREATENOTIF_IN_LIST_SCREEN{
                        let createNewJobVC = ScreenManager.getCreateJobScreen()
                        createNewJobVC.isFromEdit = false
                        createNewJobVC.isScreen = "WorkOrder"
                        createNewJobVC.createUpdateDelegate = self
                        createNewJobVC.modalPresentationStyle = .fullScreen
                        self.present(createNewJobVC, animated: false) {}
                    }else{
                        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                        createNotificationVC.isFromEdit = false
                        createNotificationVC.createUpdateDelegate = self
                        createNotificationVC.modalPresentationStyle = .fullScreen
                        self.present(createNotificationVC, animated: false) {}
                    }
                }
            }
        }else if currentMasterView == "WorkOrder" {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_WO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                    createWorkOrderVC.isFromEdit = false
                    createWorkOrderVC.isScreen = "WorkOrder"
                    createWorkOrderVC.createUpdateDelegate = self
                    createWorkOrderVC.modalPresentationStyle = .fullScreen
                    self.present(createWorkOrderVC, animated: false) {}
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func notificationButtoAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let filteredArray = (masterViewModel.woNoArray as! [NotificationModel]).filter{$0.isSelectedCell == true}
        for NotifItem in filteredArray{
            NotifItem.isSelectedCell = false
        }
        didSelectedCell = sender.tag
        let notificationClass = masterViewModel.woNoArray[sender.tag]
        (notificationClass as! NotificationModel).isSelectedCell = true
        singleNotification = notificationClass as! NotificationModel
        self.reloadWorkorderTableView()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func filterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder"{
            self.masterViewModel.getFilterVaues(type: "WorkOrder", assignment: WORKORDER_ASSIGNMENT_TYPE)
        }else{
            self.masterViewModel.getFilterVaues(type: "", assignment: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func scanButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "search", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func ActiveOrderButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if((UserDefaults.standard.value(forKey:"active_details")) != nil){
            let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
            if currentMasterView == "WorkOrder"{
                self.masterViewModel.getActiveDetails(activeDetails: activedetails, type: "WorkOrder", assignment: WORKORDER_ASSIGNMENT_TYPE)
            }else{
                self.masterViewModel.getActiveDetails(activeDetails: activedetails, type: "", assignment: "")
            }
        }else{
            if currentMasterView == "WorkOrder"{
                self.showNoActiveMessage(type: "Workorder")
            }else{
                self.showNoActiveMessage(type: "Notification")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func showNoActiveMessage(type:String){
        if type == "Notification"{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_Notifications_not_found".localized(), button: okay)
        }else if type == "Workorder"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_Operation_not_found".localized(), button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
            }
        }
    }
    //MARK: - Delegate Methods..
    func EntityCreated(){
        if onlineSearch != true {
            if currentMasterView == "WorkOrder" {
                if !(WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"){
                }
            }else if currentMasterView == "Notification" {
            }
        }
    }
    func EntityUpdated(){
        if currentMasterView == "WorkOrder"{
            masterViewModel.woNoArray[didSelectedCell] = singleWorkOrder
        } else if currentMasterView == "Notification"{
            masterViewModel.woNoArray[didSelectedCell] = singleNotification
        }
        self.reloadWorkorderTableView()
    }
    //MARK: viewModel Delegate
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "NoFilter"{
            let dict = object[0] as! Dictionary<String,Any>
            self.setNotificationFilterQuery(dict: dict)
        }else if type == "OprFilter"{
            let dict = object[0] as! Dictionary<String,Any>
            self.setOperationFilterQuery(dict: dict)
        }else if type == "WoFilter"{
            let dict = object[0] as! Dictionary<String,Any>
            self.setWorkorderFilterQuery(dict: dict)
        }else if type == "sorting"{
            self.reloadWorkorderTableView()
        }else if type == "scrollToActive"{
            if let index = object[0] as? Int{
                let indexPath  = IndexPath(row: index, section: 0)
                if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                    if DeviceType == iPad{
                        self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                    }
                    self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }else if type == "noActive"{
            if let title = object[0] as? String{
                if title == "workorder"{
                    self.showNoActiveMessage(type: "Workorder")
                }else if title == "Notification"{
                    self.showNoActiveMessage(type: "Notification")
                }
            }
        }else if type == "filter"{
            if let dict = object[0] as? Dictionary<String,Any>{
                let filterVC = ScreenManager.getListFilterScreen()
                if onlineSearch == true{
                    filterVC.childfrom = "online"
                }
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_FILTER", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        if let priorityArray = dict["priority"] as? [String]{
                            filterVC.filterViewModel.priorityArray = priorityArray
                        }
                        if let ordertypeArray = dict["ordertype"] as? [String]{
                            filterVC.filterViewModel.typeArray = ordertypeArray
                        }
                        if let statusArray = dict["status"] as? [String]{
                            filterVC.filterViewModel.statusArray = statusArray
                        }
                        if let plantArray = dict["plant"] as? [String]{
                            filterVC.filterViewModel.plantsArray = plantArray
                        }
                        if let createdByArray = dict["createdBy"] as? [String]{
                            filterVC.filterViewModel.createdByArray = createdByArray
                        }
                        if let mainWorkCenterArray = dict["mainWorkCenter"] as? [String]{
                            filterVC.filterViewModel.mainWorkCenterArry = mainWorkCenterArray
                        }
                        if let mainPlantGroupArray = dict["mainPlantGroup"] as? [String]{
                            filterVC.filterViewModel.mainPlantGroupListArray = mainPlantGroupArray
                        }
                        if let staffIdArr = dict["staffId"] as? [String]{
                            filterVC.filterViewModel.persponseArray = staffIdArr
                        }
                        if let maintenancePlantArray = dict["maintenancePlant"] as? [String]{
                            filterVC.filterViewModel.maintenancePlantArray = maintenancePlantArray
                        }
                        if let planningPlantArray = dict["planningPlant"] as? [String]{
                            filterVC.filterViewModel.planningPlantArray = planningPlantArray
                        }
                        if let equipArray = dict["equip"] as? [String]{
                            filterVC.filterViewModel.equipmentArray = equipArray
                        }
                        filterVC.delegate = self
                        filterVC.modalPresentationStyle = .fullScreen
                        self.present(filterVC, animated: false) {}
                    }
                }
            }
        }else if type == "listData"{
            if let title = object[0] as? String{
                if title == "workorder"{
                    myAssetDataManager.uniqueInstance.getActiveDetails(type: "")
                    if DeviceType == iPhone{
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: "Work_Orders".localized)
                    }
                    self.setTitleLabelDetails(type: "Workorder")
                }else if title == "Notification"{
                    myAssetDataManager.uniqueInstance.getActiveDetails(type: "Notification")
                    if DeviceType == iPhone{
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: "Notifications".localized)
                    }
                    self.setTitleLabelDetails(type: "Notification")
                }
            }
        }
    }
    func updateUI(type:String){
    }
    //...END...//
}
