//
//  CITreeViewCell.swift
//  CITreeView
//
//  Created by Apple on 24.01.2018.
//  Copyright © 2018 Cenk Işık. All rights reserved.
//

import UIKit

class HierarchyTreeViewCell: UITableViewCell {
    
   
    @IBOutlet var leadingConstraint: NSLayoutConstraint!

    @IBOutlet var expandImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeImg: UIImageView!
    @IBOutlet weak var bgView: UIView!

    let leadingValueForChildrenCell:CGFloat = 20

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(level:Int)
    {
       self.leadingConstraint.constant = leadingValueForChildrenCell * CGFloat(level + 1)
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
