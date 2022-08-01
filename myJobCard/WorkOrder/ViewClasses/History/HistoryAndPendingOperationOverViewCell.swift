//
//  ComponentOverViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/11/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib

class HistoryAndPendingOperationOverViewCell: UITableViewCell {
    
    //workOrderNumberLabel Outlets..
    @IBOutlet var workOrderNumberView: UIView!
    @IBOutlet var workOrderNumberLabelView: UIView!
    @IBOutlet var workOrderNumberLabel: UILabel!
    
    //workOrderNumberLabel Outlets..
    @IBOutlet var operationNumberView: UIView!
    @IBOutlet var operationNumberLabelView: UIView!
    @IBOutlet var operationNumberLabel: UILabel!
    
    //workOrderNumberLabel Outlets..
    @IBOutlet var workCenterView: UIView!
    @IBOutlet var workCenterLabelView: UIView!
    @IBOutlet var workCenterLabel: UILabel!
    
    //workOrderNumberLabel Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantLabelView: UIView!
    @IBOutlet var plantLabel: UILabel!
    
    var historyPendingOprDetailModel: HistoryAndPendingOperationModel? {
        didSet{
            historyandPendingOprDetailConfiguration()
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
    func historyandPendingOprDetailConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        operationNumberLabel.text = historyPendingOprDetailModel?.OperationNum
        workOrderNumberLabel.text = historyPendingOprDetailModel?.WorkOrderNum
        workCenterLabel.text = historyPendingOprDetailModel?.WorkCenter
        plantLabel.text = historyPendingOprDetailModel?.Plant
        mJCLogger.log("Ended", Type: "info")
    }
    
}
