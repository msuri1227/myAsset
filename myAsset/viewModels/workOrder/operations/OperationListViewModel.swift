//
//  OperationListViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OperationListViewModel {
    
    var vc: OperationListVC?
    var isfromsup = String()
    var totalOprationArray = [WoOperationModel]()
    var selectedOperationArray = NSMutableArray()
    var confirmOperationList = [String]()
    
    func getOperationsData() {
        mJCLogger.log("Starting", Type: "info")
        if isfromsup == "Supervisor"{
            self.getSuperVOprData()
        }else{
            self.getOprData()
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    func getOprData() {
        mJCLogger.log("Starting", Type: "info")
        let  defineQuery = "$filter=(WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and startswith(SystemStatus, 'DLT') ne true)&$orderby=OperationNum"
        
        WoOperationModel.getOperationList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        DispatchQueue.main.async {
                            self.vc?.noDataLabel.isHidden = true
                            self.vc?.noDataLabel.text = ""
                            self.totalOprationArray = responseArr
                            self.vc?.totalOprationArray = responseArr
                            if selectedOperationNumber != "" {
                                for i in 0..<self.totalOprationArray.count {
                                    let ope = self.totalOprationArray[i]
                                    let operationNumber = ope.OperationNum
                                    if operationNumber == selectedOperationNumber {
                                        self.vc?.singleOperationArray.append(self.totalOprationArray[i])
                                        operationTableCountSelectedCell = i
                                        singleOperation = self.totalOprationArray[i]
                                        selectedOperationNumber = singleOperation.OperationNum
                                        break
                                    }else {
                                        if self.totalOprationArray.count > 0 {
                                            self.vc?.singleOperationArray.append(self.totalOprationArray[0])
                                            operationTableCountSelectedCell = 0
                                            singleOperation = self.totalOprationArray[0]
                                            selectedOperationNumber = singleOperation.OperationNum
                                        }
                                    }
                                }
                            }else {
                                if self.totalOprationArray.count > 0 {
                                    self.vc?.singleOperationArray.append(self.totalOprationArray[0])
                                    operationTableCountSelectedCell = 0
                                    singleOperation = self.totalOprationArray[0]
                                    selectedOperationNumber = singleOperation.OperationNum
                                }
                            }
                            for item in self.totalOprationArray{
                                if self.confirmOperationList.contains(item.OperationNum){
                                    item.isCompleted = true
                                }
                            }
                            self.vc?.totalOprCountLabel.text = "Total_Operations".localized() + ": \(self.totalOprationArray.count)"
                            self.vc?.operationListTable.reloadData()
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async {
                            self.vc?.totalOprCountLabel.text = "Total_Operations".localized() + " : 0"
                            self.vc?.noDataLabel.isHidden = false
                            self.vc?.noDataLabel.text = "No_Data_Available".localized()
                        }
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSuperVOprData() {
        mJCLogger.log("Starting", Type: "info")
        WoOperationModel.getSuperVisorWorkOrderOperationsWithWONum(workOrderNo: selectedworkOrderNumber) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        DispatchQueue.main.async {
                            self.vc?.noDataLabel.isHidden = true
                            self.vc?.noDataLabel.text = ""
                            self.totalOprationArray = responseArr
                            self.vc?.totalOprationArray = responseArr
                            if selectedOperationNumber != "" {
                                for i in 0..<self.totalOprationArray.count {
                                    let ope = self.totalOprationArray[i]
                                    let operationNumber = ope.OperationNum
                                    if operationNumber == selectedOperationNumber {
                                        self.vc?.singleOperationArray.append(self.totalOprationArray[i])
                                        operationTableCountSelectedCell = i
                                        singleOperation = self.totalOprationArray[i]
                                        selectedOperationNumber = singleOperation.OperationNum
                                        break
                                    }else {
                                        if self.totalOprationArray.count > 0 {
                                            self.vc?.singleOperationArray.append(self.totalOprationArray[0])
                                            operationTableCountSelectedCell = 0
                                            singleOperation = self.totalOprationArray[0]
                                            selectedOperationNumber = singleOperation.OperationNum
                                        }
                                    }
                                }
                            }else {
                                if self.totalOprationArray.count > 0 {
                                    self.vc?.singleOperationArray.append(self.totalOprationArray[0])
                                    operationTableCountSelectedCell = 0
                                    singleOperation = self.totalOprationArray[0]
                                    selectedOperationNumber = singleOperation.OperationNum
                                }
                            }
                            for item in self.totalOprationArray{
                                if self.confirmOperationList.contains(item.OperationNum){
                                    item.isCompleted = true
                                }
                            }
                            self.vc?.totalOprCountLabel.text = "Total_Operations".localized() + ": \(self.totalOprationArray.count)"
                            self.vc?.operationListTable.reloadData()
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.async {
                            self.vc?.totalOprCountLabel.text = "Total_Operations".localized() + " : 0"
                            self.vc?.noDataLabel.isHidden = false
                            self.vc?.noDataLabel.text = "No_Data_Available".localized()
                        }
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getConfirmOprList() {
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
        
        WoOperationModel.getWoConfirmationSet(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        var arr = [String]()
                        for item in responseArr{
                            arr.append(item.OperationNum)
                        }
                        self.confirmOperationList = ["\(responseArr)"]
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.getOperationsData()
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    func completeBulkOperationMethod(count:Int){
        mJCLogger.log("Starting", Type: "info")
        let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
        if self.selectedOperationArray.count > 0{
            let singleOperationClass = self.selectedOperationArray[count] as! WoOperationModel
            (singleOperationClass.entity.properties["SystemStatus"] as! SODataProperty).value = mobStatusCode as NSObject
            WoOperationModel.updateOperationEntity(entity: singleOperationClass.entity,flushRequired: false, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Update Done", Type: "Debug")
                    singleOperationClass.isCompleted = true
                    print("\(singleOperationClass.OperationNum) Confirmed")
                    mJCLogger.log("\(singleOperationClass.OperationNum) Confirmed", Type: "Debug")
                    self.postOperationConfirmation(singleOperationClass: singleOperationClass, Count: count)
                }else {
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Fail_to_update_operation_try_again".localized(), button: okay)
                }
            })
        }else{
            mJCLogger.log("Please_Select_Atleast_One_operation_to_complete".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Please_Select_Atleast_One_operation_to_complete".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Complete Operation Method..
    
    func postOperationConfirmation(singleOperationClass: WoOperationModel,Count:Int) {
        
        mJCLogger.log("Starting", Type: "info")
        let singleOperationClass = singleOperationClass
        
        let property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfCounter")
        
        let count = self.confirmOperationList.count+1
        let confCounter = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 8, Num: "\(count)")
        prop!.value = confCounter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = singleOperationClass.OperationNum as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOper")
        prop!.value = singleOperationClass.SubOperation as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Split")
        prop!.value = 0 as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PostgDate")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedDate")
        prop!.value = NSDate()
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        let basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = singleOperationClass.Plant as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkCntr")
        prop!.value = singleOperationClass.WorkCenter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FinConf")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Complete")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfText")
        prop!.value = OPERATION_COMPLETE_TEXT as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        
        var flushRequired = false
        if self.selectedOperationArray.count == Count + 1{
            flushRequired = true
        }else{
            flushRequired = false
        }
        WoOperationModel.createWoConfirmationEntity(entity: entity!, collectionPath: woConfirmationSet,flushRequired: flushRequired, options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                
                mJCLogger.log("Complete Done", Type: "Debug")
                
                mJCLogger.log("\(singleOperationClass.OperationNum) Confirmation Posted".localized(), Type: "Debug")
                singleOperationClass.isCompleted = true
                self.confirmOperationList.append(singleOperationClass.OperationNum)
                if self.selectedOperationArray.count == Count + 1 {
                    self.getConfirmationOpeartionSet()
                    self.selectedOperationArray.removeAllObjects()
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Operations_Completed_Sucessfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self.vc!, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            self.vc?.SelectionAllOperationCheck.isSelected = false
                        default: break
                        }
                    }
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                    isOperationDone = true
                }else{
                    self.completeBulkOperationMethod(count:Count + 1)
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Complete Operation Method
    
    func postOperationConfirmation() {
        
        mJCLogger.log("Starting", Type: "info")
        
        let singleOperationClass = self.vc?.singleOperationArray[0]
        let property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfCounter")
        
        let count = self.confirmOperationList.count+1
        var confCounter = String()
        
        confCounter = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 8, Num: "\(count)")
        
        prop!.value = confCounter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = singleOperation.OperationNum as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOper")
        prop!.value = singleOperation.SubOperation as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Split")
        prop!.value = 0 as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PostgDate")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedDate")
        prop!.value = NSDate()
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        let basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = singleOperationClass!.Plant as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkCntr")
        prop!.value = singleOperationClass!.WorkCenter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FinConf")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Complete")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfText")
        prop!.value = OPERATION_COMPLETE_TEXT as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        
        WoOperationModel.createWoConfirmationEntity(entity: entity!, collectionPath: woConfirmationSet,flushRequired: true, options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                mJCLogger.log("Confirmation Done", Type: "Debug")
                let operationClass = self.totalOprationArray[self.vc?.did_DeSelectedCell ?? 0]
                operationClass.isCompleted = true
                singleOperationClass?.isCompleted = true
                self.getConfirmationOpeartionSet()
                self.vc?.operationListTable.reloadData()
                
                if DeviceType == iPad{
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                }else{
                    self.vc?.dismiss(animated: false, completion: nil)
                }
            }
            else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Get Confirmation Operation Set..
    func getConfirmationOpeartionSet() {
        mJCLogger.log("Starting", Type: "info")
        if isfromsup == "Supervisor"{
            self.getOperationsData()
        }else{
            self.getConfirmOprList()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
