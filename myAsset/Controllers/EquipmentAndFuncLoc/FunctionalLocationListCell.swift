//
//  FunctionalLocationListCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 2/24/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class FunctionalLocationListCell: UITableViewCell {    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var decriptionLabel: UILabel!
    @IBOutlet var plantLabel: UILabel!
    @IBOutlet var quantityAvailableLabel: UILabel!
    @IBOutlet var storageLocationLabel: UILabel!
    @IBOutlet weak var techIdLabel: UILabel!
    @IBOutlet weak var techIdLabelWidthConstraint: NSLayoutConstraint!
    

    var personRespListModelClass: PersonResponseModel? {
        didSet{
            personResponsibleListConfiguration()
        }
    }
    var funcLocModelClass: FunctionalLocationModel? {
        didSet{
            functionalLocaltionConfiguration()
        }
    }
    var EquipmentModel: EquipmentModel? {
        didSet{
            EquipmentConfiguration()
        }
    }
    var indexpath = IndexPath()
    var isCellFrom = ""
    var funcEquipViewModel = FuncEquipViewModel()
    
    var funcLocationClass: FunctionalLocationModel?{
        didSet{
            funcLocCellConfiguration()
        }
    }
    var equipmentClass: EquipmentModel?{
        didSet{
            equipCellConfiguration()

        }
    }
    var attendanceTypeModelClass: AttendanceTypeModel? {
        didSet{
            attendanceTypeListConfiguration()
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

    
    func personResponsibleListConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        idLabel.text = personRespListModelClass?.PersonnelNo
        decriptionLabel.text = personRespListModelClass?.EmplApplName
        mJCLogger.log("Ended", Type: "info")
    }
    func functionalLocaltionConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        idLabel.text = funcLocModelClass?.FunctionalLoc
        decriptionLabel.text = funcLocModelClass?.Description
        techIdLabelWidthConstraint.constant = 0
        mJCLogger.log("Ended", Type: "info")
    }
    func EquipmentConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        idLabel.text = EquipmentModel?.Equipment
        decriptionLabel.text = EquipmentModel?.EquipDescription
        techIdLabel.text = EquipmentModel?.TechIdentNo
        mJCLogger.log("Ended", Type: "info")
    }

    func funcLocCellConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "FuncEquipVC" {
            if let funcClass = funcLocationClass {
                self.idLabel.text = funcClass.FunctionalLoc
                self.decriptionLabel.text = funcClass.Description
                self.techIdLabelWidthConstraint.constant = 0
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func equipCellConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "FuncEquipVC" {
            if let EquipClass = equipmentClass {
                self.idLabel.text = EquipClass.Equipment
                self.decriptionLabel.text =   EquipClass.EquipDescription
                self.techIdLabel.text = EquipClass.TechIdentNo
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func attendanceTypeListConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        idLabel.text = attendanceTypeModelClass?.AttAbsType
        decriptionLabel.text = attendanceTypeModelClass?.AATypeText
        mJCLogger.log("Ended", Type: "info")
    }

}
