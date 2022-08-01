//
//  InstalleddetailTableViewCell.swift
//  testgrid
//
//  Created by Rover Software on 11/10/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class InstalledEqupFLdetailsTableViewCell: UITableViewCell {

    @IBOutlet var EquporFlTitleLabel: UILabel!
    @IBOutlet var MaterialTitleLabel: UILabel!
    @IBOutlet var MaterialValueLabel: UILabel!
    @IBOutlet var SerialLabel: UILabel!
    @IBOutlet var SerialValueLabel: UILabel!
    @IBOutlet var StatusLabel: UILabel!
    @IBOutlet var StatusValueLabel: UILabel!
    @IBOutlet var PlantLabel: UILabel!
    @IBOutlet var PlantValueLabel: UILabel!
    @IBOutlet var WorkCenterLabel: UILabel!
    @IBOutlet var WorkCenterValueLabel: UILabel!
    @IBOutlet var DismantleButton: UIButton!

    var installedEquipmentModel: EquipmentModel? {
        didSet{
            installEquipmentInfoConfiguration()
        }
    }
    var installEqupFLDetailModelClass: EquipmentModel? {
        didSet{
            installEqupFLDetailConfiguration()
        }
    }
    var installedEquipmentViewModel = InstalledEquipmentViewModel()
    var property = NSMutableArray()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func installEquipmentInfoConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        EquporFlTitleLabel.text = "\(installedEquipmentModel?.Equipment ?? "") - \(installedEquipmentModel?.EquipDescription ?? "")"
         MaterialValueLabel.text = ""
         SerialValueLabel.text = "\(installedEquipmentModel?.ManufSerialNo ?? "")"
         StatusValueLabel.text = "\(installedEquipmentModel?.SystemStatus ?? "")"
         PlantValueLabel.text = "\(installedEquipmentModel?.MaintPlant ?? "")"
         WorkCenterValueLabel.text = installedEquipmentModel?.WorkCenter
         DismantleButton.addTarget(self, action: #selector(dismantleButtonAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func dismantleButtonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
            if let equipmodel = installEqupFLDetailModelClass{
                self.installedEquipmentViewModel.dismantalEquipment(selectedEquip: equipmodel,from: "floc") //floc
            }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func installEqupFLDetailConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        EquporFlTitleLabel.text = installEqupFLDetailModelClass?.Equipment ?? "" + " - " + installEqupFLDetailModelClass!.EquipDescription
        MaterialValueLabel.text = ""
        SerialValueLabel.text = installEqupFLDetailModelClass?.ManufSerialNo
        StatusValueLabel.text = installEqupFLDetailModelClass?.SystemStatus
        PlantValueLabel.text = installEqupFLDetailModelClass?.MaintPlant
        WorkCenterValueLabel.text = installEqupFLDetailModelClass?.WorkCenter
        DismantleButton.addTarget(self, action: #selector(funclocationOverviewDismantleButtonAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func funclocationOverviewDismantleButtonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        if let equipmodel = installEqupFLDetailModelClass{
            self.installedEquipmentViewModel.dismantalEquipment(selectedEquip: equipmodel, from: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
