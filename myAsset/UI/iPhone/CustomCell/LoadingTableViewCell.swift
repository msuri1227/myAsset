//
//  LoadingTableViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 23/11/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
