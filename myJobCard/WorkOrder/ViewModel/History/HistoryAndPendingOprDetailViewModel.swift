//
//  HistoryAndPendingOprDetailViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class HistoryAndPendingOprDetailViewModel {
    
    weak var vcHistoryPendingOprDetail: HistoryAndPendingOprDetailsVC?
    var historyAndPendingLongTextArray = [LongTextModel]()
    
    // MARK:- WOPendingOpLongTextSet
    func getHistoryPendingOpLongTextSet() {
        
        mJCLogger.log("Starting", Type: "info")
        
        var WorkorderStr = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 12, Num: HistoryAndPendingWoOpr)
        WorkorderStr = WorkorderStr + "\(vcHistoryPendingOprDetail!.selectedopr.OperationNum)"
        let defineReq = DefineRequestModelClass.uniqueInstance.getHistoryPendingOprDefineRequest(type:HistoryAndPendingWoOprFrom,type1:"LongText",workOrderNum:"\(WorkorderStr)")
        
        mJCLogger.log("getWOPendingOpLongTextSet defineReq:- \(defineReq)", Type: "")
        var hederSet = String()
        if HistoryAndPendingWoOprFrom == "History"{
            hederSet = woHistoryOpLongTextSet
        }else if HistoryAndPendingWoOprFrom == "Pending"{
            hederSet =  woPendingOpLongTextSet
        }
        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(hederSet)"}
        if storeArray.count > 0{
            let store = storeArray[0]
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineReq, storeName: store.AppStoreName, entitySetClassType: LongTextModel.self){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [LongTextModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        let sortedArray:[LongTextModel] = responseArr.sorted(by: { $0.Item < $1.Item})
                        self.historyAndPendingLongTextArray = sortedArray
                        self.vcHistoryPendingOprDetail?.updateUIGetHistoryPendingOpLongTextSet()
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
