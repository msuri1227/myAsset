//
//  HistoryAndPendingVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class HistoryAndPendingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- HistoryWorkOrderView Outlet..
    @IBOutlet var historyWorkOrderView: UIView!
    @IBOutlet var historyWorkOrderHeaderView: UIView!
    @IBOutlet var historyWorkOrderHeaderLabel: UILabel!
    @IBOutlet var historyWorkOrderTableView: UITableView!
    @IBOutlet var noHistoryWorkOrderFoundLabel: UILabel!
    
    //MARK:- PendingdWorkOrderView Outlet..
    @IBOutlet var pendingdWorkOrderView: UIView!
    @IBOutlet var pendingWorkOrderHeaderView: UIView!
    @IBOutlet var pendingWorkOrderHeaderLabel: UILabel!
    @IBOutlet var pendingWorkOrderTableView: UITableView!
    @IBOutlet var noPendingWorkOrderFoundLabel: UILabel!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var isfrom = String()
    var componentsViewModel = ComponentsViewModel()
    var historyPendingModel = WorkOrderHistoryAndPendingViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        historyPendingModel.vcWOHistoryPending = self
        if DeviceType == iPad{
            historyPendingModel.historyArray.removeAll()
            historyPendingModel.pendingArray.removeAll()
            historyWorkOrderTableView.isHidden = true
            pendingWorkOrderTableView.isHidden = true
            noHistoryWorkOrderFoundLabel.isHidden = true
            noPendingWorkOrderFoundLabel.isHidden = true
            historyWorkOrderTableView.delegate = self
            historyWorkOrderTableView.separatorStyle = .none
            pendingWorkOrderTableView.delegate = self
            pendingWorkOrderTableView.separatorStyle = .none
            historyWorkOrderTableView.estimatedRowHeight = 210.0
            pendingWorkOrderTableView.estimatedRowHeight = 210.0
            ScreenManager.registerHistoryCell(tableView: self.historyWorkOrderTableView)
            ScreenManager.registerHistoryCell(tableView: self.pendingWorkOrderTableView)
            NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
            self.objectSelected()
        }else{
            historyPendingModel.historyArray.removeAll()
            if isfrom == "History"{
                historyPendingModel.getHistory()
                historyWorkOrderHeaderLabel.text = "History".localized()
            }else{
                historyWorkOrderHeaderLabel.text = "Pending".localized()
                historyPendingModel.getPending()
            }
            var title = String()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"
            }else{
                title = "\(selectedworkOrderNumber)"
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
            historyWorkOrderTableView.isHidden = true
            noHistoryWorkOrderFoundLabel.isHidden = true
            historyWorkOrderTableView.separatorStyle = .none
            ScreenManager.registerHistoryCell(tableView: self.historyWorkOrderTableView)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "Reload"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
            historyPendingModel.historyArray.removeAll()
            if isfrom == "History"{
                historyPendingModel.getHistory()
                historyWorkOrderHeaderLabel.text = "History".localized()
            }else{
                historyWorkOrderHeaderLabel.text = "Pending".localized()
                historyPendingModel.getPending()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func objectSelected(){
        if selectedworkOrderNumber != ""{
            historyPendingModel.getHistory()
            historyPendingModel.getPending()
        }else{
            self.historyWorkOrderTableView.isHidden = true
            self.noHistoryWorkOrderFoundLabel.isHidden = false
            self.pendingWorkOrderTableView.isHidden = true
            self.noPendingWorkOrderFoundLabel.isHidden = false
        }
    }
    @objc func loadList(notification:Notification){
        mJCLogger.log("Starting", Type: "info")
        if  tabSelectedIndex == 7{
            historyPendingModel.getHistory()
            historyWorkOrderHeaderLabel.text = "History".localized()
            self.noHistoryWorkOrderFoundLabel.text = "No_History_work_orders_Found".localized()
        }else if tabSelectedIndex == 8{
            historyWorkOrderHeaderLabel.text = "Pending".localized()
            self.noHistoryWorkOrderFoundLabel.text = "No_Pending_Work_Orders_Found".localized()
            historyPendingModel.getPending()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Tableview delegate methods..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if DeviceType == iPad{
            if(tableView == historyWorkOrderTableView) {
                return historyPendingModel.historyArray.count
            }else {
                return historyPendingModel.pendingArray.count
            }
        }else{
            return historyPendingModel.historyArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == historyWorkOrderTableView) {
            let historyCell = ScreenManager.getHistoryCell(tableView: tableView)
            if historyPendingModel.historyArray.count > 0 {
                historyCell.indexPath = indexPath
                if DeviceType == iPhone {
                    if historyWorkOrderHeaderLabel.text == "Pending".localized() {
                        historyCell.fromScreen = "pending"
                    }else {
                        historyCell.fromScreen = "history"
                    }
                }else {
                    historyCell.fromScreen = "history"
                }
                historyCell.historyPendingViewModel = historyPendingModel
                historyCell.historyPendingModelClass = historyPendingModel.historyArray[indexPath.row]
            }
            mJCLogger.log("Ended", Type: "info")
            return historyCell
        }else if(tableView == pendingWorkOrderTableView) {
            let historyCell = ScreenManager.getHistoryCell(tableView: tableView)
            historyCell.indexPath = indexPath
            historyCell.fromScreen = "pending"
            historyCell.historyPendingViewModel = historyPendingModel
            historyCell.historyPendingModelClass = historyPendingModel.pendingArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return historyCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var historyAndPendingModel = HistoryAndPendingModel()
        if (tableView == historyWorkOrderTableView) {
            historyAndPendingModel = historyPendingModel.historyArray[indexPath.row]
        }else{
            historyAndPendingModel = historyPendingModel.pendingArray[indexPath.row]
        }
        if historyAndPendingModel.isExpandCell == true{
            if DeviceType == iPad{
                return 160
            }else{
                return 220
            }
        }else{
            if DeviceType == iPad{
                return 122
            }else{
                return 165
            }
        }
    }
    func updateUIhistory_OperationsButton(tagValue: Int) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(historyPendingModel.historyArray.count)", Type: "Debug")
        let historyAndPendingModel = historyPendingModel.historyArray[tagValue]
        HistoryAndPendingWoOpr = historyAndPendingModel.WorkOrderNum
        HistoryAndPendingWoOprFrom = "History"
        if DeviceType == iPad{
            let splitViewController = ScreenManager.getHistoryAndPendingOprSplitScreen()
            splitViewController.modalPresentationStyle = .fullScreen
            self.present(splitViewController, animated: false, completion: nil)
        }else{
            if isfrom == "History"{
                HistoryAndPendingWoOprFrom = "History"
            } else {
                HistoryAndPendingWoOprFrom = "Pending"
            }
            let historyandpendingOprListVc = ScreenManager.getHistoryAndPendingOprListScreen()
            historyandpendingOprListVc.modalPresentationStyle = .fullScreen
            self.present(historyandpendingOprListVc, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIpending_OperationsButton(tagValue : Int) {
        mJCLogger.log("Starting", Type: "info")
        HistoryAndPendingWoOprFrom = "Pending"
        if DeviceType == iPad{
            mJCLogger.log("Response :\(historyPendingModel.pendingArray.count)", Type: "Debug")
            let historyAndPendingModel = historyPendingModel.pendingArray[tagValue]
            HistoryAndPendingWoOpr = historyAndPendingModel.WorkOrderNum
            let splitViewController = ScreenManager.getHistoryAndPendingOprSplitScreen()
            splitViewController.modalPresentationStyle = .fullScreen
            self.present(splitViewController, animated: false, completion: nil)
        }else{
            mJCLogger.log("Response :\(historyPendingModel.historyArray.count)", Type: "Debug")
            let historyAndPendingModel = historyPendingModel.historyArray[tagValue]
            HistoryAndPendingWoOpr = historyAndPendingModel.WorkOrderNum
            let historyandpendingOprListVc = ScreenManager.getHistoryAndPendingOprListScreen()
            historyandpendingOprListVc.modalPresentationStyle = .fullScreen
            self.present(historyandpendingOprListVc, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIComponentHistory(tagValue: Int) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone {
            mJCLogger.log("Response :\(historyPendingModel.historyArray.count)", Type: "Debug")
            let historyAndPendingModel = historyPendingModel.historyArray[tagValue]
            let componentsVC = ScreenManager.getComponentListScreen()
            componentsVC.isfrom = "WoHistory"
            componentsVC.isFromHistoryScreen = true
            componentsVC.hisWONum = historyAndPendingModel.WorkOrderNum
            componentsVC.modalPresentationStyle = .fullScreen
            self.present(componentsVC, animated: false) {}
        }else {
            let historyAndPendingModel = historyPendingModel.historyArray[tagValue]
            let componentsVC = ScreenManager.getComponentScreen()
            componentsVC.isFromHistoryScreen = true
            componentsVC.hisWONum = historyAndPendingModel.WorkOrderNum
            componentsVC.modalPresentationStyle = .fullScreen
            self.present(componentsVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getnoteListScreen(WorkOrderNum : String){
              mJCLogger.log("Starting", Type: "info")
              let noteListVC = ScreenManager.getLongTextListScreen()
        noteListVC.isAddNewNote = false
        noteListVC.woNum = WorkOrderNum
        noteListVC.fromScreen = "woHistoryPending"
        noteListVC.modalPresentationStyle = .fullScreen
        self.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Update UI - Get History Data..
    func updateUIGetHistory() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if DeviceType == iPad{
                mJCLogger.log("Response :\(self.historyPendingModel.historyArray.count)", Type: "Debug")
                if self.historyPendingModel.historyArray.count > 0 {
                    self.historyWorkOrderTableView.reloadData()
                    self.historyWorkOrderTableView.isHidden = false
                    self.noHistoryWorkOrderFoundLabel.isHidden = true
                }else{
                    self.historyWorkOrderTableView.isHidden = true
                    self.noHistoryWorkOrderFoundLabel.isHidden = false
                    self.noHistoryWorkOrderFoundLabel.text = "No_History_work_orders_Found".localized()
                }
            }else {
                mJCLogger.log("Response :\(self.historyPendingModel.historyArray.count)", Type: "Debug")
                if self.historyPendingModel.historyArray.count > 0 {
                    self.historyWorkOrderTableView.reloadData()
                    self.historyWorkOrderTableView.isHidden = false
                    self.noHistoryWorkOrderFoundLabel.isHidden = true
                }else{
                    self.historyWorkOrderTableView.isHidden = true
                    self.noHistoryWorkOrderFoundLabel.isHidden = false
                    self.noHistoryWorkOrderFoundLabel.text = "No_History_work_orders_Found".localized()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Update UI - Get Pending Data..
    func updateUIGetPending() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if DeviceType == iPad{
                mJCLogger.log("Response :\(self.historyPendingModel.pendingArray.count)", Type: "Debug")
                if self.historyPendingModel.pendingArray.count > 0 {
                    self.pendingWorkOrderTableView.reloadData()
                    self.pendingWorkOrderTableView.isHidden = false
                    self.noPendingWorkOrderFoundLabel.isHidden = true
                }else{
                    self.pendingWorkOrderTableView.isHidden = true
                    self.noPendingWorkOrderFoundLabel.isHidden = false
                    self.noPendingWorkOrderFoundLabel.text = "No_Pending_Work_Orders_Found".localized()
                }
            }else{
                mJCLogger.log("Response :\(self.historyPendingModel.historyArray.count)", Type: "Debug")
                if self.historyPendingModel.historyArray.count > 0 {
                    self.historyWorkOrderTableView.reloadData()
                    self.historyWorkOrderTableView.isHidden = false
                    self.noHistoryWorkOrderFoundLabel.isHidden = true
                }else{
                    self.historyWorkOrderTableView.isHidden = true
                    self.noHistoryWorkOrderFoundLabel.isHidden = false
                    self.noHistoryWorkOrderFoundLabel.text = "No_Pending_Work_Orders_Found".localized()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetLongText(WorkOrderNumValue : String, indexValue : Int, fromStr: String){
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.historyPendingModel.historyArray.count)", Type: "Debug")
        mJCLogger.log("Response :\(self.historyPendingModel.pendingArray.count)", Type: "Debug")
        var historyAndPendingModel = HistoryAndPendingModel()
        if DeviceType == iPad {
            if fromStr == "pending"{
                historyAndPendingModel = historyPendingModel.pendingArray[indexValue]
            }else {
                historyAndPendingModel = historyPendingModel.historyArray[indexValue]
            }
        }else {
            historyAndPendingModel = historyPendingModel.historyArray[indexValue]
        }
        historyAndPendingModel.isNotesAvailable = true
        DispatchQueue.main.async {
            if DeviceType == iPad {
                if fromStr == "pending"{
                    self.pendingWorkOrderTableView.reloadData()
                }else {
                    self.historyWorkOrderTableView.reloadData()
                }
            }else {
                self.historyWorkOrderTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
