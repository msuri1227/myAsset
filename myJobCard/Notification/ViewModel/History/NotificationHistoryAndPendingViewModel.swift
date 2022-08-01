//
//  NotificationHistoryAndPendingViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class NotificationHistoryAndPendingViewModel {
    var vcNOHistoryPending: NotificationHistoryAndPendingVC?
    var historyArray = [HistoryAndPendingModel]()
    var pendingArray = [HistoryAndPendingModel]()
    
    //MARK:- Get History Notification List..
    func getHistory() {
        mJCLogger.log("Starting", Type: "info")
        var query = ""

        if singleNotification.Equipment == "" && singleNotification.FunctionalLoc != ""{
            query = "$filter=(FunctionalLoc eq '\(singleNotification.FunctionalLoc)')&$orderby=Notification"
        }else if  singleNotification.Equipment != "" && singleNotification.FunctionalLoc == ""{
            query = "$filter=(Equipment eq '\(singleNotification.Equipment)')&$orderby=Notification"
        }else{
            query = ""
        }
        HistoryAndPendingModel.getNotificatonHistory(notifNum: "", equipNum: "\(singleNotification.Equipment)", funcLoc: "\(singleNotification.FunctionalLoc)") { (responseDict, error) in
            if error == nil{
                if let responseArr = responseDict["data"] as? [HistoryAndPendingModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.historyArray = responseArr
                    self.vcNOHistoryPending?.updateUIGetNotificationHistory()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.vcNOHistoryPending?.updateUIHistoryWithoutResponse()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Pending Notification List..
    func getPending() {
  
        mJCLogger.log("Starting", Type: "info")
        var query = ""
        if singleNotification.Equipment != "" && singleNotification.FunctionalLoc == ""{
            query = "$filter=(Equipment eq '\(singleNotification.Equipment)')&$orderby=Notification"
        }else if  singleNotification.Equipment == "" && singleNotification.FunctionalLoc != ""{
            query = "$filter=(FunctionalLoc eq '\(singleNotification.FunctionalLoc)')&$orderby=Notification"
        }else{
            query = ""
        }
        HistoryAndPendingModel.getNotificatonPending(notifNum: "", equipNum: "\(singleNotification.Equipment)", funcLoc: "\(singleNotification.FunctionalLoc)",filterQuery: query) { (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [HistoryAndPendingModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if DeviceType == iPad{
                        self.pendingArray = responseArr
                    }else{
                        self.historyArray = responseArr
                    }
                    self.vcNOHistoryPending?.updateUIGetNotificationPending()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.vcNOHistoryPending?.updateUIPendingWithoutResponse()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get LongText List..
    func getLongTextSet(NotificationNum : String, index : Int, from: String) {
        
        mJCLogger.log("Starting", Type: "info")
        let defineReq = "$filter=(endswith(TextName, '" + NotificationNum + "') eq true)"
        LongTextModel.getNoHistoryPendingLongTextSet(filterQuery: defineReq){ (response, error)  in
            
            if(error == nil) {
                mJCLogger.log("Response :\(response.count)", Type: "Debug")
                DispatchQueue.main.async {
                    if ((response["data"] as AnyObject).count > 0) {
                        self.vcNOHistoryPending?.updateUIGetLongText(from: from, indexValue: index, notesAvailable: true)
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                        self.vcNOHistoryPending?.updateUIGetLongText(from: from, indexValue: index, notesAvailable: false)
                    }
                }
            }
            else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

