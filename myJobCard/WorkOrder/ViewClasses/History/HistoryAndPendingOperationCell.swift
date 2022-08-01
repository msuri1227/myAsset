//
//  ComponentTotalCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class HistoryAndPendingOperationCell: UITableViewCell {
    
    @IBOutlet var backGroudView: UIView!
    @IBOutlet var operationNoLabel: UILabel!
    @IBOutlet var shortTextLabel: UILabel!
    @IBOutlet var transperentView: UIView!
    @IBOutlet var componentButton: UIButton!
    @IBOutlet var componentStatusView: UIView!
    
    var indexpath = IndexPath()
    var historyPendingOprViewModel = HistoryAndPendingOprListViewModel()
    var historyPendingoprListModelClass: HistoryAndPendingOperationModel? {
        didSet{
            historyPendingoprListConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func historyPendingoprListConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let histModel = historyPendingoprListModelClass{
            operationNoLabel.text = histModel.OperationNum
            shortTextLabel.text = histModel.ShortText
            backGroudView.layer.cornerRadius = 3.0
            backGroudView.layer.shadowOffset = CGSize(width: 3, height: 3)
            backGroudView.layer.shadowOpacity = 0.2
            backGroudView.layer.shadowRadius = 2
            componentButton.isHidden = false
            componentButton.tag = indexpath.row
            componentButton.addTarget(self, action: #selector(self.selectOperationButtonClicked), for: .touchUpInside)
            if historyPendingOprViewModel.vcHistoryPendingOprList?.selectedopr.OperationNum == histModel.OperationNum{
                transperentView?.isHidden = false
                if DeviceType == iPad{
                    historyPendingOprViewModel.vcHistoryPendingOprList?.selectedopr = historyPendingOprViewModel.OprListArray[indexpath.row]
                    historyPendingOprViewModel.vcHistoryPendingOprList?.performSegue(withIdentifier: "showDetail", sender: HistoryAndPendingOperationCell.self)
                }
            }else {
                transperentView?.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func selectOperationButtonClicked(btn:UIButton)  {
        mJCLogger.log("Starting", Type: "info")
        historyPendingOprViewModel.did_DeSelectedCell = historyPendingOprViewModel.didSelectedCell
        if let selectedOpr = historyPendingOprViewModel.OprListArray[historyPendingOprViewModel.did_DeSelectedCell] as? WoOperationModel {
            historyPendingOprViewModel.vcHistoryPendingOprList?.selectedopr.isSelected = false
        }
        historyPendingOprViewModel.vcHistoryPendingOprList?.selectedopr = historyPendingOprViewModel.OprListArray[btn.tag]
        historyPendingOprViewModel.didSelectedCell = btn.tag
        historyPendingOprViewModel.vcHistoryPendingOprList?.selectedopr.isSelected = true
        historyPendingOprViewModel.vcHistoryPendingOprList?.updateUIselectOperationButton(tagValue: btn.tag)
        historyPendingOprViewModel.vcHistoryPendingOprList?.OprListTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }

}
