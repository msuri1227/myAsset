//
//  ObjectsTableViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ObjectsTableViewCell: UITableViewCell {

    @IBOutlet var backGroudView: UIView!
    @IBOutlet var objectMaterialLabel: UILabel!
    @IBOutlet var objectObjectLabel: UILabel!
    @IBOutlet var objectEquipmentlLabel: UILabel!
    @IBOutlet var objectSerialNumberLabel: UILabel!
    @IBOutlet var objectNotificationLabel: UILabel!
    @IBOutlet var objectFunctionalLocationLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet var notificationButtonView: UIView!
    @IBOutlet var objNotesWidthConstraint: NSLayoutConstraint!
    @IBOutlet var redLineWidthConstraint: NSLayoutConstraint!
    
    var indexpath = IndexPath()
    var woObjectViewModel = WorkOrderObjectsViewModel()
    var woObjectModel: WorkorderObjectModel? {
        didSet{
            woObjectsConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func woObjectsConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        backGroudView.layer.cornerRadius = 3.0
        backGroudView.layer.shadowOffset = CGSize(width: 3, height: 3)
        backGroudView.layer.shadowOpacity = 0.2
        backGroudView.layer.shadowRadius = 2
        
        
        objNotesWidthConstraint.constant = 0.0
        redLineWidthConstraint.constant = 0.0

        if woObjectModel?.NotificationType == "MC" {
            objNotesWidthConstraint.constant = 30.0
            redLineWidthConstraint.constant = 5.0
        }
        
        objectMaterialLabel.text = woObjectModel?.Material
        objectObjectLabel.text = woObjectModel?.ObjectNumber
        objectEquipmentlLabel.text = woObjectModel?.Equipment
        objectSerialNumberLabel.text = woObjectModel?.SerialNumber
        objectNotificationLabel.text = woObjectModel?.Notification
        if DeviceType == iPhone{
            notificationButton.setTitle(woObjectModel?.Notification, for: .normal)
        }
        if woObjectModel?.Notification == ""{
            notificationButtonView.isHidden = true
        }else{
            notificationButtonView.isHidden = false
        }
        objectFunctionalLocationLabel.text = woObjectModel?.FunctionalLoc
        notificationButton.tag = indexpath.row
        notificationButton.addTarget(self, action:#selector(objectNotificationButtonAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func objectNotificationButtonAction(sender: UIButton!) {
        mJCLogger.log("Starting", Type: "info")
        woObjectViewModel.vc?.updateUIObjectNotificationButton(tagValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
}
