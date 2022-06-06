//
//  WorkorderDetailMModel.swift
//  myJobCard
//
//  Created by Suri on 10/01/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class WorkorderDetailModel{

    weak var delegate: viewModelDelegate?
    var orderTypeFeatureDict = NSMutableDictionary()
    var inCompOprCount = Int()
    var notIssuedComponentCount = Int()
    var operationArray = [WoOperationModel]()
    var componentArray = [WoComponentModel]()
    var woUploadAttachmentsArray = [UploadedAttachmentsModel]()
    var woAttachmentsArray = [AttachmentModel]()
    var woObjectArray = [WorkorderObjectModel]()
    var inspectionlotDetail = InspectionLotModel()
    var attachmedsByLoggedInUser = Int()
    var confirmedOprList = [String]()
    var componentIssued = false
    var attachmentAdded = false
    var recordPointDone = false


    var oprCount = String()
    var oprCountColor : UIColor? = UIColor.red
    var componetCount = String()
    var componetCountColor : UIColor? = UIColor.red
    var woAttchmentCount = String()
    var woAttchmentCountColor : UIColor? = appColor
    var inspectionCount = String()
    var inspectionCountColor : UIColor? = UIColor.red
    var woObj = WoHeaderModel()
    var countDict = [String:Any]()

    //TODO: Workorder Badge Count
    //MARK: Workorder Child Count Batch request
    func getWorkorderChildBadgeCount(woObj: WoHeaderModel, oprNum: String? = "", display:String? = ""){
        let batchArr = NSMutableArray()
        if oprNum == ""{
            let ConfOprQuery = "\(woConfirmationSet)?$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
            let incompleteOprQuery = "\(woOperationSet)?$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)'and startswith(SystemStatus,'" + "DLT" + "') ne true)&$orderby=OperationNum,SubOperation";
            batchArr.add(ConfOprQuery)
            batchArr.add(incompleteOprQuery)
        }
        if woObj.WorkOrderNum != "" && oprNum != "" && display == "X"{
            let defineQuery = "\(woComponentSet)?$filter=WorkOrderNum eq '" + woObj.WorkOrderNum + "' and OperAct eq '" + oprNum! + "' and Deleted eq false &$orderby=Item"
            batchArr.add(defineQuery)
        }else{
            let defineQuery = "\(woComponentSet)?$filter=WorkOrderNum eq '" + woObj.WorkOrderNum + "' and Deleted eq false&$orderby=Item"
            batchArr.add(defineQuery)
        }
        let WoattachemtQuery = "\(woAttachmentSet)?$filter=(endswith(ObjectKey, '" + woObj.WorkOrderNum + "') eq true)"
        let uploadAttachmentsQuery = "\(uploadWOAttachmentContentSet)?$filter=(WorkOrderNum eq '" + (woObj.WorkOrderNum) + "' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        batchArr.add(WoattachemtQuery)
        batchArr.add(uploadAttachmentsQuery)
        let ObjectQuery = "\(woObjectSet)?$filter=WorkOrderNum eq '\(woObj.WorkOrderNum)'"
        batchArr.add(ObjectQuery)
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
                            self.confirmedOprList.removeAll()
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getConfirmationOpeartionlist(dictionary: dictval)
                            self.confirmedOprList = dict["data"] as! [String]
                        }else if resourcePath == woOperationSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoOperationModel.self)
                            if  let oprarray = dict["data"] as? [WoOperationModel]{
                                self.operationArray = oprarray
                            }
                        }else if resourcePath == woComponentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoComponentModel.self)
                            if  let comparray = dict["data"] as? [WoComponentModel]{
                                self.componentArray = comparray
                            }
                        }else if resourcePath == uploadWOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                            if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                if(uploadattacharray.count > 0) {
                                    self.woUploadAttachmentsArray = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == "" }
                                }else{
                                    self.woUploadAttachmentsArray.removeAll()
                                }
                            }
                        }else if resourcePath == woAttachmentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Woattacharray = dict["data"] as? [AttachmentModel]{
                                if(Woattacharray.count > 0) {
                                    let attcharry  = Woattacharray.filter{$0.EnteredBy == "\(strUser.uppercased())"}
                                    self.attachmedsByLoggedInUser = self.attachmedsByLoggedInUser + attcharry.count
                                    self.woAttachmentsArray = Woattacharray
                                }else{
                                    self.woAttachmentsArray.removeAll()
                                }
                            }
                        }else if resourcePath == woObjectSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let responseDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WorkorderObjectModel.self)
                            if let arr = responseDict["data"] as? [WorkorderObjectModel]{
                                self.woObjectArray = arr
                            }
                        }
                    }
                    self.woObj = woObj
                    self.setOperationCount(fromBatch: true)
                }
            }else{
                self.setOperationCount(fromBatch: true)
                self.woObj = woObj
                self.setComponentCount(fromBatch: true)
                self.setWorkorderAttachmentCount(fromBatch: true)
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Get Operation Count Details
    func getConfirmationOpeartionSet(woNum:String){

        let defineQuery = "$filter=(WorkOrderNum eq '\(woNum)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
        WoOperationModel.getWoConfirmationSet(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                var arr = [String]()
                if let responseArr = response["data"] as? [WoOperationModel]{
                    for item in responseArr{
                        arr.append(item.OperationNum)
                    }
                }
                self.getIncompletedOperationCount(woNum: woNum, confirmedOprArr: arr)
            }else{
                self.getIncompletedOperationCount(woNum: woNum, confirmedOprArr: [])
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getIncompletedOperationCount(woNum:String,confirmedOprArr:[String]){
        let defineQuery = "$filter=(WorkOrderNum eq '\(woNum)'and startswith(SystemStatus,'" + "DLT" + "') ne true)&$orderby=OperationNum,SubOperation";
        WoOperationModel.getOperationList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    self.operationArray = responseArr
                    self.confirmedOprList = confirmedOprArr
                    self.setOperationCount()
                }else{
                    self.setOperationCount()
                }
            }else{
                self.setOperationCount()
            }
        }
    }
    func setOperationCount(fromBatch:Bool? = false){

        mJCLogger.log("Starting", Type: "info")
        var confirmedOprCount = Int()
        for item in self.operationArray{
            if self.confirmedOprList.contains(item.OperationNum) {
                confirmedOprCount+=1
            }
        }
        if self.orderTypeFeatureDict.value(forKey: self.woObj.OrderType) != nil {
            let featureListArr = self.orderTypeFeatureDict.value(forKey: woObj.OrderType)
            if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary {
                if let featurelist = featureDict.allKeys as? [String]{
                    if featurelist.contains("OPERATION"){
                        let mandLevel = featureDict.value(forKey: "OPERATION") as? String ?? ""
                        if mandLevel == "1"{
                            if confirmedOprCount == 0 {
                                self.inCompOprCount = self.operationArray.count
                                oprCount = "\(self.operationArray.count)"
                                oprCountColor = UIColor.red
                            }else if confirmedOprCount == self.operationArray.count{
                                self.inCompOprCount = self.operationArray.count - confirmedOprCount
                                oprCount = "\(self.inCompOprCount)"
                                oprCountColor = appColor
                            }else if confirmedOprCount > 0{
                                self.inCompOprCount = self.operationArray.count - confirmedOprCount
                                oprCount = "\(self.inCompOprCount)"
                                oprCountColor = filledCountColor
                            }
                        }else if mandLevel == "2"{
                            if confirmedOprCount == self.operationArray.count{
                                self.inCompOprCount = self.operationArray.count - confirmedOprCount
                                oprCount = "\( self.operationArray.count)"
                                oprCountColor = appColor
                            }else{
                                self.inCompOprCount = self.operationArray.count
                                oprCount = "\(self.operationArray.count)"
                                oprCountColor = UIColor.red
                            }
                        }
                    }else{
                        if confirmedOprCount == self.operationArray.count{
                            oprCount = "\(self.operationArray.count)"
                            oprCountColor = appColor
                        }else {
                            self.inCompOprCount = self.operationArray.count
                            oprCount = "\(self.inCompOprCount)"
                            oprCountColor = filledCountColor
                        }
                    }
                }
            }
        }else{
            if confirmedOprCount == self.operationArray.count{
                self.inCompOprCount = self.operationArray.count
                oprCount = "\(self.operationArray.count)"
                oprCountColor = appColor
            }else {
                self.inCompOprCount = self.operationArray.count - confirmedOprCount
                oprCount = "\(self.inCompOprCount)"
                oprCountColor = filledCountColor
            }
        }
        if fromBatch == true{
            self.setComponentCount(fromBatch: true)
        }else{
            self.delegate?.setBadgeCount?(type: "operationCount", count: oprCount, badgeColor: oprCountColor!)
        }
    }
    //MARK: Get Component Count Details
    func getIncompletedComponentCount(woObj:WoHeaderModel,oprNum:String? = "",display:String? = "") {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        if woObj.WorkOrderNum != "" && oprNum != "" && WO_OP_OBJS_DISPLAY == "X"{
            defineQuery = "$filter=WorkOrderNum eq '" + woObj.WorkOrderNum + "' and OperAct eq '" + oprNum! + "' and Deleted eq false &$orderby=Item"
        }else{
            defineQuery = "$filter=WorkOrderNum eq '" + woObj.WorkOrderNum + "' and Deleted eq false&$orderby=Item"
        }
        WoComponentModel.getComponentsList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoComponentModel]{
                    self.componentArray = responseArr
                    self.setComponentCount()
                }else{
                    self.setComponentCount()
                }
            }else{
                self.setComponentCount()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setComponentCount(fromBatch:Bool? = false){
        if self.componentArray.count > 0{
            if self.orderTypeFeatureDict.value(forKey: self.woObj.OrderType) != nil {
                let featureListArr = self.orderTypeFeatureDict.value(forKey: woObj.OrderType)
                if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary {
                    if let featurelist = featureDict.allKeys as? [String]{
                        if featurelist.contains("COMPONENT"){
                            let mandLevel = featureDict.value(forKey: "COMPONENT") as? String ?? ""
                            if mandLevel == "1"{
                                let WithdrawalQtyFilterArray = self.componentArray.filter{$0.WithdrawalQty != 0}
                                if WithdrawalQtyFilterArray.count > 0{
                                    let nonWithdrawalQtyFilterArray = self.componentArray.filter{$0.WithdrawalQty == 0}
                                    if nonWithdrawalQtyFilterArray.count == 0{
                                        componetCountColor = appColor
                                    }else{
                                        componetCountColor = filledCountColor
                                    }
                                    self.componentIssued = true
                                    notIssuedComponentCount = self.componentArray.count
                                    componetCount =  "\(self.componentArray.count)"
                                }else{
                                    self.componentIssued = false
                                    componetCountColor = UIColor.red
                                    notIssuedComponentCount = self.componentArray.count
                                    componetCount =  "\(self.componentArray.count)"
                                }
                            }else if mandLevel == "2"{
                                let WithdrawalQty = self.componentArray.filter{$0.ReqmtQty != $0.WithdrawalQty }
                                if WithdrawalQty.count == self.componentArray.count{
                                    self.componentIssued = false
                                    componetCountColor = UIColor.red
                                    notIssuedComponentCount = self.componentArray.count
                                    componetCount =  "\(self.componentArray.count)"
                                }else{
                                    if WithdrawalQty.count > 0 {
                                        var newfilterarray = [WoComponentModel]()
                                        for i in 0..<WithdrawalQty.count{
                                            let withdrawalQty = Int(truncating: WithdrawalQty[i].WithdrawalQty)
                                            let reqmtQty = Int(truncating: WithdrawalQty[i].ReqmtQty)
                                            if reqmtQty > withdrawalQty{
                                                newfilterarray.append(WithdrawalQty[i])
                                            }
                                        }
                                        if newfilterarray.count > 0{
                                            self.componentIssued = false
                                            componetCountColor = UIColor.red
                                            notIssuedComponentCount = newfilterarray.count
                                            componetCount = "\(newfilterarray.count)"
                                        }else{
                                            self.componentIssued = true
                                            componetCount = "\(self.componentArray.count)"
                                            componetCountColor = appColor
                                        }
                                    }else{
                                        self.componentIssued = true
                                        componetCount = "\(self.componentArray.count)"
                                        componetCountColor = appColor
                                    }
                                }
                            }
                        }else{
                            self.componentIssued = true
                            componetCountColor = filledCountColor
                            componetCount = "\(self.componentArray.count)"
                        }
                    }
                }
            }else{
                self.componentIssued = true
                componetCount = "\(self.componentArray.count)"
                componetCountColor = filledCountColor
            }
        }else{
            self.componentIssued = true
            componetCount = ""
            componetCountColor = filledCountColor
        }
        if fromBatch == true{
            self.setWorkorderAttachmentCount(fromBatch: true)
        }else{
            //self.delegate?.setBadgeCount?(type: "componentCount", count: componetCount, badgeColor: componetCountColor)
        }

        mJCLogger.log("Ended", Type: "info")
    }

    //MARK: Inspection Lot Count Details
    
    func getWorkorderInspectionBadgeCount(woObj: WoHeaderModel,oprNum:String? = "",display:String? = "",fromBatch:Bool? = false){

        let inspectionOprQuery = "InspectionOperSet?$filter=(InspectionLot eq '\(woObj.InspectionLot)')&$orderby=Operation"
        let inspectionPointQuery = "InspectionPointSet?$filter=(InspLot eq '\(woObj.InspectionLot)')&$orderby=InspPoint"
        let inspectionCharQuery = "InspectionCharSet?$filter=(InspLot eq '\(woObj.InspectionLot)')&$orderby=InspChar"
        let insepctionResultQuery = "InspectionResultsGetSet?$filter=(InspLot eq '\(woObj.InspectionLot)')"
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
                        if resourcePath == "InspectionOperSet" {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionOperationModel.self)
                            if  let inspOprArr = dict["data"] as? [InspectionOperationModel]{
                                inspOprArray = inspOprArr
                            }
                        }else if resourcePath == "InspectionPointSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionPointModel.self)
                            if  let insppointarray = dict["data"] as? [InspectionPointModel]{
                                inspPointArray = insppointarray
                            }
                        }else if resourcePath == "InspectionCharSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionCharModel.self)
                            if  let inspcharArray = dict["data"] as? [InspectionCharModel]{
                                inspCharArray = inspcharArray
                            }
                        }else if resourcePath == "InspectionResultsGetSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionResultModel.self)
                            if  let inspresult = dict["data"] as? [InspectionResultModel]{
                                inspResultArray = inspresult
                            }
                        }
                    }
                    self.setInspectionCount(woObj: woObj,oprNum: oprNum ?? "", display: display,inspOprArr: inspOprArray, inspPointArray: inspPointArray, inspcharArray: inspCharArray, inspResultArray: inspResultArray)
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }

    func setInspectionCount(woObj: WoHeaderModel,oprNum:String? = "",display:String? = "",inspOprArr: [InspectionOperationModel], inspPointArray:[InspectionPointModel], inspcharArray:[InspectionCharModel], inspResultArray:[InspectionResultModel],fromBatch:Bool? = false){

        var finalCharArray = Int()
        var finalResultArray = Int()
        if inspOprArr.count > 0{
            if woObj.WorkOrderNum != "" && oprNum != "" && display != "X"{
                let pointArray = inspPointArray.filter{$0.InspOper == "\(oprNum!)"}
                if pointArray.count > 0{
                    for item in pointArray{
                        let chararry = inspcharArray.filter{$0.InspPoint == "\(item.InspPoint)" && $0.InspOper == "\(item.InspOper)"}
                        if chararry.count > 0{
                            finalCharArray = finalCharArray + chararry.count
                            for item3 in chararry{
                                let resultarray = inspResultArray.filter{$0.InspOper == "\(item3.InspOper)" && $0.InspSample == "\(item3.InspPoint)" && $0.InspChar == "\(item3.InspChar)"}
                                finalResultArray = finalResultArray + resultarray.count
                            }
                        }
                    }
                }
            }else{
                for item in inspOprArr{
                    let pointArray = inspPointArray.filter{$0.InspOper == "\(item.Operation)"}
                    if pointArray.count > 0{
                        for item1 in pointArray{
                            let chararry = inspcharArray.filter{$0.InspPoint == "\(item1.InspPoint)" && $0.InspOper == "\(item1.InspOper)"}
                            if chararry.count > 0{
                                finalCharArray = finalCharArray + chararry.count
                                for item3 in chararry{
                                    let resultarray = inspResultArray.filter{$0.InspOper == "\(item3.InspOper)" && $0.InspSample == "\(item3.InspPoint)" && $0.InspChar == "\(item3.InspChar)" && $0.ResNo == "0001"}
                                    finalResultArray = finalResultArray + resultarray.count
                                }
                            }
                        }
                    }
                }
            }
        }
        if inspOprArr.count == 0{
            inspectionCount = ""
        }else if inspcharArray.count != 0 {
            if finalCharArray == finalResultArray{
                inspectionCount = "\(finalCharArray)"
                inspectionCountColor = appColor
            }else{
                inspectionCount = "\(finalCharArray - finalResultArray)"
                inspectionCountColor = filledCountColor
            }
        }else{
            let remaincount = finalCharArray - finalResultArray
            inspCount = "\(remaincount)"
            if let featurelist = self.orderTypeFeatureDict.value(forKey: woObj.OrderType){
                if (featurelist as! NSMutableArray).contains("INSPECTION"){
                    inspectionCountColor = UIColor.red
                }else{
                    inspectionCountColor = filledCountColor
                }
            }
        }
        self.countDict["inspectionCount"] = inspectionCount
        self.countDict["inspectionCountColor"] = inspectionCountColor
        self.delegate?.dataFetchCompleted?(type: "InspCountValue", object: [self.countDict])
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Get Workorder Attachment Count Details List..
    func getAttachment(woObj:WoHeaderModel) {
        let defineQuery = "$filter=(endswith(ObjectKey, '" + woObj.WorkOrderNum + "') eq true)"
        AttachmentModel.getWoNoAttachmentList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [AttachmentModel]{
                    self.woAttachmentsArray = responseArr
                    let arr = responseArr.filter{$0.EnteredBy == "\(strUser.uppercased())"}
                    self.attachmedsByLoggedInUser = arr.count
                    self.getWoUploadAttachment(woObj: woObj, attachmentArray: responseArr)
                }else{
                    self.getWoUploadAttachment(woObj: woObj, attachmentArray: [])
                }
            }else{
                self.getWoUploadAttachment(woObj: woObj, attachmentArray: [])
            }
        }
    }
    //Get Upload Attachment List..
    func getWoUploadAttachment(woObj:WoHeaderModel,attachmentArray: [AttachmentModel]) {
        let defineQuery = "$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)' and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        UploadedAttachmentsModel.getWoUploadAttachmentListWith(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [UploadedAttachmentsModel]{
                    self.woUploadAttachmentsArray = responseArr.filter{$0.FuncLocation == "" && $0.Equipment == ""}
                    self.setWorkorderAttachmentCount()
                }else{
                    self.setWorkorderAttachmentCount()
                }
            }else{
                self.setWorkorderAttachmentCount()
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkorderAttachmentCount(fromBatch:Bool? = false){
        let totalAttachmentCount = self.woUploadAttachmentsArray.count + self.woAttachmentsArray.count
        if (totalAttachmentCount > 0) {
            self.attachmentAdded = true
            woAttchmentCount = "\(totalAttachmentCount)"
            if woUploadAttachmentsArray.count == 0{
                if self.attachmedsByLoggedInUser > 0{
                    self.attachmentAdded = true
                }else{
                    self.attachmentAdded = false
                }
                if woObj.OrderType != ""{
                    if let featurelist =  orderTypeFeatureDict.value(forKey: woObj.OrderType){
                        if (featurelist as! NSMutableArray).contains("ATTACHMENT"){
                            if self.woAttachmentsArray.count != 0{
                                if self.attachmedsByLoggedInUser == 0{
                                    woAttchmentCountColor = UIColor.red
                                }
                            }else{
                                woAttchmentCount = "!"
                                woAttchmentCountColor = UIColor.red
                            }
                        }else{
                            if totalAttachmentCount > 0{
                                woAttchmentCount = "\(totalAttachmentCount)"
                            }else{
                                woAttchmentCount = ""
                            }
                        }
                    }else{
                        if totalAttachmentCount > 0{
                            woAttchmentCount = "\(totalAttachmentCount)"
                        }else{
                            woAttchmentCount = ""
                        }
                    }
                }
            }
        }else{
            self.attachmentAdded = false
            woAttchmentCount = "!"
            woAttchmentCountColor = UIColor.red
            if woUploadAttachmentsArray.count == 0{
                self.attachmentAdded = false
                if woObj.OrderType != ""{
                    if let featurelist = self.orderTypeFeatureDict.value(forKey: woObj.OrderType) as? NSMutableArray {
                        if featurelist.contains("ATTACHMENT"){
                            woAttchmentCount = "!"
                            woAttchmentCountColor = UIColor.red
                        }else{
                            if totalAttachmentCount > 0{
                                woAttchmentCount = "\(totalAttachmentCount)"
                            }else{
                                woAttchmentCount = ""
                            }
                        }
                    }else{
                        if totalAttachmentCount > 0{
                            woAttchmentCount = "\(totalAttachmentCount)"
                        }else{
                            woAttchmentCount = ""
                        }
                    }
                }
            }
        }
        if fromBatch == true{
            countDict["oprCount"] = oprCount
            countDict["oprCountColor"] = oprCountColor
            countDict["componetCount"] = componetCount
            countDict["componetCountColor"] = componetCountColor
            countDict["woAttchmentCount"] = woAttchmentCount
            countDict["woAttchmentCountColor"] = woAttchmentCountColor
            countDict["woObjCount"] = "\(self.woObjectArray.count)"
            self.delegate?.dataFetchCompleted?(type: "woChildCounts", object: [countDict])
        }else{
            self.delegate?.setBadgeCount?(type: "woAttachmentCount", count: woAttchmentCount, badgeColor: woAttchmentCountColor!)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Set Record Point Badge Count..
    func setRecordPointCount(woObj:WoHeaderModel,currentRecordPoints:[MeasurementPointModel],totalReacordPoints:[MeasurementPointModel]) {
        var mandLevel = String()
        var featureList = [String]()
        var woRecordPointCount = String()
        var woRecordPointColor = UIColor()
        if let featureListArr =  self.orderTypeFeatureDict.value(forKey: woObj.OrderType){
            if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary{
                if let featurelist = featureDict.allKeys as? [String]{
                    featureList = featurelist
                    if featurelist.contains("RECORD_POINT"){
                        mandLevel = featureDict.value(forKey: "RECORD_POINT") as? String ?? ""
                    }
                }
            }
        }
        if totalReacordPoints.count > 0 {
            if currentRecordPoints.count > 0 {
                var count = 0
                if totalReacordPoints.count > currentRecordPoints.count{
                    count = totalReacordPoints.count - currentRecordPoints.count
                }
                if mandLevel == "1"{
                    if currentRecordPoints.count > 0{
                        self.recordPointDone = true
                        woRecordPointColor = filledCountColor
                    }else{
                        self.recordPointDone = false
                        woRecordPointColor = UIColor.red
                    }
                }else if mandLevel == "2"{
                    if totalReacordPoints.count == currentRecordPoints.count{
                        self.recordPointDone = true
                        woRecordPointColor = appColor
                    }else{
                        self.recordPointDone = false
                        woRecordPointColor = UIColor.red
                    }
                }else{
                    self.recordPointDone = true
                    woRecordPointColor = filledCountColor
                }
                if count == 0 {
                    woRecordPointCount = "\(totalReacordPoints.count)"
                }else {
                    woRecordPointCount = "\(count)"
                }
            }else {
                woRecordPointCount = "\(totalReacordPoints.count)"
                woRecordPointColor = filledCountColor
                if woObj.OrderType != ""{
                    if featureList.contains("RECORD_POINT"){
                        woRecordPointColor = UIColor.red
                    }else{
                        woRecordPointColor = filledCountColor
                    }
                }
            }
        }else {
            self.recordPointDone = true
            woRecordPointCount = ""
            woRecordPointColor = filledCountColor
        }
        self.delegate?.setBadgeCount?(type: "recordPointCount", count: woRecordPointCount, badgeColor: woRecordPointColor)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Get Workorder Object Count Details
    func getWorkOrderObjectCount(woNum:String) {
        mJCLogger.log("Starting", Type: "info")
        WorkorderObjectModel.getWorkOrderObjects(workOrderNum: woNum){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WorkorderObjectModel]{
                    self.delegate?.dataFetchCompleted!(type: "ObjectCount", object: responseArr)
                }else{
                    self.delegate?.dataFetchCompleted!(type: "ObjectCount", object: [])
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                self.delegate?.dataFetchCompleted!(type: "ObjectCount", object: [])
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

