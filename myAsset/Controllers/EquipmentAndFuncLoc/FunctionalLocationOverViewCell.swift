//
//  FunctioanLocationOverViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 3/18/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class FunctionalLocationOverViewCell: UITableViewCell {

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
    
    //MARK:- Section View Outlets...
    @IBOutlet var overViewSectionView: UIView!
    @IBOutlet var overViewSectionLabelView: UIView!
    @IBOutlet var overViewSectionLabel: UILabel!
    
    //MARK:- Plant View Outlets...
    @IBOutlet var overViewPlantView: UIView!
    @IBOutlet var overViewPlantLabelView: UIView!
    @IBOutlet var overViewPlantLabel: UILabel!
    
    //MARK:- Superior Equipment View Outlets...
    @IBOutlet var overViewSuperiorFunctionalLocationView: UIView!
    @IBOutlet var overViewSuperiorFunctionalLocationLabelView: UIView!
    @IBOutlet var overViewSuperiorFunctionalLocationLabel: UILabel!
    
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
    
    var funcLocOverviewModelClass: FunctionalLocationModel? {
        didSet{
            functionLocationOverviewConfiguration()
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
    
    func functionLocationOverviewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
         overViewDiscriptionLabel.text = funcLocOverviewModelClass?.Description
         overViewCategoryLabel.text = funcLocOverviewModelClass?.FunctLocCat
         overViewLocationLabel.text = funcLocOverviewModelClass?.Location
         overViewStatusLabel.text = funcLocOverviewModelClass?.SystemStatus
         overViewMenufacturerLabel.text = funcLocOverviewModelClass?.Manufacturer
         overViewPartNumberLabel.text = funcLocOverviewModelClass?.ManufPartNo
         overViewTypeLabel.text = funcLocOverviewModelClass?.ObjectType
         overViewSuperiorFunctionalLocationLabel.text = funcLocOverviewModelClass?.SupFunctLoc
         overViewSectionLabel.text = funcLocOverviewModelClass?.PlantSection
         overViewPlantLabel.text = funcLocOverviewModelClass?.PlanningPlant
         overViewModelNumberLabel.text = funcLocOverviewModelClass?.ModelNumber
         overViewSerialNumberLabel.text = funcLocOverviewModelClass?.ManufSerialNo
         overViewWorkCenterLabel.text = funcLocOverviewModelClass?.WorkCenter
         mJCLogger.log("Ended", Type: "info")
    }    
}
