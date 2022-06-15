//
//  EquipmentOverViewCell.swift
//  myJobCard
//
//  Created by Alphaved on 16/01/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class EquipmentOverViewCell: UITableViewCell {
    
    //MARK:- ObjectType View Outlets...
    @IBOutlet var overViewDiscriptionView: UIView!
    @IBOutlet var overViewDiscriptionLabelView: UIView!
    @IBOutlet var overViewDiscriptionLabel: UILabel!
    
    //MARK:- Category View Outlets...
    @IBOutlet var overViewCategoryView: UIView!
    @IBOutlet var overViewCategoryLabelView: UIView!
    @IBOutlet var overViewCategoryLabel: UILabel!
    
    //MARK:- Location View Outlets...
    @IBOutlet var overViewLocationView: UIView!
    @IBOutlet var overViewLocationLabelView: UIView!
    @IBOutlet var overViewLocationLabel: UILabel!
    
    //MARK:- Status View Outlets...
    @IBOutlet var overViewStatusView: UIView!
    @IBOutlet var overViewStatusLabelView: UIView!
    @IBOutlet var overViewStatusLabel: UILabel!
    
    //MARK:- Functional Location View Outlets...
    @IBOutlet var overViewFunctionalLocationView: UIView!
    @IBOutlet var overViewFunctionalLocationLabelView: UIView!
    @IBOutlet var overViewFunctionalLocationLabel: UILabel!

    //MARK:- Section View Outlets...
    @IBOutlet var overViewSectionView: UIView!
    @IBOutlet var overViewSectionLabelView: UIView!
    @IBOutlet var overViewSectionLabel: UILabel!
    
    //MARK:- Plant View Outlets...
    @IBOutlet var overViewPlantView: UIView!
    @IBOutlet var overViewPlantLabelView: UIView!
    @IBOutlet var overViewPlantLabel: UILabel!
    
    //MARK:- Superior Equipment View Outlets...
    @IBOutlet var overViewSuperiorEquipmentView: UIView!
    @IBOutlet var overViewSuperiorEquipmentLabelView: UIView!
    @IBOutlet var overViewSuperiorEquipmentLabel: UILabel!
    
    //MARK:- Part Number View Outlets...
    @IBOutlet var overViewPartNumberView: UIView!
    @IBOutlet var overViewPartNumberLabelView: UIView!
    @IBOutlet var overViewPartNumberLabel: UILabel!
    
    //MARK:- WorkCenter View Outlets...
    @IBOutlet var overViewWorkCenterView: UIView!
    @IBOutlet var overViewWorkCenterLabelView: UIView!
    @IBOutlet var overViewWorkCenterLabel: UILabel!
    
    //MARK:- Menufacturer View Outlets...
    @IBOutlet var overViewMenufacturerView: UIView!
    @IBOutlet var overViewMenufacturerLabelView: UIView!
    @IBOutlet var overViewMenufacturerLabel: UILabel!
    
    //MARK:- Serial Number View Outlets...
    @IBOutlet var overViewSerialNumberView: UIView!
    @IBOutlet var overViewSerialNumberLabelView: UIView!
    @IBOutlet var overViewSerialNumberLabel: UILabel!
    
    //MARK:- Type View Outlets...
    @IBOutlet var overViewTypeView: UIView!
    @IBOutlet var overViewTypeLabelView: UIView!
    @IBOutlet var overViewTypeLabel: UILabel!
    
    //MARK:- Model Number View Outlets...
    @IBOutlet var overViewModelNumberView: UIView!
    @IBOutlet var overViewModelNumberLabelView: UIView!
    @IBOutlet var overViewModelNumberLabel: UILabel!
    @IBOutlet var EquipmentassetmapButton: UIButton!
    
    @IBOutlet weak var equipmentValLbl: UILabel!
    @IBOutlet weak var assetValLbl: UILabel!
    @IBOutlet weak var assetClassValLbl: UILabel!
    @IBOutlet weak var assetOwnerValLbl: UILabel!
    @IBOutlet weak var subNumberValLbl: UILabel!
    @IBOutlet weak var lastInventoryDateValLbl: UILabel!
    @IBOutlet weak var inventoryNoteValLbl: UILabel!
    @IBOutlet weak var inventoryNumValLbl: UILabel!
    @IBOutlet weak var captilizedOnValLbl: UILabel!
    @IBOutlet weak var deactivatedOnValLbl: UILabel!
    @IBOutlet weak var firstAcquisitionDateValLbl: UILabel!
    @IBOutlet weak var geoLocationValLbl: UILabel!
    
    var indexpath = IndexPath()
    var equipOverviewModelClass: ZEquipmentModel? {
        didSet{
            equipmentOverviewConfiguration()
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
    
    func equipmentOverviewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
         overViewDiscriptionLabel.text = equipOverviewModelClass?.EquipDescription
         overViewCategoryLabel.text = equipOverviewModelClass?.EquipCategory
         overViewLocationLabel.text = equipOverviewModelClass?.Location
         overViewStatusLabel.text = equipOverviewModelClass?.SystemStatus
         overViewFunctionalLocationLabel.text = equipOverviewModelClass?.FuncLocation
         overViewSectionLabel.text = equipOverviewModelClass?.PlantSection
         overViewPlantLabel.text = ""
         overViewSuperiorEquipmentLabel.text = equipOverviewModelClass?.SuperiorEquipment
         overViewPartNumberLabel.text = equipOverviewModelClass?.ManufPartNo
         overViewWorkCenterLabel.text = equipOverviewModelClass?.WorkCenter
         overViewMenufacturerLabel.text = equipOverviewModelClass?.Manufacturer
         overViewSerialNumberLabel.text = equipOverviewModelClass?.ManufSerialNo
         overViewTypeLabel.text = equipOverviewModelClass?.ObjectType
         overViewModelNumberLabel.text = equipOverviewModelClass?.ModelNumber
//         EquipmentassetmapButton.tag = indexpath.row
//         EquipmentassetmapButton.addTarget(self, action: #selector(equipmentAssetMapAction(sender:)), for: .touchUpInside)
        
        equipmentValLbl.text = equipOverviewModelClass?.Equipment
        assetValLbl.text = equipOverviewModelClass?.Asset
        assetClassValLbl.text = equipOverviewModelClass?.AssetClass
        assetOwnerValLbl.text = equipOverviewModelClass?.AssetOwner
        subNumberValLbl.text = equipOverviewModelClass?.SubNumber
        inventoryNoteValLbl.text =  equipOverviewModelClass?.InventoryNote
        inventoryNumValLbl.text = equipOverviewModelClass?.InventoryNo

        if equipOverviewModelClass?.LastInventoryDate != nil{
            lastInventoryDateValLbl.text =  ODSDateHelper.convertDateToString(date: (equipOverviewModelClass?.LastInventoryDate)!)
        }
        if equipOverviewModelClass?.AcquistionDate != nil{
            firstAcquisitionDateValLbl.text = ODSDateHelper.convertDateToString(date: (equipOverviewModelClass?.AcquistionDate)!)
        }
        if equipOverviewModelClass?.CapitalizedOn != nil{
            captilizedOnValLbl.text =  ODSDateHelper.convertDateToString(date: (equipOverviewModelClass?.CapitalizedOn)!)
        }
        if equipOverviewModelClass?.DeactivatedOn != nil{
            deactivatedOnValLbl.text =  ODSDateHelper.convertDateToString(date: (equipOverviewModelClass?.DeactivatedOn)!)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
//    //Mark:- Equipment assetmap Actions
//    @objc func equipmentAssetMapAction(sender : UIButton){
//        mJCLogger.log("Starting", Type: "info")
//        self.equipOverviewViewModel.equipmentVc?.updateUIEquipmentassetMap()
//        mJCLogger.log("Ended", Type: "info")
//    }
    
}
