//
//  AssetSearchViewModel.swift
//  myAsset
//
//  Created by Rover Software on 13/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class AssetSearchViewModel: NSObject {
    weak var delegate: viewModelDelegate?
    var assetList = [ZEquipmentModel]()
    var searchParams = Dictionary<String,Any>()
    
    func getAssetList(){
        let query = self.getAssetListQuery()
        EquipmentModel.getEquipmentList(filterQuery: query,modelClass: ZEquipmentModel.self){(response,error) in
            if error == nil{
                if let respArr = response["data"] as? [ZEquipmentModel]{
                    self.assetList = respArr
                }else{
                    mJCLoader.stopAnimating()
                }
                self.delegate?.dataFetchCompleted?(type: "assetList", object: [])
            }
        }
    }
    func getAssetListQuery() -> String{
        var queryStr = ""
        for i in 0..<searchParams.keys.count {
            let key = Array(searchParams.keys)[i]
            let param = "\(searchParams["\(key)"] ?? "")"
            if queryStr.count == 0{
                if key == "assetID" && param != ""{
                    queryStr = queryStr + "(Asset eq '\(param)')"
                }else if key == "assetDesc" && param != ""{
                    queryStr = queryStr + "(AssetDesc eq '\(param)')"
                }else if key == "assetCls" && param != ""{
                    queryStr = queryStr + "(AssetClass eq '\(param)')"
                }else if key == "assetFloc" && param != ""{
                    queryStr = queryStr + "(FuncLocation eq '\(param)')"
                }else if key == "assetCostCtr" && param != ""{
                    queryStr = queryStr + "(CostCenter eq '\(param)')"
                }else if key == "assetLocation" && param != ""{
                    queryStr = queryStr + "(Location eq '\(param)')"
                }else if key == "assetRoom" && param != ""{
                    queryStr = queryStr + "(Room eq '\(param)')"
                }
            }else{
                if key == "assetID" && param != ""{
                    queryStr = queryStr + " and " + "(Asset eq '\(param)')"
                }else if key == "assetDesc" && param != ""{
                    queryStr = queryStr + " and " + "(AssetDesc eq '\(param)')"
                }else if key == "assetCls" && param != ""{
                    queryStr = queryStr + " and "  + "(AssetClass eq '\(param)')"
                }else if key == "assetFloc" && param != ""{
                    queryStr = queryStr + " and "  + "(FuncLocation eq '\(param)')"
                }else if key == "assetCostCtr" && param != ""{
                    queryStr = queryStr + " and "  + "(CostCenter eq '\(param)')"
                }else if key == "assetLocation" && param != ""{
                    queryStr = queryStr + " and "  + "(Location eq '\(param)')"
                }else if key == "assetRoom" && param != ""{
                    queryStr = queryStr + " and "  + "(Room eq '\(param)')"
                }
            }
        }
        if queryStr.count != 0{
            queryStr = "$filter=(\(queryStr))&$orderby=Asset"
        }
        return queryStr
    }
    func updateGeoLocation(list:[EquipmentModel],currentLoc:String,count:Int){
        if count == list.count{
            self.delegate?.dataFetchCompleted?(type: "geoLocationUpdated", object: [])
        }else{
            let equipment = list[count]
            (equipment.entity.properties["GEOLocation"] as! SODataProperty).value = "\(currentLoc)" as NSObject
            EquipmentModel.updateWorkorderEntity(entity: equipment.entity,  flushRequired: false, options: nil){(response, error) in
                if(error == nil) {
                    self.updateGeoLocation(list: list, currentLoc: currentLoc, count: count + 1)
                    mJCLogger.log("Equipment Header Updated successfully", Type: "Debug")
                }else {
                    self.updateGeoLocation(list: list, currentLoc: currentLoc, count: count + 1)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func updateFunctionalLocation(list:[EquipmentModel],FuncLocation:String,count:Int){
        if count == list.count{
            self.delegate?.dataFetchCompleted?(type: "geoLocationUpdated", object: [])
        }else{
            let equipment = list[count]
            (equipment.entity.properties["FuncLocation"] as! SODataProperty).value = "\(FuncLocation)" as NSObject
            EquipmentModel.updateWorkorderEntity(entity: equipment.entity,  flushRequired: false, options: nil){(response, error) in
                if(error == nil) {
                    self.updateFunctionalLocation(list: list, FuncLocation: FuncLocation, count: count + 1)
                    mJCLogger.log("Equipment Header Updated successfully", Type: "Debug")
                }else {
                    self.updateFunctionalLocation(list: list, FuncLocation: FuncLocation, count: count + 1)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
}
