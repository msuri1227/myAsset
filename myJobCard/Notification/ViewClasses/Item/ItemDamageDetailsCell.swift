//
//  ItemDamageDetailsCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ItemDamageDetailsCell: UITableViewCell {
    
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //DamageView Outlets..
    @IBOutlet var itemDamageView: UIView!
    @IBOutlet var itemDamageLabelView: UIView!
    @IBOutlet var itemDamageLabel: UILabel!
    
    //DamageGroupView Outlets..
    @IBOutlet var itemDamageGroupView: UIView!
    @IBOutlet var itemDamageGroupLabelView: UIView!
    @IBOutlet var itemDamageGroupLabel: UILabel!
    
    //CatalogView Outlets..
    @IBOutlet var itemCatalogView: UIView!
    @IBOutlet var itemCatalogLabelView: UIView!
    @IBOutlet var itemCatalogLabel: UILabel!
    
    var NotificationItemsModel:NotificationItemsModel?{
        didSet{
            configureItemDamageDetailsCell()
        }
    }
    var notificationItemViewModel = NotificationItemViewModel()
    var indexPath = IndexPath()
    
    func configureItemDamageDetailsCell(){
        mJCLogger.log("Starting", Type: "info")
        notificationItemViewModel.getDamageValue(catalogCode: NotificationItemsModel!.DefectTypes, codeGroup: NotificationItemsModel!.DamageCodeGroup, code: NotificationItemsModel!.DamageCode)
        
        self.itemCatalogLabel.text = self.NotificationItemsModel!.DefectTypes
        self.notificationItemViewModel.damageArray.removeAll()
        self.itemDamageGroupLabel.text = ""
        self.itemDamageLabel.text = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if self.notificationItemViewModel.damageArray.count > 0{
                self.itemDamageGroupLabel.text = self.notificationItemViewModel.damageArray[0].CodeGroup + " - " + self.notificationItemViewModel.damageArray[0].CodeGroupText
                self.itemDamageLabel.text = self.notificationItemViewModel.damageArray[0].Code + " - " + self.notificationItemViewModel.damageArray[0].CodeText
            }
        })
        
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
