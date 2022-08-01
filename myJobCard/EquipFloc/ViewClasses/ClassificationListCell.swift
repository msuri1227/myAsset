//
//  ClassificationListCell.swift
//  myJobCard
//
//  Created by Gowri on 12/02/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ClassificationListCell: UITableViewCell {

    @IBOutlet weak var lbl_classificationType: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_classificationName: UILabel!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var BgView: UIView!
    
    var indexpath = IndexPath()

    var equipClassificationModelClass: ClassificationModel? {
        didSet{
            equipmentClassificationConfiguration()
        }
    }
    var funcLocClassificationModelClass: ClassificationModel? {
        didSet{
            funcLocClassificationConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func equipmentClassificationConfiguration() {
        lbl_classificationName.text = equipClassificationModelClass?.ClassNum
        lbl_classificationType.text = equipClassificationModelClass?.ClassType
        lbl_description.text = equipClassificationModelClass?.ClassDesc
        BgView.layer.cornerRadius = 3.0
        BgView.layer.shadowOffset = CGSize(width: 3, height: 3)
        BgView.layer.shadowOpacity = 0.2
        BgView.layer.shadowRadius = 2
        if DeviceType == iPad{
            if indexpath.row == 0{
                transparentView.isHidden = false
               // equipClassificationViewModel.getClassficationCharacterstics(classification: equipClassificationModelClass!)
            }else{
                transparentView.isHidden = true
            }
        }
    }
    func funcLocClassificationConfiguration() {
        lbl_classificationName.text = funcLocClassificationModelClass?.ClassNum
        lbl_classificationType.text = funcLocClassificationModelClass?.ClassType
        lbl_description.text = funcLocClassificationModelClass?.ClassDesc
        if DeviceType == iPad{
            if indexpath.row == 0{
                transparentView.isHidden = false
                //funcLocClassificationViewModel.getFLClassficationCharacterstics(classification: funcLocClassificationModelClass!)
            }
        }
        BgView.layer.cornerRadius = 3.0
        BgView.layer.shadowOffset = CGSize(width: 3, height: 3)
        BgView.layer.shadowOpacity = 0.2
        BgView.layer.shadowRadius = 2

    }
}
