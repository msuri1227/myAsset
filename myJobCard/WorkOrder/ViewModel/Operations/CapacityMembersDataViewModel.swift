//
//  CapacityMembersDataViewModel.swift
//  myJobCard
//
//  Created by Navdeep Singla on 31/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class CapacityMembersDataViewModel {
    
    var capacityVC: CapacityAssignmentVC?
    var capacityMembersListArray = [WoCapacityModel]()
    var property = NSMutableArray()
    
    func getCapacityMembersData() {
        mJCLogger.log("Starting", Type: "info")
        
        let  defineQuery = "$filter=(EnteredBy%20eq%20%27" + (userSystemID) + "%27 and WoNum eq '\(singleOperation.WorkOrderNum)' and Operation eq '\(singleOperation.OperationNum)')"
        WoCapacityModel.getWoOperationCapacityData(filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoCapacityModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.capacityMembersListArray = responseArr
                    self.capacityVC?.updateUICapacityMembersData()
                    DispatchQueue.main.async {
                        self.capacityVC!.totalTechniciansCountLabel.text = "Total_Technicians_Assigned".localized() +  " : " + "\(self.capacityMembersListArray.count)"
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
    func addNewCapacityMemberData(){
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "CapRecordId")
        prop!.value = String.random(length: 12, type: "Number") as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "IntCounter")
        prop!.value = singleOperation.InternalCounter as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CapReqCnt")
        let count = self.capacityMembersListArray.count+1
        let confCounter = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\(count)")
        prop!.value = confCounter as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WoNum")
        prop!.value = singleOperation.WorkOrderNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OprRoutNo")
        prop!.value = singleOperation.PlannofOpera as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OprCounter")
        prop!.value = singleOperation.Counter as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Operation")
        prop!.value = singleOperation.OperationNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "RemSplitInd")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CapacityId")
        prop!.value = "00000000" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "NoOfSplits")
        prop!.value = NSDecimalNumber(value: self.capacityMembersListArray.count)
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = self.capacityVC!.selectedPersonalRespName as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SplitNo")
        prop!.value = self.capacityMembersListArray.count+1 as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Work")
        prop!.value = NSDecimalNumber(string: self.capacityVC!.normalDurationTextField.text)
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkUOM")
        prop!.value = "HR" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "NormalDuration")
        prop!.value = NSDecimalNumber(string: self.capacityVC!.normalDurationTextField.text)
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "NormalDurationUnit")
        prop!.value = "HR" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "StartDate")
        let startDate = ODSDateHelper.getDateFromString(dateString: (capacityVC?.startDateTextField.text!)!, dateFormat: localDateFormate).localDate()
        prop!.value = startDate as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "StartTime")
        let starttime = SODataDuration()
        let starttimeArray = capacityVC?.startTimeTextField.text!.components(separatedBy:":")
        starttime.hours = Int(starttimeArray![0])! as NSNumber
        starttime.minutes = Int(starttimeArray![1])! as NSNumber
        starttime.seconds = 0
        prop!.value = starttime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EndDate")
        let endDatestr = Date().localDate()
        prop!.value = endDatestr as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EndTime")
        let endbasicTime = SODataDuration()
        let endTime = Date().toString(format: .custom("HH:mm"))
        let endBasicTimeArray = endTime.components(separatedBy:":")
        endbasicTime.hours = Int(endBasicTimeArray[0]) as NSNumber?
        endbasicTime.minutes = Int(endBasicTimeArray[1]) as NSNumber?
        endbasicTime.seconds = 0
        prop!.value = endbasicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Action")
        prop!.value = "CREATE" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userSystemID as NSObject
        self.property.add(prop!)
        
        let CapacityMemberHeaderSet_Entity = "\(createEntityBase_TxS)WoCapacity"
        
        print("====== Add Capacity Member Key Value Start ======")
        let entity = SODataEntityDefault(type: CapacityMemberHeaderSet_Entity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        print("====== Create Capacity Member Key Value End ======")
        WoCapacityModel.createWoOperationCapacityMemberEntity(entity: entity!, collectionPath: "WoCapacitySet", flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                DispatchQueue.main.async {
                    print("New Member Added Successfully")
                    mJCLoader.stopAnimating()
                    self.capacityVC!.addMemberBgView.isHidden = true
                    self.getCapacityMembersData()
                }
            }else {
                DispatchQueue.main.async {
                    mJCLoader.stopAnimating()
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    mJCAlertHelper.showAlert(self.capacityVC!, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
                }
            }
        })
    }
    func updateCapacityMemberData(tagValue: Int) {
        if self.capacityMembersListArray.count != 0 {
            let indexPath = IndexPath(row: tagValue, section: 0)
            let cell = capacityVC?.capacityMemberDataTableview.cellForRow(at: indexPath) as! CapacityTableViewCell
            let capacityClass = self.capacityMembersListArray[tagValue]
            cell.normalDurationTextField.text = cell.workDurationTextField.text
            if capacityClass.StartDate != nil {
                if cell.workDurationTextField.text == "\(capacityClass.Work)" && cell.startDateTextField.text == capacityClass.StartDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current) && cell.startTimeTextField.text == ODSDateHelper.getTimeFromSODataDuration(dataDuration: capacityClass.StartTime) {
                    mJCAlertHelper.showAlert(self.capacityVC!, title: alerttitle, message: "Please_Update_Atleast_One_Value_To_Update_The_Capacity".localized(), button: okay)
                    return
                }
            }else {
                mJCAlertHelper.showAlert(self.capacityVC!, title: alerttitle, message: "Please_Select_Start_Date".localized() , button: okay)
                return
            }
            (capacityClass.entity.properties["Work"] as! SODataProperty).value = NSDecimalNumber(string: cell.workDurationTextField.text)
            (capacityClass.entity.properties["WorkUOM"] as! SODataProperty).value = capacityClass.WorkUOM as NSObject
            (capacityClass.entity.properties["NormalDuration"] as! SODataProperty).value = NSDecimalNumber(string: cell.normalDurationTextField.text)
            (capacityClass.entity.properties["NormalDurationUnit"] as! SODataProperty).value = capacityClass.NormalDurationUnit as NSObject
            let startDate = ODSDateHelper.getDateFromString(dateString: (cell.startDateTextField.text)!, dateFormat: localDateFormate).localDate()
            (capacityClass.entity.properties["StartDate"] as! SODataProperty).value = startDate as NSObject
            let startTime = SODataDuration()
            let startTimeArray = cell.startTimeTextField.text?.components(separatedBy: ":")
            startTime.hours = Int(startTimeArray![0]) as NSNumber?
            startTime.minutes = Int(startTimeArray![1]) as NSNumber?
            startTime.seconds = 0
            (capacityClass.entity.properties["StartTime"] as! SODataProperty).value = startTime
            capacityClass.StartTime = startTime
            (capacityClass.entity.properties["Action"] as! SODataProperty).value = "UPDATE" as NSObject
            (capacityClass.entity.properties["EnteredBy"] as! SODataProperty).value = capacityClass.EnteredBy as NSObject
            WoCapacityModel.updateWoOperationCapacityMemberEntity(entity: capacityClass.entity,  flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    print("Capacity Updated successfully")
                    self.getCapacityMembersData()
                    mJCLogger.log("Capacity Updated successfully".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(self.capacityVC!, title: alerttitle, message: "Capacity Updated Successfully", button: okay)
                }else {
                    mJCLogger.log("Fail_to_update_item_try_again".localized(), Type: "Error")
                    mJCAlertHelper.showAlert(self.capacityVC!, title: alerttitle, message: "Fail_to_update_item_try_again".localized(), button: okay)
                }
            })
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func deleteCapacityMember(tag:Int)  {
        mJCLogger.log("Starting", Type: "info")
        if self.capacityMembersListArray.count != 0{
            let capacityClass = self.capacityMembersListArray[tag]
            var entity = SODataEntityDefault()
            entity = capacityClass.entity
            (entity.properties["Action"] as! SODataProperty).value = "DELETE" as NSObject
            WoCapacityModel.deleteWoOperationCapacityMemberEntity(entity: entity, options: nil, completionHandler: { (response, error) in
                if error == nil {
                    self.getCapacityMembersData()
                    mJCLogger.log("Record deleted successfully!", Type: "Debug")
                }
                else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
