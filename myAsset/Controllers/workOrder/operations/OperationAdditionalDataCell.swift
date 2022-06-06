//
//  OperationAdditionalDataCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OperationAdditionalDataCell: UITableViewCell {

    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //AdditionalDataMaterialGroupView Outlets..
    @IBOutlet var additionalDataMaterialGroupView: UIView!
    @IBOutlet var additionalDataMaterialGroupLabelView: UIView!
    @IBOutlet var additionalDataMaterialGroupLabel: UILabel!
    
    //AdditionalDataBusinessAreaView Outlets..
    @IBOutlet var additionalDataBusinessAreaView: UIView!
    @IBOutlet var additionalDataBusinessAreaLabelView: UIView!
    @IBOutlet var additionalDataBusinessAreaLabel: UILabel!
    
    //AdditionalDataActualPlantView Outlets..
    @IBOutlet var additionalDataActualPlantView: UIView!
    @IBOutlet var additionalDataActualPlantLabelView: UIView!
    @IBOutlet var additionalDataActualPlantLabel: UILabel!
    
    @IBOutlet weak var WorkOrderInfoButton: UIButton!
    
    
    var operationVCModel = OperationOverViewModel()
    var indexPath: NSIndexPath!
    var operationClass: WoOperationModel?{
        didSet{
            operationAddDataConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func operationAddDataConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let singleOperalClass = operationClass {
            
            self.additionalDataMaterialGroupLabel.text = singleOperalClass.MaterialGroup
            self.additionalDataBusinessAreaLabel.text = singleOperalClass.BusinessArea
            self.additionalDataActualPlantLabel.text = singleOperalClass.Plant
            
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity :singleOperalClass.entity){
                self.additionalDataBusinessAreaLabel.text = ""
            }
            
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && self.operationVCModel.isfromsup != "Supervisor" {
                
                self.WorkOrderInfoButton.tag = indexPath.row
                
                self.WorkOrderInfoButton.addTarget(self, action: #selector(self.WorkOrderInforButtonAction), for: UIControl.Event.touchUpInside)
                if singleOperalClass.WorkOrderDetailsInfo == true{
                    self.WorkOrderInfoButton.isSelected = true
                }else{
                    self.WorkOrderInfoButton.isSelected = false
                }
            }else{
                self.WorkOrderInfoButton.isHidden = true
            }

        }
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    @objc func WorkOrderInforButtonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        self.operationVCModel.operationWOInfoDetails()
        mJCLogger.log("Ended", Type: "info")
    }
    
}
