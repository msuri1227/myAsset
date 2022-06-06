//
//  File.swift
//  myJobCard
//
//  Created by Suri on 04/04/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class InstalledEquipmentViewModel {

    weak var delegate: viewModelDelegate?
    var flocEquipObjText = String()

    var property = NSMutableArray()
    var selectedEquipment = String()
    var selectedFloc = String()
    var SuperiorEquipment = String()
    var SuperiorFunc = String()

    func getInstalledEquipmentToFlocList() {
        let defineQuery = "$filter=(SystemStatusCode eq 'I0100') and (FuncLocation eq '\(flocEquipObjText)')"
        //and sap.islocal()
        EquipmentModel.getEquipmentList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [EquipmentModel]{
                    self.delegate?.dataFetchCompleted?(type: "flocEquip", object: responseArr)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "flocEquip", object: [])
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "flocEquip", object: [])
                mJCLogger.log("Error : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getInstalledEquipmentToEquipList() {

        let defineQuery = "$filter=(SystemStatusCode eq 'I0116') and (SuperiorEquipment eq '\(flocEquipObjText)')"
        //and sap.islocal()
        EquipmentModel.getEquipmentList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [EquipmentModel]{
                    self.delegate?.dataFetchCompleted?(type: "equip", object: responseArr)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "equip", object: [])
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "equip", object: [])
                mJCLogger.log("Error : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }

    func setPlantvalue() {
        mJCLogger.log("Starting", Type: "info")
        var plantDispArr = [String]()
        for item in globalPlanningPlantArray {
            let plant = item.Plant + " - " + item.Name1
            if !plantDispArr.contains(plant){
                plantDispArr.append(plant)
            }
        }
        self.delegate?.dataFetchCompleted?(type: "plant", object: plantDispArr)
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkCenterValue(plant:String)  {
        mJCLogger.log("Starting", Type: "info")
        var workcenterDispArr = [String]()
        let arr = plant.components(separatedBy: " - ")
        if arr.count > 1{
            let workCtrArr = globalWorkCtrArray.filter{$0.Plant == "\(arr[0])" }
            for item in workCtrArr {
                let workCtr = item.WorkCenter + " - " + item.ShortText
                if !workcenterDispArr.contains(workCtr){
                    workcenterDispArr.append(workCtr)
                }
            }
        }
        self.delegate?.dataFetchCompleted?(type: "workCtr", object: workcenterDispArr)
        mJCLogger.log("Ended", Type: "info")
    }
    func getCategories(){
        mJCLogger.log("Starting", Type: "info")
        EquipmentCategoryModel.getEquipmentCategoryList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [EquipmentCategoryModel] {
                    if responseArr.count > 0 {
                        var categoryDispArr = [String]()
                        for item in responseArr {
                            let category = item.EquipCategory + " - " + item .CategoryDesc
                            if !categoryDispArr.contains(category){
                                categoryDispArr.append(category)
                            }
                        }
                        self.delegate?.dataFetchCompleted?(type: "EquipCategory", object: categoryDispArr)
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "EquipCategory", object: [])
                    }
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "EquipCategory", object: [])
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    func installequipmnetEntry(isitfrom:String){

        mJCLogger.log("Starting", Type: "info")

        self.property = NSMutableArray()

        var prop : SODataProperty? = SODataPropertyDefault(name: "Item")
        let tempId = String.random(length: 4, type: "Number")
        prop!.value = tempId as NSObject
        self.property.add(prop!)

        if isitfrom == "SuperiorFunc"{
            prop = SODataPropertyDefault(name: "FunctionalLocation")
            prop!.value = SuperiorFunc as NSObject
            self.property.add(prop!)
        }else if isitfrom == "SuperiorEquipment"{
            prop = SODataPropertyDefault(name: "SuperiorEquipment")
            prop!.value = SuperiorEquipment as NSObject
            self.property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "Equipment")
        prop!.value = self.selectedEquipment as NSObject
        self.property.add(prop!)

        let entity = SODataEntityDefault(type: installEquipmentEntity)

        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        WoHeaderModel.createWorkorderEntity(entity: entity!, collectionPath: "InstallEquipmentSet",  flushRequired: false, options: nil){ (response, error) in
            if(error == nil) {
                mJCLogger.log("Create Done", Type: "Debug")
                self.updatedateStatus(isitfrom: isitfrom)
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(title: errorTitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updatedateStatus(isitfrom:String){

        if self.selectedEquipment == ""{
            return
        }
        EquipmentModel.getEquipmentDetails(equipNum: "\(self.selectedEquipment)"){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [EquipmentModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr[0])", Type: "Debug")
                        let singleEquipment = responseArr[0]
                        if isitfrom == "SuperiorFunc"{
                            (singleEquipment.entity.properties["SystemStatus"] as! SODataProperty).value = "INST" as NSObject
                            (singleEquipment.entity.properties["SystemStatusCode"] as! SODataProperty).value = "I0100" as NSObject
                            (singleEquipment.entity.properties["FuncLocation"] as! SODataProperty).value = self.SuperiorFunc as NSObject
                        }else if isitfrom == "SuperiorEquipment" {
                            (singleEquipment.entity.properties["SystemStatus"] as! SODataProperty).value = "ASEQ" as NSObject
                            (singleEquipment.entity.properties["SystemStatusCode"] as! SODataProperty).value = "I0116" as NSObject
                            (singleEquipment.entity.properties["SuperiorEquipment"] as! SODataProperty).value = self.SuperiorEquipment as NSObject
                        }
                        EquipmentModel.updateWorkorderEntity(entity: singleEquipment.entity,  flushRequired: true, options: nil){(response, error) in
                            if(error == nil) {
                                mJCLogger.log("Equipment Header Updated successfully", Type: "Debug")
                            }else {
                                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                            }
                            self.delegate?.dataFetchCompleted?(type: "Dismiss", object: [])
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func dismantalEquipment(selectedEquip:EquipmentModel,from:String){

        let property = NSMutableArray()

        var prop : SODataProperty! = SODataPropertyDefault(name: "Item")
        let tempId = String.random(length: 4, type: "Number")
        prop!.value = tempId as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "FunctionalLocation")
        prop!.value = selectedEquip.FuncLocation as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Equipment")
        prop!.value = selectedEquip.Equipment as NSObject
        property.add(prop!)

        let entity = SODataEntityDefault(type: equipmentDismantleEntity)

        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            print("Key : \(proper.name)")
            print("Value :\(proper.value!)")
            print("...............")
        }
        WoHeaderModel.createWorkorderEntity(entity: entity!, collectionPath: "EquipmentDismantleSet",  flushRequired: false, options: nil){ (response, error) in

            DispatchQueue.main.async {
                if(error == nil) {
                    self.updatedateStatus(selectedEquip: selectedEquip,from: from)
                }else {
                    mJCAlertHelper.showAlert(title: alerttitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
                }
            }
        }
    }
    func updatedateStatus(selectedEquip:EquipmentModel,from:String) {

        if from == "floc"{
            (selectedEquip.entity.properties["SystemStatus"] as! SODataProperty).value = "AVLB" as NSObject
            (selectedEquip.entity.properties["FuncLocation"] as! SODataProperty).value = "" as NSObject
        }else{
            (selectedEquip.entity.properties["SystemStatus"] as! SODataProperty).value = "AVLB" as NSObject
            (selectedEquip.entity.properties["SuperiorEquipment"] as! SODataProperty).value = "" as NSObject
        }

        EquipmentModel.updateWorkorderEntity(entity: selectedEquip.entity,  flushRequired: true, options: nil){ (response, error) in
            if(error == nil) {
                DispatchQueue.main.async {
                    print("Equipment Header Updated successfully")
                    mJCLogger.log("Equipment Header Updated successfully".localized(), Type: "Debug")
                    if from == "floc"{
                        self.flocEquipObjText = selectedEquip.FuncLocation
                        self.getInstalledEquipmentToFlocList()
                    }else{
                        self.flocEquipObjText = selectedEquip.Equipment
                        self.getInstalledEquipmentToEquipList()
                    }
                }
            }else {
                print("error in equipment status update")
                mJCLogger.log("error in equipment status update".localized(), Type: "Error")
            }
        }
    }
}
