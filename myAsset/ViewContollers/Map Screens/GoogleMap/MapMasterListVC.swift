//
//  MapMasterListVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/7/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class MapMasterListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,filterDelegate {
   
    
    //MARK:- Outlets..
    @IBOutlet var profileView: UIView!
    @IBOutlet var totalWorkOrderLabel: UILabel!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchInView: UIView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var tableViewSuperView: UIView!
    @IBOutlet var workOrderTableView: UITableView!
    
    @IBOutlet var footerView: UIView!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet var addWorkFormButton: UIButton!
    @IBOutlet var priorityButton: UIButton!
  
    @IBOutlet var noDataView: UIView!
    
    @IBOutlet var noDataLabel: UILabel!
    
    @IBOutlet weak var ActiveOrderButton: UIButton!
    
    //MARK:- Declared Variables..
    var addressNumberArray = NSArray()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var detailViewController: UIViewController? = nil
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
@objc    var Priority = String()
    
    var last = String()
    var statuArray = Array<StatusCategoryModel>()
    
    var technicianSort : Bool = false
    var dateSort : Bool = false
    var priortySort : Bool = false
    
    var showMore = false
    var numberofSection = 2
    var skipvalue = masterDataLoadingItems
    var totalWOCount = Int()
    var totalNOCount = Int()
    var isfromFilter = Bool()
    var mapMasterViewModel = MapMasterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")

        isfromFilter = false

        mapMasterViewModel.vc = self
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        
        self.profileView.layer.masksToBounds = true
        
        self.setLayout()
        myAssetDataManager.uniqueInstance.getActiveDetails(type: "WorkOrder")

        self.mapMasterViewModel.getWorkOrderList()
    
        isSupportPortait = false
     
        
        
       
        
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            
            self.profileNameLabel.text = userDisplayName
            self.profilePetNameLabel.text = userSystemID.lowercased()
        }
        
        mapMasterViewModel.workOrderArray.removeAll()
        mapMasterViewModel.workOrderListArray.removeAll()
        appDeli.notificationFireType = "OpenOverViewDataBase"
        workOrderTableView.estimatedRowHeight = 135
        workOrderTableView.separatorStyle  = .none
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Search".localized(),attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        
        if let split = self.splitViewController as? MapSplitVC {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MapDeatilsVC
        }
        ScreenManager.registerWorkOrderCell(tableView: self.workOrderTableView)

        NotificationCenter.default.addObserver(self, selector: #selector(MapMasterListVC.filterWorkOrder(notification:)), name:NSNotification.Name(rawValue:"FilterWorkOrder"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableView(notification:)), name:NSNotification.Name(rawValue:"reloadTableView"), object: nil)
        ScreenManager.registerLoadingTableViewCell(tableView: self.workOrderTableView)
        mJCLogger.log("Ended", Type: "info")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")

        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

         statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        mJCLogger.log("Ended", Type: "info")

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Notification deinit..
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Filter Workorder..
    @objc func filterWorkOrder(notification : NSNotification){
        mJCLogger.log("Starting", Type: "info")

        if(notification.name.rawValue != "")
        {
            let str = notification.object as! String
            self.mapMasterViewModel.map_searchTextFieldEditingChanged(searchText: str)
        }
        mJCLogger.log("Ended", Type: "info")

    }
    
    
    @IBAction func ActiveOrderButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")

        if((UserDefaults.standard.value(forKey:"active_details")) != nil){
            
            let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
            let activeWOnum = activedetails.value(forKey: "WorkorderNum") as! String
            let filterar = (self.mapMasterViewModel.workOrderArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(activeWOnum)"}
            if filterar.count > 0{
                if let index = (self.mapMasterViewModel.workOrderArray as! [WoHeaderModel]).firstIndex(of: filterar[0]){
                    if self.mapMasterViewModel.workOrderArray.indices.contains(index){
                        let indexPath  = IndexPath(row: index, section: 0)
                        
                        if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                            if DeviceType == iPad{
                                self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                            }
                            self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                        
                    }else{
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
                        mJCLogger.log("Active_work_orders_not_found".localized(), Type: "Debug ")
                    }
                    
                }else{
                    mJCLogger.log("Active_work_orders_not_found".localized(), Type: "Debug ")
                    
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
                }
            }else{
                let filterar2 = (self.mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(activeWOnum)"}
                if filterar2.count > 0{
                    var index = (self.mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).firstIndex(of: filterar2[0]) ?? 0
                    
                    var countValue = 0
                    var listValue = 0
                    countValue = (index/50)+1
                    listValue = (50*countValue)
                    if listValue > self.mapMasterViewModel.workOrderListArray.count{
                        let removeValue = listValue - self.mapMasterViewModel.workOrderListArray.count
                        listValue = listValue - removeValue
                    }
                    
                    
                    self.mapMasterViewModel.workOrderArray.removeAll()
                    
                    for i in 0..<listValue{
                        self.mapMasterViewModel.workOrderArray.append(self.mapMasterViewModel.workOrderListArray[i])
                    }
                    if DeviceType == iPad {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
                    }
                    index = (self.mapMasterViewModel.workOrderArray as! [WoHeaderModel]).firstIndex(of: filterar2[0]) ?? 0
                    if index <= self.mapMasterViewModel.workOrderArray.count{
                        let indexPath  = IndexPath(row: index, section: 0)
                        selectedworkOrderNumber = activeWOnum
                        DispatchQueue.main.async {
                            
                            self.workOrderTableView.reloadData()
                            self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.mapMasterViewModel.workOrderArray.count)/\(self.mapMasterViewModel.workOrderListArray.count)"
                            
                            if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
                                if DeviceType == iPad{
                                    self.tableView(self.workOrderTableView, didSelectRowAt: indexPath)
                                }
                                self.workOrderTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            
        }else{
            mJCLogger.log("Active_work_orders_not_found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Active_work_orders_not_found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")

    }
 
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofSection

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")

        if section == 0{
            mJCLogger.log("Ended", Type: "info")
        return mapMasterViewModel.workOrderArray.count
            
        }else if section == 1 && showMore == true{
            mJCLogger.log("Ended", Type: "info")

            return 1
         }
        mJCLogger.log("Ended", Type: "info")

        return 0
    }
    
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    mJCLogger.log("Starting", Type: "info")

    if indexPath.section == 0{

    let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
        if indexPath.row < mapMasterViewModel.workOrderArray.count{
            if let WorkOrderList = mapMasterViewModel.workOrderArray[indexPath.row] as? WoHeaderModel {
                cell.indexpath = indexPath
                cell.mapMasterViewModel = mapMasterViewModel
                // cell.mapWoModelClass = WorkOrderList
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        return cell
    }else {
        let loaderCell = ScreenManager.getLoadingTableViewCell(tableView: self.workOrderTableView)
        loaderCell.loader.startAnimating()
        mJCLogger.log("Ended", Type: "info")
        return loaderCell
    }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")

        did_DeSelectedCell = didSelectedCell
        let filteredArray = (self.mapMasterViewModel.workOrderArray as! [WoHeaderModel]).filter{$0.isSelectedCell == true}
          
        for workorderItem in filteredArray {
            
            workorderItem.isSelectedCell = false
        }
        
        didSelectedCell = indexPath.row
         let workOrderStr = mapMasterViewModel.workOrderArray[didSelectedCell]
        singleWorkOrder = workOrderStr as! WoHeaderModel
            singleWorkOrder.isSelectedCell = true
            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
            NotificationCenter.default.post(name: Notification.Name(rawValue:"SelectWorkOrder"), object: "selectWorkOrder")
            workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    //MARK:- Search Functionality..
    @IBAction func searchButtonAction(sender: AnyObject) {
        
    }
    
    //MARK:- tableview scroll
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mJCLogger.log("Starting", Type: "info")

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY >= contentHeight - scrollView.frame.height{
            if !showMore{
                let count = self.mapMasterViewModel.workOrderListArray.count
                if count > mapMasterViewModel.workOrderArray.count && isfromFilter == false{
                    refreshList()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func filterButtonAction(sender: AnyObject){

        let filterVC = ScreenManager.getListFilterScreen()
        filterVC.isfrom = currentMasterView
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_FILTER", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                var priorityArray = [String]()
                var ordertypeArray = [String]()
                var statusArray = [String]()
                var plantArray = [String]()
                var createdByArray = [String]()
                var mainWorkCenterArray = [String]()
                var mainPlantGroupArray = [String]()
                var staffIdArr = [String]()
                var maintenancePlantArray = [String]()
                var planningPlantArray = [String]()
                var equipArray = [String]()

                priorityArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.Priority}
                ordertypeArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.OrderType}
                statusArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MobileObjStatus}
                plantArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.Plant}
                createdByArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.EnteredBy}
                mainWorkCenterArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MainWorkCtr}
                mainPlantGroupArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.ResponsiblPlannerGrp}
                staffIdArr = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.PersonResponsible}
                maintenancePlantArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MaintPlant}
                planningPlantArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MaintPlanningPlant}
                equipArray = (mapMasterViewModel.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.EquipNum}

                filterVC.filterViewModel.priorityArray = priorityArray
                filterVC.filterViewModel.typeArray = ordertypeArray
                filterVC.filterViewModel.statusArray = statusArray
                filterVC.filterViewModel.plantsArray = plantArray
                filterVC.filterViewModel.createdByArray = createdByArray
                filterVC.filterViewModel.mainWorkCenterArry = mainWorkCenterArray
                filterVC.filterViewModel.mainPlantGroupListArray = mainPlantGroupArray
                filterVC.filterViewModel.persponseArray = staffIdArr
                filterVC.filterViewModel.maintenancePlantArray = maintenancePlantArray
                filterVC.filterViewModel.planningPlantArray = planningPlantArray
                filterVC.filterViewModel.equipmentArray = equipArray

                filterVC.isfrom = "WorkOrderMAP"
                filterVC.delegate = self
                filterVC.modalPresentationStyle = .fullScreen
                self.present(filterVC, animated: false) {}

            }
        }
    }

