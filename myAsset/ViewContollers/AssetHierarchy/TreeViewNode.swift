//
//  TreeViewNode.swift
//  TreeView1
//
//  Created by Cindy Oakes on 5/19/16.
//  Copyright © 2016 Cindy Oakes. All rights reserved.
//


class TreeViewNode:Equatable
{
    static func == (lhs: TreeViewNode, rhs: TreeViewNode) -> Bool {
         return lhs.nodeLevel == rhs.nodeLevel && lhs.isExpanded == rhs.isExpanded && lhs.nodeName == rhs.nodeName && lhs.nodeType == rhs.nodeType && lhs.nodeDesc == rhs.nodeDesc && lhs.nodeChildren == rhs.nodeChildren
    }
    
    
    var nodeLevel: Int?
    var isExpanded: Bool?
    var nodeName: String?
    var nodeType: String?
    var nodeDesc: String?
    var nodeChildren: [TreeViewNode]?
    
  
}
