//
//  NotificationItemCausesViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class NotificationItemCausesViewModel {
    
    var vc: NotificationItemCausesVC!
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var selectedTask = String()
    var selectedActivity = String()
    var selectedItemCauses = String()
    var singleActivityArray = [NotificationActivityModel]()
    var singleItemCausesArray = [NotificationItemCauseModel]()
    var singleTaskArray = [NotificationTaskModel]()
    var totalActivityArray = [NotificationActivityModel]()
    var totalItemArray = [NotificationItemCauseModel]()
    var totalTaskArray = [NotificationTaskModel]()
    var activityClass = NotificationActivityModel()
    var taskClass = NotificationTaskModel()
    var causeClass = NotificationItemCauseModel()
    var property = NSMutableArray()
    var partArray = Array<CodeGroupModel>()

    
    //Get Single Item Causes..
    func getSingleItemCausesData() {
        mJCLogger.log("Starting", Type: "info")
        if isSingleNotification == true {
            NotificationItemCauseModel.getWoNoItemCauseDetails(notifNum: "\(selectedNotificationNumber)", itemNum: "\(String(describing: selectedItem))", itemCauseNum: "\(selectedItemCauses)"){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.singleItemCausesArray = responseArr
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCauseCount = 0
                    }
                    DispatchQueue.main.async {
                        self.vc?.getSingleItemCausesDataUI()
                        self.vc?.getNotificationItemsCausesDataUI()
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        else {
            NotificationItemCauseModel.getNotificationItemCauseDetails(notifNum: "\(selectedNotificationNumber)", itemNum: "\(String(describing: selectedItem))", itemCauseNum: "\(selectedItemCauses)") { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.singleItemCausesArray = responseArr
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCauseCount = 0
                    }
                    
                    DispatchQueue.main.async {
                        self.vc?.getSingleItemCausesDataUI()
                        self.vc?.getNotificationItemsCausesDataUI()
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Notification Activity list..
    func getNotificationActivityData() {
        mJCLogger.log("Starting", Type: "info")
        var itemNum = String()
        if vc!.isFromScreen == "ItemActivity"{
            itemNum = selectedItem ?? ""
        }else{
            itemNum = "0000"
        }
        let defReq = "$filter=(Notification%20eq%20%27\(selectedNotificationNumber)%27 and Item eq '\(itemNum)')&$orderby=Activity"
        
        if isSingleNotification == true {
            
            NotificationActivityModel.getWoNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: itemNum, filterQuery: defReq) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            DispatchQueue.main.async {
                                self.singleActivityArray = responseArr
                                self.totalActivityArray = responseArr
                                for i in 0..<self.totalActivityArray.count {
                                    let activityObj = self.totalActivityArray[i]
                                    activityObj.isSelected = false
                                }
                                if selectedItemActivity != "" {
                                    for i in 0..<self.totalActivityArray.count {
                                        let activityObj = self.totalActivityArray[i]
                                        if selectedItemActivity == activityObj.Activity {
                                            self.selectedActivity = activityObj.Activity
                                            self.did_DeSelectedCell = i
                                            activityObj.isSelected = true
                                            break
                                        }
                                        else {
//                                            let activityObj = self.totalActivityArray[0]
//                                            self.selectedActivity = activityObj.Activity
//                                            activityObj.isSelected = true
                                        }
                                    }
                                }
                                else {
                                    if self.totalActivityArray.count > 0 {
                                        let activityObj = self.totalActivityArray[0]
                                        self.selectedActivity = activityObj.Activity
                                        self.did_DeSelectedCell = 0
                                        activityObj.isSelected = true
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.getSingleActivityData()
                                }
                            }
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getNotificationActivityDataUI()
                            }
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
        else {
            NotificationActivityModel.getNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: itemNum, filterQuery: defReq) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            DispatchQueue.main.async {
                                self.singleActivityArray = responseArr
                                self.totalActivityArray = responseArr
                                for i in 0..<self.totalActivityArray.count {
                                    let activityObj = self.totalActivityArray[i]
                                    activityObj.isSelected = false
                                }
                                if selectedItemActivity != "" {
                                    for i in 0..<self.totalActivityArray.count {
                                        let activityObj = self.totalActivityArray[i]
                                        if selectedItemActivity == activityObj.Activity {
                                            self.selectedActivity = activityObj.Activity
                                            self.did_DeSelectedCell = i
                                            activityObj.isSelected = true
                                            break
                                        }
                                        else {
//                                            let activityObj = self.totalActivityArray[0]
//                                            self.selectedActivity = activityObj.Activity
//                                            activityObj.isSelected = true
                                        }
                                    }
                                }
                                else {
                                    if self.totalActivityArray.count > 0 {
                                        let activityObj = self.totalActivityArray[0]
                                        self.selectedActivity = activityObj.Activity
                                        self.did_DeSelectedCell = 0
                                        activityObj.isSelected = true
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.getSingleActivityData()
                                }
                            }
                        }
                        else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getNotificationActivityDataUI()
                            }
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async {
                            self.vc?.getNotificationActivityDataUI()
                        }
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    

    //Get Notification Activity list..
    func getSingleActivityData() {
        
        mJCLogger.log("Starting", Type: "info")
        var itemNum = String()
        if vc?.isFromScreen == "ItemActivity"{
            itemNum = selectedItem ?? ""
        }else{
            itemNum = "0000"
        }
        if vc!.notificationFrom == "FromWorkorder"{
            NotificationActivityModel.getWoNoItemActivityDetails(notifNum: selectedNotificationNumber, itemNum: itemNum, activityNum: selectedActivity, filterQuery: "") {   (responseDict, error)  in
                if error == nil{
                    self.singleActivityArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.singleActivityArray = responseArr
                            self.activityClass = self.singleActivityArray[0]
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc?.getSingleActivityDataUI()
                            self.vc?.getNotificationActivityDataUI()
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationActivityModel.getNoItemActivityDetails(notifNum: selectedNotificationNumber, itemNum: itemNum, activityNum: selectedActivity){ (responseDict, error)  in
                if error == nil{
                    self.singleActivityArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.singleActivityArray = responseArr
                            self.activityClass = self.singleActivityArray[0]

                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc?.getSingleActivityDataUI()
                            self.vc?.getNotificationActivityDataUI()
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
    
    //MARK:- Get Notification Items list..
    func getNotificationTasksData() {
        mJCLogger.log("Starting", Type: "info")

        var itemNum = String()
        if vc!.isFromScreen == "ItemTask"{
            itemNum =  selectedItem ?? ""
        }else{
            itemNum = "0000"
        }
        
        if isSingleNotification == true {
            NotificationTaskModel.getWoNoItemTaskList(notifNum: selectedNotificationNumber, itemNum: itemNum, filterQuery: "") { (responseDict, error)  in
                if error == nil{
                    self.totalTaskArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalTaskArray = responseArr
                        if(self.totalTaskArray.count > 0) {
                            for i in 0..<self.totalTaskArray.count {
                                let taskObj = self.totalTaskArray[i]
                                taskObj.isSelected = false
                            }
                            if selectedItemTask != "" {
                                for i in 0..<self.totalTaskArray.count {
                                    let taskObj = self.totalTaskArray[i]
                                    if selectedItemTask == taskObj.Task {
                                        self.selectedTask = taskObj.Task
                                        self.did_DeSelectedCell = i
                                        taskObj.isSelected = true
                                        break
                                    }
//                                    else {
//                                        let taskObj = self.totalTaskArray[0]
//                                        self.selectedTask = taskObj.Task
//                                        taskObj.isSelected = true
//                                    }
                                }
                            }
                            else {
                                if self.totalTaskArray.count > 0 {
                                    let taskObj = self.totalTaskArray[0]
                                    self.selectedTask = taskObj.Task
                                    self.did_DeSelectedCell = 0
                                    taskObj.isSelected = true
                                }
                            }
                            DispatchQueue.main.async {
                                if self.totalTaskArray.count > 0 {
                                    self.getSingleTaskData()
                                }
                            }
                        }
                        else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getNotificationTasksDataUI()
                            }
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async {
                            self.vc?.getNotificationTasksDataUI()
                        }
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        else {
            NotificationTaskModel.getNoItemTaskList(notifNum: selectedNotificationNumber, itemNum: itemNum, filterQuery: "") { (responseDict, error)  in
                if error == nil{
                    self.totalTaskArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalTaskArray = responseArr
                        if(self.totalTaskArray.count > 0) {
                            for i in 0..<self.totalTaskArray.count {
                                let taskObj = self.totalTaskArray[i]
                                taskObj.isSelected = false
                            }
                            if selectedItemTask != "" {
                                for i in 0..<self.totalTaskArray.count {
                                    let taskObj = self.totalTaskArray[i]
                                    if selectedItemTask == taskObj.Task {
                                        self.selectedTask = taskObj.Task
                                        self.did_DeSelectedCell = i
                                        taskObj.isSelected = true
                                        break
                                    }
                                    else {
//                                        let taskObj = self.totalTaskArray[0]
//                                        self.selectedTask = taskObj.Task
//                                        taskObj.isSelected = true
                                    }
                                }
                            }
                            else {
                                if self.totalTaskArray.count > 0 {
                                    let taskObj = self.totalTaskArray[0]
                                    self.selectedTask = taskObj.Task
                                    self.did_DeSelectedCell = 0
                                    taskObj.isSelected = true
                                }
                            }
                            DispatchQueue.main.async {
                                if self.totalTaskArray.count > 0 {
                                    self.getSingleTaskData()
                                }
                            }
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getNotificationTasksDataUI()
                            }
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async {
                            self.vc?.getNotificationTasksDataUI()
                        }
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    //Get Single Item Data..
    func getSingleTaskData() {
        mJCLogger.log("Starting", Type: "info")
       
        if vc!.notificationFrom == "FromWorkorder"{
            
            NotificationTaskModel.getWoNoItemTaskDetails(notifNum: selectedNotificationNumber, itemNum: selectedItem, taskNum: selectedTask) { (responseDict, error)  in
                if error == nil{
                    self.singleTaskArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.singleTaskArray = responseArr
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc?.getNotificationTasksDataUI()
                            self.vc?.getSingleTaskDataUI()
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationTaskModel.getNoItemTaskDetails(notifNum: selectedNotificationNumber, itemNum: selectedItem, taskNum: selectedTask){
                (responseDict, error)  in
                if error == nil{
                    self.singleTaskArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.singleTaskArray = responseArr
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc?.getNotificationTasksDataUI()
                            self.vc?.getSingleTaskDataUI()
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
    
    //MARK:- Get Items Causes Data..
    func getNotificationItemsCausesData() {
        mJCLogger.log("Starting", Type: "info")
        if isSingleNotification == true {
           
            NotificationItemCauseModel.getWoNoItemCauseList(notifNum: selectedNotificationNumber, itemNum: selectedItem) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        
                        if(self.totalItemArray.count > 0) {
                            
                            for i in 0..<self.totalItemArray.count {
                                let causesObj = self.totalItemArray[i]
                                causesObj.isSelected = false
                            }
                            if selectedItemCause != "" {
                                for i in 0..<self.totalItemArray.count {
                                    let causesObj = self.totalItemArray[i]
                                    if selectedItemCause == causesObj.Cause {
                                        self.selectedItemCauses = causesObj.Cause
                                        self.did_DeSelectedCell = i
                                        causesObj.isSelected = true
                                        break
                                    }else {
//                                        let causesObj = self.totalItemArray[0]
//                                        self.selectedItemCauses = causesObj.Cause
//                                        causesObj.isSelected = true
                                    }
                                }
                            }
                            else {
                                if self.totalItemArray.count > 0 {
                                    let causesObj = self.totalItemArray[0]
                                    self.selectedItemCauses = causesObj.Cause
                                    self.did_DeSelectedCell = 0
                                    causesObj.isSelected = true
                                }
                            }
                            if self.totalItemArray.count > 0 {
                                self.causeClass = self.totalItemArray[0]
                                self.getSingleItemCausesData()
                            }
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getNotificationItemsCausesDataUI()
                            }
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else {
            NotificationItemCauseModel.getNotificationItemCauseList(notifNum: selectedNotificationNumber, itemNum: selectedItem) {  (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        
                        if(self.totalItemArray.count > 0) {
                            for i in 0..<self.totalItemArray.count {
                                let causesObj = self.totalItemArray[i]
                                causesObj.isSelected = false
                            }
                            if selectedItemCause != "" {
                                for i in 0..<self.totalItemArray.count {
                                    let causesObj = self.totalItemArray[i]
                                    if selectedItemCause == causesObj.Cause {
                                        self.selectedItemCauses = causesObj.Cause
                                        self.did_DeSelectedCell = i
                                        causesObj.isSelected = true
                                        break
                                    }else {
//                                        let causesObj = self.totalItemArray[0]
//                                        self.selectedItemCauses = causesObj.Cause
//                                        causesObj.isSelected = true
                                    }
                                }
                            }
                            else {
                                let causesObj = self.totalItemArray[0]
                                self.selectedItemCauses = causesObj.Cause
                                self.did_DeSelectedCell = 0
                                causesObj.isSelected = true
                            }
                            self.causeClass = self.totalItemArray[0]
                            self.getSingleItemCausesData()
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getNotificationItemsCausesDataUI()
                            }
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
                    if responseArr.count == 0 {
                        self.postStatusChangeLogSet(statusClass: validStatus)
                    }else{
                        if responseArr.count > 0 {
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
                    }else {
                        self.vc.getWorkFlowSet(validClass:statusClass, from: "")
                    }
                }else {
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

