//
//  OperationOverViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OperationOverViewCell: UITableViewCell {
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerlabel: UILabel!
    @IBOutlet var mainDetailView: UIView!
    
    //OerViewActivityNumberView Outlets..
    @IBOutlet var overViewActivityNumberView: UIView!
    @IBOutlet var overViewActivityNumberLabelView: UIView!
    @IBOutlet var overViewActivityNumberLabel: UILabel!
    
    //OverViewStatusView Outlets..
    @IBOutlet var overViewStatusView: UIView!
    @IBOutlet var overViewStatusLabelView: UIView!
    @IBOutlet var overViewStatusLabel: UILabel!

    @IBOutlet var overViewSystemStatusView: UIView!
    @IBOutlet var overViewSystemStatusLabelView: UIView!
    @IBOutlet var overViewSystemStatusLabel: UILabel!


    //OverViewShortTextView Outlets..
    @IBOutlet var overViewShortTextView: UIView!
    @IBOutlet var overViewShortTextLabelView: UIView!
    @IBOutlet var overViewShortTextLabel: UILabel!
    
    //OverViewControlKeyView Outlets..
    @IBOutlet var overViewControlKeyView: UIView!
    @IBOutlet var overViewControlKeyLabelView: UIView!
    @IBOutlet var overViewControlKeyLabel: UILabel!
    
    //OverViewActivityTypeView Outlets..
    @IBOutlet var overViewActivityTypeView: UIView!
    @IBOutlet var overViewActivityTypeLabelView: UIView!
    @IBOutlet var overViewActivityTypeLabel: UILabel!
    
    //OverViewSystemCondtionView Outlets..
    @IBOutlet var overViewSystemCondtionView: UIView!
    @IBOutlet var overViewSystemCondtionLabelView: UIView!
    @IBOutlet var overViewSystemCondtionLabel: UILabel!
    
    //OverViewPriorityView Outlets..
    @IBOutlet var overViewPriorityView: UIView!
    @IBOutlet var overViewPriorityLabelView: UIView!
    @IBOutlet var overViewPriorityLabel: UILabel!
    
    //OverViewInspectionTypeView Outlets..
    @IBOutlet var overViewInspectionTypeView: UIView!
    @IBOutlet var overViewInspectionTypeLabelView: UIView!
    @IBOutlet var overViewInspectionTypeLabel: UILabel!
    
    //OverViewFunctionalLocationView Outlets..
    @IBOutlet var overViewFunctionalLocationView: UIView!
    @IBOutlet var overViewFunctionalLocationLabelView: UIView!
    @IBOutlet var overViewFunctionalLocationLabel: UILabel!
    @IBOutlet var overViewFunctionalLocationNaviButton: UIButton!
    @IBOutlet var overViewFunctionalLocationMapButton: UIButton!
    
    
    //OverViewEquipmentView Outlets..
    @IBOutlet var overViewEquipmentView: UIView!
    @IBOutlet var overViewEquipmentLabelView: UIView!
    @IBOutlet var overViewEquipmentLabel: UILabel!
    @IBOutlet var overViewEquipmentNaviButton: UIButton!
    @IBOutlet var overViewEquipmentMapButton: UIButton!
    
    //OverViewPlantView Outlets..
    @IBOutlet var overViewPlantView: UIView!
    @IBOutlet var overViewPlantLabelView: UIView!
    @IBOutlet var overViewPlantLabel: UILabel!
    
    //OverViewWorkCenterView Outlets..
    @IBOutlet var overViewWorkCenterView: UIView!
    @IBOutlet var overViewWorkCenterLabelView: UIView!
    @IBOutlet var overViewWorkCenterLabel: UILabel!
    
    //OverViewSubOperationView Outlets..
    @IBOutlet var overViewSubOperationView: UIView!
    @IBOutlet var overViewTSubOperationLabelView: UIView!
    @IBOutlet var overViewSubOperationLabel: UILabel!
    
    //OverViewActualWorkView Outlets..
    @IBOutlet var overViewActualWorkView: UIView!
    @IBOutlet var overViewActualWorkLabelView: UIView!
    @IBOutlet var overViewActualWorkLabel: UILabel!
    
    //OverViewActualWorkView Outlets..
    @IBOutlet var overViewTransferToView: UIView!
    @IBOutlet var overViewTransferToLabelView: UIView!
    @IBOutlet var overViewTransferToLabel: UILabel!
    
    //OverView Duration Outlets..
    @IBOutlet var overViewDurationView: UIView!
    @IBOutlet var overViewDurationLabelView: UIView!
    @IBOutlet var overViewDurationToLabel: UILabel!
    
    //OverView No.of Technicians Outlets..
    @IBOutlet weak var overViewNoOfTechniciansView: UIView!
    @IBOutlet weak var overViewNoOfTechniciansLabelView: UIView!
    @IBOutlet weak var overViewNoOfTechniciansLabel: UILabel!
    
    //OverView Person Responsible Outlets..
    @IBOutlet weak var overviewPersonResponsibleView: UIView!
    @IBOutlet weak var overviewPersonResponsibleLabelView: UIView!
    @IBOutlet weak var overviewPersonResponsibleLabel: UILabel!
    
    //OverView Total Work Duration Outlets..
    @IBOutlet weak var overviewTotalWorkDurationView: UIView!
    @IBOutlet weak var overviewTotalWorkDurationLabelView: UIView!
    @IBOutlet weak var overviewTotalWorkDurationLabel: UILabel!
    
    
    // MVVM Change
    
    var operationVCModel = OperationOverViewModel()
    
    var operationClass: WoOperationModel?{
        didSet{
            operationConfiguration()
        }
    }
    var indexPath: NSIndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func operationConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let singleOperalClass = operationClass {
            self.overViewActivityNumberLabel.text = singleOperalClass.OperationNum
            self.overViewEquipmentMapButton.addTarget(self, action: #selector(self.equipmentmapButtonAction(sener:)), for: .touchUpInside)
            self.overViewFunctionalLocationMapButton.addTarget(self, action: #selector(self.funlocmapbuttonAction(sener:)), for: .touchUpInside)
            self.overViewFunctionalLocationNaviButton.addTarget(self, action: #selector(self.assetFunctionLocationButtonAction(sender:)), for: .touchUpInside)
            self.overViewEquipmentNaviButton.addTarget(self, action:#selector(self.assetEquipmentButtonAction(sener:)), for: .touchUpInside)
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && currentMasterView == "WorkOrder"{
                if operationVCModel.isfromsup != "Supervisor"{
                    let status = WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: singleOperalClass.UserStatus, mobileStatus: singleOperalClass.MobileStatus, oprClass: singleOperalClass)
                    let statusDesc = WorkOrderDataManegeClass.uniqueInstance.oprMobileStatusDec(status: status)
                    self.overViewStatusLabel.text = statusDesc
                }
                self.overViewSystemStatusLabel.text = "\(singleOperalClass.SystemStatus)"
            }else{
                if singleOperalClass.SystemStatus.contains(find: "CNF") || singleOperalClass.isCompleted {
                    self.overViewSystemStatusLabel.text = "Confirmed".localized()
                }else  if singleOperalClass.SystemStatus.contains(find: "REL") {
                    self.overViewSystemStatusLabel.text = "Released".localized()
                }else{
                    self.overViewSystemStatusLabel.text = ""
                }
                let status = WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: singleOperalClass.UserStatus, mobileStatus: singleOperalClass.MobileStatus, oprClass: singleOperalClass)
                let statusDesc = WorkOrderDataManegeClass.uniqueInstance.oprMobileStatusDec(status: status)
                self.overViewStatusLabel.text = statusDesc
            }
            self.overViewShortTextLabel.text = singleOperalClass.ShortText
            self.overViewControlKeyLabel.text = singleOperalClass.ControlKey
            self.overViewActivityTypeLabel.text = singleOperalClass.ActivityType
            self.overViewSystemCondtionLabel.text = singleOperalClass.SystemCondition
            var priorityText = String()
            let priorityFilteredArray = globalPriorityArray.filter{ $0.Priority == singleOperalClass.WoPriority}
            if priorityFilteredArray.count > 0 {
                let obj = priorityFilteredArray[0]
                priorityText = obj.PriorityText
            }
            self.overViewPriorityLabel.text = priorityText
            self.overViewInspectionTypeLabel.text = singleOperalClass.InspectionType
            self.overViewEquipmentNaviButton.setTitle(singleOperalClass.Equipment, for: .normal)
            self.overViewFunctionalLocationNaviButton.setTitle(singleOperalClass.FuncLoc, for: .normal)
            
            self.overViewPlantLabel.text = singleOperalClass.Plant
            self.overViewWorkCenterLabel.text = singleOperalClass.WorkCenter
            
            if singleOperalClass.SubOperation != ""{
                self.overViewSubOperationLabel.text = singleOperalClass.SubOperation
            }
            
            if singleOperalClass.ActualWork == 0 {
                
                self.overViewActualWorkLabel.text = "0.000"
            }else{
                self.overViewActualWorkLabel.text = "\(singleOperalClass.ActualWork)"
            }
            
            self.overViewDurationToLabel.text = "\(singleOperalClass.NormalDuration)"
            self.overViewNoOfTechniciansLabel.text =  "\(singleOperalClass.NumberPerson)"
            self.overviewTotalWorkDurationLabel.text = "\(singleOperalClass.Work)"
            
            if singleOperalClass.PersonnelNo != "00000000" && singleOperalClass.PersonnelNo != "" {
                let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",singleOperalClass.PersonnelNo)
                let newfilterar = operationVCModel.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
                if newfilterar.count > 0{
                    mJCLogger.log("Response:\(newfilterar[0])", Type: "Debug")
                    let details = newfilterar[0]
                    self.overViewTransferToView.isHidden = false
                    self.overviewPersonResponsibleLabel.text = details.SystemID
                    
                }
            }
            if singleOperalClass.TransferPerson != "00000000" && (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"){
                let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",singleOperalClass.TransferPerson)
                let newfilterar = operationVCModel.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
                if newfilterar.count > 0{
                    mJCLogger.log("Response:\(newfilterar[0])", Type: "Debug")
                    let details = newfilterar[0]
                    self.overViewTransferToView.isHidden = false
                    self.overViewTransferToLabel.text = details.SystemID
                    operationVCModel.isTranformHidden = false
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    self.overViewTransferToView.isHidden = true
                    operationVCModel.isTranformHidden = true
                }
            }else if singleOperalClass.ToWorkCenter != ""{
                self.overViewTransferToView.isHidden = false
                operationVCModel.isTranformHidden = false
                self.overViewTransferToLabel.text = singleOperalClass.ToWorkCenter
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.overViewTransferToView.isHidden = true
                operationVCModel.isTranformHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func equipmentmapButtonAction(sener: UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        if self.operationClass?.Equipment == "" {
            mJCAlertHelper.showAlert(operationVCModel.operationsVC, title: alerttitle, message: "Equipment_Not_Found".localized(), button: okay)
            return
        }else{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_ESRI_MAP", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    operationVCModel.equipmentAction(equipmentNum: self.operationClass!.Equipment)
                }else{
                    mJCAlertHelper.showAlert(operationVCModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
                }
            }else{
                mJCAlertHelper.showAlert(operationVCModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func funlocmapbuttonAction(sener: UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        if operationClass?.FuncLoc == "" {
            mJCAlertHelper.showAlert(operationVCModel.operationsVC, title: alerttitle, message: "Functional_Location_Not_Found".localized(), button: okay)
            return
        }else{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_ESRI_MAP", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    operationVCModel.funcLocMapAction(funcLocation:operationClass!.FuncLoc)
                }else{
                    mJCAlertHelper.showAlert(operationVCModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
                }
            }else{
                mJCAlertHelper.showAlert(operationVCModel.operationsVC, title: alerttitle, message: "This_Option_is_not_Enabled".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func assetFunctionLocationButtonAction(sender: UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        var titleStr = ""
        if let title = sender.titleLabel?.text {
            titleStr = title
        }
        operationVCModel.assetFunctionLocationAction(title:titleStr)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func assetEquipmentButtonAction(sener: UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        var titleStr = ""
        if let title = sener.titleLabel?.text {
            titleStr = title
        }
        operationVCModel.assetEquipmentAction(title:titleStr)
        mJCLogger.log("Ended", Type: "info")
    }
}
