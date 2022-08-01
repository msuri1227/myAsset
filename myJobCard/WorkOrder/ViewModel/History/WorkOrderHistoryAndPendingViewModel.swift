//
//  WorkOrderHistoryAndPendingViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class WorkOrderHistoryAndPendingViewModel {

    weak var vcWOHistoryPending: HistoryAndPendingVC?
    var historyArray = [HistoryAndPendingModel]()
    var pendingArray = [HistoryAndPendingModel]()

    
    //MARK:- Get History Data..
    func getHistory() {
        mJCLogger.log("Starting", Type: "info")
        HistoryAndPendingModel.getWorkOrderHistory(workOrderNum: selectedworkOrderNumber) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [HistoryAndPendingModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.historyArray = responseArr
                    self.vcWOHistoryPending?.updateUIGetHistory()
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Pending Data..
    func getPending() {
        mJCLogger.log("Starting", Type: "info")
        HistoryAndPendingModel.getWorkOrderPending(workOrderNum: selectedworkOrderNumber) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [HistoryAndPendingModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if DeviceType == iPad{
                        self.pendingArray = responseArr
                    }else{
                        self.historyArray.removeAll()
                        self.historyArray = responseArr
                    }
                    self.vcWOHistoryPending?.updateUIGetPending()
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get LongText List..
    func getLongTextSet(WorkOrderNum : String, index : Int, from: String) {

        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(endswith(TextName, '" + WorkOrderNum + "') eq true)"
        
        LongTextModel.getWoHistoryPendingLongTextSet(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [LongTextModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.vcWOHistoryPending?.updateUIGetLongText(WorkOrderNumValue: WorkOrderNum, indexValue: index, fromStr: from)
                    }
                    else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
