//
//  ConfirmationVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 30/03/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import Foundation
import MobileCoreServices
import ODSFoundation
import mJCLib

class CreateFinalConfirmationVC: UIViewController{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet var workOrderNumView: UIView!
    @IBOutlet var workOrderNumTitleLabel: UILabel!
    @IBOutlet var workOrderNumTextFieldView: UIView!
    @IBOutlet var workOrderNumTextField: UITextField!
    @IBOutlet var workOrderNumTextbutton: UIButton!
    
    @IBOutlet var operationView: UIView!
    @IBOutlet var operationTitleLabel: UILabel!
    @IBOutlet var operationTextFieldView: UIView!
    @IBOutlet var operationTextField: UITextField!
    @IBOutlet var operationTextbutton: UIButton!
    
    @IBOutlet  var activityTypeTextView: UIView!
    @IBOutlet  var activityTypeTitleLabel: UIView!
    @IBOutlet  var activityTypeTextFieldView: UIView!
    @IBOutlet  var activityTypeTextField: UITextField!
    @IBOutlet  var activityTypeTextbutton: UIButton!
    
    @IBOutlet weak var actualDurTextView: UIView!
    @IBOutlet weak var actualDurHrsLabel: UILabel!
    @IBOutlet weak var actualDurHrsTextFieldView: UIView!
    @IBOutlet weak var actualDurHrsTextField: UITextField!
    @IBOutlet weak var actualDurHrsButton: UIButton!
    
    @IBOutlet weak var actualDurMinsLabel: UILabel!
    @IBOutlet weak var actualDurMinsTextFieldView: UIView!
    @IBOutlet weak var actualDurMinsTextField: UITextField!
    @IBOutlet weak var actualDurMinsButton: UIButton!
    
    @IBOutlet  var actualDurFormateTextView: UIView!
    @IBOutlet  var actualDurFormateTitleLabel: UILabel!
    @IBOutlet  var actualDurFormateTextFieldView: UIView!
    @IBOutlet  var actualDurFormateTextField: UITextField!
    @IBOutlet  var actualDurFormateTextbutton: UIButton!
    
    @IBOutlet  var confirmationTextTextView: UIView!
    @IBOutlet  var confirmationTextTitleLabel: UILabel!
    @IBOutlet  var confirmationTextTextFieldView: UIView!
    @IBOutlet  var confirmationTextTextField: UITextField!
    
    @IBOutlet  var execStartDateTextTextView: UIView!
    @IBOutlet  var execStartDateTitleLabel: UILabel!
    @IBOutlet  var execStartDateTextFieldView: UIView!
    @IBOutlet  var execStartDateTextField: UITextField!
    @IBOutlet  var execStartDateTextbutton: UIButton!
    
    @IBOutlet  var execStartTimeTextFieldView: UIView!
    @IBOutlet  var execStartTimeTitleLabel: UILabel!
    @IBOutlet  var execStartTimeTextField: UITextField!
    @IBOutlet  var execStartTimeTextbutton: UIButton!
    
    @IBOutlet  var execEndDateTextTextView: UIView!
    @IBOutlet  var execEndDateTitleLabel: UILabel!
    @IBOutlet  var execEndDateTextFieldView: UIView!
    @IBOutlet  var execEndDateTextField: UITextField!
    @IBOutlet  var execEndDateTextbutton: UIButton!
    
    @IBOutlet  var execEndTimeTextFieldView: UIView!
    @IBOutlet  var execEndTimeTitleLabel: UILabel!
    @IBOutlet  var execEndTimeTextField: UITextField!
    @IBOutlet  var execEndTimeTextbutton: UIButton!
    
    @IBOutlet  var unitOfWorkTextTextView: UIView!
    @IBOutlet  var unitOfWorkTextTitleLabel: UILabel!
    @IBOutlet  var unitOfWorkTextFieldView: UIView!
    @IBOutlet  var unitOfWorkTextField: UITextField!
    @IBOutlet weak var unitOfWorkLabel: UILabel!
    @IBOutlet  var finalConfirmationCheckBox: UIButton!
    
