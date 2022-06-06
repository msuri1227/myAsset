//
//  ClassificationViewModel.swift
//  myJobCard
//
//  Created by Navdeep Singla on 14/03/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class ClassificationViewModel{
    
    var classificationType = String()
    var flocEquipObjText = String()
    weak var delegate: viewModelDelegate?
    
    func getFlocClassficationList() {
        if classificationType == "Workorder"{
            ClassificationModel.getWoFunctionalLocClassificationList(funcLoc: flocEquipObjText){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [ClassificationModel]{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                }
            }
        }else if classificationType == "Notification"{
            ClassificationModel.getNoFunctionLocClassificationList(funcLoc: flocEquipObjText){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [ClassificationModel]{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                }
            }
        }else{
            if classificationType == "WONotification"{
                ClassificationModel.getWoNoFuncLocClassificationList(funcLoc: flocEquipObjText){(response, error)  in
                    if error == nil{
                        if let responseArr = response["data"] as? [ClassificationModel]{
                            self.delegate?.dataFetchCompleted?(type: "classifications", object: [responseArr])
                        }else{
                            self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                        }
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                    }
                }
            }
        }
    }
    func getEquipmentClassficationList(){
        
        if classificationType == "Workorder"{
            ClassificationModel.getWoEquipmentClassificationsList(equipmentNum: flocEquipObjText){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [ClassificationModel]{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                }
            }
        }else if classificationType == "Notification"{
            ClassificationModel.getNoEquipmentClassificationsList(equipmentNum: flocEquipObjText){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [ClassificationModel]{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                }
            }
        }else if classificationType == "WONotification"{
            ClassificationModel.getWoNoEquipmentClassificationsList(equipmentNum: flocEquipObjText){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [ClassificationModel]{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [responseArr])
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                    }
                }else{
                    self.delegate?.dataFetchCompleted?(type: "classifications", object: [])
                }
            }
        }
    }
}
