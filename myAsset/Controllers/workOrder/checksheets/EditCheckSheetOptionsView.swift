
//
//  EditCheckSheetOptionsView.swift
//  myJobCard
//
//  Created by Suri on 28/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class EditCheckSheetOptionsView: UITableViewCell {
    
    @IBOutlet var formTitleLabel: UILabel!
    @IBOutlet var formVersionLabel: UILabel!
    @IBOutlet var optionalButton: UIButton!
    @IBOutlet var mandatoryButton: UIButton!
    @IBOutlet var singleOccurrenceButton: UIButton!
    @IBOutlet var multipleOccurrenceButton: UIButton!
    @IBOutlet var minusButtton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var occurrenceTxtField: UITextField!
    @IBOutlet var occurrenceFillStackView: UIStackView!
    @IBOutlet var popViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var popViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var popUpView: UIView!
    
    var mangeCSVC: ManageCheckSheetVC?
    
    var manulCheckSheetModel: FormAssignDataModel?{
        didSet{
            editManulCheckSheetConfiguration()
        }
    }
    func popUpViewUI(){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            popViewWidthConstraint.constant = 600
            popViewHeightConstraint.constant = 645
        }else{
            popViewWidthConstraint.constant = 320
            popViewHeightConstraint.constant = 550
        }
        ODSUIHelper.setTextfiledLayout(textfield: self.occurrenceTxtField,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        mJCLogger.log("Ended", Type: "info")
    }
    func editManulCheckSheetConfiguration(){
        self.formTitleLabel.text = manulCheckSheetModel?.FormID
        self.formVersionLabel.text = manulCheckSheetModel?.Version
        let mandatory = manulCheckSheetModel?.Mandatory
        if mandatory == "X"{
            self.mandatoryButton.isSelected = true
            self.optionalButton.isSelected = false
        }else{
            self.mandatoryButton.isSelected = false
            self.optionalButton.isSelected = true
        }
        let occurance = manulCheckSheetModel?.MultipleSub
        if occurance == "X"{
            self.singleOccurrenceButton.isSelected = false
            self.multipleOccurrenceButton.isSelected = true
            self.occurrenceFillStackView.isHidden = false
            self.occurrenceTxtField.text = "\(manulCheckSheetModel?.Occur ?? "0")"
        }else{
            self.singleOccurrenceButton.isSelected = true
            self.multipleOccurrenceButton.isSelected = false
            self.occurrenceFillStackView.isHidden = true
        }
    }
    
    @IBAction func optionalButtonAction(_ sender: Any) {
        self.optionalButton.isSelected = true
        self.mandatoryButton.isSelected = false
    }
    @IBAction func mandatoryButtonAction(_ sender: Any) {
        self.mandatoryButton.isSelected = true
        self.optionalButton.isSelected = false
    }
    @IBAction func singleOccurrenceButtonAction(_ sender: Any) {
        self.singleOccurrenceButton.isSelected = true
        self.multipleOccurrenceButton.isSelected = false
        self.occurrenceFillStackView.isHidden = true
    }
    @IBAction func multipleOccurrenceButtonAction(_ sender: Any) {
        self.singleOccurrenceButton.isSelected = false
        self.multipleOccurrenceButton.isSelected = true
        self.occurrenceFillStackView.isHidden = false
    }
    @IBAction func minusButtonAction(_ sender: Any) {
        let value = Int(self.occurrenceTxtField.text ?? "0") ?? 0
        if value != 0{
            self.occurrenceTxtField.text = "\(value - 1)"
        }else{
            self.occurrenceTxtField.text = "0"
        }
    }
    @IBAction func plusButtonAction(_ sender: Any) {
        let value = Int(self.occurrenceTxtField.text ?? "0") ?? 0
        self.occurrenceTxtField.text = "\(value + 1)"
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        if self.manulCheckSheetModel?.entity != nil{
            let formEntity = self.manulCheckSheetModel!.entity
            var multiOccurance = Bool()
            var multiOccCount = Int()
            if self.multipleOccurrenceButton.isSelected == true{
                multiOccurance = true
                let occurrenceCount = Int(self.occurrenceTxtField.text ?? "")
                if occurrenceCount == nil{
                    print("nil")
                    return
                }else if occurrenceCount ?? -1 < 0{
                    print("nagative")
                    return
                }else if occurrenceCount ?? 0 == 0{
                    print(" occurs 0")
                    return
                }else{
                    multiOccCount = occurrenceCount!
                }
            }else{
                multiOccCount = 1
                multiOccurance = false
            }
            
            if self.mandatoryButton.isSelected == true{
                (formEntity.properties["Mandatory"] as! SODataProperty).value = "X" as NSObject
            }else{
                (formEntity.properties["Mandatory"] as! SODataProperty).value = "" as NSObject
            }
            
            if multiOccurance == true{
                (formEntity.properties["MultipleSub"] as! SODataProperty).value = "X" as NSObject
            }else{
                (formEntity.properties["MultipleSub"] as! SODataProperty).value = "" as NSObject
            }
            
            (formEntity.properties["Occur"] as! SODataProperty).value = "\(multiOccCount)" as NSObject
            
            FormAssignDataModel.updateFormManualAssignmentEntry(entity: formEntity, options: nil){ (response, error) in
                if error == nil{
                    print("updated")
                    DispatchQueue.main.async {
                        self.isHidden = true
                        self.mangeCSVC?.manualCheckSheetVM.getManualCheckSheetData()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.isHidden = true
                        self.mangeCSVC?.manualCheckSheetVM.getManualCheckSheetData()
                    }
                    print("Deletion failed ")
                }
            }
        }
    }
    @IBAction func canceButtonAction(_ sender: Any) {
        self.isHidden = true
    }
}
