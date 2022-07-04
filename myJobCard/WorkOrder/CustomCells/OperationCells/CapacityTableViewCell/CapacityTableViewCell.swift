//
//  CapacityTableViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CapacityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var personResponsibleNameLbl: UILabel!
    @IBOutlet weak var workDurationTextField: UITextField!
    @IBOutlet weak var normalDurationTextField: UITextField!
    @IBOutlet var normalDurationUOM: UILabel!
    @IBOutlet var workDurationUOM: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startTimeButton: UIButton!
  
    
    var indexPath: IndexPath!
    var capacityModel = CapacityMembersDataViewModel()
    var capacityClass: WoCapacityModel?{
        didSet{
            capacityMemberDataVConfirugation()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.editButton.layer.cornerRadius = self.editButton.frame.size.width/2
        self.deleteButton.layer.cornerRadius = self.deleteButton.frame.size.width/2
    }
    
    func capacityMemberDataVConfirugation() {
        
        let editImg = UIImage(named: "ic_Pencil_color")
        let saveImg = UIImage(named: "ic_ok")
        
        let personRespArr = globalPersonRespArray.filter{$0.PersonnelNo == capacityClass?.PersNo}
        if personRespArr.count > 0 {
            personResponsibleNameLbl.text = personRespArr[0].EmplApplName
        }
        normalDurationTextField.text = "\(capacityClass!.NormalDuration)"
        workDurationTextField.text = "\(capacityClass!.Work)"
        if capacityClass?.StartDate != nil{
            startDateTextField.text = capacityClass?.StartDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            startDateTextField.text = ""
        }
        if capacityClass?.StartTime != nil{
            startTimeTextField.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: capacityClass!.StartTime)
        }else{
            startTimeTextField.text = ""
        }
 
        if editImg?.pngData() == editButton.imageView?.image?.pngData() {
            ODSUIHelper.setBorderToView(view: normalDurationTextField, borderColor: .clear)
            ODSUIHelper.setBorderToView(view: workDurationTextField, borderColor: .clear)
            normalDurationTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
            workDurationTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
           
            
        }else if saveImg?.pngData() == editButton.imageView?.image?.pngData() {
            ODSUIHelper.setBorderToView(view: normalDurationTextField, borderColor: .clear)
            ODSUIHelper.setBorderToView(view: workDurationTextField, borderColor: .clear)
            normalDurationTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
            workDurationTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
         
        }
        self.normalDurationTextField.isUserInteractionEnabled = false
        
        
        editButton.tag = indexPath.row
        deleteButton.tag = indexPath.row
        startDateButton.tag = indexPath.row
        startTimeButton.tag = indexPath.row
        editButton.addTarget(self, action: #selector(capacityMemberEditButtonAction(sender:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(capacityMemberDeleteButtonAction(sender:)), for: .touchUpInside)
        startDateButton.addTarget(self, action: #selector(startDateButtonAction(sender:)), for: .touchUpInside)
        startTimeButton.addTarget(self, action: #selector(startTimeButtonAction(sender:)), for: .touchUpInside)
        
        if !applicationFeatureArrayKeys.contains("EDIT_CAPACITY_DATA"){
            self.editButton.isHidden = true
        }else{
            self.editButton.isHidden = false
        }
        
        if !applicationFeatureArrayKeys.contains("DELETE_CAPACITY_DATA"){
            self.deleteButton.isHidden = true
        }else{
            self.deleteButton.isHidden = false
        }
    }
    
    @objc func capacityMemberEditButtonAction(sender : UIButton) {
        self.normalDurationTextField.isUserInteractionEnabled = false
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let editImg = UIImage(named: "ic_Pencil_color")
        let saveImg = UIImage(named: "ic_ok")
        let cell = capacityModel.capacityVC?.capacityMemberDataTableview.cellForRow(at: indexPath) as! CapacityTableViewCell
        if editImg?.pngData() == cell.editButton.imageView?.image?.pngData() {
            workDurationTextField.backgroundColor = .clear
            startDateTextField.backgroundColor = .clear
            startTimeTextField.backgroundColor = .clear
            
            ODSUIHelper.setTextfiledLayout(textfield: self.workDurationTextField,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setTextfiledLayout(textfield: self.startTimeTextField,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setTextfiledLayout(textfield: self.startDateTextField,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            cell.editButton.setImage(saveImg, for: .normal)
        }else if saveImg?.pngData() == cell.editButton.imageView?.image?.pngData() {
           
            ODSUIHelper.setBorderToView(view: self.normalDurationTextField, borderColor: .clear)
            ODSUIHelper.setBorderToView(view: self.startTimeTextField, borderColor: .clear)
            ODSUIHelper.setBorderToView(view: self.startDateTextField, borderColor: .clear)
            ODSUIHelper.setBorderToView(view: self.workDurationTextField, borderColor: .clear)
            
            normalDurationTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
            workDurationTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
            startDateTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
            startTimeTextField.backgroundColor = UIColor(named: "mjcSubViewColor")
            self.capacityModel.updateCapacityMemberData(tagValue: tag)
            editButton.setImage(editImg, for: .normal)
        }
                
    }
    
    @objc func capacityMemberDeleteButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
//        if deletionValue == true {
            
            let params = Parameters(
                title: alerttitle,
                message: "Are_you_sure_you_want_to_delete".localized(),
                cancelButton: "Cancel".localized(),
                otherButtons: [okay]
            )
            mJCAlertHelper.showAlertWithHandler(capacityModel.capacityVC!, parameters: params) { buttonIndex in
                switch buttonIndex {
                case 0: break
                case 1:
                    self.capacityModel.deleteCapacityMember(tag: sender.tag)
                default: break
                }
            }
//        }else {
//            capacityModel.deleteCapacityMember(tag: sender.tag)
//        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func startDateButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        capacityModel.capacityVC?.cellStartDateButtonAction(sender: sender)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func startTimeButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        capacityModel.capacityVC?.cellStartTimeButtonAction(sender: sender)
        mJCLogger.log("Ended", Type: "info")
    }
    
}
