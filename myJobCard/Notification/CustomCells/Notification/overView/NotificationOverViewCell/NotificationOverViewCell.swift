//
//  NotificationOverViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationOverViewCell: UITableViewCell {
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    //DescriptionView Outlets..
    @IBOutlet var overViewDescriptionView: UIView!
    @IBOutlet var overViewDescriptionLabelView: UIView!
    @IBOutlet var overViewDescriptionLabel: UILabel!
    
    //NotificationView Outlets..
    @IBOutlet var overViewNotificationView: UIView!
    @IBOutlet var overViewNotificationLabelView: UIView!
    @IBOutlet var overViewNotificationLabel: UILabel!
    
    //PriorityView Outlets..
    @IBOutlet var overViewPriorityView: UIView!
    @IBOutlet var overViewPriorityLabelView: UIView!
    @IBOutlet var overViewPriorityLabel: UILabel!
    
    //NotificationTypeView Outlets..
    @IBOutlet var overViewNotificationTypeView: UIView!
    @IBOutlet var overViewNotificationTypeLabelView: UIView!
    @IBOutlet var overViewNotificationTypeLabel: UILabel!
    
    //BreakdownDurationView Outlets..
    @IBOutlet var overViewBreakdownDurationView: UIView!
    @IBOutlet var overViewBreakdownDurationLabelView: UIView!
    @IBOutlet var overViewBreakdownDurationLabel: UILabel!
    
    //CatalogTypeView Outlets..
    @IBOutlet var overViewCatalogTypeView: UIView!
    @IBOutlet var overViewCatalogTypeLabelView: UIView!
    @IBOutlet var overViewCatalogTypeLabel: UILabel!
    
    //CodeGroupView Outlets..
    @IBOutlet var overViewCodeGroupView: UIView!
    @IBOutlet var overViewCodeGroupLabelView: UIView!
    @IBOutlet var overViewCodeGroupLabel: UILabel!
    
    //CodingView Outlets..
    @IBOutlet var overViewCodingView: UIView!
    @IBOutlet var overViewCodingLabelView: UIView!
    @IBOutlet var overViewCodingLabel: UILabel!
    
    //FunctionalLocationView Outlets..
    @IBOutlet var overViewFunctionalLocationView: UIView!
    @IBOutlet var overViewFunctionalLocationLabelView: UIView!
    @IBOutlet var overViewFunctionalLocationLabel: UILabel!
    @IBOutlet var overViewFunctionalLocationButton: UIButton!
    
    //Breakdown Button Outlets..
    @IBOutlet var breakdownButton: UIButton!
    @IBOutlet weak var overViewBreakdownView: UIView!
    
    //EquipementView Outlets..
    @IBOutlet var overViewEquipementView: UIView!
    @IBOutlet var overViewEquipementLabelView: UIView!
    @IBOutlet var overViewEquipementLabel: UILabel!
    @IBOutlet var overViewEquipementButton: UIButton!
    
    @IBOutlet var overViewStatusView: UIView!
    @IBOutlet var overViewStatusLabelView: UIView!
    @IBOutlet var overViewStatusLabel: UILabel!

    @IBOutlet var overViewSystemStatusView: UIView!
    @IBOutlet var overViewSystemStatusLabelView: UIView!
    @IBOutlet var overViewSystemStatusLabel: UILabel!


    var indexPath = IndexPath()
    var notiOverviewViewModel = NotificationOverviewViewModel()
    var notifOverviewModelClass : NotificationModel? {
        didSet{
            notificationOverViewConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func notificationOverViewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        overViewDescriptionLabel.text = notifOverviewModelClass?.ShortText
        overViewNotificationLabel.text = notifOverviewModelClass?.Notification
        var priority = String()
        let priorityFilteredArray = globalPriorityArray.filter{ $0.Priority == notifOverviewModelClass?.Priority}
        if priorityFilteredArray.count > 0 {
            let obj = priorityFilteredArray[0]
            priority = obj.PriorityText
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        overViewPriorityLabel.text = priority
        overViewNotificationTypeLabel.text = notifOverviewModelClass?.NotificationType
        overViewStatusLabel.text = notifOverviewModelClass?.UserStatus
        overViewSystemStatusLabel.text = notifOverviewModelClass?.SystemStatus
        let breakDownDur = notifOverviewModelClass?.BreakdownDur
        if notifOverviewModelClass?.Unit == "H" ||  notifOverviewModelClass?.Unit == "h" {
            overViewBreakdownDurationLabel.text = String(breakDownDur ?? 0.0) + " " + "Hours".localized()
        }else {
            overViewBreakdownDurationLabel.text = String(breakDownDur ?? 0.0) + " " + "Units".localized()
        }
        overViewCatalogTypeLabel.text = notifOverviewModelClass?.CatalogType
        overViewCodeGroupLabel.text = notifOverviewModelClass?.CodeGroup
        overViewCodingLabel.text = notifOverviewModelClass?.Coding
        overViewFunctionalLocationLabel.text = notifOverviewModelClass?.FunctionalLoc
        overViewFunctionalLocationButton.setTitle(notifOverviewModelClass?.FunctionalLoc, for: .normal)
        
        overViewFunctionalLocationButton.tag = indexPath.row
        overViewEquipementButton.tag = indexPath.row
        overViewEquipementLabel.text = notifOverviewModelClass?.Equipment
        overViewEquipementButton.setTitle(notifOverviewModelClass?.Equipment, for: .normal)
        
        overViewFunctionalLocationButton.addTarget(self, action: #selector(overViewFunctionalLocationButtonAction(sender:)), for: .touchUpInside)
        overViewEquipementButton.addTarget(self, action: #selector(overViewEquipementButtonAction(sender:)), for: .touchUpInside)
        breakdownButton.isHidden = false
        breakdownButton.isSelected = true
        if notifOverviewModelClass?.Breakdown == "X" || notifOverviewModelClass?.Breakdown == "X" {
            breakdownButton.isSelected = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Function Location Button Action..
    @objc func overViewFunctionalLocationButtonAction(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        
        if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
            notiOverviewViewModel.notificationOverviewFunclocServiceCall(title: (sender.titleLabel?.text)!)
        }
        else {
            mJCLogger.log("Functional_Location_Not_Found", Type: "Error")
            mJCAlertHelper.showAlert(notiOverviewViewModel.vcNOOverview!, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Equipment Button Action..
    @objc func overViewEquipementButtonAction(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
            notiOverviewViewModel.notificationOverviewEquipmentServiceCall(title: (sender.titleLabel?.text)!)
        }else {
            mJCLogger.log("Equipment_Not_Found".localized(), Type: "Error")
            mJCAlertHelper.showAlert(notiOverviewViewModel.vcNOOverview!, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}

