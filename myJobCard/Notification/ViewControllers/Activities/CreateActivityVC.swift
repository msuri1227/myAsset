//
//  CreateActivityVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/11/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class CreateActivityVC: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var createActivityHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    // ActivityView Outlets..
    @IBOutlet var activityView: UIView!
    @IBOutlet var activityTitleLabel: UILabel!
    @IBOutlet var activityViewTextField: UITextField!
    @IBOutlet var activityViewTextFieldView: UIView!
    // CodeGroup Outlets..
    @IBOutlet var codeGroupView: UIView!
    @IBOutlet var codeGroupTitleLabel: UILabel!
    @IBOutlet var codeGroupTextField: iOSDropDown!
    @IBOutlet var codeGroupTextFieldView: UIView!
    @IBOutlet var codeGroupButton: UIButton!
    // SortNumberView Outlets..
    @IBOutlet var sortNumberView: UIView!
    @IBOutlet var sortNumberTitleLabel: UILabel!
    @IBOutlet var sortNumberTextField: UITextField!
    @IBOutlet var sortNumberTextFieldView: UIView!
    // ActivityCode Outlets..
    @IBOutlet var activityCodeView: UIView!
    @IBOutlet var activityCodeTitleLabel: UILabel!
    @IBOutlet var activityCodeTextField: iOSDropDown!
    @IBOutlet var activityCodeTextFieldView: UIView!
    @IBOutlet var activityCodeButton: UIButton!
    //NotificationView Outlets..
    @IBOutlet var notificationView: UIView!
    @IBOutlet var notificationTitleLabel: UILabel!
    @IBOutlet var notificationTextField: UITextField!
    @IBOutlet var notificationTextFieldView: UIView!
    // ActivityTextView Outlets..
    @IBOutlet var activityTextView: UIView!
    @IBOutlet var activityTextTitleLabel: UILabel!
    @IBOutlet var activityTextTextField: UITextField!
    @IBOutlet var activityTextTextFieldView: UIView!
    //buttonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextFieldView: UIView!
    @IBOutlet var itemNumHgt: NSLayoutConstraint!
    
    //MARK:- Declared Variables..
    var isFromEdit = Bool()
    var activityClass = NotificationActivityModel()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var property = NSMutableArray()
    var mainCodeGroupArray = [CatalogProfileModel]()
    var mainCodeGroupTextArray = [String]()
    var codeGroupArray = Array<CodeGroupModel>()
    var codeGroupTextArray = [String]()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var sortNumber = String()
    var itemNum = String()
    var notificationFrom = String()
    var delegate: CreateUpdateDelegate?
    var catlogprof = String()
    var selectedCodeGropArray = [String]()
    var selectedCodeArray = [String]()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")
        if isItemActivity == true{
            itemNumHgt.constant = 65
            itemView.isHidden = false
            if isFromEdit == true{
                self.createActivityHeaderLabel.text = "Edit_Item_Activity".localized() + " : \(activityClass.Activity)"
            }
        }else{
            itemNumHgt.constant = 0
            itemView.isHidden = true
        }
        self.setViewLayout()
        self.setPrimaryData()
        self.activityTextTextField.delegate  = self
        self.GetCatalogProfileSet()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateActivityVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        if isFromEdit == true{
            if isItemActivity == true {
                self.createActivityHeaderLabel.text = "Edit_Item_Activity".localized() + " : \(activityClass.Activity)"
            }else{
                self.createActivityHeaderLabel.text = "Edit_Activity".localized() + " : \(activityClass.Activity)"
            }
        }else{
            if isItemActivity == true {
                self.createActivityHeaderLabel.text = "Create_Item_Activity".localized()
            }else{
                self.createActivityHeaderLabel.text = "Create_Activity".localized()
            }
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "CodeGroup" {
                self.codeGroupTextField.text = item
                if item != ""{
                    let codeGrpArr = item.components(separatedBy: " - ")
                    if codeGrpArr.count > 0{
                        self.getActivityCode(catalogCode: CATALOGCODE_ACTIVITY, codeGroup: codeGrpArr[0], isFromDropdown: true)
                    }
                }
                self.dropDownSelectString = ""
            }
            else if self.dropDownSelectString == "ActivitiCode" {
                self.activityCodeTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        mJCLogger.log("Ended", Type: "info")
        
        //Code group
        self.codeGroupTextField.didSelect{(selectedText , index , id) in
            self.codeGroupTextField.text = selectedText
            let codeGrpArr = selectedText.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                self.getActivityCode(catalogCode: CATALOGCODE_ACTIVITY, codeGroup: codeGrpArr[0], isFromDropdown: true)
            }
        }
        
        //Activity Code
        self.activityCodeTextField.didSelect{(selectedText , index , id) in
            self.activityCodeTextField.text = selectedText
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        if textField == self.activityTextTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Activity_Text_length_should_not_be_more_than_40_characters", Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Activity_Text_length_should_not_be_more_than_40_characters".localized() , button: okay)
                mJCLogger.log("Ended", Type: "info")
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
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
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.activityTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.codeGroupTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.sortNumberTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.activityCodeTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.notificationTitleLabel)
    }
    //MARK:- Footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if activityViewTextField.text == "" {
            mJCLogger.log("Please_enter_activity", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_activity".localized(), button: okay)
        }else if codeGroupTextField.text == "" {
            mJCLogger.log("Please_enter_code_group", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_code_group".localized(), button: okay)
        }else if sortNumberTextField.text == "" {
            mJCLogger.log("Please_enter_sort_number", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_sort_number".localized(), button: okay)
        }else if activityCodeTextField.text == "" {
            mJCLogger.log("Please_enter_activity_code", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_activity_code".localized(), button: okay)
        }else if notificationTextField.text == "" {
            mJCLogger.log("Please_enter_notification", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_notification".localized(), button: okay)
        }
//        else if activityTextTextField.text == "" {
//            mJCLogger.log("Please_enter_activity_text", Type: "Debug")
//            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_activity_text".localized(), button: okay)
//        }
        else {
            if isFromEdit == true {
                self.updateActivity()
            }else {
                self.createActivity()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == true {
            self.setEditActivityValue()
            self.GetCatalogProfileSet()
        }else{
            if self.mainCodeGroupTextArray.count > 0 {
                self.codeGroupTextField.text = self.mainCodeGroupTextArray[0]
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            if self.codeGroupTextArray.count > 0 {
                self.activityCodeTextField.text = self.codeGroupTextArray[0]
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            activityTextTextField.text = ""
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backbuttonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- GetCatalogProfile
    func GetCatalogProfileSet(){
        if singleNotification.Equipment != ""{
            EquipmentModel.getEquipmentDetails(equipNum: singleNotification.Equipment){(response, error)  in
                if error == nil{
                    if let equip = response["data"] as? [EquipmentModel]{
                        if equip.count > 0{
                            let equipmentdetails = equip[0]
                            self.catlogprof  = equipmentdetails.CatalogProfile
                            if equipmentdetails.CatalogProfile == "" && singleNotification.FunctionalLoc != ""{
                                FunctionalLocationModel.getFuncLocationDetails(funcLocation: singleNotification.FunctionalLoc){(response, error)  in
                                    if error == nil{
                                        if let funcArr = response["data"] as? [FunctionalLocationModel]{
                                            if funcArr.count > 0{
                                                let funcdetails = funcArr[0]
                                                self.catlogprof  = funcdetails.CatalogProfile
                                            }
                                            self.getActivityGroupValuse()
                                        }
                                    }
                                }
                            }else{
                                self.getActivityGroupValuse()
                            }
                        }else{
                            self.getActivityGroupValuse()
                        }
                    }
                }
            }
        }else if singleNotification.FunctionalLoc != ""{
            FunctionalLocationModel.getFuncLocationDetails(funcLocation: singleNotification.FunctionalLoc){(response, error)  in
                if error == nil{
                    if let funcArr = response["data"] as? [FunctionalLocationModel]{
                        if funcArr.count > 0{
                            let funcdetails = funcArr[0]
                            self.catlogprof  = funcdetails.CatalogProfile
                        }
                        self.getActivityGroupValuse()
                    }
                }
            }
        }else{
            self.catlogprof = ""
            self.getActivityGroupValuse()
        }
    }
    func getActivityGroupValuse(){
        var searchPredicate = NSPredicate()
        var notifCatProfile = ""
        if self.catlogprof == ""{
            let type = singleNotification.NotificationType
            if type != ""{
                let notificationTypeArr = notificationTypeArray.filter{$0.NotifictnType == "\(type)"}
                if notificationTypeArr.count > 0{
                    notifCatProfile = notificationTypeArr[0].CatalogProfile
                }else{
                    notifCatProfile = ""
                }
            }else{
                notifCatProfile = ""
            }
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ACTIVITY)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ACTIVITY)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ACTIVITY)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let damgeGropArr = catlogArray.filtered(using: searchPredicate) as Array
        self.mainCodeGroupArray.removeAll()
        self.mainCodeGroupTextArray.removeAll()
        if let arr = damgeGropArr as? [CatalogProfileModel]{
            self.mainCodeGroupArray = arr
            self.mainCodeGroupTextArray.append(selectStr)
            for item in self.mainCodeGroupArray{
                self.mainCodeGroupTextArray.append("\(item.CodeGroup) - \(item.ShortText)")
            }
        }
        
        if self.mainCodeGroupTextArray.count > 0 {
            DispatchQueue.main.async {
                self.codeGroupTextField.optionArray = self.mainCodeGroupTextArray
                self.codeGroupTextField.checkMarkEnabled = false
            }
        }
        
        self.setActivityGroup()
    }
    func setActivityGroup(){
        
        if self.isFromEdit == true {
            let codeGroupPredicate : NSPredicate = NSPredicate(format: "SELF.CodeGroup == %@",self.activityClass.CodeGroup)
            let codeGroupFilteredArray = (self.mainCodeGroupArray as NSArray).filtered(using: codeGroupPredicate) as! [CatalogProfileModel]
            if codeGroupFilteredArray.count > 0{
                DispatchQueue.main.async {
                    let codegroup = codeGroupFilteredArray[0]
                    self.codeGroupTextField.text = "\(codegroup.CodeGroup) - \(codegroup.ShortText)"
                    self.getActivityCode(catalogCode: CATALOGCODE_ACTIVITY, codeGroup: codegroup.CodeGroup,isFromDropdown: false)
                }
            }
        }else {
            if self.mainCodeGroupArray.count > 0 {
                DispatchQueue.main.async {
                    self.codeGroupTextField.text = self.mainCodeGroupTextArray[0]
                    let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
                    if codeGrpArr.count > 0{
                        self.getActivityCode(catalogCode: CATALOGCODE_ACTIVITY, codeGroup: codeGrpArr[0],isFromDropdown: false)
                    }
                }
            }
        }
    }
    //MARK:- Get Activity Code..
    func getActivityCode(catalogCode:String, codeGroup:String,isFromDropdown : Bool) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                self.codeGroupArray.removeAll()
                self.codeGroupTextArray.removeAll()
                self.codeGroupTextArray.append(selectStr)
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    DispatchQueue.main.async {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.codeGroupArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                        }
                        for item in self.codeGroupArray {
                            self.codeGroupTextArray.append("\(item.Code) - \(item.CodeText)")
                        }
                        if self.isFromEdit == true {
                            if isFromDropdown == true {
                                if self.codeGroupTextArray.count > 0 {
                                    self.activityCodeTextField.text = self.codeGroupTextArray[0]
                                }
                            }else {
                                let arr = self.codeGroupArray.filter{$0.Code == "\(self.activityClass.ActivityCode)"}
                                if arr.count > 0{
                                    let codeGroupClass = arr[0]
                                    self.activityCodeTextField.text = "\(codeGroupClass.Code) - \(codeGroupClass.CodeText)"
                                }
                            }
                        }else  if self.isFromEdit == false {
                            if self.codeGroupTextArray.count > 0{
                                self.activityCodeTextField.text = self.codeGroupTextArray[0]
                            }
                        }
                        
                        if self.codeGroupTextArray.count > 0 {
                            DispatchQueue.main.async {
                                self.activityCodeTextField.optionArray = self.codeGroupTextArray
                                self.activityCodeTextField.checkMarkEnabled = false
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.activityViewTextField.resignFirstResponder()
        self.codeGroupTextField.resignFirstResponder()
        self.sortNumberTextField.resignFirstResponder()
        self.activityCodeTextField.resignFirstResponder()
        self.notificationTextField.resignFirstResponder()
        self.activityTextTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Set View Layout..
    func setViewLayout() {
        mJCLogger.log("Starting", Type: "info")
        ODSUIHelper.setBorderToView(view:self.activityViewTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.codeGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.sortNumberTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.activityCodeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.activityTextTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Set Primary Data..
    func setPrimaryData() {
        mJCLogger.log("Starting", Type: "info")
        let activity = String.random(length: 4, type: "Number")
        if isFromEdit == true {
            self.itemTextField.text = itemNum
            self.setEditActivityValue()
        }else {
            self.activityViewTextField.text = activity
            self.sortNumberTextField.text = sortNumber
            self.itemTextField.text = itemNum
            self.notificationTextField.text = selectedNotificationNumber
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Edit data..
    func setEditActivityValue(){
        mJCLogger.log("Starting", Type: "info")
        self.activityViewTextField.text = activityClass.Activity
        self.sortNumberTextField.text = activityClass.SortNumber
        self.notificationTextField.text = activityClass.Notification
        self.activityTextTextField.text = activityClass.ActivityText
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create & Update Activity..
    func createActivity() {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        self.property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "Activity")
        prop!.value = "\(self.activityViewTextField.text!)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = sortNumberTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(selectedNotificationNumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CodeGroup")
        if self.codeGroupTextField.text != "" && self.codeGroupTextField.text != selectStr{
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                prop!.value = codeGrpArr[0] as NSObject
                self.property.add(prop!)
            }
        }
        if self.activityCodeTextField.text != "" && self.activityCodeTextField.text != selectStr{
            let codeTextArr = self.activityCodeTextField.text!.components(separatedBy: " - ")
            if codeTextArr.count > 1{
                prop = SODataPropertyDefault(name: "ActivityCode")
                prop!.value = codeTextArr[0] as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "ActivityCodeText")
                prop!.value = codeTextArr[1] as NSObject
                self.property.add(prop!)
            }
        }
        prop = SODataPropertyDefault(name: "ActivityText")
        prop!.value = self.activityTextTextField.text! as NSObject
        self.property.add(prop!)
        
        if self.notificationFrom != "FromWorkorder"{
            prop = SODataPropertyDefault(name: "TempID")
            prop!.value = "\(self.activityViewTextField.text!)" as NSObject
            self.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "Cause")
        prop!.value = "0000" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        if isItemActivity == true{
            prop!.value = itemNum as NSObject
        }else{
            prop!.value = "0000" as NSObject
        }
        self.property.add(prop!)
        
        var entitytypStr = String()
        var entitySet = String()
        
        if self.notificationFrom == "FromWorkorder" {
            entitytypStr = woNotificationActivityCollectionEntity
            entitySet = woNotificationActivityCollection
        }else{
            entitytypStr = notificationActivitySetEntity
            entitySet = notificationActivitySet
        }
        
        let Actentity = SODataEntityDefault(type: entitytypStr)
        
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            Actentity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("................")
        }
        if self.notificationFrom == "FromWorkorder"{
            NotificationActivityModel.createWoNotificationActivityEntity(entity: Actentity!, collectionPath: entitySet,flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Response:\(response.count)", Type: "Debug")
                    mJCLogger.log("Activity Created successfully".localized(), Type: "")
                    self.delegate?.EntityCreated?()
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    mJCLogger.log("Fail_to_create_activity_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_activity_try_again".localized(), button: okay)
                }
            })
        }else{
            NotificationActivityModel.createNotificationActivityEntity(entity: Actentity!, collectionPath: entitySet,flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Activity Created successfully".localized(), Type: "")
                    self.delegate?.EntityCreated?()
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    mJCLogger.log("Fail_to_create_activity_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_activity_try_again".localized(), button: okay)
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Update Activity..
    func updateActivity() {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        if self.codeGroupTextField.text != ""{
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                (activityClass.entity.properties["CodeGroup"] as! SODataProperty).value = "\(codeGrpArr[0])" as NSObject
                activityClass.CodeGroup = "\(codeGrpArr[0])"
            }
        }
        if self.activityCodeTextField.text != ""{
            let codeTextArr = self.activityCodeTextField.text!.components(separatedBy: " - ")
            if codeTextArr.count > 1{
                (activityClass.entity.properties["ActivityCode"] as! SODataProperty).value = codeTextArr[0] as NSObject
                activityClass.ActivityCode = codeTextArr[0]
                (activityClass.entity.properties["ActivityCodeText"] as! SODataProperty).value = codeTextArr[1] as NSObject
                activityClass.ActivityCode = codeTextArr[1]
            }
        }
        (activityClass.entity.properties["ActivityText"] as! SODataProperty).value = "\(self.activityTextTextField.text!)" as NSObject
        activityClass.ActivityText = "\(self.activityTextTextField.text!)"
        NotificationActivityModel.updateNotificationActivityEntity(entity: activityClass.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Response:\(response.count)", Type: "Debug")
                mJCLogger.log("Activity Updated successfully".localized(), Type: "")
                self.delegate?.EntityCreated?()
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log("Fail_to_update_activity_try_again".localized(), Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_activity_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Not Using Methods
    @IBAction func codeGroupButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.mainCodeGroupTextArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: mainCodeGroupTextArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedCodeGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedCodeGropArray = selectedList
                self?.codeGroupTextField.text = selectedList.joined(separator: ";")
                let codeGrpArr = self?.codeGroupTextField.text!.components(separatedBy: " - ")
                if codeGrpArr?.count ?? 0 > 0{
                    self?.getActivityCode(catalogCode: CATALOGCODE_ACTIVITY, codeGroup: codeGrpArr![0],isFromDropdown: false)
                }
            }
            if self.mainCodeGroupTextArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.mainCodeGroupTextArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.codeGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.codeGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func activityCodeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.codeGroupTextArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: codeGroupTextArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedCodeArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedCodeArray = selectedList
                self?.activityCodeTextField.text = selectedList.joined(separator: ";")
            }
            if self.codeGroupTextArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.codeGroupTextArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.codeGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.codeGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //...END...//
}
