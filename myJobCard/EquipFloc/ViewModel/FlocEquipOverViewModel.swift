//
//  FunctionalLocationOverviewViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class FlocEquipOverViewModel {

    weak var delegate: viewModelDelegate?
    var flocEquipObjText = String()
    var selectedPlant = ""
    var selectedWorkcenter = ""
    var selectedCategory = ""
    var selectedFunctionalLocation = ""

    func getFunctionalLocationDetails(){
        FunctionalLocationModel.getFuncLocationDetails(funcLocation: flocEquipObjText){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FunctionalLocationModel]{
                    if responseArr.count > 0 {
                        self.delegate?.dataFetchCompleted?(type: "floc", object: [responseArr[0]])
                    }else {
                        self.delegate?.dataFetchCompleted?(type: "floc", object: [FuncEquipViewModel()])
                    }
                }else {
                    mJCLoader.stopAnimating()
                    self.delegate?.dataFetchCompleted?(type: "floc", object: [FuncEquipViewModel()])
                }
            }else{
                mJCLoader.stopAnimating()
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.delegate?.dataFetchCompleted?(type: "floc", object: [FuncEquipViewModel()])
            }
        }
    }
    func getEquipmentDetails(){
        EquipmentModel.getEquipmentDetails(equipNum: flocEquipObjText,modelClass: ZEquipmentModel.self){(response, error) in
            if error == nil{
                if let responseArr = response["data"] as? [ZEquipmentModel]{
                    if responseArr.count > 0 {
                        self.delegate?.dataFetchCompleted?(type: "equip", object: [responseArr[0]])
                    }else {
                        self.delegate?.dataFetchCompleted?(type: "equip", object: [ZEquipmentModel()])
                    }
                }else {
                    mJCLoader.stopAnimating()
                    self.delegate?.dataFetchCompleted?(type: "equip", object: [ZEquipmentModel()])
                }
            }else{
                mJCLoader.stopAnimating()
                self.delegate?.dataFetchCompleted?(type: "equip", object: [ZEquipmentModel()])
            }
        }
    }
    func getFunctionalLocationList(from:String){
        if from == "installEquipment"{
            var str = String()
            if self.selectedPlant != ""{
                str = "MaintPlant eq '\(self.selectedPlant)'"
            }
            if self.selectedWorkcenter != ""{
                if str.count > 0{
                    str = str + " and MainWorkcenter eq '\(self.selectedWorkcenter)'"
                }else{
                    str = "MainWorkcenter eq '\(self.selectedWorkcenter)'"
                }
            }
            let defineQuery = "$filter=(\(str))"
            FunctionalLocationModel.getFuncLocationList(filterQuery: defineQuery){(response, error)  in
                if error == nil{
                    var flocArr = [FunctionalLocationModel]()
                    if let responseArr = response["data"] as? [FunctionalLocationModel]{
                        flocArr = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "installedFloc", object: flocArr)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "installedFloc", object: [])
                }
            }
        }
    }
    func getEquipementList(from:String) {

        if from == "installEquipment"{
            var str = String()
            if self.selectedCategory != ""{
                str = "EquipCategory eq '\(self.selectedCategory)'"
            }
            if self.selectedPlant != ""{
                if str.count > 0{
                    str = str + " and MaintPlant eq '\(self.selectedPlant)'"
                }else{
                    str = "MaintPlant eq '\(self.selectedPlant)'"
                }
            }
            if self.selectedWorkcenter != ""{
                if str.count > 0{
                    str = str + " and WorkCenter eq '\(self.selectedWorkcenter)'"
                }else{
                    str = "WorkCenter eq '\(self.selectedWorkcenter)'"
                }
            }
            if self.selectedFunctionalLocation != ""{
                if str.count > 0{
                    str = str + " and FuncLocation eq '\(self.selectedFunctionalLocation)'"
                }else{
                    str = "FuncLocation eq '\(self.selectedFunctionalLocation)'"
                }
            }
            let defineQuery = "$filter=(\(str))"
            EquipmentModel.getEquipmentList(filterQuery: defineQuery){(response, error)  in
                if error == nil{
                    var equipArr = [EquipmentModel]()
                    if let responseArr = response["data"] as? [EquipmentModel]{
                        equipArr = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "installedEquip", object: equipArr)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "installedEquip", object: [])
                }
            }
        }
    }
}
