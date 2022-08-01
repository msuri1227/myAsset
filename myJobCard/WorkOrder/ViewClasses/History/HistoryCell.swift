//
//  HistoryCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/7/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class HistoryCell: UITableViewCell {
    
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var typeView: UIView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var workOrdNumberView: UIView!
    @IBOutlet var workOrdNumberLabel: UILabel!
    @IBOutlet var workorderLabel: UILabel!
    @IBOutlet var priorityView: UIView!
    @IBOutlet var priorityLabel: UILabel!
    @IBOutlet var startView: UIView!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endView: UIView!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var viewNotesButton: UIButton!
    @IBOutlet var componentsButton: UIButton!
    @IBOutlet var viewMoreButton: UIButton!
    @IBOutlet var operationsButton: UIButton!
    @IBOutlet weak var startViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var endViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewNotesHeightConstraint: NSLayoutConstraint!
    
    var fromScreen = String()
    var indexPath = IndexPath()
    weak var vcWOHistoryPending: HistoryAndPendingVC?
    var historyPendingViewModel = WorkOrderHistoryAndPendingViewModel()
    var notifHistoryPendingViewModel = NotificationHistoryAndPendingViewModel()
    
    var historyPendingModelClass: HistoryAndPendingModel? {
        didSet{
            historyAndPendingConfiguration()
        }
    }
    var notifHistoryPendingModelClass: HistoryAndPendingModel? {
        didSet{
            notifHistoryAndPendingConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewNotesButton.layer.cornerRadius = 5
        self.viewNotesButton.layer.borderColor = appColor.cgColor
        self.viewNotesButton.layer.borderWidth = 2
        self.operationsButton.layer.cornerRadius = 5
        self.operationsButton.layer.borderColor = appColor.cgColor
        self.operationsButton.layer.borderWidth = 2
        self.componentsButton.layer.cornerRadius = 5
        self.componentsButton.layer.borderColor = appColor.cgColor
        self.componentsButton.layer.borderWidth = 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK:- Work Order History and Pending Configuration
    
    func historyAndPendingConfiguration() {
        
        mJCLogger.log("Starting", Type: "info")
        if fromScreen == "history" {
            backGroundView.layer.cornerRadius = 3.0
            descriptionLabel.text = historyPendingModelClass?.ShortText
            typeLabel.text = historyPendingModelClass?.OrderType
            workOrdNumberLabel.text = historyPendingModelClass?.WorkOrderNum
            priorityLabel.text = historyPendingModelClass?.Priority
            if historyPendingModelClass?.BasicStartDate != nil{
                startLabel.text = historyPendingModelClass?.BasicStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                startLabel.text = ""
            }
            if historyPendingModelClass?.TechCompletion != nil{
                endLabel.text = historyPendingModelClass?.TechCompletion!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                endLabel.text = ""
            }
            viewMoreButton.tag = indexPath.row
            viewNotesButton.tag = indexPath.row
            operationsButton.tag = indexPath.row
            componentsButton.tag = indexPath.row
            viewMoreButton.addTarget(self, action: #selector(history_MoreButtonClicked), for: UIControl.Event.touchUpInside)
            viewNotesButton.addTarget(self, action: #selector(history_viewNotesButtonClicked), for: UIControl.Event.touchUpInside)
            componentsButton.addTarget(self, action: #selector(componentHistoryClicked), for: .touchUpInside)
            operationsButton.addTarget(self, action: #selector(history_OperationsButtonClicked), for: UIControl.Event.touchUpInside)
            if historyPendingModelClass!.isExpandCell {
                startView.isHidden = false
                endView.isHidden = false
                viewMoreButton.isSelected = true
            }else {
                startView.isHidden = true
                endView.isHidden = true
                viewMoreButton.isSelected = false
            }
        }else{
            descriptionLabel.text = historyPendingModelClass?.ShortText
            typeLabel.text = historyPendingModelClass?.OrderType
            workOrdNumberLabel.text = historyPendingModelClass?.WorkOrderNum
            priorityLabel.text = historyPendingModelClass?.Priority
            if historyPendingModelClass?.Startdate != nil{
                startLabel.text = historyPendingModelClass?.Startdate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                startLabel.text = ""
            }
            if historyPendingModelClass?.TechCompletion != nil{
                endLabel.text = historyPendingModelClass?.TechCompletion!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                endLabel.text = ""
            }
            viewMoreButton.tag = indexPath.row
            componentsButton.isHidden = true
            operationsButton.tag = indexPath.row
            viewNotesButton.tag = indexPath.row
            viewMoreButton.addTarget(self, action: #selector(pending_MoreButtonClicked), for: UIControl.Event.touchUpInside)
            operationsButton.addTarget(self, action: #selector(pending_OperationsButtonClicked), for: UIControl.Event.touchUpInside)
            viewNotesButton.addTarget(self, action: #selector(pending_viewNotesButtonClicked), for: .touchUpInside)
            if historyPendingModelClass!.isExpandCell {
                startView.isHidden = false
                endView.isHidden = false
                viewMoreButton.isSelected = true
            }else {
                startView.isHidden = true
                endView.isHidden = true
                viewMoreButton.isSelected = false
                viewMoreButton.isSelected = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TablewView Cell Button Action
    @objc func history_MoreButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if sender.isSelected == true {
            let historyAndPendingModel = historyPendingViewModel.historyArray[sender.tag]
            historyAndPendingModel.isExpandCell = false
        }else {
            let historyAndPendingModel = historyPendingViewModel.historyArray[sender.tag]
            historyAndPendingModel.isExpandCell = true
            historyPendingViewModel.getLongTextSet(WorkOrderNum: historyAndPendingModel.WorkOrderNum, index: sender.tag, from: "history")
        }
        historyPendingViewModel.vcWOHistoryPending?.historyWorkOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func history_viewNotesButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_HISANDPEN_OP_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("history_viewNotesButtonClicked".localized(), Type: "")
                let historyAndPendingModel = historyPendingViewModel.historyArray[sender.tag]
                historyPendingViewModel.vcWOHistoryPending?.getnoteListScreen(WorkOrderNum: historyAndPendingModel.WorkOrderNum)
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func history_OperationsButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        historyPendingViewModel.vcWOHistoryPending?.updateUIhistory_OperationsButton(tagValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func componentHistoryClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        historyPendingViewModel.vcWOHistoryPending?.updateUIComponentHistory(tagValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func pending_MoreButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if sender.isSelected == true {
            if DeviceType == iPhone {
                let historyAndPendingModel = historyPendingViewModel.historyArray[sender.tag]
                historyAndPendingModel.isExpandCell = false
                historyPendingViewModel.vcWOHistoryPending?.historyWorkOrderTableView
                    .reloadData()
            }else {
                let historyAndPendingModel = historyPendingViewModel.pendingArray[sender.tag]
                historyAndPendingModel.isExpandCell = false
                historyPendingViewModel.vcWOHistoryPending?.pendingWorkOrderTableView.reloadData()
            }
        }else {
            if DeviceType == iPhone {
                let historyAndPendingModel = historyPendingViewModel.historyArray[sender.tag]
                historyAndPendingModel.isExpandCell = true
                historyPendingViewModel.getLongTextSet(WorkOrderNum: historyAndPendingModel.WorkOrderNum, index: sender.tag, from: "pending")
                historyPendingViewModel.vcWOHistoryPending?.historyWorkOrderTableView
                    .reloadData()
            }else {
                let historyAndPendingModel = historyPendingViewModel.pendingArray[sender.tag]
                historyAndPendingModel.isExpandCell = true
                historyPendingViewModel.getLongTextSet(WorkOrderNum: historyAndPendingModel.WorkOrderNum, index: sender.tag, from: "pending")
                historyPendingViewModel.vcWOHistoryPending?.pendingWorkOrderTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func pending_OperationsButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        historyPendingViewModel.vcWOHistoryPending?.updateUIpending_OperationsButton(tagValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func pending_viewNotesButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_HIS&PEN_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let historyPendingModel = historyPendingViewModel.pendingArray[sender.tag]
                historyPendingViewModel.vcWOHistoryPending?.getnoteListScreen(WorkOrderNum: historyPendingModel.WorkOrderNum)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification History and Pending Configuration
    func notifHistoryAndPendingConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if fromScreen == "history" {
            backGroundView.layer.cornerRadius = 3.0
            descriptionLabel.text = notifHistoryPendingModelClass?.Description
            typeLabel.text = notifHistoryPendingModelClass?.NotificationType
            workOrdNumberLabel.text = notifHistoryPendingModelClass?.Notification
            workorderLabel.text = "Notification".localized()
            priorityLabel.text = notifHistoryPendingModelClass?.Priority
            if notifHistoryPendingModelClass?.ReqStart != nil{
                startLabel.text = notifHistoryPendingModelClass?.ReqStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                startLabel.text = ""
            }
            if notifHistoryPendingModelClass?.RequiredEnd != nil{
                endLabel.text = notifHistoryPendingModelClass?.RequiredEnd!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                endLabel.text = ""
            }
            componentsButton.isHidden = true
            operationsButton.isHidden = true
            viewMoreButton.tag = indexPath.row
            viewNotesButton.tag = indexPath.row
            operationsButton.tag = indexPath.row
            viewMoreButton.addTarget(self, action: #selector(notificationHistory_MoreButtonClicked), for: UIControl.Event.touchUpInside)
            viewNotesButton.addTarget(self, action: #selector(notificationHistory_viewNotesButtonClicked), for: UIControl.Event.touchUpInside)
            operationsButton.addTarget(self, action: #selector(notificationHistory_OperationsButtonClicked), for: UIControl.Event.touchUpInside)
            
            if notifHistoryPendingModelClass!.isExpandCell {
                startView.isHidden = false
                endView.isHidden = false
                viewMoreButton.isSelected = true
            }else {
                startView.isHidden = true
                endView.isHidden = true
                viewMoreButton.isSelected = false
            }
        }else{
            descriptionLabel.text = notifHistoryPendingModelClass?.Description
            typeLabel.text = notifHistoryPendingModelClass?.NotificationType
            workOrdNumberLabel.text = notifHistoryPendingModelClass?.Notification
            workorderLabel.text = "Notification".localized()
            priorityLabel.text = notifHistoryPendingModelClass?.Priority
            if notifHistoryPendingModelClass?.ReqStart != nil{
                startLabel.text = notifHistoryPendingModelClass?.ReqStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                startLabel.text = ""
            }
            if notifHistoryPendingModelClass?.RequiredEnd != nil{
                endLabel.text = notifHistoryPendingModelClass?.RequiredEnd!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                endLabel.text = ""
            }
            operationsButton.isHidden = true
            componentsButton.isHidden = true
            viewMoreButton.tag = indexPath.row
            viewNotesButton.tag = indexPath.row
            operationsButton.tag = indexPath.row
            
            viewMoreButton.addTarget(self, action: #selector(notificationPending_MoreButtonClicked), for: UIControl.Event.touchUpInside)
            viewNotesButton.addTarget(self, action: #selector(notificationPending_viewNotesButtonClicked), for: UIControl.Event.touchUpInside)
            operationsButton.addTarget(self, action: #selector(notificationPending_OperationsButtonClicked), for: UIControl.Event.touchUpInside)
            
            if notifHistoryPendingModelClass!.isExpandCell {
                startView.isHidden = false
                endView.isHidden = false
                viewMoreButton.isSelected = true
            }else {
                startView.isHidden = true
                endView.isHidden = true
                viewMoreButton.isSelected = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TableView Cell Button Clicked..
    @objc func notificationHistory_MoreButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if sender.isSelected == true {
            let historyAndPendingModel = notifHistoryPendingViewModel.historyArray[sender.tag]
            historyAndPendingModel.isExpandCell = false
        }else {
            let historyAndPendingModel = notifHistoryPendingViewModel.historyArray[sender.tag]
            historyAndPendingModel.isExpandCell = true
            notifHistoryPendingViewModel.getLongTextSet(NotificationNum: historyAndPendingModel.Notification, index: sender.tag, from: "history")
        }
        notifHistoryPendingViewModel.vcNOHistoryPending?.historyWorkOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func notificationHistory_viewNotesButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_HISANDPEN_OP_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("notificationHistory_viewNotesButtonClicked".localized(), Type: "")
                let historyAndPendingModel = notifHistoryPendingViewModel.historyArray[sender.tag]
                notifHistoryPendingViewModel.vcNOHistoryPending?.getnoteListScreen(notificationNum: historyAndPendingModel.Notification)
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func notificationHistory_OperationsButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if let historyAndPendingModel = notifHistoryPendingViewModel.historyArray[sender.tag] as? HistoryAndPendingModel {
            //            let historyandpendingOprListVc = ScreenManager.getHistoryAndPendingOprListScreen()
            //            historyandpendingOprListVc.checkServiceList = "historyOperations"
            //            historyandpendingOprListVc.referenceWorkOrderStr = historyAndPendingModel.ReferenceOrder
            //            historyandpendingOprListVc.workOrderNumberStr = historyAndPendingModel.WorkOrderNum
            //            // self.modalPresentationStyle = UIModalPresentationStyle.currentContext
            //            historyandpendingOprListVc.modalPresentationStyle = .fullScreen
            //            self.present(historyandpendingOprListVc, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func notificationPending_MoreButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if sender.isSelected == true {
            let historyAndPendingModel = notifHistoryPendingViewModel.pendingArray[sender.tag]
            historyAndPendingModel.isExpandCell = false
        }else {
            let historyAndPendingModel = notifHistoryPendingViewModel.pendingArray[sender.tag]
            historyAndPendingModel.isExpandCell = true
            notifHistoryPendingViewModel.getLongTextSet(NotificationNum: historyAndPendingModel.Notification, index: sender.tag, from: "pending")
        }
        notifHistoryPendingViewModel.vcNOHistoryPending?.pendingWorkOrderTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func notificationPending_viewNotesButtonClicked(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        let historyAndPendingModel = notifHistoryPendingViewModel.pendingArray[sender.tag]
        notifHistoryPendingViewModel.vcNOHistoryPending?.getnoteListScreen(notificationNum: historyAndPendingModel.Notification)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func notificationPending_OperationsButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if let historyAndPendingModel = notifHistoryPendingViewModel.pendingArray[sender.tag] as? HistoryAndPendingModel {
            //            let historyandpendingOprListVc = ScreenManager.getHistoryAndPendingOprListScreen()
            //
            //            historyandpendingOprListVc.checkServiceList = "PendingOperations"
            //            historyandpendingOprListVc.referenceWorkOrderStr = historyAndPendingModel.ReferenceOrder
            //            historyandpendingOprListVc.workOrderNumberStr = historyAndPendingModel.WorkOrderNum
            //
            //            // self.modalPresentationStyle = UIModalPresentationStyle.currentContext
            //            historyandpendingOprListVc.modalPresentationStyle = .fullScreen
            //            self.present(historyandpendingOprListVc, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
