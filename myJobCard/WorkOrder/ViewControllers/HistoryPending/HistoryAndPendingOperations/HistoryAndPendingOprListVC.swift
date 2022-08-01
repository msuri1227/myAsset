//
//  ComponentsVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class HistoryAndPendingOprListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var noListLabel: UILabel!
    @IBOutlet var OprListTableView: UITableView!
    @IBOutlet var sideView: UIView!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var isfrom = String()
    var ListViewCellStr = String()
    var selectedopr = HistoryAndPendingOperationModel()
    var historyPendingOprModel = HistoryAndPendingOprListViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        historyPendingOprModel.vcHistoryPendingOprList = self
        OprListTableView.rowHeight = UITableView.automaticDimension
        OprListTableView.estimatedRowHeight = 80
        historyPendingOprModel.getOpeartionData()
        if DeviceType == iPad{
            ListViewCellStr = "HistoryAndPendingOperationCell_iPad"
        }else{
            var title = String()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"
            }else{
                title = "\(selectedworkOrderNumber)"
            }
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: title, NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"Back")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            ListViewCellStr = "HistoryAndPendingOperationCell_iPhone"
            historyPendingOprModel.did_DeSelectedCell = historyPendingOprModel.didSelectedCell
        }
        self.OprListTableView.separatorStyle = .none
        self.OprListTableView.estimatedRowHeight = 150.0
        mJCLogger.log("Ended", Type: "info")
    }
    // Update UI - Get Operation Data
    func updateUIGetOperationData() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.historyPendingOprModel.OprListArray.count)", Type: "Debug")
            if self.historyPendingOprModel.OprListArray.count > 0 {
                self.selectedopr = self.historyPendingOprModel.OprListArray[0]
                self.noListLabel.isHidden = true
                self.OprListTableView.isHidden = false
                self.selectedopr.isSelected = true
                self.OprListTableView.reloadData()
            }else{
                self.noListLabel.isHidden = false
                self.OprListTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetOperationDataWithoutResponseOrError() {
        mJCLogger.log("Starting", Type: "info")
        self.noListLabel.isHidden = false
        self.OprListTableView.isHidden = true
        mJCLogger.log("Ended", Type: "info")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if segue.identifier == "showDetail" {
                let controller = (segue.destination as! UINavigationController).topViewController as!
                    HistoryAndPendingOprDetailsVC
                controller.selectedopr = selectedopr
            }
        }else{
            if segue.identifier == "showDetail" {
                let controller = segue.destination as! HistoryAndPendingOprDetailsVC
                controller.modalPresentationStyle = .fullScreen
                controller.selectedopr = selectedopr
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DeviceType == iPad{
            if(tableView == OprListTableView) {
                return historyPendingOprModel.OprListArray.count
            }else{
                return 0
            }
        }else{
            return historyPendingOprModel.OprListArray.count
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == OprListTableView) {
            let OprCell = tableView.dequeueReusableCell(withIdentifier: ListViewCellStr) as! HistoryAndPendingOperationCell
            OprCell.indexpath = indexPath
            OprCell.historyPendingOprViewModel = historyPendingOprModel
            OprCell.historyPendingoprListModelClass = historyPendingOprModel.OprListArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return OprCell
        }
        return UITableViewCell()
    }
    func updateUIselectOperationButton(tagValue:Int) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad {
            self.performSegue(withIdentifier: "showDetail", sender: HistoryAndPendingOperationCell.self)
        }else {
            let historyAndPendingOprDetailsVc = ScreenManager.getHistoryAndPendingOprDetailsScreen()
            historyAndPendingOprDetailsVc.modalPresentationStyle = .fullScreen
            historyAndPendingOprDetailsVc.selectedopr = historyPendingOprModel.OprListArray[tagValue]
            self.present(historyAndPendingOprDetailsVc, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  DeviceType == iPad{
            return UITableView.automaticDimension
        }else{
            return 80
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            mJCLogger.log("Response :\(workFlowObj)", Type: "Debug")
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){}
    //MARK:-CancelButtonAction
    @IBAction func BackButtonAction(sender: AnyObject) {
        mJCLogger.log("BackButtonAction", Type: "")
        self.dismiss(animated: false) {}
    }
    func backButtonClicked(_ sender: UIButton?){}
    //...END...//
}

