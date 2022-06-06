//
//  CheckSheetAvailabilityVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 20/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import Foundation
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetAvailabilityVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:-  Outletss..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var searchHolderView: UIView!
    @IBOutlet var searchTextfieldHolderView: UIView!
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var searchTextFieldButton: UIButton!
    @IBOutlet var searchFilterView: UIView!
    @IBOutlet var searchFilterButton: UIButton!
    @IBOutlet var listItemTableview: UITableView!
    @IBOutlet var footerButtonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var lastSyncLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var noDataAvaialable: UILabel!
    @IBOutlet var checkSheetName: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    
    //MARK:-  Declared variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var delegate:checkSheetSelectionDelegate?
    let dropDown = DropDown()
    var filterBy = String()
    var formApprovalViewModel = CheckSheetApprovalViewModel()
    var cellIdentifier = String()
    var property = NSMutableArray()
    var selectedCheckSheet = FormAssignDataModel()
    var checkSheetApproverEntityArray = [SODataEntityDefault]()
    var checkSheetApproversList = [FormAssignDataModel]()
    var deletedApprovers = [SODataEntityDefault]()
    var previewSelectedApprovers = [ApproverMasterDataModel]()
    var selectedApprovers = [ApproverMasterDataModel]()
    var selectedCheckSheetList = [FormMasterMetaDataModel]()
    var previousSelectedCheckSheetList = [FormMasterMetaDataModel]()
    var checkListMasterArr = [FormMasterMetaDataModel]()
    var previousCheckListArr = [FormAssignDataModel]()
    var isFrom = String()
    
    //MARK: - LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.lastSyncLabel.isHidden = false
        ScreenManager.registerCheckSheetListCell(tableView: self.listItemTableview)
        self.searchTextfield.addTarget(self, action: #selector(CheckSheetAvailabilityVC.searchtextfiledTextChanged), for: UIControl.Event.editingChanged)
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        formApprovalViewModel.checkSheetAvailabilityVC = self
        if isFrom == "Approval"{
            self.headerLabel.text = "Approvers_List".localized()
            formApprovalViewModel.getApproverMasterList()
        }else{
            if checkListMasterArr.count == 0{
                formApprovalViewModel.getCheckSheetList()
            }else{
                formApprovalViewModel.checkSheetArray = checkListMasterArr
                formApprovalViewModel.checkSheetListArray = checkListMasterArr
                self.updateCheckSheetMasterUI()
            }
            self.headerLabel.text = "CheckSheet_Availability".localized()
        }
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 50.0
        self.listItemTableview.backgroundColor = UIColor.white
        if isFrom == "Approval"{
            self.searchFilterButton.setTitle("  "+"Id".localized(), for: .normal)
            self.filterBy = "Id".localized()
            checkSheetName.text = "Name".localized()
            versionLabel.text  = "UserID".localized()
            categoryLabel.text = "Plant".localized() + " / " + "WorkCenter".localized()
        }else{
            self.searchFilterButton.setTitle(" " + "CheckSheet_Name".localized(), for: .normal)
            self.filterBy = "CheckSheet_Name".localized()
            checkSheetName.text = "CheckSheet_Name".localized()
            versionLabel.text  = "Version".localized()
            categoryLabel.text = "CS_Category".localized()
        }
        self.searchTextfield.clearButtonMode = .whileEditing
        self.setLayoutToView(view: self.searchTextfieldHolderView, borderColor: UIColor.lightGray, borderWidth: 1.0)
        self.setLayoutToView(view: self.searchFilterView, borderColor: appColor, borderWidth: 1.0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let text = "  \(item)"
            self.filterBy = item
            self.searchFilterButton.setTitle(text, for: .normal)
            self.dropDown.hide()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - Data update methods
    func updateApproverMasterListUI(){
        DispatchQueue.main.async {
            if self.formApprovalViewModel.formApproverListArray.count > 0{
                self.listItemTableview.reloadData()
                self.listItemTableview.isHidden = false
                self.noDataAvaialable.isHidden = true
            }else{
                self.listItemTableview.isHidden = true
                self.noDataAvaialable.isHidden = false
            }
            self.formApprovalViewModel.getAddedApproverListForCheckSheet(form: self.selectedCheckSheet)
        }
    }
    func updateSelectedApproverUI(){
        DispatchQueue.main.async {
            self.selectedApprovers.removeAll()
            if self.previewSelectedApprovers.count > 0{
                self.selectedApprovers.append(contentsOf: self.previewSelectedApprovers)
                for i in 0..<self.selectedApprovers.count{
                    if let index = self.formApprovalViewModel.formApproverArray.index(of: self.selectedApprovers[i]){
                        self.formApprovalViewModel.formApproverArray.swapAt(index, i)
                    }
                }
                self.listItemTableview.reloadData()
                self.listItemTableview.isHidden = false
                self.noDataAvaialable.isHidden = true
            }
        }
    }
    func updateCheckSheetMasterUI(){
        DispatchQueue.main.async {
            if self.formApprovalViewModel.checkSheetArray.count > 0{
                if self.previousSelectedCheckSheetList.count > 0{
                    self.selectedCheckSheetList.removeAll()
                    self.selectedCheckSheetList.append(contentsOf: self.previousSelectedCheckSheetList)
                    for i in 0..<self.selectedCheckSheetList.count{
                        if let index = self.formApprovalViewModel.checkSheetArray.index(of: self.selectedCheckSheetList[i]){
                            self.formApprovalViewModel.checkSheetArray.swapAt(index, i)
                        }
                    }
                }
                self.listItemTableview.reloadData()
                self.listItemTableview.isHidden = false
                self.noDataAvaialable.isHidden = true
            }else{
                self.listItemTableview.isHidden = true
                self.noDataAvaialable.isHidden = false
            }
        }
    }
    //MARK: - UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFrom == "Approval"{
            return formApprovalViewModel.formApproverArray.count
        }else{
            return formApprovalViewModel.checkSheetArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if isFrom == "Approval"{
            if self.formApprovalViewModel.formApproverArray.count > 0{
                let cell = ScreenManager.getCheckSheetListCell(tableView: tableView)
                cell.formApprovalViewModel = self.formApprovalViewModel
                cell.indexpath = indexPath
                cell.formApproverModel = formApprovalViewModel.formApproverArray[indexPath.row]
                mJCLogger.log("Ended", Type: "info")
                return cell
            }
        }else{
            if self.formApprovalViewModel.checkSheetArray.count > 0{
                let cell = ScreenManager.getCheckSheetListCell(tableView: tableView)
                cell.formApprovalViewModel = formApprovalViewModel
                cell.indexpath = indexPath
                cell.checkSheetAvailabilityModel = formApprovalViewModel.checkSheetArray[indexPath.row]
                mJCLogger.log("Ended", Type: "info")
                cell.onClickCheckSheetBtn = {
                    let checkSheet = self.formApprovalViewModel.checkSheetArray[indexPath.row]
                    DispatchQueue.main.async{
                        let popView = Bundle.main.loadNibNamed("CheckSheetInfoView", owner: self, options: nil)?.last as! CheckSheetInfoView
                        popView.setFrame()
                        popView.setCheckSheetData(checkSheetObj: checkSheet)
                        UIApplication.shared.windows.first!.addSubview(popView)
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if isFrom == "Approval"{
            return []
        }else{
            let viewAction = UITableViewRowAction(style: .destructive, title: "View") { (rowAction, indexPath) in
                print("viewAction")
            }
            viewAction.backgroundColor =  UIColor(red: 88.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            return [viewAction]
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if isFrom == "Approval"{
            let approver = formApprovalViewModel.formApproverArray[indexPath.row]
            if self.selectedApprovers.contains(approver){
                if let index = self.selectedApprovers.index(of: approver){
                    self.selectedApprovers.remove(at: index)
                    let newindexpath = self.selectedApprovers.count
                    self.formApprovalViewModel.formApproverArray.swapAt(indexPath.row, newindexpath)
                }
            }else{
                let newindexpath = self.selectedApprovers.count
                self.formApprovalViewModel.formApproverArray.swapAt(indexPath.row, newindexpath)
                self.selectedApprovers.append(approver)
            }
            
            DispatchQueue.main.async {
                self.listItemTableview.reloadData()
            }
        }else{
            let checkSheet = self.formApprovalViewModel.checkSheetArray[indexPath.row]
            checkSheet.multiOccur = true
            checkSheet.mandatory = true
            checkSheet.occur = 99
            if self.previousCheckListArr.count > 0{
                let arr = self.previousCheckListArr.filter{$0.FormID == "\(checkSheet.FormID)" && $0.Version == "\(checkSheet.Version)"}
                if arr.count != 0{
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Chesheet already added", button: okay)
                    return
                }
            }
            if self.selectedCheckSheetList.contains(checkSheet){
                if let index = self.selectedCheckSheetList.index(of: checkSheet){
                    self.selectedCheckSheetList.remove(at: index)
                    let newindexpath = self.selectedCheckSheetList.count
                    self.formApprovalViewModel.checkSheetArray.swapAt(indexPath.row, newindexpath)
                }
            }else{
                let newindexpath = self.selectedCheckSheetList.count
                self.formApprovalViewModel.checkSheetArray.swapAt(indexPath.row, newindexpath)
                self.selectedCheckSheetList.append(checkSheet)
            }
            DispatchQueue.main.async {
                self.listItemTableview.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
    //MARK: - Search function..
    @IBAction func searchEditingChanged(sender: UITextField) {}
    @IBAction func searchTextFieldButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.searchtextfiledTextChanged()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func searchtextfiledTextChanged(){
        mJCLogger.log("Starting", Type: "info")
        if self.searchTextfield.text != "" {
            var searchPredicate = NSPredicate()
            if isFrom == "Approval"{
                if self.filterBy == "Id".localized() {
                    searchPredicate = NSPredicate(format: "SELF.UserSystemID contains[cd] %@", self.searchTextfield.text!)
                }else if self.filterBy == "Plant".localized() {
                    searchPredicate = NSPredicate(format: "SELF.Plant contains[cd] %@", self.searchTextfield.text!)
                }else if self.filterBy == "WorkCenter".localized() {
                    searchPredicate = NSPredicate(format: "SELF.WorkCenter contains[cd] %@", self.searchTextfield.text!)
                }else if self.filterBy == "Name".localized() {
                    searchPredicate = NSPredicate(format: "SELF.FirstName contains[cd] %@ or SELF.LastName contains[cd] %@", self.searchTextfield.text!,self.searchTextfield.text!)
                }
                let filterArray = (formApprovalViewModel.formApproverArray as NSArray).filtered(using: searchPredicate) as! [ApproverMasterDataModel]
                if   filterArray.count > 0 {
                    formApprovalViewModel.formApproverArray.removeAll()
                    formApprovalViewModel.formApproverArray =  filterArray
                }
            }else{
                if self.filterBy == "CheckSheet_Name".localized() {
                    searchPredicate = NSPredicate(format: "SELF.FormName contains[cd] %@", self.searchTextfield.text!)
                }else if self.filterBy == "Category".localized() {
                    searchPredicate = NSPredicate(format: "SELF.FormCategory contains[cd] %@", self.searchTextfield.text!)
                }else if self.filterBy == "Description".localized() {
                    searchPredicate = NSPredicate(format: "SELF.Description contains[cd] %@", self.searchTextfield.text!)
                }
                let filterArray = (formApprovalViewModel.checkSheetListArray as NSArray).filtered(using: searchPredicate) as! [FormMasterMetaDataModel]
                if filterArray.count > 0{
                    formApprovalViewModel.checkSheetArray.removeAll()
                    formApprovalViewModel.checkSheetArray =  filterArray
                }
            }
            DispatchQueue.main.async {
                self.listItemTableview.reloadData()
            }
        }else {
            if isFrom == "Approval"{
                formApprovalViewModel.formApproverArray.removeAll()
                formApprovalViewModel.formApproverArray =  formApprovalViewModel.formApproverListArray
            }else{
                formApprovalViewModel.checkSheetArray.removeAll()
                formApprovalViewModel.checkSheetArray =  formApprovalViewModel.checkSheetListArray
            }
            DispatchQueue.main.async {
                self.listItemTableview.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func searchFilterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.searchFilterView
        var arr = [String]()
        if isFrom == "Approval"{
            arr  = ["Id".localized(),"Name".localized(),"Plant".localized(),"WorkCenter".localized()]
        }else{
            arr  = ["CheckSheet_Name".localized(),"Category".localized(),"Description".localized()]
        }
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Button Actions..
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.selectedApprovers.removeAll()
        self.selectedCheckSheetList.removeAll()
        self.listItemTableview.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        if isFrom == "Approval"{
            if self.selectedApprovers.count == 0 && self.previewSelectedApprovers.count == 0{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please select approver ", button: okay)
                return
            }
            for item in selectedApprovers{
                if self.previewSelectedApprovers.contains(item){
                    if let index = self.selectedApprovers.index(of: item){
                        selectedApprovers.remove(at: index)
                    }
                }
            }
            for item in previewSelectedApprovers{
                if !self.selectedApprovers.contains(item){
                    let arr = self.self.checkSheetApproversList.filter{$0.ApproverID == "\(item.UserSystemID)"}
                    if arr.count > 0{
                        self.deletedApprovers.append(arr[0].entity)
                    }
                }
            }
            self.checkSheetApproverEntityArray.removeAll()
            for i in 0..<selectedApprovers.count{
                self.property = NSMutableArray()
                if self.selectedCheckSheet.FormID != "" && self.selectedCheckSheet.Version != ""{
                    
                    var prop = SODataPropertyDefault()
                    
                    prop = SODataPropertyDefault(name: "FormID")
                    prop.value = "\(self.selectedCheckSheet.FormID)" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "FormName")
                    prop.value = "\(self.selectedCheckSheet.FormName)" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "Version")
                    prop.value = "\(self.selectedCheckSheet.Version)" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "WorkOrderNum")
                    prop.value = "\(singleWorkOrder.WorkOrderNum)" as NSObject
                    self.property.add(prop)
                    
                    if WORKORDER_ASSIGNMENT_TYPE == "2" ||  WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        prop = SODataPropertyDefault(name: "OprNum")
                        prop.value = "\(singleOperation.OperationNum)" as NSObject
                        self.property.add(prop)
                    }
                    
                    prop = SODataPropertyDefault(name: "ApproverID")
                    prop.value = "\(selectedApprovers[i].UserSystemID)" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "FormStatus")
                    prop.value = "" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "AssignedDate")
                    let datestr = Date().localDate()
                    prop.value = datestr as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "AssignedTime")
                    let basicTime = SODataDuration()
                    let time = Date().toString(format: .custom("HH:mm"))
                    let basicTimeArray = time.components(separatedBy:":")
                    basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
                    basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
                    basicTime.seconds = 0
                    prop.value = basicTime
                    property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "AssignedBy")
                    prop.value = "\(strUser)" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "Notification")
                    prop.value = "" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "NotificationItem")
                    prop.value = "" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "NotificationTask")
                    prop.value = "" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "Equipment")
                    prop.value = "" as NSObject
                    self.property.add(prop)
                    
                    prop = SODataPropertyDefault(name: "FunctionalLocation")
                    prop.value = "" as NSObject
                    self.property.add(prop)
                }
                let formApproverEntitity = SODataEntityDefault(type: formApprovalSetEntity)
                for prop in self.property {
                    let proper = prop as! SODataProperty
                    formApproverEntitity?.properties[proper.name!] = proper
                    print("Key : \(proper.name!)")
                    print("Value :\(proper.value!)")
                    print("..............")
                }
                self.checkSheetApproverEntityArray.append(formApproverEntitity!)
            }
            formApprovalViewModel.addApproverToCheckSheet(count: 0, entityList: self.checkSheetApproverEntityArray)
        }else{
            if selectedCheckSheetList.count > 0{
                if let delegate = self.delegate {
                    delegate.checkSheetSelected?(list: self.selectedCheckSheetList, masterList: self.formApprovalViewModel.checkSheetArray)
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Set View Layout..
    func setLayoutToView(view:UIView,borderColor:UIColor,borderWidth:CGFloat) {
        mJCLogger.log("Starting", Type: "info")
        view.layer.cornerRadius = 1.0
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.masksToBounds = true
        mJCLogger.log("Ended", Type: "info")
    }
}

