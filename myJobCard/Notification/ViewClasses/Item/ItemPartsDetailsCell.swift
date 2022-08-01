//
//  ItemPartsDetailsCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ItemPartsDetailsCell: UITableViewCell {
    
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //PartsView Outlets..
    @IBOutlet var itemPartsView: UIView!
    @IBOutlet var itemPartsLabelView: UIView!
    @IBOutlet var itemPartsLabel: UILabel!
    
    //PartsGroupView Outlets..
    @IBOutlet var itemPartsGroupView: UIView!
    @IBOutlet var itemPartsGroupLabelView: UIView!
    @IBOutlet var itemPartsGroupLabel: UILabel!
    
    //CatalogView Outlets..
    @IBOutlet var itemCatalogView: UIView!
    @IBOutlet var itemCatalogLabelView: UIView!
    @IBOutlet var itemCatalogLabel: UILabel!
    
    var NotificationItemsModel:NotificationItemsModel?{
        didSet{
            configureItemPartsDetailsCell()
        }
    }
    var notificationItemViewModel = NotificationItemViewModel()
    var indexPath = IndexPath()
    
    func configureItemPartsDetailsCell(){
        mJCLogger.log("Starting", Type: "info")
        itemPartsLabel.text = "\(NotificationItemsModel!.ObjectPartCode) - \(NotificationItemsModel!.ObjectPartCodeText)"
        self.itemPartsGroupLabel.text = "\(NotificationItemsModel!.CodeGroupParts) - \(NotificationItemsModel!.CodeGroupPartsText)"
        itemCatalogLabel.text = NotificationItemsModel!.CatalogType
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
