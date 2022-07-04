//
//  dBStyle2ViewModel.swift
//  myJobCard
//
//  Created by Suri on 16/08/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class dBStyle2ViewModel {
    
    var dBVc: DashboardStyle2?
    
    var confirmOperationList = Array<String>()
    var operationArr = Array<WoOperationModel>()
    var woAttachmentArr = Array<AttachmentModel>()
    var woUploadAttachmentArr = Array<UploadedAttachmentsModel>()
    var componentArr = Array<WoComponentModel>()
    var formsAssignArray = Array<FormAssignDataModel>()
    var mendatoryFormCount = Int()
    var formsResponseArr = Array<FormResponseCaptureModel>()
    var noUploadAttachmentArr = Array<UploadedAttachmentsModel>()
    var noAttachmentArr = Array<AttachmentModel>()
    var finalpoints = Array<MeasurementPointModel>()
    var currentpoints = Array<MeasurementPointModel>()
    var noCompIdArr = [String]()
    
    var priorityListArray = NSMutableArray()
    var workCentersListArray = [String]()
    var techniciansListArray = [String]()
    var techniciansArray = [PersonResponseModel]()
    var statusListArray = [String]()
    var userStatusListArr = Array<String>()
    var locationListArray = [String]()
    var systemStatusListArray = [String]()
    var planningPlantListArray = [String]()
    var plannerGroupListArray = [String]()
    var maintainacePlantListArray = [String]()
    var techIDListArray = [String]()
    var orderTypeListArray = [String]()
    var notificationTypeListArray = [String]()
    var mainActivityTypeArray = [String]()
    var controlkeyListArray = [String]()
    var funcLocListArr = Array<String>()
    var equipListArr = [String]()
    var equipmentArr = [EquipmentModel]()
    
    func setFilterData(){

        DispatchQueue.main.async{
            if UserDefaults.standard.value(forKey: "DashFilter") != nil{
                let dict = UserDefaults.standard.value(forKey: "DashFilter")
                self.dBVc!.FilterDict = dict as! [String: String]
                if let header = self.dBVc!.FilterDict["Header"]{
                    if header == "WorkOrder"{
                        currentMasterView = "WorkOrder"
                        self.dBVc!.filterTypeTextField.text = "Work_Order".localized()
                        self.dBVc!.listButton.setImage(UIImage(named: "wo"), for: .normal)
                        self.dBVc!.workOrderFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
                        self.dBVc!.notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
                        self.dBVc!.FirstDropDownArr = WoFilterArray
                        self.dBVc!.TotalLabel.text = "Total_Workorders".localized()+": \(allworkorderArray.count)"
                        let arr = self.dBVc!.FirstDropDownArr
                        self.dBVc!.SecondDropDownArr = arr
                        self.dBVc!.workOrderFilterButton.backgroundColor = dbfilterBgColor
                        self.dBVc!.notificationFilterButton.backgroundColor = UIColor.clear
                        if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                            self.dBVc!.addButton.isHidden = false
                        }else{
                            self.dBVc!.addButton.isHidden = true
                        }
                    }else if header == "Notification"{
                        currentMasterView = "Notification"
                        self.dBVc!.filterTypeTextField.text = "Notification".localized()
                        self.dBVc!.listButton.setImage(UIImage(named: "notifi"), for: .normal)
                        self.dBVc!.workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
                        self.dBVc!.notificationFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
                        self.dBVc!.FirstDropDownArr = NoFilterArray
                        let arr = self.dBVc!.FirstDropDownArr
                        self.dBVc!.SecondDropDownArr = arr
                        if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                            self.dBVc!.addButton.isHidden = false
                        }else{
                            self.dBVc!.addButton.isHidden = true
                        }
                        self.dBVc!.workOrderFilterButton.backgroundColor = UIColor.clear
                        self.dBVc!.notificationFilterButton.backgroundColor = dbfilterBgColor
                    }
                    if let first = self.dBVc!.FilterDict["First"]{
                        self.dBVc!.firstDropDownTxtField.text = "\(first)"
                        if let str = self.dBVc!.FilterDict["Third"]{
                            self.dBVc!.thirdDropDownTxtField.text = "\(str)"
                            let index = self.dBVc!.SecondDropDownArr.firstIndex(of: first)
                            if index != nil{
                                self.dBVc!.SecondDropDownArr.remove(at: index!)
                            }
                        }
                    }else{
                        self.dBVc!.firstDropDownTxtField.text = self.dBVc!.FirstDropDownArr[0]
                        self.dBVc!.thirdDropDownTxtField.text = selectStr
                    }
                    if let second = self.dBVc!.FilterDict["Second"]{
                        self.dBVc!.secondDropDownTxtField.text = "\(second)"
                        if let str = self.dBVc!.FilterDict["Fourth"]{
                            self.dBVc!.fourthDropDownTxtField.text = "\(str)"
                            let index = self.dBVc!.FirstDropDownArr.firstIndex(of: second)
                            if index != nil{
                                self.dBVc!.FirstDropDownArr.remove(at: index!)
                            }
                        }
                    }else{
                        self.dBVc!.secondDropDownTxtField.text = self.dBVc!.SecondDropDownArr[0]
                        self.dBVc!.fourthDropDownTxtField.text = selectStr
                    }
                    self.dBVc!.finalFiltervalues.removeAll()
                    self.dBVc!.ApplyDashBoardFilter()
                }else{
                    self.dBVc!.finalFiltervalues.removeAll()
                    self.dBVc!.ApplyDashBoardFilter()
                }
            }else{
                if self.dBVc!.FirstDropDownArr.count > 0{
                    self.dBVc!.firstDropDownTxtField.text = Filters.Priority.value
                    var arr = self.dBVc!.FirstDropDownArr
                    if let index = arr.firstIndex(of: Filters.Priority.value){
                        arr.remove(at: index)
                    }
                    self.dBVc!.SecondDropDownArr = arr
                    //Second dropdown
                    if self.dBVc!.SecondDropDownArr.count > 0{
                        self.dBVc!.secondDropDownTxtField.optionArray = self.dBVc!.SecondDropDownArr
                        self.dBVc!.secondDropDownTxtField.checkMarkEnabled = false
                    }
                    self.dBVc!.FilterDict["First"] = Filters.Priority.value
                    self.dBVc!.secondDropDownTxtField.text = selectStr
                    self.dBVc!.fourthDropDownTxtField.text = selectStr
                    self.setPriority(fromInit: true)
                    self.dBVc!.finalFiltervalues.removeAll()
                    self.dBVc!.ApplyDashBoardFilter()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setMaintActivityType(){
        mJCLogger.log("Starting", Type: "info")
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                self.mainActivityTypeArray.removeAll()
                self.mainActivityTypeArray = allworkorderArray.uniqueValues{$0.MaintActivityTypeText}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setControlKey(){
        mJCLogger.log("Starting", Type: "info")
        self.controlkeyListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "Operation"{
                let controlKeyArr = allOperationsArray.unique{$0.ControlKey }
                for opr in controlKeyArr{
                    if opr.ControlKey != ""{
                        self.controlkeyListArray.append(opr.ControlKey)
                    }
                }
            }
        }
    }
    func setPriority(fromInit:Bool){
        mJCLogger.log("Starting", Type: "info")
        self.priorityListArray.removeAllObjects()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let priortyArr = allworkorderArray.unique{$0.Priority}.sorted{$0.Priority.compare($1.Priority) == .orderedAscending }
                for pr in priortyArr{
                    if pr.Priority == ""{
                        self.priorityListArray.add(Filters.NoPriority.value)
                    }else{
                        let prclsArr = globalPriorityArray.filter{$0.Priority == pr.Priority}
                        if prclsArr.count > 0{
                            let prcls = prclsArr[0]
                            self.priorityListArray.add(prcls.PriorityText)
                        }
                    }
                }
            }else if header == "Operation"{
                let priortyArr = allOperationsArray.unique{$0.WoPriority}.sorted{$0.WoPriority.compare($1.WoPriority) == .orderedAscending }
                for pr in priortyArr{
                    if pr.WoPriority == ""{                            self.priorityListArray.add(Filters.NoPriority.value)
                    }else{
                        let prclsArr = globalPriorityArray.filter{$0.Priority == pr.WoPriority}
                        if prclsArr.count > 0{
                            let prcls = prclsArr[0]
                            self.priorityListArray.add(prcls.PriorityText)
                        }
                    }
                }
            }else if header == "Notification"{
                let priortyArr = allNotficationArray.unique{$0.Priority }
                for pr in priortyArr{
                    if pr.Priority == ""{
                        self.priorityListArray.add(Filters.NoPriority.value)
                    }else{
                        let prclsArr = globalPriorityArray.filter{$0.Priority == pr.Priority}
                        if prclsArr.count > 0{
                            let prcls = prclsArr[0]
                            self.priorityListArray.add(prcls.PriorityText)
                        }
                    }
                }
            }
        }
        if  self.dBVc!.FilterDict["First"] == Filters.Priority.value{
            if fromInit == true {
                var str = String()
                for item in self.priorityListArray{
                    if (item as! String) != selectStr{
                        str =  (item as! String) + ";" + str
                    }
                }
                self.dBVc!.FilterDict["Third"] = str
                self.dBVc!.thirdDropDownTxtField.text = str
            }
            self.setStatusList(fromInit: fromInit)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setStatusList(fromInit:Bool) {
        mJCLogger.log("Starting", Type: "info")
        self.statusListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let StatusArr = allworkorderArray.unique{$0.MobileObjStatus}
                for status in StatusArr{
                    if status.MobileObjStatus != ""{
                        self.statusListArray.append(status.MobileObjStatus)
                    }
                }
            }else if header == "Operation"{
                let statusArr = allOperationsArray.unique{$0.MobileStatus}
                for status in statusArr{
                    if status.MobileStatus != ""{
                        self.statusListArray.append(status.MobileStatus)
                    }
                }
            }else if header == "Notification"{
                let statusArr = allNotficationArray.unique{$0.MobileStatus}
                for status in statusArr{
                    if status.MobileStatus != ""{
                        self.statusListArray.append(status.MobileStatus)
                    }
                }
            }
        }
        if self.dBVc!.FilterDict["Second"] == Filters.Status.value{
            if fromInit == true{
                var str = String()
                for item in self.statusListArray{
                    if item != selectStr{
                        str =  item  + ";" + str
                    }
                }
                self.dBVc!.FilterDict["Fourth"] = str
                self.dBVc!.fourthDropDownTxtField.text = str
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkCentersList() {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let workCenterArr = allworkorderArray.unique{$0.MainWorkCtr}.sorted{$0.MainWorkCtr.compare($1.MainWorkCtr) == .orderedAscending }
                for wrkcenter in workCenterArr{
                    if wrkcenter.MainWorkCtr != ""{
                        let wrkcenterClsArr = globalWorkCtrArray.filter{$0.WorkCenter == wrkcenter.MainWorkCtr}
                        if wrkcenterClsArr.count > 0 {
                            let wrkcls = wrkcenterClsArr[0]
                            self.workCentersListArray.append("\(wrkcls.WorkCenter)")
                        }
                    }
                }
            }else if header == "Operation"{
                let workCtrArr = allOperationsArray.unique{$0.WorkCenter}.sorted{$0.WorkCenter.compare($1.WorkCenter) == .orderedAscending }
                for wrkctr in workCtrArr{
                    if wrkctr.WorkCenter != ""{
                        let wrkctrClsArr = globalWorkCtrArray.filter{$0.WorkCenter == wrkctr.WorkCenter}
                        if wrkctrClsArr.count > 0 {
                            let wrkcls = wrkctrClsArr[0]
                            self.workCentersListArray.append("\(wrkcls.WorkCenter)")
                        }
                    }
                }
            }else if header == "Notification"{
                let wrkctrArray = allNotficationArray.unique{$0.WorkCenter}.sorted{$0.WorkCenter.compare($1.WorkCenter) == .orderedAscending }
                for wrkctr in wrkctrArray {
                    if wrkctr.WorkCenter != ""{
                        let wrkctrclsArray = globalWorkCtrArray.filter{$0.ObjectID == wrkctr.WorkCenter}
                        if wrkctrclsArray.count == 1 {
                            let wrkcls = wrkctrclsArray[0]
                            self.workCentersListArray.append("\(wrkcls.WorkCenter)")
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    func setUserStatusList() {
        mJCLogger.log("Starting", Type: "info")
        self.userStatusListArr.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let UserStatusArr = allworkorderArray.unique{$0.UserStatus }
                for pr in UserStatusArr{
                    if pr.UserStatus != ""{
                        self.userStatusListArr.append(pr.UserStatus)
                    }
                }
            }else if header == "Operation"{
                let UserStatusArr = allOperationsArray.unique{$0.UserStatus }
                for pr in UserStatusArr{
                    if pr.UserStatus != ""{
                        self.userStatusListArr.append(pr.UserStatus)
                    }
                }
            }else if header == "Notification"{
                let UserStatusArr = allNotficationArray.unique{$0.UserStatus }
                for pr in UserStatusArr{
                    if pr.UserStatus != ""{
                        self.userStatusListArr.append(pr.UserStatus)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setLocationList() {
        mJCLogger.log("Starting", Type: "info")
        self.locationListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let StatusArr = allworkorderArray.unique{$0.Location}
                for status in StatusArr{
                    if status.Location != ""{
                        self.locationListArray.append(status.Location)
                    }
                }
            }else if header == "Operation"{
                let statusArr = allOperationsArray.unique{$0.Location}
                for status in statusArr{
                    if status.Location != ""{
                        self.locationListArray.append(status.Location)
                    }
                }
            }else if header == "Notification"{
                let statusArr = allNotficationArray.unique{$0.Location}
                for status in statusArr{
                    if status.Location != ""{
                        self.locationListArray.append(status.Location)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func setSystemStatusList() {
        mJCLogger.log("Starting", Type: "info")
        self.systemStatusListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let statusArr = allworkorderArray.unique{$0.SysStatus}
                for status in statusArr{
                    if status.SysStatus != ""{
                        self.systemStatusListArray.append(status.SysStatus)
                    }
                }
            }else if header == "Operation"{
                let statusArr = allOperationsArray.unique{$0.SystemStatus}
                for status in statusArr{
                    if status.SystemStatus != ""{
                        self.systemStatusListArray.append(status.SystemStatus)
                    }
                }
            }else if header == "Notification"{
                let statusArr = allNotficationArray.unique{$0.SystemStatus}
                for status in statusArr{
                    if status.SystemStatus != ""{
                        self.systemStatusListArray.append(status.SystemStatus)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setPlanningPlantList() {
        mJCLogger.log("Starting", Type: "info")
        self.planningPlantListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let planningPlantArr = allworkorderArray.unique{$0.MaintPlanningPlant}
                for pr in planningPlantArr{
                    if pr.MaintPlanningPlant != ""{
                        self.planningPlantListArray.append(pr.MaintPlanningPlant)
                    }
                }
            }else if header == "Operation"{
                let planningPlantArr = allOperationsArray.unique{$0.PlanningPlant}
                for pr in planningPlantArr{
                    if pr.PlanningPlant != ""{
                        self.planningPlantListArray.append(pr.PlanningPlant)
                    }
                }
            }else if header == "Notification"{
                let planningPlantArr = allNotficationArray.unique{$0.PlanningPlant}
                for pr in planningPlantArr{
                    if pr.PlanningPlant != ""{
                        self.planningPlantListArray.append(pr.PlanningPlant)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func setPlannerGroupList() {
        
        mJCLogger.log("Starting", Type: "info")
        self.plannerGroupListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let plannerGrpArr = allworkorderArray.unique{$0.ResponsiblPlannerGrp}
                for pr in plannerGrpArr{
                    if pr.ResponsiblPlannerGrp != ""{
                        self.plannerGroupListArray.append(pr.ResponsiblPlannerGrp)
                    }
                }
            }else if header == "Operation"{
                let plannerGrpArr = allOperationsArray.unique{$0.PlannerGroup}
                for pr in plannerGrpArr{
                    if pr.PlannerGroup != ""{
                        self.plannerGroupListArray.append(pr.PlannerGroup)
                    }
                }
            }else if header == "Notification"{
                let plannerGrpArr = allNotficationArray.unique{$0.PlannerGroup}
                for pr in plannerGrpArr{
                    if pr.PlannerGroup != ""{
                        self.plannerGroupListArray.append(pr.PlannerGroup)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setMaintainancePlantList() {
        
        mJCLogger.log("Starting", Type: "info")
        self.maintainacePlantListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let maintPlantArr = allworkorderArray.unique{$0.MaintPlant}
                for pr in maintPlantArr{
                    if pr.MaintPlant != ""{
                        self.maintainacePlantListArray.append(pr.MaintPlant)
                    }
                }
            }else if header == "Operation"{
                let maintPlantArr = allOperationsArray.unique{$0.MaintPlanningPlant}
                for pr in maintPlantArr{
                    if pr.MaintPlanningPlant != ""{
                        self.maintainacePlantListArray.append(pr.MaintPlanningPlant)
                    }
                }
            }else if header == "Notification"{
                let maintPlantArr = allNotficationArray.unique{$0.MaintPlant}
                for pr in maintPlantArr{
                    if pr.MaintPlant != ""{
                        self.maintainacePlantListArray.append(pr.MaintPlant)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setTechIDList() {
        mJCLogger.log("Starting", Type: "info")
        self.techIDListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let techIdArr = allworkorderArray.unique{$0.TechID}
                for id in techIdArr{
                    if id.TechID != ""{
                        self.techIDListArray.append(id.TechID)
                    }
                }
            }else if header == "Operation"{
                let techIdArr = allOperationsArray.unique{$0.TechID}
                for id in techIdArr{
                    if id.TechID != ""{
                        self.techIDListArray.append(id.TechID)
                    }
                }
            }else if header == "Notification"{
                let techIdArr = allNotficationArray.unique{$0.TechID}
                for id in techIdArr {
                    if id.TechID != ""{
                        self.techIDListArray.append(id.TechID)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setOrderTypeList() {
        mJCLogger.log("Starting", Type: "info")
        self.orderTypeListArray.removeAll()
        
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let orderTypeArr = allworkorderArray.unique{$0.OrderType}
                for status in orderTypeArr {
                    if status.OrderType != ""{
                        self.orderTypeListArray.append(status.OrderType)
                    }
                }
            }else if header == "Operation"{
                let orderTypeArr = allOperationsArray.unique{$0.OrderType}
                for status in orderTypeArr{
                    if status.OrderType != ""{
                        self.orderTypeListArray.append(status.OrderType)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setFunctionalLocationList(){
        mJCLogger.log("Starting", Type: "info")
        self.funcLocListArr.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let flocArr = allworkorderArray.uniqueValues{$0.FuncLocation}
                for floc in flocArr {
                    if floc != ""{
                        self.funcLocListArr.append(floc)
                    }
                }
            }else if header == "Operation"{
                let flocArr = allOperationsArray.uniqueValues{$0.FuncLoc}
                for floc in flocArr {
                    if floc != ""{
                        self.funcLocListArr.append(floc)
                    }
                }
            }else if header == "Notification"{
                let flocArr = allNotficationArray.uniqueValues{$0.FunctionalLoc}
                for floc in flocArr {
                    if floc != ""{
                        self.funcLocListArr.append(floc)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getEquipmentList(from: String){
        mJCLogger.log("Starting", Type: "info")
        self.equipListArr.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "WorkOrder"{
                let equipArr = allworkorderArray.uniqueValues{$0.EquipNum}
                for equip in equipArr {
                    if equip != ""{
                        self.equipListArr.append(equip)
                    }
                }
            }else if header == "Operation"{
                let equipArr = allOperationsArray.uniqueValues{$0.Equipment}
                for equip in equipArr {
                    if equip != ""{
                        self.equipListArr.append(equip)
                    }
                }
            }else if header == "Notification"{
                let equipArr = allNotficationArray.uniqueValues{$0.Equipment}
                for equip in equipArr {
                    if equip != ""{
                        self.equipListArr.append(equip)
                    }
                }
            }
            if from == "TechID"{
                mJCLoader.startAnimating(status: "Please_Wait".localized())
                self.getTechIdValues()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getTechIdValues(){
        let define = "$filter=\(myAssetDataManager.getEquipmentQuery(equipArr: self.equipListArr))"
        self.equipmentArr.removeAll()
        EquipmentModel.getEquipmentList(filterQuery: define){(response,error) in
            if error == nil{
                if let respArr = response["data"] as? [EquipmentModel]{
                    self.equipmentArr = respArr
                    var techIdArr = [String]()
                    for item in respArr{
                        if item.TechIdentNo != "" {
                            techIdArr.append(item.TechIdentNo)
                        }
                    }
                    mJCLoader.stopAnimating()
                    self.techIDListArray = techIdArr
                }else{
                    mJCLoader.stopAnimating()
                }
            }
        }
    }
    func setNotificationTypeList() {
        mJCLogger.log("Starting", Type: "info")
        self.notificationTypeListArray.removeAll()
        if let header = self.dBVc!.FilterDict["Header"]{
            if header == "Notification"{
                let NotifTypeArr = allNotficationArray.unique{$0.NotificationType}
                for status in NotifTypeArr{
                    if status.NotificationType != ""{
                        self.notificationTypeListArray.append(status.NotificationType)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setTechniciansList() {
        
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            var perNoArr = [String]()
            let perArray = allworkorderArray.unique{$0.PersonResponsible}.sorted{$0.PersonResponsible.compare($1.PersonResponsible) == .orderedAscending }
            for perNo in perArray{
                if perNo.PersonResponsible == "" || perNo.PersonResponsible == "00000000"{
                    self.techniciansListArray.append(Filters.Unassignged.value)
                }else{
                    perNoArr.append(perNo.PersonResponsible)
                }
            }
            let predicate5 = NSPredicate(format: "PersonnelNo IN %@", perNoArr as [AnyObject])
            techniciansArray = globalPersonRespArray.filter{predicate5.evaluate(with: $0)}
            if techniciansArray.count > 0{
                for item in techniciansArray{
                    self.techniciansListArray.append(item.EmplApplName)
                }
            }
        }else{
            var perNoArr = [String]()
            let perArray = allOperationsArray.unique{$0.PersonnelNo}.sorted{$0.PersonnelNo.compare($1.PersonnelNo) == .orderedAscending }
            for perNo in perArray{
                if perNo.PersonnelNo == "" || perNo.PersonnelNo == "00000000"{
                    self.techniciansListArray.append(Filters.Unassignged.value)
                }else{
                    perNoArr.append(perNo.PersonnelNo)
                }
            }
            let predicate5 = NSPredicate(format: "PersonnelNo IN %@", perNoArr as [AnyObject])
            techniciansArray = globalPersonRespArray.filter{predicate5.evaluate(with: $0)}
            if techniciansArray.count > 0{
                for item in techniciansArray{
                    self.techniciansListArray.append(item.EmplApplName)
                }
            }
        }
    }
    func createBatchRequestForTransactionCount(ObjectClass: AnyObject){
        mJCLogger.log("Starting", Type: "info")

        if let workorder = ObjectClass as? WoHeaderModel {
            
            let ConfOpr = "\(woConfirmationSet)?$filter=(WorkOrderNum eq '\(workorder.WorkOrderNum)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
            let incompleteOpr = DefineRequestModelClass.uniqueInstance.getOperationsDefineRequest(type: "List", workorderNum: workorder.WorkOrderNum, oprNum: "", from: "") as String
            let  inCompleteComponent = DefineRequestModelClass.uniqueInstance.getComponentsDefineRequest(type: "GetComponentCount", workorderNum: workorder.WorkOrderNum, componentNum: "", operationNum: "", from: "") as String
            let attachemts = "\(woAttachmentSet)?$filter=(endswith(ObjectKey, '" + workorder.WorkOrderNum + "') eq true)"
            let uploadAttachments = "\(uploadWOAttachmentContentSet)?$select=WorkOrderNum,DocID,FILE_NAME,BINARY_FLG&$filter=(WorkOrderNum%20eq%20%27" + (workorder.WorkOrderNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
            
            let currentReadings = measurementPointReadingSet

            let batchArr = NSMutableArray()
            
            batchArr.add(ConfOpr)
            batchArr.add(incompleteOpr)
            batchArr.add(inCompleteComponent)
            batchArr.add(attachemts)
            batchArr.add(uploadAttachments)
            batchArr.add(currentReadings)
            
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
                            if resourcePath == woConfirmationSet {
                                self.confirmOperationList.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getConfirmationOpeartionlist(dictionary: dictval)
                                self.confirmOperationList = dict["data"] as! [String]
                            }else if resourcePath == woOperationSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                self.operationArr.removeAll()
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoOperationModel.self)
                                if  let oprarray = dict["data"] as? [WoOperationModel]{
                                    if oprarray.count > 0{
                                        mJCLogger.log("Response:\(oprarray.count)", Type: "Debug")
                                        self.operationArr = oprarray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == woComponentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoComponentModel.self)
                                self.componentArr.removeAll()
                                if  let comparray = dict["data"] as? [WoComponentModel]{
                                    if(comparray.count > 0) {
                                        mJCLogger.log("Response:\(comparray.count)", Type: "Debug")
                                        self.componentArr = comparray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        cmpCount = ""
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == uploadWOAttachmentContentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                                self.woUploadAttachmentArr.removeAll()
                                if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                    if(uploadattacharray.count > 0) {
                                        mJCLogger.log("Response:\(uploadattacharray.count)", Type: "Debug")
                                        self.woUploadAttachmentArr = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == ""}
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == woAttachmentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                                self.woAttachmentArr.removeAll()
                                if  let Woattacharray = dict["data"] as? [AttachmentModel]{
                                    if(Woattacharray.count > 0) {
                                        mJCLogger.log("Response:\(Woattacharray.count)", Type: "Debug")
                                        self.woAttachmentArr = Woattacharray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == measurementPointReadingSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: MeasurementPointModel.self)
                                self.finalpoints.removeAll()
                                self.currentpoints.removeAll()
                                if  let pointArray = dict["data"] as? [MeasurementPointModel]{
                                    if(pointArray.count > 0) {
                                        mJCLogger.log("Response:\(pointArray.count)", Type: "Debug")
                                        self.currentpoints = pointArray.filter{$0.WOObjectNum == workorder.ObjectNumber}
                                        var equipPoints = [MeasurementPointModel]()
                                        var flocPoints = [MeasurementPointModel]()
                                        if workorder.EquipNum != ""{
                                            equipPoints = pointArray.filter({$0.Equipment == "\(workorder.EquipNum)" && $0.WOObjectNum == "" && $0.OpObjectNumber == ""})
                                        }
                                        if workorder.FuncLocation != ""{
                                            flocPoints = pointArray.filter({$0.FunctionalLocation == "\(workorder.FuncLocation)" && $0.WOObjectNum == "" && $0.OpObjectNumber == ""})
                                        }
                                        self.finalpoints.append(contentsOf: equipPoints)
                                        self.finalpoints.append(contentsOf: flocPoints)
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        self.createBatchRequestForFormsCount(ObjectClass: ObjectClass)
                    }
                }else{
                    if error?.code == 10{
                        mJCLogger.log("Store open Failed", Type: "Debug")
                    }else if error?.code == 1227{
                        mJCLogger.log("Entity set not found", Type: "Debug")
                    }else{
                        mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
        }else if let operation = ObjectClass as? WoOperationModel {
            let  inCompleteComponent = DefineRequestModelClass.uniqueInstance.getComponentsDefineRequest(type: "GetComponentCount", workorderNum: operation.WorkOrderNum, componentNum: "", operationNum: "", from: "") as String
            let attachemts = "\(woAttachmentSet)?$filter=(endswith(ObjectKey, '" + operation.WorkOrderNum + "') eq true)"
            let uploadAttachments = "\(uploadWOAttachmentContentSet)?$select=WorkOrderNum,DocID,FILE_NAME,BINARY_FLG&$filter=(WorkOrderNum%20eq%20%27" + (operation.WorkOrderNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
            let currentReadings = measurementPointReadingSet

            let batchArr = NSMutableArray()
            batchArr.add(inCompleteComponent)
            batchArr.add(attachemts)
            batchArr.add(uploadAttachments)
            batchArr.add(currentReadings)
            
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
                            if resourcePath == woConfirmationSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoComponentModel.self)
                                self.componentArr.removeAll()
                                if  let comparray = dict["data"] as? [WoComponentModel]{
                                    if(comparray.count > 0) {
                                        mJCLogger.log("Response:\(comparray.count)", Type: "Debug")
                                        self.componentArr = comparray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        cmpCount = ""
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == uploadWOAttachmentContentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                                self.woUploadAttachmentArr.removeAll()
                                if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                    if(uploadattacharray.count > 0) {
                                        mJCLogger.log("Response:\(uploadattacharray.count)", Type: "Debug")
                                        self.woUploadAttachmentArr = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == ""}
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == woAttachmentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                                self.woAttachmentArr.removeAll()
                                if  let Woattacharray = dict["data"] as? [AttachmentModel]{
                                    if(Woattacharray.count > 0) {
                                        mJCLogger.log("Response:\(Woattacharray.count)", Type: "Debug")
                                        self.woAttachmentArr = Woattacharray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == measurementPointReadingSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: MeasurementPointModel.self)
                                self.finalpoints.removeAll()
                                self.currentpoints.removeAll()
                                if  let pointArray = dict["data"] as? [MeasurementPointModel]{
                                    if(pointArray.count > 0) {
                                        mJCLogger.log("Response:\(pointArray.count)", Type: "Debug")
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        self.createBatchRequestForFormsCount(ObjectClass: ObjectClass)
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else if let notification = ObjectClass as? NotificationModel{
            
            let itemList = DefineRequestModelClass.uniqueInstance.getNotificationItems(type: "deleteList", notificationNum: notification.Notification, itemNum: "", notificationFrom: "") as String
            let ActivityList = DefineRequestModelClass.uniqueInstance.getNotificationActivity(type: "List", notificationNum: notification.Notification, activityNum: "",notificationFrom: "", ItemNum: "0000") as String
            let taskList = DefineRequestModelClass.uniqueInstance.getNotificationTask(type: "List", notificationNum: notification.Notification, taskNum: "", notificationFrom: "", ItemNum: "0000") as String
            let NoUploadList = uploadNOAttachmentContentSet + "?$filter=(Notification%20eq%20%27" + (notification.Notification) + "%27 and BINARY_FLG ne 'N')";
            let NoAttachList = "NOAttachmentSet" + "?$filter=(endswith(ObjectKey, '\(notification.Notification)') eq true)"
            
            let batchArr = NSMutableArray()
            
            batchArr.add(itemList)
            batchArr.add(ActivityList)
            batchArr.add(taskList)
            batchArr.add(NoUploadList)
            batchArr.add(NoAttachList)

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
                            if resourcePath == notificationActivitySet {
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                                if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                    if NoActivityArr.count > 0{
                                        mJCLogger.log("Response:\(NoActivityArr.count)", Type: "Debug")
                                        ActvityCount = "\(NoActivityArr.count)"
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        ActvityCount = ""
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == notificationItemSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                                if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                    if NoItemArr.count > 0{
                                        mJCLogger.log("Response:\(NoItemArr.count)", Type: "Debug")
                                        ItemCount = "\(NoItemArr.count)"
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        ItemCount = ""
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == notificationTaskSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                                if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                    if NoTaskArr.count > 0{
                                        mJCLogger.log("Response:\(NoTaskArr.count)", Type: "Debug")
                                        TaskCount = "\(NoTaskArr.count)"
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        TaskCount = ""
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == uploadNOAttachmentContentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                                self.noUploadAttachmentArr.removeAll()
                                if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                    if(uploadattacharray.count > 0) {
                                        mJCLogger.log("Response:\(uploadattacharray.count)", Type: "Debug")
                                        self.noUploadAttachmentArr = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Item == "" && $0.Task == ""}
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == noAttachmentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                                self.noAttachmentArr.removeAll()
                                if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                    if(Noattacharray.count > 0) {
                                        mJCLogger.log("Response:\(Noattacharray.count)", Type: "Debug")
                                        self.noAttachmentArr = Noattacharray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                                if  let Noattacharray = dict["CompID"] as? [String]{
                                    if(Noattacharray.count > 0) {
                                        mJCLogger.log("Response:\(Noattacharray.count)", Type: "Debug")
                                        self.noCompIdArr = Noattacharray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        self.setNoAttachementCount(Notification: notification)
                        DispatchQueue.main.async {
                            self.dBVc!.detailsTableView.reloadData()
                        }
                    }
                }else{
                    if error?.code == 10{
                        mJCLogger.log("Store open Failed", Type: "Debug")
                    }else if error?.code == 1227{
                        mJCLogger.log("Entity set not found", Type: "Debug")
                    }else{
                        mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createBatchRequestForFormsCount(ObjectClass: AnyObject){
        mJCLogger.log("Starting", Type: "info")

        if let workorder = ObjectClass as? WoHeaderModel {

            let formAssignment = "\(formAssingmentSet)?$filter=(ControlKey%20eq%20%27%27%20and%20OrderType%20eq%20%27\( workorder.OrderType)%27)"
            let responseCapture = "\(responseCaptureSet)?$filter=(CreatedBy%20eq%20%27\(strUser)%27 and (WoNum%20eq%20%27\(workorder.WorkOrderNum)%27) and (IsDraft%20ne%20%27X%27))&$select=FormID"
            let reviewerForm = ReviewerFormResponseSet
            let formResponseApproval = "\(formResponseApprovalStatusSet)?$filter=ApproverID eq '\(strUser)'"
            
            let batchArr = NSMutableArray()
            batchArr.add(formAssignment)
            batchArr.add(responseCapture)
            batchArr.add(reviewerForm)
            batchArr.add(formResponseApproval)
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
            }
            FormsBatchRequestModel.getExecuteFormsBatchRequest(batchRequest: batchRequest){ (response, error)  in

                if error == nil {
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        for key in responseDic.allKeys{
                            let resourcePath = key as! String
                            if resourcePath == formAssingmentSet {
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                self.formsAssignArray.removeAll()
                                self.mendatoryFormCount = Int()
                                let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAssignDataModel.self)
                                if  let formsassignarray = dict["data"] as? [FormAssignDataModel]{
                                    if formsassignarray.count > 0{
                                        mJCLogger.log("Response:\(formsassignarray.count)", Type: "Debug")
                                        self.formsAssignArray = formsassignarray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                                if  let mcount = dict["mendatoryCount"] as? Int{
                                    self.mendatoryFormCount = mcount
                                }
                            }else if resourcePath == responseCaptureSet{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseCaptureModel.self)
                                if  let formresparray = dict["data"] as? [FormResponseCaptureModel]{
                                    if formresparray.count > 0{
                                        mJCLogger.log("Response:\(formresparray.count)", Type: "Debug")
                                        self.formsResponseArr = formresparray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == ReviewerFormResponseSet{
                                self.dBVc!.yetToBeReviewedArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormReviewerResponseModel.self)
                                if  let formresparray = dict["data"] as? [FormReviewerResponseModel]{
                                    if formresparray.count > 0{
                                        mJCLogger.log("Response:\(formresparray.count)", Type: "Debug")
                                        self.dBVc!.yetToBeReviewedArr = formresparray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == formResponseApprovalStatusSet{
                                self.dBVc!.approvedChecksheetArr.removeAll()
                                self.dBVc!.rejectedChecksheetArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseApprovalStatusModel.self)
                                if  let formresparray = dict["data"] as? [FormResponseApprovalStatusModel]{
                                    if formresparray.count > 0{
                                        let rejectedArr = formresparray.filter{$0.FormContentStatus == "REJECT"}
                                        let appovedArr = formresparray.filter{$0.FormContentStatus == "APPROVE"}
                                        self.dBVc!.rejectedChecksheetArr = rejectedArr
                                        self.dBVc!.approvedChecksheetArr = appovedArr
                                        mJCLogger.log("Response:\(formresparray.count)", Type: "Debug")
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        self.setOperationCount(workorder:workorder)
                        self.setComponentCount(workorder:workorder)
                        self.setWoAttachementCount(workorder:workorder)
                        self.setFormCount(workorder: workorder)
                        self.setRecordpointCount(workorder: workorder)
                        if  workorder.InspectionLot != "000000000000"{
                            self.createBatchRequestForInspectionCount(ObjectClass: workorder)
                        }
                        DispatchQueue.main.async {
                            self.dBVc!.detailsTableView.reloadData()
                        }
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    self.setOperationCount(workorder:workorder)
                    self.setComponentCount(workorder:workorder)
                    self.setWoAttachementCount(workorder:workorder)
                    self.setFormCount(workorder: workorder)
                    self.setRecordpointCount(workorder: workorder)
                    if  workorder.InspectionLot != "000000000000"{
                        self.createBatchRequestForInspectionCount(ObjectClass: workorder)
                    }
                    DispatchQueue.main.async {
                        self.dBVc!.detailsTableView.reloadData()
                    }
                }
            }
        }else if let operation = ObjectClass as? WoOperationModel {
            
            let formAssignment = "\(formAssingmentSet)?$filter=(ControlKey%20eq%20%27%27%20and%20OrderType%20eq%20%27\( operation.OrderType)%27)"
            let responseCapture = "\(responseCaptureSet)?$filter=(CreatedBy%20eq%20%27\(strUser)%27 and (WoNum%20eq%20%27\(operation.WorkOrderNum)%27) and (IsDraft%20ne%20%27X%27))&$select=FormID"
            
            let batchArr = NSMutableArray()
            batchArr.add(formAssignment)
            batchArr.add(responseCapture)
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
            }
            FormsBatchRequestModel.getExecuteFormsBatchRequest(batchRequest: batchRequest){ (response, error)  in

                if error == nil {
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        for key in responseDic.allKeys{
                            let resourcePath = key as! String
                            if resourcePath == formAssingmentSet {
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                self.formsAssignArray.removeAll()
                                self.mendatoryFormCount = Int()
                                let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAssignDataModel.self)
                                if  let formsassignarray = dict["data"] as? [FormAssignDataModel]{
                                    if formsassignarray.count > 0{
                                        mJCLogger.log("Response:\(formsassignarray.count)", Type: "Debug")
                                        self.formsAssignArray = formsassignarray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                                if  let mcount = dict["mendatoryCount"] as? Int{
                                    self.mendatoryFormCount = mcount
                                }
                            }else if resourcePath == responseCaptureSet{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseCaptureModel.self)
                                if  let formresparray = dict["data"] as? [FormResponseCaptureModel]{
                                    if formresparray.count > 0{
                                        mJCLogger.log("Response:\(formresparray.count)", Type: "Debug")
                                        self.formsResponseArr = formresparray
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.dBVc!.detailsTableView.reloadData()
                        }
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createBatchRequestForInspectionCount(ObjectClass: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        if let workorder = ObjectClass as? WoHeaderModel {
            
            // inspection operation
            let inspectionOprQuery = "\(inspectionOperSet)?$filter=(InspectionLot%20eq%20%27\(workorder.InspectionLot)%27)&$orderby=Operation"
            let inspectionPointQuery = "\(inspectionPointSet)?$filter=(InspLot eq '\(workorder.InspectionLot)')&$orderby=InspPoint"
            let inspectionCharQuery = "\(inspectionCharSet)?$filter=(InspLot eq '\(workorder.InspectionLot)')&$orderby=InspChar"
            let insepctionResultQuery = "\(ispectionResultsGetSet)?$filter=(InspLot eq '\(workorder.InspectionLot)')"

            let batchArr = NSMutableArray()
            batchArr.add(inspectionOprQuery)
            batchArr.add(inspectionPointQuery)
            batchArr.add(inspectionCharQuery)
            batchArr.add(insepctionResultQuery)
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
            }
            BatchRequestModel.getExecuteQmBatchRequest(batchRequest: batchRequest){ (response, error)  in

                if error == nil {
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        var inspOprArray = Array<InspectionOperationModel>()
                        var inspPointArray = Array<InspectionPointModel>()
                        var inspCharArray = Array<InspectionCharModel>()
                        var inspResultArray = Array<InspectionResultModel>()
                        for key in responseDic.allKeys{
                            
                            let resourcePath = key as! String
                            if resourcePath == inspectionOperSet {
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict =  formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionOperationModel.self)
                                if  let inspOprArr = dict["data"] as? [InspectionOperationModel]{
                                    mJCLogger.log("Response:\(inspOprArr.count)", Type: "Debug")
                                    inspOprArray = inspOprArr
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == inspectionPointSet{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionPointModel.self)
                                if  let insppointarray = dict["data"] as? [InspectionPointModel]{
                                    mJCLogger.log("Response:\(insppointarray.count)", Type: "Debug")
                                    inspPointArray = insppointarray
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == inspectionCharSet{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionCharModel.self)
                                if  let inspcharArray = dict["data"] as? [InspectionCharModel]{
                                    mJCLogger.log("Response:\(inspcharArray.count)", Type: "Debug")
                                    inspCharArray = inspcharArray
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == ispectionResultsGetSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionResultModel.self)
                                if  let inspresult = dict["data"] as? [InspectionResultModel]{
                                    mJCLogger.log("Response:\(inspresult.count)", Type: "Debug")
                                    inspResultArray = inspresult
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        self.setinspectionCount(workorder: workorder, inspOprArr: inspOprArray, inspPointArray: inspPointArray, inspcharArray: inspCharArray, inspResultArray: inspResultArray)
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setOperationCount(workorder: WoHeaderModel) {
        mJCLogger.log("Starting", Type: "info")
        var count = Int()
        for itemCount in 0..<self.operationArr.count {
            let oprCls = self.operationArr[itemCount]
            let opr = oprCls.OperationNum
            if !self.confirmOperationList.contains(opr) {
                count+=1
            }
        }
        DispatchQueue.main.async {
            if count == 0 {
                OprCount = "\(self.operationArr.count)"
                OprColor = appColor
                if self.operationArr.count == 0{
                    OprCount = ""
                }
            }else {
                OprCount = "\(count)"
                OprColor = UIColor.red
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setComponentCount(workorder:WoHeaderModel){
        mJCLogger.log("Starting", Type: "info")
        cmpCount = ""
        let filterarray = self.componentArr.filter{$0.WithdrawalQty == 0}
        if self.componentArr.count == filterarray.count {
            if workorder.OrderType != ""{
                if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType){
                    if (featurelist as! NSMutableArray).contains("COMPONENT"){
                        cmpColor = UIColor.red
                    }else{
                        cmpColor = filledCountColor
                    }
                }else{
                    cmpColor = filledCountColor
                }
            }
            cmpCount =  "\(filterarray.count)"
        }else{
            if filterarray.count > 0 {
                if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType){
                    if (featurelist as! NSMutableArray).contains("COMPONENT"){
                        cmpColor = UIColor.red
                    }else{
                        cmpColor = filledCountColor
                    }
                }else{
                    cmpColor = filledCountColor
                }
                cmpCount = "\(filterarray.count)"
            }else {
                var incompleteWithdrawnCount = Int()
                var totalWithdrawnCount = Int()
                for item in filterarray {
                    let reqQty = item.ReqmtQty
                    let WithdrawalQty = item.WithdrawalQty
                    if WithdrawalQty == reqQty {
                        totalWithdrawnCount+=1
                    }
                }
                if incompleteWithdrawnCount == 0 {
                    cmpCount = "\(totalWithdrawnCount)"
                    cmpColor = appColor
                }else{
                    cmpCount = "\(incompleteWithdrawnCount)"
                    cmpColor = filledCountColor
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWoAttachementCount(workorder:WoHeaderModel){
        mJCLogger.log("Starting", Type: "info")
        attchmentCount = ""
        let totalAttachmentCount = self.woUploadAttachmentArr.count + self.woAttachmentArr.count
        
        DispatchQueue.main.async {
            if (totalAttachmentCount > 0) {
                attchmentCount = "\(totalAttachmentCount)"
                if self.woUploadAttachmentArr.count == 0{
                    if workorder.OrderType != ""{
                        if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType){
                            if (featurelist as! NSMutableArray).contains("ATTACHMENT"){
                                if self.woAttachmentArr.count != 0 {
                                    attchmentColor = UIColor.red
                                }else{
                                    attchmentCount = "!"
                                    attchmentColor = UIColor.red
                                }
                            }else{
                                if totalAttachmentCount > 0{
                                    attchmentCount = "\(totalAttachmentCount)"
                                }else{
                                    attchmentCount = ""
                                }
                            }
                        }else{
                            if totalAttachmentCount > 0{
                                attchmentCount = "\(totalAttachmentCount)"
                            }else{
                                attchmentCount = ""
                            }
                        }
                    }
                }
            }else {
                attchmentCount = "!"
                attchmentColor = UIColor.red
                if self.woUploadAttachmentArr.count == 0{
                    if workorder.OrderType != ""{
                        if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType) as? NSMutableArray {
                            if featurelist.contains("ATTACHMENT"){
                                attchmentCount = "!"
                                attchmentColor = UIColor.red
                            }else{
                                if totalAttachmentCount > 0{
                                    attchmentCount = "\(totalAttachmentCount)"
                                }else{
                                    attchmentCount = ""
                                }
                            }
                        }else{
                            attchmentCount = ""
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setFormCount(workorder: WoHeaderModel) {
        mJCLogger.log("Starting", Type: "info")
        formCount = ""
        if self.mendatoryFormCount > 0 {
            let filteraarr = self.formsAssignArray.filter{$0.Mandatory == "X" && $0.filledFormCount == 0}
            if filteraarr.count > 0{
                formCount = "\(filteraarr.count)"
                formColor = UIColor.red
            }else{
                let filteraarr = self.formsAssignArray.filter{$0.filledFormCount == 0}
                if filteraarr.count > 0{
                    formCount = "\(filteraarr.count)"
                    formColor = filledCountColor
                }else{
                    formCount = "\(self.formsAssignArray.count)"
                    formColor = appColor
                }
            }
        }else{
            let filteraarr = self.formsAssignArray.filter{$0.filledFormCount == 0}
            if filteraarr.count > 0{
                formCount = "\(filteraarr.count)"
                formColor = filledCountColor
            }else{
                formCount = "\(self.formsAssignArray.count)"
                formColor = filledCountColor
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setRecordpointCount(workorder: WoHeaderModel){
        mJCLogger.log("Starting", Type: "info")
        rpCount = ""
        if self.finalpoints.count > 0 {
            if self.currentpoints.count > 0 {
                let count = self.finalpoints.count - self.currentpoints.count
                if count == 0 {
                    rpCount = "\(self.finalpoints.count)"
                    rpColor = appColor
                }else {
                    rpCount = "\(count)"
                    rpColor = filledCountColor
                }
            }else {
                rpCount = "\(self.finalpoints.count)"
                rpColor = UIColor.red
                if workorder.OrderType != ""{
                    if let featurelist = orderTypeFeatureDict.value(forKey: workorder.OrderType){
                        if (featurelist as! NSMutableArray).contains("RECORD_POINT"){
                            rpColor = UIColor.red
                        }else{
                            rpColor = filledCountColor
                        }
                    }else{
                        rpColor = filledCountColor
                    }
                }
            }
        }else {
            rpCount = ""
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setNoAttachementCount(Notification:NotificationModel){
        mJCLogger.log("Starting", Type: "info")
        attchmentCount = ""
        if self.noAttachmentArr.count > 0{
            var uploadedAttachementCount = self.noUploadAttachmentArr.count
            for item in self.noUploadAttachmentArr{
                let filename = item.FILE_NAME
                if noCompIdArr.contains(filename){
                    uploadedAttachementCount -= 1
                }
            }
            let totalAttchmentCount = self.noCompIdArr.count + uploadedAttachementCount
            if (totalAttchmentCount > 0) {
                attchmentCount = "\(totalAttchmentCount)"
            }else {
                attchmentCount = ""
            }
        }else{
            let uploadedAttachementCount = noUploadAttachmentArr.count
            if (uploadedAttachementCount > 0) {
                attchmentCount = "\(uploadedAttachementCount)"
            }else {
                attchmentCount = ""
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setinspectionCount(workorder: WoHeaderModel,inspOprArr:Array<InspectionOperationModel>,inspPointArray:Array<InspectionPointModel>,inspcharArray:Array<InspectionCharModel>,inspResultArray:Array<InspectionResultModel>){
        mJCLogger.log("Starting", Type: "info")
        var finalCharArray = Int()
        var finalResultArray = Int()
        inspCount = ""
        if inspOprArr.count > 0{
            for item in inspOprArr{
                let pointArray = inspPointArray.filter{$0.InspOper == "\(item.Operation)"}
                if pointArray.count > 0{
                    for item1 in pointArray{
                        let chararry = inspcharArray.filter{$0.InspPoint == "\(item1.InspPoint)"}
                        if chararry.count > 0{
                            finalCharArray = finalCharArray + chararry.count
                            for item3 in chararry{
                                let resultarray = inspResultArray.filter{$0.InspOper == "\(item3.InspOper)" && $0.InspSample == "\(item3.InspPoint)" && $0.InspChar == "\(item3.InspChar)"}
                                finalResultArray = finalResultArray + resultarray.count
                            }
                        }
                    }
                }
            }
        }
        if finalCharArray == finalResultArray{
            inspCount = "\(finalCharArray)"
            InspColor = appColor
        }else{
            let remaincount = finalCharArray - finalResultArray
            inspCount = "\(remaincount)"
            if let featurelist = orderTypeFeatureDict.value(forKey: workorder.OrderType){
                if (featurelist as! NSMutableArray).contains("INSPECTION"){
                    InspColor = UIColor.red
                }else{
                    InspColor = filledCountColor
                }
            }
        }
        DispatchQueue.main.async {
            self.dBVc!.detailsTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
