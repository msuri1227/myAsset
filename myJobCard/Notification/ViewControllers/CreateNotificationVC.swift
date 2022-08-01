//
//  CreateNotificationVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/9/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import MobileCoreServices
import ODSFoundation
import mJCLib

class CreateNotificationVC: UIViewController,UITextViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,barcodeDelegate,personResponsibleDelegate,FuncLocEquipSelectDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var createNotificationHeaderLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var doneButton: UIButton!

    // MainView Outlets..
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainScrollview: UIScrollView!
    @IBOutlet var scrollViewContainerView: UIView!


    // NotificationTypeMainView Outlets..
    @IBOutlet var notificationTypeView: UIView!
    @IBOutlet var notificationTypeTitleLabel: UILabel!
    @IBOutlet var notificationTypeTextFieldView: UIView!
    @IBOutlet var notificationTypeTextField: iOSDropDown!
    @IBOutlet var notificationTypeButton: UIButton!

    // DescriptionView Outlets..
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextFieldView: UIView!
    @IBOutlet var descriptionTextField: UITextField!

    // PriorityView Outlets..
    @IBOutlet var priorityView: UIView!
    @IBOutlet var priorityTitleLabel: UILabel!
    @IBOutlet var priorityTextFieldView: UIView!
    @IBOutlet var priorityTextField: iOSDropDown!
    @IBOutlet var priorityButton: UIButton!

    // MaintenancePlantView Outlets..
    @IBOutlet var maintenancePlantView: UIView!
    @IBOutlet var maintenancePlantTitleLabel: UILabel!
    @IBOutlet var maintenancePlantTextFieldView: UIView!
    @IBOutlet var maintenancePlantTextField: iOSDropDown!
    @IBOutlet var maintenancePlantButton: UIButton!
    // WorkCenter Outlets..
    @IBOutlet weak var mainWorkCenterView: UIView!
    @IBOutlet var mainWorkCenterTitleLabel: UILabel!
    @IBOutlet weak var mainWorkCenterTextFieldView: UIView!
    @IBOutlet weak var mainWorkCenterTextField: iOSDropDown!
    @IBOutlet weak var mainWorkCenterButton: UIButton!

    @IBOutlet var personResponsibleView: UIView!
    @IBOutlet var personResponsibleTitleLabel: UILabel!
    @IBOutlet var personResponsibleTextFieldView: UIView!
    @IBOutlet var personResponsibleTextField: UITextField!
    @IBOutlet var personResponsibleButton: UIButton!

    @IBOutlet var standardTextView: UIView!
    @IBOutlet var standardTextTitleLabel: UILabel!
    @IBOutlet var standardTextFieldView: UIView!
    @IBOutlet var standardTextField: iOSDropDown!
    @IBOutlet var standardTextbutton: UIButton!

    // NotificationDateMainView Outlets..
    @IBOutlet var notificationDateView: UIView!
    @IBOutlet var notificationDateTitleLabel: UILabel!
    @IBOutlet var notificationDateTextFieldView: UIView!
    @IBOutlet var notificationDateTextField: UITextField!
    @IBOutlet var notificationDateButton: UIButton!

    @IBOutlet var notificationTimeTextFieldView: UIView!
    @IBOutlet var notificationTimeTextField: UITextField!
    @IBOutlet var notificationTimeButton: UIButton!

    // FunctionalLocationView Outlets..
    @IBOutlet var functionalLocationView: UIView!
    @IBOutlet var functionalLocationTitleLabel: UILabel!
    @IBOutlet var functionalLocationTextFieldView: UIView!
    @IBOutlet var functionalLocationTextField: UITextField!
    @IBOutlet var functionalLocationScanQRButton: UIButton!
    @IBOutlet var functionalLocationButton: UIButton!

    // EquipmentView Outlets..
    @IBOutlet var equipmentView: UIView!
    @IBOutlet var equipmentTitleLabel: UILabel!
    @IBOutlet var equipmentTextFieldView: UIView!
    @IBOutlet var equipmentTextField: UITextField!
    @IBOutlet var equipmentButton: UIButton!
    @IBOutlet var equipmentScanQRButton: UIButton!

    // Equipment Warrenty Info Label Outlet
    @IBOutlet weak var equipWarrantyInfoLabel: UILabel!
    @IBOutlet weak var equipmentWarrantyView: UIView!
    @IBOutlet weak var equipmentWarrantyImageView: UIImageView!

    // BothSwitchView Outlets..
    @IBOutlet var bothSwitchView: UIView!
    @IBOutlet var breakdownInnerView: UIView!
    @IBOutlet var bothSwitchTittleLabel: UILabel!
    @IBOutlet var breakdownSwitch: UISwitch!

    //Malfunction Start Outlets..
    @IBOutlet weak var malfunctionStartDateView: UIView!
    @IBOutlet weak var malfunctionStartDateTitleLabel: UILabel!
    @IBOutlet weak var malfunctionStartDateTextFieldView: UIView!
    @IBOutlet weak var malfunctionStartDateTextField: UITextField!
    @IBOutlet weak var malfunctionStartDateButton: UIButton!

    @IBOutlet weak var malfunctionStartTimeTextFieldView: UIView!
    @IBOutlet weak var malfunctionStartTimeTextField: UITextField!
    @IBOutlet weak var malfunctionStartTimeButton: UIButton!

    //Malfunction End Outlets..
    @IBOutlet weak var malfunctionEndDateView: UIView!
    @IBOutlet weak var malfunctionEndDateTitleLabel: UILabel!
    @IBOutlet weak var malfunctionEndDateTextFieldView: UIView!
    @IBOutlet weak var malfunctionEndDateTextField: UITextField!
    @IBOutlet weak var malfunctionEndDateButton: UIButton!

    @IBOutlet weak var malfunctionEndTimeTextFieldView: UIView!
    @IBOutlet weak var malfunctionEndTimeTextField: UITextField!
    @IBOutlet weak var malfunctionEndTimeButton: UIButton!

    // Reportedby
    @IBOutlet var reportedByView: UIView!
    @IBOutlet var reportedByTitleLabel: UILabel!
    @IBOutlet var reportedByTextFieldView: UIView!
    @IBOutlet var reportedByTextField: UITextField!
    @IBOutlet var reportedByButton: UIButton!

    // NoteView Outlets..
    @IBOutlet var noteView: UIView!
    @IBOutlet var noteTitleLabel: UILabel!
    @IBOutlet var noteTextFieldView: UIView!
    @IBOutlet var noteTextView: UITextView!

    // FooterButtonView Outlets..
    @IBOutlet var footerButtonView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var refreshButton: UIButton!

    @IBOutlet weak var checkOnlineNotificationsButton: UIButton!

    //MARK:- Declared Variables..
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var breakDownSwitchState = Bool()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var isFromEdit = Bool()
    var isFromWorkOrder = Bool()
    var isFromError = Bool()
    var errorNotifiation = NotificationModel()
    var maintPlantArray = [MaintencePlantModel]()
    var maintPlantListArray = [String]()
    var notificationClass = NotificationModel()
    var errorNOtification = WoHeaderModel()
    var notificationType = String()
    var notifTypeArray = [NotificationTypeModel]()
    var notificationTypeListArray = [String]()
    var property = NSMutableArray()
    var priorityArray = [PriorityListModel]()
    var priorityListArray = [String]()
    var workCentersArray = [WorkCenterModel]()
    var workCentersListArray = [String]()
    var typeOfScanCode = String()
    var selectedPlant = String()
    var selectedMainWorkCenter = String()
    var selectDateAndTime = NSString()
    var standardTextNameArray = [String]()
    var StandardTextArray = [StandardTextModel]()
    var createUpdateDelegate:CreateUpdateDelegate?
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")
        self.updateUI()
        //get data..
        self.getPriorityList()
        self.getNotificationType()
        self.getMaintPlantList()
        self.getStandardText()
        //set TapGesture..
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateNotificationVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
//        notificationTypeTextField.isEnabled = false
//        priorityTextField.isEnabled = false
//        functionalLocationTextField.isEnabled = false
//        equipmentTextField.isEnabled = false
//        maintenancePlantTextField.isEnabled = false
        functionalLocationTextField.textColor = UIColor.darkGray
        equipmentTextField.textColor = UIColor.darkGray
        self.standardTextField.delegate = self
        if isFromEdit == true {
            self.checkOnlineNotificationsButton.isHidden = true
            self.standardTextView.isHidden = true
            if DeviceType == iPad {
                self.createNotificationHeaderLabel.text = "Edit_Notification".localized() + " \(selectedNotificationNumber)"
            }else {
                self.createNotificationHeaderLabel.font = self.createNotificationHeaderLabel.font.withSize(15)
                self.createNotificationHeaderLabel.text = "Edit_Notification".localized() +  " \(selectedNotificationNumber)"
            }
            if DeviceType == iPad {
                self.createNotificationHeaderLabel.text = "Edit_Notification".localized() + "\(selectedNotificationNumber)"
            }else {
                self.createNotificationHeaderLabel.font = self.createNotificationHeaderLabel.font.withSize(15)
                self.createNotificationHeaderLabel.text = "Edit_Notification".localized() +  "\(selectedNotificationNumber)"
            }
            self.setNotificationEditData()
        }else {
            self.standardTextView.isHidden = false
            self.checkOnlineNotificationsButton.isHidden = false
            self.createNotificationHeaderLabel.text = "Create_Notification".localized()
            self.setNotificationCreateData()
        }
        if isFromWorkOrder == true {
            let priArry = self.priorityArray.filter{$0.Priority == singleWorkOrder.Priority}
            if priArry.count > 0{
                let priCls = priArry[0]
                self.priorityTextField.text = "\(priCls.PriorityText)"
            }
            self.equipmentTextField.text = singleWorkOrder.EquipNum
            self.functionalLocationTextField.text = singleWorkOrder.FuncLocation
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "notificationType" {
                self.notificationTypeTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Priority" {
                self.priorityTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "maintenancePlant" {
                self.maintenancePlantTextField.text = item
                self.dropDownSelectString = ""
                self.getWorkCentersList()
            }else if self.dropDownSelectString == "WorkCentersDropDown" {
                self.mainWorkCenterTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "standardTextdDropDown"{
                self.standardTextField.text = item
                if item == selectStr{
                    self.noteTextView.text = ""
                }else{
                    self.standardTextNameArray.remove(at: 0)
                    if let index =  self.standardTextNameArray.firstIndex(of: item){
                        let replacedText = self.StandardTextArray[index].LongText.replacingOccurrences(of: "\nL ", with: "\n")
                        self.noteTextView.text = replacedText
                    }
                }
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        self.noteTextView.isUserInteractionEnabled = true
        if onlineSearch {
            self.noteTextView.isUserInteractionEnabled = false
        }
        
        //Notification type
        self.notificationTypeTextField.didSelect { selectedText, index, id in
            self.notificationTypeTextField.text = selectedText
        }
        
        //Priority
        self.priorityTextField.didSelect { selectedText, index, id in
            self.priorityTextField.text = selectedText
        }
        
        //Maintenance plant
        self.maintenancePlantTextField.didSelect { selectedText, index, id in
            self.maintenancePlantTextField.text = selectedText
            self.getWorkCentersList()
        }
        
        //Main workcenter
        self.mainWorkCenterTextField.didSelect { selectedText, index, id in
            self.mainWorkCenterTextField.text = selectedText
        }
        
        //Standard text
        self.standardTextField.didSelect { selectedText, index, id in
            self.standardTextField.text = selectedText
            if selectedText == selectStr{
                self.noteTextView.text = ""
            }else{
                self.standardTextNameArray.remove(at: 0)
                if let index =  self.standardTextNameArray.firstIndex(of: selectedText){
                    let replacedText = self.StandardTextArray[index].LongText.replacingOccurrences(of: "\nL ", with: "\n")
                    self.noteTextView.text = replacedText
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUI(){

        ODSUIHelper.setBorderToView(view:self.notificationDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.functionalLocationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.equipmentTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.priorityTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.maintenancePlantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.standardTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.noteTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionStartDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionStartTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionEndDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionEndTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.mainWorkCenterTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.breakdownInnerView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if  NOTIFICATION_ASSIGNMENT_TYPE == "2"{
            self.personResponsibleView.isHidden = true
        }
        self.descriptionTextField.delegate = self
        self.malfunctionStartDateView.isHidden = true
        self.malfunctionEndDateView.isHidden = true
        self.equipmentWarrantyView.isHidden = true

    }
    open override var shouldAutorotate: Bool {
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func FuncLocOrEquipSelected(selectedObj: String, EquipObj: EquipmentModel, FuncObj:FunctionalLocationModel) {
        mJCLogger.log("Starting", Type: "info")
        if selectedObj == "Equipment"{
            self.functionalLocationTextField.text = EquipObj.FuncLocation
            self.equipmentTextField.text = EquipObj.Equipment
        }else if selectedObj == "FunctionalLocation"{
            self.functionalLocationTextField.text = FuncObj.FunctionalLoc
            self.equipmentTextField.text = EquipObj.Equipment
        }
        if EquipObj.Equipment != ""{
            self.equipWarrantyInfoLabel.text = myAssetDataManager.uniqueInstance.getEquipmentWarrantyInfo(EquipObj: EquipObj)
            equipmentWarrantyView.isHidden = false
            equipmentWarrantyImageView.isHidden = false
            equipmentWarrantyImageView.image = UIImage(named: "history_pending")
        }else{
            equipWarrantyInfoLabel.text = ""
            equipmentWarrantyImageView.isHidden = true
            equipmentWarrantyView.isHidden = true
        }
        if ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO == true{
            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
            if result == "ServerUp"{
                if self.equipmentTextField.text != "" {
                    if self.functionalLocationTextField.text == "" {
                        DispatchQueue.main.async {
                            let params = Parameters(
                                title: MessageTitle,
                                message: "Functional_Location_is_not_available_for_this_Equipment".localized(),
                                cancelButton: okay
                            )
                            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                switch buttonIndex {
                                case 0:
                                    mJCLogger.log("Functional_Location_is_not_available_for_this_Equipment".localized(), Type: "Debug")
                                    self.showOnlineSearchPopUp(searchType:"Notifications")
                                    
                                default: break
                                }
                            }
                        }
                    }else{
                        self.showOnlineSearchPopUp(searchType:"Notifications")
                    }
                }else if self.functionalLocationTextField.text != "" {
                    self.showOnlineSearchPopUp(searchType:"Notifications")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        if textField == descriptionTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Description_length_should_not_be_more_than_40_characters".localized() , button: okay)
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    
    //MARK:- Notificatio Field Button Action..
    @IBAction func functionalLocationButtonAction(sender: AnyObject) {
        var workCenterStr : String? = ""
        var planningPlantStr : String? = ""
        if self.mainWorkCenterTextField.text != "" || self.maintenancePlantTextField.text != nil {
            workCenterStr = self.mainWorkCenterTextField.text
            planningPlantStr = self.maintenancePlantTextField.text
        }
        menuDataModel.uniqueInstance.presentFlocEquipHierarchyScreen(vc: self, select: "FunctionalLocation", delegateVC: self, workCenter: workCenterStr, maintenancePlant: planningPlantStr)
    }
    
    @IBAction func functionalLocationScanQRButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Floc", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentScanQRButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Equip", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentButtonAction(sender: AnyObject) {
        var workCenterStr : String? = ""
        var planningPlantStr : String? = ""
        if self.mainWorkCenterTextField.text != "" || self.maintenancePlantTextField.text != nil {
            workCenterStr = self.mainWorkCenterTextField.text
            planningPlantStr = self.maintenancePlantTextField.text
        }
        menuDataModel.uniqueInstance.presentFlocEquipHierarchyScreen(vc: self, select: "Equipement", delegateVC: self, workCenter: workCenterStr, selectedFuncLoc: functionalLocationTextField.text, maintenancePlant: planningPlantStr)
    }
    @IBAction func notificationTimeButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "NotificationTime"
        
        ODSPicker.selectDate(title: "Select_Notification_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
            self?.notificationTimeTextField.text = selectedDate.dateString(localTimeFormat)
        })
        mJCLogger.log("Notification Time Button Tapped".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func notificationDateButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "NotificationDate"
        
        ODSPicker.selectDate(title: "Select_Notification_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            self?.notificationDateTextField.text = selectedDate.dateString(localDateFormate)
        })
        mJCLogger.log("Notification Date Button Tapped".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    func setMandatoryFields(){
        self.personResponsibleView.isHidden = true
        self.reportedByView.isHidden = true
        myAssetDataManager.setMandatoryLabel(label: self.descriptionTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.malfunctionEndDateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.mainWorkCenterTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.equipmentTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.functionalLocationTitleLabel)
    }
    //MARK:- Footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if breakDownSwitchState == true{
            let malfuncStartDateString = malfunctionStartDateTextField.text! + " " + malfunctionStartTimeTextField.text!
            let malfuncEndDateString = malfunctionEndDateTextField.text! + " " + malfunctionEndTimeTextField.text!
            let malfuncBasicDate = ODSDateHelper.getDateFromString(dateString: malfuncStartDateString, dateFormat: localDateTimeFormate)
            let malfuncDueDate = ODSDateHelper.getDateFromString(dateString: malfuncEndDateString, dateFormat: localDateTimeFormate)
            if malfuncDueDate < malfuncBasicDate {
                mJCLogger.log("Malfunction_Start_date_can't_fall_after_finish".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Malfunction_Start_date_can't_fall_after_finish".localized(), button: okay)
                return
            }
            if malfunctionEndDateTextField.text == "" {
                mJCLogger.log("Please_select_malfunction_end_date_and_time".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_malfunction_end_date_and_time".localized(), button: okay)
                return
            }else if malfunctionEndTimeTextField.text == "" {
                mJCLogger.log("Please_select_malfunction_end_date_and_time".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_malfunction_end_date_and_time".localized(), button: okay)
                return
            }
        }
        if self.mainWorkCenterTextField.text == "" {
            mJCLogger.log(WorkCenterAlert, Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: WorkCenterAlert, button: okay)
            return
        }
        if descriptionTextField.text == "" {
            mJCLogger.log("Please_enter_description".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_description".localized(), button: okay)
            return
        }else if equipmentTextField.text == "" && self.functionalLocationTextField.text == "" && self.isFromEdit == false{
            mJCLogger.log("Please_Add_Equipment".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Add_Equipment".localized(), button: okay)
            return
        }else {
            if isFromEdit == true {
                self.allTextFieldResign()
                if onlineSearch {
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    DispatchQueue.main.asyncAfter(deadline:.now() + 1.0) {
                        self.editOnlineNotification()
                    }
                }else {
                    if self.isFromError == true{
                        self.updateErrorNotification()
                    }else{
                        self.updateNotification()
                    }
                }
            }else {
                self.createNotification()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.isFromEdit == true {
            setNotificationEditData()
            if self.notificationClass.Priority == "" {
                if priorityListArray.count > 0{
                    self.priorityTextField.text = self.priorityListArray[0]
                }
            }else {
                let filteredArray = self.priorityArray.filter{$0.Priority == self.notificationClass.Priority}
                if filteredArray.count != 0 {
                    mJCLogger.log("Response:\(filteredArray[0])", Type: "Debug")
                    let priorityClass = filteredArray[0]
                    self.priorityTextField.text = priorityClass.PriorityText
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            let filteredArray = self.notifTypeArray.filter{$0.NotifictnType == "\(self.notificationClass.NotificationType)"}
            if filteredArray.count != 0 {
                mJCLogger.log("Response:\(filteredArray[0])", Type: "Debug")
                let notificationClass = filteredArray[0]
                self.notificationTypeTextField.text = notificationClass.NotifictnType + " - " + notificationClass.NotificationTypeText
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else {
            if notificationTypeListArray.count > 0{
                self.notificationTypeTextField.text = self.notificationTypeListArray[0]
                self.setCurrentDateAndTime()
                self.descriptionTextField.text = ""
                self.functionalLocationTextField.text = ""
                self.equipmentTextField.text = ""
                self.priorityTextField.text = self.priorityListArray[0]
                self.maintenancePlantTextField.text = self.maintPlantListArray[0]
                self.noteTextView.text = ""
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Switch Action..
    @IBAction func breakdownSwitchAction(sender: UISwitch) {
        mJCLogger.log("Starting", Type: "info")
        if sender.isOn == true {
            breakDownSwitchState = true
            self.malfunctionStartDateView.isHidden = false
            self.malfunctionEndDateView.isHidden = false
            let today = Date()
            let calendar = NSCalendar.current
            self.malfunctionStartDateTextField.text = today.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.malfunctionStartTimeTextField.text = today.toString(format: .custom("HH:mm"))
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today as Date)
            let tomorrowDate =  calendar.date(byAdding: .minute, value: 1, to: tomorrow!)
            self.malfunctionEndDateTextField.text = tomorrowDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.malfunctionEndTimeTextField.text = tomorrowDate?.toString(format: .custom("HH:mm"))
        }else {
            breakDownSwitchState = false
            self.malfunctionStartDateView.isHidden = true
            self.malfunctionEndDateView.isHidden = true
        }
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func personalResponsibleButtonAction(_ sender: Any) {
        allTextFieldResign()
        menuDataModel.uniqueInstance.presentPersonResponsibleListScreen(vc: self, isFrm: "planner", delegateVC: self)
    }
    @IBAction func reportedyButtonAction(sender: AnyObject) {
        menuDataModel.uniqueInstance.presentPersonResponsibleListScreen(vc: self, isFrm: "reportedBy", delegateVC: self)
    }
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        mJCLogger.log("Starting", Type: "info")
        if respType == "reportedBy"{
            self.reportedByTextField.text = result
        }else if respType == "planner"{
            self.personResponsibleTextField.text = result
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setPersonResponsible() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            let personRespArray = globalPersonRespArray.filter{$0.PersonnelNo == "\(userPersonnelNo)"}
            if personRespArray.count > 0{
                let personRes = personRespArray[0]
                self.personResponsibleTextField.text = personRes.SystemID + " - " + personRes.EmplApplName
            }else{
                if globalPersonRespArray.count > 0{
                    let personRes = globalPersonRespArray[0]
                    self.personResponsibleTextField.text = personRes.SystemID + " - " + personRes.EmplApplName
                }else{
                    self.personResponsibleTextField.text = ""
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setReportedBy(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            let personRespArray = globalPersonRespArray.filter{$0.PersonnelNo == "\(userPersonnelNo)"}
            if personRespArray.count > 0{
                let personRes = personRespArray[0]
                self.reportedByTextField.text = personRes.SystemID + " - " + personRes.EmplApplName
            }else{
                if globalPersonRespArray.count > 0{
                    let personRes = globalPersonRespArray[0]
                    self.reportedByTextField.text = personRes.SystemID + " - " + personRes.EmplApplName
                }else{
                    self.reportedByTextField.text = ""
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Notificatio Type..
    func getNotificationType()  {
        mJCLogger.log("Starting", Type: "info")
        self.notifTypeArray.removeAll()
        self.notifTypeArray = notificationTypeArray
        mJCLogger.log("Response:\(self.notifTypeArray.count)", Type: "Debug")
        for item in self.notifTypeArray {
            self.notificationTypeListArray.append(item.NotifictnType + " - " + item.NotificationTypeText)
            if self.isFromEdit == true && self.isFromError == true{
                if item.NotifictnType == self.errorNotifiation.NotificationType {
                    self.notificationTypeTextField.text = item.NotifictnType + " - " + item.NotificationTypeText
                }
            }else if self.isFromEdit == true {
                if item.NotifictnType == self.notificationClass.NotificationType {
                    self.notificationTypeTextField.text = item.NotifictnType + " - " + item.NotificationTypeText
                }
            }
        }
        
        if self.notificationTypeListArray.count > 0{
            DispatchQueue.main.async {
                self.notificationTypeTextField.optionArray = self.notificationTypeListArray
                self.notificationTypeTextField.checkMarkEnabled = false
            }
        }
        if self.isFromEdit == false {
            if self.notificationTypeListArray.count > 0 {
                mJCLogger.log("Response:\(self.notificationTypeListArray[0])", Type: "Debug")
                self.notificationTypeTextField.text = self.notificationTypeListArray[0]
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get PriorityList..
    func getPriorityList()  {
        mJCLogger.log("Starting", Type: "info")
        
        self.priorityArray.removeAll()
        self.priorityListArray.removeAll()
        if globalPriorityArray.count > 0 {
            mJCLogger.log("Response:\(globalPriorityArray.count)", Type: "Debug")
            self.priorityArray =  globalPriorityArray
            for item in self.priorityArray {
                self.priorityListArray.append(item.PriorityText)
                if self.isFromEdit == true && self.isFromError == true{
                    if item.Priority == self.errorNotifiation.Priority {
                        self.priorityTextField.text = item.PriorityText
                    }
                }
                if self.isFromEdit == true {
                    if item.Priority == self.notificationClass.Priority {
                        self.priorityTextField.text = item.PriorityText
                    }
                }
            }
            if self.priorityListArray.count > 0{
                DispatchQueue.main.async {
                    self.priorityTextField.optionArray = self.priorityListArray
                    self.priorityTextField.checkMarkEnabled = false
                }
            }
            if self.isFromEdit == false {
                if priorityListArray.count > 0{
                self.priorityTextField.text = self.priorityListArray[0]
                }
            } else {
                if self.notificationClass.Priority == "" {
                    if priorityListArray.count > 0{
                    self.priorityTextField.text = self.priorityListArray[0]
                    }
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Plant Data..
    func getMaintPlantList()  {
        mJCLogger.log("Starting", Type: "info")
        self.maintPlantArray.removeAll()
        self.maintPlantListArray.removeAll()
        if globalPlanningPlantArray.count > 0 {
            mJCLogger.log("Response:\(globalPlanningPlantArray.count)", Type: "Debug")
            self.maintPlantArray = globalPlanningPlantArray
            for item in self.maintPlantArray {
                self.maintPlantListArray.append("\(item.Plant) - \(item.Name1)")
                if self.isFromEdit == true && self.isFromError == true{
                    if item.Plant == self.errorNotifiation.MaintPlant {
                        self.maintenancePlantTextField.text = "\(item.Plant) - \(item.Name1)"
                        break
                    }
                }
                if self.isFromEdit == true {
                    if item.Plant == self.notificationClass.MaintPlant {
                        self.maintenancePlantTextField.text = "\(item.Plant) - \(item.Name1)"
                        break
                    }
                }
            }
            if self.maintPlantListArray.count > 0{
                DispatchQueue.main.async {
                    self.maintenancePlantTextField.optionArray = self.maintPlantListArray
                    self.maintenancePlantTextField.checkMarkEnabled = false
                }
            }
            if self.isFromEdit == false {
                var isSetPlant = false
                for i in 0..<self.maintPlantListArray.count{
                    if isSetPlant == false {
                        let str = self.maintPlantListArray[i]
                        if str.range(of: userPlant) != nil{
                            self.maintenancePlantTextField.text = self.maintPlantListArray[i]
                            isSetPlant = true
                        }
                    }
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        if self.mainWorkCenterView.isHidden != true{
            self.getWorkCentersList()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //    MARK:- Get WorkCenters List..
    func getWorkCentersList() {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersArray.removeAll()
        if globalWorkCtrArray.count > 0 {
            mJCLogger.log("Response:\(globalWorkCtrArray.count)", Type: "Debug")
            workCentersArray.append(contentsOf: globalWorkCtrArray)
            self.setWorkCenterValue()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get standarded text ..
    func getStandardText() {
        mJCLogger.log("Starting", Type: "info")
        StandardTextModel.getStandardText(){ (response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [StandardTextModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.StandardTextArray =  responseArr
                    DispatchQueue.main.async {
                        self.standardTextField.text = selectStr
                    }
                    
                    self.standardTextNameArray.removeAll()
                    self.standardTextNameArray.append(selectStr)
                    for i in 0..<self.StandardTextArray.count{
                        self.standardTextNameArray.append(self.StandardTextArray[i].StandardTextName)
                    }
                    
                    if self.standardTextNameArray.count > 0{
                        DispatchQueue.main.async {
                            self.standardTextField.optionArray = self.standardTextNameArray
                            self.standardTextField.checkMarkEnabled = false
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkCenterValue()  {
        
        mJCLogger.log("Starting", Type: "info")
        self.workCentersListArray.removeAll()
        DispatchQueue.main.async {
            var plant = String()
            if self.maintenancePlantTextField.text != ""{
                let arr = self.maintenancePlantTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    mJCLogger.log("Response:\(arr.count)", Type: "Debug")
                    plant = (arr[0])
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                let filteredArray = self.workCentersArray.filter{$0.Plant == "\(plant)"}
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
            if self.workCentersListArray.count > 0{
                DispatchQueue.main.async {
                    self.mainWorkCenterTextField.optionArray = self.workCentersListArray
                    self.mainWorkCenterTextField.checkMarkEnabled = false
                }
            }
            var workCenterStr = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                workCenterStr = self.errorNOtification.MainWorkCtr
            }else  if self.isFromEdit == true {
                workCenterStr = self.notificationClass.MainWorkCenter
            }else if self.isFromEdit == false {
                workCenterStr = self.notificationClass.MainWorkCenter
            }
            if workCenterStr == "" && self.workCentersListArray.count > 0{
                mJCLogger.log("Response:\(self.workCentersListArray.count)", Type: "Debug")
                let filterArr = self.workCentersArray.filter{$0.WorkCenter == userWorkcenter}
                if filterArr.count > 0{
                    let cls = filterArr[0]
                    self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                }
            }else if self.workCentersListArray.count > 0{
                mJCLogger.log("Response:\(self.workCentersListArray.count)", Type: "Debug")
                let filterArr = self.workCentersArray.filter{$0.ObjectID == workCenterStr}
                if filterArr.count > 0{
                    let cls = filterArr[0]
                    self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                }
            }else{
                self.mainWorkCenterTextField.text = ""
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Set Create & Edit Notification Data..
    func setNotificationEditData() {
        mJCLogger.log("Starting", Type: "info")
        if isFromError == true && isFromEdit == true{
            notificationTypeButton.isUserInteractionEnabled = true
            notificationDateButton.isUserInteractionEnabled = true
            notificationTimeButton.isUserInteractionEnabled = true
            functionalLocationButton.isUserInteractionEnabled = true
            functionalLocationScanQRButton.isUserInteractionEnabled = true
            equipmentButton.isUserInteractionEnabled = true
            equipmentScanQRButton.isUserInteractionEnabled = true
            maintenancePlantButton.isUserInteractionEnabled = true
            mainWorkCenterButton.isUserInteractionEnabled = true
            if errorNotifiation.NotifDate != nil{
                notificationDateTextField.text = errorNotifiation.NotifDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                notificationDateTextField.text = ""
            }
            notificationTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorNotifiation.NotifTime)
            descriptionTextField.text = errorNotifiation.ShortText
            functionalLocationTextField.text = errorNotifiation.FunctionalLoc
            equipmentTextField.text = errorNotifiation.Equipment
            noteView.isHidden = true
            if errorNotifiation.Breakdown == "X" || errorNotifiation.Breakdown == "x" {
                self.breakdownSwitch.setOn(true, animated: true)
                self.breakDownSwitchState = true
                self.malfunctionStartDateView.isHidden = false
                self.malfunctionEndDateView.isHidden = false
            }else {
                self.breakdownSwitch.setOn(false, animated: true)
                self.breakDownSwitchState = false
                self.malfunctionStartDateView.isHidden = true
                self.malfunctionEndDateView.isHidden = true
            }
            self.functionalLocationButton.isUserInteractionEnabled = true
            self.equipmentButton.isUserInteractionEnabled = true
        }else{
            notificationTypeTextField.isUserInteractionEnabled = false
            notificationDateButton.isUserInteractionEnabled = false
            notificationTimeButton.isUserInteractionEnabled = false
            functionalLocationButton.isUserInteractionEnabled = false
            functionalLocationScanQRButton.isUserInteractionEnabled = false
            equipmentButton.isUserInteractionEnabled = false
            equipmentScanQRButton.isUserInteractionEnabled = false
            maintenancePlantTextField.isUserInteractionEnabled = false
            mainWorkCenterTextField.isUserInteractionEnabled = false
            if notificationClass.NotifDate != nil{
                notificationDateTextField.text = notificationClass.NotifDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                notificationDateTextField.text = ""
            }
            notificationTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notificationClass.NotifTime)
            descriptionTextField.text = notificationClass.ShortText
            functionalLocationTextField.text = notificationClass.FunctionalLoc
            equipmentTextField.text = notificationClass.Equipment
            noteView.isHidden = true
            if notificationClass.Breakdown == "X" || notificationClass.Breakdown == "x" {
                self.breakdownSwitch.setOn(true, animated: true)
                self.breakDownSwitchState = true
                self.malfunctionStartDateView.isHidden = false
                self.malfunctionEndDateView.isHidden = false
                if notificationClass.MalfunctStart != nil{
                    malfunctionStartDateTextField.text = notificationClass.MalfunctStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    malfunctionStartDateTextField.text = ""
                }
                malfunctionStartTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notificationClass.MalFunctStartTime)
                if notificationClass.MalfunctEnd != nil{
                    malfunctionEndDateTextField.text = notificationClass.MalfunctEnd!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    malfunctionEndDateTextField.text = ""
                }
                malfunctionEndTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notificationClass.MalfunctEndTime)
            }else {
                self.breakdownSwitch.setOn(false, animated: true)
                self.breakDownSwitchState = false
                self.malfunctionStartDateView.isHidden = true
                self.malfunctionEndDateView.isHidden = true
            }
            if self.functionalLocationTextField.text == "" && self.equipmentTextField.text == "" {
                //   self.functionalLocationButton.isUserInteractionEnabled = true
                //   self.equipmentButton.isUserInteractionEnabled = true
                //   self.equipmentScanQRButton.isUserInteractionEnabled = true
                //   self.functionalLocationScanQRButton.isUserInteractionEnabled = true
            }else if equipmentTextField.text != "" && self.functionalLocationTextField.text == "" {
                //  self.functionalLocationButton.isUserInteractionEnabled = false
                //  self.equipmentButton.isUserInteractionEnabled = false
                //  self.equipmentScanQRButton.isHidden = true
                //  self.functionalLocationScanQRButton.isHidden = true
            }else if self.functionalLocationTextField.text != "" && self.equipmentTextField.text == "" {
                //   self.functionalLocationButton.isUserInteractionEnabled = true
                //   self.equipmentButton.isUserInteractionEnabled = true
                //   self.equipmentScanQRButton.isUserInteractionEnabled = true
                //   self.functionalLocationScanQRButton.isUserInteractionEnabled = true
            }else if functionalLocationTextField.text != "" && self.equipmentTextField.text != "" {
                //   self.functionalLocationButton.isUserInteractionEnabled = false
                //   self.equipmentButton.isUserInteractionEnabled = false
                //   self.equipmentScanQRButton.isHidden = true
                //   self.functionalLocationScanQRButton.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Create Notification Data
    func setNotificationCreateData() {
        mJCLogger.log("Starting", Type: "info")
        notificationDateButton.isUserInteractionEnabled = true
        notificationTimeButton.isUserInteractionEnabled = true
        functionalLocationButton.isUserInteractionEnabled = true
        functionalLocationScanQRButton.isUserInteractionEnabled = true
        equipmentButton.isUserInteractionEnabled = true
        equipmentScanQRButton.isUserInteractionEnabled = true
        maintenancePlantTextField.isUserInteractionEnabled = true
        self.breakdownSwitch.setOn(false, animated: true)
        self.breakDownSwitchState = false
        self.setCurrentDateAndTime()
        mJCLogger.log("Ended", Type: "info")
    }
    //Set CurrentDate And Time..
    func setCurrentDateAndTime() {
        mJCLogger.log("Starting", Type: "info")
        let today = Date()
        notificationDateTextField.text = ODSDateHelper.getCurrentDate()
        notificationDateTextField.isEnabled = false
        notificationDateTextField.textColor = UIColor.darkGray
        self.notificationTimeTextField.text = today.toString(format: .custom("HH:mm"))
        notificationTimeTextField.isEnabled = false
        notificationTimeTextField.textColor = UIColor.darkGray
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.notificationDateTextField.resignFirstResponder()
        self.notificationTimeTextField.resignFirstResponder()
        self.notificationTypeTextField.resignFirstResponder()
        self.functionalLocationTextField.resignFirstResponder()
        self.descriptionTextField.resignFirstResponder()
        self.equipmentTextField.resignFirstResponder()
        self.priorityTextField.resignFirstResponder()
        self.maintenancePlantTextField.resignFirstResponder()
        self.noteTextView.resignFirstResponder()
        self.malfunctionStartDateTextField.resignFirstResponder()
        self.malfunctionStartTimeTextField.resignFirstResponder()
        self.malfunctionStartTimeTextField.resignFirstResponder()
        self.malfunctionEndTimeTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create & Update Notification..
    func createNotification() {
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "Breakdown")
        if breakDownSwitchState == true {
            prop!.value = "X" as NSObject
            property.add(prop!)
            prop = SODataPropertyDefault(name: "MalfunctStart")
            let malStartDate = ODSDateHelper.getDateFromString(dateString: self.malfunctionStartDateTextField.text!, dateFormat: localDateFormate).localDate()
            prop!.value = malStartDate as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "MalFunctStartTime")
            let malfunctionRegStarttime = SODataDuration()
            let malfunctionReqStarttimeArray = self.malfunctionStartTimeTextField.text?.components(separatedBy:":")
            malfunctionRegStarttime.hours = Int(malfunctionReqStarttimeArray![0])! as NSNumber
            malfunctionRegStarttime.minutes = Int(malfunctionReqStarttimeArray![1])! as NSNumber
            malfunctionRegStarttime.seconds = 0
            prop!.value = malfunctionRegStarttime
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "MalfunctEnd")
            let malfunctionReqEndDate = ODSDateHelper.getDateFromString(dateString: self.malfunctionEndDateTextField.text!, dateFormat: localDateFormate).localDate()
            prop!.value = malfunctionReqEndDate as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "MalfunctEndTime")
            let malfunctionReqEndtime = SODataDuration()
            let malfunctionReqEndtimeArray = self.malfunctionEndTimeTextField.text?.components(separatedBy:":")
            malfunctionReqEndtime.hours = Int(malfunctionReqEndtimeArray![0]) as NSNumber?
            malfunctionReqEndtime.minutes = Int(malfunctionReqEndtimeArray![1]) as NSNumber?
            malfunctionReqEndtime.seconds = 0
            prop!.value = malfunctionReqEndtime
            property.add(prop!)
        }else{
            prop!.value = "" as NSObject
            property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "BreakdownDur")
        prop!.value = 0 as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = Date().localDate() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "NotifDate")
        let notifDate = ODSDateHelper.getDateFromString(dateString: notificationDateTextField.text!, dateFormat: localDateFormate).localDate()
        prop!.value = notifDate as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "NotifTime")
        let notifTime = SODataDuration()
        let notifTimeArray = self.notificationTimeTextField.text?.components(separatedBy:":")
        notifTime.hours = Int(notifTimeArray![0])! as NSNumber
        notifTime.minutes = Int(notifTimeArray![1])! as NSNumber
        notifTime.seconds = 0
        prop!.value = notifTime
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "NotificationType")
        let notificationType = self.notificationTypeTextField.text?.components(separatedBy:" - ")
        prop!.value = notificationType![0] as NSObject
        self.property.add(prop!)
        
        let priorityFilteredArray = self.priorityArray.filter({$0.PriorityText == "\(self.priorityTextField.text!)"})
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0]
            prop = SODataPropertyDefault(name: "Priority")
            prop!.value = priorityClass.Priority as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PriorityType")
            prop!.value = priorityClass.PriorityType as NSObject
            self.property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "ShortText")
        prop!.value = descriptionTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FunctionalLoc")
        prop!.value = self.functionalLocationTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Equipment")
        prop!.value = self.equipmentTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MaintPlant")
        
        let plant = self.maintenancePlantTextField.text!
        let Pcount = plant.components(separatedBy: " - ")
        if Pcount.count > 0{
            prop!.value = Pcount[0] as NSObject
            self.property.add(prop!)
        }else{
            prop!.value = "" as NSObject
            self.property.add(prop!)
        }
        prop = SODataPropertyDefault(name:"MainWorkCenter")

        let mainWrkArray = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
        if mainWrkArray.count > 0 {
            prop!.value = mainWrkArray[0] as NSObject
            self.property.add(prop!)
        }else{
            prop!.value = "\(userWorkcenter)" as NSObject
            self.property.add(prop!)
        }
        if isFromWorkOrder == true{
            prop = SODataPropertyDefault(name:"WorkOrderNum")
            prop!.value = singleWorkOrder.WorkOrderNum as NSObject
            self.property.add(prop!)
        }

        let notifNum = String.random(length: 11, type: "Number")
        let randomNotificationNumber = "L\(notifNum)"
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(randomNotificationNumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(randomNotificationNumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ABCIndicator")
        prop!.value = "A" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "RequiredStartDate")
        prop!.value = notifDate.localDate() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "RequiredStartTime")
        prop!.value = notifTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MalfunctStart")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MalFunctStartTime")
        let malFunctStartTime = SODataDuration()
        let timeString = Date().toString(format: .custom("HH:mm")) 
        let dueTimeArray = timeString.components(separatedBy:":")
        malFunctStartTime.hours = Int(dueTimeArray[0]) as NSNumber?
        malFunctStartTime.minutes = Int(dueTimeArray[1]) as NSNumber?
        malFunctStartTime.seconds = 0
        prop!.value = malFunctStartTime
        self.property.add(prop!)
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Partner")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ReportedBy")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: notificationHeaderSetEntity)
        
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        var flushReq = Bool()
        if self.noteTextView.text! != "" {
            flushReq = false
        }else{
            flushReq = true
        }
        NotificationModel.createNotificationEntity(entity: entity!, collectionPath: notificationHeaderSet, flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Notification Created successfully", Type: "Debug")
                let params = Parameters(
                    title: alerttitle,
                    message: "Notification_created_successfully".localized(),
                    cancelButton: okay
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        mJCLogger.log("Notification Created successfully", Type: "Debug")
                        self.createUpdateDelegate?.EntityCreated?()
                        if self.noteTextView.text! != "" {
                            self.createNewNote(notification: randomNotificationNumber, noteText: self.noteTextView.text)
                        }else {
                            DispatchQueue.main.async {
                                if isCreateNotificationThroughForms == true{
                                    isFormCreatedThroughNotification = true
                                    self.dismiss(animated: false) {}
                                }else{
                                    isFormCreatedThroughNotification = false
                                    self.dismiss(animated: false) {}
                                }
                            }
                        }
                    default: break
                    }
                }
            }else {
                DispatchQueue.main.async {
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    self.createUpdateDelegate?.EntityCreated?()
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func updateErrorNotification(){
        
        mJCLogger.log("Starting", Type: "info")
        let notificationType = self.notificationTypeTextField.text?.components(separatedBy:" - ")
        (errorNotifiation.entity.properties["NotificationType"] as! SODataProperty).value = notificationType![0] as NSObject
        (errorNotifiation.entity.properties["ShortText"] as! SODataProperty).value = self.descriptionTextField.text! as NSObject
        let priorityFilteredArray = self.priorityArray.filter({$0.PriorityText == "\(self.priorityTextField.text!)"})
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0]
            (errorNotifiation.entity.properties["Priority"] as! SODataProperty).value = priorityClass.Priority as NSObject
            (errorNotifiation.entity.properties["PriorityType"] as! SODataProperty).value = priorityClass.PriorityType as NSObject
        }
        if breakDownSwitchState == true {
            (errorNotifiation.entity.properties["Breakdown"] as! SODataProperty).value = "X" as NSObject
            (singleNotification.entity.properties["MalfunctStart"] as! SODataProperty).value =   ODSDateHelper.getDateFromString(dateString: self.malfunctionStartDateTextField.text!, dateFormat: localDateFormate) as NSObject
            singleNotification.MalfunctStart =  ODSDateHelper.getDateFromString(dateString: self.malfunctionStartDateTextField.text!, dateFormat: localDateTimeFormate)
            let malfuncStartTime = SODataDuration()
            let malfuncStartTimeArray = malfunctionStartTimeTextField.text?.components(separatedBy: ":")
            malfuncStartTime.hours = Int(malfuncStartTimeArray![0]) as NSNumber?
            malfuncStartTime.minutes = Int(malfuncStartTimeArray![1]) as NSNumber?
            malfuncStartTime.seconds = 0
            (singleNotification.entity.properties["MalFunctStartTime"] as! SODataProperty).value = malfuncStartTime
            singleNotification.MalFunctStartTime = malfuncStartTime
            (singleNotification.entity.properties["MalfunctEnd"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.malfunctionEndDateTextField.text!, dateFormat: localDateFormate) as NSObject
            singleNotification.MalfunctEnd = ODSDateHelper.getDateFromString(dateString: self.malfunctionEndDateTextField.text!, dateFormat: localDateTimeFormate)
            let malfuncEndTime = SODataDuration()
            let malfuncEndTimeArray = malfunctionEndTimeTextField.text?.components(separatedBy: ":")
            malfuncEndTime.hours = Int(malfuncEndTimeArray![0]) as NSNumber?
            malfuncEndTime.minutes = Int(malfuncEndTimeArray![1]) as NSNumber?
            malfuncEndTime.seconds = 0
            (singleNotification.entity.properties["MalfunctEndTime"] as! SODataProperty).value = malfuncEndTime
            singleNotification.MalfunctEndTime = malfuncEndTime
        }else{
            (singleNotification.entity.properties["Breakdown"] as! SODataProperty).value = "" as NSObject
        }
        NotificationModel.updateNotificationEntity(entity: errorNotifiation.entity, options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Notification Updated successfully", Type: "Debug")
                self.createUpdateDelegate?.EntityUpdated?()
                if self.noteTextView.text! != "" {
                    self.createNewNote(notification: self.errorNotifiation.Notification, noteText: self.noteTextView.text!)
                }else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //Update Notification..
    func updateNotification()  {
        
        mJCLogger.log("Starting", Type: "info")
        
        let notificationType = self.notificationTypeTextField.text?.components(separatedBy:" - ")
        (notificationClass.entity.properties["NotificationType"] as! SODataProperty).value = notificationType![0] as NSObject
        notificationClass.NotificationType = notificationType![0]
        (notificationClass.entity.properties["ShortText"] as! SODataProperty).value = self.descriptionTextField.text! as NSObject
        notificationClass.ShortText = self.descriptionTextField.text!
        let priorityFilteredArray = self.priorityArray.filter({$0.PriorityText == "\(self.priorityTextField.text!)"})
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0]
            (notificationClass.entity.properties["Priority"] as! SODataProperty).value = priorityClass.Priority as NSObject
            notificationClass.Priority = priorityClass.Priority
            (notificationClass.entity.properties["PriorityType"] as! SODataProperty).value = priorityClass.PriorityType as NSObject
            notificationClass.PriorityType = priorityClass.PriorityType
        }
        if breakDownSwitchState == true {
            (singleNotification.entity.properties["Breakdown"] as! SODataProperty).value = "X" as NSObject
            notificationClass.Breakdown = "X"
            (notificationClass.entity.properties["MalfunctStart"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.malfunctionStartDateTextField.text!, dateFormat: localDateFormate) as NSObject
            notificationClass.MalfunctStart = ODSDateHelper.getDateFromString(dateString: self.malfunctionStartDateTextField.text!, dateFormat: localDateTimeFormate)
            let malfuncStartTime = SODataDuration()
            let malfuncStartTimeArray = malfunctionStartTimeTextField.text?.components(separatedBy: ":")
            malfuncStartTime.hours = Int(malfuncStartTimeArray![0]) as NSNumber?
            malfuncStartTime.minutes = Int(malfuncStartTimeArray![1]) as NSNumber?
            malfuncStartTime.seconds = 0
            (notificationClass.entity.properties["MalFunctStartTime"] as! SODataProperty).value = malfuncStartTime
            notificationClass.MalFunctStartTime = malfuncStartTime
            (notificationClass.entity.properties["MalfunctEnd"] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.malfunctionEndDateTextField.text!, dateFormat: localDateFormate) as NSObject
            notificationClass.MalfunctEnd = ODSDateHelper.getDateFromString(dateString: self.malfunctionEndDateTextField.text!, dateFormat: localDateTimeFormate)
            let malfuncEndTime = SODataDuration()
            let malfuncEndTimeArray = malfunctionEndTimeTextField.text?.components(separatedBy: ":")
            malfuncEndTime.hours = Int(malfuncEndTimeArray![0]) as NSNumber?
            malfuncEndTime.minutes = Int(malfuncEndTimeArray![1]) as NSNumber?
            malfuncEndTime.seconds = 0
            (notificationClass.entity.properties["MalfunctEndTime"] as! SODataProperty).value = malfuncEndTime
            notificationClass.MalfunctEndTime = malfuncEndTime
        }else {
            (notificationClass.entity.properties["Breakdown"] as! SODataProperty).value = "" as NSObject
            notificationClass.Breakdown = ""
        }
        if let mobile = (notificationClass.entity.properties["StatusFlag"] as? SODataProperty){
            mobile.value = "" as NSObject
            notificationClass.StatusFlag = ""
        }
        var flushReq = Bool()
        if self.noteTextView.text! == "" {
            flushReq = true
        }else{
            flushReq = false
        }
        NotificationModel.updateNotificationEntity(entity: notificationClass.entity,flushRequired: flushReq, options: nil, completionHandler:{ (response, error) in
            if(error == nil) {
                mJCLogger.log("Notification Updated successfully", Type: "Debug")
                self.createUpdateDelegate?.EntityUpdated?()
                if self.noteTextView.text != "" {
                    self.createNewNote(notification: selectedNotificationNumber, noteText: self.noteTextView.text!)
                }else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    func editOnlineNotification() {
        
        mJCLogger.log("Starting", Type: "info")
        let entityset = singleNotification.entityValue.entitySet
        let entitype = entityset.entityType
        var propety = SODataV4_Property.init()
        let resultentity = singleNotification.entityValue
        let options = SODataV4_RequestOptions.new()
        options.updateMode = SODataV4_UpdateMode.replace
        propety = entitype.getProperty("ShortText")
        propety.setString(resultentity, descriptionTextField.text!)
        singleNotification.ShortText = descriptionTextField.text!
        propety = entitype.getProperty("Priority")
        
        let priorityFilteredArray = self.priorityArray.filter({$0.PriorityText == "\(self.priorityTextField.text!)"})
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0]
            propety.setString(resultentity, priorityClass.Priority)
            singleNotification.Priority = priorityClass.Priority
        }else{
            propety.setString(resultentity, "")
        }
        propety = entitype.getProperty("FunctionalLoc")
        propety.setString(resultentity, functionalLocationTextField.text!)
        singleNotification.FunctionalLoc = functionalLocationTextField.text!
        
        propety = entitype.getProperty("Equipment")
        propety.setString(resultentity, equipmentTextField.text!)
        singleNotification.Equipment = equipmentTextField.text!
        
        if breakDownSwitchState == true {
            propety = entitype.getProperty("Breakdown")
            propety.setString(resultentity, "X")
            singleNotification.Breakdown = "X"
            
            propety = entitype.getProperty("MalfunctStart")
            
            let arr = self.malfunctionStartDateTextField.text!.components(separatedBy: "-")
            let malstatdate = SODataV4_LocalDateTime.of(Int32(arr[2]) ?? 0, Int32(arr[1]) ?? 00, Int32(arr[0]) ?? 0, 0, 0, 0)
            propety.setValue(resultentity, malstatdate)
            propety = entitype.getProperty("MalFunctStartTime")
            let malfuncStartTimeArray = malfunctionStartTimeTextField.text!.components(separatedBy: ":")
            let malstattime = SODataV4_LocalTime.of(Int32(malfuncStartTimeArray[0]) ?? 0, Int32(malfuncStartTimeArray[1]) ?? 0, 0)
            propety.setValue(resultentity, malstattime)
            propety = entitype.getProperty("MalfunctEnd")
            let arr1 = self.malfunctionEndDateTextField.text!.components(separatedBy: "-")
            let malenddate = SODataV4_LocalDateTime.of(Int32(arr1[2]) ?? 0, Int32(arr1[1]) ?? 00, Int32(arr1[0]) ?? 0, 0, 0, 0)
            propety.setValue(resultentity, malenddate)
            propety = entitype.getProperty("MalfunctEndTime")
            let malfuncEndTimeArray = malfunctionEndTimeTextField.text!.components(separatedBy: ":")
            let malendtime = SODataV4_LocalTime.of(Int32(malfuncEndTimeArray[0]) ?? 0, Int32(malfuncEndTimeArray[1]) ?? 0, 0)
            propety.setValue(resultentity, malendtime)
        }else {
            propety = entitype.getProperty("Breakdown")
            propety.setString(resultentity, "")
            singleNotification.Breakdown = ""
        }
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        let respDict = NotificationModel.updateOnlineNotificationEntity(httpcon: httpConvMan!, entityValue: resultentity)
        if let status = respDict["Status"] as? String{
            if status == "Success"{
                mJCLoader.stopAnimating()
                self.createUpdateDelegate?.EntityUpdated?()
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: MessageTitle, message:"Notification_Updated".localized(), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: okay, style: UIAlertAction.Style.default, handler: {_ in
                        self.dismiss(animated: false) {}
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }else if status == "-1"{
                mJCLoader.stopAnimating()
                print("Update Entity Error \(respDict["Error"] ?? "")")
                mJCLogger.log("Reason : \(respDict["Error"] ?? "")", Type: "Error")
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: MessageTitle, message:"\(respDict["Error"] ?? "")", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: okay, style: UIAlertAction.Style.default, handler: {_ in
                        self.dismiss(animated: false) {}
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            DispatchQueue.main.async{
                let alert = UIAlertController(title: MessageTitle, message:somethingwrongalert, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: okay, style: UIAlertAction.Style.default, handler: {_ in
                    self.dismiss(animated: false) {}
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create note..
    func createNewNote(notification : String, noteText:String) {
        
        mJCLogger.log("Starting", Type: "info")
        
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = noteText as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextName")
        prop!.value = notification as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(notification)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(notification)" as NSObject
        self.property.add(prop!)
        
        var longTextSetEntity = String()
        var longTextCollectionPath = String()
        var textObject = String()
        
        textObject = LONG_TEXT_TYPE_NOTIFICATION
        longTextSetEntity = notificationLongTextSetEntity
        longTextCollectionPath = notificationLongTextSet
        
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
        
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: longTextCollectionPath, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("New Note Created successfully", Type: "Debug")
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                UserDefaults.standard.set(false, forKey: "isCreateNote")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
            }
            if isCreateNotificationThroughForms == true{
                isFormCreatedThroughNotification = true
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }

            }else{
                isFormCreatedThroughNotification = false
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - UITextField Delegate..
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectDateAndTime = ""
        if textField == standardTextField{
            standardTextNameArray.removeAll()
            standardTextNameArray.append(selectStr)
            for i in 0..<StandardTextArray.count{
                standardTextNameArray.append( StandardTextArray[i].StandardTextName)
            }
            self.standardTextField.optionArray = standardTextNameArray
            self.standardTextField.checkMarkEnabled = false
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.standardTextField{
            if textField.text == ""{
                
            }
            else{
                if !(self.standardTextNameArray.contains(textField.text!)){
                    textField.text = ""
//                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please enter valid value", button: okay)
                }
            }
        }
        return true
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
    @IBAction func checkNotificationsListButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.showOnlineSearchPopUp(searchType:"Notifications")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func malfunctionStartDateButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "MalFunctionStartDate"
        self.allTextFieldResign()
        
        ODSPicker.selectDate(title: "Select_Malfunction_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.malfunctionEndDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.malfunctionEndDateTextField.text)!){
                    self?.malfunctionStartDateTextField.text = selectedDate.dateString(localDateFormate)
                }
                else{
                    self?.malfunctionEndDateTextField.text = ""
                    self?.malfunctionStartDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            }
            else{
                self?.malfunctionStartDateTextField.text = selectedDate.dateString(localDateFormate)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func malfunctionStartTimeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "MalfunctionStartTime"
        self.allTextFieldResign()
        
        if ODSDateHelper.compareTwoDates(fromDate: self.malfunctionStartDateTextField.text!, toDate: self.malfunctionEndDateTextField.text!){
            let startDate = ODSDateHelper.restrictHoursOnCurrentTimer()
            let endDate = ODSDateHelper.restrictMiniutsOnCurrentTimer()
            ODSPicker.selectDate(title: "Select_Basic_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, minDate: startDate as Date, maxDate: endDate as Date, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.malfunctionStartTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        else{
            ODSPicker.selectDate(title: "Select_Malfunction_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.malfunctionStartTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func malfunctionEndDateButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "MalfunctionEndDate"
        self.allTextFieldResign()
        
        if malfunctionStartDateTextField.text!.count > 0 {
            let fromDate = ODSDateHelper.getDateFromString(dateString: malfunctionStartDateTextField.text!, dateFormat: localDateFormate)
                ODSPicker.selectDate(title: "Select_Malfunction_End_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: fromDate, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                    if !(self?.malfunctionStartDateTextField.text!.isEmpty)! {
                        if ODSDateHelper.compareTwoDates(fromDate: (self?.malfunctionStartDateTextField.text)!, toDate: selectedDate.dateString(localDateFormate)){
                            self?.malfunctionEndDateTextField.text = selectedDate.dateString(localDateFormate)
                        }
                        else{
                            self?.malfunctionEndDateTextField.text = ""
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized(), button: okay)
                        }
                    }
                    else{
                        self?.malfunctionEndDateTextField.text = selectedDate.dateString(localDateFormate)
                    }
                })
        }else{
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_Start_Date".localized(), button: okay)
        }

        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func malfunctionEndTimeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("MalfunctionEndTimeButtonAction".localized(), Type: "")
        selectDateAndTime = "MalfunctionEndTime"
        self.allTextFieldResign()
        
        if ODSDateHelper.compareTwoDates(fromDate: self.malfunctionStartDateTextField.text!, toDate: self.malfunctionEndDateTextField.text!){
            ODSPicker.selectDate(title: "Select_Malfunction_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.malfunctionEndTimeTextField.text = selectedDate.dateString(localTimeFormat)
                let startDateStr = "\(self!.malfunctionStartDateTextField.text!) \(self!.malfunctionStartTimeTextField.text!)"
                let endDateStr = "\(self!.malfunctionEndDateTextField.text!) \(self!.malfunctionEndTimeTextField.text!)"
                let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startDateStr, timeFormate: localDateTimeFormate)
                let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endDateStr, timeFormate: localDateTimeFormate)
                if startTime != nil && endTime != nil{
                    if startTime! >= endTime!{
                        self!.malfunctionEndTimeTextField.text = ""
                        mJCLogger.log("Please_select_valid_time".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }
                }else{
                    mJCLogger.log("Please_select_valid_time".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                    return
                }
            })
        }
        else{
            if malfunctionStartTimeTextField.text!.count > 0 && malfunctionStartDateTextField.text!.count > 0{
                ODSPicker.selectDate(title: "Select_Malfunction_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                    self?.malfunctionEndTimeTextField.text = selectedDate.dateString(localTimeFormat)
                })
                mJCLogger.log("Ended", Type: "info")
            }
            else{
                malfunctionEndTimeTextField.text = ""
                mJCLogger.log("Please_Select_Start_time".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Start_time".localized(), button: okay)
                return
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func showOnlineSearchPopUp(searchType:String){
        DispatchQueue.main.async{
            let lotPopUp = Bundle.main.loadNibNamed("OnlineWorkOrderAndNotification", owner: self, options: nil)?.last as! OnlineWorkOrderAndNotification
            lotPopUp.onlineSearchNotificationTableView.isHidden = true
            let windows = UIApplication.shared.windows
            let firstWindow = windows.first
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            lotPopUp.searchType = searchType
            lotPopUp.plantText = self.maintenancePlantTextField.text!
            lotPopUp.mainWorkCenterText = self.mainWorkCenterTextField.text!
            lotPopUp.functionalLocationText = self.functionalLocationTextField.text!
            lotPopUp.equipmentText = self.equipmentTextField.text!
            lotPopUp.frame = UIScreen.main.bounds
            lotPopUp.loadNibView()
            firstWindow?.addSubview(lotPopUp)
        }
    }
    
    //MARK: - Not Using Methods
    @IBAction func standardTextButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.standardTextFieldView
        standardTextNameArray.removeAll()
        standardTextNameArray.append(selectStr)
        for i in 0..<StandardTextArray.count{
            standardTextNameArray.append( StandardTextArray[i].StandardTextName)
        }
        let arr : [String] = self.standardTextNameArray
        dropDown.dataSource = arr
        dropDownSelectString = "standardTextdDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func notificationTypeButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.notificationTypeListArray.count > 0 {
            mJCLogger.log("Response:\(self.notificationTypeListArray.count)", Type: "Debug")
            dropDown.anchorView = self.notificationTypeTextFieldView
            let arr : [String] = self.notificationTypeListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "notificationType"
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func priorityButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.priorityListArray.count > 0 {
            mJCLogger.log("Response:\(self.priorityListArray.count)", Type: "Debug")
            dropDown.anchorView = self.priorityTextFieldView
            let arr : [String] = self.priorityListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "Priority"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func maintenancePlantButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.maintPlantListArray.count > 0 {
            mJCLogger.log("Response:\(self.maintPlantListArray.count)", Type: "Debug")
            dropDown.anchorView = self.maintenancePlantTextFieldView
            let arr : [String] = self.maintPlantListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "maintenancePlant"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func mainWorkCenterButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.workCentersListArray.count > 0 {
            mJCLogger.log("Response:\(self.workCentersListArray.count)", Type: "Debug")
            dropDown.anchorView = self.mainWorkCenterTextFieldView
            let arr : [String] = self.workCentersListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "WorkCentersDropDown"
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
