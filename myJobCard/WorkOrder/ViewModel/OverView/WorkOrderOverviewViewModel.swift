//
//  WorkOrderOverviewViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib

class WorkOrderOverviewViewModel {
    
    weak var vcOverview: WorkOrderOverViewVC?
    var notificationListArr = [NotificationModel]()
    var AllowedFollOnObjTypArray = [AllowedFollowOnObjectTypeModel]()
    var singleWorkOrderArray = [WoHeaderModel]()
    var personResponsibleArray = [PersonResponseModel]()
    var InspLotArray = InspectionLotModel()
    var overViewEquipmentArray = [EquipmentModel]()
    var overViewFunctionalLocationArray = [FunctionalLocationModel]()
    var gotoArray = NSMutableArray()
    var isTranformHidden = true
    
    func getWororderDetails(){
        if vcOverview?.isfromsup == "Supervisor"{
            WoHeaderModel.getSuperVisorWorkorderDetailsWith(workOrderNo: singleWorkOrder.WorkOrderNum){
                (response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [WoHeaderModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0 {
                            self.vcOverview?.selectedWorkorder = responseArr[0]
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.vcOverview?.updateUI()
            }
        }else{
            WoHeaderModel.getWorkorderDetailsWith(workOrderNo: singleWorkOrder.WorkOrderNum){
                (response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [WoHeaderModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0 {
                            self.vcOverview?.selectedWorkorder = responseArr[0]
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.vcOverview?.updateUI()
            }
        }

    }
    func getNotificationList() {
        mJCLogger.log("Starting", Type: "info")
        NotificationModel.getWoNotificationDetailsWith(NotifNum: singleWorkOrder.NotificationNum) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [NotificationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        singleNotification = responseArr[0]
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
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
    
    func getAllowedFollowOnObjectType() {
        mJCLogger.log("Starting", Type: "info")
        AllowedFollowOnObjectTypeModel.getAllowedFollowOnObjectTypeList(objectType: singleWorkOrder.OrderType, roleId: Role_ID){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [AllowedFollowOnObjectTypeModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    
                    self.AllowedFollOnObjTypArray = responseArr
                    
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getSingleWOArray() {
        mJCLogger.log("Response :\(singleWorkOrder)", Type: "Debug")
        self.singleWorkOrderArray.append(singleWorkOrder)
    }
    func getPersonResponsibleList() {
        self.personResponsibleArray.removeAll()
        mJCLogger.log("Response :\(globalPersonRespArray.count)", Type: "Debug")
        if globalPersonRespArray.count > 0 {
            self.personResponsibleArray.append(contentsOf: globalPersonRespArray)
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
    }
    func deleteWorkOrderFromList() {
        mJCLogger.log("Starting", Type: "info")
        if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleWorkOrder.entity) == true{
            WoHeaderModel.deleteWorkorderEntity(entity: singleWorkOrder.entity, options: nil, completionHandler: { (response, error) in
                if error == nil {
                    print("\(singleWorkOrder.WorkOrderNum) record deleted : Done")
                    mJCLogger.log("\(singleWorkOrder.WorkOrderNum) record deleted : Done", Type: "Debug")
                    self.vcOverview?.updateUIDeleteWorkOrderFromList()
                }else {
                    print("\(singleWorkOrder.WorkOrderNum) record deleted : Fail!")
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }else {
            mJCAlertHelper.showAlert(self.vcOverview!, title: alerttitle, message: "You_cannot_mark_this_workorder_as_deleted".localized(), button: okay)
            mJCLogger.log("You_cannot_mark_this_workorder_as_deleted".localized(), Type: "Warn")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getInspectionLotInfo() {
        mJCLogger.log("Starting", Type: "info")
        let inspectionLot = singleWorkOrder.InspectionLot
        if inspectionLot == "000000000000" || inspectionLot == ""{
            mJCAlertHelper.showAlert(self.vcOverview!, title: MessageTitle, message: "Inspection_Lot_Not_Available".localized(), button: okay)
            return
        }
        InspectionLotModel.getInspLotDetails(inspLotNum: inspectionLot) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [InspectionLotModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        mJCLogger.log("response success", Type: "Debug")
                        self.InspLotArray = responseArr[0]
//                        self.vcOverview?.updateInspectionLotInfoUI()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
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
    func overviewAssetEquipmentServiceCall(equipmentNo: String) {
        mJCLogger.log("Starting", Type: "info")
        self.vcOverview?.updateUIAssetEquipmentButton(equipNo: equipmentNo)
        mJCLogger.log("Ended", Type: "info")
    }
    func overviewAssetFunctionLocationServiceCall(title: String) {
        mJCLogger.log("Starting", Type: "info")
        self.vcOverview?.updateUIAssetFunctionLocationButton(funcLocNo: title)
        mJCLogger.log("Ended", Type: "info")
    }
}

