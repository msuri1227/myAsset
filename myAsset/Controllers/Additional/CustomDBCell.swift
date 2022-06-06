//
//  CustomDBCell.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 20/10/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit

class CustomDBCell: UITableViewCell {

    @IBOutlet weak var woNumLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priorityImg: UIImageView!
    @IBOutlet weak var technicianLable: UILabel!
    @IBOutlet weak var techWidthConstant: NSLayoutConstraint!
    
    @IBOutlet weak var plannedHoursLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.TypeLabel.layer.backgroundColor  = UIColor.lightGray.cgColor
        self.TypeLabel.layer.borderWidth = 1.0
        self.TypeLabel.layer.borderColor = UIColor.gray.cgColor
        self.TypeLabel.layer.cornerRadius = 10
        self.TypeLabel.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
