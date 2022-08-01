//
//  NotificationTaskViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class NotificationTaskViewModel {
    
    var vc: NotificationTaskVC!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var selectedTask = String()
    var singleTaskArray = [NotificationTaskModel]()
    var totalTaskArray = [NotificationTaskModel]()
    var property = NSMutableArray()
    var partArray = Array<CodeGroupModel>()

    //MARK:- Get Notification Items list..
    func getNotificationTasksData() {
        mJCLogger.log("Starting", Type: "info")
        var itemNum = String()
        if vc?.isfromscreen == "ItemTasks" {
            itemNum = vc?.itemNum ?? ""
        }else{
            itemNum = "0000"
        }
        
        if self.vc?.notificationFrom == "FromWorkorder"{
            
            let defineQuery = "$filter=(Notification%20eq%20%27" + selectedNotificationNumber + "%27%20and%20Item%20eq%20%27" + itemNum + "%27)&$orderby=Task"
            
            NotificationTaskModel.getWoNotificationtaskList(notifNum: selectedNotificationNumber, filterQuery: defineQuery) {  (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalTaskArray = responseArr
                            if(self.totalTaskArray.count > 0) {
                                self.vc?.totalTaskCountLabel.text = "Total".localized() + ": \(self.totalTaskArray.count)"
                                self.vc?.noDataLAbel.isHidden = true
                                if DeviceType == iPad{
                                    for i in 0..<self.totalTaskArray.count {
                                        let notificationItemsClass = self.totalTaskArray[i]
                                        notificationItemsClass.isSelected = false
                                    }
                                    if self.selectedTask != "" {
                                        for i in 0..<self.totalTaskArray.count {
                                            let notificationItemsClass = self.totalTaskArray[i]
                                            let currentTask = notificationItemsClass.Task
                                            if self.selectedTask == currentTask {
                                                notificationItemsClass.isSelected = true
                                                self.selectedTask = notificationItemsClass.Task
                                                break
                                            }else {
                                                let notificationItemsClass = self.totalTaskArray[0]
                                                notificationItemsClass.isSelected = true
                                                self.selectedTask = notificationItemsClass.Task
                                            }
                                        }
                                    }else {
                                        let notificationItemsClass = self.totalTaskArray[0]
                                        notificationItemsClass.isSelected = true
                                        self.selectedTask = notificationItemsClass.Task
                                    }
                                    if DeviceType == iPad{
                                        self.vc?.totalTaskTableView.reloadData()
                                    }
                                }
                                self.getSingleTaskData()
                            }else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getNotificationTasksDataUI()
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            let defineQuery = "$filter=(Notification%20eq%20%27" + selectedNotificationNumber + "%27%20and%20Item%20eq%20%27" + itemNum + "%27)&$orderby=Task"
            NotificationTaskModel.getNotificationTaskList(notifNum: selectedNotificationNumber, filterQuery: defineQuery) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalTaskArray = responseArr
                            if(self.totalTaskArray.count > 0) {
                                self.vc?.totalTaskCountLabel.text = "Total".localized() + ": \(self.totalTaskArray.count)"
                                self.vc?.noDataLAbel.isHidden = true
                                if DeviceType == iPad{
                                    for i in 0..<self.totalTaskArray.count {
                                        let notificationItemsClass = self.totalTaskArray[i]
                                        notificationItemsClass.isSelected = false
                                    }
                                    if self.selectedTask != "" {
                                        for i in 0..<self.totalTaskArray.count {
                                            let notificationItemsClass = self.totalTaskArray[i]
                                            let currentTask = notificationItemsClass.Task
                                            if self.selectedTask == currentTask {
                                                notificationItemsClass.isSelected = true
                                                self.selectedTask = notificationItemsClass.Task
                                                break
                                            }else {
                                                let notificationItemsClass = self.totalTaskArray[0]
                                                notificationItemsClass.isSelected = true
                                                self.selectedTask = notificationItemsClass.Task
                                            }
                                        }
                                    }else {
                                        let notificationItemsClass = self.totalTaskArray[0]
                                        notificationItemsClass.isSelected = true
                                        self.selectedTask = notificationItemsClass.Task
                                    }
                                    if DeviceType == iPad{
                                        self.vc?.totalTaskTableView.reloadData()
                                    }
                                }
                                self.getSingleTaskData()
                            }else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getNotificationTasksDataUI()
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    //MARK:- Get Single Item Data..
    func getSingleTaskData() {
        
        mJCLogger.log("Starting", Type: "info")
        if self.vc?.notificationFrom == "FromWorkorder"{
            
            if self.vc?.isfromscreen == "ItemTasks"{
                
                NotificationTaskModel.getWoNoItemTaskDetails(notifNum: selectedNotificationNumber, itemNum: self.vc.itemNum, taskNum: selectedTask){ (responseDict, error)  in
                    if error == nil{
                        DispatchQueue.main.async {
                            
                            self.singleTaskArray.removeAll()
                            if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                                mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                self.singleTaskArray = responseArr
                                
                            }
                            else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getSingleTaskDataUI()
                        }
                    }else{
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }else{
                
                NotificationTaskModel.getWoNotificationTaskDetails(notifNum: selectedNotificationNumber, taskNum: selectedTask, filterQuery: ""){ (responseDict, error)  in
                    if error == nil{
                        DispatchQueue.main.async {
                            
                            self.singleTaskArray.removeAll()
                            if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                                mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                self.singleTaskArray = responseArr
                                
                            }
                            else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getSingleTaskDataUI()
                        }
                    }else{
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
        }else{
            if self.vc?.isfromscreen == "ItemTasks"{
                NotificationTaskModel.getNoItemTaskDetails(notifNum: selectedNotificationNumber, itemNum: self.vc.itemNum, taskNum: selectedTask) { (responseDict, error)  in
                    if error == nil{
                        DispatchQueue.main.async {
                            
                            self.singleTaskArray.removeAll()
                            if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                                mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                self.singleTaskArray = responseArr
                                
                            }
                            else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getSingleTaskDataUI()
                        }
                    }else{
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }else{
                NotificationTaskModel.getNotificationTaskDetails(notifNum: selectedNotificationNumber, taskNum: selectedTask)  { (responseDict, error)  in
                    if error == nil{
                        DispatchQueue.main.async {
                            
                            self.singleTaskArray.removeAll()
                            if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                                mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                self.singleTaskArray = responseArr
                                
                            }
                            else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getSingleTaskDataUI()
                        }
                    }else{
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func UpdateStatus(index:Int){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "Notification"{
            let validStatusClass = self.vc.statusArray[index] as! StatusCategoryModel
            if validStatusClass.CnfPopup == "X"
            {
                DispatchQueue.main.async {
                    
                    let params = Parameters(
                        title: alerttitle,
                        message: validStatusClass.Msgkey,
                        cancelButton: "YES".localized(),
                        otherButtons: ["NO".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(self.vc, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            DispatchQueue.main.async {
                                if validStatusClass.CaptureTime == "X"{
                                    self.getStausChangeLogSet(validStatus:validStatusClass, isfrom: "")
                                }else {
                                    self.vc.getWorkFlowSet(validClass:validStatusClass, from: "")
                                }
                            }
                        case 1: break
                        default: break
                        }
                    }
                }
                
            }else{
                if validStatusClass.CaptureTime == "X"{
                    self.getStausChangeLogSet(validStatus:validStatusClass, isfrom: "")
                }else {
                    self.vc.getWorkFlowSet(validClass:validStatusClass, from: "")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getStausChangeLogSet(validStatus:StatusCategoryModel,isfrom:String) {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        var status = String()
        if isfrom == "Update"{
            status = validStatus.Ref_Cal_Status
        }else{
            status = validStatus.StatusCode
        }
       
        defineQuery = "$filter=(StatusCode eq '\(status)' and ObjectNum eq '\(selectedworkOrderNumber)' and IsConsidered eq false)"
        
        StatusChangeLogModel.getStatusChangeLogList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                
                let responseArr = response["data"] as! [StatusChangeLogModel]
                mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                if isfrom == "Update"{
                    self.vc.getWorkFlowSet(validClass:validStatus, from: "")
                }else{
                    if responseArr.count == 0{
                        self.postStatusChangeLogSet(statusClass: validStatus)
                    }else{
                        if responseArr.count == 0{
                            self.UpdateStatusChangeLogSet(logSetClass: responseArr[0], statusClass: validStatus)
                        }
                    }
                }
                
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func postStatusChangeLogSet(statusClass:StatusCategoryModel) {
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ObjectNum")
        prop!.value = "\(selectedNotificationNumber)\(selectedItem)\(selectedTask)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Operation")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "StatusCode")
        prop!.value = statusClass.StatusCode as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = String.random(length: 16, type: "Number") as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "StatusChangedTime")
        prop!.value = Date().localDate() as NSObject
        self.property.add(prop!)
        
        
        prop = SODataPropertyDefault(name: "PostedBy")
        prop!.value = strUser.uppercased() as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Longitude")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Latitude")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "IsConsidered")
        prop!.value = false as NSObject
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: "ODS_SAP_WM_DLITE_SRV.StatusChangeLog")
        
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
        }
        
        let newTimeSheetEntity : SODataEntity?
        newTimeSheetEntity = entity
        
        StatusChangeLogModel.createStatusChangeLogEntry(entity: newTimeSheetEntity!, collectionPath: "StatusChangeLogSet", flushRequired: false,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                mJCLogger.log("Create Done", Type: "Debug")
                if statusClass.PostTime == "X" {
                    
                    self.getStausChangeLogSet(validStatus:statusClass, isfrom: "Update")
                }
                else {
                    self.vc.getWorkFlowSet(validClass:statusClass, from: "")
                }
                
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.vc.getWorkFlowSet(validClass:statusClass, from: "")
                
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func getLatAndLog(locations: [CLLocation]) {

//        let lastLocation: CLLocation = locations[locations.count - 1]
//        self.Latitude = NSDecimalNumber(value: lastLocation.coordinate.latitude)
//        self.Longitude = NSDecimalNumber(value: lastLocation.coordinate.longitude)
//        userLocation_LatLong = "Location Lat:\(self.Latitude);Long:\(self.Longitude);"

    }

    func UpdateStatusChangeLogSet(logSetClass:StatusChangeLogModel,statusClass:StatusCategoryModel){
        
        mJCLogger.log("Starting", Type: "info")
        (logSetClass.entity.properties["IsConsidered"] as! SODataProperty).value = true as NSObject
        
        StatusChangeLogModel.updateStatusChangeLogEntry(entity: logSetClass.entity, flushRequired: false,options: nil, completionHandler: { (response, error) in
            
            DispatchQueue.main.async {
                
                if(error == nil) {
                    mJCLogger.log("Update Done", Type: "Debug")
                    if statusClass.PostTime == "X" {
                        self.postStatusChangeLogSet(statusClass: statusClass)
                    }
                    else {
                        self.vc.getWorkFlowSet(validClass:statusClass, from: "")
                    }
                }
                else {
                    self.vc.getWorkFlowSet(validClass:statusClass, from: "")
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Parts Value..
    func getPartValue(catalogCode:String, codeGroup:String,code:String){
        mJCLogger.log("Starting", Type: "info")
        let filter = "$filter=(Catalog eq '\(catalogCode)' and CodeGroup eq '\(codeGroup)' and Code eq '\(code)')"
 
        CodeGroupModel.getCatalogCodeList(filterQuery:filter ){ (responseDict, error)  in
            if error == nil{
                
                self.partArray.removeAll()
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")

                    if responseArr.count > 0{
                        self.partArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}
