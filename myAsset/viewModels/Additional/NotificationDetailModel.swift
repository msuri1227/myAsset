//
//  NotificationDetailModel.swift
//  myJobCard
//
//  Created by Suri on 10/01/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation
class NotificationDetailModel{

    weak var delegate: viewModelDelegate?
    var orderTypeFeatureDict = NSMutableDictionary()
    var noObj = NotificationModel()
    var countDict = [String:Any]()

    var noItemArray = [NotificationItemsModel]()
    var noActivityArray = [NotificationActivityModel]()
    var noTaskArray = [NotificationTaskModel]()
    var noUploadAttachmentArr = [UploadedAttachmentsModel]()
    var noAttachmentArr = [AttachmentModel]()

    
    //TODO: Notification Badge Count
    //MARK: Notification Child Count Batch request
    func getNotificationChildBadgeCount(noObj: NotificationModel,woNotification:Bool? = false){

        let batchArr = NSMutableArray()
        if woNotification == true{
            let itemList  = "\(woNotificationItemCollection)?$filter=(Notification eq '\(noObj.Notification)')&$orderby=Item"
            let ActivityList = "\(woNotificationActivityCollection)?$filter=(Notification eq '\(noObj.Notification)' and Item eq '0000')&$orderby=Activity"
            let taskList = "\(woNotificationTaskCollection)?$filter=(Notification eq '\(noObj.Notification)' and Item eq '0000')&$orderby=Task"
            let NoAttachList = "\(woNOAttachmentSet)?$filter=(endswith(ObjectKey, '\(noObj.Notification)') eq true)"
            let NoUploadList = "\(uploadNOAttachmentContentSet)?$filter=(Notification eq '\(noObj.Notification)' and BINARY_FLG ne 'N')";
            batchArr.add(itemList)
            batchArr.add(ActivityList)
            batchArr.add(taskList)
            batchArr.add(NoUploadList)
            batchArr.add(NoAttachList)
        }else{
            let itemList  = "\(notificationItemSet)?$filter=(Notification eq '\(noObj.Notification)')&$orderby=Item"
            let ActivityList = "\(notificationActivitySet)?$filter=(Notification eq '\(noObj.Notification)' and Item eq '0000')&$orderby=Activity"
            let taskList = "\(notificationTaskSet)?$filter=(Notification eq '\(noObj.Notification)' and Item eq '0000')&$orderby=Task"
            let NoAttachList = "\(noAttachmentSet)?$filter=(endswith(ObjectKey, '\(noObj.Notification)') eq true)"
            let NoUploadList = "\(uploadNOAttachmentContentSet)?$filter=(Notification eq '\(noObj.Notification)' and BINARY_FLG ne 'N')";
            batchArr.add(itemList)
            batchArr.add(ActivityList)
            batchArr.add(taskList)
            batchArr.add(NoUploadList)
            batchArr.add(NoAttachList)
        }
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
                    var noAttachmentArr = Array<AttachmentModel>()
                    var noUploadAttachmentArr =  Array<UploadedAttachmentsModel>()

                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == notificationItemSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                            if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                self.noItemArray = NoItemArr
                            }
                        }else if resourcePath == notificationActivitySet {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                            if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                self.noActivityArray = NoActivityArr
                            }
                        }else if resourcePath == notificationTaskSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                self.noTaskArray = NoTaskArr
                            }
                        }else if resourcePath == uploadNOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                            if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                if(uploadattacharray.count > 0) {
                                    self.noUploadAttachmentArr = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Item == "" && $0.Task == ""}
                                }else{
                                    self.noUploadAttachmentArr.removeAll()
                                }
                            }
                        }else if resourcePath == noAttachmentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                self.noAttachmentArr = Noattacharray
                            }
                        }else if resourcePath == woNotificationItemCollection{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                            if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                self.noItemArray = NoItemArr
                            }
                        }else if resourcePath == woNotificationActivityCollection {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                            if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                self.noActivityArray = NoActivityArr
                            }
                        }else if resourcePath == woNotificationTaskCollection{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                            if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                self.noTaskArray = NoTaskArr
                            }
                        }else if resourcePath == woNOAttachmentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                            if  let NoAttachArray = dict["data"] as? [AttachmentModel]{
                                self.noAttachmentArr = NoAttachArray
                            }
                        }
                    }
                    self.setNoAttachementCount(noObj: noObj,fromBatch: true)
                }
            }else{
                self.setNoAttachementCount(noObj: noObj,fromBatch: true)
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setNoAttachementCount(noObj:NotificationModel,fromBatch :Bool? = false){

        if fromBatch == true{
            var attachmentCount = Int()
            if self.noAttachmentArr.count > 0{
                attachmentCount = self.noAttachmentArr.count + self.noUploadAttachmentArr.count
            }else{
                attachmentCount = self.noUploadAttachmentArr.count
            }
            self.countDict["noItemCount"] = "\(self.noItemArray.count)"
            self.countDict["noActivityCount"] = "\(self.noActivityArray.count)"
            self.countDict["noTaskCount"] = "\(self.noTaskArray.count)"
            self.countDict["noAttachCount"] = "\(attachmentCount)"
            self.delegate?.dataFetchCompleted?(type: "noChildCounts", object: [self.countDict])
        }else{
            mJCLogger.log("Starting", Type: "info")
            if noAttachmentArr.count > 0{
                let totalAttchmentCount = noAttachmentArr.count + noUploadAttachmentArr.count
                if (totalAttchmentCount > 0) {
                    noAttchmentCount = "\(totalAttchmentCount)"
                }else {
                    noAttchmentCount = ""
                }
            }else{
                let uploadedAttachementCount = noUploadAttachmentArr.count
                if (uploadedAttachementCount > 0) {
                    noAttchmentCount = "\(uploadedAttachementCount)"
                }else {
                    noAttchmentCount = ""
                }
            }
        }

    }
    //MARK:  Notification Item Badge Count Details
    func getNotificationItemBadgeCount(woNotification:Bool? = false) {
        if woNotification == true{

        }else{
            NotificationItemsModel.getNotificationItemsList(notifNum: selectedNotificationNumber){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemsModel]{
                        self.delegate?.setBadgeCount?(type: "ItemCount", count: "\(responseArr.count)", badgeColor: appColor)
                    }else{
                        self.delegate?.setBadgeCount?(type: "ItemCount", count: "", badgeColor: UIColor.clear)
                    }
                }else{
                    self.delegate?.setBadgeCount?(type: "ItemCount", count: "", badgeColor: UIColor.clear)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Notification Activity Badge Count Details
    func getNotificationActivityBadgeCount(woNotification:Bool? = false) {
        NotificationActivityModel.getNotificationActivityList(notifNum: selectedNotificationNumber){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [NotificationActivityModel]{
                    self.delegate?.setBadgeCount?(type: "noActivityCount", count: "\(responseArr.count)", badgeColor: appColor)
                }else{
                    self.delegate?.setBadgeCount?(type: "noActivityCount", count: "", badgeColor: UIColor.clear)
                }
            }else{
                self.delegate?.setBadgeCount?(type: "noActivityCount", count: "", badgeColor: UIColor.clear)
            }
        }
    }
    //MARK: Notification Task Badge Count Details
    func getNotificationTaskBadgeCount(woNotification:Bool? = false) {
        if woNotification == true{

        }else{
            NotificationTaskModel.getNotificationTaskList(notifNum: selectedNotificationNumber){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        self.delegate?.setBadgeCount?(type: "noTaskCount", count: "\(responseArr.count)", badgeColor: appColor)
                    }else{
                        self.delegate?.setBadgeCount?(type: "noTaskCount", count: "", badgeColor: appColor)
                    }
                }else{
                    self.delegate?.setBadgeCount?(type: "noTaskCount", count: "", badgeColor: appColor)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    //MARK: Notification Attachment Count Details ..
    func getNOAttachmentSet(noObj:NotificationModel,woNotification:Bool? = false) {
        if woNotification == true{

        }else{
            let  defineQuery = "$filter=(endswith(ObjectKey, '\(noObj.Notification)') eq true)"
            AttachmentModel.getNoAttachmentList(filterQuery: defineQuery){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [AttachmentModel]{
                        self.noAttachmentArr = responseArr
                        self.getNotificationUploadedAttachment(noObj: noObj,woNotification:woNotification)
                    }else{
                        self.getNotificationUploadedAttachment(noObj: noObj,woNotification:woNotification)
                    }
                }else{
                    self.getNotificationUploadedAttachment(noObj: noObj,woNotification:woNotification)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }
    func getNotificationUploadedAttachment(noObj:NotificationModel,woNotification:Bool? = false) {
        if woNotification == true{

        }else{
            let defineQuery = "$filter=(Notification eq '\(selectedNotificationNumber)' and BINARY_FLG ne 'N')";
            UploadedAttachmentsModel.getNoUploadAttachmentCount(filterQuery: defineQuery){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [UploadedAttachmentsModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.noUploadAttachmentArr = responseArr.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Item == "" && $0.Task == ""}
                        self.setNoAttachementCount(noObj: noObj)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        self.setNoAttachementCount(noObj: noObj)
                    }
                }else{
                    self.setNoAttachementCount(noObj: noObj)
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
    }

    //MARK: - get Item ItemCause Mandatory Values ..
    func getItemItemCauseMandatoryValues(woObj:WoHeaderModel,noObj:NotificationModel,orderType:StringLiteralType){
        mJCLogger.log("Starting", Type: "info")
        //self.getWorkorderChildBadgeCount(woObj: woObj)
        if let featurs =  self.orderTypeFeatureDict.value(forKey: orderType){
            if let featurs =  featurs as? NSArray{
                if let featureDict = featurs[0] as? NSMutableDictionary {
                    if featureDict.allKeys.count > 0 {
                        let featurelist = featureDict.allKeys as NSArray
                        if featurelist.contains("NOTIFICATION") && woObj.NotificationNum != ""{
                            let notifType = noObj.NotificationType
                            if let notiFeaturs =  self.orderTypeFeatureDict.value(forKey: notifType){
                                if let featurs =  notiFeaturs as? NSArray{
                                    if let featureDict = featurs[0] as? NSMutableDictionary {
                                        if featureDict.allKeys.count > 0 {
                                            let featurelist = featureDict.allKeys as NSArray
                                            if featurelist.contains("ITEM") && featurelist.contains("ITEMCAUSE"){
                                                self.getNotiItemCount(noti: noObj.Notification, itemCause: true, notificationFrom: "FromWorkorder")
                                            }else if featurelist.contains("ITEM"){
                                                self.getNotiItemCount(noti: noObj.Notification, itemCause: false, notificationFrom: "FromWorkorder")
                                            }else if  featurelist.contains("ITEMCAUSE"){
                                                self.getNotiItemCauseCount(notifNum: noObj.Notification, notificationFrom: "FromWorkorder")
                                            }
                                            if featurelist.contains("TASK") && featurelist.contains("ITEMTASK"){
                                                self.getIncompletedTaskCount(notifNum: noObj.Notification, type: "", notificationFrom: "FromWorkorder")
                                            }else if featurelist.contains("TASK"){
                                                self.getIncompletedTaskCount(notifNum: noObj.Notification, type: "Header", notificationFrom: "FromWorkorder")
                                            }else if featurelist.contains("ITEMTASK"){
                                                self.getIncompletedTaskCount(notifNum: noObj.Notification, type: "Item", notificationFrom: "FromWorkorder")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotiItemCount(noti:String,itemCause:Bool,notificationFrom:String){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder"{
            NotificationItemsModel.getWoNotificationItemsList(notifNum: singleNotification.Notification){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        NOItemCount = responseArr.count
                        if NOItemCount > 0 && notificationFrom != "" && itemCause == true{
                            self.getNotiItemCauseCount(notifNum: singleWorkOrder.NotificationNum, notificationFrom: "FromWorkorder")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCount = 0
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationItemsModel.getNotificationItemsList(notifNum: singleNotification.Notification){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        NOItemCount = responseArr.count
                        if NOItemCount > 0 && notificationFrom != "" && itemCause == true{
                            self.getNotiItemCauseCount(notifNum: singleNotification.Notification, notificationFrom: "")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCount = 0
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotiItemCauseCount(notifNum:String,notificationFrom:String){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder" {
            NotificationItemCauseModel.getWoNoItemCauseList(notifNum: notifNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        NOItemCauseCount = responseArr.count
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        else {
            NotificationItemCauseModel.getNotificationItemCauseList(notifNum: notifNum){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        NOItemCauseCount = responseArr.count
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getIncompletedTaskCount(notifNum:String,type:String,notificationFrom:String){
        var filterQuery = String()
        if type == "Header"{
            filterQuery = "$filter=(Notification eq '\(notifNum)' Item eq '0000')&$orderby=Task"
        }else if type == "Item" {
            filterQuery = "$filter=(Notification eq '\(notifNum)' Item ne '0000')&$orderby=Task"
        }else{
            filterQuery = "$filter=(Notification eq '\(notifNum)')&$orderby=Task"
        }
        if notificationFrom == "FromWorkorder" {
            NotificationTaskModel.getWoNotificationtaskList(filterQuery: filterQuery){(response,error) in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        if responseArr.count > 0{
                            mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                            let statusArr = NO_TASK_COMP_STATUS.components(separatedBy: ",")
                            let predicate = NSPredicate(format: "MobileStatus IN %@ || UserStatus In %@", statusArr as [AnyObject],statusArr as [AnyObject])
                            let compTaskArr = responseArr.filter{predicate.evaluate(with: $0)}
                            if responseArr.count != compTaskArr.count{
                                inCompTaskCount = responseArr.count - compTaskArr.count
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            inCompTaskCount = 0
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        inCompTaskCount = 0
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationTaskModel.getNotificationTaskList(filterQuery: filterQuery){(response,error) in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        if responseArr.count > 0{
                            let statusArr = NO_TASK_COMP_STATUS.components(separatedBy: ",")
                            let predicate = NSPredicate(format: "MobileStatus IN %@ || UserStatus In %@", statusArr as [AnyObject],statusArr as [AnyObject])
                            let compTaskArr = responseArr.filter{predicate.evaluate(with: $0)}
                            if responseArr.count != compTaskArr.count{
                                inCompTaskCount = responseArr.count - compTaskArr.count
                            }else{
                                inCompTaskCount = 0
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                            inCompTaskCount = 0
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        inCompTaskCount = 0
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func taskStatusUpdated(){
        self.notificationPrecompletioncheck()
    }
    func notificationPrecompletioncheck(){
        mJCLogger.log("Starting", Type: "info")
        let orderType = singleNotification.NotificationType
        if singleNotification.UserStatus != "COMP"{
            if let featurs =  orderTypeFeatureDict.value(forKey: orderType){
                if let featurs =  featurs as? NSArray{
                    if let featureDict = featurs[0] as? NSMutableDictionary {
                        if featureDict.allKeys.count > 0 {
                            let featurelist = featureDict.allKeys as NSArray
                            if featurelist.contains("ITEM") && featurelist.contains("ITEMCAUSE"){
                                self.getNotiItemCount(noti: singleNotification.Notification, itemCause: true, notificationFrom: "Notification")
                            }else if featurelist.contains("ITEM"){
                                self.getNotiItemCount(noti: singleNotification.Notification, itemCause: false, notificationFrom: "Notification")
                            }else if  featurelist.contains("ITEMCAUSE"){
                                self.getNotiItemCauseCount(notifNum: singleNotification.Notification, notificationFrom: "Notification")
                            }
                            if featurelist.contains("TASK") && featurelist.contains("ITEMTASK")
                            {
                                self.getIncompletedTaskCount(notifNum: singleNotification.Notification, type: "", notificationFrom: "Notification")
                            }else if featurelist.contains("TASK"){
                                self.getIncompletedTaskCount(notifNum: singleNotification.Notification, type: "Header", notificationFrom: "Notification")
                            }else if featurelist.contains("ITEMTASK"){
                                self.getIncompletedTaskCount(notifNum: singleNotification.Notification, type: "Item", notificationFrom: "Notification")
                            }
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

