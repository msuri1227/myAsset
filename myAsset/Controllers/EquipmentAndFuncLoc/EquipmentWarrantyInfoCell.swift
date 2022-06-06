//
//  EquipmentWarrantyInfoCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 31/08/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class EquipmentWarrantyInfoCell: UITableViewCell {

    @IBOutlet weak var customerWarrantyTypeView: UIView!
    @IBOutlet weak var customerWarrantyTypeLabelView: UIView!
    @IBOutlet weak var customerWarrantyTypeLabel: UILabel!
    
    @IBOutlet weak var customerWarrantyStartDateView: UIView!
    @IBOutlet weak var customerWarrantyStartDateLabelView: UIView!
    @IBOutlet weak var customerWarrantyStartDateLabel: UILabel!
    
    @IBOutlet weak var customerWarrantyEndDateView: UIView!
    @IBOutlet weak var customerWarrantyEndDateLabelView: UIView!
    @IBOutlet weak var customerWarrantyEndDateLabel: UILabel!
    
    @IBOutlet weak var customerMasterWarrantyView: UIView!
    @IBOutlet weak var customerMasterWarrantyLabelView: UIView!
    @IBOutlet weak var customerMasterWarrantyLabel: UILabel!
    
    @IBOutlet weak var customerWarrantyStatusView: UIView!
    @IBOutlet weak var customerWarrantyStatusLabelView: UIView!
    @IBOutlet weak var customerWarrantyStatusLabel: UILabel!
    
    @IBOutlet weak var vendorWarrantyTypeView: UIView!
    @IBOutlet weak var vendorWarrantyTypeLabelView: UIView!
    @IBOutlet weak var vendorWarrantyTypeLabel: UILabel!
    
    @IBOutlet weak var vendorWarrantyStartDateView: UIView!
    @IBOutlet weak var vendorWarrantyStartDateLabelView: UIView!
    @IBOutlet weak var vendorWarrantyStartDateLabel: UILabel!
    
    @IBOutlet weak var vendorWarrantyEndDateView: UIView!
    @IBOutlet weak var vendorWarrantyEndDateLabelView: UIView!
    @IBOutlet weak var vendorWarrantyEndDateLabel: UILabel!
    
    @IBOutlet weak var vendorMatserWarrantyView: UIView!
    @IBOutlet weak var vendorMatserWarrantyLabelView: UIView!
    @IBOutlet weak var vendorMatserWarrantyLabel: UILabel!
    
    @IBOutlet weak var vendorWarrantyStatusView: UIView!
    @IBOutlet weak var vendorWarrantyStatusLabelView: UIView!
    @IBOutlet weak var vendorWarrantyStatusLabel: UILabel!
    
    var equipWarrantyInfoModelClass: EquipmentModel? {
        didSet{
            equipmentWarrantyInfoConfiguration()
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
    
    func equipmentWarrantyInfoConfiguration() {
        mJCLogger.log("Starting", Type: "info")
         customerWarrantyTypeLabel.text = equipWarrantyInfoModelClass?.CusWarrantyType
        
        if equipWarrantyInfoModelClass?.CusWarrantyStartDate != nil{
            customerWarrantyStartDateLabel.text = equipWarrantyInfoModelClass?.CusWarrantyStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            customerWarrantyStartDateLabel.text = ""
        }
        
        if equipWarrantyInfoModelClass?.CusWarrantyEndDate != nil{
            customerWarrantyEndDateLabel.text = equipWarrantyInfoModelClass?.CusWarrantyEndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            
        }else{
            customerWarrantyEndDateLabel.text = ""
            
        }
        
         customerMasterWarrantyLabel.text = equipWarrantyInfoModelClass?.CusMasterWarranty
         customerWarrantyStatusLabel.text = equipWarrantyInfoModelClass?.CusWarrantyStatus
         vendorWarrantyTypeLabel.text = equipWarrantyInfoModelClass?.VenWarrantyType
        
        if equipWarrantyInfoModelClass?.VenWarrantyStartDate != nil{
            vendorWarrantyStartDateLabel.text = equipWarrantyInfoModelClass?.VenWarrantyStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            vendorWarrantyStartDateLabel.text = ""
        }
        
        if equipWarrantyInfoModelClass?.VenWarrantyEndDate != nil{
            vendorWarrantyEndDateLabel.text =  equipWarrantyInfoModelClass?.VenWarrantyEndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            vendorWarrantyEndDateLabel.text = ""
        }
        
         vendorMatserWarrantyLabel.text = equipWarrantyInfoModelClass?.VenMasterWarranty
         vendorWarrantyStatusLabel.text = equipWarrantyInfoModelClass?.VenWarrantyStatus
        mJCLogger.log("Ended", Type: "info")
    }

}
