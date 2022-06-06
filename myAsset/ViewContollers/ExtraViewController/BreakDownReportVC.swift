//
//  BreakDownReportVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/10/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class BreakDownReportVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet var equipmentUILabel: UILabel!
    @IBOutlet var equipmentTitleLabel: UILabel!
    @IBOutlet var descriptionUILabel: UILabel!
    @IBOutlet var fromdateTextfield: UITextField!
    @IBOutlet var toDateTextField: UITextField!
    @IBOutlet var fromdateTextfieldView: UIView!
    @IBOutlet var toDateTextFieldView: UIView!
    @IBOutlet var meanTimeRepairTF: UITextField!
    @IBOutlet var timeBetweenRepairsTF: UITextField!
    @IBOutlet var meanTimeBetweenRepairsTF: UITextField!
    @IBOutlet var breakDownReportTableview: UITableView!
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var meanTimeStachView: UIStackView!
    @IBOutlet var breakdownHeaderView: UIView!
    @IBOutlet var noDataLabel: UILabel!
    
    var dateSelctionType = String()
    var breakDownObj = String()
    var breakDownObjDescription = String()
    var BreakdownDetailsCellStr = String()
    var BreakdownHeaderCellStr = String()
    var BreakdownFooterCellStr = String()
    var currentRow = Int()
    var isFromScreen = String()
    var breakdownReportViewModel = BreakdownReportViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        breakdownReportViewModel.vcBreakdownReport = self
        if DeviceType == iPhone{
            self.breakDownReportTableview.tableHeaderView = self.breakdownHeaderView
        }
        ODSUIHelper.setBorderToView(view:self.fromdateTextfieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.toDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.breakDownReportTableview.dataSource = self
        self.breakDownReportTableview.delegate = self
        self.breakDownReportTableview.isHidden = true
        self.meanTimeStachView.isHidden = true
        ScreenManager.registerBreakdownReportTableViewCell(tableView: self.breakDownReportTableview)
        self.getBreakDownReports()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        self.equipmentUILabel.text = breakDownObj
        self.descriptionUILabel.text = breakDownObjDescription
        if isFromScreen == "FUNCTIONALLOCATION"{
            self.equipmentTitleLabel.text = "Functional_Location".localized()
        }else{
            self.equipmentTitleLabel.text = "Equipment".localized()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetOnlineResults() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            if self.breakdownReportViewModel.breakdownReportArray.count > 0 {
                self.breakDownReportTableview.isHidden = false
                self.meanTimeStachView.isHidden = false
                self.breakDownReportTableview.reloadData()
                self.noDataLabel.isHidden = true
            }else{
                self.breakDownReportTableview.isHidden = true
                self.noDataLabel.isHidden = false
                mJCLoader.stopAnimating()
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func fromDateButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        
         ODSPicker.selectDate(title: "Select_From_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            if !(self?.toDateTextField.text!.isEmpty)! {
                if ODSDateHelper.compareTwoDates(fromDate: selectedDate.dateString(localDateFormate), toDate: (self?.toDateTextField.text)!){
                    self?.fromdateTextfield.text = selectedDate.dateString(localDateFormate)
                }
                else{
                    self?.toDateTextField.text = ""
                    self?.fromdateTextfield.text = selectedDate.dateString(localDateFormate)
                }
            }
            else{
                self?.fromdateTextfield.text = selectedDate.dateString(localDateFormate)
            }
        })
        dateSelctionType = "FromDate"
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func toDateButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        dateSelctionType = "ToDate"
        if fromdateTextfield.text!.count > 0 {
                ODSPicker.selectDate(title: "Select_To_Date".localized(), cancelText: "Cancel".localized(), datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                    if !(self?.fromdateTextfield.text!.isEmpty)! {
                        if ODSDateHelper.compareTwoDates(fromDate: (self?.fromdateTextfield.text)!, toDate: selectedDate.dateString(localDateFormate)){
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
    @IBAction func applyButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        applyButton.addTarget(self, action: #selector(dropdownButtonAction(sender:)), for: .touchUpInside)
        self.getBreakDownReports()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView DataSource & Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakdownReportViewModel.breakdownReportArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        var  breakdownReportCell = BreakdownReportTableViewCell()
        if breakdownReportViewModel.breakdownReportArray.count > indexPath.row{
            self.meanTimeRepairTF.text = "\((breakdownReportViewModel.breakdownReportArray[0] as! BreakdownReportModel).MeanTimeToRepair)"
            self.timeBetweenRepairsTF.text = "\((breakdownReportViewModel.breakdownReportArray[0] as! BreakdownReportModel).TimeBetweenRepairs)"
            self.meanTimeBetweenRepairsTF.text = "\((breakdownReportViewModel.breakdownReportArray[0] as! BreakdownReportModel).MeanTimeBetweenRepairs)"
            breakdownReportCell = ScreenManager.getBreakdownReportTableViewCell(tableView: tableView)
            mJCLogger.log("Response:\(breakdownReportViewModel.breakdownReportArray.count)", Type: "Debug")
            breakdownReportCell.breakdownReportModelClass = breakdownReportViewModel.breakdownReportArray[indexPath.row] as? BreakdownReportModel
            mJCLogger.log("Ended", Type: "info")
            return breakdownReportCell
        }else{
            mJCLogger.log("Ended", Type: "info")
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType == iPad{
            return 90
        }else{
            return 110
        }
    }

    @objc func dropdownButtonAction(sender:UIButton!){
        mJCLogger.log("Starting", Type: "info")
        self.breakDownReportTableview.isHidden = true
        self.meanTimeStachView.isHidden = true
        mJCLogger.log("Ended", Type: "info")
    }
    func getBreakDownReports(){
        mJCLogger.log("Starting", Type: "info")
        var strQuery = String()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
        if result == "ServerUp"{
            if self.fromdateTextfield.text?.count ?? 0 > 0 && self.toDateTextField.text?.count ?? 0 > 0 {
                let startDate = ODSDateHelper.getDateFromString(dateString: fromdateTextfield.text!, dateFormat: localDateFormate)
                let selecteddate = ODSDateHelper.getDateFromString(dateString: toDateTextField.text!, dateFormat: localDateFormate)
                if startDate > selecteddate {
                    mJCLogger.log("Please_Select_End_Date_Greaterthan_Start_Date".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized() , button: okay)
                    return
                }
            }
            mJCLoader.startAnimating(status: "Please_Wait".localized())
            if self.fromdateTextfield.text != "" && self.toDateTextField.text != "" {
                let fromDate = self.fromdateTextfield.text! + "T00:00:00"
                let toDate = self.toDateTextField.text! + "T00:00:00"
                if isFromScreen == "EQUIPMENT"{
                    strQuery = "$filter=(Online%20eq%20%27X%27%20and%20Date%20gt%20datetime%27\(fromDate)%27%20and%20Date%20lt%20datetime%27\(toDate)%27%20and%20Equipment%20eq%20%27\(breakDownObj)%27)"
                }else{
                    strQuery = "$filter=(Online%20eq%20%27X%27%20and%20Date%20gt%20datetime%27\(fromDate)%27%20and%20Date%20lt%20datetime%27\(toDate)%27%20and%20FuncLocation%20eq%20%27\(breakDownObj)%27)"
                }
            }else if self.fromdateTextfield.text == "" && self.toDateTextField.text == "" {
                if isFromScreen == "EQUIPMENT"{
                    strQuery = "$filter=(Online%20eq%20%27X%27%20and%20Equipment%20eq%20%27\(breakDownObj)%27)"
                }else{
                    strQuery = "?&$filter=(Online%20eq%20%27X%27%20and%20FuncLocation%20eq%20%27\(breakDownObj)%27)"
                }
            }else if self.fromdateTextfield.text != "" && self.toDateTextField.text == "" {
                let fromDate = self.fromdateTextfield.text! + "T00:00:00"
                if isFromScreen == "EQUIPMENT"{
                    strQuery = "$filter=(Online%20eq%20%27X%27%20and%20Equipment%20eq%20%27\(breakDownObj)%27%20and%20Date%20eq%20datetime%27\(fromDate)%27)"
                }else{
                    strQuery = "$filter=(Online%20eq%20%27X%27%20and%20FuncLocation%20eq%20%27\(breakDownObj)%27%20and%20Date%20eq%20datetime%27\(fromDate)%27)"
                }
            }
            let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
            dispatchQueue.async{
                self.breakdownReportViewModel.getOnlineResults(query: strQuery)
            }
        }else if result == "ServerDown"{
            mJCLogger.log("Unable_to_connect_with_server".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
        }else{
            mJCLogger.log("The_Internet_connection_appears_to_be_offline".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
