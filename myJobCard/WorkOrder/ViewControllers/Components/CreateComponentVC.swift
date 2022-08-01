//
//  CreateComponentVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/11/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CreateComponentVC: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate,barcodeDelegate,SelectComponetDelegate,viewModelDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var addCompponentHeaderLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    //MARK:- ComponentSerialNumberView Outlets..
    @IBOutlet var componentSerialNumberView: UIView!
    @IBOutlet var componentSerialNumberTitleLabel: UILabel!
    @IBOutlet var componentSerialNumberTextField: UITextField!
    @IBOutlet var componentSerialNumberTextFieldView: UIView!
    
    //MARK:- ItemView Outlets..
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextTitleLabel: UILabel!
    @IBOutlet var itemButton: UIButton!
    @IBOutlet var itemTextFieldView: UIView!
    @IBOutlet var itemTextLabel: UILabel!
    @IBOutlet var itemTextSelectButton: UIButton!
    
    @IBOutlet var itemScanButton: UIButton!
    //MARK:- OperationView Outlets..
    @IBOutlet var operationView: UIView!
    @IBOutlet var operationTitleLabel: UILabel!
    @IBOutlet var operationTextFieldView: UIView!
    @IBOutlet var operationTextField: iOSDropDown!
    @IBOutlet var operationButton: UIButton!
    
    //MARK:- DescriptionView Outlets..
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var descriptionTextFieldView: UIView!
    
    //MARK:- PlantView Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTitleLabel: UILabel!
    @IBOutlet var plantTextField: iOSDropDown!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantButton: UIButton!
    
    //MARK:- QuintityView Outlets.
    @IBOutlet var quintityView: UIView!
    @IBOutlet var quintityTitleLabel: UILabel!
    @IBOutlet var quintityTextFieldView: UIView!
    @IBOutlet var quintityTextField: UITextField!    
    @IBOutlet var checkAvailablityButton: UIButton!
    
    @IBOutlet var storageLocationView: UIView!
    @IBOutlet var storageLocationTitleLabel: UILabel!
    @IBOutlet var storageLocationTextFieldView: UIView!
    @IBOutlet weak var storageLocationTextField: iOSDropDown!
    @IBOutlet var storageLocationButton: UIButton!
    
    //MARK:- ButtonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var bomListButton: UIButton!
    @IBOutlet var materialStockButton: UIButton!
    @IBOutlet var woComponentHistory: UIButton!
    @IBOutlet var descriptionTop: NSLayoutConstraint!
    @IBOutlet var itemViewHieght: NSLayoutConstraint!
    @IBOutlet weak var inStockButton: UIButton!
    @IBOutlet var selectItemStackVIew: UIStackView!
    @IBOutlet var issueComponentButton: UIButton!

    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var componentAvailable = ComponentAvailabilityModel()
    var componentArray = NSMutableArray()
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var isFromEdit = Bool()
    var isFromScreen = String()
    var isFromError = Bool()
    var errorComponent = WoComponentModel()
    var plantArray = [String]()
    var maintPlantArray = [MaintencePlantModel]()
    var storageLocationArray = [StorageLocationModel]()
    var operationArray = [WoOperationModel]()
    var operationListArray = [String]()
    var property = NSMutableArray()
    var sortNumber = String()
    var selectedComp = WoComponentModel()
    var itemEdit = String()
    var isBomItem = false
    var isWoHistory = false
    var selectedStorageLoc = String()
    var isFromCheckCompScreen = Bool()
    var createUpdateDelegate:CreateUpdateDelegate?
    var componentAvailabilityViewModel = ComponentAvailabilityViewModel()
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setMandatoryFields()
        componentAvailabilityViewModel.delegate = self
        mJCLogger.log("Starting", Type: "info")
        inStockButton.setImage(UIImage(named: "ic_check_fill"), for: .normal)
        inStockAvailable = false
        inStockButton.isHidden = true
        itemView.isHidden = true
        itemViewHieght.constant = 0
        descriptionView.isHidden = true
        self.property.removeAllObjects()
        ODSUIHelper.setBorderToView(view:self.componentSerialNumberTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.operationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.descriptionTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.quintityTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.storageLocationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "PlantDropDown" {
                self.plantTextField.text = item
                self.itemEdit = item
                self.dropDownSelectString = ""
                let arr = item.components(separatedBy: " - ")
                if arr.count > 0{
                    self.getStorageLocations(plant:arr[0])
                }
            }else if self.dropDownSelectString == "OperationDropDown" {
                self.operationTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "StoragLocation"{
                self.storageLocationTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        if isFromEdit == true {
            addCompponentHeaderLabel.text = "Edit_Component".localized()
            if isFromError != true{
                self.itemButton.isUserInteractionEnabled = false
                self.operationTextField.isUserInteractionEnabled = false
                self.descriptionTextField.isUserInteractionEnabled = false
                self.plantTextField.isUserInteractionEnabled = false
                self.componentSerialNumberTextField.isUserInteractionEnabled = false
                self.storageLocationTextField.isUserInteractionEnabled = false
                self.itemScanButton.isUserInteractionEnabled = false
                self.itemViewHieght.constant = 65
                itemView.isHidden = false
                descriptionView.isHidden = false
                selectItemStackVIew.isHidden = true
            }
            self.setCreateComponentData()
        }else {
            if isFromScreen == "Component" {
                self.storageLocationTextField.isUserInteractionEnabled = true
                self.itemTextField.isUserInteractionEnabled = true
                self.operationTextField.isUserInteractionEnabled = true
                self.descriptionTextField.isUserInteractionEnabled = true
                self.plantTextField.isUserInteractionEnabled = true
                self.componentSerialNumberTextField.isUserInteractionEnabled = true
                selectItemStackVIew.isHidden = false
                self.setCreateComponentData()
            }
        }
        self.getMaintPlantList()
        if isFromEdit == true && isFromError == true{
            self.getOpeartionList(workorderNumber: errorComponent.WorkOrderNum)
        }else{
            self.getOpeartionList(workorderNumber: selectedworkOrderNumber)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateComponentVC.handleTap(sender:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        materialStockButton.addTarget(self, action: #selector(BomItemSelected), for: .touchUpInside)
        bomListButton.addTarget(self, action: #selector(BomItemSelected), for: .touchUpInside)
        woComponentHistory.addTarget(self, action: #selector(BomItemSelected), for: .touchUpInside)
        
        //Operation
        self.operationTextField.didSelect { selectedText, index, id in
            self.operationTextField.text = selectedText
        }
        
        //Plant
        self.plantTextField.didSelect { selectedText, index, id in
            self.plantTextField.text = selectedText
        }
        
        //Storage location
        self.storageLocationTextField.didSelect { selectedText, index, id in
            self.storageLocationTextField.text = selectedText
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Field Button Action..
    @IBAction func itemTextSelectButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if sender.isSelected == true {
            itemButton.isEnabled = true
            sender.isSelected = false
            descriptionTextField.isEnabled = false
            descriptionTextField.text = ""
        }else {
            sender.isSelected = true
            if sender.isSelected == true{
                itemButton.isEnabled = false
            }
            descriptionTextField.isEnabled = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setSeleceditem(selectedItem: ComponentAvailabilityModel) {
        
        mJCLogger.log("Starting", Type: "info")
        componentAvailable = selectedItem
        self.descriptionTextField.text = componentAvailable.MaterialDescription
        if isBomItem == true {
            self.itemTextField.text = "\(componentAvailable.Component)"
        }else if isWoHistory == true {
            self.itemTextField.text = "\(componentAvailable.Material)"
        }else{
            self.itemTextField.text = "\(componentAvailable.Material)"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func BomItemSelected(btn: UIButton){
        mJCLogger.log("Starting", Type: "info")
        btn.isSelected = !btn.isSelected
        if btn.isSelected{
            itemView.isHidden = false
            descriptionView.isHidden = false
            itemTextFieldView.isHidden = false
            itemViewHieght.constant = 65
            if btn.tag == 1 {
                isBomItem = true
                isWoHistory = false
                if bomListButton.isSelected == true{
                    materialStockButton.isSelected = false
                    woComponentHistory.isSelected = false
                    self.inStockButton.isHidden = true
                    inStockAvailable = true
                }
            }else if btn.tag == 2 {
                isBomItem = false
                isWoHistory = false
                if materialStockButton.isSelected == true{
                    bomListButton.isSelected = false
                    woComponentHistory.isSelected = false
                    self.inStockButton.isHidden = false
                }
            }else if btn.tag == 3 {
                isBomItem = false
                isWoHistory = true
                if woComponentHistory.isSelected == true{
                    materialStockButton.isSelected = false
                    bomListButton.isSelected = false
                    self.inStockButton.isHidden = true
                }
            }
        }else{
            isBomItem = false
            isWoHistory = false
            bomListButton.isSelected = false
            materialStockButton.isSelected = false
            woComponentHistory.isSelected = false
            itemView.isHidden = true
            descriptionView.isHidden = true
            itemTextFieldView.isHidden = true
            itemViewHieght.constant = 0
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func issueComponentButtonAction(_ sender: Any) {
    }
    @IBAction func checkAvailablityButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        let plantSepArray = plantTextField.text?.components(separatedBy: " - ")
        let storageLocArray = storageLocationTextField.text?.components(separatedBy: " - ")
        var storageLocation = String()
        storageLocation = storageLocArray![0]
        let componentAvailabilityVC = ScreenManager.getComponentAvailabilityScreen()
        DispatchQueue.main.async {
            componentAvailabilityVC.componentAvailabilityViewModel.selectedPlant = plantSepArray![0]
            componentAvailabilityVC.componentAvailabilityViewModel.isBomItem = self.isBomItem
            componentAvailabilityVC.componentAvailabilityViewModel.isWoHistory = self.isWoHistory
            componentAvailabilityVC.componentAvailabilityViewModel.isFromCheckCompScreen = true
            componentAvailabilityVC.componentAvailabilityViewModel.selectedStortageLocation = storageLocation
            componentAvailabilityVC.modalPresentationStyle = .fullScreen
            self.present(componentAvailabilityVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func itemButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if plantTextField.text == ""{
            mJCLogger.log("Please_Select_Plant".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_select_the_plant".localized(), button: okay)
        }else{
            DispatchQueue.main.async {
                let plantSepArray = self.plantTextField.text?.components(separatedBy: " - ")
                let storageLocation = self.storageLocationTextField.text?.components(separatedBy: " - ")
                let componentAvailabilityVC = ScreenManager.getComponentAvailabilityScreen()
                componentAvailabilityVC.componentAvailabilityViewModel.selectedPlant = plantSepArray![0]
                componentAvailabilityVC.modalPresentationStyle = .fullScreen
                componentAvailabilityVC.delegateComp = self
                componentAvailabilityVC.componentAvailabilityViewModel.isFromCheckCompScreen = false
                componentAvailabilityVC.componentAvailabilityViewModel.isBomItem = self.isBomItem
                componentAvailabilityVC.componentAvailabilityViewModel.isWoHistory = self.isWoHistory
                componentAvailabilityVC.componentAvailabilityViewModel.selectedStortageLocation = storageLocation![0]
                self.present(componentAvailabilityVC, animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func itemscanButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Material", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.itemTextTitleLabel)
        myAssetDataManager.setMandatoryLabel(label: self.quintityTitleLabel)
    }
    //MARK:- Footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == false{
            if !bomListButton.isSelected && !materialStockButton.isSelected && !woComponentHistory.isSelected{
                mJCLogger.log("please_select_item_type".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "please_select_item_type".localized(), button: okay)
                return
            }else{
                if itemTextField.text == "" {
                    mJCLogger.log("Please_select_item".localized(), Type: "Warn")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_select_item".localized(), button: okay)
                    return
                }
            }
        }
        if quintityTextField.text == "" {
            mJCLogger.log("Please_enter_quantity".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_quantity".localized(), button: okay)
            return
        }else if quintityTextField.text?.contains(find: "-") ?? false{
            mJCLogger.log("nagative_values_not_allowed".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "nagative_values_not_allowed".localized(), button: okay)
            return
        } else if (NSDecimalNumber(string: self.quintityTextField.text) as Decimal == 0) || Int(self.quintityTextField.text!) == nil{
            mJCLogger.log("Invalid_Quantity_Please_enter_valid_one".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Invalid_Quantity_Please_enter_valid_one".localized(), button: okay)
            return
        }else {
            var stock = Decimal()
            if isBomItem == true
            {
                stock = componentAvailable.Quantity as Decimal
            }else{
                stock = componentAvailable.Stock as Decimal
            }
            let add = Decimal(string: quintityTextField.text ?? "0") ?? 0.0
            if stock < add{
                let params = Parameters(
                    title: alerttitle,
                    message: "Quantity_of_Add_Component_is_more_than_the_available_Qunatity_Do_you_want_to_continue".localized(),
                    cancelButton: "Cancel".localized(),
                    otherButtons: ["Continue".localized()]
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: return
                    case 1:
                        self.createCompnent()
                    default: break
                    }
                }
            }else{
                if isFromScreen == "Component" {
                    if isFromEdit == true {
                        if isFromError == true{
                            self.updateErrorComponent()
                        }else{
                            self.updateComponent()
                        }
                    }else {
                        self.createCompnent()
                    }
                }
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
        itemButton.isEnabled = true
        self.plantTextField.text = ""
        self.setCreateComponentData()
        mJCLogger.log("Response :\(self.plantArray.count)", Type: "Debug")
        for i in 0..<self.plantArray.count{
            let str = self.plantArray[i]
            if str.range(of: userPlant) != nil{
                self.plantTextField.text = self.plantArray[i]
            }
        }
        if operationListArray.count > 0{
            self.operationTextField.text = operationListArray[0]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.allTextFieldResign()
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.descriptionTextField.resignFirstResponder()
        self.plantTextField.resignFirstResponder()
        self.componentSerialNumberTextField.resignFirstResponder()
        self.itemTextField.resignFirstResponder()
        self.quintityTextField.resignFirstResponder()
        self.operationTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    func setCreateComponentData()  {
        mJCLogger.log("Starting", Type: "info")
        if isFromEdit == true{
            if isFromError == true{
                self.descriptionTextField.text = errorComponent.ItemText
                self.quintityTextField.text = "\(errorComponent.ReqmtQty)"
                sortNumber = errorComponent.Item
                self.componentSerialNumberTextField.text = sortNumber
            }else{
                self.descriptionTextField.text = selectedComp.ItemText
                self.quintityTextField.text = "\(selectedComp.ReqmtQty)"
                sortNumber = selectedComp.Item
                self.componentSerialNumberTextField.text = sortNumber
            }
        }else{
            self.componentSerialNumberTextField.text = sortNumber
            self.itemTextField.text = ""
            self.descriptionTextField.text = ""
            self.descriptionTextField.isEnabled = false
            self.quintityTextField.text = ""
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func updateErrorComponent() {
        
        mJCLogger.log("Starting", Type: "info")
        (errorComponent.entity.properties["Item"] as! SODataProperty).value = "\(String(describing: componentSerialNumberTextField.text))" as NSObject
        (errorComponent.entity.properties["ItemText"] as! SODataProperty).value = "\(self.descriptionTextField.text!)" as NSObject
        let arr = self.operationTextField.text!.components(separatedBy: " - ")
        let oprNum = String()
        if arr.count == 2{
            (errorComponent.entity.properties["OperAct"] as! SODataProperty).value = oprNum as NSObject
        }
        let plannofOperaFilteredArray = self.operationArray.filter{$0.OperationNum == "\(oprNum)"}
        if plannofOperaFilteredArray.count > 0 {
            let operationClass = plannofOperaFilteredArray[0]
            (errorComponent.entity.properties["PlannofOpera"] as! SODataProperty).value  = operationClass.PlannofOpera as NSObject
        }
        let plant = self.plantTextField.text!.components(separatedBy: " - ")
        (errorComponent.entity.properties["Plant"] as! SODataProperty).value = plant[0] as NSObject
        (errorComponent.entity.properties["QuantityinUnE"] as! SODataProperty).value =  NSDecimalNumber(string: self.quintityTextField.text!)
        (errorComponent.entity.properties["ReqmtQty"] as! SODataProperty).value = NSDecimalNumber(string: quintityTextField.text!)
        WoComponentModel.updateComponentEntity(entity: errorComponent.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("error Component Updated successfully".localized(), Type: "Debug")
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "failed_to_update_component".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func updateComponent() {
        
        mJCLogger.log("Starting", Type: "info")
        let string = NSDecimalNumber(string: quintityTextField.text!)
        (selectedComp.entity.properties["ReqmtQty"] as! SODataProperty).value = string as NSObject?
        WoComponentModel.updateComponentEntity(entity: selectedComp.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Component Updated successfully".localized(), Type: "Debug")
                self.createUpdateDelegate?.EntityCreated?()
                self.selectedComp.ReqmtQty = string
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "fail_to_update_component_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func getStorageLocations(plant:String) {
        
        mJCLogger.log("Starting", Type: "info")
        StorageLocationModel.getStorageLocation(plant: plant){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [StorageLocationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.storageLocationArray.removeAll()
                        self.storageLocationArray = responseArr
                        if self.isFromEdit == true{
                            let storageArray = self.storageLocationArray.filter{$0.StorLocation == "\(self.selectedComp.StorLocation)" && $0.Plant == "\(self.selectedComp.Plant)"}
                            if storageArray.count > 0{
                                let storageClass = self.storageLocationArray[0]
                                DispatchQueue.main.async {
                                    self.storageLocationTextField.text  = "\(storageClass.StorLocation)" + " - " + "\(storageClass.StorageLocationDescription)"
                                }
                            }else{
                                DispatchQueue.main.async {
                                    self.storageLocationTextField.text = ""
                                }
                            }
                        }else{
                            if self.storageLocationArray.count > 0{
                                
                                let storageClass = self.storageLocationArray[0]
                                DispatchQueue.main.async {
                                    self.storageLocationTextField.text  = "\(storageClass.StorLocation)" + " - " + "\(storageClass.StorageLocationDescription)"
                                    self.selectedStorageLoc = storageClass.StorLocation
                                }
                            }else{
                                DispatchQueue.main.async {
                                    self.storageLocationTextField.text = ""
                                }
                            }
                        }
                        var listarr = [String]()
                        for item in self.storageLocationArray {
                            listarr.append("\(item.StorLocation)" + " - " + "\(item.StorageLocationDescription)")
                        }
                        let arr : [String] = listarr as NSArray as! [String]
                        if arr.count > 0{
                            self.storageLocationTextField.optionArray = arr
                            self.storageLocationTextField.checkMarkEnabled = false
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get mainPlant
    func getMaintPlantList()  {
        mJCLogger.log("Starting", Type: "info")
        self.maintPlantArray.removeAll()
        self.plantArray.removeAll()
        mJCLogger.log("Response :\(globalPlanningPlantArray.count)", Type: "Debug")
        if globalPlanningPlantArray.count > 0 {
            self.maintPlantArray.append(contentsOf: globalPlanningPlantArray)
            var isSetPlant = false
            for item in self.maintPlantArray {
                self.plantArray.append(item.Plant + " - " + item.Name1)
            }
            if self.isFromEdit == true && self.isFromError == true{
                let filtered = maintPlantArray.filter {($0 as AnyObject).Plant.contains(errorComponent.Plant) }
                mJCLogger.log("Response :\(filtered.count)", Type: "Debug")
                if filtered.count > 0{
                    self.plantTextField.text = filtered[0].Plant + " - " + filtered[0].Name1
                    componentAvailabilityViewModel.getMaterialDetails(material: "\(errorComponent.Material)")
                }
            }else if self.isFromEdit == true {
                let filtered = maintPlantArray.filter {($0 as AnyObject).Plant.contains(selectedComp.Plant) }
                mJCLogger.log("Response :\(filtered.count)", Type: "Debug")
                if filtered.count > 0{
                    self.plantTextField.text = filtered[0].Plant + " - " + filtered[0].Name1
                    self.getStorageLocations(plant: filtered[0].Plant)
                    componentAvailabilityViewModel.getMaterialDetails(material: "\(selectedComp.Material)")
                }
            }else if self.isFromEdit == false {
                if isSetPlant == false {
                    if self.isFromScreen == "Component" {
                        let filtered = maintPlantArray.filter { ($0 as AnyObject).Plant.contains(userPlant) }
                        mJCLogger.log("Response :\(filtered.count)", Type: "Debug")
                        if filtered.count > 0{
                            self.plantTextField.text = filtered[0].Plant + " - " + filtered[0].Name1
                            self.getStorageLocations(plant: filtered[0].Plant)
                        }
                        isSetPlant = true
                    }
                }
            }
            
            if self.plantArray.count > 0{
                self.plantTextField.optionArray = self.plantArray
                self.plantTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Operation List..
    func getOpeartionList(workorderNumber:String) {
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(WorkOrderNum%20eq%20%27" + workorderNumber + "%27 and startswith(SystemStatus, 'DLT') ne true)&$select=OperationNum,PlannofOpera,ShortText&$orderby=OperationNum";
        WoOperationModel.getOperationList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(responseArr)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.operationArray.removeAll()
                        self.operationArray = responseArr
                        self.setOperationData()
                    }else{
                        DispatchQueue.main.async {
                            mJCLogger.log("Data not found", Type: "Debug")
                            self.operationTextField.text = ""
                            self.operationListArray.removeAll()
                        }
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func setOperationData()  {
        mJCLogger.log("Starting", Type: "info")
        self.operationListArray.removeAll()
        for opritem in self.operationArray {
            self.operationListArray.append(opritem.OperationNum + " - " + opritem.ShortText)
        }
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            let operarray = self.operationArray.filter{$0.OperationNum == "\(selectedOperationNumber)"}
            DispatchQueue.main.async {
                if operarray.count != 0 {
                    let oprItem = operarray[0]
                    self.operationTextField.text = oprItem.OperationNum + " - " + oprItem.ShortText
                }else{
                    self.operationTextField.text = self.operationListArray[0]
                }
            }
        }else{
            if operationListArray.count > 0{
                DispatchQueue.main.async {
                    self.operationTextField.text = self.operationListArray[0]
                }
            }
        }
        
        if self.operationListArray.count > 0{
            self.operationTextField.optionArray = self.operationListArray
            self.operationTextField.checkMarkEnabled = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    //MARK:- Quantity TextField Editig Actiojn..
    @IBAction func quantityEditigTextFieldAction(sender: UITextField) {
        mJCLogger.log("Starting", Type: "info")
        let resultString = sender.text?.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
        sender.text = resultString
        mJCLogger.log("Ended", Type: "info")
    }
    func createCompnent()  {
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BaseUnit")
        prop!.value = componentAvailable.BaseUnit as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "BusinessArea")
        prop!.value = singleWorkOrder.BusArea as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        //  prop!.value = "\(self.sortNumber)" as NSObject
        prop!.value = String.random(length: 4, type: "Number") as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ItemCategory")
        prop!.value = "L" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Deleted")
        prop!.value = false as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ItemText")
        prop!.value = "\(self.descriptionTextField.text!)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Material")
        
        if self.isBomItem == true{
            prop!.value = componentAvailable.Component as NSObject
        }else{
            prop!.value = componentAvailable.Material as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MaterialGroup")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        var oprNum = String()
        let arr = self.operationTextField.text!.components(separatedBy: " - ")
        if arr.count > 1{
            oprNum = arr[0]
        }
        prop = SODataPropertyDefault(name: "OperAct")
        prop!.value = oprNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PlannofOpera")
        let plannofOperaFilteredArray = self.operationArray.filter{$0.OperationNum == "\(oprNum)"}
        if plannofOperaFilteredArray.count > 0 {
            let operationClass = plannofOperaFilteredArray[0]
            prop!.value = operationClass.PlannofOpera as NSObject
            self.property.add(prop!)
        }
        
        let plant = self.plantTextField.text!.components(separatedBy: " - ")
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = plant[0] as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "QuantityinUnE")
        prop!.value = NSDecimalNumber(string: self.quintityTextField.text!)
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ReqmtQty")
        prop!.value = NSDecimalNumber(string: self.quintityTextField.text!)
        self.property.add(prop!)
        
        let storageLocation = self.storageLocationTextField.text!.components(separatedBy: " - ")
        prop = SODataPropertyDefault(name: "StorLocation")
        
        if storageLocation.count > 0{
            prop!.value = storageLocation[0] as NSObject
        }else{
            prop!.value = "" as NSObject
        }
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WithdrawalQty")
        prop!.value = NSDecimalNumber(string: "0")
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "UnitofEntry")
        prop!.value = componentAvailable.BaseUnit as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.sortNumber)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        self.property.add(prop!)
        
        print("===== Component Key Value ======")
        
        let entity = SODataEntityDefault(type: woComponentSetEntity)
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("........................")
        }
        
        WoComponentModel.createComponentEntity(entity: entity!, collectionPath: woComponentSet, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                workOrderCreateDictionary.removeAllObjects()
                mJCLogger.log("record inserted successfully".localized(), Type: "Debug")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setComponentBadgeIcon"), object: "")
                self.createUpdateDelegate?.EntityCreated?()
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {}
                }
            }else{
                DispatchQueue.main.async {
                    print("Error : \(String(describing: error))")
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "fail_to_add_component_please_try_again".localized(), button: okay)
                }
            }
            
        })
        mJCLogger.log("Ended", Type: "info")
    }

    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if barCode == "Material"{
                DispatchQueue.main.async {
                    if let obj = object as? ComponentAvailabilityModel,obj.Material != ""{
                        self.componentAvailable = obj
                        self.itemTextField.text = "\(obj.Material)"
                        self.descriptionTextField.text = "\(obj.MaterialDescription)"
                    }else{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "couldn’t_find_Material_for_id".localized() , button: okay)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func inStockButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let checkFillimg = UIImage(named: "ic_check_fill")
        if inStockButton.imageView?.image == checkFillimg {
            inStockButton.setImage(UIImage(named: "ic_check_nil"), for: .normal)
            inStockAvailable = false
        }else{
            inStockButton.setImage(UIImage(named: "ic_check_fill"), for: .normal)
            inStockAvailable = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: viewModelDelegate
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "Material"{
            var material = ComponentAvailabilityModel()
            if let objDict = object[0] as? ComponentAvailabilityModel{
                material = objDict
            }else{
                material = ComponentAvailabilityModel()
            }
            self.scanCompleted(type: "success", barCode: "Material", object: material)
        }
    }
    
    //MARK: - Not using methods
    @IBAction func operationButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.operationListArray.count)", Type: "Debug")
        if self.operationListArray.count > 0 {
            dropDown.anchorView = self.operationTextFieldView
            let arr : [String] = self.operationListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "OperationDropDown"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func plantButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.plantArray.count)", Type: "Debug")
        if self.plantArray.count > 0 {
            dropDown.anchorView = self.plantTextFieldView
            let arr : [String] = self.plantArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "PlantDropDown"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func storageLocationButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.storageLocationArray.count)", Type: "Debug")
        if self.storageLocationArray.count > 0 {
            var listarr = [String]()
            dropDown.anchorView = self.storageLocationTextField
            for item in self.storageLocationArray {
                listarr.append("\(item.StorLocation)" + " - " + "\(item.StorageLocationDescription)")
            }
            let arr : [String] = listarr as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "StoragLocation"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
