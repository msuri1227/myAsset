//
//  ComponentAdditionalDataCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ComponentAdditionalDataCell: UITableViewCell {

    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    //AdditionalDataBusinessAreaView Outlets..
    @IBOutlet var additionalDataBusinessAreaView: UIView!
    @IBOutlet var additionalDataBusinessAreaLabelView: UIView!
    @IBOutlet var additionalDataBusinessAreaLabel: UILabel!
    
    //AdditionalDataOperationActivityView Outlets..
    @IBOutlet var additionalDataOperationActivityView: UIView!
    @IBOutlet var additionalDataOperationActivityLabelView: UIView!
    @IBOutlet var additionalDataOperationActivityLabel: UILabel!
    
    //AdditionalDataPlantView Outlets..
    @IBOutlet var additionalDataPlantView: UIView!
    @IBOutlet var additionalDataPlantLabelView: UIView!
    @IBOutlet var additionalPlantDataLabel: UILabel!
    
    //AdditionalDataStorageLocationView Outlets..
    @IBOutlet var additionalDataStorageLocationView: UIView!
    @IBOutlet var additionalDataStorageLocationLabelView: UIView!
    @IBOutlet var additionalDataStorageLocationLabel: UILabel!
    
    //AdditionalDataBatchView Outlets..
    @IBOutlet var additionalDataBatchView: UIView!
    @IBOutlet var additionalDataBatchLabelView: UIView!
    @IBOutlet var additionalDataBatchLabel: UILabel!
    
    var componentModel:WoComponentModel?{
        didSet{
            configureComponentAdditionalCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureComponentAdditionalCell(){
        mJCLogger.log("Starting", Type: "info")
        additionalDataBusinessAreaLabel.text = componentModel?.BusinessArea
        additionalDataOperationActivityLabel.text = componentModel?.OperAct
        additionalPlantDataLabel.text = componentModel?.Plant
        additionalDataStorageLocationLabel.text = componentModel?.StorLocation
        additionalDataBatchLabel.text = componentModel?.Batch
//        if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: componentModeClass.entity){
             additionalDataBusinessAreaLabel.text = ""
//        }
        mJCLogger.log("Ended", Type: "info")
    }
}
