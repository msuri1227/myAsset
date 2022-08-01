//
//  // swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationActivityCell: UITableViewCell {
    
    @IBOutlet var notificationActivityTextLabel: UILabel!
    @IBOutlet var notificationActivityNumberLabel: UILabel!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var activityCellButton: UIButton!
    @IBOutlet var transperentView: UIView!
    
    var isfrom = ""
    
    var indexPath = IndexPath()
    
    var NotificationTaskModel:NotificationTaskModel?{
        didSet{
            configureNotificationTaskActivityCell()
        }
    }
    var NotificationItemsModel:NotificationItemsModel?{
        didSet{
            configureNotificationItemActivityCell()
        }
    }
    
    var notifItemCauseModelClass:NotificationItemCauseModel?{
        didSet{
            configureNotificationItemCauseActivityCell()
        }
    }
    
    var notificationItemListModelClass:NotificationItemsModel?{
        didSet{
            configureNotificationItemListActivityCell()
        }
    }
    
    var notificationActivityModel:NotificationActivityModel?{
        didSet{
            configureNotificationActivityCell()
        }
    }
    
    var notificationItemTaskModelClass:NotificationTaskModel?{
        didSet{
            configureNotificationItemListActivityCell()
        }
    }
    
    var notificationItemCausesModelClass:NotificationItemCauseModel?{
        didSet{
            configureNotificationItemListActivityCell()
        }
    }


    
    var notificationTaskViewModel = NotificationTaskViewModel()
    var notificationItemViewModel = NotificationItemViewModel()
    var notificationItemCausesViewModel = NotificationItemCausesViewModel()
    var notificationActivityViewModel = NotificationActivityViewModel()
    var notifItemListViewModel = NotifItemListViewModel()

    func configureNotificationItemCauseActivityCell(){
        mJCLogger.log("Starting", Type: "info")
        if let NotificationItemCauseModel = notifItemCauseModelClass {
            if notificationItemCausesViewModel.vc?.isFromScreen == "ItemCause"{
                notificationActivityNumberLabel.text = NotificationItemCauseModel.Cause
                notificationActivityTextLabel.text = NotificationItemCauseModel.CauseText
               activityCellButton.isHidden = false
               activityCellButton.tag = indexPath.row
               activityCellButton.addTarget(self, action: #selector(self.itemCauseCellButtonClicked), for: .touchUpInside)
                
                if NotificationItemCauseModel.isSelected == true {
                   transperentView.isHidden = false
                }
                else {
                   transperentView.isHidden = true
                }
            }

        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func configureNotificationItemActivityCell(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemViewModel.totalItemArray.count > 0 {
            mJCLogger.log("Response:\(notificationItemViewModel.totalItemArray.count)", Type: "Debug")
            if let notificationItemsClass = notificationItemViewModel.totalItemArray[indexPath.row] as? NotificationItemsModel {
            
            backGroundView.layer.cornerRadius = 3.0
            backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
            backGroundView.layer.shadowOpacity = 0.2
            backGroundView.layer.shadowRadius = 2
            
            notificationActivityNumberLabel.text = notificationItemsClass.Item
            notificationActivityTextLabel.text = notificationItemsClass.ShortText
            
            activityCellButton.isHidden = false
            activityCellButton.tag = indexPath.row
            activityCellButton.addTarget(self, action: #selector(self.itemCellButtonClicked), for: .touchUpInside)
            
                if selectedItem == notificationItemsClass.Item {

                    if (notificationItemsClass.isSelected == true) {

                        transperentView.isHidden = false

                        notificationItemViewModel.did_DeSelectedCell = indexPath.row

                    }
                    else {

                        transperentView.isHidden = true
                    }

                }
            else {
                
                transperentView.isHidden = true
            }

        }
        
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    func configureNotificationTaskActivityCell(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.vc?.isFromScreen == "ItemTask"{
            
            let notificationItemsClass = notificationItemCausesViewModel.totalTaskArray[indexPath.row]
           notificationActivityNumberLabel.text = notificationItemsClass.Task
           notificationActivityTextLabel.text = notificationItemsClass.TaskText
           activityCellButton.isHidden = false
           activityCellButton.tag = indexPath.row
           activityCellButton.addTarget(self, action: #selector(self.itemCauseCellButtonClicked), for: .touchUpInside)
            
            if (notificationItemsClass.isSelected == true) {
               transperentView.isHidden = false
            }
            else {
               transperentView.isHidden = true
            }
        }else{
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
        backGroundView.layer.shadowOpacity = 0.2
        backGroundView.layer.shadowRadius = 2
            
            if let NotificationTaskModel = NotificationTaskModel {
                notificationActivityNumberLabel.text = NotificationTaskModel.Task
                notificationActivityTextLabel.text = NotificationTaskModel.TaskText
                
                activityCellButton.isHidden = false
                activityCellButton.tag = indexPath.row
                activityCellButton.addTarget(self, action: #selector(self.taskCellButtonClicked), for: .touchUpInside)
                
                if notificationTaskViewModel.selectedTask == NotificationTaskModel.Task {
                    
                    if (NotificationTaskModel.isSelected == true) {
                        transperentView.isHidden = false
                        notificationTaskViewModel.did_DeSelectedCell = indexPath.row
                    }
                    else {
                        transperentView.isHidden = true
                    }
                }
                else {
                    transperentView.isHidden = true
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func configureNotificationActivityCell(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.vc?.isFromScreen == "ItemActivity"{
            notificationActivityNumberLabel.text = notificationActivityModel?.Activity
            notificationActivityTextLabel.text = notificationActivityModel?.ActivityText
            if DeviceType == iPad {
                activityCellButton.isHidden = false
            }else{
                activityCellButton.isHidden = true
            }
            activityCellButton.tag = indexPath.row
            
            activityCellButton.addTarget(self, action: #selector(self.itemCauseCellButtonClicked), for: .touchUpInside)

            
            if (notificationActivityModel?.isSelected == true) {
               transperentView.isHidden = false
            }
            else {
                transperentView.isHidden = true
            }
            
        }else{
            
            
           backGroundView.layer.cornerRadius = 3.0
           backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
           backGroundView.layer.shadowOpacity = 0.2
           backGroundView.layer.shadowRadius = 2
           if DeviceType == iPad {
                activityCellButton.isHidden = false
           }else{
                activityCellButton.isHidden = true
           }
            
           activityCellButton.tag = indexPath.row
           activityCellButton.addTarget(self, action: #selector(activityCellButtonClicked), for: .touchUpInside)
            
            notificationActivityNumberLabel.text = notificationActivityModel?.Activity
            notificationActivityTextLabel.text = notificationActivityModel?.ActivityText
            
            if notificationActivityViewModel.selectedActivity == notificationActivityModel?.Activity {
                
                if (notificationActivityModel?.isSelected == true) {
                    if DeviceType == iPad{

                   transperentView.isHidden = false
                    }
                    notificationActivityViewModel.did_DeSelectedCell = indexPath.row
                    
                }
                else {
                    if DeviceType == iPad{
                   transperentView.isHidden = true
                    }
                }
                
            }
            else {
                if DeviceType == iPad{

               transperentView.isHidden = true
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Task Cell Button Action..
    @objc func taskCellButtonClicked(sender:UIButton) {
        
        mJCLogger.log("Starting", Type: "info")

        let notificationActivity = notificationTaskViewModel.totalTaskArray[notificationTaskViewModel.did_DeSelectedCell]
        notificationActivity.isSelected = false
        
        let notificationActivity1 = notificationTaskViewModel.totalTaskArray[sender.tag]
        notificationActivity1.isSelected = true
        notificationTaskViewModel.selectedTask = notificationActivity1.Task
        selectedTask = notificationActivity1.Task
        
        notificationTaskViewModel.didSelectedCell = sender.tag
        notificationTaskViewModel.did_DeSelectedCell = notificationTaskViewModel.didSelectedCell
        if DeviceType == iPad{
            notificationTaskViewModel.vc!.totalTaskTableView.reloadData()
        }
        notificationTaskViewModel.getSingleTaskData()
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    
    //MARK:- ItemsCell Button Action..
    @objc func itemCellButtonClicked(sender:UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if notificationItemViewModel.totalItemArray.count > 0{
            mJCLogger.log("Response:\(notificationItemViewModel.totalItemArray.count)", Type: "Debug")
            selectedItemTask = ""
            selectedItemCause = ""
            selectedItemActivity = ""
            
        let notificationActivity = notificationItemViewModel.totalItemArray[notificationItemViewModel.did_DeSelectedCell]
        notificationActivity.isSelected = false
        
        let notificationActivity1 = notificationItemViewModel.totalItemArray[sender.tag]
        notificationActivity1.isSelected = true
        selectedItem = notificationActivity1.Item
        selectedItem = notificationActivity1.Item
        notificationItemViewModel.didSelectedCell = sender.tag
        notificationItemViewModel.did_DeSelectedCell = notificationItemViewModel.didSelectedCell
        if DeviceType == iPad{
            notificationItemViewModel.vc!.totalItemTableView.reloadData()
        }
        notificationItemViewModel.getSingleItemData()
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    //MARK:- ItemsCell Button Action..
    @objc func itemCauseCellButtonClicked(sender:UIButton) {
        
        mJCLogger.log("Starting", Type: "info")

        if notificationItemCausesViewModel.vc?.isFromScreen == "ItemTask" {
            notificationItemCausesViewModel.didSelectedCell = sender.tag

            notificationItemCausesViewModel.taskClass = notificationItemCausesViewModel.totalTaskArray[notificationItemCausesViewModel.didSelectedCell]

            if let notificationActivity = notificationItemCausesViewModel.totalTaskArray[notificationItemCausesViewModel.did_DeSelectedCell] as? NotificationTaskModel {
            notificationActivity.isSelected = false
            
                if let notificationActivity1 = notificationItemCausesViewModel.totalTaskArray[sender.tag] as? NotificationTaskModel {
            notificationActivity1.isSelected = true
            notificationItemCausesViewModel.selectedTask = notificationActivity1.Task
            
            notificationItemCausesViewModel.didSelectedCell = sender.tag
            notificationItemCausesViewModel.did_DeSelectedCell = notificationItemCausesViewModel.didSelectedCell
                selectedItemTask = notificationItemCausesViewModel.taskClass.Task
                    
                    notificationItemCausesViewModel.vc?.totalItemTableView.reloadData()
              notificationItemCausesViewModel.getSingleTaskData()
            }
        }
        }
        else if notificationItemCausesViewModel.vc?.isFromScreen == "ItemCause" {
            notificationItemCausesViewModel.didSelectedCell = sender.tag
            notificationItemCausesViewModel.causeClass = notificationItemCausesViewModel.totalItemArray[notificationItemCausesViewModel.didSelectedCell]

            if let notificationActivity = notificationItemCausesViewModel.totalItemArray[notificationItemCausesViewModel.did_DeSelectedCell] as? NotificationItemCauseModel {
            notificationActivity.isSelected = false
            
                if let notificationActivity1 = notificationItemCausesViewModel.totalItemArray[sender.tag] as? NotificationItemCauseModel {
            notificationActivity1.isSelected = true
            notificationItemCausesViewModel.selectedItemCauses = notificationActivity1.Cause
            notificationItemCausesViewModel.didSelectedCell = sender.tag

                    selectedItemCause = notificationActivity1.Cause
                    notificationItemCausesViewModel.did_DeSelectedCell = notificationItemCausesViewModel.didSelectedCell
            notificationItemCausesViewModel.getSingleItemCausesData()
                    notificationItemCausesViewModel.vc?.totalItemTableView.reloadData()

            }
        }
        }
        else if notificationItemCausesViewModel.vc?.isFromScreen == "ItemActivity" {
            notificationItemCausesViewModel.didSelectedCell = sender.tag
            
            notificationItemCausesViewModel.activityClass = notificationItemCausesViewModel.totalActivityArray[notificationItemCausesViewModel.didSelectedCell]

            if let notificationActivity = notificationItemCausesViewModel.totalActivityArray[notificationItemCausesViewModel.did_DeSelectedCell] as? NotificationActivityModel {
            notificationActivity.isSelected = false
            
                if let notificationActivity1 = notificationItemCausesViewModel.totalActivityArray[sender.tag] as? NotificationActivityModel {
            notificationActivity1.isSelected = true
                    
            selectedItemActivity = notificationActivity1.Activity
            notificationItemCausesViewModel.selectedActivity = notificationActivity1.Activity
            notificationItemCausesViewModel.did_DeSelectedCell = notificationItemCausesViewModel.didSelectedCell
              notificationItemCausesViewModel.vc?.totalItemTableView.reloadData()
            notificationItemCausesViewModel.getSingleActivityData()
            }
            
        }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    //MARK:- ActivityCell Button Action..
    @objc func activityCellButtonClicked(sender:UIButton) {

        mJCLogger.log("Starting", Type: "info")
        if notificationActivityViewModel.totalActivityArray.count > 0{
            mJCLogger.log("Response:\(notificationActivityViewModel.totalActivityArray.count)", Type: "Debug")
        let notificationActivity = notificationActivityViewModel.totalActivityArray[notificationActivityViewModel.did_DeSelectedCell]
        notificationActivity.isSelected = false
        let notificationActivity1 = notificationActivityViewModel.totalActivityArray[sender.tag]
       notificationActivity1.isSelected = true
       notificationActivityViewModel.selectedActivity = notificationActivity1.Activity
            selectedAcitivity = notificationActivity1.Activity
             notificationActivityModel?.isSelected = true
      notificationActivityViewModel.selectedActivity = notificationActivityModel!.Activity
       selectedAcitivity = notificationActivityModel!.Activity


        notificationActivityModel?.isSelected = true

        notificationActivityViewModel.selectedActivity = notificationActivityModel!.Activity
        selectedAcitivity = notificationActivityModel!.Activity
        notificationActivityViewModel.didSelectedCell = sender.tag
        notificationActivityViewModel.did_DeSelectedCell = notificationActivityViewModel.didSelectedCell
        if DeviceType == iPad{
            notificationActivityViewModel.vc!.totalActivityTableView.reloadData()
        }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        notificationActivityViewModel.getSingleActivityData()
        mJCLogger.log("Ended", Type: "info")
    }

    func configureNotificationItemListActivityCell() {
        mJCLogger.log("Starting", Type: "info")
        if isfrom == "Items"{
                
            self.notificationActivityNumberLabel.text = notificationItemListModelClass?.Item
            self.notificationActivityTextLabel.text = notificationItemListModelClass?.ShortText

                
        }else if isfrom == "Activities" || isfrom == "ItemActivities"{
                 
                self.notificationActivityNumberLabel.text = notificationActivityModel?.Activity
                self.notificationActivityTextLabel.text = notificationActivityModel?.ActivityText
            
        }else if isfrom == "Tasks" || isfrom == "ItemTasks"{
            
                self.notificationActivityNumberLabel.text = notificationItemTaskModelClass?.Task
                self.notificationActivityTextLabel.text = notificationItemTaskModelClass?.TaskText

        }else if isfrom == "ItemCauses"{

                self.notificationActivityNumberLabel.text = notificationItemCausesModelClass?.Cause
                self.notificationActivityTextLabel.text = notificationItemCausesModelClass?.CauseText

        }
        
        self.backGroundView.layer.cornerRadius = 3.0
        self.backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.backGroundView.layer.shadowOpacity = 0.2
        self.backGroundView.layer.shadowRadius = 2
        self.activityCellButton.isHidden = true
        mJCLogger.log("Ended", Type: "info")
    }
}
