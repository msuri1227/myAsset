//
//  WorkOrderObjectsViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class WorkOrderObjectsViewModel {
    weak var vc: ObjectsVC?
    weak var delegate:viewModelDelegate?
    var objectListArray = [WorkorderObjectModel]()
    var equipmentArr = [ZEquipmentModel]()
    
    func getObjectlist() {
        mJCLogger.log("Starting", Type: "info")
        let query = "$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)' and Equipment ne '')"
        WorkorderObjectModel.getWorkOrderObjects(filterQuery: query){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WorkorderObjectModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    objectCount = "\(responseArr.count)"
                    self.objectListArray = responseArr
                    self.delegate?.dataFetchCompleted?(type: "assetList", object: [])
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateVerifyWorkOrder(list:[WorkorderObjectModel], status:String, count:Int){
        if count == list.count{
            self.delegate?.dataFetchCompleted?(type: "VerifyWriteOffCompleted", object: [])
        }else{
            let equipment = list[count]
            (equipment.entity.properties["ProcessIndic"] as! SODataProperty).value = "\(status)" as NSObject
            WoHeaderModel.updateWorkorderEntity(entity: equipment.entity,  flushRequired: false, options: nil){(response, error) in
                if(error == nil) {
                    self.updateVerifyWorkOrder(list: list, status: status, count: count + 1)
                }else {
                    self.updateVerifyWorkOrder(list: list, status: status, count: count + 1)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func updateWriteOffWorkOder(list:[WorkorderObjectModel], status:String, notes:String, count:Int){
        if count == list.count{
            self.delegate?.dataFetchCompleted?(type: "VerifyWriteOffCompleted", object: [])
        }else{
            let equipment = list[count]
            (equipment.entity.properties["ProcessIndic"] as! SODataProperty).value = "\(status)" as NSObject
//            (equipment.entity.properties["InspectionNotes"] as! SODataProperty).value = "\(notes)" as NSObject
            WoHeaderModel.updateWorkorderEntity(entity: equipment.entity,  flushRequired: false, options: nil){(response, error) in
                if(error == nil) {
                    self.updateVerifyWorkOrder(list: list, status: status, count: count + 1)
                }else {
                    self.updateVerifyWorkOrder(list: list, status: status, count: count + 1)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func getEquipmentListForAssets(list:[WorkorderObjectModel],currentLoc:String,from:String){
        var str = String()
        self.equipmentArr.removeAll()
        for item in list{
            if str.count == 0{
                str = str + "Equipment eq" + " '\(item.Equipment)'"
            }else{
                str = str + " or " + "Equipment eq" + " '\(item.Equipment)'"
            }
        }
        let query = "$filter=\(str)&$orderby=Equipment"
        EquipmentModel.getEquipmentList(filterQuery: query,modelClass: ZEquipmentModel.self){(response, error)  in
            if error == nil{
                if let respArr = response["data"] as? [ZEquipmentModel]{
                    if from == "AssetMap"{
                        self.equipmentArr = respArr
                        self.delegate?.dataFetchCompleted?(type: "AssetMap", object: [])
                    }else{
                        self.updateGeoLocation(list: respArr, currentLoc: currentLoc, count: 0)
                    }
                }else{
                    if from == "AssetMap"{
                        self.delegate?.dataFetchCompleted?(type: "AssetMap", object: [])
                    }else{
                        self.updateGeoLocation(list: [], currentLoc: currentLoc, count: 0)
                    }
                }
            }
        }
    }
    func updateGeoLocation(list:[ZEquipmentModel],currentLoc:String,count:Int){
        if count == list.count{
            self.delegate?.dataFetchCompleted?(type: "geoLocationUpdated", object: [currentLoc])
        }else{
            let equipment = list[count]
            (equipment.entity.properties["GEOLocation"] as! SODataProperty).value = "\(currentLoc)" as NSObject
            EquipmentModel.updateWorkorderEntity(entity: equipment.entity,  flushRequired: false, options: nil){(response, error) in
                if(error == nil) {
                    equipment.GEOLocation = currentLoc
                    self.updateGeoLocation(list: list, currentLoc: currentLoc, count: count + 1)
                    mJCLogger.log("Equipment Header Updated successfully", Type: "Debug")
                }else {
                    self.updateGeoLocation(list: list, currentLoc: currentLoc, count: count + 1)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
}
