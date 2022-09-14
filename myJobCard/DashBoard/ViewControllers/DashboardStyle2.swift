//
//  DashboardStyle2.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/05/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib
import AVFoundation


class DashboardStyle2: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ChartViewDelegate,CustomNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,barcodeDelegate,CreateUpdateDelegate,UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionView1: UICollectionView!
    @IBOutlet var userTitlelabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    
    @IBOutlet var workOrderFilterButton: UIButton!
    @IBOutlet var notificationFilterButton: UIButton!
    @IBOutlet var supervisorFilterButton: UIButton!
    @IBOutlet var timeSheetFilterButton: UIButton!
    
    @IBOutlet var firstDropDownTxtField: iOSDropDown!
    @IBOutlet var secondDropDownTxtField: iOSDropDown!
    @IBOutlet var thirdDropDownTxtField: iOSDropDown!
    @IBOutlet var fourthDropDownTxtField: iOSDropDown!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet var detailsTabelViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var activeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var filterNavButton: UIButton!
    @IBOutlet var filterNavImage: UIImageView!

    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var newpieChartView: PieChartView!
    @IBOutlet weak var filterCountView: UIView!
    
    @IBOutlet weak var thirdDropDownButton: UIButton!
    @IBOutlet weak var thirdDropDownFuncLocScanButton: UIButton!
    @IBOutlet var threeDotMenu: UIButton!
    @IBOutlet weak var fourthDropDownButton: UIButton!
    @IBOutlet weak var fourthDropDownFuncLocScanButton: UIButton!

    @IBOutlet var filterTypeDropdownView: UIView!
    @IBOutlet var filterTypeTextField: UITextField!
    @IBOutlet var filterTypeButton: UIButton!
    @IBOutlet var filterTypeStackView: UIStackView!
    
    @IBOutlet weak var seachAssestTagBtn: UIButton!

    let menudropDown = DropDown()
    let multiDropDown = DropDown()
    var menuarr = [String]()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    weak var valueFormatter: IValueFormatter?
    var cellTapped  = Bool()
    var currentRow = Int()
    var dropDownSelectString = String()
    var FilterDict : [String: String] = [:]
    var FirstDropDownArr = Array<String>()
    var SecondDropDownArr = Array<String>()
    var ThirdDropDownArr = [String]()
    var FourthDropDownArr = [String]()
    
    var userStatusArr = Array<StatusCategoryModel>()
    var selectedChartArr = Array<Any>()
    var finalFiltervalues : [String: Array<Any>] = [:]
    var typeOfScanCode = String()
    var approvedChecksheetArr = Array<FormResponseApprovalStatusModel>()
    var rejectedChecksheetArr = Array<FormResponseApprovalStatusModel>()
    var yetToBeReviewedArr = Array<FormReviewerResponseModel>()
    var oprFilterViewModel = OperationFiltersViewModel()
    var woFilterViewModel  = WorkOrderFiltersViewModel()
    var noFilterViewModel  = NotificationFiltersViewModel()
    var style2ViewModel = dBStyle2ViewModel()
    var filterTypeListArr = ["Work_Order".localized(),"Notification".localized()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJCLogger.log("Starting", Type: "info")
        oprFilterViewModel.dBVc = self
        woFilterViewModel.dBVc = self
        noFilterViewModel.dBVc = self
        style2ViewModel.dBVc =  self
        self.thirdDropDownFuncLocScanButton.isHidden = true
        self.fourthDropDownFuncLocScanButton.isHidden = true
        self.listButton.isHidden = true
        ODSUIHelper.setBorderToView(view:self.filterTypeDropdownView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        filterTypeButton.setTitle("", for: UIControl.State.normal)
        filterTypeTextField.text = self.filterTypeListArr[0]
        newpieChartView.backgroundColor = UIColor(named: "mjcSubViewColorNormal") ?? UIColor.blue
        self.TotalLabel.textColor = .black
        self.thirdDropDownTxtField.delegate = self
        self.thirdDropDownTxtField.isSearchEnable = false
//        self.firstDropDownTxtField.isUserInteractionEnabled = false
//        self.secondDropDownTxtField.isUserInteractionEnabled = false
        self.thirdDropDownTxtField.isUserInteractionEnabled = false
        self.fourthDropDownTxtField.isUserInteractionEnabled = false
        
        if DOWNLOAD_CREATEDBY_WO == "X" {
            WoFilterArray.append(Filters.CreatedOrAssigned.value)
        }
        if DOWNLOAD_CREATEDBY_NOTIF == "X" {
            NoFilterArray.append(Filters.CreatedOrAssigned.value)
        }
        listButton.setImage(UIImage(named: "wo"), for: .normal)
        
        ODSUIHelper.setBorderToView(view: self.firstDropDownTxtField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.secondDropDownTxtField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.thirdDropDownTxtField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.fourthDropDownTxtField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setButtonLayout(button: self.addButton, cornerRadius: self.addButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        if applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  dashBoardArray.firstIndex(of: "DASH_ASSET_HIE_TILE"){
                dashBoardArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("ASSET_HIERARCHY"){
            if let index =  dashBoardArray.firstIndex(of: "ASSET_HIERARCHY"){
                dashBoardArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_TIMESHEET_TILE"){
            if let index =  dashBoardArray.firstIndex(of: "DASH_TIMESHEET_TILE"){
                dashBoardArray.remove(at: index)
            }
        }
        if applicationFeatureArrayKeys.contains("DASH_GENERAL_FORM_TILE"){
            if let index =  dashBoardArray.firstIndex(of: "DASH_GENERAL_FORM_TILE"){
                dashBoardArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_TILE"){
            if let index =  dashBoardArray.firstIndex(of: "DASH_ONLINE_SEARCH_TILE"){
                dashBoardArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASHBOARD_REVIWER_TILE"){
            if let index =  dashBoardArray.firstIndex(of: "DASHBOARD_REVIWER_TILE"){
                dashBoardArray.remove(at: index)
            }
        }
        
        mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        
        if DeviceType == iPhone{
            ODSUIHelper.setBorderToView(view: self.filterCountView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        if applicationFeatureArrayKeys.contains("DASH_WO_TILE") &&  !applicationFeatureArrayKeys.contains("DASH_OPR_TILE"){
            workOrderFilterButton.isHidden = false
            workOrderFilterButton.setTitle("Work_Order".localized(), for: .normal)
            FilterDict["Header"] = "WorkOrder"
            FirstDropDownArr.removeAll()
            FirstDropDownArr = WoFilterArray
            if let index = FirstDropDownArr.firstIndex(of: Filters.ControlKey.value){
                FirstDropDownArr.remove(at: index)
            }
            if #available(iOS 13.0, *) {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                    self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
                }else{
                    self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                    self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
                }
            } else {
                self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
            }
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            self.workOrderFilterButton.backgroundColor = UIColor.init(red: 212.0/255.0, green: 227.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.notificationFilterButton.backgroundColor = UIColor.clear
            if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                self.addButton.isHidden = false
            }else{
                self.addButton.isHidden = true
            }
        }
        if applicationFeatureArrayKeys.contains("DASH_OPR_TILE") &&  !applicationFeatureArrayKeys.contains("DASH_WO_TILE"){
            workOrderFilterButton.isHidden = false
            workOrderFilterButton.setTitle("Operation".localized(), for: .normal)
            FilterDict["Header"] = "Operation"
            FirstDropDownArr.removeAll()
            FirstDropDownArr = WoFilterArray
            if let index = FirstDropDownArr.firstIndex(of: Filters.MantActivityType.value){
                FirstDropDownArr.remove(at: index)
            }
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            self.workOrderFilterButton.backgroundColor = UIColor.init(red: 212.0/255.0, green: 227.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.notificationFilterButton.backgroundColor = UIColor.clear
            if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                self.addButton.isHidden = false
            }else{
                self.addButton.isHidden = true
            }
            if #available(iOS 13.0, *) {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                    self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
                }else{
                    self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                    self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
                }
            } else {
                self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_WO_TILE") &&  !applicationFeatureArrayKeys.contains("DASH_OPR_TILE"){
            workOrderFilterButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("DASH_NOTI_TILE"){
            notificationFilterButton.isHidden = false
            if FilterDict["Header"] == nil{
                notificationFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
                FilterDict["Header"] = "Notification"
                FirstDropDownArr = NoFilterArray
                if #available(iOS 13.0, *) {
                    if UITraitCollection.current.userInterfaceStyle == .dark {
                        self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
                        self.workOrderFilterButton.setTitleColor(UIColor.white, for: .normal)
                    }else{
                        self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
                        self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                    }
                } else {
                    self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
                    self.workOrderFilterButton.setTitleColor(UIColor.white, for: .normal)
                }
                self.workOrderFilterButton.backgroundColor = UIColor.clear
                self.notificationFilterButton.backgroundColor = UIColor.init(red: 212.0/255.0, green: 227.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                    self.addButton.isHidden = false
                }else{
                    self.addButton.isHidden = true
                }
            }
        }else{
            notificationFilterButton.isHidden = true
        }
        supervisorFilterButton.isHidden = true
        UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
        onlineSearch = Bool()
        onlineSearchArray.removeAll()
        fromSupervisorWorkOrder = false
        detailsTableView.estimatedRowHeight = 90.0
        self.userTitlelabel.text = userDisplayName + " (\(Role_ID)) "
        workOrderFilterButton.addTarget(self, action: #selector(self.orderTypeSelectionButton(btn:)), for: .touchUpInside)
        notificationFilterButton.addTarget(self, action: #selector(self.orderTypeSelectionButton(btn:)), for: .touchUpInside)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardStyle2.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardStyle2.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        self.style2ViewModel.setFilterData()
        
        //First dropdown
        if self.FirstDropDownArr.count > 0{
            self.firstDropDownTxtField.optionArray = self.FirstDropDownArr
            self.firstDropDownTxtField.checkMarkEnabled = false
        }
        
        self.firstDropDownTxtField.didSelect { [self] selectedText, index, id in
            self.firstDropDownTxtField.text = selectedText
            self.FilterDict["First"] = selectedText
            if selectedText == Filters.FunctionalLocation.value{
                typeOfScanCode = "firstFunctionalLocation"
            }else if selectedText == Filters.Equipment.value {
                typeOfScanCode = "firstEquipment"
            }else if selectedText == Filters.TechID.value{
                self.style2ViewModel.getEquipmentList(from: "TechID")
            }
            if selectedText == Filters.FunctionalLocation.value || selectedText == Filters.Equipment.value {
                if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                    self.thirdDropDownTxtField.isUserInteractionEnabled = false
                    self.thirdDropDownFuncLocScanButton.isUserInteractionEnabled = false
                    self.thirdDropDownButton.isHidden = false
                }else{
                    self.thirdDropDownTxtField.isUserInteractionEnabled = true
                    self.thirdDropDownFuncLocScanButton.isUserInteractionEnabled = true
                    self.thirdDropDownButton.isHidden = true
                    self.FilterDict.removeValue(forKey: "Third")
                }
                self.thirdDropDownFuncLocScanButton.isHidden = false
                self.thirdDropDownTxtField.arrow.isHidden = true
            }else{
                self.thirdDropDownTxtField.isUserInteractionEnabled = false
                self.thirdDropDownFuncLocScanButton.isUserInteractionEnabled = false
                self.thirdDropDownFuncLocScanButton.isHidden = true
                self.thirdDropDownTxtField.arrow.isHidden = false
                self.thirdDropDownButton.isHidden = false
            }
            var arr = self.FirstDropDownArr
            let index = arr.firstIndex(of: selectedText)
            if index != nil{
                arr.remove(at: index!)
                if selectedText == Filters.Equipment.value{
                    let index = arr.firstIndex(of: Filters.TechID.value)
                    if index != nil{
                        arr.remove(at: index!)
                    }
                }else if selectedText == Filters.TechID.value{
                    let index = arr.firstIndex(of: Filters.Equipment.value)
                    if index != nil{
                        arr.remove(at: index!)
                    }
                }
                self.SecondDropDownArr = arr
                self.secondDropDownTxtField.text = selectStr
                if selectedText == Filters.FunctionalLocation.value || selectedText == Filters.Equipment.value {
                    self.thirdDropDownTxtField.text = ""
                    self.thirdDropDownTxtField.becomeFirstResponder()
                }else{
                    self.thirdDropDownTxtField.text = selectStr
                }
                self.fourthDropDownTxtField.text = selectStr
                self.FilterDict.removeValue(forKey: "Second")
                self.FilterDict.removeValue(forKey: "Fourth")
                self.FilterDict.removeValue(forKey: "Third")
            }
            if selectedText == selectStr{
                self.FilterDict.removeValue(forKey: "First")
                self.FilterDict.removeValue(forKey: "Third")
            }
            self.dropDownSelectString = ""
            //Second dropdown
            if self.SecondDropDownArr.count > 0{
                self.secondDropDownTxtField.optionArray = self.SecondDropDownArr
                self.secondDropDownTxtField.checkMarkEnabled = false
            }
        }
        
        //Second dropdown
        self.secondDropDownTxtField.didSelect { [self] selectedText, index, id in
            self.secondDropDownTxtField.text = selectedText
            if selectedText == Filters.FunctionalLocation.value{
                typeOfScanCode = "secondFunctionalLocation"
            }else if selectedText == Filters.Equipment.value {
                typeOfScanCode = "secondEquipment"
            }else if selectedText == Filters.TechID.value{
                self.style2ViewModel.getEquipmentList(from: "TechID")
            }
            if selectedText == Filters.FunctionalLocation.value || selectedText == Filters.Equipment.value {
                if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                    self.fourthDropDownTxtField.isUserInteractionEnabled = false
                    self.fourthDropDownFuncLocScanButton.isUserInteractionEnabled = false
                    self.fourthDropDownFuncLocScanButton.isHidden = true
                    self.fourthDropDownTxtField.arrow.isHidden = false
                }else{
                    self.fourthDropDownTxtField.isUserInteractionEnabled = true
                    self.fourthDropDownFuncLocScanButton.isUserInteractionEnabled = true
                    self.fourthDropDownButton.isHidden = true
                    self.FilterDict.removeValue(forKey: "Fourth")
                }
                self.fourthDropDownFuncLocScanButton.isHidden = false
                self.fourthDropDownTxtField.arrow.isHidden = true
            }else{
                self.fourthDropDownTxtField.isUserInteractionEnabled = false
                self.fourthDropDownFuncLocScanButton.isUserInteractionEnabled = false
                self.fourthDropDownFuncLocScanButton.isHidden = true
                self.fourthDropDownTxtField.arrow.isHidden = false
                self.fourthDropDownButton.isHidden = false
            }
            if selectedText == Filters.FunctionalLocation.value || selectedText == Filters.Equipment.value {
                self.fourthDropDownTxtField.text = ""
                self.fourthDropDownTxtField.becomeFirstResponder()
            }else{
                self.fourthDropDownTxtField.text = selectStr
            }
            if selectedText == selectStr{
                self.FilterDict.removeValue(forKey: "Second")
                self.FilterDict.removeValue(forKey: "Fourth")
            }else{
                FourthDropDownArr.removeAll()
                self.FilterDict["Second"] = selectedText
            }
            self.dropDownSelectString = ""
        }
        
        //Third dropdown
        self.thirdDropDownTxtField.didSelect { selectedText, index, id in
            self.thirdDropDownTxtField.text = selectedText
            let selectedArr = selectedText.components(separatedBy: ";")
            if selectedArr.count > 0{
                var arr = selectedArr
                if arr.contains(selectStr){
                    let index = selectedArr.firstIndex(of: selectStr)
                    if index! >= 0 && index! <= selectedArr.count{
                        arr.remove(at: index!)
                    }
                }
                var itemstr = String()
                for item in arr{
                    itemstr += item + ";"
                }
                self.thirdDropDownTxtField.text = "\(itemstr)"
                self.FilterDict["Third"] = itemstr
            }
            else{
                let itemstr = selectStr
                self.thirdDropDownTxtField.text = itemstr
                self.FilterDict["Third"] = itemstr
            }
        }
        
        //Fourth dropdown
        self.fourthDropDownTxtField.didSelect { selectedText, index, id in
            self.fourthDropDownTxtField.text = selectedText
            let selectedArr = selectedText.components(separatedBy: ";")
            if selectedArr.count > 0{
                var arr = selectedArr
                if arr.contains(selectStr){
                    let index = selectedArr.firstIndex(of: selectStr)
                    if index! >= 0 && index! <= selectedArr.count{
                        arr.remove(at: index!)
                    }
                }
                var itemstr = String()
                for item in arr{
                    itemstr += item + ";"
                }
                self.fourthDropDownTxtField.text = "\(itemstr)"
                self.FilterDict["Fourth"] = itemstr
            }else{
                let itemstr = selectStr
                self.fourthDropDownTxtField.text = itemstr
                self.FilterDict["Fourth"] = itemstr
            }
        }
        
        multiDropDown.multiSelectionAction = { [weak self] (indices, items) in
            if !items.isEmpty {
                if self?.dropDownSelectString == "Third"{
                    var arr = items
                    if arr.contains(selectStr){
                        let index = items.firstIndex(of: selectStr)
                        if index! >= 0 && index! <= items.count{
                            arr.remove(at: index!)
                        }
                    }
                    var itemstr = String()
                    for item in arr{
                        itemstr += item + ";"
                    }
                    self?.thirdDropDownTxtField.text = "\(itemstr)"
                    self?.FilterDict["Third"] = itemstr
                }else if self?.dropDownSelectString == "Fourth"{
                    var arr = items
                    if arr.contains(selectStr){
                        let index = items.firstIndex(of: selectStr)
                        if index! >= 0 && index! <= items.count{
                            arr.remove(at: index!)
                        }
                    }
                    var itemstr = String()
                    for item in arr{
                        itemstr += item + ";"
                    }
                    self?.fourthDropDownTxtField.text = "\(itemstr)"
                    self?.FilterDict["Fourth"] = itemstr
                }
            }else{
                let itemstr = selectStr
                if self?.dropDownSelectString == "Third"{
                    self?.thirdDropDownTxtField.text = itemstr
                    self?.FilterDict["Third"] = itemstr
                }else if self?.dropDownSelectString == "Fourth"{
                    self?.fourthDropDownTxtField.text = itemstr
                    self?.FilterDict["Fourth"] = itemstr
                }
            }
        }
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownSelectString == "First"{
                self.firstDropDownTxtField.text = "\(item)"
                self.FilterDict["First"] = item
                if item == Filters.FunctionalLocation.value{
                    typeOfScanCode = "firstFunctionalLocation"
                }else if item == Filters.Equipment.value {
                    typeOfScanCode = "firstEquipment"
                }else if item == Filters.TechID.value{
                    self.style2ViewModel.getEquipmentList(from: "TechID")
                }
                if item == Filters.FunctionalLocation.value || item == Filters.Equipment.value {
                    if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                        self.thirdDropDownTxtField.isUserInteractionEnabled = false
                        self.thirdDropDownFuncLocScanButton.isUserInteractionEnabled = false
                        self.thirdDropDownButton.isHidden = false
                    }else{
                        self.thirdDropDownTxtField.isUserInteractionEnabled = true
                        self.thirdDropDownFuncLocScanButton.isUserInteractionEnabled = true
                        self.thirdDropDownButton.isHidden = true
                        self.FilterDict.removeValue(forKey: "Third")
                    }
                    self.thirdDropDownFuncLocScanButton.isHidden = false
                }else{
                    self.thirdDropDownTxtField.isUserInteractionEnabled = false
                    self.thirdDropDownFuncLocScanButton.isUserInteractionEnabled = false
                    self.thirdDropDownFuncLocScanButton.isHidden = true
                    self.thirdDropDownButton.isHidden = false
                }
                var arr = self.FirstDropDownArr
                let index = arr.firstIndex(of: item)
                if index != nil{
                    arr.remove(at: index!)
                    if item == Filters.Equipment.value{
                        let index = arr.firstIndex(of: Filters.TechID.value)
                        if index != nil{
                            arr.remove(at: index!)
                        }
                    }else if item == Filters.TechID.value{
                        let index = arr.firstIndex(of: Filters.Equipment.value)
                        if index != nil{
                            arr.remove(at: index!)
                        }
                    }
                    self.SecondDropDownArr = arr
                    self.secondDropDownTxtField.text = selectStr
                    if item == Filters.FunctionalLocation.value || item == Filters.Equipment.value {
                        self.thirdDropDownTxtField.text = ""
                        self.thirdDropDownTxtField.becomeFirstResponder()
                    }else{
                        self.thirdDropDownTxtField.text = selectStr
                    }
                    self.fourthDropDownTxtField.text = selectStr
                    self.FilterDict.removeValue(forKey: "Second")
                    self.FilterDict.removeValue(forKey: "Fourth")
                    self.FilterDict.removeValue(forKey: "Third")
                }
                if item == selectStr{
                    self.FilterDict.removeValue(forKey: "First")
                    self.FilterDict.removeValue(forKey: "Third")
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "Second"{
                self.secondDropDownTxtField.text = "\(item)"
                if item == Filters.FunctionalLocation.value{
                    typeOfScanCode = "secondFunctionalLocation"
                }else if item == Filters.Equipment.value {
                    typeOfScanCode = "secondEquipment"
                }else if item == Filters.TechID.value{
                    self.style2ViewModel.getEquipmentList(from: "TechID")
                }
                if item == Filters.FunctionalLocation.value || item == Filters.Equipment.value {
                    if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                        self.fourthDropDownTxtField.isUserInteractionEnabled = false
                        self.fourthDropDownFuncLocScanButton.isUserInteractionEnabled = false
                        self.fourthDropDownFuncLocScanButton.isHidden = true
                    }else{
                        self.fourthDropDownTxtField.isUserInteractionEnabled = true
                        self.fourthDropDownFuncLocScanButton.isUserInteractionEnabled = true
                        self.fourthDropDownButton.isHidden = true
                        self.FilterDict.removeValue(forKey: "Fourth")
                    }
                    self.fourthDropDownFuncLocScanButton.isHidden = false
                }else{
                    self.fourthDropDownTxtField.isUserInteractionEnabled = false
                    self.fourthDropDownFuncLocScanButton.isUserInteractionEnabled = false
                    self.fourthDropDownFuncLocScanButton.isHidden = true
                    self.fourthDropDownButton.isHidden = false
                }
                if item == Filters.FunctionalLocation.value || item == Filters.Equipment.value {
                    self.fourthDropDownTxtField.text = ""
                    self.fourthDropDownTxtField.becomeFirstResponder()
                }else{
                    self.fourthDropDownTxtField.text = selectStr
                }
                if item == selectStr{
                    self.FilterDict.removeValue(forKey: "Second")
                    self.FilterDict.removeValue(forKey: "Fourth")
                }else{
                    self.FilterDict["Second"] = item
                }
                self.dropDownSelectString = ""
            }else if self.dropDownSelectString == "FilterObject"{
                if item == "Work_Order".localized(){
                    self.filterTypeTextField.text = item
                    setWorkOrderDefaultValues()
                }else if item == "Notification".localized(){
                    self.filterTypeTextField.text = item
                    setNotificationDefaultValues()
                }
            }
        }
        ScreenManager.registerDBStyle2ListCell(tableView: self.detailsTableView)
        createFwLogsShareBtn()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        dashboardFilterDic.removeAll()
        if onlineSearch == false{
            myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
            if flushStatus == true{
                if self.refreshButton != nil {
                    self.refreshButton.showSpin()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        self.listButton.center = self.newpieChartView.centerCircleBox
        self.listButton.isHidden = false
    }
    @IBAction func selectMenuaction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if self.filterTypeListArr.count > 0 {
            menudropDown.anchorView = self.filterTypeDropdownView
            let arr : [String] = self.filterTypeListArr as NSArray as! [String]
            menudropDown.dataSource = arr
            self.dropDownSelectString = "FilterObject"
            menudropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func moreOptionsMenuaction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        menuDataModel.uniqueInstance.presentMenu(menuArr: dashBoardMenuArray, imgArr: dashBoardMenuimgArray, sender: sender, vc: self)
        mJCLogger.log("Ended", Type: "info")
    }
    func shareLogs(fwLogs:Bool){
        if DeviceType == iPad {
            myAssetDataManager.uniqueInstance.shareLogFiles(sender: self.threeDotMenu,screen: self,fwLogs: fwLogs,from: "",userId: strUser)
        }else {
            myAssetDataManager.uniqueInstance.shareLogFiles(sender: self.logoutButton,screen: self,fwLogs: fwLogs,from: "",userId: strUser)
        }
    }
    func EntityCreated(){
        mJCLogger.log("Starting", Type: "info")
        self.style2ViewModel.setFilterData()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func ApplyFilter(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.newpieChartView.clear()
        if let header = FilterDict["Header"]{
            if header == ""{
                mJCLogger.log("Please_Select_Header".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Header".localized(), button: okay)
                return
            }
        }
        if let first = FilterDict["First"]{
            if first != "" ||  first != selectStr{
                if (first == Filters.FunctionalLocation.value || first == Filters.Equipment.value) && self.thirdDropDownTxtField.text != "" {
                    FilterDict["Third"] = self.thirdDropDownTxtField.text
                }
                if let third = FilterDict["Third"]  {
                    if third == "" || third == selectStr{
                        mJCLogger.log("Please_Select".localized() + " \(first) " +  "Filter".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select".localized() + " \(first) " +  "Filter".localized(), button: okay)
                        return
                    }
                }else{
                    mJCLogger.log("Please_Select".localized() + " \(first) " + "Filter".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select".localized() + " \(first) " + "Filter".localized(), button: okay)
                    return
                }
            }
        }
        if let second = FilterDict["Second"]{
            
            if second != "" ||  second != selectStr{
                if (second == Filters.FunctionalLocation.value || second == Filters.Equipment.value) && self.fourthDropDownTxtField.text != "" {
                    FilterDict["Fourth"] = self.fourthDropDownTxtField.text
                }
                if let fourth = FilterDict["Fourth"]{
                    if (fourth == "" || fourth == selectStr) {
                        mJCLogger.log("Please_Select".localized() + " \(second) " + "Filter".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select".localized() + " \(second) " + "Filter".localized(), button: okay)
                        return
                    }
                }else{
                    mJCLogger.log("Please_Select".localized() + " \(second) " + "Filter".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select".localized() + " \(second) " + "Filter".localized(), button: okay)
                    return
                    
                }
            }
        }
        if FilterDict["First"] == nil && FilterDict["Second"] == nil{
            mJCLogger.log("Please_Select_Filter".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Select_Filter".localized(), button: okay)
            return
        }
        UserDefaults.standard.removeObject(forKey: "DashFilter")
        UserDefaults.standard.setValue(FilterDict, forKey: "DashFilter")
        self.finalFiltervalues.removeAll()
        self.ApplyDashBoardFilter()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.FilterDict.removeValue(forKey: "First")
        self.FilterDict.removeValue(forKey: "Second")
        self.FilterDict.removeValue(forKey: "Third")
        self.FilterDict.removeValue(forKey: "Fourth")
        self.thirdDropDownFuncLocScanButton.isHidden = true
        self.fourthDropDownFuncLocScanButton.isHidden = true
        if self.FirstDropDownArr.count > 0{
            self.firstDropDownTxtField.text = Filters.Priority.value
            var arr = self.FirstDropDownArr
            if let index = arr.firstIndex(of: Filters.Priority.value){
                arr.remove(at: index)
            }
            self.SecondDropDownArr = arr
            self.FilterDict["First"] = Filters.Priority.value
            self.secondDropDownTxtField.text = selectStr
            self.fourthDropDownTxtField.text = selectStr
            self.FourthDropDownArr.removeAll()
            self.dropDownSelectString = ""
            self.style2ViewModel.setPriority(fromInit: true)
            self.finalFiltervalues.removeAll()
            self.ApplyDashBoardFilter()
        }
        self.ApplyDashBoardFilter()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func orderTypeSelectionButton(btn: UIButton){
        mJCLogger.log("Starting", Type: "info")
        btn.isSelected = !btn.isSelected
        self.thirdDropDownFuncLocScanButton.isHidden = true
        self.fourthDropDownFuncLocScanButton.isHidden = true
        if btn.tag == 0 {
            self.setWorkOrderDefaultValues()
        }else if btn.tag == 1 {
            self.setNotificationDefaultValues()
        }
        if DeviceType == iPhone{
            if selectedChartArr.count == 0 {
                self.detailsTabelViewHeightConstraint.constant = 0
            }else if selectedChartArr.count == 1{
                self.detailsTabelViewHeightConstraint.constant = 150
            }else{
                self.detailsTabelViewHeightConstraint.constant = 300
            }
        }
        self.detailsTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkOrderDefaultValues(){
        currentMasterView = "WorkOrder"
        listButton.setImage(UIImage(named: "wo"), for: .normal)
        workOrderFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
        notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
        if applicationFeatureArrayKeys.contains("DASH_WO_TILE") &&  !applicationFeatureArrayKeys.contains("DASH_OPR_TILE"){
            workOrderFilterButton.setTitle("Work_Order".localized(), for: .normal)
            FilterDict["Header"] = "WorkOrder"
            FirstDropDownArr.removeAll()
            FirstDropDownArr = WoFilterArray
            if let index = FirstDropDownArr.firstIndex(of: Filters.ControlKey.value){
                FirstDropDownArr.remove(at: index)
            }
        }
        if applicationFeatureArrayKeys.contains("DASH_OPR_TILE") &&  !applicationFeatureArrayKeys.contains("DASH_WO_TILE"){
            workOrderFilterButton.setTitle("Operation".localized(), for: .normal)
            FilterDict["Header"] = "Operation"
            FirstDropDownArr.removeAll()
            FirstDropDownArr = WoFilterArray
            if let index = FirstDropDownArr.firstIndex(of: Filters.MantActivityType.value){
                FirstDropDownArr.remove(at: index)
            }
        }
        self.FilterDict["First"] = Filters.Priority.value
        self.TotalLabel.text = "Total_Workorders".localized()+": \(allworkorderArray.count)"
        let arr = self.FirstDropDownArr
        self.SecondDropDownArr = arr
        let index = self.SecondDropDownArr.firstIndex(of: Filters.Priority.value)
        if index != nil{
            self.SecondDropDownArr.remove(at: index!)
        }
        self.secondDropDownTxtField.text = selectStr
        self.fourthDropDownTxtField.text = selectStr
        if self.secondDropDownTxtField.text == selectStr{
            self.FilterDict.removeValue(forKey: "Second")
            self.FilterDict.removeValue(forKey: "Fourth")
        }
        self.style2ViewModel.setPriority(fromInit: true)
        self.finalFiltervalues.removeAll()
        self.firstDropDownTxtField.text = Filters.Priority.value
        if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
            self.addButton.isHidden = false
        }else{
            self.addButton.isHidden = true
        }
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
            }else{
                self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
            }
        } else {
            self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
            self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
        }
        UserDefaults.standard.setValue(FilterDict, forKey: "DashFilter")
        self.workOrderFilterButton.backgroundColor = dbfilterBgColor
        self.notificationFilterButton.backgroundColor = .clear
        ApplyDashBoardFilter()
    }
    func setNotificationDefaultValues(){
        currentMasterView = "Notification"
        listButton.setImage(UIImage(named: "notifi"), for: .normal)
        workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
        notificationFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
            }else{
                self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
                self.notificationFilterButton.setTitleColor(UIColor.black, for: .normal)
            }
        } else {
            self.workOrderFilterButton.setTitleColor(UIColor.black, for: .normal)
            self.notificationFilterButton.setTitleColor(UIColor.white, for: .normal)
        }
        FilterDict["Header"] = "Notification"
        FirstDropDownArr = NoFilterArray
        self.FilterDict["First"] = Filters.Priority.value
        self.firstDropDownTxtField.text = Filters.Priority.value
        self.secondDropDownTxtField.text = selectStr
        self.fourthDropDownTxtField.text = selectStr
        self.TotalLabel.text = "Total_Notifications".localized() + " : \(allNotficationArray.count)"
        let arr = self.FirstDropDownArr
        self.SecondDropDownArr = arr
        let index = self.SecondDropDownArr.firstIndex(of: Filters.Priority.value)
        if index != nil{
            self.SecondDropDownArr.remove(at: index!)
        }
        if self.secondDropDownTxtField.text == selectStr{
            self.FilterDict.removeValue(forKey: "Second")
            self.FilterDict.removeValue(forKey: "Fourth")
        }
        self.style2ViewModel.setPriority(fromInit: true)
        self.finalFiltervalues.removeAll()
        UserDefaults.standard.setValue(FilterDict, forKey: "DashFilter")
        ApplyDashBoardFilter()
        if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
            self.addButton.isHidden = false
        }else{
            self.addButton.isHidden = true
        }
        self.notificationFilterButton.backgroundColor = dbfilterBgColor
        self.workOrderFilterButton.backgroundColor = .clear
    }
    @IBAction func firstDropDownButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.dataSource = self.FirstDropDownArr
        menudropDown.anchorView = sender as? UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.isHidden = true
        }
        menudropDown.width = 220.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        self.dropDownSelectString = "First"
        menudropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func secondDropDownButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if  FilterDict["First"] != nil{
            menudropDown.dataSource = self.SecondDropDownArr
            menudropDown.anchorView = sender as? UIButton
            menudropDown.cellHeight = 40.0
            menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                guard let cell = cell as? DropDownWithImageCell else { return }
                cell.logoImageView.isHidden = true
            }
            menudropDown.width = 220.0
            self.dropDownSelectString = "Second"
            menudropDown.backgroundColor = UIColor.white
            menudropDown.textColor = appColor
            menudropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func thirdDropDownButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        ThirdDropDownArr.removeAll()
        self.thirdDropDownTxtField.selectedCells.removeAll()
        if firstDropDownTxtField.text == Filters.Priority.value{
            self.style2ViewModel.priorityListArray.removeAllObjects()
            self.style2ViewModel.setPriority(fromInit: false)
            ThirdDropDownArr = self.style2ViewModel.priorityListArray as! [String]
        }else if firstDropDownTxtField.text == Filters.UserStatus.value{
            self.style2ViewModel.setUserStatusList()
            ThirdDropDownArr = self.style2ViewModel.userStatusListArr
        }else if firstDropDownTxtField.text == Filters.WorkCenter.value{
            self.style2ViewModel.workCentersListArray.removeAll()
            self.style2ViewModel.setWorkCentersList()
            ThirdDropDownArr = self.style2ViewModel.workCentersListArray
        }else if firstDropDownTxtField.text == Filters.Date.value{
            var arr = [String]()
            arr = dateDropArray
            if currentMasterView == "Notification"{
                if let schedulIndex = arr.index(of: Filters.SchedulingComplaint.value){
                    arr.remove(at: schedulIndex)
                }
                if let nonScheIndex = arr.index(of: Filters.SchedulingNonComplaint.value){
                    arr.remove(at: nonScheIndex)
                }
            }
            ThirdDropDownArr = arr
        }else if firstDropDownTxtField.text == Filters.MantActivityType.value{
            self.style2ViewModel.setMaintActivityType()
            ThirdDropDownArr = self.style2ViewModel.mainActivityTypeArray
        }else if firstDropDownTxtField.text == Filters.ControlKey.value{
            self.style2ViewModel.setControlKey()
            ThirdDropDownArr = self.style2ViewModel.controlkeyListArray
        }else if firstDropDownTxtField.text == Filters.WorkorderConversion.value{
            let arr = [Filters.WorkorderCreated.value,Filters.WorkorderNotCreated.value]
            ThirdDropDownArr = arr
        }else if firstDropDownTxtField.text == Filters.CreatedOrAssigned.value{
            ThirdDropDownArr = typeArray
        }else if firstDropDownTxtField.text == Filters.Status.value{
            self.style2ViewModel.statusListArray.removeAll()
            self.style2ViewModel.setStatusList(fromInit: false)
            ThirdDropDownArr = self.style2ViewModel.statusListArray
        }else if firstDropDownTxtField.text == Filters.Technician.value{
            self.style2ViewModel.techniciansListArray.removeAll()
            self.style2ViewModel.setTechniciansList()
            ThirdDropDownArr = self.style2ViewModel.techniciansListArray
        }else if firstDropDownTxtField.text == Filters.PlanningPlant.value{
            self.style2ViewModel.planningPlantListArray.removeAll()
            self.style2ViewModel.setPlanningPlantList()
            ThirdDropDownArr = self.style2ViewModel.planningPlantListArray
        }else if firstDropDownTxtField.text == Filters.PlannerGroup.value{
            self.style2ViewModel.plannerGroupListArray.removeAll()
            self.style2ViewModel.setPlannerGroupList()
            ThirdDropDownArr = self.style2ViewModel.plannerGroupListArray
        }else if firstDropDownTxtField.text == Filters.MaintenancePlant.value{
            self.style2ViewModel.maintainacePlantListArray.removeAll()
            self.style2ViewModel.setMaintainancePlantList()
            ThirdDropDownArr = self.style2ViewModel.maintainacePlantListArray
        }else if firstDropDownTxtField.text == Filters.TechID.value{
            ThirdDropDownArr = self.style2ViewModel.techIDListArray
        }else if firstDropDownTxtField.text == Filters.OrderType.value{
            self.style2ViewModel.orderTypeListArray.removeAll()
            self.style2ViewModel.setOrderTypeList()
            ThirdDropDownArr = self.style2ViewModel.orderTypeListArray
        }else if firstDropDownTxtField.text == Filters.NotificationType.value{
            self.style2ViewModel.notificationTypeListArray.removeAll()
            self.style2ViewModel.setNotificationTypeList()
            ThirdDropDownArr = self.style2ViewModel.notificationTypeListArray
        }else if firstDropDownTxtField.text == Filters.SystemStatus.value{
            self.style2ViewModel.systemStatusListArray.removeAll()
            self.style2ViewModel.setSystemStatusList()
            ThirdDropDownArr = self.style2ViewModel.systemStatusListArray
        }else if firstDropDownTxtField.text == Filters.Location.value{
            self.style2ViewModel.locationListArray.removeAll()
            self.style2ViewModel.setLocationList()
            ThirdDropDownArr = self.style2ViewModel.locationListArray
        }else if firstDropDownTxtField.text == Filters.InspectionLot.value{
            let arr = [Filters.InspectionPending.value,Filters.InspectionCompleted.value]
            ThirdDropDownArr = arr
        }else if firstDropDownTxtField.text == Filters.CSStatus.value{
            ThirdDropDownArr = CSStatusArry
        }else if firstDropDownTxtField.text == Filters.FunctionalLocation.value{
            if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                self.style2ViewModel.setFunctionalLocationList()
                ThirdDropDownArr = self.style2ViewModel.funcLocListArr
            }
        }else if firstDropDownTxtField.text == Filters.Equipment.value{
            if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                self.style2ViewModel.getEquipmentList(from: "")
                ThirdDropDownArr = self.style2ViewModel.equipListArr
            }
        }
        self.dropDownSelectString = "Third"
        if ThirdDropDownArr.count > 0{
            self.thirdDropDownTxtField.optionArray = ThirdDropDownArr
            if ThirdDropDownArr.count == 1{
                self.thirdDropDownTxtField.checkMarkEnabled = false
                self.thirdDropDownTxtField.isMultipleSelection = false
            }
            else{
                self.thirdDropDownTxtField.checkMarkEnabled = true
                self.thirdDropDownTxtField.isMultipleSelection = true
            }
            self.thirdDropDownTxtField.touchAction()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func fourthDropDownButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.FourthDropDownArr.removeAll()
        self.fourthDropDownTxtField.selectedCells.removeAll()
        if secondDropDownTxtField.text == Filters.Priority.value{
            self.style2ViewModel.priorityListArray.removeAllObjects()
            self.style2ViewModel.setPriority(fromInit: false)
            FourthDropDownArr = self.style2ViewModel.priorityListArray as! [String]
        }else if secondDropDownTxtField.text == Filters.WorkCenter.value{
            self.style2ViewModel.workCentersListArray.removeAll()
            self.style2ViewModel.setWorkCentersList()
            FourthDropDownArr = self.style2ViewModel.workCentersListArray
        }else if secondDropDownTxtField.text == Filters.ControlKey.value{
            self.style2ViewModel.setControlKey()
            FourthDropDownArr = self.style2ViewModel.controlkeyListArray
        }else if secondDropDownTxtField.text == Filters.UserStatus.value{
            self.style2ViewModel.setUserStatusList()
            FourthDropDownArr = self.style2ViewModel.userStatusListArr
        }else if secondDropDownTxtField.text == Filters.Date.value{
            var arr = [String]()
            arr = dateDropArray
            if currentMasterView == "Notification"{
                if let schedulIndex = arr.index(of: Filters.SchedulingComplaint.value){
                    arr.remove(at: schedulIndex)
                }
                if let nonScheIndex = arr.index(of: Filters.SchedulingNonComplaint.value){
                    arr.remove(at: nonScheIndex)
                }
            }
            FourthDropDownArr = arr
        }else if secondDropDownTxtField.text == Filters.MantActivityType.value{
            self.style2ViewModel.setMaintActivityType()
            FourthDropDownArr = self.style2ViewModel.mainActivityTypeArray
        }else if secondDropDownTxtField.text == Filters.Technician.value{
            self.style2ViewModel.techniciansListArray.removeAll()
            self.style2ViewModel.setTechniciansList()
            FourthDropDownArr = self.style2ViewModel.techniciansListArray
        }else if secondDropDownTxtField.text == Filters.WorkorderConversion.value{
            let arr = [Filters.WorkorderCreated.value,Filters.WorkorderNotCreated.value]
            FourthDropDownArr = arr
        }else if secondDropDownTxtField.text == Filters.CreatedOrAssigned.value{
            FourthDropDownArr = typeArray
        }else if secondDropDownTxtField.text == Filters.Status.value{
            self.style2ViewModel.statusListArray.removeAll()
            self.style2ViewModel.setStatusList(fromInit: false)
            FourthDropDownArr = self.style2ViewModel.statusListArray
        }else if secondDropDownTxtField.text == Filters.Technician.value{
            self.style2ViewModel.techniciansListArray.removeAll()
            self.style2ViewModel.setTechniciansList()
            FourthDropDownArr = self.style2ViewModel.techniciansListArray
        }else if secondDropDownTxtField.text == Filters.PlanningPlant.value{
            self.style2ViewModel.planningPlantListArray.removeAll()
            self.style2ViewModel.setPlanningPlantList()
            FourthDropDownArr = self.style2ViewModel.planningPlantListArray
        }else if secondDropDownTxtField.text == Filters.PlannerGroup.value{
            self.style2ViewModel.plannerGroupListArray.removeAll()
            self.style2ViewModel.setPlannerGroupList()
            FourthDropDownArr = self.style2ViewModel.plannerGroupListArray
        }else if secondDropDownTxtField.text == Filters.MaintenancePlant.value{
            self.style2ViewModel.maintainacePlantListArray.removeAll()
            self.style2ViewModel.setMaintainancePlantList()
            FourthDropDownArr = self.style2ViewModel.maintainacePlantListArray
        }else if secondDropDownTxtField.text == Filters.TechID.value{
            FourthDropDownArr = self.style2ViewModel.techIDListArray
        }else if secondDropDownTxtField.text == Filters.OrderType.value{
            self.style2ViewModel.orderTypeListArray.removeAll()
            self.style2ViewModel.setOrderTypeList()
            FourthDropDownArr = self.style2ViewModel.orderTypeListArray
        }else if secondDropDownTxtField.text == Filters.NotificationType.value{
            self.style2ViewModel.notificationTypeListArray.removeAll()
            self.style2ViewModel.setNotificationTypeList()
            FourthDropDownArr = self.style2ViewModel.notificationTypeListArray
        }else if secondDropDownTxtField.text == Filters.SystemStatus.value{
            self.style2ViewModel.systemStatusListArray.removeAll()
            self.style2ViewModel.setSystemStatusList()
            FourthDropDownArr = self.style2ViewModel.systemStatusListArray
        }else if secondDropDownTxtField.text == Filters.Location.value{
            self.style2ViewModel.locationListArray.removeAll()
            self.style2ViewModel.setLocationList()
            FourthDropDownArr = self.style2ViewModel.locationListArray
        }else if secondDropDownTxtField.text == Filters.InspectionLot.value{
            let arr = [Filters.InspectionPending.value,Filters.InspectionCompleted.value]
            FourthDropDownArr = arr
        }else if secondDropDownTxtField.text == Filters.CSStatus.value{
            FourthDropDownArr = CSStatusArry
        }else if secondDropDownTxtField.text == Filters.FunctionalLocation.value{
            if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                self.style2ViewModel.setFunctionalLocationList()
                FourthDropDownArr = self.style2ViewModel.funcLocListArr
            }
        }else if secondDropDownTxtField.text == Filters.Equipment.value{
            if DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER == true{
                self.style2ViewModel.getEquipmentList(from: "")
                FourthDropDownArr = self.style2ViewModel.equipListArr
            }
        }
        self.dropDownSelectString = "Fourth"
        if FourthDropDownArr.count > 0{
            self.fourthDropDownTxtField.optionArray = FourthDropDownArr
            if FourthDropDownArr.count == 1{
                self.fourthDropDownTxtField.checkMarkEnabled = false
                self.fourthDropDownTxtField.isMultipleSelection = false
            }
            else{
                self.fourthDropDownTxtField.checkMarkEnabled = true
                self.fourthDropDownTxtField.isMultipleSelection = true
            }
            self.fourthDropDownTxtField.rowHeight = 45
            self.fourthDropDownTxtField.touchAction()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func ApplyDashBoardFilter(){
        mJCLogger.log("Starting", Type: "info")
        if let header = FilterDict["Header"]{
            var firstFilterItem = String()
            var secondFilterItem = String()
            var thirdFilterArr = Array<String>()
            var fourthFilterArr = Array<String>()
            if let first = FilterDict["First"]{
                if first == Filters.Priority.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.Priority.value
                    }
                }else if first == Filters.WorkCenter.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.WorkCenter.value
                    }
                }else if first == Filters.UserStatus.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.UserStatus.value
                    }
                }else if first == Filters.Date.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.Date.value
                    }
                }else if first == Filters.MantActivityType.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.MantActivityType.value
                    }
                }else if first == Filters.WorkorderConversion.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.WorkorderConversion.value
                    }
                }else if first == Filters.CreatedOrAssigned.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.CreatedOrAssigned.value
                    }
                }else if first == Filters.ControlKey.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.ControlKey.value
                    }
                }else if first == Filters.Status.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.Status.value
                    }
                }else if first == Filters.FunctionalLocation.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.FunctionalLocation.value
                    }
                }else if first == Filters.Technician.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.Technician.value
                    }
                }else if first == Filters.Equipment.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.Equipment.value
                    }
                }else if first == Filters.PlanningPlant.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.PlanningPlant.value
                    }
                }else if first == Filters.PlannerGroup.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.PlannerGroup.value
                    }
                }else if first == Filters.MaintenancePlant.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.MaintenancePlant.value
                    }
                }else if first == Filters.TechID.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.TechID.value
                    }
                }else if first == Filters.OrderType.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.OrderType.value
                    }
                }else if first == Filters.NotificationType.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.NotificationType.value
                    }
                }else if first == Filters.SystemStatus.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.SystemStatus.value
                    }
                }else if first == Filters.Location.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.Location.value
                    }
                }else if first == Filters.InspectionLot.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.InspectionLot.value
                    }
                }else if first == Filters.CSStatus.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = Filters.CSStatus.value
                    }
                }
                if thirdFilterArr.last == ""{
                    thirdFilterArr.removeLast()
                }
            }
            if let second = FilterDict["Second"]{
                if second == Filters.Priority.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.Priority.value
                    }
                }else if second == Filters.WorkCenter.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.WorkCenter.value
                    }
                }else if second == Filters.UserStatus.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.UserStatus.value
                    }
                }else if second == Filters.Date.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.Date.value
                    }
                }else if second == Filters.MantActivityType.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.MantActivityType.value
                    }
                }else if second == Filters.WorkorderConversion.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.WorkorderConversion.value
                    }
                }else if second == Filters.CreatedOrAssigned.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.CreatedOrAssigned.value
                    }
                }else if second == Filters.ControlKey.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.ControlKey.value
                    }
                }else if second == Filters.Status.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.Status.value
                    }
                }else if second == Filters.FunctionalLocation.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.FunctionalLocation.value
                    }
                }else if second == Filters.Technician.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.Technician.value
                    }
                }else if second == Filters.Equipment.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.Equipment.value
                    }
                }else if second == Filters.PlanningPlant.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.PlanningPlant.value
                    }
                }else if second == Filters.PlannerGroup.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.PlannerGroup.value
                    }
                }else if second == Filters.MaintenancePlant.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.MaintenancePlant.value
                    }
                }else if second == Filters.TechID.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.TechID.value
                    }
                }else if second == Filters.OrderType.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.OrderType.value
                    }
                }else if second == Filters.NotificationType.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.NotificationType.value
                    }
                }else if second == Filters.SystemStatus.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.SystemStatus.value
                    }
                }else if second == Filters.Location.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.Location.value
                    }
                }else if second == Filters.InspectionLot.value{
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.InspectionLot.value
                    }
                }else if second == Filters.CSStatus.value{
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = Filters.CSStatus.value
                    }
                }
                if fourthFilterArr.last == ""{
                    fourthFilterArr.removeLast()
                }
            }
            if header == "WorkOrder"{
                let filterDict = woFilterViewModel.applyWoFilter(firstFilterItem: firstFilterItem, secondFilterItem: secondFilterItem, thirdFilterArr: thirdFilterArr, fourthFilterArr: fourthFilterArr, from: "DB")
                let countarr = filterDict["count"] as? [Int] ?? [Int]()
                let colorArr = filterDict["color"] as? [UIColor] ?? [UIColor]()
                let legendArr = filterDict["legend"] as? [String] ?? [String]()
                self.TotalLabel.text = "Total_Workorders".localized()+": \(allworkorderArray.count)"
                if countarr.count == 0{
                    self.countLabel.text = ""
                    self.colourView.backgroundColor = .clear
                    self.filterTitleLabel.text = ""
                    self.filterNavImage.isHidden = true
                }
                self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
            }else if header == "Operation"{
                let filterDict = oprFilterViewModel.applyOperationFilter(firstFilterItem: firstFilterItem, secondFilterItem: secondFilterItem, thirdFilterArr: thirdFilterArr, fourthFilterArr: fourthFilterArr, from: "DB")
                let countarr = filterDict["count"] as? [Int] ?? [Int]()
                let colorArr = filterDict["color"] as? [UIColor] ?? [UIColor]()
                let legendArr = filterDict["legend"] as? [String] ?? [String]()
                self.TotalLabel.text = "Total_Operations".localized() + ": \(allOperationsArray.count)"
                if countarr.count == 0{
                    self.countLabel.text = ""
                    self.colourView.backgroundColor = .clear
                    self.filterTitleLabel.text = ""
                    self.filterNavImage.isHidden = true
                }
                self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
            }else if header == "Notification"{
                let filterDict = noFilterViewModel.applyNoFilter(firstFilterItem: firstFilterItem, secondFilterItem: secondFilterItem, thirdFilterArr: thirdFilterArr, fourthFilterArr: fourthFilterArr, from: "DB")
                let countarr = filterDict["count"] as? [Int] ?? [Int]()
                let colorArr = filterDict["color"] as? [UIColor] ?? [UIColor]()
                let legendArr = filterDict["legend"] as? [String] ?? [String]()
                self.TotalLabel.text = "Total_Notifications".localized() + ": \(allNotficationArray.count)"
                if countarr.count == 0{
                    self.countLabel.text = ""
                    self.colourView.backgroundColor = .clear
                    self.filterTitleLabel.text = ""
                    self.filterNavImage.isHidden = true
                }
                self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - TableView Delegate and Datasource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedChartArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == currentRow {
            if cellTapped{
                if selectedChartArr[indexPath.row] is NotificationModel{
                    return 225
                }else{
                    return 290
                }
            } else {
                return 145
            }
        }
        return 145
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let cell = ScreenManager.getDBStyle2ListCell(tableView: tableView)
        if let selectedclass = selectedChartArr[indexPath.row] as? WoHeaderModel{
            cell.indexpath = indexPath
            cell.dBVc = self
            cell.detailLabelView.isHidden = false
            cell.dBWorkOrderClass = selectedclass
            return cell
        }else if let  selectedclass = selectedChartArr[indexPath.row] as? WoOperationModel{
            cell.indexpath = indexPath
            cell.dBVc = self
            cell.detailLabelView.isHidden = false
            cell.dBOperationClass = selectedclass
            return cell
        }else if let selectedclass = selectedChartArr[indexPath.row] as? NotificationModel{
            cell.indexpath = indexPath
            cell.dBVc = self
            cell.detailLabelView.isHidden = true
            cell.dBNotificationClass = selectedclass
            return cell
        }
        mJCLogger.log("Ended", Type: "info")
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if let  selectedclass = selectedChartArr[indexPath.row] as? WoHeaderModel{
            self.style2ViewModel.createBatchRequestForTransactionCount(ObjectClass: selectedclass)
        }else if let  selectedclass = selectedChartArr[indexPath.row] as? WoOperationModel{
            self.style2ViewModel.createBatchRequestForTransactionCount(ObjectClass: selectedclass)
        }else if let selectedclass = selectedChartArr[indexPath.row] as? NotificationModel{
            self.style2ViewModel.createBatchRequestForTransactionCount(ObjectClass: selectedclass)
        }
        cellTapped = !cellTapped
        currentRow = indexPath.row
        self.detailsTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    //MARK: - CollectionView Delegate

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return dashBoardArray.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        mJCLogger.log("Starting", Type: "info")
        var cell = DashboardCollectionViewCell()
        if collectionView == collectionView1{
            if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE" || dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell2", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                cell.layer.cornerRadius = 5.0
                cell.layer.borderWidth = 1.0;
                cell.layer.borderColor = UIColor.white.cgColor;
                cell.addButton.imageView?.contentMode = .scaleAspectFit
                cell.workOrderSearchBtn.imageView?.contentMode = .scaleAspectFit
                if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"{
                    cell.TitleLabel.text = "Online_Search".localized()
                    cell.button1ImageView.image = UIImage(named: "wo")
                    cell.addButton.setTitle("Work_Orders_Search".localized(), for: .normal)
                    cell.button2ImageView.image = UIImage(named: "Notifi")
                    cell.workOrderSearchBtn.setTitle("Notifications_Search".localized(), for: .normal)
                    cell.addButton.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                }else if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{
                    cell.TitleLabel.text = "Time_Sheet".localized()
                    cell.button1ImageView.image = UIImage(named: "TimeSheetSM")
                    cell.addButton.setTitle("View_Time_Entries".localized(), for: .normal)
                    cell.button2ImageView.image = UIImage(named: "add_icon")
                    cell.workOrderSearchBtn.setTitle("Add_Time_Entry".localized(), for: .normal)
                    cell.addButton.addTarget(self, action: #selector(self.viewTimeSheetButtonAction(sender:)), for: .touchUpInside)
                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.createTimeSheetButtonAction(sender:)), for: .touchUpInside)
                }

            }else{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell1", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                cell.layer.cornerRadius = 5.0
                cell.layer.borderWidth = 1.0;
                cell.layer.borderColor = UIColor.white.cgColor;

                if dashBoardArray[indexPath.row] == "ASSET_HIERARCHY"{
                    cell.TitleLabel.text = "Hierarchy".localized()
                    cell.centerImage.image = UIImage(named: "asset_hierarchy.png")
                }else if dashBoardArray[indexPath.row] == "DASH_GENERAL_FORM_TILE"{
                    cell.TitleLabel.text = "General_Checklist".localized()
                    cell.centerImage.image = UIImage(named: "document.png")
                }else if dashBoardArray[indexPath.row] == "DASHBOARD_REVIWER_TILE" {
                    cell.TitleLabel.text = "DASHBOARD_REVIWER_TILE".localized()
                    cell.centerImage.image = UIImage(named: "document.png")
                }else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"{
                    cell.TitleLabel.text = "Asset_Map".localized()
                    cell.centerImage.image = UIImage(named: "assetmap.png")
                }
            }
        }else{
            if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlineSearchCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                cell.TitleLabel.text = "OnlineSearch".localized()
                cell.centerImage.image = UIImage(named: "search_icon.png")
//                cell.workOrderSearchBtn.setImage(UIImage(named:"wo.png"), for: .normal)
//                cell.addButton.setImage(UIImage(named:"notifi.png"), for: .normal)
                cell.workOrderSearchBtn.setTitle(" ",for: .normal)
                cell.addButton.setTitle(" ", for: .normal)
                if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_TILE"){
                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                    cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                }
                if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_WO"){
                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                }
                if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_NO"){
                    cell.addButton.addTarget(self, action:#selector(self.searchNotifications(sender:)), for: .touchUpInside)
                }
                return cell
            }else{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                cell.workOrderSearchBtn.isHidden = true
                cell.layer.cornerRadius = 4
                if DeviceType == iPad{
                    cell.AddImage.layer.cornerRadius = 15
                }else{
                    cell.AddImage.layer.cornerRadius = 20
                }
                if dashBoardArray[indexPath.row] == "ASSET_HIERARCHY"{
                    cell.TitleLabel.text = "Hierarchy".localized()
                    cell.centerImage.image = UIImage(named: "asset_hierarchy.png")
                    cell.AddImage.isHidden = true
                    cell.bringSubviewToFront(cell.AddImage)
                    cell.addButton.isHidden = true
                }else if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{
                    cell.TitleLabel.text = "Time_Sheet".localized()
                    cell.addButton.setImage(UIImage.init(named: "add_icon.png"), for: .normal)
                    cell.centerImage.image = UIImage(named: "timesht.png")
                    cell.workOrderSearchBtn.isHidden = true
                    cell.AddImage.isHidden = false
                    cell.bringSubviewToFront(cell.AddImage)
                    cell.addButton.addTarget(self, action: #selector(DashboardStyle2.createTimeSheetButtonAction(sender:)), for: UIControl.Event.touchUpInside)
                }else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"{
                    cell.TitleLabel.text = "Asset_Map".localized()
                    cell.centerImage.image = UIImage(named: "assetmap.png")
                    cell.AddImage.isHidden = true
                    cell.workOrderSearchBtn.isHidden = true
                }else  if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"{
                    cell.TitleLabel.text = "Online_Search".localized()
                    cell.addButton.isHidden = true
                    cell.workOrderSearchBtn.isHidden = true
                    cell.AddImage.isHidden = true
                    cell.centerImage.image = UIImage(named: "searchicon.png")
                    if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_TILE"){
                        cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                        cell.addButton.isHidden = false
                        cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                        cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                        cell.workOrderSearchBtn.isHidden = false
                    }
                    if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_WO"){
                        cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                        cell.addButton.isHidden = false
                    }
                    if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_NO"){
                        cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                        cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                        cell.workOrderSearchBtn.isHidden = false
                    }
                }else  if dashBoardArray[indexPath.row] == "DASH_GENERAL_FORM_TILE"{
                    cell.TitleLabel.text = "General_Checklist".localized()
                    cell.centerImage.image = UIImage(named: "document.png")
                    cell.workOrderSearchBtn.isHidden = true
                    cell.addButton.isHidden = true
                    cell.AddImage.isHidden = true
                }else if dashBoardArray[indexPath.row] == "DASHBOARD_REVIWER_TILE" {
                    cell.TitleLabel.text = "DASHBOARD_REVIWER_TILE".localized()
                    cell.centerImage.image = UIImage(named: "document.png")
                    cell.workOrderSearchBtn.isHidden = true
                    cell.addButton.isHidden = true
                    cell.AddImage.isHidden = true
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

        mJCLogger.log("Starting", Type: "info")
        onlineSearch = Bool()
        if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_TIME", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    currentMasterView = "TimeSheet"
                    if DeviceType == iPad {
                        menuDataModel.uniqueInstance.presentTimeSheetScreen()
                    }else {
                        let rootController = ScreenManager.getDashBoardScreen()
                        let mainViewController = ScreenManager.getTimeSheetScreen()
                        myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_ASSTMAP", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    if DeviceType == iPad{
                        ASSETMAP_TYPE = "ESRIMAP"
                        assetmapVC.openmappage(id: "")
                    }else{
                        ASSETMAP_TYPE = "ESRIMAP"
                        currentMasterView = "WorkOrder"
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                        assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                        self.present(assetMapDeatilsVC, animated: false, completion: nil)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if dashBoardArray[indexPath.row] == "ASSET_HIERARCHY"{
            let assetHierarchyVC = ScreenManager.getAssetHierarchyScreen()
            assetHierarchyVC.modalPresentationStyle = .fullScreen
            self.present(assetHierarchyVC, animated: false, completion: nil)
        }else if dashBoardArray[indexPath.row] == "DASH_GENERAL_FORM_TILE"{
            let generalCheckSheetVC = ScreenManager.getGeneralCheckSheetScreen()
            generalCheckSheetVC.modalPresentationStyle = .fullScreen
            self.present(generalCheckSheetVC, animated: false, completion: nil)
        }else if dashBoardArray[indexPath.row] == "DASHBOARD_REVIWER_TILE"{
            let GeneralFormVC = ScreenManager.getReviewerScreen()
            GeneralFormVC.modalPresentationStyle = .fullScreen
            self.present(GeneralFormVC, animated: false, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        mJCLogger.log("Starting", Type: "info")

        if collectionView == collectionView1{
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
                  let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section),
                  dataSourceCount > 0 else {
                      return .zero
                  }
            let cellCount = CGFloat(dataSourceCount)
            let itemSpacing = flowLayout.minimumInteritemSpacing
            let cellWidth = flowLayout.itemSize.width + itemSpacing
            var insets = flowLayout.sectionInset
            let totalCellWidth = (cellWidth * cellCount) - itemSpacing
            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
            guard totalCellWidth < contentWidth else {
                return insets
            }
            let padding = (contentWidth - totalCellWidth) / 2.0
            insets.left = padding
            insets.right = padding
            mJCLogger.log("Ended", Type: "info")
            return insets
        }else{
            return UIEdgeInsets()
        }

    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if DeviceType == iPhone{
            if screenWidth > 375{
                if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE" || dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"{
                    return CGSize(width: 180, height: 90)
                }else{
                    return CGSize(width: 180, height: 90)
                }
            }else{
                if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE" || dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"{
                    return CGSize(width: 160, height: 90)
                }else{
                    return CGSize(width: 160, height: 90)
                }
            }
        }else{
            return CGSize(width: 200, height: 150)
        }

    }
    //MARK: - Button Actions..
    @IBAction func seachAssestTagButtonAction(_ sender: Any) {
        let searchAssetVC = ScreenManager.searchAssestTagScreen()
        let rootController = ScreenManager.getDashBoardScreen()
        myAssetDataManager.uniqueInstance.pushViewControllerToNavigation(mainController: searchAssetVC, rootController: rootController, menuType: "")
    }
    @IBAction func refreshButtonAction(_ sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func logoutButtonAction(_ sender: AnyObject) {
        self.moreOptionsMenuaction(sender as! UIButton)
    }
    func createchartData(Countarr: Array<Int>,Legendstr: Array<String>,ColorArr: Array<UIColor>,chart:PieChartView){
        mJCLogger.log("Starting", Type: "info")
        var entries = [PieChartDataEntry]()
        if Countarr.count != Legendstr.count{
            return
        }
        if Countarr.count == Legendstr.count {
            for i in 0..<Countarr.count{
                let entry = PieChartDataEntry()
                entry.x = Double(i)
                entry.y = Double(Countarr[i])
                entry.label = Legendstr[i]
                entry.data = Legendstr[i]
                entries.append( entry)
            }
        }
        let set = PieChartDataSet( entries: entries, label: " ")
        set.colors = ColorArr
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1.0
        pFormatter.percentSymbol = ""
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueTextColor(UIColor.white)
        data.setValueFont(UIFont(name: "HelveticaNeue-Bold", size: 14.0)!)
        
        DispatchQueue.main.async{
            chart.noDataText = ""
            chart.data = data
            chart.chartDescription?.enabled = false;
            chart.drawEntryLabelsEnabled = false
            chart.delegate = self
            chart.rotationEnabled = false
            if Countarr.count > 0{
                self.detailsTableView.isHidden = false
            }else{
                chart.clear()
                self.detailsTableView.isHidden = true
            }
            self.setupChartView(chart: chart)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setupChartView(chart:PieChartView){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            var chartLegend = Legend()
            chartLegend = chart.legend
            chartLegend.horizontalAlignment = .right
            chartLegend.verticalAlignment = .center
            chartLegend.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
            chartLegend.textColor =  UIColor(named: "mjcLabelColor") ?? UIColor.blue
            chartLegend.wordWrapEnabled = true
            chartLegend.orientation = .vertical
            chartLegend.drawInside = false
            chart.notifyDataSetChanged()
            chart.highlightValue(x: 0, dataSetIndex: 0)
            chart.holeColor = UIColor(named: "mjcSubViewColorNormal") ?? UIColor.white
            self.listButton.center = chart.centerCircleBox
            self.listButton.isHidden = false
        }
        mJCLoader.stopAnimating()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
        mJCLogger.log("Starting", Type: "info")
        cellTapped = false
        let legend = entry.data as! String
        self.filterTitleLabel.text = legend
        self.filterNavImage.isHidden = false
        if let dataSet = chartView.data?.dataSets[ highlight.dataSetIndex] {
            let Index: Int = dataSet.entryIndex( entry: entry)
            self.colourView.backgroundColor = dataSet.colors[Index]
        }
        if let arr = self.finalFiltervalues[legend]{
            if let header = FilterDict["Header"]{
                if header == "WorkOrder"{
                    self.countLabel.text = "Work_Orders".localized() + " : \(arr.count)"
                }else if header == "Operation"{
                    self.countLabel.text = "Operations".localized() + " : \(arr.count)"
                }else if header == "Notification"{
                    self.countLabel.text = "Notifications".localized() + " : \(arr.count)"
                }
            }
            self.selectedChartArr.removeAll()
            self.selectedChartArr.append(contentsOf: arr)
            if DeviceType == iPhone{
                if selectedChartArr.count == 0 {
                    self.detailsTabelViewHeightConstraint.constant = 0
                }else if selectedChartArr.count == 1{
                    self.detailsTabelViewHeightConstraint.constant = 150
                }else{
                    self.detailsTabelViewHeightConstraint.constant = 300
                }
            }
            self.detailsTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    @objc func searchWorkOrders(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ONLINE_SEARCH", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("search WorkOrders".localized(), Type: "")
                if demoModeEnabled == true{
                    onlineSearch = false
                    mJCLogger.log("We_have_limited_features_enabled_in_Demo_mode".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode".localized(), button: okay)
                }else{
                    DispatchQueue.main.async {
                        onlineSearch = true
                        let onlineSearchVC = ScreenManager.getOnlineSearchScreen()
                        searchType = "WorkOrders"
                        onlineSearchVC.modalPresentationStyle = .fullScreen
                        self.present(onlineSearchVC, animated: false) {}
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func searchNotifications(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_NO_ONLINE_SEARCH", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {

                mJCLogger.log("Search Notifications".localized(), Type: "")
                if demoModeEnabled == true{
                    onlineSearch = false
                    mJCLogger.log("We_have_limited_features_enabled_in_Demo_mode".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode".localized(), button: okay)
                }else{
                    DispatchQueue.main.async {
                        onlineSearch = true
                        let onlineSearchVC = ScreenManager.getOnlineSearchScreen()
                        searchType = "Notifications"
                        onlineSearchVC.modalPresentationStyle = .fullScreen
                        self.present(onlineSearchVC, animated: false) {}
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Button Action Methods
    
    @objc func hierachyButtonTapped(sender : UIButton){
        print("hierachyButtonTapped")
    }
    @objc func assetMapButtonTapped(sender : UIButton){
        menuDataModel.uniqueInstance.presentMapSplitScreen()
    }
    @objc func Centerbuttontapped(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if sender.tag == 1000{
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
            }else{
                let rootController = ScreenManager.getDashBoardScreen()
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
            }
        }else if sender.tag == 1001{
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentListSplitScreen(type: "Notification")
            }else{
                let rootController = ScreenManager.getDashBoardScreen()
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
            }
        }else if sender.tag == 1002{
            if isSupervisor == "X"{
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                currentMasterView = "Supervisor"
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                if DeviceType == iPad{
                    menuDataModel.uniqueInstance.presentSupervisorSplitScreen()
                }else{
                    let rootController = ScreenManager.getDashBoardScreen()
                    let mainViewController = ScreenManager.getSupervisorMasterListScreen()
                    myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                }
            }else{
                mJCLogger.log("User_is_not_Supervisor".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "User_is_not_Supervisor".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func viewTimeSheetButtonAction(sender: UIButton){
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_TIME", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                currentMasterView = "TimeSheet"
                if DeviceType == iPad {
                    menuDataModel.uniqueInstance.presentTimeSheetScreen()
                }else {
                    let rootController = ScreenManager.getDashBoardScreen()
                    let mainViewController = ScreenManager.getTimeSheetScreen()
                    myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
    }
    @objc func createTimeSheetButtonAction(sender : UIButton) {
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_DB_TIME", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateTimeSheetScreen(vc: self, isFromScrn: "AddTimeSheet")
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
    }
    @objc func Addbuttontapped(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if sender.tag == 1000{
            menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", delegateVC: self)
        }else if sender.tag == 1001{
            menuDataModel.presentCreateJobScreen(vc: self, isScreen: "dashboard")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func allListButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let header = FilterDict["Header"]{
            if header == "WorkOrder"{
                filteredWorkorders.removeAll()
                if allworkorderArray.count > 0{
                    if DeviceType == iPad{
                        menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
                    }else{
                        onlineSearch = false
                        currentMasterView = "WorkOrder"
                        let rootController = ScreenManager.getDashBoardScreen()
                        let mainViewController = ScreenManager.getMasterListScreen()
                        myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                    }
                }else{
                    mJCLogger.log("Work_Orders_not_found".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Work_Orders_not_found".localized(), button: okay)
                }
            }else if header == "Operation"{
                filteredOperations.removeAll()
                if allOperationsArray.count > 0{
                    if DeviceType == iPad{
                        menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
                    }else{
                        currentMasterView = "WorkOrder"
                        onlineSearch = false
                        let rootController = ScreenManager.getDashBoardScreen()
                        let mainViewController = ScreenManager.getMasterListScreen()
                        myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                    }
                }else{
                    mJCLogger.log("Work_Orders_not_found".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Work_Orders_not_found".localized(), button: okay)
                }
            }else if header == "Notification"{
                filteredNotifications.removeAll()
                if allNotficationArray.count > 0{
                    if DeviceType == iPad{
                        menuDataModel.uniqueInstance.presentListSplitScreen(type: "Notification")
                    }else{
                        onlineSearch = false
                        currentMasterView = "Notification"
                        let rootController = ScreenManager.getDashBoardScreen()
                        let mainViewController = ScreenManager.getMasterListScreen()
                        myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                    }
                }else{
                    mJCLogger.log("Notifications_Not_Found".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Notifications_Not_Found".localized(), button: okay)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func ActiveButtonAction(_ sender: Any) {
    }
    @IBAction func AddButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let header = FilterDict["Header"]{
            if header == "WorkOrder" || header == "Operation"{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_DB_WO", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", delegateVC: self)
                    }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                        myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                    }else{
                        myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else if header == "Notification"{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_DB_NO", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    workFlowObj.ActionType = "Screen"
                    if workFlowObj.ActionType == "Screen" {
                        menuDataModel.presentCreateJobScreen(vc: self, delegate: true, isScreen: "dashboard")
                    }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                        myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                    }else{
                        myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        self.style2ViewModel.setFilterData()
        mJCLogger.log("Ended", Type: "info")
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if self.refreshButton != nil {
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func filterNavigationButtonAction(_ sender: Any) {

        var filterDict : [String: String] = [:]
        if let header = FilterDict["Header"]{
            filterDict["Header"] = header
        }
        if let firstFilter = FilterDict["First"]{
            filterDict["First"] = firstFilter
        }
        if let firstFilter = FilterDict["Second"]{
            filterDict["Second"] = firstFilter
        }

        if self.filterTitleLabel.text != "" && self.filterTitleLabel.text != nil{
            guard let legend = self.filterTitleLabel.text else { return }

            let titlArr = self.filterTitleLabel.text?.components(separatedBy: " - ")
            if titlArr?.count == 1{
                filterDict["Third"] = titlArr?[0]
            }else if titlArr?.count == 2{
                filterDict["Third"] = titlArr?[0]
                filterDict["Fourth"] = titlArr?[1]
            }
            if let arr = self.finalFiltervalues[legend] as? [WoHeaderModel]{
                filteredWorkorders = arr
            }
            if let arr = self.finalFiltervalues[legend] as? [WoOperationModel]{
                filteredOperations = arr
            }
            if let arr = self.finalFiltervalues[legend] as? [NotificationModel]{
                filteredNotifications = arr
            }
            dashboardFilterDic = filterDict
            if let header = FilterDict["Header"]{
                if header == "WorkOrder" || header == "Operation" {
                    if self.finalFiltervalues.count > 0{
                        mJCLogger.log("Response:\(self.finalFiltervalues.count)", Type: "Debug")
                        if DeviceType == iPad{
                            menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
                        }else{
                            onlineSearch = false
                            currentMasterView = "WorkOrder"
                            let rootController = ScreenManager.getDashBoardScreen()
                            let mainViewController = ScreenManager.getMasterListScreen()
                            myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                        }
                    }else{
                        mJCLogger.log("Work_Orders_not_found".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Work_Orders_not_found".localized(), button: okay)
                    }
                }else if header == "Notification"{
                    if self.finalFiltervalues.count > 0{
                        mJCLogger.log("Response:\(self.finalFiltervalues.count)", Type: "Debug")
                        if DeviceType == iPad{
                            menuDataModel.uniqueInstance.presentListSplitScreen(type: "Notification")
                        }else{
                            onlineSearch = false
                            currentMasterView = "Notification"
                            let rootController = ScreenManager.getDashBoardScreen()
                            let mainViewController = ScreenManager.getMasterListScreen()
                            myAssetDataManager.uniqueInstance.addingViewControllerAsChildToNavigationController(mainController: mainViewController, rootController: rootController, menuType: "Main")
                        }
                    }else{
                        mJCLogger.log("Notifications_Not_Found".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Notifications_Not_Found".localized(), button: okay)
                    }
                }
            }
        }else{
            return
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func createFwLogsShareBtn(){
        let btn:UIButton = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.frame = CGRect(x: 0, y: (newpieChartView.frame.origin.y + newpieChartView.frame.size.height - 40), width:40, height: 40)
        newpieChartView.addSubview(btn)
        btn.addTarget(self, action: #selector(shareFwLogsAction), for: UIControl.Event.touchUpInside)
        
    }

    @objc func shareFwLogsAction(){
        shareLogs(fwLogs:true)
    }
    
    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        menuDataModel.presentCreateJobScreen(vc: self, delegate: true)
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.refreshButtonAction(sender!)
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let dashboard = ScreenManager.getDashBoardScreen()
        let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
        nvc.isNavigationBarHidden = true
        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
        myAssetDataManager.uniqueInstance.navigationController = nvc
        self.logoutButtonAction(sender!)
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }
    @IBAction func thirdDropDownfuncLocBarcodeScanButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "dashboars", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func fourthDropDownfuncLocBarcodeScanButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "dashboars", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if typeOfScanCode == "firstFunctionalLocation" || typeOfScanCode == "firstEquipment" {
                self.thirdDropDownTxtField.text = barCode
            }else if typeOfScanCode == "secondFunctionalLocation" ||  typeOfScanCode == "secondEquipment" {
                self.fourthDropDownTxtField.text = barCode
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

