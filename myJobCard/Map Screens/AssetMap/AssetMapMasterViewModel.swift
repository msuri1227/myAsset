//
//  AssetMapMasterViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class AssetMapMasterViewModel {
    
    var vc : AssetMapMasterVC!
    var notificationArray = [Any]()
    var notificationListArray = [Any]()
    var workOrderArray = [Any]()
    var workOrderListArray = [Any]()
    var assetMapDetailViewModel = AssetMapDetailViewModel()
    
    //MARK:- Get WorkOrder Data..
    
    func getWorkOrderList() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getWorkorderList(){ (responseDict, error)  in
            if error == nil {
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.workOrderArray.removeAll()
                            self.workOrderListArray.removeAll()
                            let arr = (responseArr as Array<Any>).prefix(masterDataLoadingItems)
                            self.workOrderArray.append(contentsOf: arr)
                            self.vc.skipvalue = arr.count
                            self.workOrderListArray.append(contentsOf: responseArr)
                            if DeviceType == iPad {
                                DispatchQueue.main.async {
                                    self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                                }
                            }
                            DispatchQueue.main.async{
                                self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
                                self.vc.workOrderTableView.reloadData()
                            }
                        }
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
    //MARK:- Get WorkOrder Data..
    func getSupervisorWorkOrderList() {
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
                        //singleWorkOrder = self.workOrderArray[selectedWOIndex] as! WoHeaderModel
                        self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ": \(self.workOrderArray.count)/\(self.workOrderListArray.count)"
                        self.vc.workOrderTableView.reloadData()
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
    func getNotificationList() {
        
        mJCLogger.log("Starting", Type: "info")
        NotificationModel.getNotificationList(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.notificationArray.removeAll()
                        self.notificationListArray.removeAll()
                        let arr = (responseArr as Array<Any>).prefix(masterDataLoadingItems)
                        self.notificationArray.append(contentsOf: arr)
                        if DeviceType == iPad {
                            DispatchQueue.main.async {
                                self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                        self.vc.skipvalue = arr.count
                        self.notificationListArray.append(contentsOf: responseArr)
                        DispatchQueue.main.async{
                            self.vc.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(self.notificationArray.count)/\(self.notificationListArray.count)"
                            self.vc.workOrderTableView.reloadData()
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
    func createBatchToGetCountRequest(){
        
        mJCLogger.log("Starting", Type: "info")
        self.vc.skipvalue = 0
        let woCountQuery = "WoHeaderSet/$count"
        let workorderQuery = "WoHeaderSet?$top=\(masterDataLoadingItems)&$skip=\(self.vc.skipvalue)&$orderby=CreatedOn,Priority,WorkOrderNum asc"
        let batchArr = NSMutableArray()
        self.vc.showMore = false
        batchArr.add(woCountQuery)
        batchArr.add(workorderQuery)
        let batchRequest = SODataRequestParamBatchDefault.init()
        for obj in batchArr {
            let str = obj as! String
            let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
            reqParam?.customTag = str
            batchRequest.batchItems.add(reqParam!)
        }
        BatchRequestModel.getExecuteTransactionBatchRequest(batchRequest: batchRequest){ (response, error)  in
            if error == nil {
                if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                    let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == "WoHeaderSet" {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoHeaderModel.self)
                            if  let woarray = dict["data"] as? [WoHeaderModel]{
                                self.workOrderArray.removeAll()
                                self.workOrderListArray.removeAll()
                                if woarray.count > 0{
                                    mJCLogger.log("Response:\(woarray.count)", Type: "Debug")
                                    self.workOrderArray = woarray
                                    self.workOrderListArray = woarray
                                    if DeviceType == iPad {
                                        DispatchQueue.main.async {
                                            self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                                        }
                                    }
                                    for i in 0..<self.workOrderArray.count {
                                        if let notificationActivity = self.workOrderArray[i] as? WoHeaderModel {
                                            notificationActivity.isSelectedCell = false
                                        }
                                    }
                                    if selectedworkOrderNumber != "" {
                                        for i in 0..<self.workOrderArray.count {
                                            if let notificationActivity = self.workOrderArray[i] as? WoHeaderModel {
                                                let currentItemNum = notificationActivity.WorkOrderNum
                                                if selectedworkOrderNumber == currentItemNum {
                                                    notificationActivity.isSelectedCell = true
                                                    singleWorkOrder = (self.workOrderArray[i] as! WoHeaderModel)
                                                }
                                            }
                                        }
                                    }else {
                                        (self.workOrderArray[0] as! WoHeaderModel).isSelectedCell = true
                                        singleWorkOrder = (self.workOrderArray[0] as! WoHeaderModel)
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else if resourcePath == "Count"{
                            self.vc.totalWOCount = Int(responseDic["Count"] as! String) ?? 0
                        }
                        DispatchQueue.main.async{
                            mJCLoader.stopAnimating()
                            self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ":"+"\(self.workOrderArray.count)"+"/"+"\(self.workOrderListArray.count)"
                            for i in 0..<self.workOrderArray.count {
                                if let notificationActivity = self.workOrderArray[i] as? WoHeaderModel {
                                    notificationActivity.isSelectedCell = false
                                }
                            }
                            if selectedworkOrderNumber != "" {
                                for i in 0..<self.workOrderArray.count {
                                    if let notificationActivity = self.workOrderArray[i] as? WoHeaderModel {
                                        let currentItemNum = notificationActivity.WorkOrderNum
                                        if selectedworkOrderNumber == currentItemNum {
                                            notificationActivity.isSelectedCell = true
                                            singleWorkOrder = (self.workOrderArray[i] as! WoHeaderModel)
                                        }
                                    }
                                }
                            }else {
                                if self.workOrderArray.count > 0 {
                                    if self.workOrderListArray.count > 0{
                                        if let WOSelected =  self.workOrderListArray[0] as? WoHeaderModel{
                                            WOSelected.isSelectedCell = true
                                        }
                                    }
                                    if let WOSelected =  self.workOrderArray[0] as? WoHeaderModel{
                                        singleWorkOrder = WOSelected
                                    }
                                }
                            }
                            DispatchQueue.main.async{
                                self.vc.workOrderTableView.reloadData()
                            }
                        }
                    }
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshList(){
        
        mJCLogger.log("Starting", Type: "info")
        self.vc.showMore = true
        let WOcount = self.workOrderListArray.count
        let NOcount = self.notificationListArray.count
        if self.vc.numberofSection == 2 {
            self.vc.workOrderTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print(self.vc.skipvalue)
            self.vc.skipvalue += masterDataLoadingItems
            if currentMasterView == "Notification" {
                if NOcount >= self.vc.skipvalue {
                    let newarr = self.notificationListArray[(self.notificationArray.count)..<self.vc.skipvalue]
                    self.notificationArray.append(contentsOf: newarr)
                    if DeviceType == iPad {
                        DispatchQueue.main.async {
                            self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
                    }
                    self.vc.showMore = false
                    DispatchQueue.main.async{
                        self.vc.workOrderTableView.reloadData()
                    }
                }else{
                    let count =  self.vc.skipvalue - self.notificationListArray.count
                    let newarr = self.notificationListArray[(self.notificationArray.count)..<(self.vc.skipvalue - count)]
                    self.notificationArray.append(contentsOf: newarr)
                    if DeviceType == iPad {
                        DispatchQueue.main.async {
                            self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
                    }
                    self.vc.showMore = false
                    DispatchQueue.main.async{
                        self.vc.workOrderTableView.reloadData()
                    }
                }
                self.vc.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(self.notificationArray.count)/\(self.notificationListArray.count)"
            }else{
                if WOcount >= self.vc.skipvalue {
                    let newarr = self.workOrderListArray[(self.workOrderArray.count)..<self.vc.skipvalue]
                    self.workOrderArray.append(contentsOf: newarr)
                    if DeviceType == iPad {
                        DispatchQueue.main.async {
                            self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
                    }
                    self.vc.showMore = false
                    DispatchQueue.main.async{
                        self.vc.workOrderTableView.reloadData()
                    }
                }else{
                    let count =  self.vc.skipvalue - self.workOrderListArray.count
                    let newarr = self.workOrderListArray[(self.workOrderArray.count)..<(self.vc.skipvalue - count)]
                    self.workOrderArray.append(contentsOf: newarr)
                    if DeviceType == iPad {
                        DispatchQueue.main.async {
                            self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                        }
                    }
                    self.vc.showMore = false
                    DispatchQueue.main.async{
                        self.vc.workOrderTableView.reloadData()
                    }
                }
                self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ":"+"\(self.workOrderArray.count)"+"/"+"\(self.workOrderListArray.count)"
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Filter WorkOrder..
    func setWorkorderFilterQuery(dict : Dictionary<String,Any>) {
        
        mJCLogger.log("Starting", Type: "info")
        self.vc.isfromFilter = true
        let predicateArray = NSMutableArray()
        if dict.keys.count == 0{
            self.vc.isfromFilter = false
            self.workOrderArray.removeAll()
            for workorderItem in self.workOrderListArray{
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            if self.workOrderListArray.count > 0 {
                let woClass = self.workOrderListArray[0] as! WoHeaderModel
                woClass.isSelectedCell = true
                selectedworkOrderNumber = woClass.WorkOrderNum
                self.workOrderArray = self.workOrderListArray
                if DeviceType == iPad {
                    DispatchQueue.main.async {
                        self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                    }
                }
                singleWorkOrder = self.workOrderArray[0] as! WoHeaderModel
                self.vc.filterCountLabel.isHidden = true
                self.vc.workOrderTableView.reloadData()
            }
        }else{
            if dict.keys.contains("priority"),let arr = dict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("orderType"),let arr = dict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "OrderType IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("status"),let arr = dict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", arr,arr)
                    predicateArray.add(predicate)
                }
            }
            self.vc.did_DeSelectedCell = 0
            self.vc.didSelectedCell = 0
            for workorderItem in self.workOrderListArray{
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            let array = [(self.workOrderListArray as! [WoHeaderModel])].filter{compound.evaluate(with: $0)}
            if array.count > 0 {
                self.workOrderArray.removeAll()
                self.vc.filterCountLabel.isHidden = false
                self.vc.filterCountLabel.text = "\(self.workOrderArray.count)"
            }else {
                self.vc.filterCountLabel.isHidden = false
                self.vc.filterCountLabel.text = "0"
                selectedworkOrderNumber = ""
                singleWorkOrder = WoHeaderModel()
            }
            self.vc.workOrderTableView.reloadData()
            NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
        }
        self.vc.totalWorkOrderLabel.text = "Total_Workorders".localized() + ":"+"\(self.workOrderArray.count)"+"/"+"\(self.workOrderListArray.count)"
        mJCLogger.log("Ended", Type: "info")
    }
    func setNotificationFilterQuery(dict: Dictionary<String,Any>) {
        
        mJCLogger.log("Starting", Type: "info")
        self.vc.isfromFilter = true
        let predicateArray = NSMutableArray()
        if dict.keys.count == 0{
            self.vc.isfromFilter = false
            self.notificationArray.removeAll()
            for noItem in self.notificationListArray {
                (noItem as! NotificationModel).isSelectedCell = false
            }
            if self.notificationListArray.count > 0 {
                let noClass = self.notificationListArray[0] as! NotificationModel
                noClass.isSelectedCell = true
                selectedNotificationNumber = noClass.Notification
                self.notificationArray = self.notificationListArray
                singleNotification = self.notificationArray[0] as! NotificationModel
                self.vc.filterCountLabel.isHidden = true
            }
        }else{
            self.vc.did_DeSelectedCell = 0
            self.vc.didSelectedCell = 0
            
            for noItem in self.notificationListArray {
                (noItem as! NotificationModel).isSelectedCell = false
            }
            if dict.keys.contains("priority"),let arr = dict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("orderType"),let arr = dict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "NotificationType IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            let array = self.notificationListArray.filter{compound.evaluate(with: $0)}
            
            if array.count > 0 {
                self.notificationArray.removeAll()
                let noClass = array[0] as! NotificationModel
                noClass.isSelectedCell = false
                selectedNotificationNumber = noClass.Notification
                self.notificationArray = array
                singleNotification = self.notificationArray[0] as! NotificationModel
                self.vc.filterCountLabel.isHidden = false
                self.vc.filterCountLabel.text = "\(self.notificationArray.count)"
            }else {
                selectedNotificationNumber = ""
                singleNotification = NotificationModel()
            }
            self.vc.workOrderTableView.reloadData()
            NotificationCenter.default.post(name:Notification.Name(rawValue: "dataSetSuccessfully"), object: "DataSetMasterViewNotification")
        }
        self.vc.totalWorkOrderLabel.text = "Total_Notifications".localized() + ": \(self.notificationArray.count)"
        mJCLogger.log("Ended", Type: "info")
    }
}
