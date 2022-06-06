//
//  ConformationViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 05/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class ConformationViewModel{
    
    var confirmationVC : CreateFinalConfirmationVC?
    var suspendViewModel = SuspendViewModel()
    var totalHours = Int()
    var totalMins = Int()
    var startDateTime = Date()
    var endDateTime = Date()
    
    func setViewLayouts(){
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.workOrderNumTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.operationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.activityTypeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.actualDurHrsTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.actualDurMinsTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.actualDurFormateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.confirmationTextTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.execStartDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.execStartTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.execEndDateTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.execEndTimeTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.confirmationVC!.unitOfWorkTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        for index in 0..<60 {
            if index < 10 {
                let minut = "0\(index)"
                confirmationVC!.minutsArray.add(minut)
            }else {
                let minut = "\(index)"
                confirmationVC!.minutsArray.add(minut)
            }
            if index < 24 {
                let hour = "\(index)"
                confirmationVC!.hoursArray.add(hour)
            }
        }
    }
    //MARK:- Set Create & Edit Data..
    func getStausChangeLogSet(validStatus:StatusCategoryModel) {
        
        mJCLogger.log("Starting", Type: "info")
        
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
                        self.confirmationVC?.conformationStatusArray = responseArr
                        let timeDict = responseArr[0]
                        if timeDict.StatusChangedTime != nil{
                            let startDate = timeDict.StatusChangedTime!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            let startTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeDict.StatusTime)
                            let startDateTime = Date(fromString: "\(startDate) \(startTime)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let currrentDateTime = Date().localDate()
                            let elapsedTime = currrentDateTime.timeIntervalSince(startDateTime)
                            let hours = floor(elapsedTime / 60 / 60)
                            let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
                            self.totalHours = Int(hours)
                            self.totalMins = Int(minutes)
                            self.startDateTime = startDateTime
                            self.endDateTime = currrentDateTime
                            DispatchQueue.main.async{
                                var workTime = String()
                                if self.confirmationVC!.unitOfWorkLabel.text ?? "MIN" == "H"{
                                    workTime = "\(abs(Float(self.totalHours) + Float(self.totalMins) / 60))"
                                }else{
                                    workTime = "\(abs(self.totalHours * 60 + self.totalMins))"
                                }
                                self.confirmationVC!.unitOfWorkTextField.text = "\(workTime)"
                                self.confirmationVC!.actualDurHrsTextField.text = "\(self.totalHours)"
                                self.confirmationVC!.actualDurMinsTextField.text = "\(self.totalMins)"
                                self.confirmationVC?.execStartDateTextField.text = "\(startDate)"
                                self.confirmationVC?.execStartTimeTextField.text = "\(startTime)"
                                let currentDate = Date().localDate().toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                                let currentTime = Date().toString(format: .custom("HH:mm"), timeZone: .local, locale: .current)
                                self.confirmationVC?.execEndDateTextField.text = "\(currentDate)"
                                self.confirmationVC?.execEndTimeTextField.text = "\(currentTime)"
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        self.totalHours = 0
                        self.totalMins = 0
                        DispatchQueue.main.async{
                            self.confirmationVC!.actualDurHrsTextField.text = "0"
                            self.confirmationVC!.actualDurMinsTextField.text = "00"
                        }
                    }
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Activity List..
    func getActivityList() {
        
        mJCLogger.log("Starting", Type: "info")
        WorkOrderActivityModel.getWorkOrderActivityList(){ (responseDict, error)  in
            if error == nil{
                self.confirmationVC?.activityArray.removeAll()
                if let responseArr = responseDict["data"] as? [WorkOrderActivityModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.confirmationVC?.activityArray = responseArr
                    self.setActivity()
                }
            }else{
                self.confirmationVC?.activityTypeTextField.text = singleOperation.ActivityType
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Activity Data..
    func setActivity()  {
        
        mJCLogger.log("Starting", Type: "info")
        self.confirmationVC?.activityListArray.removeAll()
        DispatchQueue.main.async {
            if self.confirmationVC!.activityArray.count > 0 {
                for activity in self.confirmationVC!.activityArray {
                    self.confirmationVC?.activityListArray.append(activity.ActivityType + " - " + activity.ShortText)
                }
            }else {
                mJCLogger.log("Data not found", Type: "Debug")
                self.confirmationVC?.activityListArray.removeAll()
            }
            if self.confirmationVC?.screenType == "errorEdit"{
                if self.confirmationVC?.errorConfirEntity.ActType != ""{
                    let arr = self.confirmationVC!.activityArray.filter{$0.ActivityType == "\(self.confirmationVC!.errorConfirEntity.ActType)"}
                    if arr.count > 0{
                        let activityCls = arr[0]
                        self.confirmationVC?.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                    }
                }
            }else{
                let arr = self.confirmationVC!.activityArray.filter{$0.ActivityType == "\(self.confirmationVC!.statusCategoryCls.ActivityType)"}
                if arr.count > 0{
                    let activityCls = arr[0]
                    self.confirmationVC?.activityTypeTextField.text = activityCls.ActivityType + " - " + activityCls.ShortText
                }
                if self.confirmationVC?.activityTypeTextField.text == ""{
                    self.confirmationVC?.activityTypeTextField.text = singleOperation.ActivityType
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func validateScreenValues() {
        
        if self.confirmationVC!.workOrderNumTextField.text == "" {
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_select_or_enter_workorder".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if self.confirmationVC!.operationTextField.text == ""{
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_operation".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
//        if self.confirmationVC!.confirmationTextTextField.text == ""{
//            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Confirmation_text".localized(), button: okay)
//            mJCLogger.log("Ended", Type: "info")
//            return
//        }
        if self.confirmationVC!.actualDurFormateTextField.text == selectStr {
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_activity_type".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if self.confirmationVC!.execStartDateTextField.text == "" && self.confirmationVC!.execStartTimeTextField.text == ""{
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Execution_Start_Details".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if self.confirmationVC!.execStartDateTextField.text == ""{
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Execution_Start_Date".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if  self.confirmationVC!.execStartTimeTextField.text == ""{
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Execution_Start_Time".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if self.confirmationVC!.execEndDateTextField.text == "" && self.confirmationVC!.execEndTimeTextField.text == ""{
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Execution_End_Details".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if self.confirmationVC!.execEndDateTextField.text == ""{
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Execution_End_Date".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if self.confirmationVC!.execEndTimeTextField.text == ""{
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Execution_End_Time".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if (self.confirmationVC!.actualDurHrsTextField.text == "0" || self.confirmationVC!.actualDurHrsTextField.text == "") && (self.confirmationVC!.actualDurMinsTextField.text == "" || self.confirmationVC!.actualDurMinsTextField.text == "0" || self.confirmationVC!.actualDurMinsTextField.text == "00"){
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Actual_Duration_Value".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if (self.confirmationVC!.unitOfWorkTextField.text == "" || self.confirmationVC!.unitOfWorkTextField.text == "0"){
            mJCLogger.log("Please_enter_Duration_formate".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self.confirmationVC!, title: alerttitle, message: "Please_enter_Actual_work_Value".localized(), button: okay)
            mJCLogger.log("Ended", Type: "info")
            return
        }
        if confirmationVC?.screenType == "errorEdit"{
            self.updateConfirmation()
        }else{
            self.postConformation()
        }
    }
    func updateConfirmation(){

        let confEntity = self.confirmationVC?.errorConfirEntity.entity

        (confEntity?.properties["ConfText"] as! SODataProperty).value = "\(self.confirmationVC!.confirmationTextTextField.text ?? "Confirmation")" as NSObject

        if self.confirmationVC!.activityTypeTextField.text != "" && self.confirmationVC!.activityTypeTextField.text != nil {
            let arr = self.confirmationVC!.activityTypeTextField.text!.components(separatedBy: " - ")
            if arr.count > 0{
                (confEntity?.properties["ActType"] as! SODataProperty).value = "\(arr[0])" as NSObject
            }
        }
        var finalstartDate = Date()
        var finalendDate = Date()

        if  WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4"  || WORKORDER_ASSIGNMENT_TYPE == "5"{
            finalstartDate = Date(fromString: "\(self.confirmationVC!.execStartDateTextField.text!) \(self.confirmationVC!.execStartTimeTextField.text!)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
            finalendDate = Date(fromString: "\(self.confirmationVC!.execEndDateTextField.text!) \(self.confirmationVC!.execEndTimeTextField.text!)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
        }

        (confEntity?.properties["ExecStartDate"] as! SODataProperty).value =  finalstartDate as NSObject

        var basicTimeArray = "\(self.confirmationVC!.execStartTimeTextField.text ?? "00:00")".components(separatedBy: ":")
        if basicTimeArray.count > 1{
            let basicTime1 = SODataDuration()
            basicTime1.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime1.minutes = Int(basicTimeArray[1]) as NSNumber?
            (confEntity?.properties["ExecStartTime"] as! SODataProperty).value =  basicTime1 as NSObject
        }
        (confEntity?.properties["ExecFinDate"] as! SODataProperty).value =  finalendDate as NSObject

        basicTimeArray = "\(self.confirmationVC!.execEndTimeTextField.text ?? "00:00")".components(separatedBy: ":")
        if basicTimeArray.count > 1{
            let basicTime2 = SODataDuration()
            basicTime2.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime2.minutes = Int(basicTimeArray[1]) as NSNumber?
            (confEntity?.properties["ExecFinTime"] as! SODataProperty).value =  basicTime2 as NSObject
        }

        var ActualDur = String()
        let hours = Int(self.confirmationVC!.actualDurHrsTextField.text ?? "0") ?? 0
        let min = Int(self.confirmationVC!.actualDurMinsTextField.text ?? "0") ?? 0

        if self.confirmationVC!.actualDurFormateTextField.text == "MIN"{
            ActualDur = "\(abs(hours * 60 + min))"
        }else{
            ActualDur = "\(abs(Float(hours) * 60 + Float(min) / 60))"
        }
        (confEntity?.properties["ActualDur"] as! SODataProperty).value =  NSDecimalNumber(string: ActualDur) as NSObject
        let actulWorkStr = self.confirmationVC!.unitOfWorkTextField.text ?? "0"
        (confEntity?.properties["ActWork"] as! SODataProperty).value =  NSDecimalNumber(string: "\(actulWorkStr)") as NSObject
        WoConfirmationModel.updateWoConfirmationEntity(entity: confEntity!, options: nil){ (response, error) in
            if(error == nil) {
                mJCLogger.log("confimation Updated successfully".localized(), Type: "Debug")
                DispatchQueue.main.async {
                    self.confirmationVC!.dismiss(animated: false) {}
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func postConformation(){
        
        mJCLogger.log("postoperationconformation start".localized(), Type: "")
        var activitytype = ""
        if self.confirmationVC!.activityTypeTextField.text != "" && self.confirmationVC!.activityTypeTextField.text != nil {
            let arr = self.confirmationVC!.activityTypeTextField.text!.components(separatedBy: " - ")
            if arr.count > 0{
                activitytype = arr[0]
            }
        }else{
            activitytype = self.confirmationVC!.statusCategoryCls.ActivityType
        }
        if activitytype == ""{
            activitytype = singleOperation.ActivityType
        }
        var FinalConfFlag = ""
        if self.confirmationVC!.finalConfirmationCheckBox.isSelected == true{
            FinalConfFlag = "X"
        }
        var finalstartDate = Date()
        var finalendDate = Date()
        let singleOperationClass = singleOperation
        
        let property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfCounter")
        let count = "0000\(String.random(length: 4, type: "Number"))"
        
        prop!.value = count as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = "\(self.confirmationVC!.workOrderNumTextField.text!)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = "\(self.confirmationVC!.operationTextField.text!)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOper")
        prop!.value = singleOperation.SubOperation as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Split")
        prop!.value = 0 as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PostgDate")
        prop!.value = Date().localDate() as NSObject
        mJCLogger.log("Conformation PostgDate \(Date().localDate())", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FcstFinDate")
        prop!.value = Date().localDate() as NSObject
        mJCLogger.log("Conformation FcstFinDate \(Date().localDate())", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedDate")
        prop!.value = Date().localDate() as NSObject
        mJCLogger.log("Conformation ExCreatedDate \(Date().localDate())", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        mJCLogger.log("Conformation ExCreatedTime \(time)", Type: "")
        mJCLogger.log("Conformation FcstFinTime \(time)", Type: "")
        property.add(prop!)
        var basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FcstFinTime")
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            prop!.value = singleWorkOrder.Plant as NSObject
        }else{
            prop!.value = singleOperationClass.Plant as NSObject
        }

        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkCntr")
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            prop!.value = singleWorkOrder.MainWorkCtr as NSObject
        }else{
            prop!.value = singleOperationClass.WorkCenter as NSObject
        }
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        if  WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4"  || WORKORDER_ASSIGNMENT_TYPE == "5"{
            
            var ActualDur = String()
            
            if self.confirmationVC!.actualDurFormateTextField.text == "MIN"{
                ActualDur = "\(abs(self.totalHours * 60 + self.totalMins))"
            }else{
                ActualDur = "\(abs(Float(self.totalHours) * 60 + Float(self.totalMins) / 60))"
            }
            finalstartDate = Date(fromString: "\(self.confirmationVC!.execStartDateTextField.text!) \(self.confirmationVC!.execStartTimeTextField.text!)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
            finalendDate = Date(fromString: "\(self.confirmationVC!.execEndDateTextField.text!) \(self.confirmationVC!.execEndTimeTextField.text!)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
            
            prop = SODataPropertyDefault(name: "ActType")
            prop!.value = activitytype as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "UnActDur")
            prop!.value = "\(self.confirmationVC!.actualDurFormateTextField.text ?? "MIN")" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ActualDur")
            prop!.value = NSDecimalNumber(string: ActualDur)
            mJCLogger.log("Conformation ActualDur \(ActualDur)", Type: "")
            property.add(prop!)
            

            let actulWorkStr = self.confirmationVC!.unitOfWorkTextField.text ?? "0"
            prop = SODataPropertyDefault(name: "ActWork")
            prop!.value = NSDecimalNumber(string: "\(actulWorkStr)") as NSObject
            property.add(prop!)

            var unwork = String()
            if singleOperationClass.UnitWork == ""{
                unwork = "MIN"
            }else{
                unwork = singleOperationClass.UnitWork
            }

            prop = SODataPropertyDefault(name: "UnWork")
            prop!.value = "\(unwork)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "FinConf")
            prop!.value = FinalConfFlag as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Complete")
            prop!.value = FinalConfFlag as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ConfText")
            prop!.value = "\(self.confirmationVC!.confirmationTextTextField.text ?? "Confirmation")" as NSObject
            property.add(prop!)
        }else{
            
            prop = SODataPropertyDefault(name: "ConfText")
            prop!.value = OPERATION_COMPLETE_TEXT as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "FinConf")
            prop!.value = FinalConfFlag as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Complete")
            prop!.value = FinalConfFlag as NSObject
            property.add(prop!)
            
        }
        
        prop = SODataPropertyDefault(name: "ExecStartDate")
        prop!.value = finalstartDate as NSDate
        property.add(prop!)
        
        if self.confirmationVC?.clearReservationCheckBox.isSelected == true{
            prop = SODataPropertyDefault(name: "ClearRes")
            prop!.value = "X" as NSObject
            property.add(prop!)
        }
        
        basicTimeArray = "\(self.confirmationVC!.execStartTimeTextField.text ?? "00:00")".components(separatedBy: ":")
        if basicTimeArray.count > 1{
            let basicTime1 = SODataDuration()
            
            basicTime1.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime1.minutes = Int(basicTimeArray[1]) as NSNumber?
            
            prop = SODataPropertyDefault(name: "ExecStartTime")
            prop!.value = basicTime1
            property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "ExecFinDate")
        prop!.value = finalendDate as NSDate
        property.add(prop!)
        
        basicTimeArray = "\(self.confirmationVC!.execEndTimeTextField.text ?? "00:00")".components(separatedBy: ":")
        if basicTimeArray.count > 1{
            let basicTime2 = SODataDuration()
            basicTimeArray = time.components(separatedBy:":")
            basicTime2.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime2.minutes = Int(basicTimeArray[1]) as NSNumber?
            
            prop = SODataPropertyDefault(name: "ExecFinTime")
            prop!.value = basicTime2
            property.add(prop!)
        }
        let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
        for prop in property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name ?? ""] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        if self.confirmationVC!.screenType == "StatusChange"{
            
            var entityDict = Dictionary<String,Any>()
            entityDict["collectionPath"] = woConfirmationSet
            entityDict["entity"] = entity
            entityDict["type"] = "Create"
            self.confirmationVC!.suspendViewModel.entityDict["Confirmation"] = entityDict
            self.confirmationVC!.suspendViewModel.validateCompletionFeatures()
            
        }
    }
}
