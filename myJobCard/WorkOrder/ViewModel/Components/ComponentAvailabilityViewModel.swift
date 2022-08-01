//
//  ComponentAvailabilityViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 15/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class ComponentAvailabilityViewModel {
    
    var vcComponentAvailability: ComponentAvailabilityVC?
    var componentArray = [ComponentAvailabilityModel]()
    var componentListArray = [ComponentAvailabilityModel]()
    var isFromCheckCompScreen = false
    var selectedPlant = String()
    var selectedStortageLocation = String()
    var isWoHistory = Bool()
    var isBomItem = Bool()
    var historyCompArray = [String]()

    weak var delegate: viewModelDelegate?
    
    func getdefineRequset() -> String{
        var str = "Material eq "
        for item in self.historyCompArray{
            if item != ""{
                str = str + "'\(item)' or Material eq "
            }
        }
        str = str.replacingLastOccurrenceOfString(" or Material eq ", with: "")
        return str
    }
    
    //MARK:- Get ComponentList
    func getAvailableComponentList() {

        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        }
        var defineReq = String()

        var queryarr = Array<String>()
        
        if isFromCheckCompScreen == true{
            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
            if result == "ServerUp"{

                if selectedPlant != "" {
                    queryarr.append("Plant")
                }
                if selectedStortageLocation != ""{
                    queryarr.append("MaterialStorageLocation")
                }
                if inStockAvailable == true{
                    queryarr.append("Stock")
                }

                if queryarr.count>0{
                    var strQuery = ""
                    for i in 0..<queryarr.count {
                        if strQuery.count == 0{
                            if queryarr[i] == "Plant"{
                                strQuery = "Plant eq '\(selectedPlant)'"
                            }else if queryarr[i] == "MaterialStorageLocation"{
                                strQuery = "MaterialStorageLocation eq '\(selectedStortageLocation)'"
                            }else if queryarr[i] == "Stock"{
                                strQuery = "Stock gt 0"
                            }
                        }else{
                            if queryarr[i] == "Plant"{
                                strQuery = strQuery + " and " + "Plant eq '\(selectedPlant)'"
                            }else if queryarr[i] == "MaterialStorageLocation"{
                                strQuery = strQuery + " and "  + "MaterialStorageLocation eq '\(selectedStortageLocation)'"
                            }else if queryarr[i] == "Stock"{
                                strQuery = strQuery + " and " + "Stock gt 0"
                            }
                        }
                    }
                    defineReq = "$filter=(\(strQuery))"
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        let httpConvMan1 = HttpConversationManager.init()
                        let commonfig1 = CommonAuthenticationConfigurator.init()
                        if authType == "Basic"{
                            commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                        }else if authType == "SAML"{
                            commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                        }
                        commonfig1.configureManager(httpConvMan1)
                        let componentDict =  ComponentAvailabilityModel.getOnlineHTMaterialStorageLocationList(httpConvManager: httpConvMan1!, filterQuery: defineReq)
                        if let status = componentDict["Status"] as? Int{
                            if status == 200{
                                if let dict = componentDict["Response"] as? NSMutableDictionary{
                                    let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: ComponentAvailabilityModel.self)
                                    if let responseArr = responseDict["data"] as? [ComponentAvailabilityModel]{
                                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                        self.componentArray = responseArr
                                        self.componentListArray = responseArr
                                    }else {
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        mJCLoader.stopAnimating()
                        if self.componentArray.count > 0 {
                            DispatchQueue.main.async {
                                self.vcComponentAvailability?.listItemTableview.reloadData()
                            }
                        }else {
                            mJCAlertHelper.showAlert(self.vcComponentAvailability!, title:alerttitle, message: "Components_Not_Found".localized(), button: okay)
                            mJCLogger.log("Components_Not_Found".localized(), Type: "Error")
                        }
                    }
                }else{
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        let httpConvMan1 = HttpConversationManager.init()
                        let commonfig1 = CommonAuthenticationConfigurator.init()
                        if authType == "Basic"{
                            commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                        }else if authType == "SAML"{
                            commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                        }
                        commonfig1.configureManager(httpConvMan1)
                        let componentDict =  ComponentAvailabilityModel.getOnlineHTMaterialStorageLocationList(httpConvManager: httpConvMan1!)
                        if let status = componentDict["Status"] as? Int{
                            if status == 200{
                                if let dict = componentDict["Response"] as? NSMutableDictionary{
                                    let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: ComponentAvailabilityModel.self)
                                    if let responseArr = responseDict["data"] as? [ComponentAvailabilityModel]{
                                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                        self.componentArray = responseArr
                                        self.componentListArray = responseArr
                                    }else {
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }
                            }
                        }
                        mJCLoader.stopAnimating()
                        if self.componentArray.count > 0 {
                            DispatchQueue.main.async {
                                self.vcComponentAvailability?.listItemTableview.reloadData()
                            }
                        }else {
                            mJCAlertHelper.showAlert(self.vcComponentAvailability!, title:alerttitle, message: "Components_Not_Found".localized(), button: okay)
                            mJCLogger.log("Components_Not_Found".localized(), Type: "Error")
                        }
                    }
                }
            }
        }else{
            var defineQuery = String()
            if inStockAvailable == true && self.isWoHistory == false{
                defineQuery = "$filter=(Plant eq '\(selectedPlant)' and MaterialStorageLocation eq '\(selectedStortageLocation)' and Stock gt 0)&$orderby=Material"
            }else if self.isWoHistory == true{
                defineQuery = "$filter=(\(getdefineRequset()))&$orderby=Material"
            }else{
                defineQuery = "$filter=(Plant eq '\(selectedPlant)' and MaterialStorageLocation eq '\(selectedStortageLocation)')&$orderby=Material"
            }
            ComponentAvailabilityModel.getHTMaterialStorageLocationList(filterQuery: defineQuery){(response, error)  in
                if error == nil{
                    self.componentArray.removeAll()
                    self.componentListArray.removeAll()
                    if let responseArr = response["data"] as? [ComponentAvailabilityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.componentArray = responseArr
                        self.componentListArray = responseArr
                        self.vcComponentAvailability?.updateUIGetComponentList()
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLoader.stopAnimating()
                    if error?.code == 10{
                        mJCLogger.log("Store open Failed", Type: "Debug")
                    }else if error?.code == 1227{
                        mJCLogger.log("Entity set not found", Type: "Debug")
                    }else{
                        mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getBOMItemList()  {
        mJCLogger.log("Starting", Type: "info")
        if singleWorkOrder.BOMCategory == "" && singleWorkOrder.BOM == ""{
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(self.vcComponentAvailability!, title:alerttitle, message: "Components_Not_Found".localized(), button: okay)
            return
        }
        var defineReq = String()
        var queryarr = Array<String>()
        DispatchQueue.main.async {
            mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        }
        if isFromCheckCompScreen == true{

            let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
            if result == "ServerUp"{

                if singleWorkOrder.BOMCategory != ""{
                    queryarr.append("BOMCategory")
                }
                if singleWorkOrder.BOM != ""{
                    queryarr.append("BOM")
                }
                if inStockAvailable == true{
                    queryarr.append("Stock")
                }
                if queryarr.count>0{
                    var strQuery = ""
                    for i in 0..<queryarr.count {
                        if strQuery.count == 0{
                            if queryarr[i] == "BOMCategory"{
                                strQuery = "BOMCategory eq '\(singleWorkOrder.BOMCategory)'"
                            }else if queryarr[i] == "BOM"{
                                strQuery = "BOM eq '\(singleWorkOrder.BOM)'"
                            }else if queryarr[i] == "Stock"{
                                strQuery = "Quantity gt 0"
                            }
                        }else{
                            if queryarr[i] == "BOMCategory"{
                                strQuery = strQuery + " and " + "BOMCategory eq '\(singleWorkOrder.BOMCategory)'"
                            }else if queryarr[i] == "BOM"{
                                strQuery = strQuery + " and "  + "BOM eq '\(singleWorkOrder.BOM)'"
                            }else if queryarr[i] == "Stock"{
                                strQuery = strQuery + " and " + "Quantity gt 0"
                            }
                        }
                    }
                    defineReq = "$filter=(\(strQuery))"
                    let httpConvMan1 = HttpConversationManager.init()
                    let commonfig1 = CommonAuthenticationConfigurator.init()
                    if authType == "Basic"{
                        commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                    }else if authType == "SAML"{
                        commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                    }
                    commonfig1.configureManager(httpConvMan1)
                    let componentDict =  ComponentAvailabilityModel.getOnlineBomComponentsList(httpConvManager: httpConvMan1!, filterQuery: defineReq)
                    if let status = componentDict["Status"] as? Int{
                        if status == 200{
                            mJCLoader.stopAnimating()
                            if let dict = componentDict["Response"] as? NSMutableDictionary{
                                let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: ComponentAvailabilityModel.self)
                                if let responseArr = responseDict["data"] as? [ComponentAvailabilityModel]{
                                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                    self.componentArray = responseArr
                                    self.componentListArray = responseArr
                                    DispatchQueue.main.async {
                                        self.vcComponentAvailability?.listItemTableview.reloadData()
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }else{
                            mJCLoader.stopAnimating()
                        }
                    }
                }else{
                    let httpConvMan1 = HttpConversationManager.init()
                    let commonfig1 = CommonAuthenticationConfigurator.init()
                    if authType == "Basic"{
                        commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                    }else if authType == "SAML"{
                        commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                    }
                    commonfig1.configureManager(httpConvMan1)
                    let componentDict =  ComponentAvailabilityModel.getOnlineBomComponentsList(httpConvManager: httpConvMan1!)
                    if let status = componentDict["Status"] as? Int{
                        if status == 200{
                            mJCLoader.stopAnimating()
                            if let dict = componentDict["Response"] as? NSMutableDictionary{
                                let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: ComponentAvailabilityModel.self)
                                if let responseArr = responseDict["data"] as? [ComponentAvailabilityModel]{
                                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                                    self.componentArray = responseArr
                                    self.componentListArray = responseArr
                                    DispatchQueue.main.async {
                                        self.vcComponentAvailability?.listItemTableview.reloadData()
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }else{
                            mJCLoader.stopAnimating()
                        }
                    }
                }
            }
        }else{
            var queryarr = Array<String>()
            if singleWorkOrder.BOMCategory != ""{
                queryarr.append("BOMCategory")
            }
            if singleWorkOrder.BOM != ""{
                queryarr.append("BOM")
            }
            if inStockAvailable == true{
                queryarr.append("Stock")
            }
            if queryarr.count>0{
                var strQuery = ""
                for i in 0..<queryarr.count {
                    if strQuery.count == 0{
                        if queryarr[i] == "BOMCategory"{
                            strQuery = "BOMCategory eq '\(singleWorkOrder.BOMCategory)'"
                        }else if queryarr[i] == "BOM"{
                            strQuery = "BOM eq '\(singleWorkOrder.BOM)'"
                        }else if queryarr[i] == "Stock"{
                            strQuery = "Quantity gt 0"
                        }
                    }else{
                        if queryarr[i] == "BOMCategory"{
                            strQuery = strQuery + " and " + "BOMCategory eq '\(singleWorkOrder.BOMCategory)'"
                        }else if queryarr[i] == "BOM"{
                            strQuery = strQuery + " and "  + "BOM eq '\(singleWorkOrder.BOM)'"
                        }else if queryarr[i] == "Stock"{
                            strQuery = strQuery + " and " + "Quantity gt 0"
                        }
                    }
                }
                defineReq = "$filter=(\(strQuery))"
            }
            ComponentAvailabilityModel.getBomComponentsList(filterQuery:defineReq){(response, error)  in
                if error == nil{
                    mJCLoader.stopAnimating()
                    self.componentArray.removeAll()
                    self.componentListArray.removeAll()
                    if let responseArr = response["data"] as? [ComponentAvailabilityModel]{
                        mJCLogger.log("Respnse :\(responseArr)", Type: "Debug")
                        self.componentArray = responseArr
                        self.componentListArray = responseArr
                        self.vcComponentAvailability?.updateUIGetBOMList()
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLoader.stopAnimating()
                    self.vcComponentAvailability?.updateUIGetBOMList()
                    if error?.code == 10{
                        mJCLogger.log("Store open Failed", Type: "Debug")
                    }else if error?.code == 1227{
                        mJCLogger.log("Entity set not found", Type: "Debug")
                    }else{
                        mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
            mJCLoader.stopAnimating()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getComponentHistoryList() {
        mJCLogger.log("Starting", Type: "info")
        ComponentAvailabilityModel.getWoHistoryComponentsList(workOrderNo: selectedworkOrderNumber){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [ComponentAvailabilityModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.historyCompArray.removeAll()
                        for item in responseArr{
                            self.historyCompArray.append(item.Material)
                        }
                        self.getAvailableComponentList()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        mJCAlertHelper.showAlert(self.vcComponentAvailability!, title:alerttitle, message: "Components_Not_Found".localized(), button: okay)
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLoader.stopAnimating()
                if error?.code == 10{
                    mJCLogger.log("Store open Failed", Type: "Debug")
                }else if error?.code == 1227{
                    mJCLogger.log("Entity set not found", Type: "Debug")
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getMaterialDetails(material: String) {
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=Material%20eq%20%27\(material)%27"
        ComponentAvailabilityModel.getHTMaterialStorageLocationList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [ComponentAvailabilityModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.delegate?.dataFetchCompleted?(type: "Material", object: [responseArr[0]])
                    }else {
                        self.delegate?.dataFetchCompleted?(type: "Material", object: [ComponentAvailabilityModel()])
                    }
                }else {
                    mJCLoader.stopAnimating()
                    self.delegate?.dataFetchCompleted?(type: "Material", object: [ComponentAvailabilityModel()])
                }
            }else{
                mJCLoader.stopAnimating()
                self.delegate?.dataFetchCompleted?(type: "Material", object: [ComponentAvailabilityModel()])
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
