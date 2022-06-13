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
    @IBOutlet weak var assetIdLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var assetClassLbl: UILabel!
    @IBOutlet weak var serialNumLbl: UILabel!
    @IBOutlet weak var funcLocLbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var assetBgView: UIView!
    @IBOutlet weak var assetIdBgView: UIView!
    @IBOutlet weak var descBgView: UIView!
    @IBOutlet weak var assetClassBgView: UIView!
    @IBOutlet weak var serialNumBgView: UIView!
    @IBOutlet weak var funcLocBgView: UIView!
    
    
    @IBOutlet weak var assetBgViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var assetIdBgViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var descBgViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var assetClassBgViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var serialNumBgViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var funcLocBgViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var rightArrowbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.assetBgViewHeightConst.constant = 0
        self.assetClassBgViewHeightConst.constant = 0
        self.assetBgView.isHidden = true
        self.assetClassBgView.isHidden = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()

//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
