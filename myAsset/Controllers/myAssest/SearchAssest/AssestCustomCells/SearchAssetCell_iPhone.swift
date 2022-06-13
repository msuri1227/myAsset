//
//  SearchAssetCell_iPhone.swift
//  myAsset
//
//  Created by Ruby's Mac on 30/05/22.
//

import UIKit

class SearchAssetCell_iPhone: UITableViewCell {

    @IBOutlet weak var checkBoxImgView: UIImageView!
    
    @IBOutlet weak var assetLbl: UILabel!
    @IBOutlet weak var assetClassLbl: UILabel!
    @IBOutlet weak var assetIdLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var serialNumLbl: UILabel!
    @IBOutlet weak var funcLocLbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var assetStackView: UIStackView!
    @IBOutlet weak var assetClassStackView: UIStackView!
    @IBOutlet weak var assetIdStackView: UIStackView!
    @IBOutlet weak var descStackView: UIStackView!
    @IBOutlet weak var serialNumStackView: UIStackView!
    @IBOutlet weak var funcLocStackView: UIStackView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var rightArrowbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func layoutSubviews() {
        super.layoutSubviews()

//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
