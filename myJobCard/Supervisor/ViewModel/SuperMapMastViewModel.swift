//
//  SuperMapMastViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class SuperMapMastViewModel {
    
    var vc : SupervisorMapMasterVC!
    var notificationArray = NSMutableArray()
    var notificationListArray = NSMutableArray()
    var workOrderArray = [WoHeaderModel]()
    var workOrderListArray = [WoHeaderModel]()
    
    //Get WorkOrder List..
    func getWorkOrderList() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getSuperVisorWorkorderList(){ (responseDict, error)  in
            if error == nil{
                self.workOrderArray.removeAll()
                self.workOrderListArray.removeAll()
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.workOrderArray = responseArr
                        self.workOrderListArray = responseArr
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
//                        singleWorkOrder = self.workOrderArray[selectedWOIndex]
//                        DispatchQueue.main.async {
//                            self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)"
//                            self.vc.workOrderTableView.reloadData()
//                        }
                        isfromMapScreen = false
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"SelectWorkOrder"), object: "selectWorkOrder")
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"SelectWorkOrder"), object: "selectWorkOrder")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getTechnicianName (){
        mJCLogger.log("Starting", Type: "info")
        SupervisorTechnicianModel.getSupervisorTechncianDetails(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [SupervisorTechnicianModel]{
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    alltechnicianListArray = responseArr
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Filter WorkOrder..
    func setWorkorderFilterQuery(dict : Dictionary<String,Any>) {
        
        mJCLogger.log("Starting", Type: "info")
        self.workOrderArray.removeAll()
        let predicateArray = NSMutableArray()
        if dict.keys.count == 0{
            if self.workOrderListArray.count > 0 {
                workOrderArray.removeAll()
                for workorderItem in self.workOrderListArray {
                    workorderItem.isSelectedCell = false
                }
                if selectedworkOrderNumber != "" {
                    for i in 0..<self.workOrderListArray.count {
                        let workorderObj = self.workOrderListArray[i]
                            let currentItemNum = workorderObj.WorkOrderNum
                            if selectedworkOrderNumber == currentItemNum {
                                workorderObj.isSelectedCell = true
                                self.vc.didSelectedCell = i
                                if self.workOrderListArray.count > 0 && workorderObj != self.workOrderListArray[0]  {
                                    self.workOrderListArray[0].isSelectedCell = false
                                }
                                DispatchQueue.main.async {
                                    self.vc.workOrderTableView.reloadData()
                                }
                                break
                            }else{
                                if self.workOrderListArray.count > 0 {
                                    self.workOrderListArray[0].isSelectedCell = true
                                    singleWorkOrder = self.workOrderListArray[0]
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        
                    }
                    let arr = (self.workOrderListArray as Array<Any>).prefix(masterDataLoadingItems)
                    self.workOrderArray.append(contentsOf: arr as! [WoHeaderModel])
                }
                else {
                    let woClass = self.workOrderListArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    let arr = (self.workOrderListArray as Array<Any>).prefix(masterDataLoadingItems)
                    self.workOrderArray.append(contentsOf: arr as! [WoHeaderModel])
                    singleWorkOrder = self.workOrderArray[0]
                }
                self.vc.filterCountLabel.isHidden = true
                DispatchQueue.main.async {
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)"
                }
            }
        }else{
            if dict.keys.contains("priority"),let arr = dict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("status"),let arr = dict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", arr,arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("teamMember"),let arr = dict["teamMember"] as? [String]{
                if arr.count > 0{
                    var listArr = [SupervisorTechnicianModel]()
                    var objectArr = [String]()
                    let predicate = NSPredicate(format: "Name IN %@",arr)
                    listArr = alltechnicianListArray.filter{predicate.evaluate(with: $0)}
                    for item in listArr {
                        let dispStr = item.Technician
                        objectArr.append(dispStr)
                    }
                    let predicate4 = NSPredicate(format: "Technician IN %@",objectArr)
                    predicateArray.add(predicate4)
                }
            }
            self.vc.did_DeSelectedCell = 0
            self.vc.didSelectedCell = 0
            for workorderItem in self.workOrderListArray {
                workorderItem.isSelectedCell = false
            }
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            let array = self.workOrderListArray.filter{compound.evaluate(with: $0)}
            self.workOrderArray.removeAll()
            if array.count > 0 {
                if selectedworkOrderNumber != "" {
                    self.workOrderArray = array
                    for i in 0..<array.count {
                        let workorderObj = array[i]
                        let currentItemNum = workorderObj.WorkOrderNum
                        if selectedworkOrderNumber == currentItemNum {
                            workorderObj.isSelectedCell = true
                            self.vc.didSelectedCell = i
                            if array.count > 0 && workorderObj != array[0]  {
                                array[0].isSelectedCell = false
                            }
                            DispatchQueue.main.async {
                                self.vc.workOrderTableView.reloadData()
                            }
                            break
                        }else{
                            if array.count > 0 {
                                array[0].isSelectedCell = true
                                singleWorkOrder = array[0]
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }
                    }
                }else {
                    let woClass = array[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.workOrderArray = array
                    singleWorkOrder = self.workOrderArray[0]
                }
                DispatchQueue.main.async{
                    self.vc.filterCountLabel.font = UIFont(name:AppFontName.regular, size: 12.0)
                    self.vc.filterCountLabel.text = " \(self.workOrderArray.count)"
                    self.vc.filterCountLabel.isHidden = false
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
                }
            }else {
                mJCLogger.log("Data not found", Type: "Debug")
                selectedworkOrderNumber = ""
                singleWorkOrder = WoHeaderModel()
                self.vc.filterCountLabel.text = "0"
                self.vc.filterCountLabel.isHidden = false
                self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
            }
        }
        DispatchQueue.main.async {
            self.vc.workOrderTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
