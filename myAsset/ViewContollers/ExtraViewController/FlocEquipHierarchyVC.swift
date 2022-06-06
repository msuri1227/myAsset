//
//  FlocEquipHierarchyVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 2/24/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class FlocEquipHierarchyVC: UIViewController , UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,barcodeDelegate{
    
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
    @IBOutlet weak var AssetHierarchyTableView: UITableView!
    
    //MARK:-  Declared variables..
    
    let dropDown = DropDown()
    var filterBy = String()
    var isSelect = String()
    var selectedFunLoc = String()
    var selectedplant = String()
    var selectedWorkcenter = String()
    var selectedCategory = String()
    var selectedFuncLocation = String()
    var indentation: Int = 0
    var selectedEQ = EquipmentModel()
    var selectedFL = FunctionalLocationModel()
    var planningPlant = String()
    var workCenter = String()
    var delegate:FuncLocEquipSelectDelegate?
    var funcEquipViewModel = FuncEquipViewModel()
    
    //MARK:- LifeCycle.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        funcEquipViewModel.vc = self
        self.scanButton.isHidden = true
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        self.searchTextfield.font = UIFont.systemFont(ofSize: 12)
        if self.isSelect == "FunctionalLocation" {
            self.searchTextfield.placeholder = "Search_Functional_location".localized()
        }else if self.isSelect == "Equipement" {
            self.searchTextfield.placeholder = "Search_Equipment".localized()
        }
        ScreenManager.registerTreeViewCell(tableView: self.AssetHierarchyTableView)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"TreeNodeButtonClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssetHierarchyVC.ExpandCollapseNode(notification:)), name:NSNotification.Name(rawValue:"TreeNodeButtonClicked"), object: nil)
        self.listItemTableview.isHidden = true
        self.AssetHierarchyTableView.isHidden = false
        self.funcEquipViewModel.GetAssetHierarchyDetails()
        self.searchTextfield.addTarget(self, action: #selector(FlocEquipHierarchyVC.searchTextFieldMethod), for: UIControl.Event.editingChanged)
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 66.0
        self.listItemTableview.backgroundColor = UIColor.white
        self.searchFilterButton.setTitle("  " + "Id".localized(), for: .normal)
        self.filterBy = "Id"
        self.searchTextfield.clearButtonMode = .whileEditing
        self.lastSyncLabel.isHidden = false
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
        if tableView.tag == 1002{
            return self.funcEquipViewModel.displayArray.count
        }else{
            return self.funcEquipViewModel.FuncEquipArray.count
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if tableView.tag == 1002{
            let node: TreeViewNode = self.funcEquipViewModel.displayArray[indexPath.row]
            let cell  = ScreenManager.getTreeViewCell(tableView: self.AssetHierarchyTableView)
            cell.treeNode = node
            cell.titleLabel.text = "\(node.nodeName ?? "" as String)"
            cell.descriptionLabel.text = "\(node.nodeDesc ?? ""  as String)"
            if (node.isExpanded == true){
                cell.treeButton.setImage(UIImage(named: "DownArrow"), for: .normal)
            }else{
                cell.treeButton.setImage(UIImage(named: "next_arrow"), for: .normal)
            }
            if node.nodeChildren?.count == nil{
                cell.treeButton.isHidden = true
            }else{
                cell.treeButton.isHidden = false
            }
            let type = node.nodeType
            if type == "EQ"{
                cell.typeImg.image = UIImage(named: "components")
            }else if type == "FL"{
                cell.typeImg.image = UIImage(named: "Joblocation")
            }else{
                cell.typeImg.isHidden = true
            }
            cell.setNeedsDisplay()
            mJCLogger.log("Ended", Type: "info")
            return cell
        }else{
            let functionalLocationCell = tableView.dequeueReusableCell(withIdentifier: "FunctionalLocationListCell") as! FunctionalLocationListCell
            if self.funcEquipViewModel.FuncEquipArray.count > 0{
                if let funcClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? FunctionalLocationModel{
                    functionalLocationCell.isCellFrom = "FuncEquipVC"
                    functionalLocationCell.funcLocationClass = funcClass
                    functionalLocationCell.funcEquipViewModel = funcEquipViewModel
                }else if let EquipClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? EquipmentModel{
                    functionalLocationCell.isCellFrom = "FuncEquipVC"
                    functionalLocationCell.equipmentClass = EquipClass
                    functionalLocationCell.funcEquipViewModel = funcEquipViewModel
                }
            }
            mJCLogger.log("Ended", Type: "info")
            return functionalLocationCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        if tableView.tag == 1002{
            mJCLogger.log("Ended", Type: "info")
            return 50
        }else{
            mJCLogger.log("Ended", Type: "info")
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        selectedEQ = EquipmentModel()
        selectedFL = FunctionalLocationModel()
        if tableView.tag == 1002{
            let node: TreeViewNode = self.funcEquipViewModel.displayArray[indexPath.row]
            mJCLogger.log("Response:\(self.funcEquipViewModel.displayArray.count)", Type: "Debug")
            let num = node.nodeName!
            let type = node.nodeType!
            if type == "EQ"{
                if totalEquipmentArray.count == 0{
                    EquipmentModel.getEquipmentDetails(equipNum: num){ (response, error)  in
                        if error == nil{
                            if let equipArr = response["data"] as? [EquipmentModel]{
                                if equipArr.count > 0{
                                    self.selectedEQ = equipArr[0]
                                    FunctionalLocationModel.getFuncLocationDetails(funcLocation: self.selectedEQ.FuncLocation){ (response, error)  in
                                        if error == nil{
                                            if let flocArr = response["data"] as? [FunctionalLocationModel]{
                                                if flocArr.count > 0{
                                                    self.selectedFL = flocArr[0]
                                                }else{
                                                    self.selectedFL = FunctionalLocationModel()
                                                }
                                            }else{
                                                self.selectedFL = FunctionalLocationModel()
                                                mJCLogger.log("floc Data not found", Type: "Debug")
                                            }
                                        }else{
                                            self.selectedFL = FunctionalLocationModel()
                                            mJCLogger.log("floc Data not found", Type: "Debug")
                                        }
                                    }
                                }else{
                                    self.selectedEQ = EquipmentModel()
                                }
                            }else{
                                mJCLogger.log("Equipment Data not found", Type: "Debug")
                            }
                        }else{
                            mJCLogger.log("Equipment Data not found", Type: "Debug")
                        }
                    }
                }else{
                    let arr = totalEquipmentArray.filter{$0.Equipment == num}
                    if arr.count > 0{
                        mJCLogger.log("Response:\(arr.count)", Type: "Debug")
                        selectedEQ = arr[0]
                        if funcLocationArray.count == 0{
                            FunctionalLocationModel.getFuncLocationDetails(funcLocation: self.selectedEQ.FuncLocation){ (response, error)  in
                                if error == nil{
                                    if let flocArr = response["data"] as? [FunctionalLocationModel]{
                                        if flocArr.count > 0{
                                            self.selectedFL = flocArr[0]
                                        }else{
                                            self.selectedFL = FunctionalLocationModel()
                                        }
                                    }else{
                                        self.selectedFL = FunctionalLocationModel()
                                        mJCLogger.log("floc Data not found", Type: "Debug")
                                    }
                                }else{
                                    self.selectedFL = FunctionalLocationModel()
                                    mJCLogger.log("floc Data not found", Type: "Debug")
                                }
                            }
                        }else{
                            let funcArr = funcLocationArray.filter{$0.FunctionalLoc == selectedEQ.FuncLocation}
                            if funcArr.count > 0{
                                mJCLogger.log("Response:\(funcArr[0])", Type: "Debug")
                                selectedFL = funcArr[0]
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        selectedFL = FunctionalLocationModel()
                    }
                }
            }else if type == "FL"{
                if funcLocationArray.count == 0{
                    FunctionalLocationModel.getFuncLocationDetails(funcLocation: num){ (response, error)  in
                        if error == nil{
                            if let flocArr = response["data"] as? [FunctionalLocationModel]{
                                if flocArr.count > 0{
                                    self.selectedFL = flocArr[0]
                                }else{
                                    self.selectedFL = FunctionalLocationModel()
                                }
                            }else{
                                self.selectedFL = FunctionalLocationModel()
                                mJCLogger.log("floc Data not found", Type: "Debug")
                            }
                        }else{
                            self.selectedFL = FunctionalLocationModel()
                            mJCLogger.log("floc Data not found", Type: "Debug")
                        }
                    }
                }else{
                    let funLocArr = funcLocationArray.filter{$0.FunctionalLoc == "\(num)"}
                    if funLocArr.count > 0 {
                        selectedFL = funLocArr[0]
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
        }else{
            if let funcClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? FunctionalLocationModel{
                selectedFL = funcClass
            }else if let EquipClass = self.funcEquipViewModel.FuncEquipArray[indexPath.row] as? EquipmentModel{
                selectedEQ = EquipClass
            }
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
        self.AssetHierarchyTableView.isHidden = false
        self.AssetHierarchyTableView.reloadData()
        textField.text = ""
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    //MARK:- Search TextField Methods..
    @objc   @IBAction func searchEditingChanged(sender: UITextField) {
        mJCLogger.log("Starting", Type: "info")
        if sender.text == "" {
            self.listItemTableview.isHidden = true
            self.AssetHierarchyTableView.isHidden = false
            self.AssetHierarchyTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func searchTextFieldMethod() {
        mJCLogger.log("Starting", Type: "info")
        if self.searchTextfield.text == "" {
            self.listItemTableview.isHidden = true
            self.AssetHierarchyTableView.isHidden = false
            self.AssetHierarchyTableView.reloadData()
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
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.isSelect == "FunctionalLocation" {
            if selectedFL.FunctionalLoc == "" && selectedEQ.Equipment == "" {
                mJCLogger.log("Functional_location_Not_Selected".localized(), Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
            }else {
                if selectedFL.FunctionalLoc != ""{
                    self.delegate?.FuncLocOrEquipSelected(selectedObj: "FunctionalLocation", EquipObj: selectedEQ, FuncObj: selectedFL)
                    self.dismiss(animated: false) {}
                }else if selectedEQ.Equipment != ""{
                    self.delegate?.FuncLocOrEquipSelected(selectedObj: "Equipment", EquipObj: selectedEQ, FuncObj: selectedFL)
                    self.dismiss(animated: false) {}
                }else{
                    mJCLogger.log("Functional_location_Not_Selected".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
                }
            }
        }else if self.isSelect == "Equipement" {
            if selectedEQ.Equipment == "" && selectedFL.FunctionalLoc == ""{
                mJCLogger.log("Equipment_not_selected".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
            }else {
                if selectedEQ.Equipment != ""{
                    self.delegate?.FuncLocOrEquipSelected(selectedObj: "Equipment", EquipObj: selectedEQ, FuncObj: selectedFL)
                    self.dismiss(animated: false) {}
                }else if selectedFL.FunctionalLoc != ""{
                    self.delegate?.FuncLocOrEquipSelected(selectedObj: "FunctionalLocation", EquipObj: selectedEQ, FuncObj: selectedFL)
                    self.dismiss(animated: false) {}
                }else{
                    mJCLogger.log("Equipment_not_selected".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
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
    
    //MARK:  Node/Data Functions
    
    @objc func ExpandCollapseNode(notification: NSNotification){
        mJCLogger.log("Starting", Type: "info")
        if let tree = notification.value(forKey: "object") as? TreeViewNode{
            mJCLoader.startAnimating(status: "Fetching_Data..".localized())
            let defineQuery = "$filter=(HierLevel eq \(tree.nodeLevel! + 1) and ParentId eq '\(tree.nodeName!)') or (HierLevel eq \(tree.nodeLevel! + 2)) &$orderby=HierLevel,ObjectId"
            AssetHierarchyModel.getAssetHierarchyList(filterQuery:defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [AssetHierarchyModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        let data = self.funcEquipViewModel.setChildData(array: responseArr)
                        let nodes = TreeViewLists.LoadInitialNodes(dataList: data, datalevel: tree.nodeLevel! + 1)
                        if tree.isExpanded == true{
                            self.funcEquipViewModel.LoadChildDisplayArray(nodes: nodes, selectedNode: tree)
                        }else{
                            self.funcEquipViewModel.removeChildDisplayArray(nodes: nodes, selectedNode: tree)
                        }
                        DispatchQueue.main.async {
                            mJCLoader.stopAnimating()
                            self.AssetHierarchyTableView.reloadData()
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        if error?.code == 10{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                        }
                    }
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //...END..//
}
