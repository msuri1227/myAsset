//
//  FuncEquipViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class FuncEquipViewModel {
    
    var funcEquipVc : FlocEquipHierarchyVC!
    var displayArray = [HierarchyTreeViewNode]()
    var assetHierarchyArray = [AssetHierarchyModel]()
    var FuncEquipArray = [Any]()
    var nodes: [HierarchyTreeViewNode] = []
    var dataArr: [HierarchyTreeViewData] = []

    var flocChildArry = [FunctionalLocationModel]()
    var equipChildArray = [EquipmentModel]()
    var flocSubChildArry = [FunctionalLocationModel]()
    var equipSubChildArray = [EquipmentModel]()
    var selectedIndex : IndexPath? = nil
    func getRootLevelNodesForAssetHierarchy() {

        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        if funcEquipVc.isSelect == "FunctionalLocation"{
            defineQuery = "filter=(Type eq 'FL')&$orderby=ObjectId"
        }else{
            defineQuery = ""
        }
        AssetHierarchyModel.getAssetHierarchyList(filterQuery:defineQuery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [AssetHierarchyModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.assetHierarchyArray = responseArr
                    self.setRootLevelNodes()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    DispatchQueue.main.async{
                        mJCAlertHelper.showAlert(self.funcEquipVc, title: MessageTitle, message: "Data_not_found".localized(), button: okay)
                    }
                }
            }else{
                DispatchQueue.main.async{
                    mJCLoader.stopAnimating()
                    if error?.code == 10{
                        mJCAlertHelper.showAlert(self.funcEquipVc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                    }
                }
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setRootLevelNodes(){
        dataArr.removeAll()
        for item in self.assetHierarchyArray{
            var hasChild = false
            if Int(item.NumChilds) ?? 0 > 0{
                hasChild = true
            }
            let child =  HierarchyTreeViewData(nodeTitle: item.ObjectId, nodeDescription: item.Description, nodeType: item.Type, nodeChildren: hasChild)
            dataArr.append(child)
        }
        self.funcEquipVc.HierarchyTable.reloadData()
    }
    func getBatchForChild(treeObject:HierarchyTreeViewData){

        mJCLogger.log("Starting", Type: "info")
        self.flocChildArry.removeAll()
        self.equipChildArray.removeAll()
        self.flocSubChildArry.removeAll()
        self.equipSubChildArray.removeAll()

        let batchArr = NSMutableArray()
        if treeObject.nodeType  == "FL"{
            let flocQuery = "\(functionalLocationHeaderSet)?$filter=(SupFunctLoc eq '\(treeObject.nodeTitle)')&$select=FunctionalLoc,Description,SupFunctLoc&$orderby=FunctionalLoc"
            batchArr.add(flocQuery)
            let equpQuery = "\(equipmentHeaderSet)?$filter=(FuncLocation eq '\(treeObject.nodeTitle)')&$select=Equipment,EquipDescription,FuncLocation,SuperiorEquipment&$orderby=Equipment"
            batchArr.add(equpQuery)
        }else if treeObject.nodeType == "EQ"{
            let equpQuery = "\(equipmentHeaderSet)?$filter=(FuncLocation eq '\(treeObject.nodeTitle)')&$select=Equipment,EquipDescription,FuncLocation,SuperiorEquipment&$orderby=Equipment"
            batchArr.add(equpQuery)
        }
        let batchRequest = SODataRequestParamBatchDefault.init()
        for obj in batchArr {
            let str = obj as! String
            let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
            reqParam?.customTag = str
            batchRequest.batchItems.add(reqParam!)
        }
        BatchRequestModel.getExecuteHighVolumeBatchRequest(batchRequest: batchRequest){ (response, error)  in
            if error == nil {
                if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                    let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == functionalLocationHeaderSet {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FunctionalLocationModel.self)
                            if  let flocArray = dict["data"] as? [FunctionalLocationModel]{
                                self.flocChildArry.append(contentsOf: flocArray)
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else if resourcePath == equipmentHeaderSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: EquipmentModel.self)
                            if  let equpArray = dict["data"] as? [EquipmentModel]{
                                self.equipChildArray.append(contentsOf: equpArray)
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }
                    }
                    if self.flocChildArry.count == 0  && self.equipChildArray.count > 0{
                        self.getEquipmentSubChilds(equipArr: self.equipChildArray, selecteNode: treeObject)
                    }else{
                        self.getBatchForSubChildCount(flocArr: self.flocChildArry, equipArr: self.equipChildArray, selectedNode: treeObject)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getBatchForSubChildCount(flocArr:[FunctionalLocationModel],equipArr:[EquipmentModel],selectedNode:HierarchyTreeViewData){
        mJCLogger.log("Starting", Type: "info")

        let batchArr = NSMutableArray()
        let flocQuery = self.getFlocQuery(flocArr: flocArr)
        let flocforEquipQuery = self.getFlocQueryForEquip(flocArr: flocArr)
        if flocQuery.count == 0 && flocforEquipQuery.count == 0{
            self.createHierarchyData(selectedNode: selectedNode)
        }else{
            if flocQuery.count > 0{
                batchArr.add("\(functionalLocationHeaderSet)?$filter=\(flocQuery)&$select=FunctionalLoc,Description,SupFunctLoc&$orderby=FunctionalLoc")
            }
            if flocforEquipQuery.count > 0{
                batchArr.add("\(equipmentHeaderSet)?$filter=\(flocforEquipQuery)&$select=Equipment,EquipDescription,FuncLocation,SuperiorEquipment&$orderby=Equipment")
            }
            let batchRequest = SODataRequestParamBatchDefault.init()
            for obj in batchArr {
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
            }
            BatchRequestModel.getExecuteHighVolumeBatchRequest(batchRequest: batchRequest){ (response, error)  in
                if error == nil {
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        for key in responseDic.allKeys{
                            let resourcePath = key as! String
                            if resourcePath == functionalLocationHeaderSet {
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FunctionalLocationModel.self)
                                if  let flocArray = dict["data"] as? [FunctionalLocationModel]{
                                    self.flocSubChildArry.append(contentsOf: flocArray)
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == equipmentHeaderSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: EquipmentModel.self)
                                if  let equpArray = dict["data"] as? [EquipmentModel]{
                                    self.equipSubChildArray.append(contentsOf: equpArray)
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        if equipArr.count > 0{
                            self.getEquipmentSubChilds(equipArr: equipArr, selecteNode: selectedNode)
                        }else{
                            self.createHierarchyData(selectedNode: selectedNode)
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getEquipmentSubChilds(equipArr:[EquipmentModel],selecteNode:HierarchyTreeViewData){
        let equipQuery = self.getEquipQuery(equipArr: equipArr)
        let queery = "\(equipmentHeaderSet)?$filter=\(equipQuery)"
        EquipmentModel.getEquipmentList(filterQuery: queery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [EquipmentModel]{
                    self.equipSubChildArray.append(contentsOf: responseArr)
                }
            }
            self.createHierarchyData(selectedNode: selecteNode)
        }
    }
    func createHierarchyData(selectedNode:HierarchyTreeViewData){
        var arr = [HierarchyTreeViewData]()
        for item in self.flocChildArry{
            var hasChild = false
            let flocsubChildArr = self.flocSubChildArry.filter{$0.SupFunctLoc == "\(item.FunctionalLoc)"}
            let equipSubChildArr = self.equipSubChildArray.filter{$0.FuncLocation == "\(item.FunctionalLoc)"}
            let count = flocsubChildArr.count + equipSubChildArr.count
            if count > 0{
                hasChild = true
            }
            let child =  HierarchyTreeViewData(nodeTitle: item.FunctionalLoc, nodeDescription: item.Description, nodeType: "FL", nodeChildren: hasChild)
            arr.append(child)
        }
        for item in self.equipChildArray{
            var hasChild = false
            let equipSubChildArr = self.equipSubChildArray.filter{$0.SuperiorEquipment == "\(item.Equipment)"}
            if equipSubChildArr.count > 0{
                hasChild = true
            }
            let child =  HierarchyTreeViewData(nodeTitle: item.Equipment, nodeDescription: item.EquipDescription, nodeType: "EQ", nodeChildren: hasChild)
            arr.append(child)
        }
        selectedNode.nodeChildren = arr
        if selectedIndex != nil && self.funcEquipVc.selectedTreeNode != nil{
            DispatchQueue.main.async {
                mJCLoader.stopAnimating()
                self.funcEquipVc.selectedTreeNode?.expand = true
                self.funcEquipVc.HierarchyTable.expandSelectedNode(indexPath: self.selectedIndex!, selectedTreeViewNode: self.funcEquipVc.selectedTreeNode!)
            }
        }
    }
    func getFlocQuery(flocArr:[FunctionalLocationModel]) -> String{
        var queryStr = ""
        for item in flocArr{
            if queryStr.count == 0{
                queryStr = queryStr + "(SupFunctLoc eq '\(item.FunctionalLoc)')"
            }else{
                queryStr = queryStr + " or " + "(SupFunctLoc eq '\(item.FunctionalLoc)')"
            }
        }
        return queryStr
    }
    func getFlocQueryForEquip(flocArr:[FunctionalLocationModel]) -> String{
        var queryStr = ""
        for item in flocArr{
            if queryStr.count == 0{
                queryStr = queryStr + "(FuncLocation eq '\(item.FunctionalLoc)')"
            }else{
                queryStr = queryStr + " or " + "(FuncLocation eq '\(item.FunctionalLoc)')"
            }
        }
        return queryStr
    }
    func getEquipQuery(equipArr:[EquipmentModel]) -> String{
        var queryStr = ""
        for item in equipArr{
            if queryStr.count == 0{
                queryStr = queryStr + "(SuperiorEquipment eq '\(item.Equipment)')"
            }else{
                queryStr = queryStr + " or " + "(SuperiorEquipment eq '\(item.Equipment)')"
            }
        }
        return queryStr
    }
    func getSelectedFLocDetails(floc:String){
        FunctionalLocationModel.getFuncLocationDetails(funcLocation: floc){ (response, error)  in
            if error == nil{
                if let flocArr = response["data"] as? [FunctionalLocationModel]{
                    if flocArr.count > 0{
                        self.funcEquipVc.selectedFL = flocArr[0]
                    }else{
                        self.funcEquipVc.selectedFL = FunctionalLocationModel()
                    }
                }else{
                    self.funcEquipVc.selectedFL = FunctionalLocationModel()
                    mJCLogger.log("floc Data not found", Type: "Debug")
                }
                self.funcEquipVc.updateSelectedFlocAndEquipmentDetails()
            }else{
                self.funcEquipVc.selectedFL = FunctionalLocationModel()
                DispatchQueue.main.async{
                    if error?.code == 10{
                        mJCAlertHelper.showAlert(self.funcEquipVc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                    }
                }
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getSelectedEqpDetails(equipment:String){
        EquipmentModel.getEquipmentDetails(equipNum: equipment){ (response, error)  in
            if error == nil{
                if let equipArr = response["data"] as? [EquipmentModel]{
                    if equipArr.count > 0{
                        self.funcEquipVc.selectedEQ = equipArr[0]
                        FunctionalLocationModel.getFuncLocationDetails(funcLocation: self.funcEquipVc.selectedEQ.FuncLocation){ (response, error)  in
                            if error == nil{
                                if let flocArr = response["data"] as? [FunctionalLocationModel]{
                                    if flocArr.count > 0{
                                        self.funcEquipVc.selectedFL = flocArr[0]
                                    }else{
                                        self.funcEquipVc.selectedFL = FunctionalLocationModel()
                                    }
                                }else{
                                    self.funcEquipVc.selectedFL = FunctionalLocationModel()
                                    mJCLogger.log("floc Data not found", Type: "Debug")
                                }
                            }else{
                                self.funcEquipVc.selectedFL = FunctionalLocationModel()
                                DispatchQueue.main.async{
                                    if error?.code == 10{
                                        mJCAlertHelper.showAlert(self.funcEquipVc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                                    }
                                }
                                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                            }
                            self.funcEquipVc.updateSelectedFlocAndEquipmentDetails()
                        }
                    }else{
                        self.funcEquipVc.selectedEQ = EquipmentModel()
                        self.funcEquipVc.updateSelectedFlocAndEquipmentDetails()
                    }
                }else{
                    mJCLogger.log("Equipment Data not found", Type: "Debug")
                }
            }else{
                DispatchQueue.main.async{
                    if error?.code == 10{
                        mJCAlertHelper.showAlert(self.funcEquipVc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                    }
                }
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func searchFuncOrEquipList(){
        mJCLogger.log("Starting", Type: "info")
        let searchText = "\(self.funcEquipVc.searchTextfield.text!)"
        var filterString = String()
        if self.funcEquipVc.filterBy == "Id".localized() {
            if self.funcEquipVc.isSelect == "FunctionalLocation" {
                filterString = "filter=substringof('\(searchText)', tolower(FunctionalLoc)) eq true"
            }else if self.funcEquipVc.isSelect == "Equipement" {
                filterString = "filter=substringof('\(searchText)', tolower(Equipment)) eq true"
            }
        }else if self.funcEquipVc.filterBy == "Description".localized() {
            if self.funcEquipVc.isSelect == "FunctionalLocation" {
                filterString = "filter=substringof('\(searchText)', tolower(Description)) eq true"
            }else if self.funcEquipVc.isSelect == "Equipement" {
                filterString = "filter=substringof('\(searchText)', tolower()EquipDescription) eq true"
            }
        }else if self.funcEquipVc.filterBy == "Tech_ID".localized() {
            if self.funcEquipVc.isSelect == "Equipement" {
                filterString = "filter=substringof('\(searchText)', tolower(TechIdentNo)) eq true"
            }
        }
        mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        if self.funcEquipVc.isSelect == "FunctionalLocation" {
            FunctionalLocationModel.getFuncLocationList(filterQuery: filterString){ (responseDict, error)  in
                if error == nil{
                    self.FuncEquipArray.removeAll()
                    if let arr = responseDict["data"] as? [FunctionalLocationModel]{
                        if arr.count > 0{
                            mJCLoader.stopAnimating()
                            self.FuncEquipArray = arr
                            DispatchQueue.main.async {
                                self.funcEquipVc.HierarchyTable.isHidden = true
                                self.funcEquipVc.listItemTableview.isHidden = false
                                self.funcEquipVc.detaisTitleView.isHidden = false
                                self.funcEquipVc.detailsTitleViewHightConstant.constant = 50.0
                                self.funcEquipVc.listItemTableview.reloadData()
                            }
                        }else{
                            mJCLoader.stopAnimating()
                            DispatchQueue.main.async{
                                mJCAlertHelper.showAlert(self.funcEquipVc, title: MessageTitle, message: "Functional_location_not_found".localized(), button: okay)
                            }
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        DispatchQueue.main.async{
                            mJCAlertHelper.showAlert(self.funcEquipVc, title: MessageTitle, message: "Functional_location_not_found".localized(), button: okay)
                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        if error?.code == 10{
                            mJCAlertHelper.showAlert(self.funcEquipVc!, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                        }
                    }
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }

        }else if self.funcEquipVc.isSelect == "Equipement" {

            EquipmentModel.getEquipmentList(filterQuery: filterString){ (responseDict, error)  in
                if error == nil{
                    self.FuncEquipArray.removeAll()
                    if let arr = responseDict["data"] as? [EquipmentModel]{
                        if arr.count > 0{
                            mJCLoader.stopAnimating()
                            self.FuncEquipArray = arr
                            DispatchQueue.main.async {
                                self.funcEquipVc.HierarchyTable.isHidden = true
                                self.funcEquipVc.listItemTableview.isHidden = false
                                self.funcEquipVc.detaisTitleView.isHidden = false
                                self.funcEquipVc.detailsTitleViewHightConstant.constant = 50.0
                                self.funcEquipVc.listItemTableview.reloadData()
                            }
                        }else{
                            mJCLoader.stopAnimating()
                            DispatchQueue.main.async{
                                mJCAlertHelper.showAlert(self.funcEquipVc, title: MessageTitle, message: "Equipement_not_found".localized(), button: okay)
                            }
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        DispatchQueue.main.async{
                            mJCAlertHelper.showAlert(self.funcEquipVc, title: MessageTitle, message: "Equipement_not_found".localized(), button: okay)
                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        if error?.code == 10{
                            mJCAlertHelper.showAlert(self.funcEquipVc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                        }
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
