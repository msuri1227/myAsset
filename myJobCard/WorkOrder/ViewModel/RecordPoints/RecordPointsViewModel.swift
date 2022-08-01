//
//  RecordPointsViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class RecordPointsViewModel {
    var vcRecordPoints: RecordPointsVC?
    var operationArray = Array<EquipFuncLocMeasurementModel>()
    var curentReadingArray = Array<MeasurementPointModel>()
    var volutioncodeDict = NSMutableDictionary()
    var recordPointArray = NSMutableArray()
    var property = NSMutableArray()
    weak var newReadingEntity : SODataEntity?

    
    func getOperationDetails(workorderNum:String){
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(WorkOrderNum eq '\(workorderNum)')&$select=OperationNum,Equipment,FuncLoc,WorkOrderNum,Counter,OpObjectNum";
        
        EquipFuncLocMeasurementModel.getOperationEquipFuncLocDetails(workOrderNum: workorderNum, filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [EquipFuncLocMeasurementModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                   if responseArr.count > 0{
                       let allPointArray = responseArr.sorted{$0.OperationNum.compare($1.OperationNum) == .orderedAscending } as NSArray
//                        let predicate : NSPredicate = NSPredicate(format: "SELF.Equipment != '' OR SELF.FunctionalLocation != ''")
//                        let filteredArray = allPointArray.filtered(using: predicate)
                        self.operationArray.removeAll()
                        self.operationArray.append(contentsOf: allPointArray as! [EquipFuncLocMeasurementModel])
                        self.vcRecordPoints?.updateUIGetOperationDetails()
                   }
                   else {
                    mJCLogger.log("Data not found", Type: "Debug")
                   }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
            else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
     }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getvaluationcode(Catalog : String, CodeGroup : String,sender: Int,MeasValuationCode:String,from:String){
        mJCLogger.log("Starting", Type: "info")
        CodeGroupModel.getCatalogCodeList(cataLogCode: Catalog, codeGroup: CodeGroup){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    let key  = "\(sender)code"
                    self.volutioncodeDict.setValue(responseArr, forKey: key)
                    self.vcRecordPoints?.updateUIGetValutionCode(senderValue: sender, MeasValuationCodeStr: MeasValuationCode, keyValue: key, fromStr: from)
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
            
    
    //MARK:- Create New Reading..
    func createNewReading(tag: Int,isfromUpdate:Bool) {
        mJCLogger.log("Starting", Type: "info")
        
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = vcRecordPoints?.detailTableView.cellForRow(at: indexPath) as! ReadingpointsTableViewCell
        let measuringPointClass = self.recordPointArray[tag] as! MeasurementPointModel
        
        let newreadingText = cell.newReadingTextField.text
        let newdescText = cell.newReadingDesTextView.text
        let ValCodeSuff = measuringPointClass.ValCodeSuff
        
        var valcode = String()
        if ValCodeSuff == true{
            if cell.newReadingTextField.text != "" || cell.newReadingTextField.text != nil {
                let strarray = cell.newReadingTextField.text?.components(separatedBy: " - ")
                valcode = strarray![0]
            }
        }
        if isfromUpdate == true{
            var filterArray = Array<MeasurementPointModel>()
            if measuringPointClass.Equipment != ""{
                if measuringPointClass.OperationNum != ""{
                    let oprArray = self.operationArray.filter({$0.OperationNum == "\(measuringPointClass.OperationNum)"})
                    if oprArray.count > 0{
                        let opr = oprArray[0]
                        filterArray = (curentReadingArray.filter({$0.MeasuringPoint == "\(measuringPointClass.MeasuringPoint)" && $0.Equipment == "\(measuringPointClass.Equipment)" && $0.OperationNum == "\(opr.OperationNum)" && $0.OpObjectNumber == "\(opr.OpObjectNum)"}))
                    }
                }else{
                    filterArray = curentReadingArray.filter({$0.MeasuringPoint == "\(measuringPointClass.MeasuringPoint)" && $0.Equipment == "\(measuringPointClass.Equipment)" && $0.WOObjectNum == "\(singleWorkOrder.ObjectNumber)" && $0.OperationNum == ""})
                }
            }
            else {
                if measuringPointClass.OperationNum != ""{
                    let oprArray = operationArray.filter({$0.OperationNum == "\(measuringPointClass.OperationNum)"})
                    if oprArray.count > 0{
                        let opr = oprArray[0]
                        filterArray = curentReadingArray.filter({$0.MeasuringPoint == "\(measuringPointClass.MeasuringPoint)" && $0.Equipment == "\(measuringPointClass.Equipment)" && $0.OperationNum == "\(opr.OperationNum)" && $0.OpObjectNumber == "\(opr.OpObjectNum)"})
                    }
                }else{
                    filterArray = curentReadingArray.filter({$0.MeasuringPoint == "\(measuringPointClass.MeasuringPoint)" && $0.Equipment == "\(measuringPointClass.Equipment)" && $0.WOObjectNum == "\(singleWorkOrder.ObjectNumber)"})
                }
            }
            mJCLogger.log("Response :\(filterArray.count)", Type: "Debug")
            if filterArray.count > 0 {
                let value = filterArray[0]
                print("\(value.MeasuringPoint) -\(measuringPointClass.MeasuringPoint)")
                if (value.MeasuringPoint == measuringPointClass.MeasuringPoint) && (value.OperationNum == measuringPointClass.OperationNum) {
                    (value.entity.properties["MeasDocumentDate"] as! SODataProperty).value = NSDate()
                    let MeasDocumentTime = Date().toString(format: .custom("HH:mm"))
                    let basicTime = SODataDuration()
                    let basicTimeArray = MeasDocumentTime.components(separatedBy: ":")
                    basicTime.hours = Int(basicTimeArray[0])! as NSNumber
                    basicTime.minutes = Int(basicTimeArray[1])! as NSNumber
                    basicTime.seconds = 0
                    
                    (value.entity.properties["MeasDocumentTime"] as! SODataProperty).value = basicTime
                    if ValCodeSuff == true{
                        
                        (value.entity.properties["MeasValuationCode"] as! SODataProperty).value = valcode as NSObject
                    }else{
                        let val = Double(newreadingText!)
                        (value.entity.properties["MeasReading"] as! SODataProperty).value = val! as NSObject
                        (value.entity.properties["MeasReadingChar"] as! SODataProperty).value = cell.newReadingTextField.text! as NSObject
                    }
                    (value.entity.properties["MeasText"] as! SODataProperty).value = newdescText! as NSObject
                    
                    MeasurementPointModel.updateMeasurementPointEntity(entity: value.entity,flushRequired: true ,options: nil, completionHandler: { (response, error) in
                        if(error == nil) {
                            DispatchQueue.main.async {
                                mJCLogger.log("Point Updated Successfully".localized(), Type: "Debug")
                                mJCAlertHelper.showAlert(self.vcRecordPoints!, title: MessageTitle, message: "Point_Updated_Successfully".localized(), button: okay)
                                NotificationCenter.default.post(name: Notification.Name(rawValue:"getRecordPointCount"), object: "")
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                                mJCAlertHelper.showAlert(self.vcRecordPoints!, title: alerttitle, message: (error?.localizedDescription)!, button: okay)
                            }
                        }
                    })
                    
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            
            self.property = NSMutableArray()
            let keyArray = measuringPointClass.entity.properties.allKeys
            for key in keyArray {
                let keytype = key as! String
                if keytype == "MeasuringPoint"{
                    let  prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = measuringPointClass.MeasuringPoint as NSObject
                    self.property.add(prop!)
                }else if keytype == "OperationNum"{
                    let  prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = measuringPointClass.OperationNum as NSObject
                    self.property.add(prop!)
                }else if keytype == "OpObjectNumber"{
                    let  prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    let oprArr = operationArray.filter({$0.OperationNum == "\(measuringPointClass.OperationNum)"})
                    if oprArr.count > 0{
                        let opr = oprArr[0]
                        prop!.value = opr.OpObjectNum as NSObject
                    }else{
                        prop!.value = "" as NSObject
                    }
                    self.property.add(prop!)
                }else if keytype == "WOObjectNum"{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = singleWorkOrder.ObjectNumber as NSObject
                    self.property.add(prop!)
                }else if keytype == "Counter"{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = "1" as NSObject
                    self.property.add(prop!)
                }else if keytype == "MeasDocumentDate"{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = NSDate()
                    self.property.add(prop!)
                }else if keytype == "MeasDocumentTime"{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    let MeasDocumentTime = Date().toString(format: .custom("HH:mm"))
                    let basicTime = SODataDuration()
                    let basicTimeArray = MeasDocumentTime.components(separatedBy: ":")
                    basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
                    basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
                    basicTime.seconds = 0
                    prop!.value = basicTime
                    self.property.add(prop!)
                }else if keytype == "MeasValuationCode"{
                    if ValCodeSuff == true{
                        let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                        prop!.value = valcode as NSObject
                        self.property.add(prop!)
                    }
                }
                else if keytype == "MeasReadingChar"{
                    if ValCodeSuff == false{
                        let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                        prop!.value = cell.newReadingTextField.text! as NSObject
                        self.property.add(prop!)
                    }
                }
                else if keytype == "MeasReading"{
                    if ValCodeSuff == false{
                        let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                        prop!.value = Double(cell.newReadingTextField.text!) as NSObject?
                        self.property.add(prop!)
                    }
                }
                else if keytype == "MeasText"{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = newdescText! as NSObject
                    self.property.add(prop!)
                }else if keytype == "EnteredBy"{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = (measuringPointClass.entity.properties[keytype] as! SODataProperty).value
                    self.property.add(prop!)
                }else{
                    let prop = measuringPointClass.entity.properties[keytype] as? SODataProperty
                    prop!.value = (measuringPointClass.entity.properties[keytype] as! SODataProperty).value
                    self.property.add(prop!)
                }
            }
            print("===== Reading Point Key Value ======")
            
            let entity = SODataEntityDefault(type: measurementPointReadingSetEntity)
            for prop in self.property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name] = proper
                print("Key : \(proper.name)")
                print("Value :\(proper.value!)")
                print("...............")
            }
            newReadingEntity = entity
            MeasurementPointModel.createMeasurementPointEntity(entity: newReadingEntity!, collectionPath: measurementPointReadingSet,flushRequired: true, options: nil, completionHandler: { (response, error) in
                
                DispatchQueue.main.async {
                    if(error == nil) {
                        mJCLogger.log("Create Done", Type: "Debug")
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"getRecordPointCount"), object: "")
                        mJCLogger.log("Create New Reading  Success".localized(), Type: "Debug")
                    }
                    else {
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                        mJCAlertHelper.showAlert(self.vcRecordPoints!, title: alerttitle, message: "Fail_to_record_point_try_again".localized(), button: okay)
                    }
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

