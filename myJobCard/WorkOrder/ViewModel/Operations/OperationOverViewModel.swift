//
//  OperationOverViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 11/01/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class OperationOverViewModel {
    
    var operationsVC: OperationsVC!
    var workorderListArr = [WoHeaderModel]()
    var personResponsibleArray = NSMutableArray()
    var AllowedFollOnObjTypArray = [AllowedFollowOnObjectTypeModel]()
    var selectedOperationArray = [WoOperationModel]()
    var totalOprationArray = [WoOperationModel]()
    var singleOperationArray = [WoOperationModel]()
    var isfromsup = String()
    var isTranformHidden = true
    func getAllowedFollowOnObjectType() {
        mJCLogger.log("Starting", Type: "info")
        AllowedFollowOnObjectTypeModel.getAllowedFollowOnObjectTypeList(objectType: singleWorkOrder.OrderType, roleId: Role_ID){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [AllowedFollowOnObjectTypeModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.AllowedFollOnObjTypArray = responseArr
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // Confirmation Operation List
    func getConfirmationOpeartionSet(isfromsup:String) {
        mJCLogger.log("Starting", Type: "info")
        if isfromsup == "Supervisor"{
            self.getOpeartionData(isfromsup:isfromsup)
        }else{
            if DeviceType == iPad{
                self.operationsVC.operationButtonView.isHidden = false
            }
            let defineQuery = "$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
            WoOperationModel.getWoConfirmationSet(filterQuery: defineQuery){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [WoOperationModel]{
                        if responseArr.count > 0 {
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                            self.operationsVC.confirmOperationList.removeAll()
                            var arr = [String]()
                            for item in responseArr{
                                arr.append(item.OperationNum)
                            }
                            self.operationsVC.confirmOperationList = arr
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    self.getOpeartionData(isfromsup:isfromsup)
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getOpeartionData(isfromsup:String) {
        if isfromsup == "Supervisor"{
            self.getSuperisorOprData()
        }else{
            self.getOprData()
        }
    }
    func getOprData() {
        mJCLogger.log("Starting", Type: "info")
        let  defineQuery = "$filter=(WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and startswith(SystemStatus, 'DLT') ne true)&$orderby=OperationNum"
        WoOperationModel.getOperationList(filterQuery: defineQuery) { (response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.totalOprationArray = responseArr
                        for item in self.totalOprationArray{
                            if self.operationsVC.confirmOperationList.contains(item.OperationNum){
                                item.isCompleted = true
                            }
                        }
                        if DeviceType == iPad{
                            DispatchQueue.main.async {
                                self.operationsVC.totalOperationCount.text = "Total".localized() + ": \(self.totalOprationArray.count)"
                                self.operationsVC.totalCountTableView.reloadData()
                            }
                            if selectedOperationNumber != "" {
                                for i in 0..<self.totalOprationArray.count {
                                    let ope = self.totalOprationArray[i]
                                    let operationNumber = ope.OperationNum
                                    if operationNumber == selectedOperationNumber {
                                        self.operationsVC.didSelectedCell = i
                                        self.singleOperationArray.append(self.totalOprationArray[self.operationsVC.didSelectedCell])
                                        operationTableCountSelectedCell = self.operationsVC.didSelectedCell
                                        singleOperation = self.totalOprationArray[self.operationsVC.didSelectedCell]
                                        singleOperation.isSelected = true
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.operationsVC.operationTableView.reloadData()
                                }
                            }else{
                                if self.totalOprationArray.count > 0 {
                                    self.singleOperationArray.append(self.totalOprationArray[0])
                                    operationTableCountSelectedCell = 0
                                    singleOperation = self.totalOprationArray[0]
                                    singleOperation.isSelected = true
                                    selectedOperationNumber = singleOperation.OperationNum
                                    DispatchQueue.main.async {
                                        self.operationsVC.operationTableView.reloadData()
                                    }
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.singleOperationArray.append(self.totalOprationArray[self.operationsVC.selectedIndexOp])
                                self.operationsVC.operationTableView.reloadData()
                                operationTableCountSelectedCell = self.operationsVC.selectedIndexOp
                                singleOperation = self.totalOprationArray[self.operationsVC.selectedIndexOp]
                            }
                        }
                    }
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getSuperisorOprData() {
        mJCLogger.log("Starting", Type: "info")
        WoOperationModel.getSuperVisorWorkOrderOperationsWithWONum(workOrderNo: selectedworkOrderNumber) { (response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.totalOprationArray = responseArr
                        for item in self.totalOprationArray{
                            if self.operationsVC.confirmOperationList.contains(item.OperationNum){
                                item.isCompleted = true
                            }
                        }
                        if DeviceType == iPad{
                            DispatchQueue.main.async {
                                self.operationsVC.totalOperationCount.text = "Total".localized() + ": \(self.totalOprationArray.count)"
                                self.operationsVC.totalCountTableView.reloadData()
                            }
                            if selectedOperationNumber != "" {
                                for i in 0..<self.totalOprationArray.count {
                                    let ope = self.totalOprationArray[i]
                                    let operationNumber = ope.OperationNum
                                    if operationNumber == selectedOperationNumber {
                                        self.operationsVC.didSelectedCell = i
                                        self.singleOperationArray.append(self.totalOprationArray[self.operationsVC.didSelectedCell])
                                        operationTableCountSelectedCell = self.operationsVC.didSelectedCell
                                        singleOperation = self.totalOprationArray[self.operationsVC.didSelectedCell]
                                        singleOperation.isSelected = true
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.operationsVC.operationTableView.reloadData()
                                }
                            }else {
                                if self.totalOprationArray.count > 0 {
                                    self.singleOperationArray.append(self.totalOprationArray[0])
                                    operationTableCountSelectedCell = 0
                                    singleOperation = self.totalOprationArray[0]
                                    singleOperation.isSelected = true
                                    selectedOperationNumber = singleOperation.OperationNum
                                    DispatchQueue.main.async {
                                        self.operationsVC.operationTableView.reloadData()
                                    }
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.singleOperationArray.append(self.totalOprationArray[self.operationsVC.selectedIndexOp])
                                self.operationsVC.operationTableView.reloadData()
                                operationTableCountSelectedCell = self.operationsVC.selectedIndexOp
                                singleOperation = self.totalOprationArray[self.operationsVC.selectedIndexOp]
                            }
                        }
                    }
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPersonResponsibleList() {
        self.personResponsibleArray.removeAllObjects()
        mJCLogger.log("Response :\(globalPersonRespArray.count)", Type: "Debug")
        if globalPersonRespArray.count > 0 {
            self.personResponsibleArray.addObjects(from: globalPersonRespArray)
        }
    }
    func getWONotificationDetails() {
        mJCLogger.log("Starting", Type: "info")
        if operationsVC.oprWorkOrderDetails.NotificationNum != ""{
            NotificationModel.getWoNotificationDetailsWith(NotifNum: operationsVC.oprWorkOrderDetails.NotificationNum) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        if responseArr.count > 0 {
                            singleNotification = responseArr[0]
                        }else{
                            singleNotification = NotificationModel()
                            mJCLogger.log("Notification data not found", Type: "Debug")
                        }
                    }else {
                        singleNotification = NotificationModel()
                        mJCLogger.log("Notification data not found", Type: "Debug")
                    }
                }else{
                    singleNotification = NotificationModel()
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            singleNotification = NotificationModel()
            mJCLogger.log("Workorder Notification not availble", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getInspectionLot() {
        mJCLogger.log("Starting", Type: "info")
        let inspectionLot = singleWorkOrder.InspectionLot
        if inspectionLot == "000000000000" || inspectionLot == ""{
            mJCAlertHelper.showAlert(self.operationsVC, title: MessageTitle, message: "Inspection_Lot_Not_Available".localized(), button: okay)
            return
        }
        InspectionLotModel.getInspLotDetails(inspLotNum: inspectionLot) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [InspectionLotModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response :\(responseArr[0])", Type: "Debug")
                        let lotDetails = responseArr[0]
                        DispatchQueue.main.async{
                            let lotPopUp = Bundle.main.loadNibNamed("InspectionLotOverview", owner: self.operationsVC, options: nil)?.last as! InspectionLotOverview
                            lotPopUp.inspectionLotLabel.text = lotDetails.InspLot
                            lotPopUp.createdByLabel.text = lotDetails.EnteredBy
                            if lotDetails.CreatedOnDate != nil{
                                lotPopUp.createdOnLabel.text = lotDetails.CreatedOnDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                lotPopUp.createdOnLabel.text = ""
                            }
                            if lotDetails.InspectionStartsOnDate != nil{
                                lotPopUp.inspectionStartLabel.text = lotDetails.InspectionStartsOnDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                lotPopUp.inspectionStartLabel.text = ""
                            }
                            if lotDetails.InspectionEndsOnDate != nil{
                                lotPopUp.inspectionEndLabel.text = lotDetails.InspectionEndsOnDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                lotPopUp.inspectionEndLabel.text = ""
                            }
                            lotPopUp.sampleSizeLabel.text = "\(lotDetails.SampleSize)"
                            lotPopUp.ActualInspQtyLabel.text = "\(lotDetails.SampleQtyActuallyInspected)"
                            lotPopUp.destroyedQtyLabel.text = "\(lotDetails.SampleQtyDestroyed)"
                            lotPopUp.defectiveQtyLabel.text = "\(lotDetails.SampleQtyDefective)"
                            lotPopUp.valuationLabel.text = lotDetails.CodeValuation
                            lotPopUp.systemStatusLabel.text = lotDetails.SyStDscr
                            let windows = UIApplication.shared.windows
                            let lastWindow = windows.last
                            lotPopUp.frame = UIScreen.main.bounds
                            lotPopUp.popUpViewUI()
                            lastWindow?.addSubview(lotPopUp)
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // Operation Conformation
    func updateOperationConformation() {
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)' and OperationNum eq '\(selectedOperationNumber)' and Complete eq 'X')"
        WoOperationModel.getWoConfirmationSet(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let array = response["data"] as? [WoOperationModel]{
                    mJCLogger.log("Response :\(array.count)", Type: "Debug")
                    if array.count > 0{
                        let entity = array[0].entity
                        (entity.properties["ConfText"] as! SODataProperty).value = "Cancelled confirmation" as NSObject
                        WoOperationModel.updateOperationEntity(entity: entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
                            if(error == nil) {
                                DispatchQueue.main.async {
                                    if DeviceType == iPad {
                                        self.operationsVC.operationTableView.reloadData()
                                        self.operationsVC.totalCountTableView.reloadData()
                                    }else{
                                        self.operationsVC.operationTableView.reloadData()
                                    }
                                    mJCAlertHelper.showAlert(self.operationsVC, title: MessageTitle, message: "Opearation_marked_as_incomplete".localized(), button: okay)
                                }
                            }
                        })
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // get Asset Equipment
    func getAssetEquipment(titleText:String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            menuDataModel.uniqueInstance.presentFlocEquipDetialsScreen(vc: self.operationsVC, flocOrEquipObjType: "equip", flocOrEquipObjText: titleText, classificationType: "Workorder")
        }else{
            let equipmentVC = ScreenManager.getFlocEquipDetialsScreen()
            equipmentVC.flocEquipObjType = "equip"
            equipmentVC.flocEquipObjText = titleText
            equipmentVC.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: equipmentVC, menuType: "Equipment")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // Asset Functional Location
    func getAssetFuncLocation(titleText:String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            menuDataModel.uniqueInstance.presentFlocEquipDetialsScreen(vc: self.operationsVC, flocOrEquipObjType: "floc", flocOrEquipObjText: titleText, classificationType: "Workorder")
        }else{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = "floc"
            flocEquipDetails.flocEquipObjText = titleText
            flocEquipDetails.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: flocEquipDetails, menuType: "Equipment")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // CompleteOperation
    func completeOperation(entity:SODataEntityDefault) {
        mJCLogger.log("Starting", Type: "info")
        WoOperationModel.updateOperationEntity(entity: entity,flushRequired: false ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("update Done", Type: "Debug")
                let operationClass = self.totalOprationArray[self.operationsVC.did_DeSelectedCell]
                operationClass.isCompleted = true
                self.postOperationConfirmation(partialConfirmation: false)
                DispatchQueue.main.async {
                    if DeviceType == iPad{
                        self.operationsVC.totalCountTableView.reloadData()
                    }
                    self.operationsVC.operationTableView.reloadData()
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                mJCLogger.log("Confirmation Done".localized(), Type: "Debug")
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self.operationsVC, title: alerttitle, message: "Fail_to_update_operation_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func equipmentAction(equipmentNum:String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad {
           assetmapVC.openmappage(id: equipmentNum)
        }else {
            currentMasterView = "WorkOrder"
            selectedNotificationNumber = ""
            selectedEquipment = equipmentNum
            self.operationsVC.navigateToAssetMap()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func funcLocMapAction(funcLocation:String) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad {
           assetmapVC.openmappage(id: funcLocation)
        }else{
            currentMasterView = "WorkOrder"
            selectedNotificationNumber = ""
            selectedEquipment = funcLocation
            let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
            assetMapDeatilsVC.modalPresentationStyle = .fullScreen
            self.operationsVC.present(assetMapDeatilsVC, animated: true, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func assetFunctionLocationAction(title:String) {
        mJCLogger.log("Starting", Type: "info")
        if title != "" {
            self.getAssetFuncLocation(titleText: title)
        }else{
            mJCLogger.log("Functional_Location_Not_Found".localized(), Type: "Error")
            mJCAlertHelper.showAlert(self.operationsVC, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func assetEquipmentAction(title:String) {
        mJCLogger.log("Starting", Type: "info")
        if title != "" {
            self.getAssetEquipment(titleText:title)
        }else{
            mJCLogger.log("Equipment_Not_Found".localized(), Type: "")
            mJCAlertHelper.showAlert(self.operationsVC, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func operationWOInfoDetails() {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.singleOperationArray.count)", Type: "Debug")
        if self.singleOperationArray.count > 0{
            let operationClass = self.singleOperationArray[0]
            if operationClass.WorkOrderDetailsInfo == true{
                DispatchQueue.main.async{
                    operationClass.WorkOrderDetailsInfo = false
                    self.operationsVC.operationTableView.reloadData()
                    let indexPath  = IndexPath(row: 0, section: 0)
                    if self.operationsVC.operationTableView.isValidIndexPath(indexPath: indexPath){
                        self.operationsVC.operationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }else{
                DispatchQueue.main.async{
                    if self.singleOperationArray.count > 0{
                        let operationClass = self.singleOperationArray[0]
                        operationClass.WorkOrderDetailsInfo = true
                        DispatchQueue.main.async{
                            self.operationsVC.operationTableView.reloadData()
                            let indexPath  = IndexPath(row: 3, section: 0)
                            if self.operationsVC.operationTableView.isValidIndexPath(indexPath: indexPath){
                                self.operationsVC.operationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }else {
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func selectOperationClick(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(self.selectedOperationArray.count)", Type: "Debug")
        if self.selectedOperationArray.count == 0{
            let singleOperationClass = totalOprationArray[self.operationsVC.did_DeSelectedCell]
            singleOperationClass.isSelected = false
            self.operationsVC.did_DeSelectedCell = self.operationsVC.didSelectedCell
            let filteredArray = self.totalOprationArray.filter{$0.isSelected == true}
            for oprItem in filteredArray {
                oprItem.isSelected = false
            }
            let singleOperationClass1 = totalOprationArray[btn.tag]
            singleOperation = singleOperationClass1
            singleOperationClass1.isSelected = true
            selectedOperationNumber = singleOperationClass1.OperationNum
            self.operationsVC.didSelectedCell = btn.tag
            self.operationsVC.did_DeSelectedCell = self.operationsVC.didSelectedCell
            self.singleOperationArray.removeAll()
            self.singleOperationArray.append(self.totalOprationArray[btn.tag])
            DispatchQueue.main.async{
                self.operationsVC.totalCountTableView.reloadData()
                self.operationsVC.operationTableView.reloadData()
            }
        }else{
            let indexPath = IndexPath(row: btn.tag, section: 0)
            let cell = self.operationsVC.totalCountTableView.cellForRow(at: indexPath) as! TotalOperationCountCell
            let singleoperationCls = self.totalOprationArray[btn.tag]
            if cell.selectCheckBoxButton.isSelected == false{
                cell.selectCheckBoxButton.isSelected = true
                if !self.selectedOperationArray.contains(singleoperationCls){
                    let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
                    if singleoperationCls.OperationNum.contains(find: "L") {
                        mJCAlertHelper.showAlert(self.operationsVC, title: alerttitle, message: "This_is_local_operation_You_can't_Complete_this_operation".localized(), button: okay)
                        return
                    }else if singleoperationCls.SystemStatus.contains(mobStatusCode){
                        mJCAlertHelper.showAlert(self.operationsVC, title: alerttitle, message: "This_Operation_is_already_completed".localized(), button: okay)
                        return
                    }else{
                        self.selectedOperationArray.append(singleoperationCls)
                        singleoperationCls.isSelected = true
                    }
                }
            }else{
                cell.selectCheckBoxButton.isSelected = false
                if self.selectedOperationArray.contains(singleoperationCls){
                    if let index = self.selectedOperationArray.firstIndex(of: singleoperationCls){
                        selectedOperationArray.remove(at: index)
                        singleoperationCls.isSelected = false
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func operationSelectionClick(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let indexPath = IndexPath(row: btn.tag, section: 0)
        let cell = self.operationsVC.totalCountTableView.cellForRow(at: indexPath) as! TotalOperationCountCell
        let singleoperationCls = self.totalOprationArray[btn.tag]
        if cell.selectCheckBoxButton.isSelected == false{
            cell.selectCheckBoxButton.isSelected = true
            if !self.selectedOperationArray.contains(singleoperationCls){
                let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
                if singleoperationCls.OperationNum.contains(find: "L") {
                    cell.selectCheckBoxButton.isSelected = false
                    mJCAlertHelper.showAlert(self.operationsVC, title: alerttitle, message: "This_is_local_operation_You_can't_Complete_this_operation".localized(), button: okay)
                    return
                }else if singleoperationCls.SystemStatus.contains(mobStatusCode){
                    cell.selectCheckBoxButton.isSelected = false
                    mJCAlertHelper.showAlert(self.operationsVC, title: alerttitle, message: "This_Operation_is_already_completed".localized(), button: okay)
                    return
                }else{
                    cell.selectCheckBoxButton.isSelected = true
                    self.selectedOperationArray.append(singleoperationCls)
                }
            }
            mJCLogger.log("\(self.selectedOperationArray)", Type: "Debug")
        }else{
            cell.selectCheckBoxButton.isSelected = false
            if self.selectedOperationArray.contains(singleoperationCls){
                if let index  = self.selectedOperationArray.firstIndex(of: singleoperationCls){
                    self.selectedOperationArray.remove(at: index)
                }
            }
        }
        mJCLogger.log("\(self.selectedOperationArray)", Type: "Debug")
        DispatchQueue.main.async{
            self.operationsVC.totalCountTableView.reloadData()
            self.operationsVC.operationTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // Postings
    func completeBulkOperationMethod(count:Int){
        mJCLogger.log("Starting", Type: "info")
        let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
        let singleOperationClass = self.selectedOperationArray[count]
        (singleOperationClass.entity.properties["SystemStatus"] as! SODataProperty).value = mobStatusCode as NSObject
        WoOperationModel.updateOperationEntity(entity: singleOperationClass.entity,flushRequired: false ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("update Done", Type: "Debug")
                singleOperationClass.isCompleted = true
                mJCLogger.log("\(singleOperationClass.OperationNum) Confirmed", Type: "Debug")
                self.postOperationConfirmation(singleOperationClass: singleOperationClass, Count: count)
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self.operationsVC, title: alerttitle, message: "Fail_to_update_operation_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func postOperationConfirmation(singleOperationClass: WoOperationModel,Count:Int) {
        mJCLogger.log("Starting", Type: "info")
        let singleOperationClass = singleOperationClass
        
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfCounter")
        let count = self.operationsVC.confirmOperationList.count+1
        let confCounter = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 8, Num: "\(count)")
        prop!.value = confCounter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = singleOperationClass.OperationNum as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOper")
        prop!.value = singleOperationClass.SubOperation as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Split")
        prop!.value = 0 as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PostgDate")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedDate")
        prop!.value = NSDate()
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        let basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = singleOperationClass.Plant as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkCntr")
        prop!.value = singleOperationClass.WorkCenter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FinConf")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Complete")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfText")
        prop!.value = OPERATION_COMPLETE_TEXT as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
        
        for prop in property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        var flushReq = Bool()
        if self.selectedOperationArray.count == Count + 1
        {
            flushReq = true
        }else{
            flushReq = false
        }
        WoOperationModel.createWoConfirmationEntity(entity: entity!, collectionPath: woConfirmationSet, flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
            
            if(error == nil) {
                
                mJCLogger.log("Create Done", Type: "Debug")
                mJCLogger.log("\(singleOperationClass.OperationNum) Confirmation Posted".localized(), Type: "Debug")
                singleOperationClass.isCompleted = true
                self.operationsVC.confirmOperationList.append(singleOperationClass.OperationNum)
                if self.selectedOperationArray.count == Count + 1 {
                    self.getConfirmationOpeartionSet(isfromsup: self.isfromsup)
                    self.selectedOperationArray.removeAll()
                    self.singleOperationArray.removeAll()
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Operations_Completed_Sucessfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self.operationsVC, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            self.singleOperationArray.append(self.totalOprationArray[self.operationsVC.selectedIndexOp])
                            isOperationDone = true
                            self.operationsVC.selectAllOperationCheckBox.isSelected = false
                            DispatchQueue.main.async {
                                self.operationsVC.operationTableView.reloadData()
                            }
                        default: break
                        }
                    }
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                }else{
                    self.completeBulkOperationMethod(count:Count + 1)
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Complete Operation Method..
    func postOperationConfirmation(partialConfirmation:Bool) {
        mJCLogger.log("Starting", Type: "info")
        if self.singleOperationArray.count > 0 {
            let singleOperationClass = self.singleOperationArray[0]
            let property = NSMutableArray()
            
            var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
            prop!.value = "" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ConfCounter")
            
            let count = self.operationsVC.confirmOperationList.count+1
            let confCounter = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 8, Num: "\(count)")
            
            prop!.value = confCounter as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkOrderNum")
            prop!.value = selectedworkOrderNumber as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "OperationNum")
            prop!.value = singleOperation.OperationNum as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "SubOper")
            prop!.value = singleOperation.SubOperation as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Split")
            prop!.value = 0 as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "PostgDate")
            prop!.value = Date().localDate() as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ExCreatedDate")
            prop!.value = NSDate()
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ExCreatedTime")
            let basicTime = SODataDuration()
            let time = Date().toString(format: .custom("HH:mm"))
            let basicTimeArray = time.components(separatedBy:":")
            basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
            basicTime.seconds = 0
            prop!.value = basicTime
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "Plant")
            prop!.value = singleOperationClass.Plant as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "WorkCntr")
            prop!.value = singleOperationClass.WorkCenter as NSObject
            property.add(prop!)
            
            if partialConfirmation == true{

                prop = SODataPropertyDefault(name: "FinConf")
                prop!.value = "" as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "Complete")
                prop!.value = "" as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "ConfText")
                prop!.value = "" as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "ActWork")
                prop!.value = 0 as NSDecimalNumber
                property.add(prop!)
            }else{
                prop = SODataPropertyDefault(name: "FinConf")
                prop!.value = STATUS_SET_FLAG as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "Complete")
                prop!.value = STATUS_SET_FLAG as NSObject
                property.add(prop!)

                prop = SODataPropertyDefault(name: "ConfText")
                prop!.value = OPERATION_COMPLETE_TEXT as NSObject
                property.add(prop!)
                
            }
            prop = SODataPropertyDefault(name: "PersNo")
            prop!.value = userPersonnelNo as NSObject
            property.add(prop!)
            
            let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
            for prop in property {
                
                let proper = prop as! SODataProperty
                entity?.properties[proper.name as Any] = proper
                print("Key : \(proper.name ?? "")")
                print("Value :\(proper.value!)")
                print("...............")
            }
            WoOperationModel.createWoConfirmationEntity(entity: entity!, collectionPath: woConfirmationSet,flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Confirmation Done", Type: "Debug")
                    let operationClass = self.totalOprationArray[self.operationsVC.did_DeSelectedCell]
                    operationClass.isCompleted = true
                    singleOperationClass.isCompleted = true
                    singleOperationClass.SystemStatus = operationClass.SystemStatus
                    self.getConfirmationOpeartionSet(isfromsup:self.isfromsup)
                    DispatchQueue.main.async{
                        if DeviceType == iPad{
                            self.operationsVC.totalCountTableView.reloadData()
                        }else{
                            self.operationsVC.operationTableView.reloadData()
                        }
                    }
                    if DeviceType == iPad{
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                    }else{
                        self.operationsVC.dismiss(animated: false, completion: nil)
                    }
                }else {
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

