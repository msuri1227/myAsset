//
//  ComponentOverViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/11/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ComponentOverViewCell: UITableViewCell {
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    //OverViewReservationNumberView Outlets..
    @IBOutlet var overViewReservationNumberView: UIView!
    @IBOutlet var overViewReservationNumberLabelView: UIView!
    @IBOutlet var overViewReservationNumberLabel: UILabel!
    
    //OverViewRequiredItemView Outlets..
    @IBOutlet var overViewRequiredItemView: UIView!
    @IBOutlet var overViewRequiredItemLabelView: UIView!
    @IBOutlet var overViewRequiredItemLabel: UILabel!
    
    //OverViewMaterialNumberView Outlets..
    @IBOutlet var overViewMaterialNumberView: UIView!
    @IBOutlet var overViewMaterialNumberLabelView: UIView!
    @IBOutlet var overViewMaterialNumberLabel: UILabel!
    
    //OverViewFinalIssueView Outlets..
    @IBOutlet var overViewFinalIssueView: UIView!
    @IBOutlet var overViewFinalIssueLabelView: UIView!
    @IBOutlet var overViewFinalIssueLabel: UILabel!
    
    //OverViewMaterialTextView Outlets..
    @IBOutlet var overViewMaterialTextView: UIView!
    @IBOutlet var overViewMaterialTextLabelView: UIView!
    @IBOutlet var overViewMaterialTextLabel: UILabel!
    
    //OverViewMaterialGroupView Outlets..
    @IBOutlet var overViewMaterialGroupView: UIView!
    @IBOutlet var overViewMaterialGroupLabelView: UIView!
    @IBOutlet var overViewMaterialGroupLabel: UILabel!
    
    //OverViewObjectTypeView Outlets..
    @IBOutlet var overViewObjectTypeView: UIView!
    @IBOutlet var overViewObjectTypeLabelView: UIView!
    @IBOutlet var overViewObjectTypeLabel: UILabel!
    
    //OverViewUnitOfMeasureView Outlets..
    @IBOutlet var overViewUnitOfMeasureView: UIView!
    @IBOutlet var overViewUnitOfMeasureLabelView: UIView!
    @IBOutlet var overViewUnitOfMeasureLabel: UILabel!
    
    //OverViewQuantityWithdrawnView Outlets..
    @IBOutlet var overViewQuantityWithdrawnView: UIView!
    @IBOutlet var overViewQuantityWithdrawnLabelView: UIView!
    @IBOutlet var overViewQuantityWithdrawnLabel: UILabel!
    
    //OverViewRequirementQuantityView Outlets..
    @IBOutlet var overViewRequirementQuantityView: UIView!
    @IBOutlet var overViewRequirementQuantityLabelView: UIView!
    @IBOutlet var overViewRequirementQuantityLabel: UILabel!
    
    //OverViewItemTextView Outlets..
    @IBOutlet var overViewItemTextView: UIView!
    @IBOutlet var overViewItemTextLabelView: UIView!
    @IBOutlet var overViewItemTextLabel: UILabel!
    
    //OverViewConfirmedQtySKUView Outlets..
    @IBOutlet var overViewConfirmedQtySKUView: UIView!
    @IBOutlet var overViewConfirmedQtySKULabelView: UIView!
    @IBOutlet var overViewConfirmedQtySKULabel: UILabel!
    
    var isFromHistoryScreen = false
    var isfrom = String()
    
    var componentModel:WoComponentModel?{
        didSet{
            configureComponentOverviewCell()
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
    
    
    func  configureComponentOverviewCell(){
        mJCLogger.log("Starting", Type: "info")
        if let compModel = componentModel {
            
            overViewReservationNumberLabel.text = compModel.Reservation
            overViewRequiredItemLabel.text = compModel.Item
            overViewMaterialNumberLabel.text = compModel.Material
            
            if compModel.FinalIssue == true {
                overViewFinalIssueLabel.text = "TRUE".localized()
            }else{
                overViewFinalIssueLabel.text = "false".localized()
            }
            
            if isFromHistoryScreen {
                overViewMaterialTextLabel.text = compModel.Description
            }else {
                overViewMaterialTextLabel.text = compModel.MaterialDescription
            }
            overViewMaterialGroupLabel.text = compModel.MaterialGroup
            overViewObjectTypeLabel.text = compModel.MovementType
            overViewUnitOfMeasureLabel.text = compModel.BaseUnit
            overViewQuantityWithdrawnLabel.text = "\(String(describing: compModel.WithdrawalQty))"
            overViewRequirementQuantityLabel.text = "\(String(describing: compModel.ReqmtQty))"
            overViewItemTextLabel.text = componentModel!.ItemText
            overViewConfirmedQtySKULabel.text = "\(String(describing: compModel.QuantityinUnE))"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}
