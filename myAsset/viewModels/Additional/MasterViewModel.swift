//
//  MasterViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 13/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation
import AVFoundation

class MasterViewModel{

    var woNoArray = [Any]()
    var woNoListArray = [Any]()
    var techIdEquipmentList = [String]()
    var skipvalue = masterDataLoadingItems
    weak var delegate: viewModelDelegate?

    func getWorkorderDetails(woNumber:String , showPopUp : Bool){
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getWorkorderDetailsWith(workOrderNo: (woNumber as String)) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        let WoDetail = responseArr[0]
                        singleWorkOrder = WoDetail
                        if showPopUp == true {
                            myAssetDataManager.presentWorkOrderInfoView(woObject: singleWorkOrder)
                        }else{
                            self.getCurrentReading(objectType: singleOperation)
                        }
                    }else{
                        if showPopUp == true {
                            if onlineSearch == true{
                                let workArr = (self.woNoArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(singleOperation.WorkOrderNum)"}
                                if workArr.count > 0{
                                    let WoDetail = workArr[0]
                                    singleWorkOrder = WoDetail
                                }
                                myAssetDataManager.presentWorkOrderInfoView(woObject: singleWorkOrder)
                            }else{
                                mJCLogger.log("UNABLE_FETCH_WO".localized(), Type: "Warn")
                                mJCAlertHelper.showAlert(title: MessageTitle, message: "UNABLE_FETCH_WO".localized(), button: okay)
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleNotificationList() {
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=Notification eq '\(singleWorkOrder.NotificationNum)'"
        mJCLogger.log("Notification list for markers :- \(defineQuery)", Type: "")
        NotificationModel.getWoNotificationDetailsWith(filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [NotificationModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        singleNotification = responseArr[0]
                    }else{
                        singleNotification = NotificationModel()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    singleNotification = NotificationModel()
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Recordpoints Data..
    func getCurrentReading(objectType : AnyObject) {
        currentRecordPointArray.removeAll()
        mJCLogger.log("Starting", Type: "info")
        MeasurementPointModel.getFilledMeasurementPointDetails(WoObjectNum: singleWorkOrder.ObjectNumber) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [MeasurementPointModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        currentRecordPointArray.removeAll()
                        currentRecordPointArray = responseArr
                        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && onlineSearch == false{
                            self.getRecordpointdata(ObjectType: objectType)
                        }else{
                            self.getRecordpointdata(ObjectType: objectType)
                        }
                    }else{
                        self.getRecordpointdata(ObjectType: objectType)
                    }
                }else{
                    self.getRecordpointdata(ObjectType: objectType)
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                self.getRecordpointdata(ObjectType: objectType)
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getRecordpointdata(ObjectType : AnyObject){
        mJCLogger.log("Starting", Type: "info")
        let pointarray = NSMutableArray()
        if let workorderDetail = ObjectType as? WoHeaderModel {
            let allMeasurmentpointsmodel = EquipFuncLocMeasurementModel()
            allMeasurmentpointsmodel.Equipment = workorderDetail.EquipNum
            allMeasurmentpointsmodel.FunctionalLocation = workorderDetail.FuncLocation
            allMeasurmentpointsmodel.WoObjectNum =  workorderDetail.ObjectNumber
            allMeasurmentpointsmodel.WorkOrderNum = workorderDetail.WorkOrderNum
            allMeasurmentpointsmodel.OperationNum = ""
            pointarray.add(allMeasurmentpointsmodel)
            if ENABLE_OPERATION_MEASUREMENTPOINT_READINGS == true {
                EquipFuncLocMeasurementModel.getOperationEquipFuncLocDetails(workOrderNum: workorderDetail.WorkOrderNum) {(response, error)  in
                    if error == nil{
                        let dict1 =  NSMutableDictionary()
                        if let responseArr = response["data"] as? [EquipFuncLocMeasurementModel]{
                            if responseArr.count > 0{
                                let allPointArray = responseArr.sorted{$0.OperationNum.compare($1.OperationNum) == .orderedAscending } as NSArray
                                let predicate : NSPredicate = NSPredicate(format: "SELF.Equipment != '' OR SELF.FunctionalLocation != ''")
                                let filteredArray = allPointArray.filtered(using: predicate)
                                pointarray.addObjects(from: filteredArray)
                                let pointarray1 = NSMutableArray()
                                pointarray1.addObjects(from: filteredArray)
                                dict1.setValue(pointarray1, forKey: "Operations")
                            }
                            dict1.setValue(pointarray, forKey: "Workorder")
                            self.getPointDetails(detailarray: dict1)
                        }
                    }
                }
            }else{
                let dict =  NSMutableDictionary()
                dict.setValue(pointarray, forKey: "Workorder")
                self.getPointDetails(detailarray: dict)
            }
        }else if let operation = ObjectType as? WoOperationModel{
            let dict =  NSMutableDictionary()
            if ENABLE_OPERATION_MEASUREMENTPOINT_READINGS == true{
                let allMeasurmentpointsmodel = EquipFuncLocMeasurementModel()
                allMeasurmentpointsmodel.Equipment = singleWorkOrder.EquipNum
                allMeasurmentpointsmodel.FunctionalLocation = singleWorkOrder.FuncLocation
                allMeasurmentpointsmodel.WoObjectNum =  singleWorkOrder.ObjectNumber
                allMeasurmentpointsmodel.WorkOrderNum = singleWorkOrder.WorkOrderNum
                allMeasurmentpointsmodel.OperationNum = ""
                let pointarray1 = NSMutableArray()
                pointarray1.add(allMeasurmentpointsmodel)
                dict.setValue(pointarray1, forKey: "Workorder")
            }
            let allMeasurmentpointsmodel = EquipFuncLocMeasurementModel()
            allMeasurmentpointsmodel.Equipment = operation.Equipment
            allMeasurmentpointsmodel.FunctionalLocation = operation.FuncLoc
            allMeasurmentpointsmodel.OperationNum = operation.OperationNum
            allMeasurmentpointsmodel.OpObjectNum = operation.OpObjectNum
            pointarray.add(allMeasurmentpointsmodel)
            dict.setValue(pointarray, forKey: "Operations")
            self.getPointDetails(detailarray: dict)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPointDetails(detailarray:NSMutableDictionary){
        mJCLogger.log("Starting", Type: "info")
        finalReadingpointsArray.removeAll()
        let filterStr = myAssetDataManager.uniqueInstance.getRecordPointDefineRequestString(detailarray: detailarray)
        var defineQuery = String()
        if filterStr.contains(find: "Equipment") || filterStr.contains(find: "FunctionalLocation"){
            defineQuery =  "$filter=\(filterStr)&$orderby=FunctionalLocation,Equipment,MeasuringPoint"
        }else{
            finalReadingpointsArray.removeAll()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "RecordPointsUpdated"), object: nil)
            return
        }
        mJCLogger.log("work order list for markers :- \(defineQuery)", Type: "")
        MeasurementPointModel.getMeasurementPointDetails(filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                finalReadingpointsArray.removeAll()
                if let responseArr = response["data"] as? [MeasurementPointModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        if let workorderdata = detailarray.value(forKey: "Workorder") as? [EquipFuncLocMeasurementModel]{
                            if workorderdata.count > 0 {
                                let workorder = workorderdata[0]
                                if workorder.Equipment != ""{
                                    let filterArray = responseArr.filter{$0.Equipment == "\(workorder.Equipment)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        for j in 0..<filterArray.count{
                                            if finalReadingpointsArray.count > 0{
                                                if !finalReadingpointsArray.contains(filterArray[j]){
                                                    finalReadingpointsArray.append(contentsOf: filterArray)
                                                }
                                            }
                                        }
                                    }
                                }
                                if workorder.FunctionalLocation != ""{
                                    let filterArray = responseArr.filter{$0.FunctionalLocation
                                        == "\(workorder.FunctionalLocation)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        for j in 0..<filterArray.count{
                                            if !finalReadingpointsArray.contains(filterArray[j]){
                                                finalReadingpointsArray.append(contentsOf: filterArray)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if let operationdata = detailarray.value(forKey: "Operations") as? [EquipFuncLocMeasurementModel]{
                            for i in 0..<operationdata.count{
                                let operation = operationdata[i]
                                if operation.Equipment != ""{
                                    let filterArray = responseArr.filter{$0.Equipment == "\(operation.Equipment)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        for j in 0..<filterArray.count{
                                            let opr = filterArray[j]
                                            opr.OperationNum = operation.OperationNum
                                            finalReadingpointsArray.append(opr)
                                        }
                                    }
                                }
                                if operation.FunctionalLocation != ""{
                                    let filterArray = responseArr.filter{$0.FunctionalLocation == "\(operation.FunctionalLocation)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        for j in 0..<filterArray.count{
                                            let opr = filterArray[j]
                                            opr.OperationNum = operation.OperationNum
                                            finalReadingpointsArray.append(opr)
                                        }
                                    }
                                }
                            }
                        }
                        let array  = finalReadingpointsArray.uniqued()
                        finalReadingpointsArray.removeAll()
                        finalReadingpointsArray.append(contentsOf: array )
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"OperationNum", ascending : true)
                        let descriptor1:NSSortDescriptor = NSSortDescriptor (key:"MeasuringPoint", ascending : true)
                        let sortedArray:NSArray = ((finalReadingpointsArray as NSArray).sortedArray(using : [descriptor,descriptor1]) as NSArray)
                        finalReadingpointsArray.removeAll()
                        finalReadingpointsArray.append(contentsOf: sortedArray as! [MeasurementPointModel])
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "RecordPointsUpdated"), object: nil)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        finalReadingpointsArray.removeAll()
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "RecordPointsUpdated"), object: nil)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    finalReadingpointsArray.removeAll()
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "RecordPointsUpdated"), object: nil)
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                finalReadingpointsArray.removeAll()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "RecordPointsUpdated"), object: nil)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: equipment details
    func getEquipmentsFromTechID(list:[String],dict:Dictionary<String,Any>,type:String){
        let defineQ = "$filter=\(self.getEquipmentQuery(list: list))"
        EquipmentModel.getEquipmentList(filterQuery: defineQ){(response,error) in
            if error == nil{
                var equipmetnArr = [String]()
                if let respArr = response["data"] as? [EquipmentModel]{
                    for item in respArr{
                        if !equipmetnArr.contains(item.Equipment){
                            equipmetnArr.append(item.Equipment)
                        }
                    }
                }
                self.techIdEquipmentList.removeAll()
                self.techIdEquipmentList = equipmetnArr
                if type == "Notification" {
                    self.delegate?.dataFetchCompleted?(type: "NoFilter", object: [dict])
                }else if type == "WorkOrder" {
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        self.delegate?.dataFetchCompleted?(type: "OprFilter", object: [dict])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "WoFilter", object: [dict])
                    }
                }
            }
        }
    }
    func getEquipmentQuery(list:[String]) -> String{
        var str = ""
        for item in list{
            if str.count == 0{
                str = str + "TechIdentNo eq" + " '\(item)'"
            }else{
                str = str + "or" + " " + "TechIdentNo eq" + " '\(item)'"
            }
        }
        return str
    }
    //MARK: Searching
    func applyWorkorderFilter(filterDict:Dictionary<String,Any>,searchText: String? = "" ) -> [WoHeaderModel]{
        mJCLogger.log("Starting", Type: "info")
        let predicateArray = NSMutableArray()
        var filteredArray = [WoHeaderModel]()
        if filterDict.keys.count != 0{
            if filterDict.keys.contains("priority"),let arr = filterDict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("orderType"),let arr = filterDict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "OrderType IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("status"),let arr = filterDict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", arr,arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("plant"),let arr = filterDict["plant"] as? [String]{
                if arr.count > 0{
                    //selectedPlantArry = arr
                }
            }
            if filterDict.keys.contains("createdBy"),let arr = filterDict["createdBy"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "EnteredBy IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("mainWorkCenter"),let arr = filterDict["mainWorkCenter"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MainWorkCtr IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("mainPlantGroup"),let arr = filterDict["mainPlantGroup"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "ResponsiblPlannerGrp IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("staffId"),let arr = filterDict["staffId"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "PersonResponsible IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("maintenancePlant"),let arr = filterDict["maintenancePlant"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MaintPlant IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("planningPlant"),let arr = filterDict["planningPlant"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MaintPlanningPlant IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("techID"),let arr = filterDict["techID"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "EquipNum IN %@", self.techIdEquipmentList)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("unAssigned"),let arr = filterDict["unAssigned"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "UnAssigned" {
                        let predicate5 = NSPredicate(format: "PersonResponsible == ''")
                        predicateArray.add(predicate5)
                    }
                }
            }
            if filterDict.keys.contains("createdByMe"),let arr = filterDict["createdByMe"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "CreatedByMe" {
                        let predicate = NSPredicate(format: "EnteredBy == %@",userDisplayName)
                        predicateArray.add(predicate)
                    }
                }
            }
            self.woNoArray.removeAll()
            for item in (self.woNoListArray as! [WoHeaderModel]) {
                item.isSelectedCell = false
            }
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            filteredArray = (self.woNoListArray as! [WoHeaderModel]).filter{compound.evaluate(with: $0)}
        }else{
            filteredArray = (self.woNoListArray as! [WoHeaderModel])
        }
        if searchText != ""{
            var searchFilter = [WoHeaderModel]()
            if searchText!.isNumeric == true{
                searchFilter = filteredArray.filter{$0.WorkOrderNum.contains(searchText!) || $0.EquipNum.contains(searchText!)}
            }else {
                searchFilter = filteredArray.filter{$0.FuncLocation.containsIgnoringCase(find: searchText!) || $0.ShortText.containsIgnoringCase(find: searchText!)}
            }
            return searchFilter
        }else{
            return filteredArray
        }
    }
    func applyOperationFilter(filterDict:Dictionary<String,Any>,searchText: String? = "" ) -> [WoOperationModel]{
        let predicateArray = NSMutableArray()
        var filteredArray = [WoOperationModel]()

        if filterDict.keys.count != 0{
            if filterDict.keys.contains("priority"),let arr = filterDict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "WoPriority IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("orderType"),let arr = filterDict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "OrderType IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("status"),let arr = filterDict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileStatus IN %@ || UserStatus IN %@",arr,arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("plant"),let arr = filterDict["plant"] as? [String]{
                if arr.count > 0{
                    //selectedPlantArry = arr
                }
            }
            if filterDict.keys.contains("createdBy"),let arr = filterDict["createdBy"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "EnteredBy IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("mainWorkCenter"),let arr = filterDict["mainWorkCenter"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "SELF.WorkCenter IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("mainPlantGroup"),let arr = filterDict["mainPlantGroup"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "PlannerGroup IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("staffId"),let arr = filterDict["staffId"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "PersonnelNo IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("maintenancePlant"),let arr = filterDict["maintenancePlant"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MaintPlanningPlant IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("planningPlant"),let arr = filterDict["planningPlant"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "PlanningPlant IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("techID"),let arr = filterDict["techID"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Equipment IN %@", self.techIdEquipmentList)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("unAssigned"),let arr = filterDict["unAssigned"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "UnAssigned" {
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            let predicate5 = NSPredicate(format: "PersonnelNo == '00000000'")
                            predicateArray.add(predicate5)
                        }else if WORKORDER_ASSIGNMENT_TYPE == "4"{
                            let predicate5 = NSPredicate(format: "WorkCenter == ''")
                            predicateArray.add(predicate5)
                        }
                    }
                }
            }
            if filterDict.keys.contains("createdByMe"),let arr = filterDict["createdByMe"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "CreatedByMe" {
                        let predicate = NSPredicate(format: "EnteredBy == %@",userDisplayName)
                        predicateArray.add(predicate)
                    }
                }
            }
            self.woNoArray.removeAll()
            for item in (self.woNoListArray as! [WoOperationModel]) {
                item.isSelected = false
            }
            let finalPredicateArray : [NSPredicate] = predicateArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)

