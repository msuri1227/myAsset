//
//  EditNotificationViewController.swift
//  myJobCard
//
//  Created by Ruby's Mac on 17/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation
import MobileCoreServices


class ItemCauseCompleteVC : UIViewController,UITextFieldDelegate{
    
    @IBOutlet var notificationNumView: UIView!
    @IBOutlet var notificationNumTextFieldView: UIView!
    @IBOutlet var notificationNumTextField: UITextField!
    
    @IBOutlet var notificationDescrpView: UIView!
    @IBOutlet var notificationDescrpTextField: UITextField!
    @IBOutlet var notificationDescrpTextFieldView: UIView!
    
    @IBOutlet var malfunctionEndView: UIView!
    @IBOutlet var malfunctionEndDateTextField: UITextField!
    @IBOutlet var malfunctionEndDateTextFieldView: UIView!
    @IBOutlet var malfunctionEndDateButton: UIButton!
    
    @IBOutlet var malfunctionEndTimeTextField: UITextField!
    @IBOutlet var malfunctionEndTimeTextFieldView: UIView!
    @IBOutlet var malfunctionEndTimeButton: UIButton!
    
    @IBOutlet var personRespView: UIView!
    @IBOutlet var personRespTextField: UITextField!
    @IBOutlet var personRespTextFieldView: UIView!
    
    @IBOutlet var itemCodeGroupView: UIView!
    @IBOutlet var itemCodeGroupTextField: UITextField!
    @IBOutlet var itemCodeGroupdTextFieldView: UIView!
    @IBOutlet var itemCodeGroupButton: UIButton!
    
    @IBOutlet var itemCodeView: UIView!
    @IBOutlet var itemCodeTextFieldView: UIView!
    @IBOutlet var itemCodeTextField: UITextField!
    @IBOutlet var itemCodeButton: UIButton!
    
    @IBOutlet var itemPartGroupView: UIView!
    @IBOutlet var itemPartGroupTextField: UITextField!
    @IBOutlet var itemPartGroupTextFieldView: UIView!
    @IBOutlet var itemPartGroupButton: UIButton!
    
    @IBOutlet var itemPartView: UIView!
    @IBOutlet var itemPartTextFieldView: UIView!
    @IBOutlet var itemPartTextField: UITextField!
    @IBOutlet var itemPartButton: UIButton!
    
    @IBOutlet var causeCodeGroupView: UIView!
    @IBOutlet var causeCodeGroupTextField: UITextField!
    @IBOutlet var causeCodeGroupdTextFieldView: UIView!
    @IBOutlet var causeCodeGroupButton: UIButton!
    
    @IBOutlet var causeCodeView: UIView!
    @IBOutlet var causeCodeTextFieldView: UIView!
    @IBOutlet var causeCodeButton: UIButton!
    @IBOutlet var causeCodeTextField: UITextField!
    
    @IBOutlet var causeTextView: UIView!
    @IBOutlet var causeTextFieldView: UIView!
    @IBOutlet var causeTextField: UITextField!
    
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    var selectDateAndTime = NSString()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var notificationClass = NotificationModel()
    var causeClass = NotificationItemCauseModel()
    var itemClass = NotificationItemsModel()
    var itemCauseCompleteVMModel  = ItemCauseCompleteViewModel()
    var suspendViewModel = SuspendViewModel()
    var updateEntityArr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCauseCompleteVMModel.itemCauseCompleteVc = self
        itemCauseCompleteVMModel.getNotificationDetails()
        
        self.causeTextField.delegate = self
        self.notificationDescrpTextField.delegate = self
        