    @IBOutlet var clearReservationCheckBox: UIButton!
    @IBOutlet var headerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    var suspendViewModel = SuspendViewModel()
    var conformationViewModel = ConformationViewModel()
    var statusCategoryCls = StatusCategoryModel()
    var activityArray = [WorkOrderActivityModel]()
    var activityListArray = [String]()
    var actualDurationFormateArray = [String]()
    var hoursArray = NSMutableArray()
    var minutsArray = NSMutableArray()
    let dropDown = DropDown()
    var dropDownString = String()
    var screenType = String()
    var selectedworkOrder = String()
    var selectedOperation = String()
    var selectionType = String()
    var selectFinalConfimation = Bool()
    var conformationStatusArray = [StatusChangeLogModel]()
    var errorConfirEntity = WoConfirmationModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.conformationViewModel.confirmationVC = self
        self.conformationViewModel.setViewLayouts()
        self.conformationViewModel.getActivityList()
        actualDurationFormateArray.append(contentsOf: ["H","MIN"])
        if actualDurationFormateArray.count > 0 {
            actualDurFormateTextField.text = actualDurationFormateArray[0]
            self.setMandatoryFields()
        }
        if screenType == "StatusChange"{
            headerViewHeightConst.constant = 0.0
            headerView.isHidden = true
            self.statusCategoryCls = self.suspendViewModel.suspendVc!.statusCategoryCls
            self.workOrderNumTextField.text = "\(self.selectedworkOrder)"
            self.operationTextField.text = "\(self.selectedOperation)"
            self.conformationViewModel.getStausChangeLogSet(validStatus: self.statusCategoryCls)
            self.unitOfWorkLabel.text = "\(singleOperation.UnitWork)"
            self.unitOfWorkTextField.text = "\(singleOperation.Work)"
            self.workOrderNumView.isUserInteractionEnabled = false
            self.operationView.isUserInteractionEnabled = false
            if selectFinalConfimation == true{
                self.finalConfirmationCheckBox.isSelected = true
                self.finalConfirmationCheckBox.isUserInteractionEnabled = false
            }else{
                self.finalConfirmationCheckBox.isHidden = true
                self.finalConfirmationCheckBox.isSelected = false
                self.finalConfirmationCheckBox.isUserInteractionEnabled = true
            }
            if DeviceType == iPad{
                let index = self.suspendViewModel.completionFeatureListArray.firstIndex{$0.title == "Confirmation".localized()} ?? 0
                if index == self.suspendViewModel.completionFeatureListArray.count - 1{
                    if self.suspendViewModel.suspendVc?.isFromScreen == "Hold"{
                        self.doneButton.setTitle("Hold_order".localized(), for: .normal)
                    }else if self.suspendViewModel.suspendVc?.isFromScreen == "Suspend"{
                        self.doneButton.setTitle("Suspend".localized(), for: .normal)
                    }else{
                        self.doneButton.setTitle("Complete".localized(), for: .normal)
                    }
                }
            }
        }else if screenType == "errorEdit"{
            self.headerLabel.text = "Create_confirmation".localized()
            headerViewHeightConst.constant = 64.0
            headerView.isHidden = false
            self.workOrderNumTextField.text = "\(errorConfirEntity.WorkOrderNum)"
            self.operationTextField.text = "\(errorConfirEntity.OperationNum)"
            self.confirmationTextTextField.text = "\(errorConfirEntity.ConfText)"
            self.unitOfWorkLabel.text = ""
            self.unitOfWorkTextField.text = ""
            self.workOrderNumView.isUserInteractionEnabled = false
            self.operationView.isUserInteractionEnabled = false
            if errorConfirEntity.ExecStartDate != nil{
                self.execStartDateTextField.text = (errorConfirEntity.ExecStartDate ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.execStartTimeTextField.text = ""
            }
            self.execStartTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorConfirEntity.ExecStartTime)
            if errorConfirEntity.ExecFinDate != nil{
                self.execEndDateTextField.text = (errorConfirEntity.ExecFinDate ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.execEndDateTextField.text = ""
            }
            self.execEndTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorConfirEntity.ExecFinTime)
            self.unitOfWorkLabel.text = "\(errorConfirEntity.UnActDur)"
            self.actualDurFormateTextField.text = "\(errorConfirEntity.UnActDur)"
            self.unitOfWorkTextField.text = "\(errorConfirEntity.ActualDur)"
            let hrs = Int(truncating: errorConfirEntity.ActualDur) / 60
            let min = Float(truncating: errorConfirEntity.ActualDur).truncatingRemainder(dividingBy: 60)
            self.actualDurHrsTextField.text = "\(hrs)"
            self.actualDurMinsTextField.text = "\(min * 60)"
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownString == "ActivityNumber"{
                self.activityTypeTextField.text = item
            }else if self.dropDownString == "Hours"{
                self.actualDurHrsTextField.text = item
                let hours = Int(self.actualDurHrsTextField.text ?? "0") ?? 0
                let minutes = Int(self.actualDurMinsTextField.text ?? "0") ?? 0
                var workTime = String()
                self.conformationViewModel.totalHours = hours
                if self.unitOfWorkLabel.text ?? "MIN" == "H"{
                    workTime = "\(abs(Float(hours) + Float(minutes) / 60))"
                }else{
                    workTime = "\(abs(hours * 60 + minutes))"
                }
                self.unitOfWorkTextField.text = "\(workTime)"
            }else if self.dropDownString == "Minutes"{
                self.actualDurMinsTextField.text = item
                let hours = Int(self.actualDurHrsTextField.text ?? "0") ?? 0
                let minutes = Int(self.actualDurMinsTextField.text ?? "0") ?? 0
                var workTime = String()
                self.conformationViewModel.totalMins = minutes
                if self.unitOfWorkLabel.text ?? "MIN" == "H"{
                    workTime = "\(abs(Float(hours) + Float(minutes) / 60))"
                }else{
                    workTime = "\(abs(hours * 60 + minutes))"
                }
                self.unitOfWorkTextField.text = "\(workTime)"
            }else if self.dropDownString == "DurationFormate"{
                self.actualDurFormateTextField.text = item
            }
            self.dropDownString = ""
            self.dropDown.hide()
        }
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.workOrderNumTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.operationTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.actualDurHrsLabel)
        myAssetDataManager.setMandatoryLabel(label: self.actualDurMinsLabel)
        myAssetDataManager.setMandatoryLabel(label: self.execStartDateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.execStartTimeTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.execEndDateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.execEndTimeTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.unitOfWorkTextTitleLabel)
    }
    
    @IBAction func workOrderNumberButtonAction(_ sender: Any) {
    }
    @IBAction func activityTypeButtonActionn(_ sender: Any) {

        mJCLogger.log("Starting", Type: "info")
        if self.activityListArray.count > 0 {
            self.dropDownString = "ActivityNumber"
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
    @IBAction func operationButtonAction(_ sender: Any) {
    }
    @IBAction func actualDurationFormateButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.actualDurationFormateArray.count > 0 {
            self.dropDownString = "DurationFormate"
            dropDown.anchorView = actualDurFormateTextFieldView
            if let arr : [String] = self.actualDurationFormateArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func executionStartDateAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        
        let dbDateStr = ODSDateHelper.getDateFromString(dateString: execStartDateTextField.text!, dateFormat: localDateFormate)
        ODSPicker.selectDate(title: "Select_Execution_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: dbDateStr, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.execEndDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.execEndDateTextField.text)!){
                    self?.execStartDateTextField.text = selectedDate.dateString(localDateFormate)
                }
                else{
                    self?.execEndDateTextField.text = ""
                    self?.execStartDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            }
            else{
                self?.execStartDateTextField.text = selectedDate.dateString(localDateFormate)
            }
        })
        
        selectionType = "executionStartDate"
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func executionStartTimeAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("executionStartTimeAction".localized(), Type: "")
        selectionType = "executionStartTime"
        
        if ODSDateHelper.compareTwoDates(fromDate: self.execStartDateTextField.text!, toDate: self.execEndDateTextField.text!){
            let startDate = ODSDateHelper.restrictHoursOnCurrentTimer()
            let endDate = ODSDateHelper.restrictMiniutsOnCurrentTimer()
            ODSPicker.selectDate(title: "Select_Execution_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, minDate: startDate, maxDate: endDate, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self!.execStartTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        else{
            ODSPicker.selectDate(title: "Select_Execution_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self!.execStartTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func executionEndDateAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        selectionType = "executionEndDate"
        
        if execStartDateTextField.text!.count > 0 {
            let fromDate = ODSDateHelper.getDateFromString(dateString: execStartDateTextField.text!, dateFormat: localDateFormate)
                ODSPicker.selectDate(title: "Select_Execution_End_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: fromDate, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                    if !(self?.execStartDateTextField.text!.isEmpty)! {
                        if ODSDateHelper.compareTwoDates(fromDate: (self?.execStartDateTextField.text)!, toDate: selectedDate.dateString(localDateFormate)){
                            self?.execEndDateTextField.text = selectedDate.dateString(localDateFormate)
                        }
                        else{
                            self?.execEndDateTextField.text = ""
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized(), button: okay)
                        }
                    }
                    else{
                        self?.execEndDateTextField.text = selectedDate.dateString(localDateFormate)
                    }
                })
        }else{
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_Start_Date".localized() , button: okay)
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func executionEndTimeAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("MalfunctionEndTimeButtonAction".localized(), Type: "")
        selectionType = "executionEndTime"
        if ODSDateHelper.compareTwoDates(fromDate: self.execStartDateTextField.text!, toDate: self.execEndDateTextField.text!){
            ODSPicker.selectDate(title: "Select_Execution_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self!.execEndTimeTextField.text = selectedDate.dateString(localTimeFormat)
                let startDate = Date(fromString: "\(self!.execStartDateTextField.text!) \(self!.execStartTimeTextField.text!)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current)
                let endDate = Date(fromString: "\(self!.execEndDateTextField.text!) \(selectedDate.dateString(localTimeFormat))", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current)
                if startDate != nil && endDate != nil{
                    if startDate! >= endDate!{
                        self!.execEndTimeTextField.text = ""
                        mJCLogger.log("Please_select_valid_time".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }else{
                        self!.execEndTimeTextField.text = selectedDate.dateString(localTimeFormat)
                    }
                }else{
                    mJCLogger.log("Please_select_valid_time".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                    return
                }
            })
        }
        else{
            ODSPicker.selectDate(title: "Select_Execution_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self!.execEndTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func finalConfirmationCheckBoxAction(_ sender: Any) {
        if (sender as! UIButton).isSelected {
            (sender as! UIButton).isSelected = false
        }else {
            (sender as! UIButton).isSelected = true
        }
    }
    @IBAction func ClearReservationButtonAction(_ sender: Any) {
        if (sender as! UIButton).isSelected {
            (sender as! UIButton).isSelected = false
        }else {
            (sender as! UIButton).isSelected = true
        }
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        
        finalConfirmationCheckBox.isSelected = false
        clearReservationCheckBox.isSelected = false
        self.unitOfWorkLabel.text = "\(singleOperation.UnitWork)"
        self.unitOfWorkTextField.text = "\(singleOperation.Work)"
        self.confirmationTextTextField.text = ""
        if self.actualDurationFormateArray.count > 0 {
            self.actualDurFormateTextField.text = self.actualDurationFormateArray[0]
        }
        if self.activityArray.count > 0 {
            for activity in self.activityArray {
                if activity.ActivityType == self.statusCategoryCls.ActivityType {
                    self.activityTypeTextField.text = activity.ActivityType + " - " + activity.ShortText
                }
            }
        }
        if self.conformationStatusArray.count > 0 {
            let timeDict = self.conformationStatusArray[0]
            if timeDict.StatusChangedTime != nil{
                let startDate = timeDict.StatusChangedTime!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                let startTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeDict.StatusTime)
                let startDateTime = Date(fromString: "\(startDate) \(startTime)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                let currrentDateTime = Date().localDate()
                let elapsedTime = currrentDateTime.timeIntervalSince(startDateTime)
                let hours = floor(elapsedTime / 60 / 60)
                let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
                self.conformationViewModel.totalHours = Int(hours)
                self.conformationViewModel.totalMins = Int(minutes)
                self.conformationViewModel.startDateTime = startDateTime
                self.conformationViewModel.endDateTime = currrentDateTime
                DispatchQueue.main.async{
                    self.actualDurHrsTextField.text = "\(Int(hours))"
                    self.actualDurMinsTextField.text = "\(Int(minutes))"
                    var workTime = String()
                    if self.unitOfWorkLabel.text ?? "MIN" == "H"{
                        workTime = "\(abs(Float(hours) + Float(minutes) / 60))"
                    }else{
                        workTime = "\(abs(hours * 60 + minutes))"
                    }
                    self.unitOfWorkTextField.text = "\(workTime)"
                    self.execStartDateTextField.text = "\(startDate)"
                    self.execStartTimeTextField.text = "\(startTime)"
                    let currentDate = Date().localDate().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    let currentTime = Date().toString(format: .custom("HH:mm"), timeZone: .local, locale: .current)
                    self.execEndDateTextField.text = "\(currentDate)"
                    self.execEndTimeTextField.text = "\(currentTime)"
                }
            }
        }
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        if self.screenType == "StatusChange"{
            self.suspendViewModel.suspendVc?.dismissViewController()
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        self.conformationViewModel.validateScreenValues()
    }
    @IBAction func actualDurHrsButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        dropDownString = "Hours"
        dropDown.anchorView = actualDurHrsTextFieldView
        if let arr : [String] = self.hoursArray as NSArray as? [String] {
            dropDown.dataSource = arr
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func actualDurMinsButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        dropDownString = "Minutes"
        dropDown.anchorView = actualDurMinsTextFieldView
        if let arr : [String] = self.minutsArray as NSArray as? [String] {
            dropDown.dataSource = arr
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
