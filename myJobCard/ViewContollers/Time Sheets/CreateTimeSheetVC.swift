//
//  CreateTimeSheetVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/12/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CreateTimeSheetVC: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,personResponsibleDelegate,attendanceTypeDelegate,UITableViewDelegate,UITableViewDataSource{
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var addTimeEntryHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    //DateView Outlets..
    @IBOutlet var dateView: UIView!
    @IBOutlet var dateTitleLabel: UILabel!
    @IBOutlet var dateViewTextField: UITextField!
    @IBOutlet var selectDateButton: UIButton!
    @IBOutlet var dateViewTextFieldView: UIView!
    //WorkOrderView Outlets..
    @IBOutlet var workOrderView: UIView!
    @IBOutlet var workOrderTitleLabel: UILabel!
    @IBOutlet var workOrdrTextField: iOSDropDown!
    @IBOutlet var workOrderButton: UIButton!
    @IBOutlet var workOrderButtonView: UIView!
    @IBOutlet var workOrderTextField: UITextField!
    @IBOutlet var workOrderTextFieldView: UIView!
    //Premium Outlets..
    @IBOutlet var PremiumView: UIView!
    @IBOutlet var PremiumTitleLabel: UILabel!
    @IBOutlet var premiumTextField: iOSDropDown!
    @IBOutlet var PremiumButton: UIButton!
    @IBOutlet var PremiumTextFieldView: UIView!
    //AttenenceTypeView Outlets..
    @IBOutlet var attenenceTypeView: UIView!
    @IBOutlet var attenenceTypeTitleLabel: UILabel!
    @IBOutlet var attenenceTypeTextField: UITextField!
    @IBOutlet var attenenceTypeTextFieldView: UIView!
    @IBOutlet var attenenceTypeButton: UIButton!
    //OperationView Outlets..
    @IBOutlet var operationView: UIView!
    @IBOutlet var operationTitleLabel: UILabel!
    @IBOutlet var operationTextField: iOSDropDown!
    @IBOutlet var operationTextFieldView: UIView!
    @IBOutlet weak var selectOperationButton: UIButton!
    @IBOutlet var operationViewHieghtConstant: NSLayoutConstraint!
    //ActivityTypeView Outlets..
    @IBOutlet var activityTypeView: UIView!
    @IBOutlet var activityTypeTitleLabel: UILabel!
    @IBOutlet var activityTypeTextField: iOSDropDown!
    @IBOutlet var activityTypeTextFieldView: UIView!
    @IBOutlet weak var selectActivityTypeButton: UIButton!
    //WorkcenterView Outlets..
    @IBOutlet var workCenterView: UIView!
    @IBOutlet var workCenterTitleLabel: UILabel!
    @IBOutlet var workCenterTextField: iOSDropDown!
    @IBOutlet var workCenterTextFieldView: UIView!
    @IBOutlet weak var selectWorkcenterButton: UIButton!
    //PersonResponsible Outlets..
    @IBOutlet var personResponsibleView: UIView!
    @IBOutlet var personResponsibleTitleLabel: UILabel!
    @IBOutlet var personResponsibleTextFieldView: UIView!
    @IBOutlet var personResponsibleTextField: UITextField!
    @IBOutlet var personResponsibleButton: UIButton!
    //ButtonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    //Start Time Outlets..
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startTimeTextFieldView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startTimeButton: UIButton!
    //End Time Outlets..
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endTimeTextFieldView: UIView!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet var postConfirmationButton: UIButton!
    @IBOutlet weak var resourceTimesheetView: UIView!
    @IBOutlet weak var resourceTimesheetTableView: UITableView!
    @IBOutlet weak var addResourceButton: UIButton!
    @IBOutlet weak var resourceresourceCompleteButton: UIButton!
    @IBOutlet var headerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var headerLabel: UILabel!
    
    
    //MARK:- Declared Variables..
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var workOrderArray = [WoHeaderModel]()
    var workOrderListArray = [String]()
    var operationArray = [WoOperationModel]()
    var operationListArray = [String]()
    var activityArray = [WorkOrderActivityModel]()
    var activityListArray = [String]()
    var attendanceTypeArray = [AttendanceTypeModel]()
    var attendanceTypeListArray = [AttendanceTypeModel]()
    var workCentersArray = [WorkCenterModel]()
    var workCentersListArray = [String]()
    var premiumIDArray = Array<PremiumIdModel>()
    var hoursArray = NSMutableArray()
    var minutsArray = NSMutableArray()
    let dropDown = DropDown()
    var dropDownString = String()
    var isFromError = Bool()
    var screenType = String()
    var timeSheetClass = TimeSheetModel()
    var timeSheetArray = [TimeSheetModel]()
    var newTimeSheetEntity : SODataEntity?
    var property = NSMutableArray()
    var resourceTimesheetArray = NSMutableArray()
    var totalMinutes = Float()
    var selectTimeString = ""
    var cellIndex = Int()
    var selectedHours = String()
    var selectedMinutes = String()
    var selectedDate = NSDate()
    var selectedworkOrder = String()
    var selectedPersonalNumber = String()
    var statusCategoryCls = StatusCategoryModel()
    var timeSheetDelegate : timeSheetDelegate?
    var timeEntryViewModel = TimeEntryViewModel()
    var suspendViewModel = SuspendViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")
        self.timeEntryViewModel.addTimeEntryVC = self
        self.timeEntryViewModel.getWorkOrderList()
        self.timeEntryViewModel.setViewLayouts()
        self.timeEntryViewModel.getActivityList()
        self.timeEntryViewModel.getAttandenceTypeList()
        self.timeEntryViewModel.getPremiumvalues()
        self.timeEntryViewModel.getWorkCentersList()
        personResponsibleTextField.isUserInteractionEnabled = true
        self.workOrderTextField.delegate = self
        if screenType == "AddTimeSheet"{
            dateViewTextField.text = ODSDateHelper.convertDateToString(date: selectedDate as Date)
            self.addTimeEntryHeaderLabel.text = "Add_Time_Entry".localized()
            self.timeEntryViewModel.getTimeSheetData(date: selectedDate as Date)
        }else if self.screenType == "EditTimeSheet"{
            self.timeEntryViewModel.getTimeSheetData(date: selectedDate as Date)
            selectedworkOrder = timeSheetClass.RecOrder
            self.addTimeEntryHeaderLabel.text = "Edit_Time_Entry".localized()
            self.setEditData()
        }else if self.screenType == "StatusChange" {
            self.resourceTimesheetTableView.delegate = self
            self.resourceTimesheetTableView.dataSource = self
            self.workOrderTextField.text = selectedworkOrder
            if self.suspendViewModel.suspendVc?.isFromScreen == "Complete" {
                self.postConfirmationButton.isUserInteractionEnabled = false
                self.postConfirmationButton.isSelected = true
            }
            ScreenManager.registerTeamTimesheetCell(tableView: self.resourceTimesheetTableView)
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if self.dropDownString == "Work_order_Number".localized() {
                self.workOrderButton.setTitle(item, for: .normal)
                if item == "--none--".localized() {
                    self.selectOperationButton.isHidden = true
                    self.workOrderTextField.isUserInteractionEnabled = true
                    self.operationTextField.text = ""
                }else {
                    self.workOrderTextField.isUserInteractionEnabled = false
                    self.workOrderTextField.text = ""
//                    self.selectOperationButton.isHidden = false
                    let itemAttay = item.components(separatedBy: " - ")
                    if itemAttay.count > 0{
                        self.selectedworkOrder = itemAttay[0]
                    }
                    self.timeEntryViewModel.getOpertionList()
                }
            }else if self.dropDownString == "Operation_Number".localized() {
                self.operationTextField.text = item
            }else if self.dropDownString == "Activity_Number".localized(){
                self.activityTypeTextField.text = item
            }else if self.dropDownString == "Work_Center_Number".localized(){
                self.workCenterTextField.text = item
            }else if self.dropDownString == "Premium"{
                self.premiumTextField.text = item
            }else if self.dropDownString == "Hours"{
                self.timeEntryViewModel.totalHours = Int(item) ?? 0
                self.startTimeTextField.text = "\(self.timeEntryViewModel.totalHours)"
            }else if self.dropDownString == "Minutes"{
                self.timeEntryViewModel.totalMins = Int(item) ?? 00
                self.endTimeTextField.text = "\(self.timeEntryViewModel.totalMins)"
            }
            self.dropDownString = ""
            self.dropDown.hide()
        }
        //Activity
        self.activityTypeTextField.didSelect { selectedText, index, id in
            self.activityTypeTextField.text = selectedText
        }
        
        //Work center
        self.workCenterTextField.didSelect { selectedText, index, id in
            self.workCenterTextField.text = selectedText
        }
        
        //Premium
        self.premiumTextField.didSelect { selectedText, index, id in
            self.premiumTextField.text = selectedText
        }
        
        //Operation
        self.operationTextField.didSelect { selectedText, index, id in
            self.operationTextField.text = selectedText
        }
        
        //Work order
        self.workOrdrTextField.didSelect { selectedText, index, id in
            self.workOrdrTextField.text = selectedText
            if selectedText == "--none--".localized() {
                self.workOrderTextField.isUserInteractionEnabled = true
                self.operationTextField.text = ""
            }else {
                self.workOrderTextField.isUserInteractionEnabled = false
                self.workOrderTextField.text = ""
                let itemAttay = selectedText.components(separatedBy: " - ")
                if itemAttay.count > 0{
                    self.selectedworkOrder = itemAttay[0]
                }
                self.timeEntryViewModel.getOpertionList()
            }
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func attendanceTypeSelected(value: String) {
        mJCLogger.log("Starting", Type: "info")
        self.attenenceTypeTextField.text = value
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func addResourceButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.resourceTimesheetView.isHidden = true
        self.startTimeTextField.text = ""
        self.endTimeTextField.text = ""
        self.personResponsibleTextField.text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func timeSheetCompleteAction(_ sender: Any) {
        self.timeEntryViewModel.complete()
    }
    //MARK:- UITapGesture Recognizer..
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        mJCLogger.log("Starting", Type: "info")
        if textField == self.workOrderTextField {
            if textField.text!.count >= 7 {
                self.workOrderTextField.isUserInteractionEnabled = true
                self.selectOperationButton.isHidden = false
                self.selectedworkOrder = "\(textField.text!)\(string)"
                self.timeEntryViewModel.getOpertionList()
            }else{
                self.operationTextField.text = ""
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    //MARK:- Back Button Action..
    @IBAction func backbuttonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.dateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.workOrderTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.operationTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.attenenceTypeTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.activityTypeTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.workCenterTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.startTimeLabel)
        myAssetDataManager.setMandatoryLabel(label: self.endTimeLabel)

    }
    //MARK:- footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        timeEntryViewModel.validateScreenValues()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.screenType == "StatusChange"{
            self.suspendViewModel.suspendVc?.dismissViewController()
        }else{
            self.dismiss(animated: false, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.workCenterTextField.text = "--none--".localized()
        self.workOrderTextField.text = ""
        self.premiumTextField.text = selectStr
        self.premiumTextField.text = ""
        self.startTimeTextField.text = ""
        self.endTimeTextField.text = ""
        self.personResponsibleTextField.text = selectStr
        postConfirmationButton.isSelected = false
        self.timeEntryViewModel.getActivityList()
        self.timeEntryViewModel.getAttandenceTypeList()
        self.timeEntryViewModel.getPremiumvalues()
        self.timeEntryViewModel.getWorkCentersList()
        if screenType == "AddTimeSheet" {
            dateViewTextField.text = ODSDateHelper.convertDateToString(date: Date())
        }else if self.screenType == "EditTimeSheet"{
            self.timeEntryViewModel.getTimeSheetData(date: selectedDate as Date)
            selectedworkOrder = timeSheetClass.RecOrder
            self.setEditData()
        }else if self.screenType == "StatusChange" {
            self.workOrderTextField.text = selectedworkOrder
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func attenenceTypeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let attendanceTypeListVC = ScreenManager.getAttendanceTypeListScreen()
        attendanceTypeListVC.delegate = self
        attendanceTypeListVC.attendanceTypeModel.attendanceTypeArray = attendanceTypeArray
        attendanceTypeListVC.attendanceTypeModel.attendanceTypeListArray = attendanceTypeListArray
        attendanceTypeListVC.modalPresentationStyle = .fullScreen
        self.present(attendanceTypeListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func postConfirmationButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        sender.isSelected = !sender.isSelected
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func selectDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("selectDateButtonAction".localized(), Type: "")
        self.allTextFieldResign()
        
        ODSPicker.selectDate(title: "Select_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, maxDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            self!.dateViewTextField.text = selectedDate.dateString(localDateFormate)
        })
        
        UserDefaults.standard.set(false, forKey: "showclock")
    }
    @IBAction func personResponsibleButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Person Responsible Scan Button Tapped".localized(), Type: "")
        let personRespVC = ScreenManager.getPersonResponsibleListScreen()
        personRespVC.modalPresentationStyle = .fullScreen
        personRespVC.delegate = self
        self.present(personRespVC, animated: false) {
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        mJCLogger.log("Starting", Type: "info")
        self.personResponsibleTextField.text = result
        let PersonRespclass = objcet as! PersonResponseModel
        selectedPersonalNumber = PersonRespclass.PersonnelNo
        mJCLogger.log("Ended", Type: "info")
    }
    func setEditData()  {
        mJCLogger.log("Starting", Type: "info")
        if timeSheetClass.date != nil{
            let datestr = (timeSheetClass.date?.localDate() ?? Date().localDate()).toString(format: .custom(localDateTimeFormate))
            let date = datestr.components(separatedBy: " ")
            self.dateViewTextField.text = date[0]
        }
        self.workOrderButton.setTitle("--none--".localized(), for: UIControl.State.normal)
        self.workOrderButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        self.workOrderButton.isUserInteractionEnabled = false
        self.workOrderView.isUserInteractionEnabled = false
        if ENABLE_CAPTURE_DURATION == false{
            let CatsHours = "\(timeSheetClass.CatsHours)"
            let time = CatsHours.components(separatedBy: ".")
            self.selectedHours = time[0]
            if time.count > 1 {
                if time[1] == "0" || time[1] == "00"{
                    self.selectedMinutes = "00"
                }else {
                    if time[1].count > 2 {
                        var countInt  = 1
                        for _ in 0 ... time[1].count - 2 {
                            let devideCountStr  = String(format: "\(countInt)0")
                            countInt = Int(devideCountStr)!
                        }
                        let time12 = lroundf(Float(time[1])!) * 6 / countInt
                        self.selectedMinutes = "\(time12)"
                    }else {
                        var time12 = Float()
                        if time[1].prefix(1) == "0"{
                            time12 = Float(time[1])! * 6 / 10
                        }else{
                            time12 = Float(time[1])! * 6
                        }
                        if time12 > 60{
                            time12 = time12 / 10
                        }
                        self.selectedMinutes = "\(lroundf(time12))"
                    }
                }
            }
            self.startTimeTextField.text = "\(self.selectedHours)"
            self.endTimeTextField.text = "\(self.selectedMinutes)"
        }else{
            self.startTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.StartTime)
            self.endTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.EndTime)
        }
        self.workOrderTextField.text = timeSheetClass.RecOrder
        self.operationTextField.text = timeSheetClass.OperAct
        self.workOrderTextField.isUserInteractionEnabled = false
        self.operationTextField.isUserInteractionEnabled = false
        self.selectOperationButton.isHidden = true
        self.workCenterTextField.isEnabled = false
        self.timeEntryViewModel.getWorkCentersList()
        if timeSheetClass.FinalConfirmtn == "X"{
            self.postConfirmationButton.isHidden = false
            self.postConfirmationButton.isSelected = true
        }else{
            self.postConfirmationButton.isHidden = true
            self.postConfirmationButton.isSelected = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.dateViewTextField.resignFirstResponder()
        self.workOrderTextField.resignFirstResponder()
        self.attenenceTypeTextField.resignFirstResponder()
        self.operationTextField.resignFirstResponder()
        self.activityTypeTextField.resignFirstResponder()
        self.workCenterTextField.resignFirstResponder()
        self.workOrdrTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func startTimeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if ENABLE_CAPTURE_DURATION == false{
            dropDownString = "Hours"
            dropDown.anchorView = startTimeTextField
            if let arr : [String] = self.hoursArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            selectTimeString = "STARTTIME"
            
            ODSPicker.selectDate(title: "Select_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                if self!.endTimeTextField.text != "" && self!.endTimeTextField.text != "00:00"{
                    let startTimeStr = selectedDate.dateString(localTimeFormat)
                    let endTimeStr = self!.endTimeTextField.text!
                    let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startTimeStr, timeFormate: "HH:mm")
                    let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endTimeStr, timeFormate: "HH:mm")
                    if startTime != nil && endTime != nil{
                        let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
                        let timeDifference = Calendar.current.dateComponents(requestedComponent, from: startTime!, to: endTime!)
                        if timeDifference.hour ?? 0 < 0 || timeDifference.minute ?? 0 < 0{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                            return
                        }else{
                            self!.startTimeTextField.text = selectedDate.dateString(localTimeFormat)
                        }
                    }else{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }
                }else{
                    self!.startTimeTextField.text = selectedDate.dateString(localTimeFormat)
                }
                
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func endTimeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if ENABLE_CAPTURE_DURATION == false{
            dropDownString = "Minutes"
            dropDown.anchorView = endTimeTextFieldView
            if let arr : [String] = self.minutsArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            selectTimeString = "ENDTIME"
            
            ODSPicker.selectDate(title: "Select_End_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                if self!.startTimeTextField.text == ""{
                    self!.endTimeTextField.text = ""
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Start_time".localized() , button: okay)
                    return
                }
                self!.endTimeTextField.text = selectedDate.dateString(localTimeFormat)
                let startTimeStr = self!.startTimeTextField.text!
                let endTimeStr = self!.endTimeTextField.text!
                let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startTimeStr, timeFormate: "HH:mm")
                let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endTimeStr, timeFormate: "HH:mm")
                if startTime != nil && endTime != nil{
                    if startTime! >= endTime!{
                        self!.endTimeTextField.text = ""
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }else if startTime == endTime{
                        self!.endTimeTextField.text = ""
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }
                    let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
                    let timeDifference = Calendar.current.dateComponents(requestedComponent, from: startTime!, to: endTime!)
                    self!.selectedHours = "\(timeDifference.hour ?? 0)"
                    self!.selectedMinutes = "\(timeDifference.minute ?? 0)"
                }else{
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                    return
                }
                
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")
        return resourceTimesheetArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        mJCLogger.log("Starting", Type: "info")
        
        let cell = ScreenManager.getTeamTimesheetCell(tableView: resourceTimesheetTableView)
        let timeSheetEntity = resourceTimesheetArray[indexPath.row] as! SODataEntity
        if let nameproperty = timeSheetEntity.properties["PersonnelNo"] as? SODataPropertyDefault{
            cell.numberLabel.text = nameproperty.value as? String
            let personDetails = globalPersonRespArray.filter{$0.PersonnelNo == "\(cell.numberLabel.text ?? "")"}
            if personDetails.count > 0{
                let per = personDetails[0]
                cell.nameLabel.text = per.SystemID
            }
        }
        if ENABLE_CAPTURE_DURATION == false{
            if let nameproperty = timeSheetEntity.properties["CatsHours"] as? SODataPropertyDefault{
                let timeStr = "\(nameproperty.value ?? "0.00" as NSObject)"
                let time = timeStr.components(separatedBy: ".")
                let hours = time[0]
                var mins = "0"
                if time.count > 1 {
                    if time[1] == "0" || time[1] == "00"{
                        mins = "00"
                    }else {
                        if time[1].count > 2 {
                            var countInt  = 1
                            for _ in 0 ... time[1].count - 2 {
                                let devideCountStr  = String(format: "\(countInt)0")
                                countInt = Int(devideCountStr)!
                            }
                            let time12 = lroundf(Float(time[1])!) * 6 / countInt
                            mins = "\(time12)"
                        }else {
                            var time12 = Float()
                            if time[1].prefix(1) == "0"{
                                time12 = Float(time[1])! * 6 / 10
                            }else{
                                time12 = Float(time[1])! * 6
                            }
                            if time12 > 60{
                                time12 = time12 / 10
                            }
                            mins = "\(lroundf(time12))"
                        }
                    }
                }
                cell.durationLabel.text = "Duration".localized() + " : " + " \(hours) " + "Hours".localized() + " \(mins) " +  "Minutes".localized()
            }
        }else{
            var startTime = String()
            var endTime = String()
            var startDate = String()
            if let nameproperty = timeSheetEntity.properties["StartTime"] as? SODataPropertyDefault{
                let startTimeStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: nameproperty.value as! SODataDuration)
                startTime = "\(startTimeStr)"
            }
            if let nameproperty = timeSheetEntity.properties["EndTime"] as? SODataPropertyDefault{
                let endTimeStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: nameproperty.value as! SODataDuration)
                endTime = "\(endTimeStr)"
            }
            if let nameproperty = timeSheetEntity.properties["Date"] as? SODataPropertyDefault{
                startDate = ODSDateHelper.convertDateToString(date: (nameproperty.value as? Date)!)
//                StartDate = DateFormatterModelClass.uniqueInstance.getFullDateWithoutTimeZoneForMultipleSheetsPosting(date: nameproperty.value as! NSDate)
            }
            cell.durationLabel.text = "Start_Time".localized() + " : " + "\(startDate)" + " \(startTime)" + "\n" + "End_Time".localized() + " : " + "\(startDate)" + " \(endTime)"
        }
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    @objc func deleteButtonAction(sender: UIButton!) {
        mJCLogger.log("Starting", Type: "info")
        self.resourceTimesheetArray.removeObject(at: sender.tag)
        self.resourceTimesheetTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK: - Not using methods
    @IBAction func selectActivityTypeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.activityListArray.count > 0 {
            self.dropDownString = "Activity_Number".localized()
            dropDown.anchorView = activityTypeTextFieldView
            if let arr : [String] = self.activityListArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func PremiumButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.premiumIDArray.count > 0 {
            self.dropDownString = "Premium".localized()
            dropDown.anchorView = PremiumTextFieldView
            var arr = Array<String>()
            arr.append(selectStr)
            for item in self.premiumIDArray{
                arr.append(item.PremiumID + " - " + item.PremiumText)
            }
            dropDown.dataSource = arr
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func workOrderButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.workOrderListArray.count > 0 {
            self.dropDownString = "Work_order_Number".localized()
            dropDown.anchorView = workOrderButtonView
            if let arr : [String] = self.workOrderListArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func selectOperationButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.operationListArray.count > 0 {
            self.dropDownString = "Operation_Number".localized()
            dropDown.anchorView = operationTextFieldView
            if let arr : [String] = self.operationListArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func selectWorkcenterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.workCentersListArray.count > 0 {
            self.dropDownString = "Work_Center_Number".localized()
            dropDown.anchorView = workCenterTextFieldView
            if let arr : [String] = self.workCentersListArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //...END...//
}
