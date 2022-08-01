//
//  OnlineNotificationOtherInfoCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 19/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OnlineNotificationOtherInfoCell: UITableViewCell {

    @IBOutlet weak var workOrderLbl: UILabel!
    @IBOutlet weak var planningPlantlbl: UILabel!
    @IBOutlet weak var workCenterLbl: UILabel!
    @IBOutlet weak var PlantForWorkCenterLbl: UILabel!
    @IBOutlet weak var createdOnLbl: UILabel!
    @IBOutlet weak var notificationDateLbl: UILabel!
    @IBOutlet weak var malFuntionStartLbl: UILabel!
    @IBOutlet weak var malFunctionEndLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contactLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var reportedByLbl: UILabel!
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var assignedToLbl: UILabel!
    
    var onlineNotiOtherInfoViewModel = OnlineSearchNotificationOverviewViewModel()
    var onlineNotifOtherinfoModelClass : NotificationModel? {
        didSet{
            onlineNotificationOtherInfoConfiguration()
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
    func onlineNotificationOtherInfoConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let onlineNotifOtherinfoModelClass = onlineNotifOtherinfoModelClass {
            workOrderLbl.text = onlineNotifOtherinfoModelClass.WorkOrderNum
            workCenterLbl.text = onlineNotifOtherinfoModelClass.WorkCenter
            PlantForWorkCenterLbl.text = onlineNotifOtherinfoModelClass.PltforWorkCtr
            planningPlantlbl.text = onlineNotifOtherinfoModelClass.PlanningPlant
            
            if onlineNotifOtherinfoModelClass.CreatedOn != nil{
                createdOnLbl.text = onlineNotifOtherinfoModelClass.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                createdOnLbl.text = ""
            }
            if onlineNotifOtherinfoModelClass.NotifDate != nil{
                notificationDateLbl.text = onlineNotifOtherinfoModelClass.NotifDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                notificationDateLbl.text = ""
            }
            
            var malfunctStart = String()
            
            if onlineNotifOtherinfoModelClass.MalfunctStart != nil{
                 malfunctStart = onlineNotifOtherinfoModelClass.MalfunctStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
           
           let malfunctStartTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: onlineNotifOtherinfoModelClass.MalFunctStartTime)
           if malfunctStart == "" {
                malFuntionStartLbl.text = ""
           }
           else {
               malFuntionStartLbl.text = "\(String(describing: malfunctStart)) \(malfunctStartTime)"
           }
            var malfunctend = String()
            
            if onlineNotifOtherinfoModelClass.MalfunctEnd != nil{
                 malfunctend = onlineNotifOtherinfoModelClass.MalfunctEnd!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            
           
           let malfunctendTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: onlineNotifOtherinfoModelClass.MalfunctEndTime)
           if malfunctend == "" {
                malFunctionEndLbl.text = ""
           }
           else {
               malFunctionEndLbl.text = "\(String(describing: malfunctend)) \(malfunctendTime)"
           }
          
            nameLbl.text = onlineNotiOtherInfoViewModel.name
            contactLbl.text = onlineNotiOtherInfoViewModel.contactNum
            reportedByLbl.text = onlineNotifOtherinfoModelClass.ReportedBy
            customerLbl.text = onlineNotifOtherinfoModelClass.Customer
           if onlineNotifOtherinfoModelClass.Address != "" {
                addressLbl.text = onlineNotifOtherinfoModelClass.Address
           }
           let partner = onlineNotifOtherinfoModelClass.Partner
           if partner != "" {
            let userArr = globalPersonRespArray.filter{$0.PersonnelNo.contains(find: partner )}
               if userArr.count > 0{
                mJCLogger.log("Response:\(userArr[0])", Type: "Debug")
                   let user = userArr[0]
                    assignedToLbl.text = user.EmplApplName
               }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    assignedToLbl.text = ""
               }
           }
           else {
                mJCLogger.log("Data not found", Type: "Debug")
               self.assignedToLbl.text = ""
           }

        }
        mJCLogger.log("Starting", Type: "info")
    }
    
}
