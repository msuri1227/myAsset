//
//  TimeSheetsCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/1/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class TimeSheetsCell: UITableViewCell {
    
    @IBOutlet var workOrderLabel: UILabel!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var absentLabel: UILabel!
    @IBOutlet var workCenterLabel: UILabel!
    @IBOutlet var activityLabel: UILabel!
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var timeSheetDeleteButton: UIButton!
    @IBOutlet var timeSheetEditButton: UIButton!
    @IBOutlet var lessMoreButton: UIButton!
    @IBOutlet var plantLabel: UILabel!
    @IBOutlet var subOperationLabel: UILabel!
    @IBOutlet var operationHolderView: UIView!
    @IBOutlet var subOperationHolderView: UIView!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var timeSheetClickButton: UIButton!
    @IBOutlet weak var subOperationTitleLbl: UILabel!
    @IBOutlet weak var operationTitleLbl: UILabel!
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endTimeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startTimeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var operationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subOperationHolderViewHeightConstraint: NSLayoutConstraint!
    
    var timeSheetVCModel = TimeSheetViewModel()
    var superTimeViewModel = SuperTimeSheetViewModel()
    var indexPath: NSIndexPath!
    
    var timesheetClass: TimeSheetModel?{
        didSet{
            timesheetConfiguration()
        }
    }
    var supTimesheetClass: TimeSheetModel?{
        didSet{
            supTimesheetConfiguration()
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
    func timesheetConfiguration() {
        
        mJCLogger.log("Starting", Type: "info")
        if let timeSheetClass = timesheetClass {
            self.workOrderLabel.text = timeSheetClass.RecOrder
            if ENABLE_CAPTURE_DURATION == true{
                let startTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.StartTime)
                let endTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.EndTime)
                self.startTimeLabel.text = startTime
                self.endTimeLabel.text = endTime
                var timeDifference = DateComponents()
                if  let strDate = timeSheetClass.date{
                    let startDate = strDate.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    let startDateTime = Date(fromString: "\(startDate) \(startTime)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                    let endDateTime = Date(fromString: "\(startDate) \(endTime)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                    let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
                     timeDifference = Calendar.current.dateComponents(requestedComponent, from: startDateTime, to: endDateTime)
                     var hours = Float()
                     var minutes = Float()
                     var totaltime = Float()
                     if timeDifference.hour != nil && timeDifference.minute != nil{
                         let hour = timeDifference.hour!
                         let min = timeDifference.minute!
                         hours = Float(hour)
                         minutes = Float(min)
                         totaltime = Float()
                     }else{
                         hours = 0
                         minutes =  0
                     }
                     if hours == 0 && minutes < 1{
                         totaltime = 0.02
                     }else{
                         totaltime = hours + minutes / 60
                     }
                     let hrtext = String(format: "%.3f", totaltime)
                     self.hoursLabel.text = hrtext
                }
            }else{
                self.hoursLabel.text = String(format: "%.3f", timeSheetClass.CatsHours as CVarArg)
                let CatsHours = "\(timeSheetClass.CatsHours)"
                let time = CatsHours.components(separatedBy: ".")
                let hours = time[0]
                var min = String()
                if time.count > 1 {
                    if time[1] == "0" || time[1] == "00"{
                        min = "00"
                    }else {
                        if time[1].count > 2 {
                            var countInt  = 1
                            for _ in 0 ... time[1].count - 2 {
                                let devideCountStr  = String(format: "\(countInt)0")
                                countInt = Int(devideCountStr)!
                            }
                            let time12 = lroundf(Float(time[1])!) * 6 / countInt
                            min = "\(time12)"
                        }else {
                            var time12 = Float()
                            if time[1].prefix(1) == "0"{
                                time12 = Float(time[1])! * 6 / 10
                            }else{
                                time12 = Float(time[1])! * 6
                            }
                            if time12 > 60{
                                time12 = time12 / 10
                            }
                            min = "\(lroundf(time12))"
                        }
                    }
                    self.hoursLabel.text = "\(hours).\(min)"
                }else{
                    self.hoursLabel.text = "\(0).\(min)"
                }
            }
            self.absentLabel.text = timeSheetClass.AttAbsType
            self.activityLabel.text = timeSheetClass.ActivityType
            self.operationLabel.text = timeSheetClass.OperAct
            self.subOperationLabel.text = timeSheetClass.SubOperation
            self.workCenterLabel.text = timeSheetClass.WorkCenter
            self.plantLabel.text = timeSheetClass.Plant
            ODSUIHelper.setCornerRadiusToView(view: self.backGroundView, cornerRadius: 3.0)
            self.timeSheetClickButton.tag = indexPath.row
            self.timeSheetClickButton.addTarget(self, action: #selector(self.timeSheetClickButtonAction), for: UIControl.Event.touchUpInside)
            self.timeSheetDeleteButton.tag = indexPath.row
            self.timeSheetDeleteButton.addTarget(self, action: #selector(self.timeSheetDeleteButtonAction), for: UIControl.Event.touchUpInside)
            self.timeSheetEditButton.tag = indexPath.row
            self.timeSheetEditButton.addTarget(self, action: #selector(self.timeSheetEditButtonAction), for: UIControl.Event.touchUpInside)
            if timeSheetClass.isExpand == true {
                if DeviceType == iPhone{
                    self.operationViewHeightConstraint.constant = 50
                    self.subOperationHolderViewHeightConstraint.constant = 50
                    self.startTimeHeightConstraint.constant = 20
                    self.endTimeHeightConstraint.constant = 20
                }
                self.subOperationHolderView.isHidden = false
                self.operationHolderView.isHidden = false
                self.lessMoreButton.isSelected = true
                if ENABLE_CAPTURE_DURATION == true {
                    self.startTimeView.isHidden = false
                    self.endTimeView.isHidden = false
                }
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    if DeviceType == iPhone{
                        self.subOperationHolderViewHeightConstraint.constant = 0
                        if ENABLE_CAPTURE_DURATION == false{
                            self.startTimeHeightConstraint.constant = 0
                            self.endTimeHeightConstraint.constant = 0
                        }
                    }
                    self.subOperationTitleLbl.isHidden = true
                    self.operationTitleLbl.isHidden = true
                    self.operationLabel.isHidden = true
                    self.subOperationLabel.isHidden = true
                }else{
                    if DeviceType == iPhone{
                        self.subOperationHolderViewHeightConstraint.constant = 50
                        if ENABLE_CAPTURE_DURATION == false{
                            self.startTimeHeightConstraint.constant = 0
                            self.endTimeHeightConstraint.constant = 0
                        }
                    }
                    self.subOperationTitleLbl.isHidden = false
                    self.operationTitleLbl.isHidden = false
                    self.operationLabel.isHidden = false
                    self.subOperationLabel.isHidden = false
                }
            }else {
                if DeviceType == iPhone{
                    self.operationViewHeightConstraint.constant = 0
                    self.subOperationHolderViewHeightConstraint.constant = 0
                    self.startTimeHeightConstraint.constant = 0
                    self.endTimeHeightConstraint.constant = 0
                }
                self.subOperationHolderView.isHidden = true
                self.operationHolderView.isHidden = true
                self.lessMoreButton.isSelected = false
                self.startTimeView.isHidden = true
                self.endTimeView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func supTimesheetConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let timeSheetClass = supTimesheetClass {
            self.workOrderLabel.text = timeSheetClass.RecOrder
            self.hoursLabel.text = String(format: "%.2f", timeSheetClass.CatsHours as CVarArg)
            self.timeSheetEditButton.isHidden = true
            self.timeSheetDeleteButton.isHidden = true
            self.absentLabel.text = timeSheetClass.AttAbsType
            self.activityLabel.text = timeSheetClass.ActivityType
            self.operationLabel.text = timeSheetClass.PlannofOpera
            self.subOperationLabel.text = timeSheetClass.SubOperation
            self.workCenterLabel.text = timeSheetClass.WorkCenter
            self.plantLabel.text = timeSheetClass.Plant
            ODSUIHelper.setCornerRadiusToView(view: self.backGroundView, cornerRadius: 3.0)
            self.timeSheetClickButton.tag = indexPath.row
            self.timeSheetClickButton.addTarget(self, action: #selector(timeSheetClickButtonAction), for: UIControl.Event.touchUpInside)
            if timeSheetClass.isExpand == true {
                self.subOperationHolderView.isHidden = false
                self.operationHolderView.isHidden = false
                self.lessMoreButton.isSelected = true
            }else {
                self.subOperationHolderView.isHidden = true
                self.operationHolderView.isHidden = true
                self.lessMoreButton.isSelected = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func timeSheetClickButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        timeSheetVCModel.timeSheetClick(sender:sender)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func timeSheetDeleteButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        timeSheetVCModel.timeSheetDeleteClick(sender:sender)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func timeSheetEditButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        timeSheetVCModel.timeSheetEditClick(sender:sender)
        mJCLogger.log("Ended", Type: "info")
    }
}
