//
//  ExpandableTableViewCell.swift
//  SettingsScreenDemo
//
//  Created by Rover Software on 16/01/20.
//  Copyright © 2020 Rover Software. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {
    
    @IBOutlet var settingTitle: UILabel!

    @IBOutlet var settingTextLable: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var sideArrowImg: UIImageView!
    @IBOutlet var switchBtn: UISwitch!
    @IBOutlet var selectionButton: UIButton!


    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
