//
//  NotificationDatesCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationDatesCell: UITableViewCell {  
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    //CreatedOnView Outlets..
    @IBOutlet var datesCreatedOnView: UIView!
    @IBOutlet var datesCreatedOnLabelView: UIView!
    @IBOutlet var datesCreatedOnLabel: UILabel!
    
    //ChangedOnView Outlets..
    @IBOutlet var datesChangedOnView: UIView!
    @IBOutlet var datesChangedOnLabelView: UIView!
    @IBOutlet var datesChangedOnLabel: UILabel!
    
    //NotificationDateView Outlets..
    @IBOutlet var datesNotificationDateView: UIView!
    @IBOutlet var datesNotificationDateLabelView: UIView!
    @IBOutlet var datesNotificationDateLabel: UILabel!
    
    //NotificationTimeView Outlets..
    @IBOutlet var datesNotificationTimeView: UIView!
    @IBOutlet var datesNotificationTimeLabelView: UIView!
    @IBOutlet var datesNotificationTimeLabel: UILabel!
    
    //CompletionDateView Outlets..
    @IBOutlet var datesCompletionDateView: UIView!
    @IBOutlet var datesCompletionDateLabelView: UIView!
    @IBOutlet var datesCompletionDateLabel: UILabel!
    
    //CompletionTimeView Outlets..
    @IBOutlet var datesCompletionTimeView: UIView!
    @IBOutlet var datesCompletionTimeLabelView: UIView!
    @IBOutlet var datesCompletionTimeLabel: UILabel!
    
    //MalfunctionStartView Outlets..
    @IBOutlet var datesMalfunctionStartView: UIView!
    @IBOutlet var datesMalfunctionStartLabelView: UIView!
    @IBOutlet var datesMalfunctionStartLabel: UILabel!
    
    //MalfunctionEndView Outlets..
    @IBOutlet var datesMalfunctionEndView: UIView!
    @IBOutlet var datesMalfunctionEndLabelView: UIView!
    @IBOutlet var datesMalfunctionEndLabel: UILabel!
    
    //StartDate Outlets..
    @IBOutlet weak var datesStartDateView: UIView!
    @IBOutlet weak var datesStartDateLabelView: UIView!
    @IBOutlet weak var datesStartDateLabel: UILabel!
    
    //EndDate Outlets..
    @IBOutlet weak var datesEndDateView: UIView!
    @IBOutlet weak var datesEndDateLabelView: UIView!
    @IBOutlet weak var datesEndDateLabel: UILabel!
    
    var notifDatesModelClass : NotificationModel? {
        didSet{
            notificationDatesConfiguration()
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
    func notificationDatesConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let notifDatesModelClass = notifDatesModelClass {
            
            if notifDatesModelClass.CreatedOn != nil{
                datesCreatedOnLabel.text = notifDatesModelClass.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                datesCreatedOnLabel.text = ""
            }
            if notifDatesModelClass.ChangedOn != nil{
                datesChangedOnLabel.text = notifDatesModelClass.ChangedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                datesChangedOnLabel.text = ""
            }
            
            if notifDatesModelClass.NotifDate != nil{
                datesNotificationDateLabel.text = notifDatesModelClass.NotifDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                datesNotificationDateLabel.text = ""
            }
            

            if (notifDatesModelClass.NotifTime.hours == nil && notifDatesModelClass.NotifTime.minutes == nil) {
                datesNotificationTimeLabel.text = "00:00"
            }
            else {
                var notificationTime = String()
                if notifDatesModelClass.NotifTime.hours == nil {
                    notificationTime = "00:\(String(describing: notifDatesModelClass.NotifTime.minutes))"
                }
                else if notifDatesModelClass.NotifTime.minutes == nil {
                    notificationTime = "\(String(describing: notifDatesModelClass.NotifTime.hours)):00"
                }
                else {
                    notificationTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notifDatesModelClass.NotifTime)
                }
                datesNotificationTimeLabel.text = notificationTime
            }
            
            if notifDatesModelClass.CompletionDate != nil{
                datesCompletionDateLabel.text = notifDatesModelClass.CompletionDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                datesCompletionDateLabel.text = ""
            }

            if (notifDatesModelClass.CompletionTime.hours == nil && notifDatesModelClass.CompletionTime.minutes == nil) {
                datesCompletionTimeLabel.text = "00:00"
            }
            else {
                var completionTime = String()
                if notifDatesModelClass.CompletionTime.hours == nil {
                    completionTime = "00:\(String(describing: notifDatesModelClass.CompletionTime.minutes))"
                }
                else if notifDatesModelClass.CompletionTime.minutes == nil {
                    completionTime = "\(String(describing: notifDatesModelClass.CompletionTime.hours)):00"
                }else{
                    completionTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notifDatesModelClass.CompletionTime)
                }
                datesCompletionTimeLabel.text = completionTime
            }
            
            var malfunctStart = String()
            if notifDatesModelClass.MalfunctStart != nil{
                malfunctStart = notifDatesModelClass.MalfunctStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                let malfunctStartTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notifDatesModelClass.MalFunctStartTime)
                datesMalfunctionStartLabel.text = "\(String(describing: malfunctStart)) \(malfunctStartTime)"
            }
            var malfunctEnd = String()
            if notifDatesModelClass.MalfunctEnd != nil{
                malfunctEnd = notifDatesModelClass.MalfunctEnd!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                let malfunctEndTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notifDatesModelClass.MalfunctEndTime)
                datesMalfunctionEndLabel.text = "\(String(describing: malfunctEnd)) \(malfunctEndTime)"
            }
            var RequiredStartDate = String()
            if notifDatesModelClass.RequiredStartDate != nil{
                RequiredStartDate = notifDatesModelClass.RequiredStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                let RequiredStartTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notifDatesModelClass.RequiredStartTime)
                datesStartDateLabel.text = "\(RequiredStartDate) \(RequiredStartTime)"
            }
            var RequiredEndDate = String()
            if notifDatesModelClass.RequiredEndDate  != nil{
                RequiredEndDate = notifDatesModelClass.RequiredEndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                let RequiredEndTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: notifDatesModelClass.RequiredEndTime)
                datesEndDateLabel.text = "\(RequiredEndDate) \(RequiredEndTime)"
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
