//
//  SupervisorMapMasterVC.swift
//  myJobCard
//
//  Created by Rover Software on 24/07/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SupervisorMapMasterVC: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, filterDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var profileView: UIView!
    @IBOutlet var totalWorkOrderLabel: UILabel!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var tableViewSuperView: UIView!
    @IBOutlet var workOrderTableView: UITableView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var sortButton: UIButton!
    @IBOutlet var PriorityButton: UIButton!
    @IBOutlet var TechnicianButton: UIButton!
    @IBOutlet var statusButton: UIButton!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var detailViewController: UIViewController? = nil
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var statuArray = Array<StatusCategoryModel>()
    var technicianSort : Bool = false
    var dateSort : Bool = false
    var priortySort : Bool = false
    var lastContentOffset: CGFloat = 0
    var showMore = false
    var numberofSection = 2
    var skipvalue = masterDataLoadingItems
    var supMapViewModel = SuperMapMastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJCLogger.log("Starting", Type: "info")
        supMapViewModel.vc = self
        ODSUIHelper.setCornerRadiusToImgView(imageView: self.profileImage, cornerRadius: self.profileImage.frame.size.width / 2)
        statusButton.setTitle("Date", for: .normal)
        didSelectedCell = 0
        did_DeSelectedCell = 0
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            self.profileNameLabel.text = userDisplayName
            self.profilePetNameLabel.text = userSystemID.lowercased()
        }
        ODSUIHelper.setRoundLabel(label: self.filterCountLabel)
        self.filterCountLabel.backgroundColor = UIColor.red
        filterCountLabel.isHidden = true
        ODSUIHelper.setCornerRadiusToImgView(imageView: self.profileImage, cornerRadius: self.profileView.frame.size.width / 2)
        self.profileView.layer.borderColor = UIColor.white.cgColor
        self.profileView.layer.borderWidth = 1.0
        self.supMapViewModel.workOrderArray.removeAll()
        self.supMapViewModel.workOrderListArray.removeAll()
        self.appDeli.notificationFireType = "OpenOverViewDataBase"
        self.workOrderTableView.estimatedRowHeight = 135
        self.workOrderTableView.separatorStyle  = .none
        self.workOrderTableView.bounces = false
        self.supMapViewModel.getWorkOrderList()
        self.supMapViewModel.getTechnicianName()
        if let split = self.splitViewController as? ListSplitVC {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? SupervisorDetailsVC
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshTableView(notification:)), name:NSNotification.Name(rawValue:"refreshTableView"), object: nil)
        statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        ScreenManager.registerWorkOrderCell(tableView: self.workOrderTableView)
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SupervisorMapMasterVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        UserDefaults.standard.removeObject(forKey: "ListFilter")
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification Methods..
    @objc func refreshTableView(notification : NSNotification){
        mJCLogger.log("Starting", Type: "info")
        let indexPath = IndexPath(row: 0, section: 0)
        self.workOrderTableView.reloadData()
        if self.workOrderTableView.isValidIndexPath(indexPath: indexPath){
            self.workOrderTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: false)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- tableview scroll
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mJCLogger.log("Starting", Type: "info")
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.height{}
        mJCLogger.log("Ended", Type: "info")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notifications Methods..
    @objc  func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        didSelectedCell = 0
        did_DeSelectedCell = 0
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TableView Delegate and Datasource..
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "SupervisorMap" {
            mJCLogger.log("Ended", Type: "info")
            return self.supMapViewModel.workOrderArray.count
        }
        mJCLogger.log("Ended", Type: "info")
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        var WorkOrderList = WoHeaderModel()
        let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
        WorkOrderList = self.supMapViewModel.workOrderArray[indexPath.row]
        cell.indexpath = indexPath
        cell.supMapViewModel = supMapViewModel
        cell.superMapModelClass = WorkOrderList
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mJCLogger.log("Starting", Type: "info")
        let cell = tableView.cellForRow(at: indexPath) as! WorkOrderCell
       // TechnicianName = cell.TechnicianLabel.text!
        if currentMasterView == "SupervisorMap" {
            did_DeSelectedCell = didSelectedCell
            let filteredArray = self.supMapViewModel.workOrderArray.filter{$0.isSelectedCell == true}
            for item in 0..<filteredArray.count {
                filteredArray[item].isSelectedCell = false
            }
            didSelectedCell = indexPath.row
            if self.supMapViewModel.workOrderArray.indices.contains(didSelectedCell) == true{
                let workorder = self.supMapViewModel.workOrderArray[didSelectedCell]
                singleWorkOrder = workorder
                singleWorkOrder.isSelectedCell = true
                selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                NotificationCenter.default.post(name: Notification.Name(rawValue:"SelectWorkOrder"), object: "selectWorkOrder")
                workOrderTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
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
    //MARK:- Get WorkOrder Data..
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mJCLogger.log("Starting", Type: "info")
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! SupervisorMapDetailVC
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.supMapDetViewModel.totalWorkOrderArr = self.supMapViewModel.workOrderArray
            if let indexPath = self.workOrderTableView.indexPathForSelectedRow {
                if currentMasterView == "SupervisorMap" {
                    singleWorkOrder = self.supMapViewModel.workOrderArray[indexPath.row] as! WoHeaderModel
                    selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Button Actions
    
    @IBAction func filterButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        var priorityArray = Array<String>()
        var statusArray = Array<String>()
        for i in 0..<self.supMapViewModel.workOrderArray.count {
            if let workorder = self.supMapViewModel.workOrderArray[i] as? WoHeaderModel {
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
        mJCLogger.log("Ended", Type: "info")
    }
    func ApplyFilter() {
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
            self.supMapViewModel.setWorkorderFilterQuery(dict: dict)
            UserDefaults.standard.removeObject(forKey: "ListFilter")
        }
    }
    @IBAction func sortButtonAction(_ sender: Any) {
    }
    @IBAction func priorityButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        PriorityButton.backgroundColor = selectionBgColor
        TechnicianButton.backgroundColor = appColor
        statusButton.backgroundColor = appColor
        if priortySort == true {
            priortySort = false
            let sortedArray = self.supMapViewModel.workOrderArray.sorted(by: { $0.Priority < $1.Priority })
            self.supMapViewModel.workOrderArray.removeAll()
            self.supMapViewModel.workOrderArray = sortedArray
            if DeviceType == iPad {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                }
            }
        }else{
            priortySort = true
            self.supMapViewModel.workOrderArray = self.supMapViewModel.workOrderArray.reversed()
            if DeviceType == iPad {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                }
            }
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
            let sortedArray = self.supMapViewModel.workOrderArray.sorted(by: { $0.Technician > $1.Technician })
            self.supMapViewModel.workOrderArray.removeAll()
            self.supMapViewModel.workOrderArray = sortedArray
            if DeviceType == iPad {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                }
            }
        }else{
            technicianSort = true
            self.supMapViewModel.workOrderArray = self.supMapViewModel.workOrderArray.reversed()
            if DeviceType == iPad {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func statusButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        statusButton.backgroundColor = selectionBgColor
        TechnicianButton.backgroundColor = appColor
        PriorityButton.backgroundColor = appColor
        if dateSort == true {
            dateSort = false
            let arr = self.supMapViewModel.workOrderArray.sorted(by: { $0.BasicFnshDate ?? Date().localDate() > $1.BasicFnshDate ?? Date().localDate()})
            self.supMapViewModel.workOrderArray.removeAll()
            self.supMapViewModel.workOrderArray = arr
            if DeviceType == iPad {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                }
            }
        }else{
            dateSort = true
            self.supMapViewModel.workOrderArray = self.supMapViewModel.workOrderArray.reversed()
            if DeviceType == iPad {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                }
            }
        }
        self.workOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func SearchButtonAction(_ sender: Any) {
    }
    func backButtonClicked(_ sender: UIButton?){
    }
}
