//
//  NotificationItemViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//



import Foundation
import mJCLib
import ODSFoundation

class NotificationItemViewModel {
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var singleItemArray = [NotificationItemsModel]()
    var totalItemArray = [NotificationItemsModel]()
    
    var vc: NotificationItemVC?
    var partArray = Array<CodeGroupModel>()
    var damageArray = Array<CodeGroupModel>()

    
    //MARK:- Get Notification Items list..
    func getNotificationItemsData() {
        mJCLogger.log("Starting", Type: "info")
        if vc!.notificationFrom == "FromWorkorder"{
            if DeviceType == iPad{
                selectedItem = ""
            }
            NotificationItemsModel.getWoNotificationItemsList(notifNum: selectedNotificationNumber) {  (responseDict, error)  in
                if error == nil{
                    DispatchQueue.main.async {
                        self.totalItemArray.removeAll()
                        if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                            self.totalItemArray = responseArr
                            NOItemCount = self.totalItemArray.count
                            if(self.totalItemArray.count > 0) {
                                for i in 0..<self.totalItemArray.count {
                                    let notificationActivity = self.totalItemArray[i]
                                    notificationActivity.isSelected = false
                                }
                                if selectedItem != "" {
                                    for i in 0..<self.totalItemArray.count {
                                        let notificationActivity = self.totalItemArray[i]
                                        let currentItemNum = notificationActivity.Item
                                        if selectedItem == currentItemNum {
                                            selectedItem = notificationActivity.Item
                                            notificationActivity.isSelected = true
                                            break
                                        }
                                        else {
                                            let notificationActivity = self.totalItemArray[0]
                                            selectedItem = notificationActivity.Item
                                            notificationActivity.isSelected = true
                                        }
                                    }
                                }
                                else {
                                    let notificationActivity = self.totalItemArray[0]
                                    selectedItem = notificationActivity.Item
                                    selectedItem = notificationActivity.Item
                                    notificationActivity.isSelected = true
                                }
                                DispatchQueue.main.async {
                                    if DeviceType == iPhone && self.vc?.totalItemTableView != nil{
                                        self.vc?.totalItemTableView.reloadData()
                                    }
                                    self.getSingleItemData()
                                }
                            }
                            else {
                                
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.getNotificationItemsDataUI()
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationItemsModel.getNotificationItemsList(notifNum: singleNotification.Notification){ (responseDict, error)  in
                if error == nil{
                    self.totalItemArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalItemArray = responseArr
                            NOItemCount = self.totalItemArray.count
                            if(self.totalItemArray.count > 0) {
                                if DeviceType == iPad{
                                    for i in 0..<self.totalItemArray.count {
                                        let notificationActivity = self.totalItemArray[i]
                                        notificationActivity.isSelected = false
                                    }
                                    if selectedItem != "" {
                                        for i in 0..<self.totalItemArray.count {
                                            let notificationActivity = self.totalItemArray[i]
                                            let currentItemNum = notificationActivity.Item
                                            if selectedItem == currentItemNum {
                                                selectedItem = notificationActivity.Item
                                                notificationActivity.isSelected = true
                                                break
                                            }
                                            else {
                                                let notificationActivity = self.totalItemArray[0]
                                                selectedItem = notificationActivity.Item
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                    else {
                                        let notificationActivity = self.totalItemArray[0]
                                        selectedItem = notificationActivity.Item
                                        notificationActivity.isSelected = true
                                    }
                                }
                                self.getSingleItemData()
                            }
                            else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            
                            self.vc?.getNotificationItemsDataUI()
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Notification single Item..
    func getSingleItemData() {
        mJCLogger.log("Starting", Type: "info")
        if vc!.notificationFrom == "FromWorkorder"{
            NotificationItemsModel.getWoNotificationItemDetails(notifNum: selectedNotificationNumber, itemNum: selectedItem) { (responseDict, error)  in
                if error == nil{
                    self.singleItemArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.singleItemArray = responseArr
                            self.vc?.getSingleItemDataUI()
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationItemsModel.getNotificationItemsDetails(notifNum: singleNotification.Notification, itemNum: selectedItem, filterQuery: "") { (responseDict, error)  in
                if error == nil{
                    self.singleItemArray.removeAll()
                    if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.singleItemArray = responseArr
                            self.vc?.getSingleItemDataUI()
                        }
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Parts Value..
    func getPartValue(catalogCode:String, codeGroup:String,code:String){
        mJCLogger.log("Starting", Type: "info")
        let filter = "$filter=(Catalog eq '\(catalogCode)' and CodeGroup eq '\(codeGroup)' and Code eq '\(code)')"
 
        CodeGroupModel.getCatalogCodeList(filterQuery:filter ){ (responseDict, error)  in
            if error == nil{
                
                self.partArray.removeAll()
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")

                    if responseArr.count > 0{
                        self.partArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    
    //MARK:- Get Damage Value..
    func getDamageValue(catalogCode:String, codeGroup:String,code:String) {
        mJCLogger.log("Starting", Type: "info")
    
        let filter = "$filter=(Catalog eq '\(catalogCode)' and CodeGroup eq '\(codeGroup)' and Code eq '\(code)')"

        CodeGroupModel.getCatalogCodeList(filterQuery: filter){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [CodeGroupModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")

                    if responseArr.count > 0{
                        self.damageArray = responseArr.sorted{$0.Code.compare($1.Code) == .orderedAscending }
                    }
                }else{
                    
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
        
    }
}
