//
//  FilterVCCell.swift
//  myJobCard
//
//  Created by Suri on 17/08/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit

class FilterVCCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleImg: UIImageView!
    @IBOutlet var bgView: UIView!
    var Selected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
