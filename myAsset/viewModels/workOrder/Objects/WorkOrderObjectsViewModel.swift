//
//  WorkOrderObjectsViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class WorkOrderObjectsViewModel {
    
    weak var delegate:viewModelDelegate?
    var objectListArray = [WorkorderObjectModel]()

    
    func getObjectlist() {
        mJCLogger.log("Starting", Type: "info")
        WorkorderObjectModel.getWorkOrderObjects(workOrderNum: selectedworkOrderNumber){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WorkorderObjectModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    objectCount = "\(responseArr.count)"
                    self.objectListArray = responseArr
                    self.delegate?.dataFetchCompleted?(type: "assetList", object: [])
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
