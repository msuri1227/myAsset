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

class ComponentTotalCell: UITableViewCell {
    
    @IBOutlet var backGroudView: UIView!
    @IBOutlet var ComponentWaitListQuantityLabel: UILabel!
    @IBOutlet var ComponentRequireQuantityLabel: UILabel!
    @IBOutlet var ComponentTypeLabel: UILabel!
    @IBOutlet var componentIDNumberLabel: UILabel!
    @IBOutlet var transperentView: UIView!
    @IBOutlet var componentButton: UIButton!
    @IBOutlet var componentCheckBoxButton: UIButton!
    @IBOutlet var componentIssueDoneImageView: UIImageView!
    @IBOutlet var componentIssueDoneImageWidthConst: NSLayoutConstraint!
    @IBOutlet var componentCheckBoxButtonWidthConst: NSLayoutConstraint!
    @IBOutlet var componentStatusView: UIView!
    
    var indexPath = IndexPath()
    var isfrom = String()
    var isFromHistoryScreen = false
    var componentListArray = [WoComponentModel]()
    var singleComponentArray = [WoComponentModel]()
    var selectedComponentArray = WoComponentModel()
    var componentsViewModel = ComponentsViewModel()
    var componentModel:WoComponentModel?{
        didSet{
            configureComponentTotalCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureComponentTotalCell(){
        mJCLogger.log("Starting", Type: "info")
        if componentsViewModel.componentsVC?.isFromHistoryScreen == true {
            componentCheckBoxButton.isHidden = true
        }else {
            componentCheckBoxButton.isHidden = false
        }
        
        if let componentModel = componentModel {
            
            backGroudView.layer.cornerRadius = 3.0
            backGroudView.layer.shadowOffset = CGSize(width: 3, height: 3)
            backGroudView.layer.shadowOpacity = 0.2
            backGroudView.layer.shadowRadius = 2
            componentIssueDoneImageView.isHidden = true
            componentIssueDoneImageWidthConst.constant = 0.0
            componentIDNumberLabel.text = componentModel.Item
            componentButton.tag = self.indexPath.row
            componentCheckBoxButton.addTarget(self, action: #selector(self.ComponentCheckBoxSelected(btn:)), for: .touchUpInside)
            componentButton.addTarget(self, action: #selector(self.selectComponentButtonClicked), for: .touchUpInside)
            if isFromHistoryScreen {
                ComponentTypeLabel.text = componentModel.Material + " - " + componentModel.Description
            }else {
                ComponentTypeLabel.text = componentModel.Material + " - " + componentModel.MaterialDescription
            }
            ComponentRequireQuantityLabel.text = "Rqd_Qty".localized() + " : \(String(describing: componentModel.ReqmtQty))"
            ComponentWaitListQuantityLabel.text = "Wtd_Qty".localized() + " : \(String(describing: componentModel.WithdrawalQty))"
            componentCheckBoxButtonWidthConst.constant = 20.0
            if selectedComponentNumber == componentModel.Item {
                if componentModel.isSelected == true {
                    transperentView.isHidden = false
                    componentsViewModel.componentsVC?.selectedComponent = componentModel.Item
                    componentsViewModel.did_DeSelectedCell = indexPath.row
                    componentsViewModel.selectedComponentClass = componentModel
                } else {
                    transperentView.isHidden = true
                }
            }else {
                transperentView.isHidden = true
            }
            let  withdrawalQty = Int(truncating: componentModel.WithdrawalQty)
            let  reqmtQty = Int(truncating: componentModel.ReqmtQty)
            
            if Int(truncating: componentModel.WithdrawalQty ) > 0 {
                if componentModel.WithdrawalQty == componentModel.ReqmtQty || withdrawalQty > reqmtQty {
                    componentStatusView.isHidden = true
                    componentIssueDoneImageWidthConst.constant = 20.0
                    componentIssueDoneImageView.isHidden = false
                    componentCheckBoxButtonWidthConst.constant = 0.0
                }else {
                    if let featureListArr =  orderTypeFeatureDict.value(forKey: singleWorkOrder.OrderType){
                        if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary{
                            if let featurelist = featureDict.allKeys as? [String]{
                                if featurelist.contains("COMPONENT"){
                                    let mandLevel = featureDict.value(forKey: "COMPONENT") as? String ?? ""
                                    if mandLevel == "1"{
                                        componentStatusView.isHidden = false
                                        componentStatusView.backgroundColor = filledCountColor
                                        
                                    }else{
                                        componentStatusView.isHidden = false
                                        componentStatusView.backgroundColor = UIColor.red
                                        
                                    }
                                }else{
                                    componentStatusView.isHidden = false
                                    componentStatusView.backgroundColor = filledCountColor
                                }
                            }
                        }
                    }
                }
            }else {
                mJCLogger.log("Data not found", Type: "Debug")
                componentStatusView.isHidden = false
                componentStatusView.backgroundColor = UIColor.red
            }
            
            componentButton.isHidden = false
            
            if componentsViewModel.selectedComponentArray.contains(componentModel){
                componentCheckBoxButton.isSelected = true
            }else{
                componentCheckBoxButton.isSelected = false
            }
            if isfrom == "Supervisor"{
                componentCheckBoxButtonWidthConst.constant = 0.0
                componentsViewModel.componentsVC?.selectAllComponentButton.isHidden = true
            }
            if isFromHistoryScreen {
                componentCheckBoxButton.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    //MARK:- Select Component Button Action..
    @objc func selectComponentButtonClicked(btn:UIButton)  {
        
        mJCLogger.log("Starting", Type: "info")
        if componentsViewModel.selectedComponentArray.count == 0{
            let componentsClass = componentListArray[componentsViewModel.did_DeSelectedCell]
            componentsClass.isSelected = false
            
            let componentsClass1 = componentListArray[btn.tag]
            componentsClass1.isSelected = true
            componentsViewModel.selectedComponentClass = componentsClass1
            
            selectedComponentNumber = componentsClass1.Item
            componentsViewModel.componentsVC?.selectedComponent =  componentsClass1.Item
            componentsViewModel.didSelectedCell = btn.tag
            componentsViewModel.did_DeSelectedCell = componentsViewModel.didSelectedCell
            
            componentsViewModel.componentsVC?.componentTotalTableView.reloadData()
            componentsViewModel.componentsVC?.componentDetailTableView.reloadData()
            
        }else {
            
            let indexPath = IndexPath(row: btn.tag, section: 0)
            let cell = componentsViewModel.componentsVC?.componentTotalTableView.cellForRow(at: indexPath) as! ComponentTotalCell
            
            let componentCls = componentListArray[btn.tag]
            
            if cell.componentCheckBoxButton.isSelected == false{
                cell.componentCheckBoxButton.isSelected = true
                if !componentsViewModel.selectedComponentArray.contains(componentCls){
                    if componentCls.ReqmtQty == componentCls.WithdrawalQty{
                        mJCLogger.log("Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(componentsViewModel.componentsVC!, title:alerttitle, message: "Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), button: okay)
                    }else if componentCls.Reservation == ""{
                        mJCLogger.log("This_is_a_local_component_you_can't_issue".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(componentsViewModel.componentsVC!, title: "Local_Component".localized(), message: "This_is_a_local_component_you_can't_issue".localized(), button: okay)
                    }else{
                        componentsViewModel.selectedComponentArray.append(componentCls)
                    }
                }
            }else{
                cell.componentCheckBoxButton.isSelected = false
            }
            DispatchQueue.main.async {
                self.componentsViewModel.componentsVC?.componentTotalTableView.reloadData()
                self.componentsViewModel.componentsVC?.componentDetailTableView.reloadData()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    @objc func ComponentCheckBoxSelected(btn:UIButton){
        mJCLogger.log("Starting", Type: "info")
        let indexPath = IndexPath(row: btn.tag, section: 0)
        if let componentCls = componentModel{
            let reqmtQty = Int(truncating: componentCls.ReqmtQty)
            let withdrawalQty = Int(truncating: componentCls.WithdrawalQty)
            
            if componentCheckBoxButton.isSelected == false{
                componentCheckBoxButton.isSelected = true
                if !componentsViewModel.selectedComponentArray.contains(componentCls){
                    
                    if componentCls.ReqmtQty == componentCls.WithdrawalQty{
                        mJCLogger.log("Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(componentsViewModel.componentsVC!, title:alerttitle, message: "Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), button: okay)
                    }else if componentCls.Reservation == ""{
                        mJCLogger.log("This_is_a_local_component_you_can't_issue".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(componentsViewModel.componentsVC!, title:"Local_Component".localized(), message: "This_is_a_local_component_you_can't_issue".localized(), button: okay)
                        
                    }else{
                        if reqmtQty > withdrawalQty{
                            componentsViewModel.selectedComponentArray.append(componentCls)
                        }else{
                            mJCLogger.log("Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), Type: "Debug")
                            mJCAlertHelper.showAlert(componentsViewModel.componentsVC!, title: alerttitle, message: "Requied_Quantity_already_issued_you_can't_issue_this_component".localized(), button: okay)
                        }
                    }
                }
            }else{
                componentCheckBoxButton.isSelected = false
                if componentsViewModel.selectedComponentArray.contains(componentCls){
                    componentsViewModel.selectedComponentArray.remove(at:indexPath.row)
                }
            }
            self.componentsViewModel.componentsVC?.componentTotalTableView.reloadData()
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
