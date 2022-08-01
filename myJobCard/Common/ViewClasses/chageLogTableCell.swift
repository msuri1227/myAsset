//
//  chageLogTableCell.swift
//  myJobCard
//
//  Created by Suri on 28/11/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation

class chageLogTableCell: UITableViewCell {

    @IBOutlet var bgView: TileView!
    @IBOutlet var sideImageView: UIImageView!
    @IBOutlet var featureTextLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
