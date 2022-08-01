//
//  OnlineItemOprVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 19/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class OnlineItemOprVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ListTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var itemNumLbl: UILabel!
    

    var isfrom = String()
    var onlineItemOprModel = OnlineItemOprViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        onlineItemOprModel.vcOnlineItemOpr = self
        self.noDataView.isHidden = false
        self.ListTableView.isHidden = true
        ListTableView.estimatedRowHeight = 570
        ListTableView.rowHeight = UITableView.automaticDimension
        if isfrom == "NotificationItem" {
            if singleNotification.NavNOItem.count != 0 {
                mJCLogger.log("Response:\(singleNotification.NavNOItem.count)", Type: "Debug")
                onlineItemOprModel.getOnlineNotificationItem()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            ScreenManager.registerNotificationItemCell(tableView: self.ListTableView)
        }else{
            if singleWorkOrder.NAVOPERA.count != 0 {
                mJCLogger.log("Response:\(singleWorkOrder.NAVOPERA.count)", Type: "Debug")
                onlineItemOprModel.getOnlineWorkorderOperation()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            ScreenManager.registerOnlineOperationsCell(tableView: self.ListTableView)
        }
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        self.ListTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        self.ListTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIOnlineNotificationItem() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.onlineItemOprModel.totalItemsArr.count > 0 {
                mJCLogger.log("Response:\(self.onlineItemOprModel.totalItemsArr.count)", Type: "Debug")
                self.noDataView.isHidden = true
                self.ListTableView.isHidden = false
                if DeviceType == iPhone{
                    self.itemNumLbl.text = "Total_Items".localized() + " \(self.onlineItemOprModel.totalItemsArr.count)"
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.noDataView.isHidden = false
                self.ListTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIOnlineWithoutResponse() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.noDataView.isHidden = false
            self.ListTableView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIOnlineWorkOrderOperation() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.onlineItemOprModel.totalItemsArr.count > 0 {
                mJCLogger.log("Response:\(self.onlineItemOprModel.totalItemsArr.count)", Type: "Debug")
                self.noDataView.isHidden = true
                self.ListTableView.isHidden = false
                if DeviceType == iPhone{
                    self.itemNumLbl.text = "Total_Operations".localized() + ": \(self.onlineItemOprModel.totalItemsArr.count)"
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.noDataView.isHidden = false
                self.ListTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Data Source & Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType == iPad {
            return 220
        }else {
            return 653
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineItemOprModel.totalItemsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if isfrom == "NotificationItem"{
            let cell = ScreenManager.getNotificationItemCell(tableView: tableView)
            mJCLogger.log("Response:\(self.onlineItemOprModel.totalItemsArr.count)", Type: "Debug")
            cell.onlineNOItemModelClass = onlineItemOprModel.totalItemsArr[indexPath.row] as? NotificationItemsModel
            mJCLogger.log("Ended", Type: "info")
            return cell
        }else{
            let cell = ScreenManager.getOnlineOperationsCell(tableView: tableView)
            mJCLogger.log("Response:\(self.onlineItemOprModel.totalItemsArr.count)", Type: "Debug")
            cell.indexPath = indexPath
            cell.onlineOperationViewModel = onlineItemOprModel
            cell.onlineOperationModelClass = onlineItemOprModel.totalItemsArr[indexPath.row] as? WoOperationModel
            mJCLogger.log("Ended", Type: "info")
            return  cell
        }
    }
    func updateUITransferOnlineOperation(tagValue: Int) {
        singleOperation = WoOperationModel()
        singleOperation = onlineItemOprModel.totalItemsArr[tagValue] as! WoOperationModel
        menuDataModel.uniqueInstance.presentWorkOrderTransferScreen(vc: self, rejectStr: "Transfer", priorityVal: singleOperation.Priority, transferOperationCls: onlineItemOprModel.totalItemsArr[tagValue] as? WoOperationModel)
    }
    @IBAction func backBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.navigationController?.popViewController(animated: true)
        mJCLogger.log("Ended", Type: "info")
    }
}
