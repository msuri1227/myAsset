//
//  noLongTextViewModel.swift
//  myJobCard
//
//  Created by Suri on 17/05/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class noLongTextViewModel {
    
    weak var delegate: viewModelDelegate?
    var noLongTextArray = [LongTextModel]()
    var itemLongTextArray = [LongTextModel]()
    var activityLongTextArray = [LongTextModel]()
    var taskLongTextArray = [LongTextModel]()
    var itemCauseLongTextArray = [LongTextModel]()
    
    var noObj = NotificationModel()
    var woNotification = Bool()
    var userId = String()
    var entityArr = [SODataEntityDefault]()

    //MARK: - Notification long text
    func getNoLongText(postText:Bool? = false,textArr:[String]? = [""]){
        
        let defineQuery = "$filter=((Notification eq '\(self.noObj.Notification)') and TextObject eq '\(LONG_TEXT_TYPE_NOTIFICATION)')&$orderby=Item"
        
        if woNotification == true{
            LongTextModel.getWoNotificationLongTextSet(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.noLongTextArray = responseArr
                    }
                    if postText == true{
                        self.entityArr.removeAll()
                        self.createMultipleNoLongtextEntity(textArr: textArr!, longTxtCount: self.noLongTextArray.count + 1, textCount: 0)
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.noLongTextArray)
                    }
                }else{
                    self.noLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            LongTextModel.getNoLongText(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.noLongTextArray = responseArr
                    }
                    if postText == true{
                        self.entityArr.removeAll()
                        self.createMultipleNoLongtextEntity(textArr: textArr!, longTxtCount: self.noLongTextArray.count + 1, textCount: 0)
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.noLongTextArray)
                    }
                }else{
                    self.noLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func createNoLongtext(text:String,flushRequired:Bool? = false){

        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.noLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: noObj.Notification)
        prop!.value = combString as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(noObj.Notification)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotificationItem")
        prop!.value = "0000" as NSObject
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
        prop!.value = "\(LONG_TEXT_TYPE_NOTIFICATION)" as NSObject
        property.add(prop!)

        var entity : SODataEntityDefault?
        var collectionPath = String()
        if woNotification == true{
            entity = SODataEntityDefault(type: woNotificationLongTextSetEntity)
            collectionPath = woNotificationLongTextSet
        }else{
            entity = SODataEntityDefault(type: notificationLongTextSetEntity)
            collectionPath = notificationLongTextSet
        }
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: collectionPath,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    func createMultipleNoLongtextEntity(textArr:[String],longTxtCount:Int,textCount:Int,flushRequired:Bool? = false){

        if textCount == textArr.count{
            self.postMultipleLongText(count: 0)
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
            let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: noObj.Notification)
            prop!.value = combString as NSObject
            property.add(prop!)

            prop = SODataPropertyDefault(name: "Notification")
            prop!.value = "\(noObj.Notification)" as NSObject
            property.add(prop!)

            prop = SODataPropertyDefault(name: "NotificationItem")
            prop!.value = "0000" as NSObject
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
            prop!.value = "\(LONG_TEXT_TYPE_NOTIFICATION)" as NSObject
            property.add(prop!)

            var entity : SODataEntityDefault?
            if woNotification == true{
                entity = SODataEntityDefault(type: woNotificationLongTextSetEntity)
            }else{
                entity = SODataEntityDefault(type: notificationLongTextSetEntity)
            }
            for prop in property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name as Any] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
            self.entityArr.append(entity!)
            self.createMultipleNoLongtextEntity(textArr: textArr, longTxtCount: longTxtCount + 1, textCount: textCount + 1)
        }
    }
    //MARK: - Item long text
    func getItemLongText(itemNum:String){
        
        let defineQuery = "$filter=((Notification eq '\(self.noObj.Notification)') and NotificationItem eq '\(itemNum)' and TextObject eq '\(LONG_TEXT_TYPE_NOTIFICATION_ITEM)')&$orderby=Item"
        
        if woNotification == true{
            LongTextModel.getWoNotificationLongTextSet(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.itemLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.itemLongTextArray)
                }else{
                    self.itemLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            LongTextModel.getNoLongText(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.itemLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.itemLongTextArray)
                }else{
                    self.itemLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func createItemLongtext(itemNum:String,text:String,flushRequired:Bool? = false){

        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.itemLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: noObj.Notification)
        prop!.value = "\(combString)\(itemNum)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(noObj.Notification)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotificationItem")
        prop!.value = "\(itemNum)" as NSObject
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
        prop!.value = "\(LONG_TEXT_TYPE_NOTIFICATION_ITEM)" as NSObject
        property.add(prop!)

        var entity : SODataEntityDefault?
        var collectionPath = String()
        if woNotification == true{
            entity = SODataEntityDefault(type: woNotificationLongTextSetEntity)
            collectionPath = woNotificationLongTextSet
        }else{
            entity = SODataEntityDefault(type: notificationLongTextSetEntity)
            collectionPath = notificationLongTextSet
        }
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: collectionPath,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    //MARK: - Activity long text
    func getActivityLongText(itemNum:String? = "0000",activityNum:String){
        
        let defineQuery = "$filter=((endswith(TextName,'\(noObj.Notification)\(activityNum)') eq true) and NotificationItem eq '\(itemNum!)' and TextObject eq '\(LONG_TEXT_TYPE_NOTIFICATION_ACTIVITY)')&$orderby=Item"
        
        if woNotification == true{
            LongTextModel.getWoNotificationLongTextSet(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.activityLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.activityLongTextArray)
                }else{
                    self.activityLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            LongTextModel.getNoLongText(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.activityLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.activityLongTextArray)
                }else{
                    self.activityLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func createActivityLongtext(itemNum:String,activityNum:String,text:String,flushRequired:Bool? = false){

        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.activityLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: noObj.Notification)
        prop!.value = "\(combString)\(itemNum)\(activityNum)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(noObj.Notification)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotificationItem")
        if itemNum == ""{
            prop!.value = "0000" as NSObject
        }else{
            prop!.value = "\(itemNum)" as NSObject
        }
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
        prop!.value = "\(LONG_TEXT_TYPE_NOTIFICATION_ACTIVITY)" as NSObject
        property.add(prop!)

        var entity : SODataEntityDefault?
        var collectionPath = String()
        if woNotification == true{
            entity = SODataEntityDefault(type: woNotificationLongTextSetEntity)
            collectionPath = woNotificationLongTextSet
        }else{
            entity = SODataEntityDefault(type: notificationLongTextSetEntity)
            collectionPath = notificationLongTextSet
        }
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: collectionPath,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    //MARK: - Task long text
    func getTaskText(itemNum:String? = "0000",taskNum:String){

        let defineQuery = "$filter=((endswith(TextName,'\(noObj.Notification)\(taskNum)') eq true) and NotificationItem eq '\(itemNum!)' and TextObject eq '\(LONG_TEXT_TYPE_NOTIFICATION_TASK)')&$orderby=Item"
        
        if woNotification == true{
            LongTextModel.getWoNotificationLongTextSet(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.taskLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.taskLongTextArray)
                }else{
                    self.taskLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            LongTextModel.getNoLongText(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.taskLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.taskLongTextArray)
                }else{
                    self.taskLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func createTaskLongtext(itemNum:String,taskNum:String,text:String,flushRequired:Bool? = false){

        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.taskLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: noObj.Notification)
        prop!.value = "\(combString)\(itemNum)\(taskNum)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(noObj.Notification)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotificationItem")
        if itemNum == ""{
            prop!.value = "0000" as NSObject
        }else{
            prop!.value = "\(itemNum)" as NSObject
        }
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
        prop!.value = "\(LONG_TEXT_TYPE_NOTIFICATION_TASK)" as NSObject
        property.add(prop!)

        var entity : SODataEntityDefault?
        var collectionPath = String()
        if woNotification == true{
            entity = SODataEntityDefault(type: woNotificationLongTextSetEntity)
            collectionPath = woNotificationLongTextSet
        }else{
            entity = SODataEntityDefault(type: notificationLongTextSetEntity)
            collectionPath = notificationLongTextSet
        }
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: collectionPath,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    //MARK: - Item Cause long text
    func getItemCauseLongtext(itemNum:String,itemCause:String){
        
        let defineQuery = "$filter=((endswith(TextName,'\(noObj.Notification)\(itemNum)\(itemCause)') eq true) and NotificationItem eq '\(itemNum)' and TextObject eq '\(LONG_TEXT_TYPE_NOTIFICATION_ITEM_CAUSE)')&$orderby=Item"
        
        if woNotification == true{
            LongTextModel.getWoNotificationLongTextSet(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.itemCauseLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.itemCauseLongTextArray)
                }else{
                    self.itemCauseLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            LongTextModel.getNoLongText(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [LongTextModel]{
                        self.itemCauseLongTextArray = responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: self.itemCauseLongTextArray)
                }else{
                    self.itemCauseLongTextArray.removeAll()
                    self.delegate?.dataFetchCompleted?(type: "longTextFetch", object: [])
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func createItemCauseLongtext(itemNum:String,itemCause:String,text:String,flushRequired:Bool? = false){
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "TextLine")
        prop!.value = text as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Item")
        let itemCount = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((self.itemCauseLongTextArray.count) + 1)")
        prop!.value = itemCount as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "TextName")
        let combString = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: noObj.Notification)
        prop!.value = "\(combString)\(itemNum)\(itemCause)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(noObj.Notification)" as NSObject
        property.add(prop!)

        prop = SODataPropertyDefault(name: "NotificationItem")
        prop!.value = "\(itemNum)" as NSObject
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
        prop!.value = "\(LONG_TEXT_TYPE_NOTIFICATION_ITEM_CAUSE)" as NSObject
        property.add(prop!)

        var entity : SODataEntityDefault?
        var collectionPath = String()
        if woNotification == true{
            entity = SODataEntityDefault(type: woNotificationLongTextSetEntity)
            collectionPath = woNotificationLongTextSet
        }else{
            entity = SODataEntityDefault(type: notificationLongTextSetEntity)
            collectionPath = notificationLongTextSet
        }
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        LongTextModel.createLongTextEntity(entity: entity!, collectionPath: collectionPath,flushRequired: true ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "longTextCreated", object: [])
            }else {
                self.delegate?.dataFetchCompleted?(type: "longTextFailed", object: [])
            }
        })
    }
    //MARK: Multiple Posting
    func postMultipleLongText(count:Int){
        if count == entityArr.count{
            self.delegate?.dataFetchCompleted?(type: "multipleLongTextPosted", object: [])
        }else{
            if entityArr.indices.contains(count){
                var collectionPath = String()
                if woNotification == true{
                    collectionPath = woNotificationLongTextSet
                }else{
                    collectionPath = notificationLongTextSet
                }
                let entity = entityArr[count]
                WoHeaderModel.createWorkorderEntity(entity: entity, collectionPath: collectionPath,  flushRequired: false, options: nil){ (response, error) in
                    if(error == nil) {
                        self.postMultipleLongText(count: count + 1)
                    }else {
                        self.postMultipleLongText(count: count + 1)
                    }
                }
            }
        }
    }
}