        ODSUIHelper.setBorderToView(view:self.notificationNumTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationDescrpTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionEndDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionEndTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.personRespTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemCodeGroupdTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemCodeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemPartGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemPartTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.causeCodeGroupdTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.causeCodeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.causeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "ItemCodeGroup" {
                self.itemCodeGroupTextField.text = item
                let arr = item.components(separatedBy: " - ")
                if arr.count > 0{
                    self.itemCauseCompleteVMModel.getItemCodeValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: arr[0])
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "itemCode" {
                self.itemCodeTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "PartGroup" {
                self.itemPartGroupTextField.text = item
                let arr = item.components(separatedBy: " - ")
                if arr.count > 0{
                    self.itemCauseCompleteVMModel.getItemPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: arr[0])
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Part" {
                self.itemPartTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "itemCauseGroup" {
                self.causeCodeGroupTextField.text = item
                let arr = item.components(separatedBy: " - ")
                if arr.count > 0{
                    self.itemCauseCompleteVMModel.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: arr[0])
                }
                self.dropDownSelectString = ""
            } else if self.dropDownSelectString == "causeCode" {
                self.causeCodeTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
    }
    
    @IBAction func malFunctionEndDateButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "MalfunctionEndDate"
        
        let malFuncStartDate = ODSDateHelper.convertDateToString(date: notificationClass.MalfunctStart!)
        let malFromDateStr = ODSDateHelper.getDateFromString(dateString: malFuncStartDate, dateFormat: localDateFormate)
        ODSPicker.selectDate(title: "Select_Malfunction_End_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: malFromDateStr, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            self?.malfunctionEndDateTextField.text = selectedDate.dateString(localDateFormate)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func malfunctionEndTimeAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("MalfunctionEndTimeButtonAction".localized(), Type: "")
        
        selectDateAndTime = "MalfunctionEndTime"
        ODSPicker.selectDate(title: "Select_Malfunction_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
            self?.malfunctionEndTimeTextField.text = selectedDate.dateString(localTimeFormat)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemCodeGroupButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseCompleteVMModel.itemCodeGroupListArray.count > 0 {
            dropDown.anchorView = self.itemCodeGroupdTextFieldView
            let damageGroupList = itemCauseCompleteVMModel.itemCodeGroupListArray
            let arr : [String] = damageGroupList as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "ItemCodeGroup"
            dropDown.show()
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemCodeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseCompleteVMModel.itemCodeListArray.count > 0 {
            dropDown.anchorView = self.itemCodeTextFieldView
            let damageList = itemCauseCompleteVMModel.itemCodeListArray
            let arr : [String] = damageList as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "itemCode"
            dropDown.show()
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemPartGroupButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseCompleteVMModel.partGroupListArray.count > 0 {
            dropDown.anchorView = self.itemPartGroupTextFieldView
            let partGroupList = itemCauseCompleteVMModel.partGroupListArray
            let arr : [String] = partGroupList as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "PartGroup"
            dropDown.show()
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemPartButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseCompleteVMModel.partListArray.count > 0 {
            dropDown.anchorView = self.itemPartTextFieldView
            let partList = itemCauseCompleteVMModel.partListArray
            let arr : [String] = partList as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "Part"
            dropDown.show()
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func causeCodeGroupButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseCompleteVMModel.itemCauseCodeGroupListArray.count > 0 {
            dropDown.anchorView = self.causeCodeGroupdTextFieldView
            let taskGroupList = itemCauseCompleteVMModel.itemCauseCodeGroupListArray
            let arr : [String] = taskGroupList as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "itemCauseGroup"
            dropDown.show()
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func causeCodeButtionAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseCompleteVMModel.itemCauseCodeListArray.count > 0 {
            dropDown.anchorView = self.causeCodeTextField
            let taskList = itemCauseCompleteVMModel.itemCauseCodeListArray
            if let arr : [String] = taskList as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDownSelectString = "causeCode"
                dropDown.show()
            }
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func canceButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.suspendViewModel.suspendVc?.dismissViewController()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.itemCauseCompleteVMModel.updateNotifcation()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        itemCauseCompleteVMModel.getNotificationDetails()
        self.personRespTextField.text = ""
    }
    @IBAction func backButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    
    func setBasicData(){
        DispatchQueue.main.async {
            self.notificationNumTextField.isUserInteractionEnabled = false
            self.notificationDescrpTextField.isUserInteractionEnabled = true
            self.personRespTextField.isUserInteractionEnabled = true
            self.notificationNumTextField.text = self.notificationClass.Notification
            self.notificationDescrpTextField.text = self.notificationClass.ShortText
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        let maxLength = 40
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == self.causeTextField {
            if newString.length > maxLength {
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Cause_Text_length_should_not_be_more_than_40_characters".localized(), button: okay)
                return newString.length <= maxLength
            }
        }else if textField == self.notificationDescrpTextField{
            if newString.length > maxLength {
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                return newString.length <= maxLength
            }
        }
        return true
    }
}
