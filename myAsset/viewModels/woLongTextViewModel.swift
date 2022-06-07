//
//  woLongTextViewModel.swift
//  myJobCard
//
//  Created by Suri on 17/05/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class woLongTextViewModel {
    
    weak var delegate: viewModelDelegate?
    var userId = String()
    
    var woLongTextArray = [LongTextModel]()
    var oprLongTextArray = [LongTextModel]()
    var subOprLongTextArray = [LongTextModel]()
    var compLongTextArray = [LongTextModel]()
    var woHistoryLongTextArray  = [LongTextModel]()
    var woHistoryOprLongTextArray  = [LongTextModel]()
    
    var woObj = WoHeaderModel()
    var oprObj = WoOperationModel()
    var compObj = WoComponentModel()
    var entityArr = [SODataEntityDefault]()
    
    //MARK: - Workorder Long text
    func getWoLongText(postText:Bool? = false,textArr:[String]? = [""]){
        let defineReq = "$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)' and TextObject eq '\(LONG_TEXT_TYPE_WO)')&$orderby=Item"
        LongTextModel.getWoLongText(filterQuery: defineReq){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [LongTextModel]{
                    self.woLongTextArray = responseArr
                }
                if postText == true{
                    self.entityArr.removeAll()
                    self.createMultipleWoLongtextEntity(textArr: textArr!, longTxtCount: self.woLongTextArray.count + 1, textCount: 0)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.woLongTextArray)
                }
            }else{
                self.woLongTextArray.removeAll()
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func createWoLongtext(text:String,flushRequired:Bool? = false,requiredEntity:Bool? = false){
        
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.woLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: woObj.WorkOrderNum)
        prop!.value = combString as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = "\(woObj.WorkOrderNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOperation")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = "\(userId)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = "\(LONG_TEXT_TYPE_WO)" as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: woLongTextSetEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        if requiredEntity == true{
            self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [entity!])
        }else{
            LongTextModel.createLongTextEntity(entity: entity!, collectionPath: woLongTextSet,flushRequired: true ,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
                }else {
                    self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
                }
            })
        }
    }
    func createMultipleWoLongtextEntity(textArr:[String],longTxtCount:Int,textCount:Int,flushRequired:Bool? = false){
        if textCount == textArr.count{
            self.postMultipleLongText(count: 0, type: "workorder")
        }else{
            let property = NSMutableArray()
            var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
            prop!.value = textArr[textCount] as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Item")
            let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\(longTxtCount)")
            prop!.value = itemCount as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TextName")
            let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: woObj.WorkOrderNum)
            prop!.value = combString as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkOrderNum")
            prop!.value = "\(woObj.WorkOrderNum)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "OperationNum")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "SubOperation")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EnteredBy")
            prop!.value = "\(userId)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TagColumn")
            prop!.value = "*" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TempID")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TextObject")
            prop!.value = "\(LONG_TEXT_TYPE_WO)" as NSObject
            property.add(prop!)
            
            let entity = SODataEntityDefault(type: woLongTextSetEntity)
            for prop in property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name as Any] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
            entityArr.append(entity!)
            self.createMultipleWoLongtextEntity(textArr: textArr, longTxtCount: longTxtCount + 1, textCount: textCount + 1)
        }
    }
    //MARK: - Operation long text
    func getOprLongText(postText:Bool? = false,textArr:[String]? = [""]){
        let defineReq = "$filter=(WorkOrderNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and SubOperation eq '' and TextObject eq '\(LONG_TEXT_TYPE_OPERATION)')&$orderby=Item"
        LongTextModel.getWoLongText(filterQuery: defineReq){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [LongTextModel]{
                    self.oprLongTextArray = responseArr
                }
                if postText == true{
                    self.entityArr.removeAll()
                    self.createMultipleOprLongtextEntity(textArr: textArr!, longTxtCount: self.oprLongTextArray.count + 1, textCount: 0)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.oprLongTextArray)
                }
            }else{
                self.oprLongTextArray.removeAll()
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func createOprLongtext(text:String,flushRequired:Bool? = false,requiredEntity:Bool? = false){
        
        mJCLogger.log("Starting", Type: "info")
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.oprLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: oprObj.WorkOrderNum)
        prop!.value = "\(combString)\(oprObj.OperationNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = "\(oprObj.WorkOrderNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = "\(oprObj.OperationNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PlannofOpera")
        prop!.value = "\(oprObj.PlannofOpera)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOperation")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = "\(oprObj.Counter)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = "\(userId)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = "\(LONG_TEXT_TYPE_OPERATION)" as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: woLongTextSetEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        if requiredEntity == true{
            self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [entity!])
        }else{
            LongTextModel.createLongTextEntity(entity: entity!, collectionPath: woLongTextSet,flushRequired: true ,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
                }else {
                    self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
                }
            })
        }
    }
    func createMultipleOprLongtextEntity(textArr:[String],longTxtCount:Int,textCount:Int,flushRequired:Bool? = false){
        
        if textCount == textArr.count{
            self.postMultipleLongText(count: 0, type: "operation")
        }else{
            let property = NSMutableArray()
            var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
            prop!.value = textArr[textCount] as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Item")
            let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\(longTxtCount)")
            prop!.value = itemCount as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TextName")
            let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: oprObj.WorkOrderNum)
            prop!.value = "\(combString)\(oprObj.OperationNum)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkOrderNum")
            prop!.value = "\(oprObj.WorkOrderNum)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "OperationNum")
            prop!.value = "\(oprObj.OperationNum)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PlannofOpera")
            prop!.value = "\(oprObj.PlannofOpera)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "SubOperation")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Counter")
            prop!.value = "\(oprObj.Counter)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EnteredBy")
            prop!.value = "\(userId)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TagColumn")
            prop!.value = "*" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TempID")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TextObject")
            prop!.value = "\(LONG_TEXT_TYPE_OPERATION)" as NSObject
            property.add(prop!)
            
            let entity = SODataEntityDefault(type: woLongTextSetEntity)
            for prop in property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name as Any] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
            entityArr.append(entity!)
            self.createMultipleOprLongtextEntity(textArr: textArr, longTxtCount: longTxtCount + 1, textCount: textCount + 1)
        }
    }
    //MARK: - Sub operation long text
    func getSubOprLongText(postText:Bool? = false,textArr:[String]? = [""]){
        
        let defineReq = "$filter=(WorkOrderNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and SubOperation eq '\(oprObj.SubOperation)' and TextObject eq '\(LONG_TEXT_TYPE_OPERATION)')&$orderby=Item"
        LongTextModel.getWoLongText(filterQuery: defineReq){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [LongTextModel]{
                    self.subOprLongTextArray = responseArr
                }
                if postText == true{
                    self.entityArr.removeAll()
                    self.createMultipleSubOprLongtextEntity(textArr: textArr!, longTxtCount: self.subOprLongTextArray.count + 1, textCount: 0)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.subOprLongTextArray)
                }
            }else{
                self.subOprLongTextArray.removeAll()
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func createSubOprLongtext(text:String,flushRequired:Bool? = false){
        
        mJCLogger.log("Starting", Type: "info")
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.subOprLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: oprObj.WorkOrderNum)
        prop!.value = "\(combString)\(oprObj.OperationNum)\(oprObj.SubOperation)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = "\(oprObj.WorkOrderNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = "\(oprObj.OperationNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PlannofOpera")
        prop!.value = "\(oprObj.PlannofOpera)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOperation")
        prop!.value = "\(oprObj.SubOperation)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = "\(oprObj.Counter)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = "\(userId)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = "\(LONG_TEXT_TYPE_OPERATION)" as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: woLongTextSetEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: woLongTextSet,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    func createMultipleSubOprLongtextEntity(textArr:[String],longTxtCount:Int,textCount:Int,flushRequired:Bool? = false){
        
        if textCount == textArr.count{
            self.postMultipleLongText(count: 0,type: "subOperation")
        }else{
            
            let property = NSMutableArray()
            var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
            prop!.value = textArr[textCount] as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Item")
            let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\(longTxtCount)")
            prop!.value = itemCount as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TextName")
            let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: oprObj.WorkOrderNum)
            prop!.value = "\(combString)\(oprObj.OperationNum)\(oprObj.SubOperation)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkOrderNum")
            prop!.value = "\(oprObj.WorkOrderNum)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "OperationNum")
            prop!.value = "\(oprObj.OperationNum)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PlannofOpera")
            prop!.value = "\(oprObj.PlannofOpera)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "SubOperation")
            prop!.value = "\(oprObj.SubOperation)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Counter")
            prop!.value = "\(oprObj.Counter)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "EnteredBy")
            prop!.value = "\(userId)" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TagColumn")
            prop!.value = "*" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TempID")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "TextObject")
            prop!.value = "\(LONG_TEXT_TYPE_OPERATION)" as NSObject
            property.add(prop!)
            
            let entity = SODataEntityDefault(type: woLongTextSetEntity)
            for prop in property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name as Any] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
            entityArr.append(entity!)
            self.createMultipleSubOprLongtextEntity(textArr: textArr, longTxtCount: longTxtCount + 1, textCount: textCount + 1)
        }
    }
    //MARK: - Component long text
    func getWoComponentLongtext(){
        let defineReq = "$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)' and ComponentItem eq '\(compObj.Item)' and  TextObject eq '\(LONG_TEXT_TYPE_COMPONENT)')&$orderby=Item"
        LongTextModel.getWoLongText(filterQuery: defineReq){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [LongTextModel]{
                    self.compLongTextArray = responseArr
                }
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.compLongTextArray)
            }else{
                self.compLongTextArray.removeAll()
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func createCompLongtext(text:String,flushRequired:Bool? = false){
        
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.compLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: woObj.WorkOrderNum)
        prop!.value = "\(combString)\(compObj.Item)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = "\(woObj.WorkOrderNum)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ComponentItem")
        prop!.value = "\(compObj.Item)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = "00000000" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = "\(userId)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TagColumn")
        prop!.value = "*" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TextObject")
        prop!.value = "\(LONG_TEXT_TYPE_COMPONENT)" as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: woLongTextSetEntity)
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: woLongTextSet,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    //MARK: - Workorder History and Pending Long text
    func getwoHistoryLongText(woNum:String){
        let defineQuery = "$filter=(endswith(TextName, '\(woNum)') eq true)&$orderby=Item"
        LongTextModel.getWoHistoryPendingLongTextSet(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [LongTextModel]{
                    self.woHistoryLongTextArray = responseArr
                }
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.woHistoryLongTextArray)
            }else{
                self.woHistoryLongTextArray.removeAll()
                self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getwoPendingText(oprObj:WoOperationModel){
        //        let defineQuery = "$filter=(endswith(TextName, '" + woNum + "') eq true)"
        //        LongTextModel.getWoHistoryPendingLongTextSet(filterQuery: defineQuery){(response, error)  in
        //            if error == nil{
        //                if let responseArr = response["data"] as? [LongTextModel]{
        //                    self.woHistoryLongTextArray = responseArr
        //                }
        //                self.delegate?.dataFetchCompleted?(type: "woHistoryLongText", object: [])
        //            }else{
        //                self.woHistoryLongTextArray.removeAll()
        //                self.delegate?.dataFetchCompleted?(type: "woHistoryLongText", object: [])
        //                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
        //            }
        //        }
    }
    //MARK: Multiple Posting
    func postMultipleLongText(count:Int,type:String){
        if count == entityArr.count{
            if type == "workorder"{
                self.delegate?.dataFetchCompleted?(type: "multipleWoLongTextPosted", object: [])
            }else if type == "operation"{
                self.delegate?.dataFetchCompleted?(type: "multipleOprLongTextPosted", object: [])
            }else if type == "subOperation"{
                self.delegate?.dataFetchCompleted?(type: "multipleSubOprLongTextPosted", object: [])
            }
        }else{
            if entityArr.indices.contains(count){
                let entity = entityArr[count]
                WoHeaderModel.createWorkorderEntity(entity: entity, collectionPath: woLongTextSet,  flushRequired: false, options: nil){ (response, error) in
                    if(error == nil) {
                        self.postMultipleLongText(count: count + 1, type: type)
                    }else {
                        self.postMultipleLongText(count: count + 1, type: type)
                    }
                }
            }
        }
    }
}
