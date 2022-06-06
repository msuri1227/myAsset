//
//  NotificationLocationAndContactCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationLocationAndContactCell: UITableViewCell {
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //NameView Outlets..
    @IBOutlet var locationAndContactNameView: UIView!
    @IBOutlet var locationAndContactNameLabelView: UIView!
    @IBOutlet var locationAndContactNameLabel: UILabel!
    
    //ContactView Outlets..
    @IBOutlet var locationAndContactContactView: UIView!
    @IBOutlet var locationAndContactContactLabelView: UIView!
    @IBOutlet var locationAndContactContactLabel: UILabel!
    
    //AddressView Outlets..
    @IBOutlet var locationAndContactAddressView: UIView!
    @IBOutlet var locationAndContactAddressLabelView: UIView!
    @IBOutlet var locationAndContactAddressLabel: UILabel!
    
    //ReportedByView Outlets..
    @IBOutlet var locationAndContactReportedByView: UIView!
    @IBOutlet var locationAndContactReportedByLabelView: UIView!
    @IBOutlet var locationAndContactReportedByLabel: UILabel!
    
    //CustomerView Outlets..
    @IBOutlet var locationAndContactCustomerView: UIView!
    @IBOutlet var locationAndContactCustomerLabelView: UIView!
    @IBOutlet var locationAndContactCustomerLabel: UILabel!
    
    //VenderView Outlets..
    @IBOutlet var locationAndContactVenderView: UIView!
    @IBOutlet var locationAndContactVenderLabelView: UIView!
    @IBOutlet var locationAndContactVenderLabel: UILabel!
    
    //AssignedToView Outlets..
    @IBOutlet var locationAndContactAssignedToView: UIView!
    @IBOutlet var locationAndContactAssignedToLabelView: UIView!
    @IBOutlet var locationAndContactAssignedToLabel: UILabel!
    
    //PartnerView Outlets..
    @IBOutlet var locationAndContactPartnerView: UIView!
    @IBOutlet var locationAndContactPartnerLabelView: UIView!
    @IBOutlet var locationAndContactPartnerLabel: UILabel!
    
    var notifLocationContactViewModel = NotificationOverviewViewModel()
    var notifLocationContactModelClass : NotificationModel? {
        didSet{
            notificationLocationAndContactConfiguration()
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
    func notificationLocationAndContactConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        locationAndContactNameLabel.text = notifLocationContactViewModel.name
        locationAndContactContactLabel.text = notifLocationContactViewModel.contactNum
         locationAndContactReportedByLabel.text = notifLocationContactModelClass?.ReportedBy
         locationAndContactCustomerLabel.text = notifLocationContactModelClass?.Customer
         locationAndContactVenderLabel.text = notifLocationContactModelClass?.Vendor
        
        if notifLocationContactModelClass?.Address != "" {
             locationAndContactAddressLabel.text = notifLocationContactModelClass?.Address
        }
        let partner = notifLocationContactModelClass?.Partner
        let finalCode = "0\(String(describing: partner))"
        
        if partner != "" {
            let userArr = globalPersonRespArray.filter{$0.PersonnelNo.contains(find: partner ?? "")}
            if userArr.count > 0{
                mJCLogger.log("Response:\(userArr[0])", Type: "Debug")
                let user = userArr[0]
                 locationAndContactAssignedToLabel.text = user.EmplApplName
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                 locationAndContactAssignedToLabel.text = ""
            }
        }
        else {
            mJCLogger.log("Data not found", Type: "Debug")
             locationAndContactAssignedToLabel.text = ""
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}
