//
//  CheckSheetListVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/14/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, CreateUpdateDelegate,viewModelDelegate{

    //MARK:- Outlets..
    @IBOutlet var predefinedCheckSheetView: UIView!
    @IBOutlet var predefinedCheckSheetTable: UITableView!
    @IBOutlet var predefinedCheckSheetDataLabel: UILabel!

    @IBOutlet weak var predefinedCheckSheetSearchView: UIView!
    @IBOutlet weak var predefinedCheckSheetSearchInView: UIView!
    @IBOutlet weak var predefinedCheckSheetSearchButton: UIButton!
    @IBOutlet var predefinedCheckSheetSearchField: UISearchBar!
    
    @IBOutlet var manualCheckSheetView: UIView!
    @IBOutlet var manualCheckSheetTable: UITableView!
    @IBOutlet var manualCheckSheetDataLabel: UILabel!

    @IBOutlet weak var manualCheckSheetSearchView: UIView!
    @IBOutlet weak var manualCheckSheetSearchInView: UIView!
    @IBOutlet weak var manualCheckSheetSearchButton: UIButton!
    @IBOutlet weak var manualCheckSheetSearchField: UISearchBar!

    @IBOutlet var checkSheetSegment: UISegmentedControl!
    @IBOutlet var predefinedCheckSheetHeaderViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var checkSheetSegViewHeightConst: UIView!
    @IBOutlet var manualCheckSheetHeaderViewHeightConstant: NSLayoutConstraint!
    @IBOutlet var checkSheetSegmentHeightConstant: NSLayoutConstraint!

    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var formApprovalViewModel = CheckSheetApprovalViewModel()
    var checkSheetVM = checkSheetViewModel()

    //MARK:- Lifecycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        checkSheetVM.delegate = self
        checkSheetVM.woObj = singleWorkOrder
        checkSheetVM.oprObj  = singleOperation
        checkSheetVM.formAssignmentType = FORM_ASSIGNMENT_TYPE
        checkSheetVM.woAssigmentType = WORKORDER_ASSIGNMENT_TYPE
        checkSheetVM.userID = strUser.uppercased()
        predefinedCheckSheetSearchField.setImage(UIImage(), for: .search, state: .normal)
        predefinedCheckSheetSearchField.compatibleSearchTextField.backgroundColor = UIColor.white
        if DeviceType == iPhone{
            var title = String()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title =  "\(singleOperation.WorkOrderNum)"+"/"+"\(singleOperation.OperationNum)"
            }else{
                title = "\(singleWorkOrder.WorkOrderNum)"
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
        }else{
            NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        }
        self.setBasicView()
        predefinedCheckSheetTable.delegate = self
        predefinedCheckSheetTable.dataSource = self
        manualCheckSheetTable.delegate = self
        manualCheckSheetTable.dataSource = self
        self.manualCheckSheetTable.estimatedRowHeight = 130
        self.predefinedCheckSheetTable.estimatedRowHeight = 130
        ScreenManager.registerFormTableViewCell(tableView: self.predefinedCheckSheetTable)
        ScreenManager.registerFormTableViewCell(tableView: self.manualCheckSheetTable)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        self.objectSelected()
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setBasicView(){
        if FORM_ASSIGNMENT_TYPE == "1" || FORM_ASSIGNMENT_TYPE == "2" || FORM_ASSIGNMENT_TYPE == "3" || FORM_ASSIGNMENT_TYPE == "4" || FORM_ASSIGNMENT_TYPE == "5"{
            if DeviceType == iPad{
                predefinedCheckSheetHeaderViewHeightConstant.constant = 0
                manualCheckSheetView.isHidden = true
            }else{
                self.predefinedCheckSheetView.isHidden = false
                self.manualCheckSheetView.isHidden = true
                self.checkSheetSegmentHeightConstant.constant = 0
            }
            self.predefinedCheckSheetSearchInView.layer.borderColor = UIColor.lightGray.cgColor
            self.predefinedCheckSheetSearchInView.layer.borderWidth = 1.0
            predefinedCheckSheetSearchField.compatibleSearchTextField.backgroundColor = UIColor.white
            predefinedCheckSheetSearchField.setImage(UIImage(), for: .search, state: .normal)
            predefinedCheckSheetSearchField.barTintColor = UIColor(named: "mjcViewBgColor")
        }else if FORM_ASSIGNMENT_TYPE == "6" || FORM_ASSIGNMENT_TYPE == "7" || FORM_ASSIGNMENT_TYPE == "8" || FORM_ASSIGNMENT_TYPE == "9" {
            formApprovalViewModel.getCheckApproverList(from: "")
            formApprovalViewModel.getCheckSheetList()
            if DeviceType == iPad{
                manualCheckSheetHeaderViewHeightConstant.constant = 0
                predefinedCheckSheetView.isHidden = true
            }else{
                self.manualCheckSheetView.isHidden = false
                self.predefinedCheckSheetView.isHidden = true
                self.checkSheetSegmentHeightConstant.constant = 0
            }
            self.manualCheckSheetSearchInView.layer.borderColor = UIColor.lightGray.cgColor
            self.manualCheckSheetSearchInView.layer.borderWidth = 1.0
            manualCheckSheetSearchField.compatibleSearchTextField.backgroundColor = UIColor.white
            manualCheckSheetSearchField.setImage(UIImage(), for: .search, state: .normal)
            manualCheckSheetSearchField.barTintColor = UIColor(named: "mjcViewBgColor")
        }else{
            if DeviceType == iPhone{
                checkSheetSegment.setTitle("Pre_Define_Assigment".localized(), forSegmentAt: 0)
                checkSheetSegment.setTitle("Manual_Assigment".localized(), forSegmentAt: 1)
                self.checkSheetSegment.selectedSegmentIndex = 0
                self.manualCheckSheetView.isHidden = true
            }
        }
    }
    //MARK: viewModelDelegate
    @objc func objectSelected(){
        checkSheetVM.getPredefinedCheckSheetDataWithBatchRequest()
    }
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "CheckSheetList"{
            DispatchQueue.main.async {
                if self.checkSheetVM.predefinedFormArray.count > 0{
                    self.predefinedCheckSheetTable.reloadData()
                    self.predefinedCheckSheetTable.isHidden = false
                    self.predefinedCheckSheetDataLabel.isHidden = true
                }else{
                    self.predefinedCheckSheetTable.isHidden = true
                    self.predefinedCheckSheetDataLabel.isHidden = false
                }
                if self.checkSheetVM.manualFormArray.count > 0{
                    self.manualCheckSheetTable.reloadData()
                    self.manualCheckSheetTable.isHidden = false
                    self.manualCheckSheetDataLabel.isHidden = true
                }else{
                    self.manualCheckSheetTable.isHidden = true
                    self.manualCheckSheetDataLabel.isHidden = false
                }
            }
        }
    }
    func EntityCreated() {
        self.objectSelected()
    }
    //MARK: - Tableview Delegate & DataSource....
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == predefinedCheckSheetTable{
            return checkSheetVM.predefinedFormArray.count
        }else{
            return checkSheetVM.manualFormArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let formTableviewCell  = ScreenManager.getFormTableViewCell(tableView: tableView)
        formTableviewCell.checkSheetListVC = self
        formTableviewCell.indexpath = indexPath
        if tableView == predefinedCheckSheetTable{
            formTableviewCell.predefinedCheckSheetCellModel = checkSheetVM.predefinedFormArray[indexPath.row]
        }else if tableView == manualCheckSheetTable{
            formTableviewCell.isFromManual = true
            formTableviewCell.manulCheckSheetCellModel = checkSheetVM.manualFormArray[indexPath.row]
        }
        formTableviewCell.formApprovalViewModel = self.formApprovalViewModel
        mJCLogger.log("Ended", Type: "info")
        return formTableviewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK: - Cell Button Action..

    func formTableViewCellButtonAction(tagValue: Int,from:String) {
        if isActiveWorkOrder == true{
            if from == "preDefined"{
                if checkSheetVM.predefinedFormArray.indices.contains(tagValue){
                    let cheeckSheet = checkSheetVM.predefinedFormArray[tagValue]
                    if cheeckSheet.filledFormCount > 0{
                        let filledCSVC = ScreenManager.getFilledCheckSheetListScreen()
                        let filledCheckList = checkSheetVM.predefinedRespArray.filter{$0.FormID == "\(cheeckSheet.FormID)" && $0.Version == "\(cheeckSheet.Version)"}
                        filledCSVC.filledCheckSheetList = filledCheckList
                        filledCSVC.createUpdateDelegate = self
                        filledCSVC.selectedCheckSheet = cheeckSheet
                        filledCSVC.isFrom = "preDefined"
                        filledCSVC.modalPresentationStyle = .fullScreen
                        self.present(filledCSVC, animated: false, completion: {})
                    }else if cheeckSheet.MultipleSub == "X" || Int(cheeckSheet.Occur) ?? 0 > 0 {
                        menuDataModel.uniqueInstance.presentCheckSheetViewerScreen(vc: self, delegateVC: self, formCls: cheeckSheet)
                    }
                }
            }else if from == "manual"{
                if checkSheetVM.manualFormArray.indices.contains(tagValue){
                    let cheeckSheet = checkSheetVM.manualFormArray[tagValue]
                    if cheeckSheet.filledFormCount > 0{
                        let filledCSVC = ScreenManager.getFilledCheckSheetListScreen()
                        let filledCheckList = checkSheetVM.manualRespArray.filter{$0.FormID == "\(cheeckSheet.FormID)" && $0.Version == "\(cheeckSheet.Version)"}
                        filledCSVC.filledCheckSheetList = filledCheckList
                        filledCSVC.selectedCheckSheet = cheeckSheet
                        filledCSVC.createUpdateDelegate = self
                        filledCSVC.isFrom = "manual"
                        filledCSVC.modalPresentationStyle = .fullScreen
                        self.present(filledCSVC, animated: false, completion: {})
                    }else if cheeckSheet.MultipleSub == "X" || Int(cheeckSheet.Occur) ?? 0 > 0 {
                        menuDataModel.uniqueInstance.presentCheckSheetViewerScreen(vc: self, delegateVC: self, formCls: cheeckSheet)
                    }
                }
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func searchButtonAction(_ sender: Any) {}
    //MARK: -  Search Bar delegate..
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){}
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        if searchBar == predefinedCheckSheetSearchField{
            checkSheetVM.predefinedFormArray.removeAll()
            var filteredArray = [FormAssignDataModel]()
            if(searchText == "") {
                self.predefinedCheckSheetSearchField.endEditing(true)
                self.predefinedCheckSheetSearchField.becomeFirstResponder()
            }else{
                filteredArray = checkSheetVM.predefinedFormListArray.filter{$0.FormID.containsIgnoringCase(find: "\(searchText)")}
            }
            if filteredArray.count > 0 {
                checkSheetVM.predefinedFormArray.append(contentsOf: filteredArray)
            }else{
                checkSheetVM.predefinedFormArray.append(contentsOf: self.checkSheetVM.predefinedFormListArray)
            }
            DispatchQueue.main.async{
                self.predefinedCheckSheetTable.reloadData()
            }
        }else if searchBar == manualCheckSheetSearchField{
            var filteredArray = [FormAssignDataModel]()
            checkSheetVM.manualFormArray.removeAll()
            if(searchText == "") {
                self.manualCheckSheetSearchField.endEditing(true)
                self.manualCheckSheetSearchField.becomeFirstResponder()
            }else{
                filteredArray = checkSheetVM.manualFormListArray.filter{$0.FormID.containsIgnoringCase(find: "\(searchText)")}
            }
            if filteredArray.count > 0 {
                checkSheetVM.manualFormArray.append(contentsOf: filteredArray)
            }else{
                checkSheetVM.manualFormArray.append(contentsOf: self.checkSheetVM.manualFormListArray)
            }
            DispatchQueue.main.async{
                self.predefinedCheckSheetTable.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - iPhone Methods
    @IBAction func chekSheetSegmentChanged(_ sender: Any) {
        if self.checkSheetSegment.selectedSegmentIndex == 0{
            self.predefinedCheckSheetView.isHidden = false
            self.manualCheckSheetView.isHidden = true
        }else if self.checkSheetSegment.selectedSegmentIndex == 1{
            self.manualCheckSheetView.isHidden = false
            self.predefinedCheckSheetView.isHidden = true
        }
    }
    //...End...//
}
