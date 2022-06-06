//
//  AssetHierarchyOverView.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 29/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class AssetHierarchyOverViewCell: UITableViewCell {
    
    //AssetHierarchyOverViewHeaderView Outlets..
    @IBOutlet var AssetHierarchyOverViewHeaderView: UIView!
    @IBOutlet var AssetHierarchyOverViewHeaderLabel: UILabel!
    
    //BackGroundView Outlets..
    @IBOutlet var backGroundView: UIView!
    
    //AssetHierarchyOverViewDescriptionView Outlets..
    @IBOutlet var AssetHierarchyOverViewDescriptionView: UIView!
    @IBOutlet var AssetHierarchyOverViewDescriptionLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewDescriptionLabel: UILabel!
    
    //AssetHierarchyOverViewCategoryView Outlets..
    @IBOutlet var AssetHierarchyOverViewCategoryView: UIView!
    @IBOutlet var AssetHierarchyOverViewCategoryLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewCategoryLabel: UILabel!
    
    //AssetHierarchyOverViewStatusView Outlets..
    @IBOutlet var AssetHierarchyOverViewStatusView: UIView!
    @IBOutlet var AssetHierarchyOverViewStatusLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewStatusLabel: UILabel!
    
    @IBOutlet var addspeakerButton: UIButton!
    //AssetHierarchyOverViewLocationView Outlets..
    @IBOutlet var AssetHierarchyOverViewLocationView: UIView!
    @IBOutlet var AssetHierarchyOverViewLocationLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewLocationLabel: UILabel!
    
    //AssetHierarchyOverViewPlantView Outlets..
    @IBOutlet var AssetHierarchyOverViewPlantView: UIView!
    @IBOutlet var AssetHierarchyOverViewPlantLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewPlantLabel: UILabel!
    
    //AssetHierarchyOverViewSectionView Outlets..
    @IBOutlet var AssetHierarchyOverViewSectionView: UIView!
    @IBOutlet var AssetHierarchyOverViewSectionLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewSectionLabel: UILabel!
    
    //AssetHierarchyOverViewTypeView Outlets..
    @IBOutlet var AssetHierarchyOverViewWorkcentreView: UIView!
    @IBOutlet var AssetHierarchyOverViewWorkcentreLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewWorkcentreLabel: UILabel!
    
    //AssetHierarchyOverViewPartNumberView Outlets..
    @IBOutlet var AssetHierarchyOverViewPartNumberView: UIView!
    @IBOutlet var AssetHierarchyOverViewPartNumberLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewPartNumberLabel: UILabel!
    
    //AssetHierarchyOverViewManufaturerView Outlets..
    @IBOutlet var AssetHierarchyOverViewManufaturerView: UIView!
    @IBOutlet var AssetHierarchyOverViewManufaturerLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewManufaturerLabel: UILabel!
    
    //AssetHierarchyOverViewSerialNumberView Outlets..
    @IBOutlet var AssetHierarchyOverViewSerialNumberView: UIView!
    @IBOutlet var AssetHierarchyOverViewSerialNumberLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewSerialNumberLabel: UILabel!
    
    @IBOutlet var AssetHierarchyOverViewNotificationButton: UIButton!
    //AssetHierarchyOverViewTypeView Outlets..
    @IBOutlet var AssetHierarchyOverViewTypeView: UIView!
    @IBOutlet var AssetHierarchyOverViewTypeLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewTypeLabel: UILabel!
    
    //AssetHierarchyOverViewPlanningModelNumberView Outlets..
    @IBOutlet var AssetHierarchyOverViewModelNumberView: UIView!
    @IBOutlet var AssetHierarchyOverViewModelNumberLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewModelNumberLabel: UILabel!
    
    //AssetHierarchyOverViewStartView Outlets..
    @IBOutlet var AssetHierarchyOverViewSuperiorFuncLocationView: UIView!
    @IBOutlet var AssetHierarchyOverViewSuperiorFuncLocationLabelView: UIView!
    @IBOutlet var AssetHierarchyOverViewSuperiorFuncLocationLabel: UILabel!
    
    var assetHierarchyEquipmentModel: EquipmentModel? {
        didSet{
            assetHierarchyEquipmentConfiguration()
        }
    }
    var assetHierarchyFuncLocModelClass: FunctionalLocationModel? {
        didSet{
            assetHierarchyFuncLocConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        AssetHierarchyOverViewHeaderLabel.text = "OverView".localized()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func assetHierarchyEquipmentConfiguration() {
         AssetHierarchyOverViewDescriptionLabel.text = assetHierarchyEquipmentModel?.EquipDescription
         AssetHierarchyOverViewCategoryLabel.text = assetHierarchyEquipmentModel?.EquipCategory
         AssetHierarchyOverViewStatusLabel.text = assetHierarchyEquipmentModel?.SystemStatus
         AssetHierarchyOverViewLocationLabel.text = assetHierarchyEquipmentModel?.Location
         AssetHierarchyOverViewPlantLabel.text = assetHierarchyEquipmentModel?.MaintPlant
         AssetHierarchyOverViewSectionLabel.text = assetHierarchyEquipmentModel?.PlantSection
         AssetHierarchyOverViewWorkcentreLabel.text = assetHierarchyEquipmentModel?.WorkCenter
         AssetHierarchyOverViewPartNumberLabel.text = assetHierarchyEquipmentModel?.ManufPartNo
         AssetHierarchyOverViewManufaturerLabel.text = assetHierarchyEquipmentModel?.Manufacturer
         AssetHierarchyOverViewSerialNumberLabel.text = assetHierarchyEquipmentModel?.ManufSerialNo
         AssetHierarchyOverViewTypeLabel.text = assetHierarchyEquipmentModel?.ObjectType
         AssetHierarchyOverViewModelNumberLabel.text = assetHierarchyEquipmentModel?.ModelNumber
         AssetHierarchyOverViewSuperiorFuncLocationLabel.text = assetHierarchyEquipmentModel?.FuncLocation
    }
    func assetHierarchyFuncLocConfiguration() {
         AssetHierarchyOverViewDescriptionLabel.text = assetHierarchyFuncLocModelClass?.Description
         AssetHierarchyOverViewCategoryLabel.text = assetHierarchyFuncLocModelClass?.FunctLocCat
         AssetHierarchyOverViewStatusLabel.text = assetHierarchyFuncLocModelClass?.SystemStatus
         AssetHierarchyOverViewLocationLabel.text = assetHierarchyFuncLocModelClass?.Location
         AssetHierarchyOverViewPlantLabel.text = assetHierarchyFuncLocModelClass?.MaintPlant
         AssetHierarchyOverViewSectionLabel.text = assetHierarchyFuncLocModelClass?.PlantSection
         AssetHierarchyOverViewWorkcentreLabel.text = assetHierarchyFuncLocModelClass?.WorkCenter
         AssetHierarchyOverViewPartNumberLabel.text = assetHierarchyFuncLocModelClass?.ManufPartNo
         AssetHierarchyOverViewManufaturerLabel.text = assetHierarchyFuncLocModelClass?.Manufacturer
         AssetHierarchyOverViewSerialNumberLabel.text = assetHierarchyFuncLocModelClass?.ManufSerialNo
         AssetHierarchyOverViewTypeLabel.text = assetHierarchyFuncLocModelClass?.ObjectType
         AssetHierarchyOverViewModelNumberLabel.text = assetHierarchyFuncLocModelClass?.ModelNumber
         AssetHierarchyOverViewSuperiorFuncLocationLabel.text = assetHierarchyFuncLocModelClass?.SupFunctLoc
    }
}
