//
//  FormApprovalVC.swift
//  myJobCard
//
//  Created by Ruby's Mac on 03/06/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class FormApprovalVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,checkSheetSelectionDelegate,UISearchBarDelegate{
    
    @IBOutlet var formsApprovalTableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet var totalChecksheet: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextField: UISearchBar!
    
    @IBOutlet var searchView: UIView!
    var formApprovalViewModel =  CheckSheetApprovalViewModel()
    var totalCheckSheetArray = [FormAssignDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchView.layer.cornerRadius = 3.0
        self.searchView.layer.borderWidth = 1.0
        self.searchView.layer.borderColor = UIColor.lightGray.cgColor
        self.searchView.layer.masksToBounds = true

        self.formApprovalViewModel.formApprovalVC = self
        self.formApprovalViewModel.getCheckApproverList(from: "Approver")
        self.formApprovalViewModel.getCheckSheetList()

        self.searchTextField.delegate = self
        ScreenManager.registerFormTableViewCell(tableView: self.formsApprovalTableView)
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    @IBAction func searchButtonAction(_ sender: Any) {}
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalCheckSheetArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let formTableviewCell = ScreenManager.getFormTableViewCell(tableView: tableView)
        formTableviewCell.indexpath = indexPath
        formTableviewCell.formApprovalViewModel = formApprovalViewModel
        formTableviewCell.isFromApproval = true
        if totalCheckSheetArray.count > 0{
            formTableviewCell.approvalCheckSheetCellModel = totalCheckSheetArray[indexPath.row]
        }
        mJCLogger.log("Ended", Type: "info")
        return formTableviewCell
    }
    
    func updateUI(){
        if self.formApprovalViewModel.manualCheckSheetListArray.count > 0{
            totalCheckSheetArray.append(contentsOf: self.formApprovalViewModel.manualCheckSheetListArray)
        }
        if self.formApprovalViewModel.predefinedFormArray.count > 0{
            totalCheckSheetArray.append(contentsOf: self.formApprovalViewModel.predefinedFormArray)
        }
        DispatchQueue.main.async {
            if self.totalCheckSheetArray.count > 0{
                self.totalChecksheet.text = "Total_Checksheet".localized() +  " : "
                + "\(self.totalCheckSheetArray.count)"
                self.formsApprovalTableView.reloadData()
                self.noDataLabel.isHidden = true
            }else{
                self.totalChecksheet.text = "Total_Checksheet".localized() +  " : "
                + "0"
                self.formsApprovalTableView.reloadData()
                self.noDataLabel.isHidden = false
            }
        }
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        mJCLogger.log("Starting", Type: "info")
        if searchBar == searchTextField{
            if(searchText == "") {
                self.searchTextField.endEditing(true)
                self.searchTextField.becomeFirstResponder()
            }
            mJCLogger.log("Response :\(self.totalCheckSheetArray.count)", Type: "Debug")
            let filteredArray = self.totalCheckSheetArray.filter{($0 as AnyObject).FormID.contains(find: "\(searchText)")}
            mJCLogger.log("Response :\(filteredArray.count)", Type: "Debug")
            
            if filteredArray.count > 0 {
                self.totalCheckSheetArray.removeAll()
                self.totalCheckSheetArray.append(contentsOf: filteredArray)
            }else{
                self.totalCheckSheetArray.removeAll()
                self.updateUI()
            }
            DispatchQueue.main.async{
                self.formsApprovalTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
