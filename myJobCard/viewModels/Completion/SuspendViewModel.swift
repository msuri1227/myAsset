//
//  SuspendViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 01/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class SuspendViewModel{
    
    var suspendVc : WorkOrderSuspendVC?
    var completionFeatureListArray : [TabItem] = []
    var noteProperty = NSMutableArray()
    var entityDict = Dictionary<String, Any>()
    var featurelist = [String]()
    var holdReason = String()
    
    func setTabItems() -> [TabItem]{
        if let featureListArr =  orderTypeFeatureDict.value(forKey: singleWorkOrder.OrderType) {
            if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary {
                if let featurelist = featureDict.allKeys as? [String]{
                    self.featurelist = featurelist
                }
            }
        }
        if self.suspendVc?.isFromScreen == "Hold"{
            self.featurelist.append("HOLDREASON")
            if self.suspendVc?.statusCategoryCls.PostTime == "X" && self.suspendVc?.statusCategoryCls.DispTimeSheetString == "X"{
                self.featurelist.append("HOLDTIMESHEET")
            }
            if self.suspendVc?.statusCategoryCls.PostConfirmations == "X" &&  self.suspendVc?.statusCategoryCls.DispTimeSheetString == "X"{
                self.featurelist.append("HOLDCONFIRMATION")
            }
        }else{
            self.featurelist.append("COMPLETIONNOTES")
            if self.suspendVc?.statusCategoryCls.PostTime == "X" && self.suspendVc?.statusCategoryCls.DispTimeSheetString == "X"{
                self.featurelist.append("COMPLETIONTIMESHEET")
            }
            if self.featurelist.contains("SIGNATURE") && ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION == true{
                self.featurelist.append("COMPLETIONSIGNATURE")
            }
            if singleWorkOrder.NotificationNum != "" && EDIT_NO_SCREEN_IN_COMPLETION == true{
                self.featurelist.append("EDITNOTIFICATON")
            }
            if self.suspendVc?.statusCategoryCls.PostConfirmations == "X" &&  self.suspendVc?.statusCategoryCls.DispTimeSheetString == "X"{
                self.featurelist.append("COMPLETIONCONFIRMATION")
            }

        }
        if self.suspendVc?.isFromScreen == "Hold"{
            if self.featurelist.contains("HOLDREASON"){
                let notesTab  = TabItem(title: "Notes".localized(), image: UIImage(named: "notes"))
                completionFeatureListArray.append(notesTab)
            }
            if self.featurelist.contains("HOLDSIGNATURE"){
                let signatureTab  = TabItem(title: "Signature".localized(), image: UIImage(named: "signature"))
                completionFeatureListArray.append(signatureTab)
            }
            if self.featurelist.contains("HOLDTIMESHEET"){
                let timeEntryTab  = TabItem(title: "TimeEntry".localized(), image: UIImage(named: "timesheet"))
                completionFeatureListArray.append(timeEntryTab)
            }
            if self.featurelist.contains("HOLDCONFIRMATION"){
                let conformationTab  = TabItem(title: "Confirmation".localized(), image: UIImage(named: "ic_CheckmarkDone"))
                completionFeatureListArray.append(conformationTab)
            }
        }else{
            if self.featurelist.contains("COMPLETIONNOTES"){
                let notesTab  = TabItem(title: "Notes".localized(), image: UIImage(named: "notes"))
                completionFeatureListArray.append(notesTab)
            }
            if self.featurelist.contains("COMPLETIONSIGNATURE"){
                let signatureTab  = TabItem(title: "Signature".localized(), image: UIImage(named: "signature"))
                completionFeatureListArray.append(signatureTab)
            }
            if self.featurelist.contains("COMPLETIONTIMESHEET"){
                let timeEntryTab  = TabItem(title: "TimeEntry".localized(), image: UIImage(named: "timesheet"))
                completionFeatureListArray.append(timeEntryTab)
            }
            if self.featurelist.contains("EDITNOTIFICATON"){
                let conformationTab  = TabItem(title: "Edit_Notification".localized(), image: UIImage(named: "ic_EditPencil"))
                completionFeatureListArray.append(conformationTab)
            }
            if self.featurelist.contains("COMPLETIONCONFIRMATION"){
                let conformationTab  = TabItem(title: "Confirmation".localized(), image: UIImage(named: "ic_CheckmarkDone"))
                completionFeatureListArray.append(conformationTab)
            }
        }
        return completionFeatureListArray
    }
    func setViewControllers() -> [UIViewController] {
        
        mJCLogger.log("Starting", Type: "info")
        
        var vCArray = [UIViewController]()
        if self.suspendVc?.isFromScreen == "Hold"{
            if self.featurelist.contains("HOLDREASON"){
                let holdVc = ScreenManager.getWorkOrderHoldScreen()
                holdVc.suspendViewModel = self
                holdVc.screenType = "StatusChange"
                vCArray.append(holdVc)
            }
            if self.featurelist.contains("HOLDSIGNATURE"){
                let signatureCaptureVc = ScreenManager.getSignatureCaptureScreen()
                signatureCaptureVc.suspendViewModel = self
                signatureCaptureVc.screenType = "StatusChange"
                vCArray.append(signatureCaptureVc)
            }
            if self.featurelist.contains("HOLDTIMESHEET"){
                let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
                addTimeEntryVC.screenType = "StatusChange"
                addTimeEntryVC.selectedworkOrder = selectedworkOrderNumber
                addTimeEntryVC.statusCategoryCls = self.suspendVc!.statusCategoryCls
                addTimeEntryVC.suspendViewModel = self
                vCArray.append(addTimeEntryVC)
            }
            if self.featurelist.contains("HOLDCONFIRMATION"){
                let confirmationVC = ScreenManager.getCreateFinalConfirmationScreen()
                confirmationVC.screenType = "StatusChange"
                confirmationVC.selectedworkOrder = selectedworkOrderNumber
                confirmationVC.selectedOperation = self.suspendVc!.refNum
                confirmationVC.suspendViewModel = self
                confirmationVC.selectFinalConfimation = false
                vCArray.append(confirmationVC)
            }
        }else{
            if self.featurelist.contains("COMPLETIONNOTES"){
                let notesCaptureVc = ScreenManager.getNotesCaptureScreen()
                notesCaptureVc.suspendViewModel = self
                notesCaptureVc.screenType = "StatusChange"
                vCArray.append(notesCaptureVc)
            }
            if self.featurelist.contains("COMPLETIONSIGNATURE"){
                let signatureCaptureVc = ScreenManager.getSignatureCaptureScreen()
                signatureCaptureVc.suspendViewModel = self
                signatureCaptureVc.screenType = "StatusChange"
                vCArray.append(signatureCaptureVc)
            }
            if self.featurelist.contains("COMPLETIONTIMESHEET"){
                let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
                addTimeEntryVC.screenType = "StatusChange"
                addTimeEntryVC.selectedworkOrder = selectedworkOrderNumber
                addTimeEntryVC.statusCategoryCls = self.suspendVc!.statusCategoryCls
                addTimeEntryVC.suspendViewModel = self
                vCArray.append(addTimeEntryVC)
            }
            if self.featurelist.contains("EDITNOTIFICATON"){
                let itemCauseCompleteVC = ScreenManager.getItemCauseCompleteScreen()
                itemCauseCompleteVC.suspendViewModel = self
                vCArray.append(itemCauseCompleteVC)
            }
            if self.featurelist.contains("COMPLETIONCONFIRMATION"){
                let confirmationVC = ScreenManager.getCreateFinalConfirmationScreen()
                confirmationVC.screenType = "StatusChange"
                confirmationVC.selectedworkOrder = selectedworkOrderNumber
                confirmationVC.selectedOperation = self.suspendVc!.refNum
                confirmationVC.selectFinalConfimation = true
                confirmationVC.suspendViewModel = self
                vCArray.append(confirmationVC)
            }
        }
        return vCArray
    }
    func validateCompletionFeatures(){
        
        if self.suspendVc?.isFromScreen == "Hold"{
            if self.featurelist.contains("HOLDREASON") && self.entityDict["notes"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "Notes".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
            if self.featurelist.contains("HOLDSIGNATURE") && self.entityDict["signature"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "Signature".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
            if self.featurelist.contains("HOLDTIMESHEET") && self.entityDict["timeEntry"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "TimeEntry".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
            if self.featurelist.contains("HOLDCONFIRMATION") && self.entityDict["Confirmation"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "Confirmation".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
        }else{
            if self.featurelist.contains("COMPLETIONNOTES") && self.entityDict["notes"] == nil{
//                let index = self.completionFeatureListArray.firstIndex{$0.title == "Notes".localized()}
//                self.suspendVc!.moveTo(index: index ?? 0)
//                return
            }
            if self.featurelist.contains("COMPLETIONSIGNATURE") && self.entityDict["signature"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "Signature".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
            if self.featurelist.contains("COMPLETIONTIMESHEET") && self.entityDict["timeEntry"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "TimeEntry".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
            if self.featurelist.contains("EDITNOTIFICATON") && self.entityDict["editNotification"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "Edit_Notification".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
            if self.featurelist.contains("COMPLETIONCONFIRMATION") && self.entityDict["Confirmation"] == nil{
                let index = self.completionFeatureListArray.firstIndex{$0.title == "Confirmation".localized()}
                self.suspendVc!.moveTo(index: index ?? 0)
                return
            }
        }
       // if self.entityDict.keys.count == self.completionFeatureListArray.count{
            var newEntityDict = Dictionary<String, Any>()
            if self.entityDict.keys.contains("timeEntry") || self.entityDict.keys.contains("editNotification"){
                for key in self.entityDict.keys{
                    if key == "timeEntry"{
                        if let dict = self.entityDict[key] as? Dictionary<String,Any>{
                            if let arr = dict["entity"] as? NSMutableArray{
                                for i in 0..<arr.count{
                                    var dict1 = Dictionary<String,Any>()
                                    dict1["collectionPath"] = catRecordSet
                                    dict1["entity"] = arr[i]
                                    dict1["type"] = "Create"
                                    newEntityDict["timeEntry\(i)"] = dict1
                                }
                            }
                        }
                    }else if key == "editNotification"{
                        if let arr = self.entityDict[key] as? [Any]{
                            for i in 0..<arr.count{
                                newEntityDict["editNotif\(i)"] = arr[i]
                            }
                        }
                    }else{
                        newEntityDict[key] = self.entityDict[key]
                    }
                }
            }else{
                newEntityDict = self.entityDict
            }
            self.postData(count: 0,entityDict:newEntityDict)
            mJCLoader.startAnimating(status: "Updating".localized())
        //}
    }
    func postData(count:Int,entityDict:Dictionary<String,Any>){
        
        let completedFeatures = Array(entityDict.keys)
        if count == completedFeatures.count{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5" {
                WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: self.holdReason, objStatus: self.suspendVc!.statusCategoryCls.StatusCode,objClass: singleOperation,flushRequired: true)
            }else{
                WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: self.holdReason, objStatus: self.suspendVc!.statusCategoryCls.StatusCode,objClass: singleWorkOrder,flushRequired: true)
            }
        }else{
            let featureStr =  completedFeatures[count]
            if let entityDetails = entityDict[featureStr] as? Dictionary<String,Any>{
                let collectioPath = entityDetails["collectionPath"] as! String
                let entity = entityDetails["entity"] as! SODataEntityDefault
                let type = entityDetails["type"] as? String ?? "Create"
                if type == "Create"{
                    WoHeaderModel.createWorkorderEntity(entity: entity, collectionPath: collectioPath,  flushRequired: false, options: nil){ (response, error) in
                        if(error == nil) {
                            mJCLogger.log("\(collectioPath) Created", Type: "Debug")
                            self.postData(count: count + 1, entityDict: entityDict)
                        }
                        else {
                            self.postData(count: count + 1, entityDict: entityDict)
                            mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                        }
                    }
                }else if type == "Update"{
                    WoHeaderModel.updateWorkorderEntity(entity: entity,flushRequired: false,options: nil){ (response, error) in
                        if(error == nil) {
                            mJCLogger.log("\(collectioPath) Updated", Type: "Debug")
                            self.postData(count: count + 1, entityDict: entityDict)
                        }
                        else {
                            self.postData(count: count + 1, entityDict: entityDict)
                            mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                        }
                    }
                }
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
                        let timeDict = responseArr[0]
                        self.suspendVc?.statusLogset = timeDict
                    }

                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            mJCLogger.log("Ended", Type: "info")
        }
    }
}
