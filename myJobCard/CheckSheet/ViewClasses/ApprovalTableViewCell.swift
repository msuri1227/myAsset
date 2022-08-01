//
//  ApprovalTableViewCell.swift
//  myJobCard
//
//  Created by Ruby's Mac on 07/06/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class ApprovalTableViewCell: UITableViewCell {
    
    @IBOutlet var approverID: UILabel!
    @IBOutlet var formStatus: UILabel!
    @IBOutlet var remarkLabel: UILabel!
    @IBOutlet var reviewDateLabel: UILabel!
    @IBOutlet var auditLogButton: UIButton!
    
    var formApprovalViewModel = CheckSheetApprovalViewModel()
    
    var formApproverModel: FormResponseApprovalStatusModel?{
        didSet{
            formApproverConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ODSUIHelper.setButtonLayout(button: self.auditLogButton, cornerRadius: self.auditLogButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func formApproverConfiguration(){
        if let formApproverModel = formApproverModel{
            approverID.text = formApproverModel.ApproverID
            formStatus.text = formApproverModel.FormContentStatus
            if formApproverModel.FormContentStatus == "APPROVE"{
                formStatus.textColor = UIColor.systemGreen
            }else if formApproverModel.FormContentStatus == "REJECT"{
                formStatus.textColor = UIColor.systemRed
            }
            var date = String()
            if formApproverModel.CreatedDate != nil{
                date = formApproverModel.CreatedDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: formApproverModel.CreatedTime)
            reviewDateLabel.text = "\(date) \(time)"
            remarkLabel.text = formApproverModel.Remarks
            
            if !applicationFeatureArrayKeys.contains("APPROVER_AUDIT_LOG_OPTION"){
                self.auditLogButton.isHidden = true
            }else{
                self.auditLogButton.isHidden = false
                self.auditLogButton.addTarget(self, action: #selector(auditLogButtonAction), for: UIControl.Event.touchUpInside)
            }
        }
    }
    @objc func auditLogButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.formApprovalViewModel.formApprovalStatusVC.updateAuditLogView()
        mJCLogger.log("Ended", Type: "info")
    }
}
