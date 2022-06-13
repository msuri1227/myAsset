//
//  AssetViewModel.swift
//  myAsset
//
//  Created by Mangi Reddy on 10/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class AssetClassViewModel {
    
    weak var delegate: viewModelDelegate?
    var assetClassList = [AssetClassModel]()
    var costCenterList:[String] = []
    var locationList:[String] = []
    
    func getAssetClassList(){
        AssetClassModel.getAssetClassList{(responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [AssetClassModel]{
                    self.assetClassList = responseArr
                }
                self.delegate?.dataFetchCompleted?(type: "assetList", object: [])
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    
    func getCostCenterList(){
        costCenterList = ["--Select--", "SAP-DUMMY", "Office Cost Center"]
    }
    func getLocationList(){
        locationList = ["--Select--", "0001-Meeting Room"]
    }
}
