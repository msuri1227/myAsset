//
//  ExtraTableViewCell.swift
//  myJobCard
//
//  Created by Rover Software on 15/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var objectTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var msgTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
