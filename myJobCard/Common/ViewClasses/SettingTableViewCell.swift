//
//  SettingTableViewCell.swift
//  SettingsScreenDemo
//
//  Created by Rover Software on 17/01/20.
//  Copyright © 2020 Rover Software. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell{
    
    @IBOutlet var settingTitleLabel: UILabel!
    
    @IBOutlet var settingsSwitch: UISwitch!
    
    @IBOutlet var expandButton: UIButton!
    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var sideArrImg: UIImageView!
    @IBOutlet var settingDescriptionLabel: UILabel!

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   
       
}
