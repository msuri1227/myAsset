//
//  FunctioanLocationAdditionalInfoCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 3/18/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class FunctionalLocationAdditionalInfoCell: UITableViewCell {
    
    //MARK:- ObjectType View Outlets...
    @IBOutlet var addInfoObjectTypeView: UIView!
    @IBOutlet var addInfoObjectTypeLabelView: UIView!
    @IBOutlet var addInfoObjectTypeLabel: UILabel!
    
    //MARK:- Year of Construction View Outlets...
    @IBOutlet var addInfoYearofConstructionView: UIView!
    @IBOutlet var addInfoYearofConstructionLabelView: UIView!
    @IBOutlet var addInfoYearofConstructionLabel: UILabel!
    
    //MARK:- Maintenance Plant View Outlets...
    @IBOutlet var addInfoMaintenancePlantView: UIView!
    @IBOutlet var addInfoMaintenancePlantLabelView: UIView!
    @IBOutlet var addInfoMaintenancePlantLabel: UILabel!
    
    //MARK:- Dimension View Outlets...
    @IBOutlet var addInfoDimensionView: UIView!
    @IBOutlet var addInfoDimensionLabelView: UIView!
    @IBOutlet var addInfoDimensionLabel: UILabel!
    
    //MARK:- Month of Construction View Outlets...
    @IBOutlet var addInfoMonthofConstructionView: UIView!
    @IBOutlet var addInfoMonthofConstructionLabelView: UIView!
    @IBOutlet var addInfoMonthofConstructionLabel: UILabel!
    
    //MARK:- Business Area View Outlets...
    @IBOutlet var addInfoBusinessAreaView: UIView!
    @IBOutlet var addInfoBusinessAreaLabelView: UIView!
    @IBOutlet var addInfoBusinessAreaLabel: UILabel!
    
    //MARK:- Weight View Outlets...
    @IBOutlet var addInfoWeightView: UIView!
    @IBOutlet var addInfoWeightLabelView: UIView!
    @IBOutlet var addInfoWeightLabel: UILabel!
    
    //MARK:- Store Location View Outlets...
    @IBOutlet var addInfoStoreLocationView: UIView!
    @IBOutlet var addInfoOStoreLocationLabelView: UIView!
    @IBOutlet var addInfoStoreLocationLabel: UILabel!
    
    //MARK:- Cost Center  View Outlets...
    @IBOutlet var addInfoCostCenterView: UIView!
    @IBOutlet var addInfoCostCenterLabelView: UIView!
    @IBOutlet var addInfoCostCenterLabel: UILabel!
    
    //MARK:- Unit View Outlets...
    @IBOutlet var addInfoUnitView: UIView!
    @IBOutlet var addInfoUnitLabelView: UIView!
    @IBOutlet var addInfoUnitLabel: UILabel!
    
    //MARK:- Current Customer  View Outlets...
    @IBOutlet var addInfoCurrentCustomerView: UIView!
    @IBOutlet var addInfoCurrentCustomerLabelView: UIView!
    @IBOutlet var addInfoCurrentCustomerLabel: UILabel!
    
    //MARK:- Company Code View Outlets...
    @IBOutlet var addInfoCompanyCodeView: UIView!
    @IBOutlet var addInfoCompanyCodeLabelView: UIView!
    @IBOutlet var addInfoCompanyCodeLabel: UILabel!
    
    //MARK:- Vendor View Outlets...
    @IBOutlet var addInfoVendorView: UIView!
    @IBOutlet var addInfoVendorLabelView: UIView!
    @IBOutlet var addInfoVendorLabel: UILabel!
    
    //MARK:- Maintenance Plan View Outlets...
    @IBOutlet var addInfoMaintenancePlanView: UIView!
    @IBOutlet var addInfoMaintenancePlanLabelView: UIView!
    @IBOutlet var addInfoMaintenancePlanLabel: UILabel!
    
    //MARK:- Address View Outlets...
    @IBOutlet var addInfoSortFieldView: UIView!
    @IBOutlet var addInfoSortFieldLabelView: UIView!
    @IBOutlet var addInfoSortFieldLabel: UILabel!

    //MARK:- Stock Type View Outlets...
    @IBOutlet var addInfoStockTypeView: UIView!
    @IBOutlet var addInfoStockTypeLabelView: UIView!
    @IBOutlet var addInfoStockTypeLabel: UILabel!
    
    //MARK:- Warrenty End View Outlets...
    @IBOutlet var addInfoWarrentyEndView: UIView!
    @IBOutlet var addInfoWarrentyEndLabelView: UIView!
    @IBOutlet var addInfoWarrentyEndLabel: UILabel!
    
    //MARK:- Position View Outlets...
    @IBOutlet var addInfoPositionView: UIView!
    @IBOutlet var addInfoPositionLabelView: UIView!
    @IBOutlet var addInfoPositionLabel: UILabel!
    
    //MARK:- Stock Batch View Outlets...
    @IBOutlet var addInfoStockBatchView: UIView!
    @IBOutlet var addInfoStockBatchLabelView: UIView!
    @IBOutlet var addInfoStockBatchLabel: UILabel!
    
    //MARK:- Drawing Number View Outlets...
    @IBOutlet var addInfoDrawingNumberView: UIView!
    @IBOutlet var addInfoDrawingNumberLabelView: UIView!
    @IBOutlet var addInfoDrawingNumberLabel: UILabel!
    
    //MARK:- ABC Indicator View Outlets...
    @IBOutlet var addInfoABCIndicatorView: UIView!
    @IBOutlet var addInfoABCIndicatorLabelView: UIView!
    @IBOutlet var addInfoABCIndicatorLabel: UILabel!
        
    var funcLocAdditionalInfoModelClass: FunctionalLocationModel? {
        didSet{
            functionLocationAdditionalInfoConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func functionLocationAdditionalInfoConfiguration() {
        mJCLogger.log("Starting", Type: "info")
         addInfoObjectTypeLabel.text = funcLocAdditionalInfoModelClass?.ObjectType
         addInfoYearofConstructionLabel.text = funcLocAdditionalInfoModelClass?.ConstructYear
         addInfoMaintenancePlantLabel.text = funcLocAdditionalInfoModelClass?.MaintPlant
         addInfoDimensionLabel.text = funcLocAdditionalInfoModelClass?.SizeDimens
         addInfoMonthofConstructionLabel.text = funcLocAdditionalInfoModelClass?.ConstructMth
         addInfoBusinessAreaLabel.text = funcLocAdditionalInfoModelClass?.BusinessArea
         addInfoStoreLocationLabel.text = funcLocAdditionalInfoModelClass?.RefLocation
         addInfoCostCenterLabel.text = funcLocAdditionalInfoModelClass?.CostCenter
         addInfoUnitLabel.text = funcLocAdditionalInfoModelClass?.WeightUnit
         addInfoCurrentCustomerLabel.text = ""
         addInfoCompanyCodeLabel.text = funcLocAdditionalInfoModelClass?.CompanyCode
         addInfoVendorLabel.text = ""
         addInfoMaintenancePlanLabel.text = ""
         addInfoSortFieldLabel.text = funcLocAdditionalInfoModelClass?.Sortfield
         addInfoWarrentyEndLabel.text = ""
         addInfoPositionLabel.text = funcLocAdditionalInfoModelClass?.Position
         addInfoStockTypeLabel.text = funcLocAdditionalInfoModelClass?.StrIndicator
         addInfoDrawingNumberLabel.text = ""
         addInfoABCIndicatorLabel.text = funcLocAdditionalInfoModelClass?.ABCIndicator
         addInfoStockBatchLabel.text = ""
        //                    let intval :Int? = Int(funcLocAdditionalInfoModelClass?.GrossWeight)
        //                     addInfoWeightLabel.text = "\(intval!).000"
        mJCLogger.log("Ended", Type: "info")
    }
}
