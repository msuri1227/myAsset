//
//  HistoryAndPendingOprListViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class HistoryAndPendingOprListViewModel {
    
    weak var vcHistoryPendingOprList: HistoryAndPendingOprListVC?
    var OprListArray = [HistoryAndPendingOperationModel]()
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
    
    func getOpeartionData() {
        mJCLogger.log("Starting", Type: "info")
        if HistoryAndPendingWoOprFrom == "History"{
            HistoryAndPendingOperationModel.getHistoryOperations(workOrderNum: HistoryAndPendingWoOpr, filterQuery: "") {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [HistoryAndPendingOperationModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.OprListArray = responseArr
                        self.vcHistoryPendingOprList?.updateUIGetOperationData()
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    self.vcHistoryPendingOprList?.updateUIGetOperationDataWithoutResponseOrError()
                }
            }
        }else if HistoryAndPendingWoOprFrom == "Pending"{
            HistoryAndPendingOperationModel.getPendingOperations(workOrderNum: HistoryAndPendingWoOpr, filterQuery: "") {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [HistoryAndPendingOperationModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.OprListArray = responseArr
                        self.vcHistoryPendingOprList?.updateUIGetOperationData()
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    self.vcHistoryPendingOprList?.updateUIGetOperationDataWithoutResponseOrError()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
