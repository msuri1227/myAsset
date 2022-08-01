//
//  OperationListVC.swift
//  myJobCard
//
//  Created by Rover Software on 25/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OperationListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var totalOprCountLabel: UILabel!
    @IBOutlet weak var operationListTable: UITableView!
    @IBOutlet var SelectionAllOperationCheck: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet var viewTopConstant: NSLayoutConstraint!
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
    var isfromsup = String()
    var singleOperationArray = [WoOperationModel]()
    var totalOprationArray = [WoOperationModel]()
    var selectedOprNum = String()
    var isfrom = String()
    var operationModel = OperationListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationModel.vc = self
        viewTopConstant.constant = 0.0
        operationListTable.delegate = self
        operationListTable.dataSource = self
        self.operationListTable.estimatedRowHeight = 80
        self.operationListTable.rowHeight = UITableView.automaticDimension
        ScreenManager.registerTotalOperationCountCell(tableView: self.operationListTable)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OperationListVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        operationModel.vc = self
        operationModel.isfromsup = isfromsup
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        var title = String()
        if DeviceType == iPhone{
            if isfromsup != "Supervisor"{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            }
            currentsubView = "Operations"
        }
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"
        }else{
            title = "\(selectedworkOrderNumber)"
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
        if onlineSearch != true {
            operationModel.getConfirmationOpeartionSet()
        }
    }
    //MARK:- Notifications Methods..
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        operationModel.getConfirmationOpeartionSet()
    }
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operationModel.totalOprationArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalOperationCountCell = ScreenManager.getTotalOperationCountCell(tableView: tableView)
        if operationModel.totalOprationArray.count > 0{
            let operationClass = operationModel.totalOprationArray[indexPath.row]
            totalOperationCountCell.indexPath = indexPath
            totalOperationCountCell.operationListVCModel = self.operationModel
            totalOperationCountCell.totalOprListIphoneClass = operationClass
        }
        return totalOperationCountCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if operationModel.selectedOperationArray.count == 0{
            let operationsVC = ScreenManager.getOperationScreen()
            let operationClass = operationModel.totalOprationArray[indexPath.row]
            operationsVC.selectedOprNum = operationClass.OperationNum
            selectedOperationNumber = operationClass.OperationNum
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: "\(selectedworkOrderNumber)")
            if isfromsup == "Supervisor"{
                operationsVC.isfromsup = "Supervisor"
            }else{
                operationsVC.isfromsup = ""
            }
            operationsVC.selectedIndexOp = indexPath.row
            operationsVC.modalPresentationStyle = .fullScreen
            self.present(operationsVC, animated: false) {}
        }
    }
    //MARK:- Get Operation Data..
    @objc func savebutoonAction(){
        mJCLogger.log("saveOperationButtonAction".localized(), Type: "")
        if isActiveWorkOrder == true{
            if operationModel.selectedOperationArray.count > 0{
                operationModel.completeBulkOperationMethod(count: 0)
            }else{
                if self.singleOperationArray.count > 0 {
                    let singleOperationClass = self.singleOperationArray[0]
                    if singleOperationClass.isCompleted == true {
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_Operation_is_already_completed".localized(), button: okay)
                    }else {
                        self.completeOperationMethod()
                    }
                } else {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_operation_selected".localized(), button: okay)
                }
            }
        }else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
    }
    func completeOperationMethod() {
        
        mJCLogger.log("completeOperationMethod Start".localized(), Type: "")
        let singleOperationClass = self.singleOperationArray[0]
        let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
        if singleOperationClass.OperationNum.contains(find: "L") {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "This_is_local_operation_You_can't_Complete_this_operation".localized(), button: okay)
            return
        }else {
            let params = Parameters(
                title: alerttitle,
                message: "You_are_completing_this_operation_do_you_want_to_continue".localized(),
                cancelButton: "YES".localized(),
                otherButtons: ["NO".localized()]
            )
            mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                switch buttonIndex {
                case 0:
                    (singleOperationClass.entity.properties["SystemStatus"] as! SODataProperty).value = mobStatusCode as NSObject
                    WoOperationModel.updateOperationEntity(entity: singleOperationClass.entity,flushRequired: false, options: nil, completionHandler: { (response, error) in
                        if(error == nil) {
                            let operationClass = self.operationModel.totalOprationArray[self.did_DeSelectedCell]
                            operationClass.isCompleted = true
                            self.operationModel.postOperationConfirmation()
                            mJCLogger.log("Confirmation Done".localized(), Type: "Debug")
                            DispatchQueue.main.async {
                                self.operationListTable.reloadData()
                            }
                        }else {
                            mJCLogger.log("\(error?.localizedDescription)", Type: "Error")
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_operation_try_again".localized(), button: okay)
                        }
                    })
                case 1: break
                    
                default: break
                }
            }
        }
    }
    @IBAction func selectAllOperationCheckBoxAction(sender: AnyObject){
        
        if SelectionAllOperationCheck.isSelected == false{
            SelectionAllOperationCheck.isSelected = true
            let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
            for i in 0..<operationModel.totalOprationArray.count{
                let indexPath = IndexPath(row: i, section: 0)
                let cell = operationListTable.cellForRow(at: indexPath) as! TotalOperationCountCell
                let singleoperationCls = operationModel.totalOprationArray[i]
                if !singleoperationCls.OperationNum.contains(find: "L") && !singleoperationCls.SystemStatus.contains(mobStatusCode){
                    operationModel.selectedOperationArray.add(singleoperationCls)
                    SelectionAllOperationCheck.isSelected = true
                }
            }
        }else{
            SelectionAllOperationCheck.isSelected = false
            operationModel.selectedOperationArray.removeAllObjects()
        }
        DispatchQueue.main.async{
            self.operationListTable.reloadData()
        }
    }
    func completeBulkOperationMethod(count:Int){
        operationModel.completeBulkOperationMethod(count: count)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}






