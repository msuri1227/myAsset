//
//  HierarchyTreeViewData.swift
//  HierarchyTree
//
//  Created by Apple on 24.01.2018.
//  Copyright © 2018 Cenk Işık. All rights reserved.
//

import UIKit

class HierarchyTreeViewData {
    
    let nodeTitle : String
    let nodeDescription : String
    let nodeType : String
    var hasChildren : Bool
    var nodeChildren : [HierarchyTreeViewData]
    
    init(nodeTitle : String,nodeDescription:String ,nodeType:String,hasChildren:Bool,nodeChildren: [HierarchyTreeViewData]) {
        self.nodeTitle = nodeTitle
        self.nodeType = nodeType
        self.nodeDescription = nodeDescription
        self.hasChildren = hasChildren
        self.nodeChildren = nodeChildren
    }
    
    convenience init(nodeTitle : String,nodeDescription:String ,nodeType:String,nodeChildren:Bool) {
        self.init(nodeTitle: nodeTitle, nodeDescription: nodeDescription, nodeType: nodeType,hasChildren: nodeChildren,nodeChildren: [HierarchyTreeViewData]())
    }
    func addChild(_ child : HierarchyTreeViewData) {
        self.nodeChildren.append(child)
    }
    func removeChild(_ child : HierarchyTreeViewData) {
        self.nodeChildren = self.nodeChildren.filter( {$0 !== child})
    }
}
