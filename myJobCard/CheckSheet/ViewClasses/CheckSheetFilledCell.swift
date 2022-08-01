//
//  FormFilledCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/21/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetFilledCell: UITableViewCell {
    
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var formID: UILabel!
    @IBOutlet var formVersionLabel: UILabel!
    @IBOutlet var formInstantIDLabel: UILabel!
    @IBOutlet var filledByLabel: UILabel!
    @IBOutlet var filledOnLabel: UILabel!
    @IBOutlet var iterationsLabel: UILabel!
    @IBOutlet var RemarksLabel: UILabel!
    @IBOutlet var formEditButton: UIButton!
    @IBOutlet var approvalStatusButton: UIButton!
    @IBOutlet var formStatusLabel: UILabel!
    @IBOutlet var statusLabelSV: UIStackView!
    @IBOutlet var iterationLabelSV: UIStackView!

    
    var indexpath = IndexPath()
    var filledCSVC: FilledCheckSheetListVC?
    var woFormFilledModelClass: FormResponseCaptureModel? {
        didSet{
            woFormFilledConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func woFormFilledConfiguration() {
        
        mJCLogger.log("Starting", Type: "info")
        
        formID.text = woFormFilledModelClass?.FormID
        formVersionLabel.text = woFormFilledModelClass?.Version
        
        if woFormFilledModelClass?.CreatedOn != nil{
            filledOnLabel.text = woFormFilledModelClass?.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            filledOnLabel.text = ""
        }
        formInstantIDLabel.text = woFormFilledModelClass?.InstanceID
        filledByLabel.text = woFormFilledModelClass?.CreatedBy
        formEditButton.isHidden = false

        if woFormFilledModelClass?.IsDraft == "X"{
            formEditButton.setImage(UIImage.init(named: "ic_Pencil_color"), for: .normal)
        }else{
            formEditButton.setImage(UIImage.init(named: "showPswd"), for: .normal)
        }

        if filledCSVC?.isFrom == "Supervisor"{
            formEditButton.setImage(UIImage.init(named: "showPswd"), for: .normal)
        }else if filledCSVC?.isFrom == "GeneralCheckList"{
            self.statusLabelSV.isHidden = true
            self.iterationLabelSV.isHidden = true
            self.approvalStatusButton.isHidden = true
        }else{
            if FORM_ASSIGNMENT_TYPE == "1" || FORM_ASSIGNMENT_TYPE == "2" || FORM_ASSIGNMENT_TYPE == "3" || FORM_ASSIGNMENT_TYPE == "4" || FORM_ASSIGNMENT_TYPE == "5"{
                self.statusLabelSV.isHidden = true
                self.iterationLabelSV.isHidden = true
                self.approvalStatusButton.isHidden = true
            }else{
                self.approvalStatusButton.isHidden = false
                approvalStatusButton.tag = indexpath.row
                approvalStatusButton.addTarget(self, action: #selector(formApprovalStatusButtonAction), for: UIControl.Event.touchUpInside)
            }
        }
        if applicationFeatureArrayKeys.contains("FORM_VIEW_FILLED_FORM_OPTION") {
            formEditButton.isHidden = false
        }else{
            formEditButton.isHidden = true
        }
        formEditButton.tag = indexpath.row
        formEditButton.addTarget(self, action: #selector(formEditButtonClicked), for: UIControl.Event.touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Cell Button Action..
    @objc func formEditButtonClicked(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        filledCSVC?.formFilledCellEditButtonAction(tagValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func formApprovalStatusButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
//        let formApprovalStatusVC = ScreenManager.getFormApprovalStatusScreen()
//        formApprovalStatusVC.modalPresentationStyle = .overFullScreen
//        formApprovalStatusVC.selectedformResponse = woFormFilledViewModel.formResponseCaptureArray[btn.tag]
//        woFormFilledViewModel.vcFormFilled?.present(formApprovalStatusVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
}
