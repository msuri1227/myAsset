//
//  ClientLoggingManger.swift
//  myJobCard
//
//  Created by Rover Software on 14/11/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ClientLoggingManger: NSObject {
    
    var logManger : SAPClientLogManager? =  SAPSupportabilityFacade.sharedManager().getClientLogManager()
    class var uniqueInstance : ClientLoggingManger {
        struct Static {
            static let instance : ClientLoggingManger = ClientLoggingManger()
        }
        return Static.instance
    }
    func initilize() {
        mJCLogger.log("Starting", Type: "info")
        logManger?.setLogDestination(.FILESYSTEM)
        logManger?.setLogLevel(.DebugClientLogLevel)
        let kCustomLogger = "My CustomLogger"
        let  customLogger =  logManger?.getLogger(kCustomLogger) as! SAPClientLogger
        self.retrive()
        mJCLogger.log("Ended", Type: "info")
    }
    func retrive(){
        mJCLogger.log("Starting", Type: "info")
        var error: Error? = nil
        var path = "\(NSTemporaryDirectory())\("logdata.txt")"
        // map stream to file
        var logStream = OutputStream.init(toFileAtPath: path, append: false)
        if myAsset.fileManager.fileExists(atPath: path) {
            try? myAsset.fileManager.removeItem(atPath: path)
        }else{
            print("not exist")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
