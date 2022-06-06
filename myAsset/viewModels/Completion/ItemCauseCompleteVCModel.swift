//
//  EditNotificationViewModel.swift
//  myJobCard
//
//  Created by Ruby's Mac on 17/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class ItemCauseCompleteViewModel{
    
    var itemCodeGroupArray = [CatalogProfileModel]()
    var itemCodeGroupListArray = [String]()
    
    var itemCodeArray = Array<CodeGroupModel>()
    var itemCodeListArray = Array<String>()
    
    var partGroupArray = [CatalogProfileModel]()
    var partGroupListArray = [String]()
    
    var partArray = Array<CodeGroupModel>()
    var partListArray = [String]()
    
    var itemCauseCodeGroupArray = [CatalogProfileModel]()
    var itemCauseCodeGroupListArray = [String]()
    
    var itemCauseCodeArray = Array<CodeGroupModel>()
    var itemCauseCodeListArray = Array<String>()
    
    var catlogprof = String()
    var catlogArray = NSMutableArray()
    
    var itemCauseCompleteVc :  ItemCauseCompleteVC?
    var property = NSMutableArray()
    
    var itemArray = [NotificationItemsModel]()
    var itemCauseArray = [NotificationItemCauseModel]()
    
    func getNotificationDetails(){
        
        NotificationModel.getWoNotificationDetailsWith(NotifNum: singleWorkOrder.NotificationNum){
            (responseDict,error) in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.itemCauseCompleteVc?.notificationClass = responseArr[0]
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.itemCauseCompleteVc?.setBasicData()
                self.getItemDetails(notificationNum: singleWorkOrder.NotificationNum)
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getItemDetails(notificationNum:String){
        NotificationItemsModel.getWoNotificationItemsList(notifNum:notificationNum){
            (responseDict,error) in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.itemArray = responseArr
                        self.itemCauseCompleteVc?.itemClass = responseArr[0]
                        self.getItemCauseDetails(notificationNun: notificationNum, itemNum: self.itemCauseCompleteVc?.itemClass.Item ?? "0001")
                    }else{
                        self.GetCatalogProfileSet()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    self.GetCatalogProfileSet()
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                self.GetCatalogProfileSet()
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getItemCauseDetails(notificationNun:String,itemNum:String){
        NotificationItemCauseModel.getWoNoItemCauseList(notifNum: notificationNun, itemNum: itemNum){
            (responseDict,error) in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.itemCauseArray = responseArr
                        self.itemCauseCompleteVc?.causeClass = responseArr[0]
                        DispatchQueue.main.async {
                            self.itemCauseCompleteVc?.causeTextField.text = self.itemCauseCompleteVc?.causeClass.CauseText
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    self.GetCatalogProfileSet()
                }else{
                    self.GetCatalogProfileSet()
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    //MARK:- GetCatalogProfile
    func GetCatalogProfileSet(){
        CatalogProfileModel.getCatalogProfileList(){ (response, error)  in
            if error == nil{
                self.catlogArray.removeAllObjects()
                if let responseArr = response["data"] as? [CatalogProfileModel]{
                    let sortedArr = responseArr.sorted{$0.CodeGroup.compare($1.CodeGroup) == .orderedAscending }
                    self.catlogArray.addObjects(from: sortedArr as [AnyObject])
                    if self.itemCauseCompleteVc?.notificationClass.Equipment != ""{
                        EquipmentModel.getEquipmentDetails(equipNum: singleNotification.Equipment){(response, error)  in
                            if error == nil{
                                if let equip = response["data"] as? [EquipmentModel]{
                                    if equip.count > 0{
                                        let equipmentdetails = equip[0]
                                        self.catlogprof  = equipmentdetails.CatalogProfile
                                        if equipmentdetails.CatalogProfile == "" && singleNotification.FunctionalLoc != ""{
                                            FunctionalLocationModel.getFuncLocationDetails(funcLocation: singleNotification.FunctionalLoc){(response, error)  in
                                                if error == nil{
                                                    if let funcArr = response["data"] as? [FunctionalLocationModel]{
                                                        let funcdetails = funcArr[0]
                                                        self.catlogprof  = funcdetails.CatalogProfile
                                                        self.getGroupValues()
                                                    }
                                                }
                                            }
                                        }else{
                                            self.getGroupValues()
                                        }
                                    }else{
                                        if self.itemCauseCompleteVc?.notificationClass.FunctionalLoc != ""{
                                            FunctionalLocationModel.getFuncLocationDetails(funcLocation: singleNotification.FunctionalLoc){(response, error)  in
                                                if error == nil{
                                                    if let funcArr = response["data"] as? [FunctionalLocationModel]{
                                                        let funcdetails = funcArr[0]
                                                        self.catlogprof  = funcdetails.CatalogProfile
                                                        self.getGroupValues()
                                                    }
                                                }
                                            }
                                        }else{
                                            self.getGroupValues()
                                        }
                                    }
                                }else{
                                    if self.itemCauseCompleteVc?.notificationClass.FunctionalLoc != ""{
                                        FunctionalLocationModel.getFuncLocationDetails(funcLocation: singleNotification.FunctionalLoc){(response, error)  in
                                            if error == nil{
                                                if let funcArr = response["data"] as? [FunctionalLocationModel]{
                                                    if funcArr.count > 0{
                                                        let funcdetails = funcArr[0]
                                                        self.catlogprof  = funcdetails.CatalogProfile
                                                        self.getGroupValues()
                                                    }else{
                                                        self.getGroupValues()
                                                    }
                                                }
                                            }
                                        }
                                    }else{
                                        self.getGroupValues()
                                    }
                                }
                            }else{
                                self.getGroupValues()
                            }
                        }
                    }else if self.itemCauseCompleteVc?.notificationClass.FunctionalLoc != ""{
                        FunctionalLocationModel.getFuncLocationDetails(funcLocation: singleNotification.FunctionalLoc){(response, error)  in
                            if error == nil{
                                if let funcArr = response["data"] as? [FunctionalLocationModel]{
                                    if funcArr.count > 0{
                                        let funcdetails = funcArr[0]
                                        self.catlogprof  = funcdetails.CatalogProfile
                                        self.getGroupValues()
                                    }else{
                                        self.getGroupValues()
                                    }
                                }else{
                                    self.getGroupValues()
                                }
                            }else{
                                self.getGroupValues()
                            }
                        }
                    }else{
                        self.getGroupValues()
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getGroupValues() {
        // Damege Group
        var searchPredicate = NSPredicate()
        var notifCatProfile = ""
        if self.catlogprof == ""{
            let type = singleNotification.NotificationType
            if type != ""{
                let notificationTypeArr = notificationTypeArray.filter{$0.NotifictnType == "\(type)"}
                if notificationTypeArr.count > 0{
                    notifCatProfile = notificationTypeArr[0].CatalogProfile
                }else{
                    notifCatProfile = ""
                }
            }else{
                notifCatProfile = ""
            }
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_DAMAGE)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let damgeGropArr = self.catlogArray.filtered(using: searchPredicate) as Array
        self.itemCodeGroupArray.removeAll()
        self.itemCodeGroupListArray.removeAll()
        self.itemCodeGroupListArray.append("--Select--".localized())
        if let arr = damgeGropArr as? [CatalogProfileModel]{
            self.itemCodeGroupArray = arr
            for itemCount in 0..<arr.count {
                let codeGroupClass = arr[itemCount]
                self.itemCodeGroupListArray.append("\(codeGroupClass.CodeGroup) - \(codeGroupClass.ShortText) - \(codeGroupClass.CatalogProfile)")
            }
            self.setItemCodeGroupValue()
        }
        // Damege Group End
        
        // Part group Values
        if self.catlogprof == ""{
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_ITEM)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let partGropArr = self.catlogArray.filtered(using: searchPredicate) as Array
        self.partGroupArray.removeAll()
        self.partGroupListArray.removeAll()
        self.partGroupListArray.append("--Select--".localized())
        if let arr = partGropArr as? [CatalogProfileModel]{
            self.partGroupArray = arr
            for itemCount in 0..<arr.count {
                let codeGroupClass = arr[itemCount]
                self.partGroupListArray.append("\(codeGroupClass.CodeGroup) - \(codeGroupClass.ShortText) - \(codeGroupClass.CatalogProfile)")
            }
            self.setPartGroupValue()
        }
        // Part grop values End
        
        // itemCause Group Value
        if self.catlogprof == ""{
            if notifCatProfile == ""{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)'")
            }else{
                searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)' AND SELF.CatalogProfile == %@",notifCatProfile)
            }
        }else{
            searchPredicate = NSPredicate(format: "SELF.CatalogCode == '\(CATALOGCODE_CAUSE)' AND SELF.CatalogProfile == %@",self.catlogprof)
        }
        let itemCauseGroupArray = self.catlogArray.filtered(using: searchPredicate) as Array
        self.itemCauseCodeGroupArray.removeAll()
        self.itemCauseCodeGroupListArray.removeAll()
        self.itemCauseCodeGroupListArray.append("--Select--".localized())
        if let arr = itemCauseGroupArray as? [CatalogProfileModel]{
            self.itemCauseCodeGroupArray = arr
            for itemCount in 0..<arr.count {
                let codeGroupClass = arr[itemCount]
                self.itemCauseCodeGroupListArray.append("\(codeGroupClass.CodeGroup) - \(codeGroupClass.ShortText) - \(codeGroupClass.CatalogProfile)")
            }
            self.setItemCauseCodeGroupValue()
        }
        // itemCause Group end
        
    }
    func setItemCodeGroupValue(){
        if self.itemArray.count > 0 && self.itemCodeGroupArray.count > 0 && itemCodeListArray.count > 0{
            let item = self.itemArray[0]
            let itemCodeGroupArr = self.itemCodeGroupArray.filter{$0.CodeGroup == item.DamageCodeGroup }
            if itemCodeGroupArr.count > 0{
                DispatchQueue.main.async {
                    let codeGroupClass = itemCodeGroupArr[0]
                    self.itemCauseCompleteVc?.itemCodeGroupTextField.text = "\(codeGroupClass.CodeGroup) - \(codeGroupClass.ShortText) - \(codeGroupClass.CatalogProfile)"
                    self.getItemCodeValue(catalogCode: CATALOGCODE_DAMAGE, codeGroup: codeGroupClass.CodeGroup)
                }
            }else{
                if self.itemCodeGroupListArray.count > 0{
                    DispatchQueue.main.async {
                        self.itemCauseCompleteVc?.itemCodeGroupTextField.text = self.itemCodeGroupListArray[0]
                        self.itemCodeListArray.removeAll()
                        self.itemCodeListArray.append("--Select--".localized())
                        self.itemCauseCompleteVc?.itemCodeTextField.text = self.itemCodeListArray[0]
                    }
                }
            }
        }else{
            if self.itemCodeGroupListArray.count > 0{
                DispatchQueue.main.async {
                    self.itemCauseCompleteVc?.itemCodeGroupTextField.text = self.itemCodeGroupListArray[0]
                    self.itemCodeListArray.removeAll()
                    self.itemCodeListArray.append("--Select--".localized())
                    self.itemCauseCompleteVc?.itemCodeTextField.text = self.itemCodeListArray[0]
                }
            }
            mJCLogger.log("Item Code Groups Not Found", Type: "Debug")
        }
    }
    func getItemCodeValue(catalogCode:String, codeGroup:String){
        self.itemCodeArray.removeAll()
        self.itemCodeListArray.removeAll()
        self.itemCodeListArray.append("--Select--".localized())
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.itemCodeArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                    for itemCount in 0..<self.itemCodeArray.count {
                        let codeGroupClass = self.itemCodeArray[itemCount]
                        self.itemCodeListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                    }
                }
                self.setItemCodeValue()
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func setItemCodeValue(){
        if self.itemArray.count > 0 && self.itemCodeArray.count > 0{
            let item = self.itemArray[0]
            let itemCodeGroupArr = self.itemCodeArray.filter{$0.Code == item.DamageCode && $0.CodeGroup == item.DamageCodeGroup }
            if itemCodeGroupArr.count > 0{
                DispatchQueue.main.async {
                    let codeClass = itemCodeGroupArr[0]
                    self.itemCauseCompleteVc?.itemCodeTextField.text = "\(codeClass.Code) - \(codeClass.CodeText)"
                }
            }else{
                if self.itemCodeListArray.count > 0{
                    DispatchQueue.main.async {
                        self.itemCauseCompleteVc?.itemCodeTextField.text = self.itemCodeListArray[0]
                    }
                }
            }
        }else{
            if self.itemCodeListArray.count > 0 {
                DispatchQueue.main.async {
                    self.itemCauseCompleteVc?.itemCodeTextField.text = self.itemCodeListArray[0]
                }
            }
        }
    }
    func setPartGroupValue(){
        if self.itemArray.count > 0 && self.partGroupArray.count > 0{
            let item = self.itemArray[0]
            let itemCodeGroupArr = self.partGroupArray.filter{$0.CodeGroup == item.CodeGroupParts }
            if itemCodeGroupArr.count > 0{
                DispatchQueue.main.async {
                    let codeGroupClass = itemCodeGroupArr[0]
                    self.itemCauseCompleteVc?.itemPartGroupTextField.text = "\(codeGroupClass.CodeGroup) - \(codeGroupClass.ShortText) - \(codeGroupClass.CatalogProfile)"
                    self.getItemPartValue(catalogCode: CATALOGCODE_ITEM, codeGroup: codeGroupClass.CodeGroup)
                }
            }else{
                if self.partListArray.count > 0{
                    DispatchQueue.main.async {
                        self.itemCauseCompleteVc?.itemPartGroupTextField.text = self.partGroupListArray[0]
                        self.partListArray.removeAll()
                        self.partListArray.append("--Select--".localized())
                        self.itemCauseCompleteVc?.itemPartTextField.text = self.partListArray[0]
                    } }
            }
        }else{
            if self.partGroupListArray.count > 0{
                DispatchQueue.main.async {
                    self.itemCauseCompleteVc?.itemPartGroupTextField.text = self.partGroupListArray[0]
                    self.partListArray.removeAll()
                    self.partListArray.append("--Select--".localized())
                    self.itemCauseCompleteVc?.itemPartTextField.text = self.partListArray[0]
                }
            }
            mJCLogger.log("Item Code Groups Not Found", Type: "Debug")
        }
    }
    func getItemPartValue(catalogCode:String, codeGroup:String){
        self.partArray.removeAll()
        self.partListArray.removeAll()
        self.partListArray.append("--Select--".localized())
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.partArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                    for itemCount in 0..<self.partArray.count {
                        let codeGroupClass = self.partArray[itemCount]
                        self.partListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                    }
                }
                self.setItemPartValue()
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func setItemPartValue(){
        if self.itemArray.count > 0 && self.partArray.count > 0{
            let item = self.itemArray[0]
            let itemPartArr = self.partArray.filter{$0.Code == item.ObjectPartCode && $0.CodeGroup == item.CodeGroupParts }
            if itemPartArr.count > 0{
                DispatchQueue.main.async {
                    let codeClass = itemPartArr[0]
                    self.itemCauseCompleteVc?.itemPartTextField.text = "\(codeClass.Code) - \(codeClass.CodeText)"
                }
            }else{
                if self.partListArray.count > 0{
                    DispatchQueue.main.async {
                        self.itemCauseCompleteVc?.itemPartTextField.text = self.partListArray[0]
                    }
                }
            }
        }else{
            if self.partListArray.count > 0{
                DispatchQueue.main.async {
                    self.itemCauseCompleteVc?.itemPartTextField.text = self.partListArray[0]
                }
            }
        }
    }
    func setItemCauseCodeGroupValue(){
        if self.itemCauseArray.count > 0 && self.itemCauseCodeGroupArray.count > 0{
            let itemCause = self.itemCauseArray[0]
            let itemCodeGroupArr = self.itemCauseCodeGroupArray.filter{$0.CodeGroup == itemCause.CodeGroup }
            if itemCodeGroupArr.count > 0{
                DispatchQueue.main.async {
                    let codeGroupClass = itemCodeGroupArr[0]
                    self.itemCauseCompleteVc?.causeCodeGroupTextField.text = "\(codeGroupClass.CodeGroup) - \(codeGroupClass.ShortText) - \(codeGroupClass.CatalogProfile)"
                    self.getItemCauseCodeValue(catalogCode: CATALOGCODE_CAUSE, codeGroup: codeGroupClass.CodeGroup)
                }
            }else{
                if self.itemCodeGroupListArray.count > 0 {
                    DispatchQueue.main.async {
                        self.itemCauseCompleteVc?.causeCodeGroupTextField.text = self.itemCodeGroupListArray[0]
                        self.itemCauseCodeListArray.removeAll()
                        self.itemCauseCodeListArray.append("--Select--".localized())
                        self.itemCauseCompleteVc?.causeCodeTextField.text = self.itemCauseCodeListArray[0]
                    } }
            }
        }else{
            if self.itemCodeGroupListArray.count > 0 {
                DispatchQueue.main.async {
                    self.itemCauseCompleteVc?.causeCodeGroupTextField.text = self.itemCodeGroupListArray[0]
                    self.itemCauseCodeListArray.removeAll()
                    self.itemCauseCodeListArray.append("--Select--".localized())
                    self.itemCauseCompleteVc?.causeCodeTextField.text = self.itemCauseCodeListArray[0]
                }
            }
            mJCLogger.log("Item Code Groups Not Found", Type: "Debug")
        }
    }
    func getItemCauseCodeValue(catalogCode:String, codeGroup:String){
        self.itemCauseCodeArray.removeAll()
        self.itemCauseCodeListArray.removeAll()
        self.itemCauseCodeListArray.append("--Select--".localized())
        CodeGroupModel.getCatalogCodeList(cataLogCode: catalogCode, codeGroup: codeGroup){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.itemCauseCodeArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                    for itemCount in 0..<self.itemCauseCodeArray.count {
                        let codeGroupClass = self.itemCauseCodeArray[itemCount]
                        self.itemCauseCodeListArray.append("\(codeGroupClass.Code) - \(codeGroupClass.CodeText)")
                    }
                }
                self.setItemCauseCodeValue()
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func setItemCauseCodeValue(){
        if self.itemCauseArray.count > 0 && self.itemCauseCodeArray.count > 0{
            let itemCause = self.itemCauseArray[0]
            let itemCodeGroupArr = self.itemCauseCodeArray.filter{$0.Code == itemCause.CauseCode && $0.CodeGroup == itemCause.CodeGroup }
            if itemCodeGroupArr.count > 0{
                DispatchQueue.main.async {
                    let codeClass = itemCodeGroupArr[0]
                    self.itemCauseCompleteVc?.causeCodeTextField.text = "\(codeClass.Code) - \(codeClass.CodeText)"
                }
            }else{
                if self.itemCauseCodeListArray.count > 0{
                    DispatchQueue.main.async {
                        self.itemCauseCompleteVc?.causeCodeTextField.text = self.itemCauseCodeListArray[0]
                    }
                }
            }
        }else{
            if self.itemCauseCodeListArray.count > 0{
                DispatchQueue.main.async {
                    self.itemCauseCompleteVc?.causeCodeTextField.text = self.itemCauseCodeListArray[0]
                }
            }
        }
    }
    func updateNotifcation(){
        
        if self.itemCauseCompleteVc?.notificationClass.Notification != ""{
            if self.itemCauseCompleteVc?.malfunctionEndDateTextField.text != "" && self.itemCauseCompleteVc?.malfunctionEndTimeTextField.text != ""{
                (self.itemCauseCompleteVc?.notificationClass.entity.properties["MalfunctEnd"] as! SODataProperty).value =
                Date(fromString: self.itemCauseCompleteVc!.malfunctionEndDateTextField.text!, format: .custom(localDateFormate), timeZone: .utc, locale: .current) as NSObject!
                let malfuncEndTime = SODataDuration()
                let malfuncEndTimeArray = self.itemCauseCompleteVc?.malfunctionEndTimeTextField.text?.components(separatedBy: ":")
                if malfuncEndTimeArray?.count ?? 0 > 0{
                    malfuncEndTime.hours = Int(malfuncEndTimeArray![0]) as NSNumber?
                    malfuncEndTime.minutes = Int(malfuncEndTimeArray![1]) as NSNumber?
                    malfuncEndTime.seconds = 0
                }
                (self.itemCauseCompleteVc?.notificationClass.entity.properties["MalfunctEndTime"] as! SODataProperty).value = malfuncEndTime
            }
            (self.itemCauseCompleteVc?.notificationClass.entity.properties["ShortText"] as! SODataProperty).value = (self.itemCauseCompleteVc?.notificationDescrpTextField.text! ?? "") as NSObject
            (self.itemCauseCompleteVc?.notificationClass.entity.properties["TechInspectnBy"] as! SODataProperty).value = (self.itemCauseCompleteVc?.personRespTextField.text! ?? "") as NSObject
            (self.itemCauseCompleteVc?.notificationClass.entity.properties["TechInspecOn"] as! SODataProperty).value = Date().localDate() as NSObject
            var entityDict = Dictionary<String,Any>()
            entityDict["collectionPath"] = woNotificationHeaderSet
            entityDict["entity"] = self.itemCauseCompleteVc?.notificationClass.entity
            entityDict["type"] = "Update"
            self.itemCauseCompleteVc?.updateEntityArr.append(entityDict)
            self.updateItem()
        }
    }
    func updateItem(){
        
        if self.itemArray.count > 0{
            let itemClass = self.itemArray[0]
            if self.itemCauseCompleteVc?.itemCodeGroupTextField.text == "--Select--".localized() && self.itemCauseCompleteVc?.itemCodeTextField.text == "--Select--".localized() && self.itemCauseCompleteVc?.itemPartGroupTextField.text == "--Select--".localized() && self.itemCauseCompleteVc?.itemPartTextField.text == "--Select--".localized(){
                self.itemCauseCompleteVc!.suspendViewModel.entityDict["editNotification"] = self.itemCauseCompleteVc!.updateEntityArr
                self.itemCauseCompleteVc!.suspendViewModel.validateCompletionFeatures()
            }else{
                if self.itemCauseCompleteVc?.itemCodeGroupTextField.text != "--Select--".localized() && self.itemCauseCompleteVc?.itemCodeTextField.text != "--Select--".localized(){
                    let codeGroupArr = self.itemCauseCompleteVc!.itemCodeGroupTextField.text!.components(separatedBy: " - ")
                    if codeGroupArr.count > 0 {
                        (itemClass.entity.properties["DamageCodeGroup"] as! SODataProperty).value = codeGroupArr[0] as NSObject
                    }
                    let codeArr = self.itemCauseCompleteVc!.itemCodeTextField.text!.components(separatedBy: " - ")
                    if codeArr.count > 0 {
                        (itemClass.entity.properties["DamageCode"] as! SODataProperty).value = codeArr[0] as NSObject
                    }
                }
                if self.itemCauseCompleteVc?.itemPartGroupTextField.text != "--Select--".localized() && self.itemCauseCompleteVc?.itemPartTextField.text != "--Select--".localized(){
                    let partGroupArr = self.itemCauseCompleteVc!.itemPartGroupTextField.text!.components(separatedBy: " - ")
                    if partGroupArr.count > 0{
                        (itemClass.entity.properties["CodeGroupParts"] as! SODataProperty).value = partGroupArr[0] as NSObject
                    }
                    let partArr = self.itemCauseCompleteVc!.itemPartTextField.text!.components(separatedBy: " - ")
                    if partArr.count > 0{
                        (itemClass.entity.properties["ObjectPartCode"] as! SODataProperty).value = partArr[0] as NSObject
                    }
                }
                var entityDict = Dictionary<String,Any>()
                entityDict["collectionPath"] = woNotificationHeaderSet
                entityDict["entity"] = itemClass.entity
                entityDict["type"] = "Update"
                self.itemCauseCompleteVc?.updateEntityArr.append(entityDict)
                self.updateItemCause()
            }
        }else if self.itemCauseCompleteVc?.itemCodeGroupTextField.text == "--Select--".localized() && self.itemCauseCompleteVc?.itemCodeTextField.text == "--Select--".localized() && self.itemCauseCompleteVc?.itemPartGroupTextField.text == "--Select--".localized() && self.itemCauseCompleteVc?.itemPartTextField.text == "--Select--".localized(){
            self.itemCauseCompleteVc!.suspendViewModel.entityDict["editNotification"] = self.itemCauseCompleteVc!.updateEntityArr
            self.itemCauseCompleteVc!.suspendViewModel.validateCompletionFeatures()
        }else if self.itemCauseCompleteVc?.itemCodeGroupTextField.text != "--Select--".localized() &&   self.itemCauseCompleteVc?.itemCodeTextField.text != "--Select--".localized() && self.itemCauseCompleteVc?.itemPartGroupTextField.text != "--Select--".localized() && self.itemCauseCompleteVc?.itemPartTextField.text != "--Select--".localized(){
            if self.itemCauseCompleteVc?.itemCodeGroupTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_damage_code_Group".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc?.itemCodeTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_samage_code".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc?.itemPartGroupTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_part_group".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc?.itemPartTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_part".localized(), button: okay)
                return
            }else{
                self.creatItem()
            }
        }else{
            if self.itemCauseCompleteVc?.itemCodeGroupTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_damage_code_Group".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc?.itemCodeTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_samage_code".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc?.itemPartGroupTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_part_group".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc?.itemPartTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_part".localized(), button: okay)
                return
            }else{
                self.creatItem()
            }
        }
    }
    func creatItem(){
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_ITEM)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ChangedOn")
        let date = Date().localDate()
        prop!.value = date as NSObject
        property.add(prop!)
        
        if self.itemCauseCompleteVc!.itemPartGroupTextField.text != ""{
            let partGrpArr = self.itemCauseCompleteVc!.itemPartGroupTextField.text!.components(separatedBy: " - ")
            if partGrpArr.count > 1{
                
                prop = SODataPropertyDefault(name: "CodeGroupParts")
                prop!.value = partGrpArr[0] as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "CodeGroupPartsText")
                prop!.value = partGrpArr[1] as NSObject
                self.property.add(prop!)
                
            }
        }
        if self.itemCauseCompleteVc!.itemPartTextField.text != ""{
            let partDrpArr = self.itemCauseCompleteVc!.itemPartTextField.text!.components(separatedBy: " - ")
            if partDrpArr.count > 0{
                prop = SODataPropertyDefault(name: "ObjectPartCode")
                prop!.value = partDrpArr[0] as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "ObjectPartCodeText")
                prop!.value = partDrpArr[1] as NSObject
                self.property.add(prop!)
            }
        }
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = date as NSObject
        property.add(prop!)
        
        if self.itemCauseCompleteVc!.itemCodeGroupTextField.text != "" {
            prop = SODataPropertyDefault(name: "DamageCodeGroup")
            let codeGroupArr = self.itemCauseCompleteVc!.itemCodeGroupTextField.text!.components(separatedBy: " - ")
            if codeGroupArr.count > 0{
                prop!.value = codeGroupArr[0] as NSObject
                property.add(prop!)
            }
        }
        if self.itemCauseCompleteVc!.itemCodeTextField.text != "" {
            prop = SODataPropertyDefault(name: "DamageCode")
            let codeArr = self.itemCauseCompleteVc!.itemCodeTextField.text!.components(separatedBy: " - ")
            if codeArr.count > 1{
                let damageCodePredicate : NSPredicate = NSPredicate(format: "SELF.Code == %@ and SELF.CodeText == %@",codeArr[0],codeArr[1])
                let codeGroupFilteredArray = (self.itemCauseCompleteVc!.itemCauseCompleteVMModel.itemCodeArray as NSArray).filtered(using: damageCodePredicate) as! [CodeGroupModel]
                if codeGroupFilteredArray.count > 0{
                    let codegroup = codeGroupFilteredArray[0]
                    prop!.value = codegroup.Code as NSObject
                    property.add(prop!)
                    
                    prop = SODataPropertyDefault(name: "Version")
                    prop!.value = codegroup.Version as NSObject
                    property.add(prop!)
                }else{
                    prop!.value = "" as NSObject
                    property.add(prop!)
                }
            }
        }
        prop = SODataPropertyDefault(name: "DefectTypes")
        prop!.value = "\(CATALOGCODE_DAMAGE)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userSystemID.uppercased() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(self.itemCauseCompleteVc!.notificationNumTextField.text!)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ShortText")
        prop!.value = "\(self.itemCauseCompleteVc!.notificationDescrpTextField.text!)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = "0001" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.itemCauseCompleteVc!.notificationNumTextField.text!)" as NSObject
        property.add(prop!)
        
        print("================= Notification Item Property Start =================")
        var itemSet_Entity = String()
        var itemSet = String()
        
        itemSet_Entity = woNotificationItemCollectionEntity
        itemSet = woNotificationItemCollection
        let entity = SODataEntityDefault(type: itemSet_Entity)
        for prop in property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            print("Key : \(proper.name)")
            print("Value :\(proper.value!)")
            print("...............")
        }
        
        var entityDict = Dictionary<String,Any>()
        entityDict["collectionPath"] = itemSet
        entityDict["entity"] = entity
        entityDict["type"] = "Create"
        self.itemCauseCompleteVc!.updateEntityArr.append(entityDict)
        self.updateItemCause()
    }
    func updateItemCause(){
        
        if self.itemCauseArray.count > 0{
            
            if self.itemCauseCompleteVc!.causeCodeGroupTextField.text != "--Select--".localized() && self.itemCauseCompleteVc!.causeCodeTextField.text != "--Select--".localized(){
                
                let causeClass = self.itemCauseArray[0]
                let causeGrpArr = self.itemCauseCompleteVc!.causeCodeGroupTextField.text!.components(separatedBy: " - ")
                if causeGrpArr.count > 0{
                    (causeClass.entity.properties["CodeGroup"] as! SODataProperty).value = causeGrpArr[0] as NSObject
                }
                let causeCodeArr = self.itemCauseCompleteVc!.causeCodeTextField.text!.components(separatedBy: " - ")
                if causeCodeArr.count > 0{
                    (causeClass.entity.properties["CauseCode"] as! SODataProperty).value = causeCodeArr[0] as NSObject
                }
                (causeClass.entity.properties["CauseText"] as! SODataProperty).value = "\(self.itemCauseCompleteVc!.causeTextField.text ?? "")" as NSObject
                var entityDict = Dictionary<String,Any>()
                entityDict["collectionPath"] = woNotificationItemCausesCollection
                entityDict["entity"] = causeClass.entity
                entityDict["type"] = "Update"
                self.itemCauseCompleteVc!.updateEntityArr.append(entityDict)
                self.itemCauseCompleteVc!.suspendViewModel.entityDict["editNotification"] = self.itemCauseCompleteVc!.updateEntityArr
                self.itemCauseCompleteVc!.suspendViewModel.validateCompletionFeatures()
            }else{
                self.itemCauseCompleteVc!.suspendViewModel.entityDict["editNotification"] = self.itemCauseCompleteVc!.updateEntityArr
                self.itemCauseCompleteVc!.suspendViewModel.validateCompletionFeatures()
            }
        }else if self.itemCauseCompleteVc!.causeCodeGroupTextField.text == "--Select--".localized() && self.itemCauseCompleteVc!.causeCodeTextField.text == "--Select--".localized(){
            self.itemCauseCompleteVc!.suspendViewModel.entityDict["editNotification"] = self.itemCauseCompleteVc!.updateEntityArr
            self.itemCauseCompleteVc!.suspendViewModel.validateCompletionFeatures()
        }else if self.itemCauseCompleteVc!.causeCodeGroupTextField.text != "--Select--".localized() && self.itemCauseCompleteVc!.causeCodeTextField.text != "--Select--".localized(){
            if self.itemCauseCompleteVc!.causeCodeGroupTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_cause_code_group".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc!.causeCodeTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_cause_code".localized(), button: okay)
                return
            }else{
                self.createItemCause()
            }
        }else{
            if self.itemCauseCompleteVc!.causeCodeGroupTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_cause_code_group".localized(), button: okay)
                return
            }else if self.itemCauseCompleteVc!.causeCodeTextField.text == "--Select--".localized(){
                mJCAlertHelper.showAlert(self.itemCauseCompleteVc!, title: alerttitle, message: "Please_select_cause_code".localized(), button: okay)
                return
            }else{
                self.createItemCause()
            }
        }
        
    }
    func createItemCause(){
        
        let property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "CatalogType")
        prop!.value = "\(CATALOGCODE_TASK)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Cause")
        prop!.value = "0001" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ChangedOn")
        let date = Date().localDate()
        prop!.value = date as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = date as NSObject
        property.add(prop!)
        
        if self.itemCauseCompleteVc!.causeCodeTextField.text != "" {
            prop = SODataPropertyDefault(name: "CauseCode")
            let causeCodeArr = self.itemCauseCompleteVc!.causeCodeTextField.text!.components(separatedBy: " - ")
            if causeCodeArr.count > 0{
                prop!.value = causeCodeArr[0] as NSObject
                property.add(prop!)
            }else{
                prop!.value = "" as NSObject
                property.add(prop!)
            }
        }
        if self.itemCauseCompleteVc!.causeCodeGroupTextField.text != "" {
            prop = SODataPropertyDefault(name: "CodeGroup")
            let causeGrpArr = self.itemCauseCompleteVc!.causeCodeGroupTextField.text!.components(separatedBy: " - ")
            if causeGrpArr.count > 0{
                prop!.value = causeGrpArr[0] as NSObject
                property.add(prop!)
            }
        }
        prop = SODataPropertyDefault(name: "DefectTypes")
        prop!.value = "\(CATALOGCODE_DAMAGE)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userSystemID.uppercased() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Item")
        prop!.value = "0001" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Notification")
        prop!.value = "\(self.itemCauseCompleteVc!.notificationNumTextField.text!)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CauseText")
        prop!.value = "\(self.itemCauseCompleteVc!.causeTextField.text ?? "")" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SortNumber")
        prop!.value = "0001" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "TempID")
        prop!.value = "\(self.itemCauseCompleteVc!.notificationNumTextField.text!)" as NSObject
        property.add(prop!)
        
        var entitytypStr = String()
        var entitySet = String()
        
        entitytypStr = woNotificationItemCausesCollectionEntity
        entitySet = woNotificationItemCausesCollection
        
        let causeEntity = SODataEntityDefault(type: entitytypStr)
        for prop in property {
            
            let proper = prop as! SODataProperty
            causeEntity?.properties[proper.name] = proper
            print("Key : \(proper.name)")
            print("Value :\(proper.value!)")
            print("..............")
        }
        var entityDict = Dictionary<String,Any>()
        entityDict["collectionPath"] = woNotificationItemCausesCollection
        entityDict["entity"] = causeEntity
        entityDict["type"] = "Create"
        self.itemCauseCompleteVc!.updateEntityArr.append(entityDict)
        self.itemCauseCompleteVc!.suspendViewModel.entityDict["editNotification"] = self.itemCauseCompleteVc!.updateEntityArr
        self.itemCauseCompleteVc!.suspendViewModel.validateCompletionFeatures()
    }
}
