//
//  TimeSheetViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class TimeSheetViewModel {
    
    var vc: TimeSheetVC!
    var timeSheetArray = [TimeSheetModel]()
    
    func getTimeSheetData() {
        
        mJCLogger.log("Starting", Type: "info")
        self.timeSheetArray.removeAll()
        self.vc.totalHours = 0
        TimeSheetModel.getTimeSheetData(date: self.vc.dateSelected){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [TimeSheetModel] {
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.timeSheetArray = responseArr
                    DispatchQueue.main.async {
                        self.vc.totalHours = Float()
                        self.vc.totalEntriesLabel.text = "Total_Entries".localized() + ": \(self.timeSheetArray.count)"
                        self.vc.totalHoursLabel.text = "Total_Hours".localized() + ": 0"
                        self.vc.timeSheetTableView.reloadData()
                        self.totalTimeCalculation()
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    self.vc.totalHours = Float()
                    self.vc.totalEntriesLabel.text = "Total_Entries".localized() + ": 0"
                    self.vc.totalHoursLabel.text = "Total_Hours".localized() + ": 0"
                    self.vc.timeSheetTableView.reloadData()
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func timeSheetClick(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let timeSheetClass = self.timeSheetArray[sender.tag]
        if timeSheetClass.isExpand == true {
            timeSheetClass.isExpand = false
        }else {
            timeSheetClass.isExpand = true
        }
        self.vc.totalHours = Float()
        self.vc.timeSheetTableView.reloadData()
        self.totalTimeCalculation()
        mJCLogger.log("Ended", Type: "info")
    }
    func totalTimeCalculation(){
        for item in self.timeSheetArray{
            if ENABLE_CAPTURE_DURATION == true{
                let startTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: item.StartTime)
                let endTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: item.EndTime)
                var timeDifference = DateComponents()
                if  let strDate = item.date{
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
                    self.vc.totalHours = self.vc.totalHours + totaltime
                    self.vc.totalHoursLabel.text = String(format: "\("Total_Hours".localized()) : %.3f", self.vc.totalHours)
                }
            }
        }
    }
    func timeSheetDeleteClick(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if deletionValue == true {
            let params = Parameters(
                title: alerttitle,
                message: "Are_you_sure_you_want_to_delete".localized(),
                cancelButton: "Cancel".localized(),
                otherButtons: [okay]
            )
            mJCAlertHelper.showAlertWithHandler(self.vc, parameters: params) { buttonIndex in
                switch buttonIndex {
                case 0: break
                case 1:
                    self.deleteTimeSheetRecord(tag: sender.tag)
                default: break
                }
            }
        }else{
            self.deleteTimeSheetRecord(tag: sender.tag)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func timeSheetEditClick(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_TIME", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateTimeSheetScreen(vc: self.vc, isFromScrn: "EditTimeSheet", delegateVC: self.vc, timeSheetCls: self.timeSheetArray[sender.tag], cellIndex: sender.tag)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    //MARK:- Delete timeSheet Record..
    func deleteTimeSheetRecord(tag:Int)  {
        
        mJCLogger.log("Starting", Type: "info")
        if self.timeSheetArray.count != 0{
            let timeSheetClass = self.timeSheetArray[tag]
            TimeSheetModel.deleteTimeSheetEntity(entity: timeSheetClass.entity, options: nil, completionHandler: { (response, error) in
                if error == nil {
                    self.getTimeSheetData()
                    mJCLogger.log("Record deleted successfully!", Type: "Debug")
                }else{
                    print("Record deleted fails!")
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
