//
//  SettingUtilities.swift
//  myJobCard
//
//  Created by Pratik Patel on 11/18/16.
//  Copyright © 2016 Pratik Patel. All rights reserved.
//

import UIKit

class SettingUtilities: NSObject {
    
    class func updateConnectivitySettingsFromUserSettings() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.smpAppID = "com.ods.mJCDevIOS"
    }
}
