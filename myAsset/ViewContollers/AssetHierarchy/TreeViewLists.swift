//
//  TreeViewLists.swift
//  TreeView1
//
//  Created by Cindy Oakes on 5/21/16.
//  Copyright © 2016 Cindy Oakes. All rights reserved.
//
import mJCLib

class TreeViewLists
{
    //MARK:  Load Array With Initial Data 
    
//    static func LoadInitialData() -> [TreeViewData]
//    {
//        var data: [TreeViewData] = []
//        data.append(TreeViewData(level: 0, name: "cindy's family tree", id: "1", parentId: "-1")!)
//        data.append(TreeViewData(level: 0, name: "jack's family tree", id: "2", parentId: "-1")!)
//        data.append(TreeViewData(level: 1, name: "katherine", id: "3", parentId: "1")!)
//        data.append(TreeViewData(level: 1, name: "kyle", id: "4", parentId: "1")!)
//        data.append(TreeViewData(level: 2, name: "hayley", id: "5", parentId: "3")!)
//        data.append(TreeViewData(level: 2, name: "macey", id: "6", parentId: "3")!)
//        data.append(TreeViewData(level: 1, name: "katelyn", id: "7", parentId: "2")!)
//        data.append(TreeViewData(level: 1, name: "jared", id: "8", parentId: "2")!)
//        data.append(TreeViewData(level: 1, name: "denyee", id: "9", parentId: "2")!)
//        data.append(TreeViewData(level: 2, name: "cayleb", id: "10", parentId: "4")!)
//        data.append(TreeViewData(level: 2, name: "carter", id: "11", parentId: "4")!)
//        data.append(TreeViewData(level: 2, name: "braylon", id: "12", parentId: "4")!)
//        data.append(TreeViewData(level: 3, name: "samson", id: "13", parentId: "5")!)
//        data.append(TreeViewData(level: 3, name: "samson", id: "14", parentId: "6")!)
//
//        
//        return data
//    }
    
    //MARK:  Load Nodes From Initial Data
    
    static func LoadInitialNodes(dataList: [TreeViewData]) -> [TreeViewNode]
    {
        mJCLogger.log("Starting", Type: "info")
        var nodes: [TreeViewNode] = []
        for data in dataList where data.level == 0
        {
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeName = data.name as String
            node.nodeType = data.type as String
            node.nodeDesc = data.Descr as String
            node.isExpanded = false
            let newLevel = data.level + 1
            node.nodeChildren = LoadChildrenNodes(dataList: dataList, level: newLevel, parentId: data.id)
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            nodes.append(node)
        }
        mJCLogger.log("Ended", Type: "info")
        return nodes
    }
    static func LoadInitialNodes(dataList: [TreeViewData],datalevel: Int) -> [TreeViewNode]
    {
        mJCLogger.log("Starting", Type: "info")
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == datalevel
        {
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeName = data.name as String
            node.nodeType = data.type as String
            node.nodeDesc = data.Descr as String
            node.isExpanded = false
            let newLevel = data.level + 1
            node.nodeChildren = LoadChildrenNodes(dataList: dataList, level: newLevel, parentId: data.id)
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            nodes.append(node)
        }
        mJCLogger.log("Ended", Type: "info")
        return nodes
    }
    
    //MARK:  Recursive Method to Create the Children/Grandchildren....  node arrays
    
    static func LoadChildrenNodes(dataList: [TreeViewData], level: Int, parentId: String) -> [TreeViewNode]
    {
        mJCLogger.log("Starting", Type: "info")
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == level && data.parentId == parentId
        {
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeName = data.name as String
            node.nodeType = data.type as String
            node.nodeDesc = data.Descr as String
            node.isExpanded = false
            let newLevel = level + 1
            node.nodeChildren = LoadChildrenNodes(dataList: dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            nodes.append(node)
            
        }
        mJCLogger.log("Ended", Type: "info")
        return nodes
    }
    
    
}
