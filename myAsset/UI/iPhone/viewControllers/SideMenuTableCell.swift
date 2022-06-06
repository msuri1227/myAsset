//
//  SideMenuTableCell.swift
//  SlideMenuDemo
//
//  Created by Ondevice Solutions on 26/02/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit

class SideMenuTableCell: UITableViewCell {

    @IBOutlet weak var sideMenuImg: UIImageView!
    @IBOutlet weak var sideMenuNameLbl: UILabel!
    
    @IBOutlet var sideMenuCellView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
