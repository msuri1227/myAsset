//
//  BreakdownReportViewController.swift
//  myJobCard
//
//  Created by Ruby's Mac on 12/10/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class BreakdownReportViewController: UIViewController,ODSDatePickerViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UsernamePasswordProviderProtocol  {
    
    func provideUsernamePassword(forAuthChallenge authChallenge: URLAuthenticationChallenge!, completionBlock: username_password_provider_completion_t!) {
        
        DispatchQueue.main.async {
            if let dict =  UserDefaults.standard.value(forKey:"login_Details") as? NSDictionary {
                let username = dict.value(forKey: "userName") as! String
                let password = dict.value(forKey: "password") as! String
                let credential = URLCredential(user: username, password: password, persistence: .forSession)
                completionBlock(credential, nil)
            }
        }
    }
    
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
    var newBreakdownReport = BreakdownReportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBreakdownReport.vcBreakdownReport = self
        if DeviceType == iPhone{
            self.breakDownReportTableview.tableHeaderView = self.breakdownHeaderView
           
        }
        ODSUIHelper.setBorderToView(view:self.fromdateTextfieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)

        ODSUIHelper.setBorderToView(view:self.toDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)

        
        self.breakDownReportTableview.dataSource = self
        self.breakDownReportTableview.delegate = self
