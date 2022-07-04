//
// assetmapVC.swift
//  myJobCard
//
//  Created by Rover Software on 16/06/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class assetmapVC: NSObject {
    
    class func openmappage(id : String){
        
        mJCLogger.log("Starting", Type: "info")
        let window = UIApplication.shared.keyWindow
        if ASSETMAP_TYPE == "LATLONGO"{
            if id == ""{
                openlatlangoapp()
            }else{
                highlightsapids(id: id)
            }
        }else if ASSETMAP_TYPE == "LEMUR"{
            
        }else if ASSETMAP_TYPE == "ESRIMAP"{
//            if DeviceType == iPad{
//                currentMasterView = "WorkOrder"
//                selectedworkOrderNumber = ""
//                selectedNotificationNumber = ""
//                selectedEquipment = id
//                let mapSplitVC = ScreenManager.getAssetMapSplitScreen()
//                window?.rootViewController = mapSplitVC
//                window?.makeKeyAndVisible()
//            }
        }else{
            if DeviceType == iPad{
                currentMasterView = "MapSplitViewController"
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                let mapSplitVC = ScreenManager.getMapSplitScreen()
                window?.rootViewController = mapSplitVC
                window?.makeKeyAndVisible()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    class func openlatlangoapp() {
        mJCLogger.log("Starting", Type: "info")
        var url = URL(string: "latlongo:bringtofront")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }else{
            url = URL(string: "https://itunes.apple.com/us/app/latlongo/id660652949?mt=8")
            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    class func highlightsapids(id : String) {
        mJCLogger.log("Starting", Type: "info")
        var url = URL(string: "latlongo:highlight?sapids=" + id)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }else{
            url = URL(string: "https://itunes.apple.com/us/app/latlongo/id660652949?mt=8")
            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
