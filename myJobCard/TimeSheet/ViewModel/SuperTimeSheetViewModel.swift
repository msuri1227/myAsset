//
//  SuperTimeSheetViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class SuperTimeSheetViewModel {
    
    weak var vc: SupervisorTimeSheetVC!
    var timeSheetArray = [TimeSheetModel]()
    
    func gettimesheetreacords() {
        
        mJCLogger.log("Starting", Type: "info")
        TimeSheetModel.getSupervisorTimeSheetData(personnelNo: self.vc.technicianid){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [TimeSheetModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.timeSheetArray = responseArr
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    self.vc.totalEntries.text = "Total_Entries".localized() + ": 0"
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

}
