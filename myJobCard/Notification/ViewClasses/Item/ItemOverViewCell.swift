//
//  ItemOverViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ItemOverViewCell: UITableViewCell {

    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //DescriptionView Outlets..
    @IBOutlet var itemDescriptionView: UIView!
    @IBOutlet var itemDescriptionLabelView: UIView!
    @IBOutlet var itemDescriptionLabel: UILabel!
    
    //SortNumberView Outlets..
    @IBOutlet var itemSortNumberView: UIView!
    @IBOutlet var itemSortNumberLabelView: UIView!
    @IBOutlet var itemSortNumberLabel: UILabel!
    
    var NotificationItemsModel:NotificationItemsModel?{
        didSet{
            configureItemOverViewCell()
        }
    }
    
    var notificationItemViewModel = NotificationItemViewModel()
    var indexPath = IndexPath()

    func configureItemOverViewCell(){
        mJCLogger.log("Starting", Type: "info")
        itemDescriptionLabel.text = NotificationItemsModel?.ShortText
        itemSortNumberLabel.text = NotificationItemsModel?.SortNumber
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