            filteredArray = (self.woNoListArray as! [WoOperationModel]).filter{compound.evaluate(with: $0)}
        }else{
            filteredArray = self.woNoListArray as! [WoOperationModel]
        }
        if searchText != ""{
            var searchFilter = [WoOperationModel]()
            if searchText!.isNumeric == true{
                searchFilter = filteredArray.filter{$0.WorkOrderNum.containsIgnoringCase(find: searchText!) || $0.OperationNum.containsIgnoringCase(find: searchText!) || $0.Equipment.containsIgnoringCase(find: searchText!)}
            }else {
                searchFilter = filteredArray.filter{$0.ShortText.containsIgnoringCase(find: searchText!) || $0.FuncLoc.containsIgnoringCase(find: searchText!)}
            }
            return searchFilter
        }else{
            return filteredArray
        }
    }
    func applyNotificationFilter(filterDict:Dictionary<String,Any>,searchText: String? = "" ) -> [NotificationModel]{

        let predicateArray = NSMutableArray()
        var filteredArray = [NotificationModel]()

        if filterDict.keys.count != 0{

            if filterDict.keys.contains("priority"),let arr = filterDict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("orderType"),let arr = filterDict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "NotificationType IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("status"),let arr = filterDict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileStatus IN %@ || UserStatus In %@", arr,arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("plant"),let arr = filterDict["plant"] as? [String]{
                if arr.count > 0{
                    //selectedPlantArry = arr
                }
            }
            if filterDict.keys.contains("createdBy"),let arr = filterDict["createdBy"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "EnteredBy IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("mainWorkCenter"),let arr = filterDict["mainWorkCenter"] as? [String]{
                if arr.count > 0{
                    var listArr = [WorkCenterModel]()
                    var objectArr = [String]()
                    let predicate = NSPredicate(format: "WorkCenter IN %@",arr)
                    listArr = globalWorkCtrArray.filter{predicate.evaluate(with: $0)}
                    for item in listArr {
                        let dispStr = item.ObjectID
                        objectArr.append(dispStr)
                    }
                    let predicate4 = NSPredicate(format: "WorkCenter IN %@",objectArr)
                    predicateArray.add(predicate4)
                }
            }
            if filterDict.keys.contains("mainPlantGroup"),let arr = filterDict["mainPlantGroup"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "PlannerGroup IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("staffId"),let arr = filterDict["staffId"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Partner IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("maintenancePlant"),let arr = filterDict["maintenancePlant"] as? [String]{
                if arr.count > 0{
                    let predicate5 = NSPredicate(format: "MaintPlant IN %@",arr)
                    predicateArray.add(predicate5)
                }
            }
            if filterDict.keys.contains("planningPlant"),let arr = filterDict["planningPlant"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "PlanningPlant IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("techID"),let arr = filterDict["techID"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Equipment IN %@", self.techIdEquipmentList)
                    predicateArray.add(predicate)
                }
            }
            if filterDict.keys.contains("unAssigned"),let arr = filterDict["unAssigned"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "UnAssigned" {
                        let predicate = NSPredicate(format: "Partner == ''")
                        predicateArray.add(predicate)
                    }
                }
            }
            if filterDict.keys.contains("createdByMe"),let arr = filterDict["createdByMe"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "CreatedByMe" {
                        let predicate = NSPredicate(format: "EnteredBy == %@",userDisplayName)
                        predicateArray.add(predicate)
                    }
                }
            }
            self.woNoArray.removeAll()
            for noitem in self.woNoListArray {
                (noitem as! NotificationModel).isSelectedCell = false
            }


            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            filteredArray = (self.woNoListArray as! [NotificationModel]).filter{compound.evaluate(with: $0)}
        }else{
            filteredArray = self.woNoListArray as! [NotificationModel]
        }
        if searchText != ""{
            var searchFilter = [NotificationModel]()
            if searchText!.isNumeric == true{
                searchFilter = filteredArray.filter{$0.Notification.containsIgnoringCase(find: searchText!) || $0.Equipment.containsIgnoringCase(find: searchText!)}
            }else {
                searchFilter = filteredArray.filter{$0.ShortText.containsIgnoringCase(find: searchText!) || $0.FunctionalLoc.containsIgnoringCase(find: searchText!)}
            }
            return searchFilter
        }else{
            return filteredArray
        }
    }
    func applyDateSorting(type:String,dateSort:Bool,assignment:String){
        if type == "WorkOrder" {
            if dateSort == true {
                if assignment == "2" || assignment == "4" || assignment == "5" {
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"LatestSchStartDate", ascending : false)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [Any]
                    }
                }else{
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"BasicStrtDate", ascending : false)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [WoHeaderModel]
                    }
                }
            }else{
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"LatestSchStartDate", ascending : true)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [Any]
                    }
                }else{
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"BasicStrtDate", ascending : true)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [WoHeaderModel]
                    }
                }
            }
        }else if type == "Notification" {
            if dateSort == true {
                if woNoArray.count > 0 {
                    let array = woNoListArray as NSArray
                    let descriptor:NSSortDescriptor = NSSortDescriptor (key:"RequiredStartDate", ascending : false)
                    let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                    woNoArray.removeAll()
                    woNoArray = sortedArray as! [NotificationModel]
                }
            }else {
                if woNoArray.count > 0 {
                    let array = woNoListArray as NSArray
                    let descriptor:NSSortDescriptor = NSSortDescriptor (key:"RequiredStartDate", ascending : true)
                    let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                    woNoArray.removeAll()
                    woNoArray = sortedArray as! [NotificationModel]
                }
            }
        }
        self.delegate?.dataFetchCompleted?(type: "sorting", object: [])
    }
    func applyPrioritySorting(type:String,priortySort:Bool,assignment:String){
        if currentMasterView == "WorkOrder" {
            var descriptor = NSSortDescriptor()
            if priortySort == true {
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    descriptor = NSSortDescriptor (key:"WoPriority", ascending : false)
                }else{
                    descriptor = NSSortDescriptor (key:"Priority", ascending : false)
                }
            }else {
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    descriptor = NSSortDescriptor (key:"WoPriority", ascending : true)
                }else{
                    descriptor = NSSortDescriptor (key:"Priority", ascending : true)
                }
            }
            if assignment == "2" || assignment == "4" ||  assignment == "5" {
                if woNoArray.count > 0 {
                    let array = woNoArray as NSArray
                    let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                    woNoArray.removeAll()
                    woNoArray = sortedArray as! [WoOperationModel]
                }
            }else{
                if woNoArray.count > 0 {
                    let array = woNoArray as NSArray
                    let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                    woNoArray.removeAll()
                    woNoArray = sortedArray as! [WoHeaderModel]
                }
            }
        }else if currentMasterView == "Notification" {
            var descriptor = NSSortDescriptor()
            if priortySort == true {
                descriptor = NSSortDescriptor (key:"Priority", ascending : false)
            }else {
                descriptor = NSSortDescriptor (key:"Priority", ascending : true)
            }
            let array = woNoArray as NSArray
            let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
            woNoArray.removeAll()
            woNoArray = sortedArray as! [NotificationModel]
        }
        self.delegate?.dataFetchCompleted?(type: "sorting", object: [])
    }
    func applyOrderSorting(type:String,orderSort:Bool,assignment:String){
        if type == "WorkOrder" {
            if orderSort == true {
                if assignment == "2" || assignment == "4" || assignment == "5" {
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor1:NSSortDescriptor = NSSortDescriptor (key:"WorkOrderNum", ascending : false)
                        let descriptor2:NSSortDescriptor = NSSortDescriptor (key:"OperationNum", ascending : false)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor1,descriptor2]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [Any]
                    }
                }else{
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"WorkOrderNum", ascending : false)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [WoHeaderModel]
                    }
                }
            }else{
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor1:NSSortDescriptor = NSSortDescriptor (key:"WorkOrderNum", ascending : true)
                        let descriptor2:NSSortDescriptor = NSSortDescriptor (key:"OperationNum", ascending : true)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor1,descriptor2]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [Any]
                    }
                }else{
                    if woNoArray.count > 0 {
                        let array = woNoArray as NSArray
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"WorkOrderNum", ascending : true)
                        let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                        woNoArray.removeAll()
                        woNoArray = sortedArray as! [WoHeaderModel]
                    }
                }
            }
        }else if type == "Notification" {
            if orderSort == true {
                if woNoArray.count > 0 {
                    let array = woNoListArray as NSArray
                    let descriptor:NSSortDescriptor = NSSortDescriptor (key:"Notification", ascending : false)
                    let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                    woNoArray.removeAll()
                    woNoArray = sortedArray as! [NotificationModel]
                }
            }else {
                if woNoArray.count > 0 {
                    let array = woNoListArray as NSArray
                    let descriptor:NSSortDescriptor = NSSortDescriptor (key:"Notification", ascending : true)
                    let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
                    woNoArray.removeAll()
                    woNoArray = sortedArray as! [NotificationModel]
                }
            }
        }
    }
    func getActiveDetails(activeDetails:NSDictionary,type:String,assignment:String){
        mJCLogger.log("Starting", Type: "info")
        if((UserDefaults.standard.value(forKey:"active_details")) != nil){
            let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
            if type == "WorkOrder"{
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    let activedetails = UserDefaults.standard.value(forKey: "active_details") as! Dictionary<String, Any>
                    let activeWOnum = activedetails["WorkorderNum"]  as? String ?? ""
                    let activeOprNum = activedetails["OperationNum"] as? String ?? ""
                    let filterar = (woNoArray as! [WoOperationModel]).filter{ $0.WorkOrderNum == activeWOnum && $0.OperationNum == activeOprNum}
                    if filterar.count > 0{
                        let index = (woNoArray as! [WoOperationModel]).firstIndex(of: filterar[0])
                        if woNoArray.indices.contains(index ?? 0){
                            self.delegate?.dataFetchCompleted?(type: "scrollToActive", object: [index!])
                        }
                    }else{
                        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                            self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
                        }else{
                            let filterar2 = (woNoListArray as! [WoOperationModel]).filter{ $0.WorkOrderNum == activeWOnum && $0.OperationNum == activeOprNum}
                            if filterar2.count > 0 {
                                var index = (woNoListArray as! [WoOperationModel]).firstIndex(of: filterar2[0]) ?? 0
                                var countValue = 0
                                var listValue = 0
                                countValue = (index/50)+1
                                listValue = (50*countValue)
                                if listValue > allOperationsArray.count{
                                    let removeValue = listValue - allOperationsArray.count
                                    listValue = listValue - removeValue
                                }
                                woNoArray.removeAll()
                                for i in 0..<listValue{
                                    woNoArray.append(woNoListArray[i])
                                }
                                index = (woNoArray as! [WoOperationModel]).firstIndex(of: filterar2[0]) ?? 0
                                if woNoArray.indices.contains(index){
                                    self.delegate?.dataFetchCompleted?(type: "scrollToActive", object: [index])
                                }
                            }else{
                                self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
                            }
                        }
                    }
                }else{
                    let activeWOnum = activedetails.value(forKey: "WorkorderNum") as! String
                    let filterar = (woNoArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(activeWOnum)"}
                    if filterar.count > 0{
                        if let index = (woNoArray as! [WoHeaderModel]).firstIndex(of: filterar[0]){
                            if woNoArray.indices.contains(index){
                                self.delegate?.dataFetchCompleted?(type: "scrollToActive", object: [index])
                            }else{
                                self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
                            }
                        }else{
                            self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
                        }
                    }else{
                        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                            self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
                        }else{
                            let filterar2 = (woNoListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum == "\(activeWOnum)"}
                            if filterar2.count > 0 {
                                var index = (woNoListArray as! [WoHeaderModel]).firstIndex(of: filterar2[0]) ?? 0
                                var countValue = 0
                                var listValue = 0
                                countValue = (index/50)+1
                                listValue = (50*countValue)
                                if listValue > woNoListArray.count{
                                    let removeValue = listValue - woNoListArray.count
                                    listValue = listValue - removeValue
                                }
                                woNoArray.removeAll()
                                for i in 0..<listValue{
                                    woNoArray.append(woNoListArray[i])
                                }
                                index = (woNoArray as! [WoHeaderModel]).firstIndex(of: filterar2[0]) ?? 0
                                if woNoArray.indices.contains(index){
                                    self.delegate?.dataFetchCompleted?(type: "scrollToActive", object: [index])
                                }
                            }else{
                                self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
                            }
                        }
                    }
                }
            }else{
                if let activeNOnum = activedetails.value(forKey: "Notification") as? String{
                    let filterar = (woNoArray as! [NotificationModel]).filter{$0.Notification == "\(activeNOnum)"}
                    if filterar.count > 0{
                        let index = (woNoArray as! [NotificationModel]).firstIndex(of: filterar[0])
                        if woNoArray.indices.contains(index ?? 0){
                            self.delegate?.dataFetchCompleted?(type: "scrollToActive", object: [index ?? 0])
                        }else{
                            self.delegate?.dataFetchCompleted?(type: "noActive", object: ["Notification"])
                        }
                    }else{
                        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                            self.delegate?.dataFetchCompleted?(type: "noActive", object: ["Notification"])
                        }else{
                            let filterar2 = (woNoListArray as! [NotificationModel]).filter{$0.Notification == "\(activeNOnum)"}
                            if filterar2.count > 0{
                                var index = (woNoListArray as! [NotificationModel]).firstIndex(of: filterar2[0]) ?? 0
                                var countValue = 0
                                var listValue = 0
                                countValue = (index/50)+1
                                listValue = (50*countValue)
                                if listValue > woNoListArray.count{
                                    let removeValue = listValue - woNoListArray.count
                                    listValue = listValue - removeValue
                                }
                                woNoArray.removeAll()
                                for i in 0..<listValue{
                                    woNoArray.append(woNoListArray[i])
                                }
                                index = (woNoArray as! [NotificationModel]).firstIndex(of: filterar2[0]) ?? 0
                                if woNoArray.indices.contains(index){
                                    self.delegate?.dataFetchCompleted?(type: "scrollToActive", object: [index])
                                }
                            }else{
                                self.delegate?.dataFetchCompleted?(type: "noActive", object: ["Notification"])
                            }
                        }
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "noActive", object: ["Notification"])
                }
            }
        }else{
            if currentMasterView == "WorkOrder"{
                self.delegate?.dataFetchCompleted?(type: "noActive", object: ["workorder"])
            }else{
                self.delegate?.dataFetchCompleted?(type: "noActive", object: ["Notification"])
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setListDetails(assignment:String){
        if currentMasterView == "Notification" {
            if onlineSearch == true {
                woNoArray.removeAll()
                woNoListArray.removeAll()
                if onlineSearchArray.count > 0{
                    if let arr = onlineSearchArray as? [NotificationModel]{
                        woNoArray = arr
                        woNoListArray = arr
                        mJCLoader.stopAnimating()
                        if woNoArray.count > 0{
                            if let noCls = woNoArray[0] as? NotificationModel{
                                noCls.isSelectedCell = true
                            }
                        }
                    }
                }
            }else{
                if filteredNotifications.count == 0{
                    woNoListArray.append(contentsOf: allNotficationArray)
                    let arr = (woNoListArray as Array<Any>).prefix(self.skipvalue)
                    woNoArray.append(contentsOf: arr)
                    if woNoArray.count > 0{
                        if let noCls = woNoArray[0] as? NotificationModel {
                            noCls.isSelectedCell = true
                        }
                    }
                }else{
                    woNoArray.removeAll()
                    woNoListArray.removeAll()
                    woNoArray = filteredNotifications
                    woNoListArray = allNotficationArray
                    if woNoArray.count > 0{
                        if let notification = woNoArray[0] as? NotificationModel{
                            notification.isSelectedCell = true
                        }
                    }
                    mJCLoader.stopAnimating()
                }
            }
            self.delegate?.dataFetchCompleted?(type: "listData", object: ["Notification"])
        }else if currentMasterView == "WorkOrder" {
           
            woNoArray.removeAll()
            woNoListArray.removeAll()
            if onlineSearch == true{
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    if let woArr = onlineSearchArray as? [WoHeaderModel]{
                        woNoArray = woArr
                        var oprListArr = [WoOperationModel]()
                        for item in woNoArray{
                            if let workorder = item as? WoHeaderModel{
                                if let oprArr = workorder.NAVOPERA["data"] as? [WoOperationModel]{
                                    oprListArr.append(contentsOf: oprArr)
                                }
                            }
                        }
                        oprListArr.sort{($0.WorkOrderNum,$1.OperationNum) < ($1.WorkOrderNum,$1.OperationNum)}
                        if oprListArr.count > 0{
                            for item in oprListArr{ item.isSelected = false }
                            let oprClass = oprListArr[0]
                            singleOperation = oprClass
                            selectedOperationNumber = oprClass.OperationNum
                            woNoArray.removeAll()
                            woNoListArray.removeAll()
                            woNoArray.append(contentsOf: oprListArr)
                            woNoListArray.append(contentsOf: oprListArr)
                            if DeviceType == iPad { singleOperation.isSelected = true }
                            
                            mJCLoader.stopAnimating()
                        }
                    }
                }else{
                    if let woListArr = onlineSearchArray as? [WoHeaderModel]{
                        woNoArray.removeAll()
                        woNoListArray.removeAll()
                        woNoArray = woListArr
                        woNoListArray = woListArr
                        if woNoArray.count > 0{
                            if let woCls = woNoArray[0] as? WoHeaderModel {
                                woCls.isSelectedCell = true
                            }
                        }
                    }
                }
            }else{
                woNoArray.removeAll()
                woNoListArray.removeAll()
                if assignment == "2" || assignment == "4" || assignment == "5"{
                    if filteredWorkorders.count == 0{
                        woNoArray.removeAll()
                        woNoListArray.removeAll()
                        for item in allOperationsArray{ item.isSelected = false }
                        woNoListArray.append(contentsOf: allOperationsArray)
                        let arr = (woNoListArray as Array<Any>).prefix(self.skipvalue)
                        woNoArray.append(contentsOf: arr)
                        if woNoArray.count > 0{
                            if let oprCls = woNoArray[0] as? WoOperationModel {
                                oprCls.isSelected = true
                            }
                        }
                    }else{
                        if !applicationFeatureArrayKeys.contains("DASH_OPR_TILE"){
                            var woListArr = [String]()
                            for item in filteredWorkorders{
                                if !woListArr.contains(item.WorkOrderNum){
                                    woListArr.append(item.WorkOrderNum)
                                }
                            }
                            if woListArr.count > 0 {
                                woNoListArray = allOperationsArray
                                let predicate = NSPredicate(format: "WorkOrderNum IN %@", woListArr as [AnyObject])
                                let array = woNoListArray.filter{predicate.evaluate(with: $0)}
                                woNoArray = array as! [WoOperationModel]
                                if woNoArray.count > 0{
                                    if let oprCls = woNoArray[0] as? WoOperationModel {
                                        oprCls.isSelected = true
                                    }
                                }
                            }
                        }else{
                            woNoArray = filteredOperations
                            woNoListArray = allOperationsArray
                        }
                        mJCLoader.stopAnimating()
                    }
                }else{
                    if filteredWorkorders.count == 0{
                        woNoArray.removeAll()
                        woNoListArray.removeAll()
                        woNoListArray.append(contentsOf: allworkorderArray)
                        let arr = (woNoListArray as Array<Any>).prefix(self.skipvalue)
                        woNoArray.append(contentsOf: arr)
                        if woNoArray.count > 0{
                            if let oprCls = woNoArray[0] as? WoHeaderModel {
                                oprCls.isSelectedCell = true
                            }
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        woNoArray.removeAll()
                        woNoListArray.removeAll()
                        woNoArray = filteredWorkorders
                        woNoListArray = allworkorderArray
                        if woNoArray.count > 0{
                            if let oprCls = woNoArray[0] as? WoHeaderModel {
                                oprCls.isSelectedCell = true
                            }
                        }
                    }
                }
            }
            self.delegate?.dataFetchCompleted?(type: "listData", object: ["workorder"])
        }
    }
    func getFilterVaues(type:String,assignment:String){

        var priorityArray = [String]()
        var ordertypeArray = [String]()
        var statusArray = [String]()
        var plantArray = [String]()
        var createdByArray = [String]()
        var mainWorkCenterArray = [String]()
        var mainPlantGroupArray = [String]()
        var staffIdArr = [String]()
        var maintenancePlantArray = [String]()
        var planningPlantArray = [String]()
        var equipArray = [String]()

        if type == "WorkOrder"{
            if assignment == "2" || assignment == "4" || assignment == "5"{
                priorityArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.WoPriority}
                if let index = priorityArray.index(of: ""){
                    priorityArray[index] = "No_Priority".localized()
                }
                ordertypeArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.OrderType}
                statusArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.UserStatus}
                plantArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.Plant}
                if let index = plantArray.index(of: ""){
                    plantArray[index] = "No_Value".localized()
                }
                createdByArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.EnteredBy}
                if let index = createdByArray.index(of: ""){
                    createdByArray[index] = "No_Value".localized()
                }
                mainWorkCenterArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.WorkCenter}
                if let index = mainWorkCenterArray.index(of: ""){
                    mainWorkCenterArray[index] = "No_Value".localized()
                }
                mainPlantGroupArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.PlannerGroup}
                if let index = mainPlantGroupArray.index(of: ""){
                    mainPlantGroupArray[index] = "No_Value".localized()
                }
                staffIdArr = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.PersonnelNo}
                if let index = staffIdArr.index(of: ""){
                    staffIdArr[index] = "No_Value".localized()
                }
                maintenancePlantArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.MaintPlanningPlant}
                if let index = maintenancePlantArray.index(of: ""){
                    maintenancePlantArray[index] = "No_Value".localized()
                }
                planningPlantArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.PlanningPlant}
                if let index = maintenancePlantArray.index(of: ""){
                    planningPlantArray[index] = "No_Value".localized()
                }
                equipArray = (woNoListArray as! [WoOperationModel]).uniqueValues{$0.Equipment}
            }else{
                priorityArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.Priority}
                if let index = priorityArray.index(of: ""){
                    priorityArray[index] = "No_Priority".localized()
                }
                ordertypeArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.OrderType}
                statusArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.MobileObjStatus}
                plantArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.Plant}
                if let index = plantArray.index(of: ""){
                    plantArray[index] = "No_Value".localized()
                }
                createdByArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.EnteredBy}
                if let index = createdByArray.index(of: ""){
                    createdByArray[index] = "No_Value".localized()
                }
                mainWorkCenterArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.MainWorkCtr}
                if let index = mainWorkCenterArray.index(of: ""){
                    mainWorkCenterArray[index] = "No_Value".localized()
                }
                mainPlantGroupArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.ResponsiblPlannerGrp}
                if let index = mainPlantGroupArray.index(of: ""){
                    mainPlantGroupArray[index] = "No_Value".localized()
                }
                staffIdArr = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.PersonResponsible}
                if let index = staffIdArr.index(of: ""){
                    staffIdArr[index] = "No_Value".localized()
                }
                maintenancePlantArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.MaintPlant}
                if let index = maintenancePlantArray.index(of: ""){
                    maintenancePlantArray[index] = "No_Value".localized()
                }
                planningPlantArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.MaintPlanningPlant}
                if let index = maintenancePlantArray.index(of: ""){
                    planningPlantArray[index] = "No_Value".localized()
                }
                equipArray = (woNoListArray as! [WoHeaderModel]).uniqueValues{$0.EquipNum}
            }
        }else{
            priorityArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.Priority}
            if let index = priorityArray.index(of: ""){
                priorityArray[index] = "No_Priority".localized()
            }
            ordertypeArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.NotificationType}
            statusArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.UserStatus}
            plantArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.PltforWorkCtr}
            if let index = plantArray.index(of: ""){
                plantArray[index] = "No_Value".localized()
            }
            createdByArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.EnteredBy}
            if let index = createdByArray.index(of: ""){
                createdByArray[index] = "No_Value".localized()
            }
            mainWorkCenterArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.WorkCenter}
            if let index = mainWorkCenterArray.index(of: ""){
                mainWorkCenterArray[index] = "No_Value".localized()
            }
            mainPlantGroupArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.PlannerGroup}
            if let index = mainPlantGroupArray.index(of: ""){
                mainPlantGroupArray[index] = "No_Value".localized()
            }
            staffIdArr = (woNoListArray as! [NotificationModel]).uniqueValues{$0.Partner}
            if let index = staffIdArr.index(of: ""){
                staffIdArr[index] = "No_Value".localized()
            }
            maintenancePlantArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.MaintPlant}
            if let index = maintenancePlantArray.index(of: ""){
                maintenancePlantArray[index] = "No_Value".localized()
            }
            planningPlantArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.PlanningPlant}
            if let index = planningPlantArray.index(of: ""){
                planningPlantArray[index] = "No_Value".localized()
            }
            equipArray = (woNoListArray as! [NotificationModel]).uniqueValues{$0.Equipment}
        }
        var dict = Dictionary<String,Any>()
        dict["priority"] = priorityArray
        dict["ordertype"] = ordertypeArray
        dict["status"] = statusArray
        dict["plant"] = plantArray
        dict["createdBy"] = createdByArray
        dict["mainWorkCenter"] = mainWorkCenterArray
        dict["mainPlantGroup"] = mainPlantGroupArray
        dict["staffId"] = staffIdArr
        dict["maintenancePlant"] = maintenancePlantArray
        dict["planningPlant"] = planningPlantArray
        dict["equip"] = equipArray
        self.delegate?.dataFetchCompleted?(type: "filter", object: [dict])
    }
}
