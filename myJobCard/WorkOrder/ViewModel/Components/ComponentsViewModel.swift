//
//  ComponentsViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/01/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class ComponentsViewModel {
    
    var componentsVC: ComponentsVC?
    var componentsIPhoneVC: ComponentListVC?
    var componentCount = String()
    var selectedComponentClass = WoComponentModel()
    var componentListArray = [WoComponentModel]()
    var selectedComponentArray = [WoComponentModel]()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
    var hisWONum = String()
    var property = NSMutableArray()
    var isFromHistoryScreen = Bool()
    
    public func getComponentList() {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        if self.componentsVC?.isfrom == "Supervisor"{
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && WO_OP_OBJS_DISPLAY == "X"{
                defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and OperAct%20eq%20%27" + selectedOperationNumber + "%27&$orderby=Item"
            }else{
                defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27&$orderby=Item"
            }
            mJCLogger.log("getComponentList defineReq:- \(defineQuery)", Type: "")
            WoComponentModel.getSuperVisorComponentsList(filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [WoComponentModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0{
                            self.componentListArray = responseArr
                            if selectedComponentNumber != "" {
                                for i in 0..<self.componentListArray.count {
                                    let componentModeClass = self.componentListArray[i]
                                    let currentComponentNum = componentModeClass.Item
                                    if currentComponentNum == selectedComponentNumber {
                                        componentModeClass.isSelected = true
                                        self.componentsVC?.selectedComponent =  componentModeClass.Item
                                        self.didSelectedCell = i
                                        break
                                    }
                                }
                            }else {
                                if self.componentListArray.count > 0 {
                                    let componentModeClass = self.componentListArray[0]
                                    componentModeClass.isSelected = true
                                    selectedComponentNumber = componentModeClass.Item
                                    self.componentsVC?.selectedComponent = componentModeClass.Item
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    if DeviceType == iPhone{
                        self.componentsIPhoneVC?.getComponentListUI()
                    }else {
                        self.componentsVC?.getComponentListUI()
                    }
                }else {
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    if DeviceType == iPhone{
                        self.componentsIPhoneVC?.getComponentListUI()
                    }else {
                        self.componentsVC?.getComponentListUI()
                    }
                }
            }
        }else{
            if DeviceType == iPhone{
                if self.isFromHistoryScreen == true {
                    self.getHistoryData()
                }else {
                    self.getCompData()
                }
            }else {
                if self.isFromHistoryScreen == true {
                    self.getHistoryData()
                }else {
                    self.getCompData()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Get Component Data..
    
    func getHistoryData() {
        mJCLogger.log("Starting", Type: "info")
        
        if DeviceType == iPad {
            self.componentsVC?.newNotesButton.isHidden = true
        }
        let defineQuery = "$filter=(WorkOrderNum eq '\(hisWONum)')&$orderby=Item"
        
        WoComponentModel.getWoHistoryComponentDetails(filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoComponentModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.componentListArray = responseArr
                        if selectedComponentNumber != "" {
                            for i in 0..<self.componentListArray.count {
                                let componentModeClass = self.componentListArray[i]
                                let currentComponentNum = componentModeClass.Item
                                if currentComponentNum == selectedComponentNumber {
                                    componentModeClass.isSelected = true
                                    self.componentsVC?.selectedComponent =  componentModeClass.Item
                                    self.didSelectedCell = i
                                    break
                                }
                            }
                        }else{
                            if self.componentListArray.count > 0 {
                                let componentModeClass = self.componentListArray[0]
                                componentModeClass.isSelected = true
                                selectedComponentNumber = componentModeClass.Item
                                self.componentsVC?.selectedComponent =  componentModeClass.Item
                            }
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                if DeviceType == iPhone{
                    self.componentsIPhoneVC?.getComponentListUI()
                }else {
                    self.componentsVC?.getComponentListUI()
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                if DeviceType == iPhone{
                    self.componentsIPhoneVC?.getComponentListUI()
                }else {
                    self.componentsVC?.getComponentListUI()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getCompData() {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = ""
        self.componentListArray.removeAll()
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && WO_OP_OBJS_DISPLAY == "X"{
            defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and OperAct%20eq%20%27" + selectedOperationNumber + "%27 and Deleted eq false &$orderby=Item"
        }else{
            defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and Deleted eq false&$orderby=Item"
        }
        WoComponentModel.getComponentsWith(workOrderNo: selectedworkOrderNumber, filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoComponentModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.componentListArray = responseArr
                        if selectedComponentNumber != "" {
                            for i in 0..<self.componentListArray.count {
                                let componentModeClass = self.componentListArray[i]
                                let currentComponentNum = componentModeClass.Item
                                if currentComponentNum == selectedComponentNumber {
                                    componentModeClass.isSelected = true
                                    self.componentsVC?.selectedComponent =  componentModeClass.Item
                                    self.didSelectedCell = i
                                    break
                                }
                            }
                        }else {
                            if self.componentListArray.count > 0 {
                                let componentModeClass = self.componentListArray[0]
                                componentModeClass.isSelected = true
                                selectedComponentNumber = componentModeClass.Item
                                self.componentsVC?.selectedComponent =  componentModeClass.Item
                            }
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                if DeviceType == iPhone{
                    self.componentsIPhoneVC?.getComponentListUI()
                }else {
                    self.componentsVC?.getComponentListUI()
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                if DeviceType == iPhone{
                    self.componentsIPhoneVC?.getComponentListUI()
                }else {
                    self.componentsVC?.getComponentListUI()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func updateWithdrawalQtyComponent(componentClass:WoComponentModel,count:Int) {
        mJCLogger.log("Starting", Type: "info")
        
        let withdrawn = componentClass.ReqmtQty
        let withdrawalQty = "\(withdrawn).00"
        
        (componentClass.entity.properties["WithdrawalQty"] as! SODataProperty).value = NSDecimalNumber(string: "\(withdrawalQty)")
        componentClass.WithdrawalQty = withdrawn
        
        WoComponentModel.updateComponentEntity(entity: componentClass.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                mJCLogger.log("\(componentClass.Item)-\(componentClass.Material) withdrwal component updated".localized(), Type: "Debug")
                mJCLogger.log("Update Done", Type: "Debug")
                if self.selectedComponentArray.count == count + 1{
                    DispatchQueue.main.async {
                        if DeviceType == iPhone {
                            self.componentsIPhoneVC?.componentListTable.reloadData()
                        }else {
                            self.componentsVC?.componentTotalTableView.reloadData()
                        }
                    }
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setComponentBadgeIcon"), object: "")
                    if DeviceType == iPad{
                        mJCAlertHelper.showAlert(self.componentsVC!, title:MessageTitle, message: "Issued_Components_Sucessfully".localized(), button: okay)
                    }else{
                        if self.componentsIPhoneVC != nil{
                            mJCAlertHelper.showAlert(self.componentsIPhoneVC!, title:MessageTitle, message: "Issued_Components_Sucessfully".localized(), button: okay)
                        }else{
                            mJCAlertHelper.showAlert(self.componentsVC!, title:MessageTitle, message: "Issued_Components_Sucessfully".localized(), button: okay)
                        }
                    }
                    isComponentIssueDone = true
                }else{
                    self.componentIssueSet(count: count + 1)
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- delete Entity..
    func deleteIssueComponent()  {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            let componentClass = self.componentListArray[self.did_DeSelectedCell]
            WoComponentModel.deleteComponentEntity(entity: componentClass.entity, options: nil, completionHandler: { (response, error) in
                if error == nil {
                    mJCLogger.log("Delete Done", Type: "Debug")
                    mJCLogger.log("\(componentClass.Item) record deleted : Done", Type: "Debug")
                }
                else { print("\(componentClass.Item) record deleted : Failed!")
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func componentIssueSet(count:Int) {
        
        mJCLogger.log("Starting", Type: "info")
        
        let componentClass = selectedComponentArray[count]
        
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "Item")
        prop!.value = componentClass.Item as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Material")
        prop!.value = componentClass.Material as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = componentClass.Plant as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "StorLocation")
        prop!.value = componentClass.StorLocation as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = String.random(length: 2, type: "Number") as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "IssueQty")
        let issueQuantity  =  (componentClass.ReqmtQty as Decimal) -  (componentClass.WithdrawalQty as Decimal)
        prop!.value = NSDecimalNumber(string: "\(issueQuantity)")
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "UOM")
        prop!.value = componentClass.BaseUnit as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MovementType")
        prop!.value = componentClass.MovementType as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperAct")
        prop!.value = componentClass.OperAct as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Reservation")
        prop!.value = componentClass.Reservation as NSObject
        self.property.add(prop!)
        
        print("===== Issue Component Key Value ======")
        
        let entity = SODataEntityDefault(type: woComponentIssueSetEntity)
        for prop in self.property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("..............")
        }
        
        WoComponentIssueModel.issueComponentEntity(entity: entity!, collectionPath: woComponentIssueSet, flushRequired: false,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                mJCLogger.log("\(componentClass.Item)-\(componentClass.Material) component issued", Type: "")
                if DeviceType == iPhone{
                    if self.componentsVC != nil{
                        if self.componentsVC?.singleComponentArray.count ?? 0 > 0 {
                            self.updateWithdrawalQtyComponent(componentClass: self.componentsVC!.singleComponentArray[0], count: count)
                        }
                    }else{
                        self.updateWithdrawalQtyComponent(componentClass: self.selectedComponentArray[count], count: count)
                    }
                }else{
                    self.updateWithdrawalQtyComponent(componentClass: self.selectedComponentArray[count], count: count)
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
}

