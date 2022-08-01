//
//  OnlineOperationsCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 13/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OnlineOperationsCell: UITableViewCell {

    @IBOutlet weak var operationNumberLbl: UILabel!
    @IBOutlet weak var supOperationNumberLbl: UILabel!
    @IBOutlet weak var plantlbl: UILabel!
    @IBOutlet weak var equipmentLbl: UILabel!
    @IBOutlet weak var operationShorttextLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var workCenterLbl: UILabel!
    @IBOutlet weak var functionalLocationLbl: UILabel!
    @IBOutlet weak var controlKeyLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var operationTitleLbl: UILabel!
    
    @IBOutlet weak var transferBtnAction: UIButton!
    
    var indexPath = IndexPath()
    var onlineOperationViewModel = OnlineItemOprViewModel()
    var onlineOperationModelClass: WoOperationModel? {
        didSet{
            onlineOperationConfiguration()
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
    
    func onlineOperationConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        operationTitleLbl.text = "Operation : \(onlineOperationModelClass?.OperationNum ?? "0000")"
        ODSUIHelper.setButtonLayout(button: transferBtnAction, cornerRadius:transferBtnAction.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)

        operationNumberLbl.text = onlineOperationModelClass?.OperationNum
        supOperationNumberLbl.text = onlineOperationModelClass?.SubOperation
        statusLbl.text = onlineOperationModelClass?.StatusFlag
        controlKeyLbl.text = onlineOperationModelClass?.ControlKey
        if onlineOperationModelClass?.ActStartExecDate != nil{
            startDateLbl.text = onlineOperationModelClass?.ActStartExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            startDateLbl.text = ""
        }
        if onlineOperationModelClass?.ActFinishExecDate != nil{
            endDateLbl.text = onlineOperationModelClass?.ActFinishExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            endDateLbl.text = ""
        }
       
        plantlbl.text = onlineOperationModelClass?.Plant
        workCenterLbl.text = onlineOperationModelClass?.WorkCenter
            
        if onlineOperationModelClass?.TransferPerson != "00000000"{
            priorityLbl.text = onlineOperationModelClass?.TransferPerson
        }else{
            priorityLbl.text = onlineOperationModelClass?.PersonnelNo
        }
        equipmentLbl.text = onlineOperationModelClass?.Equipment
        functionalLocationLbl.text = onlineOperationModelClass?.FuncLoc
        operationShorttextLbl.text = onlineOperationModelClass?.ShortText

        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            transferBtnAction.isHidden = false
            ODSUIHelper.setButtonLayout(button: transferBtnAction, cornerRadius: transferBtnAction.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            transferBtnAction.tag = indexPath.row
            transferBtnAction.addTarget(self, action: #selector(transferOnlineOperation(sender:)), for: .touchUpInside)
        }else{
            transferBtnAction.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func transferOnlineOperation(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        onlineOperationViewModel.vcOnlineItemOpr?.updateUITransferOnlineOperation(tagValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    
}
