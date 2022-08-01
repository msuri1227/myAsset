//
//  AssetMapMasterVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/27/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import CoreData
import ODSFoundation
import mJCLib

class AssetMapMasterVC: UIViewController, NSFetchedResultsControllerDelegate,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UISearchBarDelegate,barcodeDelegate,filterDelegate,CreateUpdateDelegate{
   
    //MARK:- Outlets..
    @IBOutlet var filterview: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var totalWorkOrderLabel: UILabel!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTextField: UISearchBar!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchInView: UIView!
    @IBOutlet var tableViewSuperView: UIView!
    @IBOutlet var workOrderTableView: UITableView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var BottomWOButton: UIButton!
    @IBOutlet var BottomNOButton: UIButton!
    @IBOutlet var scanButton: UIButton!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ActiveOrderButton: UIButton!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var detailViewController: UIViewController? = nil
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var lastContentOffset: CGFloat = 0
    var statuArray = Array<StatusCategoryModel>()
    @objc    var c = String()
    var statusImages = Array<Any>()
    var showMore = false
    var numberofSection = 2
    var skipvalue = masterDataLoadingItems
    var totalWOCount = Int()
    var totalNOCount = Int()
    var isfromFilter = Bool()
    var assetMastViewModel = AssetMapMasterViewModel()
    weak var delegate: listSelectionDelegate?
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        isfromFilter = false
        assetMastViewModel.vc = self
        didSelectedCell = 0
        did_DeSelectedCell = 0
        searchTextField.delegate = self
        singleWorkOrder = WoHeaderModel()
        
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            self.profileNameLabel.text = userDisplayName
            self.profilePetNameLabel.text = userSystemID.lowercased()
        }
        ODSUIHelper.setRoundLabel(label: self.filterCountLabel)
        ODSUIHelper.setCornerRadiusToImgView(imageView: self.profileImage, cornerRadius: self.profileImage.frame.size.width / 2)
        ODSUIHelper.setBorderToView(view: self.searchInView, borderWidth: 1.0, cornerRadius: 3.0, borderColor: .lightGray)
        self.assetMastViewModel.workOrderArray.removeAll()
        self.assetMastViewModel.workOrderListArray.removeAll()
        self.assetMastViewModel.notificationArray.removeAll()
        self.assetMastViewModel.notificationListArray.removeAll()
        
        searchTextField.setImage(UIImage(), for: .search, state: .normal)
        searchTextField.compatibleSearchTextField.backgroundColor = UIColor.white
        self.appDeli.notificationFireType = "OpenOverViewDataBase"
        self.workOrderTableView.estimatedRowHeight = 135.0
        ScreenManager.registerWorkOrderCell(tableView: self.workOrderTableView)
        ScreenManager.registerLoadingTableViewCell(tableView: self.workOrderTableView)
        self.workOrderTableView.separatorStyle  = .none
        self.workOrderTableView.bounces = false
        self.workOrderTableView.isEditing = false
        if let split = self.splitViewController as? ListSplitVC {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MasterListDetailVC
        }
        
        self.scanButton.isHidden = false
        self.BottomWOButton.backgroundColor = selectionBgColor
        self.BottomNOButton.backgroundColor = appColor
        
        if fromSupervisorWorkOrder == true {
            self.assetMastViewModel.getSupervisorWorkOrderList()
            
        }else {
            myAssetDataManager.uniqueInstance.getActiveDetails(type: "WorkOrder")
            self.assetMastViewModel.getWorkOrderList()
        }
        
        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0"
        self.assetMastViewModel.getNotificationList()
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadWorkOrderTableView(notification:)), name:NSNotification.Name(rawValue:"reloadWorkOrderTableView"), object: nil)
        statuArray.removeAll()
        statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        mJCLogger.log("Ended", Type: "info")
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssetMapDeatilsVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func EntityCreated(){
        if currentMasterView == "WorkOrder" {
            self.assetMastViewModel.getWorkOrderList()
        }else if currentMasterView == "Notification"{
            self.assetMastViewModel.getNotificationList()
        }
    }
    func EntityUpdated(){
        if currentMasterView == "WorkOrder" {
            self.assetMastViewModel.workOrderArray[didSelectedCell] = singleWorkOrder
            self.workOrderTableView.reloadData()
        }else if currentMasterView == "Notification"{
            self.assetMastViewModel.notificationArray[didSelectedCell] = singleNotification
            self.workOrderTableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Notifications Methods..
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        didSelectedCell = 0
        did_DeSelectedCell = 0
        if currentMasterView == "Notification" {
            self.assetMastViewModel.getNotificationList()
        }else if currentMasterView == "WorkOrder" {
            self.assetMastViewModel.getWorkOrderList()
        }
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func reloadWorkOrderTableView(notification : NSNotification){
        mJCLogger.log("Starting", Type: "info")
        var indexPath = IndexPath()
        
        if currentMasterView == "Notification" {
            self.workOrderTableView.reloadData()
//            indexPath = IndexPath(row: selectedNOIndex, section: 0)
//            if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
//                self.workOrderTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: false)
//            }
        }
        else {
            self.workOrderTableView.reloadData()
//            indexPath = IndexPath(row: selectedWOIndex, section: 0)
//            if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
//                self.workOrderTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: false)
//            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func ActiveOrderButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if((UserDefaults.standard.value(forKey:"active_details")) != nil){
            let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
            if currentMasterView == "WorkOrder"{
                if let activeWOnum = activedetails.value(forKey: "WorkorderNum") as? String{
                    let filter = (self.assetMastViewModel.workOrderArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(activeWOnum)"}
                    if filter.count > 0{
                        if let index = (self.assetMastViewModel.workOrderArray as! [WoHeaderModel]).firstIndex(of: filter[0]){
                            let indexPath  = IndexPath(row: index, section: 0)
                            if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                                if DeviceType == iPad{
                                    self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                                }
                                self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }else{
                            mJCLogger.log("Active_work_orders_not_found".localized(), Type: "Debug")
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
                        }
                    }else{
                        let filterar2 = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(activeWOnum)"}
                        var index = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).firstIndex(of: filterar2[0]) ?? 0
                        var countValue = 0
                        var listValue = 0
                        countValue = (index/50)+1
                        listValue = (50*countValue)
                        if listValue > self.assetMastViewModel.workOrderListArray.count{
                            let removeValue = listValue - self.assetMastViewModel.workOrderListArray.count
                            listValue = listValue - removeValue
                        }
                        self.assetMastViewModel.workOrderArray.removeAll()
                        for i in 0..<listValue{
                            self.assetMastViewModel.workOrderArray.append(self.assetMastViewModel.workOrderListArray[i])
                        }
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                        index = (self.assetMastViewModel.workOrderArray as! [WoHeaderModel]).firstIndex(of: filterar2[0]) ?? 0
                        if index <= self.assetMastViewModel.workOrderArray.count{
                            let indexPath  = IndexPath(row: index, section: 0)
                            selectedworkOrderNumber = activeWOnum
                            DispatchQueue.main.async {
                                self.workOrderTableView.reloadData()
                                if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                                    if DeviceType == iPad{
                                        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.assetMastViewModel.workOrderArray.count)/\(self.assetMastViewModel.workOrderListArray.count)"
                                        self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                                    }
                                    self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }else{
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
                    mJCLogger.log("Active_work_orders_not_found".localized(), Type: "Debug")
                }
            }else{
                if let activeNOnum = activedetails.value(forKey: "Notification") as? String{
                    let filterar = (self.assetMastViewModel.notificationArray as! [NotificationModel]).filter{$0.Notification == "\(activeNOnum)"}
                    if filterar.count > 0{
                        let index = (self.assetMastViewModel.notificationArray as! [NotificationModel]).firstIndex(of: filterar[0])
                        if index ?? 0 <= self.assetMastViewModel.notificationArray.count{
                            let indexPath  = IndexPath(row: index ?? 0, section: 0)
                            if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                                if DeviceType == iPad{
                                    self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                                }
                                self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }else{
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_Notifications_not_found".localized(), button: okay)
                            mJCLogger.log("Active_Notifications_not_found".localized(), Type: "Debug")
                        }
                    }else{
                        let filterar2 = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.Notification == "\(activeNOnum)"}
                        var index = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).firstIndex(of: filterar2[0]) ?? 0
                        var countValue = 0
                        var listValue = 0
                        countValue = (index/50)+1
                        listValue = (50*countValue)
                        if listValue > self.assetMastViewModel.notificationListArray.count{
                            let removeValue = listValue - self.assetMastViewModel.notificationListArray.count
                            listValue = listValue - removeValue
                        }
                        self.assetMastViewModel.notificationArray.removeAll()
                        for i in 0..<listValue{
                            self.assetMastViewModel.notificationArray.append(self.assetMastViewModel.notificationListArray[i])
                        }
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                        index = (self.assetMastViewModel.notificationArray as! [NotificationModel]).firstIndex(of: filterar2[0]) ?? 0
                        if index <= self.assetMastViewModel.notificationArray.count{
                            let indexPath  = IndexPath(row: index, section: 0)
                            selectedworkOrderNumber = activeNOnum
                            DispatchQueue.main.async {
                                self.workOrderTableView.reloadData()
                                self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(self.assetMastViewModel.notificationArray.count)/\(self.assetMastViewModel.notificationListArray.count)"
                                if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                                    if DeviceType == iPad{
                                        self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                                    }
                                    self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }else{
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_Notifications_not_found".localized(), button: okay)
                    mJCLogger.log("Active_Notifications_not_found".localized(), Type: "Debug")
                }
            }
        }else{
            if currentMasterView == "WorkOrder"{
                mJCLogger.log("Active_work_orders_not_found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
            }else{
                mJCLogger.log("Active_Notifications_not_found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_Notifications_not_found".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TableView Delegate and Datasource..
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if currentMasterView == "WorkOrder" {
                return self.assetMastViewModel.workOrderArray.count
            }else if currentMasterView == "Notification" {
                return self.assetMastViewModel.notificationArray.count
            }
        }else if section == 1 && showMore == true{
            return 1
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        
        var notificationList = NotificationModel()
        if indexPath.section == 0{
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && (currentMasterView == "WorkOrder"){
                let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
                cell.indexpath = indexPath
                cell.assetMastViewModel = assetMastViewModel
                if assetMastViewModel.workOrderArray.indices.contains(indexPath.row){
                    if let  woHeaderClass = assetMastViewModel.workOrderArray[indexPath.row] as? WoHeaderModel{
                        cell.mapWoModelClass = woHeaderClass
                        if(woHeaderClass.isSelectedCell) {
                            if DeviceType == iPad{
                                self.workOrderTableView.selectRow(at: cell.indexpath, animated: false, scrollPosition: .none)
                            }
                            self.navigateToDetailsScreen(selectedIndex: cell.indexpath.row)
                        }
                    }
                }
                return cell
            }
            else{
                let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
                if self.assetMastViewModel.workOrderArray.count > 0{
                    if currentMasterView == "WorkOrder" {
                        if indexPath.row < self.assetMastViewModel.workOrderArray.count{
                            if let WorkOrderListModelStr = self.assetMastViewModel.workOrderArray[indexPath.row] as? WoHeaderModel {
                                cell.assetMastViewModel = assetMastViewModel
                                cell.indexpath = indexPath
                                cell.assetMapMastModelClass = WorkOrderListModelStr
                            }
                        }
                    }else {
                        if indexPath.row < self.assetMastViewModel.notificationArray.count {
                            if let NotificationModelStr = self.assetMastViewModel.notificationArray[indexPath.row] as? NotificationModel {
                                notificationList = NotificationModelStr
                                cell.indexpath = indexPath
                                cell.assetMastViewModel = assetMastViewModel
                                cell.assetMapNoMastModelClass = notificationList
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                mJCLogger.log("Ended", Type: "info")
                return cell
            }
        }else {
            let loaderCell = ScreenManager.getLoadingTableViewCell(tableView: self.workOrderTableView)
            loaderCell.loader.startAnimating()
            mJCLogger.log("Ended", Type: "info")
            return loaderCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification" {
            did_DeSelectedCell = didSelectedCell
            let filteredArray = (self.assetMastViewModel.notificationArray as! [NotificationModel]).filter{$0.isSelectedCell == true}
            if filteredArray.count > 0{
                for NotifItem in filteredArray{
                    NotifItem.isSelectedCell = false
                }
                didSelectedCell = indexPath.row
                let notificationClass = self.assetMastViewModel.notificationArray[didSelectedCell] as! NotificationModel
                notificationClass.isSelectedCell = true
                singleNotification = notificationClass
                selectedNotificationNumber = singleNotification.Notification
                selectedworkOrderNumber = ""
                workOrderTableView.reloadData()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        else if currentMasterView == "WorkOrder" {
            did_DeSelectedCell = didSelectedCell
            let filteredArray = (self.assetMastViewModel.workOrderArray as! [WoHeaderModel]).filter{$0.isSelectedCell == true}
            if filteredArray.count > 0{
                for workorderItem in filteredArray {
                    workorderItem.isSelectedCell = false
                }
                didSelectedCell = indexPath.row
                let WorkOrderClass = self.assetMastViewModel.workOrderArray[didSelectedCell] as! WoHeaderModel
                WorkOrderClass.isSelectedCell = true
                singleWorkOrder = WorkOrderClass
                selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                DispatchQueue.main.async{
                    self.workOrderTableView.reloadData()
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue:"AssetSelectWorkOrder"), object: "AssetSelectWorkOrder")
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if self.lastContentOffset < scrollView.contentOffset.y {
                // did move up
                self.searchViewHeightConstraint.constant = 0
                self.searchTextField.isUserInteractionEnabled = false
            }else if self.lastContentOffset > scrollView.contentOffset.y {
                // did move down
                self.searchViewHeightConstraint.constant = 50
                self.searchTextField.isUserInteractionEnabled = true
            }else {
                // didn't move
                self.searchViewHeightConstraint.constant = 50
                self.searchTextField.isUserInteractionEnabled = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- tableview scroll
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mJCLogger.log("Starting", Type: "info")
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.height{
            if !showMore{
                if currentMasterView == "Notification" {
                    let count = self.assetMastViewModel.notificationListArray.count
                    if count > self.assetMastViewModel.notificationArray.count && isfromFilter == false{
                        self.assetMastViewModel.refreshList()
                    }
                }else{
                    let count = self.assetMastViewModel.workOrderListArray.count
                    if count > self.assetMastViewModel.workOrderArray.count && isfromFilter == false{
                        self.assetMastViewModel.refreshList()
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    //MARK: - Naviagte to details screen
    func navigateToDetailsScreen(selectedIndex:Int){
        if DeviceType == iPad{
            if currentMasterView == "WorkOrder" {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    if assetMastViewModel.workOrderArray.indices.contains(selectedIndex){
                        if let operation = assetMastViewModel.workOrderArray[selectedIndex] as? WoOperationModel{
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
//                    self.delegate?.listObjectSelected!()
                }else{
                    if assetMastViewModel.workOrderArray.indices.contains(selectedIndex){
                        if let workOrder = assetMastViewModel.workOrderArray[selectedIndex] as? WoHeaderModel{
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
//                        self.delegate?.listObjectSelected!()
                    }
                }
            }else if currentMasterView == "Notification" {
                if assetMastViewModel.notificationArray.indices.contains(selectedIndex){
                    if let notification = assetMastViewModel.notificationArray[selectedIndex] as? NotificationModel{
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
//                self.delegate?.listObjectSelected!()
            }
        }
    }
    
    //MARK:- Footer Button Action..
    @IBAction func BottomWoAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "WorkOrder"
        myAssetDataManager.uniqueInstance.getActiveDetails(type: "WorkOrder")
        self.assetMastViewModel.getWorkOrderList()
        let filteredArray = (self.assetMastViewModel.workOrderArray as! [WoHeaderModel]).filter{$0.isSelectedCell == true}
        if filteredArray.count > 0{
        for item in filteredArray {
            item.isSelectedCell = false
        }
        self.workOrderTableView.reloadData()
        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.assetMastViewModel.workOrderArray.count)/\(self.assetMastViewModel.workOrderListArray.count)"
         self.BottomWOButton.backgroundColor = selectionBgColor
         self.BottomNOButton.backgroundColor = appColor
         NotificationCenter.default.post(name: Notification.Name(rawValue:"AssetSelectWorkOrder"), object: "tabSelected")
        statuArray.removeAll()
        statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func BottomNoAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "Notification"
        myAssetDataManager.uniqueInstance.getActiveDetails(type: "Notification")
        
        self.assetMastViewModel.getNotificationList()
        let noClass = self.assetMastViewModel.notificationArray[didSelectedCell] as! NotificationModel
        noClass.isSelectedCell = true
        let filteredArray = (self.assetMastViewModel.notificationArray as! [NotificationModel]).filter{$0.isSelectedCell == true}
        
        if filteredArray.count > 0{
            for NotifItem in filteredArray{
                NotifItem.isSelectedCell = false
            }
            self.BottomWOButton.backgroundColor = UIColor(red: 86.0/255.0, green: 138.0/255.0, blue: 173.0/255.0, alpha: 0.8)
            self.BottomNOButton.backgroundColor = UIColor(red: 64.0/255.0, green: 113.0/255.0, blue: 139.0/255.0, alpha: 1.0)
            self.workOrderTableView.reloadData()
            selectedNotificationNumber = ""
            selectedworkOrderNumber = ""
            self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(self.assetMastViewModel.notificationArray.count)"
            NotificationCenter.default.post(name: Notification.Name(rawValue:"AssetSelectWorkOrder"), object: "tabSelected")
            statuArray.removeAll()
            statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: NotificationLevel, ObjectType: "X")
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func addWorkFormButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification" {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateNotificationScreen(vc: self)
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if currentMasterView == "WorkOrder" {
            
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_WO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", delegateVC: self)
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func filterButtonAction(sender: AnyObject) {
        menuDataModel.uniqueInstance.presentListFilterScreen(vc: self, isFrm: "ASSETMAP", delegateVC: self)
    }
    func ApplyFilter() {
        if self.assetMastViewModel.workOrderListArray.count > 0 || self.assetMastViewModel.notificationListArray.count > 0{
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String, Any>
                if currentMasterView == "Notification" {
                    self.assetMastViewModel.setNotificationFilterQuery(dict: dict)
                }else if currentMasterView == "WorkOrder" {
                    self.assetMastViewModel.setWorkorderFilterQuery(dict: dict)
                }
                isfromFilter = true
            }else{
                isfromFilter = false
                filterCountLabel.isHidden = true
            }
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification" {
            did_DeSelectedCell = 0
            didSelectedCell = 0
            if(searchText == "") {
                if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                    let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String, Any>
                    self.assetMastViewModel.setNotificationFilterQuery(dict: dict)
                }else{
                    self.assetMastViewModel.notificationArray.removeAll()
                    for notifItem in self.assetMastViewModel.notificationListArray{
                        (notifItem as! NotificationModel).isSelectedCell = false
                    }
                    let noClass = self.assetMastViewModel.notificationListArray[0] as! NotificationModel
                    noClass.isSelectedCell = true
                    selectedNotificationNumber = noClass.Notification
                    self.assetMastViewModel.notificationArray = self.assetMastViewModel.notificationListArray
                    singleNotification = self.assetMastViewModel.notificationArray[0] as! NotificationModel
                }
                self.totalWorkOrderLabel.text = "Total_Notifications".localized() +  ": \(assetMastViewModel.notificationListArray.count)"
            }
            else {
                if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                    var filteredArray = [NotificationModel]()
                    if searchText.isNumeric == true
                    {
                        filteredArray = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.Notification == "\(searchText)"}
                    }else {
                        filteredArray = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.ShortText == "\(searchText)"}
                    }
                    if filteredArray.count > 0 {
                        let NoClass = filteredArray[0]
                        NoClass.isSelectedCell = true
                        selectedNotificationNumber = NoClass.Notification
                        self.assetMastViewModel.notificationArray.removeAll()
                        self.assetMastViewModel.notificationArray = filteredArray
                        singleNotification = self.assetMastViewModel.notificationArray[0] as! NotificationModel
                        self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(assetMastViewModel.notificationArray.count)/\(assetMastViewModel.notificationListArray.count)"
                    }else {
                        selectedworkOrderNumber = ""
                        singleWorkOrder = WoHeaderModel()
                        self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": 0/\(assetMastViewModel.notificationListArray.count)"
                    }
                }else{
                    self.assetMastViewModel.notificationArray.removeAll()
                    for Noitem in self.assetMastViewModel.notificationListArray{
                        (Noitem as! NotificationModel).isSelectedCell = false
                    }
                    var filteredArray = [NotificationModel]()
                    if searchText.isNumeric == true
                    {
                        filteredArray = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.Notification.contains(searchBar.text!)}
                        if filteredArray.count == 0{
                            filteredArray = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.Equipment.contains(searchBar.text!)}
                        }
                    }else {
                        filteredArray = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.ShortText.contains(searchBar.text!)}
                        if filteredArray.count == 0 {
                            filteredArray = (self.assetMastViewModel.notificationListArray as! [NotificationModel]).filter{$0.FunctionalLoc.contains(searchBar.text!)}
                        }
                    }
                    if filteredArray.count > 0 {
                        let noClass = filteredArray[0]
                        noClass.isSelectedCell = true
                        selectedNotificationNumber = noClass.Notification
                        self.assetMastViewModel.notificationArray = filteredArray
                        singleNotification = self.assetMastViewModel.notificationArray[0] as! NotificationModel
                        self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(assetMastViewModel.notificationArray.count)/\(assetMastViewModel.notificationListArray.count)"
                    }else {
                        selectedNotificationNumber = ""
                        singleNotification = NotificationModel()
                        self.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": 0/\(assetMastViewModel.notificationListArray.count)"
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
            workOrderTableView.reloadData()
            NotificationCenter.default.post(name:Notification.Name(rawValue: "dataSetSuccessfully"), object: "DataSetMasterViewNotification")
        }else if currentMasterView == "WorkOrder" {
            did_DeSelectedCell = 0
            didSelectedCell = 0
            if(searchText == "") {
                if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                    let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String, Any>
                    self.assetMastViewModel.setWorkorderFilterQuery(dict: dict)
                }else{
                    self.assetMastViewModel.workOrderArray.removeAll()
                    for itemCount in 0..<self.assetMastViewModel.workOrderListArray.count {
                        (self.assetMastViewModel.workOrderListArray[itemCount] as! WoHeaderModel).isSelectedCell = false
                    }
                    let woClass = self.assetMastViewModel.workOrderListArray[0] as! WoHeaderModel
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.assetMastViewModel.workOrderArray = self.assetMastViewModel.workOrderListArray
                    singleWorkOrder = self.assetMastViewModel.workOrderArray[0] as! WoHeaderModel
                    if DeviceType == iPad {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
                    }
                }
                self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.assetMastViewModel.workOrderArray.count)/\(self.assetMastViewModel.workOrderListArray.count)"
            }
            else {
                if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                    var filteredArray = [WoHeaderModel]()
                    if searchText.isNumeric == true
                    {
                        filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(searchBar.text!)}
                        if filteredArray.count == 0{
                            filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(searchBar.text!)}
                        }
                    }else {
                        filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.ShortText.contains(searchBar.text!)}
                        if filteredArray.count == 0 {
                            filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(searchBar.text!)}
                        }
                    }
                    if filteredArray.count > 0 {
                        let woClass = filteredArray[0]
                        woClass.isSelectedCell = true
                        selectedworkOrderNumber = woClass.WorkOrderNum
                        self.assetMastViewModel.workOrderArray.removeAll()
                        self.assetMastViewModel.workOrderArray = filteredArray
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                        singleWorkOrder = woClass
                        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.assetMastViewModel.workOrderArray.count)/\(self.assetMastViewModel.workOrderListArray.count)"
                        
                    }else {
                        selectedworkOrderNumber = ""
                        singleWorkOrder = WoHeaderModel()
                        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0/\(self.assetMastViewModel.workOrderListArray.count)"
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
                else{
                    self.assetMastViewModel.workOrderArray.removeAll()
                    var filteredArray = [WoHeaderModel]()
                    for itemCount in 0..<self.assetMastViewModel.workOrderListArray.count {
                        (self.assetMastViewModel.workOrderListArray[itemCount] as! WoHeaderModel).isSelectedCell = false
                    }
                    if searchText.isNumeric == true
                    {
                        filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(searchBar.text!)}
                        if filteredArray.count == 0{
                            
                            filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(searchBar.text!)}
                        }
                    }else {
                        
                        filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.ShortText.contains(searchBar.text!)}
                        if filteredArray.count == 0 {
                            filteredArray = (self.assetMastViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(searchBar.text!)}
                        }
                    }
                    if filteredArray.count > 0 {
                        
                        let woClass = filteredArray[0]
                        woClass.isSelectedCell = true
                        selectedworkOrderNumber = woClass.WorkOrderNum
                        self.assetMastViewModel.workOrderArray = filteredArray
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                        singleWorkOrder = woClass
                        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.assetMastViewModel.workOrderArray.count)/\(self.assetMastViewModel.workOrderListArray.count)"
                    }else {
                        selectedworkOrderNumber = ""
                        singleWorkOrder = WoHeaderModel()
                        self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0/\(self.assetMastViewModel.workOrderListArray.count)"
                        
                    }
                }
            }
            workOrderTableView.reloadData()
            NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func scanButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "search", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITextField Methods..
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            mJCLogger.log("Starting", Type: "info")
            searchTextField.text = barCode
            self.searchBar(searchTextField, textDidChange: barCode)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            mJCLogger.log("Ended", Type: "info")
        }
    }
    //MARK:- prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mJCLogger.log("Starting", Type: "info")
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! AssetMapDeatilsVC
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.assetMapDetViewModel.workOrdersListArr = self.assetMastViewModel.workOrderArray
            controller.assetMapDetViewModel.notificationListArr = self.assetMastViewModel.notificationArray
            if currentMasterView == "WorkOrder" {
                if let indexPath = self.workOrderTableView.indexPathForSelectedRow {
                    if let workOrderStr = self.assetMastViewModel.workOrderArray[indexPath.row] as? WoHeaderModel {
                        singleWorkOrder = workOrderStr
                        didSelectedCell = indexPath.row
                        workOrderStr.isSelectedCell = true
                        selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                    }
                }else{
                    if self.assetMastViewModel.workOrderArray.count > 0
                    {
                        if let workOrderStr = self.assetMastViewModel.workOrderArray[0] as? WoHeaderModel {
                            singleWorkOrder = workOrderStr
                            didSelectedCell = 0
                            workOrderStr.isSelectedCell = true
                            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                        }
                    }
                }
            }else{
                if let indexPath = self.workOrderTableView.indexPathForSelectedRow {
                    if let workOrderStr = self.assetMastViewModel.notificationArray[indexPath.row] as? NotificationModel {
                        singleNotification = workOrderStr
                        didSelectedCell = indexPath.row
                        workOrderStr.isSelectedCell = true
                        selectedNotificationNumber = singleNotification.Notification
                    }
                }else{
                    if self.assetMastViewModel.workOrderArray.count > 0
                    {
                        if let workOrderStr = self.assetMastViewModel.notificationArray[0] as? NotificationModel {
                            singleNotification = workOrderStr
                            didSelectedCell = 0
                            workOrderStr.isSelectedCell = true
                            selectedNotificationNumber = singleNotification.Notification
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
//...END...//
}


