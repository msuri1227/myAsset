//
//  totalOperationCountswift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/28/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class TotalOperationCountCell: UITableViewCell {
    
    @IBOutlet var sideIndicatorView: UIView!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var operationNameLabel: UILabel!
    @IBOutlet var clockImage: UIImageView!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var transPerantView: UIView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var WithdranQtyLabel: UILabel!
    @IBOutlet var selectOpearettionButton: UIButton!
    @IBOutlet var operationCompleteImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet var clockImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet var selectCheckBoxButton: UIButton!
    @IBOutlet var selectCheckBoxWidthConst: NSLayoutConstraint!
    @IBOutlet weak var selectOperationButtonLeadingConstant: NSLayoutConstraint!
    
    
    var operationVCModel = OperationOverViewModel()
    var operationListVCModel = OperationListViewModel()
    var indexPath = IndexPath()
    
    var totalOprListClass: WoOperationModel?{
        didSet{
            totalOperationDataConfiguration()
        }
    }
    var totalOprListIphoneClass: WoOperationModel?{
        didSet{
            operationListDataConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        mJCLogger.log("Starting", Type: "info")
        backGroundView.layer.cornerRadius = 3
        backGroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backGroundView.layer.borderWidth = 0.1
        backGroundView.layer.shadowOpacity = 0.2
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func totalOperationDataConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let operationClass = totalOprListClass {
            if operationClass.SubOperation != ""{
                self.operationNameLabel.text = "\(operationClass.OperationNum) \\ \(operationClass.SubOperation)"
            }else{
                self.operationNameLabel.text = operationClass.OperationNum
            }
            self.backGroundView.layer.cornerRadius = 3.0
            self.backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
            self.backGroundView.layer.shadowOpacity = 0.2
            self.backGroundView.layer.shadowRadius = 2
            
            var date = String()
            if operationClass.EarlSchStartExecDate != nil{
                date = operationClass.EarlSchStartExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            
            let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: operationClass.EarlSchStartExecTime)
            self.dueDateLabel.text = "\(date) \(time)"
            
            self.selectOpearettionButton.isHidden = false
            self.selectOpearettionButton.tag = indexPath.row
            self.selectOpearettionButton.addTarget(self, action: #selector(self.selectOperationButtonClicked), for: .touchUpInside)
            
            self.selectCheckBoxButton.tag = indexPath.row
            self.selectCheckBoxButton.addTarget(self, action: #selector(self.operationSelectCheckBox), for: .touchUpInside)
            
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                
                if(operationClass.isCompleted) {
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }
                else if (operationClass.UserStatus.range(of: "ENRT") != nil) || (operationClass.UserStatus.range(of: "ARRI") != nil) || (operationClass.UserStatus.range(of: "STRT") != nil){
                    self.operationCompleteImageWidthConstraint.constant = 0.0
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }else if (operationClass.UserStatus.range(of: "COMP") != nil){
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }else{
                    self.operationCompleteImageWidthConstraint.constant = 0.0
                    self.sideIndicatorView.isHidden = false
                    self.sideIndicatorView.backgroundColor = UIColor.red
                }
            }else{
                if operationClass.SystemStatus.contains(find: "REL") ||   operationClass.SystemStatus == "" {
                    self.operationCompleteImageWidthConstraint.constant = 0.0
                    self.sideIndicatorView.isHidden = false
                    self.selectCheckBoxWidthConst.constant = 20.0
                    let filteredArray = operationVCModel.totalOprationArray.filter{$0.SystemStatus == "REL"}
                    if let featurs =  orderTypeFeatureDict.value(forKey: singleWorkOrder.OrderType) as? NSArray{
                        if let featureDict = featurs[0] as? NSMutableDictionary {
                            if featureDict.allKeys.count > 0 {
                                mJCLogger.log("Response:\(featureDict.allKeys.count)", Type: "Debug")
                                let featurelist = featureDict.allKeys as NSArray
                                if (featurelist.contains("OPERATION")) &&  (WORKORDER_ASSIGNMENT_TYPE == "1" ||  WORKORDER_ASSIGNMENT_TYPE == "3"){
                                    let mandateStr = featureDict.value(forKey: "OPERATION") as! String
                                    if mandateStr == "1" {
                                        if operationVCModel.totalOprationArray.count == filteredArray.count{
                                            self.sideIndicatorView.backgroundColor = UIColor.red
                                        }else{
                                            self.sideIndicatorView.backgroundColor = filledCountColor
                                        }
                                    }else{
                                        self.sideIndicatorView.backgroundColor = UIColor.red
                                    }
                                }else{
                                    self.sideIndicatorView.backgroundColor = filledCountColor
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
                if operationClass.SystemStatus.contains(find: "CNF") {
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.selectCheckBoxWidthConst.constant = 0.0
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func selectOperationButtonClicked(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        operationVCModel.selectOperationClick(btn:sender)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func operationSelectCheckBox(btn : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        operationVCModel.operationSelectionClick(btn: btn)
        mJCLogger.log("Ended", Type: "info")
    }
    // iPhone
    func operationListDataConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        self.selectOpearettionButton.isHidden = true
        self.operationCompleteImageWidthConstraint.constant = 0.0
        if let operationClass = totalOprListIphoneClass {
            if operationClass.SubOperation != ""{
                self.operationNameLabel.text = "\(operationClass.OperationNum) \\ \(operationClass.SubOperation)"
            }else{
                self.operationNameLabel.text =  "Operation".localized() + ": \(operationClass.OperationNum)"
            }
            self.DescriptionLabel.text = operationClass.ShortText
            self.selectCheckBoxButton.tag = indexPath.row
            self.selectCheckBoxButton.addTarget(self, action: #selector(self.operationSelectCheckBoxIphone(btn:)), for: .touchUpInside)

            var dueDate = String()
            let dueTime = ODSDateHelper.getTimeFromSODataDuration(dataDuration: operationClass.EarlSchStartExecTime)
            if operationClass.EarlSchStartExecDate != nil{
                dueDate = operationClass.EarlSchStartExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            self.dueDateLabel.text = "Start_Date".localized() + " : \(dueDate) \(dueTime)"
           if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if(operationClass.isCompleted) {
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }else if (operationClass.UserStatus.range(of: "ENRT") != nil) || (operationClass.UserStatus.range(of: "ARRI") != nil) || (operationClass.UserStatus.range(of: "STRT") != nil){
                    self.operationCompleteImageWidthConstraint.constant = -8.0
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }else if (operationClass.UserStatus.range(of: "COMP") != nil){
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.sideIndicatorView.backgroundColor = filledCountColor
                }else{
                    self.operationCompleteImageWidthConstraint.constant = -8.0
                    self.sideIndicatorView.isHidden = false
                    self.sideIndicatorView.backgroundColor = UIColor.red
                }
            }else{
                if(operationClass.isCompleted) {
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.selectCheckBoxWidthConst.constant = 0.0
                }else {
                    self.operationCompleteImageWidthConstraint.constant = -8.0
                    self.sideIndicatorView.isHidden = false
                    self.selectCheckBoxWidthConst.constant = 20.0
                }
                if operationClass.SystemStatus == "REL" {
                    self.operationCompleteImageWidthConstraint.constant = -8.0
                    self.sideIndicatorView.isHidden = false
                    self.selectCheckBoxWidthConst.constant = 20.0
                }
                if operationClass.SystemStatus.contains(find: "CNF") {
                    self.operationCompleteImageWidthConstraint.constant = 20.0
                    self.sideIndicatorView.isHidden = true
                    self.selectCheckBoxWidthConst.constant = 0.0
                }
            }
            if operationListVCModel.selectedOperationArray.contains(operationClass) == true{ self.selectCheckBoxButton.isSelected = true
            }else{
                self.selectCheckBoxButton.isSelected = false
            }
            if selectedworkOrderNumber == operationClass.WorkOrderNum && selectedOperationNumber == operationClass.OperationNum{
                operationListVCModel.vc?.selectedOprNum = operationClass.OperationNum
                transPerantView.isHidden = false
            }else{
                transPerantView.isHidden = true
            }
            if operationListVCModel.isfromsup == "Supervisor"{
                self.selectCheckBoxWidthConst.constant = 0.0
                operationListVCModel.vc?.SelectionAllOperationCheck.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func operationSelectCheckBoxIphone(btn:UIButton){
        mJCLogger.log("Starting", Type: "info")
        operationSelecrcheckBox(btn:btn)
        mJCLogger.log("Ended", Type: "info")
    }
    func operationSelecrcheckBox(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let indexPath = IndexPath(row: btn.tag, section: 0)
        if operationListVCModel.totalOprationArray.count > 0 {
            let singleoperationCls = operationListVCModel.totalOprationArray[btn.tag]
            mJCLogger.log("Response:\(operationListVCModel.totalOprationArray.count)", Type: "Debug")
           
            if selectCheckBoxButton.isSelected == false{
                selectCheckBoxButton.isSelected = true
                if operationListVCModel.selectedOperationArray.contains(singleoperationCls) == false{
                    let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
                    if singleoperationCls.OperationNum.contains(find: "L") {
                        selectCheckBoxButton.isSelected = false
                        mJCLogger.log("This_is_local_operation_You_can't_Complete_this_operation".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(operationListVCModel.vc!, title: alerttitle, message: "This_is_local_operation_You_can't_Complete_this_operation".localized(), button: okay)
                        return
                    }else if singleoperationCls.SystemStatus.contains(mobStatusCode){
                        selectCheckBoxButton.isSelected = false
                        mJCLogger.log("This_Operation_is_already_completed".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(operationListVCModel.vc!, title: alerttitle, message: "This_Operation_is_already_completed".localized(), button: okay)
                        return
                    }else{
                        operationListVCModel.selectedOperationArray.add(singleoperationCls)
                    }
                }
            }else{
                selectCheckBoxButton.isSelected = false
                if operationListVCModel.selectedOperationArray.contains(singleoperationCls) == true{
                    operationListVCModel.selectedOperationArray.remove(singleoperationCls)
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
