//
//  EuipmentAdditionalCell.swift
//  myJobCard
//
//  Created by Alphaved on 16/01/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class EuipmentAdditionalCell: UITableViewCell {

    
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
    
    //MARK:- Address View Outlets...
    @IBOutlet var addInfoAddressView: UIView!
    @IBOutlet var addInfoAddressLabelView: UIView!
    @IBOutlet var addInfoAddressLabel: UILabel!

    var equipAdditionalModelClass: EquipmentModel? {
        didSet{
            equipmentAdditionalConfiguration()
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
    
    func equipmentAdditionalConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        addInfoObjectTypeLabel.text = equipAdditionalModelClass?.ObjectType
        addInfoYearofConstructionLabel.text = equipAdditionalModelClass?.ConstructYear
        addInfoMaintenancePlanLabel.text = equipAdditionalModelClass?.MaintPlant
        addInfoDimensionLabel.text = equipAdditionalModelClass?.SizeDimens
        addInfoMonthofConstructionLabel.text = equipAdditionalModelClass?.ConstructMth
        addInfoBusinessAreaLabel.text = equipAdditionalModelClass?.BusinessArea
        addInfoWeightLabel.text = String(format:"%.2f",equipAdditionalModelClass?.Weight ?? "0.0")
        addInfoStoreLocationLabel.text = ""
        addInfoCostCenterLabel.text = equipAdditionalModelClass?.CostCenter
        addInfoUnitLabel.text = equipAdditionalModelClass?.UnitofWeight
        addInfoCurrentCustomerLabel.text = equipAdditionalModelClass?.Customer
        addInfoCompanyCodeLabel.text = equipAdditionalModelClass?.CompanyCode
        addInfoVendorLabel.text = equipAdditionalModelClass?.Vendor
        addInfoMaintenancePlanLabel.text = ""
        addInfoStockTypeLabel.text = ""
        if equipAdditionalModelClass?.WarrantyEnd != nil{
            addInfoWarrentyEndLabel.text = equipAdditionalModelClass?.WarrantyEnd!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            addInfoWarrentyEndLabel.text = ""
        }
        
        addInfoPositionLabel.text = equipAdditionalModelClass?.Position
        addInfoStockBatchLabel.text = ""
        addInfoDrawingNumberLabel.text = ""
        addInfoABCIndicatorLabel.text = equipAdditionalModelClass?.ABCIndicator
        addInfoAddressLabel.text = equipAdditionalModelClass?.AddNumber
        mJCLogger.log("Ended", Type: "info")
    }
    
}
