//
//  FunctionalLocationListCell.swift
//  MyJobCard
//
//  Created by Pratik Patel on 2/24/17.
//  Copyright © 2017 Pratik Patel. All rights reserved.
//

import UIKit

class FunctionalLocationListCell: UITableViewCell {

    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var decriptionLabel: UILabel!
    @IBOutlet var plantLabel: UILabel!
    @IBOutlet var quantityAvailableLabel: UILabel!
    @IBOutlet var storageLocationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
