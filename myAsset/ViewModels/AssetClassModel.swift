//
//  AssetClassModel.swift
//  myAsset
//
//  Created by Mangi Reddy on 10/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib
public protocol Initable1{
    init()
}
public class AssetClassModel : NSObject,Initable1{
    
    @objc public var AssetC = String()
    @objc public var AssetDes = String()
    
    @objc public var entity = SODataEntityDefault()
    @objc public var entityValue = SODataV4_EntityValue()
    
    public required override init() {
        super.init()
    }
    
    public static func getAssetClassList(filterQuery:String? = "",modelClass : AssetClassModel.Type? = AssetClassModel.self,completionHandler: @escaping ([String : Any], NSError?) -> ()){
        let handler = completionHandler
        let storeArray =  mJCLib.offlineStoreDefineRequests.filter{$0.EntitySet == "AssetClassSet"}
        if storeArray.count > 0{
            let store = storeArray[0]
            var query = String()
            if  filterQuery == ""{
                query = "AssetClassSet?$orderby=AssetC"
            }else{
                query = "AssetClassSet?\(filterQuery!)"
            }
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: query, storeName: store.AppStoreName, entitySetClassType: modelClass!){(response, error) in
                handler(response,error as NSError?)
            }
        }else{
            let error = NSError(domain: "", code: 1227, userInfo: [NSLocalizedDescriptionKey : "Store not found"])
            completionHandler(NSMutableDictionary() as! [String : Any], error as NSError)
        }
    }
}
