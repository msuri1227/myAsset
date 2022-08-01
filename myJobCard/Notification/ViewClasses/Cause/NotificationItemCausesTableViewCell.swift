//
//  NotificationItemCausesTableViewCell.swift
//  myJobCard
//
//  Created by Alphaved on 11/03/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationItemCausesTableViewCell: UITableViewCell {
    
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //CauseView Outlets..
    @IBOutlet var overViewCauseView: UIView!
    @IBOutlet var overViewCauseLabelView: UIView!
    @IBOutlet var overViewCauseLabel: UILabel!

    //Cause group View Outlets..
    @IBOutlet var overViewCauseGroupView: UIView!
    @IBOutlet var overViewCauseGroupLabelView: UIView!
    @IBOutlet var overViewCauseGroupLabel: UILabel!

    //CauseCodeView Outlets..
    @IBOutlet var overViewCauseCodeView: UIView!
    @IBOutlet var overViewCauseCodeLabelView: UIView!
    @IBOutlet var overViewCauseCodeLabel: UILabel!
    
    //NotificationView Outlets..
    @IBOutlet var overViewNotificationView: UIView!
    @IBOutlet var overViewNotificationLabelView: UIView!
    @IBOutlet var overViewNotificationLabel: UILabel!
    
    //ItemNumberView Outlets..
    @IBOutlet var overViewItemNumberView: UIView!
    @IBOutlet var overViewItemNumberLabelView: UIView!
    @IBOutlet var overViewItemNumberLabel: UILabel!
    
    //DiscriptionView Outlets..
    @IBOutlet var overViewDiscriptionView: UIView!
    @IBOutlet var overViewDiscriptionLabelView: UIView!
    @IBOutlet var overViewDiscriptionLabel: UILabel!
    
    //ActivityCatalogView Outlets..
    @IBOutlet var overViewCatalogView: UIView!
    @IBOutlet var overViewCatalogLabelView: UIView!
    @IBOutlet var overViewCatalogLabel: UILabel!
    
    
    var indexPath = IndexPath()
    
    var NotificationItemCauseModel:NotificationItemCauseModel?{
        didSet{
            configureNotificationItemCausesTableViewCell()
        }
    }
    var notificationItemCausesViewModel = NotificationItemCausesViewModel()
    
    func configureNotificationItemCausesTableViewCell(){
        mJCLogger.log("Starting", Type: "info")
        if let NotificationItemCauseModel = NotificationItemCauseModel {
            notificationItemCausesViewModel.getPartValue(catalogCode: NotificationItemCauseModel.CatalogType, codeGroup: NotificationItemCauseModel.CodeGroup, code: NotificationItemCauseModel.CauseCode)
            backGroundView.isHidden = false
            overViewCauseLabel.text = NotificationItemCauseModel.Cause
            overViewNotificationLabel.text = NotificationItemCauseModel.Notification
            overViewItemNumberLabel.text = NotificationItemCauseModel.Item
            overViewDiscriptionLabel.text = NotificationItemCauseModel.CauseText
            overViewCatalogLabel.text = NotificationItemCauseModel.CatalogType
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                if self.notificationItemCausesViewModel.partArray.count > 0{
                    self.overViewCauseGroupLabel.text = "\(self.notificationItemCausesViewModel.partArray[0].CodeGroup) - \(self.notificationItemCausesViewModel.partArray[0].CodeGroupText)"
                    self.overViewCauseCodeLabel.text = "\(self.notificationItemCausesViewModel.partArray[0].Code) - \(self.notificationItemCausesViewModel.partArray[0].CodeText)"

                }

            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
