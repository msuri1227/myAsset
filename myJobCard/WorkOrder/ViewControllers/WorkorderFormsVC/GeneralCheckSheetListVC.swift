//
//  GeneralFormVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 06/08/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class GeneralCheckSheetListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CustomNavigationBarDelegate,viewModelDelegate,CreateUpdateDelegate{
    
    @IBOutlet weak var noDataFilledForms: UILabel!
    @IBOutlet weak var filledFormsTableView: UITableView!
    @IBOutlet weak var noDataFormTemplate: UILabel!
    @IBOutlet weak var formTemplateTableView: UITableView!
    @IBOutlet weak var filledFormsView: UIView!
    @IBOutlet weak var formTemplateView: UIView!
    @IBOutlet weak var addNewJobButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var formNameLabel: UILabel!
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var FromssegmentControl: UISegmentedControl!

    @IBOutlet weak var templateCheckSheetSearch: UIView!
    @IBOutlet weak var templateCheckSheetSearchInView: UIView!
    @IBOutlet weak var templateCheckSheetSearchButton: UIButton!
    @IBOutlet weak var templateCheckSheetSearchField: UISearchBar!
    
    @IBOutlet weak var submittedCheckSheetSearchView: UIView!
    @IBOutlet weak var submittedCheckSheetSearchInView: UIView!
    @IBOutlet weak var submittedCheckSheetSearchButton: UIButton!
    @IBOutlet weak var submittedCheckSheetSearchField: UISearchBar!

    var checkSheetVM = checkSheetViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkSheetVM.delegate = self
        checkSheetVM.userID = strUser.uppercased()
        templateCheckSheetSearchField.barTintColor = UIColor(named: "mjcViewBgColor")
        submittedCheckSheetSearchField.barTintColor = UIColor(named: "mjcViewBgColor")
        if DeviceType == iPhone{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "General_Checklist".localized() , NewJobButton: false, refresButton: true, threedotmenu: false,leftMenuType:"Back")
            FromssegmentControl.setTitle("Template".localized(), forSegmentAt: 0)
            FromssegmentControl.setTitle("Submitted".localized(), forSegmentAt: 1)
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }
        formTemplateTableView.estimatedRowHeight = 80.0
        filledFormsTableView.estimatedRowHeight = 80.0
        self.formTemplateTableView.dataSource = self
        self.formTemplateTableView.delegate = self
        self.filledFormsTableView.dataSource = self
        self.filledFormsTableView.delegate = self
        if DeviceType == iPhone{
            FromssegmentControl.selectedSegmentIndex = 0
            self.formTemplateView.isHidden = false
            self.filledFormsView.isHidden = true
        }
        ScreenManager.registerFormTableViewCell(tableView: self.formTemplateTableView)
        ScreenManager.registerFormTableViewCell(tableView: self.filledFormsTableView)
        self.noDataFormTemplate.isHidden = false
        self.noDataFilledForms.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        checkSheetVM.getGeneralCheckSheetDataBatchRequest()
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "GeneralCheckSheetList"{
            DispatchQueue.main.async{
                if self.checkSheetVM.generalFormArray.count > 0 {
                    self.noDataFormTemplate.isHidden = true
                    self.formTemplateTableView.reloadData()
                }else{
                    self.noDataFormTemplate.isHidden = false
                }
                if self.checkSheetVM.generalFormRespArray.count > 0 {
                    let uniq = Array(Set(self.checkSheetVM.generalFormRespArray))
                    self.checkSheetVM.generalFormRespArray.removeAll()
                    self.checkSheetVM.generalFormRespArray = uniq
                    self.filledFormsTableView.reloadData()
                    self.noDataFilledForms.isHidden = true
                }else{
                    self.noDataFilledForms.isHidden = false
                }
            }
        }
    }
    //MARK: - Tableview Delegate & DataSource....
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == formTemplateTableView{
            return self.checkSheetVM.generalFormArray.count
        }else{
            return self.checkSheetVM.generalFilledFormArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")

        if tableView == formTemplateTableView{
            let formTableviewCell  = ScreenManager.getFormTableViewCell(tableView: formTemplateTableView)
            formTableviewCell.generalCheckSheetVC = self
            formTableviewCell.indexpath = indexPath
            formTableviewCell.fromStr = "FORM_TEMPLATE"
            formTableviewCell.generalFormModelCellModel = self.checkSheetVM.generalFormArray[indexPath.row]
            return formTableviewCell
        }else{
            let formTableviewCell  = ScreenManager.getFormTableViewCell(tableView: filledFormsTableView)
            formTableviewCell.generalCheckSheetVC = self
            formTableviewCell.indexpath = indexPath
            formTableviewCell.fromStr = "FILLED_FORM"
            formTableviewCell.generalFormModelCellModel = self.checkSheetVM.generalFilledFormArray[indexPath.row]
           return formTableviewCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK:- Form Cell Button Action..
    @IBAction func searchButtonAction(_ sender: Any) {}
    func createNewGeneralCheckSheet(index: Int)  {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.checkSheetVM.generalFormArray.indices.contains(index){
                let FormDataModel = self.checkSheetVM.generalFormArray[index]
                let newformsVC = ScreenManager.getCheckSheetViewerScreen()
                newformsVC.formClass = FormDataModel
                newformsVC.fromScreen = "GeneralCheckList"
                newformsVC.createUpdateDelegate = self
                newformsVC.modalPresentationStyle = .fullScreen
                self.present(newformsVC, animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getFilledChecksheetData(index: Int) {
        if checkSheetVM.generalFilledFormArray.indices.contains(index){
            let FormDataModel = checkSheetVM.generalFilledFormArray[index]
            if(FormDataModel.filledFormCount > 0) {
                let filledCSVC = ScreenManager.getFilledCheckSheetListScreen()
                filledCSVC.filledCheckSheetList = self.checkSheetVM.generalFormRespArray.filter{$0.FormID == "\(FormDataModel.FormID)" && $0.Version == "\(FormDataModel.Version)"}
                filledCSVC.selectedCheckSheet = FormDataModel
                filledCSVC.isFrom = "GeneralCheckList"
                filledCSVC.modalPresentationStyle = .fullScreen
                self.present(filledCSVC, animated: false, completion: {})
            }
        }
    }
    //MARK: -  Search Bar delegate..
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        var filteredArray = [FormAssignDataModel]()
        if searchBar == templateCheckSheetSearchField{
            if(searchText == "") {
                self.templateCheckSheetSearchField.endEditing(true)
                self.templateCheckSheetSearchField.becomeFirstResponder()
            }else{
                filteredArray = checkSheetVM.generalFormListArray.filter { $0.FormID.localizedCaseInsensitiveContains(searchText) }
            }
            checkSheetVM.generalFormArray.removeAll()
            if filteredArray.count > 0 {
                checkSheetVM.generalFormArray.append(contentsOf: filteredArray)
            }else{
                checkSheetVM.generalFormArray.append(contentsOf: checkSheetVM.generalFormListArray)
            }
            DispatchQueue.main.async{
                self.formTemplateTableView.reloadData()
            }
        }else if searchBar == submittedCheckSheetSearchField{
            if(searchText == "") {
                self.submittedCheckSheetSearchField.endEditing(true)
                self.submittedCheckSheetSearchField.becomeFirstResponder()
            }else{
                filteredArray = checkSheetVM.generalFilledFormListArray.filter { $0.FormID.localizedCaseInsensitiveContains(searchText)}
            }
            checkSheetVM.generalFilledFormArray.removeAll()
            if filteredArray.count > 0 {
                checkSheetVM.generalFilledFormArray.append(contentsOf: filteredArray)
            }else{
                checkSheetVM.generalFilledFormArray.append(contentsOf: checkSheetVM.generalFilledFormListArray)
            }
            DispatchQueue.main.async{
                self.filledFormsTableView.reloadData()
            }
        }
    }
    func EntityCreated() {
        checkSheetVM.getGeneralCheckSheetDataBatchRequest()
    }
    //MARK: - iPhone Methods
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func homeButtonAction(_ sender: Any) {}
    @IBAction func addNewJobButtonAction(_ sender: Any) {}
    @IBAction func syncButtonAction(_ sender: Any) {}
    @IBAction func moreButtonAction(_ sender: Any) {}
    @IBAction func segmentAction(_ sender: Any) {
        if FromssegmentControl.selectedSegmentIndex == 0 {
            FromssegmentControl.setTitle("Template".localized(), forSegmentAt: 0)
            self.formTemplateView.isHidden = false
            self.filledFormsView.isHidden = true
        }else if FromssegmentControl.selectedSegmentIndex == 1 {
            FromssegmentControl.setTitle("Submitted".localized(), forSegmentAt: 1)
            self.formTemplateView.isHidden = true
            self.filledFormsView.isHidden = false
        }
    }
    func leftMenuButtonClicked(_ sender: UIButton?){
        if sender?.imageView?.image == UIImage.init(named: "backButton") {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
    }
}
