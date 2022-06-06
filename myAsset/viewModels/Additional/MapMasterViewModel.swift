//
//  MapMasterViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class MapMasterViewModel {
    
    var vc : MapMasterListVC!
    var workOrderArray = [Any]()
    var workOrderListArray = [Any]()
    
    //MARK:- Get Workorder List..
    func getWorkOrderList() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getWorkorderList(){ (responseDict, error)  in
            if error == nil{
                self.workOrderArray.removeAll()
                self.workOrderListArray.removeAll()
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.workOrderArray.removeAll()
                            self.workOrderListArray.removeAll()
                            let arr = (responseArr as Array<Any>).prefix(masterDataLoadingItems)
                            self.workOrderArray.append(contentsOf: arr)
                            if DeviceType == iPad {
                                DispatchQueue.main.async {
                                    self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                                }
                            }
                            self.vc.skipvalue = arr.count
                            self.workOrderListArray.append(contentsOf: responseArr)
                            if self.workOrderArray.count > 0{
                                singleWorkOrder = self.workOrderArray[0] as! WoHeaderModel
                            }
                            self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + " : \(self.workOrderArray.count)"
                            self.vc.workOrderTableView.reloadData()
                            NotificationCenter.default.post(name: Notification.Name(rawValue:"SelectWorkOrder"), object: "selectWorkOrder")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func map_searchTextFieldEditingChanged(searchText : String) {
        
        mJCLogger.log("Starting", Type: "info")
        self.vc.did_DeSelectedCell = 0
        self.vc.didSelectedCell = 0
        if(searchText == "") {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                self.vc.setWorkorderFilterQuery(dict: dict)
            }else{
                self.workOrderArray.removeAll()
                for workorderItem in self.workOrderListArray {
                    (workorderItem as! WoHeaderModel).isSelectedCell = false
                }
                if self.workOrderListArray.count > 0 {
                    mJCLogger.log("Response:\(workOrderListArray.count)", Type: "Debug")
                    let woClass = self.workOrderListArray[0] as! WoHeaderModel
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.workOrderArray = self.workOrderListArray
                    if self.workOrderArray.count > 0{
                        singleWorkOrder = self.workOrderArray[0] as! WoHeaderModel
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(workOrderListArray.count)"
        }else {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                var filteredArray = [WoHeaderModel]()
                if searchText.isNumeric == true
                {
                    if filteredArray.count == 0{
                        filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(searchText)}
                    }
                }else {
                    filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.ShortText.contains(searchText)}
                    if filteredArray.count == 0 {
                        filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(searchText)}
                    }
                }
                if filteredArray.count > 0 {
                    mJCLogger.log("Response:\(filteredArray.count)", Type: "Debug")
                    let woClass = filteredArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    workOrderArray.removeAll()
                    self.workOrderArray = filteredArray
                    singleWorkOrder = woClass
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + " : \(workOrderArray.count)/\(workOrderListArray.count)"
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0/\(workOrderListArray.count)"
                }
            }else{
                workOrderArray.removeAll()
                var searchPredict = NSPredicate()
                var filteredArray = [WoHeaderModel]()
                for workOrderItem in self.workOrderListArray {
                    (workOrderItem as! WoHeaderModel).isSelectedCell = false
                }
                if searchText.isNumeric == true
                {
                    filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(searchText)}
                    if filteredArray.count == 0{
                        filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(searchText)}
                    }
                }else {
                    filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.ShortText.contains(searchText)}
                    if filteredArray.count == 0 {
                        filteredArray = (self.workOrderListArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(searchText)}
                        
                    }
                }
                if filteredArray.count > 0 {
                    mJCLogger.log("Response:\(filteredArray.count)", Type: "Debug")
                    let woClass = filteredArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.workOrderArray = filteredArray
                    singleWorkOrder = woClass
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(workOrderArray.count)/\(workOrderListArray.count)"
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": 0/\(workOrderListArray.count)"
                }
            }
        }
        self.vc.workOrderTableView.reloadData()
        NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
        if DeviceType == iPad {
            DispatchQueue.main.async {
                self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
