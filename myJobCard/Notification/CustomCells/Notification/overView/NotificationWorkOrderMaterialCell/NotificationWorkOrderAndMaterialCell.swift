//
//  NotificationWorkOrderAndMaterialCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationWorkOrderAndMaterialCell: UITableViewCell {

    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    // Outlets..
    @IBOutlet var workOrderAndMaterialWorkOrderView: UIView!
    @IBOutlet var workOrderAndMaterialWorkOrderLabelView: UIView!
    @IBOutlet var workOrderAndMaterialWorkOrderLabel: UILabel!
    
    //BatchView Outlets..
    @IBOutlet var workOrderAndMaterialBatchView: UIView!
    @IBOutlet var workOrderAndMaterialBatchLabelView: UIView!
    @IBOutlet var workOrderAndMaterialBatchLabel: UILabel!
    
    //WorkCenterView Outlets..
    @IBOutlet var workOrderAndMaterialWorkCenterView: UIView!
    @IBOutlet var workOrderAndMaterialWorkCenterLabelView: UIView!
    @IBOutlet var workOrderAndMaterialWorkCenterLabel: UILabel!
    
    //PlantWorkCenterView Outlets..
    @IBOutlet var workOrderAndMaterialPlantWorkCenterView: UIView!
    @IBOutlet var workOrderAndMaterialPlantWorkCenterLabelView: UIView!
    @IBOutlet var workOrderAndMaterialPlantWorkCenterLabel: UILabel!
    
    //PlanningplantView Outlets..
    @IBOutlet var workOrderAndMaterialPlanningplantView: UIView!
    @IBOutlet var workOrderAndMaterialPlanningplantLabelView: UIView!
    @IBOutlet var workOrderAndMaterialPlanningplantLabel: UILabel!
    
    //MaintenancePlantView Outlets..
    @IBOutlet var workOrderAndMaterialMaintenancePlantView: UIView!
    @IBOutlet var workOrderAndMaterialMaintenancePlantLabelView: UIView!
    @IBOutlet var workOrderAndMaterialMaintenancePlantLabel: UILabel!
    
    //BusinessAreaView Outlets..
    @IBOutlet var workOrderAndMaterialBusinessAreaView: UIView!
    @IBOutlet var workOrderAndMaterialBusinessAreaLabelView: UIView!
    @IBOutlet var workOrderAndMaterialBusinessAreaLabel: UILabel!
    
    //COAreaView Outlets..
    @IBOutlet var workOrderAndMaterialCOAreaView: UIView!
    @IBOutlet var workOrderAndMaterialCOAreaLabelView: UIView!
    @IBOutlet var workOrderAndMaterialCOAreaLabel: UILabel!
    
    //LocationAssignmentView Outlets..
    @IBOutlet var workOrderAndMaterialLocationAssignmentView: UIView!
    @IBOutlet var workOrderAndMaterialLocationAssignmentLabelView: UIView!
    @IBOutlet var workOrderAndMaterialLocationAssignmentLabel: UILabel!
    
    //CostCenterView Outlets..
    @IBOutlet var workOrderAndMaterialCostCenterView: UIView!
    @IBOutlet var workOrderAndMaterialCostCenterLabelView: UIView!
    @IBOutlet var workOrderAndMaterialCostCenterLabel: UILabel!
    
    var notifWOMaterialModelClass : NotificationModel? {
        didSet{
            notificationWOMaterialConfiguration()
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
    func notificationWOMaterialConfiguration() {
        mJCLogger.log("Starting", Type: "info")
         workOrderAndMaterialWorkOrderLabel.text = notifWOMaterialModelClass?.WorkOrderNum
         workOrderAndMaterialBatchLabel.text = notifWOMaterialModelClass?.Batch

        if notifWOMaterialModelClass?.WorkCenter ?? "" != ""{
            let workCtrArr = globalWorkCtrArray.filter{$0.ObjectID == "\(notifWOMaterialModelClass?.WorkCenter ?? "")"}
            if workCtrArr.count > 0{
                let workCtrCls = workCtrArr[0]
                workOrderAndMaterialWorkCenterLabel.text = "\(workCtrCls.WorkCenter)"
            }else{
                workOrderAndMaterialWorkCenterLabel.text = notifWOMaterialModelClass?.WorkCenter
            }
        }else{
            workOrderAndMaterialWorkCenterLabel.text = notifWOMaterialModelClass?.WorkCenter
        }
        workOrderAndMaterialPlantWorkCenterLabel.text = notifWOMaterialModelClass?.PltforWorkCtr
         workOrderAndMaterialPlanningplantLabel.text = notifWOMaterialModelClass?.PlanningPlant
         workOrderAndMaterialMaintenancePlantLabel.text = notifWOMaterialModelClass?.MaintPlant
         workOrderAndMaterialBusinessAreaLabel.text = notifWOMaterialModelClass?.BusinessArea
         workOrderAndMaterialCOAreaLabel.text = notifWOMaterialModelClass?.ControllingArea
         workOrderAndMaterialLocationAssignmentLabel.text = notifWOMaterialModelClass?.LocAccAssmt
         workOrderAndMaterialCostCenterLabel.text = notifWOMaterialModelClass?.CostCenter
        mJCLogger.log("Starting", Type: "info")
    }
    
}
