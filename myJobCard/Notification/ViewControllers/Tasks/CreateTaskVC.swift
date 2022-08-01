//
//  CreateTaskVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/12/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class CreateTaskVC: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var createTaskHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    // TaskView Outlets..
    @IBOutlet var taskView: UIView!
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskViewTextField: UITextField!
    @IBOutlet var taskViewTextFieldView: UIView!
    // CodeGroup Outlets..
    @IBOutlet var codeGroupView: UIView!
    @IBOutlet var codeGroupTitleLabel: UILabel!
    @IBOutlet var codeGroupTextField: iOSDropDown!
    @IBOutlet var codeGroupTextFieldView: UIView!
    @IBOutlet var taskCodeGroupButton: UIButton!
    // SortNumberView Outlets..
    @IBOutlet var sortNumberView: UIView!
    @IBOutlet var sortNumberTitleLabel: UILabel!
    @IBOutlet var sortNumberTextField: UITextField!
    @IBOutlet var sortNumberTextFieldView: UIView!
    // taskCode Outlets..
    @IBOutlet var taskCodeView: UIView!
    @IBOutlet var taskCodeTitleLabel: UILabel!
    @IBOutlet var taskCodeTextField: iOSDropDown!
    @IBOutlet var taskCodeTextFieldView: UIView!
    @IBOutlet var taskCodeButton: UIButton!
    //NotificationView Outlets..
    @IBOutlet var notificationView: UIView!
    @IBOutlet var notificationTitleLabel: UILabel!
    @IBOutlet var notificationTextField: UITextField!
    @IBOutlet var notificationTextFieldView: UIView!
    // TaskTextfield Outlets..
    @IBOutlet var taskTextView: UIView!
    @IBOutlet var taskTextTitleLabel: UILabel!
    @IBOutlet var taskTextTextField: UITextField!
    @IBOutlet var taskTextTextFieldView: UIView!
    //buttonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemTextTitleLabel: UILabel!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextFieldView: UIView!
    @IBOutlet var itemNumHgt: NSLayoutConstraint!
    //Status View Outlets..
    @IBOutlet weak var itemStatusView: UIView!
    @IBOutlet var itemStatusTextTitleLabel: UILabel!
    @IBOutlet weak var itemStatusTextFieldView: UIView!
    @IBOutlet weak var itemStatusTextField: UITextField!
    @IBOutlet weak var itemStatusButton: UIButton!
    
    //MARK:- Declared Variable
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var isFromEdit = Bool()
    var isfromWo = String()
    var property = NSMutableArray()
    var sortNumber = String()
    var taskArray = Array<CodeGroupModel>()
    var taskClass = NotificationTaskModel()
    var taskGroupArray = [CatalogProfileModel]()
    var taskGroupListArray = [String]()
    var taskListArray = [String]()
    var itemNum = String()
    var taskStatusArray = [LTStatusProfileModel]()
    var taskStatusListArray = [String]()
    var delegate: CreateUpdateDelegate?
    var catlogprof = String()
    var selectedTaskArray = [String]()
    var selectedTaskGropArray = [String]()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.property.removeAllObjects()
        if isItemTask == true{
            itemView.isHidden = false
            itemNumHgt.constant = 65
        }else{
            itemView.isHidden = true
            itemNumHgt.constant = 0
        }
        self.taskTextTextField.delegate = self
        self.taskStatusArray.removeAll()
        self.taskStatusListArray.removeAll()
        self.setPrimaryTaskData()
        self.GetCatalogProfileSet()
        if isFromEdit == true{
            self.getTaskStatus()
        }
        ODSUIHelper.setBorderToView(view:self.taskViewTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.codeGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.sortNumberTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.taskCodeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.taskTextTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemStatusTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "TaskCodeGroup" {
                self.codeGroupTextField.text = item
                if item != ""{
                    let codeGrpArr = item.components(separatedBy: " - ")
                    if codeGrpArr.count > 0{
                        self.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codeGrpArr[0])
                    }
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "TaskCode" {
                self.taskCodeTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "TaskStatus" {
                self.itemStatusTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateTaskVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        mJCLogger.log("Ended", Type: "info")
        
        self.codeGroupTextField.didSelect{(selectedText , index , id) in
            self.codeGroupTextField.text = selectedText
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                self.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codeGrpArr[0])
            }
        }
        
        self.taskCodeTextField.didSelect{(selectedText , index , id) in
            self.taskCodeTextField.text = selectedText
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
                   replacementString string: String) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        if textField == self.taskTextTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
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
    //MARK:- Footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
//        if taskTextTextField.text == "" {
//            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_task_text".localized(), button: okay)
//        }else {
            if isFromEdit == true {
                self.updateTask()
            }else {
                self.createNewTask()
            }
//        }
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
            let codeGroupPredicate : NSPredicate = NSPredicate(format: "SELF.CodeGroup == %@",self.taskClass.CodeGroup)
            let codeGroupFilteredArray = (self.taskGroupArray as NSArray).filtered(using: codeGroupPredicate) as! [CatalogProfileModel]
            if codeGroupFilteredArray.count > 0{
                let codegroup = codeGroupFilteredArray[0]
                self.codeGroupTextField.text = "\(codegroup.CodeGroup) - \(codegroup.ShortText)"
                self.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codegroup.CodeGroup)
            }
            self.taskTextTextField.text = taskClass.TaskText
        }else {
            self.refreshAllValue()
        }
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
                                            self.getTaskGroupValuse()
                                        }
                                    }
                                }
                            }else{
                                self.getTaskGroupValuse()
                            }
                        }else{
                            self.getTaskGroupValuse()
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
                        self.getTaskGroupValuse()
                    }
                }
            }
        }else{
            self.catlogprof = ""
            self.getTaskGroupValuse()
        }
    }
    
    //MARK:- Get Cause Group..
    func getTaskGroupValuse()
    {
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
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_TASK)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_TASK)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_TASK)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let damgeGropArr = catlogArray.filtered(using: searchPredicate) as Array
        self.taskGroupArray.removeAll()
        self.taskGroupListArray.removeAll()
        self.taskGroupListArray.append(selectStr)
        if let arr = damgeGropArr as? [CatalogProfileModel]{
            self.taskGroupArray = arr
            for item in self.taskGroupArray{
                self.taskGroupListArray.append("\(item.CodeGroup) - \(item.ShortText)")
            }
        }
        //Code group
        if self.taskGroupListArray.count > 0{
            DispatchQueue.main.async {
                self.codeGroupTextField.optionArray = self.taskGroupListArray
                self.codeGroupTextField.checkMarkEnabled = false
            }
        }
        self.setTaskGroup()
    }
    func setTaskGroup(){
        if self.isFromEdit == true {
            let codeGroupPredicate : NSPredicate = NSPredicate(format: "SELF.CodeGroup == %@",self.taskClass.CodeGroup)
            let codeGroupFilteredArray = (self.taskGroupArray as NSArray).filtered(using: codeGroupPredicate) as! [CatalogProfileModel]
            if codeGroupFilteredArray.count > 0{
                DispatchQueue.main.async {
                    let codegroup = codeGroupFilteredArray[0]
                    self.codeGroupTextField.text = "\(codegroup.CodeGroup) - \(codegroup.ShortText)"
                    self.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codegroup.CodeGroup)
                }
            }
        }else {
            if self.taskGroupListArray.count > 0 {
                mJCLogger.log("Response:\(self.taskGroupListArray.count)", Type: "Debug")
                DispatchQueue.main.async {
                    if self.taskGroupListArray.count > 0{
                        if self.taskGroupListArray.indices.contains(1){
                            self.codeGroupTextField.text = self.taskGroupListArray[1]
                            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
                            if codeGrpArr.count > 0{
                                self.codeGroupTextField.text = "\(codeGrpArr[0]) - \(codeGrpArr[1])"
                                self.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codeGrpArr[0])
                            }
                        }
                        else{
                            self.codeGroupTextField.text = self.taskGroupListArray[0]
                        }
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
    }
    func getTaskStatus(){
        mJCLogger.log("Starting", Type: "info")
        self.taskStatusListArray.append(selectStr)
        let query = "$filter=(StatusCategory eq '\(NotificationTaskLevel)')"
        LTStatusProfileModel.getLtStatusProfileDetails(filterQuery:query){ (responseDict, error)  in
            if error == nil{
                self.taskStatusArray.removeAll()
                if let responseArr = responseDict["data"] as? [LTStatusProfileModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.taskStatusArray = responseArr
                        for itemCount in 0..<self.taskStatusArray.count {
                            let taskStatusClass = self.taskStatusArray[itemCount]
                            self.taskStatusListArray.append("\(taskStatusClass.StatusCode) - \(taskStatusClass.StatusDescription)")
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        self.itemStatusTextField.text = self.taskStatusListArray[0]
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get getTask Code Value..
    func getTaskCodeValue(catalogCode:String, codeGroup:String) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                self.taskArray.removeAll()
                self.taskListArray.removeAll()
                self.taskListArray.append(selectStr)
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    DispatchQueue.main.async {
                        if responseArr.count > 0{
                            self.taskArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                        }
                        for itemCount in 0..<self.taskArray.count {
                            let codeGroupClass = self.taskArray[itemCount]
                            self.taskListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                        }
                        if self.isFromEdit == false {
                            if self.taskListArray.count > 0{
                                self.taskCodeTextField.text = self.taskListArray[0]
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else{
                            let arr = self.taskArray.filter{$0.Code == "\(self.taskClass.TaskCode)"}
                            if arr.count > 0{
                                let codeGroupClass = arr[0]
                                self.taskCodeTextField.text = "\(codeGroupClass.Code) - \(codeGroupClass.CodeText)"
                            }
                        }
                    }
                    //Task code
                    if self.taskListArray.count > 0{
                        DispatchQueue.main.async {
                            self.taskCodeTextField.optionArray = self.taskListArray
                            self.taskCodeTextField.checkMarkEnabled = false
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
    //MARK:- All TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.taskViewTextField.resignFirstResponder()
        self.codeGroupTextField.resignFirstResponder()
        self.sortNumberTextField.resignFirstResponder()
        self.taskCodeTextField.resignFirstResponder()
        self.notificationTextField.resignFirstResponder()
        self.taskTextTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Set & Refresh Task Data..
    func setPrimaryTaskData() {
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == true {
            self.taskViewTextField.text = taskClass.Task
            self.sortNumberTextField.text = taskClass.SortNumber
            self.notificationTextField.text = taskClass.Notification
            self.itemTextField.text = itemNum
            self.taskTextTextField.text = taskClass.TaskText
            self.itemStatusView.isHidden = false
            if isItemTask == true{
                self.createTaskHeaderLabel.text = "Edit_Item_Task".localized() + ": \(taskClass.Task)"
            }else{
                self.createTaskHeaderLabel.text = "Edit_Task".localized() + ": \(taskClass.Task)"
            }
        }else {
            self.itemStatusView.isHidden = true
            let task = String.random(length: 4, type: "Number")
            self.taskViewTextField.text = task
            self.sortNumberTextField.text = sortNumber
            self.itemTextField.text = itemNum
            self.notificationTextField.text = selectedNotificationNumber
            self.createTaskHeaderLabel.text = "Create_Task".localized()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Refresh All Value..
    func refreshAllValue()  {
        mJCLogger.log("Starting", Type: "info")
        self.taskViewTextField.text = String.random(length: 4, type: "Number")
        if taskGroupListArray.count > 0{
            self.codeGroupTextField.text = taskGroupListArray[0]
        }
        if self.codeGroupTextField.text != ""{
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                self.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codeGrpArr[0])
            }
        }
        self.taskTextTextField.text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create & Update Task..
    func createNewTask()  {
        
        mJCLogger.log("Starting", Type: "info")
        
        self.allTextFieldResign()
        self.property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_TASK)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Cause")
        prop!.value = "0000" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ChangedOn")
        let date = Date().localDate()
        prop!.value = date as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CodeGroup")
        if self.codeGroupTextField.text != "" && self.codeGroupTextField.text != selectStr{
            let codeGropArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGropArr.count > 0{
                prop!.value = codeGropArr[0] as NSObject
                self.property.add(prop!)
            }
        }
        prop = SODataPropertyDefault(name: "CreatedBy")
        prop!.value = "\(strUser.uppercased())" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = date as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        if isItemTask == true{
            prop!.value = itemNum as NSObject
        }else{
            prop!.value = "0000" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(selectedNotificationNumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = "\(sortNumberTextField.text!)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Task")
        prop!.value = "\(taskViewTextField.text!)" as NSObject
        self.property.add(prop!)
        
        if self.taskCodeTextField.text != "" && self.taskCodeTextField.text != selectStr{
            prop = SODataPropertyDefault(name: "TaskCode")
            let taskCodeArr = self.taskCodeTextField.text!.components(separatedBy: " - ")
            if taskCodeArr.count > 0{
                prop!.value = taskCodeArr[0] as NSObject
                self.property.add(prop!)
            }
        }
        prop = SODataPropertyDefault(name: "TaskText")
        prop!.value = "\(taskTextTextField.text!)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(taskViewTextField.text!)" as NSObject
        self.property.add(prop!)
        
        var entitytypStr = String()
        var entitySet = String()
        
        if self.isfromWo == "FromWorkorder" {
            entitytypStr = woNotificationTaskCollectionEntity
            entitySet = woNotificationTaskCollection
        }else{
            entitytypStr = notificationTaskSetEntity
            entitySet = notificationTaskSet
        }
        
        let entity = SODataEntityDefault(type: entitytypStr)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name!)")
            print("Value :\(proper.value!)")
            print("..............")
        }
        if self.isfromWo == "FromWorkorder" {
            NotificationTaskModel.createWoNotificationTaskEntity(entity: entity!, collectionPath: entitySet,flushRequired: true,options: nil, completionHandler: { (response, error) in
                
                if(error == nil) {
                    mJCLogger.log("Task Created successfully", Type: "Debug")
                    self.delegate?.EntityCreated?()
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    mJCLogger.log("Fail_to_create_Task_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_Task_try_again".localized(), button: okay)
                }
            })
        }else{
            NotificationTaskModel.createNotificationTaskEntity(entity: entity!, collectionPath: entitySet,flushRequired: true,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    self.delegate?.EntityCreated?()
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    mJCLogger.log("Fail_to_create_Task_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_Task_try_again".localized(), button: okay)
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Update Task..
    func updateTask() {
        mJCLogger.log("Starting", Type: "info")
        if self.codeGroupTextField.text != ""{
            let codeGrpArr = self.codeGroupTextField.text!.components(separatedBy: " - ")
            if codeGrpArr.count > 0{
                (taskClass.entity.properties["CodeGroup"] as! SODataProperty).value = "\(codeGrpArr[0])" as NSObject
                taskClass.CodeGroup = codeGrpArr[0]
            }
        }
        if self.taskCodeTextField.text != ""{
            let taskCodeArr = self.taskCodeTextField.text!.components(separatedBy: " - ")
            if taskCodeArr.count > 0{
                (taskClass.entity.properties["TaskCode"] as! SODataProperty).value = taskCodeArr[0] as NSObject
                taskClass.TaskCode = taskCodeArr[0]
            }
        }
        if self.itemStatusTextField.text != selectStr && self.itemStatusTextField.text != ""{
            let arr = self.itemStatusTextField.text!.components(separatedBy: " - ")
            if arr.count > 0{
                let statusCode = arr[0]
                let arr1 = self.taskStatusArray.filter{$0.StatusCode == "\(statusCode)"}
                if arr1.count > 0{
                    let taskstatus = arr1[0]
                    let statusesArr = taskClass.UserStatus.components(separatedBy: " ")
                    if !statusesArr.contains("\(statusCode)"){
                        (taskClass.entity.properties["UserStatus"] as! SODataProperty).value = "\(taskClass.UserStatus) \(statusCode)" as NSObject
                    }
                    (taskClass.entity.properties["UserStatusCode"] as! SODataProperty).value = taskstatus.UserStatusCode as NSObject
                    taskClass.UserStatus = taskstatus.StatusCode
                    (taskClass.entity.properties["StatusFlag"] as! SODataProperty).value = "Y" as NSObject
                }else{
                    (taskClass.entity.properties["StatusFlag"] as! SODataProperty).value = "" as NSObject
                }
            }else{
                (taskClass.entity.properties["StatusFlag"] as! SODataProperty).value = "" as NSObject
            }
        }else{
            (taskClass.entity.properties["StatusFlag"] as! SODataProperty).value = "" as NSObject
        }
        (taskClass.entity.properties["TaskText"] as! SODataProperty).value = "\(self.taskTextTextField.text!)" as NSObject
        taskClass.TaskText = "\(self.taskTextTextField.text!)"
        NotificationTaskModel.updateNotificationTaskEntity(entity: taskClass.entity,flushRequired: true, options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Task Updated successfully", Type: "Debug")
                self.delegate?.EntityCreated?()
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log("Fail_to_update_Task_try_again".localized(), Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_Task_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func itemStatusButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let activeTask = WorkOrderDataManegeClass.uniqueInstance.getConsidereAsActive(status: taskClass.MobileStatus, from: NotificationTaskLevel)
        if activeTask == true{
            if self.taskStatusArray.count > 0 {
                mJCLogger.log("Response:\(self.taskStatusArray.count)", Type: "Debug")
                dropDown.anchorView = self.itemStatusTextFieldView
                let taskStatusList = self.taskStatusListArray
                let arr : [String] = taskStatusList as NSArray as! [String]
                dropDown.dataSource = arr
                dropDownSelectString = "TaskStatus"
                dropDown.show()
            }else{
                mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
            }
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "With_This_Task_Status_You_Cannot_Edit_Task_User_Status".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK: - Not Using Methods
    @IBAction func taskCodeGroupButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.taskGroupListArray.count > 0 {
            mJCLogger.log("Response:\(self.taskGroupListArray.count)", Type: "Debug")
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: taskGroupListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedTaskGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedTaskGropArray = selectedList
                self?.codeGroupTextField.text = selectedList.joined(separator: ";")
                let codeGrpArr = self?.codeGroupTextField.text!.components(separatedBy: " - ")
                if codeGrpArr?.count ?? 0 > 0{
                    self?.getTaskCodeValue(catalogCode: CATALOGCODE_TASK, codeGroup: codeGrpArr![0])
                }
            }
            if self.taskGroupListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.taskGroupListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.codeGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.codeGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func taskCodeButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.taskListArray.count > 0 {
            mJCLogger.log("Response:\(self.taskListArray.count)", Type: "Debug")
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: taskListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedTaskArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedTaskArray = selectedList
                self?.taskCodeTextField.text = selectedList.joined(separator: ";")
            }
            if self.taskListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.taskListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.taskCodeTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.taskCodeTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
