//
//  MenuClass.swift
//  MyJobCard
//
//  Created by Rover Software on 22/06/17.
//  Copyright © 2017 Pratik Patel. All rights reserved.
//

import UIKit

class MenuClass: NSObject {
     let dropperMenu = Dropper(width: 200, height: 250)
    class var uniqueInstance : MenuClass {
        
        struct Static {
            
            static let instance : MenuClass = MenuClass()
        }
        
        return Static.instance
    }
    
    func  initmenu(){
        
        
    }

}
