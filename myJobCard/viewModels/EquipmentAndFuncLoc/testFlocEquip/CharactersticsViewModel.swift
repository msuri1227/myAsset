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

class CharactersticsViewModel{

    var classificationType = String()
    var flocEquipObjText = String()
    var classCharList = [ClassCharacteristicValueModel]()
    weak var delegate: viewModelDelegate?

    func getFlocCharacterstics(classification:ClassificationModel){

        if classificationType == "WorkOrder"{
            CharateristicsModel.getWoFunctionalLocCharateristicsList(funcLoc: classification.FunctionalLoc, classNum: classification.ClassNum){(response, error) in
                if error == nil{
                    if let responseArr = response["data"] as? [CharateristicsModel]{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                }
            }
        }else if classificationType == "Notification"{
            CharateristicsModel.getNoFunctionalLocCharateristicsList(funcLoc: classification.FunctionalLoc, classNum: classification.ClassNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [CharateristicsModel]{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                }
            }
        }else if classificationType == "WONotification"{
            CharateristicsModel.getWoNoFunctionalLocCharateristicsList(funcLoc: classification.FunctionalLoc, classNum: classification.ClassNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [CharateristicsModel]{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                }
            }
        }
    }
    func getEquipCharacterstics(classification:ClassificationModel){

        if classificationType == "WorkOrder"{
            CharateristicsModel.getWoEquipmentCharateristicsList(equipmentNum: classification.Equipment, classNum: classification.ClassNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [CharateristicsModel]{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                }
            }
        }else if classificationType == "Notification"{
            CharateristicsModel.getNoEquipmentCharateristicsList(equipmentNum: classification.Equipment, classNum: classification.ClassNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [CharateristicsModel]{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                }
            }
        }else if classificationType == "WONotification"{
            CharateristicsModel.getWoNoEquipmentCharateristicsList(equipmentNum: classification.Equipment, classNum: classification.ClassNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [CharateristicsModel]{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "charateristics", object: [])
                }
            }
        }
    }
    func getClassCharacteristicValueList(){
        ClassCharacteristicValueModel.getclassCharacteristicValueList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [ClassCharacteristicValueModel]{
                    self.classCharList = responseArr
                }else{
                    self.classCharList = []
                }
            }else{
                self.classCharList = []
            }
        }
    }

    //    func UpdateCharateristic(Index:Int) {
    //
    //        let CharateristCls = FLorEquipCharateristicsArr[Index]
    //        let cell = classificationVC?.characteristicTableView.cellForRow(at: NSIndexPath(row: Index, section: 0) as IndexPath) as! ClassificationCharacteristicsCell
    //
    //        var newchar = cell.CharacteristicValueTxtField.text
    //        if CharateristCls.DataType != "CHAR"{
    //            newchar = newchar?.replaceCharactersFromSet(characterSet: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), replacementString: "")
    //        }
    //        (CharateristCls.entity.properties["Value1"] as? SODataProperty)?.value = newchar! as? NSObject
    //
    //        if self.classificationVC?.fromType == "WorkOrder"{
    //
    //            CharateristicsModel.updateWoFunctionalLocCharateristicsEntity(entity: CharateristCls.entity,  flushRequired: true, options: nil){ (response, error) in
    //                if(error == nil) {
    //                    DispatchQueue.main.async {
    //                        let classifcationFLParms = ClassificationModel()
    //                        classifcationFLParms.FunctionalLoc = CharateristCls.FunctionalLoc
    //                        classifcationFLParms.ClassNum = CharateristCls.ClassNum
    //                        self.getFLClassficationCharacterstics(classification: classifcationFLParms)
    //                    }
    //                }
    //            }
    //        }else if self.classificationVC?.fromType == "Notification"{
    //            if isSingleNotification == true{
    //                CharateristicsModel.updateWoNoFunctionalLocCharateristicsEntity(entity: CharateristCls.entity,  flushRequired: true, options: nil){ (response, error) in
    //                    if(error == nil) {
    //                        DispatchQueue.main.async {
    //                            let classifcationFLParms = ClassificationModel()
    //                            classifcationFLParms.FunctionalLoc = CharateristCls.FunctionalLoc
    //                            classifcationFLParms.ClassNum = CharateristCls.ClassNum
    //                            self.getFLClassficationCharacterstics(classification: classifcationFLParms)
    //                        }
    //                    }
    //                }
    //            }else{
    //                CharateristicsModel.updateNoFunctionalLocCharateristicsEntity(entity: CharateristCls.entity,  flushRequired: true, options: nil){ (response, error) in
    //                    if(error == nil) {
    //                        DispatchQueue.main.async {
    //                            let classifcationFLParms = ClassificationModel()
    //                            classifcationFLParms.FunctionalLoc = CharateristCls.FunctionalLoc
    //                            classifcationFLParms.ClassNum = CharateristCls.ClassNum
    //                            self.getFLClassficationCharacterstics(classification: classifcationFLParms)
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
}
