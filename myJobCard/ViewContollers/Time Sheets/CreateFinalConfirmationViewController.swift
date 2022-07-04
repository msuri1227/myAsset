//
//  CreateFinalConfirmationViewController.swift
//  myJobCard
//
//  Created by Ruby's Mac on 30/03/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import MobileCoreServices
import ODSFoundation
import mJCLib

class CreateFinalConfirmationViewController: UIViewController,ODSTimePickerViewControllerDelegate,ODSDatePickerViewControllerDelegate{
    
    

    @IBOutlet var workOrderNumView: UIView!
    @IBOutlet var workOrderNumTextFieldView: UIView!
    @IBOutlet var workOrderNumTextField: UITextField!
    @IBOutlet var workOrderNumTextbutton: UIButton!
    
    @IBOutlet var operationTextView: UIView!
    @IBOutlet var operationTextFieldView: UIView!
    @IBOutlet var operationTextField: UITextField!
    @IBOutlet var operationTextbutton: UIButton!
    
    
    @IBOutlet var actionTypeTextView: UIView!
    @IBOutlet var actionTypeTextFieldView: UIView!
    @IBOutlet var actionTypeTextField: UITextField!
    @IBOutlet var actionTypeTextbutton: UIButton!
    
    @IBOutlet var actualDurTextView: UIView!
    @IBOutlet var actualDurTextFieldView: UIView!
    @IBOutlet var actualDurTextField: UITextField!
    @IBOutlet var actualDurTextbutton: UIButton!
    
    @IBOutlet var actualDurationTextView: UIView!
    @IBOutlet var actualDurationTextFieldView: UIView!
    @IBOutlet var actualDurationTextField: UITextField!
    @IBOutlet var actualDurationTextbutton: UIButton!
    
    @IBOutlet var confirmationTextTextView: UIView!
    @IBOutlet var confirmationTextTextFieldView: UIView!
    @IBOutlet var confirmationTextTextField: UITextField!
    @IBOutlet var confirmationTextTextbutton: UIButton!
    
    @IBOutlet var execStartDateTextTextView: UIView!
    @IBOutlet var execStartDateTextFieldView: UIView!
    @IBOutlet var execStartDateTextField: UITextField!
    @IBOutlet var execStartDateTextbutton: UIButton!
    @IBOutlet var execStartTimeTextFieldView: UIView!
    @IBOutlet var execStartTimeTextField: UITextField!
    @IBOutlet var execStartTimeTextbutton: UIButton!
    
    @IBOutlet var execEndDateTextTextView: UIView!
    @IBOutlet var execEndDateTextFieldView: UIView!
    @IBOutlet var execEndDateTextField: UITextField!
    @IBOutlet var execEndDateTextbutton: UIButton!
    @IBOutlet var execEndTimeTextFieldView: UIView!
    @IBOutlet var execEndTimeTextField: UITextField!
    @IBOutlet var execEndTimeTextbutton: UIButton!
    
    @IBOutlet var finalConfirmationCheckBox: UIButton!
    
    var selectDateAndTime = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()
        ODSUIHelper.setBorderToView(view:self.actualDurationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.workOrderNumTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.operationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.actionTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.actualDurTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationTextTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.execStartDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.execStartTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.execEndDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.execEndTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)

