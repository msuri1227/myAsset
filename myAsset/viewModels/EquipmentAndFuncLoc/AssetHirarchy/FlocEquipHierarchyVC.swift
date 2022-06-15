//
//  FunctionaLocationListVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 2/24/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class FlocEquipHierarchyVC: UIViewController , UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    

    //MARK:- Outlets..
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
    @IBOutlet weak var techIdHeaderLabel: UILabel!
    @IBOutlet var scanButton: UIButton!
    @IBOutlet var HierarchyTable: HierarchyTreeView!
    @IBOutlet var detaisTitleView: UIView!
    @IBOutlet var detailsTitleViewHightConstant: NSLayoutConstraint!
    //MARK:-  Declared variables..

    let dropDown = DropDown()
    var filterBy = String()
    var isSelect = String()
    var selectedFunLoc = String()
    // installequipment
    var selectedplant = String()
    var selectedWorkcenter = String()
    var selectedCategory = String()
    var selectedFuncLocation = String()
    //asset
    var selectedEQ = EquipmentModel()
    var selectedFL = FunctionalLocationModel()
    var planningPlant = String()
    var workCenter = String()
    var delegate:FuncLocEquipSelectDelegate?
    var funcEquipViewModel = FuncEquipViewModel()

    var selectedTreeNode : HierarchyTreeViewNode? = nil
    let treeViewCellIdentifier = "HierarchyTreeViewCell"
    let treeViewCellNibName = "HierarchyTreeViewCell"
    //MARK:- LifeCycle.
    var hirechy = false
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        funcEquipViewModel.funcEquipVc = self
        self.scanButton.isHidden = true
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else{
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        self.searchTextfield.font = UIFont.systemFont(ofSize: 12)
        if self.isSelect == "FunctionalLocation" {
            self.searchTextfield.placeholder = "Search_Functional_location".localized()
        }else if self.isSelect == "Equipement" {
            self.searchTextfield.placeholder = "Search_Equipment".localized()
        }
        if hirechy == true{
            funcEquipViewModel.getRootLevelNodesForAssetHierarchy()
        }else{
            funcEquipViewModel.getFunctionLocationList()
        }
        HierarchyTable.collapseNoneSelectedRows = false
        HierarchyTable.treeViewDelegate = self
        HierarchyTable.register(UINib(nibName: treeViewCellNibName, bundle: nil), forCellReuseIdentifier: treeViewCellIdentifier)
        self.listItemTableview.isHidden = true
        self.HierarchyTable.isHidden = false
        self.detaisTitleView.isHidden = true
        self.detailsTitleViewHightConstant.constant = 0.0
        self.searchTextfield.addTarget(self, action: #selector(FunctionaLocationListVC.searchTextFieldMethod), for: UIControl.Event.editingChanged)
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 66.0
        self.listItemTableview.backgroundColor = UIColor.white
        self.searchFilterButton.setTitle("  " + "Id".localized(), for: .normal)
        self.filterBy = "Id"
        self.searchTextfield.clearButtonMode = .whileEditing
        self.lastSyncLabel.isHidden = false

        ODSUIHelper.setBorderToView(view: self.searchTextfieldHolderView)
        ODSUIHelper.setBorderToView(view: self.searchFilterView)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.funcEquipViewModel.FuncEquipArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")

        let functionalLocationCell = tableView.dequeueReusableCell(withIdentifier: "FunctionalLocationListCell") as! FunctionalLocationListCell
        if self.funcEquipViewModel.FuncEquipArray.count > 0{
            if let funcClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? FunctionalLocationModel{
                functionalLocationCell.isCellFrom = "FuncEquipVC"
                functionalLocationCell.funcLocationClass = funcClass
            }else if let EquipClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? EquipmentModel{
                functionalLocationCell.isCellFrom = "FuncEquipVC"
                functionalLocationCell.equipmentClass = EquipClass
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return functionalLocationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        selectedEQ = EquipmentModel()
        selectedFL = FunctionalLocationModel()
        if let funcClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? FunctionalLocationModel{
            selectedFL = funcClass
        }else if let EquipClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? EquipmentModel{
            selectedEQ = EquipClass
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    //MARK:- Search Button Action..
    @IBAction func searchTextFieldButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.funcEquipViewModel.searchFuncOrEquipList()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func searchFilterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.searchFilterView
        var arr = [String]()
        if self.isSelect == "FunctionalLocation" {
            arr = ["Id".localized(),"Description".localized()]
        }else if self.isSelect == "Equipement" {
            arr = ["Id".localized(),"Description".localized(),"Tech_ID".localized()]
        }
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        self.listItemTableview.isHidden = true
        self.HierarchyTable.isHidden = false
        self.detaisTitleView.isHidden = true
        self.detailsTitleViewHightConstant.constant = 0.0
        self.HierarchyTable.reloadData()
        textField.text = ""
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    //MARK:- Search TextField Methods..
    @objc   @IBAction func searchEditingChanged(sender: UITextField) {
        mJCLogger.log("Starting", Type: "info")
        if sender.text == "" {
            self.listItemTableview.isHidden = true
            self.HierarchyTable.isHidden = false
            self.detaisTitleView.isHidden = true
            self.detailsTitleViewHightConstant.constant = 0.0
            self.HierarchyTable.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func searchTextFieldMethod() {
        mJCLogger.log("Starting", Type: "info")
        if self.searchTextfield.text == "" {
            self.listItemTableview.isHidden = true
            self.HierarchyTable.isHidden = false
            self.detaisTitleView.isHidden = true
            self.detailsTitleViewHightConstant.constant = 0.0
            self.HierarchyTable.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.searchTextfield.text = ""
        searchTextFieldMethod()
        self.listItemTableview.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func BackButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLoader.stopAnimating()
        mJCLogger.log("Ended", Type: "info")
    }
    func updateSelectedFlocAndEquipmentDetails(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.isSelect == "FunctionalLocation" {
                if self.selectedFL.FunctionalLoc == "" && self.selectedEQ.Equipment == "" {
                    mJCLogger.log("Functional_location_Not_Selected".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
                }else{
                    if self.selectedFL.FunctionalLoc != ""{
                        self.delegate?.FuncLocOrEquipSelected(selectedObj: "FunctionalLocation", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                        self.dismiss(animated: false) {}
                    }else if self.selectedEQ.Equipment != ""{
                        self.delegate?.FuncLocOrEquipSelected(selectedObj: "Equipment", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                        self.dismiss(animated: false) {}
                    }else{
                        mJCLogger.log("Functional_location_Not_Selected".localized(), Type: "Error")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
                    }
                }
            }else if self.isSelect == "Equipement" {
                if self.selectedEQ.Equipment == "" && self.selectedFL.FunctionalLoc == ""{
                    mJCLogger.log("Equipment_not_selected".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
                }else {
                    if self.selectedEQ.Equipment != ""{
                        self.delegate?.FuncLocOrEquipSelected(selectedObj: "Equipment", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                        self.dismiss(animated: false) {}
                    }else if self.selectedFL.FunctionalLoc != ""{
                        self.delegate?.FuncLocOrEquipSelected(selectedObj: "FunctionalLocation", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                        self.dismiss(animated: false) {}
                    }else{
                        mJCLogger.log("Equipment_not_selected".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.HierarchyTable.isHidden == false{
            if self.isSelect == "FunctionalLocation" && self.selectedTreeNode == nil{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
            }else if self.isSelect == "Equipement" && self.selectedTreeNode == nil{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
            }else{
                let dataObj = selectedTreeNode!.item as! HierarchyTreeViewData
                if dataObj.nodeType == "FL"{
                    funcEquipViewModel.getSelectedFLocDetails(floc: dataObj.nodeTitle)
                }else if dataObj.nodeType == "EQ"{
                    funcEquipViewModel.getSelectedEqpDetails(equipment: dataObj.nodeTitle)
                }
            }
        }else if self.listItemTableview.isHidden == false{
            DispatchQueue.main.async {
                if self.isSelect == "FunctionalLocation" {
                    if self.selectedFL.FunctionalLoc == "" && self.selectedEQ.Equipment == "" {
                        mJCLogger.log("Functional_location_Not_Selected".localized(), Type: "Error")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
                    }else {
                        if self.selectedFL.FunctionalLoc != ""{
                            self.delegate?.FuncLocOrEquipSelected(selectedObj: "FunctionalLocation", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                            self.dismiss(animated: false) {}
                        }else if self.selectedEQ.Equipment != ""{
                            self.delegate?.FuncLocOrEquipSelected(selectedObj: "Equipment", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                            self.dismiss(animated: false) {}
                        }else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
                        }
                    }
                }else if self.isSelect == "Equipement" {
                    if self.selectedEQ.Equipment == "" && self.selectedFL.FunctionalLoc == ""{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
                    }else {
                        if self.selectedEQ.Equipment != ""{
                            self.delegate?.FuncLocOrEquipSelected(selectedObj: "Equipment", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                            self.dismiss(animated: false) {}
                        }else if self.selectedFL.FunctionalLoc != ""{
                            self.delegate?.FuncLocOrEquipSelected(selectedObj: "FunctionalLocation", EquipObj: self.selectedEQ, FuncObj: self.selectedFL)
                            self.dismiss(animated: false) {}
                        }else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismiss(animated: false) {}
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
    //...END..//
}
extension FlocEquipHierarchyVC : HierarchyTreeViewDelegate {

    func treeViewNode(_ treeViewNode: HierarchyTreeViewNode, willExpandAt indexPath: IndexPath) {
    }
    func treeViewNode(_ treeViewNode: HierarchyTreeViewNode, didExpandAt indexPath: IndexPath) {
        let dataObj = treeViewNode.item as! HierarchyTreeViewData
        let cell = HierarchyTable.cellForRow(at: indexPath) as! HierarchyTreeViewCell
        if dataObj.hasChildren{
            cell.expandImgView.image = UIImage(named: "DownArrow")
        }else{
            cell.expandImgView.image = UIImage(named: "emptySideArrow")
        }
    }
    func treeViewNode(_ treeViewNode: HierarchyTreeViewNode, willCollapseAt indexPath: IndexPath) {
    }
    func treeViewNode(_ treeViewNode: HierarchyTreeViewNode, didCollapseAt indexPath: IndexPath) {
        let dataObj = treeViewNode.item as! HierarchyTreeViewData
        let cell = HierarchyTable.cellForRow(at: indexPath) as! HierarchyTreeViewCell
        if dataObj.hasChildren{
            cell.expandImgView.image = UIImage(named: "SideArrow")
        }else{
            cell.expandImgView.image = UIImage(named: "emptySideArrow")
        }
    }
    func treeView(_ treeView: HierarchyTreeView, heightForRowAt indexPath: IndexPath, with treeViewNode: HierarchyTreeViewNode) -> CGFloat {
        return 45
    }
    func treeView(_ treeView: HierarchyTreeView, didDeselectRowAt treeViewNode: HierarchyTreeViewNode, at indexPath: IndexPath) {

    }
    func treeView(_ treeView: HierarchyTreeView, didSelectRowAt treeViewNode: HierarchyTreeViewNode, at indexPath: IndexPath) {
        let dataObj = treeViewNode.item as! HierarchyTreeViewData
        self.selectedTreeNode = treeViewNode
        if dataObj.hasChildren && dataObj.nodeChildren.count == 0{
            mJCLoader.startAnimating(status: "")
            funcEquipViewModel.selectedIndex = indexPath
            funcEquipViewModel.getBatchForChild(treeObject: dataObj)
        }
    }
}
extension FlocEquipHierarchyVC : HierarchyTreeViewDataSource {

    func treeViewSelectedNodeChildren(for treeViewNodeItem: Any) -> [Any] {
        if let dataObj = treeViewNodeItem as? HierarchyTreeViewData {
            return dataObj.nodeChildren
        }
        return []
    }
    func treeViewDataArray() -> [Any] {
        return funcEquipViewModel.dataArr
    }
    func treeView(_ treeView: HierarchyTreeView, cellForRowAt indexPath: IndexPath, with treeViewNode: HierarchyTreeViewNode) -> UITableViewCell {
        let cell = treeView.dequeueReusableCell(withIdentifier: treeViewCellIdentifier) as! HierarchyTreeViewCell
        let dataObj = treeViewNode.item as! HierarchyTreeViewData
        cell.titleLabel.text = dataObj.nodeTitle
        cell.descriptionLabel.text = dataObj.nodeDescription
        if dataObj.nodeType == "EQ"{
            cell.typeImg.image = UIImage(named: "components")
        }else if dataObj.nodeType == "FL"{
            cell.typeImg.image = UIImage(named: "ic_locationblue")
        }else{
            cell.typeImg.isHidden = true
        }
        if dataObj.hasChildren{
            cell.expandImgView.image = UIImage(named: "SideArrow")
        }else{
            cell.expandImgView.image = UIImage(named: "emptySideArrow")
        }
        cell.setupCell(level: treeViewNode.level)
        return cell;
    }
}
