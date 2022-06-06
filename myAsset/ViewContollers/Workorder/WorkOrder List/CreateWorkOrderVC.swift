//
//  CreateWorkOrderVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/7/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CreateWorkOrderVC: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,personResponsibleDelegate,FuncLocEquipSelectDelegate, operationCreationDelegate,barcodeDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var createWorkOrderHeaderLAbel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var scrollContainerView: UIView!
    
    //plantView Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTitleLabel: UILabel!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantTextField: iOSDropDown!
    @IBOutlet var plantButton: UIButton!
    
    //priorityView Outlets..
    @IBOutlet var priorityView: UIView!
    @IBOutlet var priorityTitleLabel: UILabel!
    @IBOutlet var priorityTextFieldView: UIView!
    @IBOutlet var priorityTextField: iOSDropDown!
    @IBOutlet var priorityButton: UIButton!
    
    //typeView Outlets..
    @IBOutlet var typeView: UIView!
    @IBOutlet var typeTitleLabel: UILabel!
    @IBOutlet var typeTextFieldView: UIView!
    @IBOutlet var typeTextField: iOSDropDown!
    @IBOutlet var typeButton: UIButton!
    
    //basicStartView Outlets..
    @IBOutlet var basicStartView: UIView!
    @IBOutlet var basicDateTitleLabel: UILabel!
    @IBOutlet var basicDateTextFieldView: UIView!
    @IBOutlet var basicDateTextField: UITextField!
    @IBOutlet var basicDateButton: UIButton!
    @IBOutlet var basicTimeTextFieldView: UIView!
    @IBOutlet var basicTimeTextField: UITextField!
    @IBOutlet var basicTimeButton: UIButton!
    
    //descriptionView Outlets..
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionViewTextFieldView: UIView!
    @IBOutlet var descriptionViewTextField: UITextField!
    
    // DueDateView Outlets..
    @IBOutlet var dueDateView: UIView!
    @IBOutlet var dueDateTitleLabel: UILabel!
    @IBOutlet var dueDateTextFieldview: UIView!
    @IBOutlet var dueDateTextField: UITextField!
    
    // DueDate Time Button Outlets..
    @IBOutlet var dueDateButton: UIButton!
    @IBOutlet var dueDateTimeTextFieldview: UIView!
    @IBOutlet var dueDateTimeTextField: UITextField!
    @IBOutlet var dueDateTimeButton: UIButton!
    
    // BusinessAreaView Outlets..
    @IBOutlet var businessAreaView: UIView!
    @IBOutlet var businessAreaTitleLabel: UILabel!
    @IBOutlet var businessAreaTextFieldView: UIView!
    @IBOutlet var businessAreaTextField: iOSDropDown!
    @IBOutlet var businessAreaButton: UIButton!
    
    // MainWorkCenterView Outlets..
    @IBOutlet var mainWorkCenterView: UIView!
    @IBOutlet var mainWorkCenterTitleLabel: UILabel!
    @IBOutlet var mainWorkCenterTextFieldView: UIView!
    @IBOutlet var mainWorkCenterTextField: iOSDropDown!
    @IBOutlet var mainWorkCenterButton: UIButton!
    
    // EquipmentView Outlets..
    @IBOutlet var equipmentView: UIView!
    @IBOutlet var equipmentTitleLabel: UILabel!
    @IBOutlet var equipmentTextFieldView: UIView!
    @IBOutlet var equipmentTextField: UITextField!
    @IBOutlet var equipmentScanButton: UIButton!
    @IBOutlet var equipmentButton: UIButton!
    
    //FunctionalLocationView Outlets..
    @IBOutlet var functionalLocationView: UIView!
    @IBOutlet var functionalLocationTitleLabel: UILabel!
    @IBOutlet var functionalLocationTextFieldView: UIView!
    @IBOutlet var functionalLocationTextField: UITextField!
    @IBOutlet var functionalLocationButton: UIButton!
    @IBOutlet var functionalLocationScanButton: UIButton!
    
    // personResponsibleView Outlets..
    @IBOutlet var personResponsibleView: UIView!
    @IBOutlet var personResponsibleTitleLabel: UILabel!
    @IBOutlet var personResponsibleTextFieldView: UIView!
    @IBOutlet var personResponsibleTextField: UITextField!
    @IBOutlet var personResponsibleButton: UIButton!
    
    // NoteView Outlets..
    @IBOutlet var noteView: UIView!
    @IBOutlet var noteTitleLabel: UILabel!
    @IBOutlet var noteTextViewView: UIView!
    @IBOutlet var noteTextView: UITextView!
    // ButtonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var ActivityTypeView: UIView!
    @IBOutlet var ActivityTypeTitleLabel: UILabel!
    @IBOutlet var ActivityTypeTextFieldView: UIView!
    @IBOutlet var ActivityTypeTextField: iOSDropDown!
    @IBOutlet var ActivityTypeButton: UIButton!
    
    @IBOutlet weak var checkOnlineSearchButton: UIButton!
    
    // Equipment Warrenty Info Label Outlet
    @IBOutlet weak var equipWarrantyInfoLabel: UILabel!
    @IBOutlet weak var equipmentWarrantyView: UIView!
    @IBOutlet weak var equipmentWarrantyImageView: UIImageView!
    
    @IBOutlet var standardTextView: UIView!
    @IBOutlet var standardTextTitleLabel: UILabel!
    @IBOutlet var standardTextFieldView: UIView!
    @IBOutlet var standardTextField: iOSDropDown!
    @IBOutlet var standardTextbutton: UIButton!
    
    // User Status Outlets..
    @IBOutlet weak var userStatusView: UIView!
    @IBOutlet var userStatusTitleLabel: UILabel!
    @IBOutlet weak var userStatusTextFieldView: UIView!
    @IBOutlet weak var userStatusTextField: UITextField!
    @IBOutlet weak var userStatusButton: UIButton!
    
    //MARK:- Declared Variable..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var businessAreaArray = [BussinessAreaModel]()
    var businessAreaListArray = [String]()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var functionalLocationArray = NSMutableArray()
    var functionalLocationListArray = NSMutableArray()
    var isFromEdit = Bool()
    var isScreen = String()
    var isFromError = Bool()
    var isSelectedFunLoc = Bool()
    var isfromfollowOnWo = Bool()
    var searchType = String()
    var errorWorkorder = WoHeaderModel()
    @objc    var Name1 = String()
    weak var newWorkOrder : SODataEntity?
    var maintPlantArray = [MaintencePlantModel]()
    var plantArray = [String]()
    var planingPlantArray = [String]()
    var associatePlantArray = [String]()
    var personResponsibleArray = [PersonResponseModel]()
    var personResponsibleListArray = [String]()
    var priorityArray = [PriorityListModel]()
    var priorityListArray = [String]()
    var workCentersArray = [WorkCenterModel]()
    var workCentersListArray = [String]()
    var workOrderTypeArray = [LtOrderControlKeyModel]()
    var workOrderTypeListArray = [String]()
    var activityArray = [ActivityTypeModel]()
    var activityListArray = [String]()
    var StandardTextArray = [StandardTextModel]()
    var standardTextNameArray = [String]()
    var AllowedFollOnObjTypArray = [AllowedFollowOnObjectTypeModel]()
    var PriorityText = String()
    var property = NSMutableArray()
    var selectDateAndTime = NSString()
    var typeOfScanCode = String()
    var notificationNum = String()
    var notificationType = String()
    var subStringArr = NSMutableArray()
    var successMsg = String()
    var selectedPlant = String()
    var selectedMainWorkCenter = String()
    var createUpdateDelegate:CreateUpdateDelegate?
    var statusArray = [LTStatusProfileModel]()
    var statusListArray = [String]()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")
        isOperationCreated = false
        property.removeAllObjects()
        self.mainScrollView.showsVerticalScrollIndicator = false
        self.mainScrollView.showsHorizontalScrollIndicator = false
        self.descriptionViewTextField.delegate = self
        self.standardTextField.delegate = self
        ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.priorityTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.typeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.basicDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.basicTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionViewTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.dueDateTextFieldview, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.ActivityTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.dueDateTimeTextFieldview, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.businessAreaTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.mainWorkCenterTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.equipmentTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.functionalLocationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.noteTextViewView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.standardTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.personResponsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.userStatusTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        //self.getCheckBoxStatus()
        self.getMaintPlantList()
        self.getPriorityList()
        self.getBusinessAreaList()
        self.getPersonResponsibleList()
        self.getStandardText()
        self.getWorkOrderType(isfromEdit: isFromEdit)
        if onlineSearch == true{
            self.standardTextView.isHidden = true
            self.noteView.isHidden = true
        }else{
            self.standardTextView.isHidden = false
            self.noteView.isHidden = false
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "Plant_Drop_Down".localized() {
                self.plantTextField.text = item
                self.dropDownSelectString = ""
                self.mainWorkCenterTextField.text = ""
                self.setWorkCenterValue()
            }else if self.dropDownSelectString == "Priority_Drop_Down".localized() {
                self.priorityTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "WorkOrder_Type_DropDown".localized() {
                self.typeTextField.text = item
                var ordertype = String()
                self.dropDownSelectString = ""
                if self.isfromfollowOnWo == true{
                    ordertype = item
                }else{
                    let type = item.components(separatedBy: " - ")
                    ordertype = type[0]
                }
                if ordertype.count > 0{
                    let activityFilteredArray = self.activityArray.filter{$0.OrderType == ordertype}
                    if activityFilteredArray.count > 0{
                        self.activityListArray.removeAll()
                        for item in activityFilteredArray {
                            self.activityListArray.append(item.MaintActivType + " - " + item.Description)
                        }
                        if self.activityListArray.count != 0 {
                            self.ActivityTypeTextField.text = self.activityListArray[0]
                        }
                    }else{
                        if self.activityArray.count > 0{
                            let actClass = self.activityArray[0]
                            self.ActivityTypeTextField.text = actClass.MaintActivType + " - " + actClass.Description
                        }else{
                            self.ActivityTypeTextField.text = ""
                        }
                    }
                }
            }else if self.dropDownSelectString == "Business_Area_DropDown".localized() {
                self.businessAreaTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "WorkCenters_DropDown".localized() {
                self.mainWorkCenterTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Person_Responsible_DropDown".localized() {
                self.personResponsibleTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Activity_DropDown".localized() {
                self.ActivityTypeTextField.text = item
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
            }else if dropDownSelectString == "UserStatus"{
                self.userStatusTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateWorkOrderVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.setBasicData()
        if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "4"{
            self.personResponsibleView.isHidden = true
        }else{
            self.personResponsibleView.isHidden = false
            ODSUIHelper.setBorderToView(view:self.personResponsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        noteTextView.isUserInteractionEnabled = true
        if onlineSearch {
            noteTextView.isUserInteractionEnabled = false
        }
        if onlineSearch == true{
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(CreateWorkOrderVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        }
        //Order type
        self.typeTextField.didSelect { selectedText, index, id in
            self.typeTextField.text = selectedText
            var ordertype = String()
            self.dropDownSelectString = ""
            if self.isfromfollowOnWo == true{
                ordertype = selectedText
            }else{
                let type = selectedText.components(separatedBy: " - ")
                ordertype = type[0]
            }
            if ordertype.count > 0{
                let activityFilteredArray = self.activityArray.filter{$0.OrderType == ordertype}
                if activityFilteredArray.count > 0{
                    self.activityListArray.removeAll()
                    for item in activityFilteredArray {
                        self.activityListArray.append(item.MaintActivType + " - " + item.Description)
                    }
                    if self.activityListArray.count != 0 {
                        self.ActivityTypeTextField.text = self.activityListArray[0]
                    }
                }else{
                    if self.activityArray.count > 0{
                        let actClass = self.activityArray[0]
                        self.ActivityTypeTextField.text = actClass.MaintActivType + " - " + actClass.Description
                    }else{
                        self.ActivityTypeTextField.text = ""
                    }
                }
            }
        }
        //Plant
        self.plantTextField.didSelect { selectedText, index, id in
            self.plantTextField.text = selectedText
            self.mainWorkCenterTextField.text = ""
            self.setWorkCenterValue()
        }
        //Main work center
        self.mainWorkCenterTextField.didSelect { selectedText, index, id in
            self.mainWorkCenterTextField.text = selectedText
        }
        //Activity type
        self.ActivityTypeTextField.didSelect { selectedText, index, id in
            self.ActivityTypeTextField.text = selectedText
        }
        //Busniess area
        self.businessAreaTextField.didSelect { selectedText, index, id in
            self.businessAreaTextField.text = selectedText
        }
        //Standard
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
        //Prioroty
        self.priorityTextField.didSelect { selectedText, index, id in
            self.priorityTextField.text = selectedText
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.stopAnimating()
        DispatchQueue.main.async{
            self.dismiss(animated: false, completion: nil)
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
        if isOperationCreated == true{
            singleNotification.WorkOrderNum = UserDefaults.standard.value(forKey: "WONum") as! String
            self.createUpdateDelegate?.EntityCreated?()
            UserDefaults.standard.removeObject(forKey: "WONum")
            self.dismiss(animated: false) {
            }
        }
        if isFromEdit == true{
            checkOnlineSearchButton.isHidden = true
            self.standardTextView.isHidden = true
            if equipmentTextField.text == "" && functionalLocationTextField.text == "" {
                self.equipmentScanButton.isHidden = false
                self.functionalLocationScanButton.isHidden = false
            }else if equipmentTextField.text == "" && self.functionalLocationTextField.text != "" {
                self.equipmentScanButton.isHidden = false
                self.functionalLocationScanButton.isHidden = false
            }else {
                self.equipmentScanButton.isHidden = true
                self.functionalLocationScanButton.isHidden = true
            }
        }else{
            self.standardTextView.isHidden = false
            equipmentScanButton.isHidden = false
            functionalLocationScanButton.isHidden = false
            checkOnlineSearchButton.isHidden = false
        }
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
            equipmentWarrantyImageView.isHidden = false
            equipmentWarrantyView.isHidden = false
            equipmentWarrantyImageView.image = UIImage(named: "history_pending")
        }else{
            equipWarrantyInfoLabel.text = ""
            equipmentWarrantyImageView.isHidden = true
            equipmentWarrantyView.isHidden = true
        }
        if ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO == true{
            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
            if result == "ServerUp" && onlineSearch == false{
                if self.equipmentTextField.text != "" {
                    if self.functionalLocationTextField.text == "" {
                        DispatchQueue.main.async {
                            let params = Parameters(
                                title: MessageTitle,
                                message: "Functional_Location_is_not_available_for_this_Equipment".localized() as String,
                                cancelButton: okay
                            )
                            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                switch buttonIndex {
                                case 0: print("")
                                    //self.showOnlineSearchPopUp(searchType: "WorkOrder")
                                default: break
                                }
                            }
                        }
                    }else{
                        //self.showOnlineSearchPopUp(searchType: "WorkOrder")
                    }
                }else if self.functionalLocationTextField.text != "" {
                    
                   // self.showOnlineSearchPopUp(searchType: "WorkOrder")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func operation(_ Create: Bool, Update: Bool) {
        if Create == true{
            isOperationCreated = true
            if isScreen == "NotificationOverView"{
                singleNotification.WorkOrderNum = UserDefaults.standard.value(forKey: "WONum") as! String
                self.updateNotification(workorder: singleNotification.WorkOrderNum)
            }
        }else{
            isOperationCreated = false
        }
    }
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.allTextFieldResign()
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.typeTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.descriptionTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.dueDateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.mainWorkCenterTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.functionalLocationTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.equipmentTitleLabel)
    }
    //MARK:- footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if (typeTextField.text == "" || typeTextField.text == selectStr) && isFromEdit == false{
            mJCLogger.log("Please_select_ordertype".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_ordertype".localized(), button: okay)
        }else  if descriptionViewTextField.text == "" {
            mJCLogger.log("Please_enter_description".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_description".localized(), button: okay)
        }else if dueDateTextField.text == "" {
            mJCLogger.log("Please_select_end_date_and_time".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_end_date_and_time".localized(), button: okay)
        }else if dueDateTimeTextField.text == "" {
            mJCLogger.log("Please_select_end_date_and_time".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_end_date_and_time".localized(), button: okay)
        }else if self.mainWorkCenterTextField.text == "" {
            mJCLogger.log(WorkCenterAlert, Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: WorkCenterAlert, button: okay)
        }else if isFromEdit == false {
            if equipmentTextField.text == "" && functionalLocationTextField.text == "" {
                mJCLogger.log("Please_Add_Equipment".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Add_Equipment".localized(), button: okay)
            }else {
                self.workOrderFunction()
            }
        }else {
            self.workOrderFunction()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func workOrderFunction() {
        mJCLogger.log("Starting", Type: "info")
        let basicDateString = basicDateTextField.text! + " " + basicTimeTextField.text!
        let dueDateString = dueDateTextField.text! + " " + dueDateTimeTextField.text!
        let basicDate = ODSDateHelper.getDateFromString(dateString: basicDateString, dateFormat: localDateTimeFormate)
        let dueDate = ODSDateHelper.getDateFromString(dateString: dueDateString, dateFormat: localDateTimeFormate)
        if dueDate < basicDate {
            mJCLogger.log("Start_date_can't_fall_after_finish".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Start_date_can't_fall_after_finish".localized(), button: okay)
        }else {
            if isFromEdit == true {
                if onlineSearch {
                    self.allTextFieldResign()
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    self.editOnlineWorkorder()
                }else {
                    if self.isFromEdit == true &&  self.isFromError == true{
                        self.editErrorWorkorder()
                    }else{
                        self.editWorkorder()
                    }
                }
            }else {
                if onlineSearch {
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        self.createWorkOrder()
                    }
                }else {
                    self.createWorkOrder()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Cancel Button Tapped".localized(), Type: "")
        self.allTextFieldResign()
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.isSelectedFunLoc = false
            self.descriptionViewTextField.text = ""
            self.noteTextView.text = ""
            self.plantTextField.text = ""
            self.businessAreaTextField.text = ""
            self.typeTextField.text = ""
            self.mainWorkCenterTextField.text = ""
            self.functionalLocationTextField.text = ""
            self.equipmentTextField.text = ""
            self.standardTextField.text = selectStr
            self.setBasicData()
            self.setMaintPlantValue()
            self.setBusinessArea()
            self.setPriorityValue()
            self.setWorkOrderType()
            self.setWorkCenterValue()
            self.setPersonResponsible()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Field Button Action.
    @IBAction func functionalLocationButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let functionaLocationListVC = ScreenManager.getFlocEquipHierarchyScreen()
        functionaLocationListVC.isSelect = "FunctionalLocation"
        let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
        if arr.count > 0{
            functionaLocationListVC.workCenter = arr[0]
        }
        let arr1 = self.plantTextField.text!.components(separatedBy: " - ")
        if arr1.count > 0{
            functionaLocationListVC.planningPlant = arr1[0]
        }
        functionaLocationListVC.modalPresentationStyle = .fullScreen
        functionaLocationListVC.delegate = self
        self.present(functionaLocationListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func functionalLocationScanButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Floc", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let functionaLocationListVC = ScreenManager.getFlocEquipHierarchyScreen()
        functionaLocationListVC.selectedFunLoc = functionalLocationTextField.text!
        functionaLocationListVC.isSelect = "Equipement"
        let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
        if arr.count > 0{
            functionaLocationListVC.workCenter = arr[0]
        }
        let arr1 = self.plantTextField.text!.components(separatedBy: " - ")
        if arr1.count > 0{
            functionaLocationListVC.planningPlant = arr1[0]
        }
        functionaLocationListVC.planningPlant = arr1[0]
        functionaLocationListVC.selectedFunLoc = self.functionalLocationTextField.text ?? ""
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
    @IBAction func personResponsibleButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        let personRespVC = ScreenManager.getPersonResponsibleListScreen()
        personRespVC.modalPresentationStyle = .fullScreen
        personRespVC.delegate = self
        self.present(personRespVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        self.personResponsibleTextField.text = result
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        self.dismiss(animated: false) {}
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == descriptionViewTextField {
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
    func textFieldDidEndEditing(_ textField: UITextField) {}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.standardTextField{
            if textField.text != ""{
                if !(self.standardTextNameArray.contains(textField.text!)){
                    textField.text = ""
                }
            }
        }
        return true
    }
    //MARK:- UITextView Delegate..
    func textViewDidBeginEditing(_ textView: UITextView) {}
    func textViewDidEndEditing(_ textView: UITextView) {}
    //MARK:- Date And Time Button Action..
    @IBAction func basicDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "BasicDate"
        self.allTextFieldResign()
        ODSPicker.selectDate(title: "Select_Basic_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.dueDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.dueDateTextField.text)!){
                    self?.basicDateTextField.text = selectedDate.dateString(localDateFormate)
                }else{
                    self?.dueDateTextField.text = ""
                    self?.basicDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            }else{
                self?.basicDateTextField.text = selectedDate.dateString(localDateFormate)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func basicTimeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "BasicTime"
        self.allTextFieldResign()
        if ODSDateHelper.compareTwoDates(fromDate: self.basicDateTextField.text!, toDate: self.dueDateTextField.text!){
            let startDate = ODSDateHelper.restrictHoursOnCurrentTimer()
            let endDate = ODSDateHelper.restrictMiniutsOnCurrentTimer()
            ODSPicker.selectDate(title: "Select_Basic_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, minDate: startDate as Date, maxDate: endDate as Date, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.basicTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }else{
            ODSPicker.selectDate(title: "Select_Basic_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.basicTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func dueDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "DueDate"
        self.allTextFieldResign()
        if basicDateTextField.text!.count > 0 {
            let fromDate = ODSDateHelper.getDateFromString(dateString: basicDateTextField.text!, dateFormat: localDateFormate)
            ODSPicker.selectDate(title: "Select_Due_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: fromDate, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                if !(self?.basicDateTextField.text!.isEmpty)! {
                    if ODSDateHelper.compareTwoDates(fromDate: (self?.basicDateTextField.text)!, toDate: selectedDate.dateString(localDateFormate)){
                        self?.dueDateTextField.text = selectedDate.dateString(localDateFormate)
                    }else{
                        self?.dueDateTextField.text = ""
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized(), button: okay)
                    }
                }else{
                    self?.dueDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            })
        }else{
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_Start_Date".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func dueDateTimeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "DueTime"
        self.allTextFieldResign()
        if ODSDateHelper.compareTwoDates(fromDate: self.basicDateTextField.text!, toDate: self.dueDateTextField.text!){
            ODSPicker.selectDate(title: "Select_Due_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self!.dueDateTimeTextField.text = selectedDate.dateString(localTimeFormat)
                let startDateStr = "\(self!.basicDateTextField.text!) \(self!.basicTimeTextField.text!)"
                let endDateStr = "\(self!.dueDateTextField.text!) \(self!.dueDateTimeTextField.text!)"
                let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startDateStr, timeFormate: localDateTimeFormate)
                let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endDateStr, timeFormate: localDateTimeFormate)
                if startTime != nil && endTime != nil{
                    if startTime! >= endTime!{
                        self!.dueDateTimeTextField.text = ""
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
        }else{
            if basicTimeTextField.text!.count > 0 && basicDateTextField.text!.count > 0{
                ODSPicker.selectDate(title: "Select_Due_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                    self?.dueDateTimeTextField.text = selectedDate.dateString(localTimeFormat)
                })
                mJCLogger.log("Ended", Type: "info")
            }else{
                dueDateTimeTextField.text = ""
                mJCLogger.log("Please_Select_Start_time".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Start_time".localized(), button: okay)
                return
            }
        }
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        self.plantTextField.resignFirstResponder()
        self.priorityTextField.resignFirstResponder()
        self.typeTextField.resignFirstResponder()
        self.descriptionViewTextField.resignFirstResponder()
        self.businessAreaTextField.resignFirstResponder()
        self.mainWorkCenterTextField.resignFirstResponder()
        self.equipmentTextField.resignFirstResponder()
        self.functionalLocationTextField.resignFirstResponder()
        self.noteTextView.resignFirstResponder()
        self.ActivityTypeTextField.resignFirstResponder()
        self.standardTextField.resignFirstResponder()
    }
    func setBasicData() {
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == false {
            if isfromfollowOnWo == true{
                self.descriptionViewTextField.text = singleWorkOrder.ShortText
                self.functionalLocationTextField.text = singleWorkOrder.FuncLocation
                self.equipmentTextField.text = singleWorkOrder.EquipNum
                self.createWorkOrderHeaderLAbel.text = "Create_Follow_on_Work_order_For".localized() + " \(singleWorkOrder.WorkOrderNum)"
            }else{
                self.createWorkOrderHeaderLAbel.text = "Create_Work_Order".localized()
            }
            self.noteView.isHidden = false
            if isScreen == "NotificationOverView" {
                let today = Date()
                self.descriptionViewTextField.text = singleNotification.ShortText
                self.functionalLocationTextField.text = singleNotification.FunctionalLoc
                self.equipmentTextField.text = singleNotification.Equipment
                if singleNotification.RequiredStartDate != nil{
                    let basicDate = singleNotification.RequiredStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    if basicDate == "" {
                        let currentDate = Date().localDate().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                        self.basicDateTextField.text = currentDate
                    }else {
                        self.basicDateTextField.text = basicDate
                    }
                }else{
                    let currentDate = Date().localDate().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    self.basicDateTextField.text = currentDate
                }
                self.basicTimeTextField.text = today.toString(format: .custom("HH:mm"))
                if singleNotification.RequiredEndDate != nil{
                    let endDate = singleNotification.RequiredEndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    if endDate == "" {
                        let currentDate = Date().localDate().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                        self.dueDateTextField.text = currentDate
                    }else {
                        self.dueDateTextField.text = endDate
                    }
                }else{
                    let currentDate = Date().localDate().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    self.dueDateTextField.text = currentDate
                }
                self.dueDateTimeTextField.text = today.toString(format: .custom("HH:mm"))
            }else if isScreen=="WorkOrder" {
                let today = Date()
                let calendar = NSCalendar.current
                if isfromfollowOnWo == true {
                    self.functionalLocationTextField.text = singleWorkOrder.FuncLocation
                    self.equipmentTextField.text = singleWorkOrder.EquipNum
                }
                self.basicDateTextField.text =  today.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                self.basicTimeTextField.text = today.toString(format: .custom("HH:mm"))
                let tomorrow = calendar.date(byAdding: .day, value: 1, to: today as Date)
                let tomorrowDate =  calendar.date(byAdding: .second, value: 1, to: tomorrow!)
                
                self.dueDateTextField.text = tomorrowDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                self.dueDateTimeTextField.text = tomorrowDate?.toString(format: .custom("HH:mm"))
            }
        }else if isFromEdit == true && isFromError == true{
            if errorWorkorder.BasicStrtDate != nil{
                self.basicDateTextField.text =  errorWorkorder.BasicStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.basicDateTextField.text = ""
            }
            self.basicTimeTextField.text =  ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorWorkorder.BasicStrtTime)
            if errorWorkorder.BasicFnshDate != nil{
                self.dueDateTextField.text = errorWorkorder.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.dueDateTextField.text = ""
            }
            self.noteView.isHidden = true
            self.dueDateTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: errorWorkorder.BasicFnshTime)
            self.descriptionViewTextField.text = errorWorkorder.ShortText
            self.equipmentTextField.text = errorWorkorder.EquipNum
            self.functionalLocationTextField.text = errorWorkorder.FuncLocation
            self.createWorkOrderHeaderLAbel.text = "Edit_Work_Order".localized() + "- \(errorWorkorder.WorkOrderNum)"
        }else{
            if singleWorkOrder.BasicStrtDate != nil{
                self.basicDateTextField.text = singleWorkOrder.BasicStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.basicDateTextField.text = ""
            }
            if singleWorkOrder.BasicFnshDate != nil{
                self.dueDateTextField.text = singleWorkOrder.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.dueDateTextField.text = ""
            }
            self.noteView.isHidden = true
            self.basicTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleWorkOrder.BasicStrtTime)
            self.dueDateTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleWorkOrder.BasicFnshTime)
            self.descriptionViewTextField.text = singleWorkOrder.ShortText
            self.equipmentTextField.text = singleWorkOrder.EquipNum
            self.functionalLocationTextField.text = singleWorkOrder.FuncLocation
            self.createWorkOrderHeaderLAbel.text = "Edit_Work_Order".localized() +  "- \(singleWorkOrder.WorkOrderNum)"
            self.plantButton.isEnabled = false
            self.typeButton.isEnabled = false
            self.ActivityTypeButton.isEnabled = false
            self.basicDateButton.isEnabled = false
            self.basicTimeButton.isEnabled = false
            self.dueDateButton.isEnabled = false
            self.dueDateTimeButton.isEnabled = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Get mainPlant
    func getMaintPlantList()  {
        mJCLogger.log("Starting", Type: "info")
        self.maintPlantArray.removeAll()
        if globalPlanningPlantArray.count > 0 {
            self.maintPlantArray = globalPlanningPlantArray
            self.setMaintPlantValue()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setMaintPlantValue() {
        mJCLogger.log("Starting", Type: "info")
        self.plantArray.removeAll()
        self.planingPlantArray.removeAll()
        self.associatePlantArray.removeAll()
        DispatchQueue.main.async {
            for item in self.maintPlantArray {
                self.plantArray.append("\(item.Plant) - \(item.Name1)")
                self.planingPlantArray.append("\(item.PlanningPlant) - \(item.Name1)")
                self.associatePlantArray.append("\(item.Plant) - \(item.Name1)")
            }
            //Palnt
            self.workCentersListArray.removeAll()
            if self.plantArray.count > 0{
                self.plantTextField.optionArray = self.plantArray
                self.plantTextField.checkMarkEnabled = false
            }
            var plant = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                plant = self.errorWorkorder.Plant
            }else  if self.isFromEdit == true {
                plant = singleWorkOrder.Plant
            }else if self.isFromEdit == false {
                if self.isScreen == "NotificationOverView" {
                    if singleNotification.MaintPlant == "" {
                        plant = userPlant
                    }else {
                        plant = singleNotification.MaintPlant
                    }
                }else if self.isScreen == "WorkOrder" {
                    plant =  userPlant
                }
            }
            let filterarr =  self.maintPlantArray.filter{$0.Plant == plant}
            if filterarr.count > 0{
                let cls = filterarr[0]
                self.plantTextField.text = cls.Plant + " - " + cls.Name1
            }
            self.getWorkCentersList()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get PriorityList..
    func getPriorityList() {
        mJCLogger.log("Starting", Type: "info")
        self.priorityArray.removeAll()
        if globalPriorityArray.count > 0 {
            self.priorityArray = globalPriorityArray
            self.setPriorityValue()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setPriorityValue()  {
        
        mJCLogger.log("Starting", Type: "info")
        self.priorityListArray.removeAll()
        DispatchQueue.main.async {
            for item in globalPriorityArray {
                self.priorityListArray.append(item.PriorityText)
            }
            var priorityStr = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                priorityStr = self.errorWorkorder.Priority
            }else if self.isFromEdit == true {
                priorityStr = singleWorkOrder.Priority
            }else if self.isFromEdit == false {
                if self.isScreen == "NotificationOverView" {
                    priorityStr = singleNotification.Priority
                }else if self.isScreen == "WorkOrder" {
                    if self.isfromfollowOnWo == true{
                        priorityStr = singleWorkOrder.Priority
                    }
                }
            }
            if priorityStr == ""{
                self.priorityTextField.text = self.priorityListArray[0]
            }else{
                let prArry = self.priorityArray.filter{$0.Priority == "\(priorityStr)"}
                if prArry.count > 0{
                    let cls = prArry[0]
                    self.priorityTextField.text = cls.PriorityText
                }else{
                    if self.priorityListArray.count > 0{
                        self.priorityTextField.text = self.priorityListArray[0]
                    }
                }
            }
            if self.priorityListArray.count > 0{
                self.priorityTextField.optionArray = self.priorityListArray
                self.priorityTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get BusinessArea List..
    func getBusinessAreaList() {
        mJCLogger.log("Starting", Type: "info")
        BussinessAreaModel.getBussinessAreaList(){ (response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [BussinessAreaModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.businessAreaArray = responseArr
                    self.setBusinessArea()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setBusinessArea()  {
        mJCLogger.log("Starting", Type: "info")
        self.businessAreaListArray.removeAll()
        DispatchQueue.main.async {
            for item in self.businessAreaArray {
                self.businessAreaListArray.append(item.BusinessArea + " - " + item.BusinessAreaText)
            }
            var businessAreaStr = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                businessAreaStr = self.errorWorkorder.BusArea
            }else  if self.isFromEdit == true {
                businessAreaStr = singleWorkOrder.BusArea
            }else if self.isFromEdit == false {
                if self.isScreen == "NotificationOverView" {
                    businessAreaStr = singleNotification.BusinessArea
                }
            }
            if businessAreaStr == ""{
                if self.businessAreaListArray.count > 0{
                    self.businessAreaTextField.text = self.businessAreaListArray[0]
                }
            }else{
                let arr = self.businessAreaArray.filter{$0.BusinessArea == "\(businessAreaStr)"}
                if arr.count > 0{
                    let cls = arr[0]
                    self.businessAreaTextField.text = cls.BusinessArea + " - " + cls.BusinessAreaText
                }else{
                    if self.businessAreaListArray.count > 0{
                        self.businessAreaTextField.text = self.businessAreaListArray[0]
                    }
                }
            }
            if self.businessAreaListArray.count > 0{
                self.businessAreaTextField.optionArray = self.businessAreaListArray
                self.businessAreaTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get WorkCenters List..
    func getWorkCentersList() {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersArray.removeAll()
        if globalWorkCtrArray.count > 0 {
            workCentersArray = globalWorkCtrArray
            self.setWorkCenterValue()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkCenterValue()  {
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
                self.mainWorkCenterTextField.optionArray = self.workCentersListArray
                self.mainWorkCenterTextField.checkMarkEnabled = false
            }
            var workcenterStr = String()
            var workcenterType = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                workcenterStr = self.errorWorkorder.MainWorkCtr
                workcenterType = "Wo"
            }else  if self.isFromEdit == true {
                workcenterStr = singleWorkOrder.MainWorkCtr
                workcenterType = "Wo"
            }else if self.isFromEdit == false {
                if self.isScreen == "NotificationOverView" {
                    workcenterStr = singleNotification.WorkCenter
                    workcenterType = "No"
                }else if self.isScreen == "WorkOrder" {
                    if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                        workcenterStr = singleWorkOrder.MainWorkCtr
                    }else{
                        workcenterStr = singleOperation.WorkCenter
                    }
                    workcenterType = "Wo"
                }
            }
            if workcenterStr == "" && self.workCentersListArray.count > 0{
                if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                    let filterArr = self.workCentersArray.filter{$0.WorkCenter == userWorkcenter}
                    if filterArr.count > 0{
                        let cls = filterArr[0]
                        self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                    }else{
                        if self.workCentersListArray.count > 0{
                            self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                        }
                    }
                }else{
                    let filterArr = self.workCentersArray.filter{$0.WorkCenter == OpWorkCentter}
                    if filterArr.count > 0{
                        let cls = filterArr[0]
                        self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                    }else{
                        if self.workCentersListArray.count > 0{
                            self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                        }
                    }
                }
            }else if self.workCentersListArray.count > 0{
                var filterArr = Array<Any>()
                if workcenterType == "Wo"{
                    filterArr = self.workCentersArray.filter{$0.WorkCenter == workcenterStr}
                }else if workcenterType == "No"{
                    filterArr = self.workCentersArray.filter{$0.ObjectID == workcenterStr}
                }
                if filterArr.count > 0{
                    let cls = filterArr[0] as! WorkCenterModel
                    self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    if self.workCentersListArray.count > 0{
                        self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                    }
                }
            }else{
                self.mainWorkCenterTextField.text = ""
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Person Responsible List..
    func getPersonResponsibleList() {
        mJCLogger.log("Starting", Type: "info")
        self.personResponsibleArray.removeAll()
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
            }
            var persoNo = String()
            if self.isFromEdit == true &&  self.isFromError == true{
                persoNo = self.errorWorkorder.PersonResponsible
                
            }else  if self.isFromEdit == false {
                persoNo = userPersonnelNo
            }else {
                persoNo = singleWorkOrder.PersonResponsible
            }
            if persoNo == ""{
                self.personResponsibleTextField.text = selectStr
            }else{
                let arr = self.personResponsibleArray.filter{$0.PersonnelNo == persoNo}
                if arr.count > 0{
                    let cls = arr[0]
                    self.personResponsibleTextField.text = cls.SystemID + " - " + cls.EmplApplName
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Work OrderType List..
    func getWorkOrderType(isfromEdit : Bool)  {
        mJCLogger.log("Starting", Type: "info")
        if isfromEdit == true{
            LtOrderControlKeyModel.getltOrderControlKeyList(){ (response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [LtOrderControlKeyModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.workOrderTypeArray = responseArr
                        self.setWorkOrderType()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            LtOrderControlKeyModel.getltWorkOrderTypeList(){ (response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [LtOrderControlKeyModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if self.isScreen == "NotificationOverView" {
                            self.workOrderTypeArray = responseArr.filter{$0.NotificationType == self.notificationType}
                            if self.workOrderTypeArray.count == 0{
                                self.workOrderTypeArray = responseArr
                            }
                        }else{
                            self.workOrderTypeArray = responseArr
                        }
                        self.setWorkOrderType()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkOrderType() {
        mJCLogger.log("Starting", Type: "info")
        self.workOrderTypeListArray.removeAll()
        if isfromfollowOnWo == true{
            for item in self.AllowedFollOnObjTypArray{
                self.workOrderTypeListArray.append(item.AllowedObjectType + " - " + item.Description)
            }
            if self.workOrderTypeListArray.count > 0{
                DispatchQueue.main.async{
                    self.typeTextField.text = self.workOrderTypeListArray[0]
                }
                if self.workOrderTypeListArray.count > 0{
                    self.typeTextField.optionArray = self.workOrderTypeListArray
                    self.typeTextField.checkMarkEnabled = false
                }
                self.getActivityList()
            }
        }else{
            DispatchQueue.main.async {
                for item in self.workOrderTypeArray {
                    self.workOrderTypeListArray.append(item.OrderType + " - " + item.OrderDescription)
                }
                if self.workOrderTypeListArray.count > 0{
                    self.typeTextField.optionArray = self.workOrderTypeListArray
                    self.typeTextField.checkMarkEnabled = false
                }
                var orderTypeStr = String()
                if self.isFromEdit == true &&  self.isFromError == true{
                    orderTypeStr =  self.errorWorkorder.OrderType
                    
                }else if self.isFromEdit == true {
                    orderTypeStr =  singleWorkOrder.OrderType
                }
                if orderTypeStr == ""{
                    if self.workOrderTypeListArray.count > 0{
                        self.typeTextField.text = self.workOrderTypeListArray[0]
                    }
                }else{
                    let arr = self.workOrderTypeArray.filter{$0.OrderType == "\(orderTypeStr)"}
                    if arr.count > 0{
                        self.typeTextField.text = arr[0].OrderType + " - " + arr[0].OrderDescription
                    }
                }
                self.getActivityList()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getCheckBoxStatus(){
        mJCLogger.log("Starting", Type: "info")
        self.statusListArray.append(selectStr)
        var statusCategory = String()
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            statusCategory = WorkorderLevel
        }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            statusCategory = OperationLevel
        }
        let query = "$filter=(StatusCategory eq '\(statusCategory)')"
        LTStatusProfileModel.getLtStatusProfileDetails(filterQuery:query){ (responseDict, error)  in
            if error == nil{
                self.statusArray.removeAll()
                if let responseArr = responseDict["data"] as? [LTStatusProfileModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.statusArray = responseArr
                        for itemCount in 0..<self.statusArray.count {
                            let statusClass = self.statusArray[itemCount]
                            self.statusListArray.append("\(statusClass.StatusCode) - \(statusClass.StatusDescription)")
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        if self.statusListArray.count > 0{
            self.userStatusTextField.text = self.statusListArray[0]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createWorkOrder() {
        mJCLogger.log("Starting", Type: "info")
        if onlineSearch == true && isScreen == "NotificationOverView" {
            let httpConvMan2 = HttpConversationManager.init()
            let commonfig2 = CommonAuthenticationConfigurator.init()
            if authType == "Basic"{
                commonfig2.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
            }else if authType == "SAML"{
                commonfig2.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
            }
            commonfig2.configureManager(httpConvMan2)
            let respDict = WoHeaderModel.getEntitySetDetails(httpcon: httpConvMan2!)
            if let status = respDict["Status"] as? String{
                if status == "Success"{
                    if let entityset = respDict["Response"] as? SODataV4_EntitySet{
                        let entitype = entityset.entityType
                        let queryresult =  SODataV4_EntityValue.ofType(entitype)
                        var assigendtoSelf = Bool()
                        var propety = SODataV4_Property.init()
                        propety = entitype.getProperty("MaintActivityType")
                        let activityArr = self.ActivityTypeTextField.text!.components(separatedBy: " - ")
                        if activityArr.count > 0{
                            propety.setString(queryresult, activityArr[0])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        propety = entitype.getProperty("BusArea")
                        let busAreaArr = self.businessAreaTextField.text!.components(separatedBy: " - ")
                        if busAreaArr.count > 0 {
                            propety.setString(queryresult, busAreaArr[0])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        propety = entitype.getProperty("BusAreaText")
                        if busAreaArr.count > 1{
                            propety.setString(queryresult, busAreaArr[1])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        if isScreen == "NotificationOverView"{
                            propety = entitype.getProperty("CreateNotifFlag")
                            propety.setString(queryresult, "X")
                            
                            propety = entitype.getProperty("NotificationNum")
                            propety.setString(queryresult, notificationNum)
                        }
                        propety = entitype.getProperty("CategoryText")
                        let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
                        if typeArray.count > 1 {
                            propety.setString(queryresult, typeArray[1])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        propety = entitype.getProperty("EnteredBy")
                        propety.setString(queryresult, strUser.uppercased())
                        
                        propety = entitype.getProperty("EquipNum")
                        propety.setString(queryresult, self.equipmentTextField.text!)
                        
                        propety = entitype.getProperty("FuncLocation")
                        propety.setString(queryresult, self.functionalLocationTextField.text!)
                        
                        propety = entitype.getProperty("MainWorkCtr")
                        
                        let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
                        if arr.count > 0{
                            propety.setString(queryresult, arr[0])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        propety = entitype.getProperty("Plant")
                        
                        let arr1 = self.plantTextField.text!.components(separatedBy: " - ")
                        if arr1.count > 0{
                            propety.setString(queryresult, arr1[0])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        propety = entitype.getProperty("MaintPlant")
                        if arr1.count > 0{
                            propety.setString(queryresult, arr1[0])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        if arr1.count > 1{
                            propety = entitype.getProperty("MaintPlanningPlant")
                            let plantFilteredArray = self.maintPlantArray.filter{$0.Plant == "\(arr1[0])" && $0.Name1 == "\(arr1[1])"}
                            if plantFilteredArray.count > 0{
                                let plantClass = plantFilteredArray[0]
                                propety.setString(queryresult, plantClass.PlanningPlant)
                                
                            }else{
                                propety.setString(queryresult, "")
                                
                            }
                            propety = entitype.getProperty("PlantMainWorkCtr")
                            if plantFilteredArray.count > 0{
                                let plantClass = plantFilteredArray[0]
                                propety.setString(queryresult, plantClass.Plant)
                                
                            }else{
                                propety.setString(queryresult, "")
                            }
                        }
                        propety = entitype.getProperty("OrderType")
                        let arr2 = self.typeTextField.text!.components(separatedBy: " - ")
                        if arr2.count > 0{
                            propety.setString(queryresult, arr2[0])
                        }else{
                            propety.setString(queryresult, "")
                        }
                        if WORKORDER_ASSIGNMENT_TYPE != "3" || WORKORDER_ASSIGNMENT_TYPE != "4" {
                            var personResponsibleClass = PersonResponseModel()
                            propety = entitype.getProperty("PersonResponsible")
                            let perrespArray = self.personResponsibleTextField.text!.components(separatedBy: " - ")
                            if perrespArray.count > 0 {
                                let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == perrespArray[0] && $0.EmplApplName == "\(perrespArray[1])"}
                                if personResponsibleFilteredArray.count > 0{
                                    personResponsibleClass = personResponsibleFilteredArray[0]
                                    propety.setString(queryresult, personResponsibleClass.PersonnelNo)
                                    if personResponsibleClass.PersonnelNo == userPersonnelNo{
                                        assigendtoSelf = true
                                    }
                                }else{
                                    propety.setString(queryresult, "")
                                }
                            }
                        }
                        propety = entitype.getProperty("Priority")
                        let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(self.priorityTextField.text!)"}
                        if priorityFilteredArray.count > 0{
                            let priorityClass = priorityFilteredArray[0]
                            propety.setString(queryresult, priorityClass.Priority)
                        }else{
                            propety.setString(queryresult, "")
                        }
                        propety = entitype.getProperty("ShortText")
                        propety.setString(queryresult, descriptionViewTextField.text!)
                        
                        let randomWorkorderNumber = String.random(length: 7, type: "Number")
                        propety = entitype.getProperty("TempID")
                        propety.setString(queryresult, "L\(randomWorkorderNumber)")
                        
                        propety = entitype.getProperty("WorkOrderNum")
                        propety.setString(queryresult, "L\(randomWorkorderNumber)")
                        
                        let Dict = WoHeaderModel.createOnlineWorkorderEntity(httpcon: httpConvMan2!, entityValue: queryresult)
                        mJCLogger.log("Response :\(Dict)", Type: "Debug")
                        if let status = Dict["Status"] as? String{
                            if status == "Success"{
                                mJCLogger.log("Create Done", Type: "Debug")
                                DispatchQueue.main.async{
                                    mJCLoader.stopAnimating()
                                    if assigendtoSelf == true{
                                        let params = Parameters(
                                            title: "Warning".localized(),
                                            message: "Work_order_created_and_assigned_to_your_self_successfully.Do_u_want_transmit".localized(),
                                            cancelButton: "Cancel".localized(),
                                            otherButtons: ["Continue".localized()]
                                        )
                                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                            switch buttonIndex {
                                            case 0:
                                                self.dismiss(animated: false) {}
                                            case 1:
                                                mJCLoader.startAnimating(status: "Downloading".localized())
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                                    myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
                                                    self.createUpdateDelegate?.EntityCreated?()
                                                    isWOCreated  = true
                                                })
                                            default: break
                                            }
                                        }
                                    }else{
                                        let params = Parameters(
                                            title: MessageTitle,
                                            message: "Work_order_Created".localized(),
                                            cancelButton: okay
                                        )
                                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                            switch buttonIndex {
                                            case 0:
                                                self.dismiss(animated: false, completion: nil)
                                            default: break
                                            }
                                        }
                                        self.createUpdateDelegate?.EntityCreated?()
                                        isWOCreated  = true
                                    }
                                }
                            }else{
                                mJCLogger.log("\(Dict.value(forKey: "Error") ?? "\(somethingwrongalert)")", Type: "Error")
                                mJCLoader.stopAnimating()
                                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "\(Dict.value(forKey: "Error") ?? "\(somethingwrongalert)")", button: okay)
                            }
                        }else{
                            mJCLogger.log(somethingwrongalert, Type: "Error")
                            mJCLoader.stopAnimating()
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
                        }
                    }else{
                        mJCLogger.log(somethingwrongalert, Type: "Error")
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
                    }
                }else if status == "-1"{
                    mJCLogger.log(somethingwrongalert, Type: "Error")
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
                }
            }else{
                mJCLogger.log(somethingwrongalert, Type: "Error")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
            }
        }else{
            self.property = NSMutableArray()
            var prop : SODataProperty! = SODataPropertyDefault(name: "BasicFnshDate")
            DispatchQueue.main.async {
                prop = SODataPropertyDefault(name: "BasicFnshDate")
                prop!.value = ODSDateHelper.getDateFromString(dateString: self.dueDateTextField.text!, dateFormat: localDateFormate).localDate() as NSObject
                self.property.add(prop!)
            }
            prop = SODataPropertyDefault(name: "BasicFnshTime")
            let dueTime = SODataDuration()
            let dueTimeArray = dueDateTimeTextField.text?.components(separatedBy: ":")
            dueTime.hours = Int(dueTimeArray![0]) as NSNumber?
            dueTime.minutes = Int(dueTimeArray![1]) as NSNumber?
            dueTime.seconds = 0
            prop!.value = dueTime
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "BasicStrtDate")
            prop!.value = ODSDateHelper.getDateFromString(dateString: self.basicDateTextField.text!, dateFormat: localDateFormate).localDate() as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "BasicStrtTime")
            let basicTime = SODataDuration()
            let basicTimeArray = basicTimeTextField.text?.components(separatedBy: ":")
            basicTime.hours = Int(basicTimeArray![0]) as NSNumber?
            basicTime.minutes = Int(basicTimeArray![1]) as NSNumber?
            basicTime.seconds = 0
            prop!.value = basicTime
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "StrtDate")
            prop!.value = ODSDateHelper.getDateFromString(dateString: self.basicDateTextField.text!, dateFormat: localDateFormate).localDate() as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "MaintActivityType")
            let activityArray = self.ActivityTypeTextField.text!.components(separatedBy: " - ")
            if activityArray.count > 0 {
                prop!.value = activityArray[0] as NSObject
            }else{
                prop!.value = "" as NSObject
            }
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "BusArea")
            if self.businessAreaTextField.text != "" && self.businessAreaTextField.text != nil{
                let busAreaArry = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if busAreaArry.count > 0 {
                    prop!.value = busAreaArry[0] as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                self.property.add(prop!)
            }else{
                prop!.value = "" as NSObject
                self.property.add(prop!)
            }
            prop = SODataPropertyDefault(name: "BusAreaText")
            if self.businessAreaTextField.text != "" && self.businessAreaTextField.text != nil {
                let busAreaTextArry = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if busAreaTextArry.count > 1 {
                    prop!.value = busAreaTextArry[1] as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                self.property.add(prop!)
            }else{
                prop!.value = "" as NSObject
                self.property.add(prop!)
            }
            if isScreen == "NotificationOverView"{
                prop = SODataPropertyDefault(name: "CreateNotifFlag")
                prop!.value = "X" as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "NotificationNum")
                prop!.value = notificationNum as NSObject
                self.property.add(prop!)
            }
            
            prop = SODataPropertyDefault(name: "CategoryText")
            let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
            if typeArray.count > 0 {
                if isfromfollowOnWo == true{
                    prop!.value = typeArray[0] as NSObject
                }else{
                    prop!.value = typeArray[0] as NSObject
                }
            }else{
                prop!.value = "" as NSObject
            }
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "CreatedOn")
            prop!.value = Date().localDate() as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EnteredBy")
            prop!.value = strUser.uppercased() as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EquipNum")
            prop!.value = self.equipmentTextField.text! as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "FuncLocation")
            prop!.value = self.functionalLocationTextField.text! as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "MainWorkCtr")
            let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
            if arr.count > 0{
                prop!.value = arr[0] as NSObject
            }else{
                prop!.value = "" as NSObject
            }
            self.property.add(prop!)
            
            let arr1 = self.plantTextField.text!.components(separatedBy: " - ")
            if arr1.count > 1{
                prop = SODataPropertyDefault(name: "Plant")
                let plantFilteredArray = self.maintPlantArray.filter{$0.Plant == "\(arr1[0])" && $0.Name1 == "\(arr1[1])"}
                if plantFilteredArray.count > 0{
                    let plantClass = plantFilteredArray[0]
                    prop!.value = plantClass.Plant as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "MaintPlant")
                
                if plantFilteredArray.count > 0{
                    let plantClass = plantFilteredArray[0]
                    prop!.value = plantClass.Plant as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "MaintPlanningPlant")
                if plantFilteredArray.count > 0{
                    let plantClass = plantFilteredArray[0]
                    prop!.value = plantClass.PlanningPlant as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "PlantMainWorkCtr")
                if plantFilteredArray.count > 0{
                    let plantClass = plantFilteredArray[0]
                    prop!.value = plantClass.Plant as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                self.property.add(prop!)
            }
            
            prop = SODataPropertyDefault(name: "OrderType")
            
            let workOrderTypeFilteredArray = self.typeTextField.text!.components(separatedBy: " - ")
            if workOrderTypeFilteredArray.count > 0{
                prop!.value = workOrderTypeFilteredArray[0] as NSObject
            }else{
                prop!.value = "" as NSObject
            }
            self.property.add(prop!)
            
            var personResponsibleClass = PersonResponseModel()
            
            if WORKORDER_ASSIGNMENT_TYPE == "1" {
                prop = SODataPropertyDefault(name: "PersonResponsible")
                let perrespArray = self.personResponsibleTextField.text!.components(separatedBy: " - ")
                if perrespArray.count > 0 {
                    let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == perrespArray[0] && $0.EmplApplName == "\(perrespArray[1])"}
                    if personResponsibleFilteredArray.count > 0{
                        personResponsibleClass = personResponsibleFilteredArray[0]
                        prop!.value = personResponsibleClass.PersonnelNo as NSObject
                    }else{
                        prop!.value = "" as NSObject
                    }
                    self.property.add(prop!)
                }
            }
            prop = SODataPropertyDefault(name: "Priority")
            let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(self.priorityTextField.text!)"}
            if priorityFilteredArray.count > 0{
                let priorityClass = priorityFilteredArray[0]
                prop!.value = priorityClass.Priority as NSObject
            }else{
                prop!.value = "" as NSObject
            }
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ShortText")
            prop!.value = descriptionViewTextField.text! as NSObject
            self.property.add(prop!)
            
            let randomWorkorderNumber = String.random(length: 7, type: "Number")
            prop = SODataPropertyDefault(name: "TempID")
            prop!.value = "L\(randomWorkorderNumber)" as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkOrderNum")
            prop!.value = "L\(randomWorkorderNumber)" as NSObject
            self.property.add(prop!)
            
            if isfromfollowOnWo == true{
                
                prop = SODataPropertyDefault(name: "FollowUpOrder")
                prop!.value = singleWorkOrder.WorkOrderNum as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "FolllowOnFlag")
                prop!.value = "X" as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "SuperiorOrder")
                prop!.value = singleWorkOrder.WorkOrderNum as NSObject
                self.property.add(prop!)
            }
            if CREATE_WORKORDER_WITH_OPERATION == true{
                workOrderCreateDictionary.removeAllObjects()
                if priorityFilteredArray.count > 0{
                    let priorityClass = priorityFilteredArray[0]
                    workOrderCreateDictionary.setValue(priorityClass.Priority, forKey: "Priority")
                }
                let workOrderTypeFilteredArray = self.typeTextField.text!.components(separatedBy: " - ")
                if workOrderTypeFilteredArray.count > 0{
                    workOrderCreateDictionary.setValue(workOrderTypeFilteredArray[0], forKey: "ControlKey")
                }
                let businessAreaFilteredArray = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if businessAreaFilteredArray.count > 0{
                    workOrderCreateDictionary.setValue(businessAreaFilteredArray[0], forKey: "BusinessArea")
                }
                workOrderCreateDictionary.setValue(self.basicDateTextField.text!, forKey: "BasicStrtDate")
                workOrderCreateDictionary.setValue(self.basicTimeTextField.text!, forKey: "BasicStrtTime")
                workOrderCreateDictionary.setValue(self.dueDateTextField.text!, forKey: "BasicFnshDate")
                workOrderCreateDictionary.setValue(self.dueDateTimeTextField.text!, forKey: "BasicFnshTime")
                workOrderCreateDictionary.setValue(self.mainWorkCenterTextField.text!, forKey: "WorkCenter")
                workOrderCreateDictionary.setValue(self.functionalLocationTextField.text!, forKey: "FunctionalLocation")
                workOrderCreateDictionary.setValue(self.equipmentTextField.text!, forKey: "Equipment")
                workOrderCreateDictionary.setValue(self.plantTextField.text!, forKey: "Plant")
                if  WORKORDER_ASSIGNMENT_TYPE == "2"  || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    workOrderCreateDictionary.setValue(personResponsibleClass.PersonnelNo, forKey: "PersonnelNo")
                }
                workOrderCreateDictionary.setValue("L\(randomWorkorderNumber)", forKey: "WorkOrderNum")
                if isfromfollowOnWo == true{
                    workOrderCreateDictionary.setValue(singleWorkOrder.WorkOrderNum, forKey: "FollowUpOrder")
                    workOrderCreateDictionary.setValue(singleWorkOrder.WorkOrderNum, forKey: "FolllowOnFlag")
                }
                UserDefaults.standard.set("L\(randomWorkorderNumber)", forKey: "WONum")
                isWOCreated  = true
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_OP", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
                    if workFlowObj.ActionType == "Screen" {
                        mJCLoader.stopAnimating()
                        DispatchQueue.main.async {
                            let addNewOperationVC = ScreenManager.getCreateOperationScreen()
                            addNewOperationVC.isFromScreen = "WorkOrderCreate"
                            addNewOperationVC.isFromEdit = false
                            addNewOperationVC.operationNumber = "L010"
                            addNewOperationVC.delegate = self
                            if self.noteTextView.text != ""{
                                addNewOperationVC.NewWorkorderNotes = self.noteTextView.text!
                            }else{
                                addNewOperationVC.NewWorkorderNotes = ""
                            }
                            addNewOperationVC.propertyWorkOrderArray = self.property
                            addNewOperationVC.modalPresentationStyle = .fullScreen
                            self.present(addNewOperationVC, animated: false) {}
                        }
                    }
                }
            }else {
                if ENABLE_LOCAL_STATUS_CHANGE == true{
                    prop = SODataPropertyDefault(name: "StatusFlag")
                    prop!.value = "X" as NSObject
                    self.property.add(prop!)
                    
                    prop = SODataPropertyDefault(name: "MobileObjStatus")
                    prop!.value = DEFAULT_STATUS_TO_SEND as NSObject
                    self.property.add(prop!)
                    
                    prop = SODataPropertyDefault(name: "UserStatus")
                    prop!.value = DEFAULT_STATUS_TO_SEND as NSObject
                    self.property.add(prop!)
                }
                print("===== WorkOrder Key Value ======")
                let entity = SODataEntityDefault(type: woHeader_Entity)
                for prop in self.property {
                    let proper = prop as! SODataProperty
                    entity?.properties[proper.name as Any] = proper
                    print("Key : \(proper.name!)")
                    print("Value :\(proper.value!)")
                    print("......................")
                }
                var flushreq = Bool()
                if self.isScreen == "NotificationOverView"{
                    flushreq = false
                }
                if self.noteTextView.text.count > 0{
                    flushreq = false
                }else{
                    flushreq = true
                }
                WoHeaderModel.createWorkorderEntity(entity: entity!, collectionPath: woHeader, flushRequired: flushreq,options: nil, completionHandler: { (response, error) in
                    if(error == nil) {
                        mJCLogger.log("Create Done", Type: "Debug")
                        let data = response.value(forKey: "data") as! String
                        if data == "record inserted successfully" {
                            self.createUpdateDelegate?.EntityCreated?()
                        }
                        if self.isScreen == "NotificationOverView"{
                            self.updateNotification(workorder: "L\(randomWorkorderNumber)")
                            singleNotification.WorkOrderNum = "L\(randomWorkorderNumber)"
                        }
                        if self.noteTextView.text.count > 0{
                            self.createNewNote(noteText: self.noteTextView.text, Workorder: "L\(randomWorkorderNumber)")
                            self.noteTextView.text = ""
                        }else{
                            mJCLoader.stopAnimating()
                            self.successMsg = "Work_Order_is_created_successfully".localized()
                            isWOCreated  = true
                            let params = Parameters(
                                title: MessageTitle,
                                message: self.successMsg,
                                cancelButton: okay
                            )
                            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                switch buttonIndex {
                                case 0:
                                    self.dismiss(animated: false, completion: nil)
                                default: break
                                }
                            }
                        }
                    }else {
                        DispatchQueue.main.async {
                            print("Error : \(error?.localizedDescription)")
                            mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                            self.createUpdateDelegate?.EntityCreated?()
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Create_Workorder_failed".localized(), button: okay)
                        }
                    }
                })
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Activity List..
    func getActivityList() {
        mJCLogger.log("Starting", Type: "info")
        ActivityTypeModel.getActivityList(){ (response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [ActivityTypeModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.activityArray =  responseArr
                    self.setActivityType()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setActivityType() {
        mJCLogger.log("Starting", Type: "info")
        self.activityListArray.removeAll()
        var orderType = String()
        DispatchQueue.main.async {
            let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
            if typeArray.count > 0 {
                orderType = typeArray[0]
            }else{
                orderType = ""
            }
            if orderType != ""{
                for item in self.activityArray {
                    if orderType == item.OrderType {
                        self.activityListArray.append(item.MaintActivType + " - " + item.Description)
                    }
                }
            }else{
                for item in self.activityArray {
                    self.activityListArray.append(item.MaintActivType + " - " + item.Description)
                }
            }
            if self.activityListArray.count != 0 {
                self.ActivityTypeTextField.text = self.activityListArray[0]
            }else {
                mJCLogger.log("Activity Type list not available", Type: "Debug")
            }
            
            if self.activityListArray.count > 0{
                self.ActivityTypeTextField.optionArray = self.activityListArray
                self.ActivityTypeTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateNotification(workorder:String)  {
        mJCLogger.log("Starting", Type: "info")
        (singleNotification.entity.properties["WorkOrderNum"] as! SODataProperty).value = workorder as NSObject
        singleNotification.WorkOrderNum = workorder
        NotificationModel.updateNotificationEntity(entity: singleNotification.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                print("Notification Updated successfully")
                mJCLogger.log("Notification Updated successfully".localized(), Type: "Debug")
                
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func editErrorWorkorder() {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        let keyArray = errorWorkorder.entity.properties.allKeys
        for key in keyArray {
            let keytype = key as! String
            if keytype == "BasicFnshDate" {
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.dueDateTextField.text!, dateFormat: localDateFormate) as NSObject
            }else if keytype == "BasicFnshTime" {
                let dueTime = SODataDuration()
                let dueTimeArray = dueDateTimeTextField.text?.components(separatedBy: ":")
                dueTime.hours = Int(dueTimeArray![0]) as NSNumber?
                dueTime.minutes = Int(dueTimeArray![1]) as NSNumber?
                dueTime.seconds = 0
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = dueTime
            }else if keytype == "BasicStrtDate" {
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.basicDateTextField.text!, dateFormat: localDateFormate) as NSObject
            }else if keytype == "BasicStrtTime" {
                let basicTime = SODataDuration()
                let dueTimeArray = basicTimeTextField.text?.components(separatedBy: ":")
                basicTime.hours = Int(dueTimeArray![0]) as NSNumber?
                basicTime.minutes = Int(dueTimeArray![1]) as NSNumber?
                basicTime.seconds = 0
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = basicTime
            }else if keytype == "BusArea" {
                let busAreaArray = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if busAreaArray.count > 0 {
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = busAreaArray[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "BusAreaText" {
                let busAreaArray = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if busAreaArray.count > 0 {
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = busAreaArray[1] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "CategoryText" {
                let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
                if typeArray.count > 1 {
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = typeArray[1] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "EquipNum" {
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = self.equipmentTextField.text! as NSObject
            }else if keytype == "FuncLocation" {
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = self.functionalLocationTextField.text! as NSObject
            }else if keytype == "MainWorkCtr" {
                let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = arr[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "MaintPlanningPlant" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "MaintPlant" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "OrderType" {
                let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
                if typeArray.count > 0 {
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = typeArray[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "2"  || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if keytype == "PersonResponsible" {
                    let perrespArray = self.personResponsibleTextField.text!.components(separatedBy: " - ")
                    if perrespArray.count > 0{
                        let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == perrespArray[0] && $0.EmplApplName == "\(perrespArray[1])"}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = personResponsibleClass.PersonnelNo as NSObject
                            errorWorkorder.PersonResponsible = personResponsibleClass.PersonnelNo
                        }else{
                            (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                        }
                    }
                }
            }else if keytype == "Plant" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "PlantMainWorkCtr" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "Priority" {
                let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(self.priorityTextField.text!)"}
                if priorityFilteredArray.count > 0{
                    let priorityClass = priorityFilteredArray[0]
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = priorityClass.Priority as NSObject
                }else{
                    (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                }
            }else if keytype == "ShortText" {
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = descriptionViewTextField.text! as NSObject
            }else if keytype == "StatusFlag"{
                (errorWorkorder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
            }
        }
        var flushReq = Bool()
        if self.noteTextView.text! == "" {
            flushReq = true
        }else{
            flushReq = false
        }
        WoHeaderModel.updateWorkorderEntity(entity: errorWorkorder.entity,flushRequired: flushReq ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.successMsg = "Work_Order_is_Updated_successfully".localized()
                mJCLogger.log("Workorder Updated successfully".localized(), Type: "Debug")
                self.createUpdateDelegate?.EntityUpdated?()
                DispatchQueue.main.async {
                    if self.noteTextView.text! == "" {
                        self.successMsg = "Work_Order_is_Updated_successfully".localized()
                        let params = Parameters(
                            title: MessageTitle,
                            message: self.successMsg,
                            cancelButton: okay
                        )
                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0:
                                self.dismiss(animated: false, completion: nil)
                            default: break
                            }
                        }
                    }else {
                        if self.noteTextView.text.count > 0 {
                            self.createNewNote(noteText: self.noteTextView.text, Workorder: self.errorWorkorder.WorkOrderNum)
                            self.noteTextView.text = ""
                        }
                    }
                }
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Workorder_update_fails_try_again".localized(), button: okay)
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func editWorkorder() {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        let keyArray = singleWorkOrder.entity.properties.allKeys
        for key in keyArray {
            let keytype = key as! String
            if keytype == "BasicFnshDate" {
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.dueDateTextField.text!, dateFormat: localDateFormate) as NSObject
            }else if keytype == "BasicFnshTime" {
                let dueTime = SODataDuration()
                let dueTimeArray = dueDateTimeTextField.text?.components(separatedBy: ":")
                dueTime.hours = Int(dueTimeArray![0]) as NSNumber?
                dueTime.minutes = Int(dueTimeArray![1]) as NSNumber?
                dueTime.seconds = 0
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = dueTime
                singleWorkOrder.BasicFnshTime = dueTime
            }else if keytype == "BasicStrtDate" {
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = ODSDateHelper.getDateFromString(dateString: self.basicDateTextField.text!, dateFormat: localDateFormate) as NSObject
            }else if keytype == "BasicStrtTime" {
                let basicTime = SODataDuration()
                let dueTimeArray = basicTimeTextField.text?.components(separatedBy: ":")
                basicTime.hours = Int(dueTimeArray![0]) as NSNumber?
                basicTime.minutes = Int(dueTimeArray![1]) as NSNumber?
                basicTime.seconds = 0
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = basicTime
                singleWorkOrder.BasicStrtTime = basicTime
            }else if keytype == "BusArea" {
                let busAreaArray = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if busAreaArray.count > 0 {
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = busAreaArray[0] as NSObject
                    singleWorkOrder.BusArea = busAreaArray[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.BusArea = ""
                }
            }else if keytype == "BusAreaText" {
                let busAreaArray = self.businessAreaTextField.text!.components(separatedBy: " - ")
                if busAreaArray.count > 0 {
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = busAreaArray[1] as NSObject
                    singleWorkOrder.BusArea = busAreaArray[1]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.BusArea = ""
                }
            }else if keytype == "CategoryText" {
                let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
                if typeArray.count > 1 {
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = typeArray[1] as NSObject
                    singleWorkOrder.CategoryText = typeArray[1]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.CategoryText = ""
                }
            }else if keytype == "EquipNum" {
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = self.equipmentTextField.text! as NSObject
                singleWorkOrder.EquipNum = self.equipmentTextField.text!
            }else if keytype == "FuncLocation" {
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = self.functionalLocationTextField.text! as NSObject
                singleWorkOrder.FuncLocation = self.functionalLocationTextField.text!
            }else if keytype == "MainWorkCtr" {
                let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = arr[0] as NSObject
                    singleWorkOrder.MainWorkCtr = arr[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.MainWorkCtr = ""
                }
            }else if keytype == "MaintPlanningPlant" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0 ]as NSObject
                    singleWorkOrder.MaintPlanningPlant = plantFilteredArray[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.MaintPlanningPlant = ""
                }
            }else if keytype == "MaintPlant" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                    singleWorkOrder.MaintPlant = plantFilteredArray[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.MaintPlant = ""
                }
            }else if keytype == "OrderType" {
                let typeArray = self.typeTextField.text!.components(separatedBy: " - ")
                if typeArray.count > 0 {
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = typeArray[0] as NSObject
                    singleWorkOrder.CategoryText = typeArray[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.CategoryText = ""
                }
            }else if keytype == "PersonResponsible" {
                if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    let perrespArray = self.personResponsibleTextField.text!.components(separatedBy: " - ")
                    if perrespArray.count > 0 {
                        let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == perrespArray[0] && $0.EmplApplName == "\(perrespArray[1])"}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = personResponsibleClass.PersonnelNo as NSObject
                            singleWorkOrder.PersonResponsible = personResponsibleClass.PersonnelNo
                        }else{
                            (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                            singleWorkOrder.PersonResponsible = ""
                        }
                    }
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.PersonResponsible = ""
                }
            }else if keytype == "Plant" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                    singleWorkOrder.Plant = plantFilteredArray[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.Plant = ""
                }
            }else if keytype == "PlantMainWorkCtr" {
                let plantFilteredArray = self.plantTextField.text!.components(separatedBy: " - ")
                if plantFilteredArray.count > 0{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = plantFilteredArray[0] as NSObject
                    singleWorkOrder.PlantMainWorkCtr = plantFilteredArray[0]
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.PlantMainWorkCtr = ""
                }
            }else if keytype == "Priority" {
                let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(self.priorityTextField.text!))"}
                if priorityFilteredArray.count > 0{
                    let priorityClass = priorityFilteredArray[0]
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = priorityClass.Priority as NSObject
                    singleWorkOrder.Priority = priorityClass.Priority
                }else{
                    (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                    singleWorkOrder.Priority = ""
                }
            }else if keytype == "ShortText" {
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = descriptionViewTextField.text! as NSObject
                singleWorkOrder.ShortText = self.descriptionViewTextField.text!
            }else if keytype == "StatusFlag"{
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                singleWorkOrder.StatusFlag = ""
            }else if keytype == "TransferFlag"{
                (singleWorkOrder.entity.properties[keytype] as! SODataProperty).value = "" as NSObject
                singleWorkOrder.StatusFlag = ""
            }else if keytype == "UserStaus"{
                if self.userStatusTextField.text != selectStr && self.userStatusTextField.text != ""{
                    let arr = self.userStatusTextField.text!.components(separatedBy: " - ")
                    if arr.count > 0{
                        let statusCode = arr[0]
                        let arr1 = self.statusArray.filter{$0.StatusCode == "\(statusCode)"}
                        if arr1.count > 0{
                            let taskstatus = arr1[0]
                            let statusesArr = singleWorkOrder.UserStatus.components(separatedBy: " ")
                            if !statusesArr.contains("\(statusCode)"){
                                (singleWorkOrder.entity.properties["UserStatus"] as! SODataProperty).value = "\(singleWorkOrder.UserStatus) \(statusCode)" as NSObject
                            }
                            (singleWorkOrder.entity.properties["UserStatusCode"] as! SODataProperty).value = taskstatus.UserStatusCode as NSObject
                            singleWorkOrder.UserStatus = taskstatus.StatusCode
                            (singleWorkOrder.entity.properties["StatusFlag"] as! SODataProperty).value = "Y" as NSObject
                        }else{
                            (singleWorkOrder.entity.properties["StatusFlag"] as! SODataProperty).value = "" as NSObject
                        }
                    }else{
                        (singleWorkOrder.entity.properties["StatusFlag"] as! SODataProperty).value = "" as NSObject
                    }
                }else{
                    (singleWorkOrder.entity.properties["StatusFlag"] as! SODataProperty).value = "" as NSObject
                }
            }
        }
        var flushReq = Bool()
        if self.noteTextView.text! == "" {
            flushReq = true
        }else{
            flushReq = false
        }
        WoHeaderModel.updateWorkorderEntity(entity: singleWorkOrder.entity,flushRequired: flushReq ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.successMsg = "Work_Order_is_Updated_successfully".localized()
                mJCLogger.log("Workorder Updated successfully".localized(), Type: "Debug")
                self.createUpdateDelegate?.EntityUpdated?()
                DispatchQueue.main.async {
                    if self.noteTextView.text! == "" {
                        self.successMsg = "Work_Order_is_Updated_successfully".localized()
                        let params = Parameters(
                            title: MessageTitle,
                            message: self.successMsg,
                            cancelButton: okay
                        )
                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0:
                                self.dismiss(animated: false, completion: nil)
                            default: break
                            }
                        }
                    }else{
                        if self.noteTextView.text.count > 0 {
                            self.createNewNote(noteText: self.noteTextView.text, Workorder: selectedworkOrderNumber)
                            self.noteTextView.text = ""
                        }
                    }
                }
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Workorder_update_fails_try_again".localized(), button: okay)
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func editOnlineWorkorder() {
        
        mJCLogger.log("Starting", Type: "info")
        let entityset = singleWorkOrder.entityValue.entitySet
        
        let entitype = entityset.entityType
        var propety = SODataV4_Property.init()
        let resultentity = singleWorkOrder.entityValue
        let options = SODataV4_RequestOptions.new()
        options.updateMode = SODataV4_UpdateMode.replace
        
        propety = entitype.getProperty("ShortText")
        propety.setString(resultentity, descriptionViewTextField.text!)
        singleWorkOrder.ShortText = descriptionViewTextField.text!
        
        propety = entitype.getProperty("MainWorkCtr")
        let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
        if arr.count > 0{
            propety.setString(resultentity, arr[0])
            singleWorkOrder.MainWorkCtr = arr[0]
        }else{
            propety.setString(resultentity, "")
            singleWorkOrder.MainWorkCtr = ""
        }
        
        propety = entitype.getProperty("BusArea")
        let busAreaArray = self.businessAreaTextField.text!.components(separatedBy: " - ")
        if busAreaArray.count > 0 {
            propety.setString(resultentity, busAreaArray[0])
            singleWorkOrder.BusArea =  busAreaArray[0]
        }else{
            propety.setString(resultentity, "")
            singleWorkOrder.BusArea =  ""
        }
        propety = entitype.getProperty("BusAreaText")
        if busAreaArray.count > 1 {
            propety.setString(resultentity, busAreaArray[1])
            singleWorkOrder.BusArea =  busAreaArray[1]
        }else{
            propety.setString(resultentity, "")
            singleWorkOrder.BusArea =  ""
        }
        propety = entitype.getProperty("Priority")
        let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(self.priorityTextField.text!)"}
        if priorityFilteredArray.count > 0{
            let priorityClass = priorityFilteredArray[0]
            propety.setString(resultentity, priorityClass.Priority)
            singleWorkOrder.Priority = priorityClass.Priority
        }else{
            propety.setString(resultentity, "")
            singleWorkOrder.Priority = ""
        }
        propety = entitype.getProperty("FuncLocation")
        propety.setString(resultentity, functionalLocationTextField.text!)
        singleWorkOrder.FuncLocation = functionalLocationTextField.text!
        
        propety = entitype.getProperty("EquipNum")
        propety.setString(resultentity, equipmentTextField.text!)
        singleWorkOrder.EquipNum = equipmentTextField.text!
        
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        
        let respDict = WoHeaderModel.updateOnlineWorkorderEntity(httpcon: httpConvMan!, entityValue: resultentity)
        if let status = respDict["Status"] as? String{
            if status == "Success"{
                mJCLogger.log("Work_Order_is_Updated_successfully".localized(), Type: "Debug")
                mJCLoader.stopAnimating()
                self.createUpdateDelegate?.EntityUpdated?()
                self.successMsg = "Work_Order_is_Updated_successfully".localized()
                let params = Parameters(
                    title: MessageTitle,
                    message: self.successMsg,
                    cancelButton: okay
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        self.dismiss(animated: false, completion: nil)
                    default: break
                    }
                }
            }else if status == "-1"{
                mJCLoader.stopAnimating()
                mJCLogger.log("Update Entity Error \(respDict["Error"] ?? "")", Type: "Error")
                print("Update Entity Error \(respDict["Error"] ?? "")")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "\(respDict["Error"] ?? "")", button: okay)
            }
        }else{
            mJCLogger.log(somethingwrongalert, Type: "Error")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create Note..
    func createNewNote(noteText:String, Workorder: String) {
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = noteText as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        self.property.add(prop!)
        
        let WorkorderStr = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: Workorder)
        prop = SODataPropertyDefault(name: "TextName")
        prop!.value = WorkorderStr as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = "\(Workorder)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = Workorder as NSObject
        self.property.add(prop!)
        
        var longTextSetEntity = String()
        var longTextCollectionPath = String()
        
        var textObject = String()
        textObject = LONG_TEXT_TYPE_WO
        longTextSetEntity = woLongTextSetEntity
        longTextCollectionPath = woLongTextSet
        
        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = textObject as NSObject
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: longTextSetEntity)
        print("----New Note key values----")
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: longTextCollectionPath,flushRequired: true, options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                let params = Parameters(
                    title: MessageTitle,
                    message: "Work_Order_is_created_successfully".localized(),
                    cancelButton: okay
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        self.dismiss(animated: false, completion: nil)
                    default: break
                    }
                }
                mJCLogger.log("New Note Created successfully".localized(), Type: "Debug")
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_Note_try_again".localized(), button: okay)
                mJCLogger.log("Fail_to_create_Note_try_again".localized(), Type: "Error")
                self.dismiss(animated: false, completion: nil)
            }
        })
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
    //MARK:- Get standarded text ..
    func getStandardText() {
        mJCLogger.log("Starting", Type: "info")
        StandardTextModel.getStandardText(){ (response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [StandardTextModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
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
                        self.standardTextField.optionArray = self.standardTextNameArray
                        self.standardTextField.checkMarkEnabled = false
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func checkOnlineWorkOrdersButtonAction(_ sender: Any) {
    }
    @IBAction func userStatusButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.statusListArray.count > 0 {
            dropDown.anchorView = self.userStatusTextFieldView
            let arr : [String] = self.statusListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "UserStatus"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Not using methods
    @IBAction func mainWorkCenterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.workCentersListArray.count > 0 {
            dropDown.anchorView = self.mainWorkCenterTextFieldView
            let arr : [String] = self.workCentersListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "WorkCenters_DropDown".localized()
            dropDown.show()
        }else {
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func activityTypeBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.activityListArray.count > 0 {
            dropDown.anchorView = self.ActivityTypeTextFieldView
            let arr : [String] = self.activityListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "Activity_DropDown".localized()
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
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
    @IBAction func businessAreaButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.businessAreaListArray.count > 0 {
            dropDown.anchorView = self.businessAreaTextFieldView
            let arr : [String] = self.businessAreaListArray
            dropDown.dataSource = arr
            dropDownSelectString = "Business_Area_DropDown".localized()
            dropDown.show()
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func plantButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        self.workCentersListArray.removeAll()
        if self.plantArray.count > 0 {
            dropDown.anchorView = self.plantTextFieldView
            let arr : [String] = self.plantArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "Plant_Drop_Down".localized()
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func priorityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.priorityListArray.count > 0 {
            dropDown.anchorView = self.priorityTextFieldView
            let arr : [String] = self.priorityListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "Priority_Drop_Down".localized()
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func typeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.workOrderTypeListArray.count > 0 {
            dropDown.anchorView = self.typeTextFieldView
            let arr : [String] = self.workOrderTypeListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "WorkOrder_Type_DropDown".localized()
            dropDown.show()
        }else {
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
