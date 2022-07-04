//
//  NotificationOverviewViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class NotificationOverviewViewModel {
    var vcNOOverview: NotificationOverViewVC?
    var gotoListArray = NSMutableArray()
    var notificationArray = [NotificationModel]()
    var contactNum = String()
    var name  = String()
    var btnTitleText = String()
    var notiFuncLocArray = [FunctionalLocationModel]()
    var notiEquipmentArray = [EquipmentModel]()

    func notificationOverviewFunclocServiceCall(title: String) {
        mJCLogger.log("Starting", Type: "info")
        self.vcNOOverview?.updateUINotificationOverviewFunLoc(title: title)
        mJCLogger.log("Ended", Type: "info")
    }
    func notificationOverviewEquipmentServiceCall(title: String) {
        mJCLogger.log("Starting", Type: "info")
        self.vcNOOverview?.updateUINotificationOverviewEquipement(title: title)
        mJCLogger.log("Ended", Type: "info")
    }

}
