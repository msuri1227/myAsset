//
//  AssetHierarViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 16/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class AssetHierarViewModel {
    
    var vc : AssetHierarchyVC!
    var nodes: [TreeViewNode] = []
    var data: [TreeViewData] = []
    var AssetHierarchyArray = [AssetHierarchyModel]()
    var displayArray = [TreeViewNode]()
    
    func AssetHierarchy() {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLoader.startAnimating(status: "Fetching_Data..".localized())
        }
        let defineQuery = "$filter=(HierLevel eq \(0) or HierLevel eq \(1))&$orderby=HierLevel,ObjectId"
        AssetHierarchyModel.getAssetHierarchyList(filterQuery:defineQuery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [AssetHierarchyModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    self.AssetHierarchyArray = responseArr
                    self.data = self.setIntialsData()
                    self.nodes = TreeViewLists.LoadInitialNodes(dataList: self.data)
                    self.LoadDisplayArray()
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        self.vc.AssetHierarchyTableView.reloadData()
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
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
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
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
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
        return data
    }
    func LoadDisplayArray() {
        
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
    func AddChildrenArray(childrenArray: [TreeViewNode]) {
        
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
    func getNodeDetails(node:TreeViewNode){
        
        let num = node.nodeName!
        let type = node.nodeType!
        if type == "EQ"{
            let searchPredicate = NSPredicate(format: "SELF.Equipment == %@",num)
            var equipmenntarr = [EquipmentModel]()
            if totalEquipmentArray.count == 0{
                EquipmentModel.getEquipmentDetails(equipNum: num){ (response, error)  in
                    if error == nil{
                        if let equipArr = response["data"] as? [EquipmentModel]{
                            equipmenntarr = equipArr
                            if equipmenntarr.count > 0{
                                self.vc.updateUIDetails(nodeDetail: equipmenntarr[0])
                            }else{
                                self.vc.updateUIDetails(nodeDetail: EquipmentModel())
                            }
                        }else{
                            self.vc.updateUIDetails(nodeDetail: EquipmentModel())
                            mJCLogger.log("Equipment Data not found", Type: "Debug")
                        }
                    }else{
                        self.vc.updateUIDetails(nodeDetail: EquipmentModel())
                        mJCLogger.log("Equipment Data not found", Type: "Debug")
                    }
                }
            }else{
                equipmenntarr = (totalEquipmentArray as NSArray).filtered(using: searchPredicate) as! [EquipmentModel]
                if equipmenntarr.count > 0{
                    self.vc.updateUIDetails(nodeDetail: equipmenntarr[0])
                }else{
                    self.vc.updateUIDetails(nodeDetail: EquipmentModel())
                }
            }
        }else if type == "FL"{
            
            var functionLocationArray = [FunctionalLocationModel]()
            if funcLocationArray.count == 0{
                FunctionalLocationModel.getFuncLocationDetails(funcLocation: num){ (response, error)  in
                    if error == nil{
                        if let flocArr = response["data"] as? [FunctionalLocationModel]{
                            functionLocationArray = flocArr
                            if functionLocationArray.count > 0{
                                self.vc.updateUIDetails(nodeDetail: functionLocationArray[0])
                            }else{
                                self.vc.updateUIDetails(nodeDetail: FunctionalLocationModel())
                            }
                        }else{
                            self.vc.updateUIDetails(nodeDetail: FunctionalLocationModel())
                            mJCLogger.log("floc Data not found", Type: "Debug")
                        }
                    }else{
                        self.vc.updateUIDetails(nodeDetail: FunctionalLocationModel())
                        mJCLogger.log("floc Data not found", Type: "Debug")
                    }
                }
            }else{
                let searchPredicate = NSPredicate(format: "SELF.FunctionalLoc == %@",num)
                functionLocationArray = (funcLocationArray as NSArray).filtered(using: searchPredicate) as! [FunctionalLocationModel]
                if functionLocationArray.count > 0{
                    self.vc.updateUIDetails(nodeDetail: functionLocationArray[0])
                }else{
                    self.vc.updateUIDetails(nodeDetail: FunctionalLocationModel())
                }
            }
        }
    }
}
