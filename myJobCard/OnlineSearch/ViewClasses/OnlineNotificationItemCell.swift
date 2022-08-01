//
//  OnlineNotificationItemCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 19/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OnlineNotificationItemCell: UITableViewCell {

    @IBOutlet weak var partLbl: UILabel!
    @IBOutlet weak var partGroupLbl: UILabel!
    @IBOutlet weak var partCatalogLbl: UILabel!
    @IBOutlet weak var damageLbl: UILabel!
    @IBOutlet weak var damageGroupLbl: UILabel!
    @IBOutlet weak var damageCatalog: UILabel!
    @IBOutlet weak var sortNumberLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var itemNumLbl: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var onlineNOItemModelClass: NotificationItemsModel? {
        didSet{
            onlineNOItemConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func onlineNOItemConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let onlineNOItemClass = onlineNOItemModelClass {
            itemNumLbl.text = "Item".localized() + " : \(onlineNOItemClass.SortNumber)"
            sortNumberLbl.text = onlineNOItemClass.SortNumber
            descriptionLbl.text = onlineNOItemClass.ShortText
            partLbl.text = onlineNOItemClass.ObjectPartCode
            partGroupLbl.text = onlineNOItemClass.CodeGroupParts
            partCatalogLbl.text = onlineNOItemClass.CatalogType
            damageLbl.text = onlineNOItemClass.DamageCode
            damageGroupLbl.text = onlineNOItemClass.DamageCodeGroup
            damageCatalog.text = onlineNOItemClass.DefectTypes
        }
        mJCLogger.log("Ended", Type: "info")
    }

}
