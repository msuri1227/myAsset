//
//  ReviewerVC.swift
//  myJobCard
//
//  Created by Khaleel on 14/07/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class ReviewerVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var reviewerCheckSheetView: UIView!
    @IBOutlet var reviewerCheckSheetTable: UITableView!
    @IBOutlet var reviewerCheckSheetDataLabel: UILabel!
    @IBOutlet weak var reviewerCheckSheetSearchView: UIView!
    @IBOutlet weak var reviewerCheckSheetSearchInView: UIView!
    @IBOutlet weak var reviewerCheckSheetSearchButton: UIButton!
    @IBOutlet var reviewerCheckSheetSearchField: UISearchBar!
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var checkSheetReviewBgView: UIView!
    @IBOutlet weak var checkSheetReviewView: UIView!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var correctionRequiredButton: UIButton!
    @IBOutlet weak var remarksTextView: UITextView!
    @IBOutlet var correctionRequiredButtonHightConstraints: NSLayoutConstraint!

    @IBOutlet weak var checkSheetRemarksBgView: UIView!
    @IBOutlet weak var checkSheetRemarksView: UIView!
    @IBOutlet weak var reviewerRemarksTable: UITableView!
    @IBOutlet weak var cancelButton: UIButton!


    var reviewerViewModel = ReviewerListViewModel()
    var reviewerRespArr = [FormReviewerResponseModel]()
    var mainReviewerRespArr = [FormReviewerResponseModel]()
    var approverRespObj = FormResponseApprovalStatusModel()
    var approverRespArr = [FormResponseApprovalStatusModel]()


    //MARK:- Lifecycle..
    override func viewDidLoad() {

        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        reviewerViewModel.reviewerVC = self
        self.reviewerCheckSheetSearchView.layer.borderWidth = 1.0
        self.reviewerCheckSheetSearchView.layer.borderColor = UIColor.lightGray.cgColor
        self.reviewerCheckSheetSearchView.layer.masksToBounds = true
        self.reviewerCheckSheetTable.estimatedRowHeight = 180
        self.setRemarksViewLayout()
        self.checkSheetReviewBgView.isHidden = true
        self.checkSheetRemarksBgView.isHidden = true
        ScreenManager.registerReviewerCell(tableView: self.reviewerCheckSheetTable)
        mJCLogger.log("Ended", Type: "info")
        self.reviewerViewModel.getRevieweList()
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUI(){
        DispatchQueue.main.async {
            if self.reviewerRespArr.count > 0{
                self.reviewerCheckSheetView.isHidden = false
                self.reviewerCheckSheetDataLabel.isHidden = true
                self.reviewerCheckSheetTable.reloadData()
            }else{
                self.reviewerCheckSheetView.isHidden = true
                self.reviewerCheckSheetDataLabel.isHidden = false
            }
        }
    }
    func updateApprroveRejectView(){
        if approverRespObj.FormID == "" && approverRespObj.FormInstanceID == ""{
            DispatchQueue.main.async {
                self.checkSheetReviewBgView.isHidden = false
                self.correctionRequiredButtonHightConstraints.constant = 0.0
                self.correctionRequiredButton.isHidden = true
            }
        }else{
            DispatchQueue.main.async {
                self.checkSheetReviewBgView.isHidden = false
                self.remarksTextView.text = self.approverRespObj.Remarks
                if self.approverRespObj.FormContentStatus == "REJECT"{
                    self.rejectButton.isSelected = true
                    self.approveButton.isEnabled = false
                    self.correctionRequiredButton.isHidden = false
                    self.correctionRequiredButtonHightConstraints.constant = 30.0
                    if self.approverRespObj.IterationRequired == "X"{
                        self.correctionRequiredButton.isSelected = true
                    }else{
                        self.correctionRequiredButton.isSelected = false
                    }
                }else if self.approverRespObj.FormContentStatus == "APPROVE"{
                    self.approveButton.isSelected = true
                    self.rejectButton.isHidden = true
                    self.correctionRequiredButton.isHidden = true
                    self.correctionRequiredButtonHightConstraints.constant = 0.0
                }
            }
        }
    }
    func updateRemarksListView(){
        DispatchQueue.main.async {
            self.checkSheetRemarksBgView.isHidden = false
            self.reviewerRemarksTable.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setRemarksViewLayout() {
        ODSUIHelper.setBorderToView(view:self.remarksTextView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.remarksTextView.layer.borderWidth = 2.0
        self.remarksTextView.layer.masksToBounds = true
    }
    //MARK:- Tableview Delegate & DataSource....
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == reviewerCheckSheetTable{
            return self.reviewerRespArr.count
        }else{
            return self.approverRespArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if tableView == reviewerCheckSheetTable{
            let reviewerCell = ScreenManager.getReviewerCell(tableView: tableView)
            reviewerCell.reviewerViewModel = reviewerViewModel
            let reviewerClass = self.reviewerRespArr[indexPath.row]
            reviewerCell.indexpath = indexPath
            reviewerCell.reviewerCellModel = reviewerClass
            return reviewerCell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if(cell != nil){
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            }
            let statusCls = self.approverRespArr[indexPath.row]
            var date = String()
            if statusCls.CreatedDate != nil{
                date = statusCls.CreatedDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: statusCls.CreatedTime)
            let str = "\(statusCls.FormContentStatus) by \(statusCls.ApproverID) on \(date) \(time) with remarks : \(statusCls.Remarks)"
            cell!.textLabel?.numberOfLines = 0
            cell!.textLabel?.text = str
            return cell!
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == reviewerCheckSheetTable{
            if DeviceType == iPad{
                return 180
            }else{
                return UITableView.automaticDimension
            }
        }else{
            return UITableView.automaticDimension
        }
    }
    @IBAction func searchButtonAction(_ sender: Any) {
        
    }
    //MARK:-  Search Bar delegate..
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        mJCLogger.log("Starting", Type: "info")
        self.reviewerCheckSheetSearchField.endEditing(true)
        mJCLogger.log("Ended", Type: "info")
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){

        mJCLogger.log("Starting", Type: "info")
        
        if searchText != "" {
            let filterArray = self.mainReviewerRespArr.filter{$0.FormID.contains(find: "\(searchText)")}
            if filterArray.count > 0 {
                self.reviewerRespArr.removeAll()
                self.reviewerRespArr.append(contentsOf: filterArray)
            }else{
                self.reviewerRespArr.removeAll()
                self.reviewerRespArr.append(contentsOf: self.mainReviewerRespArr)
            }
        }else {
            self.reviewerRespArr.removeAll()
            self.reviewerRespArr.append(contentsOf: self.mainReviewerRespArr)
        }
        DispatchQueue.main.async{
            self.reviewerCheckSheetTable.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func approveButtonAction(_ sender: UIButton) {
        self.approveButton.isSelected = !self.approveButton.isSelected
        if self.approveButton.isSelected{
            self.rejectButton.isSelected = !self.approveButton.isSelected
            self.correctionRequiredButton.isSelected = false
            self.correctionRequiredButton.isHidden = true
            self.correctionRequiredButtonHightConstraints.constant = 0.0
        }
    }
    @IBAction func rejectButtonAction(_ sender: UIButton) {
        self.rejectButton.isSelected = !self.rejectButton.isSelected
        if self.rejectButton.isSelected{
            self.approveButton.isSelected = !self.rejectButton.isSelected
            self.correctionRequiredButton.isSelected = true
            self.correctionRequiredButton.isHidden = false
            self.correctionRequiredButtonHightConstraints.constant =  30.0
        }
    }
    @IBAction func correctionRequiredButtonAction(_ sender: UIButton) {
        self.correctionRequiredButton.isSelected = !self.correctionRequiredButton.isSelected
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        if approverRespObj.FormID == "" && approverRespObj.FormInstanceID == ""{
            if self.approveButton.isSelected == false && self.rejectButton.isSelected == false{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please select status", button: okay)
            }else if self.remarksTextView.text == "" && self.rejectButton.isSelected == true{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please enter remarks", button: okay)
            }else{
                self.reviewerViewModel.createApproverStatus()
            }
        }else{
            if self.remarksTextView.text == ""{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please enter remarks", button: okay)
            }else{
                self.reviewerViewModel.updateApproverStatus()
            }
        }
    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.checkSheetReviewBgView.isHidden = true
        approveButton.isSelected = false
        rejectButton.isSelected = false
        correctionRequiredButton.isSelected = false
        remarksTextView.text = ""
    }
    @IBAction func remarksCancelButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.checkSheetRemarksBgView.isHidden = true
        }
    }
    func getPreviewCheckSheet(index:Int) {
        let newformsVC = ScreenManager.getCheckSheetViewerScreen()
        newformsVC.reviewerFormResponseClass = self.reviewerRespArr[index]
        newformsVC.isFromEditScreen = true
        newformsVC.fromScreen = "Reviewer"
        newformsVC.modalPresentationStyle = .fullScreen
        self.present(newformsVC, animated: false) {}
    }
    //...End...//
}