        setBasicData()
        // Do any additional setup after loading the view.
    }
    

    func ODSTimePickerDidSet(_ viewController: ODSTimePickerViewController, result: ODSTimePickerResult) {
        mJCLogger.log("Starting", Type: "info")
        if selectDateAndTime == "executionStartTime" {
            execStartTimeTextField.text = result.description
        }else if selectDateAndTime == "executionEndTime" {
          
            if execStartTimeTextField.text!.count > 0 && execStartDateTextField.text!.count > 0{
              
                execEndDateTextField.text = result.description
                
                let startDateStr = "\(execStartDateTextField.text!) \(execStartTimeTextField.text!)"
                let endDateStr = "\(execEndDateTextField.text!) \(result.description)"
                let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startDateStr, timeFormate: localDateTimeFormate)
                let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endDateStr, timeFormate: localDateTimeFormate)
                
                if startTime != nil && endTime != nil{
                    if startTime! >= endTime!{
                        execEndDateTextField.text = ""
                        mJCLogger.log("Please_select_valid_time".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(viewController, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }
                }else{
                    mJCLogger.log("Please_select_valid_time".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(viewController, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                    return

                }
                
            }else{
                mJCLogger.log("Please_Select_Start_time".localized(), Type: "Debug")
                execEndDateTextField.text = ""
                mJCAlertHelper.showAlert(viewController, title: alerttitle, message: "Please_Select_Start_time".localized() , button: okay)
                return
            }
            
        }
            viewController.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
        }
    
    func ODSTimePickerDidCancel(_ viewController: ODSTimePickerViewController) {
        mJCLogger.log("Starting", Type: "info")
        viewController.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    
    func ODSDatePickerDidSet(_ viewController: ODSDatePickerViewController, result: ODSDatePickerResult) {
     
        
        mJCLogger.log("Starting", Type: "info")
        let resultdate = result.dateFromPicker
        if selectDateAndTime == "executionStartDate" {
            execStartDateTextField.text = resultdate
            viewController.dismiss(animated: true, completion: nil)
        }else if selectDateAndTime == "executionEndDate" {
            if execEndDateTextField.text!.count > 0 {
                let startDate = ODSDateHelper.getDateFromString(dateString: execStartDateTextField.text!, dateFormat: localDateFormate)
                let selecteddate = ODSDateHelper.getDateFromString(dateString: resultdate, dateFormat: localDateFormate)
                
                if selecteddate as Date > startDate {
                    self.execEndDateTextField.text = resultdate
                    viewController.dismiss(animated: true, completion: nil)
                }else{
                    mJCLogger.log("Please_Select_Malfunction_End_Date_Greaterthan_Malfunction_Start_Date".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(viewController, title: MessageTitle, message: "Please_Select_Malfunction_End_Date_Greaterthan_Malfunction_Start_Date".localized() , button: okay)
                }
            }else{
                mJCLogger.log("Please_Select_Malfunction_Start_Date".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(viewController, title: MessageTitle, message: "Please_Select_Malfunction_Start_Date".localized() , button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func ODSDatePickerDidCancel(_ viewController: ODSDatePickerViewController) {
        mJCLogger.log("Starting", Type: "info")
           viewController.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func finalConfirmationCheckBoxAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let checkFillimg = UIImage(named: "ic_check_fill")
        if finalConfirmationCheckBox.imageView?.image == checkFillimg {
            finalConfirmationCheckBox.setImage(UIImage(named: "ic_check_nil"), for: .normal)
            finalConfirmationCheckBox.isSelected = false

        }else{
            finalConfirmationCheckBox.setImage(UIImage(named: "ic_check_fill"), for: .normal)
            finalConfirmationCheckBox.isSelected = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func executionStartDateAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let vc = ODSDatePickerViewController()
        vc.datePickerTitle = "Select_Execution_Start_Date".localized()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    
       selectDateAndTime = "executionStartDate"
       self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
   }
    
    @IBAction func executionStartTimeAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("executionStartTimeAction".localized(), Type: "")
        let vc = ODSTimePickerViewController()
        vc.timePickerTitle = "Select_Execution_Start_Time".localized()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        selectDateAndTime = "executionStartTime"
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func executionEndDateAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let vc = ODSDatePickerViewController()
        vc.datePickerTitle = "Select_Execution_End_Date".localized()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
       selectDateAndTime = "executionEndDate"
       self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func executionEndTimeAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("MalfunctionEndTimeButtonAction".localized(), Type: "")
        let vc = ODSTimePickerViewController()
        vc.timePickerTitle = "Select_Execution_End_Time".localized()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        selectDateAndTime = "executionEndTime"
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func actualDurationButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")

        self.allTextFieldResign()
        
//        if self.maintPlantListArray.count > 0 {
//            mJCLogger.log("Response:\(self.maintPlantListArray.count)", Type: "Debug")
//            dropDown.anchorView = self.maintenancePlantTextFieldView
//            let arr : [String] = self.maintPlantListArray as NSArray as! [String]
//            dropDown.dataSource = arr
//            dropDownSelectString = "maintenancePlant"
//            dropDown.show()
//        }
        mJCLogger.log("Ended", Type: "info")
       
    }
    
    
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.workOrderNumTextField.resignFirstResponder()
        self.operationTextField.resignFirstResponder()
        self.actionTypeTextField.resignFirstResponder()
        self.actualDurTextField.resignFirstResponder()
        self.confirmationTextTextField.resignFirstResponder()
        self.execStartDateTextField.resignFirstResponder()
        self.execStartTimeTextField.resignFirstResponder()
        self.execEndDateTextField.resignFirstResponder()
        self.execEndDateTextField.resignFirstResponder()
     
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Set Create Notification Data
    func setBasicData() {
        mJCLogger.log("Starting", Type: "info")

        workOrderNumTextField.text = selectedworkOrderNumber
        operationTextField.text = selectedOperationNumber
        
        self.setCurrentDateAndTime()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Set CurrentDate And Time..
    func setCurrentDateAndTime() {
        mJCLogger.log("Starting", Type: "info")
        let todaysDate : NSDate = NSDate()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let DateInFormat:String = dateFormatter.string(from: todaysDate as Date)
        
        execStartDateTextField.text = DateInFormat
        execStartDateTextField.isEnabled = false
        execStartDateTextField.textColor = UIColor.darkGray
        execEndDateTextField.text = DateInFormat
        execEndDateTextField.isEnabled = false
        execEndDateTextField.textColor = UIColor.darkGray
        
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: todaysDate as Date)
        
        execStartTimeTextField.text = timeString
        execStartTimeTextField.isEnabled = false
        execStartTimeTextField.textColor = UIColor.darkGray
        execEndTimeTextField.text = timeString
        execEndTimeTextField.isEnabled = false
        execEndTimeTextField.textColor = UIColor.darkGray
        
        mJCLogger.log("Ended", Type: "info")
        
    }
}
