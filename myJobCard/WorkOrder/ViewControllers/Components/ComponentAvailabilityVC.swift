//
//  ComponentAvailabilityVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 3/25/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ComponentAvailabilityVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
    
    //MARK:-  Declared variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var attendanceTypeArray = NSMutableArray()
    var attendanceTypeListArray = NSMutableArray()
    let dropDown = DropDown()
    var filterBy = String()
    var isFromEdit = Bool()
    var isfromScreen = String()
    var isSelect = String()
    var selectedAttandenceType = String()
    var selectedTableViewCell = Int()
    var isHistoryScreen = false
    var delegateComp: SelectComponetDelegate?
    var selectedItem = ComponentAvailabilityModel()
    var componentAvailabilityViewModel = ComponentAvailabilityViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        componentAvailabilityViewModel.vcComponentAvailability = self
        self.lastSyncLabel.isHidden = false
        self.searchTextfield.addTarget(self, action: #selector(ComponentAvailabilityVC.searchtextfiledTextChanged), for: UIControl.Event.editingChanged)
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        self.headerLabel.text = "Component_Availability".localized()
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 50.0
        self.listItemTableview.backgroundColor = UIColor.white
        self.searchFilterButton.setTitle("  "+"Id".localized(), for: .normal)
        self.filterBy = "Id"
        self.searchTextfield.clearButtonMode = .whileEditing
        selectedTableViewCell = -1
        ODSUIHelper.setLayoutToView(view: self.searchTextfieldHolderView, borderColor: UIColor.lightGray, borderWidth: 1.0)
        ODSUIHelper.setLayoutToView(view: self.searchFilterView, borderColor: appColor, borderWidth: 1.0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let text = "  \(item)"
            self.filterBy = item
            self.searchFilterButton.setTitle(text, for: .normal)
            self.dropDown.hide()
        }
        if componentAvailabilityViewModel.isFromCheckCompScreen == true{
            footerButtonView.isHidden = true
        }else{
            footerButtonView.isHidden = false
        }
        if isHistoryScreen {
            footerButtonView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        if  componentAvailabilityViewModel.isBomItem == true{
            componentAvailabilityViewModel.getBOMItemList()
        }else if componentAvailabilityViewModel.isWoHistory == true{
            componentAvailabilityViewModel.getComponentHistoryList()
        }else{
            componentAvailabilityViewModel.getAvailableComponentList()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func updateUIGetComponentList() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.componentAvailabilityViewModel.componentArray.count)", Type: "Debug")
            if self.componentAvailabilityViewModel.componentArray.count > 0{
                if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
                    let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
                    self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current)) - " + "Total_Components".localized() + " : \(self.componentAvailabilityViewModel.componentArray.count)"
                }else {
                    let date = "\(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
                    self.lastSyncLabel.text = "Last_sync".localized() + ": \(date) - " + "Total_Components".localized() + " : \(self.componentAvailabilityViewModel.componentArray.count)"
                }
            }else{
                mJCLogger.log("Components_Not_Found".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Components_Not_Found".localized(), button: okay)
            }
            self.listItemTableview.reloadData()
            mJCLoader.stopAnimating()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetBOMList() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.componentAvailabilityViewModel.componentArray.count)", Type: "Debug")
            if self.componentAvailabilityViewModel.componentArray.count > 0{
                if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
                    let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
                    self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current)) - " + "Total_Components".localized() + " : \(self.componentAvailabilityViewModel.componentArray.count)"
                }else {
                    let date = Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current)
                    self.lastSyncLabel.text = "Last_sync".localized() + ": \(date) - " + "Total_Components".localized() + " : \(self.componentAvailabilityViewModel.componentArray.count)"
                }
            }else{
                mJCLogger.log("Components_Not_Found".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Components_Not_Found".localized(), button: okay)
            }
            self.listItemTableview.reloadData()
            mJCLoader.stopAnimating()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return componentAvailabilityViewModel.componentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let functionalLocationCell = tableView.dequeueReusableCell(withIdentifier: "FunctionalLocationListCell") as! FunctionalLocationListCell
        functionalLocationCell.indexpath = indexPath
        functionalLocationCell.componentAvailabilityViewModel = componentAvailabilityViewModel
        functionalLocationCell.componentAvailabilityModelClass = componentAvailabilityViewModel.componentArray[indexPath.row]
        mJCLogger.log("Ended", Type: "info")
        return functionalLocationCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        selectedTableViewCell = indexPath.row
        let componentClass = componentAvailabilityViewModel.componentArray[indexPath.row]
        self.selectedItem = componentClass
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- search text field Methods..
    @IBAction func searchEditingChanged(sender: UITextField) {}
    //MARK:- search text field Methods..
    @objc func searchtextfiledTextChanged(){
        mJCLogger.log("Starting", Type: "info")
        if self.searchTextfield.text != "" {
            componentAvailabilityViewModel.componentArray.removeAll()
            var searchPredicate = NSPredicate()
            if self.filterBy == "Id" {
                if componentAvailabilityViewModel.isBomItem == true{
                    searchPredicate = NSPredicate(format: "SELF.Component contains[cd] %@", self.searchTextfield.text!)
                }else{
                    searchPredicate = NSPredicate(format: "SELF.Material contains[cd] %@", self.searchTextfield.text!)
                }
            }else if self.filterBy == "Description" {
                searchPredicate = NSPredicate(format: "SELF.MaterialDescription contains[cd] %@", self.searchTextfield.text!)
            }else if self.filterBy == "Tech ID" {
                searchPredicate = NSPredicate(format: "SELF.TechIdentNo contains[cd] %@", self.searchTextfield.text!)
            }else if self.filterBy == "Plant" {
                searchPredicate = NSPredicate(format: "SELF.Plant contains[cd] %@", self.searchTextfield.text!)
            }
            let filterComponentArray = (componentAvailabilityViewModel.componentListArray as NSArray).filtered(using: searchPredicate) as! [ComponentAvailabilityModel]
            componentAvailabilityViewModel.componentArray =  filterComponentArray
            self.listItemTableview.reloadData()
        }else {
            componentAvailabilityViewModel.componentArray =  componentAvailabilityViewModel.componentListArray
            self.listItemTableview.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Search Button Action..
    @IBAction func searchTextFieldButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.searchtextfiledTextChanged()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Search Filter Button Action..
    @IBAction func searchFilterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.searchFilterView
        if componentAvailabilityViewModel.isBomItem == true{
            let arr : [String] = ["Id".localized(), "Description".localized()]
            dropDown.dataSource = arr
            dropDown.show()
        }else{
            let arr : [String] = ["Id".localized(), "Description".localized(), "Plant".localized()]
            dropDown.dataSource = arr
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectedTableViewCell = -1
        self.listItemTableview.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false) {}
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if !isHistoryScreen {
            if selectedTableViewCell == -1 {
                mJCLogger.log("You_haven't_selected_any_item".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "You_haven't_selected_any_item".localized(), button: okay)
            }else {
                self.dismiss(animated: false) {
                    self.delegateComp?.setSeleceditem(selectedItem: self.selectedItem)
                }
            }
        }else {
            self.dismiss(animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
}
