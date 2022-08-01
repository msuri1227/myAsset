//
//  AttendanceTypeListVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 3/22/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class AttendanceTypeListVC: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
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
    var selectedAttandenceType = String()
    var delegate:attendanceTypeDelegate?
    var attendanceTypeModel = AttendanceTypeListViewModel()
    
    //MARK:- LifeCycle..
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        self.searchTextfield.addTarget(self, action: #selector(AttendanceTypeListVC.searchtextfiledTextChanged), for: UIControl.Event.editingChanged)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        attendanceTypeModel.vcAttendanceTypeList = self
        self.listItemTableview.separatorStyle = .none
        self.listItemTableview.estimatedRowHeight = 66.0
        self.listItemTableview.backgroundColor = UIColor.white
        self.searchFilterButton.setTitle("  " + "Id".localized(), for: .normal)
        self.attendanceTypeModel.filterBy = "Id"
        self.lastSyncLabel.isHidden = false
        if (UserDefaults.standard.value(forKey:"lastSyncDate_Master") != nil) {
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate_Master") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        ODSUIHelper.setLayoutToView(view: self.searchTextfieldHolderView, borderColor: UIColor.lightGray, borderWidth: 1.0)
        ODSUIHelper.setLayoutToView(view: self.searchFilterView, borderColor: appColor, borderWidth: 1.0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let text = "  \(item)"
            attendanceTypeModel.filterBy = item
            self.searchFilterButton.setTitle(text, for: .normal)
            self.dropDown.hide()
        }
        attendanceTypeModel.setAttendanceType()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceTypeModel.attendanceTypeArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let functionalLocationCell = tableView.dequeueReusableCell(withIdentifier: "FunctionalLocationListCell") as! FunctionalLocationListCell
        functionalLocationCell.attendanceTypeModelClass = attendanceTypeModel.attendanceTypeArray[indexPath.row]
        mJCLogger.log("Response:\(attendanceTypeModel.attendanceTypeArray.count)", Type: "Debug")
        mJCLogger.log("Ended", Type: "info")
        return functionalLocationCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        let attendanceTyeListClass = attendanceTypeModel.attendanceTypeArray[indexPath.row]
        selectedAttandenceType = "\(attendanceTyeListClass.AttAbsType) - \(attendanceTyeListClass.AATypeText)"
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
        let arr : [String] = ["Id".localized(),"Description".localized()]
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.listItemTableview.reloadData()
        if attendanceTypeModel.attendanceTypeArray.count > 0{
            let attendanceTyeListClass = attendanceTypeModel.attendanceTypeArray[0]
            selectedAttandenceType = "\(attendanceTyeListClass.AttAbsType) - \(attendanceTyeListClass.AATypeText)"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func BackButtonAction(_ sender: Any) {
        self.dismiss(animated: false) {}
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if selectedAttandenceType == "" {
            mJCLogger.log("You_haven't_selected_any_item".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_haven't_selected_any_item".localized(), button: okay)
        }else {
            self.delegate?.attendanceTypeSelected(value: selectedAttandenceType)
            self.dismiss(animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- search text field Methods..
    @objc func searchtextfiledTextChanged() {
        mJCLogger.log("Starting", Type: "info")
        attendanceTypeModel.searchMethod()
        mJCLogger.log("Ended", Type: "info")
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        print("editing changed12")
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField)  {
        
        print("editing changed")
    }
    @IBAction func searchEditingChanged(sender: AnyObject) {
        
    }
}
