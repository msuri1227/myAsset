//
//      .swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class NotificationActivityViewModel {
    
    var vc: NotificationActivityVC?
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var entities = NSMutableArray()
    var selectedActivity = String()
    var singleActivityArray = [NotificationActivityModel]()
    var totalActivityArray = [NotificationActivityModel]()
    var partArray = Array<CodeGroupModel>()

    //Get Single Activity Data..
    func getSingleActivityData() {
        mJCLogger.log("Starting", Type: "info")
        var itemNum = String()
        if vc?.isFrom == "ItemActivities"{
            itemNum = vc?.selectedItemNum ?? ""
        }else{
            itemNum = "0000"
        }
        

        if vc?.notificationFrom == "FromWorkorder"{
            if vc?.isFrom == "ItemActivities"{
                NotificationActivityModel.getWoNoItemActivityDetails(notifNum: selectedNotificationNumber, itemNum: itemNum , activityNum: selectedActivity) { (responseDict, error)  in
                    if error == nil{
                        if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                            DispatchQueue.main.async {
                                self.singleActivityArray = responseArr
                                self.vc?.getSingleActivityDataUI()

                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            self.vc?.getSingleActivityDataUI()

                        }
                    }else{
                        
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }else{

                NotificationActivityModel.getWoNotificationActivityDetails(notifNum: selectedNotificationNumber, activityNum: selectedActivity)  { (responseDict, error)  in
                    if error == nil{
                        if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                            DispatchQueue.main.async {
                                self.singleActivityArray = responseArr
                                self.vc?.getSingleActivityDataUI()

                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            self.vc?.getSingleActivityDataUI()

                        }
                    }else{
                        
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
           
        }else{
            if vc?.isFrom == "ItemActivities"{
             
                NotificationActivityModel.getNoItemActivityDetails(notifNum: selectedNotificationNumber, itemNum: itemNum, activityNum: selectedActivity) { (responseDict, error)  in
                    if error == nil{
                        if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                self.singleActivityArray = responseArr
                            DispatchQueue.main.async {
                                self.vc?.getSingleActivityDataUI()
                            }

                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getSingleActivityDataUI()
                            }

                        }
                    }else{
                        
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }else{
                
                NotificationActivityModel.getNotificationActivityDetails(notifNum: selectedNotificationNumber, activityNum: selectedActivity,filterQuery: ""){ (responseDict, error)  in
                    if error == nil{
                        if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                self.singleActivityArray = responseArr
                            DispatchQueue.main.async {
                                self.vc?.getSingleActivityDataUI()
                            }

                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            DispatchQueue.main.async {
                                self.vc?.getSingleActivityDataUI()
                            }

                        }
                    }else{
                        
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Notification Activity list..
    func getNotificationActivityData() {
        var itemNum = String()
        if vc?.isFrom == "ItemActivities"{
            itemNum = vc?.selectedItemNum ?? ""
        }else{
            itemNum = "0000"
        }
        mJCLogger.log("Starting", Type: "info")
        if vc?.notificationFrom == "FromWorkorder"{
            NotificationActivityModel.getWoNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: itemNum) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalActivityArray = responseArr
                        DispatchQueue.main.async {
                            if(self.totalActivityArray.count > 0) {
                                if DeviceType == iPad{
                                    for i in 0..<self.totalActivityArray.count {
                                        let notificationActivityClass = self.totalActivityArray[i]
                                        notificationActivityClass.isSelected = false
                                    }
                                    if selectedAcitivity != "" {
                                        for i in 0..<self.totalActivityArray.count {
                                            let notificationActivityClass = self.totalActivityArray[i]
                                            let currentActivityNum = notificationActivityClass.Activity
                                            if selectedAcitivity == currentActivityNum {
                                                notificationActivityClass.isSelected = true
                                                self.selectedActivity = notificationActivityClass.Activity
                                                break
                                            }else {
                                                let notificationActivityClass = self.totalActivityArray[0]
                                                notificationActivityClass.isSelected = true
                                                self.selectedActivity = notificationActivityClass.Activity
                                            }
                                        }
                                    }else {
                                        let notificationActivityClass = self.totalActivityArray[0]
                                        notificationActivityClass.isSelected = true
                                        self.selectedActivity = notificationActivityClass.Activity
                                    }
                                }
                                self.getSingleActivityData()
                                self.vc?.getNotificationActivityDataUI()

                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                                self.vc?.getNotificationActivityDataUI()
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        self.vc?.getNotificationActivityDataUI()
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationActivityModel.getNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: itemNum, filterQuery: "") { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalActivityArray = responseArr
                        DispatchQueue.main.async {
                            if(self.totalActivityArray.count > 0) {
                                
                                if DeviceType == iPad{
                                    for i in 0..<self.totalActivityArray.count {
                                        let notificationActivityClass = self.totalActivityArray[i]
                                        notificationActivityClass.isSelected = false
                                    }
                                    if selectedAcitivity != "" {
                                        for i in 0..<self.totalActivityArray.count {
                                            let notificationActivityClass = self.totalActivityArray[i]
                                            let currentActivityNum = notificationActivityClass.Activity
                                            if selectedAcitivity == currentActivityNum {
                                                notificationActivityClass.isSelected = true
                                                self.selectedActivity = notificationActivityClass.Activity
                                                break
                                             }
                                            else {
                                                let notificationActivityClass = self.totalActivityArray[0]
                                                notificationActivityClass.isSelected = true
                                                self.selectedActivity = notificationActivityClass.Activity
                                            }
                                        }
                                        
                                    }
                                    else {
                                        let notificationActivityClass = self.totalActivityArray[0]
                                        notificationActivityClass.isSelected = true
                                        self.selectedActivity = notificationActivityClass.Activity
                                    }
                                   
                                }
                                
                                self.vc?.getNotificationActivityDataUI()

                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                                self.vc?.getNotificationActivityDataUI()
                                
                            }
                            self.getSingleActivityData()

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
}
