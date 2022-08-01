//
//  InstallEquipFlocVC.swift
//  myJobCard
//
//  Created by Rover Software on 23/10/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class InstallEquipFlocVC: UIViewController,barcodeDelegate,FuncOrEquipmentSelectedDelegate,viewModelDelegate{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var categoryButton: UIButton!
    
    @IBOutlet var functionalLocationView: UIView!
    @IBOutlet var functionalLocationTextField: UITextField!
    @IBOutlet var functionalLocationButton: UIButton!
    @IBOutlet var functionalLocationScanButton: UIButton!
    
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTextField: UITextField!
    @IBOutlet var plantButton: UIButton!
    
    @IBOutlet var equipmentView: UIView!
    @IBOutlet var equipmentTextField: UITextField!
    @IBOutlet var equipmentButton: UIButton!
    @IBOutlet var equipmentScanButton: UIButton!
    
    @IBOutlet var mainWorkCenterView: UIView!
    @IBOutlet var mainWorkCenterTextField: UITextField!
    @IBOutlet var mainWorkCenterButton: UIButton!
    
    @IBOutlet weak var equipWarrantyInfoLabel: UILabel!
    @IBOutlet weak var equipmentWarrantyView: UIView!
    @IBOutlet weak var equipmentWarrantyImageView: UIImageView!
    
    
    let dropDown = DropDown()
    var dropDownSelectString = String()
    var isSelectedFunLoc = Bool()
    var typeOfScanCode = String()
    var isitfrom = String()

    var maintPlantArray = [MaintencePlantModel]()
    var maintPlantDispArray = [String]()
    var mainWorkCenterArray = [WorkCenterModel]()
    var mainWorkCenterDispArray = [String]()
    var categoriesArray = [EquipmentCategoryModel]()
    var categoryDispArray = [String]()
    var installedEquipmentViewModel = InstalledEquipmentViewModel()
    var SuperiorEquipment = String()
    var SuperiorFunc = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        installedEquipmentViewModel.delegate = self
        installedEquipmentViewModel.getCategories()
        self.equipmentWarrantyView.isHidden = true
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "PlantDropDown" {
                self.plantTextField.text = item
                self.dropDownSelectString = ""
                self.installedEquipmentViewModel.setWorkCenterValue(plant: item)
            }else if self.dropDownSelectString == "mainWorkCenterPlantDropDown"{
                self.mainWorkCenterTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "categoryDropDown"{
                self.categoryTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        if DeviceType == iPad{
            ODSUIHelper.setBorderToView(view:self.categoryView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.functionalLocationView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.plantView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.mainWorkCenterView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.equipmentView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }else{
            ODSUIHelper.setTextfiledLayout(textfield: categoryTextField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setTextfiledLayout(textfield: functionalLocationTextField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setTextfiledLayout(textfield: plantTextField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setTextfiledLayout(textfield: equipmentTextField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setTextfiledLayout(textfield: mainWorkCenterTextField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "EquipCategory"{
            DispatchQueue.main.async {
                if let objDict = object as? [String]{
                    self.categoryDispArray = objDict
                }else{
                    self.categoryDispArray = []
                }
                if self.categoryDispArray.count > 0{
                    self.categoryTextField.text = self.categoryDispArray[0]
                }else{
                    self.categoryTextField.text = ""
                }
                self.installedEquipmentViewModel.setPlantvalue()
            }
        }else if type == "plant"{
            DispatchQueue.main.async {
                if let objDict = object as? [String]{
                    self.maintPlantDispArray = objDict
                }else{
                    self.maintPlantDispArray = []
                }
                if self.maintPlantDispArray.count > 0{
                    self.plantTextField.text = self.maintPlantDispArray[0]
                }else{
                    self.plantTextField.text = ""
                }
                self.installedEquipmentViewModel.setWorkCenterValue(plant: self.plantTextField.text ?? "")
            }
        }else if type == "workCtr"{
            DispatchQueue.main.async {
                if let objDict = object as? [String]{
                    self.mainWorkCenterDispArray = objDict
                }else{
                    self.mainWorkCenterDispArray = []
                }
                if self.mainWorkCenterDispArray.count > 0{
                    self.mainWorkCenterTextField.text = self.mainWorkCenterDispArray[0]
                }else{
                    self.mainWorkCenterTextField.text = ""
                }
            }
        }else if type == "Dismiss"{
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    func FuctionOrEquipment(funcSelectd: Bool, equipSelected: Bool,equipmentObjSelected:AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if funcSelectd == true{
            self.functionalLocationTextField.text = tempSelectedFunctionalLocation
            self.isSelectedFunLoc = true
            tempSelectedFunctionalLocation = ""
        }else if equipSelected == true{
            let EquipObj = equipmentObjSelected as! EquipmentModel
            if EquipObj.Equipment != ""{
                self.equipWarrantyInfoLabel.text = myAssetDataManager.uniqueInstance.getEquipmentWarrantyInfo(EquipObj: EquipObj)
                self.equipmentWarrantyView.isHidden = false
                equipmentWarrantyImageView.isHidden = false
                equipmentWarrantyImageView.image = UIImage(named: "history_pending")
            }else{
                equipWarrantyInfoLabel.text = ""
                equipmentWarrantyImageView.isHidden = true
                self.equipmentWarrantyView.isHidden = true
            }
            if isSelectedFunLoc == false {
                self.functionalLocationTextField.text = tempSelectedFunctionalLocation
                self.equipmentTextField.text = tempSelectedEquipment
                tempSelectedFunctionalLocation = ""
                tempSelectedEquipment = ""
                if self.functionalLocationTextField.text == "" {
                    mJCLogger.log("Functional_Location_is_not_available_for_this_Equipment".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_is_not_available_for_this_Equipment".localized(), button: okay)
                }
            }else {
                self.equipmentTextField.text = tempSelectedEquipment
                tempSelectedEquipment = ""
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    
    @IBAction func functionalLocationButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        let functionaLocationListVC = ScreenManager.getFunctionaLocationListScreen()
        functionaLocationListVC.isSelect = "FunctionalLocation"
        functionaLocationListVC.isfrom = "installEquipment"
        functionaLocationListVC.delegate = self
        if self.categoryTextField.text != nil && self.categoryTextField.text != ""{
            let arr = self.categoryTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedCategory = (arr?[0])!
        }
        if self.plantTextField.text != nil && self.plantTextField.text != ""{
            let arr = self.plantTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedPlant = (arr?[0])!
        }
        if self.mainWorkCenterTextField.text != nil && self.mainWorkCenterTextField.text != ""{
            let arr = self.mainWorkCenterTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedWorkcenter = (arr?[0])!
        }
        functionaLocationListVC.modalPresentationStyle = .fullScreen
        self.present(functionaLocationListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func functionalLocationScanButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Floc", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func categoryButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if categoryDispArray.count > 0 {
            dropDown.anchorView = self.categoryTextField
            dropDown.dataSource = self.categoryDispArray
            dropDownSelectString = "categoryDropDown"
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func plantButtonAction(_ sender: Any) {
        if maintPlantDispArray.count > 0 {
            dropDown.anchorView = self.plantTextField
            dropDown.dataSource = self.maintPlantDispArray
            dropDownSelectString = "PlantDropDown"
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func mainWorkCenterButtonAction(_ sender: Any) {
        if self.mainWorkCenterDispArray.count > 0 {
            dropDown.anchorView = self.mainWorkCenterTextField
            dropDown.dataSource = self.mainWorkCenterDispArray
            dropDownSelectString = "mainWorkCenterPlantDropDown"
            dropDown.show()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        
        let functionaLocationListVC = ScreenManager.getFunctionaLocationListScreen()
        functionaLocationListVC.isSelect = "Equipement"
        functionaLocationListVC.isfrom = "installEquipment"
        
        if self.categoryTextField.text != nil && self.categoryTextField.text != ""{
            let arr = self.categoryTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedCategory = (arr?[0])!
        }
        if self.plantTextField.text != nil && self.plantTextField.text != ""{
            let arr = self.plantTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedPlant = (arr?[0])!
        }
        if self.mainWorkCenterTextField.text != nil && self.mainWorkCenterTextField.text != ""{
            let arr = self.mainWorkCenterTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedWorkcenter = (arr?[0])!
        }
        if self.functionalLocationTextField.text != nil && self.functionalLocationTextField.text != ""{
            let arr = self.functionalLocationTextField.text?.components(separatedBy: " - ")
            functionaLocationListVC.selectedFunctionalLocation = (arr?[0])!
        }
        functionaLocationListVC.delegate = self
        functionaLocationListVC.modalPresentationStyle = .fullScreen
        self.present(functionaLocationListVC, animated: false) {
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func equipmentScanButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Equip", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.isSelectedFunLoc = false
        self.categoryTextField.text = self.categoryDispArray[0]
        self.installedEquipmentViewModel.setPlantvalue()
        self.functionalLocationTextField.text = ""
        self.equipmentTextField.text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.equipmentTextField.text != "" {
            installedEquipmentViewModel.selectedEquipment = self.equipmentTextField.text ?? ""
            installedEquipmentViewModel.selectedFloc = self.functionalLocationTextField.text ?? ""
            installedEquipmentViewModel.SuperiorEquipment = self.SuperiorEquipment
            installedEquipmentViewModel.SuperiorFunc = self.SuperiorFunc
            installedEquipmentViewModel.installequipmnetEntry(isitfrom: self.isitfrom)
        }else{
            mJCLogger.log("No_Equipment_is_selected_to_install".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Equipment_is_selected_to_install".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
