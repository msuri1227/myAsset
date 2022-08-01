//
//  OnlineSearchViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 15/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class OnlineSearchViewModel {
    var vcOnlineSearch: OnlineSearchVC?
    var maintPlantArray = [MaintencePlantModel]()
    var mainWorkCenterArray = [WorkCenterModel]()
    var workCentersListArray = [String]()
    var priorityArray = NSMutableArray()
    var priorityListArray = NSMutableArray()
    var maintPlantdecArray = [String]()
    var superiorWCListArray = [String]()
    
    func getOnlineResults(query:String) {
        mJCLogger.log("Starting", Type: "info")
        if searchType == "WorkOrders"{
            
            currentMasterView = "WorkOrder"
            
            let httpConvMan1 = HttpConversationManager.init()
            let commonfig1 = CommonAuthenticationConfigurator.init()
            if authType == "Basic"{
                commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
            }else if authType == "SAML"{
                commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
            }
            commonfig1.configureManager(httpConvMan1)
            
            let  workorderDict = WoHeaderModel.getOnlineWorkOrderList(filterQuery: query, navProperty: "NAVOPERA", httpConvManager: httpConvMan1!)
            
            if let status = workorderDict["Status"] as? Int{
                if status == 200{
                    if let dict = workorderDict["Response"] as? NSMutableDictionary{
                        let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: WoHeaderModel.self)
                        if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                            for i in 0..<responseArr.count{
                                let oprDict = ODSHelperClass.getListInFormte(dictionary: responseArr[i].NAVOPERA, entityModelClassType: WoOperationModel.self)
                                responseArr[i].NAVOPERA = NSMutableDictionary(dictionary: oprDict)
                            }
                            mJCLogger.log("Response \(responseArr)", Type: "Debug")
                            onlineSearchArray = responseArr
                        }
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: workorderDict["Status"]))", Type: "Error")
                }
            }
            mJCLoader.stopAnimating()
            
        }else{
            currentMasterView = "Notification"
            let httpConvMan1 = HttpConversationManager.init()
            let commonfig1 = CommonAuthenticationConfigurator.init()
            if authType == "Basic"{
                commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
            }else if authType == "SAML"{
                commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
            }
            commonfig1.configureManager(httpConvMan1)
            let NotifiDict = NotificationModel.getOnlineNotificationList(filterQuery: query, navProperty: "NavNOItem", httpConvManager: httpConvMan1!)
            
            if let status = NotifiDict["Status"] as? Int{
                if status == 200{
                    if let dict = NotifiDict["Response"] as? NSMutableDictionary{
                        let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: NotificationModel.self)
                        if let responseArr = responseDict["data"] as? [NotificationModel]{
                            for i in 0..<responseArr.count{
                                let itemDict = ODSHelperClass.getListInFormte(dictionary: responseArr[i].NavNOItem, entityModelClassType: NotificationItemsModel.self)
                                responseArr[i].NavNOItem = NSMutableDictionary(dictionary: itemDict)
                            }
                            mJCLogger.log("Response : \(responseArr)", Type: "Debug")
                            onlineSearchArray = responseArr
                        }
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: NotifiDict["Status"]))", Type: "Error")
                }
            }
            mJCLoader.stopAnimating()
        }
        self.vcOnlineSearch?.updateUIGetOnlineResults(queryValue: query)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Main Plant List......
    func maintPlantList(){
        mJCLogger.log("Starting", Type: "info")
        self.maintPlantArray.removeAll()
        if globalPlanningPlantArray.count > 0 {
            self.maintPlantArray =  globalPlanningPlantArray
            self.vcOnlineSearch?.plantTextField.text = selectStr
            
            self.workCentersListArray.removeAll()
            self.maintPlantdecArray.removeAll()
            self.maintPlantdecArray.append(selectStr)
            if self.maintPlantArray.count > 0 {
                for item in self.maintPlantArray {
                    self.maintPlantdecArray.append("\(item.Plant) - \(item.Name1)")
                }
                if let arr : [String] = self.maintPlantdecArray as NSArray as? [String]{
                    vcOnlineSearch?.plantTextField.optionArray = arr
                    vcOnlineSearch?.plantTextField.checkMarkEnabled = false
                }
            }
            self.getmainWorkCentersList()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Main Work Centers List......
    func getmainWorkCentersList()  {
        mJCLogger.log("Starting", Type: "info")
        self.mainWorkCenterArray.removeAll()
        if globalWorkCtrArray.count > 0 {
            self.mainWorkCenterArray = globalWorkCtrArray
            self.vcOnlineSearch?.mainWrkCtrTextField.text = selectStr
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Set Work Center Value......
    func setWorkCenterValue() {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersListArray.removeAll()
        self.workCentersListArray.append(selectStr)
        var plant = String()
        DispatchQueue.main.async {
            if self.vcOnlineSearch?.plantTextField.text != "" || self.vcOnlineSearch?.plantTextField.text != nil {
                let arr = self.vcOnlineSearch?.plantTextField.text!.components(separatedBy: " - ")
                if arr!.count > 0{
                    plant = (arr?[0])!
                }
                let filteredArray = self.mainWorkCenterArray.filter{$0.Plant == "\(plant)"}
                if filteredArray.count > 0{
                    for item in filteredArray {
                        self.workCentersListArray.append(item.WorkCenter + " - " + item.ShortText)
                    }
                    self.vcOnlineSearch?.mainWrkCtrTextField.text = self.workCentersListArray[0]
                }
            }else{
                self.workCentersListArray.removeAll()
                self.workCentersListArray.append(selectStr)
                if self.workCentersListArray.count > 0 {
                    self.vcOnlineSearch?.mainWrkCtrTextField.text = self.workCentersListArray[0]
                }
            }
            
            if self.workCentersListArray.count > 0{
                self.vcOnlineSearch?.mainWrkCtrTextField.optionArray = self.workCentersListArray
                self.vcOnlineSearch?.mainWrkCtrTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Main Plant List......
    func getSuperiorWorkCenter() {
        self.vcOnlineSearch?.superiorWrkCtrTextField.text = selectStr
    }
    //MARK:- Get Priority List..
    func getPriorityList()  {
        mJCLogger.log("Starting", Type: "info")
        self.priorityArray.removeAllObjects()
        if globalPriorityArray.count > 0 {
            let array = globalPriorityArray as NSArray
            let descriptor:NSSortDescriptor = NSSortDescriptor (key:"PriorityText", ascending : true)
            let sortedArray:NSArray = (array.sortedArray(using : [descriptor]) as NSArray)
            self.priorityArray.addObjects(from: sortedArray as! [Any])
            self.setPriorityValue()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Set Priority..
    func setPriorityValue()  {
        mJCLogger.log("Starting", Type: "info")
        self.priorityListArray.removeAllObjects()
        self.priorityListArray.add(selectStr)
        DispatchQueue.main.async {
            self.vcOnlineSearch?.priorityTextField.text = selectStr
            for item in self.priorityArray {
                self.priorityListArray.add((item as! PriorityListModel).PriorityText)
            }
            if self.priorityListArray.count > 0{
                self.vcOnlineSearch?.priorityTextField.optionArray = self.priorityListArray as! [String]
                self.vcOnlineSearch?.priorityTextField.checkMarkEnabled = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}
