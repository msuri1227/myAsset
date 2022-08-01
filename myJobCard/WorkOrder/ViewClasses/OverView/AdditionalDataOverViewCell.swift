//
//  AdditionalDataOverViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/7/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class AdditionalDataOverViewCell: UITableViewCell {
    
    //AdditionalDataView Outlets..
    @IBOutlet var additionalDataView: UIView!
    @IBOutlet var additionalDataHeaderLabel: UILabel!
    
    //AdditionalDataCreatedOnView Outlets..
    @IBOutlet var additionalDataCreatedOnView: UIView!
    @IBOutlet var additionalDataCreatedOnTextLabelView: UIView!
    @IBOutlet var additionalDataCreatedOnTextLabel: UILabel!
    
    //AdditionalDataPersonResponsibleView Outlets..
    @IBOutlet var additionalDataPersonResponsibleView: UIView!
    @IBOutlet var additionalDataPersonResponsibleLabelView: UIView!
    @IBOutlet var additionalDataPersonResponsibleLabel: UILabel!
    
    //AdditionalDataBusinessAreaView Outlets..
    @IBOutlet var additionalDataBusinessAreaView: UIView!
    @IBOutlet var additionalDataBusinessAreaLabelView: UIView!
    @IBOutlet var additionalDataBusinessAreaLabel: UILabel!
    
    //AdditionalDataControllingAreaView Outlets..
    @IBOutlet var additionalDataControllingAreaView: UIView!
    @IBOutlet var additionalDataControllingAreaLabelView: UIView!
    @IBOutlet var additionalDataControllingAreaLabel: UILabel!
    
    //AdditionalDataWorkPermitView Outlets..
    @IBOutlet var additionalDataWorkPermitView: UIView!
    @IBOutlet var additionalDataWorkPermitLabelView: UIView!
    @IBOutlet var additionalDataWorkPermitLabel: UILabel!
    
    //AdditionalDataWBSView Outlets..
    @IBOutlet var additionalDataWBSView: UIView!
    @IBOutlet var additionalDataWBSLabelView: UIView!
    @IBOutlet var additionalDataWBSLabel: UILabel!
    
    //AdditionalDataMainWorkCenterView Outlets..
    @IBOutlet var additionalDataMainWorkCenterView: UIView!
    @IBOutlet var additionalDataMainWorkCenterLabelView: UIView!
    @IBOutlet var additionalDataMainWorkCenterLabel: UILabel!
    
    //AdditionalDataAssociatedPlantView Outlets..
    @IBOutlet var additionalDataAssociatedPlantView: UIView!
    @IBOutlet var additionalDataAssociatedPlantLabelView: UIView!
    @IBOutlet var additionalDataAssociatedPlantLabel: UILabel!
  
    //AdditionalDataRespPlannerGroupView Outlets..
    @IBOutlet var additionalDataRespPlannerGroupView: UIView!
    @IBOutlet var additionalDataRespPlannerGroupLabelView: UIView!
    @IBOutlet var additionalDataRespPlannerGroupLabel: UILabel!
    
    //AdditionalMaintenansePlantDataView Outlets..
    @IBOutlet var additionalMaintenansePlantDataView: UIView!
    @IBOutlet var additionalDataMaintenansePlantUILabelView: UIView!
    @IBOutlet var additionalDataMaintenansePlantUILabel: UILabel!
    
    var personRespArray = [PersonResponseModel]()
    var woAdditionalDataModel: WoHeaderModel? {
        didSet{
            woAdditionalDataOverviewConfiguration()
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
    
    func woAdditionalDataOverviewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let woAdditionalDataModel = woAdditionalDataModel {
            
            if woAdditionalDataModel.CreatedOn != nil{
                additionalDataCreatedOnTextLabel.text = (woAdditionalDataModel.CreatedOn ?? Date().localDate()).toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                additionalDataCreatedOnTextLabel.text = ""
            }
            
            additionalDataBusinessAreaLabel.text = woAdditionalDataModel.BusArea + " - " + woAdditionalDataModel.BusAreaText
            additionalDataControllingAreaLabel.text = woAdditionalDataModel.ControllingArea
            additionalDataWorkPermitLabel.text = woAdditionalDataModel.WorkPermitIssued
            additionalDataWBSLabel.text = woAdditionalDataModel.WBSElem
            additionalDataMainWorkCenterLabel.text = woAdditionalDataModel.MainWorkCtr
            additionalDataAssociatedPlantLabel.text = woAdditionalDataModel.Plant
            additionalDataRespPlannerGroupLabel.text = woAdditionalDataModel.ResponsiblPlannerGrp
            additionalDataMaintenansePlantUILabel.text = woAdditionalDataModel.MaintPlant
           
           if woAdditionalDataModel.PersonResponsible != ""{
                   
               let newFilterArr = personRespArray.filter{$0.PersonnelNo == woAdditionalDataModel.PersonResponsible}
               if newFilterArr.count > 0 {
                   additionalDataPersonResponsibleLabel.text = newFilterArr[0].SystemID
               }else{
                    additionalDataPersonResponsibleLabel.text = ""
               }
           }else{
                mJCLogger.log("Data not found", Type: "Debug")
                additionalDataPersonResponsibleLabel.text = ""
           }

        }
        mJCLogger.log("Ended", Type: "info")
    }
}