//    {
//
//        mJCLogger.log("Starting", Type: "info")
//
//        let filterVC = ScreenManager.getListFilterScreen()
//        var priorityArray = Array<String>()
//        var statusArray = Array<String>()
//        var ordertypeArray = Array<String>()
//        var workcenterArray = Array<String>()
//        var createdByArray = Array<String>()
//
//        for workorderItem in self.mapMasterViewModel.workOrderListArray{
//
//            if !statusArray.contains((workorderItem as! WoHeaderModel).UserStatus){
//                statusArray.append((workorderItem as! WoHeaderModel).UserStatus)
//            }
//            if !ordertypeArray.contains((workorderItem as! WoHeaderModel).OrderType){
//                ordertypeArray.append(((workorderItem as! WoHeaderModel) ).OrderType)
//            }
//            if !workcenterArray.contains((workorderItem as! WoHeaderModel).MainWorkCtr){
//                workcenterArray.append((workorderItem as! WoHeaderModel).MainWorkCtr)
//            }
//            if !createdByArray.contains((workorderItem as! WoHeaderModel).LastChangedBy){
//                createdByArray.append((workorderItem as! WoHeaderModel).LastChangedBy)
//            }
//            if !priorityArray.contains((workorderItem as! WoHeaderModel).Priority){
//                let prclsArr = globalPriorityArray.filter{$0.Priority == ((workorderItem as! WoHeaderModel).Priority)}
//                if prclsArr.count == 1{
//                    let prcls = prclsArr[0]
//                    priorityArray.append(prcls.Priority)
//                }
//            }
//        }
//
//        filterVC.filterViewModel.priorityArray = priorityArray
//        filterVC.filterViewModel.statusArray = statusArray
//        filterVC.filterViewModel.typeArray = ordertypeArray
//        filterVC.filterViewModel.mainWorkCenterArry = workcenterArray
//        filterVC.filterViewModel.createdByArray = createdByArray
//
//
//        mJCLogger.log("Ended", Type: "info")
//    }
    
    
    //MARK:- MasterView Footer Button..
    @IBAction func downloadButtonAction(sender: AnyObject) {
    }
    
    @IBAction func priorityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")

        if priortySort == true {
            priortySort = false
            let sortedArray = (self.mapMasterViewModel.workOrderArray as! [WoHeaderModel]).sorted(by: { $0.Priority < $1.Priority })

            self.mapMasterViewModel.workOrderArray.removeAll()
            self.mapMasterViewModel.workOrderArray = sortedArray
        }
        else {
            priortySort = true

            self.mapMasterViewModel.workOrderArray = self.mapMasterViewModel.workOrderArray.reversed()
        }
        if DeviceType == iPad {
           DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                    }
        }
       
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func dateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")

        if dateSort == true {
            dateSort = false
            let arr = (self.mapMasterViewModel.workOrderArray as! [WoHeaderModel]).sorted(by: { $0.BasicStrtDate ?? Date().localDate() > $1.BasicStrtDate ?? Date().localDate()})
            self.mapMasterViewModel.workOrderArray.removeAll()
            self.mapMasterViewModel.workOrderArray = arr
        }else {
            dateSort = true
            mapMasterViewModel.workOrderArray = mapMasterViewModel.workOrderArray.reversed()
        }
        if DeviceType == iPad {
           DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                    }
        }
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func addWorkFormButtonAction(sender: AnyObject) {
        
    }
    
    //MARK:- prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mJCLogger.log("Starting", Type: "info")

        if segue.identifier == "showDetail" {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! MapDeatilsVC
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.workOrderArray = self.mapMasterViewModel.workOrderArray
            controller.workOrderListArray = self.mapMasterViewModel.workOrderListArray
            if let indexPath = self.workOrderTableView.indexPathForSelectedRow {
                if let workOrderStr = mapMasterViewModel.workOrderArray[indexPath.row] as? WoHeaderModel {
                singleWorkOrder = workOrderStr
                selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Filter WorkOrder..
    func setWorkorderFilterQuery(dict : Dictionary<String,Any>) {
        
        mJCLogger.log("Starting", Type: "info")
        isfromFilter = true
        let predicateArray = NSMutableArray()
        
        if dict.keys.count == 0{
            isfromFilter = false
            mapMasterViewModel.workOrderArray.removeAll()
            for workorderItem in self.mapMasterViewModel.workOrderListArray {
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            if mapMasterViewModel.workOrderListArray.count > 0{
                let woClass = self.mapMasterViewModel.workOrderListArray[0] as! WoHeaderModel
                woClass.isSelectedCell = true
                selectedworkOrderNumber = woClass.WorkOrderNum
                self.mapMasterViewModel.workOrderArray = self.mapMasterViewModel.workOrderListArray

                singleWorkOrder = woClass
                filterCountLabel.isHidden = true
                self.noDataView.isHidden = true
                self.noDataLabel.text = ""
                self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ":"+"\(self.mapMasterViewModel.workOrderArray.count)"+"/"+"\(self.mapMasterViewModel.workOrderListArray.count)"
                self.workOrderTableView.reloadData()
            }
        }else{
            
            if dict.keys.contains("priority"),let arr = dict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("orderType"),let arr = dict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "OrderType IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("status"),let arr = dict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", arr,arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("createdBy"),let arr = dict["createdBy"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "EnteredBy IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("mainWorkCenter"),let arr = dict["mainWorkCenter"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MainWorkCtr IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            did_DeSelectedCell = 0
            didSelectedCell = 0
            for workorderItem in self.mapMasterViewModel.workOrderListArray {
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            let array = self.mapMasterViewModel.workOrderListArray.filter{compound.evaluate(with: $0)}
            self.mapMasterViewModel.workOrderArray.removeAll()
            if array.count > 0 {
                if let woClass = array[0] as? WoHeaderModel {
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.mapMasterViewModel.workOrderArray = array
                    singleWorkOrder = self.mapMasterViewModel.workOrderArray[0] as! WoHeaderModel
                    filterCountLabel.isHidden = false
                    filterCountLabel.text = "\(mapMasterViewModel.workOrderArray.count)"
                }
                self.noDataView.isHidden = true
                self.noDataLabel.text = ""
            }else{
                filterCountLabel.isHidden = false
                filterCountLabel.text = "0"
                self.noDataView.isHidden = false
                self.noDataLabel.text = "No_Data_Available".localized()
                mJCLogger.log("Data not found", Type: "Debug ")
                selectedworkOrderNumber = ""
                singleWorkOrder = WoHeaderModel()
            }
            self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ":"+"\(self.mapMasterViewModel.workOrderArray.count)"+"/"+"\(self.mapMasterViewModel.workOrderListArray.count)"

            self.workOrderTableView.reloadData()
            NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
            mJCLogger.log("setWorkorderFilterQuery End".localized(), Type: "")
        }

        if DeviceType == iPad {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Notification Methods..
    
    @objc func reloadTableView(notification : NSNotification){
        mJCLogger.log("Starting", Type: "info")

        self.workOrderTableView.reloadData()
//        let indexPath = IndexPath(row: selectedWOIndex, section: 0)
//      
//        if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
//            self.workOrderTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: false)
//        }
    
        mJCLogger.log("Ended", Type: "info")
    }
            
    func ApplyFilter(){
        mJCLogger.log("Starting", Type: "info")
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
            self.setWorkorderFilterQuery(dict: dict)
        }else{
            isfromFilter = false
            filterCountLabel.isHidden = true
            self.noDataView.isHidden = true
            self.noDataLabel.text = ""
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Set Layout..
    func setLayout() {
        mJCLogger.log("Starting", Type: "info")

        self.filterCountLabel.layer.cornerRadius = self.filterCountLabel.frame.size.width / 2
        self.filterCountLabel.layer.masksToBounds = true
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
    }
    
    
    func refreshList(){
        mJCLogger.log("Starting", Type: "info")

        showMore = true
        let WOcount = self.mapMasterViewModel.workOrderListArray.count
       
        if numberofSection == 2 {
            self.workOrderTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print(self.skipvalue)
            self.skipvalue += masterDataLoadingItems
            if WOcount >= self.skipvalue {
                let newarr = self.mapMasterViewModel.workOrderListArray[(self.mapMasterViewModel.workOrderArray.count)..<self.skipvalue]
                self.mapMasterViewModel.workOrderArray.append(contentsOf: newarr)
               
                self.showMore = false
                DispatchQueue.main.async{
                    self.workOrderTableView.reloadData()
                }
            }else{
                let count =  self.skipvalue - self.mapMasterViewModel.workOrderListArray.count
                let newarr = self.mapMasterViewModel.workOrderListArray[(self.mapMasterViewModel.workOrderArray.count)..<(self.skipvalue - count)]
                self.mapMasterViewModel.workOrderArray.append(contentsOf: newarr)
              
                self.showMore = false
                DispatchQueue.main.async{
                    self.workOrderTableView.reloadData()
                }
            }
            self.totalWorkOrderLabel.text = "Total_Workorders".localized() + ":"+"\(self.mapMasterViewModel.workOrderArray.count)"+"/"+"\(self.mapMasterViewModel.workOrderListArray.count)"
            if DeviceType == iPad {
               DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
//...END
}
