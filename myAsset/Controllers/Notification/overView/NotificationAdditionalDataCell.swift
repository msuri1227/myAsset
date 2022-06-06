//
//  NotificationAdditionalDataCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationAdditionalDataCell: UITableViewCell {
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //ObjectNumberView Outlets..
    @IBOutlet var additionalDataObjectNumberView: UIView!
    @IBOutlet var additionalDataObjectNumberLabelView: UIView!
    @IBOutlet var additionalDataObjectNumberLabel: UILabel!
    
    //Assembly Outlets..
    @IBOutlet var additionalDataAssemblyView: UIView!
    @IBOutlet var additionalDataAssemblyLabelView: UIView!
    @IBOutlet var additionalDataAssemblyLabel: UILabel!
    
    //ABCIndicatorView Outlets..
    @IBOutlet var additionalDataABCIndicatorView: UIView!
    @IBOutlet var additionalDataABCIndicatorLabelView: UIView!
    @IBOutlet var additionalDataABCIndicatorLabel: UILabel!
    
    var notifAdditionalModelClass : NotificationModel? {
        didSet{
            notificationAdditionalDataConfiguration()
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
    func notificationAdditionalDataConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        additionalDataObjectNumberLabel.text = notifAdditionalModelClass?.ObjectNumber
        additionalDataAssemblyLabel.text = notifAdditionalModelClass?.Assembly
        additionalDataABCIndicatorLabel.text = notifAdditionalModelClass?.ABCIndicator
        mJCLogger.log("Ended", Type: "info")
    }
    
}
