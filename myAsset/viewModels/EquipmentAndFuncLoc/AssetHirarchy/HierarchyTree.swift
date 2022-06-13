//
//  HierarchyTree.swift
//  HierarchyTreeView
//
//  Created by Apple on 24.01.2018.
//  Copyright © 2018 Cenk Işık. All rights reserved.
//

import Foundation

public protocol HierarchyTreeDelegate: NSObjectProtocol {
    func getChildren(for treeViewNodeItem: Any, at indexPath: IndexPath) -> [Any]
    func willExpandTreeViewNode(_ treeViewNode: HierarchyTreeViewNode, at indexPath: IndexPath)
    func willCollapseTreeViewNode(_ treeViewNode: HierarchyTreeViewNode, at indexPath: IndexPath)
}

public class HierarchyTree: NSObject {
    
    var treeViewNodes: [HierarchyTreeViewNode] = []
    var indexPathsArray: [IndexPath] = []
    weak var treeViewDelegate: HierarchyTreeDelegate?
    
    init(treeViewNodes: [HierarchyTreeViewNode]) {
        self.treeViewNodes = treeViewNodes
    }
    
    //MARK: Tree View Nodes Functions
    func addTreeViewNode(with item: Any) {
        let treeViewNode = HierarchyTreeViewNode(item: item)
        treeViewNodes.append(treeViewNode)
    }
    
    func getTreeViewNode(atIndex index: Int) -> HierarchyTreeViewNode {
        if treeViewNodes.indices.contains(index){
            return treeViewNodes[index]
        }
        return treeViewNodes.last!
    }
    
    func index(of treeViewNode: HierarchyTreeViewNode) -> Int? {
        return treeViewNodes.index(of: treeViewNode)
    }
    
    func insertTreeViewNode(parent parentTreeViewNode: HierarchyTreeViewNode, with item: Any, to index: Int) {
        let treeViewNode = HierarchyTreeViewNode(item: item)
        treeViewNode.parentNode = parentTreeViewNode
        treeViewNodes.insert(treeViewNode, at: index)
    }
    
    func removeTreeViewNodesAtRange(from start:Int , to end:Int) {
        treeViewNodes.removeSubrange(start ... end)
    }
    
    func setExpandTreeViewNode(atIndex index:Int) {
        treeViewNodes[index].expand = true
    }
    
    func setCollapseTreeViewNode(atIndex index:Int) {
        treeViewNodes[index].expand = false
    }
    
    func setLevelTreeViewNode(atIndex index: Int, to level: Int) {
        treeViewNodes[index].level = level + 1
    }
    
    // MARK: Expand Rows
    
    func addIndexPath(withRow row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        indexPathsArray.append(indexPath)
    }
    
    func expandRows(atIndexPath indexPath: IndexPath, with selectedTreeViewNode: HierarchyTreeViewNode) {
        let children = self.treeViewDelegate?.getChildren(for: selectedTreeViewNode.item, at: indexPath)
        indexPathsArray = [IndexPath]()
        var row = indexPath.row + 1
        
        if (children?.count)! > 0 {
            self.treeViewDelegate?.willExpandTreeViewNode(selectedTreeViewNode, at: indexPath)
            setExpandTreeViewNode(atIndex: indexPath.row)
        }
        
        for item in children!{
            addIndexPath(withRow: row)
            insertTreeViewNode(parent: selectedTreeViewNode, with: item, to: row)
            setLevelTreeViewNode(atIndex: row, to: selectedTreeViewNode.level)
            row += 1
        }
    }
    
    // MARK: Collapse Rows
    func removeIndexPath(withRow row: inout Int, and indexPath:IndexPath) {
        let treeViewNode = getTreeViewNode(atIndex: row)
        let children = self.treeViewDelegate?.getChildren(for: treeViewNode.item, at: indexPath)
        
        let index = IndexPath(row: row, section: indexPath.section)
        indexPathsArray.append(index)
        row += 1
        
        if (treeViewNode.expand) {
            for _ in children!{
                removeIndexPath(withRow: &row, and: indexPath)
            }
        }
    }
    
