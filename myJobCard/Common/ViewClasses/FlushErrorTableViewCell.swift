//
//  FlushErrorTableViewCell.swift
//  myJobCard
//
//  Created by Khaleel on 29/03/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib

class FlushErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var objKeyLabel: UILabel!
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var ignoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mJCLogger.log("Starting", Type: "info")
        self.editButton.isHidden = true
        self.ignoreButton.isHidden = true
        self.clearButton.isHidden = false
        self.clearButton.setTitle("Edit".localized(), for: .normal)
        mJCLogger.log("Ended", Type: "info")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
