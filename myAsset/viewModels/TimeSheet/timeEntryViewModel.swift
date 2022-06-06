//
//  timeEntryViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 05/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class TimeEntryViewModel{
    
    var addTimeEntryVC :  CreateTimeSheetVC?
    var totalHours = Int()
    var totalMins = Int()
    var totalCatHours = Float()
    var StatusChangeData = true
    
    func setViewLayouts(){
        
        mJCLogger.log("Starting", Type: "info")
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.dateViewTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.workOrderButtonView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.workOrderTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.attenenceTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.operationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.activityTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.workCenterTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.startTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.endTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.personResponsibleTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:addTimeEntryVC!.PremiumTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5" {
            self.addTimeEntryVC!.operationViewHieghtConstant.constant = 65.0
            self.addTimeEntryVC!.operationView.isHidden = false
            if self.addTimeEntryVC!.screenType == "EditTimeSheet"{
                self.addTimeEntryVC!.selectedworkOrder = self.addTimeEntryVC!.timeSheetClass.RecOrder
            }else{
                self.getOpertionList()
            }
        }else{
            self.addTimeEntryVC!.operationViewHieghtConstant.constant = 0.0
            self.addTimeEntryVC!.operationView.isHidden = true
        }
        if ENABLE_CAPTURE_TEAM_TIMESHEET == true && self.addTimeEntryVC!.screenType == "StatusChange"{
            self.addTimeEntryVC!.resourceTimesheetView.isHidden = false
            self.addTimeEntryVC!.headerViewHeightConst.constant = 0.0
            self.addTimeEntryVC!.personResponsibleView.isHidden = false
            
            if DeviceType == iPad{
                let index = self.addTimeEntryVC!.suspendViewModel.completionFeatureListArray.firstIndex{$0.title == "TimeEntry".localized()} ?? 0
                if index == self.addTimeEntryVC!.suspendViewModel.completionFeatureListArray.count - 2{
                    self.addTimeEntryVC!.resourceresourceCompleteButton.setTitle("Save".localized(), for: .normal)
                }else if index == self.addTimeEntryVC!.suspendViewModel.completionFeatureListArray.count - 1{
                    if self.addTimeEntryVC!.suspendViewModel.suspendVc?.isFromScreen == "Hold"{
                        self.addTimeEntryVC!.resourceresourceCompleteButton.setTitle("Hold_order".localized(), for: .normal)
                    }else if self.addTimeEntryVC!.suspendViewModel.suspendVc?.isFromScreen == "Suspend"{
                        self.addTimeEntryVC!.resourceresourceCompleteButton.setTitle("Suspend".localized(), for: .normal)
                    }else{
                        self.addTimeEntryVC!.resourceresourceCompleteButton.setTitle("Complete".localized(), for: .normal)
                    }
                }
            }else{
                self.addTimeEntryVC!.resourceresourceCompleteButton.setTitle("", for: .normal)
            }
        }else if  self.addTimeEntryVC!.screenType == "StatusChange"{
            self.addTimeEntryVC!.headerViewHeightConst.constant = 0.0
            self.addTimeEntryVC!.personResponsibleView.isHidden = true
            self.addTimeEntryVC!.resourceTimesheetView.isHidden = true
            if DeviceType == iPad{
                let index = self.addTimeEntryVC!.suspendViewModel.completionFeatureListArray.firstIndex{$0.title == "TimeEntry".localized()} ?? 0
                if index == self.addTimeEntryVC!.suspendViewModel.completionFeatureListArray.count - 2{
                    self.addTimeEntryVC!.doneButton.setTitle("Save".localized(), for: .normal)
                }else if index == self.addTimeEntryVC!.suspendViewModel.completionFeatureListArray.count - 1{
                    if self.addTimeEntryVC!.suspendViewModel.suspendVc?.isFromScreen == "Hold"{
                        self.addTimeEntryVC!.doneButton.setTitle("Hold_order".localized(), for: .normal)
                    }else if self.addTimeEntryVC!.suspendViewModel.suspendVc?.isFromScreen == "Suspend"{
                        self.addTimeEntryVC!.doneButton.setTitle("Suspend".localized(), for: .normal)
                    }else{
                        self.addTimeEntryVC!.doneButton.setTitle("Complete".localized(), for: .normal)
                    }
                }
            }
        }else{
            self.addTimeEntryVC!.resourceTimesheetView.isHidden = true
            self.addTimeEntryVC!.personResponsibleView.isHidden = true
            self.addTimeEntryVC!.personResponsibleView.isUserInteractionEnabled = true
            if DeviceType == iPad{
                self.addTimeEntryVC!.headerViewHeightConst.constant = 64.0
            }else{
                self.addTimeEntryVC!.headerViewHeightConst.constant = 50.0
            }
        }
        if ENABLE_CAPTURE_DURATION == false{
            self.addTimeEntryVC!.startTimeLabel.text = "Hours".localized()
            self.addTimeEntryVC!.endTimeLabel.text = "Minutes".localized()
            self.addTimeEntryVC!.startTimeTextField.placeholder = "Select_Hours".localized()
            self.addTimeEntryVC!.endTimeTextField.placeholder = "Select_Minutes".localized()
            for index in 0..<60 {
                if index < 10 {
                    let minut = "0\(index)"
                    addTimeEntryVC!.minutsArray.add(minut)
                }
                else {
                    let minut = "\(index)"
                    addTimeEntryVC!.minutsArray.add(minut)
                }
                if index < 24 {
                    let hour = "\(index)"
                    addTimeEntryVC!.hoursArray.add(hour)
                }
            }
        }else{
            self.addTimeEntryVC!.startTimeLabel.text = "Start_Time".localized()
            self.addTimeEntryVC!.endTimeLabel.text = "End_Time".localized()
            self.addTimeEntryVC!.startTimeTextField.placeholder = "Select_Start_Time".localized()
            self.addTimeEntryVC!.endTimeTextField.placeholder = "Select_End_Time".localized()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get WorkOrder List..
    func getWorkOrderList() {
        
        mJCLogger.log("Starting", Type: "info")
        self.addTimeEntryVC!.workOrderArray.removeAll()
        self.addTimeEntryVC!.workOrderListArray.removeAll()
        self.addTimeEntryVC!.workOrderArray = allworkorderArray
        self.addTimeEntryVC!.workOrderListArray.append("--none--".localized())
        for workorderItem in self.addTimeEntryVC!.workOrderArray {
            self.addTimeEntryVC!.workOrderListArray.append("\(workorderItem.WorkOrderNum) - \(workorderItem.ControllingArea)")
        }
        if self.addTimeEntryVC!.workOrderListArray.count > 0 {
            if self.addTimeEntryVC!.screenType == "AddTimeSheet"{
                self.addTimeEntryVC!.workOrderTextField.isUserInteractionEnabled = true
                self.addTimeEntryVC?.workOrdrTextField.isUserInteractionEnabled = true
            }else{
                self.addTimeEntryVC!.workOrderTextField.isUserInteractionEnabled = false
                self.addTimeEntryVC?.workOrdrTextField.isUserInteractionEnabled = false
            }
            self.addTimeEntryVC?.workOrdrTextField.optionArray = self.addTimeEntryVC!.workOrderListArray
            self.addTimeEntryVC?.workOrdrTextField.checkMarkEnabled = false
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Operation List..
    func getOpertionList() {
        
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(WorkOrderNum%20eq%20%27" + self.addTimeEntryVC!.selectedworkOrder + "%27 and startswith(SystemStatus, 'DLT') ne true)&$select=OperationNum,PlannofOpera&$orderby=OperationNum"
        mJCLogger.log("defineQuery :- \(defineQuery)", Type: "")
        WoOperationModel.getOperationList(filterQuery: defineQuery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.addTimeEntryVC!.operationArray.removeAll()
                        self.addTimeEntryVC!.operationArray = responseArr
                        self.addTimeEntryVC!.operationListArray.removeAll()
                        for oprItem in self.addTimeEntryVC!.operationArray {
                            self.addTimeEntryVC!.operationListArray.append(oprItem.OperationNum + " - " + oprItem.PlannofOpera)
                        }
                        
                        if (self.addTimeEntryVC?.operationListArray.count)! > 0{
                            self.addTimeEntryVC?.operationTextField.optionArray = self.addTimeEntryVC!.operationListArray
                            self.addTimeEntryVC?.operationTextField.checkMarkEnabled = false
                        }
                        if self.addTimeEntryVC!.screenType == "StatusChange"{
                            if selectedOperationNumber != ""{
                                let oprArr  = self.addTimeEntryVC!.operationArray.filter{$0.OperationNum == selectedOperationNumber}
                                DispatchQueue.main.async {
                                    if oprArr.count > 0{
                                        let opr  = oprArr[0]
                                        self.addTimeEntryVC!.operationTextField.text = opr.OperationNum + " - " + opr.PlannofOpera
                                    }else{
                                        self.addTimeEntryVC!.operationTextField.text = ""
                                    }
                                    self.addTimeEntryVC!.selectOperationButton.isUserInteractionEnabled = false
                                    self.addTimeEntryVC!.operationTextField.isUserInteractionEnabled = false
                                }
                            }
                        }else if self.addTimeEntryVC!.screenType == "EditTimeSheet"{
                            if self.addTimeEntryVC!.timeSheetClass.OperAct != ""{
                                let oprArr  = self.addTimeEntryVC!.operationArray.filter{$0.OperationNum == self.addTimeEntryVC!.timeSheetClass.OperAct}
                                DispatchQueue.main.async {
                                    if oprArr.count > 0{
                                        let opr  = oprArr[0]
                                        self.addTimeEntryVC!.operationTextField.text = opr.OperationNum + " - " + opr.PlannofOpera
                                    }else{
                                        self.addTimeEntryVC!.operationTextField.text = ""
                                    }
                                    self.addTimeEntryVC!.selectOperationButton.isUserInteractionEnabled = false
                                    self.addTimeEntryVC!.operationTextField.isUserInteractionEnabled = false
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                if self.addTimeEntryVC!.operationListArray.count > 0{
                                    self.addTimeEntryVC!.operationTextField.text = self.addTimeEntryVC!.operationListArray[0]
                                }
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async {
                            self.addTimeEntryVC!.operationTextField.text = ""
                            self.addTimeEntryVC!.operationListArray.removeAll()
                        }
                    }
                }else{
                    mJCLogger.log("Data not availble", Type: "Error")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getTimeSheetData(date : Date) {
        
        mJCLogger.log("Starting", Type: "info")
        self.addTimeEntryVC!.timeSheetArray.removeAll()
        TimeSheetModel.getTimeSheetData(date: date){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [TimeSheetModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.addTimeEntryVC!.timeSheetArray = responseArr
                }else{
                    mJCLogger.log("Data not found",Type: "Error")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    //MARK:- Set Create & Edit Data..
    func getStausChangeLogSet(validStatus:StatusCategoryModel) {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.addTimeEntryVC!.dateViewTextField.text = "\(Date().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))"
        }
        self.getTimeSheetData(date: self.addTimeEntryVC!.selectedDate as Date)
        
        if  self.addTimeEntryVC!.screenType == "StatusChange"{
            
            var defineQuery = String()
            let status  = validStatus.Ref_Cal_Status
            
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                defineQuery = "$filter=(StatusCode eq '\(status)' and Operation eq '\(selectedOperationNumber)'  and ObjectNum eq '\(selectedworkOrderNumber)' and IsConsidered eq false)"
            }else{
                defineQuery = "$filter=(StatusCode eq '\(status)' and Operation eq ''  and ObjectNum eq '\(selectedworkOrderNumber)' and IsConsidered eq false)"
            }
            StatusChangeLogModel.getStatusChangeLogList(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [StatusChangeLogModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0 {
                            let timeDict = responseArr[0]
                            self.addTimeEntryVC!.suspendViewModel.suspendVc?.statusLogset = timeDict
                            if ENABLE_CAPTURE_DURATION == false{
                                if timeDict.StatusChangedTime != nil{
                                    let date = timeDict.StatusChangedTime!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                                    let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeDict.StatusTime)
                                    let datetime = Date(fromString: "\(date) \(time)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let currrentDateTime = Date().localDate()
                                    let elapsedTime = currrentDateTime.timeIntervalSince(datetime)
                                    let hours = floor(elapsedTime / 60 / 60)
                                    let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
                                    self.totalHours = Int(hours)
                                    self.totalMins = Int(minutes)
                                    DispatchQueue.main.async{
                                        self.addTimeEntryVC!.startTimeTextField.text = "\(self.totalHours)"
                                        self.addTimeEntryVC!.endTimeTextField.text = "\(self.totalMins)"
                                    }
                                }
                            }else{
                                DispatchQueue.main.async{
                                    let startTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeDict.StatusTime)
                                    let currrentTime = Date().toString(format: .custom("HH:mm"), timeZone: .local, locale: .current)
                                    self.addTimeEntryVC!.startTimeTextField.text = startTime
                                    self.addTimeEntryVC!.endTimeTextField.text = currrentTime
                                }
                            }
                        }else{
                            self.StatusChangeData = false
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        self.StatusChangeData = false
                    }
                    if ENABLE_CAPTURE_TEAM_TIMESHEET == true && self.addTimeEntryVC!.screenType == "StatusChange"{
                        let personDetails = globalPersonRespArray.filter{$0.PersonnelNo == "\(userPersonnelNo)"}
                        if personDetails.count > 0{
                            DispatchQueue.main.async {
                                let per = personDetails[0]
                                self.addTimeEntryVC!.personResponsibleTextField.text = "\(per.SystemID) - \(per.EmplApplName)"
                                self.validateScreenValues()
                            }
                        }
                    }
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
//            let date = DateFormatterModelClass.uniqueInstance.getDateWithoutTimeZone(date: NSDate())
            self.addTimeEntryVC!.dateViewTextField.text = ODSDateHelper.convertDateToString(date: Date())
        }
        self.getWorkCentersList()
        mJCLogger.log("Ended", Type: "info")
        
    }
    //MARK:- Get WorkCenters List..
    func getWorkCentersList() {
        
        mJCLogger.log("Starting", Type: "info")
        
        self.addTimeEntryVC!.workCentersArray.removeAll()
        self.addTimeEntryVC!.workCentersListArray.removeAll()
        if globalWorkCtrArray.count > 0
        {
            self.addTimeEntryVC!.workCentersArray.append(contentsOf: globalWorkCtrArray)
            for item in self.addTimeEntryVC!.workCentersArray {
                self.addTimeEntryVC!.workCentersListArray.append(item.WorkCenter + " - " + item.Plant)
            }
            if self.addTimeEntryVC!.screenType == "EditTimeSheet" && self.addTimeEntryVC!.isFromError == true{
                self.addTimeEntryVC!.workCenterTextField.text = "\(self.addTimeEntryVC!.timeSheetClass.WorkCenter) - \(self.addTimeEntryVC!.timeSheetClass.Plant)"
            }else if self.addTimeEntryVC!.screenType == "EditTimeSheet" {
                self.addTimeEntryVC!.workCenterTextField.text = "\(self.addTimeEntryVC!.timeSheetClass.WorkCenter) - \(self.addTimeEntryVC!.timeSheetClass.Plant)"
            }else {
                let filterArr = self.addTimeEntryVC!.workCentersArray.filter{$0.WorkCenter == userWorkcenter}
                if filterArr.count > 0{
                    let cls = filterArr[0]
                    DispatchQueue.main.async {
                        self.addTimeEntryVC!.workCenterTextField.text = (cls.WorkCenter + " - " + cls.Plant)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.addTimeEntryVC!.workCenterTextField.text = self.addTimeEntryVC!.workCentersListArray[0]
                    }
                }
            }
            if (self.addTimeEntryVC?.workCentersListArray.count)! > 0{
                self.addTimeEntryVC?.workCenterTextField.optionArray = self.addTimeEntryVC!.workCentersListArray
                self.addTimeEntryVC?.workCenterTextField.checkMarkEnabled = false
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    //MARK:- Get Activity List..
    func getActivityList() {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderActivityModel.getWorkOrderActivityList(){ (responseDict, error)  in
            if error == nil{
                self.addTimeEntryVC?.activityArray.removeAll()
                if let responseArr = responseDict["data"] as? [WorkOrderActivityModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.addTimeEntryVC?.activityArray = responseArr
                    self.setActivity()
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Activity Data..
    func setActivity()  {
        mJCLogger.log("Starting", Type: "info")
        self.addTimeEntryVC!.activityListArray.removeAll()
        DispatchQueue.main.async {
            if self.addTimeEntryVC!.activityArray.count > 0 {
                for activity in self.addTimeEntryVC!.activityArray {
                    self.addTimeEntryVC!.activityListArray.append(activity.ActivityType + " - " + activity.ShortText)
                }
                if self.addTimeEntryVC!.screenType == "EditTimeSheet" && self.addTimeEntryVC?.isFromError == true{
                    let activityArr = self.addTimeEntryVC!.activityArray.filter{$0.ActivityType == "\(self.addTimeEntryVC!.timeSheetClass.ActivityType)"}
                    if activityArr.count > 0{
                        let activityCls = activityArr[0]
                        self.addTimeEntryVC!.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                    }
                }else if self.addTimeEntryVC!.screenType == "EditTimeSheet" {
                    let activityArr = self.addTimeEntryVC!.activityArray.filter{$0.ActivityType == "\(self.addTimeEntryVC!.timeSheetClass.ActivityType)"}
                    if activityArr.count > 0{
                        let activityCls = activityArr[0]
                        self.addTimeEntryVC!.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                    }
                }else if self.addTimeEntryVC!.screenType == "AddTimeSheet" {
                    let activityCls = self.addTimeEntryVC!.activityArray[0]
                    self.addTimeEntryVC!.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                }else {
                    let activityArr = self.addTimeEntryVC!.activityArray.filter{$0.ActivityType == "\(self.addTimeEntryVC!.statusCategoryCls.ActivityType)"}
                    if activityArr.count > 0{
                        let activityCls = activityArr[0]
                        self.addTimeEntryVC!.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                    }else{
                        let activityCls = self.addTimeEntryVC!.activityArray[0]
                        self.addTimeEntryVC!.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                    }
                }
                if (self.addTimeEntryVC?.activityListArray.count)! > 0{
                    self.addTimeEntryVC?.activityTypeTextField.optionArray = self.addTimeEntryVC!.activityListArray
                    self.addTimeEntryVC?.activityTypeTextField.checkMarkEnabled = false
                }
            }else {
                mJCLogger.log("Data not found", Type: "Debug")
                self.addTimeEntryVC?.activityListArray.removeAll()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Attendance Type List..
    func getAttandenceTypeList() {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.global(qos: .default).async {
            AttendanceTypeModel.getAttendanceTypeList(){ (responseDict, error)  in
                if error == nil{
                    self.addTimeEntryVC!.attendanceTypeArray.removeAll()
                    self.addTimeEntryVC!.attendanceTypeListArray.removeAll()
                    if let responseArr = responseDict["data"] as? [AttendanceTypeModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.addTimeEntryVC!.attendanceTypeArray =  responseArr
                        self.addTimeEntryVC!.attendanceTypeListArray = responseArr
                        self.setAttendanceType()
                    }else{
                        DispatchQueue.main.async {
                            self.addTimeEntryVC!.attenenceTypeTextField.text = ""
                        }
                    }
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
                if self.addTimeEntryVC!.screenType == "StatusChange" {
                    self.getStausChangeLogSet(validStatus: self.addTimeEntryVC!.statusCategoryCls)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set AttendanceType Data..
    func setAttendanceType() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.addTimeEntryVC!.screenType != "EditTimeSheet" {
                let attendancePredicate : NSPredicate = NSPredicate(format: "SELF.AttAbsType == %@","\(ATT_TYPE_HOURS_OF_COSTING)")
                let attendanceFilteredArray = (self.addTimeEntryVC!.attendanceTypeListArray as NSArray).filtered(using: attendancePredicate) as! [AttendanceTypeModel]
                if attendanceFilteredArray.count > 0{
                    let attendanceClass = attendanceFilteredArray[0]
                    self.addTimeEntryVC!.attenenceTypeTextField.text = "\(attendanceClass.AttAbsType) - \(attendanceClass.AATypeText)"
                }else{
                    self.addTimeEntryVC!.attenenceTypeTextField.text = self.addTimeEntryVC!.attendanceTypeArray[0].AttAbsType + " - " + self.addTimeEntryVC!.attendanceTypeArray[0].AATypeText
                }
            }else if self.addTimeEntryVC!.screenType == "EditTimeSheet" && self.addTimeEntryVC!.isFromError == true{
                let attendancePredicate : NSPredicate = NSPredicate(format: "SELF.AttAbsType == %@",self.addTimeEntryVC!.timeSheetClass.AttAbsType)
                let attendanceFilteredArray = (self.addTimeEntryVC!.attendanceTypeListArray as NSArray).filtered(using: attendancePredicate) as! [AttendanceTypeModel]
                if attendanceFilteredArray.count > 0{
                    let attendanceClass = attendanceFilteredArray[0]
                    self.addTimeEntryVC!.attenenceTypeTextField.text = "\(attendanceClass.AttAbsType) - \(attendanceClass.AATypeText)"
                }
            }else if self.addTimeEntryVC!.screenType == "EditTimeSheet" {
                let attendancePredicate : NSPredicate = NSPredicate(format: "SELF.AttAbsType == %@",self.addTimeEntryVC!.timeSheetClass.AttAbsType)
                let attendanceFilteredArray = (self.addTimeEntryVC!.attendanceTypeListArray as NSArray).filtered(using: attendancePredicate) as! [AttendanceTypeModel]
                if attendanceFilteredArray.count > 0{
                    let attendanceClass = attendanceFilteredArray[0]
                    self.addTimeEntryVC!.attenenceTypeTextField.text = "\(attendanceClass.AttAbsType) - \(attendanceClass.AATypeText)"
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPremiumvalues(){
        mJCLogger.log("Starting", Type: "info")
        PremiumIdModel.getPremiumIdList(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [PremiumIdModel]{
                    self.addTimeEntryVC!.premiumIDArray = responseArr
                }
                self.setpremiumvalue()
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setpremiumvalue(){
        mJCLogger.log("Starting", Type: "info")
        if self.addTimeEntryVC!.premiumIDArray.count > 0{
            if self.addTimeEntryVC!.screenType == "EditTimeSheet"{
                let premiumId = self.addTimeEntryVC!.timeSheetClass.PremiumID
                let premiumNo = self.addTimeEntryVC!.timeSheetClass.PremiumNo
                if premiumId != "" && premiumNo != ""{
                    let filterArr = self.addTimeEntryVC!.premiumIDArray.filter{$0.PremiumNo == "\(premiumNo)" && $0.PremiumID == "\(premiumId)"}
                    if filterArr.count > 0{
                        DispatchQueue.main.async {
                            self.addTimeEntryVC!.premiumTextField.text = filterArr[0].PremiumID + " - " + filterArr[0].PremiumText
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.addTimeEntryVC!.premiumTextField.text = selectStr
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.addTimeEntryVC!.premiumTextField.text = selectStr
//                    self.addTimeEntryVC!.PremiumButton.setTitle("", for: .normal)
                }
            }
            
            if self.addTimeEntryVC!.premiumIDArray.count > 0 {
                var arr = Array<String>()
                arr.append(selectStr)
                for item in self.addTimeEntryVC!.premiumIDArray{
                    arr.append(item.PremiumID + " - " + item.PremiumText)
                }
                self.addTimeEntryVC?.premiumTextField.optionArray = arr
                self.addTimeEntryVC?.premiumTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func validateScreenValues(){
        
        DispatchQueue.main.async {
            mJCLogger.log("Starting", Type: "info")
            if self.addTimeEntryVC!.dateViewTextField.text == "" {
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Pleas_select_the_date".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return
            }
            if (self.addTimeEntryVC!.workOrdrTextField.text == "--none--".localized() || self.addTimeEntryVC!.workOrdrTextField.text == nil) && self.addTimeEntryVC!.workOrdrTextField.text == "" {
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_select_or_enter_workorder".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return
            }
            if (self.addTimeEntryVC!.workOrdrTextField.text == "--none--".localized() || self.addTimeEntryVC!.workOrdrTextField.text == nil) && self.addTimeEntryVC!.workOrdrTextField.text != "" && self.addTimeEntryVC!.screenType != "EditTimeSheet"{
                let workorderNum  = "\(self.addTimeEntryVC!.workOrderTextField.text!)"
                let woNumPredicate : NSPredicate = NSPredicate(format: "SELF.WorkOrderNum == %@",workorderNum)
                if let workCenterFilteredArray = (self.addTimeEntryVC!.workOrderArray as NSArray).filtered(using: woNumPredicate) as? [WoHeaderModel] {
                    if workCenterFilteredArray.count == 0{
                        mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Work_Order_Number_Doesn't_exist".localized(), button: okay)
                        mJCLogger.log("Ended", Type: "info")
                        return
                    }
                }
            }
            if (self.addTimeEntryVC!.workOrdrTextField.text != "--none--".localized() || self.addTimeEntryVC!.workOrdrTextField.text != nil) && self.addTimeEntryVC!.workOrdrTextField.text == "" && self.addTimeEntryVC!.screenType != "EditTimeSheet"{
                let woNum = self.addTimeEntryVC!.workOrdrTextField.text!
                if woNum == "" {
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_select_or_enter_workorder".localized(), button: okay)
                    return
                }else{
                    let arr = woNum.components(separatedBy: " - ")
                    if arr.count > 0 {
                        if arr[0].contains(find: "L"){
                            mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "We_can't_fill_time_sheet_for_Local_Work_order".localized(), button: okay)
                            mJCLogger.log("Ended", Type: "info")
                            return
                        }
                    }else{
                        mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Work_Order_Number_Doesn't_exist".localized(), button: okay)
                        mJCLogger.log("Ended", Type: "info")
                        return
                    }
                }
            }
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if self.addTimeEntryVC!.operationTextField.text == "" {
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_enter_operation".localized(), button: okay)
                    mJCLogger.log("Ended", Type: "info")
                    return
                }
            }
            if self.addTimeEntryVC!.attenenceTypeTextField.text == "" {
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_enter_absent_attenence_type".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return
            }
            if self.addTimeEntryVC!.activityTypeTextField.text == "" {
                mJCLogger.log("Please_enter_activity_type".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_enter_activity_type".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return
            }
            if self.addTimeEntryVC!.workCenterTextField.text == "" {
                mJCLogger.log("Please_enter_workcenter".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_enter_workcenter".localized(), button: okay)
                mJCLogger.log("Ended", Type: "info")
                return
            }
            if ENABLE_CAPTURE_TEAM_TIMESHEET == true && self.addTimeEntryVC!.screenType == "StatusChange"{
                if self.addTimeEntryVC!.personResponsibleTextField.text == "" && self.addTimeEntryVC!.resourceTimesheetArray.count != 0{
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Person_Responsible".localized(), button: okay)
                    mJCLogger.log("Please_Select_Person_Responsible".localized(), Type: "Warn")
                    return
                }
            }
            if ENABLE_CAPTURE_DURATION == false{
                if self.addTimeEntryVC!.startTimeTextField.text == "" && self.addTimeEntryVC!.endTimeTextField.text == ""{
                    if self.StatusChangeData == false && self.addTimeEntryVC!.screenType == "StatusChange"{
                        return
                    }else{
                        mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Hours_And_Minutes".localized(), button: okay)
                        mJCLogger.log("Please_Select_Hours_And_Minutes".localized(), Type: "Warn")
                        return
                    }
                }
                if (self.addTimeEntryVC!.startTimeTextField.text == "0" || self.addTimeEntryVC!.startTimeTextField.text == "00") && (self.addTimeEntryVC!.endTimeTextField.text == "0" || self.addTimeEntryVC!.endTimeTextField.text == "00") {
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Hours_And_Minutes".localized(), button: okay)
                    mJCLogger.log("Please_Select_Hours_And_Minutes".localized(), Type: "Warn")
                    return
                }
                if (self.addTimeEntryVC!.startTimeTextField.text == "" || self.addTimeEntryVC!.startTimeTextField.text == "0") && (self.addTimeEntryVC!.endTimeTextField.text == "" || self.addTimeEntryVC!.endTimeTextField.text == "0" || self.addTimeEntryVC!.endTimeTextField.text == "00"){
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Hours".localized(), button: okay)
                    mJCLogger.log("Please_Select_Hours".localized(), Type: "Warn")
                    return
                }
                if (self.addTimeEntryVC!.endTimeTextField.text == "" || self.addTimeEntryVC!.endTimeTextField.text == "0" || self.addTimeEntryVC!.endTimeTextField.text == "00") && (self.addTimeEntryVC!.startTimeTextField.text == "" || self.addTimeEntryVC!.startTimeTextField.text == "0") || self.addTimeEntryVC!.startTimeTextField.text == "00"{
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Minutes".localized(), button: okay)
                    mJCLogger.log("Please_Select_Minutes".localized(), Type: "Warn")
                    return
                }
                if self.totalHours > 24{
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Hours".localized(), button: okay)
                    mJCLogger.log("Please_Select_Hours".localized(), Type: "Warn")
                    return
                }
                if self.totalMins > 60{
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Minutes".localized(), button: okay)
                    mJCLogger.log("Please_Select_Minutes".localized(), Type: "Warn")
                    return
                }
            }else{
                if self.addTimeEntryVC!.startTimeTextField.text == "" && self.addTimeEntryVC!.endTimeTextField.text == ""{
                    if self.StatusChangeData == false && self.addTimeEntryVC!.screenType == "StatusChange"{
                        return
                    }else{
                        mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_select_time".localized() , button: okay)
                        mJCLogger.log("Please_select_time".localized(), Type: "Warn")
                    }
                }
                if self.addTimeEntryVC!.startTimeTextField.text == "" {
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_Star_Time".localized(), button: okay)
                    mJCLogger.log("Please_Select_Star_Time".localized(), Type: "Warn")
                    return
                }
                if self.addTimeEntryVC!.endTimeTextField.text == "" {
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_Select_End_Time".localized(), button: okay)
                    mJCLogger.log("Please_Select_End_Time".localized(), Type: "Warn")
                    return
                }
                if self.validateTimeRange() == false {
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Please_selecte_valid_time_range".localized(), button: okay)
                    return
                }
            }
            if self.totalHours * 60 > 1440{
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Can't_add_more_than_24_hours_in_one_day".localized(), button: okay)
                return
            }
            if self.addTimeEntryVC!.screenType == "EditTimeSheet"{
                self.updateTimeSheet()
            }else {
                self.createTimeSheet()
            }
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func complete(){
        if self.addTimeEntryVC!.screenType == "StatusChange"{
            var entityDict = Dictionary<String,Any>()
            entityDict["collectionPath"] = catRecordSet
            entityDict["entity"] = self.addTimeEntryVC!.resourceTimesheetArray
            entityDict["type"] = "Create"
            self.addTimeEntryVC!.suspendViewModel.entityDict["timeEntry"] = entityDict
            self.addTimeEntryVC!.suspendViewModel.validateCompletionFeatures()
        }
    }
    func validateTimeRange() -> Bool{
        
        mJCLogger.log("Starting", Type: "info")
        if self.addTimeEntryVC!.timeSheetArray.count > 0 {
            if self.addTimeEntryVC!.screenType == "EditTimeSheet"{
                let timeSheetArrayedit = self.addTimeEntryVC!.timeSheetArray[self.addTimeEntryVC!.cellIndex]
                var timeSheetArray1 = self.addTimeEntryVC!.timeSheetArray
                timeSheetArray1.remove(at: self.addTimeEntryVC!.cellIndex)
                let timesheetClassEdit = timeSheetArrayedit
                let startTimeEditStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timesheetClassEdit.StartTime)
                let endTimeEditStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timesheetClassEdit.EndTime)
                if self.addTimeEntryVC!.startTimeTextField.text == startTimeEditStr && self.addTimeEntryVC!.endTimeTextField.text == endTimeEditStr{
                    return true
                }else{
                    for i in 0..<timeSheetArray1.count{
                        if timeSheetArray1.count > 0 {
                            let timeSheetClass = timeSheetArray1[i]
                            let startTimeStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.StartTime)
                            let endTimeStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.EndTime)
                            let oldStartTitme = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: startTimeStr)
                            let oldEndTime = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: endTimeStr)
                            let newStartTitme = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: self.addTimeEntryVC!.startTimeTextField.text!)
                            let newEndTime = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: self.addTimeEntryVC!.endTimeTextField.text!)
                            if (oldStartTitme <= newStartTitme && newStartTitme <= oldEndTime) || (oldStartTitme <= newEndTime && newEndTime <= oldEndTime){
                                return false
                            }
                        }
                    }
                    return true
                }
            }else{
                for i in 0..<self.addTimeEntryVC!.timeSheetArray.count{
                    let timeSheetClass = self.addTimeEntryVC!.timeSheetArray[i]
                    let startTimeStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.StartTime)
                    let endTimeStr = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeSheetClass.EndTime)
                    let oldStartTitme = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: startTimeStr)
                    let oldEndTime = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: endTimeStr)
                    let newStartTitme = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: self.addTimeEntryVC!.startTimeTextField.text!)
                    let newEndTime = DateFormatterModelClass.uniqueInstance.getStringtoTime(time: self.addTimeEntryVC!.endTimeTextField.text!)
                    if (oldStartTitme <= newStartTitme && newStartTitme <= oldEndTime) || (oldStartTitme <= newEndTime && newEndTime <= oldEndTime){
                        mJCLogger.log("Ended", Type: "info")
                        return false
                    }
                }
                mJCLogger.log("Ended", Type: "info")
                return true
            }
        }else{
            mJCLogger.log("Ended", Type: "info")
            return true
        }
    }
    //MARK:- Create & Update TimeSheet..
    func createTimeSheet() {
        
        mJCLogger.log("Starting", Type: "info")
        if ENABLE_CAPTURE_DURATION == true{
            let startTimeStr = self.addTimeEntryVC!.startTimeTextField.text!
            let endTimeStr = self.addTimeEntryVC!.endTimeTextField.text!
            let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startTimeStr, timeFormate: "HH:mm")
            let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endTimeStr, timeFormate: "HH:mm")
            if startTime != nil && endTime != nil{
                let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
                let timeDifference = Calendar.current.dateComponents(requestedComponent, from: startTime!, to: endTime!)
                var hours = Float()
                var minutes = Float()
                if timeDifference.hour != nil && timeDifference.minute != nil{
                    let hour = timeDifference.hour!
                    let min = timeDifference.minute!
                    hours = Float(hour)
                    minutes = Float(min)
                }else{
                    hours = 0
                    minutes =  0
                }
                self.totalCatHours = Float("\(hours + minutes / 60)")!
            }
        }else{
            let hour = self.addTimeEntryVC?.startTimeTextField.text ?? "0"
            let min = self.addTimeEntryVC?.endTimeTextField.text ?? "0"
            var hours = Float()
            var minutes = Float()
            if let hou = Float(hour){
                hours = hou
            }else{
                hours = 0.0
            }
            if let mini = Float(min){
                minutes = mini
            }else{
                minutes = 0.2
            }
            self.totalCatHours = Float("\(hours + minutes / 60)")!
        }
        
        self.addTimeEntryVC!.property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ActivityNumber")
        prop!.value = String.random(length: 4, type: "Number") as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ActivityType")
        let activityArr = self.addTimeEntryVC!.activityTypeTextField.text!.components(separatedBy: " - ")
        if activityArr.count > 0{
            let activityFilteredArray = self.addTimeEntryVC!.activityArray.filter{$0.ActivityType == activityArr[0]}
            if activityFilteredArray.count > 0{
                let activityClass = activityFilteredArray[0]
                prop!.value = activityClass.ActivityType as NSObject
                self.addTimeEntryVC!.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "SendCCtr")
                prop!.value = activityClass.CostCenter as NSObject
                self.addTimeEntryVC!.property.add(prop!)
            }
        }
        
        prop = SODataPropertyDefault(name: "Amount")
        prop!.value = NSDecimalNumber(string: "0")
        self.addTimeEntryVC!.property.add(prop!)
        
        if let premiumtext = self.addTimeEntryVC!.premiumTextField.text{
            if premiumtext != selectStr || premiumtext != ""{
                let arr = self.addTimeEntryVC!.premiumTextField.text!.components(separatedBy: " - ")
                if arr.count > 0{
                    let filteredArray = self.addTimeEntryVC!.premiumIDArray.filter{$0.PremiumID == arr[0]}
                    if filteredArray.count > 0{
                        prop = SODataPropertyDefault(name: "PremiumID")
                        prop!.value = filteredArray[0].PremiumID as NSObject
                        self.addTimeEntryVC!.property.add(prop!)
                        
                        prop = SODataPropertyDefault(name: "PremiumNo")
                        prop!.value = filteredArray[0].PremiumNo as NSObject
                        self.addTimeEntryVC!.property.add(prop!)
                    }
                }
            }
        }
        prop = SODataPropertyDefault(name: "ApprovedBy")
        prop!.value = "" as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "AttAbsType")
        let attendanceArr = self.addTimeEntryVC!.attenenceTypeTextField.text!.components(separatedBy: " - ")
        if attendanceArr.count > 0 {
            prop!.value = attendanceArr[0] as NSObject
            self.addTimeEntryVC!.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "COArea")
        if addTimeEntryVC?.screenType == "StatusChange"{
            prop!.value = singleWorkOrder.ControllingArea as NSObject
        }else{
            let woNum = self.addTimeEntryVC!.workOrdrTextField.text!
            let arr = woNum.components(separatedBy: " - ")
            if arr.count > 0 {
                prop!.value = arr[1] as NSObject
            }else{
                prop!.value = "" as NSObject
            }
        }
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = String.random(length: 4, type: "Number") as NSObject as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ChangedBy")
        prop!.value = strUser.uppercased() as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = Date().localDate() as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedonTime")
        let createdTime = SODataDuration()
        
        let time = Date().localDate().toString(format: .custom("hh:mm"))
        let timeArray = time.components(separatedBy: ":")
        createdTime.hours = Int(timeArray[0]) as NSNumber?
        createdTime.minutes = Int(timeArray[1]) as NSNumber?
        createdTime.seconds = 0
        prop!.value = createdTime
        self.addTimeEntryVC!.property.add(prop!)
        
        if ENABLE_CAPTURE_DURATION == true{
            prop = SODataPropertyDefault(name: "StartTime")
            let startTime = SODataDuration()
            let startTimeArray = self.addTimeEntryVC!.startTimeTextField.text?.components(separatedBy:":")
            startTime.hours = Int(startTimeArray![0])! as NSNumber
            startTime.minutes = Int(startTimeArray![1])! as NSNumber
            startTime.seconds = 0
            prop!.value = startTime
            self.addTimeEntryVC!.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EndTime")
            let endTime = SODataDuration()
            let endTimeArray = self.addTimeEntryVC!.endTimeTextField.text?.components(separatedBy:":")
            endTime.hours = Int(endTimeArray![0])! as NSNumber
            endTime.minutes = Int(endTimeArray![1])! as NSNumber
            endTime.seconds = 0
            prop!.value = endTime
            self.addTimeEntryVC!.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "CatsHours")
        prop!.value = NSDecimalNumber(string: "\(abs(totalCatHours))")
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Date")
        prop!.value = Date(fromString: self.addTimeEntryVC!.dateViewTextField.text!, format: .custom(localDateFormate), timeZone: .utc, locale: .current) as NSObject?
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userPersonnelNo as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FullDay")
        prop!.value = false as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "LastChange")
        prop!.value = NSDate()
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "LastChangeTime")
        prop!.value = createdTime
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "LongText")
        prop!.value = false as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Network")
        prop!.value = "" as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            var operaionNum = String()
            var PlannofOpera = String()
            
            let arr = self.addTimeEntryVC!.operationTextField.text!.components(separatedBy: " - ")
            if arr.count == 2{
                operaionNum = arr[0]
                PlannofOpera = arr[1]
            }
            prop = SODataPropertyDefault(name: "OperAct")
            prop!.value = operaionNum as NSObject
            self.addTimeEntryVC!.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PlannofOpera")
            prop!.value = PlannofOpera as NSObject
            self.addTimeEntryVC!.property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "OperaCounter")
        prop!.value = "" as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OrderCategory")
        prop!.value = "" as NSObject
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        let arr1 = self.addTimeEntryVC!.workCenterTextField.text!.components(separatedBy: " - ")
        if arr1.count > 0 {
            prop!.value = arr1[1] as NSObject
            self.addTimeEntryVC!.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkCenter")
            prop!.value = arr1[0] as NSObject
            self.addTimeEntryVC!.property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "PreviousDay")
        prop!.value = NSDecimalNumber(string: "0")
        self.addTimeEntryVC!.property.add(prop!)
        
        if self.addTimeEntryVC!.postConfirmationButton.isSelected{
            prop = SODataPropertyDefault(name: "FinalConfirmtn")
            prop!.value = "X" as NSObject
            self.addTimeEntryVC!.property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "RecOrder")
        if (self.addTimeEntryVC!.workOrdrTextField.text == "--none--".localized()){
            prop!.value = "\(self.addTimeEntryVC!.workOrdrTextField.text!)" as NSObject
        }else {
            let woNum = self.addTimeEntryVC?.workOrdrTextField.text ?? ""
            let arr = woNum.components(separatedBy: " - ")
            if arr.count > 0 {
                prop!.value = arr[0] as NSObject
                self.addTimeEntryVC!.property.add(prop!)
            }
        }
        self.addTimeEntryVC!.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "RemainingWork")
        prop!.value = NSDecimalNumber(string: "0")
        self.addTimeEntryVC!.property.add(prop!)
        
        let entity = SODataEntityDefault(type: catsRecordSetEntity)
        
        if ENABLE_CAPTURE_TEAM_TIMESHEET == true && self.addTimeEntryVC!.screenType == "StatusChange"{
            
            prop = SODataPropertyDefault(name: "PersonnelNo")
            if self.addTimeEntryVC!.selectedPersonalNumber == "" && self.addTimeEntryVC!.resourceTimesheetArray.count == 0{
                prop!.value = userPersonnelNo as NSObject
            }else{
                prop!.value = self.addTimeEntryVC!.selectedPersonalNumber as NSObject
            }
            self.addTimeEntryVC!.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EnteredBy")
            prop!.value = userSystemID.uppercased() as NSObject
            self.addTimeEntryVC!.property.add(prop!)
            
            for prop in self.addTimeEntryVC!.property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name ?? ""] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
            self.addTimeEntryVC!.resourceTimesheetArray.add(entity!)
            DispatchQueue.main.async {
                self.addTimeEntryVC!.resourceTimesheetView.isHidden = false
                self.addTimeEntryVC!.resourceTimesheetTableView.reloadData()
            }
            return
        }else{
            prop = SODataPropertyDefault(name: "PersonnelNo")
            prop!.value = userPersonnelNo as NSObject
            self.addTimeEntryVC!.property.add(prop!)
            
            for prop in self.addTimeEntryVC!.property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name ?? ""] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
        }
        self.addTimeEntryVC!.newTimeSheetEntity = entity
        if self.addTimeEntryVC!.screenType == "StatusChange"{
            let arr = NSMutableArray()
            arr.add(entity!)
            var entityDict = Dictionary<String,Any>()
            entityDict["collectionPath"] = catRecordSet
            entityDict["entity"] = arr
            entityDict["type"] = "Create"
            self.addTimeEntryVC!.suspendViewModel.entityDict["timeEntry"] = entityDict
            self.addTimeEntryVC!.suspendViewModel.validateCompletionFeatures()
        }else{
            TimeSheetModel.createTimeSheetEntity(entity: self.addTimeEntryVC!.newTimeSheetEntity!, collectionPath: catRecordSet,flushRequired: true ,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("TimeSheet Entity Created successfully".localized(), Type: "")
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Timesheet_Data_Saved_Successfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self.addTimeEntryVC!, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            DispatchQueue.main.async {
                                self.addTimeEntryVC!.timeSheetDelegate?.timeSheetAdded(statusCategoryCls: self.addTimeEntryVC!.statusCategoryCls)
                                self.addTimeEntryVC!.dismiss(animated: false) {}
                            }
                        default: break
                        }
                    }
                }else {
                    self.addTimeEntryVC!.timeSheetDelegate?.timeSheetAdded(statusCategoryCls: self.addTimeEntryVC!.statusCategoryCls)
                    mJCLogger.log("\(error?.localizedDescription)", Type: "Error")
                    mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Adding_timeSheet_entity_fails".localized(), button: okay)
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func updateTimeSheet() {
        
        mJCLogger.log("Starting", Type: "info")
        
        let activityArr = self.addTimeEntryVC!.activityTypeTextField.text!.components(separatedBy: " - ")
        if activityArr.count > 0{
            let activityFilteredArray = self.addTimeEntryVC!.activityArray.filter{$0.ActivityType == activityArr[0]}
            if activityFilteredArray.count > 0{
                let activityClass = activityFilteredArray[0]
                (self.addTimeEntryVC!.timeSheetClass.entity.properties["ActivityType"] as! SODataProperty).value = activityClass.ActivityType as NSObject
                self.addTimeEntryVC!.timeSheetClass.ActivityType = activityClass.ActivityType
                (self.addTimeEntryVC!.timeSheetClass.entity.properties["SendCCtr"] as! SODataProperty).value = activityClass.CostCenter as NSObject
                self.addTimeEntryVC!.timeSheetClass.SendCCtr = activityClass.CostCenter
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        let attendanceArr = self.addTimeEntryVC!.attenenceTypeTextField.text!.components(separatedBy: " - ")
        if attendanceArr.count > 0{
            (self.addTimeEntryVC!.timeSheetClass.entity.properties["AttAbsType"] as! SODataProperty).value = attendanceArr[0] as NSObject
            self.addTimeEntryVC!.timeSheetClass.AttAbsType = attendanceArr[0]
        }
        (self.addTimeEntryVC!.timeSheetClass.entity.properties["COArea"] as! SODataProperty).value = singleWorkOrder.ControllingArea as NSObject
        self.addTimeEntryVC!.timeSheetClass.COArea = singleWorkOrder.ControllingArea
        if ENABLE_CAPTURE_DURATION == true{
            let startTimeStr = self.addTimeEntryVC!.startTimeTextField.text!
            let endTimeStr = self.addTimeEntryVC!.endTimeTextField.text!
            let startTime = ODSDateHelper.getdateTimeFromTimeString(timeString: startTimeStr, timeFormate: "HH:mm")
            let endTime = ODSDateHelper.getdateTimeFromTimeString(timeString: endTimeStr, timeFormate: "HH:mm")
            if startTime != nil && endTime != nil{
                let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
                let timeDifference = Calendar.current.dateComponents(requestedComponent, from: startTime!, to: endTime!)
                self.totalHours = timeDifference.hour ?? 0
                self.totalMins = timeDifference.minute ?? 0
                self.totalCatHours = Float("\(self.totalHours + self.totalMins / 60)")!
            }else{
                self.totalCatHours = 0.2
            }
        }else{
            
            let hour = self.addTimeEntryVC?.startTimeTextField.text ?? "0"
            let min = self.addTimeEntryVC?.endTimeTextField.text ?? "0"
            var hours = Float()
            var minutes = Float()
            if let hou = Float(hour){
                hours = hou
            }else{
                hours = 0.0
            }
            if let mini = Float(min){
                minutes = mini
            }else{
                minutes = 0.2
            }
            self.totalCatHours = Float("\(hours + minutes / 60)")!
        }
        (self.addTimeEntryVC!.timeSheetClass.entity.properties["CatsHours"] as! SODataProperty).value = NSDecimalNumber(string: "\(abs(totalCatHours))")
        self.addTimeEntryVC!.timeSheetClass.CatsHours = NSDecimalNumber(string: "\(abs(totalCatHours))")
        (self.addTimeEntryVC!.timeSheetClass.entity.properties["Date"] as! SODataProperty).value = Date(fromString: self.addTimeEntryVC!.dateViewTextField.text!, format: .custom(localDateFormate), timeZone: .utc, locale: .current) as NSObject?
        self.addTimeEntryVC!.timeSheetClass.date = Date(fromString: self.addTimeEntryVC!.dateViewTextField.text!, format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        (self.addTimeEntryVC!.timeSheetClass.entity.properties["LastChange"] as! SODataProperty).value = Date() as NSObject
        self.addTimeEntryVC!.timeSheetClass.LastChange = Date()
        let lastChangeTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        let timeArray = time.components(separatedBy: ":")
        lastChangeTime.hours = Int(timeArray[0]) as NSNumber?
        lastChangeTime.minutes = Int(timeArray[1]) as NSNumber?
        lastChangeTime.seconds = 0
        (self.addTimeEntryVC!.timeSheetClass.entity.properties["LastChangeTime"] as! SODataProperty).value = lastChangeTime
        self.addTimeEntryVC!.timeSheetClass.LastChangeTime = lastChangeTime
        if ENABLE_CAPTURE_DURATION == true{
            let startTime = SODataDuration()
            let startTimeArray = self.addTimeEntryVC!.startTimeTextField.text?.components(separatedBy: ":")
            startTime.hours = Int(startTimeArray![0]) as NSNumber?
            startTime.minutes = Int(startTimeArray![1]) as NSNumber?
            startTime.seconds = 0
            (self.addTimeEntryVC!.timeSheetClass.entity.properties["StartTime"] as! SODataProperty).value = startTime
            self.addTimeEntryVC!.timeSheetClass.StartTime = startTime
            let endTime = SODataDuration()
            let endTimeArray = self.addTimeEntryVC!.endTimeTextField.text?.components(separatedBy: ":")
            endTime.hours = Int(endTimeArray![0]) as NSNumber?
            endTime.minutes = Int(endTimeArray![1]) as NSNumber?
            endTime.seconds = 0
            (self.addTimeEntryVC!.timeSheetClass.entity.properties["EndTime"] as! SODataProperty).value = endTime
            self.addTimeEntryVC!.timeSheetClass.EndTime = endTime
        }
        let wrkctrArray = self.addTimeEntryVC!.workCenterTextField.text!.components(separatedBy: " - ")
        if wrkctrArray.count > 0 {
            let workCenterFilteredArray = self.addTimeEntryVC!.workCentersArray.filter{$0.WorkCenter == wrkctrArray[0]}
            if workCenterFilteredArray.count > 0{
                let workCenterClass = workCenterFilteredArray[0]
                (self.addTimeEntryVC!.timeSheetClass.entity.properties["Plant"] as! SODataProperty).value = workCenterClass.PlanningPlant as NSObject
                self.addTimeEntryVC!.timeSheetClass.Plant = workCenterClass.PlanningPlant
                (self.addTimeEntryVC!.timeSheetClass.entity.properties["WorkCenter"] as! SODataProperty).value = workCenterClass.WorkCenter as NSObject
                self.addTimeEntryVC!.timeSheetClass.WorkCenter = workCenterClass.WorkCenter
            }
        }
        TimeSheetModel.updateTimeSheetEntity(entity: self.addTimeEntryVC!.timeSheetClass.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("TimeSheet Updated successfully".localized(), Type: "")
                DispatchQueue.main.async {
                    self.addTimeEntryVC!.timeSheetDelegate?.timeSheetAdded(statusCategoryCls: self.addTimeEntryVC!.statusCategoryCls)
                    self.addTimeEntryVC!.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log("\(error?.localizedDescription ?? "")", Type: "Error")
                mJCAlertHelper.showAlert(self.addTimeEntryVC!, title: alerttitle, message: "Update_timeSheet_entity_fails".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
}

