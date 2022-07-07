//
//  ManageDeleteEntityClass.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 4/21/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class ManageDeleteEntityClass: NSObject {

    var WorkOrderClass = WoHeaderModel()
    var isfromnewuser : Bool = false
    class var uniqueInstance : ManageDeleteEntityClass {
        
        struct Static {
            static let instance : ManageDeleteEntityClass = ManageDeleteEntityClass()
        }
        return Static.instance
    }
    
    //MARK:- Delete Entity..
    func deleteEntity(entity: SODataEntityDefault, enitityName: String)  {
        
        mJCLogger.log("deleteEntity".localized(), Type: "")

        WoHeaderModel.deleteWorkorderEntity(entity: entity, options: nil, completionHandler: { (response, error) in
            if error == nil {
                print("\(enitityName) record deleted : Done")
                mJCLogger.log("\(enitityName) record deleted : Done", Type: "Debug")
            }
            else {
                print("\(enitityName) record deleted : Fail!")
                mJCLogger.log("\(enitityName) record deleted : Fail!", Type: "Error")
            }
        })
    }
}
