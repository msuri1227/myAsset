//
//  CreateItemCauseVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 05/06/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CreateItemCauseVC: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate  {
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var createTaskHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    // CodeGroup Outlets..
    @IBOutlet var codeGroupView: UIView!
    @IBOutlet var codeGroupTitleLabel: UILabel!
    @IBOutlet var codeGroupTextField: iOSDropDown!
    @IBOutlet var codeGroupTextFieldView: UIView!
    @IBOutlet var taskCodeGroupButton: UIButton!
    // taskCode Outlets..
    @IBOutlet var causeCodeView: UIView!
    @IBOutlet var causeCodeTitleLabel: UILabel!
    @IBOutlet var causeCodeTextField: iOSDropDown!
    @IBOutlet var causeCodeTextFieldView: UIView!
    @IBOutlet var causeCodeButton: UIButton!
    
    //NotificationView Outlets..
    @IBOutlet var notificationView: UIView!
    @IBOutlet var notificationTitleLabel: UILabel!
    @IBOutlet var notificationTextField: UITextField!
    @IBOutlet var notificationTextFieldView: UIView!
    //buttonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!

    @IBOutlet var itemView: UIView!
    @IBOutlet var itemTextTitleLabel: UILabel!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextFieldView: UIView!

    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextFieldView: UIView!
    @IBOutlet var descriptionTextField: UITextField!

    @IBOutlet var noteView: UIView!
    @IBOutlet var noteTextTitleLabel: UILabel!
    @IBOutlet var noteTextFieldView: UIView!
    @IBOutlet var noteTextView: UITextView!

    @IBOutlet var sortNumberView: UIView!
    @IBOutlet var sortNumberTitleLabel: UILabel!
    @IBOutlet var sortNumberTextField: UITextField!
    @IBOutlet var sortNumberTextFieldView: UIView!
    
    //MARK:- Declared Variable
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var isFromEdit = Bool()
    var property = NSMutableArray()
    var sortNumber = String()
    var taskArray = Array<CodeGroupModel>()
    var causeClass = NotificationItemCauseModel()
    var taskCount = Int()
    var itemCauseGroupArray = [CatalogProfileModel]()
    var itemCauseGroupListArray = [String]()
    var taskListArray = [String]()
    var notificationFrom = String()
    var catlogprof = String()
    var catlogArray = NSMutableArray()
    var selectedCodeGropArray = [String]()
    var selectedCodeArray = [String]()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")
        self.property.removeAllObjects()
        descriptionTextField.delegate = self
        taskCount = 0
        if isItemCause == true{
            itemView.isHidden = false
        }else{
            itemView.isHidden = true
        }
        descriptionTextField.isUserInteractionEnabled  = true
        self.setPrimaryTaskData()
        ODSUIHelper.setBorderToView(view:self.codeGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.causeCodeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.noteTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.sortNumberTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "itemCauseGroup" {
                self.codeGroupTextField.text = item
                self.dropDownSelectString = ""
                let codeGrpArr = item.components(separatedBy: " - ")
                if codeGrpArr.count > 0{
                    self.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: codeGrpArr[0])
                }else{
                    self.causeCodeTextField.text = ""
                }
            }else if self.dropDownSelectString == "causeCode" {
                self.causeCodeTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        self.descriptionTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateTaskVC.handleTap(sender:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        mJCLogger.log("Ended", Type: "info")
        
        //Code group
        self.codeGroupTextField.didSelect{(selectedText , index , id) in
            self.codeGroupTextField.text = selectedText
            let codeGrpArr = selectedText.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                self.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: codeGrpArr[0])
            }else{
                self.causeCodeTextField.text = ""
            }
        }
        
        //Cause code
        self.causeCodeTextField.didSelect{(selectedText , index , id) in
            self.causeCodeTextField.text = selectedText
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
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
                   replacementString string: String) -> Bool {
        mJCLogger.log("Starting", Type: "info")
        if textField == self.descriptionTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Task_Text_length_should_not_be_more_than_40_characters".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Task_Text_length_should_not_be_more_than_40_characters".localized() , button: okay)
                return newString.length <= maxLength
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
        myAssetDataManager.setMandatoryLabel(label: self.causeCodeTitleLabel)
    }
    //MARK:- Footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
