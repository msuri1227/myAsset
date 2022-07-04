//
//  CheckSheetApprovalViewModel.swift
//  myJobCard
//
//  Created by Ruby's Mac on 03/06/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib


class CheckSheetApprovalViewModel {
    
    var formApprovalVC: FormApprovalVC!
    var checkSheetAvailabilityVC: CheckSheetAvailabilityVC!
    var formApprovalStatusVC: FormApprovalStatusVC!
    var formApproverArray = [ApproverMasterDataModel]()
    var formApproverListArray = [ApproverMasterDataModel]()
    var manualCheckSheetListArray = [FormAssignDataModel]()
    var predefinedFormArray = Array<FormAssignDataModel>()
    var property = NSMutableArray()
    var selectedApprovalForm = FormAssignDataModel()
    var formApproverStatusArray = [FormResponseApprovalStatusModel]()
    var formApproverStatusListArray = [FormResponseApprovalStatusModel]()
    var checkSheetArray = [FormMasterMetaDataModel]()
    var checkSheetListArray = [FormMasterMetaDataModel]()
    var checksheetApproverArr = [FormAssignDataModel]()
    //MARK:- Get Form Assignment Data..
    
    func getPredefinedCheckSheetDataWithBatchRequest(){
        var batchQueryArr = [String]()
        var formQuery = ""
        if FORM_ASSIGNMENT_TYPE == "1" {
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '' and OrderType eq '\(singleWorkOrder.OrderType)')&$orderby=Mandatory desc"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '' and OrderType eq '\(singleOperation.OrderType)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
        }else if FORM_ASSIGNMENT_TYPE == "2"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formAssingmentSet)?$filter=\(myAssetDataManager.getAssignementType2Query())"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '\(singleOperation.ControlKey)' and OrderType eq '\(singleOperation.OrderType)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
            
        }else if FORM_ASSIGNMENT_TYPE == "3"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formAssingmentSet)?$filter=\(myAssetDataManager.getAssignmentType3Query())"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(EquipCategory eq '\(singleOperation.EquipCategory)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
        }else if FORM_ASSIGNMENT_TYPE == "4"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formAssingmentSet)?$filter=\(myAssetDataManager.getAssignement4Query())"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(FuncLocCategory eq '\(singleOperation.FuncLocCategory)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
            
        }else if FORM_ASSIGNMENT_TYPE == "5" || FORM_ASSIGNMENT_TYPE == "10"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                batchQueryArr.append(myAssetDataManager.getAssignement5Query())
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '\(singleOperation.ControlKey)' and OrderType eq '\(singleOperation.OrderType)' and TaskListType eq '\(singleOperation.TaskListType)' and Group eq '\(singleOperation.Group)' and GroupCounter eq '\(singleOperation.GroupCounter)' and InternalCounter eq '\(singleOperation.InternalCounter)')&$orderby=Mandatory desc"
                batchQueryArr.append(formQuery)
            }
        }
        
        let batchRequest = SODataRequestParamBatchDefault.init()
        for query in batchQueryArr {
            let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: query)
            reqParam?.customTag = query
            batchRequest.batchItems.add(reqParam!)
        }
        FormsBatchRequestModel.getExecuteFormsBatchRequest(batchRequest: batchRequest){ (response, error)  in
            if error == nil {
                if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                    let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                    for resourcePath in responseDic.allKeys{
                        let headerSet = resourcePath as! String
                        if headerSet == formAssingmentSet{
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAssignDataModel.self)
                            if  let formAssignedArr = dict["data"] as? [FormAssignDataModel]{
                                self.predefinedFormArray.removeAll()
                                self.predefinedFormArray = formAssignedArr
                            }
                        }
                    }
                    self.getManualCheckSheetDataWithBatchRequest()
                }
            }
        }
    }
    func getManualCheckSheetDataWithBatchRequest(){
        
        var batchQueryArr = [String]()
        var formQuery = ""
        
        if FORM_ASSIGNMENT_TYPE == "6" {
            formQuery = "\(formManualAssignmentSet)?$filter=(WorkOrderNum eq '\(singleWorkOrder.WorkOrderNum)')&$orderby=Mandatory desc"
            batchQueryArr.append(formQuery)
        }else if FORM_ASSIGNMENT_TYPE == "7" || FORM_ASSIGNMENT_TYPE == "10"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formManualAssignmentSet)?$filter=\(myAssetDataManager.getAssignementType7Query())&$orderby=Mandatory desc"
            }else{
                formQuery = "\(formManualAssignmentSet)?$filter=(WorkOrderNum eq '\(singleOperation.WorkOrderNum)' and OprNum eq '\(singleOperation.OperationNum)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
        }else if FORM_ASSIGNMENT_TYPE == "8"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formManualAssignmentSet)?$filter=\(myAssetDataManager.getAssignmentType8Query())&$orderby=Mandatory desc"
            }else{
                formQuery = "\(formManualAssignmentSet)?$filter=(Equipment eq '\(singleOperation.Equipment)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
        }else if FORM_ASSIGNMENT_TYPE == "9"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                formQuery = "\(formManualAssignmentSet)?$filter=\(myAssetDataManager.getAssignmentType9Query())&$orderby=Mandatory desc"
            }else{
                formQuery = "\(formManualAssignmentSet)?$filter=(FuncLocCategory eq '\(singleOperation.FuncLoc)')&$orderby=Mandatory desc"
            }
            batchQueryArr.append(formQuery)
        }
        let batchRequest = SODataRequestParamBatchDefault.init()
        for query in batchQueryArr {
            let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: query)
            reqParam?.customTag = query
            batchRequest.batchItems.add(reqParam!)
        }
        FormsBatchRequestModel.getExecuteFormsBatchRequest(batchRequest: batchRequest){ (response, error)  in
            if error == nil {
                if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                    let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                    for resourcePath in responseDic.allKeys{
                        let headerSet = resourcePath as! String
                        if headerSet == formManualAssignmentSet{
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAssignDataModel.self)
                            if  let responseArr = dict["data"] as? [FormAssignDataModel]{
                                self.manualCheckSheetListArray.removeAll()
                                self.manualCheckSheetListArray = responseArr
                            }
                        }
                    }
                    self.formApprovalVC.updateUI()
                }
            }
        }
    }
    func getApproverMasterList(){
        ApproverMasterDataModel.getApproverMasterDataData(){ (response, error) in
            if error == nil{
                if let responseArr = response["data"] as? [ApproverMasterDataModel]{
                    self.formApproverArray.removeAll()
                    self.formApproverListArray.removeAll()
                    self.formApproverArray = responseArr
                    self.formApproverListArray = responseArr
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.checkSheetAvailabilityVC.updateApproverMasterListUI()
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getAddedApproverListForCheckSheet(form: FormAssignDataModel){
        
        var defineQuery = ""
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            defineQuery = "$filter=(FormID eq '\(form.FormID)' and Version eq '\(form.Version)' and WorkOrderNum eq '\(singleOperation.WorkOrderNum)' and OprNum eq '\(singleOperation.OperationNum)')"
        }else{
            defineQuery = "$filter=(FormID eq '\(form.FormID)' and Version eq '\(form.Version)' and WorkOrderNum eq '\(singleWorkOrder.WorkOrderNum)')"
        }
        FormAssignDataModel.getFormApproverData(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FormAssignDataModel]{
                    self.checkSheetAvailabilityVC.checkSheetApproversList = responseArr
                    self.checkSheetAvailabilityVC.previewSelectedApprovers.removeAll()
                    for item in responseArr{
                        let approverArr = self.formApproverListArray.filter{$0.UserSystemID == "\(item.ApproverID)"}
                        if approverArr.count > 0{
                            self.checkSheetAvailabilityVC.previewSelectedApprovers.append(approverArr[0])
                        }
                    }
                }
                self.checkSheetAvailabilityVC.updateSelectedApproverUI()
            }
        }
    }
    func deleteAppoverFromCheckSheet(count:Int){
        if count == self.checkSheetAvailabilityVC.deletedApprovers.count{
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(self.checkSheetAvailabilityVC, title: MessageTitle, message: "Approver Added sucessfully", button: okay)
        }else{
            var flush = false
            if count == self.checkSheetAvailabilityVC.deletedApprovers.count - 1{
                flush = true
            }
            FormAssignDataModel.deleteFormApprovalEntry(entity: self.checkSheetAvailabilityVC.deletedApprovers[count],  flushRequired: flush, options: nil){(reponse, error) in
                if error == nil{
                    mJCLogger.log("Approver deleted successfully", Type: "Debug")
                    self.deleteAppoverFromCheckSheet(count: count + 1)
                }else{
                    mJCLogger.log("Faild to delete approver please try again! Reason \(error)", Type: "Error")
                    self.deleteAppoverFromCheckSheet(count: count + 1)
                }
            }
        }
    }
    func addApproverToCheckSheet(count:Int,entityList:[SODataEntityDefault]){
        mJCLoader.startAnimating(status: "Updating")
        if entityList.count ==  count{
            if self.checkSheetAvailabilityVC.deletedApprovers.count > 0{
                self.deleteAppoverFromCheckSheet(count: 0)
            }else{
                mJCLoader.stopAnimating()
                mJCAlertHelper.showAlert(self.checkSheetAvailabilityVC, title: MessageTitle, message: "Approver Added sucessfully", button: okay)
            }
        }else{
            var flushReq = false
            if (count == entityList.count - 1) && self.checkSheetAvailabilityVC.deletedApprovers.count == 0{
                flushReq = true
            }
            let entity = entityList[count]
            FormAssignDataModel.createFormApprovalEntry(entity: entity,  flushRequired: flushReq, options: nil){ (reponse, error) in
                if error == nil{
                    mJCLogger.log("Approver added successfully", Type: "Debug")
                    self.addApproverToCheckSheet(count: count + 1, entityList: entityList)
                }else{
                    mJCLogger.log("Faild to add approver please try again! Reason \(error)", Type: "Error")
                    self.addApproverToCheckSheet(count: count + 1, entityList: entityList)
                }
            }
        }
    }
    func getApproverStatus(){
        let response = formApprovalStatusVC.selectedformResponse
        let defineQuery = "$filter=(FormID eq '\(response.FormID)' and Version eq '\(response.Version)' and FormInstanceID eq '\(response.InstanceID)' and FormSubmittedBy eq '\(response.CreatedBy)')"
        FormResponseApprovalStatusModel.getFormResponseApprovalStatusData(filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FormResponseApprovalStatusModel]{
                    self.formApproverStatusArray.removeAll()
                    self.formApproverStatusListArray.removeAll()
                    self.formApproverStatusArray = responseArr
                    self.formApproverStatusListArray = responseArr
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.formApprovalStatusVC.updateListUI()
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    //MARK:CheckSheet Master List
    func getCheckSheetList(){
        FormMasterMetaDataModel.getFormMasterDataList(){(response, error) in
            if error == nil{
                if let responseArr = response["data"] as? [FormMasterMetaDataModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.checkSheetArray.removeAll()
                    self.checkSheetListArray.removeAll()
                    self.checkSheetArray = responseArr
                    self.checkSheetListArray = responseArr
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                if self.checkSheetAvailabilityVC != nil{
                    self.checkSheetAvailabilityVC.updateCheckSheetMasterUI()
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getCheckApproverList(from:String){
        FormAssignDataModel.getFormApproverData(){(response, error) in
            if error == nil{
                if let responseArr = response["data"] as? [FormAssignDataModel]{
                    self.checksheetApproverArr.removeAll()
                    self.checksheetApproverArr = responseArr
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
            if from == "Approver"{
                self.getPredefinedCheckSheetDataWithBatchRequest()
            }
        }
    }
}
