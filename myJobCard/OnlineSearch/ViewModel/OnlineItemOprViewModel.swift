//
//  OnlineItemOprViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 13/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class OnlineItemOprViewModel {
    var vcOnlineItemOpr: OnlineItemOprVC?
    var totalItemsArr = [Any]()

    func getOnlineNotificationItem() {
        mJCLogger.log("Starting", Type: "info")
        if let itemArr = singleNotification.NavNOItem["data"] as? [NotificationItemsModel]{
            self.totalItemsArr.removeAll()
            self.totalItemsArr = itemArr
            mJCLogger.log("Response: \(itemArr.count)", Type: "Debug")
            self.vcOnlineItemOpr?.updateUIOnlineNotificationItem()
        }else{
            mJCLogger.log("No Data Available", Type: "Debug")
            self.vcOnlineItemOpr?.updateUIOnlineWithoutResponse()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getOnlineWorkorderOperation() {
        mJCLogger.log("Starting", Type: "info")
        if let itemArr = singleWorkOrder.NAVOPERA["data"] as? [WoOperationModel] {
            self.totalItemsArr.removeAll()
            self.totalItemsArr = itemArr
            mJCLogger.log("Response: \(itemArr.count)", Type: "Debug")
            self.vcOnlineItemOpr?.updateUIOnlineWorkOrderOperation()
        }else{
            mJCLogger.log("No Data Available", Type: "Debug")
            self.vcOnlineItemOpr?.updateUIOnlineWithoutResponse()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
