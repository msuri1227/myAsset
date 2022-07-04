//
//  workOrderInfoView.swift
//  myJobCard
//
//  Created by Rover Software on 13/01/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class workOrderInfoView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var popView: UIView!
    @IBOutlet var moreInfoButton: UIButton!
    @IBOutlet weak var WorkorderNumberLbl: UILabel!
    @IBOutlet weak var WoNameLbl: UILabel!
    @IBOutlet weak var WoContactAddressLbl: UILabel!
    @IBOutlet weak var WoDescriptionLbl: UILabel!
    @IBOutlet weak var WoPrioorityLbl: UILabel!
    @IBOutlet weak var WoOrderTypeLbl: UILabel!
    @IBOutlet weak var WoCreatedOnLbl: UILabel!
    @IBOutlet weak var barCodeImg: UIImageView!
    @IBOutlet weak var operationView: UIView!
    @IBOutlet weak var operationTableView: UITableView!
    @IBOutlet var popViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var popViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var noDataLabel: UILabel!
    
    var operationArray = NSMutableArray()
    var workOrderNumer = String()

    @IBAction func closeButtonAction(_ sender: Any) {
        removeFromSuperview()
    }
    
    func popUpViewUI(){
        if DeviceType == iPad{
            popViewWidthConstraint.constant = 600
            popViewHeightConstraint.constant = 645
        }else{
            popViewWidthConstraint.constant = 360
            popViewHeightConstraint.constant = 600
        }
        popView.layer.cornerRadius = 15
        popView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        popView.layer.borderWidth = 2.0
        popView.layer.borderColor = #colorLiteral(red: 0.337254902, green: 0.5411764706, blue: 0.6784313725, alpha: 1)
        
        closeButton.layer.cornerRadius = 24
        closeButton.clipsToBounds = true
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
    
    @IBAction func moreInfoButtonActionn(_ sender: Any) {
        if (sender as! UIButton).titleLabel?.text == "Hide_Operations".localized(){
            self.moreInfoButton.setTitle("Show_Operations".localized(), for: .normal)
            self.operationView.isHidden = true
        }else{
            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
            if result == "ServerUp"{
                if (sender as! UIButton).titleLabel?.text == "Show_Operations".localized(){
                    self.moreInfoButton.setTitle("Hide_Operations".localized(), for: .normal)
                    ScreenManager.registerAdditionalOperationCountCell(tableView: self.operationTableView)
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)

                    if woOperationsArray.count == 0 || woWorkOrder != workOrderNumer {
                        dispatchQueue.async{
                            mJCLoader.startAnimating(status: "Please_Wait".localized())
                            self.getOnlineResults()
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.operationView.isHidden = false
                            self.operationTableView.isHidden = false
                            self.operationTableView.delegate = self
                            self.operationTableView.dataSource = self
                            self.operationTableView.reloadData()
                            mJCLoader.stopAnimating()
                        }
                    }
                }
            }else if result == "ServerDown"{
                mJCLoader.stopAnimating()
                mJCAlertHelper.showAlert(title: alerttitle, message: ServerDownAlert, button: okay)
            }else{
                mJCLoader.stopAnimating()
                mJCAlertHelper.showAlert(title: alerttitle, message: noInternetAlert, button: okay)
            }
        }
    }
    
    func getOnlineResults() {
        let query = "$filter=(OnlineSearch%20eq%20%27X%27%20and%20WorkOrderNum%20eq%20%27\(workOrderNumer)%27)"
         woWorkOrder = workOrderNumer
        let httpConvMan1 = HttpConversationManager.init()
        let commonfig1 = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig1.configureManager(httpConvMan1)
        
        let  workorderDict = WoOperationModel.getOnlineWoOperations(filterQuery: query, httpConvManager: httpConvMan1!)
        if let status = workorderDict["Status"] as? Int{
            if status == 200{
                if let dict = workorderDict["Response"] as? NSMutableDictionary{
                    let responseDict = formateHelperClass.getListInFormte(dictionary: dict, entityModelClassType: WoOperationModel.self)
                    if let responseArr = responseDict["data"] as? [WoOperationModel]{
                        if responseArr.count > 0{
                        woOperationsArray = responseArr
                        DispatchQueue.main.async {
                            self.operationView.isHidden = false
                            self.operationTableView.isHidden = false
                            self.operationTableView.delegate = self
                            self.operationTableView.dataSource = self
                            self.operationTableView.reloadData()
                            self.noDataLabel.isHidden = true
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.operationView.isHidden = false
                            self.operationTableView.isHidden = false
                        self.noDataLabel.isHidden = false
                        }
                    }
                    }else{
                        DispatchQueue.main.async {
                            self.operationView.isHidden = false
                            self.operationTableView.isHidden = false
                        self.noDataLabel.isHidden = false
                        }

                    }
                }
            }
        }
        mJCLoader.stopAnimating()
    }
    //MARK: - TableView Delegate and Datasource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return woOperationsArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let totalOperationCountCell = ScreenManager.getAdditionalOperationCountCell(tableView: tableView)
        if woOperationsArray.count > 0{
            let operationClass = woOperationsArray[indexPath.row]
            totalOperationCountCell.operationNameLabel.text =  "Operation".localized() + " : \(operationClass.OperationNum)"
            totalOperationCountCell.DescriptionLabel.text = " \(operationClass.ShortText)"
            totalOperationCountCell.operationCompleteImageWidthConstraint.constant = 0.0
            totalOperationCountCell.WithdranQtyLabel.isHidden = false
            totalOperationCountCell.sideIndicatorView.isHidden = true
            totalOperationCountCell.selectCheckBoxWidthConst.constant = 0.0
            totalOperationCountCell.selectCheckBoxButton.isHidden = true
            totalOperationCountCell.transPerantView.isHidden = true
            let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: operationClass.EarlSchStartExecTime)
            var date = String()
            if operationClass.EarlSchStartExecDate != nil{
                date = operationClass.EarlSchStartExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            totalOperationCountCell.dueDateLabel.text = " " + "Start_Date".localized() + " : \(date) \(time)"
            if WORKORDER_ASSIGNMENT_TYPE == "1" && WORKORDER_ASSIGNMENT_TYPE == "2"{
                totalOperationCountCell.WithdranQtyLabel.isHidden = true
            }else if WORKORDER_ASSIGNMENT_TYPE == "3" && WORKORDER_ASSIGNMENT_TYPE == "5"{
                if operationClass.PersonnelNo != "" && operationClass.PersonnelNo != userPersonnelNo{
                    let percls = globalPersonRespArray.filter{$0.PersonnelNo == "\(operationClass.PersonnelNo)"}
                    if percls.count > 0{
                        totalOperationCountCell.WithdranQtyLabel.text = "Assigned_To".localized() + " : " + "\(percls[0].SystemID)"
                    }else{
                        totalOperationCountCell.WithdranQtyLabel.isHidden = true
                    }
                }else{
                    totalOperationCountCell.WithdranQtyLabel.isHidden = true
                }
            }else if WORKORDER_ASSIGNMENT_TYPE == "4" {
                totalOperationCountCell.WithdranQtyLabel.text = "Assigned_To".localized() + " : " + "\(operationClass.WorkCenter)"
            }
        }
        return totalOperationCountCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
