//
//  File.swift
//  myJobCard
//
//  Created by Suri on 12/05/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class checkSheetViewerViewModel {
    
    weak var delegate: viewModelDelegate?
    var formAssignmentType = String()
    var woAssigmentType = String()
    var woObj = WoHeaderModel()
    var oprObj = WoOperationModel()
    var userId = String()
    
    var formMasterArry = [FormMasterModel]()
    var checkSheetAttachArray = [Any]()
    var checkSheetQuestionImgArry = [FormQuestionImageModel]()
    var property = NSMutableArray()


    func getInstanceID() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = dateFormatter.string(from: NSDate() as Date)
        return ("FE" + dateString)
    }
    func getFormDetailsWithBatchRequest(options: [String:Any]){
        
        let fromScreen = options["fromScreen"] as? String ?? ""
        let isfromError = options["fromError"] as? Bool ?? false
        let isFromEditScreen  = options["fromEdit"] as? Bool ?? false
        let reviewerRespClass = options["reviewerResp"] as? FormReviewerResponseModel ?? FormReviewerResponseModel()
        let formRespClass =  options["formResp"] as? FormResponseCaptureModel ?? FormResponseCaptureModel()
        let formClass = options["formModel"] as? FormAssignDataModel ?? FormAssignDataModel()
        
        let batchArr = NSMutableArray()
        if isfromError == true || isFromEditScreen == true {
            if fromScreen == "Reviewer"{
                let formQuery = "\(formMasterSet)?$filter=(FormID eq '\(reviewerRespClass.FormID)' and Version eq '\(reviewerRespClass.Version)')"
                let attachmentQuery = "\(formAttachmentSet)?$filter=(ObjectNum eq '\(reviewerRespClass.WoNum)' and FormId eq '\(reviewerRespClass.FormID)' and InstanceId eq '\(reviewerRespClass.InstanceID)' and Version eq '\(reviewerRespClass.Version)')"
                let questionQuery = "\(formImageSet)?$filter=(Formid eq '\(reviewerRespClass.FormID)' and Version eq '\(reviewerRespClass.Version)'"
                batchArr.add(formQuery)
                batchArr.add(attachmentQuery)
                batchArr.add(questionQuery)
            }else{
                let formQuery = "\(formMasterSet)?$filter=(FormID eq '\(formRespClass.FormID)' and Version eq '\(formRespClass.Version)')"
                let attachmentQuery = "\(formAttachmentSet)?$filter=(ObjectNum eq '\(woObj.WorkOrderNum)' and FormId eq '\(formRespClass.FormID)' and InstanceId eq '\(formRespClass.InstanceID)' and Version eq '\(formRespClass.Version)')"
                let questionQuery = "\(formImageSet)?$filter=(Formid eq '\(formRespClass.FormID)' and Version eq '\(formRespClass.Version)'"
                batchArr.add(formQuery)
                batchArr.add(attachmentQuery)
                batchArr.add(questionQuery)
            }
        }else{
            let formQuery = "\(formMasterSet)?$filter=(FormID eq '\(formClass.FormID)' and Version eq '\(formClass.Version)')"
            let questionQuery = "\(formImageSet)?$filter=(Formid eq '\(formClass.FormID)' and Version eq '\((formClass.Version))')"
            batchArr.add(formQuery)
            batchArr.add(questionQuery)
        }
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
                        if resourcePath == formMasterSet {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormMasterModel.self)
                            if  let formsassignarray = dict["data"] as? [FormMasterModel]{
                                if formsassignarray.count > 0{
                                    self.formMasterArry = formsassignarray
                                }else{
                                    self.formMasterArry.removeAll()
                                }
                            }
                        }else if resourcePath == formAttachmentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAttachmentModel.self)
                            if  let formresparray = dict["data"] as? [FormAttachmentModel]{
                                if formresparray.count > 0{
                                    var arra = Array<Any>()
                                    for i in 0..<formresparray.count{
                                        var dict : [String: String] = [:]
                                        let attach = formresparray[i]
                                        dict["FileName"] = attach.FileName
                                        dict["ImageData"] = attach.ImageData
                                        arra.append(dict)
                                    }
                                    self.checkSheetAttachArray = arra
                                }
                            }
                        }else if resourcePath == formImageSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormQuestionImageModel.self)
                            if  let formresparray = dict["data"] as? [FormQuestionImageModel]{
                                if formresparray.count > 0{
                                    self.checkSheetQuestionImgArry = formresparray
                                }else{
                                    self.checkSheetQuestionImgArry.removeAll()
                                }
                            }
                        }
                    }
                    self.delegate?.dataFetchCompleted?(type: "CheckSheetViewData", object: [])
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "CheckSheetViewData", object: [])
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getSchemaData(list:Array<String>,count:Int,xmlFile : String,checkSheetModel:String? = "", checkSheetHtml:String? = ""){
        mJCLogger.log("Starting", Type: "info")
        var valuetype = String()
        if list.count == count{
            var modelString = checkSheetModel!
            var formString = checkSheetHtml!
            
            modelString = modelString.trimmingCharacters(in: .whitespacesAndNewlines)
            modelString = modelString.replacingOccurrences(of: "\n", with: "")
            modelString = modelString.replacingOccurrences(of: "\r", with: "")
            modelString = modelString.replacingOccurrences(of:"  =", with: " =")
            modelString = modelString.replacingOccurrences(of:"  ", with: "")
            modelString = modelString.replacingOccurrences(of:" /", with: "/")
            modelString = modelString.replacingOccurrences(of:" \"", with: "\"")
            
            formString = formString.trimmingCharacters(in: .whitespacesAndNewlines)
            formString = formString.replacingOccurrences(of: "\n", with: "")
            formString = formString.replacingOccurrences(of: "\r", with: "")
            formString = formString.replacingOccurrences(of:"  =", with: " =")
            formString = formString.replacingOccurrences(of:"  ", with: "")
            formString = formString.replacingOccurrences(of:" /", with: "/")
            formString = formString.replacingOccurrences(of:" \"", with: "\"")
            formString = formString.replacingOccurrences(of:" '", with: "'")
            formString = formString.replacingOccurrences(of:"&lt;", with: "<")
            formString = formString.replacingOccurrences(of:"&gt;", with: ">")
            
            self.delegate?.dataFetchCompleted?(type: "SchemaData", object: [xmlFile,formString ,modelString])
        }else{
            let strarray = list[count].components(separatedBy: "$")
            if strarray.count > 1{
                if strarray[1].prefix(1) == "v" {
                    valuetype = String(strarray[1].dropFirst())
                }
                if strarray[2].prefix(1) == "e" {
                    let entitiset = String(strarray[2].dropFirst())
                    var displaystrings = String()
                    var queryParam = String()
                    if strarray.count == 4{
                        if strarray[3].prefix(1) == "f"{
                            displaystrings = String(strarray[3].dropFirst())
                        }
                    }
                    if strarray.count == 5{
                        if strarray[3].prefix(1) == "f"{
                            displaystrings = String(strarray[3].dropFirst())
                        }
                        if strarray[4].prefix(2) == "qp"{
                            queryParam = String(strarray[4].dropFirst(2))
                        }
                    }
                    DispatchQueue.global(qos: .default).async {
                        var definceReq = String()
                        if queryParam != ""{
                            if queryParam == "customCodeGroup"{
                                definceReq = "\(entitiset)?$filter=(Catalog eq 'A' and CodeGroup eq 'PRÜ00001')&$select=\(displaystrings)&$orderby=Code"
                            }else if displaystrings != "" && displaystrings != "count"{
                                definceReq = "\(entitiset)?$filter=(\(queryParam) eq '\(selectedworkOrderNumber)')&$select=\(displaystrings)"
                            }else{
                                definceReq = "\((entitiset))?$filter=\(queryParam) eq '\(selectedworkOrderNumber)'"
                            }
                        }else{
                            if displaystrings != "" && displaystrings != "count"{
                                definceReq = entitiset + "?$select=\(displaystrings)"
                            }else{
                                definceReq = entitiset
                            }
                        }
                        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(entitiset)"}
                        mJCLogger.log("Response :\(storeArray.count)", Type: "Debug")
                        if storeArray.count > 0{
                            let store = storeArray[0]
                            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: definceReq, storeName: store.AppStoreName){ (response, error)  in
                                if(error == nil) {
                                    if let data = response.value(forKey:"data") as? NSMutableArray {
                                        mJCLogger.log("Response :\(data.count)", Type: "Debug")
                                        if data.count > 0{
                                            if displaystrings == "count"{
                                                var newfile = String()
                                                let html = checkSheetHtml
                                                var model = checkSheetModel
                                                if valuetype == "C"{
                                                    if html != "" && model != ""{
                                                        model = model!.replacingOccurrences(of: "\(list[count])", with: "\(data.count)")
                                                    }else{
                                                        newfile = xmlFile.replacingOccurrences(of: "\(list[count])", with: "\(data.count)")
                                                    }
                                                }else{
                                                    newfile = xmlFile
                                                }
                                                self.getSchemaData(list: list, count: count + 1, xmlFile: newfile, checkSheetModel: model, checkSheetHtml: html)
                                            }else{
                                                let displayvaluearray = displaystrings.components(separatedBy: ",")
                                                var displayarray = Array<String>()
                                                var valuearray = Array<String>()
                                                var newfile = String()
                                                var html = checkSheetHtml
                                                let model = checkSheetModel
                                                if valuetype == "M"{
                                                    for i in 0..<data.count{
                                                        let dict = data[i] as! NSMutableDictionary
                                                        var displaystring1 = String()
                                                        for i in 0..<displayvaluearray.count{
                                                            var str = (dict.value(forKey: displayvaluearray[i]) as? String ?? "")
                                                            str = "\(str)"
                                                            displaystring1 = displaystring1 + str + " - "
                                                            //"<![CDATA[\(str)]]>"
                                                        }
                                                        displaystring1 =  displaystring1.replacingLastOccurrenceOfString(" - ", with: "")
                                                        displayarray.append(displaystring1)
                                                        valuearray.append(dict.value(forKey: displayvaluearray[0]) as! String)
                                                    }
                                                    let file = xmlFile;
                                                    var newstr = ""
                                                    if html != "" && model != ""{
                                                        for i in 0..<displayarray.count {
                                                            newstr = newstr + "<option value=\"\(valuearray[i])\">\(displayarray[i])</option>"
                                                        }
                                                        html = html!.replacingOccurrences(of: "<option value=\"-999\">\(list[count])</option>", with: newstr)
                                                    }else{
                                                        for i in 0..<displayarray.count {
                                                            newstr = newstr + ("<item><label>\(displayarray[i])</label><value>\(valuearray[i])</value></item>")
                                                        }
                                                        newstr = (newstr as? NSString)?.substring(from: 6) ?? ""
                                                        newstr = (newstr as? NSString)?.substring(to: newstr.count - 7) ?? ""
                                                        newfile = file.replacingOccurrences(of: "<label>\(list[count])</label><value>-999</value>", with: newstr)
                                                    }
                                                }else if valuetype == "S"{
                                                    var displaystring1 = String()
                                                    for i in 0..<data.count{
                                                        let dict = data[i] as! NSMutableDictionary
                                                        for i in 0..<displayvaluearray.count{
                                                            var str = (dict.value(forKey: displayvaluearray[i]) as? String ?? "")
                                                            str = "<![CDATA[\(str)]]>"
                                                            displaystring1 = displaystring1 + str + " - "
                                                        }
                                                        displaystring1 =  displaystring1.replacingLastOccurrenceOfString(" - ", with: "")
                                                    }
                                                    if newfile.contains(find: list[count]){
                                                        newfile = newfile.replacingOccurrences(of: "\(list[count])", with: displaystring1)
                                                    }
                                                    if html != "" && model != ""{
                                                        html = html!.replacingOccurrences(of: "\(list[count])", with: displaystring1)
                                                    }else{
                                                        newfile = newfile.replacingOccurrences(of: "\(list[count])", with: displaystring1)
                                                    }
                                                }else{
                                                    newfile = xmlFile
                                                }
                                                self.getSchemaData(list: list, count: count + 1, xmlFile: newfile, checkSheetModel: model, checkSheetHtml: html)
                                            }
                                        }else{
                                            mJCLogger.log("Data not found", Type: "Debug")
                                            self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                                        }
                                    }else {
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                                    }
                                }else {
                                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                                    self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                                }
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                        }
                    }
                }else{
                    if valuetype == "SCO"{
                        if strarray.indices.contains(2) && strarray[2].prefix(1) == "t" {
                            let str = String(strarray[2].dropFirst())
                            if str == "User"{
                                var file = xmlFile;
                                let html = checkSheetHtml
                                var model = checkSheetModel
                                if strarray.indices.contains(3) && strarray[3].prefix(1) == "f"{
                                    let displayString = String(strarray[3].dropFirst())
                                    if displayString == "Name"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(userId)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(userId)")
                                        }
                                    }
                                }
                                self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                            }else if str == "WorkOrder"{
                                var file = xmlFile;
                                let html = checkSheetHtml
                                var model = checkSheetModel
                                if strarray.indices.contains(3) && strarray[3].prefix(1) == "f"{
                                    let displayString = String(strarray[3].dropFirst())
                                    
                                    if displayString == "WorkOrderNum"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(selectedworkOrderNumber)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(selectedworkOrderNumber)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "ShortText"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.ShortText)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.ShortText)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "FuncLocation"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.FuncLocation)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.FuncLocation)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "EquipNum"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.EquipNum)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.EquipNum)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "WorkCenter"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.MainWorkCtr)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.MainWorkCtr)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "NotificationNum"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.NotificationNum)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleWorkOrder.NotificationNum)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else{
                                        let defineQuery = "\(woHeader)?$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)')&$select=\(displayString)"
                                        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(woHeader)"}
                                        if storeArray.count > 0{
                                            let store = storeArray[0]
                                            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName){ (response, error)  in
                                                if(error == nil) {
                                                    if let data = response.value(forKey:"data") as? NSMutableArray {
                                                        if data.count > 0{
                                                            let dict = data[0] as! NSMutableDictionary
                                                            var displayValue = (dict.value(forKey: displayString) as? String ?? "")
                                                            if displayString.contains("Date"){
                                                                if dict.value(forKey: displayString) != nil{
                                                                    displayValue = (dict.value(forKey: displayString) as! Date).toString(format: .custom(localDateFormate))
                                                                }
                                                            }else{
                                                                displayValue = (dict.value(forKey: displayString) as? String ?? "")
                                                            }
                                                            if html != "" && model != ""{
                                                                model = model!.replacingOccurrences(of: "\(list[count])", with: "\(displayValue)")
                                                            }else{
                                                                file = file.replacingOccurrences(of: "\(list[count])", with: "\(displayValue)")
                                                            }
                                                            self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                        }else{
                                                            self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                        }
                                                    }else{
                                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                    }
                                                }else{
                                                    self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                }
                                            }
                                        }else{
                                            self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                        }
                                    }
                                }else{
                                    self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                }
                            }else if str == "Operation"{
                                var file = xmlFile;
                                let html = checkSheetHtml
                                var model = checkSheetModel
                                if strarray.indices.contains(3) && strarray[3].prefix(1) == "f"{
                                    let displayString = String(strarray[3].dropFirst())
                                    if displayString == "WorkOrderNum"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.WorkOrderNum)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.WorkOrderNum)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "Operation"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.OperationNum)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.OperationNum)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "FunctionalLoc"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.FuncLoc)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.FuncLoc)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "EquipNum"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.Equipment)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.Equipment)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "WorkCenter"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.WorkCenter)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.WorkCenter)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else if displayString == "ShortText"{
                                        if html != "" && model != ""{
                                            model = model!.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.ShortText)")
                                        }else{
                                            file = file.replacingOccurrences(of: "\(list[count])", with: "\(singleOperation.ShortText)")
                                        }
                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                    }else{
                                        let defineQuery = "\(woOperationSet)?$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)' and OperationNum eq '\(selectedOperationNumber)')&$select=\(displayString)"
                                        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(woOperationSet)"}
                                        if storeArray.count > 0{
                                            let store = storeArray[0]
                                            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName){ (response, error)  in
                                                if(error == nil) {
                                                    if let data = response.value(forKey:"data") as? NSMutableArray {
                                                        if data.count > 0{
                                                            let dict = data[0] as! NSMutableDictionary
                                                            var displayValue = (dict.value(forKey: displayString) as? String ?? "")
                                                            if displayString.contains("Date"){
                                                                if dict.value(forKey: displayString) != nil{
                                                                    displayValue = (dict.value(forKey: displayString) as! Date).toString(format: .custom(localDateFormate))
                                                                }
                                                            }else{
                                                                displayValue = (dict.value(forKey: displayString) as? String ?? "")
                                                            }
                                                            if html != "" && model != ""{
                                                                model = model!.replacingOccurrences(of: "\(list[count])", with: "\(displayValue)")
                                                            }else{
                                                                file = file.replacingOccurrences(of: "\(list[count])", with: "\(displayValue)")
                                                            }
                                                            self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                        }else{
                                                            self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                        }
                                                    }else{
                                                        self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                    }
                                                }else{
                                                    self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                                }
                                            }
                                        }else{
                                            self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                        }
                                    }
                                }else{
                                    self.getSchemaData(list: list, count: count + 1, xmlFile: file, checkSheetModel: model, checkSheetHtml: html)
                                }
                            }else{
                                self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                            }
                        }else{
                            self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                        }
                    }else{
                        self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
                    }
                }
            }else{
                self.getSchemaData(list: list, count: count + 1, xmlFile: xmlFile, checkSheetModel: checkSheetModel, checkSheetHtml: checkSheetHtml)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createNewForm(options: [String:Any]) {

        let fromScreen = options["fromScreen"] as? String ?? ""
        let userID = options["userID"] as? String ?? ""
        let fromEdit  = options["fromEdit"] as? String ?? ""
        let xmlString  = options["XMLString"] as? String ?? ""
        let formClass = options["formModel"] as? FormAssignDataModel ?? FormAssignDataModel()
        let attachmentArry = options["attachmentArry"] as! NSMutableArray
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "CreatedBy")
        prop!.value = "\(userID)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = Date().localDate() as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "FormID")
        let date = "\(formClass.FormID)" as NSObject
        prop!.value = date
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "InstanceID")
        let instanceid = self.getInstanceID()
        prop!.value = "\(instanceid)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "OrderType")
        prop!.value = formClass.OrderType as NSObject
        self.property.add(prop!)

        if fromEdit == "TRUE"{
            prop = SODataPropertyDefault(name: "IsDraft")
            prop!.value = "X" as NSObject
            self.property.add(prop!)
        }else{
            prop = SODataPropertyDefault(name: "IsDraft")
            prop!.value = "" as NSObject
            self.property.add(prop!)
        }

        prop = SODataPropertyDefault(name: "ModifiedOn")
        prop!.value = Date().localDate() as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "ResponseData")
        prop!.value = "\(xmlString)" as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "Version")
        prop!.value = "\(formClass.Version)" as NSObject
        self.property.add(prop!)

        if fromScreen == "GeneralCheckList"{
            prop = SODataPropertyDefault(name: "NonObjType")
            prop!.value = "X" as NSObject
            self.property.add(prop!)

            prop = SODataPropertyDefault(name: "WoNum")
            prop!.value = "" as NSObject
            self.property.add(prop!)
        }else{
            prop = SODataPropertyDefault(name: "NonObjType")
            prop!.value = "" as NSObject
            self.property.add(prop!)

            prop = SODataPropertyDefault(name: "WoNum")
            prop!.value = "\(selectedworkOrderNumber)" as NSObject
            self.property.add(prop!)

            if formAssignmentType == "2" || formAssignmentType == "7" || formAssignmentType == "10"{
                prop = SODataPropertyDefault(name: "OperationNum")
                prop!.value = "\(oprObj.OperationNum)" as NSObject
                self.property.add(prop!)
            }else  if formAssignmentType == "3" || formAssignmentType == "8"{
                prop = SODataPropertyDefault(name: "Equipment")
                if woAssigmentType == "1" || woAssigmentType == "3"{
                    prop!.value = "\(woObj.EquipNum)" as NSObject
                }else{
                    prop!.value = "\(oprObj.Equipment)" as NSObject
                }
                self.property.add(prop!)
            }else if formAssignmentType == "4" || formAssignmentType == "9"{
                prop = SODataPropertyDefault(name: "FunctionLocation")
                if woAssigmentType == "1" || woAssigmentType == "3"{
                    prop!.value = "\(woObj.FuncLocation)" as NSObject
                }else{
                    prop!.value = "\(oprObj.FuncLoc)" as NSObject
                }
                self.property.add(prop!)
            }else if formAssignmentType == "5"{
                if woAssigmentType == "2" || woAssigmentType == "4" || woAssigmentType == "5"{
                    prop = SODataPropertyDefault(name: "OperationNum")
                    prop!.value = "\(oprObj.OperationNum)" as NSObject
                    self.property.add(prop!)
                }

                prop = SODataPropertyDefault(name: "TaskListType")
                prop!.value = "\(formClass.TaskListType)" as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "Group")
                prop!.value = "\(formClass.Group)" as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "GroupCounter")
                prop!.value = "\(formClass.GroupCounter)" as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "InternalCounter")
                prop!.value = "\(formClass.InternalCounter)" as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "ControlKey")
                prop!.value = "\(formClass.ControlKey)" as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "EquipCategory")
                prop!.value = "\(formClass.EquipCategory)" as NSObject
                self.property.add(prop!)

                prop = SODataPropertyDefault(name: "FuncLocCategory")
                prop!.value = "\(formClass.FuncLocCategory)" as NSObject
                self.property.add(prop!)
            }
        }
        let entity = SODataEntityDefault(type: responseCaptureSetEntity)
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name as Any)")
            print("Value :\(proper.value!)")
            print("=================")
        }
        var flushReq = Bool()
        if attachmentArry.count > 0 {
            flushReq = false
        }else{
            flushReq = true
        }
        FormResponseCaptureModel.createResponseCaptureEntry(entity: entity!, collectionPath: responseCaptureSet,flushRequired: flushReq ,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "CheckSheetCreated", object: [instanceid,fromEdit])
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.delegate?.dataFetchCompleted?(type: "CreationFailed", object: [])
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func getFilledCheckSheetData(formObj:FormAssignDataModel,formType:String,instanceId: String) {

        var defineQuery = String()
        if formType == "GeneralCheckList"{
            defineQuery = "$filter=(NonObjType eq 'X')"
        }else{
            if formAssignmentType == "1" || formAssignmentType == "6"{
                defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)'))&$orderby=CreatedOn desc"
            }else  if formAssignmentType == "2" || formAssignmentType == "7" || formAssignmentType == "10"{
                if WO_OP_OBJS_DISPLAY == "X"{
                    defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(oprObj.WorkOrderNum)') and (OperationNum eq '\(oprObj.OperationNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)'))&$orderby=CreatedOn desc"
                }else{
                    defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)'))&$orderby=CreatedOn desc"
                }
            }else  if formAssignmentType == "3" || formAssignmentType == "8"{
                if woAssigmentType == "2" || woAssigmentType == "4" || woAssigmentType == "5"{
                    if WO_OP_OBJS_DISPLAY == "X"{
                        defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(oprObj.WorkOrderNum)') and (OperationNum eq '\(oprObj.OperationNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)') and (Equipment eq '\(oprObj.Equipment)'))&$orderby=CreatedOn desc"
                    }else{
                        defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)') and (Equipment eq '\(woObj.EquipNum)'))&$orderby=CreatedOn desc"
                    }
                }else{
                    defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)') and (Equipment eq '\(woObj.EquipNum)'))&$orderby=CreatedOn desc"
                }
            }else if formAssignmentType == "4" || formAssignmentType == "9"{
                if woAssigmentType == "2" || woAssigmentType == "4" || woAssigmentType == "5"{
                    if WO_OP_OBJS_DISPLAY == "X"{
                        defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(oprObj.WorkOrderNum)') and (OperationNum eq '\(oprObj.OperationNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)') and (FunctionLocation eq '\(oprObj.FuncLoc)'))&$orderby=CreatedOn desc"
                    }else{
                        defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)') and (FunctionLocation eq '\(woObj.FuncLocation)'))&$orderby=CreatedOn desc"
                    }
                }else{
                    defineQuery = "$filter=(CreatedBy eq '\(userId)' and (WoNum eq '\(woObj.WorkOrderNum)') and (FormID eq '\(formObj.FormID)') and (Version eq '\(formObj.Version)') and (InstanceID eq '\(instanceId)') and (FunctionLocation eq '\(woObj.FuncLocation)'))&$orderby=CreatedOn desc"
                }
            }else if formAssignmentType == "5"{
                if woAssigmentType == "1" || woAssigmentType == "3"{
                    defineQuery = "$filter=(WoNum eq '\(woObj.WorkOrderNum)' and FormID eq '\(formObj.FormID)'and Version eq '\(formObj.Version)')$orderby=CreatedOn desc"
                }else{
                    defineQuery = "$filter=(WoNum eq '\(oprObj.WorkOrderNum)' and OperationNum eq '\(oprObj.OperationNum)' and FormID eq '\(formObj.FormID)' eq '\(formObj.Version)')$orderby=CreatedOn desc"
                }
            }
            if defineQuery == ""{
                return
            }
        }
        var respClass = FormResponseCaptureModel()
        FormResponseCaptureModel.getFormResponseCaptureData(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FormResponseCaptureModel]{
                    if responseArr.count > 0 {
                        respClass = responseArr[0]
                    }
                    self.delegate?.dataFetchCompleted?(type: "CheckSheetRespData", object: [respClass])
                }else {
                    self.delegate?.dataFetchCompleted?(type: "CheckSheetRespData", object: [respClass])
                }
            }else{
                self.delegate?.dataFetchCompleted?(type: "CheckSheetRespData", object: [respClass])
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func uploadPdfToWoAttachments(docData:NSData,checkSheetName:String){
        
        mJCLogger.log("Starting", Type: "info")
        
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "Form_\(checkSheetName)" as NSObject
        self.property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        prop!.value = "\(checkSheetName)_\(Date().localDate().toString(format: .custom("dd-MM-yyyy:HH:mm"))).pdf" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Extension")
        prop!.value = "pdf" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value =  String(docData.length) as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Line")
        let base64String = docData.base64EncodedString(options: .lineLength64Characters)
        prop!.value = base64String as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "application/x-doctype" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = woObj.WorkOrderNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userId.uppercased() as NSObject
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderAttachmentUploadentity)
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            if proper.name != "Line"{
                print("Key : \(proper.name as Any)")
                mJCLogger.log("Key : \(proper.name as Any)", Type: "Debug")
                print("Value : \(proper.value!)")
                mJCLogger.log("Value : \(proper.value!)", Type: "Debug")
                print(".......................")
            }
            print("........................")
            
        }
        UploadedAttachmentsModel.uploadWoAttachmentEntity(entity: entity!, collectionPath: uploadWOAttachmentContentSet, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "WoAttachAdded", object: [docData])
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.delegate?.dataFetchCompleted?(type: "WoAttachAdded", object: ["error"])
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func uploadPdfToEquipAttachments(docData:NSData,checkSheetName:String){
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "Form_\(checkSheetName)" as NSObject
        self.property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        prop!.value = "\(checkSheetName)_\(Date().localDate().toString(format: .custom("dd-MM-yyyy:HH:mm"))).pdf" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Extension")
        prop!.value = "pdf" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value =  String(docData.length) as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Line")
        let base64String = docData.base64EncodedString(options: .lineLength64Characters)
        prop!.value = base64String as NSObject
        
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "application/x-doctype" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = woObj.WorkOrderNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Equipment")
        prop!.value = woObj.EquipNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userId.uppercased() as NSObject
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: uploadWOAttachmentContentSet)
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            if proper.name != "Line"{
                print("Key : \(proper.name)")
                print("Value : \(proper.value)")
                print(".......................")
            }
            print("........................")
        }
        
        UploadedAttachmentsModel.uploadWoAttachmentEntity(entity: entity!, collectionPath: uploadWOAttachmentContentSet,flushDelegate: myAssetDataManager.uniqueInstance, refreshDelegate: myAssetDataManager.uniqueInstance, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "EquipAttachAdded", object: [docData])
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.delegate?.dataFetchCompleted?(type: "EquipAttachAdded", object: ["error"])
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func uploadPdfToFlocAttachments(docData:NSData,checkSheetName:String){
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "Form_\(checkSheetName)" as NSObject
        self.property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        prop!.value = "\(checkSheetName)_\(Date().localDate().toString(format: .custom("dd-MM-yyyy:HH:mm"))).pdf" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Extension")
        prop!.value = "pdf" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value =  String(docData.length) as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Line")
        let base64String = docData.base64EncodedString(options: .lineLength64Characters)
        prop!.value = base64String as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "application/x-doctype" as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = woObj.WorkOrderNum as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FuncLocation")
        prop!.value = woObj.FuncLocation as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "EnteredBy")
        prop!.value = userId.uppercased() as NSObject
        self.property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderAttachmentUploadentity)
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            if proper.name != "Line"{
                print("Key : \(proper.name)")
                print("Value : \(proper.value)")
                print(".......................")
            }
            print("........................")
        }
        UploadedAttachmentsModel.uploadWoAttachmentEntity(entity: entity!, collectionPath: uploadWOAttachmentContentSet,flushDelegate: myAssetDataManager.uniqueInstance, refreshDelegate: myAssetDataManager.uniqueInstance, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                self.delegate?.dataFetchCompleted?(type: "FlocAttachAdded", object: [docData])
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.delegate?.dataFetchCompleted?(type: "FlocAttachAdded", object: ["error"])
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
}
