//
//  CreateJobVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 3/1/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import AssetsLibrary
import ODSFoundation
import mJCLib

class CreateJobVC: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,barcodeDelegate,personResponsibleDelegate,FuncLocEquipSelectDelegate,annotationDelegate{

    //MARK: - Outlet..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var doneButton: UIButton!

    //MainViewOutlet..
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var scrollViewContainerView: UIView!
    
    //TaskTypeView Outlets..
    @IBOutlet var taskTypeView: UIView!
    @IBOutlet var taskTypeTitleLabel: UILabel!
    @IBOutlet var taskTypeTextFieldView: UIView!
    @IBOutlet var taskTypeTextField: iOSDropDown!
    @IBOutlet var taskTypeButton: UIButton!

    //DescriptionView Outlets..
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextFieldView: UIView!
    @IBOutlet var descriptionTextField: UITextField!

    //PriorityView Outlets..
    @IBOutlet var priorityView: UIView!
    @IBOutlet var priorityTitleLabel: UILabel!
    @IBOutlet var priorityTextFieldView: UIView!
    @IBOutlet var priorityTextField: iOSDropDown!
    @IBOutlet var priorityButton: UIButton!

    //StartView Outlets..
    @IBOutlet var startView: UIView!
    @IBOutlet var startDateTitleLabel: UILabel!
    @IBOutlet var startDateTextFieldView: UIView!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var startDateButton: UIButton!
    @IBOutlet var startTimeTextFieldView: UIView!
    @IBOutlet var startTimeTextField: UITextField!
    @IBOutlet var startTimeButton: UIButton!

    //EndView Outlets..
    @IBOutlet var endView: UIView!
    @IBOutlet var endDateTitleLabel: UILabel!
    @IBOutlet var endDateTextFieldView: UIView!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var endDateButton: UIButton!
    @IBOutlet var endTimeTextFieldView: UIView!
    @IBOutlet var endTimeTextField: UITextField!
    @IBOutlet var endTimeButton: UIButton!

    //FunctionalLocationView Outlets..
    @IBOutlet var functionalLocationView: UIView!
    @IBOutlet var functionalLocationTitleLabel: UILabel!
    @IBOutlet var functionalLocationTextFieldView: UIView!
    @IBOutlet var functionalLocationTextField: UITextField!
    @IBOutlet var functionalLocationSelectButton: UIButton!
    @IBOutlet var functionalLocationScanButton: UIButton!

    //EquipmentView Outlets..
    @IBOutlet var equipmentView: UIView!
    @IBOutlet var equipmentTitleLabel: UILabel!
    @IBOutlet var equipmentTextFieldView: UIView!
    @IBOutlet var equipmentTextField: UITextField!
    @IBOutlet var equipmentSelectButton: UIButton!
    @IBOutlet var equipmentScanButton: UIButton!

    // Equipment Warrenty Info Label Outlet
    @IBOutlet var equipWarrantyInfoLabel: UILabel!
    @IBOutlet var equipmentWarrantyView: UIView!
    @IBOutlet var equipmentWarrantyImageView: UIImageView!

    //Plant Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTitleLabel: UILabel!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantTextField: iOSDropDown!
    @IBOutlet var plantButton: UIButton!

    //MainWorkCenterView Outlets..
    @IBOutlet var mainWorkCenterView: UIView!
    @IBOutlet var mainWorkCenterTitleLabel: UILabel!
    @IBOutlet var mainWorkCenterTextFieldView: UIView!
    @IBOutlet var mainWorkCenterTextField: iOSDropDown!
    @IBOutlet var mainWorkCenterButton: UIButton!

    //AttachImageView Outlets..
    @IBOutlet var attachImageView: UIView!
    @IBOutlet var attachImageTitleLabel: UILabel!
    @IBOutlet var attachImageTextFieldView: UIView!
    @IBOutlet var attachImageTextField: UITextField!
    @IBOutlet var attachImageCameraButton: UIButton!
    @IBOutlet var attachImageGallaryButton: UIButton!

    //AttachImageView Outlets..
    @IBOutlet var standardTextView: UIView!
    @IBOutlet var standardTextTitleLabel: UILabel!
    @IBOutlet var standardTextFieldView: UIView!
    @IBOutlet var standardTextField: iOSDropDown!
    @IBOutlet var standardTextbutton: UIButton!

    //DamageGroupView Outlets..
    @IBOutlet var damageGroupView: UIView!
    @IBOutlet var damageGroupTitleLabel: UILabel!
    @IBOutlet var damageGroupTextFieldView: UIView!
    @IBOutlet var damageGroupTextField: iOSDropDown!
    @IBOutlet var damageGroupButton: UIButton!

    //DamageView Outlets..
    @IBOutlet var damageView: UIView!
    @IBOutlet var damageTitleLabel: UILabel!
    @IBOutlet var damageTextFieldView: UIView!
    @IBOutlet var damageTextField: iOSDropDown!
    @IBOutlet var damageButton: UIButton!

    //PartGroupView Outlets..
    @IBOutlet var partGroupView: UIView!
    @IBOutlet var partGroupTitleLabel: UILabel!
    @IBOutlet var partGroupTextFieldView: UIView!
    @IBOutlet var partGroupTextField: iOSDropDown!
    @IBOutlet var partGroupButton: UIButton!

    //PartView Outlets..
    @IBOutlet var partView: UIView!
    @IBOutlet var partTitleLabel: UILabel!
    @IBOutlet var partTextFieldView: UIView!
    @IBOutlet var partTextField: iOSDropDown!
    @IBOutlet var partButton: UIButton!

    //CauseGroupView Outlets..
    @IBOutlet var causeGroupView: UIView!
    @IBOutlet var causeGroupTitleLabel: UILabel!
    @IBOutlet var causeGroupTextFieldView: UIView!
    @IBOutlet var causeGroupTextField: iOSDropDown!
    @IBOutlet var causeGroupButton: UIButton!

    //causeCodeView Outlets..
    @IBOutlet var causeCodeView: UIView!
    @IBOutlet var causeCodeTitleLabel: UILabel!
    @IBOutlet var causeCodeTextFieldView: UIView!
    @IBOutlet var causeCodeTextField: iOSDropDown!
    @IBOutlet var causeCodeButton: UIButton!

    //breakdownView Outlets..
    @IBOutlet var breakdownView: UIView!
    @IBOutlet var breakdownInnerView: UIView!
    @IBOutlet var breakdownTitleLabel: UILabel!
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

    //PlannerView Outlets..
    @IBOutlet var plannerView: UIView!
    @IBOutlet var plannerTitleLabel: UILabel!
    @IBOutlet var plannerTextFieldView: UIView!
    @IBOutlet var plannerTextField: UITextField!
    @IBOutlet var plannerButton: UIButton!

    //ReportedByView Outlets..
    @IBOutlet var reportedByView: UIView!
    @IBOutlet var reportedByTitleLabel: UILabel!
    @IBOutlet var reportedByTextFieldView: UIView!
    @IBOutlet var reportedByTextField: UITextField!
    @IBOutlet var reportedByButton: UIButton!

    //NoteView Outlets..
    @IBOutlet var noteView: UIView!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var noteTextViewView: UIView!
    @IBOutlet var noteTextView: UITextView!

    //buttonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var checkOnlineButton: UIButton!
    var createUpdateDelegate:CreateUpdateDelegate?

    //MARK: - Declared Variables..

    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var breakDownSwitchState = Bool()

    var notifTypeArray = [NotificationTypeModel]()
    var notificationTypeListArray = [String]()

    var priorityArray = [PriorityListModel]()
    var priorityListArray = [String]()

    var workCentersArray = [WorkCenterModel]()
    var workCentersListArray = [String]()

    var maintPlantArray = [MaintencePlantModel]()
    var plantArray = [String]()
    var planingPlantArray = [String]()
    var associatePlantArray = [String]()

    var damageGroupArray = [CatalogProfileModel]()
    var damageGroupListArray = [String]()
    var selectedDamageGropArray = [String]()

    var damageArray = Array<CodeGroupModel>()
    var damageListArray = [String]()
    var selectedDamageArray = [String]()

    var partGroupArray = [CatalogProfileModel]()
    var partGroupListArray = [String]()
    var selectedPartGroupArray = [String]()

    var partArray = Array<CodeGroupModel>()
    var partListArray = [String]()
    var selectedPartArray = [String]()

    var causeGroupArray = [CatalogProfileModel]()
    var causeGroupListArray = [String]()
    var selectedCauseGroupArray = [String]()

    var causeCodeArray = Array<CodeGroupModel>()
    var causeCodeListArray = [String]()
    var selectedCauseArray = [String]()

