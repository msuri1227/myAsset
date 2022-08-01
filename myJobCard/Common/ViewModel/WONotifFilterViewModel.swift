//
//  ListFilterViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 16/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class ListFilterViewModel {
    
    var filterVc : ListFilterVC!
    var selectedPriorityArray = [String]()
    var priorityArray = [String]()
    var priorityListArray = [String]()
    var selectedTypeArray = [String]()
    var typeArray = [String]()
    var selectedStatusArray = [String]()
    var statusArray = [String]()
    var selectedPlantArry = [String]()
    var plantsArray = [String]()
    var selectedCreatedByArray = [String]()
    var createdByArray = [String]()
    var selectedmainWorkCenterArry = [String]()
    var mainWorkCenterArry = [String]()
    var mainWorkCenterListArry = [String]()
    var selectedmainPlantGroupArry = [String]()
    var mainPlantGroupListArray = [String]()
    var selectedPersponseArray = [String]()
    var persponseArray = [String]()
    var selectedMaintenancePlantArray = [String]()
    var maintenancePlantArray = [String]()
    var selectedPlanningPlantArray = [String]()
    var planningPlantArray = [String]()
    var equipmentArray = [String]()
    var techIDArray = [String]()
    var selectedTechIDArray = [String]()
    var teamMemberArray = [String]()
    var selectedTeamMemberArray = [String]()
    var assetMapFilterArray = [String]()
    var selectedAssetMapFilterArray = [String]()
    
    func setPrirityValues(){
        
        self.priorityListArray.removeAll()
        self.selectedPriorityArray.removeAll()
        var listArr = [PriorityListModel]()
        let predicate = NSPredicate(format: "Priority IN %@", self.priorityArray)
        listArr = globalPriorityArray.filter{predicate.evaluate(with: $0)}
        for item in listArr {
            self.priorityListArray.append(item.PriorityText)
        }
        if self.priorityArray.contains("No_Priority".localized()){
            self.priorityListArray.append("No_Priority".localized())
        }
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("priority"),let arr = dict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    listArr = globalPriorityArray.filter{predicate.evaluate(with: $0)}
                    for item in listArr {
                        self.selectedPriorityArray.append(item.PriorityText)
                    }
                    if arr.contains(""){
                        self.selectedPriorityArray.append("No_Priority".localized())
                    }
                }
            }
        }
    }
    func setStatusValues(){
        self.selectedStatusArray.removeAll()
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("status"),let arr = dict["status"] as? [String]{
                if arr.count > 0{
                    self.selectedStatusArray = arr
                }
            }
        }
    }
    func setTypeValues(){
        self.selectedTypeArray.removeAll()
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("orderType"),let arr = dict["orderType"] as? [String]{
                if arr.count > 0{
                    self.selectedTypeArray = arr
                }
            }
        }
    }
    func setUnAssignedValues(){
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("unAssigned"),let arr = dict["unAssigned"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "UnAssigned"{
                        self.filterVc.UnassignedButton.isSelected = true
                    }
                }
            }
        }
    }
    func setCreatedByMeValues(){
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("createdByMe"),let arr = dict["createdByMe"] as? [String]{
                if arr.count > 0{
                    if arr[0] == "CreatedByMe"{
                        self.filterVc.createdByMebutton.isSelected = true
                    }
                }
            }
        }
    }
    func setPlantValues(){
        mJCLogger.log("Starting", Type: "info")
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("plant"),let arr = dict["plant"] as? [String]{
                if arr.count > 0{
                    self.selectedPlantArry = arr
                    if let index = self.selectedPlantArry.index(of: ""){
                        self.selectedPlantArry[index] = "No_Value".localized()
                    }
                    self.filterVc.plantTextField.text = self.selectedPlantArry.joined(separator: ";")
                }else{
                    self.filterVc.plantTextField.text = selectStr
                }
            }else{
                self.filterVc.plantTextField.text = selectStr
            }
        }else{
            self.filterVc.plantTextField.text = selectStr
        }
        //Plant
        if self.filterVc.filterViewModel.plantsArray.count > 0{
            self.filterVc.plantTextField.optionArray = self.filterVc.filterViewModel.plantsArray
            self.filterVc.plantTextField.checkMarkEnabled = true
            self.filterVc.plantTextField.isMultipleSelection = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setCreatedByValues(){
        
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("createdBy"),let arr = dict["createdBy"] as? [String]{
                if arr.count > 0{
                    self.selectedCreatedByArray = arr
                    if let index = self.selectedCreatedByArray.index(of: ""){
                        self.selectedCreatedByArray[index] = "No_Value".localized()
                    }
                    self.filterVc.createdByTextField.text = self.selectedCreatedByArray.joined(separator: ";")
                }else{
                    self.filterVc.createdByTextField.text = selectStr
                }
            }else{
                self.filterVc.createdByTextField.text = selectStr
            }
        }else{
            self.filterVc.createdByTextField.text = selectStr
        }
        //Created by
        if filterVc.filterViewModel.createdByArray.count > 0{
            filterVc.createdByTextField.optionArray = filterVc.filterViewModel.createdByArray
            filterVc.createdByTextField.checkMarkEnabled = true
            filterVc.createdByTextField.isMultipleSelection = true
        }
    }
    func setMainWorkCenterValues(){
        var listArr = [WorkCenterModel]()
        if filterVc.isfrom == "Notification"{
            let predicate = NSPredicate(format: "ObjectID IN %@", self.mainWorkCenterArry)
            listArr = globalWorkCtrArray.filter{predicate.evaluate(with: $0)}
        }else{
            let predicate = NSPredicate(format: "WorkCenter IN %@", self.mainWorkCenterArry)
            listArr = globalWorkCtrArray.filter{predicate.evaluate(with: $0)}
        }
        for item in listArr {
            let dispStr = item.WorkCenter
            self.mainWorkCenterListArry.append(dispStr)
        }
        
        //Work center
        if filterVc.filterViewModel.mainWorkCenterArry.count > 0{
            filterVc.mainWorkCenterTextField.optionArray = filterVc.filterViewModel.mainWorkCenterArry
            filterVc.mainWorkCenterTextField.checkMarkEnabled = true
            filterVc.mainWorkCenterTextField.isMultipleSelection = true
        }
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("mainWorkCenter"),let arr = dict["mainWorkCenter"] as? [String]{
                if arr.count > 0{
                    self.selectedmainWorkCenterArry = arr
                    if let index = self.selectedmainWorkCenterArry.index(of: ""){
                        self.selectedmainWorkCenterArry[index] = "No_Value".localized()
                    }
                    self.filterVc.mainWorkCenterTextField.text = self.selectedmainWorkCenterArry.joined(separator: ";")
                }else{
                    self.filterVc.mainWorkCenterTextField.text = selectStr
                }
            }else{
                self.filterVc.mainWorkCenterTextField.text = selectStr
            }
        }else{
            self.filterVc.mainWorkCenterTextField.text = selectStr
        }
    }
    func setMainPlannerGroupValues(){
        self.selectedmainPlantGroupArry.removeAll()
        DispatchQueue.main.async { [self] in
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("mainPlantGroup"),let arr = dict["mainPlantGroup"] as? [String]{
                    if arr.count > 0{
                        self.selectedmainPlantGroupArry = arr
                        if let index = self.selectedmainPlantGroupArry.index(of: ""){
                            self.selectedmainPlantGroupArry[index] = "No_Value".localized()
                        }
                        self.filterVc.mainPlannerGroupTextField.text = self.selectedmainPlantGroupArry.joined(separator: ";")
                    }else{
                        self.filterVc.mainPlannerGroupTextField.text = selectStr
                    }
                }else{
                    self.filterVc.mainPlannerGroupTextField.text = selectStr
                }
            }else{
                self.filterVc.mainPlannerGroupTextField.text = selectStr
            }
            
            //Main Planner
            if filterVc.filterViewModel.mainPlantGroupListArray.count > 0{
                filterVc.mainPlannerGroupTextField.optionArray = filterVc.filterViewModel.mainPlantGroupListArray
                filterVc.mainPlannerGroupTextField.checkMarkEnabled = true
                filterVc.mainPlannerGroupTextField.isMultipleSelection = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setStaffIdValues(){
        self.selectedPersponseArray.removeAll()
        DispatchQueue.main.async { [self] in
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("staffId"),let arr = dict["staffId"] as? [String]{
                    if arr.count > 0{
                        self.selectedPersponseArray = arr
                        if let index = self.selectedPersponseArray.index(of: ""){
                            self.selectedPersponseArray[index] = "No_Value".localized()
                        }
                        self.filterVc.personalRespTextField.text = self.selectedPersponseArray.joined(separator: ";")
                    }else{
                        self.filterVc.personalRespTextField.text = selectStr
                    }
                }else{
                    self.filterVc.personalRespTextField.text = selectStr
                }
            }else{
                self.filterVc.personalRespTextField.text = selectStr
            }
            //Staff id
            if filterVc.filterViewModel.persponseArray.count > 0{
                filterVc.personalRespTextField.optionArray = filterVc.filterViewModel.persponseArray
                filterVc.personalRespTextField.checkMarkEnabled = true
                filterVc.personalRespTextField.isMultipleSelection = true
            }
        }
    }
    func setMaintancePlantValues(){
        
        DispatchQueue.main.async { [self] in
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("maintenancePlant"),let arr = dict["maintenancePlant"] as? [String]{
                    if arr.count > 0{
                        self.selectedMaintenancePlantArray = arr
                        if let index = self.selectedMaintenancePlantArray.index(of: ""){
                            self.selectedMaintenancePlantArray[index] = "No_Value".localized()
                        }
                        self.filterVc.maintenancePlantTextField.text = self.selectedMaintenancePlantArray.joined(separator: ";")
                    }else{
                        self.filterVc.maintenancePlantTextField.text = selectStr
                    }
                }else{
                    self.filterVc.maintenancePlantTextField.text = selectStr
                }
            }else{
                self.filterVc.maintenancePlantTextField.text = selectStr
            }
            //Maintainance plant
            if filterVc.filterViewModel.mainPlantGroupListArray.count > 0{
                filterVc.mainPlannerGroupTextField.optionArray = filterVc.filterViewModel.mainPlantGroupListArray
                filterVc.mainPlannerGroupTextField.checkMarkEnabled = true
                filterVc.mainPlannerGroupTextField.isMultipleSelection = true
            }
        }
    }
    func setPlanningPlantValues() {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async { [self] in
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("planningPlant"),let arr = dict["planningPlant"] as? [String]{
                    if arr.count > 0{
                        self.selectedPlanningPlantArray = arr
                        if let index = self.selectedPlanningPlantArray.index(of: ""){
                            self.selectedPlanningPlantArray[index] = "No_Value".localized()
                        }
                        self.filterVc.planningPlantTextField.text = self.selectedPlanningPlantArray.joined(separator: ";")
                    }else{
                        self.filterVc.planningPlantTextField.text = selectStr
                    }
                }else{
                    self.filterVc.planningPlantTextField.text = selectStr
                }
            }else{
                self.filterVc.planningPlantTextField.text = selectStr
            }
            //Planning plant
            if filterVc.filterViewModel.planningPlantArray.count > 0{
                filterVc.planningPlantTextField.optionArray = filterVc.filterViewModel.planningPlantArray
                filterVc.planningPlantTextField.checkMarkEnabled = true
                filterVc.planningPlantTextField.isMultipleSelection = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setTechIdValues(){
        let define = "$filter=\(myAssetDataManager.getEquipmentQuery(equipArr: self.equipmentArray))"
        EquipmentModel.getEquipmentList(filterQuery: define){(response,error) in
            if error == nil{
                if let respArr = response["data"] as? [EquipmentModel]{
                    var techIdArr = [String]()
                    for item in respArr{
                        if item.TechIdentNo != "" {
                            techIdArr.append(item.TechIdentNo)
                        }
                    }
                    self.techIDArray.removeAll()
                    self.techIDArray = techIdArr
                }
                self.setTechIDValue()
            }
        }
    }
    func setTechIDValue()  {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async { [self] in
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("techID"),let arr = dict["techID"] as? [String]{
                    if arr.count > 0{
                        self.selectedTechIDArray = arr
                        if let index = self.selectedTechIDArray.index(of: ""){
                            self.selectedTechIDArray[index] = "No_Value".localized()
                        }
                        self.filterVc.techIdTextField.text = self.selectedTechIDArray.joined(separator: ";")
                    }else{
                        if self.techIDArray.count == 0{
                            self.techIDArray.append("No_Value".localized)
                        }
                        self.filterVc.techIdTextField.text = selectStr
                    }
                }else{
                    if self.techIDArray.count == 0{
                        self.techIDArray.append("No_Value".localized)
                    }
                    self.filterVc.techIdTextField.text = selectStr
                }
            }else{
                if self.techIDArray.count == 0{
                    self.techIDArray.append("No_Value".localized)
                }
                self.filterVc.techIdTextField.text = selectStr
            }
            //Technical id
            if self.filterVc.filterViewModel.techIDArray.count > 0{
                filterVc.techIdTextField.optionArray = filterVc.filterViewModel.persponseArray
                filterVc.techIdTextField.checkMarkEnabled = true
                filterVc.techIdTextField.isMultipleSelection = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setTeamMemberValues(){
        
        self.teamMemberArray = alltechnicianListArray.uniqueValues{$0.Name}
        DispatchQueue.main.async { [self] in
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("teamMember"),let arr = dict["teamMember"] as? [String]{
                    if arr.count > 0{
                        self.selectedTeamMemberArray = arr
                        self.filterVc.teamMemberTextField.text = self.selectedTeamMemberArray.joined(separator: ";")
                    }else{
                        self.filterVc.teamMemberTextField.text = selectStr
                    }
                }else{
                    self.filterVc.teamMemberTextField.text = selectStr
                }
            }else{
                self.filterVc.teamMemberTextField.text = selectStr
            }
            //Team mem
            if filterVc.filterViewModel.teamMemberArray.count > 0{
                self.filterVc.teamMemberTextField.optionArray = self.filterVc.filterViewModel.teamMemberArray
                self.filterVc.teamMemberTextField.checkMarkEnabled = true
                self.filterVc.teamMemberTextField.isMultipleSelection = true
            }
        }
    }
    func setAssetMapFilterValues(){
        
        self.assetMapFilterArray = ["Point Assets","Line Assets"]
        DispatchQueue.main.async {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("assetMap"),let arr = dict["assetMap"] as? [String]{
                    if arr.count > 0{
                        self.selectedAssetMapFilterArray = arr
                        self.filterVc.showOnMapTextField.text = self.selectedAssetMapFilterArray.joined(separator: ";")
                    }else{
                        self.filterVc.showOnMapTextField.text = selectStr
                    }
                }else{
                    self.filterVc.showOnMapTextField.text = selectStr
                }
            }else{
                self.filterVc.showOnMapTextField.text = selectStr
            }
            //Show on map
            if self.filterVc.filterViewModel.assetMapFilterArray.count > 0{
                self.filterVc.showOnMapTextField.optionArray = self.filterVc.filterViewModel.assetMapFilterArray
                self.filterVc.showOnMapTextField.checkMarkEnabled = true
                self.filterVc.showOnMapTextField.isMultipleSelection = true
            }
        }
    }
}
