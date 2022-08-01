//
//  PersonResponsibleListVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 2/24/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class PersonResponsibleListVC: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
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
    
    //MARK:-  Declared variables..
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let dropDown = DropDown()
    var isSelect = String()
    var selectedperson = String()
    var selectedObj = PersonResponseModel()
    var delegate: personResponsibleDelegate?
    var personRespListModel = PersonResponsibleListViewModel()
    var isFrom : String = ""
    var techcianlistarray = NSMutableArray()
    var techname = String()
    var techid = String()
    
    //MARK:- LifeCycle.
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        personRespListModel.personResponVC = self
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 66.0
        self.listItemTableview.backgroundColor = UIColor.white
        searchTextfield.placeholder = "Search".localized()
        headerLabel.text = "Person_Responsible".localized()
        self.searchTextfield.addTarget(self, action: #selector(searchTextFieldMethod), for: UIControl.Event.editingChanged)
        personRespListModel.filterBy = "Personnel_No".localized()
        self.searchFilterButton.setTitle("Personnel_No".localized(), for: .normal)
        self.searchTextfield.clearButtonMode = .whileEditing
        self.lastSyncLabel.isHidden = false
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        personRespListModel.getPersonResponsibleList()
        ODSUIHelper.setLayoutToView(view: self.searchTextfieldHolderView, borderColor: UIColor.lightGray, borderWidth: 1.0)
        ODSUIHelper.setLayoutToView(view: self.searchFilterView, borderColor: appColor, borderWidth: 1.0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let text = "  \(item)"
            personRespListModel.filterBy = item
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
    func updateUIGetPersonResponsibleList() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            self.listItemTableview.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func searchTextFieldMethod()  {
        mJCLogger.log("Starting", Type: "info")
        var searchText = self.searchTextfield.text!
        if searchText == "" {
            searchText = ""
        }
        if personRespListModel.filterBy == "Name".localized() {
            personRespListModel.personResponsibleArray.removeAll()
            if searchText == "" {
                personRespListModel.personResponsibleArray = personRespListModel.personResponsibleListArray
            }else {
                let Array = personRespListModel.personResponsibleListArray.filter{$0.EmplApplName.containsIgnoringCase(find: searchText)}
                if Array.count > 0{
                    mJCLogger.log("Response:\(Array.count)", Type: "Debug")
                    personRespListModel.personResponsibleArray.removeAll()
                    personRespListModel.personResponsibleArray = Array
                }else{
                    let Array1 = personRespListModel.personResponsibleListArray.filter{$0.PersonnelNo.contains(find: searchText)}
                    if Array1.count > 0{
                        mJCLogger.log("Response:\(Array1.count)", Type: "Debug")
                        personRespListModel.personResponsibleArray.removeAll()
                        personRespListModel.personResponsibleArray =  Array1
                    }else {
                        personRespListModel.personResponsibleArray.removeAll()
                    }
                }
            }
            self.updateUISearchMethod()
        }else if personRespListModel.filterBy == "Personnel_No".localized() {
            personRespListModel.personResponsibleArray.removeAll()
            if searchText == "" {
                personRespListModel.personResponsibleArray = personRespListModel.personResponsibleListArray
            }else {
                let Array = personRespListModel.personResponsibleListArray.filter{$0.PersonnelNo.contains(find: searchText)}
                if Array.count > 0{
                    mJCLogger.log("Response:\(Array.count)", Type: "Debug")
                    personRespListModel.personResponsibleArray.removeAll()
                    personRespListModel.personResponsibleArray =  Array
                }else{
                    personRespListModel.personResponsibleArray.removeAll()
                }
            }
            self.updateUISearchMethod()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personRespListModel.personResponsibleArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let PersonRespCell = tableView.dequeueReusableCell(withIdentifier: "FunctionalLocationListCell") as! FunctionalLocationListCell
        mJCLogger.log("Response:\(personRespListModel.personResponsibleArray.count)", Type: "Debug")
        PersonRespCell.personRespListModelClass = personRespListModel.personResponsibleArray[indexPath.row]
        mJCLogger.log("Ended", Type: "info")
        return PersonRespCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        let PersonRespclass = personRespListModel.personResponsibleArray[indexPath.row]
        let displayStr = PersonRespclass.SystemID + " - " + PersonRespclass.EmplApplName
        selectedperson = displayStr
        selectedObj = PersonRespclass
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Search Button Action..
    @IBAction func searchTextFieldButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        searchTextFieldMethod()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func searchFilterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.searchFilterView
        let arr : [String] = ["Name".localized(),"Personnel_No".localized()]
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Search TextField Methods..
    @objc @IBAction func searchEditingChanged(sender: UITextField) {
        mJCLogger.log("Starting", Type: "info")
        if sender.text == "" {
            searchTextFieldMethod()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUISearchMethod() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            self.listItemTableview.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        updateUISearchMethod()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func BackButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        delegate?.didSelectPersonRespData(selectedperson,selectedObj,isFrom)
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func searchFilterButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.searchFilterView
        let arr = ["Personnel_No".localized(),"Name".localized()]
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func searchTextFieldButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("searchTextFieldButtonAction".localized(), Type: "")
        self.searchTextFieldMethod()
        mJCLogger.log("Ended", Type: "info")
    }
    //...END..//
}
