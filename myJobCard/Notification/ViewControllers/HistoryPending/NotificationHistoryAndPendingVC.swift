//
//  NotificationHistoryAndPendingVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/9/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotificationHistoryAndPendingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
    var notificationFrom = String()
    var isfrom = String()
    var notificationHistoryPendingModel = NotificationHistoryAndPendingViewModel()
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        notificationHistoryPendingModel.vcNOHistoryPending = self
        if DeviceType == iPad{
            notificationHistoryPendingModel.historyArray.removeAll()
            notificationHistoryPendingModel.pendingArray.removeAll()
            historyWorkOrderTableView.isHidden = true
            pendingWorkOrderTableView.isHidden = true
            noHistoryWorkOrderFoundLabel.isHidden = true
            noPendingWorkOrderFoundLabel.isHidden = true
            historyWorkOrderTableView.delegate = self
            historyWorkOrderTableView.separatorStyle = .none
            historyWorkOrderTableView.showsVerticalScrollIndicator = false
            historyWorkOrderTableView.showsHorizontalScrollIndicator = false
            pendingWorkOrderTableView.delegate = self
            pendingWorkOrderTableView.separatorStyle = .none
            pendingWorkOrderTableView.showsVerticalScrollIndicator = false
            pendingWorkOrderTableView.showsHorizontalScrollIndicator = false
            historyWorkOrderTableView.estimatedRowHeight = 200.0
            pendingWorkOrderTableView.estimatedRowHeight = 200.0

            ScreenManager.registerHistoryCell(tableView: self.historyWorkOrderTableView)
            ScreenManager.registerHistoryCell(tableView: self.pendingWorkOrderTableView)
            NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
            self.objectSelected()
        }else{
            notificationHistoryPendingModel.historyArray.removeAll()
            if isfrom == "History"{
                notificationHistoryPendingModel.getHistory()
                historyWorkOrderHeaderLabel.text = "History".localized()
            }else{
                historyWorkOrderHeaderLabel.text = "Pending".localized()
                notificationHistoryPendingModel.getPending()
            }
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
            notificationHistoryPendingModel.historyArray.removeAll()
            if isfrom == "History"{
                notificationHistoryPendingModel.getHistory()
                historyWorkOrderHeaderLabel.text = "History".localized()
            }else{
                historyWorkOrderHeaderLabel.text = "Pending".localized()
                notificationHistoryPendingModel.getPending()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func objectSelected(){
        if selectedNotificationNumber != ""{
            notificationHistoryPendingModel.getHistory()
            notificationHistoryPendingModel.getPending()
        }else{
            self.historyWorkOrderTableView.isHidden = true
            self.noHistoryWorkOrderFoundLabel.isHidden = false
            self.pendingWorkOrderTableView.isHidden = true
            self.noPendingWorkOrderFoundLabel.isHidden = false
        }
    }
    @objc func loadList(notification:Notification){
        mJCLogger.log("Starting", Type: "info")
        if  tabSelectedIndex == 5{
            notificationHistoryPendingModel.getHistory()
            historyWorkOrderHeaderLabel.text = "History".localized()
        }else if tabSelectedIndex == 6{
            historyWorkOrderHeaderLabel.text = "Pending".localized()
            notificationHistoryPendingModel.getPending()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Tableview delegate methods..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DeviceType == iPad{
            if(tableView == historyWorkOrderTableView) {
                return notificationHistoryPendingModel.historyArray.count
            }
            else{
                return notificationHistoryPendingModel.pendingArray.count
            }
        }else{
            return notificationHistoryPendingModel.historyArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if(tableView == historyWorkOrderTableView) {
            let historyCell = ScreenManager.getHistoryCell(tableView: tableView)
            historyCell.indexPath = indexPath
            historyCell.fromScreen = "history"
            mJCLogger.log("Response:\(notificationHistoryPendingModel.historyArray.count)", Type: "Debug")
            historyCell.notifHistoryPendingViewModel = notificationHistoryPendingModel
            historyCell.notifHistoryPendingModelClass = notificationHistoryPendingModel.historyArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return historyCell
        }else if(tableView == pendingWorkOrderTableView) {
            let historyCell = ScreenManager.getHistoryCell(tableView: tableView)
            historyCell.indexPath = indexPath
            historyCell.fromScreen = "pending"
            mJCLogger.log("Response:\(notificationHistoryPendingModel.pendingArray.count)", Type: "Debug")
            historyCell.notifHistoryPendingViewModel = notificationHistoryPendingModel
            historyCell.notifHistoryPendingModelClass = notificationHistoryPendingModel.pendingArray[indexPath.row]
            mJCLogger.log("Ended", Type: "info")
            return historyCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var historyAndPendingModel = HistoryAndPendingModel()
        if (tableView == historyWorkOrderTableView) {
            historyAndPendingModel = notificationHistoryPendingModel.historyArray[indexPath.row]
        }else{
            historyAndPendingModel = notificationHistoryPendingModel.pendingArray[indexPath.row]
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
    func getnoteListScreen(notificationNum : String){
            mJCLogger.log("Starting", Type: "info")
            mJCLogger.log("getnoteListScreen".localized(), Type: "")
            let noteListVC = ScreenManager.getLongTextListScreen()
            noteListVC.isAddNewNote = false
            noteListVC.fromScreen = "noHistoryPending"
            noteListVC.modalPresentationStyle = .fullScreen
            self.present(noteListVC, animated: false) {}
            mJCLogger.log("Ended", Type: "info")
    }


    //MARK:- Update UI Get History Notification List..
    func updateUIGetNotificationHistory() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.notificationHistoryPendingModel.historyArray.count > 0{
                self.historyWorkOrderTableView.reloadData()
                self.historyWorkOrderTableView.isHidden = false
                self.noHistoryWorkOrderFoundLabel.isHidden = true
            }else{
                self.historyWorkOrderTableView.isHidden = true
                self.noHistoryWorkOrderFoundLabel.isHidden = false
                if DeviceType == iPhone{
                    self.noHistoryWorkOrderFoundLabel.text = "No_History_notifications_found".localized()
                }
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIHistoryWithoutResponse() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.historyWorkOrderTableView.isHidden = true
            self.noHistoryWorkOrderFoundLabel.isHidden = false
            if DeviceType == iPhone{
                self.noHistoryWorkOrderFoundLabel.text = "No_History_notifications_found".localized()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Update UI Get Pending Notification List..
    func updateUIGetNotificationPending() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if DeviceType == iPad{
                if self.notificationHistoryPendingModel.pendingArray.count > 0{
                    self.pendingWorkOrderTableView.reloadData()
                    self.pendingWorkOrderTableView.isHidden = false
                    self.noPendingWorkOrderFoundLabel.isHidden = true
                }else{
                    self.pendingWorkOrderTableView.isHidden = true
                    self.noPendingWorkOrderFoundLabel.isHidden = false
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            if self.notificationHistoryPendingModel.historyArray.count > 0{
                self.historyWorkOrderTableView.reloadData()
                self.historyWorkOrderTableView.isHidden = false
                self.noHistoryWorkOrderFoundLabel.isHidden = true
                
            }else{
                self.historyWorkOrderTableView.isHidden = true
                self.noHistoryWorkOrderFoundLabel.isHidden = false
                if DeviceType == iPhone{
                    self.noHistoryWorkOrderFoundLabel.text = "No_Pending_notifications_found".localized()
                }
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIPendingWithoutResponse() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if DeviceType == iPad{
                self.pendingWorkOrderTableView.isHidden = true
                self.noPendingWorkOrderFoundLabel.isHidden = false
            }else{
                self.historyWorkOrderTableView.isHidden = true
                self.noHistoryWorkOrderFoundLabel.isHidden = false
                if DeviceType == iPhone{
                    self.noHistoryWorkOrderFoundLabel.text = "No_Pending_notifications_found".localized()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetLongText(from: String, indexValue: Int, notesAvailable: Bool) {
        mJCLogger.log("Starting", Type: "info")
        var historyAndPendingModel = HistoryAndPendingModel()
        if from == "pending"{
            mJCLogger.log("Response:\(notificationHistoryPendingModel.pendingArray.count)", Type: "Debug")
            historyAndPendingModel = notificationHistoryPendingModel.pendingArray[indexValue]
        }else {
            mJCLogger.log("Response:\(notificationHistoryPendingModel.historyArray.count)", Type: "Debug")
            historyAndPendingModel = notificationHistoryPendingModel.historyArray[indexValue]
        }
        if notesAvailable == true {
            historyAndPendingModel.isNotesAvailable = true
        }else{
            historyAndPendingModel.isNotesAvailable = false
        }
        if from == "pending"{
            self.pendingWorkOrderTableView.reloadData()
        }else {
            self.historyWorkOrderTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //..END..//
}
