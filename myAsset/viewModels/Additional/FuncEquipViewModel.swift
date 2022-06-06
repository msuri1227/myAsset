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
    
    var vc : FlocEquipHierarchyVC!
    var displayArray = [TreeViewNode]()
    var AssetHierarchyArray = [AssetHierarchyModel]()
    var FuncEquipArray = [Any]()
    var FuncEquipListArray = [Any]()
    var nodes: [TreeViewNode] = []
    var data: [TreeViewData] = []
    
    func GetAssetHierarchyDetails() {
        mJCLogger.log("Starting", Type: "info")
        var plant  = self.vc.planningPlant
        if plant == selectStr || plant == "" {
            plant = ""
        }
        var workcentner = self.vc.workCenter
        if workcentner == selectStr || workcentner == ""{
            workcentner = ""
        }
        workcentner = ""
        DispatchQueue.main.async {
            mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        }
        var defineQuery = String()
        if vc.isSelect == "FunctionalLocation"{
            defineQuery = "$filter=((HierLevel eq \(0) and Type eq 'FL') or HierLevel eq \(1))&$orderby=HierLevel,ObjectId"
        }else{
            defineQuery = "$filter=(HierLevel eq \(0) or HierLevel eq \(1))&$orderby=HierLevel,ObjectId"
        }
        AssetHierarchyModel.getAssetHierarchyList(filterQuery:defineQuery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [AssetHierarchyModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.AssetHierarchyArray = responseArr
                    self.data = self.setIntialsData()
                    if self.vc.selectedFunLoc != ""{
                        let nodearry = self.AssetHierarchyArray.filter{$0.ObjectId == "\(self.vc.selectedFunLoc)" && $0.Type == "FL" }
                        if nodearry.count > 0{
                            mJCLogger.log("Response:\(nodearry[0])", Type: "Debug")
                            let nodobj = nodearry[0]
                            self.nodes = TreeViewLists.LoadInitialNodes(dataList: self.data, datalevel: nodobj.HierLevel)
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        self.nodes = TreeViewLists.LoadInitialNodes(dataList: self.data)
                    }
                    self.LoadDisplayArray()
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        self.vc.AssetHierarchyTableView.reloadData()
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    DispatchQueue.main.async{
                        mJCAlertHelper.showAlert(self.vc, title: MessageTitle, message: "Data_not_found".localized(), button: okay)
                    }
                }
            }else{
                DispatchQueue.main.async{
                    mJCLoader.stopAnimating()
                    if error?.code == 10{
                        mJCAlertHelper.showAlert(self.vc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                    }
                }
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setIntialsData() -> [TreeViewData]{
        mJCLogger.log("Starting", Type: "info")
        var data: [TreeViewData] = []
        if self.AssetHierarchyArray.count > 0{
            for item in self.AssetHierarchyArray{
                if item.HierLevel == 1 && item.ParentId == ""{
                }else{
                    data.append(TreeViewData(level: item.HierLevel, name: "\(item.ObjectId)", Descr: "\(item.Description)", id: item.ObjectId, parentId: item.ParentId, type: item.Type)!)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return data
    }
    func LoadDisplayArray()
    {
        mJCLogger.log("Starting", Type: "info")
        self.displayArray = [TreeViewNode]()
        for node: TreeViewNode in nodes
        {
            self.displayArray.append(node)
            if (node.isExpanded == true)
            {
                if node.nodeChildren != nil{
                    self.AddChildrenArray(childrenArray: node.nodeChildren!)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func LoadChildDisplayArray(nodes:[TreeViewNode],selectedNode:TreeViewNode) {
        mJCLogger.log("Starting", Type: "info")
        let index =  self.displayArray.index(of: selectedNode)
        if index != nil{
            for i in 0..<nodes.count{
                let node = nodes[i]
                if !self.displayArray.contains(node){
                    self.displayArray.insert(node, at: index! + i + 1)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func removeChildDisplayArray(nodes:[TreeViewNode],selectedNode:TreeViewNode) {
        
        mJCLogger.log("Starting", Type: "info")
        for i in 0..<nodes.count{
            let node = nodes[i]
            let index =  self.displayArray.index(of: node)
            if index != nil{
                self.displayArray.remove(at: index!)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setChildData(array:[AssetHierarchyModel]) -> [TreeViewData]{
        
        mJCLogger.log("Starting", Type: "info")
        var data: [TreeViewData] = []
        if array.count > 0{
            for item in array{
                data.append(TreeViewData(level: item.HierLevel, name: "\(item.ObjectId)", Descr: "\(item.Description)", id: item.ObjectId, parentId: item.ParentId, type: item.Type)!)
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        return data
    }
    func AddChildrenArray(childrenArray: [TreeViewNode])
    {
        mJCLogger.log("Starting", Type: "info")
        for node: TreeViewNode in childrenArray
        {
            self.displayArray.append(node)
            if (node.isExpanded == true )
            {
                if (node.nodeChildren != nil)
                {
                    self.AddChildrenArray(childrenArray: node.nodeChildren!)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func searchFuncOrEquipList(){
        
        mJCLogger.log("Starting", Type: "info")
        let searchText = "\(self.vc.searchTextfield.text!)"
        var filterString = String()
        if self.vc.filterBy == "Id".localized() {
            if self.vc.isSelect == "FunctionalLocation" {
                filterString = "filter=substringof('\(searchText)', tolower(FunctionalLoc)) eq true"
            }else if self.vc.isSelect == "Equipement" {
                filterString = "filter=substringof('\(searchText)', tolower(Equipment)) eq true"
            }
        }else if self.vc.filterBy == "Description".localized() {
            if self.vc.isSelect == "FunctionalLocation" {
                filterString = "filter=substringof('\(searchText)', tolower(Description)) eq true"
            }
            else if self.vc.isSelect == "Equipement" {
                filterString = "filter=substringof('\(searchText)', tolower()EquipDescription) eq true"
            }
        }else if self.vc.filterBy == "Tech_ID".localized() {
            if self.vc.isSelect == "Equipement" {
                filterString = "filter=substringof('\(searchText)', tolower(TechIdentNo)) eq true"
            }
        }
        mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        if self.vc.isSelect == "FunctionalLocation" {
            FunctionalLocationModel.getFuncLocationList(filterQuery: filterString){ (responseDict, error)  in
                if error == nil{
                    if  (responseDict["data"] as? [Any])?.count ?? 0 > 0{
                        mJCLoader.stopAnimating()
                        mJCLogger.log("Response:\(responseDict["data"] as! [FunctionalLocationModel])", Type: "Debug")
                        self.FuncEquipArray.removeAll()
                        self.FuncEquipArray = responseDict["data"] as! [FunctionalLocationModel]
                        DispatchQueue.main.async {
                            self.vc.AssetHierarchyTableView.isHidden = true
                            self.vc.listItemTableview.isHidden = false
                            self.vc.listItemTableview.reloadData()
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        var msg = String()
                        msg = "Functional_location_not_found".localized()
                        DispatchQueue.main.async{
                            mJCAlertHelper.showAlert(self.vc, title: MessageTitle, message: msg, button: okay)
                        }
                    }
                }else {
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        if error?.code == 10{
                            mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                        }
                    }
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else if self.vc.isSelect == "Equipement" {
            
            EquipmentModel.getEquipmentList(filterQuery: filterString){ (responseDict, error)  in
                if error == nil{
                    if  (responseDict["data"] as? [Any])?.count ?? 0 > 0{
                        mJCLoader.stopAnimating()
                        self.FuncEquipArray.removeAll()
                        self.FuncEquipArray = responseDict["data"] as! [EquipmentModel]
                        mJCLogger.log("Response:\(responseDict["data"] as! [EquipmentModel])", Type: "Debug")
                        DispatchQueue.main.async {
                            self.vc.AssetHierarchyTableView.isHidden = true
                            self.vc.listItemTableview.isHidden = false
                            self.vc.listItemTableview.reloadData()
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        var msg = String()
                        msg = "Equipement_not_found".localized()
                        DispatchQueue.main.async{
                            mJCAlertHelper.showAlert(self.vc, title: MessageTitle, message: msg, button: okay)
                        }
                    }
                }else {
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        if error?.code == 10{
                            mJCAlertHelper.showAlert(self.vc, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                        }
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // functional location equipment search old
    //    {
    //
    //        mJCLogger.log("Starting", Type: "info")
    //        let searchText = "\(self.vc.searchTextfield.text!)"
    //        var filterString = String()
    //        if self.vc.filterBy == "Id".localized() {
    //            if self.vc.isSelect == "FunctionalLocation" {
    //                filterString = "$filter=substringof('\(searchText)', FunctionalLoc) eq true"
    //            }else if self.vc.isSelect == "Equipement" {
    //                filterString = "$filter=substringof('\(searchText)', Equipment) eq true"
    //            }
    //        }else if self.vc.filterBy == "Description".localized() {
    //            if self.vc.isSelect == "FunctionalLocation" {
    //                filterString = "$filter=substringof('\(searchText)', Description) eq true"
    //            }
    //            else if self.vc.isSelect == "Equipement" {
    //                filterString = "$filter=substringof('\(searchText)', EquipDescription) eq true"
    //            }
    //        }else if self.vc.filterBy == "Tech_ID".localized() {
    //            if self.vc.isSelect == "Equipement" {
    //                filterString = "$filter=substringof('\(searchText)', TechIdentNo) eq true"
    //            }
    //        }
    //        if self.vc.isSelect == "FunctionalLocation" {
    //            FunctionalLocationModel.getFuncLocationList(filterQuery: filterString){ (responseDict, error)  in
    //                if error == nil{
    //                    if  (responseDict["data"] as? [Any])?.count ?? 0 > 0{
    //                        mJCLogger.log("Response:\(responseDict["data"] as! [FunctionalLocationModel])", Type: "Debug")
    //                        self.FuncEquipArray.removeAll()
    //                        self.FuncEquipArray = responseDict["data"] as! [FunctionalLocationModel]
    //                        DispatchQueue.main.async {
    //                            self.vc.AssetHierarchyTableView.isHidden = true
    //                            self.vc.listItemTableview.isHidden = false
    //                            self.vc.listItemTableview.reloadData()
    //                        }
    //                    }else{
    //                        var msg = String()
    //                        msg = "Functional_location_not_found".localized()
    //                        DispatchQueue.main.async{
    //                            mJCAlertHelper.showAlert(self.vc, title: MessageTitle, message: msg, button: okay)
    //                        }
    //                    }
    //                }
    //                else {
    //                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
    //                }
    //            }
    //
    //        }else if self.vc.isSelect == "Equipement" {
    //
    //            EquipmentModel.getEquipmentList(filterQuery: filterString){ (responseDict, error)  in
    //                if error == nil{
    //                    if  (responseDict["data"] as? [Any])?.count ?? 0 > 0{
    //                        self.FuncEquipArray.removeAll()
    //                        self.FuncEquipArray = responseDict["data"] as! [EquipmentModel]
    //                        mJCLogger.log("Response:\(responseDict["data"] as! [EquipmentModel])", Type: "Debug")
    //                        DispatchQueue.main.async {
    //                            self.vc.AssetHierarchyTableView.isHidden = true
    //                            self.vc.listItemTableview.isHidden = false
    //                            self.vc.listItemTableview.reloadData()
    //                        }
    //                    }else{
    //                        var msg = String()
    //                        msg = "Equipement_not_found".localized()
    //                        DispatchQueue.main.async{
    //                            mJCAlertHelper.showAlert(self.vc, title: MessageTitle, message: msg, button: okay)
    //                        }
    //                    }
    //                }
    //                else {
    //                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
    //                }
    //            }
    //        }
    //        mJCLogger.log("Ended", Type: "info")
    //    }
    
}
