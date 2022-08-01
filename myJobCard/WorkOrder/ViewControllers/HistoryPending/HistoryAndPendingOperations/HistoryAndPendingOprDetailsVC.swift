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

class HistoryAndPendingOprDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var OprDetailTableView: UITableView!
    @IBOutlet var historyAndPendingLongTextTableView: UITableView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var DetailsView: UIView!
    @IBOutlet var nodatalabel:UILabel!
    @IBOutlet weak var nodatalabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var nodatalableTopConstraint: NSLayoutConstraint!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var selectedopr = HistoryAndPendingOperationModel()
    var historyPendingOprDetailModel = HistoryAndPendingOprDetailViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        historyPendingOprDetailModel.vcHistoryPendingOprDetail = self
        headerLabel.text = "Work_Order".localized() + ":\(selectedworkOrderNumber) | " + "Operation_Notes_History_Pending".localized()
        if DeviceType == iPad{
            if selectedopr.OperationNum == ""{
                nodatalabelLeadingConstraint.constant = 10.0
                OprDetailTableView.isHidden = true
                historyAndPendingLongTextTableView.isHidden = true
                nodatalabel.isHidden = false
            }else{
                OprDetailTableView.isHidden = false
                historyAndPendingLongTextTableView.isHidden = false
                nodatalabel.isHidden = true
            }
        }else{
            var title = String()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"
            }else{
                title = "\(selectedworkOrderNumber)"
            }
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: title + ": \(selectedworkOrderNumber)", NewJobButton: false, refresButton: false, threedotmenu: false,leftMenuType:"Back")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            if selectedopr.OperationNum == ""{
                nodatalableTopConstraint.constant = 300
                OprDetailTableView.isHidden = true
                historyAndPendingLongTextTableView.isHidden = true
            }else{
                OprDetailTableView.isHidden = false
                historyAndPendingLongTextTableView.isHidden = false
            }
        }
        historyPendingOprDetailModel.getHistoryPendingOpLongTextSet()
        ScreenManager.registerHistoryAndPendingOperationOverViewCell(tableView: self.OprDetailTableView)
        self.OprDetailTableView.separatorStyle = .none
        self.OprDetailTableView.estimatedRowHeight = 150.0
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == OprDetailTableView) {
            return 1
        } else if(tableView == historyAndPendingLongTextTableView) {
            return historyPendingOprDetailModel.historyAndPendingLongTextArray.count
        }else {
            return 2
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if (tableView == OprDetailTableView) {
            if(indexPath.row == 0) {
                let componentOverViewCell = ScreenManager.getHistoryAndPendingOperationOverViewCell(tableView: tableView)
                componentOverViewCell.historyPendingOprDetailModel = selectedopr
                mJCLogger.log("Ended", Type: "info")
                return componentOverViewCell
            }
        }else if (tableView == historyAndPendingLongTextTableView) {
            let HistoryAndPendingLongTextCell = tableView.dequeueReusableCell(withIdentifier: "HistoryAndPendingLongTextCell") as! NoteListTableViewCell
            HistoryAndPendingLongTextCell.noteListClass = historyPendingOprDetailModel.historyAndPendingLongTextArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return HistoryAndPendingLongTextCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == OprDetailTableView) {
            return 320
        }else {
            return UITableView.automaticDimension
        }
    }
    // MARK:- WOPendingOpLongTextSet
    
    func updateUIGetHistoryPendingOpLongTextSet() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.historyPendingOprDetailModel.historyAndPendingLongTextArray.count)", Type: "Debug")
            if self.historyPendingOprDetailModel.historyAndPendingLongTextArray.count > 0 {
                self.nodatalabel.isHidden = true
                self.nodatalabel.text = "".localized()
                self.historyAndPendingLongTextTableView.reloadData()
            }else{
                if DeviceType == iPad{
                    if self.selectedopr.OperationNum == ""{
                        self.nodatalabelLeadingConstraint.constant = 10.0
                        self.OprDetailTableView.isHidden = true
                        self.historyAndPendingLongTextTableView.isHidden = true
                        self.nodatalabel.isHidden = false
                        self.nodatalabel.text = "No_Data_Available".localized()
                    }else{
                        self.nodatalabelLeadingConstraint.constant = 300.0
                        self.OprDetailTableView.isHidden = false
                        self.historyAndPendingLongTextTableView.isHidden = false
                        self.nodatalabel.isHidden = false
                        self.nodatalabel.text = "Notes_not_Available".localized()
                    }
                }else{
                    if self.selectedopr.OperationNum == ""{
                        self.nodatalableTopConstraint.constant = 10
                        self.OprDetailTableView.isHidden = true
                        self.historyAndPendingLongTextTableView.isHidden = true
                        self.nodatalabel.isHidden = false
                        self.nodatalabel.text = "No_data_Available".localized()
                    }else{
                        self.OprDetailTableView.isHidden = false
                        self.historyAndPendingLongTextTableView.isHidden = false
                        self.nodatalabel.isHidden = false
                        self.nodatalabel.text = "Notes_not_Available".localized()
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
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
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){}
    //...END...//
    
}

