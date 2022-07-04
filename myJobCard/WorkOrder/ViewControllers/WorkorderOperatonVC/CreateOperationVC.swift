//
//  AddNewOperationVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/9/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CreateOperationVC: UIViewController,UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,barcodeDelegate,personResponsibleDelegate,FuncLocEquipSelectDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var addOperationHeaderLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    //MainView Outlets..
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainScrollview: UIScrollView!
    @IBOutlet var scrollViewContainerView: UIView!
    
    //SubOperationView Outlets..
    @IBOutlet var subOperationView: UIView!
    @IBOutlet var subOperationTitleLabel: UILabel!
    @IBOutlet var subOperationTextFieldView: UIView!
    @IBOutlet var subOperationTextField: UITextField!
    
    //PriorityView Outlets..
    @IBOutlet var priorityView: UIView!
    @IBOutlet var priorityTitleLabel: UILabel!
    @IBOutlet var priorityTextFieldView: UIView!
    @IBOutlet var priorityTextField: UITextField!
    @IBOutlet var priorityButton: UIButton!
    
    //OperationShortTextView Outlets..
    @IBOutlet var operationShortTextView: UIView!
    @IBOutlet var operationShortTextTitleLabel: UILabel!
    @IBOutlet var operationShortTextTextFieldView: UIView!
    @IBOutlet var operationShortTextTextField: UITextField!
    
    //EarliestSchdStartDateAndTimeView Outlets..
    @IBOutlet var earliestSchdStartDateTitleLabel: UILabel!
    @IBOutlet var earliestSchdStartDateAndTimeView: UIView!
    @IBOutlet var earliestSchdStartDateView: UIView!
    @IBOutlet var earliestSchdStartDateTextField: UITextField!
    @IBOutlet var earliestSchdStartDateButton: UIButton!
    @IBOutlet var earliestSchdStartTimeView: UIView!
    @IBOutlet var earliestSchdStartTimeTextField: UITextField!
    @IBOutlet var earliestSchdStartTimeButton: UIButton!
    
    //ControlKeyView Outlets..
    @IBOutlet var controlKeyView: UIView!
    @IBOutlet var controlKeyTitleLabel: UILabel!
    @IBOutlet var controlKeyTextFieldView: UIView!
    @IBOutlet var controlKeyTextField: UITextField!
    
    //EarliestSchdFinishDateAndTimeView Outlets..
    @IBOutlet var earliestSchdFinishDateTitleLabel: UILabel!
    @IBOutlet var earliestSchdFinishDateAndTimeView: UIView!
    @IBOutlet var earliestSchdFinishDateView: UIView!
    @IBOutlet var earliestSchdFinishDateTextField: UITextField!
    @IBOutlet var earliestSchdFinishDateButton: UIButton!
    @IBOutlet var earliestSchdFinishtimeTextFieldView: UIView!
    @IBOutlet var earliestSchdFinishtimeTextField: UITextField!
    @IBOutlet var earliestSchdFinishTimeButton: UIButton!
    
    //WorkCenterView Outlets..
    @IBOutlet var workCenterView: UIView!
    @IBOutlet var workCenterTitleLabel: UILabel!
    @IBOutlet var workCenterTextFieldView: UIView!
    @IBOutlet var workCenterTextField: iOSDropDown!
    @IBOutlet var workCenterButton: UIButton!
    
    //EquipmentView Outlets..
    @IBOutlet var equipmentView: UIView!
    @IBOutlet var equipmentTitleLabel: UILabel!
    @IBOutlet var equipmentTextField: UITextField!
    @IBOutlet var equipmentTextFieldView: UIView!
    @IBOutlet var equipmentSelectButton: UIButton!
    @IBOutlet var equipmentScanButton: UIButton!
    
    //PlantView Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTitleLabel: UILabel!
    @IBOutlet var plantTextField: iOSDropDown!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantButton: UIButton!
    
    // FunctionalLocationView Outlets..
    @IBOutlet var functionalLocationView: UIView!
    @IBOutlet var functionalLocationTitleLabel: UILabel!
    @IBOutlet var functionalLocationTextField: UITextField!
    @IBOutlet var functionalLocationTextFieldView: UIView!
    @IBOutlet var functionalLocationScantButton: UIButton!
    @IBOutlet var functionalLocationSelectButton: UIButton!
    
    // personResponsible view
    @IBOutlet var personResponsibleView: UIView!
    @IBOutlet var personResponsibleTitleLabel: UILabel!
    @IBOutlet var personResponsibleTextField: UITextField!
    @IBOutlet var personResonsibleTextFieldView: UIView!
    @IBOutlet var personResponsibleButton: UIButton!

    //NoteView Outlets..
    @IBOutlet var noteView: UIView!
    @IBOutlet var noteTitleLabel: UILabel!
    @IBOutlet var noteTextFieldView: UIView!
    @IBOutlet var noteTextView: UITextView!
    
    //Footer ButtonView Outlets..
    @IBOutlet var footerButtonView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var refreshButton: UIButton!

    // Equipment Warrenty Info Label Outlet
    @IBOutlet weak var equipWarrantyInfoLabel: UILabel!
    @IBOutlet weak var equipmentWarrantyView: UIView!
    @IBOutlet weak var equipmentWarrantyImageView: UIImageView!
    
    // Total Work Duration Outlets..
    @IBOutlet weak var totalworkDurationView: UIView!
    @IBOutlet var totalworkDurationTitleLabel: UILabel!
    @IBOutlet weak var totalWorkDurationTextFieldView: UIView!
    @IBOutlet weak var totalworkDurationTextField: UITextField!
    @IBOutlet weak var totalWorkDurationButton: UIButton!
    
    // Number Of Technicians Outlets..
    @IBOutlet var NoOfTechniciansTitleLabel: UILabel!
    @IBOutlet weak var NoOfTechniciansView: UIView!
    @IBOutlet weak var NoOfTechniciansTextFieldView: UIView!
    @IBOutlet weak var NoOfTechniciansTextfield: UITextField!
    
    //MARK:- Declared Variables..
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var businessAreaArray = NSMutableArray()
    var businessAreaListArray = NSMutableArray()
    var createdWONumber = String()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var fromWOCreate_BusinessArea = String()
    var fromWOCreate_BasicFnshDate = String()
    var fromWOCreate_BasicFnshTime = String()
    var fromWOCreate_BasicStrtDate = String()
    var fromWOCreate_BasicStrtTime = String()
    var fromWOCreate_ControlKey = String()
    var fromWOCreate_Equipment = String()
    var fromWOCreate_FunctionalLocation = String()
    var fromWOCreate_Plant = String()
    var fromWOCreate_Priority = String()
    var fromWOCreate_PersonnelNo = String()
    var fromWOCreate_WorkCenter = String()
    var fromWOCreate_WorkOrderNum = String()
    var functionalLocationArray = NSMutableArray()
    var functionalLocationListArray = NSMutableArray()
    var isFromEdit = Bool()
    var isFromScreen = String()
    var isFromError = Bool()
    var errorOperation = WoOperationModel()
    var isSelectedFunLoc = Bool()
    var NewWorkorderNotes = String()
    var plantArray = [String]()
    var maintPlantArray = [MaintencePlantModel]()
    var newOperationEntity : SODataEntity?
    var newWorkOrderEntity : SODataEntity?
    var operationNumber = String()
    var personResponsibleArray = [PersonResponseModel]()
    var personResponsibleListArray = [String]()
    var priorityArray = NSMutableArray()
    var priorityListArray = NSMutableArray()
    var PriorityText = String()
    var property = NSMutableArray()
    var propertyWorkOrderArray = NSMutableArray()
    var singleOperationClass = WoOperationModel()
    var selectDateAndTime = NSString()
    var WOOrdertype = String()
    var typeOfScanCode = String()
    var workCentersArray = [WorkCenterModel]()
    var workCentersListArray = [String]()
    var workOrderTypeArray = [LtOrderControlKeyModel]()
    var workOrderTypeListArray = [String]()
    var subStringArr = NSMutableArray()
    var delegate: operationCreationDelegate?
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        self.setMandatoryFields()
        noteTextView.delegate = self
        operationShortTextTextField.delegate = self
        ODSUIHelper.setBorderToView(view:self.subOperationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.priorityTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.operationShortTextTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.earliestSchdStartDateView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.earliestSchdStartTimeView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.controlKeyTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.earliestSchdFinishDateView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.earliestSchdFinishtimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.workCenterTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.equipmentTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.functionalLocationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.noteTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.totalWorkDurationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.NoOfTechniciansTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "1" {
            if WORKORDER_ASSIGNMENT_TYPE == "3"{
                if isFromEdit == true{
                    self.getPersonResponsibleList()
                    personResponsibleView.isHidden = false
                    ODSUIHelper.setBorderToView(view:self.personResonsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
                }else{
                    personResponsibleView.isHidden = true
                    ODSUIHelper.setBorderToView(view:self.personResonsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
                }
            }else{
                personResponsibleView.isHidden = true
                ODSUIHelper.setBorderToView(view:self.personResonsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            }
        }else{
            self.getPersonResponsibleList()
            personResponsibleView.isHidden = false
            ODSUIHelper.setBorderToView(view:self.personResonsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        if onlineSearch == true{
            self.noteView.isHidden = true
        }else{
            self.noteView.isHidden = false
        }
        if self.isFromScreen == "WorkOrderCreate" {
            self.noteView.isHidden = false
            if let BasicStrtTime = workOrderCreateDictionary.value(forKey: "BasicStrtTime") as? String{
                fromWOCreate_BasicStrtTime = BasicStrtTime
            }
            if let BasicStrtDate = workOrderCreateDictionary.value(forKey: "BasicStrtDate") as? String{
                fromWOCreate_BasicStrtDate = BasicStrtDate
            }
            if let BasicFnshTime = workOrderCreateDictionary.value(forKey: "BasicFnshTime") as? String{
                fromWOCreate_BasicFnshTime = BasicFnshTime
            }
            if let BasicFnshDate = workOrderCreateDictionary.value(forKey: "BasicFnshDate") as? String{
                fromWOCreate_BasicFnshDate = BasicFnshDate
            }
            if let ControlKey = workOrderCreateDictionary.value(forKey: "ControlKey") as? String{
                fromWOCreate_ControlKey = ControlKey
            }
            if let Equipment = workOrderCreateDictionary.value(forKey: "Equipment") as? String{
                fromWOCreate_Equipment = Equipment
            }
            if let FunctionalLocation = workOrderCreateDictionary.value(forKey: "FunctionalLocation") as? String{
                fromWOCreate_FunctionalLocation = FunctionalLocation
            }
            if let Plant = workOrderCreateDictionary.value(forKey: "Plant") as? String{
                fromWOCreate_Plant = Plant
            }
            if let priority = workOrderCreateDictionary.value(forKey: "Priority") as? String{
                fromWOCreate_Priority = priority
            }
            if let WorkCenter = workOrderCreateDictionary.value(forKey: "WorkCenter") as? String{
                fromWOCreate_WorkCenter = WorkCenter
            }
            if let PersonnelNo = workOrderCreateDictionary.value(forKey: "PersonnelNo") as? String{
                fromWOCreate_PersonnelNo = PersonnelNo
            }
            if let WorkOrderNum = workOrderCreateDictionary.value(forKey: "WorkOrderNum") as? String{
                fromWOCreate_WorkOrderNum = WorkOrderNum
            }
            self.setCreateOperationWOData()
        }else if self.isFromScreen == "Operation" {
            if isFromEdit == true {
                addOperationHeaderLabel.text = "Edit_Operation".localized() + "- \(singleOperationClass.OperationNum)"
                self.noteView.isHidden = true
                earliestSchdStartDateButton.isUserInteractionEnabled = false
                earliestSchdStartTimeButton.isUserInteractionEnabled = false
                earliestSchdFinishDateButton.isUserInteractionEnabled = false
                earliestSchdFinishTimeButton.isUserInteractionEnabled = false
                plantTextField.isUserInteractionEnabled = false
                plantTextField.arrow.isHidden = true
                self.functionalLocationView.isUserInteractionEnabled = false
                self.equipmentView.isUserInteractionEnabled = false
                
                if self.functionalLocationTextField.text == "" && self.equipmentTextField.text == "" {
//                    self.functionalLocationView.isUserInteractionEnabled = true
//                    self.equipmentView.isUserInteractionEnabled = true
//                    self.equipmentScanButton.isUserInteractionEnabled = true
//                    self.functionalLocationScantButton.isUserInteractionEnabled = true
                }else if equipmentTextField.text != "" && self.functionalLocationTextField.text == "" {
//                    self.functionalLocationView.isUserInteractionEnabled = false
//                    self.equipmentView.isUserInteractionEnabled = false
//                    self.equipmentScanButton.isHidden = true
                    self.functionalLocationScantButton.isHidden = true
                }else if self.functionalLocationTextField.text != "" && self.equipmentTextField.text == "" {
//                    self.functionalLocationView.isUserInteractionEnabled = true
//                    self.equipmentView.isUserInteractionEnabled = true
//                    self.equipmentScanButton.isUserInteractionEnabled = true
                    self.functionalLocationScantButton.isUserInteractionEnabled = true
                }else if functionalLocationTextField.text != "" && self.equipmentTextField.text != "" {
//                    self.functionalLocationView.isUserInteractionEnabled = false
//                    self.equipmentView.isUserInteractionEnabled = false
//                    self.equipmentScanButton.isHidden = true
//                    self.functionalLocationScantButton.isHidden = true
                }
                self.setEditOperationDatafromOperation()
            }else {
                self.functionalLocationView.isUserInteractionEnabled = true
                self.equipmentView.isUserInteractionEnabled = true
                addOperationHeaderLabel.text = "Add_Operation".localized()
                self.noteView.isHidden = false
                earliestSchdStartDateButton.isUserInteractionEnabled = false
                earliestSchdStartTimeButton.isUserInteractionEnabled = false
                earliestSchdFinishDateButton.isUserInteractionEnabled = false
                earliestSchdFinishTimeButton.isUserInteractionEnabled = false
                plantTextField.isUserInteractionEnabled = true
                self.setCreateOperationDatafromOperation()
            }
        }
        self.getPriorityList()
        self.getMaintPlantList()
        self.getWorkOrderType()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "PlantDropDown" {
                self.plantTextField.text = item
                self.dropDownSelectString = ""
                self.setWorkCenter()
            }else if self.dropDownSelectString == "PriorityDropDown" {
                self.priorityTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "WorkCentersDropDown" {
                self.workCenterTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "PersonResponsibleDropDown" {
                self.personResponsibleTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateOperationVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        //Work Center
        self.workCenterTextField.didSelect { selectedText, index, id in
            self.workCenterTextField.text = selectedText
        }
        
        //Plant
        self.plantTextField.didSelect { selectedText, index, id in
            self.plantTextField.text = selectedText
        }
        mJCLogger.log("Ended", Type: "info")
    }
    open override var shouldAutorotate: Bool {
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.operationShortTextTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.personResponsibleTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.workCenterTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.functionalLocationTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.equipmentTitleLabel)
    }
    //MARK:- footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if operationShortTextTextField.text == "" {
            mJCLogger.log("Please_enter_Operation_Short_Text".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_Operation_Short_Text".localized(), button: okay)
            
        }else if (operationShortTextTextField.text?.count)! > 40{
            mJCLogger.log("Operation_Short_Text_limit_Exceeded".localized(), Type: "Warn")
            
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Operation_Short_Text_limit_Exceeded".localized(), button: okay)
            
        }else if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5") && personResponsibleTextField.text == "" {
            mJCLogger.log("Please_Select_Person_Responsible".localized(), Type: "Warn")
            
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Person_Responsible".localized(), button: okay)
        }else if self.workCenterTextField.text == "" {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: WorkCenterAlert.localized(), button: okay)
        }else{
            let basicDateString = self.earliestSchdStartDateTextField.text! + " " + self.earliestSchdStartTimeTextField.text!
            let dueDateString = self.earliestSchdFinishDateTextField.text! + " " + self.earliestSchdFinishtimeTextField.text!
            let startDate = ODSDateHelper.getDateFromString(dateString: basicDateString, dateFormat: localDateTimeFormate)
            let finishDate = ODSDateHelper.getDateFromString(dateString: dueDateString, dateFormat: localDateTimeFormate)
            if finishDate < startDate {
                mJCLogger.log("Start_date_can't_fall_after_finish".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Start_date_can't_fall_after_finish".localized(), button: okay)
            }else {
                if isFromScreen == "WorkOrderCreate" {
                    self.createWorkOrder()
                }else if isFromScreen == "Operation" {
                    if isFromError == true && isFromEdit == true{
                        self.updateErrorOperation()
                    }else if isFromEdit == true {
                        self.updateOperation()
                    }else {
                        self.createNewOperation()
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isFromScreen == "WorkOrderCreate" {
            self.setCreateOperationWOData()
        }else if isFromScreen == "Operation" {
            if isFromEdit == true {
                self.setEditOperationDatafromOperation()
            }else {
                self.setCreateOperationDatafromOperation()
            }
        }
        self.setPriority()
        self.setWorkCenter()
        self.setWorkOrderType()
        self.setMaintencePlant()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Select Date and Time Button Action..
    @IBAction func earliestSchdStartDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "StartDate"
        self.allTextFieldResign()
        
        ODSPicker.selectDate(title: "Select_Earliest_Schd_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.earliestSchdFinishDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.earliestSchdFinishDateTextField.text)!){
                    self?.earliestSchdStartDateTextField.text = selectedDate.dateString(localDateFormate)
                }
                else{
                    self?.earliestSchdFinishDateTextField.text = ""
                    self?.earliestSchdStartDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            }
            else{
                self?.earliestSchdStartDateTextField.text = selectedDate.dateString(localDateFormate)
            }
        })
        
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func earliestSchdStartTimeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "StartTime"
        self.allTextFieldResign()
        
        if ODSDateHelper.compareTwoDates(fromDate: self.earliestSchdStartDateTextField.text!, toDate: self.earliestSchdFinishDateTextField.text!){
            let startDate = ODSDateHelper.restrictHoursOnCurrentTimer()
            let endDate = ODSDateHelper.restrictMiniutsOnCurrentTimer()
            ODSPicker.selectDate(title: "Select_Earliest_Schd_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, minDate: startDate as Date, maxDate: endDate as Date, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.earliestSchdStartTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        else{
            ODSPicker.selectDate(title: "Select_Earliest_Schd_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.earliestSchdStartTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func earliestSchdFinishDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        
        selectDateAndTime = "FinishDate"
        self.allTextFieldResign()
        
        if earliestSchdStartDateTextField.text!.count > 0 {
            let fromDate = ODSDateHelper.getDateFromString(dateString: earliestSchdStartDateTextField.text!, dateFormat: localDateFormate)
                ODSPicker.selectDate(title: "Select_Earliest_Schd_End_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: fromDate, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                    if !(self?.earliestSchdStartDateTextField.text!.isEmpty)! {
                        if ODSDateHelper.compareTwoDates(fromDate: (self?.earliestSchdStartDateTextField.text)!, toDate: selectedDate.dateString(localDateFormate)){
                            self?.earliestSchdFinishDateTextField.text = selectedDate.dateString(localDateFormate)
                        }
                        else{
                            self?.earliestSchdFinishDateTextField.text = ""
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized(), button: okay)
                        }
                    }
                    else{
                        self?.earliestSchdFinishDateTextField.text = selectedDate.dateString(localDateFormate)
                    }
                })
        }else{
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_Start_Date".localized() , button: okay)
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func earliestSchdFinishTimeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "FinishTime"
        self.allTextFieldResign()
        
        if ODSDateHelper.compareTwoDates(fromDate: self.earliestSchdStartDateTextField.text!, toDate: self.earliestSchdFinishDateTextField.text!){
            ODSPicker.selectDate(title: "Select_Earliest_Schd_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self!.earliestSchdFinishtimeTextField.text = selectedDate.dateString(localDateFormate)
                let startDateStr = "\(self!.earliestSchdStartDateTextField.text!) \(self!.earliestSchdStartTimeTextField.text!)"
                let endDateStr = "\(self!.earliestSchdFinishDateTextField.text!) \(self!.earliestSchdFinishtimeTextField.text!)"
                let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startDateStr, timeFormate: localDateTimeFormate)
                let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endDateStr, timeFormate: localDateTimeFormate)
                if startTime != nil && endTime != nil{
                    if startTime! >= endTime!{
                        self!.earliestSchdFinishtimeTextField.text = ""
                        mJCLogger.log("Please_select_valid_time".localized(), Type: "Warn")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }
                }else{
                    mJCLogger.log("Please_select_valid_time".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                    return
                }
            })
        }
        else{
            ODSPicker.selectDate(title: "Select_Earliest_Schd_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.earliestSchdFinishtimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Field button Action..
    @IBAction func priorityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.priorityTextFieldView
        let arr : [String] = self.priorityListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "PriorityDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentSelectButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let functionaLocationListVC = ScreenManager.getFlocEquipHierarchyScreen()
        functionaLocationListVC.isSelect = "Equipement"
        let wrkCtrArray = self.workCenterTextField.text!.components(separatedBy: " - ")
        if wrkCtrArray.count > 0 {
            functionaLocationListVC.workCenter = wrkCtrArray[0]
        }
        let plantArray = self.plantTextField.text!.components(separatedBy: " - ")
        if plantArray.count > 0 {
            let plantFilteredArray = self.maintPlantArray.filter{$0.Plant == plantArray[0] && $0.Name1 == plantArray[1]}
            if plantFilteredArray.count > 0{
                let plantClass = plantFilteredArray[0]
                functionaLocationListVC.planningPlant = plantClass.PlanningPlant
            }
        }
        functionaLocationListVC.modalPresentationStyle = .fullScreen
        functionaLocationListVC.delegate = self
        self.present(functionaLocationListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentScanButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Equip", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    func FuncLocOrEquipSelected(selectedObj: String, EquipObj: EquipmentModel, FuncObj:FunctionalLocationModel) {
        mJCLogger.log("Starting", Type: "info")
        if selectedObj == "Equipment"{
            self.functionalLocationTextField.text = EquipObj.FuncLocation
            self.equipmentTextField.text = EquipObj.Equipment
            if self.functionalLocationTextField.text == "" {
                mJCLogger.log("Functional_Location_is_not_available_for_this_Equipment".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_is_not_available_for_this_Equipment".localized(), button: okay)
            }
        }else if selectedObj == "FunctionalLocation"{
            self.functionalLocationTextField.text = FuncObj.FunctionalLoc
            self.equipmentTextField.text = EquipObj.Equipment
        }
        if EquipObj.Equipment != ""{
            self.equipWarrantyInfoLabel.text = myAssetDataManager.uniqueInstance.getEquipmentWarrantyInfo(EquipObj: EquipObj)
            equipmentWarrantyImageView.isHidden = false
            equipmentWarrantyView.isHidden = false
            equipmentWarrantyImageView.image = UIImage(named: "history_pending")
        }else{
            equipWarrantyInfoLabel.text = ""
            equipmentWarrantyImageView.isHidden = true
            equipmentWarrantyView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func functionalLocationScantButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Floc", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func functionalLocationSelectButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        let functionaLocationListVC = ScreenManager.getFlocEquipHierarchyScreen()
        functionaLocationListVC.selectedFunLoc = functionalLocationTextField.text!
        functionaLocationListVC.isSelect = "FunctionalLocation"
        let wrkCtrArray = self.workCenterTextField.text!.components(separatedBy: " - ")
        if wrkCtrArray.count > 0 {
            functionaLocationListVC.workCenter = wrkCtrArray[0]
        }
        let plantArray = self.workCenterTextField.text!.components(separatedBy: " - ")
        if plantArray.count > 0 {
            let plantFilteredArray = self.maintPlantArray.filter{$0.Plant == plantArray[0] && $0.Name1 == plantArray[1]}
            if plantFilteredArray.count > 0{
                let plantClass = plantFilteredArray[0]
                functionaLocationListVC.planningPlant = plantClass.PlanningPlant
            }
        }
        functionaLocationListVC.selectedFunLoc = self.functionalLocationTextField.text ?? ""
        functionaLocationListVC.modalPresentationStyle = .fullScreen
        functionaLocationListVC.delegate = self
        self.present(functionaLocationListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func personResponsibleScanButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.personResponsibleListArray.count > 0 {
            let personRespVC = ScreenManager.getPersonResponsibleListScreen()
            personRespVC.modalPresentationStyle = .fullScreen
            personRespVC.delegate = self
            self.present(personRespVC, animated: false) {
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        self.personResponsibleTextField.text = result
    }
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.allTextFieldResign()
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.subOperationTextField.resignFirstResponder()
        self.priorityTextField.resignFirstResponder()
        self.operationShortTextTextField.resignFirstResponder()
        self.earliestSchdStartDateTextField.resignFirstResponder()
        self.earliestSchdStartTimeTextField.resignFirstResponder()
        self.controlKeyTextField.resignFirstResponder()
        self.earliestSchdFinishDateTextField.resignFirstResponder()
        self.earliestSchdFinishtimeTextField.resignFirstResponder()
        self.workCenterTextField.resignFirstResponder()
        self.equipmentTextField.resignFirstResponder()
        self.plantTextField.resignFirstResponder()
        self.functionalLocationTextField.resignFirstResponder()
        self.noteTextView.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        if textField == operationShortTextTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                return newString.length <= maxLength
            }
        }
        return true
    }
    func setCreateOperationWOData() {
        mJCLogger.log("Starting", Type: "info")
        self.operationShortTextTextField.text = ""
        self.noteTextView.text = ""
        self.NoOfTechniciansTextfield.text = ""
        self.totalworkDurationTextField.text = ""
        self.earliestSchdStartDateTextField.text = fromWOCreate_BasicStrtDate
        self.earliestSchdStartTimeTextField.text = fromWOCreate_BasicStrtTime
        self.earliestSchdFinishDateTextField.text = fromWOCreate_BasicFnshDate
        self.earliestSchdFinishtimeTextField.text = fromWOCreate_BasicFnshTime
        self.functionalLocationTextField.text = fromWOCreate_FunctionalLocation
        self.equipmentTextField.text = fromWOCreate_Equipment
        mJCLogger.log("Ended", Type: "info")
    }
    func setCreateOperationDatafromOperation() {
        mJCLogger.log("Starting", Type: "info")
        if singleWorkOrder.WorkOrderNum.contains(find: "L"){
            let today = Date()
            let calendar = NSCalendar.current
            self.earliestSchdStartDateTextField.text = today.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.earliestSchdStartTimeTextField.text = today.toString(format: .custom("HH:mm"))
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today as Date)
            let tomorrowDate =  calendar.date(byAdding: .second, value: 1, to: tomorrow!)
            self.earliestSchdFinishDateTextField.text = tomorrowDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.earliestSchdFinishtimeTextField.text = tomorrowDate?.toString(format: .custom("HH:mm"))
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                let today = Date()
                let calendar = NSCalendar.current
                self.earliestSchdStartDateTextField.text = today.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                self.earliestSchdStartTimeTextField.text = today.toString(format: .custom("HH:mm"))
                let tomorrow = calendar.date(byAdding: .day, value: 1, to: today as Date)
                let tomorrowDate =  calendar.date(byAdding: .second, value: 1, to: tomorrow!)
                self.earliestSchdFinishDateTextField.text = tomorrowDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                self.earliestSchdFinishtimeTextField.text = tomorrowDate?.toString(format: .custom("HH:mm"))
            }else{
                if singleWorkOrder.SchdStrtDate != nil{
                    let strdate = (singleWorkOrder.SchdStrtDate ?? Date().localDate()).toString(format: .custom(localDateTimeFormate))
                    let schdStart = strdate.components(separatedBy:" ")
                    self.earliestSchdStartDateTextField.text = schdStart[0]
                    self.earliestSchdStartTimeTextField.text = schdStart[1]
                }
                if singleWorkOrder.SchdFnshDate != nil{
                    let enddate = (singleWorkOrder.SchdFnshDate ?? Date().localDate()).toString(format: .custom(localDateTimeFormate))
                    let schdFinish = enddate.components(separatedBy:" ")
                    self.earliestSchdFinishDateTextField.text = schdFinish[0]
                    self.earliestSchdFinishtimeTextField.text = schdFinish[1]
                }
            }
        }
        self.functionalLocationTextField.text = singleWorkOrder.FuncLocation
        self.equipmentTextField.text = singleWorkOrder.EquipNum
        self.operationShortTextTextField.text = ""
        self.noteTextView.text = ""
        self.NoOfTechniciansTextfield.text = ""
        self.totalworkDurationTextField.text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    func setEditOperationDatafromOperation() {
        mJCLogger.log("Starting", Type: "info")
        if  isFromError == true && isFromEdit == true{
            self.operationShortTextTextField.text = errorOperation.ShortText
            self.noteTextView.text = ""
            if errorOperation.EarlSchStartExecDate != nil{
                self.earliestSchdStartDateTextField.text = (errorOperation.EarlSchStartExecDate ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.earliestSchdStartDateTextField.text = ""
            }
            self.earliestSchdStartTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorOperation.EarlSchStartExecTime)
            if errorOperation.EarlSchFinishExecDate != nil{
                self.earliestSchdFinishDateTextField.text = (errorOperation.EarlSchFinishExecDate ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.earliestSchdFinishDateTextField.text = ""
            }
            self.earliestSchdFinishtimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorOperation.EarlSchFinishExecTime)
            self.functionalLocationTextField.text = errorOperation.FuncLoc
            self.equipmentTextField.text = errorOperation.Equipment
            earliestSchdStartDateButton.isUserInteractionEnabled = true
            earliestSchdStartTimeButton.isUserInteractionEnabled = true
            earliestSchdFinishDateButton.isUserInteractionEnabled = true
            earliestSchdFinishTimeButton.isUserInteractionEnabled = true
            plantTextField.isUserInteractionEnabled = true
            self.functionalLocationView.isUserInteractionEnabled = true
            self.equipmentView.isUserInteractionEnabled = true
        }else{
            self.operationShortTextTextField.text = singleOperationClass.ShortText
            self.noteTextView.text = ""
            if singleOperationClass.EarlSchStartExecDate != nil{
                self.earliestSchdStartDateTextField.text = (singleOperationClass.EarlSchStartExecDate ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.earliestSchdStartDateTextField.text = ""
            }
            self.earliestSchdStartTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperationClass.EarlSchStartExecTime)
            if singleOperationClass.EarlSchFinishExecDate != nil{
                self.earliestSchdFinishDateTextField.text = (singleOperationClass.EarlSchFinishExecDate ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.earliestSchdFinishDateTextField.text = ""
            }
            self.earliestSchdFinishtimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperationClass.EarlSchFinishExecTime)
            self.totalworkDurationTextField.text = "\(singleOperationClass.Work)"
            self.NoOfTechniciansTextfield.text = "\(singleOperationClass.NumberPerson)"
            self.functionalLocationTextField.text = singleOperationClass.FuncLoc
            self.equipmentTextField.text = singleOperationClass.Equipment
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get PriorityList..
    func getPriorityList()  {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.priorityArray.count)", Type: "Debug")
        self.priorityArray.removeAllObjects()
        if globalPriorityArray.count > 0 {
            let array = globalPriorityArray as NSArray
            let descriptor:NSSortDescriptor = NSSortDescriptor (key:"PriorityText", ascending : true)
            let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
            self.priorityArray.addObjects(from: sortedArray as! [Any])
            self.setPriority()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setPriority()  {
        mJCLogger.log("Starting", Type: "info")
        self.priorityListArray.removeAllObjects()
        DispatchQueue.main.async {
            var isSetPriority = false
            for item in self.priorityArray {
                self.priorityListArray.add((item as! PriorityListModel).PriorityText)
                if self.isFromError == true && self.isFromEdit == true{
                    if self.errorOperation.Priority == (item as! PriorityListModel).Priority {
                        self.priorityTextField.text = (item as! PriorityListModel).PriorityText
                    }else if self.singleOperationClass.Priority == "" {
                        if self.priorityListArray.count > 0{
                            self.priorityTextField.text = self.priorityListArray[0] as? String
                        }
                    }
                }else if self.isFromEdit == true {
                    if self.singleOperationClass.Priority == (item as! PriorityListModel).Priority {
                        self.priorityTextField.text = (item as! PriorityListModel).PriorityText
                    }else if self.singleOperationClass.Priority == "" {
                        if self.priorityListArray.count > 0{
                            self.priorityTextField.text = self.priorityListArray[0] as? String
                        }
                    }
                }else if self.isFromEdit == false {
                    if isSetPriority == false {
                        if self.isFromScreen == "WorkOrderCreate" {
                            if self.fromWOCreate_Priority == (item as! PriorityListModel).Priority {
                                self.priorityTextField.text = (item as! PriorityListModel).PriorityText
                                isSetPriority = true
                            }
                        }else if self.isFromScreen == "Operation" {
                            if singleWorkOrder.Priority == (item as! PriorityListModel).Priority {
                                self.priorityTextField.text = (item as! PriorityListModel).PriorityText
                                isSetPriority = true
                            }else{
                                if self.priorityListArray.count > 0{
                                    self.priorityTextField.text = (self.priorityArray[0] as! PriorityListModel).PriorityText
                                    isSetPriority = true
                                }
                            }
                        }else {
                            if self.priorityListArray.count > 0{
                                self.priorityTextField.text = self.priorityListArray[0] as? String
                                isSetPriority = true
                            }
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get WorkCenters List..
    func getWorkCentersList()  {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersArray.removeAll()
        mJCLogger.log("Response :\(globalWorkCtrArray.count)", Type: "Debug")
        if globalWorkCtrArray.count > 0
        {
            self.workCentersArray.append(contentsOf: globalWorkCtrArray)
            self.setWorkCenter()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set WorkCenter..
    func setWorkCenter() {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersListArray.removeAll()
        DispatchQueue.main.async {
            var plant = String()
            if self.plantTextField.text != ""{
                let arr = self.plantTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    plant = (arr[0])
                }
                let filteredArray = self.workCentersArray.filter{$0.Plant == "\(plant)"}
                mJCLogger.log("Response :\(filteredArray.count)", Type: "Debug")
                if filteredArray.count > 0{
                    for item in filteredArray {
                        self.workCentersListArray.append(item.WorkCenter + " - " + item.ShortText)
                    }
                }
            }else{
                for item in self.workCentersArray {
                    self.workCentersListArray.append(item.WorkCenter + " - " + item.ShortText)
                }
            }
            //Work Center
            if self.workCentersListArray.count > 0{
                DispatchQueue.main.async {
                    self.workCenterTextField.optionArray = self.workCentersListArray
                    self.workCenterTextField.checkMarkEnabled = false
                }
            }
            
            var workcenterStr = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                workcenterStr = self.errorOperation.WorkCenter
            }else  if self.isFromEdit == true {
                workcenterStr = self.singleOperationClass.WorkCenter
                
            }else if self.isFromEdit == false {
                if self.isFromScreen == "WorkOrderCreate" {
                    self.workCenterTextField.text = self.fromWOCreate_WorkCenter
                    let arr =  self.fromWOCreate_WorkCenter.components(separatedBy: " - ")
                    if arr.count > 0{
                        workcenterStr = arr[0]
                    }else{
                        workcenterStr = ""
                    }
                }else if self.isFromScreen == "Operation" {
                    workcenterStr = singleOperation.WorkCenter
                }
            }
            if workcenterStr == "" && self.workCentersListArray.count > 0{
                let filterArr = self.workCentersArray.filter{$0.WorkCenter == userWorkcenter}
                mJCLogger.log("Response :\(filterArr.count)", Type: "Debug")
                if filterArr.count > 0{
                    let cls = filterArr[0]
                    self.workCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    if self.workCentersListArray.count > 0{
                        self.workCenterTextField.text = self.workCentersListArray[0]
                    }
                }
            }else if self.workCentersListArray.count > 0{
                var filterArr = Array<Any>()
                filterArr = self.workCentersArray.filter{$0.WorkCenter == workcenterStr}
                mJCLogger.log("Response :\(filterArr.count)", Type: "Debug")
                if filterArr.count > 0{
                    let cls = filterArr[0] as! WorkCenterModel
                    self.workCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    if self.workCentersListArray.count > 0{
                        self.workCenterTextField.text = self.workCentersListArray[0]
                    }
                }
            }else{
                self.workCenterTextField.text = ""
            }
            mJCLogger.log("Set WorkCenter End".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Work OrderType List..
    func getWorkOrderType()  {
        mJCLogger.log("Starting", Type: "info")
        LtOrderControlKeyModel.getltOrderControlKeyList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [LtOrderControlKeyModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.workOrderTypeArray =  responseArr
                    self.setWorkOrderType()
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkOrderType()  {
        mJCLogger.log("Starting", Type: "info")
        self.workOrderTypeListArray.removeAll()
        DispatchQueue.main.async {
            for item in self.workOrderTypeArray {
                self.workOrderTypeListArray.append(item.OrderType + " - " + item.OrderDescription)
                if self.isFromError == true && self.isFromEdit == true{
                    if self.errorOperation.OrderType == item.OrderType {
                        self.controlKeyTextField.text = item.ControlKey + " - " + item.OrderDescription
                    }
                }else if self.isFromEdit == true {
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        if singleOperation.OrderType == item.OrderType {
                            self.controlKeyTextField.text = item.ControlKey + " - " + item.OrderDescription
                        }
                    }else {
                        if self.WOOrdertype == item.OrderType{
                            self.controlKeyTextField.text = item.ControlKey + " - " + item.OrderDescription
                        }
                    }
                }else if self.isFromEdit == false {
                    if self.isFromScreen == "WorkOrderCreate" {
                        if self.fromWOCreate_ControlKey == item.OrderType{
                            self.controlKeyTextField.text = item.ControlKey + " - " + item.OrderDescription
                        }
                    }else if self.isFromScreen == "Operation" {
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            if singleOperation.OrderType == item.OrderType {
                                self.controlKeyTextField.text = item.ControlKey + " - " + item.OrderDescription
                            }
                        }else {
                            if singleWorkOrder.OrderType == item.OrderType {
                                self.controlKeyTextField.text = item.ControlKey + " - " + item.OrderDescription
                            }
                        }
                    }else {
                        if self.workOrderTypeListArray.count > 0{
                            self.controlKeyTextField.text =
                            self.workOrderTypeListArray[0]
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get mainPlant
    func getMaintPlantList() {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.maintPlantArray.count)", Type: "Debug")
        self.maintPlantArray.removeAll()
        if globalPlanningPlantArray.count > 0 {
            self.maintPlantArray.append(contentsOf: globalPlanningPlantArray)
            self.setMaintencePlant()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Maintence Plant..
    func setMaintencePlant() {
        mJCLogger.log("Starting", Type: "info")
        self.plantArray.removeAll()
        DispatchQueue.main.async {
            var isSetPlant = false
            for item in self.maintPlantArray {
                self.plantArray.append(item.Plant + " - " + item.Name1)
                if self.isFromError == true && self.isFromEdit == true{
                    if self.errorOperation.Plant == item.Plant {
                        self.plantTextField.text = item.Plant + " - " + item.Name1
                    }
                }else if self.isFromEdit == true {
                    if self.singleOperationClass.Plant == item.Plant {
                        self.plantTextField.text = item.Plant + " - " + item.Name1
                    }
                }else if self.isFromEdit == false {
                    if isSetPlant == false {
                        if self.isFromScreen == "WorkOrderCreate" {
                            if self.fromWOCreate_Plant == item.Plant + " - " + item.Name1 {
                                self.plantTextField.text = item.Plant + " - " + item.Name1
                            }
                        }else if self.isFromScreen == "Operation" {
                            if singleWorkOrder.Plant == item.Plant {
                                self.plantTextField.text = item.Plant + " - " + item.Name1
                            }
                        }else {
                            if self.plantArray.count > 0 {
                                self.plantTextField.text = self.plantArray[0]
                                isSetPlant = true
                            }
                        }
                    }
                }
            }
            
            //Plant
            if self.plantArray.count > 0{
                DispatchQueue.main.async {
                    self.plantTextField.optionArray = self.plantArray
                    self.plantTextField.checkMarkEnabled = false
                }
            }
            self.getWorkCentersList()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Create New WorkOrder..
    func createWorkOrder() {
        print("===== WorkOrder Key Value ======")
        mJCLogger.log("Starting", Type: "info")
        let entity = SODataEntityDefault(type: woHeader_Entity)
        for prop in self.propertyWorkOrderArray {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("......................")
        }
        newWorkOrderEntity = entity
        var flushReq = Bool()
        if self.NewWorkorderNotes != ""{
            if(self.NewWorkorderNotes.count > 0 ) {
                flushReq = false
            }else{
                flushReq = true
            }
        }else{
            flushReq = false
        }
        WoHeaderModel.createWorkorderEntity(entity: entity!, collectionPath: woHeader, flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("record inserted successfully".localized(), Type: "Debug")
                UserDefaults.standard.set(true, forKey: "isCreateWorkOrder")
                if self.NewWorkorderNotes != ""{
                    if(self.NewWorkorderNotes.count > 0 ) {
                        var workordernumber = String()
                        if self.isFromScreen == "WorkOrderCreate" {
                            workordernumber = self.fromWOCreate_WorkOrderNum
                        }else if self.isFromScreen == "Operation" {
                            workordernumber = singleWorkOrder.WorkOrderNum
                        }
                        self.createNewNote(noteText: self.NewWorkorderNotes, Workorder: workordernumber, entity: self.newWorkOrderEntity!, notesType: "WorkOrder")
                    }
                }else{
                    self.createNewOperation()
                }
            }else {
                DispatchQueue.main.async {
                    print("Error : \(error?.localizedDescription)")
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    UserDefaults.standard.set(false, forKey: "isCreateWorkOrder")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_save_workorder_try_again".localized(), button: okay)
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Create & Update Operation..
    func createNewOperation() {
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BusinessArea")
        if isFromScreen == "WorkOrderCreate" {
            prop!.value = fromWOCreate_BusinessArea as NSObject
        }
        else if isFromScreen == "Operation" {
            prop!.value = singleWorkOrder.BusArea as NSObject
        }
        self.property.add(prop!)
        prop = SODataPropertyDefault(name: "ControlKey")
        let controlKeyArray = (self.controlKeyTextField.text ?? "").components(separatedBy: " - ")
        if controlKeyArray.count > 0 {
            prop!.value = controlKeyArray[0] as NSObject
        }else {
            mJCLogger.log("controlKey_Required".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "controlKey_Required".localized(), button: okay)
            return
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "DeletionFlag")
        prop!.value = false as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOperation")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EarlSchFinishExecDate")
        prop!.value = ODSDateHelper.getDateFromString(dateString: self.earliestSchdFinishDateTextField.text!, dateFormat: localDateFormate).localDate() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EarlSchFinishExecTime")
        let dueTime = SODataDuration()
        let dueTimeArray = earliestSchdFinishtimeTextField.text?.components(separatedBy:":")
        dueTime.hours = Int(dueTimeArray![0]) as NSNumber?
        dueTime.minutes = Int(dueTimeArray![1]) as NSNumber?
        dueTime.seconds = 0
        prop!.value = dueTime
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EarlSchStartExecDate")
        prop!.value = ODSDateHelper.getDateFromString(dateString: self.earliestSchdStartDateTextField.text!, dateFormat: localDateFormate).localDate() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EarlSchStartExecTime")
        let basicTime = SODataDuration()
        let basicTimeArray = earliestSchdStartTimeTextField.text?.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray![0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray![1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Equipment")
        prop!.value = equipmentTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FuncLoc")
        prop!.value = functionalLocationTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = operationNumber as NSObject
        self.property.add(prop!)
        
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            prop = SODataPropertyDefault(name: "PersonnelNo")
            let perrespArr = self.personResponsibleTextField.text!.components(separatedBy: " - ")
            if perrespArr.count > 0 {
                let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == perrespArr[0] && $0.EmplApplName == perrespArr[1]}
                if personResponsibleFilteredArray.count > 0{
                    let personResponsibleClass = personResponsibleFilteredArray[0]
                    prop!.value = personResponsibleClass.PersonnelNo as NSObject
                    self.property.add(prop!)
                }
            }
        }else {
            prop = SODataPropertyDefault(name: "PersonnelNo")
            prop!.value = "" as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "Plant")
        let plantArray = self.plantTextField.text!.components(separatedBy: " - ")
        if plantArray.count > 0 {
            prop!.value = plantArray[0] as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "Priority")
        let priorityPredicate : NSPredicate = NSPredicate(format: "SELF.PriorityText == %@",self.priorityTextField.text!)
        let priorityFilteredArray = self.priorityArray.filtered(using: priorityPredicate)
        if priorityFilteredArray.count > 0 {
            let priorityClass = priorityFilteredArray[0] as! PriorityListModel
            prop!.value = priorityClass.Priority as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "ShortText")
        prop!.value = operationShortTextTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        if isFromScreen == "WorkOrderCreate" {
            prop!.value = fromWOCreate_WorkOrderNum as NSObject
        }else if isFromScreen == "Operation" {
            prop!.value = operationNumber as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = "\(String.random(length: 8, type: "Number"))" as NSObject
        self.property.add(prop!)
        
        let wrkCtrArr = self.workCenterTextField.text!.components(separatedBy: " - ")
        if wrkCtrArr.count > 0 {
            prop = SODataPropertyDefault(name: "WorkCenter")
            prop!.value = wrkCtrArr[0] as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        if isFromScreen == "WorkOrderCreate" {
            prop!.value = fromWOCreate_WorkOrderNum as NSObject
        }else if isFromScreen == "Operation" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                prop!.value = singleOperation.WorkOrderNum as NSObject
            }else{
                prop!.value = singleWorkOrder.WorkOrderNum as NSObject
            }
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OrderType")
        prop!.value = singleWorkOrder.OrderType as NSObject
        self.property.add(prop!)
        
        if ENABLE_LOCAL_STATUS_CHANGE == true{
            
            prop = SODataPropertyDefault(name: "StatusFlag")
            prop!.value = "X" as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "MobileStatus")
            prop!.value = DEFAULT_STATUS_TO_SEND as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "UserStatus")
            prop!.value = DEFAULT_STATUS_TO_SEND as NSObject
            self.property.add(prop!)
        }
        if totalworkDurationTextField.text != ""{
            let arr = totalworkDurationTextField.text?.components(separatedBy: " : ")
            if arr!.count > 1{
                var hourStr = arr![0]
                var minStr = arr![1]
                hourStr = hourStr.replacingOccurrences(of: " \("Hours".localized())", with: "")
                minStr = minStr.replacingOccurrences(of: " \("Minutes".localized())", with: "")
                
                let hours = Float(hourStr) ?? 0
                let min = Float(minStr) ?? 0
                let totalWork = Float("\(hours + min / 60)")!
                prop = SODataPropertyDefault(name: "Work")
                prop!.value = NSDecimalNumber(string: "\(abs(totalWork))")
                self.property.add(prop!)
            }
        }
        if self.NoOfTechniciansTextfield.text != ""{
            prop = SODataPropertyDefault(name: "NumberPerson")
            prop!.value = Int(self.NoOfTechniciansTextfield.text ?? "0") as NSObject?
            self.property.add(prop!)
        }

        print("===== Operation Key Value ======")
        
        let entity = SODataEntityDefault(type: woOperationEntity)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("......................")
        }
        newOperationEntity = entity
        
        var flushReq = Bool()
        if self.noteTextView.text! == "" {
            flushReq = true
        }else{
            flushReq = false
        }
        
        WoOperationModel.createOperationEntity(entity: entity!, collectionPath: woOperationSet, flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Operation Created successfully".localized(), Type: "Debug")
                self.delegate?.operation(true, Update: false)
                workOrderCreateDictionary.removeAllObjects()
                NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                DispatchQueue.main.async {
                    if self.noteTextView.text! == "" {
                        mJCLoader.stopAnimating()
                        let params = Parameters(
                            title: MessageTitle,
                            message: "Operation_Created_successfully".localized(),
                            cancelButton: okay
                        )
                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0:
                                self.dismiss(animated: false) {}
                            default: break
                            }
                        }
                    }else{
                        if self.noteTextView.text.count > 0 {
                            var workordernumber = String()
                            if self.isFromScreen == "WorkOrderCreate" {
                                workordernumber = self.fromWOCreate_WorkOrderNum
                            }else if self.isFromScreen == "Operation" {
                                workordernumber = singleWorkOrder.WorkOrderNum
                            }
                            self.createNewNote(noteText: self.noteTextView.text, Workorder: workordernumber, entity: self.newOperationEntity!, notesType: "Operation")
                            DispatchQueue.main.async {
                                self.noteTextView.text = ""
                            }
                        }
                    }
                }
            }else {
                DispatchQueue.main.async {
                    print("Error : \(error?.localizedDescription)")
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    self.delegate?.operation(false, Update: false)
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_save_operation_try_again".localized(), button: okay)
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func updateErrorOperation(){
        
        mJCLogger.log("Starting", Type: "info")
        let controlKeyArray = controlKeyTextField.text?.components(separatedBy:" - ")
        (errorOperation.entity.properties["ControlKey"] as! SODataProperty).value = controlKeyArray![0] as NSObject
        (errorOperation.entity.properties["EarlSchFinishExecDate"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.earliestSchdFinishDateTextField.text!, dateFormat: localDateFormate) as NSObject
        let dueTime = SODataDuration()
        let dueTimeArray = earliestSchdFinishtimeTextField.text?.components(separatedBy:":")
        dueTime.hours = Int(dueTimeArray![0]) as NSNumber?
        dueTime.minutes = Int(dueTimeArray![1]) as NSNumber?
        dueTime.seconds = 0
        (errorOperation.entity.properties["EarlSchFinishExecTime"] as! SODataProperty).value = dueTime
        (errorOperation.entity.properties["EarlSchStartExecDate"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.earliestSchdStartDateTextField.text!, dateFormat: localDateFormate) as NSObject
        let basicTime = SODataDuration()
        let basicTimeArray = earliestSchdStartTimeTextField.text?.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray![0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray![1]) as NSNumber?
        basicTime.seconds = 0
        (errorOperation.entity.properties["EarlSchStartExecTime"] as! SODataProperty).value = basicTime
        (errorOperation.entity.properties["Equipment"] as! SODataProperty).value = equipmentTextField.text! as NSObject
        (errorOperation.entity.properties["FuncLoc"] as! SODataProperty).value = functionalLocationTextField.text! as NSObject
        let plantArray = self.plantTextField.text!.components(separatedBy: " - ")
        if plantArray.count > 0 {
            (errorOperation.entity.properties["Plant"] as! SODataProperty).value = plantArray[0] as NSObject
        }
        let priorityPredicate : NSPredicate = NSPredicate(format: "SELF.PriorityText == %@",self.priorityTextField.text!)
        let priorityFilteredArray = self.priorityArray.filtered(using: priorityPredicate)
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0] as! PriorityListModel
            (errorOperation.entity.properties["Priority"] as! SODataProperty).value = priorityClass.Priority as NSObject
        }
        (errorOperation.entity.properties["ShortText"] as! SODataProperty).value = operationShortTextTextField.text! as NSObject
        let wrkCtrArr = self.workCenterTextField.text!.components(separatedBy: " - ")
        if wrkCtrArr.count > 0 {
            (errorOperation.entity.properties["WorkCenter"] as! SODataProperty).value = wrkCtrArr[0] as NSObject
        }
        WoOperationModel.updateOperationEntity(entity: errorOperation.entity, options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Operation Updated successfully".localized(), Type: "Debug")
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "fail_to_update_operation_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func updateOperation() {
        mJCLogger.log("Starting", Type: "info")
        (singleOperationClass.entity.properties["BusinessArea"] as! SODataProperty).value = singleWorkOrder.BusArea as NSObject
        singleOperationClass.BusinessArea = singleWorkOrder.BusArea
        let controlKeyArray = controlKeyTextField.text?.components(separatedBy:" - ")
        (singleOperationClass.entity.properties["ControlKey"] as! SODataProperty).value = controlKeyArray![0] as NSObject
        singleOperationClass.ControlKey =  controlKeyArray![0]
        (singleOperationClass.entity.properties["EarlSchFinishExecDate"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.earliestSchdFinishDateTextField.text!, dateFormat: localDateFormate) as NSObject
        singleOperationClass.EarlSchFinishExecDate = ODSDateHelper.getDateFromString(dateString: self.earliestSchdFinishDateTextField.text!, dateFormat: localDateTimeFormate)
        let dueTime = SODataDuration()
        let dueTimeArray = earliestSchdFinishtimeTextField.text?.components(separatedBy:":")
        dueTime.hours = Int(dueTimeArray![0]) as NSNumber?
        dueTime.minutes = Int(dueTimeArray![1]) as NSNumber?
        dueTime.seconds = 0
        (singleOperationClass.entity.properties["EarlSchFinishExecTime"] as! SODataProperty).value = dueTime
        singleOperationClass.EarlSchFinishExecTime = dueTime
        (singleOperationClass.entity.properties["EarlSchStartExecDate"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.earliestSchdStartDateTextField.text!, dateFormat: localDateFormate) as NSObject
        singleOperationClass.EarlSchStartExecDate = ODSDateHelper.getDateFromString(dateString: self.earliestSchdStartDateTextField.text!, dateFormat: localDateTimeFormate)
        let basicTime = SODataDuration()
        let basicTimeArray = earliestSchdStartTimeTextField.text?.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray![0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray![1]) as NSNumber?
        basicTime.seconds = 0
        (singleOperationClass.entity.properties["EarlSchStartExecTime"] as! SODataProperty).value = basicTime
        singleOperationClass.EarlSchStartExecTime = basicTime
        (singleOperationClass.entity.properties["Equipment"] as! SODataProperty).value = equipmentTextField.text! as NSObject
        singleOperationClass.Equipment = equipmentTextField.text!
        (singleOperationClass.entity.properties["FuncLoc"] as! SODataProperty).value = functionalLocationTextField.text! as NSObject
        singleOperationClass.FuncLoc = functionalLocationTextField.text!
        let plantArray = self.plantTextField.text!.components(separatedBy: " - ")
        if plantArray.count > 0 {
            (singleOperationClass.entity.properties["Plant"] as! SODataProperty).value = plantArray[0] as NSObject
            singleOperationClass.Plant = plantArray[0]
        }
        let priorityPredicate : NSPredicate = NSPredicate(format: "SELF.PriorityText == %@",self.priorityTextField.text!)
        let priorityFilteredArray = self.priorityArray.filtered(using: priorityPredicate)
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0] as! PriorityListModel
            (singleOperationClass.entity.properties["Priority"] as! SODataProperty).value = priorityClass.Priority as NSObject
            singleOperationClass.Priority = priorityClass.Priority
        }
        (singleOperationClass.entity.properties["ShortText"] as! SODataProperty).value = operationShortTextTextField.text as NSObject?
        singleOperationClass.ShortText = String(operationShortTextTextField.text!)
        let wrkCtrArr = self.workCenterTextField.text!.components(separatedBy: " - ")
        if wrkCtrArr.count > 0 {
            (singleOperationClass.entity.properties["WorkCenter"] as! SODataProperty).value = wrkCtrArr[0] as NSObject
            singleOperationClass.WorkCenter = wrkCtrArr[0]
        }
        if WORKORDER_ASSIGNMENT_TYPE == "2"  || WORKORDER_ASSIGNMENT_TYPE == "5" || WORKORDER_ASSIGNMENT_TYPE == "3" {
            let perrespArr = self.personResponsibleTextField.text!.components(separatedBy: " - ")
            if perrespArr.count > 0 {
                let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == perrespArr[0] && $0.EmplApplName == perrespArr[1]}
                if personResponsibleFilteredArray.count > 0{
                    let personResponsibleClass = personResponsibleFilteredArray[0]
                    (singleOperationClass.entity.properties["PersonnelNo"] as! SODataProperty).value = personResponsibleClass.PersonnelNo as NSObject
                    singleOperationClass.PersonnelNo = personResponsibleClass.PersonnelNo
                }
            }
        }
        (singleOperationClass.entity.properties["StatusFlag"] as? SODataProperty)?.value = "" as NSObject
        singleOperationClass.StatusFlag = ""
        (singleOperationClass.entity.properties["TransferFlag"] as? SODataProperty)?.value = "" as NSObject
        singleOperationClass.TransferFlag = ""
        if "\(singleOperationClass.Work)" != self.totalworkDurationTextField.text{
            let arr = totalworkDurationTextField.text?.components(separatedBy: " : ")
            if arr!.count > 1{
                var hourStr = arr![0]
                var minStr = arr![1]
                hourStr = hourStr.replacingOccurrences(of: " \("Hours".localized())", with: "")
                minStr = minStr.replacingOccurrences(of: " \("Minutes".localized())", with: "")
                let hours = Float(hourStr) ?? 0
                let min = Float(minStr) ?? 0
                let totalWork = Float("\(hours + min / 60)")!
                (singleOperationClass.entity.properties["Work"] as? SODataProperty)?.value = NSDecimalNumber(string: "\(abs(totalWork))") as NSObject
                singleOperationClass.Work = NSDecimalNumber(string: "\(abs(totalWork))")
            }
        }
        if "\(singleOperationClass.NumberPerson)" != self.NoOfTechniciansTextfield.text{
            (singleOperationClass.entity.properties["NumberPerson"] as? SODataProperty)?.value = Int(self.NoOfTechniciansTextfield.text ?? "1") as NSObject?
            singleOperationClass.NumberPerson  = UInt16(self.NoOfTechniciansTextfield.text ?? "1") ?? 1
        }
        WoOperationModel.updateOperationEntity(entity: singleOperationClass.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Operation Updated successfully".localized(), Type: "Debug")
                self.delegate?.operation(false, Update: true)
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "fail_to_update_operation_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Crete & Get Note..
    func createNewNote(noteText:String, Workorder: String,entity:SODataEntity,notesType:String) {
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = noteText as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        var itemCount = String()
        prop!.value = "0001" as NSObject
        self.property.add(prop!)
        
        if notesType == "Operation" {
            prop = SODataPropertyDefault(name: "Counter")
            prop!.value = (entity.properties["Counter"] as! SODataProperty).value!
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "TextName")
        var WorkorderStr = String()
        if Workorder.contains(find: "L"){
            WorkorderStr = Workorder
        }else{
            WorkorderStr = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: Workorder)
        }
        if notesType == "WorkOrder" {
            prop!.value = "\(WorkorderStr)" as NSObject
        }else{
            prop!.value = "\(WorkorderStr)\(operationNumber)" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        var workordernumber = String()
        if self.isFromScreen == "WorkOrderCreate" {
            workordernumber = self.fromWOCreate_WorkOrderNum
        }else if self.isFromScreen == "Operation" {
            workordernumber = singleWorkOrder.WorkOrderNum
        }
        prop!.value = "\(workordernumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        if notesType == "WorkOrder" {
            prop!.value = "" as NSObject
        }else{
            prop!.value = operationNumber as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        self.property.add(prop!)
        
        
        prop = SODataPropertyDefault(name: "TempID")
        if self.isFromScreen == "WorkOrderCreate" {
            prop!.value = "\(WorkorderStr)" as NSObject
        }else if self.isFromScreen == "Operation" {
            prop!.value = "" as NSObject
        }
        self.property.add(prop!)
        
        var longTextSetEntity = String()
        var longTextCollectionPath = String()
        var textObject = String()
        textObject = LONG_TEXT_TYPE_OPERATION
        longTextSetEntity = woLongTextSetEntity
        longTextCollectionPath = woLongTextSet
        
        if notesType == "WorkOrder"{
            textObject = LONG_TEXT_TYPE_WO
        }else{
            textObject = LONG_TEXT_TYPE_OPERATION
        }
        
        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = textObject as NSObject
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: longTextSetEntity)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        var flushReq = Bool()
        if notesType == "WorkOrder"{
            flushReq = false
        }else{
            flushReq = true
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: longTextCollectionPath,flushRequired: flushReq ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                if notesType == "WorkOrder"{
                    self.createNewOperation()
                }else{
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Operation_Created_successfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            self.dismiss(animated: false) {}
                        default: break
                        }
                    }
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                DispatchQueue.main.async {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_Note_try_again".localized(), button: okay)
                    self.dismiss(animated: false, completion: {})
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Person Responsible List..
    func getPersonResponsibleList() {
        mJCLogger.log("Starting", Type: "info")
        self.personResponsibleArray.removeAll()
        mJCLogger.log("Response :\(globalPersonRespArray.count)", Type: "Debug")
        if globalPersonRespArray.count > 0 {
            self.personResponsibleArray.append(contentsOf: globalPersonRespArray)
            self.setPersonResponsible()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func setPersonResponsible() {
        mJCLogger.log("Starting", Type: "info")
        self.personResponsibleListArray.removeAll()
        DispatchQueue.main.async {
            for item in self.personResponsibleArray {
                self.personResponsibleListArray.append(item.SystemID + " - " + item.EmplApplName)
                if self.isFromEdit == false {
                    let userString = item.SystemID.lowercased()
                    if (userString == strUser) {
                        self.personResponsibleTextField.text = item.SystemID + " - " + item.EmplApplName
                    }
                }else {
                    if singleWorkOrder.PersonResponsible == item.PersonnelNo {
                        self.personResponsibleTextField.text = item.SystemID + " - " + item.EmplApplName
                    }else{
                        if self.singleOperationClass.PersonnelNo != ""{
                            let newfilterArr = self.personResponsibleArray.filter{$0.PersonnelNo == self.singleOperationClass.PersonnelNo}
                            if newfilterArr.count > 0{
                                let details = newfilterArr[0]
                                self.personResponsibleTextField.text = "\(self.singleOperationClass.PersonnelNo)" + " - " + "\(details.SystemID)"
                            }else{
                                self.personResponsibleTextField.text = selectStr
                            }
                        }else{
                            self.personResponsibleTextField.text = selectStr
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if barCode == "Floc"{
                DispatchQueue.main.async {
                    if let obj = object as? FunctionalLocationModel,obj.FunctionalLoc != ""{
                        self.functionalLocationTextField.text = obj.FunctionalLoc
                    }else{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "couldn’t_find_functional_location_for_id".localized(), button: okay)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }else if barCode == "Equip"{
                DispatchQueue.main.async {
                    if let obj = object as? EquipmentModel,obj.Equipment != ""{
                        self.equipmentTextField.text = obj.Equipment
                        self.functionalLocationTextField.text = obj.FuncLocation
                    }else{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "couldn’t_find_equipment_for_id".localized() , button: okay)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func totalWrkDurHoursButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "totalWorkDuration"
        self.allTextFieldResign()
        
        ODSPicker.selectDate(title: "gWW-Hi-z6v".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
            let arr = selectedDate.dateString(localDateFormate).components(separatedBy: "/")
            self!.totalworkDurationTextField.text = "\(arr[0]) " + "Hours".localized() + " : " + "\(arr[1]) " + "Minutes".localized()
        })
        
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Not using methods
    @IBAction func workCenterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.workCenterTextFieldView
        let arr : [String] = self.workCentersListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "WorkCentersDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func plantButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.plantTextFieldView
        let arr : [String] = self.plantArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "PlantDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
}
