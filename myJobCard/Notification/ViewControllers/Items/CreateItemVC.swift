//
//  CreateItemVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/11/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CreateItemVC: UIViewController , UITextFieldDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var createItemHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    // Item Outlets..
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextFieldView: UIView!
    // DamegeGroup Outlets..
    @IBOutlet var damegeGroupView: UIView!
    @IBOutlet var damegeGroupTitleLabel: UILabel!
    @IBOutlet var damegeGroupTextField: iOSDropDown!
    @IBOutlet var damegeGroupTextFieldView: UIView!
    @IBOutlet var damageGroupButton: UIButton!
    // SortNumberView Outlets..
    @IBOutlet var sortNumberView: UIView!
    @IBOutlet var sortNumberTitleLabel: UILabel!
    @IBOutlet var sortNumberTextField: UITextField!
    @IBOutlet var sortNumberTextFieldView: UIView!
    // DamegeView Outlets..
    @IBOutlet var damegeView: UIView!
    @IBOutlet var damegeTitleLabel: UILabel!
    @IBOutlet var damegeTextField: iOSDropDown!
    @IBOutlet var damegeTextFieldView: UIView!
    @IBOutlet var damageButton: UIButton!
    //NotificationView Outlets..
    @IBOutlet var notificationView: UIView!
    @IBOutlet var notificationTitleLabel: UILabel!
    @IBOutlet var notificationTextField: UITextField!
    @IBOutlet var notificationTextFieldView: UIView!
    //DescriptionView Outlets..
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var descriptionTextFieldView: UIView!
    //plantView Outlets..
    @IBOutlet var partGroupView: UIView!
    @IBOutlet var partGroupTitleLabel: UILabel!
    @IBOutlet var partGroupTextField: iOSDropDown!
    @IBOutlet var partGroupTextFieldView: UIView!
    @IBOutlet var partGroupButton: UIButton!
    //plantView Outlets..
    @IBOutlet var partView: UIView!
    @IBOutlet var partTitleLabel: UILabel!
    @IBOutlet var partTextField: iOSDropDown!
    @IBOutlet var partTextFieldView: UIView!
    @IBOutlet var partButton: UIButton!
    //buttonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    //MARK:- Declared Variables..
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var damageArray = Array<CodeGroupModel>()
    var damageGroupArray = [CatalogProfileModel]()
    var damageGroupListArray = [String]()
    var damageListArray = [String]()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var isFromEdit = Bool()
    var itemClass = NotificationItemsModel()
    var notificationFrom = String()
    var isFromError = Bool()
    var errorItemClass = NotificationItemsModel()
    var partArray = Array<CodeGroupModel>()
    var partGroupArray = [CatalogProfileModel]()
    var partGroupListArray = [String]()
    var partListArray = [String]()
    var property = NSMutableArray()
    var sortNumber = String()
    var delegate: CreateUpdateDelegate?
    var catlogprof = String()
    var selectedDamageGropArray = [String]()
    var selectedDamageArray = [String]()
    var selectedPartArray = [String]()
    var selectedPartGropArray = [String]()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.SetViewLayout()
        self.descriptionTextField.placeholder = "Required".localized()
        self.descriptionTextField.delegate  = self
        self.setItemBasicData()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "DamageGroup" {
                self.damegeGroupTextField.text = item
                if self.damegeGroupTextField.text! != ""{
                    let damageGrpArr  = self.damegeGroupTextField.text!.components(separatedBy: " - ")
                    if damageGrpArr.count > 0{
                        self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: damageGrpArr[0])
                    }
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "PartGroup" {
                self.partGroupTextField.text = item
                let partGrpArr = item.components(separatedBy: " - ")
                if partGrpArr.count > 0{
                    self.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: partGrpArr[0])
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Damage" {
                self.damegeTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Part" {
                self.partTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        mJCLogger.log("Ended", Type: "info")
        
        //Part group
        self.partGroupTextField.didSelect{(selectedText , index , id) in
            self.partGroupTextField.text = selectedText
            let partGrpArr = selectedText.components(separatedBy: " - ")
            if partGrpArr.count > 0{
                self.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: partGrpArr[0])
            }
        }
        
        //Part textfield
        DispatchQueue.main.async {
            self.partTextField.didSelect{(selectedText , index , id) in
                self.partTextField.text = selectedText
            }
        }
        
        //Damage group
        DispatchQueue.main.async {
            self.damegeGroupTextField.didSelect{(selectedText , index , id) in
                self.damegeGroupTextField.text = selectedText
                let damageGrpArr  = self.damegeGroupTextField.text!.components(separatedBy: " - ")
                if damageGrpArr.count > 0{
                    self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: damageGrpArr[0])
                }
            }
        }
        
        //Part textfield
        DispatchQueue.main.async {
            self.damegeTextField.didSelect{(selectedText , index , id) in
                self.damegeTextField.text = selectedText
            }
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
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        
        mJCLogger.log("Starting", Type: "info")
        if textField == self.descriptionTextField {
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength {
                mJCLogger.log("Item_Text_length_should_not_be_more_than_40_characters".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Item_Text_length_should_not_be_more_than_40_characters".localized() , button: okay)
                mJCLogger.log("Ended", Type: "info")
                return newString.length <= maxLength
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return true
    }
    //MARK:- footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
//        if descriptionTextField.text == "" {
//            mJCLogger.log("Please_enter_item_text".localized(), Type: "Debug")
//            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_item_text".localized(), button: okay)
//        }else {
            if isFromEdit == true {
                if isFromError == true{
                    self.updateErrorItem()
                }else{
                    self.updateItem()
                }
            }else {
                self.createNewItem()
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
        self.setItemBasicData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backbuttonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Cause Group..
    func getDamageAndPartGroupValuse(){
        // Damege Group
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
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let damgeGropArr = catlogArray.filtered(using: searchPredicate) as Array
        self.damageGroupArray.removeAll()
        self.damageGroupListArray.removeAll()
        if let arr = damgeGropArr as? [CatalogProfileModel]{
            self.damageGroupArray = arr
            self.damageGroupListArray.append(selectStr)
            for item in self.damageGroupArray{
                self.damageGroupListArray.append("\(item.CodeGroup) - \(item.ShortText)")
            }
        }
        if self.damageGroupListArray.count > 0 {
            DispatchQueue.main.async {
                self.damegeGroupTextField.optionArray = self.damageGroupListArray
                self.damegeGroupTextField.checkMarkEnabled = false
            }
        }
        self.setDamageGroupValue()
        //damage group End
        
        //part Group
        if self.catlogprof == ""{
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        self.partGroupArray.removeAll()
        self.partGroupListArray.removeAll()
        self.partGroupListArray.append(selectStr)
        let partGrpArray = catlogArray.filtered(using: searchPredicate) as Array
        if let arr = partGrpArray as? [CatalogProfileModel]{
            self.partGroupArray = arr
            for item in self.partGroupArray{
                self.partGroupListArray.append("\(item.CodeGroup) - \(item.ShortText)")
            }
        }
        if self.partGroupListArray.count > 0 {
            DispatchQueue.main.async {
                self.partGroupTextField.optionArray = self.partGroupListArray
                self.partGroupTextField.checkMarkEnabled = false
            }
        }
        self.setPartGroupValue()
    }
    //Set Damage Group Value..
    func setDamageGroupValue() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.isFromEdit == true && self.isFromError == true{
                var searchPredicate = NSPredicate()
                if self.catlogprof == ""{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CodeGroup == '\(self.errorItemClass.DamageCodeGroup)'")
                }else{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == '\(self.catlogprof)' AND SELF.CodeGroup == '\(self.errorItemClass.DamageCodeGroup)'")
                }
                let filterArray = (self.damageGroupArray as NSArray).filtered(using: searchPredicate) as! [CatalogProfileModel]
                if filterArray.count > 0{
                    let catalogProfileClass = filterArray[0]
                    self.damegeGroupTextField.text = "\(catalogProfileClass.CodeGroup) - \(catalogProfileClass.ShortText)"
                    self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: catalogProfileClass.CodeGroup)
                }else {
                    self.damegeGroupTextField.text = ""
                    self.damegeTextField.text = ""
                }
            }else  if self.isFromEdit == true {
                var searchPredicate = NSPredicate()
                if self.catlogprof == ""{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CodeGroup == '\(self.itemClass.DamageCodeGroup)'")
                }else{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == '\(self.catlogprof)' AND SELF.CodeGroup == '\(self.itemClass.DamageCodeGroup)'")
                }
                let filterArray = (self.damageGroupArray as NSArray).filtered(using: searchPredicate) as! [CatalogProfileModel]
                if filterArray.count > 0{
                    let catalogProfileClass = filterArray[0]
                    self.damegeGroupTextField.text = "\(catalogProfileClass.CodeGroup) - \(catalogProfileClass.ShortText)"
                    self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: catalogProfileClass.CodeGroup)
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                    self.damegeGroupTextField.text = ""
                    self.damegeTextField.text = ""
                }
            }else {
                if self.damageGroupListArray.count > 0 {
                    let  damageGroupShortText = self.damageGroupListArray[0]
                    let damageGrpArry = damageGroupShortText.components(separatedBy: " - ")
                    if damageGrpArry.count > 0{
                        self.damegeGroupTextField.text = damageGroupShortText
                        self.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: damageGrpArry[0])
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Damage Value..
    func getDamageValue(catalogCode:String, codeGroup:String) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.damageArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                    self.setDamageValue()
                }else{
                    mJCLogger.log("Data not found", Type: "Error")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Damage Value..
    func setDamageValue()  {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.damageListArray.removeAll()
            self.damageListArray.append(selectStr)
            for itemCount in 0..<self.damageArray.count {
                let codeGroupClass = self.damageArray[itemCount]
                self.damageListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
            }
            
            if self.damageListArray.count > 0{
                self.damegeTextField.optionArray = self.damageListArray
                self.damegeTextField.checkMarkEnabled = false
            }
            if self.isFromEdit == true && self.isFromError == true{
                let arr = self.damageArray.filter{$0.Code == "\(self.errorItemClass.DamageCode)"}
                if arr.count > 0{
                    let cls = arr[0]
                    self.damegeTextField.text = "\(cls.Code) - \(cls.CodeText)"
                }
            }else if self.isFromEdit == true {
                let arr = self.damageArray.filter{$0.Code == "\(self.itemClass.DamageCode)"}
                if arr.count > 0{
                    let cls = arr[0]
                    self.damegeTextField.text = "\(cls.Code) - \(cls.CodeText)"
                }
            }else{
                if self.damageListArray.count > 0 {
                    self.damegeTextField.text = self.damageListArray[0]
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Set Part Group Value & Get Part value..
    func setPartGroupValue() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.isFromEdit == true && self.isFromError == true{
                var searchPredicate = NSPredicate()
                if self.catlogprof == ""{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CodeGroup == '\(self.errorItemClass.CodeGroupParts)'")
                }else{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == '\(self.catlogprof)' AND SELF.CodeGroup == '\(self.errorItemClass.CodeGroupParts)'")
                }
                let filterArray = (self.partGroupArray as NSArray).filtered(using: searchPredicate) as! [CatalogProfileModel]
                if filterArray.count > 0{
                    let catalogProfileClass = filterArray[0]
                    self.partGroupTextField.text = "\(catalogProfileClass.CodeGroup) - \(catalogProfileClass.ShortText)"
                    self.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: self.itemClass.CodeGroupParts)
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else if self.isFromEdit == true {
                var searchPredicate = NSPredicate()
                if self.catlogprof == ""{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CodeGroup == '\(self.itemClass.CodeGroupParts)'")
                }else{
                    searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == '\(self.catlogprof)' AND SELF.CodeGroup == '\(self.itemClass.CodeGroupParts)'")
                }
                let filterArray = (self.partGroupArray as NSArray).filtered(using: searchPredicate) as! [CatalogProfileModel]
                if filterArray.count > 0{
                    let catalogProfileClass = filterArray[0]
                    self.partGroupTextField.text = "\(catalogProfileClass.CodeGroup) - \(catalogProfileClass.ShortText)"
                    self.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: self.itemClass.CodeGroupParts)
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                if self.partGroupListArray.count > 0 {
                    let partGroup = self.partGroupListArray[0]
                    if  partGroup != ""{
                        let partGrpArr = partGroup.components(separatedBy: " - ")
                        if partGrpArr.count > 0{
                            self.partGroupTextField.text = partGroup
                            self.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: partGrpArr[0])
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Parts Value..
    func getPartValue(catalogCode:String, codeGroup:String) {
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                self.partArray.removeAll()
                self.partListArray.removeAll()
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.partArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                    self.setPartValue()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Part value..
    func setPartValue()  {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.partListArray.append(selectStr)
            for itemCount in 0..<self.partArray.count {
                let codeGroupClass = self.partArray[itemCount]
                self.partListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
            }
            if self.partListArray.count > 0 {
                DispatchQueue.main.async {
                    self.partTextField.optionArray = self.partListArray
                    self.partTextField.checkMarkEnabled = false
                }
            }
            if self.isFromEdit == true && self.isFromError == true{
                let arr = self.partArray.filter{$0.Code == "\(self.errorItemClass.ObjectPartCode)"}
                if arr.count > 0{
                    let codeclss = arr[0]
                    self.partTextField.text = "\(codeclss.Code) - \(codeclss.CodeText)"
                }
            }else if self.isFromEdit == true {
                let arr = self.partArray.filter{$0.Code == "\(self.itemClass.ObjectPartCode)"}
                if arr.count > 0{
                    let codeclss = arr[0]
                    self.partTextField.text = "\(codeclss.Code) - \(codeclss.CodeText)"
                }
            }else{
                if self.partListArray.count > 0 {
                    self.partTextField.text = self.partListArray[0]
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.itemTextField.resignFirstResponder()
        self.damegeGroupTextField.resignFirstResponder()
        self.sortNumberTextField.resignFirstResponder()
        self.damegeTextField.resignFirstResponder()
        self.notificationTextField.resignFirstResponder()
        self.descriptionTextField.resignFirstResponder()
        self.partGroupTextField.resignFirstResponder()
        self.partTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Set Item Basic Data..
    func setItemBasicData() {
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == true {
            if isFromError == true{
                self.itemTextField.text = errorItemClass.Item
                self.sortNumberTextField.text = errorItemClass.SortNumber
                self.notificationTextField.text = errorItemClass.Notification
                self.descriptionTextField.text = errorItemClass.ShortText
            }else{
                self.itemTextField.text = itemClass.Item
                self.sortNumberTextField.text = itemClass.SortNumber
                self.notificationTextField.text = itemClass.Notification
            }
            self.descriptionTextField.text = itemClass.ShortText
            self.createItemHeaderLabel.text = "Edit_Item".localized() + ": \(itemClass.Item)"
        }else {
            let item = String.random(length: 4, type: "Number")
            self.itemTextField.text = item
            self.sortNumberTextField.text = sortNumber
            self.notificationTextField.text = selectedNotificationNumber
            self.createItemHeaderLabel.text = "Create_Item".localized()
            self.descriptionTextField.text = ""
        }
        self.GetCatalogProfileSet()
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
                                            self.getDamageAndPartGroupValuse()
                                        }
                                    }
                                }
                            }else{
                                self.getDamageAndPartGroupValuse()
                            }
                        }else{
                            self.getDamageAndPartGroupValuse()
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
                        self.getDamageAndPartGroupValuse()
                    }
                }
            }
        }else{
            self.catlogprof = ""
            self.getDamageAndPartGroupValuse()
        }
    }
    //MARK:- Set View Layout..
    func SetViewLayout() {
        mJCLogger.log("Starting", Type: "info")
        ODSUIHelper.setBorderToView(view:self.itemTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.damegeGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.sortNumberTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.damegeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.notificationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.partGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.partTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create & Update Item..
    func createNewItem() {
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_ITEM)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "\(self.itemTextField.text!)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(selectedNotificationNumber)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "ShortText")
        prop!.value = "\(self.descriptionTextField.text!)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = "\(self.sortNumberTextField.text!)" as NSObject
        self.property.add(prop!)

        if self.damegeGroupTextField.text != "" && self.damegeGroupTextField.text != selectStr{
            prop = SODataPropertyDefault(name: "DamageCodeGroup")
            let damageGrpArry = self.damegeGroupTextField.text!.components(separatedBy: " - ")
            if damageGrpArry.count > 0{
                prop!.value = damageGrpArry[0] as NSObject
                self.property.add(prop!)
            }
        }

        if self.damegeTextField.text != "" && self.damegeTextField.text != selectStr{
            prop = SODataPropertyDefault(name: "DamageCode")
            let damageArr = self.damegeTextField.text!.components(separatedBy: " - ")
            if damageArr.count > 0 {
                prop!.value = damageArr[0] as NSObject
                self.property.add(prop!)
            }
        }
        if self.partGroupTextField.text != "" && self.partGroupTextField.text != selectStr{
            let partGrpArr = self.partGroupTextField.text!.components(separatedBy: " - ")
            if partGrpArr.count > 1{
                prop = SODataPropertyDefault(name: "CodeGroupParts")
                prop!.value = partGrpArr[0] as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "CodeGroupPartsText")
                prop!.value = partGrpArr[1] as NSObject
                self.property.add(prop!)
            }
        }
        if self.partTextField.text != "" && self.partTextField.text != selectStr{
            let partDrpArr = self.partTextField.text!.components(separatedBy: " - ")
            if partDrpArr.count > 0{
                prop = SODataPropertyDefault(name: "ObjectPartCode")
                prop!.value = partDrpArr[0] as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "ObjectPartCodeText")
                prop!.value = partDrpArr[1] as NSObject
                self.property.add(prop!)
            }
        }
        let date = Date().localDate()
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = date as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "ChangedOn")
        prop!.value = date as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "DefectTypes")
        prop!.value = "\(CATALOGCODE_DAMAGE)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = strUser.uppercased() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        if selectedNotificationNumber.contains(find: "L"){
            prop!.value = "\(selectedNotificationNumber)" as NSObject
        }else{
            prop!.value = "\(self.itemTextField.text!)" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Version")
        prop!.value = "1" as NSObject
        self.property.add(prop!)
        
        var itemSet_Entity = String()
        var itemSet = String()
        
        if isSingleNotification == false {
            itemSet_Entity = notificationItemSetEntity
            itemSet = notificationItemSet
        }else{
            itemSet_Entity = woNotificationItemCollectionEntity
            itemSet = woNotificationItemCollection
        }
        let entity = SODataEntityDefault(type: itemSet_Entity)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        if isSingleNotification == false {
            NotificationItemsModel.createNotificationItemEntity(entity: entity!, collectionPath: itemSet,flushRequired: true,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Response:\(response.count)", Type: "Debug")
                    mJCLogger.log("Item Created successfully".localized(), Type: "Debug")
                    self.delegate?.EntityCreated?()
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    mJCLogger.log("Fail_to_create_item_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_item_try_again".localized(), button: okay)
                }
            })
        }else {
            NotificationItemsModel.createWoNotificationItemEntity(entity: entity!, collectionPath: itemSet,flushRequired: true,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Response:\(response.count)", Type: "Debug")
                    mJCLogger.log("Item Created successfully".localized(), Type: "Debug")
                    self.delegate?.EntityCreated?()
                    DispatchQueue.main.async {
                        self.dismiss(animated: false) {}
                    }
                }else {
                    mJCLogger.log("Fail_to_create_item_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_create_item_try_again".localized(), button: okay)
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    func updateErrorItem(){
        
        mJCLogger.log("Starting", Type: "info")
        let partGrp = "\(self.partGroupTextField.text!)"
        let partGrpArr = partGrp.components(separatedBy: " - ")
        if partGrpArr.count > 0{
            (errorItemClass.entity.properties["CodeGroupParts"] as! SODataProperty).value = partGrpArr[0] as NSObject
        }
        (errorItemClass.entity.properties["CodeGroupPartsText"] as! SODataProperty).value = "\(self.partTextField.text!)" as NSObject
        if self.damegeGroupTextField.text! != ""{
            let damageGrpArr  = self.damegeGroupTextField.text!.components(separatedBy: " - ")
            if damageGrpArr.count > 0{
                (errorItemClass.entity.properties["DamageCodeGroup"] as! SODataProperty).value = damageGrpArr[0] as NSObject
            }
        }
        if self.damegeTextField.text != ""{
            let damageArr = self.damegeTextField.text!.components(separatedBy: " - ")
            if damageArr.count > 0 {
                (errorItemClass.entity.properties["DamageCode"] as! SODataProperty).value = damageArr[0] as NSObject
            }
        }
        if self.partTextField.text != ""{
            let codeTextArr = self.partTextField.text!.components(separatedBy: " - ")
            if codeTextArr.count > 1{
                (itemClass.entity.properties["ObjectPartCode"] as! SODataProperty).value = codeTextArr[0] as NSObject
                itemClass.ObjectPartCode = codeTextArr[0]
                (itemClass.entity.properties["ObjectPartCodeText"] as! SODataProperty).value = codeTextArr[1] as NSObject
                itemClass.ObjectPartCodeText = codeTextArr[1]
            }
        }
        (errorItemClass.entity.properties["ShortText"] as! SODataProperty).value = "\(self.descriptionTextField.text!)" as NSObject
        NotificationItemsModel.updateNotificationItemEntity(entity: itemClass.entity,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            mJCLogger.log("Response:\(response.count)", Type: "Debug")
            if(error == nil) {
                mJCLogger.log("Item Updated successfully".localized(), Type: "Debug")
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log("Fail_to_update_item_try_again".localized(), Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_item_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func updateItem()
    {
        mJCLogger.log("Starting", Type: "info")
        let partGrp = "\(self.partGroupTextField.text!)"
        let partGrpArr = partGrp.components(separatedBy: " - ")
        if partGrpArr.count > 0{
            (itemClass.entity.properties["CodeGroupParts"] as! SODataProperty).value = partGrpArr[0] as NSObject
            itemClass.CodeGroupParts = partGrpArr[0]
        }
        (itemClass.entity.properties["CodeGroupPartsText"] as! SODataProperty).value = "\(self.partTextField.text!)" as NSObject
        itemClass.CodeGroupPartsText = "\(self.partTextField.text!)"
        if self.damegeGroupTextField.text! != ""{
            let damageGrpArr  = self.damegeGroupTextField.text!.components(separatedBy: " - ")
            if damageGrpArr.count > 0{
                (itemClass.entity.properties["DamageCodeGroup"] as! SODataProperty).value = damageGrpArr[0] as NSObject
                itemClass.DamageCodeGroup = damageGrpArr[0]
            }
        }
        if self.damegeTextField.text != ""{
            let damageArr = self.damegeTextField.text!.components(separatedBy: " - ")
            if damageArr.count > 0 {
                (itemClass.entity.properties["DamageCode"] as! SODataProperty).value = damageArr[0] as NSObject
                itemClass.DamageCode = damageArr[0]
            }
        }
        if self.partTextField.text != ""{
            let codeTextArr = self.partTextField.text!.components(separatedBy: " - ")
            if codeTextArr.count > 1{
                (itemClass.entity.properties["ObjectPartCode"] as! SODataProperty).value = codeTextArr[0] as NSObject
                itemClass.ObjectPartCode = codeTextArr[0]
                (itemClass.entity.properties["ObjectPartCodeText"] as! SODataProperty).value = codeTextArr[1] as NSObject
                itemClass.ObjectPartCodeText = codeTextArr[1]
            }
        }
        (itemClass.entity.properties["ShortText"] as! SODataProperty).value = "\(self.descriptionTextField.text!)" as NSObject
        itemClass.ShortText = "\(self.descriptionTextField.text!)"
        NotificationItemsModel.updateNotificationItemEntity(entity: itemClass.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            mJCLogger.log("Response:\(response.count)", Type: "Debug")
            if(error == nil) {
                mJCLogger.log("Item Updated successfully".localized(), Type: "Debug")
                self.delegate?.EntityCreated?()
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log("Fail_to_update_item_try_again".localized(), Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_item_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK: - Not Using Methods
    //MARK:- Field Button Action
    @IBAction func damageGroupButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.damageGroupListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: damageGroupListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedDamageGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedDamageGropArray = selectedList
                self?.damegeGroupTextField.text = selectedList.joined(separator: ";")
                let damageGrpArr  = self?.damegeGroupTextField.text!.components(separatedBy: " - ")
                if damageGrpArr?.count ?? 0 > 0{
                    self?.getDamageValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: damageGrpArr![0])
                }
            }
            if self.damageGroupListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.damageGroupListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.damegeGroupTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.damegeGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func damageButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.damageListArray.count > 0 {
            let selectionMenu = RSSelectionMenu(selectionStyle: .single,dataSource: self.damageListArray,cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: selectedDamageArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedDamageArray = selectedList
                self?.damegeTextField.text = selectedList.joined(separator: ";")
            }
            if self.damageListArray.count > 6{
                selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in
                    return self?.damageListArray.filter({$0.containsIgnoringCase(find: searchText)}) ?? []
                }
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.damegeTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.damegeTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
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
            selectionMenu.setSelectedItems(items: selectedPartGropArray) { [weak self] (text, index, selected, selectedList) in
                self?.selectedPartGropArray = selectedList
                self?.partGroupTextField.text = selectedList.joined(separator: ";")
                let partGrpArr = self?.partGroupTextField.text!.components(separatedBy: " - ")
                if partGrpArr?.count ?? 0 > 0{
                    self?.getPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: partGrpArr![0])
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
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func partButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.partListArray.count > 0 {
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
            let size = CGSize(width: self.partTextFieldView.frame.size.width, height: 180)
            selectionMenu.show(style: .popover(sourceView: self.partTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }else{
            mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //...END...//
}

