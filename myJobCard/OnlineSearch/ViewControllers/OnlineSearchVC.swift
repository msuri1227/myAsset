//
//  OnlineSearchVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 28/08/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OnlineSearchVC: UIViewController,barcodeDelegate, UITextFieldDelegate,FuncLocEquipSelectDelegate {

    @IBOutlet weak var headerTitle: UILabel!

    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTitleLabel: UILabel!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantTextField: iOSDropDown!
    @IBOutlet var plantButton: UIButton!

    @IBOutlet var mainWrkCtrView: UIView!
    @IBOutlet var mainWrkCtrTitleLabel: UILabel!
    @IBOutlet var mainWrkCtrTextFieldView: UIView!
    @IBOutlet var mainWrkCtrTextField: iOSDropDown!
    @IBOutlet var mainWrkCtrButton: UIButton!

    @IBOutlet var superiorWrkCtrCheckBoxView: UIView!
    @IBOutlet var superiorWrkCtrCheckBox: UIButton!

    @IBOutlet var superiorWrkCtrView: UIView!
    @IBOutlet var superiorWrkCtrTitleLabel: UILabel!
    @IBOutlet var superiorWrkCtrTextFieldView: UIView!
    @IBOutlet var superiorWrkCtrTextField: iOSDropDown!
    @IBOutlet var superiorWrkCtrButton: UIButton!


    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var fromDateTitleLabel: UILabel!
    @IBOutlet weak var fromDateTextFieldView: UIView!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var fromDateButton: UIButton!

    @IBOutlet weak var toDateTitleLabel: UILabel!
    @IBOutlet weak var toDateTextFieldView: UIView!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var toDateButton: UIButton!

    @IBOutlet weak var flocView: UIView!
    @IBOutlet weak var flocTitleLabel: UILabel!
    @IBOutlet weak var flocTextFieldView: UIView!
    @IBOutlet weak var flocTextField: UITextField!
    @IBOutlet weak var flocButton: UIButton!
    @IBOutlet weak var flocScanButton: UIButton!

    @IBOutlet weak var equipView: UIView!
    @IBOutlet weak var equipTitleLabel: UILabel!
    @IBOutlet weak var equipTextFieldView: UIView!
    @IBOutlet weak var equipTextField: UITextField!
    @IBOutlet weak var equipButton: UIButton!
    @IBOutlet weak var equipEquipButton: UIButton!

    @IBOutlet weak var equipWarrantyView: UIView!
    @IBOutlet weak var equipWarrantyInfoLabel: UILabel!
    @IBOutlet weak var equipWarrantyImageView: UIImageView!

    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var priorityTitleLabel: UILabel!
    @IBOutlet weak var priorityTextFieldView: UIView!
    @IBOutlet weak var priorityTextField: iOSDropDown!
    @IBOutlet weak var priorityButton: UIButton!

    @IBOutlet weak var objSearchView: UIView!
    @IBOutlet weak var objSearchTitleLabel: UILabel!
    @IBOutlet weak var objSearchTextFieldView: UIView!
    @IBOutlet weak var objSearchTextField: UITextField!

    @IBOutlet var unassingedButton: UIButton!
    @IBOutlet var CreatedByMe: UIButton!

    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var selectedPlant = String()
    var selectedMainWorkCenter = String()
    var isSelectedFunLoc = Bool()
    var dateSelctionType = String()
    let dropDown = DropDown()
    var typeOfScanCode = String()
    var dropDownSelectString = String()
    var onlineSearchModel = OnlineSearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        onlineSearchModel.vcOnlineSearch = self
        onlineSearchModel.getPriorityList()
        mainWrkCtrTextField.delegate = self
        if searchType == "WorkOrders" {
            self.headerTitle.text = "Work_Orders_Search".localized()
            self.objSearchTitleLabel.text = "Work_Order".localized()
            self.objSearchTextField.placeholder = "Enter_Work_Order".localized()
            self.unassingedButton.isHidden = false
            self.superiorWrkCtrCheckBoxView.isHidden = false
            onlineSearchModel.superiorWCListArray.append(selectStr)
            onlineSearchModel.superiorWCListArray.append(userWorkcenter)
            self.superiorWrkCtrTextField.optionArray = onlineSearchModel.superiorWCListArray
            self.superiorWrkCtrTextField.checkMarkEnabled = false
        }else if searchType == "Notifications" {
            self.headerTitle.text = "Notifications_Search".localized()
            self.objSearchTitleLabel.text = "Notification".localized()
            self.objSearchTextField.placeholder = "Enter_Notification".localized()
            self.unassingedButton.isHidden = true
            self.unassingedButton.isSelected = false
            self.superiorWrkCtrView.isHidden = true
            self.superiorWrkCtrCheckBoxView.isHidden = true
        }
        ODSUIHelper.setBorderToView(view: self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.mainWrkCtrTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.superiorWrkCtrTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.flocTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.equipTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.fromDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.toDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.priorityTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.objSearchTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        onlineSearchModel.maintPlantList()
        onlineSearchModel.getSuperiorWorkCenter()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "PlantDropDown" {
                self.plantTextField.text = item
                self.selectedMainWorkCenter = ""
                self.dropDownSelectString = ""
                self.mainWrkCtrTextField.text = ""
                onlineSearchModel.setWorkCenterValue()
            }else if self.dropDownSelectString == "WorkCentersDropDown"{
                self.mainWrkCtrTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "PriorityDropDown"{
                self.priorityTextField.text = item
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "superiorWCDropDown"{
                self.superiorWrkCtrTextField.text = item
                self.dropDownSelectString = ""
            }
            self.dropDown.hide()
        }
        
        //Plant
        self.plantTextField.didSelect { selectedText, index, id in
            self.plantTextField.text = selectedText
            self.selectedMainWorkCenter = ""
            self.dropDownSelectString = ""
            self.mainWrkCtrTextField.text = ""
            self.onlineSearchModel.setWorkCenterValue()
        }
        //Main wrk center
        self.mainWrkCtrTextField.didSelect { selectedText, index, id in
            self.mainWrkCtrTextField.text = selectedText
        }
        //Priority
        self.priorityTextField.didSelect { selectedText, index, id in
            self.priorityTextField.text = selectedText
        }
        
        //Superior wrk center
        self.superiorWrkCtrTextField.didSelect { selectedText, index, id in
            self.superiorWrkCtrTextField.text = selectedText
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetOnlineResults(queryValue: String) {
        mJCLogger.log("Starting", Type: "info")
        if onlineSearchArray.count > 0{
            mJCLogger.log("Response:\(onlineSearchArray.count)", Type: "Debug")
            DispatchQueue.main.async {
                onlineSearch = true
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                if DeviceType == iPad {
                    if searchType == "WorkOrders"{
                        menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
                    }else {
                        menuDataModel.uniqueInstance.presentListSplitScreen(type: "Notification")
                    }
                }else {
                    let mainViewController = ScreenManager.getMasterListScreen()
                    myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                    let dashboard = ScreenManager.getOnlineSearchScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                    myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                    self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                    self.appDeli.window?.makeKeyAndVisible()
                    myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
                }
                mJCLoader.stopAnimating()
            }
        }else{
            if searchType == "WorkOrders"{
                mJCLogger.log("Work_Orders_not_found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Work_Orders_not_found".localized(), button: okay)
            }else{
                mJCLogger.log("Notifications_Not_Found".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Notifications_Not_Found".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    func FuncLocOrEquipSelected(selectedObj: String, EquipObj: EquipmentModel, FuncObj:FunctionalLocationModel) {

        mJCLogger.log("Starting", Type: "info")
        if selectedObj == "Equipment"{
            self.flocTextField.text = EquipObj.FuncLocation
            self.equipTextField.text = EquipObj.Equipment
            if self.flocTextField.text == "" {
                mJCLogger.log("Functional_Location_is_not_available_for_this_Equipment".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_is_not_available_for_this_Equipment".localized(), button: okay)
            }
        }else if selectedObj == "FunctionalLocation"{
            self.flocTextField.text = FuncObj.FunctionalLoc
            self.equipTextField.text = EquipObj.Equipment
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func functionalLocationBtnAction(_ sender: Any) {
        var workCenterStr : String? = ""
        var planningPlantStr : String? = ""
        if self.mainWrkCtrTextField.text != "" || self.mainWrkCtrTextField.text != nil {
            workCenterStr = self.mainWrkCtrTextField.text
            planningPlantStr = self.plantTextField.text
        }
        menuDataModel.uniqueInstance.presentFlocEquipHierarchyScreen(vc: self, select: "FunctionalLocation", delegateVC: self, workCenter: workCenterStr, planningPlant: planningPlantStr)
    }

    @IBAction func functionalLocationScanBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Floc", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func equipmentBtnAction(_ sender: Any) {
        var workCenterStr : String? = ""
        var planningPlantStr : String? = ""
        if self.mainWrkCtrTextField.text != "" || self.mainWrkCtrTextField.text != nil {
            workCenterStr = self.mainWrkCtrTextField.text
            planningPlantStr = self.plantTextField.text
        }
        menuDataModel.uniqueInstance.presentFlocEquipHierarchyScreen(vc: self, select: "Equipement", delegateVC: self, workCenter: workCenterStr, planningPlant: planningPlantStr, selectedFuncLoc: flocTextField.text)
    }
    @IBAction func equipmentScanBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Equip", delegate: self,controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func fromDateBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        dateSelctionType = "FromDate"
        ODSPicker.selectDate(title: "Select_From_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.toDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.toDateTextField.text)!){
                    self?.fromDateTextField.text = selectedDate.dateString(localDateFormate)
                }
                else{
                    self?.toDateTextField.text = ""
                    self?.fromDateTextField.text = selectedDate.dateString(localDateFormate)
                }
            }
            else{
                self?.fromDateTextField.text = selectedDate.dateString(localDateFormate)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func toDateBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        dateSelctionType = "ToDate"
        if fromDateTextField.text!.count > 0 {
                ODSPicker.selectDate(title: "Select_To_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                    if !(self?.fromDateTextField.text!.isEmpty)! {
                        if ODSDateHelper.compareTwoDates(fromDate: (self?.fromDateTextField.text)!, toDate: selectedDate.dateString(localDateFormate)){
                            self?.toDateTextField.text = selectedDate.dateString(localDateFormate)
                        }
                        else{
                            self?.toDateTextField.text = ""
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized(), button: okay)
                        }
                    }
                    else{
                        self?.toDateTextField.text = selectedDate.dateString(localDateFormate)
                    }
                })
        }else{
            mJCLogger.log("Please_Select_Start_Date".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_Start_Date".localized() , button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func unassingedButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        sender.isSelected = !sender.isSelected
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func creteadByMeButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let checkFillimg = UIImage(named: "ic_check_fill")
        if CreatedByMe.imageView?.image == checkFillimg {
            CreatedByMe.setImage(UIImage(named: "ic_check_nil"), for: .normal)
            CreatedByMe.isSelected = false
        }else{
            CreatedByMe.setImage(UIImage(named: "ic_check_fill"), for: .normal)
            CreatedByMe.isSelected = true
        }
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func supWOCenterSelection(_ sender: Any) {

        mJCLogger.log("Starting", Type: "info")
        print("mk")
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected == true{
            self.superiorWrkCtrView.isHidden = false
        }else{
            self.superiorWrkCtrView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func validation(){
        mJCLogger.log("Starting", Type: "info")
        if self.plantTextField.text == selectStr && self.mainWrkCtrTextField.text == selectStr && self.flocTextField.text == "" && self.equipTextField.text == "" && self.superiorWrkCtrTextField.text == selectStr && self.priorityTextField.text == selectStr {
            mJCLogger.log("Please_select_atleast_one_value_to_Search".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_atleast_one_value_to_Search".localized(), button: okay)
            return
        }else  if self.plantTextField.text != "" || self.mainWrkCtrTextField.text != "" || self.flocTextField.text != "" || self.equipTextField.text != "" || self.superiorWrkCtrTextField.text != "" && self.priorityTextField.text != "" {
            var queryarr = Array<String>()
            if plantTextField.text != selectStr {
                if self.plantTextField.text != "" || self.plantTextField.text != nil {
                    let arr = self.plantTextField.text!.components(separatedBy: " - ")
                    if arr.count > 0{
                        queryarr.append("Plant")
                        self.selectedPlant = arr[0]
                    }
                }
            }
            if self.mainWrkCtrTextField.text != selectStr{
                if self.mainWrkCtrTextField.text != "" || self.mainWrkCtrTextField.text != nil {
                    let arr = self.mainWrkCtrTextField.text!.components(separatedBy: " - ")
                    if arr.count > 0{
                        queryarr.append("WorkCenter")
                        self.selectedMainWorkCenter = arr[0]
                    }
                }
            }
            if flocTextField.text != ""{
                queryarr.append("Func")
            }
            if equipTextField.text != ""{
                queryarr.append("Equip")
            }
            if  priorityTextField.text != selectStr{
                queryarr.append("Priority")
            }
            if superiorWrkCtrTextField.text != selectStr{
                queryarr.append("SupWorkCenter")
            }
            var strQuery = String()
            strQuery = "(OnlineSearch%20eq%20%27X%27"
            if unassingedButton.isSelected == true{
                strQuery = strQuery + "%20and%20Unassigned%20eq%20%27X%27"
            }
            if CreatedByMe.isSelected == true{
                strQuery = strQuery + "%20and%20EnteredBy%20eq%20%27\(userDisplayName)%27"
            }
            for i in 0..<queryarr.count {
                if queryarr[i] == "WorkCenter"{
                    if searchType == "WorkOrders" {
                        strQuery = strQuery + "%20and%20" + "MainWorkCtr%20eq%20%27\(self.selectedMainWorkCenter)%27"
                    }else if searchType == "Notifications"{
                        strQuery = strQuery + "%20and%20" + "WorkCenter%20eq%20%27\(self.selectedMainWorkCenter)%27"
                    }
                }else if queryarr[i] == "Plant"{
                    if searchType == "WorkOrders" {
                        strQuery = strQuery + "%20and%20" + "Plant%20eq%20%27\(self.selectedPlant)%27"
                    }else if searchType == "Notifications"{
                        strQuery = strQuery + "%20and%20" + "PlanningPlant%20eq%20%27\(self.selectedPlant)%27"
                    }
                }else if queryarr[i] == "Func"{
                    if searchType == "WorkOrders" {
                        strQuery = strQuery + "%20and%20" + "FuncLocation%20eq%20%27\(String(describing: self.flocTextField.text!))%27"
                    }else if searchType == "Notifications"{
                        strQuery = strQuery + "%20and%20" + "FunctionalLoc%20eq%20%27\(String(describing: self.flocTextField.text!))%27"
                    }
                }else if queryarr[i] == "Equip"{
                    if searchType == "WorkOrders" {
                        strQuery = strQuery + "%20and%20" + "EquipNum%20eq%20%27\(String(describing: self.equipTextField.text!))%27"
                    }else if searchType == "Notifications"{
                        strQuery = strQuery + "%20and%20" + "Equipment%20eq%20%27\(String(describing: self.equipTextField.text!))%27"
                    }
                }else if queryarr[i] == "Priority"{
                    let bPredicate : NSPredicate = NSPredicate(format: "SELF.PriorityText == %@",self.priorityTextField.text!)
                    let filteredArray = self.onlineSearchModel.priorityArray.filtered(using: bPredicate)

                    if filteredArray.count != 0 {
                        let pri = filteredArray[0] as! PriorityListModel
                        strQuery = strQuery + "%20and%20" + "Priority%20eq%20%27\(pri.Priority)%27"
                    }
                }else if queryarr[i] == "SupWorkCenter"{
                    if self.superiorWrkCtrTextField.text != "" || self.superiorWrkCtrTextField.text != nil {
                        let arr = superiorWrkCtrTextField.text!.components(separatedBy: " - ")
                        if arr.count > 0 {
                            strQuery = strQuery + "%20and%20" + "MainWorkCtr%20eq%20%27\(arr[0])%27"
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }
                }
            }
            if self.fromDateTextField.text != "" && self.toDateTextField.text == "" {
                mJCLogger.log("Please_Select_To_Date".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_To_Date".localized(), button: okay)
            }else if self.fromDateTextField.text == "" && self.toDateTextField.text != "" {
                mJCLogger.log("Please_Select_From_Date".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_From_Date".localized(), button: okay)
            }else if self.fromDateTextField.text == "" && self.toDateTextField.text == "" {
                let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                if result == "ServerUp"{
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    if searchType == "WorkOrders" {
                        strQuery = "$filter=" + strQuery + ")&$expand=NAVOPERA"
                    }else if searchType == "Notifications"{
                        strQuery = "$filter=" + strQuery + ")&$expand=NavNOItem"
                    }
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        self.onlineSearchModel.getOnlineResults(query: strQuery)
                    }
                }else if result == "ServerDown"{
                    mJCLogger.log("Unable_to_connect_with_server".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
                }else{
                    mJCLogger.log("The_Internet_connection_appears_to_be_offline".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
                }
            }else if self.fromDateTextField.text != "" && self.toDateTextField.text != "" {
                let startDate = ODSDateHelper.getDateFromString(dateString: fromDateTextField.text!, dateFormat: localDateFormate)
                let selecteddate = ODSDateHelper.getDateFromString(dateString: toDateTextField.text!, dateFormat: "dd-MM-yyyy")
                if selecteddate < startDate {
                    mJCLogger.log("Please_Select_End_Date_Greaterthan_Start_Date".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized() , button: okay)
                    return
                }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateStr1 = ODSDateHelper.getDateFromString(dateString: self.fromDateTextField.text!, dateFormat: "dd-MM-yyyy").toString(format: .custom("yyyy-MM-dd"))
                let dateStr2 = ODSDateHelper.getDateFromString(dateString: self.toDateTextField.text!, dateFormat: "dd-MM-yyyy").toString(format: .custom("yyyy-MM-dd"))
                if dateStr2 > dateStr1 || dateStr1 == dateStr2 {
                    let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                    mJCLoader.stopAnimating()
                    if result == "ServerUp"{
                        mJCLoader.startAnimating(status: "Please_Wait".localized())
                        let fromDate = dateStr1 + "T00:00:00"
                        let toDate = dateStr2 + "T00:00:00"
                        if searchType == "WorkOrders" {
                            strQuery = "$filter=" + strQuery + "%20and%20" + "CreatedOn%20eq%20datetime%27\(fromDate)%27%20and%20ChangeDtForOrderMaster%20eq%20datetime%27\(toDate)%27)&$expand=NAVOPERA"
                        }else if searchType == "Notifications"{
                            strQuery = "$filter=" + strQuery + "%20and%20" + "CreatedOn%20eq%20datetime%27\(fromDate)%27%20and%20ChangedOn%20eq%20datetime%27\(toDate)%27)&$expand=NavNOItem"
                        }
                        let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                        dispatchQueue.async{
                            self.onlineSearchModel.getOnlineResults(query: strQuery)
                        }
                    }else if result == "ServerDown"{
                        mJCLogger.log("Unable_to_connect_with_server".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
                    }else{
                        mJCLogger.log("The_Internet_connection_appears_to_be_offline".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
                    }
                }else {
                    mJCLogger.log("Please_Select_Correct_Dates".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Correct_Dates".localized(), button: okay)
                }
            }
        }else{
            mJCLogger.log("Please_select_atleast_one_value_to_Search".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_atleast_one_value_to_Search".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func saveBtnAction(_ sender: Any) {

        mJCLogger.log("Starting", Type: "info")
        if objSearchTextField.text!.count > 0 {
            var strQuery = String()
            strQuery = "(OnlineSearch%20eq%20%27X%27"
            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
            if result == "ServerUp"{
                mJCLoader.startAnimating(status: "Please_Wait".localized())
                if searchType == "WorkOrders" {
                    strQuery = "$filter=" + strQuery + "%20and%20" + "WorkOrderNum%20eq%20%27\(String(describing: self.objSearchTextField.text!))%27)&$expand=NAVOPERA"
                }else if searchType == "Notifications"{
                    strQuery = "$filter=" + strQuery + "%20and%20" + "Notification%20eq%20%27\(String(describing: self.objSearchTextField.text!))%27)&$expand=NavNOItem"
                }
                let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                dispatchQueue.async{
                    self.onlineSearchModel.getOnlineResults(query: strQuery)
                }
            }else if result == "ServerDown"{
                mJCLogger.log("Unable_to_connect_with_server".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
            }else{
                mJCLogger.log("The_Internet_connection_appears_to_be_offline".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
            }
        }else {
            self.validation()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        onlineSearch = false
        self.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }

    @IBAction func resetBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.plantTextField.text = ""
        self.mainWrkCtrTextField.text = ""
        self.flocTextField.text = ""
        self.equipTextField.text = ""
        self.fromDateTextField.text = ""
        self.toDateTextField.text = ""
        self.superiorWrkCtrTextField.text = selectStr
        self.priorityTextField.text = selectStr
        self.unassingedButton.isSelected = false
        self.superiorWrkCtrCheckBox.isSelected = false
        self.CreatedByMe.isSelected = false
        self.objSearchTextField.text = ""
        onlineSearchModel.maintPlantList()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TextField Delegates......
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.mainWrkCtrTextField{
            if self.plantTextField.text == selectStr{
                mJCLogger.log("Please_select_the_plant".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_the_plant".localized(), button: okay)
                self.mainWrkCtrTextField.resignFirstResponder()
            }
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        if textField == self.mainWrkCtrTextField{
            if textField.text == ""{
                
            }
            else{
                if !(self.onlineSearchModel.workCentersListArray.contains(textField.text!)){
                    textField.text = ""
                }
            }
        }
        return true
    }
    @IBAction func searchEditingChanged(sender: AnyObject) {
    }
    
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if barCode == "Floc"{
                DispatchQueue.main.async {
                    if let obj = object as? FunctionalLocationModel,obj.FunctionalLoc != ""{
                        self.flocTextField.text = obj.FunctionalLoc
                    }else{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "couldn’t_find_functional_location_for_id".localized(), button: okay)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }else if barCode == "Equip"{
                DispatchQueue.main.async {
                    if let obj = object as? EquipmentModel,obj.Equipment != ""{
                        self.equipTextField.text = obj.Equipment
                        self.flocTextField.text = obj.FuncLocation
                    }else{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "couldn’t_find_equipment_for_id".localized() , button: okay)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func backBtnAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    
    //MARK: - Not using methods
    @IBAction func plantSelectionBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        onlineSearchModel.workCentersListArray.removeAll()
        self.onlineSearchModel.maintPlantdecArray.removeAll()
        self.onlineSearchModel.maintPlantdecArray.append(selectStr)
        if onlineSearchModel.maintPlantArray.count > 0 {
            for item in onlineSearchModel.maintPlantArray {
                self.onlineSearchModel.maintPlantdecArray.append("\(item.Plant) - \(item.Name1)")
            }
            dropDown.anchorView = self.plantTextField
            if let arr : [String] = self.onlineSearchModel.maintPlantdecArray as NSArray as? [String] {
                dropDown.dataSource = arr
                dropDownSelectString = "PlantDropDown"
                dropDown.show()
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func mainWorkCenterBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.plantTextField.text == selectStr{
                mJCLogger.log("Please_select_the_plant".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_select_the_plant".localized(), button: okay)
            }
            if self.onlineSearchModel.workCentersListArray.count != 0 {
                mJCLogger.log("Response:\(self.onlineSearchModel.workCentersListArray.count)", Type: "Debug")
                self.dropDown.anchorView = self.mainWrkCtrTextField
                let arr : [String] = self.onlineSearchModel.workCentersListArray as NSArray as! [String]
                self.dropDown.dataSource = arr
                self.dropDownSelectString = "WorkCentersDropDown"
                self.dropDown.show()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func priorityButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.priorityView
        let arr : [String] = self.onlineSearchModel.priorityListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "PriorityDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func superiorworkCtrButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        dropDown.anchorView = self.superiorWrkCtrView
        let arr : [String] = self.onlineSearchModel.superiorWCListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDownSelectString = "superiorWCDropDown"
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
}
