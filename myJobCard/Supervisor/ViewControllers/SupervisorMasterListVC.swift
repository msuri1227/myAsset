//
//  SupervisorMasterListVC.swift
//  test
//
//  Created by Rover Software on 06/06/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SupervisorMasterListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, CustomNavigationBarDelegate, SlideMenuControllerSelectDelegate, filterDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var profileView: UIView!
    @IBOutlet var totalWorkOrderLabel: UILabel!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchInView: UIView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var tableViewSuperView: UIView!
    @IBOutlet var workOrderTableView: UITableView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var sortButton: UIButton!
    @IBOutlet var PriorityButton: UIButton!
    @IBOutlet var TechnicianButton: UIButton!
    @IBOutlet var statusButton: UIButton!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var iPhoneHeader: UIView!
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var detailViewController: UIViewController? = nil
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var lastContentOffset: CGFloat = 0
    var technicianSort : Bool = false
    var dateSort : Bool = false
    var priortySort : Bool = false
    var statuArray = Array<StatusCategoryModel>()
    var showMore = false
    var numberofSection = 2
    var skipvalue = masterDataLoadingItems
    var superViewModel = SuperMasterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        
        dateSort = false
        priortySort = false
        technicianSort = false
        superViewModel.vc = self
        
        if DeviceType == iPad{
            ODSUIHelper.setCornerRadiusToImgView(imageView: self.profileImage, cornerRadius: self.profileImage.frame.size.width / 2)
            ODSUIHelper.setBorderToView(view: self.searchInView, borderWidth: 1.0, cornerRadius: 3.0, borderColor: .lightGray)
            if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                self.profileNameLabel.text = userDisplayName
                self.profilePetNameLabel.text = userSystemID.lowercased()
            }
            statusButton.setTitle("Date", for: .normal)
            if let split = self.splitViewController as? SupervisorSplitVC {
                let controllers = split.viewControllers
                self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? SupervisorDetailsVC
            }
        }else{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Supervisor".localized(), NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            ODSUIHelper.setBorderToView(view: self.searchInView, borderWidth: 1.0, cornerRadius: 0, borderColor: .lightGray)
        }
        searchTextField.compatibleSearchTextField.backgroundColor = UIColor.white
        searchTextField.setImage(UIImage(), for: .search, state: .normal)
        ODSUIHelper.setRoundLabel(label: filterCountLabel)
        self.filterCountLabel.backgroundColor = filledCountColor
        filterCountLabel.isHidden = true
        didSelectedCell = 0
        did_DeSelectedCell = 0
        singleWorkOrder = WoHeaderModel()
        self.superViewModel.workOrderArray.removeAll()
        self.superViewModel.workOrderListArray.removeAll()
        self.appDeli.notificationFireType = "OpenOverViewDataBase"
        self.workOrderTableView.estimatedRowHeight = 135
        self.workOrderTableView.separatorStyle  = .none
        self.workOrderTableView.separatorStyle  = .none
        self.workOrderTableView.bounces = false
        self.superViewModel.getWorkOrderData()
        self.superViewModel.getTechnicianName()
        statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        ScreenManager.registerWorkOrderCell(tableView: self.workOrderTableView)
        ScreenManager.registerLoadingTableViewCell(tableView: self.workOrderTableView)
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            updateSlideMenu()
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SupervisorMasterListVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        mJCLogger.log("Ended", Type: "info")
        
    }
    //MARK:- tableview scroll
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mJCLogger.log("Starting", Type: "info")
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.height{
            if !showMore{
                let count =  self.superViewModel.workOrderListArray
                    .count
                if count > self.superViewModel.workOrderArray.count{
                    refreshList()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshList(){
        mJCLogger.log("Starting", Type: "info")
        showMore = true
        let WOcount =  self.superViewModel.workOrderListArray.count
        if numberofSection == 2 {
            self.workOrderTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print(self.skipvalue)
            self.skipvalue += masterDataLoadingItems
            if WOcount >= self.skipvalue {
                let newarr =  self.superViewModel.workOrderListArray[(self.superViewModel.workOrderArray.count)..<self.skipvalue]
                self.superViewModel.workOrderArray.append(contentsOf: newarr)
                self.showMore = false
                DispatchQueue.main.async{
                    self.workOrderTableView.reloadData()
                }
            }else{
                let count =  self.skipvalue -  self.superViewModel.workOrderListArray.count
                let newarr =  self.superViewModel.workOrderListArray[(self.superViewModel.workOrderArray.count)..<(self.skipvalue - count)]
                self.superViewModel.workOrderArray.append(contentsOf: newarr)
                self.showMore = false
                DispatchQueue.main.async{
                    self.workOrderTableView.reloadData()
                }
            }
            self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.superViewModel.workOrderArray.count)/\( self.superViewModel.workOrderListArray.count)"
            
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        if isSupervisor == "X"{
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Work_Orders".localized(),"Notifications".localized(),"Job_Location".localized(), "Time_Sheet".localized(),"Team".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }else{
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Work_Orders".localized(),"Notifications".localized(),"Job_Location".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(), "Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }
        
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Time_Sheet".localized()){
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
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Asset_Map".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
                
            }
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        
        if DeviceType == iPhone {
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Supervisor".localized(), NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            updateSlideMenu()
        }
        self.superViewModel.getWorkOrderData()
        
        mJCLogger.log("Ended", Type: "info")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Notifications Methods..
    @objc    func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        didSelectedCell = 0
        did_DeSelectedCell = 0
        self.superViewModel.getWorkOrderData()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TableView Delegate and Datasource..
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberofSection
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")
        if section == 0{
            mJCLogger.log("Ended", Type: "info")
            return self.superViewModel.workOrderArray.count
        }else if section == 1 && showMore == true{
            mJCLogger.log("Ended", Type: "info")
            return 1
        }else{
            mJCLogger.log("Ended", Type: "info")
            return 0
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        
        if indexPath.section == 0{
            let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
            if self.superViewModel.workOrderArray.count > indexPath.row{
                if let  WorkOrderList = self.superViewModel.workOrderArray[indexPath.row] as? WoHeaderModel{
                    cell.indexpath = indexPath
                    cell.superViewModel = superViewModel
                    cell.superWoModelClass = WorkOrderList
                }
            }
            mJCLogger.log("Ended", Type: "info")
            return cell
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
            let cell = tableView.cellForRow(at: indexPath) as! WorkOrderCell
           // TechnicianName = cell.dueDateLabel.text!
            did_DeSelectedCell = didSelectedCell
            let filteredArray = (self.superViewModel.workOrderArray as! [WoHeaderModel]).filter{$0.isSelectedCell == true}
            for workorderItem in filteredArray {
                workorderItem.isSelectedCell = false
            }
            didSelectedCell = indexPath.row
            let WorkOrderClass = self.superViewModel.workOrderArray[didSelectedCell] as! WoHeaderModel
            WorkOrderClass.isSelectedCell = true
            singleWorkOrder = self.superViewModel.workOrderArray[didSelectedCell] as! WoHeaderModel
            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
            NotificationCenter.default.post(name: Notification.Name(rawValue:"SelectWorkOrder"), object: "selectWorkOrder")
            workOrderTableView.reloadData()
        }else{
            singleWorkOrder = self.superViewModel.workOrderArray[indexPath.row] as! WoHeaderModel
            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
            self.superViewModel.getRecordpointdata(workorder: singleWorkOrder)
            let mainViewController = ScreenManager.getSupervisorDetailsScreen()
            currentMasterView = "WorkOrder"
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mJCLogger.log("Starting", Type: "info")
        if self.lastContentOffset < scrollView.contentOffset.y {
            // did move up
            self.searchViewHeightConstraint.constant = 0
            self.searchTextField.isUserInteractionEnabled = false
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            // did move down
            self.searchViewHeightConstraint.constant = 50
            self.searchTextField.isUserInteractionEnabled = true
        } else {
            // didn't move
            self.searchViewHeightConstraint.constant = 50
            self.searchTextField.isUserInteractionEnabled = true
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
        mJCLogger.log("Starting", Type: "info")
        if tableView.isEditing {
            mJCLogger.log("Ended", Type: "info")
            return .delete
        }
        mJCLogger.log("Ended", Type: "info")
        return .none
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mJCLogger.log("Starting", Type: "info")
        
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! SupervisorDetailsVC
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            if let indexPath = self.workOrderTableView.indexPathForSelectedRow {
                singleWorkOrder = self.superViewModel.workOrderArray[indexPath.row] as! WoHeaderModel
                selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                TechnicianName = singleWorkOrder.TechnicianName
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Button Actions
    @IBAction func filterButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_SUP_FILTER", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("filterButtonAction".localized(), Type: "")
                var priorityArray = Array<String>()
                var statusArray = Array<String>()
                for i in 0..<self.superViewModel.workOrderListArray.count {
                    if let workorder = self.superViewModel.workOrderListArray[i] as? WoHeaderModel {
                        if !statusArray.contains(workorder.UserStatus){
                            statusArray.append(workorder.UserStatus)
                        }
                        if !priorityArray.contains(workorder.Priority){
                            let prclsArr = globalPriorityArray.filter{$0.Priority == (workorder.Priority)}
                            if prclsArr.count == 1{
                                let prcls = prclsArr[0]
                                priorityArray.append(prcls.Priority)
                            }
                        }
                    }
                }
                menuDataModel.uniqueInstance.presentListFilterScreen(vc: self, isFrm: "Supervisor", delegateVC: self, priorityArr: priorityArray, statusArr: statusArray)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func ApplyFilter() {
        if  self.superViewModel.workOrderListArray.count > 0 {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                if let dict = UserDefaults.standard.value(forKey:"ListFilter") as? Dictionary<String,Any> {
                    self.superViewModel.setWorkorderFilterQuery(dict: dict)
                }
            }else{
                filterCountLabel.isHidden = true
            }
        }
    }
    

    @IBAction func sortButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        PriorityButton.backgroundColor = appColor
        if DeviceType == iPad {
            TechnicianButton.backgroundColor = appColor
            statusButton.backgroundColor = appColor
        }
        self.superViewModel.workOrderArray.removeAll()
        self.superViewModel.workOrderArray =  self.superViewModel.workOrderListArray
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    @IBAction func priorityButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        PriorityButton.backgroundColor = selectionBgColor
        TechnicianButton.backgroundColor = appColor
        statusButton.backgroundColor = appColor
        if priortySort == true {
            priortySort = false
            let sortedArray = self.superViewModel.workOrderArray.sorted(by: { ($0 as! WoHeaderModel).Priority < ($1 as! WoHeaderModel).Priority })
            self.superViewModel.workOrderArray.removeAll()
            self.superViewModel.workOrderArray = sortedArray
        }else {
            priortySort = true
            self.superViewModel.workOrderArray = self.superViewModel.workOrderArray.reversed()
        }
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    @IBAction func technicianButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        TechnicianButton.backgroundColor = selectionBgColor
        PriorityButton.backgroundColor = appColor
        statusButton.backgroundColor = appColor
        if technicianSort == true {
            technicianSort = false
            let sortedArray =  (self.superViewModel.workOrderArray as! [WoHeaderModel]).sorted(by: {$0.Technician < $1.Technician })
            self.superViewModel.workOrderArray.removeAll()
            self.superViewModel.workOrderArray = sortedArray
        }else {
            technicianSort = true
            self.superViewModel.workOrderArray = self.superViewModel.workOrderArray.reversed()
        }
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    @IBAction func statusButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        statusButton.backgroundColor = selectionBgColor
        TechnicianButton.backgroundColor = appColor
        PriorityButton.backgroundColor = appColor
        if dateSort == true {
            dateSort = false
            self.superViewModel.workOrderArray.removeAll()
            self.superViewModel.workOrderArray = self.superViewModel.workOrderListArray
        }else{
            dateSort = true
            self.superViewModel.workOrderArray = self.superViewModel.workOrderArray.reversed()
        }
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        mJCLogger.log("Starting", Type: "info")
        did_DeSelectedCell = 0
        didSelectedCell = 0
        if(searchText == "") {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                if let dict = UserDefaults.standard.value(forKey:"ListFilter") as? Dictionary<String,Any> {
                    self.superViewModel.setWorkorderFilterQuery(dict: dict)
                }
            }else{
                self.superViewModel.workOrderArray.removeAll()
                for workOrderitem in  self.superViewModel.workOrderListArray {
                    (workOrderitem as! WoHeaderModel).isSelectedCell = false
                }
                if  self.superViewModel.workOrderListArray.count > 0{
                    let woClass =  self.superViewModel.workOrderListArray[0] as! WoHeaderModel
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.superViewModel.workOrderArray =  self.superViewModel.workOrderListArray
                    singleWorkOrder = self.superViewModel.workOrderArray[0] as! WoHeaderModel
                    self.noDataView.isHidden = true
                }
            }
            self.noDataView.isHidden = true
            self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.superViewModel.workOrderListArray.count)"
        }
        else {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                var filteredArray = [WoHeaderModel]()
                if searchText.isNumeric == true
                {
                    if self.superViewModel.workOrderArray.count == 0{
                        self.superViewModel.workOrderArray =  self.superViewModel.workOrderListArray
                    }
                    filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(searchBar.text!)}
                    if filteredArray.count == 0{
                        filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(searchBar.text!)}
                    }
                }else {
                    filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.ShortText.contains(searchBar.text!)}
                    if filteredArray.count == 0 {
                        
                        filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(searchBar.text!)}
                        if filteredArray.count == 0{
                            filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.TechnicianName.contains(searchBar.text!)}
                        }
                    }
                }
                if filteredArray.count > 0 {
                    let woClass = filteredArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.superViewModel.workOrderArray.removeAll()
                    self.superViewModel.workOrderArray = filteredArray
                    singleWorkOrder = self.superViewModel.workOrderArray[0] as! WoHeaderModel
                    self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.superViewModel.workOrderArray.count)/\(self.superViewModel.workOrderListArray.count)"
                    self.noDataView.isHidden = true
                }else {
                    self.superViewModel.workOrderArray.removeAll()
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                    self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0/\(self.superViewModel.workOrderListArray.count)"
                    self.noDataView.isHidden = false
                    self.noDataLabel.text = "No_Data_Available".localized()
                    mJCLogger.log("Data not found", Type: "Debug")
                    
                }
            }else{
                self.superViewModel.workOrderArray.removeAll()
                var filteredArray = [WoHeaderModel]()
                for item in  self.superViewModel.workOrderListArray {
                    (item as! WoHeaderModel).isSelectedCell = false
                }
                if searchText.isNumeric == true
                {
                    filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(searchBar.text!)}
                    if filteredArray.count == 0{
                        filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(searchBar.text!)}
                    }
                }else {
                    filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.ShortText.contains(searchBar.text!)}
                    if filteredArray.count == 0 {
                        filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(searchBar.text!)}
                        if filteredArray.count == 0{
                            filteredArray = ( self.superViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.TechnicianName.contains(searchBar.text!)}
                        }
                    }
                }
                if filteredArray.count > 0 {
                    let woClass = filteredArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.superViewModel.workOrderArray =  filteredArray
                    singleWorkOrder = self.superViewModel.workOrderArray[0] as! WoHeaderModel
                    self.totalWorkOrderLabel.text = "Total_Workorders".localized() +  ": \(self.superViewModel.workOrderArray.count)/\(self.superViewModel.workOrderListArray.count)"
                    self.noDataView.isHidden = true
                }else {
                    self.noDataView.isHidden = false
                    self.noDataLabel.text = "No_Data_Available".localized()
                    self.superViewModel.workOrderArray.removeAll()
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                    self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0/\(self.superViewModel.workOrderListArray.count)"
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        DispatchQueue.main.async {
            self.workOrderTableView.reloadData()
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func SearchButtonAction(_ sender: Any) {
    }
    
    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        if sender?.imageView?.image == UIImage.init(named: "backButton") {
            self.dismiss(animated: true, completion: nil)
        }else {
            openLeft()
        }
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
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    func threedotmenuButtonClicked(_ sender: UIButton?){
        
    }
    
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        
        if title == "Team".localized() {
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
        else if title == "Time_Sheet".localized() {
            currentMasterView = "TimeSheet"
            let mainViewController = ScreenManager.getTimeSheetScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Asset_Map".localized(){
            
            ASSETMAP_TYPE = "ESRIMAP"
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
        }else if title == "Work_Orders".localized() {
            selectedNotificationNumber = ""
            currentMasterView = "WorkOrder"
            UserDefaults.standard.removeObject(forKey: "ListFilter")
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
        }else if title == "Job_Location".localized(){
            ASSETMAP_TYPE = ""
            currentMasterView = "MapSplitViewController"
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            fromSupervisorWorkOrder = true
            var mainViewController = ScreenManager.getMapDeatilsScreen()
            
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            
        }else if title == "Error_Logs"{
            myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }
}