    var StandardTextArray = Array<StandardTextModel>()

    var uploadImgDescription = String()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var equipmentfrompoints = String()
    var funclocfrompoints = String()
    var image = UIImage()
    var isImageUpload = Bool()
    var isFromEdit = Bool()
    var isScreen = String()
    var itemClass = NotificationItemsModel()
    var isFromMap = Bool()
    var equipmentStr = String()
    var notificationNumber = String()
    var selectDateAndTime = NSString()
    var typeOfScanCode = String()
    var selectedPlant = String()
    var selectedMainWorkCenter = String()
    var isSelectedFunLoc = Bool()
    var selectedbutton = String()
    var standardTextNameArray = [String]()
    var catlogprof = String()



    //MARK: - LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")

        self.getMaintPlantList()
        self.setViewBorder()
        self.setBasicData()
        self.getPriorityList()
        self.getPersonResponsibleList()
        self.getNotificationType()
        self.getStandardText()
        self.descriptionTextField.delegate = self
        self.noteTextView.delegate = self
        self.standardTextField.delegate = self
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "TaskTypeDropDown" {
                self.taskTypeTextField.text = item
                self.getAllGroupValuse()
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "PlantDropDown" {
                self.plantTextField.text = item
                self.dropDownSelectString = ""
                self.setWorkCenterValue()
            }else if self.dropDownSelectString == "PriorityDropDown" {
                self.priorityTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "WorkCentersDropDown" {
                self.mainWorkCenterTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "DamageGroupDropDown" {
                self.damageGroupTextField.text = item
                let damageGroupArr = self.damageGroupTextField.text!.components(separatedBy: " - ")
                if damageGroupArr.count > 0{
                    self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: damageGroupArr[0])
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "DamageDropDown" {
                self.damageTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "PersonResponsibleDropDown" {
                self.plannerTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "CauseGroupDropDown" {
                self.causeGroupTextField.text = item
                let causegrpArr = self.causeGroupTextField.text!.components(separatedBy: " - ")
                if causegrpArr.count > 0{
                    self.getCauseValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: causegrpArr[0])
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "CauseCodeDropDown" {
                self.causeCodeTextField.text = item
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateJobVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        if isFromMap == true {
            self.equipmentValidation()
        }
        mJCLogger.log("Ended", Type: "info")
        
        //Damage group
        self.damageGroupTextField.didSelect{(selectedText , index , id) in
            self.damageGroupTextField.text = selectedText
            let damageGroupArr = self.damageGroupTextField.text!.components(separatedBy: " - ")
            if damageGroupArr.count > 0{
                self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: damageGroupArr[0])
            }
        }
        //Damage
        self.damageTextField.didSelect{(selectedText , index , id) in
            self.damageTextField.text = selectedText
        }
        
        //Cause group
        self.causeGroupTextField.didSelect{(selectedText , index , id) in
            self.causeGroupTextField.text = selectedText
            let causegrpArr = self.causeGroupTextField.text!.components(separatedBy: " - ")
            if causegrpArr.count > 0{
                self.getCauseValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: causegrpArr[0])
            }
        }
        
        //Cause code
        self.causeCodeTextField.didSelect{(selectedText , index , id) in
            self.causeCodeTextField.text = selectedText
        }
        
        //Part group
        self.partGroupTextField.didSelect{(selectedText , index , id) in
            self.partGroupTextField.text = selectedText
            let partgrpArr = selectedText.components(separatedBy: " - ")
            if partgrpArr.count > 0{
                self.getPartValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: partgrpArr[0])
            }
        }
        
        //Part
        self.partTextField.didSelect{(selectedText , index , id) in
            self.partTextField.text = selectedText
        }
        
        //Task type
        self.taskTypeTextField.didSelect { selectedTaskType, index, id in
            self.taskTypeTextField.text = selectedTaskType
            self.getAllGroupValuse()
        }
        
        //Priority
        self.priorityTextField.didSelect { selectedPriority, index, id in
            self.priorityTextField.text = selectedPriority
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
        
        //Plant
        self.plantTextField.didSelect { selectedText, index, id in
            self.plantTextField.text = selectedText
            self.setWorkCenterValue()
        }
        
        //Mainwork center
        self.mainWorkCenterTextField.didSelect { selectedText, index, id in
            self.mainWorkCenterTextField.text = selectedText
        }
    }
    open override var shouldAutorotate: Bool {
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }

    func equipmentValidation() {
        mJCLogger.log("Starting", Type: "info")
        if totalEquipmentListArray.contains(self.equipmentStr) {
            self.equipmentTextField.text = self.equipmentStr
            for i in 0..<totalEquipmentArray.count{
                let equipmentClass = totalEquipmentArray[i]
                if equipmentClass.Equipment == self.equipmentStr{
                    self.functionalLocationTextField.text = equipmentClass.FuncLocation
                }
            }
        }else {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "couldn’t_find_equipment_for_id".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.descriptionTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.malfunctionEndDateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.endDateTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.equipmentTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.functionalLocationTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.damageGroupTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.damageTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.causeGroupTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.causeCodeTitleLabel)
    }
    //MARK: - Button Action..
    @IBAction func startDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "StartDate"
        self.allTextFieldResign()
        ODSPicker.selectDate(title: "Select_Start_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: Date(), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.endDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.endDateTextField.text)!){
                    self?.startDateTextField.text = selectedDate.dateString(localDateFormate)
                }
                else{
                    self?.endDateTextField.text = ""
                    self?.startDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            }
            else{
                self?.startDateTextField.text = selectedDate.dateString(localDateFormate)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func startTimeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "StartTime"
        self.allTextFieldResign()
        
        if ODSDateHelper.compareTwoDates(fromDate: self.startDateTextField.text!, toDate: self.endDateTextField.text!){
            let startDate = ODSDateHelper.restrictHoursOnCurrentTimer()
            let endDate = ODSDateHelper.restrictMiniutsOnCurrentTimer()
            ODSPicker.selectDate(title: "Select_Basic_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, minDate: startDate as Date, maxDate: endDate as Date, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.startTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        else{
            ODSPicker.selectDate(title: "Select_Start_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.startTimeTextField.text = selectedDate.dateString(localTimeFormat)
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func endDateButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "EndDate"
        self.allTextFieldResign()
        if startDateTextField.text!.count > 0 {
            let fromDate = ODSDateHelper.getDateFromString(dateString: startDateTextField.text!, dateFormat: localDateFormate)
                ODSPicker.selectDate(title: "Select_End_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, minDate: fromDate, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                    if !(self?.startDateTextField.text!.isEmpty)! {
                        if ODSDateHelper.compareTwoDates(fromDate: (self?.startDateTextField.text)!, toDate: selectedDate.dateString(localDateFormate)){
                            self?.endDateTextField.text = selectedDate.dateString(localDateFormate)
                        }
                        else{
                            self?.endDateTextField.text = ""
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized(), button: okay)
                        }
                    }
                    else{
                        self?.endDateTextField.text = selectedDate.dateString(localDateFormate)
                    }
                })
        }else{
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_Start_Date".localized() , button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func endTimeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        selectDateAndTime = "EndTime"
        self.allTextFieldResign()
        if ODSDateHelper.compareTwoDates(fromDate: self.startDateTextField.text!, toDate: self.endDateTextField.text!){
            ODSPicker.selectDate(title: "Select_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                self?.endTimeTextField.text = selectedDate.dateString(localTimeFormat)
                let startDateStr = "\(self!.startDateTextField.text!) \(self!.startTimeTextField.text!)"
                let endDateStr = "\(self!.endDateTextField.text!) \(self!.endTimeTextField.text!)"
                let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startDateStr, timeFormate: localDateTimeFormate)
                let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endDateStr, timeFormate: localDateTimeFormate)
                if startTime != nil && endTime != nil{
                    if startTime! >= endTime!{
                        self!.endTimeTextField.text = ""
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
            if startTimeTextField.text!.count > 0 && startDateTextField.text!.count > 0 {
                ODSPicker.selectDate(title: "Select_End_Time".localized(), cancelText: "Cancel".localized(), datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
                    self?.endTimeTextField.text = selectedDate.dateString(localTimeFormat)
                })
                mJCLogger.log("Ended", Type: "info")
            }
            else{
                endDateTextField.text = ""
                mJCLogger.log("Please_Select_Start_time".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Start_time".localized(), button: okay)
                return
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func functionalLocationSelectButtonAction(sender: AnyObject) {
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
    @IBAction func equipmentSelectButtonAction(sender: AnyObject) {
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
    
    @IBAction func attachImageGallaryAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.openPhotoLibrary()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func attachImageCameraAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.openCamera()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func breakdownSwitchAction(sender: UISwitch) {
        mJCLogger.log("Starting", Type: "info")
        if sender.isOn == true {
            breakDownSwitchState = true
            self.malfunctionStartDateView.isHidden = false
            self.malfunctionEndDateView.isHidden = false
        }else {
            breakDownSwitchState = false
            self.malfunctionStartDateView.isHidden = true
            self.malfunctionEndDateView.isHidden = true
        }
        self.allTextFieldResign()
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
                        mJCLogger.log("Please_Select_Start_time".localized(), Type: "Debug")
                        self!.malfunctionEndTimeTextField.text = ""
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_valid_time".localized() , button: okay)
                        return
                    }
                }else{
                    mJCLogger.log("Please_Select_Start_time".localized(), Type: "Debug")
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
    @IBAction func plannerButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let personRespVC = ScreenManager.getPersonResponsibleListScreen()
        personRespVC.modalPresentationStyle = .fullScreen
        personRespVC.delegate = self
        personRespVC.isFrom = "planner"
        self.present(personRespVC, animated: false)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func reportedyButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let personRespVC = ScreenManager.getPersonResponsibleListScreen()
        personRespVC.modalPresentationStyle = .fullScreen
        personRespVC.delegate = self
        personRespVC.isFrom = "reportedBy"
        self.present(personRespVC, animated: false)
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func checkOnlineNotificationsList(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        showOnlineSearchPopUp(searchType:"Notifications")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if breakDownSwitchState == true {
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
        if descriptionTextField.text == "" {
            mJCLogger.log("Please_enter_description".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_description".localized(), button: okay)
            return
        }else if endDateTextField.text == "" {
            mJCLogger.log("Please_select_end_date_and_time".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_end_date_and_time".localized(), button: okay)
            return
        }else if endTimeTextField.text == "" {
            mJCLogger.log("Please_select_end_date_and_time".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_end_date_and_time".localized(), button: okay)
            return
        }else if self.equipmentTextField.text == "" && self.functionalLocationTextField.text == "" {
            mJCLogger.log("Please_Add_Equipment".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Add_Equipment".localized(), button: okay)
            return
        }else if self.damageGroupTextField.text == "" || self.damageGroupTextField.text == nil || self.damageGroupTextField.text == selectStr{
            mJCLogger.log("Please_Select_Damage_Group".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Damage_Group".localized(), button: okay)
            return
        }else if self.damageTextField.text == "" || self.damageTextField.text == nil || self.damageTextField.text == selectStr{
            mJCLogger.log("Please_Select_Damage".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Damage".localized(), button: okay)
            return
        }else if self.causeGroupTextField.text == "" || self.causeGroupTextField.text == nil || self.causeGroupTextField.text == selectStr {
            mJCLogger.log("Please_Select_Cause_Group".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Cause_Group".localized(), button: okay)
            return
        }else if self.causeCodeTextField.text == "" || self.causeCodeTextField.text == nil || self.causeCodeTextField.text == selectStr {
            mJCLogger.log("Please_Select_Cause_Code".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Cause_Code".localized(), button: okay)
            return
        }else{
            if ENABLE_PARTDETAILS_IN_CREATEJOB_SCREEN{
                if (self.partTextField.text == "" || self.partTextField.text == selectStr) && (self.partGroupTextField.text != "" || self.partGroupTextField.text != selectStr){
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Part".localized(), button: okay)
                    return
                }
            }
            let startDateString = startDateTextField.text! + " " + startTimeTextField.text!
            let endDateString = endDateTextField.text! + " " + endTimeTextField.text!
            let basicDate = ODSDateHelper.getDateFromString(dateString: startDateString, dateFormat: localDateTimeFormate)
            let dueDate = ODSDateHelper.getDateFromString(dateString: endDateString, dateFormat: localDateTimeFormate)
            if dueDate < basicDate {
                mJCLogger.log("Start_date_can't_fall_after_finish".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Start_date_can't_fall_after_finish".localized(), button: okay)
                return
            }else {
                self.createNewNotification()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: {})
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.isSelectedFunLoc = false
        self.setBasicData()
        self.setPriorityValue()
        self.setWorkCenterValue()
        self.setPersonResponsible()
        self.setReportedBy()
        self.getAllGroupValuse()
        self.setNotificationType()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Get and Set Data..
    func getNotificationType() {
        mJCLogger.log("Starting", Type: "info")
        self.notifTypeArray.removeAll()
        self.notifTypeArray = notificationTypeArray
        self.setNotificationType()
        mJCLogger.log("Ended", Type: "info")

    }
    func setNotificationType()  {
        mJCLogger.log("Starting", Type: "info")
        self.notificationTypeListArray.removeAll()
        for item in self.notifTypeArray {
            self.notificationTypeListArray.append(item.NotifictnType + " - " + item.NotificationTypeText)
        }
        if self.isFromEdit == false {
            if notificationTypeListArray.count > 0{
                self.taskTypeTextField.text = self.notificationTypeListArray[0]
            }
        }
        
        if self.notificationTypeListArray.count > 0{
            self.taskTypeTextField.optionArray = self.notificationTypeListArray
            self.taskTypeTextField.checkMarkEnabled = false
        }
        self.getAllGroupValuse()
        mJCLogger.log("Ended", Type: "info")
    }
    func getPriorityList()  {
        mJCLogger.log("Starting", Type: "info")
        self.priorityArray.removeAll()
        if globalPriorityArray.count > 0 {
            self.priorityArray = globalPriorityArray
            self.setPriorityValue()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Priority..
    func setPriorityValue()  {
        mJCLogger.log("Starting", Type: "info")
        self.priorityListArray.removeAll()
        DispatchQueue.main.async {
            var isSetPriority = false
            for item in self.priorityArray {
                self.priorityListArray.append(item.PriorityText)
                if self.isFromEdit == true {
                    if singleWorkOrder.Priority == item.Priority {
                        self.priorityTextField.text = item.PriorityText
                    }
                }else if self.isFromEdit == false {
                    if isSetPriority == false {
                        if self.isScreen == "NotificationOverView" {
                            if singleNotification.Priority == item.Priority {
                                self.priorityTextField.text = item.PriorityText
                                isSetPriority = true
                            }
                        }else if self.isScreen == "WorkOrder" {
                            if self.priorityListArray.count > 0{
                                self.priorityTextField.text = self.priorityListArray[0]
                                isSetPriority = true
                            }
                        }else if self.isScreen == "recordpoints" || self.isScreen == "dashboard"{
                            if self.priorityListArray.count > 0{
                                self.priorityTextField.text = self.priorityListArray[0]
                                isSetPriority = true
                            }
                        }
                    }
                }
            }
            //Priority
            DispatchQueue.main.async {
                if self.priorityListArray.count > 0{
                    self.priorityTextField.optionArray = self.priorityListArray
                    self.priorityTextField.checkMarkEnabled = false
                }
            }
            mJCLogger.log("setPriorityValue End".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Get mainPlant
    func getMaintPlantList()  {
        mJCLogger.log("Starting", Type: "info")
        self.maintPlantArray.removeAll()
        if globalPlanningPlantArray.count > 0 {
            self.maintPlantArray =  globalPlanningPlantArray
            self.setMaintPlantValue()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setMaintPlantValue() {
        mJCLogger.log("Starting", Type: "info")
        self.plantArray.removeAll()
        self.planingPlantArray.removeAll()
        self.associatePlantArray.removeAll()
        DispatchQueue.main.async {
            var plantStr = String()
            for item in self.maintPlantArray {
                self.plantArray.append("\(item.Plant) - \(item.Name1)")
                self.planingPlantArray.append("\(item.PlanningPlant) - \(item.Name1)")
                self.associatePlantArray.append("\(item.Plant) - \(item.Name1)")
            }
            if self.isFromEdit == true {
                plantStr = singleWorkOrder.Plant
            }else if self.isFromEdit == false {
                if self.isScreen == "NotificationOverView" {
                    plantStr = singleNotification.MaintPlant
                }else if self.isScreen == "WorkOrder" {
                    plantStr = singleWorkOrder.Plant
                }else{
                    plantStr = userPlant
                }
            }
            if plantStr == ""{
                plantStr = userPlant
            }
            let filterArr = self.maintPlantArray.filter{$0.Plant == plantStr}
            if filterArr.count > 0{
                let cls = filterArr[0]
                self.plantTextField.text = (cls.Plant + " - " + cls.Name1)
            }else{
                if self.workCentersListArray.count > 0{
                    self.plantTextField.text = self.workCentersListArray[0]
                }
            }
            self.getWorkCentersList()
            
            if self.plantArray.count > 0{
                self.plantTextField.optionArray = self.plantArray
                self.plantTextField.checkMarkEnabled = false
            }
            mJCLogger.log("setMaintPlantValue End".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getWorkCentersList()  {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersArray.removeAll()
        if globalWorkCtrArray.count > 0 {
            workCentersArray = globalWorkCtrArray
            self.setWorkCenterValue()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }

    //Set WorkCenter..
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
            
            if self.workCentersArray.count > 0{
                self.mainWorkCenterTextField.optionArray = self.workCentersListArray
                self.mainWorkCenterTextField.checkMarkEnabled = false
            }
            var workCenterStr = String()
            if self.isFromEdit == true {
                workCenterStr = singleNotification.WorkCenter
            }else if self.isFromEdit == false {
                if self.isScreen == "NotificationOverView" {
                    workCenterStr = singleNotification.WorkCenter
                }else if self.isScreen == "WorkOrder" {
                    workCenterStr = singleNotification.WorkCenter
                }else if self.isScreen == "recordpoints" || self.isScreen == "dashboard"{
                    workCenterStr = ""
                    self.equipmentTextField.text  = self.equipmentfrompoints
                    if self.equipmentfrompoints != ""{
                        self.getFunctionallocation(equipmentno: self.equipmentfrompoints)
                    }
                    self.functionalLocationTextField.text = self.funclocfrompoints
                }
            }
            if workCenterStr == "" && self.workCentersListArray.count > 0{
                let filterArr = self.workCentersArray.filter{$0.WorkCenter == userWorkcenter}
                if filterArr.count > 0{
                    let cls = filterArr[0]
                    self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                }
            }else if self.workCentersListArray.count > 0{
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
            mJCLogger.log("setWorkCenterValue End".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
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
                        self.standardTextNameArray.append( self.StandardTextArray[i].StandardTextName)
                    }
                    if self.standardTextNameArray.count > 0{
                        self.standardTextField.optionArray = self.standardTextNameArray
                        self.standardTextField.checkMarkEnabled = false
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPersonResponsibleList(){
        mJCLogger.log("Starting", Type: "info")
        self.setPersonResponsible()
        self.setReportedBy()
        mJCLogger.log("Ended", Type: "info")
    }
    func setPersonResponsible() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            let personRespArray = globalPersonRespArray.filter{$0.PersonnelNo == "\(userPersonnelNo)"}
            if personRespArray.count > 0{
                let personRes = personRespArray[0]
                self.plannerTextField.text = personRes.SystemID + " - " + personRes.EmplApplName
            }else{
                if globalPersonRespArray.count > 0{
                    let personRes = globalPersonRespArray[0]
                    self.plannerTextField.text = personRes.SystemID + " - " + personRes.EmplApplName
                }else{
                    self.plannerTextField.text = ""
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
    func showOnlineSearchPopUp(searchType:String){

    }
    func updatedImgData(imgData:NSData,FileName:String,Description:String) {
        mJCLogger.log("Starting", Type: "info")
        self.image =  UIImage(data: imgData as Data)!
        self.isImageUpload = true
        self.attachImageTextField.text = FileName
        self.uploadImgDescription = Description
        mJCLogger.log("Ended", Type: "info")
    }
    func getFunctionallocation(equipmentno: String){
        mJCLogger.log("Starting", Type: "info")
        EquipmentModel.getEquipmentDetails(equipNum: equipmentno){ (response, error)  in
            if(error == nil) {
                if let responseArr = response["data"] as? [EquipmentModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")

                    if responseArr.count > 0{
                        DispatchQueue.main.async {
                            let equipCls = responseArr[0]
                            self.functionalLocationTextField.text = equipCls.FuncLocation
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")

                    DispatchQueue.main.async {
                        self.functionalLocationTextField.text = ""
                    }
                }
            }else{
                mJCLogger.log("\(error?.localizedDescription ?? "")", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")

    }
    //MARK: - Get ALL Group Values..
    func getAllGroupValuse(){
        // Damege Group
        var searchPredicate = NSPredicate()
        var notifCatProfile = ""
        if self.catlogprof == ""{
            let notificationType = self.taskTypeTextField.text?.components(separatedBy:" - ")
            if notificationType?.count ?? 0 > 0{
                let notificationTypeArr = notificationTypeArray.filter{$0.NotifictnType == "\(notificationType![0])"}
                if notificationTypeArr.count > 0{
                    notifCatProfile = notificationTypeArr[0].CatalogProfile
                }else{
                    notifCatProfile = ""
                }
            }else{
                notifCatProfile = ""
            }
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        self.selectedDamageGropArray.removeAll()
        self.selectedDamageArray.removeAll()
        self.selectedPartGroupArray.removeAll()
        self.selectedPartArray.removeAll()
        self.selectedCauseGroupArray.removeAll()
        self.selectedCauseArray.removeAll()
        myAssetDataManager.removeMandatoryLabel(label: self.partTitleLabel)
        let damgeGropArr = catlogArray.filtered(using: searchPredicate) as Array
        self.damageGroupArray.removeAll()
        self.damageGroupListArray.removeAll()
        self.damageGroupListArray.append(selectStr)
        if let arr = damgeGropArr as? [CatalogProfileModel]{
            self.damageGroupArray = arr
        }
        self.setDamageGroupAndDamageCodeValue()
        //damage groupEnd

        //Cause Group
        if self.catlogprof == ""{
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        self.causeGroupArray.removeAll()
        self.causeGroupListArray.removeAll()
        let filterArray = catlogArray.filtered(using: searchPredicate) as Array
        if let arr = filterArray as? [CatalogProfileModel]{
            self.causeGroupArray = arr
        }
        self.setCauseGroupAndcauseCodeValue()
        // Part group
        if ENABLE_PARTDETAILS_IN_CREATEJOB_SCREEN{
            if self.catlogprof == ""{
                if notifCatProfile == ""{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)'")
                }else{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == %@",notifCatProfile)
                }
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == %@",self.catlogprof)
            }
            let damgeGropArr = catlogArray.filtered(using: searchPredicate) as Array
            self.partGroupArray.removeAll()
            self.partGroupListArray.removeAll()
            self.partGroupListArray.append(selectStr)
            if let arr = damgeGropArr as? [CatalogProfileModel]{
                self.partGroupArray = arr
            }
            self.setPartGroupAndPartValue()
        }
        // Part group end
    }
    //MARK: - Set DamageGroup And Get Damage Code..
    func setDamageGroupAndDamageCodeValue() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.damageGroupListArray.removeAll()
            self.damageGroupListArray.append(selectStr)
            if self.damageGroupArray.count > 0 {
                var codeGrp = [String]()
                if self.damageGroupArray.count > 0{
                    for item in self.damageGroupArray {
                        codeGrp.append("\(item.CodeGroup) - \(item.ShortText)")
                    }
                }
                if codeGrp.count > 0 {
                    let sortedCaseInsensitiveArr = codeGrp.sorted {
                        $0.caseInsensitiveCompare($1) == .orderedAscending
                    }
                    self.damageGroupListArray.append(contentsOf: sortedCaseInsensitiveArr)
                }
            }
            if self.damageGroupListArray.count > 0 {
                self.damageGroupTextField.text = self.damageGroupListArray[0]
                let causegrpArr = self.damageGroupTextField.text!.components(separatedBy: " - ")
                if causegrpArr.count > 0{
                    self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: causegrpArr[0])
                }
            }
        }
        
        //Damage group txt fld
        if self.damageGroupListArray.count > 0 {
            DispatchQueue.main.async {
                self.damageGroupTextField.optionArray = self.damageGroupListArray
                self.damageGroupTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getDamageValue(catalogCode:String, codeGroup:String) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){
            (response, error)  in
            if error == nil{
                self.damageArray.removeAll()
                self.damageListArray.removeAll()
                if let responseArr = response["data"] as? [CodeGroupModel]{
                    DispatchQueue.main.async {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.damageTextFieldView.isHidden = false
                        if responseArr.count > 0{
                            self.damageArray = responseArr.sorted(by: { $0.Code < $1.Code})
                        }
                        self.damageListArray.append(selectStr)
                        for itemCount in 0..<self.damageArray.count {
                            let codeGroupClass = self.damageArray[itemCount]
                            self.damageListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                        }
                        if self.isFromEdit == false {
                            if self.damageListArray.count > 0{
                                self.damageTextField.text = self.damageListArray[0]
                            }
                        }
                        if self.damageListArray.count > 0 {
                            DispatchQueue.main.async {
                                self.damageTextField.optionArray = self.damageListArray
                                self.damageTextField.checkMarkEnabled = false
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Get Cause Group and get cause Code Value..
    func setCauseGroupAndcauseCodeValue() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.causeGroupListArray.removeAll()
            self.causeGroupListArray.append(selectStr)
            if self.causeGroupArray.count > 0 {
                var codeGrp = [String]()
                if self.causeGroupArray.count > 0{
                    for item in self.causeGroupArray {
                        codeGrp.append("\(item.CodeGroup) - \(item.ShortText)")
                    }
                }
                if codeGrp.count > 0 {
                    let sortedCaseInsensitiveArr = codeGrp.sorted {
                        $0.caseInsensitiveCompare($1) == .orderedAscending
                    }
                    self.causeGroupListArray.append(contentsOf: sortedCaseInsensitiveArr)
                }
            }
            if self.causeGroupListArray.count > 0 {
                self.causeGroupTextField.text = self.causeGroupListArray[0]
                let causegrpArr = self.causeGroupTextField.text!.components(separatedBy: " - ")
                if causegrpArr.count > 0{
                    self.getCauseValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: causegrpArr[0])
                }
            }
            
            //Cause group
            if self.causeGroupListArray.count > 0 {
                DispatchQueue.main.async {
                    self.causeGroupTextField.optionArray = self.causeGroupListArray
                    self.causeGroupTextField.checkMarkEnabled = false
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")

    }
    func getCauseValue(catalogCode:String, codeGroup:String) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){
            (response, error)  in
            if error == nil{
                self.causeCodeArray.removeAll()
                self.causeCodeListArray.removeAll()
                if let responseArr = response["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")

                    DispatchQueue.main.async {
                        self.causeCodeTextFieldView.isHidden = false
                        if responseArr.count > 0{
                            self.causeCodeArray = responseArr.sorted(by: { $0.Code < $1.Code})
                        }
                        self.causeCodeListArray.append(selectStr)
                        for itemCount in 0..<self.causeCodeArray.count {
                            let codeGroupClass = self.causeCodeArray[itemCount]
                            self.causeCodeListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                        }
                        if self.isFromEdit == false {
                            if self.causeCodeListArray.count > 0{
                                self.causeCodeTextField.text = self.causeCodeListArray[0]
                            }
                        }
                        if self.causeCodeListArray.count > 0 {
                            DispatchQueue.main.async {
                                self.causeCodeTextField.optionArray = self.causeCodeListArray
                                self.causeCodeTextField.checkMarkEnabled = false
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found \(error)", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Get PartGroup and set part Value..
    func setPartGroupAndPartValue() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.partGroupListArray.removeAll()
            self.partGroupListArray.append(selectStr)
            if self.partGroupArray.count > 0 {
                var partGrp = [String]()
                if self.partGroupArray.count > 0{
                    for item in self.partGroupArray {
                        partGrp.append("\(item.CodeGroup) - \(item.ShortText)")
                    }
                }
                if partGrp.count > 0 {
                    let sortedCaseInsensitiveArr = partGrp.sorted {
                        $0.caseInsensitiveCompare($1) == .orderedAscending
                    }
                    self.partGroupListArray.append(contentsOf: sortedCaseInsensitiveArr)
                }
            }
            if self.partGroupListArray.count > 0 {
                self.partGroupTextField.text = self.partGroupListArray[0]
                let causegrpArr = self.partGroupTextField.text!.components(separatedBy: " - ")
                if causegrpArr.count > 0{
                    self.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: causegrpArr[0])
                }
                //Part group
                self.partGroupTextField.optionArray = self.partGroupListArray
                self.partGroupTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")

    }
    func getPartValue(catalogCode:String, codeGroup:String) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){
            (response, error)  in
            if error == nil{
                self.partArray.removeAll()
                self.partListArray.removeAll()
                if let responseArr = response["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async {
                        self.partTextFieldView.isHidden = false
                        if responseArr.count > 0{
                            self.partArray = responseArr.sorted(by: { $0.Code < $1.Code})
                        }
                        self.partListArray.append(selectStr)
                        for itemCount in 0..<self.partArray.count {
                            let codeGroupClass = self.partArray[itemCount]
                            self.partListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                        }
                        if self.isFromEdit == false {
                            if self.partListArray.count > 0{
                                self.partTextField.text = self.partListArray[0]
                            }
                        }
                        //Part
                        DispatchQueue.main.async {
                            if self.partListArray.count > 0{
                                self.partTextField.optionArray = self.partListArray
                                self.partTextField.checkMarkEnabled = false
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found \(error)", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
 //MARK: - Select Photo.
    //Open Camera..
    func openCamera() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            self.selectedbutton = "takePhoto"
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = true
                imagePicker.cameraCaptureMode = .photo
                self.present(imagePicker, animated: false, completion: nil)
            }
        }else {
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Open PhotoLibrary..
    func openPhotoLibrary() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            self.selectedbutton = "choosePhoto"
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: false, completion: nil)
            }
        }
        mJCLogger.log("Ended", Type: "info")

    }
    //MARK:  - Set BasicData..
    func setViewBorder() {
        mJCLogger.log("Starting", Type: "info")
        ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.taskTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.mainWorkCenterTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.startTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.startDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.priorityTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.endDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.endTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.damageGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.functionalLocationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.damageTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.equipmentTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.causeGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            ODSUIHelper.setBorderToView(view:self.plannerTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        ODSUIHelper.setBorderToView(view:self.breakdownInnerView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.causeCodeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.attachImageTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.noteTextViewView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionStartDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionStartTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionEndDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.malfunctionEndTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.standardTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        if DeviceType == iPhone {
            ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        ODSUIHelper.setBorderToView(view:self.reportedByTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.attachImageCameraButton.layer.cornerRadius = 15.5
        self.attachImageCameraButton.layer.masksToBounds = true
        self.attachImageGallaryButton.layer.cornerRadius = 15.5
        self.attachImageGallaryButton.layer.masksToBounds = true

        self.equipmentWarrantyView.isHidden = true
        self.malfunctionStartDateView.isHidden = true
        self.malfunctionEndDateView.isHidden = true

        if  NOTIFICATION_ASSIGNMENT_TYPE == "2" {
            self.plannerView.isHidden = true
        }else{
            self.plannerView.isHidden = false
        }
        if ENABLE_REPORTEDBY_IN_CRATEJOB_SCREEN{
            self.reportedByView.isHidden = false
        }else{
            self.reportedByView.isHidden = true
        }
        if ENABLE_PARTDETAILS_IN_CREATEJOB_SCREEN{
            self.partGroupView.isHidden = false
            self.partView.isHidden = false
            ODSUIHelper.setBorderToView(view:self.partGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.partTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }else{
            self.partGroupView.isHidden = true
            self.partView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setBasicData() {
        mJCLogger.log("Starting", Type: "info")
        if(isFromEdit == false) {
            self.headerLabel.text = "Create_New_Job".localized()
            let today = Date()
            let calendar = NSCalendar.current
            self.startDateTextField.text = today.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.startTimeTextField.text = today.toString(format: .custom("HH:mm"))
            self.malfunctionStartDateTextField.text = today.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.malfunctionStartTimeTextField.text = today.toString(format: .custom("HH:mm"))
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today as Date)
            let tomorrowDate =  calendar.date(byAdding: .minute, value: 1, to: tomorrow!)
            self.endDateTextField.text = tomorrowDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.endTimeTextField.text = tomorrowDate?.toString(format: .custom("HH:mm"))
            self.malfunctionEndDateTextField.text = tomorrowDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.malfunctionEndTimeTextField.text = tomorrowDate?.toString(format: .custom("HH:mm"))
            self.descriptionTextField.text = ""
            self.functionalLocationTextField.text = ""
            self.equipmentTextField.text = ""
            self.breakdownSwitch.isOn = false
            self.attachImageTextField.text = ""
            self.noteTextView.text = ""
        }else {
            self.headerLabel.text = "Edit_Job".localized()
            self.startDateTextField.text = Date().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.startTimeTextField.text = Date().toString(format: .custom("HH:mm"))
            self.malfunctionStartDateTextField.text = Date().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            self.malfunctionStartTimeTextField.text = Date().toString(format: .custom("HH:mm"))
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {

        mJCLogger.log("Starting", Type: "info")
        self.descriptionTextField.resignFirstResponder()
        self.noteTextView.resignFirstResponder()
        self.taskTypeTextField.resignFirstResponder()
        self.priorityTextField.resignFirstResponder()
        self.plantTextField.resignFirstResponder()
        self.mainWorkCenterTextField.resignFirstResponder()
        self.standardTextField.resignFirstResponder()
        self.damageGroupTextField.resignFirstResponder()
        self.damageTextField.resignFirstResponder()
        self.partGroupTextField.resignFirstResponder()
        self.partTextField.resignFirstResponder()
        self.causeGroupTextField.resignFirstResponder()
        self.causeCodeTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - CREATE Methods..

    //Create Notification In Odata..
    func createNewNotification() {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Creating_Notification".localized())

        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "Breakdown")

        if self.breakDownSwitchState == true {
            prop = SODataPropertyDefault(name: "Breakdown")
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

        }
        else {
            prop = SODataPropertyDefault(name: "Breakdown")
            prop!.value = "" as NSObject
            property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "BreakdownDur")
        prop!.value = 0 as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotifDate")
        let notifDate = ODSDateHelper.getDateFromString(dateString: self.startDateTextField.text!, dateFormat: localDateFormate).localDate()
        prop!.value = notifDate as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotifTime")
        let notifTime = SODataDuration()
        let notifTimeArray = self.startTimeTextField.text?.components(separatedBy:":")
        notifTime.hours = Int(notifTimeArray![0])! as NSNumber
        notifTime.minutes = Int(notifTimeArray![1])! as NSNumber
        notifTime.seconds = 0
        prop!.value = notifTime
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotificationType")
        let notificationTypeArr = self.taskTypeTextField.text?.components(separatedBy:" - ")
        if notificationTypeArr?.count ?? 0 > 0{
            prop!.value = notificationTypeArr![0] as NSObject
            property.add(prop!)
        }
        let filteredArray = self.priorityArray.filter{$0.PriorityText == "\(self.priorityTextField.text!)"}

        if filteredArray.count != 0 {

            let priorityClass = filteredArray[0]
            prop = SODataPropertyDefault(name: "Priority")
            prop!.value = priorityClass.Priority as NSObject
            property.add(prop!)

            prop = SODataPropertyDefault(name: "PriorityType")
            prop!.value = priorityClass.PriorityType as NSObject
            property.add(prop!)

        }

        prop = SODataPropertyDefault(name: "ShortText")
        prop!.value = "\(self.descriptionTextField.text!)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "FunctionalLoc")
        prop!.value = self.functionalLocationTextField.text! as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Equipment")
        prop!.value = self.equipmentTextField.text! as NSObject
        property.add(prop!)

        if DeviceType == iPhone {
            prop = SODataPropertyDefault(name: "Plant")
            let arr = self.plantTextField.text!.components(separatedBy: " - ")
            if arr.count > 0{
                prop!.value = arr[0] as NSObject
            }else{
                prop!.value = "" as NSObject
            }
            property.add(prop!)
        }

        let arr = self.mainWorkCenterTextField.text!.components(separatedBy: " - ")
        if arr.count > 0{
            let workCenterFilteredArray = self.self.workCentersArray.filter{$0.WorkCenter == "\(arr[0])" && $0.ShortText == "\(arr[1])"}
            if workCenterFilteredArray.count > 0{
                let workCenterClass = workCenterFilteredArray[0]
                prop = SODataPropertyDefault(name: "MaintPlant")
                prop!.value = workCenterClass.Plant as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "MainWorkCenter")
                prop!.value = workCenterClass.WorkCenter as NSObject
                property.add(prop!)
            }
        }

        let randomNotificatioNumber = String.random(length: 11, type: "Number")
        self.notificationNumber = "L\(randomNotificatioNumber)"
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = self.notificationNumber as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = self.notificationNumber as NSObject
        property.add(prop!)

        //Add Extra..
        prop = SODataPropertyDefault(name: "RequiredStartDate")
        prop!.value = notifDate.localDate() as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "RequiredStartTime")
        prop!.value = notifTime
        property.add(prop!)

        prop = SODataPropertyDefault(name: "RequiredEndDate")
        let reqEndDate = ODSDateHelper.getDateFromString(dateString: self.endDateTextField.text!, dateFormat: localDateFormate).localDate()
        prop!.value = reqEndDate as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "RequiredEndTime")
        let reqEndtime = SODataDuration()
        let reqEndtimeArray = self.endTimeTextField.text?.components(separatedBy:":")
        reqEndtime.hours = Int(reqEndtimeArray![0]) as NSNumber?
        reqEndtime.minutes = Int(reqEndtimeArray![1]) as NSNumber?
        reqEndtime.seconds = 0
        prop!.value = reqEndtime
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Partner")
        if  NOTIFICATION_ASSIGNMENT_TYPE == "1"{
            if self.plannerTextField.text != ""{
                let arr = self.plannerTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    let personResponsibleFilteredArray = globalPersonRespArray.filter{$0.SystemID == "\(arr[0])" && $0.EmplApplName == "\(arr[1])"}
                    if personResponsibleFilteredArray.count > 0{
                        let personResponsibleClass = personResponsibleFilteredArray[0]
                        prop!.value = personResponsibleClass.PersonnelNo as NSObject
                    }else{
                        prop!.value = "\(userPersonnelNo)" as NSObject
                    }
                }else{
                    prop!.value = "\(userPersonnelNo)" as NSObject
                }
            }else{
                prop!.value = "\(userPersonnelNo)" as NSObject
            }
        }else{
            prop!.value = "" as NSObject
        }
        property.add(prop!)

        if ENABLE_REPORTEDBY_IN_CRATEJOB_SCREEN{
            prop = SODataPropertyDefault(name: "ReportedBy")
            if self.reportedByTextField.text != ""{
                let arr = self.reportedByTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    let personResponsibleFilteredArray = globalPersonRespArray.filter{$0.SystemID == "\(arr[0])" && $0.EmplApplName == "\(arr[1])"}
                    if personResponsibleFilteredArray.count > 0{
                        let personResponsibleClass = personResponsibleFilteredArray[0]
                        prop!.value = personResponsibleClass.PersonnelNo as NSObject
                    }else{
                        prop!.value = "\(userPersonnelNo)" as NSObject
                    }
                }else{
                    prop!.value = "\(userPersonnelNo)" as NSObject
                }
            }else{
                prop!.value = "\(userPersonnelNo)" as NSObject
            }
            property.add(prop!)
        }else{
            prop = SODataPropertyDefault(name: "ReportedBy")
            prop!.value = userPersonnelNo as NSObject
            property.add(prop!)
        }

        print("====== Create Notification Key Value Start ======")
        let entity = SODataEntityDefault(type: notificationHeaderSetEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name!] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        print("====== Create Notification Key Value End ======")

        NotificationModel.createNotificationEntity(entity: entity!, collectionPath: notificationHeaderSet, flushRequired: false,options: nil, completionHandler: { (response, error) in

            if(error == nil) {
                mJCLoader.stopAnimating()
                mJCLogger.log("Notification_created_successfully", Type: "Debug")
                let params = Parameters(
                    title: alerttitle,
                    message: "Notification_created_successfully".localized(),
                    cancelButton: okay
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        self.createNewItem()
                        mJCLogger.log("Notification Created successfully".localized(), Type: "Debug")
                    default: break
                    }
                }
            }else {
                DispatchQueue.main.async {
                    mJCLoader.stopAnimating()
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    self.createUpdateDelegate?.EntityCreated?()
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
                }
            }
        })

        mJCLogger.log("Ended", Type: "info")
    }

    //Create New Item..
    func createNewItem() {

        mJCLogger.log("Starting", Type: "info")

        mJCLoader.startAnimating(status: "Creating_Item".localized())
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_ITEM)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "ChangedOn")
        let date = Date().localDate()
        prop!.value = date as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = date as NSObject
        property.add(prop!)

        if self.damageTextField.text != "" {

            prop = SODataPropertyDefault(name: "DamageCode")

            let damageArr = self.damageTextField.text!.components(separatedBy: " - ")
            if damageArr.count > 1{

                let damageCodePredicate : NSPredicate = NSPredicate(format: "SELF.Code == %@ and SELF.CodeText == %@",damageArr[0],damageArr[1])

                let codeGroupFilteredArray = (self.damageArray as NSArray).filtered(using: damageCodePredicate) as! [CodeGroupModel]
                if codeGroupFilteredArray.count > 0{
                    let codegroup = codeGroupFilteredArray[0]
                    prop!.value = codegroup.Code as NSObject
                    property.add(prop!)

                    prop = SODataPropertyDefault(name: "Version")
                    prop!.value = codegroup.Version as NSObject
                    property.add(prop!)

                }else{
                    prop!.value = "" as NSObject
                    property.add(prop!)
                }
            }else{
                prop!.value = "" as NSObject
                property.add(prop!)
            }
        }

        if self.damageGroupTextField.text != "" {
            prop = SODataPropertyDefault(name: "DamageCodeGroup")
            let damageGroupArr = self.damageGroupTextField.text!.components(separatedBy: " - ")
            if damageGroupArr.count > 0{
                prop!.value = damageGroupArr[0] as NSObject
                property.add(prop!)
            }
        }
        if self.partGroupTextField.text != "" && self.partGroupTextField.text != selectStr{
            let partGrpArr = self.partGroupTextField.text!.components(separatedBy: " - ")
            if partGrpArr.count > 1{
                prop = SODataPropertyDefault(name: "CodeGroupParts")
                prop!.value = partGrpArr[0] as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "CodeGroupPartsText")
                prop!.value = partGrpArr[1] as NSObject
                property.add(prop!)
            }
        }
        if self.partTextField.text != "" && self.partTextField.text != selectStr{
            let partDrpArr = self.partTextField.text!.components(separatedBy: " - ")
            if partDrpArr.count > 0{
                prop = SODataPropertyDefault(name: "ObjectPartCode")
                prop!.value = partDrpArr[0] as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "ObjectPartCodeText")
                prop!.value = partDrpArr[1] as NSObject
                property.add(prop!)
            }
        }

        prop = SODataPropertyDefault(name: "DefectTypes")
        prop!.value = "\(CATALOGCODE_DAMAGE)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = self.notificationNumber as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "ShortText")
        prop!.value = "\(self.descriptionTextField.text!)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = "0001" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.notificationNumber)" as NSObject
        property.add(prop!)

        print("================= Notification Item Property Start =================")
        let entity = SODataEntityDefault(type: notificationItemSetEntity)
        for prop in property {

            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            print("Key : \(proper.name)")
            print("Value :\(proper.value!)!")
            print("...............")
        }
        print("================= Notification Item Property End =================")

        NotificationItemsModel.createNotificationItemEntity(entity: entity!, collectionPath: notificationItemSet,flushRequired: false, options: nil, completionHandler: { (response, error) in

            if(error == nil) {
                mJCLoader.stopAnimating()
                print("Notification Item Created successfully")
                mJCLogger.log("Notification Item Created successfully".localized(), Type: "Debug")

            }else {
                mJCLoader.stopAnimating()
                print("Notification Item Create fails")
                mJCLogger.log("Notification Item Create fails".localized(), Type: "Error")
            }
            self.createNewItemCause()
        })

        mJCLogger.log("Ended", Type: "info")
    }

    //Create New Item..
    func createNewItemCause() {

        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Creating_Item_Cause".localized())
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_CAUSE)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Cause")
        prop!.value = "0001" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "ChangedOn")
        let date = Date().localDate()
        prop!.value = date as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = date as NSObject
        property.add(prop!)

        if self.causeCodeTextField.text != "" {

            prop = SODataPropertyDefault(name: "CauseCode")

            let causeCodeArr = self.causeCodeTextField.text!.components(separatedBy: " - ")

            if causeCodeArr.count > 1{
                let damageCodePredicate : NSPredicate = NSPredicate(format: "SELF.Code == %@ and SELF.CodeText == %@",causeCodeArr[0],causeCodeArr[1])
                let codeGroupFilteredArray = (self.causeCodeArray as NSArray).filtered(using: damageCodePredicate) as! [CodeGroupModel]
                if codeGroupFilteredArray.count > 0{
                    let codegroup = codeGroupFilteredArray[0]
                    prop!.value = codegroup.Code as NSObject
                    property.add(prop!)

                    prop = SODataPropertyDefault(name: "Version")
                    prop!.value = codegroup.Version as NSObject
                    property.add(prop!)
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        if self.causeGroupTextField.text != "" {
            prop = SODataPropertyDefault(name: "CodeGroup")
            let causeGrpArr = self.causeGroupTextField.text!.components(separatedBy: " - ")
            if causeGrpArr.count > 0{
                prop!.value = causeGrpArr[0] as NSObject
                property.add(prop!)
            }
        }

        prop = SODataPropertyDefault(name: "DefectTypes")
        prop!.value = "\(CATALOGCODE_DAMAGE)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = self.notificationNumber as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "CauseText")
        prop!.value = "\(self.descriptionTextField.text!)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = "0001" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.notificationNumber)" as NSObject
        property.add(prop!)

        print("================= Notification Item Cause Property Start =================")
        let entity = SODataEntityDefault(type: notificationItemCausesSetEntity)
        for prop in property {

            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            print("Key : \(proper.name)")
            print("Value :\(proper.value!)")
            print("...............")
        }
        print("================= Notification Item Cause Property End =================")
        var flushreq = Bool()
        if self.isImageUpload == true {
            flushreq = false
        }else {
            if self.noteTextView.text != "" {
                flushreq = false
            }else {
                flushreq = true
            }
        }
        NotificationItemCauseModel.createNotificationItemCauseEntity(entity: entity!, collectionPath: notificationItemCauseSet, flushRequired: flushreq,options: nil, completionHandler: { (response, error) in
            mJCLoader.stopAnimating()
            if(error == nil) {
                print("Cause-Item Created successfully")
                mJCLogger.log("Cause-Item Created successfully".localized(), Type: "Debug")
            }else {
                print("Cause-Item Create fails")
                mJCLogger.log("\(error?.localizedDescription)".localized(), Type: "Error")
            }
            self.createUpdateDelegate?.EntityCreated?()
            if self.isImageUpload == true {
                self.uploadNotificationAttachment()
            }else {
                if self.noteTextView.text != "" {
                    self.createNewNote(text: self.noteTextView.text)
                }else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: false, completion: {})
                    }
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }

    //Upload Notification Attachment
    func uploadNotificationAttachment() {
        mJCLogger.log("Starting", Type: "info")

        mJCLoader.startAnimating(status: "Uploading_attachment".localized())
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "\(self.uploadImgDescription)" as NSObject
        property.add(prop!)

        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "FILE_NAME")
        prop!.value = "\(self.attachImageTextField.text!)" as NSObject
        property.add(prop!)

        let imgData = self.image.jpegData(compressionQuality: 0.5)! as NSData
        let size = String(imgData.length)
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value = size as NSObject
        property.add(prop!)

        let base64String = imgData.base64EncodedString(options: .lineLength64Characters)
        prop = SODataPropertyDefault(name: "Line")
        prop!.value = base64String as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "image/jpeg" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.notificationNumber)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = self.notificationNumber as NSObject
        property.add(prop!)

        let entity = SODataEntityDefault(type: uploadNOAttachmentContentSetEntity)

        for prop in property {

            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            if (entity?.properties[proper.name] as! SODataProperty).name != "Line"{
                print("Key : \((entity?.properties[proper.name] as! SODataProperty).name)")
                print("Value : \((entity?.properties[proper.name] as! SODataProperty).value)")
                print(".......................")
            }else{
                print("Key : \(proper.name)")
                print("=================")
            }
        }
        var flushreq = Bool()
        if self.noteTextView.text != "" {
            flushreq = false
        }else {
            flushreq = true
        }
        UploadedAttachmentsModel.uploadNoAttachmentEntity(entity: entity!, collectionPath: uploadNOAttachmentContentSet,flushRequired: flushreq, options: nil, completionHandler: { (response, error) in

            mJCLoader.stopAnimating()

            if(error == nil) {
                print("Photo Upload successfully")
                mJCLogger.log("Photo Upload successfully".localized(), Type: "Debug")
            }else {
                print("Photo Upload fails")
                mJCLogger.log("\(error?.localizedDescription)".localized(), Type: "Error")
            }
            DispatchQueue.main.async {
                if self.noteTextView.text != "" {
                    self.createNewNote(text: self.noteTextView.text)
                }else {
                    self.dismiss(animated: false, completion: {})
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }

    func createNewNote(text : String) {

        mJCLogger.log("Starting", Type: "info")

        mJCLoader.startAnimating(status: "Creating_Note".localized())
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TextName")
        prop!.value = self.notificationNumber as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(self.notificationNumber)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.notificationNumber)" as NSObject
        property.add(prop!)

        var longTextSetEntity = String()
        var longTextCollectionPath = String()

        var textObject = String()
        textObject = LONG_TEXT_TYPE_NOTIFICATION
        longTextSetEntity = notificationLongTextSetEntity
        longTextCollectionPath = notificationLongTextSet

        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = textObject as NSObject
        property.add(prop!)

        print("================= Notification LongText Property Start =================")
        let entity = SODataEntityDefault(type: longTextSetEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            print("Key : \(proper.name)")
            print("Value :\(proper.value!)")
            print("...............")
        }
        print("================= Notification LongText Property End =================")

        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: longTextCollectionPath,flushRequired: true, options: nil, completionHandler: { (response, error) in

            mJCLoader.stopAnimating()
            if(error == nil) {
                print("New Note Created successfully")
                mJCLogger.log("New Note Created successfully".localized(), Type: "Debug")
            }
            else {
                print("New Note Created fails")
                mJCLogger.log("\(error?.localizedDescription)".localized(), Type: "Error")
            }
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: {})
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Delegate Methods
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        mJCLogger.log("Starting", Type: "info")
        if respType == "reportedBy"{
            self.reportedByTextField.text = result
        }else if respType == "planner"{
            self.plannerTextField.text = result
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func FuncLocOrEquipSelected(selectedObj: String, EquipObj: EquipmentModel, FuncObj:FunctionalLocationModel) {
        mJCLogger.log("Starting", Type: "info")
        if selectedObj == "Equipment"{
            self.functionalLocationTextField.text = EquipObj.FuncLocation
            self.equipmentTextField.text = EquipObj.Equipment
            self.catlogprof = EquipObj.CatalogProfile
            self.getAllGroupValuse()
        }else if selectedObj == "FunctionalLocation"{
            self.functionalLocationTextField.text = FuncObj.FunctionalLoc
            self.equipmentTextField.text = EquipObj.Equipment
            if EquipObj.Equipment == ""{
                self.catlogprof = FuncObj.CatalogProfile
            }else{
                self.catlogprof = EquipObj.CatalogProfile
            }
            if FuncObj.MainWorkcenter != ""{
                let filterArr = self.workCentersArray.filter{$0.WorkCenter == FuncObj.MainWorkcenter}
                if filterArr.count > 0{
                    let cls = filterArr[0]
                    self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                }else{
                    let filterArr = self.workCentersArray.filter{$0.WorkCenter == userWorkcenter}
                    if filterArr.count > 0{
                        let cls = filterArr[0]
                        self.mainWorkCenterTextField.text = (cls.WorkCenter + " - " + cls.ShortText)
                    }else{
                        if workCentersListArray.count > 0 {
                            self.mainWorkCenterTextField.text = self.workCentersListArray[0]
                        }
                    }
                }
            }
            self.getAllGroupValuse()
        }
        if EquipObj.Equipment != ""{
            self.equipWarrantyInfoLabel.text = myAssetDataManager.uniqueInstance.getEquipmentWarrantyInfo(EquipObj: EquipObj)
            self.equipmentWarrantyView.isHidden = false
            equipmentWarrantyImageView.isHidden = false
            equipmentWarrantyImageView.image = UIImage(named: "history_pending")
        }else{
            self.equipmentWarrantyView.isHidden = true
            equipWarrantyInfoLabel.text = ""
            equipmentWarrantyImageView.isHidden = true
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
                            mJCLogger.log("Functional_Location_is_not_available_for_this_Equipment", Type: "Debug")
                            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                switch buttonIndex {
                                case 0:
                                    self.showOnlineSearchPopUp(searchType:"Notifications")
                                default: break
                                }
                            }
                        }
                    }else{
                        showOnlineSearchPopUp(searchType:"Notifications")
                    }
                }else if self.functionalLocationTextField.text != "" {
                    showOnlineSearchPopUp(searchType:"Notifications")
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
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.allTextFieldResign()
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
                mJCLogger.log("Data not found", Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        mJCLogger.log("Starting", Type: "info")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
        let dateString = dateFormatter.string(from: NSDate() as Date)
        self.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        isSupportPortait = false
        self.isImageUpload = true
        self.attachImageTextField.text = "IMAGE_\(dateString).\(defaultImageType)"
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            uploadAttachmentVC.isFromScreen = "NotificationCreate"
            uploadAttachmentVC.fileType = defaultImageType
            uploadAttachmentVC.imgDelegate = self
            if self.selectedbutton == "takePhoto" {
                uploadAttachmentVC.fileType = "\(defaultImageType)"
                uploadAttachmentVC.fileName  = "IMAGE_\(dateString).\(defaultImageType)"
            }else {
                let newFileName = "IMAGE_\(dateString).\(defaultImageType)"
                self.attachImageTextField.text = newFileName
                uploadAttachmentVC.fileName  = newFileName
                let  arr = (newFileName.components(separatedBy: ".")) as NSArray
                uploadAttachmentVC.fileType = (arr[1] as! String).lowercased()
            }
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            uploadAttachmentVC.image = chosenImage
            uploadAttachmentVC.attachmentType = "Image"
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false, completion: {
                self.present(uploadAttachmentVC, animated: false) {}
            })
        }
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
    @IBAction func taskTypeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.taskTypeTextFieldView
        let arr : [String] = self.notificationTypeListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "TaskTypeDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func plantButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        allTextFieldResign()
        if self.plantArray.count > 0 {
            dropDown.anchorView = self.plantTextFieldView
            let arr : [String] = self.plantArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "PlantDropDown"
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func mainWorkCenterButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.mainWorkCenterTextFieldView
        let arr : [String] = self.workCentersListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "WorkCentersDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func priorityButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.priorityTextFieldView
        let arr : [String] = self.priorityListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "PriorityDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func damageGroupButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.damageGroupListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: damageGroupListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedDamageGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedDamageGropArray = selectedList
                self?.damageGroupTextField.text = selectedList.joined(separator: ";")
                let causegrpArr = self?.damageGroupTextField.text!.components(separatedBy: " - ")
                if causegrpArr?.count ?? 0 > 0{
                    self?.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: causegrpArr![0])
                }
            }
            if self.damageGroupListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.damageGroupListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.damageGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.damageGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
            //            dropDown.anchorView = self.damageGroupTextFieldView
            //            let damageGroupList = self.damageGroupListArray
            //            let arr : [String] = damageGroupList as NSArray as! [String]
            //            dropDown.dataSource = arr
            //            dropDownSelectString = "DamageGroupDropDown"
            //            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func damageButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if damageListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: damageListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedDamageArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedDamageArray = selectedList
                self?.damageTextField.text = selectedList.joined(separator: ";")
            }
            if self.damageListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.damageListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.damageTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.damageTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
            //            dropDown.anchorView = self.damageTextFieldView
            //            let damageList = self.damageListArray
            //            if let arr : [String] = damageList as NSArray as? [String] {
            //            dropDown.dataSource = arr
            //            dropDownSelectString = "DamageDropDown"
            //            dropDown.show()
            //            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func partGroupButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.partGroupListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: partGroupListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedPartGroupArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedPartGroupArray = selectedList
                self?.partGroupTextField.text = selectedList.joined(separator: ";")

                if !selectedList.contains(selectStr){
                    let causegrpArr = self?.partGroupTextField.text!.components(separatedBy: " - ")
                    if causegrpArr?.count ?? 0 > 0{
                        if !self!.partTitleLabel.text!.contains("*"){
                            myAssetDataManager.setMandatoryLabel(label: self!.partTitleLabel)
                        }
                        self?.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: causegrpArr![0])
                    }
                }else{
                    myAssetDataManager.removeMandatoryLabel(label: self!.partTitleLabel)
                }
            }
            if self.partGroupListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.partGroupListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.partGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.partGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func partButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if partListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: partListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedPartArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedPartArray = selectedList
                self?.partTextField.text = selectedList.joined(separator: ";")
            }
            if self.partListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.partListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.damageTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.partTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func causeGroupButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.causeGroupListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: causeGroupListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedCauseGroupArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedCauseGroupArray = selectedList
                self?.causeGroupTextField.text = selectedList.joined(separator: ";")
                let causegrpArr = self?.causeGroupTextField.text!.components(separatedBy: " - ")
                if causegrpArr?.count ?? 0 > 0{
                    self?.getCauseValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: causegrpArr![0])
                }
            }
            if self.causeGroupListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.causeGroupListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.causeGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.causeGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
            //            dropDown.anchorView = self.causeGroupTextFieldView
            //            let causeGroupList = self.causeGroupListArray
            //            if let arr : [String] = causeGroupList as NSArray as? [String] {
            //                dropDown.dataSource = arr
            //                dropDownSelectString = "CauseGroupDropDown"
            //                dropDown.show()
            //            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func causeCodeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.causeCodeListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: causeCodeListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedCauseArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedCauseArray = selectedList
                self?.causeCodeTextField.text = selectedList.joined(separator: ";")
            }
            if self.causeCodeListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.causeCodeListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.causeCodeTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.causeCodeTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
            //            dropDown.anchorView = self.causeCodeTextFieldView
            //            let causeList = self.causeCodeListArray
            //            if let arr : [String] = causeList as NSArray as? [String] {
            //            dropDown.dataSource = arr
            //            dropDownSelectString = "CauseCodeDropDown"
            //            dropDown.show()
            //            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}



