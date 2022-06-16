//
//  ZworkorderList.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 23/12/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ZworkorderList : WoHeaderModel {
 // @objc public var PostalCode = String()
}
class ZNotifitem : NotificationItemsModel{
    @objc public var Version = String()
}
class ZEquipmentModel: EquipmentModel{
    @objc public var AssetClass = String()
    @objc public var AssetDesc = String()
    @objc public var AssetOwner = String()
    @objc public var LastInventoryDate : Date? = nil
    @objc public var InventoryNote = String()
    @objc public var InventoryNumber = String()
    @objc public var CapitalizedOn : Date? = nil
    @objc public var DeactivatedOn : Date? = nil
    @objc public var SerialNumber = String()
    @objc public var GEOLocation = String()
    
    
}
