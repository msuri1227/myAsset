//
//  CapacityAssignmentVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CapacityAssignmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,personResponsibleDelegate, CustomNavigationBarDelegate, UITextFieldDelegate {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var capacityMemberDataTableview: UITableView!
    @IBOutlet weak var totalTechniciansCountLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var addCapacityButton: UIButton!
    @IBOutlet weak var addMemberBgView: UIView!
    @IBOutlet weak var addMemberView: UIView!
    @IBOutlet weak var personResponsibleTestFieldView: UIView!
    @IBOutlet weak var personResponsibleTextField: UITextField!
    @IBOutlet weak var personResponsibleButton: UIButton!
    @IBOutlet weak var normalDurationTextFieldView: UIView!
    @IBOutlet weak var normalDurationTextField: UITextField!
    @IBOutlet weak var startDateAndTimeView: UIView!
    @IBOutlet weak var startDateTextFieldView: UIView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var startTimeTextFieldView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    //MARK:- Declared Variables.

    var selectedPersonalRespName = String()
    var addMemberArray = [[String : String]]()
    var dict = [String : String]()
    var selectedDateAndTimeStr = NSString()
    var tagValue = Int()
    
    var capacityViewModel = CapacityMembersDataViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        capacityViewModel.capacityVC = self
        self.normalDurationTextField.delegate = self
        ODSUIHelper.setButtonLayout(button: self.addCapacityButton, cornerRadius: self.addCapacityButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.personResponsibleTestFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.normalDurationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.startDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.startTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.headerLabel.text = "Capacity_Data".localized()
        self.totalTechniciansCountLabel.text = "Total_Technicians_Assigned".localized() +  " : " + "\(addMemberArray.count)"
        self.addMemberBgView.isHidden = true
        self.capacityMemberDataTableview.delegate = self
        self.capacityMemberDataTableview.dataSource = self
        self.capacityMemberDataTableview.estimatedRowHeight = 100.0
        self.capacityMemberDataTableview.separatorStyle = .none
        ScreenManager.registerCapacityTableViewCell(tableView: self.capacityMemberDataTableview)
        capacityViewModel.getCapacityMembersData()
        if !applicationFeatureArrayKeys.contains("ADD_CAPACITY_DATA"){
            self.addCapacityButton.isHidden = true
        }else{
            self.addCapacityButton.isHidden = false
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    @objc func updateUICapacityMembersData() {
        DispatchQueue.main.async {
            if self.capacityViewModel.capacityMembersListArray.count > 0 {
                self.noDataLabel.isHidden = true
                self.noDataLabel.text = ""
                self.capacityMemberDataTableview.reloadData()
            }else{
                self.noDataLabel.isHidden = false
                self.noDataLabel.text = "No_Data_Available".localized()
            }
        }
    }
    @IBAction func addCapacityButtonAction(_ sender: UIButton) {
        self.personResponsibleTextField.text = ""
        self.normalDurationTextField.text = ""
        self.startDateTextField.text = ""
        self.startTimeTextField.text = ""
        if singleOperation.NumberPerson <= capacityViewModel.capacityMembersListArray.count {
            self.addMemberBgView.isHidden = true
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_have_already_added_the_maximum_Technicians_possible".localized(), button: okay)
            return
        }else{
            self.addMemberBgView.isHidden = false
            self.normalDurationTextField.keyboardType = .phonePad
        }

    }
    @IBAction func personResponsibleButtonAction(_ sender: UIButton) {
        mJCLogger.log("Person Responsible Scan Button Tapped".localized(), Type: "")
        menuDataModel.uniqueInstance.presentPersonResponsibleListScreen(vc: self, isFrm: "Capacity", delegateVC: self)
    }
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        mJCLogger.log("Starting", Type: "info")
        let PersonRespclass = objcet as! PersonResponseModel
        self.personResponsibleTextField.text = "\(PersonRespclass.EmplApplName)"
        selectedPersonalRespName = PersonRespclass.PersonnelNo
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        self.personResponsibleTextField.text = ""
        self.normalDurationTextField.text = ""
    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.addMemberBgView.isHidden = true
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        if self.personResponsibleTextField.text == "" {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Person_Responsible".localized(), button: okay)
            mJCLogger.log("Please_Select_Person_Responsible".localized(), Type: "Warn")
            return
        
        }else if self.normalDurationTextField.text == "" {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Enter_Normal_Duration".localized(), button: okay)
            mJCLogger.log("Please_Select_Person_Responsible".localized(), Type: "Warn")
            return
        }else if self.startDateTextField.text == "" {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Start_Date".localized(), button: okay)
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Warn")
            return
        }else if self.startTimeTextField.text == "" {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Start_time".localized(), button: okay)
            mJCLogger.log("Please_Select_Start_time".localized(), Type: "Warn")
            return
        }
        self.capacityViewModel.addNewCapacityMemberData()
    }
    
    
   
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == self.normalDurationTextField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
                
    
    //MARK:- UITableView Delegate & DataSource..
                 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return capacityViewModel.capacityMembersListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let capacityCell = ScreenManager.getCapacityTableViewCell(tableView: tableView)
        capacityCell.indexPath = indexPath
        capacityCell.capacityClass = capacityViewModel.capacityMembersListArray[indexPath.row]
        capacityCell.capacityModel = capacityViewModel
        mJCLogger.log("Ended", Type: "info")
        return capacityCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType == iPad{
            return 125
        }else{
            return 180
        }

    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func startDateButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectedDateAndTimeStr = "StartDate"
        ODSPicker.selectDate(title: "Select_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            self?.startDateTextField.text = selectedDate.dateString(localDateFormate)
        })
        mJCLogger.log("Start Date Button Tapped".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func startTimeButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectedDateAndTimeStr = "StartTime"
        ODSPicker.selectDate(title: "Select_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
            self?.startTimeTextField.text = selectedDate.dateString(localTimeFormat)
        })
        
        mJCLogger.log("Start Time Button Tapped".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func cellStartDateButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectedDateAndTimeStr = "CapacityCellStartDate"
        tagValue = sender.tag
        
        ODSPicker.selectDate(title: "Select_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = self!.capacityMemberDataTableview.cellForRow(at: indexPath) as! CapacityTableViewCell
            cell.startDateTextField.text = selectedDate.dateString(localDateFormate)
        })
        
        mJCLogger.log("Start Date Button Tapped".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func cellStartTimeButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectedDateAndTimeStr = "CapacityCellStartTime"
        tagValue = sender.tag
        ODSPicker.selectDate(title: "Select_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = self!.capacityMemberDataTableview.cellForRow(at: indexPath) as! CapacityTableViewCell
            cell.startTimeTextField.text = selectedDate.dateString(localDateFormate)
        })
        mJCLogger.log("Start Time Button Tapped".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
}