//        if descriptionTextField.text == "" {
//            mJCLogger.log("Please_enter_description".localized(), Type: "Debug")
//            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_description".localized(), button: okay)
//        }else
        if causeCodeTextField.text == "" {
            mJCLogger.log("Please_enter_cause_text".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_cause_text".localized(), button: okay)
        }else {
            if isFromEdit == true{
                self.updateItemCause()
            }else{
                self.createItemCause()
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
        self.setPrimaryTaskData()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- GetCatalogProfile
    func GetCatalogProfileSet(){
        CatalogProfileModel.getCatalogProfileList(){ (response, error)  in
            if error == nil{
                self.catlogArray.removeAllObjects()
                if let responseArr = response["data"] as? [CatalogProfileModel]{
                    let sortedArr = responseArr.sorted{$0.CodeGroup.compare($1.CodeGroup) == .orderedAscending}
                    self.catlogArray.addObjects(from: sortedArr as [AnyObject])
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
                                                        self.getCauseGroup()
                                                    }
                                                }
                                            }
                                        }else{
                                            self.getCauseGroup()
                                        }
                                    }else{
                                        self.getCauseGroup()
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
                                    self.getCauseGroup()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func getCauseGroup() {
        
        self.itemCauseGroupArray.removeAll()
        self.itemCauseGroupListArray.removeAll()
        self.itemCauseGroupListArray.append(selectStr)
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
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let filterArray = self.catlogArray.filtered(using: searchPredicate) as Array
        if filterArray.count > 0{
            self.itemCauseGroupArray = filterArray as! [CatalogProfileModel]
        }
        self.setCauseGroupAndcauseCodeValue()
    }
    func setCauseGroupAndcauseCodeValue() {
        DispatchQueue.main.async {
            if self.itemCauseGroupArray.count > 0 {
                var codeGrp = [String]()
                if self.itemCauseGroupArray.count > 0{
                    for item in self.itemCauseGroupArray {
                        codeGrp.append("\(item.CodeGroup) - \(item.ShortText)")
                    }
                }
                if codeGrp.count > 0 {
                    let sortedCaseInsensitiveArr = codeGrp.sorted {
                        $0.caseInsensitiveCompare($1) == .orderedAscending
                    }
                    self.itemCauseGroupListArray = sortedCaseInsensitiveArr
                }
            }
            if self.isFromEdit == true {
                if self.causeClass.CodeGroup != ""{
                    let filterArray = self.itemCauseGroupArray.filter{$0.CodeGroup == self.causeClass.CodeGroup}
                    if filterArray.count > 0{
                        let catalogProfileClass = filterArray[0]
                        self.codeGroupTextField.text = "\(catalogProfileClass.CodeGroup) - \(catalogProfileClass.ShortText)"
                        self.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: catalogProfileClass.CodeGroup)
                    }
                }
            }else {
                if self.itemCauseGroupListArray.count > 0 {
                    mJCLogger.log("Response:\(self.itemCauseGroupListArray[0])", Type: "Debug")
                    self.codeGroupTextField.text = self.itemCauseGroupListArray[0]
                    if self.codeGroupTextField.text != nil{
                        let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
                        if codeGrpArr.count > 0{
                            self.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: codeGrpArr[0])
                        }
                    }
                    DispatchQueue.main.async {
                        self.codeGroupTextField.optionArray = self.itemCauseGroupListArray
                        self.codeGroupTextField.checkMarkEnabled = false
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
    }
    //MARK:- Get getTask Code Value..
    func getItemCauseCodeValue(catalogCode:String, codeGroup:String) {
        
        mJCLogger.log("Starting", Type: "info")
        self.taskArray.removeAll()
        self.taskListArray.removeAll()
        self.taskListArray.append(selectStr)
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    DispatchQueue.main.async {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.taskArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                        }
                        for itemCount in 0..<self.taskArray.count {
                            let codeGroupClass = self.taskArray[itemCount]
                            self.taskListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                        }
                        if self.isFromEdit == false {
                            if self.taskListArray.count > 0{
                                self.causeCodeTextField.text = self.taskListArray[0]
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else{
                            if self.causeClass.CauseCode != ""{
                                let filterArray = self.taskArray.filter{$0.Code == self.causeClass.CauseCode}
                                if filterArray.count > 0{
                                    let catalogProfileClass = filterArray[0]
                                    self.causeCodeTextField.text = "\(catalogProfileClass.Code) - \(catalogProfileClass.CodeText)"
                                }
                            }
                        }
                        if self.taskListArray.count > 0{
                            DispatchQueue.main.async {
                                self.causeCodeTextField.optionArray = self.taskListArray
                                self.causeCodeTextField.checkMarkEnabled = false
                            }
                        }
                    }
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- All TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.causeCodeTextField.resignFirstResponder()
        self.codeGroupTextField.resignFirstResponder()
        self.notificationTextField.resignFirstResponder()
        self.descriptionTextField.resignFirstResponder()
        self.itemTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Set & Refresh Task Data..
    func setPrimaryTaskData() {
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == true {
            self.sortNumberTextField.text = causeClass.SortNumber
            self.descriptionTextField.text = causeClass.CauseText
            self.notificationTextField.text = causeClass.Notification
            self.itemTextField.text = selectedItem
            self.createTaskHeaderLabel.text = "Edit_Item_Cause".localized() + ": \(causeClass.Cause)"
        }else {
            self.descriptionTextField.text = ""
            self.sortNumberTextField.text = sortNumber
            self.itemTextField.text = selectedItem
            self.notificationTextField.text = selectedNotificationNumber
            self.createTaskHeaderLabel.text = "Create_Item_Cause".localized()
        }
        self.GetCatalogProfileSet()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Refresh All Value..
    func refreshAllValue()  {
        mJCLogger.log("Starting", Type: "info")
        if itemCauseGroupListArray.count > 0{
            mJCLogger.log("Response:\(itemCauseGroupListArray[0])", Type: "Debug")
            self.codeGroupTextField.text = itemCauseGroupListArray[0]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create & Update Task..
    func createItemCause()  {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        self.property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_TASK)" as NSObject
        self.property.add(prop!)
        
        let cause = String.random(length: 4, type: "Number")
        prop = SODataPropertyDefault(name: "Cause")
        prop!.value = "\(cause)" as NSObject
        self.property.add(prop!)
        
        if self.codeGroupTextField.text != "" && self.codeGroupTextField.text != selectStr{
            prop = SODataPropertyDefault(name: "CodeGroup")
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                prop!.value = codeGrpArr[0] as NSObject
                property.add(prop!)
            }
        }

        if self.causeCodeTextField.text != "" && self.causeCodeTextField.text != selectStr{
            prop = SODataPropertyDefault(name: "CauseCode")
            let causeCodeArr = self.causeCodeTextField.text!.components(separatedBy: " - ")
            if causeCodeArr.count > 0{
                prop!.value = causeCodeArr[0] as NSObject
                self.property.add(prop!)
            }
        }
        
        prop = SODataPropertyDefault(name: "Item")
        if isItemCause == true{
            prop!.value = selectedItem as NSObject
        }else{
            prop!.value = "0000" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(selectedNotificationNumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CauseText")
        prop!.value = descriptionTextField.text! as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = sortNumberTextField.text! as NSObject
        self.property.add(prop!)
        
        var entitytypStr = String()
        var entitySet = String()
        
        if self.notificationFrom == "FromWorkorder" {
            entitytypStr = woNotificationItemCausesCollectionEntity
            entitySet = woNotificationItemCausesCollection
        }else{
            entitytypStr = notificationItemCausesSetEntity
            entitySet = notificationItemCauseSet
        }
        
        let causeEntity = SODataEntityDefault(type: entitytypStr)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            causeEntity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name!)")
            print("Value :\(proper.value!)")
            print("..............")
        }
        if self.notificationFrom == "FromWorkorder" {
            NotificationItemCauseModel.createWoNoItemCauseEntity(entity: causeEntity!, collectionPath: entitySet, flushRequired: true,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Item cause Created successfully", Type: "Debug")
                    UserDefaults.standard.set(true, forKey: "isCreateTask")
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }
                else {
                    UserDefaults.standard.set(false, forKey: "isCreateTask")
                    mJCLogger.log("Fail_to_create_Task_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_Task_try_again".localized(), button: okay)
                }
            })
        }else{
            NotificationItemCauseModel.createNotificationItemCauseEntity(entity: causeEntity!, collectionPath: entitySet, flushRequired: true,options: nil, completionHandler: { (response, error) in
                
                if(error == nil) {
                    mJCLogger.log("Item cause Created successfully", Type: "Debug")
                    UserDefaults.standard.set(true, forKey: "isCreateTask")
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    UserDefaults.standard.set(false, forKey: "isCreateTask")
                    mJCLogger.log("Fail_to_create_Task_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_Task_try_again".localized(), button: okay)
                }
                
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Update Task..
    func updateItemCause() {
        mJCLogger.log("Starting", Type: "info")
        if self.codeGroupTextField.text != "" {
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                (causeClass.entity.properties["CodeGroup"] as! SODataProperty).value = codeGrpArr[0] as NSObject
                causeClass.CodeGroup = codeGrpArr[0]
            }
        }
        if self.causeCodeTextField.text != ""{
            let causeCodeArr = self.causeCodeTextField.text!.components(separatedBy: " - ")
            if causeCodeArr.count > 0{
                (causeClass.entity.properties["CauseCode"] as! SODataProperty).value = causeCodeArr[0] as NSObject
                causeClass.CauseCode = causeCodeArr[0]
            }
        }
        (causeClass.entity.properties["CauseText"] as! SODataProperty).value = "\(self.descriptionTextField.text!)" as NSObject
        NotificationItemCauseModel.updateNotificationItemCauseEntity(entity: causeClass.entity,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                mJCLogger.log("Task Updated successfully", Type: "Debug")
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log("Fail_to_update_Task_try_again", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_Task_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK: - Not Using Methods
    @IBAction func CodeGroupButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.itemCauseGroupListArray.count > 0 {
            mJCLogger.log("Response:\(self.itemCauseGroupListArray.count)", Type: "Debug")
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: itemCauseGroupListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedCodeGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedCodeGropArray = selectedList
                self?.codeGroupTextField.text = selectedList.joined(separator: ";")
                let codeGrpArr = self?.codeGroupTextField.text!.components(separatedBy: " - ")
                if codeGrpArr?.count ?? 0 > 0{
                    self?.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: codeGrpArr![0])
                }
            }
            if self.itemCauseGroupListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.itemCauseGroupListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.codeGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.codeGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func CodeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.taskListArray.count > 0 {
            mJCLogger.log("Response:\(self.taskListArray.count)", Type: "Debug")
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: taskListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedCodeGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedCodeGropArray = selectedList
                self?.causeCodeTextField.text = selectedList.joined(separator: ";")
            }
            if self.taskListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.taskListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.causeCodeTextField.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.causeCodeTextField, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
