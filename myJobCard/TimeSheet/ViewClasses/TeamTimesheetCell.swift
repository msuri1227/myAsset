//
//  FinalTimeSheetCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 19/11/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit

class TeamTimesheetCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
