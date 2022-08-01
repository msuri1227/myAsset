//
//  SuperMasterViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class SuperMasterViewModel {
    
    var vc : SupervisorMasterListVC!
    var notificationArray = NSMutableArray()
    var notificationListArray = NSMutableArray()
    var workOrderArray = [Any]()
    var workOrderListArray = [Any]()
    
    //Get WorkOrder List..
    func getWorkOrderData() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getSuperVisorWorkorderList(filterQuery: ""){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        let arr = (responseArr as Array<Any>).prefix(masterDataLoadingItems)
                        self.workOrderArray.removeAll()
                        self.workOrderListArray.removeAll()
                        self.workOrderArray.append(contentsOf: arr)
                        self.workOrderListArray = responseArr
                        if selectedworkOrderNumber != "" {
                            for i in 0..<self.workOrderListArray.count {
                                if let notificationActivity = self.workOrderListArray[i] as? WoHeaderModel {
                                    let currentItemNum = notificationActivity.WorkOrderNum
                                    if selectedworkOrderNumber == currentItemNum {
                                        notificationActivity.isSelectedCell = true
                                        self.vc.didSelectedCell = i
                                        let indexPath  = IndexPath(row: i, section: 0)
                                        if self.workOrderListArray.count > 0 && notificationActivity != self.workOrderListArray[0] as? WoHeaderModel  {
                                            if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                                WOSelected.isSelectedCell = false
                                            }
                                        }
                                        DispatchQueue.main.async {
                                            self.vc.workOrderTableView.reloadData()
                                        }
                                        break
                                    }else{
                                        if self.workOrderListArray.count > 0 {
                                            if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                                WOSelected.isSelectedCell = true
                                            }
                                            if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                                singleWorkOrder = WOSelected
                                            }
                                        }else{
                                            mJCLogger.log("Data not found", Type: "Debug")
                                        }
                                    }
                                }
                            }
                        }else {
                            self.vc.didSelectedCell = 0
                            let WorkOrderClass = self.workOrderArray[self.vc.didSelectedCell]
                            (WorkOrderClass as! WoHeaderModel).isSelectedCell = true
                            singleWorkOrder = self.workOrderArray[self.vc.didSelectedCell] as! WoHeaderModel
                            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
                        }
                        self.settechinianName()
                        isfromMapScreen = false
                        if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                            if let dict = UserDefaults.standard.value(forKey:"ListFilter") as? Dictionary<String,Any> {
                                DispatchQueue.main.async {
                                    self.setWorkorderFilterQuery(dict: dict)
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.vc.workOrderTableView.reloadData()
                            }
                        }
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
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
    func settechinianName(){
        
        mJCLogger.log("Starting", Type: "info")
        if workOrderListArray.count > 0{
            for i in 0..<workOrderListArray.count{
                if let workorder = workOrderListArray[i] as? WoHeaderModel {
                    let name = alltechnicianListArray.filter{$0.Technician == "\(workorder.Technician)"}
                    if name.count > 0{
                        let nameStr = name[0]
                        workorder.TechnicianName = "\(nameStr.Name)"
                    }
                }
            }
        }
        DispatchQueue.main.async{
            if UserDefaults.standard.object(forKey: "ListFilter") != nil{
                if let dict = UserDefaults.standard.value(forKey:"ListFilter") as? Dictionary<String,Any> {
                    self.setWorkorderFilterQuery(dict: dict)
                }
            }else{
                self.vc.workOrderTableView.reloadData()
                DispatchQueue.main.async {
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
                }
//                if selectedWOIndex > 0 {
//                    let indexPath = IndexPath(row: selectedWOIndex, section: 0)
//                    if self.vc.workOrderTableView.isValidIndexPath(indexPath: indexPath){
//                        self.vc.workOrderTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
//                    }
//                }else {
//                    let indexPath = IndexPath(row: 0, section: 0)
//                    if self.vc.workOrderTableView.isValidIndexPath(indexPath: indexPath){
//                        self.vc.workOrderTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
//                    }
//                    if DeviceType == iPad{
//                        self.vc.performSegue(withIdentifier: "showDetail", sender: self)
//                    }
//                }
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
                    (workorderItem as! WoHeaderModel).isSelectedCell = false
                }
                if selectedworkOrderNumber != "" {
                    for i in 0..<self.workOrderListArray.count {
                        if let notificationActivity = self.workOrderListArray[i] as? WoHeaderModel {
                            let currentItemNum = notificationActivity.WorkOrderNum
                            if selectedworkOrderNumber == currentItemNum {
                                notificationActivity.isSelectedCell = true
                                self.vc.didSelectedCell = i
                                let indexPath  = IndexPath(row: i, section: 0)
                                if self.workOrderListArray.count > 0 && notificationActivity != self.workOrderListArray[0] as? WoHeaderModel  {
                                    if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                        WOSelected.isSelectedCell = false
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.vc.workOrderTableView.reloadData()
                                }
                                break
                            }else{
                                if self.workOrderListArray.count > 0 {
                                    if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                        WOSelected.isSelectedCell = true
                                    }
                                    if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                        singleWorkOrder = WOSelected
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                    }
                    let arr = (self.workOrderListArray as Array<Any>).prefix(masterDataLoadingItems)
                    self.workOrderArray.append(contentsOf: arr)
                }else {
                    let woClass = self.workOrderListArray[0] as! WoHeaderModel
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    let arr = (self.workOrderListArray as Array<Any>).prefix(masterDataLoadingItems)
                    self.workOrderArray.append(contentsOf: arr)
                    singleWorkOrder = self.workOrderArray[0] as! WoHeaderModel
                }
                self.vc.filterCountLabel.isHidden = true
                DispatchQueue.main.async {
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)"
                }
                self.vc.noDataView.isHidden = true
                self.vc.noDataLabel.text = ""
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
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            let array = self.workOrderListArray.filter{compound.evaluate(with: $0)}
            self.workOrderArray.removeAll()
            if array.count > 0 {
                if selectedworkOrderNumber != "" {
                    self.workOrderArray = array
                    for i in 0..<array.count {
                        if let notificationActivity = array[i] as? WoHeaderModel {
                            let currentItemNum = notificationActivity.WorkOrderNum
                            if selectedworkOrderNumber == currentItemNum {
                                notificationActivity.isSelectedCell = true
                                self.vc.didSelectedCell = i
                                let indexPath  = IndexPath(row: i, section: 0)
                                if array.count > 0 && notificationActivity != array[0] as? WoHeaderModel  {
                                    if let WOSelected =  array[0] as? WoHeaderModel{
                                        WOSelected.isSelectedCell = false
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.vc.workOrderTableView.reloadData()
                                }
                                break
                            }else{
                                if array.count > 0 {
                                    if let WOSelected =  array[0] as? WoHeaderModel{
                                        WOSelected.isSelectedCell = true
                                    }
                                    if let WOSelected =  array[0] as? WoHeaderModel{
                                        singleWorkOrder = WOSelected
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                    }
                }else {
                    let woClass = array[0] as! WoHeaderModel
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.workOrderArray = array
                    singleWorkOrder = self.workOrderArray[0] as! WoHeaderModel
                    self.vc.noDataView.isHidden = true
                }
                DispatchQueue.main.async{
                    self.vc.filterCountLabel.font = UIFont(name:AppFontName.regular, size: 12.0)
                    self.vc.filterCountLabel.text = " \(self.workOrderArray.count)"
                    self.vc.filterCountLabel.isHidden = false
                    self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                selectedworkOrderNumber = ""
                singleWorkOrder = WoHeaderModel()
                self.vc.filterCountLabel.text = "0"
                self.vc.filterCountLabel.isHidden = false
                self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
                self.vc.noDataView.isHidden = false
                self.vc.noDataLabel.text = "No_Data_Available".localized()
            }
        }
        DispatchQueue.main.async {
            self.vc.workOrderTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- recordpoints
    
    func getRecordpointdata(workorder : AnyObject){
        
        mJCLogger.log("Starting", Type: "info")
        let pointarray = NSMutableArray()
        if let workorderDetail = workorder as? WoHeaderModel {
            let allMeasurmentpointsmodel = EquipFuncLocMeasurementModel()
            allMeasurmentpointsmodel.Equipment = workorderDetail.EquipNum
            allMeasurmentpointsmodel.FunctionalLocation = workorderDetail.FuncLocation
            allMeasurmentpointsmodel.WoObjectNum =  workorderDetail.ObjectNumber
            allMeasurmentpointsmodel.WorkOrderNum = workorderDetail.WorkOrderNum
            allMeasurmentpointsmodel.OperationNum = ""
            pointarray.add(allMeasurmentpointsmodel)
            
            if ENABLE_OPERATION_MEASUREMENTPOINT_READINGS == true {
                EquipFuncLocMeasurementModel.getOperationEquipFuncLocDetailsForSupervisor(workOrderNum: workorderDetail.WorkOrderNum) { (responseDict, error)  in
                    if error == nil{
                        let dict1 =  NSMutableDictionary()
                        if let responseArr = responseDict["data"] as? [EquipFuncLocMeasurementModel]{
                            if responseArr.count > 0{
                                mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                                let allPointArray = responseArr.sorted{$0.OperationNum.compare($1.OperationNum) == .orderedAscending } as NSArray
                                let predicate : NSPredicate = NSPredicate(format: "SELF.Equipment != '' OR SELF.FunctionalLocation != ''")
                                let filteredArray = allPointArray.filtered(using: predicate)
                                pointarray.addObjects(from: filteredArray)
                                let pointarray1 = NSMutableArray()
                                pointarray1.addObjects(from: filteredArray)
                                dict1.setValue(pointarray1, forKey: "Operations")
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            dict1.setValue(pointarray, forKey: "Workorder")
                            self.getPointDetails(detailarray: dict1)
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else {
                        mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }else{
                let dict =  NSMutableDictionary()
                dict.setValue(pointarray, forKey: "Workorder")
                self.getPointDetails(detailarray: dict)
            }
        }else if let operation = workorder as? WoOperationModel{
            
            //          let allMeasurmentpointsmodel = allMeasurmentpointsClass()
            //               allMeasurmentpointsmodel.Equipment = operation.Equipment
            //               allMeasurmentpointsmodel.FunctionalLocation = operation.FuncLoc
            //               allMeasurmentpointsmodel.OperationNum = operation.OperationNum
            //               allMeasurmentpointsmodel.OpObjectNum = operation.OpObjectNum
            //               pointarray.add(allMeasurmentpointsmodel)
            //               self.getPointDetails(detailarray: pointarray)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPointDetails(detailarray:NSMutableDictionary){
        mJCLogger.log("Starting", Type: "info")
        finalReadingpointsArray.removeAll()
        var defineQuery = String()
        let filterStr = myAssetDataManager.uniqueInstance.getRecordPointDefineRequestString(detailarray: detailarray)
        if filterStr.contains(find: "Equipment") || filterStr.contains(find: "FunctionalLocation"){
            defineQuery = "$filter=\(filterStr)"
        }else{
            return
        }
        MeasurementPointModel.getSupMeasurementPointDetails(filterQuery: defineQuery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [MeasurementPointModel]{
                    if responseArr.count > 0{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        if let  workorderdata = detailarray.value(forKey: "Workorder") as? [EquipFuncLocMeasurementModel]{
                            if workorderdata.count > 0 {
                                mJCLogger.log("Response:\(workorderdata[0])", Type: "Debug")
                                let workorder = workorderdata[0]
                                if workorder.Equipment != ""{
                                    let filterArray = responseArr.filter{$0.Equipment == "\(workorder.Equipment)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        mJCLogger.log("Response:\(filterArray.count)", Type: "Debug")
                                        finalReadingpointsArray =  filterArray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }
                                if workorder.FunctionalLocation != ""{
                                    let filterArray = responseArr.filter{$0.FunctionalLocation == "\(workorder.FunctionalLocation)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        finalReadingpointsArray = filterArray
                                    }
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }
                        if let  operationdata = detailarray.value(forKey: "Operations") as? [EquipFuncLocMeasurementModel]{
                            for i in 0..<operationdata.count{
                                let operation = operationdata[i]
                                if operation.Equipment != ""{
                                    let filterArray = responseArr.filter{$0.Equipment == "\(operation.Equipment)" && $0.WOObjectNum == "" && $0.OpObjectNumber == "" }
                                    if filterArray.count > 0{
                                        for j in 0..<filterArray.count{
                                            let opr = filterArray[j]
                                            opr.OperationNum = operation.OperationNum
                                            finalReadingpointsArray.append(opr)
                                        }
                                    }
                                }
                                if operation.FunctionalLocation != ""{
                                    let filterArray = responseArr.filter{$0.FunctionalLocation == "\(operation.FunctionalLocation)"}
                                    if filterArray.count > 0{
                                        mJCLogger.log("Response:\(filterArray.count)", Type: "Debug")
                                        for j in 0..<filterArray.count{
                                            let opr = filterArray[j]
                                            opr.OperationNum = operation.OperationNum
                                            finalReadingpointsArray.append(opr)
                                        }
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }
                            }
                        }
                        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"OperationNum", ascending : true)
                        let descriptor1:NSSortDescriptor = NSSortDescriptor (key:"MeasuringPoint", ascending : true)
                        let sortedArray:NSArray = ((finalReadingpointsArray as NSArray).sortedArray(using : [descriptor,descriptor1]) as NSArray)
                        finalReadingpointsArray.removeAll()
                        finalReadingpointsArray.append(contentsOf: sortedArray as! [MeasurementPointModel])
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "RecordPointsUpdated"), object: nil)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
