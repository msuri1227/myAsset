//
//  SingleNotificationViewModel`.swift
//  myJobCard
//
//  Created by Khaleel on 13/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class SingleNotificationViewModel {
    
    var vc: SingleNotificationVC!

    //MARK:- Notification methods..
    func getNotificationList() {
        mJCLogger.log("Starting", Type: "info")
        NotificationModel.getWoNotificationDetailsWith(NotifNum: selectedNotificationNumber){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        singleNotification = responseArr[0]
                        DispatchQueue.main.async {
                            self.vc.alertImage.image = myAssetDataManager.getPriorityImage(priority: singleNotification.Priority)
                        }
                        if onlineSearch != true {
                            self.getAllowedStatus(status: singleNotification.MobileStatus)
                        }
                        DispatchQueue.main.async {
                            self.vc.statusCollectionView.reloadData()
                        }
                        isActiveNotification = WorkOrderDataManegeClass.uniqueInstance.getConsidereAsActive(status: singleNotification.MobileStatus, from: "Notification")
                        self.vc.selecteHeaderButton = "OverView"
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    self.setNotificationBadgeIconCount()
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getNOAttachmentSet() {
        mJCLogger.log("Starting", Type: "info")
        let  defineQuery = "$filter=(endswith(ObjectKey, '\(selectedNotificationNumber)') eq true)"
        
        AttachmentModel.getNoAttachmentList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [AttachmentModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        var compIDArray = [String]()
                        for item in responseArr{
                            compIDArray.append(item.CompID)
                        }
                        self.getNotificationUploadedAttachment(NoattachmentArray: responseArr, ComponentArray: compIDArray)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        self.getNotificationUploadedAttachment(NoattachmentArray: responseArr, ComponentArray: [])
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

    func getNotificationUploadedAttachment(NoattachmentArray:[AttachmentModel],ComponentArray:[String]) {
        mJCLogger.log("Starting", Type: "info")
        let defineQuery = "$filter=(Notification%20eq%20%27\(selectedNotificationNumber)%27 and BINARY_FLG ne 'N')";
        UploadedAttachmentsModel.getNoUploadAttachmentCount(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [UploadedAttachmentsModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    let arr = responseArr.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Item == "" && $0.Task == ""}
                    self.setNoAttachementCount(Notification: singleNotification, NoAttachmentArr: NoattachmentArray, NoUploadAttachmentArr: arr, NoCompIdArr: ComponentArray, fromBatch: false)
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    self.setNoAttachementCount(Notification: singleNotification, NoAttachmentArr: NoattachmentArray, NoUploadAttachmentArr: [], NoCompIdArr: ComponentArray, fromBatch: false)
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotiItemCount(noti:String,notificationFrom:String){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder"{
            NotificationItemsModel.getWoNotificationItemsList(notifNum: singleNotification.Notification) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        NOItemCount = responseArr.count
                        if NOItemCount > 0 && notificationFrom != ""{
                            self.getNotiItemCauseCount(notifNum: singleWorkOrder.NotificationNum, notificationFrom: "FromWorkorder")
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCount = 0
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            
            NotificationItemsModel.getNotificationItemsList(notifNum: singleNotification.Notification) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        NOItemCount = responseArr.count
                        if NOItemCount > 0 && notificationFrom != ""{
                            self.getNotiItemCauseCount(notifNum: singleWorkOrder.NotificationNum, notificationFrom: "FromWorkorder")
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCount = 0
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    //MARK:- Set Notification Badge Count
    func setNotificationBadgeIconCount() {
        mJCLogger.log("Starting", Type: "info")
        self.createBatchRequestForTransactionCount(ObjectClass: singleNotification)
        if let featurs =  orderTypeFeatureDict.value(forKey: singleNotification.NotificationType){
            mJCLogger.log("Response :\(featurs)", Type: "Debug")
            let featurelist = featurs as! NSMutableArray
            if featurelist.contains("NOTIFICATION") && singleNotification.Notification != ""{
                if let notififeatures = orderTypeFeatureDict.value(forKey: singleNotification.NotificationType) as? NSMutableArray{
                    if notififeatures.contains("ITEM"){
                        self.getNotiItemCount(noti: singleWorkOrder.NotificationNum, notificationFrom: "FromWorkorder")
                    }
                    if notififeatures.contains("ITEMCAUSE"){
                        self.getNotiItemCauseCount(notifNum: singleWorkOrder.NotificationNum, notificationFrom: "FromWorkorder")
                    }
                }
            }
        }else {
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotiItemCauseCount(notifNum:String,notificationFrom:String){
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder" {
            NotificationItemCauseModel.getWoNoItemCauseList(notifNum: notifNum){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        NOItemCauseCount = responseArr.count
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationItemCauseModel.getNotificationItemCauseList(notifNum: notifNum){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        NOItemCauseCount = responseArr.count
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        NOItemCauseCount = 0
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- BATCH REQUEST
    // Batch request for Count
    func createBatchRequestForTransactionCount(ObjectClass: AnyObject){
        
        mJCLogger.log("Starting", Type: "info")
        if let notification = ObjectClass as? NotificationModel{
            let itemList  = DefineRequestModelClass.uniqueInstance.getNotificationItems(type: "List", notificationNum: notification.Notification, itemNum: "", notificationFrom: "FromWorkorder") as String
            let ActivityList = DefineRequestModelClass.uniqueInstance.getNotificationActivity(type: "List", notificationNum: notification.Notification, activityNum: "",notificationFrom: "FromWorkorder", ItemNum: "0000") as String
            let taskList = DefineRequestModelClass.uniqueInstance.getNotificationTask(type: "List", notificationNum: notification.Notification, taskNum: "", notificationFrom: "FromWorkorder", ItemNum: "0000") as String
            let NoUploadList = uploadNOAttachmentContentSet + "?$filter=(Notification%20eq%20%27" + (selectedNotificationNumber) + "%27 and BINARY_FLG ne 'N')";
            let NoAttachList = "WONOAttachmentSet" + "?$filter=(endswith(ObjectKey, '\(notification.Notification)') eq true)"
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
                    mJCLogger.log("Response :\(response)", Type: "Debug")
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        var NoAttachmentArr = Array<AttachmentModel>()
                        var NoUploadAttachmentArr =  Array<UploadedAttachmentsModel>()
                        var NoCompIdArr = [String]()
                        for key in responseDic.allKeys{
                            let resourcePath = key as! String
                            if resourcePath == "WONotificationActivityCollection" {
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                                if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                    mJCLogger.log("Response :\(NoActivityArr.count)", Type: "Debug")
                                    if NoActivityArr.count > 0{
                                        ActvityCount = "\(NoActivityArr.count)"
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        ActvityCount = ""
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == "WONotificationItemCollection"{
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                                if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                    mJCLogger.log("Response :\(NoItemArr.count)", Type: "Debug")
                                    if NoItemArr.count > 0{
                                        ItemCount = "\(NoItemArr.count)"
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        ItemCount = ""
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == "WONotificationTaskCollection"{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                                if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                    mJCLogger.log("Response :\(NoTaskArr.count)", Type: "Debug")
                                    if NoTaskArr.count > 0{
                                        TaskCount = "\(NoTaskArr.count)"
                                    }else{
                                        mJCLogger.log("Data not found", Type: "Debug")
                                        TaskCount = ""
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == uploadNOAttachmentContentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                                if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                    mJCLogger.log("Response :\(uploadattacharray.count)", Type: "Debug")
                                    if(uploadattacharray.count > 0) {
                                        NoUploadAttachmentArr = uploadattacharray.filter{$0.FuncLocation == "" && $0.Equipment == "" && $0.Item == "" && $0.Task == ""}
                                    }else {
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else if resourcePath == "WONOAttachmentSet"{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                                if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                    mJCLogger.log("Response :\(Noattacharray.count)", Type: "Debug")
                                    if(Noattacharray.count > 0) {
                                        NoAttachmentArr = Noattacharray
                                    }else {
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                                if  let NocompIdArr = dict["CompID"] as? [String]{
                                    mJCLogger.log("Response :\(NocompIdArr.count)", Type: "Debug")
                                    if(NocompIdArr.count > 0) {
                                        NoCompIdArr = NocompIdArr
                                    }else {
                                        mJCLogger.log("Data not found", Type: "Debug")
                                    }
                                }else {
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }
                        }
                        self.setNoAttachementCount(Notification: notification, NoAttachmentArr: NoAttachmentArr, NoUploadAttachmentArr: NoUploadAttachmentArr, NoCompIdArr: NoCompIdArr, fromBatch: false)
                    }
                }else {
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setNoAttachementCount(Notification:NotificationModel,NoAttachmentArr:[AttachmentModel],NoUploadAttachmentArr:[UploadedAttachmentsModel],NoCompIdArr:[String],fromBatch:Bool){

        mJCLogger.log("Starting", Type: "info")
        if NoAttachmentArr.count > 0{
            var uploadedAttachementCount = NoUploadAttachmentArr.count
            for item in NoUploadAttachmentArr{
                let filename = item.FILE_NAME
                if NoCompIdArr.contains(filename){
                    uploadedAttachementCount -= 1
                }
            }
            let totalAttchmentCount = NoAttachmentArr.count + uploadedAttachementCount
            if (totalAttchmentCount > 0) {
                noAttchmentCount = "\(totalAttchmentCount)"
            }else {
                noAttchmentCount = ""
            }
        }else{
            let uploadedAttachementCount = NoUploadAttachmentArr.count

            if (uploadedAttachementCount > 0) {
                noAttchmentCount = "\(uploadedAttachementCount)"
            }else {
                noAttchmentCount = ""
            }
        }
        if fromBatch == false{
            if DeviceType == iPad{
                DispatchQueue.main.async{
                    self.vc.menuCollectionView.reloadData()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Set Notification Item Badge Count..
    func setNotificationItemBadgeCount() {
        mJCLogger.log("Starting", Type: "info")

        NotificationItemsModel.getWoNotificationItemsList(notifNum: selectedNotificationNumber) { (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationItemsModel]{
                    mJCLogger.log("Response :\(responseArr)", Type: "Debug")
                    ItemCount = "\(responseArr.count)"

                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    ItemCount = ""
                }
                DispatchQueue.main.async{
                    self.vc.menuCollectionView.reloadData()
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set Notification Item Badge Count..
    func setNotificationActivityBadgeCount() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            let defineQuery =  "$filter=(Notification%20eq%20%27" + selectedNotificationNumber + "%27 and Item eq '0000')" + "&$orderby=Activity"
            NotificationActivityModel.getWoNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: "0000", filterQuery: defineQuery) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr)", Type: "Debug")
                        ActvityCount = "\(responseArr.count)"
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                        ActvityCount = ""
                    }
                    DispatchQueue.main.async{
                        self.vc.menuCollectionView.reloadData()
                    }
                }else{
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Set Notification Item Badge Count..
    func setNotificationTaskBadgeCount() {
        mJCLogger.log("Starting", Type: "info")
        NotificationTaskModel.getWoNotificationtaskList(notifNum: selectedNotificationNumber){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationTaskModel]{
                    mJCLogger.log("Response :\(responseArr)", Type: "Debug")
                    TaskCount = "\(responseArr.count)"
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    TaskCount = ""
                }
                DispatchQueue.main.async{
                    self.vc.menuCollectionView.reloadData()
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }

    func getAllowedStatus(status:String) {
        mJCLogger.log("Starting", Type: "info")
        self.vc.allowedStatusArray.removeAllObjects()

        let statusArr  = globalStatusArray
        var filteredArray = [WorkOrderStatusModel]()
        if currentMasterView == "Notification"{
            filteredArray = statusArr.filter{$0.CurrentStatusCode == "\(status)" && $0.StatusCategory == "NOTIFICATIONLEVEL"}
        }else{
            filteredArray = statusArr.filter{$0.CurrentStatusCode == "\(status)"}
        }
        mJCLogger.log("Response :\(filteredArray)", Type: "Debug")
        for obj in filteredArray {
            let statclass = obj
            self.vc.allowedStatusArray.add(statclass.AllowedStatusCode)
        }
        if currentMasterView == "Notification"{
            let arr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: NotificationLevel, ObjectType: "X")
            mJCLogger.log("Response :\(arr)", Type: "Debug")
            self.addImagesForStatusArrays(statArray:arr)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    func addImagesForStatusArrays(statArray: Array<StatusCategoryModel>) {
        mJCLogger.log("Starting", Type: "info")
        self.vc.statusArray.removeAllObjects()
        for obj in statArray {
            let woStatus = obj
            for obj1 in globalStatusArray {
                let statObj = obj1
                if statObj.AllowedStatusCode == woStatus.StatusCode {
                    self.vc.statusArray.add(woStatus)
                    break
                }
            }
        }
        let descriptor:NSSortDescriptor = NSSortDescriptor (key:"Sequence", ascending : true)
        let sortedArray:NSArray = (self.vc.statusArray.sortedArray(using : [descriptor]) as NSArray)

        if DeviceType == iPhone{
            self.vc.statusArray.removeAllObjects()
            let statusPredicat = NSPredicate(format: "StatusCode IN %@", self.vc.allowedStatusArray)
            let finalStatuses = sortedArray.filtered(using: statusPredicat)
            self.vc.statusArray.addObjects(from: finalStatuses )
        }else{
            self.vc.statusArray.removeAllObjects()
            self.vc.statusArray.addObjects(from: sortedArray as! [Any])
        }
        DispatchQueue.main.async {
            self.vc.statusCollectionView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func UpdateStatus(index:Int){
        mJCLogger.log("Starting", Type: "info")
        if currentMasterView == "WorkOrder"{
            let validStatusClass = self.vc.statusArray[index] as! StatusCategoryModel
            if validStatusClass.CnfPopup == "X"
            {
                DispatchQueue.main.async {
                    
                    var message = String()
                    if validStatusClass.StatusCode == "ACCP"{
                        message = "You_are_accepting_this_job._Do_you_want_to_continue?".localized()
                    }else if validStatusClass.StatusCode == "INPR"{
                        message = "This_job_is_getting_Inprogress_Do_you_want_to_continue".localized()
                    }
                    else if validStatusClass.StatusCode == "COMP"{
                        message = "You_are_Completing_this_job_Do_you_want_to_continue".localized()
                    }
                    else if validStatusClass.StatusCode == "REJC"{
                        message = "You_are_Rejecting_this_job_Do_you_want_to_continue".localized()
                    }
                    let params = Parameters(
                        title: alerttitle,
                        message: message,
                        cancelButton: "YES".localized(),
                        otherButtons: ["NO".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(self.vc, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            DispatchQueue.main.async {
                                self.vc.getWorkFlowSet(validClass:validStatusClass, from: "WorkOrder")
                            }
                        case 1: break
                        default: break
                        }
                    }
                }
            }else{
                self.vc.getWorkFlowSet(validClass:validStatusClass, from: "WorkOrder")
            }
        }else{
            let validStatusClass = self.vc.statusArray[index] as! StatusCategoryModel
            
            if validStatusClass.CnfPopup == "X"
            {
                DispatchQueue.main.async {
                    var message = String()
                    if validStatusClass.StatusCode == "ACCP"{
                        message = "You_are_accepting_this_job._Do_you_want_to_continue?".localized()
                    }else if validStatusClass.StatusCode == "INPR"{
                        message = "This_job_is_getting_Inprogress_Do_you_want_to_continue".localized()
                    }
                    else if validStatusClass.StatusCode == "COMP"{
                        message = "You_are_Completing_this_job_Do_you_want_to_continue".localized()
                    }
                    else if validStatusClass.StatusCode == "REJC"{
                        message = "You_are_Rejecting_this_job_Do_you_want_to_continue".localized()
                    }
                    let params = Parameters(
                        title: alerttitle,
                        message: message,
                        cancelButton: "YES".localized(),
                        otherButtons: ["NO".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(self.vc, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            DispatchQueue.main.async {

                                self.vc.getWorkFlowSet(validClass:validStatusClass, from: "Notification")
                            }
                        case 1: break
                        default: break
                        }
                    }
                }
            }else{
                self.vc.getWorkFlowSet(validClass:validStatusClass, from: "Notification")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
