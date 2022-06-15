//
//  SearchAssetCell_iPhone.swift
//  myAsset
//
//  Created by Ruby's Mac on 30/05/22.
//

import UIKit
import ODSFoundation
import mJCLib

class SearchAssetCell_iPhone: UITableViewCell {

    @IBOutlet weak var assetTitleLbl: UILabel!
    @IBOutlet weak var assetValueLbl: UILabel!
    @IBOutlet weak var assetClassTitleLbl: UILabel!
    @IBOutlet weak var assetClassValueLbl: UILabel!
    @IBOutlet weak var serialNumTitleLbl: UILabel!
    @IBOutlet weak var serialNumValueLbl: UILabel!
    @IBOutlet weak var flocTitleLbl: UILabel!
    @IBOutlet weak var flocValueLbl: UILabel!
    @IBOutlet var indicatorView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var rightArrowbtn: UIButton!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    var assetDetailsVC : AssetDetailsVC?
    var unInspCellModel: WorkorderObjectModel? {
        didSet{
            unInspectedCellConfiguration()
        }
    }
    var inspCellModel: WorkorderObjectModel? {
        didSet{
            inspectedCellConfiguration()
        }
    }
    var assetListCellModel: EquipmentModel? {
        didSet{
            assetListCellConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func unInspectedCellConfiguration(){
        self.assetTitleLbl.text = "Asset".localized()
        self.assetClassTitleLbl.text = "Description".localized()
        self.serialNumTitleLbl.text = "XlX-OA-4G1".localized()
        self.flocTitleLbl.text = "Functional_Location".localized()
        self.assetValueLbl.text = unInspCellModel?.Equipment
        self.assetClassValueLbl.text = unInspCellModel?.EquipmentDescription
        self.serialNumValueLbl.text = unInspCellModel?.SerialNumber
        self.flocValueLbl.text = unInspCellModel?.FunctionalLoc
        self.indicatorView.backgroundColor = appColor
    }
    func inspectedCellConfiguration(){
        self.assetTitleLbl.text = "Asset".localized()
        self.assetClassTitleLbl.text = "Description".localized()
        self.serialNumTitleLbl.text = "XlX-OA-4G1".localized()
        self.flocTitleLbl.text = "Functional_Location".localized()
        self.assetValueLbl.text = inspCellModel?.Equipment
        self.assetClassValueLbl.text = inspCellModel?.EquipmentDescription
        self.serialNumValueLbl.text = inspCellModel?.SerialNumber
        self.flocValueLbl.text = inspCellModel?.FunctionalLoc
        if self.inspCellModel?.ProcessIndic == "I"{
            self.checkBoxBtn.setImage(UIImage(named: "ic_check_Green"), for: .normal)
            self.indicatorView.backgroundColor = UIColor.green
        }else{
            self.checkBoxBtn.setImage(UIImage(named: "ic_check_Red"), for: .normal)
            self.indicatorView.backgroundColor = UIColor.red
        }
    }
    func assetListCellConfiguration(){
        self.assetTitleLbl.text = "Asset_ID".localized()
        self.assetClassTitleLbl.text = "Description".localized()
        self.serialNumTitleLbl.text = "Asset_Class".localized()
        self.flocTitleLbl.text = "Functional_Location".localized()
        self.assetValueLbl.text = assetListCellModel?.Equipment
        self.assetClassValueLbl.text = assetListCellModel?.EquipDescription
        self.serialNumValueLbl.text = assetListCellModel?.Equipment
        self.flocValueLbl.text = assetListCellModel?.FuncLocation
        self.cameraBtn.isHidden = true
    }
}