    func collapseRows(for treeViewNode: HierarchyTreeViewNode, atIndexPath indexPath: IndexPath) {
        guard let treeViewDelegate = self.treeViewDelegate else { return }
        let treeViewNodeChildren = treeViewDelegate.getChildren(for: treeViewNode.item, at: indexPath)
        indexPathsArray = [IndexPath]()
        var row = indexPath.row + 1
        
        if treeViewNodeChildren.count > 0 {
            treeViewDelegate.willCollapseTreeViewNode(treeViewNode, at: indexPath)
        }
        
        setCollapseTreeViewNode(atIndex: indexPath.row)
        
        for _ in treeViewNodeChildren{
            removeIndexPath(withRow: &row, and: indexPath)
        }
        
        if indexPathsArray.count > 0 {
            removeTreeViewNodesAtRange(from: (indexPathsArray.first?.row)!, to: (indexPathsArray.last?.row)!)
        }
    }
    
    
    @discardableResult func collapseAllRowsExceptOne() -> HierarchyTreeViewNode? {
        indexPathsArray = [IndexPath]()
        var collapsedTreeViewNode:HierarchyTreeViewNode? = nil
        var indexPath = IndexPath(row: 0, section: 0)
        for treeViewNode in treeViewNodes {
            if  treeViewNode.expand , treeViewNode.level == 0 {
                collapseRows(for: treeViewNode, atIndexPath: indexPath)
                collapsedTreeViewNode = treeViewNode
            }
            indexPath.row += 1
        }
        return collapsedTreeViewNode
    }
    @discardableResult
    func expandRows(atIndexPath indexPath: IndexPath, with selectedTreeViewNode: HierarchyTreeViewNode, openWithChildrens: Bool) -> Int {
        guard let treeViewDelegate = self.treeViewDelegate else { return 0 }
        let treeViewNodeChildren = treeViewDelegate.getChildren(for: selectedTreeViewNode.item, at: indexPath)
        indexPathsArray = [IndexPath]()
        var row = indexPath.row + 1
        setExpandTreeViewNode(atIndex: indexPath.row)
        
        if treeViewNodeChildren.count > 0 {
            treeViewDelegate.willExpandTreeViewNode(selectedTreeViewNode, at: indexPath)
            for item in treeViewNodeChildren {
                addIndexPath(withRow: row)
                insertTreeViewNode(parent: selectedTreeViewNode, with: item, to: row)
                setLevelTreeViewNode(atIndex: row, to: selectedTreeViewNode.level)
                if openWithChildrens {
                    let treeViewNode = getTreeViewNode(atIndex: row)
                    let indexPath = IndexPath(row: row, section: 0)
                    row = expandRows(atIndexPath: indexPath, with: treeViewNode, openWithChildrens: openWithChildrens)
                } else {
                    row += 1
                }
            }
        }
        return row
    }
    
    func collapseAllRows(){
        indexPathsArray = [IndexPath]()
        var indexPath = IndexPath(row: 0, section: 0)
        for treeViewNode in treeViewNodes {
            indexPath = getIndexPathOfTreeViewNode(treeViewNode: treeViewNode)
            if treeViewNode.level != 0 {
                setCollapseTreeViewNode(atIndex: indexPath.row)
                treeViewNodes.remove(at: indexPath.row)
            } else {
                setCollapseTreeViewNode(atIndex: indexPath.row)
            }
        }
    }
    
    func expandAllRows() {
        indexPathsArray = [IndexPath]()
        var indexPath = IndexPath(row: 0, section: 0)
        for treeViewNode in treeViewNodes {
            if !treeViewNode.expand {
                indexPath = getIndexPathOfTreeViewNode(treeViewNode: treeViewNode)
                indexPath.row = expandRows(atIndexPath: indexPath, with: treeViewNode, openWithChildrens: true)
                
            }
        }
    }
    
    func getIndexPathOfTreeViewNode(treeViewNode: HierarchyTreeViewNode) -> IndexPath {
        for (index,node) in treeViewNodes.enumerated() {
            if treeViewNode == node {
                return IndexPath(row: index, section: 0)
            }
        }
        return IndexPath(row:0, section:0)
    }
    
}
