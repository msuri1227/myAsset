//
//  TreeViewData.swift
//  TreeView1
//
//  Created by Cindy Oakes on 5/21/16.
//  Copyright © 2016 Cindy Oakes. All rights reserved.
//

class TreeViewData
{
    var level: Int
    var name: String
    var id: String
    var parentId: String
    var Descr: String
    var type: String
    
    
    init?(level: Int, name: String, Descr: String, id: String, parentId: String, type: String)
    {
        self.level = level
        self.name = name
        self.id = id
        self.parentId = parentId
        self.type = type
        self.Descr = Descr
    }
}


