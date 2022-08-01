//
//  OnlineNotification.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/05/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OnlineWorkOrderAndNotification: UIView,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var onlineSearchNotificationTableView: UITableView!
    @IBOutlet weak var notificationsCountLabel: UILabel!
    @IBOutlet weak var popViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var popviewHieghtconstraint: NSLayoutConstraint!
    @IBOutlet var workOrderNotifSegmentBar: UISegmentedControl!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataLabel: UILabel!
    
    var arrCount = NSMutableArray()
    var workOrderArray = Array<Any>()
    var notificationArray = Array<Any>()
    var searchType = String()
    var loadedNIb = Bool()
    var plantText = String()
    var mainWorkCenterText = String()
    var functionalLocationText = String()
    var equipmentText = String()
    var onlineWONotifCheckViewModel = OnlineWONotifCheckViewModel()
    
    func loadNibView(){
        onlineSearchArray.removeAll()
        workOrderArray.removeAll()
        notificationArray.removeAll()
        self.onlineSearchNotificationTableView.isHidden = true
        onlineWONotifCheckViewModel.onlineWorkOrderAndNotification = self
        onlineSearchNotificationTableView.estimatedRowHeight = 135
        workOrderNotifSegmentBar.setTitle("Notifications".localized(), forSegmentAt: 1)
        workOrderNotifSegmentBar.setTitle("Work_Orders".localized(), forSegmentAt: 0)
        if searchType == "Notifications"{
            self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"
            workOrderNotifSegmentBar.selectedSegmentIndex = 1
            if workOrderArray.count == 0{
                onlineWONotifCheckViewModel.getOnlineNotificationsList(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)")
            }
        }else{
            self.notificationsCountLabel.text = "Total_Workorders".localized() + ":  \(self.workOrderArray.count)"
            workOrderNotifSegmentBar.selectedSegmentIndex = 0
            if notificationArray.count == 0{
                onlineWONotifCheckViewModel.getOnlineWorkOrdersList(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)")
            }
        }
        
        if DeviceType == iPad{
            popViewWidthConstraint.constant = 900
            popviewHieghtconstraint.constant = 700
            
        }else{
            self.notificationsCountLabel.font = UIFont(name: "System-Medium", size: 16)
            self.closeButton.titleLabel?.font = UIFont(name: "System-Medium", size: 18)
            popViewWidthConstraint.constant = 360
            popviewHieghtconstraint.constant = 550
        }
        self.onlineSearchNotificationTableView.dataSource = self
        self.onlineSearchNotificationTableView.delegate = self
        self.onlineSearchNotificationTableView.tableFooterView = UIView()
        ScreenManager.registerWorkOrderCell(tableView: self.onlineSearchNotificationTableView)
        
        if onlineSearchArray.count > 0 {
            self.onlineSearchNotificationTableView.isHidden = false
            self.noDataLabel.isHidden = true
            self.noDataView.isHidden = true
            if let arr = onlineSearchArray as? [WoHeaderModel]{
                self.workOrderArray.removeAll()
                self.workOrderArray.append(contentsOf: arr)
                self.notificationsCountLabel.text = "Total_Workorders".localized() + ":  \(self.workOrderArray.count)"
            }else if let arr = onlineSearchArray as? [NotificationModel]{
                self.workOrderArray.removeAll()
                self.workOrderArray.append(contentsOf: arr)
                self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"
            }
            DispatchQueue.main.async{
                self.onlineSearchNotificationTableView.reloadData()
            }
        }else{
            self.noDataLabel.isHidden = false
            self.noDataView.isHidden = false
            self.onlineSearchNotificationTableView.isHidden = true
        }
        onlineSearchNotificationTableView.layer.cornerRadius = 15
        onlineSearchNotificationTableView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        onlineSearch = false
        removeFromSuperview()
    }
    @IBAction func workorderNotifiSearchSegment(_ sender: UISegmentedControl) {
        mJCLogger.log("Starting", Type: "info")
        if workOrderNotifSegmentBar.selectedSegmentIndex == 0 {
            self.notificationsCountLabel.text = "Total_Workorders".localized() + ":  \(self.workOrderArray.count)"
            workOrderNotifSegmentBar.setTitle("Work_Orders".localized(), forSegmentAt: 0)
            if workOrderArray.count == 0{
                onlineWONotifCheckViewModel.getOnlineWorkOrdersList(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)")
            }
            self.searchType = "WorkOrder"
            onlineWONotifCheckViewModel.searchType = "WorkOrder"
        }else if workOrderNotifSegmentBar.selectedSegmentIndex == 1 {
            self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"
            workOrderNotifSegmentBar.setTitle("Notifications".localized(), forSegmentAt: 1)
            if notificationArray.count == 0{
                onlineWONotifCheckViewModel.getOnlineNotificationsList(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)")
            }
            self.searchType = "Notifications"
            onlineWONotifCheckViewModel.searchType = "Notifications"
        }
        self.onlineSearchUpdateUI()
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchType == "Notifications"{
            return notificationArray.count
        }else{
            return workOrderArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getWorkOrderCell(tableView: tableView)
        if self.searchType == "Notifications"{
            cell.indexpath = indexPath
            cell.onlineWONotifCheckViewModel = self.onlineWONotifCheckViewModel
            if notificationArray.count > 0{
                if let selectedClass = notificationArray[indexPath.row] as? NotificationModel{
                    cell.onlineNotificationClass = selectedClass
                }
            }
        }else{
            cell.indexpath = indexPath
            cell.onlineWONotifCheckViewModel = self.onlineWONotifCheckViewModel
            if workOrderArray.count > 0{
                if let selectedClass = workOrderArray[indexPath.row] as? WoHeaderModel{
                    cell.onlineWorkOrderClass = selectedClass
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func onlineSearchUpdateUI(){
        DispatchQueue.main.async {
            if self.searchType == "Notifications"{
                self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"
                if self.notificationArray.count > 0{
                    self.noDataLabel.isHidden = true
                    self.noDataView.isHidden = true
                    self.onlineSearchNotificationTableView.isHidden = false
                }else{
                    self.noDataLabel.isHidden = false
                    self.noDataView.isHidden = false
                    self.onlineSearchNotificationTableView.isHidden = true
                }
            }else{
                self.notificationsCountLabel.text = "Total_Workorders".localized() + ":  \(self.workOrderArray.count)"
                if self.workOrderArray.count > 0{
                    self.noDataLabel.isHidden = true
                    self.noDataView.isHidden = true
                    self.onlineSearchNotificationTableView.isHidden = false
                }else{
                    self.noDataLabel.isHidden = false
                    self.noDataView.isHidden = false
                    self.onlineSearchNotificationTableView.isHidden = true
                }
            }
            self.onlineSearchNotificationTableView.reloadData()
        }
    }
}

