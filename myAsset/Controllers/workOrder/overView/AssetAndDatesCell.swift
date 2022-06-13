//
//  AssetAndDatesCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/29/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class AssetAndDatesCell: UITableViewCell {
    
    //BackGroundView Outlets..
    @IBOutlet var assetHeaderView: UIView!
    @IBOutlet var assetHeaderHeaderLabel: UILabel!
    
    //BackGroundView Outlets..
    @IBOutlet var backGroundView: UIView!
    
    //AssetEquipmentView Outlets..
    @IBOutlet var assetEquipmentView: UIView!
    @IBOutlet var assetEquipmentLabelView: UIView!
    @IBOutlet var assetEquipmentLabel: UILabel!
    @IBOutlet var assetEquipmentButton: UIButton!
    
    //AssetDescriptionView Outlets..
    @IBOutlet var assetDescriptionView: UIView!
    @IBOutlet var assetDescriptionLabelView: UIView!
    @IBOutlet var assetDescriptionLabel: UILabel!
    
    //AssetLocationView Outlets..
    @IBOutlet var assetLocationView: UIView!
    @IBOutlet var assetLocationLabelView: UIView!
    @IBOutlet var assetLocationLabel: UILabel!
    
    //AssetsystemConditionView Outlets..
    @IBOutlet var assetsystemConditionView: UIView!
    @IBOutlet var assetsystemConditionLabelView: UIView!
    @IBOutlet var assetsystemConditionLabel: UILabel!
    
    //AssetFunctionLocationView Outlets..
    @IBOutlet var assetFunctionLocationView: UIView!
    @IBOutlet var assetFunctionLocationLabelView: UIView!
    @IBOutlet var assetFunctionLocationLabel: UILabel!
    @IBOutlet var assetFunctionLocationButton: UIButton!
    
    @IBOutlet var FunLocationmapButton: UIButton!
    //AssetBasicStartView Outlets..
    @IBOutlet var assetBasicStartView: UIView!
    @IBOutlet var assetBasicStartLabelView: UIView!
    @IBOutlet var assetBasicStartLabel: UILabel!
    
    //AssetDueDateView Outlets..
    @IBOutlet var assetDueDateView: UIView!
    @IBOutlet var assetDueDateLabelView: UIView!
    @IBOutlet var assetDueDateLabel: UILabel!
    
    @IBOutlet var equipmentmapButton: UIButton!
    //AssetScheduleStartView Outlets..
    @IBOutlet var assetScheduleStartView: UIView!
    @IBOutlet var assetScheduleStartLabelView: UIView!
    @IBOutlet var assetScheduleStartLabel: UILabel!
    
    //AssetScheduleFinishView Outlets..
    @IBOutlet var assetScheduleFinishView: UIView!
    @IBOutlet var assetScheduleFinishLabelView: UIView!
    @IBOutlet var assetScheduleFinishLabel: UILabel!
    
    //AssetActualStartView Outlets..
    @IBOutlet var assetActualStartView: UIView!
    @IBOutlet var assetActualStartLabelView: UIView!
    @IBOutlet var assetActualStartLabel: UILabel!
    
    var indexpath = IndexPath()
    var woAssetDateModel = WorkOrderOverviewViewModel()
    var operaionViewModel = OperationOverViewModel()
    var isCellFrom = ""
    var woOverViewAssetDatesModel: WoHeaderModel? {
        didSet{
            woAssetsDatesConfiguration()
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
    
    func woAssetsDatesConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        assetEquipmentButton.setTitle("", for: .normal)
        assetEquipmentLabel.text = woOverViewAssetDatesModel?.EquipNum
        assetDescriptionLabel.text = woOverViewAssetDatesModel?.TechObjDescription
        assetLocationLabel.text = woOverViewAssetDatesModel?.TechObjLocAndAssgnmnt
        assetsystemConditionLabel.text = woOverViewAssetDatesModel!.SysCondition + " - " + woOverViewAssetDatesModel!.SysContitionText
        assetFunctionLocationLabel.text = woOverViewAssetDatesModel?.FuncLocation
        assetFunctionLocationButton.setTitle("", for: .normal)
        
        if woOverViewAssetDatesModel?.BasicStrtDate != nil{
            assetBasicStartLabel.text = woOverViewAssetDatesModel?.BasicStrtDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            assetBasicStartLabel.text = ""
        }
        if woOverViewAssetDatesModel?.BasicFnshDate != nil{
            assetDueDateLabel.text = woOverViewAssetDatesModel?.BasicFnshDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            assetDueDateLabel.text = ""
        }
        if woOverViewAssetDatesModel?.SchdStrtDate != nil{
            assetScheduleStartLabel.text = woOverViewAssetDatesModel?.SchdStrtDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            assetScheduleStartLabel.text = ""
        }
        if woOverViewAssetDatesModel?.SchdFnshDate != nil{
            assetScheduleFinishLabel.text = woOverViewAssetDatesModel?.SchdFnshDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            assetScheduleFinishLabel.text = ""
        }
        if woOverViewAssetDatesModel?.ActlStrtDate != nil{
            assetScheduleFinishLabel.text = woOverViewAssetDatesModel?.ActlStrtDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            assetActualStartLabel.text = ""
        }
        
        assetEquipmentButton.tag = indexpath.row
        assetFunctionLocationButton.tag = indexpath.row
        assetEquipmentButton.addTarget(self, action:#selector(assetEquipmentButtonAction(sender:)), for: .touchUpInside)
        equipmentmapButton.addTarget(self, action: #selector(equipmentMapButtonAction(sener:)), for: .touchUpInside)
        assetFunctionLocationButton.addTarget(self, action:#selector(assetFunctionLocationButtonAction(sender:)), for: .touchUpInside)
        FunLocationmapButton.addTarget(self, action: #selector(funLocMapButtonAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Equipment Map Button Action..
    @objc func equipmentMapButtonAction(sener: UIButton){
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "OperationDetails" {
            if woOverViewAssetDatesModel?.EquipNum == "" {
                mJCAlertHelper.showAlert(operaionViewModel.operationsVC, title: alerttitle, message: "Equipment_Not_Found".localized(), button: okay)
                return
            }else{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_ESRI_MAP", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        operaionViewModel.equipmentAction(equipmentNum: woOverViewAssetDatesModel!.EquipNum)
                    }else{
                        mJCAlertHelper.showAlert(operaionViewModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
                    }
                }else{
                    mJCAlertHelper.showAlert(operaionViewModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
                }
            }
        }else {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_ESRI_MAP", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    woAssetDateModel.vcOverview?.updateUIEquipmentMapButton()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // MARK:- Functional Location Map Button Action..
    @objc func funLocMapButtonAction(sender : UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        
        if isCellFrom == "OperationDetails" {
            if woOverViewAssetDatesModel?.FuncLocation == "" {
                mJCAlertHelper.showAlert(operaionViewModel.operationsVC, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
                return
            }else{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_FL_ESRI_MAP", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        operaionViewModel.funcLocMapAction(funcLocation: woOverViewAssetDatesModel!.FuncLocation)
                    }else{
                        mJCAlertHelper.showAlert(operaionViewModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
                    }
                }else{
                    mJCAlertHelper.showAlert(operaionViewModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
                }
            }
        }else {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_FL_ESRI_MAP", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    woAssetDateModel.vcOverview?.updateUIFunlocMapButton()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // MARK:- Equipment Button Action..
    @objc func assetEquipmentButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "OperationDetails" {
            var titleStr = ""
            if let title = self.assetEquipmentLabel.text {
                titleStr = title
            }
            operaionViewModel.assetEquipmentAction(title:titleStr)
        }else {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_EQPMNT", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    if self.assetEquipmentLabel.text != "" && self.assetEquipmentLabel.text != nil {
                        woAssetDateModel.overviewAssetEquipmentServiceCall(equipmentNo: (self.assetEquipmentLabel.text)!)
                    }else{
                        mJCLogger.log("Equipment_Not_Found".localized(), Type: "Error")
                        mJCAlertHelper.showAlert(woAssetDateModel.vcOverview!, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- OverView Cell Button Action..
    @objc func assetFunctionLocationButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "OperationDetails" {
            var titleStr = ""
            if let title = self.assetFunctionLocationLabel.text {
                titleStr = title
            }
            operaionViewModel.assetFunctionLocationAction(title:titleStr)
        }else {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_FUNCTLOC", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("assetFunctionLocationButtonAction".localized(), Type: "")
                    if self.assetFunctionLocationLabel.text != "" && self.assetFunctionLocationLabel.text != nil {
                        woAssetDateModel.overviewAssetFunctionLocationServiceCall(title: (self.assetFunctionLocationLabel.text)!)
                    }else{
                        mJCLogger.log("Functional_Location_Not_Found".localized(), Type: "Error")
                        mJCAlertHelper.showAlert(woAssetDateModel.vcOverview!, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // END...
    
}
