//
//  DetailViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 13/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class DetailViewModel {

    weak var delegate: viewModelDelegate?

    var checkSheetVM = checkSheetViewModel()
    var noDetailVM = NotificationDetailModel()
    var woDetailVM = WorkorderDetailModel()

    var assignment = String()
    var statusArray = [WorkOrderStatusModel]()
    var allowedStatusCatagoryArray = [StatusCategoryModel]()
    var allowedStatusArray = [String]()
    var woObj = WoHeaderModel()
    var oprObj = WoOperationModel()
    var noObj = NotificationModel()

    var property = NSMutableArray()
    var Latitude : NSDecimalNumber = 0
    var Longitude : NSDecimalNumber = 0
    var woArray = [Any]()
    var woListArray = [Any]()
    var formAssignmentDataQuery = ""
    var remainsTaskTextArray = [String]()
    var inspectionlotDetail = InspectionLotModel()
    var validateCond: Bool = false
    
    func setRemainsTaskText(type:String){
        self.remainsTaskTextArray.removeAll()
        if type == "WorkOrder" {
            if let featurs =  woDetailVM.orderTypeFeatureDict.value(forKey: woObj.OrderType) as? NSArray{
                if let featureDict = featurs[0] as? NSMutableDictionary {
                    if featureDict.allKeys.count > 0 {
                        let featurelist = featureDict.allKeys as NSArray
                        if (featurelist.contains("OPERATION")) &&  (assignment == "1" ||  assignment == "3"){
                            if woDetailVM.operationArray.count > 0 {
                                let mandateStr = featureDict.value(forKey: "OPERATION") as! String
                                if mandateStr == "1" {
                                    if woDetailVM.confirmedOprList.count == 0 {
                                        let operationstext = "It_is_mandatory_to_complete_all_pending_operation_Current_number_of_Incomplete_operation_are".localized() + " : \(woDetailVM.inCompOprCount)"
                                        remainsTaskTextArray.append(operationstext)
                                    }
                                } else if mandateStr == "2" {
                                    if woDetailVM.confirmedOprList.count != woDetailVM.operationArray.count {
                                        let operationstext = "It_is_mandatory_to_complete_all_pending_operation_Current_number_of_Incomplete_operation_are".localized() + " : \(woDetailVM.inCompOprCount)"
                                        remainsTaskTextArray.append(operationstext)
                                    }
                                }
                            }
                        }
                        if featurelist.contains("COMPONENT")  && woDetailVM.componentIssued == false {
                            let componentText = "It_is_mandatory_to_issue_all_the_components_Currently_unissued_components_are".localized() +  " : \(woDetailVM.notIssuedComponentCount)"
                            remainsTaskTextArray.append(componentText)
                        }
                        if  featurelist.contains("ATTACHMENT"){
                            let mandateStr = featureDict.value(forKey: "ATTACHMENT") as! String
                            if mandateStr == "2" && woDetailVM.attachmentAdded == false {
                                let attachmentText = "It_is_mandatory_to_upload_at_least_one_attachment_as_part_of_Job_execution".localized()
                                remainsTaskTextArray.append(attachmentText)
                            }
                        }
                        if checkSheetVM.checkSheetFilledDone == false {
                            let formText = "It_is_mandatory_to_submit_all_required_mandatory_forms_for_this_Job".localized()
                            remainsTaskTextArray.append(formText)
                        }
                        if featurelist.contains("RECORD_POINT") && woDetailVM.recordPointDone == false{
                            let recordText = "It_is_mandatory_to_record_the_reading_for_this_Job".localized()
                            remainsTaskTextArray.append(recordText)
                        }
                        if assignment == "2" || assignment == "4" || assignment == "5"{
                            if inspCount != "" && featurelist.contains("INSPECTIONLOT") && InspColor != appColor {
                                if singleOperation.SystemStatus.contains(OPR_INSP_ENABLE_STATUS){
                                    if !oprObj.SystemStatus.contains(OPR_INSP_RESULT_RECORDED_STATUS){
                                        let recordText = "It_is_mandatory_to_Check_Inpection_Result_status".localized()
                                        remainsTaskTextArray.append(recordText)
                                    }
                                }
                            }
                        }else{
                            if woObj.InspectionLot != "" && woObj.InspectionLot != "000000000000" && featurelist.contains("INSPECTIONLOT") {
                                if self.inspectionlotDetail.UdCode == "" {
                                    let inspectionLotText = "User_decision_is_pending_for_inspection_Lot".localized() + " \(woObj.InspectionLot)"
                                    remainsTaskTextArray.append(inspectionLotText)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    //MARK:- Get Allowed Status..
    func getAllowedStatusForCurrentStatus(type:String,currentStatus:String) {
        self.allowedStatusArray.removeAll()
        var filteredArray = [WorkOrderStatusModel]()
        if type == "Notification"{
            filteredArray = self.statusArray.filter{$0.CurrentStatusCode == "\(currentStatus)" && $0.StatusCategory == "NOTIFICATIONLEVEL"}
        }else{
            var statusCategory = String()
            if self.assignment == "1" || self.assignment == "3"{
                statusCategory = "WORKORDERLEVEL"
            }else if self.assignment == "2" || self.assignment == "4" || self.assignment == "5"{
                statusCategory = "OPERATIONLEVEL"
            }
            filteredArray = self.statusArray.filter{$0.CurrentStatusCode == "\(currentStatus)" && $0.StatusCategory == "\(statusCategory)" && $0.ObjectType == "X"}
        }
        for obj in filteredArray {
            let statclass = obj
            self.allowedStatusArray.append(statclass.AllowedStatusCode)
        }
        if type == "Notification"{
            let arr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: "NOTIFICATIONLEVEL", ObjectType: "X")
            self.getStatusCatagoryList(statusArray:arr)
        }else{
            if self.assignment == "2" || self.assignment == "4" || self.assignment == "5"{
                let arr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: self.assignment, ObjectType: singleOperation.OrderType)
                self.getStatusCatagoryList(statusArray:arr)
            }else{
                let arr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: self.assignment, ObjectType: singleWorkOrder.OrderType)
                self.getStatusCatagoryList(statusArray:arr)
            }
        }
    }
    func getStatusCatagoryList(statusArray: [StatusCategoryModel]) {
        self.allowedStatusCatagoryArray.removeAll()
        for obj in statusArray {
            self.allowedStatusCatagoryArray.append(obj)
        }
        let sortedArray:[StatusCategoryModel] = (self.allowedStatusCatagoryArray.sorted(by: {$0.Sequence < $1.Sequence}))
        if DeviceType == iPhone{
            self.allowedStatusCatagoryArray.removeAll()
            let statusPredicate = NSPredicate(format: "StatusCode IN %@", self.allowedStatusArray)
            let finalStatuses = sortedArray.filter{statusPredicate.evaluate(with: $0)}
            self.allowedStatusCatagoryArray = finalStatuses
        }else{
            self.allowedStatusCatagoryArray.removeAll()
            self.allowedStatusCatagoryArray = sortedArray
        }
        self.delegate?.dataFetchCompleted?(type: "MobileStatusList", object: [])
    }
    //MARK: Status Update Methods
    func updateObjectStatus(index:Int,type:String,selectedWO:String? = "",selectedOpr: String? = "",selectedNo:String? = ""){
        if type == "WorkOrder"{
            let validStatusClass = self.allowedStatusCatagoryArray[index]
            if validStatusClass.CnfPopup == "X"{
                var message = String()
                if validStatusClass.StatusCode == "ACCP"{
                    message = "You_are_accepting_this_job._Do_you_want_to_continue?".localized()
                }else if validStatusClass.StatusCode == "ENRT"{
                    message = "You_are_leaving_for_job_location_Do_you_want_to_continue".localized()
                }
                else if validStatusClass.StatusCode == "ARRI"{
                    message = "Have_you_arrived_at_job_location".localized()
                }
                else if validStatusClass.StatusCode == "STRT"{
                    message = "You_are_starting_this_job_Do_you_want_to_continue".localized()
                }
                let params = Parameters(
                    title: alerttitle,
                    message: message,
                    cancelButton: "YES".localized(),
                    otherButtons: ["NO".localized()]
                )
                mJCAlertHelper.showAlertWithHandler(parameters: params){ buttonIndex in
                    switch buttonIndex {
                    case 0:
                        if validStatusClass.CaptureTime == "X" || validStatusClass.PostTime == "X"{
                            self.getStausChangeLogSet(validStatus: validStatusClass, isfrom: "", type: type, selectedWO: selectedWO, selectedOpr: selectedOpr, selectedNo: selectedNo)
                        }else {
                            self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [validStatusClass])
                        }
                    case 1: break
                    default: break
                    }
                }
            }else{
                if validStatusClass.CaptureTime == "X" || validStatusClass.PostTime == "X"{
                    self.getStausChangeLogSet(validStatus: validStatusClass, isfrom: "", type: type, selectedWO: selectedWO, selectedOpr: selectedOpr, selectedNo: selectedNo)
                }else {
                    self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [validStatusClass])
                }
            }
        }else{
            let validStatusClass = self.allowedStatusCatagoryArray[index]
            if validStatusClass.CnfPopup == "X"{
                var message = String()
                if validStatusClass.StatusCode == "ACCP"{
                    message = "You_are_accepting_this_job._Do_you_want_to_continue?".localized()
                }else if validStatusClass.StatusCode == "INPR"{
                    message = "This_job_is_getting_Inprogress_Do_you_want_to_continue".localized()
                }
                else if validStatusClass.StatusCode == "COMP"{
                    message = "You_are_Completing_this_job_Do_you_want_to_continue".localized()
                }
                else if validStatusClass.StatusCode == "REJC"{
                    message = "You_are_Rejecting_this_job_Do_you_want_to_continue".localized()
                }
                let params = Parameters(
                    title: alerttitle,
                    message: message,
                    cancelButton: "YES".localized(),
                    otherButtons: ["NO".localized()]
                )
                mJCAlertHelper.showAlertWithHandler(parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        DispatchQueue.main.async {
                            if validStatusClass.CaptureTime == "X"{
                                self.getStausChangeLogSet(validStatus: validStatusClass, isfrom: "", type: type, selectedWO: selectedWO, selectedOpr: selectedOpr, selectedNo: selectedNo)
                            }else {
                                self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [validStatusClass])
                            }
                        }
                    case 1: break
                    default: break
                    }
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [validStatusClass])
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getStausChangeLogSet(validStatus:StatusCategoryModel,isfrom:String,type:String,selectedWO:String? = "",selectedOpr:String? = "",selectedNo:String? = "") {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        var status = String()
        if isfrom == "Update"{
            status = validStatus.Ref_Cal_Status
        }else{
            status = validStatus.StatusCode
        }
        if type == "WorkOrder"{
            if self.assignment == "2" || self.assignment == "4" || self.assignment == "5"{
                defineQuery = "$filter=(StatusCode eq '\(status)' and Operation eq '\(selectedOpr!)'  and ObjectNum eq '\(selectedWO!)' and IsConsidered eq false)"
            }else{
                defineQuery = "$filter=(StatusCode eq '\(status)' and Operation eq ''  and ObjectNum eq '\(selectedWO!)' and IsConsidered eq false)"
            }
        }else if type == "Notification"{
            defineQuery = "$filter=(StatusCode eq '\(status)' and ObjectNum eq '\(selectedNo!)' and IsConsidered eq false)"
        }
        StatusChangeLogModel.getStatusChangeLogList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                var timeDifference = DateComponents()
                if let responseArr = response["data"] as? [StatusChangeLogModel]{
                    if isfrom == "Update"{
                        if responseArr.count > 0{
                            mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                            let timeDict = responseArr[0]
                            if timeDict.StatusChangedTime != nil{
                                let startDate = timeDict.StatusChangedTime!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                                let startTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: timeDict.StatusTime)
                                let startDateTime = Date(fromString: "\(startDate) \(startTime)", format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let currentDateTime = Date().localDate()
                                let currentTime = Date().localDate().toString(format: .custom("HH:mm"), timeZone: .utc, locale: .current)
                                let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
                                timeDifference = Calendar.current.dateComponents(requestedComponent, from: startDateTime, to: currentDateTime)
                                if  validStatus.PostTime == "X" {
                                    if validStatus.StatusCode == "COMP" || validStatus.StatusCode == "HOLD" || validStatus.StatusCode == "SUSP"{
                                        if type == "WorkOrder"{
                                            self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [validStatus])
                                        }else if type == "Notification"{
                                            self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [validStatus])
                                        }
                                    }else{
                                        if type == "WorkOrder"{
                                            self.delegate?.dataFetchCompleted?(type: "CreteTimeSheet", object: [validStatus,timeDifference,startTime,currentTime])
                                        }
                                    }
                                }else{
                                    if type == "WorkOrder"{
                                        self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [validStatus])
                                    }else if type == "Notification"{
                                        self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [validStatus])
                                    }
                                }
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            if  validStatus.PostTime == "X" {
                                if validStatus.StatusCode == "COMP" || validStatus.StatusCode == "HOLD" || validStatus.StatusCode == "SUSP"{
                                    if type == "WorkOrder"{
                                        self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [validStatus])
                                    }else if type == "Notification"{
                                        self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [validStatus])
                                    }
                                }else{
                                    if type == "WorkOrder"{
                                        self.delegate?.dataFetchCompleted?(type: "CreteTimeSheet", object: [validStatus,timeDifference,"",""])
                                    }
                                }
                            }else{
                                if type == "WorkOrder"{
                                    self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [validStatus])
                                }else if type == "Notification"{
                                    self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [validStatus])
                                }
                            }
                        }
                    }else{
                        if responseArr.count == 0{
                            self.postStatusChangeLogSet(statusClass: validStatus, type: type,selectedWO: selectedWO,selectedOpr: selectedOpr,selectedNo: selectedNo)
                        }else {
                            if responseArr.count > 0{
                                self.UpdateStatusChangeLogSet(logSetClass: responseArr[0], statusClass: validStatus, type: type)
                            }
                        }
                    }
                }
            }else{
            }
        }
    }
    func postStatusChangeLogSet(statusClass:StatusCategoryModel,type:String,selectedWO:String? = "",selectedOpr:String? = "",selectedNo:String? = "") {

        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "ObjectNum")
        if type == "WorkOrder"{

            prop = SODataPropertyDefault(name: "ObjectNum")
            prop!.value = selectedWO! as NSObject
            self.property.add(prop!)

            if self.assignment == "2" || self.assignment == "4" || self.assignment == "5"{
                prop = SODataPropertyDefault(name: "Operation")
                prop!.value = selectedOpr! as NSObject
                self.property.add(prop!)
            }else{
                prop = SODataPropertyDefault(name: "Operation")
                prop!.value = "" as NSObject
                self.property.add(prop!)
            }
        }else if type == "Notification"{
            prop = SODataPropertyDefault(name: "ObjectNum")
            prop!.value = selectedNo! as NSObject
            self.property.add(prop!)
        }

        prop = SODataPropertyDefault(name: "StatusCode")
        prop!.value = statusClass.StatusCode as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "StatusCategory")
        var statusCategory = String()
        if self.assignment == "1" || self.assignment == "3"{
            statusCategory = "WORKORDERLEVEL"
        }else if self.assignment == "2" || self.assignment == "4" || self.assignment == "5"{
            statusCategory = "OPERATIONLEVEL"
        }
        prop!.value =  statusCategory as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = String.random(length: 16, type: "Number") as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "StatusChangedTime")
        let date = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
        prop!.value = date as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "StatusTime")
        let dateArray = "\(Date().localDate())".components(separatedBy: " ")
        if dateArray.count > 1{
            let timestr = dateArray[1]
            let timeArr = timestr.components(separatedBy: ":")
            if timeArr.count > 1{
                let statusTime = SODataDuration()
                statusTime.hours = Int(timeArr[0])! as NSNumber
                statusTime.minutes = Int(timeArr[1])! as NSNumber
                statusTime.seconds = Int(timeArr[2])! as NSNumber
                prop!.value = statusTime
                property.add(prop!)
            }
        }
        prop = SODataPropertyDefault(name: "PostedBy")
        prop!.value = strUser.uppercased() as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "Longitude")
        prop!.value = self.Longitude as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "Latitude")
        prop!.value = self.Latitude as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "IsConsidered")
        prop!.value = false as NSObject
        self.property.add(prop!)

        let entity = SODataEntityDefault(type: "ODS_SAP_WM_DLITE_SRV.StatusChangeLog")

        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("..............")
        }
        StatusChangeLogModel.createStatusChangeLogEntry(entity: entity!, collectionPath: "StatusChangeLogSet", flushRequired: false,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                if statusClass.PostTime == "X" {
                    self.getStausChangeLogSet(validStatus:statusClass, isfrom: "Update",type:type,selectedWO: selectedWO,selectedOpr:selectedOpr,selectedNo: selectedNo)
                }else {
                    if type == "WorkOrder"{
                        self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [statusClass])
                    }else if type == "Notification"{
                        self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [statusClass])
                    }
                }
            }else{
                if type == "WorkOrder"{
                    self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [statusClass])
                }else if type == "Notification"{
                    self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [statusClass])
                }
            }
        })
    }
    func UpdateStatusChangeLogSet(logSetClass:StatusChangeLogModel,statusClass:StatusCategoryModel,type:String,selectedWO:String? = "",selectedOpr:String? = "",selectedNo:String? = ""){

        (logSetClass.entity.properties["IsConsidered"] as! SODataProperty).value = true as NSObject
        StatusChangeLogModel.updateStatusChangeLogEntry(entity: logSetClass.entity, flushRequired: false,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                if statusClass.CaptureTime == "X" {
                    self.postStatusChangeLogSet(statusClass: statusClass, type: type,selectedWO: selectedWO,selectedOpr: selectedOpr,selectedNo: selectedNo)
                }else {
                    if type == "WorkOrder"{
                        self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [statusClass])
                    }else if type == "Notification"{
                        self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [statusClass])
                    }
                }
            }else {
                if type == "WorkOrder"{
                    self.delegate?.dataFetchCompleted?(type: "WorkOrderStatusUpdate", object: [statusClass])
                }else if type == "Notification"{
                    self.delegate?.dataFetchCompleted?(type: "NotificationStatusUpdate", object: [statusClass])
                }
            }
        })
    }
    //MARK: Others
    func getInspectionLotDetails(inspectionlot: String){
        InspectionLotModel.getInspLotDetails(inspLotNum: inspectionlot){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [InspectionLotModel]{
                    if responseArr.count > 0 {
                        self.inspectionlotDetail = responseArr[0]
                    }
                }
            }
        }
    }
    func getAllowedFollowOnObjectType() {
        AllowedFollowOnObjectTypeModel.getAllowedFollowOnObjectTypeList(objectType: singleWorkOrder.OrderType, roleId: Role_ID){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [AllowedFollowOnObjectTypeModel]{
                    self.delegate?.dataFetchCompleted?(type: "AllowedFollowOnObjectType", object: [responseArr])
                }else{
                    self.delegate?.dataFetchCompleted?(type: "AllowedFollowOnObjectType", object: [])
                }
            }
        }
    }
    func getLatAndLog(locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        self.Latitude = NSDecimalNumber(value: lastLocation.coordinate.latitude)
        self.Longitude = NSDecimalNumber(value: lastLocation.coordinate.longitude)
        userLocation_LatLong = "Location Lat:\(self.Latitude);Long:\(self.Longitude);"
    }
}


