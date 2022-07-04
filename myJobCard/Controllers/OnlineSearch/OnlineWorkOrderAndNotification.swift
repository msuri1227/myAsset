//
//  OnlineNotification.swift
//  myJobCard
//
//  Created by Navdeep Singla on 12/05/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OnlineWorkOrderAndNotification: UIView,UITableViewDataSource,UITableViewDelegate,UsernamePasswordProviderProtocol{
    
    

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
    var onlineWONotifCheckViewModel = OnlineWONotifCheckViewModel()
    var plantText = String()
    var mainWorkCenterText = String()
    var functionalLocationText = String()
    var equipmentText = String()
    var viewController = String()

    
    func loadNibView(){
        onlineSearchArray.removeAll()
        workOrderArray.removeAll()
        notificationArray.removeAll()
        self.onlineSearchNotificationTableView.isHidden = true
        onlineWONotifCheckViewModel.onlineWorkOrderAndNotification = self

        workOrderNotifSegmentBar.setTitle("Notifications".localized(), forSegmentAt: 1)
        workOrderNotifSegmentBar.setTitle("Work_Orders".localized(), forSegmentAt: 0)
        if searchType == "Notifications"{
            self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"

            workOrderNotifSegmentBar.selectedSegmentIndex = 1
            if workOrderArray.count == 0{
            onlineWONotifCheckViewModel.checkOnlineNotificationsListForCreateNotification(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)", viewController: viewController)
            }

        }else{
            self.notificationsCountLabel.text = "Total_WorkOrders".localized() + ":  \(self.workOrderArray.count)"

            workOrderNotifSegmentBar.selectedSegmentIndex = 0
            if notificationArray.count == 0{
            onlineWONotifCheckViewModel.checkOnlineWorkOrdersListForCreateWorkorder(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)", viewController: viewController)
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
        self.onlineSearchNotificationTableView.register(UINib(nibName: "WorkOrderCell", bundle: nil), forCellReuseIdentifier: "WorkOrderCell")
        
        if onlineSearchArray.count > 0 {
            self.onlineSearchNotificationTableView.isHidden = false
            self.noDataLabel.isHidden = true
            self.noDataView.isHidden = true
            if let arr = onlineSearchArray as? [WoHeaderModel]{
                self.workOrderArray.removeAll()
                self.workOrderArray.append(contentsOf: arr)
                self.notificationsCountLabel.text = "Total_WorkOrders".localized() + ":  \(self.workOrderArray.count)"

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
    
    func provideUsernamePassword(forAuthChallenge authChallenge: URLAuthenticationChallenge!, completionBlock: username_password_provider_completion_t!) {
        
        DispatchQueue.main.async {
            if let dict =  UserDefaults.standard.value(forKey:"login_Details") as? NSDictionary {
                let username = dict.value(forKey: "userName") as! String
                let password = dict.value(forKey: "password") as! String
                mJCLogger.log("Login@@login_Details 24 \(username) \(password)",Type: "")
                let credential = URLCredential(user: username, password: password, persistence: .forSession)
                completionBlock(credential, nil)
            }
        }
    }


    @IBAction func closeButtonAction(_ sender: Any) {
        
        removeFromSuperview()
    }
    
    @IBAction func workorderNotifiSearchSegment(_ sender: UISegmentedControl) {
        mJCLogger.log("Starting", Type: "info")
        if workOrderNotifSegmentBar.selectedSegmentIndex == 0 {
            self.notificationsCountLabel.text = "Total_WorkOrders".localized() + ":  \(self.workOrderArray.count)"

            workOrderNotifSegmentBar.setTitle("Work_Orders".localized(), forSegmentAt: 0)
            if workOrderArray.count == 0{
            onlineWONotifCheckViewModel.checkOnlineWorkOrdersListForCreateWorkorder(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)", viewController: viewController)
            }
            self.searchType = "WorkOrder"
            onlineWONotifCheckViewModel.searchType = "WorkOrder"
        }
        else if workOrderNotifSegmentBar.selectedSegmentIndex == 1 {
            self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"
            workOrderNotifSegmentBar.setTitle("Notifications".localized(), forSegmentAt: 1)
            if notificationArray.count == 0{
            onlineWONotifCheckViewModel.checkOnlineNotificationsListForCreateNotification(plantText: "\(plantText)", mainWorkCenterText: "\(mainWorkCenterText)", functionalLocationText: "\(functionalLocationText)", equipmentText: "\(equipmentText)", viewController: viewController)
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
        let cell : WorkOrderCell! = tableView.dequeueReusableCell(withIdentifier: "WorkOrderCell") as? WorkOrderCell
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
        if onlineSearchArray.count > 0 {
            self.noDataLabel.isHidden = true
            self.noDataView.isHidden = true
            self.onlineSearchNotificationTableView.isHidden = false
            if searchType == "Notifications"{
            self.notificationsCountLabel.text = "Total_Notifications".localized() + ":  \(self.notificationArray.count)"
            }else{
            self.notificationsCountLabel.text = "Total_WorkOrders".localized() + ":  \(self.workOrderArray.count)"

            }

            DispatchQueue.main.async {
                self.onlineSearchNotificationTableView.reloadData()
            }
        }else{
            
            self.noDataLabel.isHidden = false
            self.noDataView.isHidden = false
            self.onlineSearchNotificationTableView.isHidden = true
        }
    }
}

