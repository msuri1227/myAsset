//
//  InspectionLotViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 09/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation
import UIKit

class InspectionViewModel {
    
    var inspVc: InspectionsVC?
    var inspResultVc: MultipleInspectionResultCaptureVC?
    var inspOprVc: InspectionOperationsVC?
    var inspOprArray = Array<InspectionOperationModel>()
    var inspOprPointArray = Array<InspectionPointModel>()
    var inspPointCharArray = Array<InspectionCharModel>()
    var inspResultArray = Array<InspectionResultModel>()
    var qmValutionListArray = Array<QmResultModel>()
    var selectedOprCellIndex = Int()
    var currentPointIndex = Int()
    var property = NSMutableArray()
    var charclas = InspectionCharModel()
    var fromResultsScreen = false
    var vc = UIApplication.shared.keyWindow!.rootViewController

    func getInspectionOperations(from:String){
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && WO_OP_OBJS_DISPLAY == "X"{
            defineQuery = "$filter=(InspectionLot%20eq%20%27" + singleWorkOrder.InspectionLot + "%27 and Operation%20eq%20%27" + selectedOperationNumber + "%27)&$orderby=Operation"
        }else{
            defineQuery = "$filter=(InspectionLot%20eq%20%27\(singleWorkOrder.InspectionLot)%27)&$orderby=Operation"
        }
        InspectionOperationModel.getInspOperationList(inspLotNum: singleWorkOrder.InspectionLot, filterQuery: defineQuery) { (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [InspectionOperationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.inspOprArray = responseArr
                        let opr = self.inspOprArray[0]
                        self.getInspectionPoints(lot: opr.InspectionLot, Opr: opr.Operation)
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                if from == "Operations"{
                    self.inspOprVc?.updateInspectionOperationUI()
                }else{
                    self.inspVc?.getInspectionUpdateUI()
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getInspectionPoints(lot:String, Opr:String){
        mJCLogger.log("Starting", Type: "info")
        self.inspOprPointArray.removeAll()
        self.inspPointCharArray.removeAll()
        self.inspResultArray.removeAll()
        InspectionPointModel.getInspPointListWith(inspLot: lot, operNum: Opr) { (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [InspectionPointModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    var pointDetails = InspectionPointModel()
                    if responseArr.count > 0 {
                        self.inspOprPointArray = responseArr
                        pointDetails = self.inspOprPointArray[0]
                        self.getPointCharasterstics(lot: pointDetails.InspLot, operation: pointDetails.InspOper, Point: pointDetails.InspPoint)
                        self.getInspectionResult(lot: pointDetails.InspLot, operation: pointDetails.InspOper, sample: pointDetails.InspPoint, Char: "", from: "")
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    self.inspVc?.getInspectionPointsUI(pointDetails: pointDetails)
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPointCharasterstics(lot:String,operation:String,Point:String){
        mJCLogger.log("Starting", Type: "info")
        InspectionCharModel.getInspCharsWith(inspLotNum: lot, inspOpr: operation, inspPoint: Point) { (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [InspectionCharModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.inspPointCharArray = responseArr
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    self.inspVc?.getPointCharastersticsUI()
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getInspectionResult(lot:String,operation:String,sample:String,Char:String,from:String){
        mJCLogger.log("Starting", Type: "info")
        self.inspResultArray.removeAll()
        
        var filterQuery = String()
        if Char != ""{
            filterQuery = "$filter=(InspLot eq '\(lot)' and InspOper eq '\(operation)' and InspSample eq '\(sample)' and InspChar eq '\(Char)')"
        }else{
            filterQuery = ""
        }
        InspectionResultModel.getInspResultListWith(inspLotNum: lot, inspOper: operation, inspSample: sample, filterQuery: filterQuery) { (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [InspectionResultModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.inspResultArray = responseArr
                    if from == "resultsVC"{
                        self.inspResultVc?.updateResultsUI()
                    }else{
                        self.inspVc?.getPointCharastersticsUI()
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //  MARK:- Save Inspection Result
    
    func saveInspectionResult(index : Int,section:Int) {
        mJCLogger.log("Starting", Type: "info")
        
        if (isActiveWorkOrder == true) {
            var  cell = InspectionCell()
            if self.fromResultsScreen == false{
                cell = inspVc!.inspectionPointsTabelView.cellForRow(at: NSIndexPath(row: index, section: section) as IndexPath) as! InspectionCell
            }else{
                cell = inspResultVc!.inspectionTableView.cellForRow(at: NSIndexPath(row: index, section: section) as IndexPath) as! InspectionCell
            }
            if cell.resultTextField.text == ""{
                mJCAlertHelper.showAlert(self.vc!, title: errorTitle, message: "Please_add_result".localized(), button: okay)
                return
            }else if cell.resultTextField.text?.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil{
                mJCAlertHelper.showAlert(self.vc!, title: MessageTitle, message: "Please_enter_valid_result".localized(), button: okay)
                return
            }
            
            self.property = NSMutableArray()
            
            var prop = SODataPropertyDefault(name: "ResValue")
            
            if charclas.CharType == "02" {
                if cell.resultTextField.text != "" || cell.resultTextField.text != nil {
                    let arr1 = cell.resultTextField.text!.components(separatedBy: " - ")
                    let arr = self.qmValutionListArray.filter{$0.Code == "\(arr1[0])" && $0.Description == "\(arr1[1])"}
                    if arr.count > 0{
                        let qmobj = arr[0]
                        prop = SODataPropertyDefault(name: "Code1")
                        prop!.value = qmobj.Code as NSObject?
                        self.property.add(prop!)
                        
                        prop = SODataPropertyDefault(name: "Description")
                        prop!.value = qmobj.Description as NSObject?
                        self.property.add(prop!)
                        
                        prop = SODataPropertyDefault(name: "CodeGrp1")
                        prop!.value = qmobj.CodeGroup as NSObject?
                        self.property.add(prop!)
                    }
                }
            }else{
                prop!.value = cell.resultTextField.text as NSObject?
                self.property.add(prop!)
            }
            
            prop = SODataPropertyDefault(name: "Remark")
            prop!.value = cell.remarkTextView.text as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspLot")
            prop!.value = charclas.InspLot as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspOper")
            prop!.value = charclas.InspOper as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspChar")
            prop!.value = charclas.InspChar as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspSample")
            prop!.value = charclas.InspPoint as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Inspector")
            prop!.value = strUser.uppercased() as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspDate")
            let datestr = Date().localDate()
            prop!.value = datestr as NSObject
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspTime")
            let basicTime = SODataDuration()
            let time = Date().toString(format: .custom("HH:mm"))
            let basicTimeArray = time.components(separatedBy:":")
            basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
            basicTime.seconds = 0
            prop!.value = basicTime
            property.add(prop!)
            
            let resno = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((Int(self.inspResultArray.count) ) + 1)")
            
            prop = SODataPropertyDefault(name: "ResNo")
            prop!.value = resno as NSObject?
            self.property.add(prop!)
            
            print("===== SaveInspection Key Value ======")
            let entity = SODataEntityDefault(type: inspectionResultEntity)
            for prop in self.property {
                let proper = prop as! SODataProperty
                entity?.properties[proper.name as Any] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("......................")
            }
            InspectionResultModel.creatInspCharEntity(entity: entity!, collectionPath: "InspectionResultsGetSet", flushRequired: true,options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Create Done", Type: "Debug")
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setInspectionCountNotification"), object: "")
                    self.inspResultArray.removeAll()
                    if self.fromResultsScreen == true{
                        self.getInspectionResult(lot: self.charclas.InspLot, operation: self.charclas.InspOper, sample: self.charclas.InspPoint, Char: self.charclas.InspChar, from: "resultsVC")
                    }else{
                        self.getInspectionResult(lot: self.charclas.InspLot, operation: self.charclas.InspOper, sample: self.charclas.InspPoint, Char: self.charclas.InspChar, from: "")
                    }

                    
                }else{
                    DispatchQueue.main.async {
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                        mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Fail_to_save_Inspection_Result_try_again".localized(), button: okay)
                    }
                }
            })
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self.vc!, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self.vc!, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //  MARK:- Update Inspection Result
    func UpdateInspectionResult(index : Int,section:Int) {
        mJCLogger.log("Starting", Type: "info")
        if (isActiveWorkOrder == true){
            let charclas =   self.charclas
            var  cell = InspectionCell()
            if self.fromResultsScreen == false{
                cell = inspVc!.inspectionPointsTabelView.cellForRow(at: NSIndexPath(row: index, section: section) as IndexPath) as! InspectionCell
            }else{
                cell = inspResultVc!.inspectionTableView.cellForRow(at: NSIndexPath(row: index, section: section) as IndexPath) as! InspectionCell
            }
            var filterArr = Array<InspectionResultModel>()

            if charclas.Scope == "1"{
                filterArr = self.inspResultArray.filter{$0.InspLot == "\(charclas.InspLot)" && $0.InspSample == "\(charclas.InspPoint)" && $0.InspOper == "\(charclas.InspOper)" && $0.InspChar == "\(charclas.InspChar)"}
            }else{
                filterArr = self.inspResultArray.filter{$0.InspLot == "\(charclas.InspLot)" && $0.InspSample == "\(charclas.InspPoint)" && $0.InspOper == "\(charclas.InspOper)" && $0.InspChar == "\(charclas.InspChar)"} //  && $0.ResNo == "0001"
            }
            if filterArr.count > 0{
                let result = filterArr[index]
                if charclas.CharType == "02" {
                    let resultCode = result.Code1
                    var newCode = String()
                    let resultArr = cell.resultTextField.text!.components(separatedBy: " - ")
                    if resultArr.count > 0{
                        newCode = resultArr[0]
                    }
                    if resultCode == newCode && result.Remark ==  cell.remarkTextView.text{
                        mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Please_update_atleast_one_value".localized(), button: okay)
                        return
                    }
                }else{
                    if result.ResValue == cell.resultTextField.text && result.Remark ==  cell.remarkTextView.text{
                        mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Please_update_atleast_one_value".localized(), button: okay)
                        return
                    }
                }
                (result.entity.properties["Remark"] as! SODataProperty).value =  cell.remarkTextView.text as NSObject?
                if charclas.CharType == "02" {
                    if cell.resultTextField.text != "" || cell.resultTextField.text != nil {
                        let arr1 = cell.resultTextField.text!.components(separatedBy: " - ")
                        let arr = self.qmValutionListArray.filter{$0.Code == "\(arr1[0])" && $0.Description == "\(arr1[1])"}
                        if arr.count > 0{
                            let qmobj = arr[0]
                            (result.entity.properties["Code1"] as! SODataProperty).value =  qmobj.Code as NSObject?
                            (result.entity.properties["Description"] as! SODataProperty).value =  qmobj.Description as NSObject?
                            (result.entity.properties["CodeGrp1"] as! SODataProperty).value =  qmobj.CodeGroup as NSObject?
                            let datestr = Date().localDate()
                            (result.entity.properties["InspDate"] as! SODataProperty).value =  datestr as NSObject
                            let basicTime = SODataDuration()
                            let time = Date().toString(format: .custom("HH:mm"))
                            let basicTimeArray = time.components(separatedBy:":")
                            basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
                            basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
                            basicTime.seconds = 0
                            (result.entity.properties["InspTime"] as! SODataProperty).value =  basicTime
                        }
                    }
                }else{
                    (result.entity.properties["ResValue"] as! SODataProperty).value =  cell.resultTextField.text as NSObject?
                    let datestr = Date().localDate()
                    (result.entity.properties["InspDate"] as! SODataProperty).value =  datestr as NSObject
                    let basicTime = SODataDuration()
                    let time = Date().toString(format: .custom("HH:mm"))
                    let basicTimeArray = time.components(separatedBy:":")
                    basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
                    basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
                    basicTime.seconds = 0
                    (result.entity.properties["InspTime"] as! SODataProperty).value =  basicTime
                }
                InspectionResultModel.updateInspCharEntity(entity: result.entity,flushRequired: true ,options: nil, completionHandler: { (response, error) in
                    if(error == nil){
                        mJCLogger.log("Update Done", Type: "Debug")
                        self.inspResultArray.removeAll()
                        if self.fromResultsScreen == true{
                            self.getInspectionResult(lot: charclas.InspLot, operation: charclas.InspOper, sample: charclas.InspPoint, Char: charclas.InspChar, from: "resultsVC")
                        }else{
                            self.getInspectionResult(lot: charclas.InspLot, operation: charclas.InspOper, sample: charclas.InspPoint, Char: charclas.InspChar, from: "")
                        }

                    }
                    else{
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                        mJCAlertHelper.showAlert(self.vc!, title: alerttitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
                    }
                })
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self.vc!, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self.vc!, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func showDropDownDetails(sender:UIButton,qmResultArray:[QmResultModel]){
        mJCLogger.log("Starting", Type: "info")
        let menudropDown = DropDown()
        var menuarr = [String]()
        for resultObj in qmResultArray {
            menuarr.append(resultObj.Code + " - " + resultObj.Description)
        }
        menudropDown.dataSource = menuarr
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = inspVc?.inspectionPointsTabelView.cellForRow(at: indexPath) as! InspectionCell
            cell.resultTextField.text = item
            menudropDown.hide()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getQmResultArray(){
        mJCLogger.log("Starting", Type: "info")
        QmResultModel.getQmResultsListWith(equipment: singleWorkOrder.EquipNum){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [QmResultModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.qmValutionListArray.removeAll()
                        self.qmValutionListArray = responseArr
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