//        self.breakDownReportTableview.layer.cornerRadius = 5
//        self.breakDownReportTableview.layer.borderColor = UIColor.lightGray.cgColor
//        self.breakDownReportTableview.layer.borderWidth = 1
        self.breakDownReportTableview.isHidden = true
        self.meanTimeStachView.isHidden = true
        self.noDataLabel.isHidden = true

        if DeviceType == iPad{
            self.breakDownReportTableview.register(UINib(nibName: "BreakdownReportTableViewCell", bundle: nil), forCellReuseIdentifier: "BreakdownReportTableViewCell")
                
        }else{
            

            self.breakDownReportTableview.register(UINib(nibName: "BreakdownReportTableViewCell_iPhone", bundle: nil), forCellReuseIdentifier: "BreakdownReportTableViewCell_iPhone")
                
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myJobCardDataManager.uniqueInstance.methodStatusBarColorChange()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.equipmentUILabel.text = breakDownObj
        self.descriptionUILabel.text = breakDownObjDescription
        if isFromScreen == "FUNCTIONALLOCATION"{
            self.equipmentTitleLabel.text = "Functiona_Location".localized()
        }else{
            self.equipmentTitleLabel.text = "Equipment".localized()
            
        }
        self.getBreakDownReports()
    }
    
    
    func updateUIGetOnlineResults() {
        DispatchQueue.main.async{
            if self.newBreakdownReport.breakdownReportArray.count > 0 {
                self.breakDownReportTableview.isHidden = false
                self.meanTimeStachView.isHidden = false
                self.breakDownReportTableview.reloadData()
                self.noDataLabel.isHidden = true
            }else{
                self.breakDownReportTableview.isHidden = false
                self.breakDownReportTableview.reloadData()
                self.noDataLabel.isHidden = false
                mJCLoader.stopAnimating()
            }
            
        }
    }
    
    @IBAction func fromDateButtonAction(_ sender: Any) {
        mJCLogger.log("Basic_data_Button_Tapped".localized(), Type: "")
        let vc = ODSDatePickerViewController()
            vc.datePickerTitle = "Select_From_Date".localized()
            vc.delegate = self
            dateSelctionType = "FromDate"
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func toDateButtonAction(_ sender: Any) {
        mJCLogger.log("Basic_data_Button_Tapped".localized(), Type: "")
        let vc = ODSDatePickerViewController()
            vc.datePickerTitle = "Select_To_Date".localized()
            vc.delegate = self
            dateSelctionType = "ToDate"
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func applyButtonAction(_ sender: Any) {
//
        applyButton.addTarget(self, action: #selector(dropdownButtonAction(sender:)), for: .touchUpInside)
        self.getBreakDownReports()


    }
    
    //MARK:- UITableView DataSource & Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newBreakdownReport.breakdownReportArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var  breakdownReportCell = BreakdownReportTableViewCell()
        if newBreakdownReport.breakdownReportArray.count > indexPath.row{
            self.meanTimeRepairTF.text = "\((newBreakdownReport.breakdownReportArray[0] as! BreakdownReportModel).MeanTimeToRepair)"
            self.timeBetweenRepairsTF.text = "\((newBreakdownReport.breakdownReportArray[0] as! BreakdownReportModel).TimeBetweenRepairs)"
            self.meanTimeBetweenRepairsTF.text = "\((newBreakdownReport.breakdownReportArray[0] as! BreakdownReportModel).MeanTimeBetweenRepairs)"
                
                if DeviceType == iPad{
                    breakdownReportCell = tableView.dequeueReusableCell(withIdentifier: "BreakdownReportTableViewCell") as! BreakdownReportTableViewCell
                }else{
                    breakdownReportCell = tableView.dequeueReusableCell(withIdentifier: "BreakdownReportTableViewCell_iPhone") as! BreakdownReportTableViewCell
                }
                breakdownReportCell.newBreakdownReportModelClass = newBreakdownReport.breakdownReportArray[indexPath.row] as? BreakdownReportModel
                return breakdownReportCell
            
        }else{
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
    
    func ODSDatePickerDidSet(_ viewController: ODSDatePickerViewController, result: ODSDatePickerResult) {
        let resultdate = result.dateFromPickerWithOnlineSearch
        if dateSelctionType == "FromDate" {
            self.fromdateTextfield.text = resultdate
            viewController.dismiss(animated: true, completion: nil)
        }
        else if dateSelctionType == "ToDate" {
            if fromdateTextfield.text!.count > 0 {
                let startDate = ODSDateHelper.getDateFromString(dateString: fromdateTextfield.text!, dateFormat: localDateFormate)
                let selecteddate = ODSDateHelper.getDateFromString(dateString: resultdate, dateFormat: localDateFormate)
                if selecteddate >= startDate {
                    self.toDateTextField.text = resultdate
                    viewController.dismiss(animated: true, completion: nil)
                }else{
                    mJCAlertHelper.showAlert(viewController, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized() , button: okay)
                }
                
            }else{
                mJCAlertHelper.showAlert(viewController, title: MessageTitle, message: "Please_Select_Start_Date".localized() , button: okay)
            }
        }
    }
    
    func ODSDatePickerDidCancel(_ viewController: ODSDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    
    @objc func dropdownButtonAction(sender:UIButton!){
        
        self.breakDownReportTableview.isHidden = true
        self.meanTimeStachView.isHidden = true
    }
    
    
    func getBreakDownReports(){
        
        var strQuery = String()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
        if result == "ServerUp"{
            
            if self.fromdateTextfield.text?.count ?? 0 > 0 && self.toDateTextField.text?.count ?? 0 > 0 {
                let startDate = ODSDateHelper.getDateFromString(dateString: fromdateTextfield.text!, dateFormat: localDateFormate)
                let selecteddate = ODSDateHelper.getDateFromString(dateString: toDateTextField.text!, dateFormat: localDateFormate)
                    if startDate > selecteddate {
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_Select_End_Date_Greaterthan_Start_Date".localized() , button: okay)
                        return
                    }
            }
            
            mJCLoader.startAnimating(status: "Please_Wait".localized())
            
            if self.fromdateTextfield.text != "" && self.toDateTextField.text != "" {
                let fromDate = self.fromdateTextfield.text! + "T00:00:00"
                let toDate = self.toDateTextField.text! + "T00:00:00"
                    if isFromScreen == "EQUIPMENT"{
                        strQuery = "?&$filter=(Date%20ge%20datetime%27\(fromDate)%27%20and%20Date%20le%20datetime%27\(toDate)%27%20and%20Equipment%20eq%20%27\(breakDownObj)%27)"
                    }else{
                        strQuery = "?&$filter=(Date%20ge%20datetime%27\(fromDate)%27%20and%20Date%20le%20datetime%27\(toDate)%27%20and%20FuncLocation%20eq%20%27\(breakDownObj)%27)"
                    }
            }else if self.fromdateTextfield.text == "" && self.toDateTextField.text == "" {
                
                if isFromScreen == "EQUIPMENT"{
                    strQuery = "?&$filter=(Equipment%20eq%20%27\(breakDownObj)%27)"
                }else{
                    strQuery = "?&$filter=(FuncLocation%20eq%20%27\(breakDownObj)%27)"
                }
            }else if self.fromdateTextfield.text != "" && self.toDateTextField.text == "" {
                
                let fromDate = self.fromdateTextfield.text! + "T00:00:00"
                
                if isFromScreen == "EQUIPMENT"{
                    strQuery = "?&$filter=(Equipment%20eq%20%27\(breakDownObj)%27%20and%20Date%20eq%20datetime%27\(fromDate)%27)"
                }else{
                    strQuery = "?&$filter=(FuncLocation%20eq%20%27\(breakDownObj)%27%20and%20Date%20eq%20datetime%27\(fromDate)%27)"
                }
            }
            strQuery = "BreakdownReportSet" + strQuery
            let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
            
            dispatchQueue.async{
              
                self.newBreakdownReport.getOnlineResults(query: strQuery)
            }
            
        }else if result == "ServerDown"{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
            
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
        }
        
    }
    
}
