//
//  checkSheetViewModel.swift
//  myJobCard
//
//  Created by Suri on 05/01/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class checkSheetViewModel {

    weak var delegate: viewModelDelegate?
    var orderTypeFeatureDict = NSMutableDictionary()
    var checkSheetFilledDone = false
    var formAssignmentType = String()
    var woAssigmentType = String()
    var woObj = WoHeaderModel()
    var oprObj = WoOperationModel()
    var userID = String()

    //CheckSheet list
    var predefinedFormArray = Array<FormAssignDataModel>()
    var predefinedFormListArray = Array<FormAssignDataModel>()
    var manualFormArray = Array<FormAssignDataModel>()
    var manualFormListArray = Array<FormAssignDataModel>()
    var predefinedRespArray = Array<FormResponseCaptureModel>()
    var manualRespArray = Array<FormResponseCaptureModel>()
    var formRespArray = Array<FormResponseCaptureModel>()
    //General CheckSheet
    var generalFormArray = Array<FormAssignDataModel>()
    var generalFormListArray = Array<FormAssignDataModel>()
    var generalFilledFormArray = Array<FormAssignDataModel>()
    var generalFilledFormListArray = Array<FormAssignDataModel>()
    var generalFormRespArray = Array<FormResponseCaptureModel>()

    func getPredefinedCheckSheetDataWithBatchRequest(fromCount:Bool? = false){

        var batchQueryArr = [String]()
        var formQuery = ""
        var respQuery = ""
        var draftQuery = String()
        if fromCount == true{
            draftQuery = " and (IsDraft ne 'X')"
        }
        if formAssignmentType == "1" {
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '' and OrderType eq '\(woObj.OrderType)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery)"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '' and OrderType eq '\(oprObj.OrderType)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)'\(draftQuery))"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }else if formAssignmentType == "2"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formAssingmentSet)?$filter=\(myAssetDataManager.getAssignementType2Query())"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '\(oprObj.ControlKey)' and OrderType eq '\(oprObj.OrderType)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)'\(draftQuery))"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)

        }else if formAssignmentType == "3"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formAssingmentSet)?$filter=\(myAssetDataManager.getAssignmentType3Query())"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(EquipCategory eq '\(oprObj.EquipCategory)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and Equipment eq '\(oprObj.Equipment)'\(draftQuery))"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }else if formAssignmentType == "4"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formAssingmentSet)?$filter=\(myAssetDataManager.getAssignement4Query())"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(FuncLocCategory eq '\(oprObj.FuncLocCategory)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and FunctionLocation eq '\(oprObj.FuncLoc)'\(draftQuery)"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }else if  formAssignmentType == "5" || formAssignmentType == "10"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
                batchQueryArr.append(myAssetDataManager.getAssignement5Query())
                batchQueryArr.append(respQuery)
            }else{
                formQuery = "\(formAssingmentSet)?$filter=(ControlKey eq '\(oprObj.ControlKey)' and OrderType eq '\(oprObj.OrderType)' and TaskListType eq '\(oprObj.TaskListType)' and Group eq '\(oprObj.Group)' and GroupCounter eq '\(oprObj.GroupCounter)' and InternalCounter eq '\(oprObj.InternalCounter)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)'\(draftQuery))"
                batchQueryArr.append(formQuery)
                batchQueryArr.append(respQuery)
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
                                self.predefinedFormListArray.removeAll()
                                self.predefinedFormListArray = formAssignedArr
                                self.predefinedFormArray.removeAll()
                                self.predefinedFormArray = formAssignedArr
                            }
                        }else if headerSet == responseCaptureSet{
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseCaptureModel.self)
                            if  let responseArr = dict["data"] as? [FormResponseCaptureModel]{
                                self.predefinedRespArray = responseArr
                            }
                        }
                    }
                    if self.predefinedRespArray.count > 0 {
                        for tempCount in 0..<self.predefinedFormListArray.count {
                            let formDataClass = self.predefinedFormListArray[tempCount]
                            var checkSheetCount = 0
                            for count in 0..<self.predefinedRespArray.count {
                                if count < self.predefinedRespArray.count{
                                    let formResponseCaptureClass = self.predefinedRespArray[count]
                                    if(formDataClass.FormID == formResponseCaptureClass.FormID && formDataClass.Version == formResponseCaptureClass.Version) {
                                        checkSheetCount = checkSheetCount + 1
                                        formDataClass.filledFormCount = checkSheetCount
                                    }else {
                                        continue
                                    }
                                }
                            }
                        }
                    }
                    self.getManualCheckSheetDataWithBatchRequest(checkSheetList: self.predefinedFormListArray, respList: self.predefinedRespArray, fromCount: fromCount!)
                }
            }else{
                self.getManualCheckSheetDataWithBatchRequest(checkSheetList: [], respList: [], fromCount: fromCount!)
            }
        }
    }
    func getManualCheckSheetDataWithBatchRequest(checkSheetList:[FormAssignDataModel],respList:[FormResponseCaptureModel],fromCount:Bool){

        var batchQueryArr = [String]()
        var formQuery = ""
        var respQuery = ""
        var draftQuery = String()
        if fromCount == true{
            draftQuery = " and (IsDraft ne 'X')"
        }

        if  formAssignmentType == "6" {
            formQuery = "\(formManualAssignmentSet)?$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)')"
            respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery)"
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }else if  formAssignmentType == "7" ||  formAssignmentType == "10"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formManualAssignmentSet)?$filter=\(myAssetDataManager.getAssignementType7Query())"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
            }else{
                formQuery = "\(formManualAssignmentSet)?$filter=(WorkOrderNum eq '\(oprObj.WorkOrderNum)' and OprNum eq '\(oprObj.OperationNum)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)'\(draftQuery))"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }else if  formAssignmentType == "8"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formManualAssignmentSet)?$filter=\(myAssetDataManager.getAssignmentType8Query())"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
            }else{
                formQuery = "\(formManualAssignmentSet)?$filter=(Equipment eq '\(oprObj.Equipment)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and Equipment eq '\(oprObj.Equipment)'\(draftQuery))"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }else if  formAssignmentType == "9"{
            if woAssigmentType == "1" || woAssigmentType == "3"{
                formQuery = "\(formManualAssignmentSet)?$filter=\(myAssetDataManager.getAssignmentType9Query())"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(woObj.WorkOrderNum)'\(draftQuery))"
            }else{
                formQuery = "\(formManualAssignmentSet)?$filter=(FuncLocCategory eq '\(oprObj.FuncLoc)')"
                respQuery = "\(responseCaptureSet)?$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and FuncLoc eq '\(oprObj.FuncLoc)'\(draftQuery))"
            }
            batchQueryArr.append(formQuery)
            batchQueryArr.append(respQuery)
        }
        let statusQuery = "\(formResponseApprovalStatusSet)?$filter=(FormContentStatus eq 'REJECT')"
        batchQueryArr.append(statusQuery)
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
                    var formApprovalStatusArr = [FormResponseApprovalStatusModel]()
                    for resourcePath in responseDic.allKeys{
                        let headerSet = resourcePath as! String
                        if headerSet == formManualAssignmentSet{
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAssignDataModel.self)
                            if  let formAssignedArr = dict["data"] as? [FormAssignDataModel]{
                                self.manualFormArray.removeAll()
                                self.manualFormArray = formAssignedArr
                                self.manualFormListArray.removeAll()
                                self.manualFormListArray =  formAssignedArr
                            }
                        }else if headerSet == responseCaptureSet{
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseCaptureModel.self)
                            if  let responseArr = dict["data"] as? [FormResponseCaptureModel]{
                                self.manualRespArray = responseArr
                            }
                        }else if headerSet == formResponseApprovalStatusSet {
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseApprovalStatusModel.self)
                            if  let formresparray = dict["data"] as? [FormResponseApprovalStatusModel]{
                                if formresparray.count > 0{
                                    formApprovalStatusArr = formresparray
                                }
                            }
                        }
                    }
                    if self.manualRespArray.count > 0 {
                        for tempCount in 0..<self.manualFormArray.count {
                            let formDataClass = self.manualFormArray[tempCount]
                            var checkSheetCount = 0
                            for count in 0..<self.manualRespArray.count {
                                if count < self.manualRespArray.count{
                                    let formResponseCaptureClass = self.manualRespArray[count]
                                    if(formDataClass.FormID == formResponseCaptureClass.FormID && formDataClass.Version == formResponseCaptureClass.Version) {
                                        checkSheetCount = checkSheetCount + 1
                                        formDataClass.filledFormCount = checkSheetCount
                                    }else {
                                        continue
                                    }
                                }
                            }
                        }
                    }
                    let prdMandatoryCountArry = checkSheetList.filter{$0.Mandatory == "X"}
                    let manualMandatoryCountArry = self.manualFormArray.filter{$0.Mandatory == "X"}
                    let mandCount = prdMandatoryCountArry.count + manualMandatoryCountArry.count
                    var formList = [FormAssignDataModel]()
                    formList.append(contentsOf: checkSheetList)
                    formList.append(contentsOf: self.manualFormArray)
                    var respList = [FormResponseCaptureModel]()
                    respList.append(contentsOf: respList)
                    respList.append(contentsOf: self.manualRespArray)
                    if fromCount == true{
                        self.setCheckSheetViewCount(workorder: self.woObj, mendatoryFormCount: mandCount, formsAssignArray: formList, responseformArr: respList, formStatusArr: formApprovalStatusArr, fromBatch: true)
                    }else{
                        self.delegate?.dataFetchCompleted?(type: "CheckSheetList", object: [])
                    }
                }
            }else{
                let prdMandatoryCountArry = checkSheetList.filter{$0.Mandatory == "X"}
                var formList = [FormAssignDataModel]()
                formList.append(contentsOf: checkSheetList)
                var respList = [FormResponseCaptureModel]()
                respList.append(contentsOf: respList)
                if fromCount == true{
                    self.setCheckSheetViewCount(workorder: self.woObj, mendatoryFormCount: prdMandatoryCountArry.count, formsAssignArray: formList, responseformArr: respList, formStatusArr: [], fromBatch: true)
                }else{
                    self.delegate?.dataFetchCompleted?(type: "CheckSheetList", object: [])
                }
            }
        }
    }
    func getFilledCheckSheetList(formClass:FormAssignDataModel) {
        var defineQuery = String()

        if FORM_ASSIGNMENT_TYPE == "1" || FORM_ASSIGNMENT_TYPE == "6"{
            defineQuery = "$filter=(CreatedBy eq '\(userID)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
        }else if FORM_ASSIGNMENT_TYPE == "2" || FORM_ASSIGNMENT_TYPE == "7"{
            if WO_OP_OBJS_DISPLAY == "X"{
                defineQuery = "$filter=(CreatedBy eq '\(userID)' and (WoNum eq '\(oprObj.WorkOrderNum)') and (OperationNum eq '\(oprObj.OperationNum)') and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
            }else{
                defineQuery = "$filter=(CreatedBy eq '\(userID)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
            }
        }else if FORM_ASSIGNMENT_TYPE == "3" || FORM_ASSIGNMENT_TYPE == "8"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if  WO_OP_OBJS_DISPLAY == "X"{
                    defineQuery = "$filter=(CreatedBy eq '\(userID)' and (WoNum eq '\(oprObj.WorkOrderNum)') and (OperationNum eq '\(oprObj.OperationNum)') and (Equipment eq '\(oprObj.Equipment)') and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
                }else{
                    defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(woObj.WorkOrderNum)' and Equipment eq '\(woObj.EquipNum)' and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
                }
            }else{
                defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(woObj.WorkOrderNum)' and Equipment eq '\(woObj.EquipNum)' and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
            }
        }else if FORM_ASSIGNMENT_TYPE == "4"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if  WO_OP_OBJS_DISPLAY == "X"{
                    defineQuery = "$filter=(CreatedBy eq '\(userID)' and (WoNum eq '\(oprObj.WorkOrderNum)') and (OperationNum eq '\(oprObj.OperationNum)') (and FunctionLocation eq '\(oprObj.FuncLoc)') and (FormID eq '\(formClass.FormID)'))$orderby=CreatedOn desc"
                }else{
                    defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(woObj.WorkOrderNum)' and FunctionLocation eq '\(woObj.FuncLocation)' and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
                }
            }else{
                defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(woObj.WorkOrderNum)' and FunctionLocation eq '\(woObj.FuncLocation)' and (FormID eq '\(formClass.FormID)'))&$orderby=CreatedOn desc"
            }
        }else if FORM_ASSIGNMENT_TYPE == "5"{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if  WO_OP_OBJS_DISPLAY == "X"{
                    defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and FormID eq '\(formClass.FormID)')"
                }else{
                    defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(woObj.WorkOrderNum)' and FormID eq '\(formClass.FormID)')"
                }
            }else{
                defineQuery = "$filter=(CreatedBy eq '\(userID)' and WoNum eq '\(woObj.WorkOrderNum)' and FormID eq '\(formClass.FormID)')"
            }
        }
        if defineQuery == ""{
            return
        }
        FormResponseCaptureModel.getFormResponseCaptureData(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FormResponseCaptureModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.formRespArray.removeAll()
                        self.formRespArray =  responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "filledCheckSheetData", object: [])
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "filledCheckSheetData", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getGeneralCheckSheetDataBatchRequest(fromCount:Bool? = false){

        var batchQueryArr = [String]()
        let formQuery = "\(formAssingmentSet)?$filter=(Category eq 'NonObject')"
        let respQuery = "\(responseCaptureSet)?$filter=(NonObjType eq 'X')"

        batchQueryArr.append(formQuery)
        batchQueryArr.append(respQuery)
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
                                self.generalFormArray.removeAll()
                                self.generalFormArray = formAssignedArr
                                self.generalFormListArray.removeAll()
                                self.generalFormListArray = formAssignedArr
                            }
                        }else if headerSet == responseCaptureSet{
                            let dictval = responseDic.value(forKey: headerSet) as! [String:Any]
                            let dict = FormsFormateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseCaptureModel.self)
                            if  let responseArr = dict["data"] as? [FormResponseCaptureModel]{
                                self.generalFormRespArray = responseArr
                            }
                        }
                    }
                    if self.generalFormRespArray.count > 0 {
                        var filledArr = [FormAssignDataModel]()
                        for assignedForm in self.generalFormArray{
                            let respArr = self.generalFormRespArray.filter{$0.FormID == "\(assignedForm.FormID)" && $0.Version == "\(assignedForm.Version)"}
                            if respArr.count > 0{
                                assignedForm.filledFormCount = respArr.count
                                filledArr.append(assignedForm)
                            }
                        }
                        self.generalFilledFormArray = filledArr
                        self.generalFilledFormListArray = filledArr
                    }
                }
                self.delegate?.dataFetchCompleted?(type: "GeneralCheckSheetList", object: [])
            }else{
                self.delegate?.dataFetchCompleted?(type: "GeneralCheckSheetList", object: [])
            }
        }
    }
    func getFilledGeneralCheckSheetData(formClass:FormAssignDataModel){

        let defineQuery = "$filter=(CreatedBy eq '\(userID)' and FormID eq '\(formClass.FormID)' and NonObjType eq 'X')&$orderby=CreatedOn"

        FormResponseCaptureModel.getFormResponseCaptureData(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FormResponseCaptureModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.generalFormRespArray.removeAll()
                        self.generalFormRespArray =  responseArr
                    }
                    self.delegate?.dataFetchCompleted?(type: "filledGeneralCheckSheetData", object: [])
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "filledGeneralCheckSheetData", object: [])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setCheckSheetViewCount(workorder: WoHeaderModel,mendatoryFormCount: Int,formsAssignArray:[FormAssignDataModel],responseformArr:[FormResponseCaptureModel],formStatusArr:[FormResponseApprovalStatusModel],fromBatch:Bool) {

        var checkSheetCount = String()
        var checkSheetColor = UIColor()
        if let featureListArr =  self.orderTypeFeatureDict.value(forKey: workorder.OrderType) {
            if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary {
                if let featurelist = featureDict.allKeys as? [String]{
                    if featurelist.contains("WORKORDERFORM"){
                        let mandLevel = featureDict.value(forKey: "WORKORDERFORM") as? String ?? ""
                        if mendatoryFormCount > 0{
                            if mandLevel == "2"{
                                let filteraarr = formsAssignArray.filter{$0.Mandatory == "X" && $0.filledFormCount == 0}
                                if filteraarr.count > 0{
                                    checkSheetFilledDone = false
                                    checkSheetCount = "\(filteraarr.count)"
                                    checkSheetColor = UIColor.red
                                }else{
                                    let filteraarr = formsAssignArray.filter{$0.Mandatory == "X" &&  $0.filledFormCount != 0}
                                    if filteraarr.count == formsAssignArray.count{
                                        var rejected = false
                                        for form in filteraarr{
                                            let responseArr = responseformArr.filter{$0.FormID == "\(form.FormID)" && $0.Version == "\(form.Version)"}
                                            for resp in responseArr{
                                                let statusArr = formStatusArr.filter{$0.FormID == "\(resp.FormID)" && $0.Version == "\(resp.Version)" && $0.FormInstanceID == "\(resp.InstanceID)"}
                                                if statusArr.count > 0{
                                                    rejected = true
                                                    break
                                                }
                                            }
                                        }
                                        if rejected == true{
                                            checkSheetFilledDone = false
                                            checkSheetCount = "\(filteraarr.count)"
                                            checkSheetColor = UIColor.red
                                        }else{
                                            checkSheetFilledDone = true
                                            checkSheetCount = "\(filteraarr.count)"
                                            checkSheetColor = appColor
                                        }
                                    }else{
                                        checkSheetFilledDone = false
                                        checkSheetCount = "\(filteraarr.count)"
                                        checkSheetColor = filledCountColor
                                    }
                                }
                            }else if mandLevel == "1"{
                                let filteraarr = formsAssignArray.filter{$0.Mandatory == "X" &&  $0.filledFormCount != 0}
                                if filteraarr.count > 0{
                                    var rejected = false
                                    for form in filteraarr{
                                        let responseArr = responseformArr.filter{$0.FormID == "\(form.FormID)" && $0.Version == "\(form.Version)"}
                                        for resp in responseArr{
                                            let statusArr = formStatusArr.filter{$0.FormID == "\(resp.FormID)" && $0.Version == "\(resp.Version)" && $0.FormInstanceID == "\(resp.InstanceID)"}
                                            if statusArr.count > 0{
                                                rejected = true
                                                break
                                            }
                                        }
                                    }
                                    checkSheetCount = "\(filteraarr.count)"
                                    if rejected == true{
                                        checkSheetFilledDone = false
                                        checkSheetColor = UIColor.red
                                    }else{
                                        checkSheetFilledDone = true
                                        if filteraarr.count == formsAssignArray.count{
                                            checkSheetColor = appColor
                                        }else{
                                            checkSheetColor = filledCountColor
                                        }
                                    }
                                }else{
                                    checkSheetFilledDone = false
                                    checkSheetCount = "\(formsAssignArray.count)"
                                    checkSheetColor = UIColor.red
                                }
                            }
                        }else{
                            let filteraarr = formsAssignArray.filter{$0.filledFormCount != 0}
                            if filteraarr.count > 0{
                                var rejected = false
                                for form in filteraarr{
                                    let responseArr = responseformArr.filter{$0.FormID == "\(form.FormID)" && $0.Version == "\(form.Version)"}
                                    for resp in responseArr{
                                        let statusArr = formStatusArr.filter{$0.FormID == "\(resp.FormID)" && $0.Version == "\(resp.Version)" && $0.FormInstanceID == "\(resp.InstanceID)"}
                                        if statusArr.count > 0{
                                            rejected = true
                                            break
                                        }
                                    }
                                }
                                checkSheetCount = "\(filteraarr.count)"
                                if rejected == true{
                                    checkSheetFilledDone = false
                                    checkSheetColor = UIColor.red
                                }else{
                                    checkSheetFilledDone = true
                                    if filteraarr.count == formsAssignArray.count{
                                        checkSheetColor = appColor
                                    }else{
                                        checkSheetColor = filledCountColor
                                    }
                                }
                            }else{
                                checkSheetFilledDone = true
                                checkSheetCount = "\(formsAssignArray.count)"
                                checkSheetColor = filledCountColor
                            }
                        }
                    }else if featurelist.contains("OPERATIONFORM"){
                        let mandLevel = featureDict.value(forKey: "OPERATIONFORM") as? String ?? ""
                        if mendatoryFormCount > 0{
                            if mandLevel == "2"{
                                let filteraarr = formsAssignArray.filter{$0.Mandatory == "X" && $0.filledFormCount == 0}
                                if filteraarr.count > 0{
                                    checkSheetFilledDone = false
                                    checkSheetCount = "\(filteraarr.count)"
                                    checkSheetColor = UIColor.red
                                }else{
                                    let filteraarr = formsAssignArray.filter{$0.Mandatory == "X" &&  $0.filledFormCount != 0}
                                    if filteraarr.count == formsAssignArray.count{
                                        checkSheetFilledDone = true
                                        checkSheetCount = "\(filteraarr.count)"
                                        checkSheetColor = appColor
                                    }else{
                                        checkSheetFilledDone = false
                                        checkSheetCount = "\(filteraarr.count)"
                                        checkSheetColor = filledCountColor
                                    }
                                }
                            }else if mandLevel == "1"{
                                let filteraarr = formsAssignArray.filter{$0.Mandatory == "X" &&  $0.filledFormCount != 0}
                                if filteraarr.count > 0{
                                    checkSheetFilledDone = true
                                    if filteraarr.count == formsAssignArray.count{
                                        checkSheetCount = "\(filteraarr.count)"
                                        checkSheetColor = appColor
                                    }else{
                                        checkSheetCount = "\(formsAssignArray.count)"
                                        checkSheetColor = filledCountColor
                                    }
                                }else{
                                    checkSheetFilledDone = false
                                    checkSheetCount = "\(formsAssignArray.count)"
                                    checkSheetColor = UIColor.red
                                }
                            }
                        }else{
                            checkSheetFilledDone = true
                            checkSheetCount = "\(formsAssignArray.count)"
                            checkSheetColor = filledCountColor
                        }
                    }else{
                        checkSheetFilledDone = true
                        checkSheetCount = "\(formsAssignArray.count)"
                        checkSheetColor = filledCountColor
                    }
                }
            }
        }else{
            checkSheetFilledDone = true
            checkSheetCount = "\(formsAssignArray.count)"
            checkSheetColor = filledCountColor
        }
        if fromBatch == true{
            var dict = [String:Any]()
            dict["checkSheetCount"] = checkSheetCount
            dict["checkSheetColor"] = checkSheetColor
            self.delegate?.dataFetchCompleted?(type: "CheckSheetCount", object: [dict])
        }else{
            self.delegate?.setBadgeCount?(type: "CheckSheetCount", count: checkSheetCount, badgeColor: checkSheetColor)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
