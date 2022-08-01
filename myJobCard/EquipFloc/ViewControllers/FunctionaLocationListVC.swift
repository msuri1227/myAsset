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

class FunctionaLocationListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,viewModelDelegate {
    
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
    
    //MARK:-  Declared variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let dropDown = DropDown()
    var isSelect = String()
    var selectedEqpment = String()
    var selectedFunLoc = String()
    var isfrom = String()
    var selectedPlant = String()
    var selectedWorkcenter = String()
    var selectedCategory = String()
    var selectedFunctionalLocation = String()
    var delegate:FuncOrEquipmentSelectedDelegate?
    var selectedEquipObj = EquipmentModel()
    var flocEquipOverViewModel = FlocEquipOverViewModel()
    
    var functionLocationArray = [FunctionalLocationModel]()
    var functionLocationListArray = [FunctionalLocationModel]()
    var equipmentArray = [EquipmentModel]()
    var equipmentListArray = [EquipmentModel]()
    var filterBy = String()
    //MARK:- LifeCycle.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        flocEquipOverViewModel.delegate = self
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 66.0
        self.searchTextfield.addTarget(self, action: #selector(FunctionaLocationListVC.searchTextFieldMethod), for: UIControl.Event.editingChanged)
        self.searchFilterButton.setTitle("  " + "Id".localized(), for: .normal)
        self.filterBy = "Id"
        self.searchTextfield.clearButtonMode = .whileEditing
        self.lastSyncLabel.isHidden = false
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        if isSelect == "FunctionalLocation" {
            flocEquipOverViewModel.selectedPlant = selectedPlant
            flocEquipOverViewModel.selectedWorkcenter = selectedWorkcenter
            flocEquipOverViewModel.selectedCategory = selectedCategory
            flocEquipOverViewModel.selectedFunctionalLocation = ""
            flocEquipOverViewModel.getFunctionalLocationList(from: "installEquipment")
            self.headerLabel.text = "Functional_Location".localized()
            self.techIdHeaderLabel.text = ""
        }else if isSelect == "Equipement" {
            self.headerLabel.text = "Equipment".localized()
            flocEquipOverViewModel.selectedPlant = selectedPlant
            flocEquipOverViewModel.selectedWorkcenter = selectedWorkcenter
            flocEquipOverViewModel.selectedCategory = selectedCategory
            flocEquipOverViewModel.selectedFunctionalLocation = selectedFunctionalLocation
            flocEquipOverViewModel.getEquipementList(from: "installEquipment")
            self.techIdHeaderLabel.text = "Tech_ID".localized()
        }
        ODSUIHelper.setLayoutToView(view: self.searchTextfieldHolderView, borderColor: UIColor.lightGray, borderWidth: 1.0)
        ODSUIHelper.setLayoutToView(view: self.searchFilterView, borderColor: appColor, borderWidth: 1.0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let text = "  \(item)"
            self.filterBy = item
            self.searchFilterButton.setTitle(text, for: .normal)
            self.dropDown.hide()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "installedFloc"{
            if let objArr = object as? [FunctionalLocationModel]{
                self.functionLocationArray = objArr
                self.functionLocationListArray = objArr
            }else{
                self.functionLocationArray = []
                self.functionLocationListArray = []
            }
            DispatchQueue.main.async {
                self.listItemTableview.reloadData()
            }
        }else if type == "installedEquip"{
            if let objArr = object as? [EquipmentModel]{
                self.equipmentArray = objArr
                self.equipmentListArray = objArr
            }else{
                self.equipmentArray = []
                self.equipmentListArray = []
            }
            DispatchQueue.main.async {
                self.listItemTableview.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetEquipemtList() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.listItemTableview.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelect == "FunctionalLocation" {
            return self.functionLocationArray.count
        }else if isSelect == "Equipement" {
            return self.equipmentArray.count
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let functionalLocationCell = tableView.dequeueReusableCell(withIdentifier: "FunctionalLocationListCell") as! FunctionalLocationListCell
        if isSelect == "FunctionalLocation" {
            functionalLocationCell.funcLocModelClass = self.functionLocationArray[indexPath.row]
        }else if isSelect == "Equipement" {
            functionalLocationCell.EquipmentModel = self.equipmentArray[indexPath.row]
        }
        mJCLogger.log("Ended", Type: "info")
        return functionalLocationCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if isSelect == "FunctionalLocation" {
            let functionalLocationclass = self.functionLocationArray[indexPath.row]
            selectedFunLoc = functionalLocationclass.FunctionalLoc
        }else if isSelect == "Equipement" {
            let equipmentClass = self.equipmentArray[indexPath.row]
            selectedEqpment = equipmentClass.Equipment
            selectedFunLoc = equipmentClass.FuncLocation
            selectedEquipObj = equipmentClass
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Search Button Action..
    @IBAction func searchTextFieldButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("searchTextFieldButtonAction".localized(), Type: "")
        self.searchTextFieldMethod()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func searchFilterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.searchFilterView
        var arr = [String]()
        if isSelect == "FunctionalLocation" {
            arr = ["Id".localized(),"Description".localized()]
        }else if isSelect == "Equipement" {
            arr = ["Id".localized(),"Description".localized(),"Tech_ID".localized()]
        }
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Search TextField Methods..
    @objc @IBAction func searchEditingChanged(sender: UITextField) {
        mJCLogger.log("Starting", Type: "info")
        if sender.text == "" {
            self.searchTextFieldMethod()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func searchTextFieldMethod()  {
        mJCLogger.log("Starting", Type: "info")
        if let searchText = searchTextfield.text{
            if self.filterBy == "Id".localized() {
                if isSelect == "FunctionalLocation" {
                    self.functionLocationArray.removeAll()
                    if searchText == "" {
                        self.functionLocationArray = self.functionLocationListArray
                    }else {
                        let flocArry = functionLocationListArray.filter{$0.FunctionalLoc.containsIgnoringCase(find: searchText)}
                        if flocArry.count > 0{
                            self.functionLocationArray = flocArry
                        }else{
                            self.functionLocationArray.removeAll()
                            self.functionLocationArray = functionLocationListArray
                        }
                    }
                }else if isSelect == "Equipement" {
                    self.equipmentArray.removeAll()
                    if searchText == ""{
                        self.equipmentArray = equipmentListArray
                    }else {
                        let equipArr = self.equipmentListArray.filter{$0.Equipment.containsIgnoringCase(find: searchText)}
                        if equipArr.count > 0{
                            self.equipmentArray.removeAll()
                            self.equipmentArray = equipArr
                        }else{
                            self.equipmentArray.removeAll()
                            self.equipmentArray = equipmentListArray
                        }
                    }
                }
                self.listItemTableview.reloadData()
            }else if self.filterBy == "Description".localized() {
                if isSelect == "FunctionalLocation" {
                    self.functionLocationArray.removeAll()
                    if searchText == "" {
                        self.functionLocationArray = self.functionLocationListArray
                    }else {
                        let flocArry = functionLocationListArray.filter{$0.Description.containsIgnoringCase(find: searchText)}
                        if flocArry.count > 0{
                            self.functionLocationArray = flocArry
                        }else{
                            self.functionLocationArray.removeAll()
                            self.functionLocationArray = functionLocationListArray
                        }
                    }
                }else if isSelect == "Equipement" {
                    self.equipmentArray.removeAll()
                    if searchText == ""{
                        self.equipmentArray = equipmentListArray
                    }else {
                        let equipArr = self.equipmentListArray.filter{$0.EquipDescription.containsIgnoringCase(find: searchText)}
                        if equipArr.count > 0{
                            self.equipmentArray.removeAll()
                            self.equipmentArray = equipArr
                        }else{
                            self.equipmentArray.removeAll()
                            self.equipmentArray = equipmentListArray
                        }
                    }
                }
                self.listItemTableview.reloadData()
            }else if self.filterBy == "Tech_ID".localized() {
                if isSelect == "Equipement" {
                    self.equipmentArray.removeAll()
                    if searchText == "" {
                        self.equipmentArray = equipmentListArray
                    }else {
                        let equipArr = self.equipmentListArray.filter{$0.TechIdentNo.containsIgnoringCase(find: searchText)}
                        if equipArr.count > 0{
                            self.equipmentArray.removeAll()
                            self.equipmentArray = equipArr
                        }else{
                            self.equipmentArray.removeAll()
                            self.equipmentArray = equipmentListArray
                        }
                    }
                }
                self.listItemTableview.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        tempSelectedFunctionalLocation = ""
        tempSelectedEquipment = ""
        selectedFunLoc = ""
        selectedEqpment = ""
        self.listItemTableview.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func BackButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isSelect == "FunctionalLocation" {
            if selectedFunLoc == "" {
                mJCLogger.log("Functional_location_Not_Selected".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Functional_location_Not_Selected".localized(), button: okay)
            }else {
                tempSelectedFunctionalLocation = selectedFunLoc
                self.delegate?.FuctionOrEquipment(funcSelectd: true, equipSelected: false,equipmentObjSelected: selectedEquipObj)
                self.dismiss(animated: false) {}
            }
        }else if isSelect == "Equipement" {
            if selectedEqpment == "" {
                mJCLogger.log("Equipment_not_selected".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Equipment_not_selected".localized(), button: okay)
            }
            else {
                tempSelectedEquipment = selectedEqpment
                tempSelectedFunctionalLocation = selectedFunLoc
                self.delegate?.FuctionOrEquipment(funcSelectd: false, equipSelected: true,equipmentObjSelected: selectedEquipObj)
                self.dismiss(animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        tempSelectedFunctionalLocation = ""
        tempSelectedEquipment = ""
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //...END..//
}
