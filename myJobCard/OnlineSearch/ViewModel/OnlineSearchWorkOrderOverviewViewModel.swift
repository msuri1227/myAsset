//
//  OnlineSearchWorkOrderOverviewViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 13/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class OnlineSearchWorkOrderOverviewViewModel {
    
    var vcOnlineWoOverview: OnlineWorkOrderOverViewVC?
    var personResponsibleArray = NSMutableArray()
    var selecetdWorkOrderDetailsArr = NSMutableArray()
    var isTranformHidden = true
    var responsiblePerson = String()
    var onlineEquipmentArray = [EquipmentModel]()
    var functionalLocationArray = [FunctionalLocationModel]()
    
    
    //MARK:- Get Person Responsible List..
    func getPersonResponsibleList() {
        mJCLogger.log("Starting", Type: "info")
        self.personResponsibleArray.removeAllObjects()
        if globalPersonRespArray.count > 0 {
            self.personResponsibleArray.addObjects(from: globalPersonRespArray)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func equipmentServiceCall(btnTitle: String) {
        mJCLogger.log("Starting", Type: "info")
        self.vcOnlineWoOverview?.updateUIAssetEquipmentButton(btnTitle: btnTitle)
        mJCLogger.log("Ended", Type: "info")
    }
    
    func funcLocServiceCall(btnTitle: String) {
        mJCLogger.log("Starting", Type: "info")
        FunctionalLocationModel.getFuncLocationDetails(funcLocation: btnTitle){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FunctionalLocationModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.functionalLocationArray = responseArr
                        self.vcOnlineWoOverview?.updateUIAssetFuncLocButton(btnTitle: btnTitle)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
