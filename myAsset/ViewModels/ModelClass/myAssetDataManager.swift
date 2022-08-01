//
//  myAssetDataManager.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/17/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib
import CoreMedia
import MessageUI
import LocalAuthentication


class myAssetDataManager: NSObject,ODSStoreFlushDelegate, ODSStoreRefreshDelegate,MFMailComposeViewControllerDelegate,UsernamePasswordProviderProtocol,SAML2ConfigProviderProtocol,ODSStoreDelegate,ODSStoreStatusDelegate, pushDeleteDelegate{

    var FandRStoreName = String()
    var isMasterRefresh = Bool()
    var vc: UIViewController?
    var slideMenuController: ExSlideMenuController?
    var slideMenuControllerSelectionDelegateStack: [SlideMenuControllerSelectDelegate] = [SlideMenuControllerSelectDelegate]()
    var navigationController: UINavigationController?
    var window: UIWindow?
    var leftViewController = UIStoryboard(name: "iPhone_LoginSB", bundle: nil).instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
    var flushFailedArr = Array<Any>()
    var refreshFailedArr = Array<Any>()
    var flushListArr = Array<Any>()
    var allListArray = [String]()

    var detailVcDataSetObserver : Any!
    var detailVcSetOprCount : Any!
    var detailVcSetInspOprCount : Any!
    var detailVcSetCompCount : Any!
    var detailVcSetAttCount : Any!
    var detailVcSetRpCount : Any!
    var detailVcSetFormCount : Any!
    var detailVcSetNoActCount : Any!
    var detailVcSetNoItemCount : Any!
    var detailVcSetNoTaskCount : Any!
    var detailVcSetNoAttCount : Any!
    var detailVcSetBgSync : Any!
    var detailFlushObserver : Any!
    var detailStatusObserver : Any!
    var taskStatusObserver: Any!
    var detailReloadObserver : Any!
    var masterFlushObserver: Any!
    var masterOperObserver: Any!
    var masterStatusObserver: Any!
    var masterRecordPointObserverr: Any!
    var suspendVcStatusObserver: Any!
    public var dataFetchCompleteDelegate:globalDataFetchCompleteDelegate?
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    class var uniqueInstance : myAssetDataManager {
        struct Static {
            static let instance : myAssetDataManager = myAssetDataManager()
        }
        return Static.instance
    }
    override init() {
        super.init()
    }
    //MARK: - Show Toast msg
    func showtoastmsg(actionTitle:String,msg:String){
        if actionTitle == ""{
            DispatchQueue.main.async{
                self.appDeli.window?.showSnackbar(message: msg, duration: .SHORT, actionButtonText: "Ok", bgColor: appColor, actionButtonClickHandler: nil)
            }
        }else{
            DispatchQueue.main.async{
                self.appDeli.window?.showSnackbar(message: msg, duration: .SHORT, actionButtonText: "Ok", bgColor: appColor, actionButtonClickHandler: { () -> () in
                    if actionTitle == "FlushError".localized(){
                        if flushErrorsArray.count > 0{
                            DispatchQueue.main.async{
                                let FlushErrorsVC = ScreenManager.getFlushErrorsScreen()
                                FlushErrorsVC.modalPresentationStyle = .fullScreen
                                self.vc = UIApplication.shared.delegate?.window??.rootViewController
                                self.vc?.present(FlushErrorsVC, animated: true)
                            }
                        }
                    }
                })
            }
        }
    }
    //MARK: - Show Error Archive
    func getErrorArchiveSet(){
        EntityKeysModel.getEntityKeysList(isVisible: "true"){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [EntityKeysModel]{
                    entitySetKeysArray = responseArr
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
    func getFlushErrors(isFromBtn: Bool,count:Int) {
        if count == offlinestoreListArray.count{
            self.ShowErrorArchiveScreen(isfromBtn: isFromBtn)
            return
        }
        if count == 0{
            flushErrorsArray.removeAllObjects()
        }
        if offlinestoreListArray.count > 0{
            let storeDetail = offlinestoreListArray[count]
            var storename = storeDetail.AppStoreName
            if storename == "APLLICATIONSTORE"{
                storename = ApplicationID
            }
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: "ErrorArchive", storeName: storename){(response, error)  in
                if error == nil{
                    mJCLogger.log("Error Response: \(response["data"] ?? "")", Type: "Debug")
                    if let responseArr =  response["data"] as? NSMutableArray{
                        if responseArr.count > 0{
                            for i in 0..<responseArr.count{
                                let dict = NSMutableDictionary()
                                let dic = responseArr[i] as? NSMutableDictionary
                                let errorArchiveClass = ErrorArchiveModel()
                                if let RequestID = dic?.value(forKey :"RequestID") as? Int32 {
                                    dict.setValue(RequestID, forKey: "RequestID")
                                }
                                if let entities = dic?.value(forKey :"entities") as? SODataEntityDefault {
                                    errorArchiveClass.entity = entities
                                    dict.setValue(errorArchiveClass.entity, forKey: "entity")
                                    dict.setValue(storeDetail.AppStoreName, forKey: "Store")
                                    var message = String()
                                    if let value = (responseArr[i] as AnyObject).value(forKey: "Message") as? String {
                                        if value != ""{
                                            message = value
                                        }else{  break  }
                                    }
                                    var reqBody = String()
                                    if let reqVal = (responseArr[i] as AnyObject).value(forKey: "RequestBody") as? String {
                                        if reqVal != "" {
                                            reqBody = reqVal
                                        }
                                        else {  break }
                                    }
                                    else {
                                        if var RequestURL = (responseArr[i] as AnyObject).value(forKey: "RequestURL") as? String {
                                            var rUtlArr = RequestURL.components(separatedBy: "/") as NSArray
                                            RequestURL = rUtlArr[rUtlArr.count-1] as! String
                                            if RequestURL.contains(find: "("){
                                                rUtlArr = RequestURL.components(separatedBy: "(") as NSArray
                                                if rUtlArr.count != 0 {
                                                    RequestURL = rUtlArr[0] as! String
                                                }else {  break  }
                                            }
                                            dict.setValue(RequestURL, forKey: "RequestURL")
                                            if entitySetKeysArray.count > 0{
                                                let arr = entitySetKeysArray.filter{$0.EntitySetName == "\(RequestURL)"}
                                                if arr.count > 0 {
                                                    let keyString = String()
                                                    dict.setValue(keyString, forKey: "objecttext")
                                                }else{}
                                            }else{
                                                let arr = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(RequestURL)"}
                                                if arr.count != 0 {
                                                    let Keys = arr[0].Keys
                                                    let keyString = Keys
                                                    dict.setValue(keyString, forKey: "objecttext")
                                                }else{}
                                            }
                                            dict.setValue(message, forKey: "errorMsg")
                                            flushErrorsArray.add(dict)
                                        }else{
                                            break
                                        }
                                    }
                                    if let reqBodydata = reqBody.data(using: .utf8) {
                                        do {
                                            let reqBodyJsonData = try JSONSerialization.jsonObject(with: reqBodydata, options: JSONSerialization.ReadingOptions.allowFragments)
                                            if var RequestURL = (responseArr[i] as AnyObject).value(forKey: "RequestURL") as? String {
                                                var rUtlArr = RequestURL.components(separatedBy: "/") as NSArray
                                                RequestURL = rUtlArr[rUtlArr.count-1] as! String
                                                if RequestURL.contains(find: "("){
                                                    rUtlArr = RequestURL.components(separatedBy: "(") as NSArray
                                                    if rUtlArr.count != 0 {
                                                        RequestURL = rUtlArr[0] as! String
                                                    }else {  break  }
                                                }
                                                dict.setValue(RequestURL, forKey: "RequestURL")
                                                if entitySetKeysArray.count > 0{
                                                    let arr = entitySetKeysArray.filter{$0.EntitySetName == "\(RequestURL)"}
                                                    if arr.count > 0 {
                                                        var keyString = String()
                                                        for item in arr{
                                                            let  str = item.KeyName + " " + "\((reqBodyJsonData as AnyObject).value(forKey: item.KeyProperty) ?? "null")"
                                                            keyString = keyString + "\(str) ; "
                                                        }
                                                        dict.setValue(keyString, forKey: "objecttext")
                                                    }else{}
                                                }else{
                                                    let arr = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(RequestURL)"}
                                                    if arr.count != 0 {
                                                        let Keys = arr[0].Keys
                                                        let keysArr = Keys.components(separatedBy: "-")
                                                        var keyString = String()
                                                        for i in 0..<keysArr.count{
                                                            let str = (reqBodyJsonData as AnyObject).value(forKey: keysArr[i])
                                                            keyString +=  " \(str ?? "") "
                                                        }
                                                        dict.setValue(keyString, forKey: "objecttext")
                                                    }else{
                                                    }
                                                }
                                                if let msgdata = message.data(using: .utf8) {
                                                    do {
                                                        let errordata = try JSONSerialization.jsonObject(with: msgdata, options: JSONSerialization.ReadingOptions.allowFragments)
                                                        let error = (errordata as AnyObject).value(forKey: "error")
                                                        let errormsgdit = (error as AnyObject).value(forKey: "message")
                                                        let errormsg = (errormsgdit as AnyObject).value(forKey: "value")
                                                        dict.setValue(errormsg, forKey: "errorMsg")
                                                        flushErrorsArray.add(dict)
                                                    } catch let error as NSError {
                                                        mJCLogger.log(error, Type: "Error")
                                                        dict.setValue(message, forKey: "errorMsg")
                                                        flushErrorsArray.add(dict)
                                                    }
                                                }
                                            }
                                        } catch let error as NSError {
                                            mJCLogger.log(error, Type: "Error")
                                        }
                                    }
                                }
                            }
                            let newCount = count + 1
                            if newCount == offlinestoreListArray.count{
                                self.ShowErrorArchiveScreen(isfromBtn: isFromBtn)
                            }else{
                                self.getFlushErrors(isFromBtn: isFromBtn, count: newCount)
                            }
                        }else{
                            let newCount = count + 1
                            if newCount == offlinestoreListArray.count{
                                self.ShowErrorArchiveScreen(isfromBtn: isFromBtn)
                            }else{
                                self.getFlushErrors(isFromBtn: isFromBtn, count: newCount)
                            }
                        }
                    }
                }else{
                    let newCount = count + 1
                    if newCount == offlinestoreListArray.count{
                        self.ShowErrorArchiveScreen(isfromBtn: isFromBtn)
                    }else{
                        self.getFlushErrors(isFromBtn: isFromBtn, count: newCount)
                    }
                }
            }
        }else{
            self.ShowErrorArchiveScreen(isfromBtn: isFromBtn)
        }
    }
    func ShowErrorArchiveScreen(isfromBtn: Bool){
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_POPUP_ERRHNDLNG", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                if flushErrorsArray.count > 0{
                    if AUTO_DISPLAY_ERROR_SCREEN == true {
                        if isfromBtn == false {
                            self.showtoastmsg(actionTitle: "FlushError".localized(), msg: "Data_flush_Completed_with_Errors,_Click_on_View".localized())
                        }else{
                            DispatchQueue.main.async{
                                let FlushErrorsVC = ScreenManager.getFlushErrorsScreen()
                                FlushErrorsVC.modalPresentationStyle = .fullScreen
                                self.vc = UIApplication.shared.delegate?.window??.rootViewController
                                self.vc?.present(FlushErrorsVC, animated: true)
                            }
                        }
                    }else{
                        self.showtoastmsg(actionTitle: "FlushError".localized(), msg: "Data_flush_Completed_with_Errors,_Click_on_View".localized())
                    }
                } else {
                    if isfromBtn == true {
                        self.showtoastmsg(actionTitle: "", msg: "No_Flush_Errors".localized())
                    }else{
                        if self.flushListArr.count > 0{
                            self.flushListArr.removeAll()
                            self.showtoastmsg(actionTitle: "", msg: "Data_flush_Completed".localized())
                        }
                    }
                }
            }
        }
        if isfromBtn == false {
            self.refreshCompleted()
        }
    }
    //MARK: - Global Data
    func getGlobalData(){
        self.getAllWorkorders(from: "first")
        self.getCatalogProfileSet()
        self.getAllUserdetails()
        self.getApplicationFeatureSet()
        self.getAttachmentsInBatch()
    }
    //MARK: - Global Low Volume Data
    func getNotificationType() {
        NotificationTypeModel.getNotificationTypeList(){(response, error)  in
            if error == nil{
                notificationTypeArray.removeAll()
                if let responseArr = response["data"] as? [NotificationTypeModel]{
                    let sortedArray = responseArr.sorted(by: { $0.NotifictnType < $1.NotifictnType })
                    notificationTypeArray = sortedArray
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
    func getCatalogProfileSet(){
        catlogArray.removeAllObjects()
        CatalogProfileModel.getCatalogProfileList(){ (response, error)  in
            if error == nil{
                catlogArray.removeAllObjects()
                if let responseArr = response["data"] as? [CatalogProfileModel]{
                    let sortedArr = responseArr.sorted{$0.CodeGroup.compare($1.CodeGroup) == .orderedAscending }
                    catlogArray.addObjects(from: sortedArr as [AnyObject])
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
    func setWOcompleteFields(){
        OrderTypeFeatureModel.getOrderTypeFeaturesList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [OrderTypeFeatureModel]{
                    orderTypeFeatureDict.removeAllObjects()
                    for i in 0..<responseArr.count{
                        let ordertypeclass = responseArr[i]
                        let ordertype = ordertypeclass.OrderType
                        let newfilterar = responseArr.filter{$0.OrderType == "\(ordertype)"}
                        let featurearray = NSMutableArray()
                        let newDataDict = NSMutableDictionary()
                        for i in 0..<newfilterar.count{
                            let ordertypecls = newfilterar[i]
                            newDataDict.setObject(ordertypecls.MandatoryLevel, forKey: ordertypecls.Feature as NSCopying)
                        }
                        newDataDict.removeAllObjects()
                        newDataDict["COMPONENT"] = "2"
                        newDataDict["OPERATION"] = "2"
                        newDataDict["INSPECTIONLOT"] = "2"
                        newDataDict["ITEM"] = "2"
                        newDataDict["ITEMCAUSE"] = "2"
                        newDataDict["NOTIFICATION"] = "2"
                        newDataDict["ATTACHMENT"] = "2"
                        newDataDict["RECORD_POINT"] = "2"
                        featurearray.add(newDataDict)
                        orderTypeFeatureDict.setObject(featurearray, forKey: ordertypeclass.OrderType as NSCopying)
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
    func getGlobalPlantList(){
        MaintencePlantModel.getMainttencePlantList(){(response, error)  in
            if error == nil{
                if let responseArr =  response["data"] as? [MaintencePlantModel]{
                    let sortedArray = responseArr.sorted(by: { $0.Name1 < $1.Name1 })
                    globalPlanningPlantArray = sortedArray
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
            self.getGlobalPriorityList()
        }
    }
    func getGlobalPriorityList(){
        PriorityListModel.getPriorityList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [PriorityListModel]{
                    let sortedArray = responseArr.sorted(by: { $0.PriorityText < $1.PriorityText })
                    globalPriorityArray = sortedArray
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
            self.getGlobalWorkCenterList()
        }
    }
    func getGlobalWorkCenterList(){
        WorkCenterModel.getWorkCentersList(){(response, error)  in
            if error == nil{
                if let arr = response["data"] as? [WorkCenterModel]{
                    globalWorkCtrArray = arr
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
            self.getGlobalWorkFlowSet()
        }
    }
    func getGlobalWorkFlowSet(){
        LtWorkFlowModel.getltWorkFlowList(){(response, error)  in
            if error == nil{
                if let arr = response["data"] as? [LtWorkFlowModel]{
                    workFlowListArray = arr
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
            self.getGlobalAttachmentTypeSet()
        }
    }
    func getGlobalAttachmentTypeSet(){
        AttachmentTypeModel.getAttachmentTypeList{(response, error)  in
            if error == nil{
                if let arr = response["data"] as? [AttachmentTypeModel]{
                    attachmentTypeListArray = arr
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
        self.dataFetchCompleteDelegate?.globalDataFetchCompleteCompleted()
    }
    func getAllUserdetails() {
        PersonResponseModel.getPersonResponseList(){(response, error)  in
            if error == nil{
                globalPersonRespArray.removeAll()
                if let arr = response["data"] as? [PersonResponseModel]{
                    globalPersonRespArray = arr
                }
                self.getcurrentuserdetails()
            }else{
                self.getcurrentuserdetails()
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
    //MARK: - Global High Volume Data
    func getFunctionalLocationList() {
        // mJCLogger.log("getFunctionalLocationList Start".localized(), Type: "")
        //        FunctionalLocationModel.getFuncLocationList(){(response, error)  in
        //            if error == nil{
        //                funcLocationArray.removeAll()
        //                funcLocationListArray.removeAll()
        //                if let responseArr = response["data"] as? [FunctionalLocationModel]{
        //                    if responseArr.count > 0 {
        //                        funcLocationArray =  responseArr
        //                        for item in funcLocationArray{
        //                            if !funcLocationListArray.contains(item.FunctionalLoc){
        //                                funcLocationListArray.append(item.FunctionalLoc)
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }
    func getEquipmentList() {
        //       mJCLogger.log("getEquipmentList Start".localized(), Type: "")
        //        EquipmentModel.getEquipmentList(){(response, error)  in
        //            if error == nil{
        //                if let responseArr = response["data"] as? [EquipmentModel]{
        //                    if responseArr.count > 0 {
        //                        totalEquipmentArray = responseArr
        //                        for item in totalEquipmentArray{
        //                            if !totalEquipmentListArray.contains(item.Equipment){
        //                                totalEquipmentListArray.append(item.Equipment)
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }
    //MARK: - Global Appstore Details
    func getWOStatusSet(){
        WorkOrderStatusHelper.getworkOrderValidStatusList(formate:true){ (response, error)  in
            if error == nil{
                if let arr = response["data"] as? [WorkOrderStatusModel]{
                    globalStatusArray = arr
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
            self.getGlobalPlantList()
        }
    }
    func getStatusCategoryData(){
        StatusCategoryHelper.getStatusCategoryList(formate:true){ (response, error) in
            if error == nil{
                if let arr = response["data"] as? [StatusCategoryModel]{
                    statusCategoryArr = arr
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
            self.getWOStatusSet()
        }
    }
    func getApplicationFeatureSet(){
        AppFeaturesHelper.getAppFeaturesList(formate:true){ (response, error)  in
            if error == nil{
                applicationFeatureArrayKeys.removeAll()
                if let arr = response["data"] as? [AppFeaturesModel]{
                    for item in arr{
                        if !applicationFeatureArrayKeys.contains(item.Feature){
                            applicationFeatureArrayKeys.append(item.Feature)
                        }
                    }
                }
                applicationFeatureArrayKeys.append("WoAttachments")
                applicationFeatureArrayKeys.append("WoForms")
                self.setWOcompleteFields()
                self.getNotificationType()
                self.getErrorArchiveSet()
            }else{
                self.setWOcompleteFields()
                self.getNotificationType()
                self.getErrorArchiveSet()
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
    //MARK: - Clear Downloaded Attachments
    func clearDownloadedAttachments() {
        let url1 = NSURL(fileURLWithPath: documentPath)
        let filePath = url1.appendingPathComponent("iCloud")?.path
        let fileDowloadPath = url1.appendingPathComponent("Download")?.path
        if myAsset.fileManager.fileExists(atPath: fileDowloadPath!) {
            do {
                let folderTitlesArr = try myAsset.fileManager.contentsOfDirectory(atPath: fileDowloadPath ?? "")
                for item in folderTitlesArr{
                    if !allListArray.contains(item){
                        let deletePath = (url1.appendingPathComponent("Download/\(item)")?.path)!
                        try myAsset.fileManager.removeItem(at: URL.init(fileURLWithPath: deletePath))
                    }
                }
            }catch{
                print("file does not exists",error)
            }
        }else{
            print("icloud file does not exists")
        }
        if myAsset.fileManager.fileExists(atPath: filePath!) {
            do {
                try myAsset.fileManager.removeItem(at: URL.init(fileURLWithPath: filePath!))
            }
            catch{
                print("file does not exists",error)
            }
        }else{
            print("icloud file does not exists")
        }
    }
    //MARK: - Upload Form Attachment..
    func uploadAllFormAttachment(formAttachmentArray : NSMutableArray,instanceId:String) {
        
        DispatchQueue.main.async {
            mJCLoader.startAnimating(status: "Saving".localized())
            for itemCount in 0..<formAttachmentArray.count {
                let propertyArray = formAttachmentArray[itemCount] as! NSMutableArray
                let entity = SODataEntityDefault(type: uploadFormContentSetEntity)
                print("============Attachment Data ==============")
                for prop in propertyArray {
                    let proper = prop as! SODataProperty
                    if proper.name == "InstanceId"{
                        proper.value = instanceId as NSObject
                    }
                    entity?.properties[proper.name as Any] = proper
                    if (entity?.properties[proper.name ?? ""] as! SODataProperty).name != "ImageData"{
                        print("Key : \((entity?.properties[proper.name ?? ""] as! SODataProperty).name)")
                        print("Value : \((entity?.properties[proper.name ?? ""] as! SODataProperty).value)")
                        print(".......................")
                    }else{
                        print("Key : \(proper.name ?? "")")
                        print("=================")
                    }

                }
                var flushReq = Bool()
                if itemCount == formAttachmentArray.count{
                    flushReq = true
                }else{
                    flushReq = false
                }
                FormAttachmentModel.createFormAttachment(entity: entity!, collectionPath: "FormAttachmentSet", flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
                    let value = (entity?.properties["FileName"] as! SODataProperty).value
                    if(error == nil) {
                        mJCLoader.stopAnimating()
                        print("\(String(describing: value)) Attachment Uploaded : Done")
                        mJCLogger.log("\(String(describing: value)) Attachment Uploaded : Done", Type: "Debug")
                        
                    }else {
                        mJCLoader.stopAnimating()
                        print("\(String(describing: value)) Attachment Uploaded : Fail")
                        mJCLogger.log("\(String(describing: value)) Attachment Uploaded : Fail", Type: "Error")
                    }
                })
            }
        }
    }
    //MARK: - get address for workorders and notificationns
    func getLocationDetailsForWorkOrders(Arr : [Any]) -> NSMutableArray {
        let coOrdinateArr = NSMutableArray()
        let addressDict = NSMutableDictionary()
        if addressPlistPath != nil{
            if myAsset.fileManager.fileExists(atPath: addressPlistPath!.path){
                let data = myAsset.fileManager.contents(atPath: addressPlistPath!.path)
                do {
                    let addressList = try PropertyListSerialization.propertyList(from: data!, options: .mutableContainersAndLeaves, format: nil) as! NSMutableDictionary
                    addressDict.addEntries(from: (addressList  as! [AnyHashable : Any]))

                }catch{
                    print("An error occurred while writing to plist")
                }
            }
        }
        if Arr.count != 0 {
            for i in 0..<Arr.count {
                let coOrdinateDic = NSMutableDictionary()
                if let workorder = Arr[i] as? WoHeaderModel{
                    var longitudeDob = Double()
                    var latitudeDob = Double()
                    if workorder.Latitude != 0 && workorder.Longitude != 0 {
                        longitudeDob = Double(truncating: workorder.Latitude as NSNumber)
                        latitudeDob = Double(truncating: workorder.Longitude as NSNumber)
                        coOrdinateDic.setValue(latitudeDob, forKey: "Latitude")
                        coOrdinateDic.setValue(longitudeDob, forKey: "Longitude")
                        coOrdinateDic.setValue(i, forKey: "Index")
                        coOrdinateDic.setValue(workorder.WorkOrderNum, forKey: "WorkOrderNumber")
                        coOrdinateDic.setValue(workorder.NotificationNum, forKey: "Notification")
                        coOrdinateArr.add(coOrdinateDic)
                    }else if (workorder.GeoLocation.contains(find: "x:") && workorder.GeoLocation.contains(find: "y:")) || (workorder.GeoLocation.contains(find: "X:") && workorder.GeoLocation.contains(find: "Y:")){
                        var longitude = String()
                        var latitude = String()
                        let geoLocation = workorder.GeoLocation
                        let coOrdinatesArr = geoLocation.components(separatedBy: ",")
                        if coOrdinatesArr.count == 2 {
                            let firstIndex = coOrdinatesArr[0]
                            let secondeIndex = coOrdinatesArr[1]
                            let longitudeArr = firstIndex.components(separatedBy: ":")
                            let latitudeArr = secondeIndex.components(separatedBy: ":")
                            if longitudeArr.count == 2 {
                                longitude = longitudeArr[1]
                                longitude = longitude.replacingOccurrences(of: " ", with: "")
                            }
                            if latitudeArr.count == 2{
                                latitude = latitudeArr[1]
                                latitude = latitude.replacingOccurrences(of: " ", with: "")
                            }
                            if longitude != "" && latitude != "" {
                                longitudeDob = Double(longitude) ?? 0.0
                                latitudeDob = Double(latitude) ?? 0.0
                                coOrdinateDic.setValue(latitudeDob, forKey: "Latitude")
                                coOrdinateDic.setValue(longitudeDob, forKey: "Longitude")
                                coOrdinateDic.setValue(i, forKey: "Index")
                                coOrdinateDic.setValue(workorder.WorkOrderNum, forKey: "WorkOrderNumber")
                                coOrdinateDic.setValue(workorder.NotificationNum, forKey: "Notification")
                                coOrdinateArr.add(coOrdinateDic)
                            }
                        }
                    }else if workorder.Address != ""{
                        if let dict  = addressDict.value(forKey: workorder.WorkOrderNum) as? NSMutableDictionary{
                            coOrdinateDic.setValue(Double(dict.value(forKey: "Latitude") as! String) ?? 0.0, forKey: "Latitude")
                            coOrdinateDic.setValue(Double(dict.value(forKey: "Longitude") as! String) ?? 0.0, forKey: "Longitude")
                            coOrdinateDic.setValue(i, forKey: "Index")
                            coOrdinateDic.setValue(workorder.WorkOrderNum, forKey: "WorkOrderNumber")
                            coOrdinateDic.setValue(workorder.NotificationNum, forKey: "Notification")
                            coOrdinateArr.add(coOrdinateDic)
                        }
                    }
                }else if let notification = Arr[i] as? NotificationModel{
                    var longitudeDob = Double()
                    var latitudeDob = Double()
                    if notification.Latitude != 0 && notification.Longitude != 0 {
                        longitudeDob = Double(truncating: notification.Latitude)
                        latitudeDob = Double(truncating: notification.Longitude)
                        coOrdinateDic.setValue(latitudeDob, forKey: "Latitude")
                        coOrdinateDic.setValue(longitudeDob, forKey: "Longitude")
                        coOrdinateDic.setValue(i, forKey: "Index")
                        coOrdinateDic.setValue(notification.WorkOrderNum, forKey: "WorkOrderNumber")
                        coOrdinateDic.setValue(notification.Notification, forKey: "Notification")
                        coOrdinateArr.add(coOrdinateDic)
                    }else if (notification.GeoLocation.contains(find: "x:") && notification.GeoLocation.contains(find: "y:")) || (notification.GeoLocation.contains(find: "X:") && notification.GeoLocation.contains(find: "Y:")){
                        var longitude = String()
                        var latitude = String()
                        let geoLocation = notification.GeoLocation
                        let coOrdinatesArr = geoLocation.components(separatedBy: ",")
                        if coOrdinatesArr.count == 2 {
                            let firstIndex = coOrdinatesArr[0]
                            if coOrdinatesArr.count > 1{
                                let secondeIndex = coOrdinatesArr[1]
                                let longitudeArr = firstIndex.components(separatedBy: ":")
                                let latitudeArr = secondeIndex.components(separatedBy: ":")
                                if longitudeArr.count == 2 {
                                    longitude = longitudeArr[1]
                                    longitude = longitude.replacingOccurrences(of: " ", with: "")
                                }
                                if latitudeArr.count == 2 {
                                    latitude = latitudeArr[1]
                                    latitude = latitude.replacingOccurrences(of: " ", with: "")
                                }
                                if longitude != "" && latitude != "" {
                                    longitudeDob = Double(longitude) ?? 0.0
                                    latitudeDob = Double(latitude) ?? 0.0
                                    coOrdinateDic.setValue(latitudeDob, forKey: "Latitude")
                                    coOrdinateDic.setValue(longitudeDob, forKey: "Longitude")
                                    coOrdinateDic.setValue(i, forKey: "Index")
                                    coOrdinateDic.setValue(notification.WorkOrderNum, forKey: "WorkOrderNumber")
                                    coOrdinateDic.setValue(notification.Notification, forKey: "Notification")
                                    coOrdinateArr.add(coOrdinateDic)
                                }
                            }
                        }
                    }else if notification.Address != ""{
                        if let dict  = addressDict.value(forKey: notification.Notification) as? NSMutableDictionary{
                            coOrdinateDic.setValue(Double(dict.value(forKey: "Latitude") as! String) ?? 0.0, forKey: "Latitude")
                            coOrdinateDic.setValue(Double(dict.value(forKey: "Longitude") as! String) ?? 0.0, forKey: "Longitude")
                            coOrdinateDic.setValue(i, forKey: "Index")
                            coOrdinateDic.setValue(notification.WorkOrderNum, forKey: "WorkOrderNumber")
                            coOrdinateDic.setValue(notification.Notification, forKey: "Notification")
                            coOrdinateArr.add(coOrdinateDic)
                        }
                    }
                }
            }
        }
        return coOrdinateArr
    }
    func getLatLongfromAddress(list:NSMutableArray){

        let addressDict = NSMutableDictionary()
        let addressArr = NSMutableArray()

        if addressPlistPath != nil{
            if myAsset.fileManager.fileExists(atPath: addressPlistPath!.path){
                let data = myAsset.fileManager.contents(atPath: addressPlistPath!.path)
                do {
                    let addressList = try PropertyListSerialization.propertyList(from: data!, options: .mutableContainersAndLeaves, format: nil) as! NSMutableDictionary
                    addressDict.addEntries(from: (addressList  as! [AnyHashable : Any]))
                }catch{
                    print("An error occurred while writing to plist")
                }
            }
        }
        for i in 0..<list.count{
            if let dict = list[i] as? NSMutableDictionary{
                let object = dict.allKeys[0] as! String
                if !(addressDict.allKeys as NSArray).contains(object){
                    addressArr.add(list[i])
                }
            }
        }
        for i in 0..<addressArr.count{
            if let dict = addressArr[i] as? NSMutableDictionary{
                let address = dict.allValues[0] as! String
                let object = dict.allKeys[0] as! String
                self.getLatLongfromGoogle(address: address, object: object){ (response)  in
                    DispatchQueue.main.async{
                        let coOrdinates = response.components(separatedBy: "_")
                        if coOrdinates.count == 4{
                            let dict = NSMutableDictionary()
                            dict.setValue(coOrdinates[0], forKey: "Longitude")
                            dict.setValue(coOrdinates[1], forKey: "Latitude")
                            dict.setValue(coOrdinates[2], forKey: "Address")
                            addressDict.setValue(dict, forKey: coOrdinates[3])
                            let plistContent = NSDictionary(dictionary: addressDict)
                            let success:Bool = plistContent.write(toFile: addressPlistPath!.path, atomically: true)
                        }
                    }
                }
            }
        }
    }
    func getLatLongfromGoogle(address: String,object:String,callback: @escaping (String) -> ()){
        DispatchQueue.main.async{
            let add = address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            let urlStr : NSString = "https://maps.google.com/maps/api/geocode/json?sensor=false&address=\(String(describing: add))&key=\(GoogleAPIKey)" as NSString
            if let searchURL : NSURL = NSURL(string: urlStr as String) {
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let task = session.dataTask(with: searchURL as URL) { ( data,  response,  error) in
                    if (error == nil) {
                        do {
                            let  responseDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            if let result = (responseDictionary as AnyObject).value(forKey: "results") as? NSArray {
                                if result.count > 0 {
                                    var callbackstr = String()
                                    if let geometry = (result[0] as AnyObject).value(forKey:"geometry") as? NSDictionary {
                                        if let location = geometry.value(forKey:"location") as? NSDictionary {
                                            let latitude = ((location.value(forKey:"lat") as AnyObject).doubleValue)!
                                            let longitude = ((location.value(forKey:"lng")as AnyObject).doubleValue)!
                                            callbackstr = "\(longitude)_\(latitude)_\(address)_\(object)"
                                            callback(callbackstr)
                                        }
                                    }
                                }
                            }
                        } catch let error as NSError {
                            debugPrint(error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    //MARK: - Post Operation Confirmation
    func postoperationconformation(changeDate:Date,toDate:Date ,statusCategoryObj:StatusCategoryModel,flushReq:Bool){
        mJCLogger.log("postoperationconformation start".localized(), Type: "")
        mJCLogger.log("Conformation Start time \(changeDate)", Type: "")
        mJCLogger.log("Conformation End time \(toDate)", Type: "")
        let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
        let  timeDifference = Calendar.current.dateComponents(requestedComponent, from: changeDate as Date, to: toDate)
        mJCLogger.log("Conformation time Difference  \(timeDifference)", Type: "")
        let activitytype = statusCategoryObj.ActivityType
        let status = statusCategoryObj.StatusCode
        
        var finalstartDate = Date()
        var finalendDate = Date()
        let singleOperationClass = singleOperation
        let property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfCounter")
        let count = "0000\(String.random(length: 4, type: "Number"))"
        
        prop!.value = count as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = selectedOperationNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOper")
        prop!.value = singleOperation.SubOperation as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Split")
        prop!.value = 0 as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PostgDate")
        prop!.value = Date().localDate() as NSObject
        mJCLogger.log("Conformation PostgDate \(Date().localDate())", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FcstFinDate")
        prop!.value = Date().localDate() as NSObject
        mJCLogger.log("Conformation FcstFinDate \(Date().localDate())", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedDate")
        prop!.value = Date().localDate() as NSObject
        mJCLogger.log("Conformation ExCreatedDate \(Date().localDate())", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        mJCLogger.log("Conformation ExCreatedTime \(time)", Type: "")
        mJCLogger.log("Conformation FcstFinTime \(time)", Type: "")
        property.add(prop!)
        var basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FcstFinTime")
        prop!.value = basicTime
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = singleOperationClass.Plant as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkCntr")
        prop!.value = singleOperationClass.WorkCenter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        if  WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            
            var ActualDur = String()
            ActualDur = "\(abs(timeDifference.hour! * 60 + timeDifference.minute!))"
            
            finalstartDate = changeDate
            finalendDate = toDate
            
            prop = SODataPropertyDefault(name: "ActType")
            prop!.value = activitytype as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "UnActDur")
            prop!.value = "MIN" as NSObject
            property.add(prop!)
            
            prop = SODataPropertyDefault(name: "ActualDur")
            prop!.value = NSDecimalNumber(string: ActualDur)
            mJCLogger.log("Conformation ActualDur \(ActualDur)", Type: "")
            property.add(prop!)

            prop = SODataPropertyDefault(name: "ConfText")
            prop!.value = "confirmation text." as NSObject
            property.add(prop!)
        }else{
            prop = SODataPropertyDefault(name: "ConfText")
            prop!.value = OPERATION_COMPLETE_TEXT as NSObject
            property.add(prop!)
        }
        prop = SODataPropertyDefault(name: "FinConf")
        if status == "COMP"{
            prop!.value = STATUS_SET_FLAG as NSObject
        }else{
            prop!.value = "" as NSObject
        }
        property.add(prop!)

        prop = SODataPropertyDefault(name: "Complete")
        if status == "COMP"{
            prop!.value = STATUS_SET_FLAG as NSObject
        }else{
            prop!.value = "" as NSObject
        }
        property.add(prop!)

        prop = SODataPropertyDefault(name: "ExecStartDate")
        prop!.value = finalstartDate as NSDate
        property.add(prop!)
        
        let arr = "\(finalstartDate)".components(separatedBy: " ")
        if arr.count > 1{
            let time = arr[1]
            basicTimeArray = time.components(separatedBy:":")
            let basicTime1 = SODataDuration()
            
            basicTime1.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime1.minutes = Int(basicTimeArray[1]) as NSNumber?
            basicTime1.seconds = Int(basicTimeArray[2]) as NSNumber?
            
            prop = SODataPropertyDefault(name: "ExecStartTime")
            prop!.value = basicTime1
            property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "ExecFinDate")
        prop!.value = finalendDate as NSDate
        property.add(prop!)
        
        let arr1 = "\(finalendDate)".components(separatedBy: " ")
        if arr1.count > 1{
            let time = arr[1]
            let basicTime2 = SODataDuration()
            basicTimeArray = time.components(separatedBy:":")
            basicTime2.hours = Int(basicTimeArray[0]) as NSNumber?
            basicTime2.minutes = Int(basicTimeArray[1]) as NSNumber?
            basicTime2.seconds = Int(basicTimeArray[2]) as NSNumber?
            
            prop = SODataPropertyDefault(name: "ExecFinTime")
            prop!.value = basicTime2
            property.add(prop!)
        }
        
        
        let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
        for prop in property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("...............")
        }
        WoOperationModel.createWoConfirmationEntity(entity: entity!, collectionPath: woConfirmationSet, flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("conformation posted".localized(), Type: "Debug")
            }else {
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
    }
    //MARK: - Logout App
    func logOutApp(){
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_POPUP_LOGOUT", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let unFlushData = mJCStoreHelper.checkForUnflushedData()
                if logoutValue == true {
                    if unFlushData == true && demoModeEnabled != true{
                        let actionSheet : UIAlertController = UIAlertController(title: alerttitle, message: "There_are_pending_requests_to_be_sent_to_server_please_perform_transmit_before_you_logout".localized(), preferredStyle: .alert)
                        let saveActionButton: UIAlertAction = UIAlertAction(title: okay, style: .cancel) { action -> Void in
                        }
                        actionSheet.addAction(saveActionButton)
                        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
                    }else {
                        let actionSheet : UIAlertController = UIAlertController(title: alerttitle, message: "You_are_logging_out_from_the_app_do_u_want_continue".localized(), preferredStyle: .alert)
                        let saveActionButton: UIAlertAction = UIAlertAction(title: Yesalert, style: .cancel) { action -> Void in
                            self.logOut()
                        }
                        actionSheet.addAction(saveActionButton)
                        let cancelActionButton: UIAlertAction = UIAlertAction(title: Noalert, style: .default) { action -> Void in
                        }
                        actionSheet.addAction(cancelActionButton)
                        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
                    }
                }else {
                    self.logOut()
                }
            }
        }
    }
    func logOut() {

        singleNotification =  NotificationModel()
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = "LogOut"
        let storeCloseArr = mJCStoreHelper.closeOfflineStores()
        if storeCloseArr == false{
            let actionSheet : UIAlertController = UIAlertController(title: alerttitle, message: "Store Closing Failed Please try again", preferredStyle: .alert)
            let saveActionButton: UIAlertAction = UIAlertAction(title: okay, style: .cancel) { action -> Void in }
            actionSheet.addAction(saveActionButton)
            UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        }else{
            if KILL_APP_ON_LOGOUT{
                exit(0)
            }else{
                DispatchQueue.main.async {
                    let loginVc = ScreenManager.getLoginScreen()
                    loginVc.fromLogOut = true
                    self.appDeli.window?.rootViewController = loginVc
                    self.appDeli.window?.makeKeyAndVisible()
                }
            }
        }
    }
    //MARK: - App Status Bar
    func methodStatusBarColorChange() {
        if #available(iOS 13.0, *) {
            if let statusbar = UIApplication.shared.keyWindow?.viewWithTag(1234){
                DispatchQueue.main.async{
                    UIApplication.shared.keyWindow?.bringSubviewToFront(statusbar)
                }
            }else{
                DispatchQueue.main.async{
                    let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                    statusBar.backgroundColor = appColor
                    statusBar.tag = 1234
                    UIApplication.shared.keyWindow?.addSubview(statusBar)
                    UIApplication.shared.keyWindow?.bringSubviewToFront(statusBar)
                }
            }
        }else {
            let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
            statusBar?.backgroundColor = appColor
            statusBar?.setNeedsDisplay()
        }
    }
    // MARK: - Get global Transaction Dat
    func getAllWorkorders(from: String){
        WoHeaderModel.getWorkorderList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoHeaderModel]{
                    allworkorderArray.removeAll()
                    allworkorderArray = responseArr
                    self.getAllOperations(from: from)
                    if (WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3") && from == "transmit"{
                        let statusArr = DEFAULT_STATUS_TO_CHANGE.components(separatedBy: ",")
                        let predicate = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", statusArr as [AnyObject],statusArr as [AnyObject])
                        let newWorkArray = allworkorderArray.filter{predicate.evaluate(with: $0)}
                        if newWorkArray.count > 0{
                            for i in 0..<newWorkArray.count{
                                let workOrderCls = newWorkArray[i]
                                _  = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: workOrderCls.UserStatus, mobileStatus: workOrderCls.MobileObjectType, woClass: workOrderCls)
                            }
                        }else{
                            mJCLogger.log("Workorder status update not needed", Type: "info")
                        }
                    }
                    if GOOGLE_MAP_API_CALL_ENABLED == true{
                        let addressArr = NSMutableArray()
                        for workorder in responseArr{
                            if (workorder.Latitude == 0 && workorder.Longitude == 0) && workorder.Address != "" && (workorder.GeoLocation == "" || workorder.GeoLocation == "x:,y:"){
                                let dict = NSMutableDictionary()
                                dict.setValue(workorder.Address, forKey: workorder.WorkOrderNum)
                                addressArr.add(dict)
                            }
                        }
                        myAssetDataManager.uniqueInstance.getLatLongfromAddress(list: addressArr)
                    }
                }else{
                    self.getAllOperations(from : from)
                }
            }else{
                self.getAllOperations(from: from)
            }
        }
    }
    func getAllOperations(from:String) {

        let defineQuery = "$filter= startswith(SystemStatus,'" + "DLT" + "') ne true&$orderby=WorkOrderNum,OperationNum,SubOperation"

        WoOperationModel.getOperationList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    if responseArr.count > 0 {
                        allOperationsArray = responseArr
                        self.getAllNotification(from: from)
                        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && from == "transmit"{
                            let statusArr = DEFAULT_STATUS_TO_CHANGE.components(separatedBy: ",")
                            let predicate = NSPredicate(format: "MobileStatus IN %@ || UserStatus In %@", statusArr as [AnyObject],statusArr as [AnyObject])
                            let newoprArray = allOperationsArray.filter{predicate.evaluate(with: $0)}
                            if newoprArray.count > 0{
                                for i in 0..<newoprArray.count{
                                    let oprclss = newoprArray[i]
                                    _  = WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: oprclss.UserStatus, mobileStatus: oprclss.MobileStatus, oprClass: oprclss)
                                }
                            }else{
                                mJCLogger.log("Operation status update not needed", Type: "info")
                            }
                        }
                    }else{
                        self.getAllNotification(from: from)
                    }
                }
            }else{
                self.getAllNotification(from: from)
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
    func getAllNotification(from: String){

        NotificationModel.getNotificationList(){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [NotificationModel]{
                    allNotficationArray.removeAll()
                    allNotficationArray = responseArr
                    if from == "transmit"{
                        self.getFlushErrors(isFromBtn: false, count: 0)
                    }else if from == "first"{
                        self.getStatusCategoryData()
                    }
                    self.allListArray.removeAll()
                    for item in allworkorderArray{
                        if !self.allListArray.contains(item.WorkOrderNum){
                            self.allListArray.append(item.WorkOrderNum)
                        }
                        if !self.allListArray.contains(item.EquipNum){
                            self.allListArray.append(item.EquipNum)
                        }
                        let floc = item.FuncLocation.replacingOccurrences(of: "/", with: "_")
                        if !self.allListArray.contains(floc){
                            self.allListArray.append(floc)
                        }
                    }
                    for item in allNotficationArray{
                        if !self.allListArray.contains(item.Notification){
                            self.allListArray.append(item.Notification)
                        }
                        if !self.allListArray.contains(item.Equipment){
                            self.allListArray.append(item.Equipment)
                        }
                        let floc = item.FunctionalLoc.replacingOccurrences(of: "/", with: "_")
                        if !self.allListArray.contains(floc){
                            self.allListArray.append(floc)
                        }
                    }
                    self.clearDownloadedAttachments()
                }
            }
        }
    }
    func getAttachmentsInBatch(){
        let woAttachemts = "\(woAttachmentSet)?$select=ObjectKey"
        let noAttachemts = "NOAttachmentSet?$select=ObjectKey"
        let uploadWoAttachments = "\(uploadWOAttachmentContentSet)?$select=WorkOrderNum$filter=(BINARY_FLG ne 'N')"
        let uploadNoAttachments = "\(uploadNOAttachmentContentSet)?$select=Notification$filter=(BINARY_FLG ne 'N')"
        let batchArr = NSMutableArray()
        batchArr.add(woAttachemts)
        batchArr.add(noAttachemts)
        batchArr.add(uploadWoAttachments)
        batchArr.add(uploadNoAttachments)

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
                    var woAttchArr = [String]()
                    var noAttchArr = [String]()
                    for key in responseDic.allKeys{
                        let resourcePath = key as! String
                        if resourcePath == woAttachmentSet {
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let arr = mJCHelperClass.getAttachmentlist(dictionary: dictval)
                            woAttchArr.append(contentsOf: arr)
                        }else if resourcePath == uploadWOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let arr = mJCHelperClass.getAttachmentlist(dictionary: dictval)
                            woAttchArr.append(contentsOf: arr)
                        }else if resourcePath == "NOAttachmentSet"{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let arr = mJCHelperClass.getAttachmentlist(dictionary: dictval)
                            noAttchArr.append(contentsOf: arr)
                        }else if resourcePath == uploadNOAttachmentContentSet{
                            let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                            let arr = mJCHelperClass.getAttachmentlist(dictionary: dictval)
                            noAttchArr.append(contentsOf: arr)
                        }
                    }
                    globalWoAttachmentArr.removeAll()
                    globalNoAttachmentArr.removeAll()
                    globalWoAttachmentArr = woAttchArr.uniqued()
                    globalNoAttachmentArr = noAttchArr.uniqued()
                }
            }
        }
    }
    //MARK: - Get Form Page
    func getFormsPage(formDetails:String,screen:UIViewController,statusCategoryCls:StatusCategoryModel,formFrom:String) {
        
        let formDetailArr = formDetails.components(separatedBy: "#")
        let formID = formDetailArr[0]
        let version = formDetailArr[1]
        
        let defineQuery = "$filter=(FormID eq '\(formID)' and Version eq '\(version)')"
        FormAssignDataModel.getAssgnedFormData(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let formList = response["data"] as? [FormAssignDataModel]{
                    if formList.count > 0{
                        DispatchQueue.main.async{
                            let FormDataModel = formList[0]
                            let newformsVC = ScreenManager.getCheckSheetViewerScreen()
                            newformsVC.formClass = FormDataModel
                            newformsVC.isFromEditScreen = false
                            newformsVC.fromScreen = formFrom
                            newformsVC.delegate = screen as? formSaveDelegate
                            newformsVC.statusCategoryCls = statusCategoryCls
                            newformsVC.modalPresentationStyle = .fullScreen
                            screen.present(newformsVC, animated: true, completion: nil)
                        }
                    }else{
                        myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: "", msg: "WorkFlowError".localized())
                    }
                }else{
                    myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: "", msg: "WorkFlowError".localized())
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
    func getcurrentuserdetails(){

        appUserTableModel.getUserDetailsList(){ (response, error) in
            if error == nil{
                if let arr = response["data"] as? [appUserTableModel]{
                     let detailsArr = self.getLoggedInUserDetailsInFormate(detailArr: arr)
                    self.setPersonRespronsible(detailArr: detailsArr, from: true)
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
    //MARK: - get logged in user details formate
    func getLoggedInUserDetailsInFormate(detailArr : [appUserTableModel]) -> [UserDetailsModel] {

        var userDetailsArr = [UserDetailsModel]()
        let userDetailsCls = UserDetailsModel()
        for item in detailArr{
            if item.SettingName == "RFPNR" && item.SettingValue != ""{
                userDetailsCls.Supervisor = item.SettingValue
            }
            if item.SettingName == "/ODS/TECH" && item.SettingValue == "X"{
                userDetailsCls.Supervisor = ""
            }
            if item.SettingName == "PERS_SUBAREA" && item.SettingValue != ""{
                userDetailsCls.Pers_Subarea = item.SettingValue
            }
            if item.SettingName == "COMP_CODE" && item.SettingValue != ""{
                userDetailsCls.Comp_code = item.SettingValue
            }
            if item.SettingName == "EMPLOYEE_GROUP" && item.SettingValue != ""{
                userDetailsCls.Emp_group = item.SettingValue
            }
            if item.SettingName == "JOB" && item.SettingValue != ""{
                userDetailsCls.Job = item.SettingValue
            }
            if item.SettingName == "LASTNAME" && item.SettingValue != ""{
                userDetailsCls.LastName = item.SettingValue
            }
            if item.SettingName == "PERNO" && item.SettingValue != ""{
                userDetailsCls.PersonnelNo = item.SettingValue
            }
            if item.SettingName == "FIRSTNAME" && item.SettingValue != ""{
                userDetailsCls.FirstName = item.SettingValue
            }
            if item.SettingName == "VAP" && item.SettingValue != ""{
                userDetailsCls.WorkCenter = item.SettingValue
            }
            if item.SettingName == "PERS_AREA" && item.SettingValue != ""{
                userDetailsCls.PersonnelArea = item.SettingValue
            }
            if item.SettingName == "POSITION" && item.SettingValue != ""{
                userDetailsCls.Position = item.SettingValue
            }
            if item.SettingName == "IWK" && item.SettingValue != ""{
                userDetailsCls.Plant = item.SettingValue
            }
            if item.SettingName == "ORG_UNIT" && item.SettingValue != ""{
                userDetailsCls.Org_unit = item.SettingValue
            }
            if item.SettingName == "CO_AREA" && item.SettingValue != ""{
                userDetailsCls.COArea = item.SettingValue
            }
            if item.SettingName == "KOS" && item.SettingValue != ""{
                userDetailsCls.CostCenter = item.SettingValue
            }
            if item.SettingName == "EMPLOYEE_SUBGROUP" && item.SettingValue != ""{
                userDetailsCls.Emp_SubGroup = item.SettingValue
            }
            if item.SettingName == "AGR" && item.SettingValue != ""{
                userDetailsCls.OpWorkCentter = item.SettingValue
            }
            if item.SettingName == "LAG" && item.SettingValue != ""{
                userDetailsCls.userStorageLocation = item.SettingValue
            }
            if item.SettingName == "WORKORDER_ASSIGNMENT_TYPE" && item.SettingValue != ""{
                userDetailsCls.WORKORDER_ASSIGNMENT_TYPE = item.SettingValue
            }
            if item.SettingName == "NOTIFICATION_ASSIGNMENT_TYPE" && item.SettingValue != ""{
                userDetailsCls.NOTIFICATION_ASSIGNMENT_TYPE = item.SettingValue
            }
            if item.SettingName == "ADD_ASSIGNMENT_TYPE" && item.SettingValue != ""{
                userDetailsCls.ADD_ASSIGNMENT_TYPE = item.SettingValue
            }
            if item.SettingName == "ROLE_ID" && item.SettingValue != ""{
                userDetailsCls.Role_ID = item.SettingValue
            }
            if item.SettingName == "DATE_FORMAT" && item.SettingValue != ""{
                localDateFormate = self.getLocalDateFormate(formate: item.SettingValue)
                localDateTimeFormate = "\(localDateFormate) HH:mm"
                ODSDateHelper.dateFormate = localDateFormate
            }
        }
        userDetailsCls.Userdisplayname = userDetailsCls.FirstName + " " + userDetailsCls.LastName
        userDetailsArr.append(userDetailsCls)
        return userDetailsArr
    }
    //MARK: - Flush delegates
    func offlineStoreFlushStarted(storeName: String, syncType: String) {
        print("\(storeName) FlushStarted \(Date().localDate())")
        flushStatus = true
        if syncType == "single" || syncType == ""{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"BgSyncStarted"), object: "")
        }
        print("\(storeName) flush Started")
    }
    func offlineStoreFlushSucceeded(storeName: String, syncType: String) {
        print("\(storeName) FlushFinished \(Date().localDate())")
    }
    func offlineStoreFlushFailed(storeName: String, error: Error!) {
        flushStatus = false
        print("\(storeName)FlushFailed == >\(String(describing: error?.localizedDescription))")
        mJCLogger.log("\(storeName)FlushFailed == >\(String(describing: error?.localizedDescription))", Type: "Error")
        self.showtoastmsg(actionTitle: "", msg: "\(storeName) flush failed - \(String(describing: error?.localizedDescription))".localized())
        self.flushFailedArr.append(FandRStoreName)
    }
    //MARK: -  refresh delegate
    func offlineStoreRefreshStarted(storeName: String, syncType: String) {
        print("\(storeName) refresh started\(Date().localDate())")
        flushStatus = true
        if syncType == "Manual" || syncType == ""{
            mJCLoader.startAnimating(status: "Downloading".localized())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue:"BgSyncStarted"), object: "")
        }
    }
    func offlineStoreRefreshSucceeded(storeName: String, syncType: String) {
        print("\(storeName) refresh finished\(Date().localDate())")
    }
    func offlineStoreRefreshFailed(storeName: String, error: Error!) {
        print("\(storeName) Store refreh failed  ==>\(error?.localizedDescription ?? "")")
        mJCLogger.log("\(self.FandRStoreName) Store refresh fail Reason ==>\(String(describing: error?.localizedDescription))", Type: "Error")
        self.showtoastmsg(actionTitle: "", msg: "\(storeName) refresh failed - \(String(describing: error?.localizedDescription))".localized())
        self.refreshFailedArr.append(FandRStoreName)
    }
    //MARK: - Flush & refresh status
    func StoreFlushCompleted(syncType: String) {
        flushStatus = false
        mJCLoader.stopAnimating()
        print("flush Completed")
    }
    func backgroundSyncflushStatus(storeName: String, message: String) {
        flushStatus = false
        self.showtoastmsg(actionTitle: "", msg: "\(message)".localized())
    }
    func storeRefreshCompleted(syncType: String) {
        flushStatus = false
        mJCLoader.stopAnimating()
        print("All Stores refresh completed\(Date().localDate())")
        if syncType == "master"{
            self.showtoastmsg(actionTitle: "", msg: "Master_data_refresh_completed".localized())
            self.dataFetchCompleteDelegate = nil
            self.getCatalogProfileSet()
            self.getAllUserdetails()
            self.getApplicationFeatureSet()
            self.getStatusCategoryData()
            NotificationCenter.default.post(name: Notification.Name(rawValue:"storeFlushAndRefreshDone"), object: "")
        }else{
            self.dataFetchCompleteDelegate = nil
            self.getAttachmentsInBatch()
            self.getAllWorkorders(from: "transmit")
        }
    }
    func flushAndRefreshStores(masterDataRefresh:Bool) {
        if demoModeEnabled == true{
            mJCLoader.stopAnimating()
            self.showtoastmsg(actionTitle: "", msg: "We_have_limited_features_enabled_in_Demo_mode".localized())
        }else{
            isMasterRefresh  = masterDataRefresh
            if flushStatus == false{
                if masterDataRefresh == true{
                    mJCLoader.startAnimating(status: "Downloading".localized())
                }
                mJCStoreHelper.flushAndRefreshStores(masterDataRefresh: masterDataRefresh, flushDelegate: self, refreshDelegate: self)
            }else{
                mJCLoader.stopAnimating()
                self.showtoastmsg(actionTitle: "", msg: "Application_Syncng".localized())
            }
        }
    }
    func refreshCompleted(){
        if self.flushFailedArr.count == 0 && self.refreshFailedArr.count == 0{
            if isMasterRefresh {
                self.getCatalogProfileSet()
                mJCLogger.log("Synchronization completed".localized(), Type: "Debug")
                NotificationCenter.default.post(name: Notification.Name(rawValue:"storeFlushAndRefreshDone"), object: "")
                UserDefaults.standard.setValue(Date().localDate(), forKey: "lastSyncDate_Master")
                mJCLoader.stopAnimating()
            }else {
                UserDefaults.standard.setValue(Date().localDate(), forKey: "lastSyncDate")
                mJCLogger.log("Synchronization completed".localized(), Type: "Debug")
                DispatchQueue.main.async {
                    if flushErrorsArray.count > 0{
                        self.showtoastmsg(actionTitle: "FlushError".localized(), msg: "Data_flush_Completed_with_Errors,_Click_on_View".localized())
                    }else{
                        self.showtoastmsg(actionTitle: "", msg: "Synchronization_completed".localized())
                        mJCLoader.stopAnimating()
                    }
                }
                mJCLoader.stopAnimating()
            }
        }else{
            if self.flushFailedArr.count > 0{
                self.flushFailedArr.removeAll()
                self.showtoastmsg(actionTitle: "", msg: "Store_Flush_Failed".localized())
            }else  if refreshFailedArr.count > 0{
                self.refreshFailedArr.removeAll()
                self.showtoastmsg(actionTitle: "", msg: "Store_Refresh_Failed".localized())
            }
            mJCLoader.stopAnimating()
            NotificationCenter.default.post(name: Notification.Name(rawValue:"storeFlushAndRefreshDone"), object: "")
        }
    }
    func backgroundSyncRefreshStatus(storeName: String, message: String) {}
    //MARK: - Form task type Query
    public static func getAssignementType2Query() -> String{
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var queryStr = ""
        for item in oprArray{
            if item.ControlKey != "" && item.OrderType != ""{
                if queryStr.count == 0{
                    queryStr = queryStr + "(ControlKey eq '\(item.ControlKey)'"
                }else{
                    queryStr = queryStr + "or " + "ControlKey eq '\(item.ControlKey)'"
                }
            }
        }
        if queryStr.count != 0{
            queryStr = queryStr + ") and " + "OrderType eq '\(singleWorkOrder.OrderType)'"
        }
        return queryStr
    }
    public static func getAssignmentType3Query() -> String{
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var queryStr = ""
        for item in oprArray{
            if item.EquipCategory != ""{
                if queryStr.count == 0{
                    queryStr = queryStr + "EquipCategory eq '\(item.EquipCategory)'"
                }else{
                    queryStr = queryStr + "or " + "EquipCategory eq '\(item.EquipCategory)'"
                }
            }
        }
        return queryStr
    }
    public static func getAssignement4Query() -> String{
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var queryStr = ""
        for item in oprArray{
            if item.FuncLocCategory != ""{
                if queryStr.count == 0{
                    queryStr = queryStr + "FuncLocCategory eq '\(item.FuncLocCategory)'"
                }else{
                    queryStr = queryStr + "or " + "FuncLocCategory eq '\(item.FuncLocCategory)'"
                }
            }
        }
        return queryStr
    }
    public static func getAssignement5Query() -> String {
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var orderTypeArr = [String]()
        var taskListTypeArr = [String]()
        var groupArr = [String]()
        var groupCounterArr = [String]()
        var internalCounterArr = [String]()
        var equipCategoryArr = [String]()
        var funcLocCategoryArr = [String]()
        var controlKeyArr = [String]()
        for item in oprArray{
            orderTypeArr.append("OrderType eq '\(item.OrderType)'")
            taskListTypeArr.append("TaskListType eq '\(item.TaskListType)'")
            groupArr.append("Group eq '\(item.Group)'")
            groupCounterArr.append("GroupCounter eq '\(item.GroupCounter)'")
            internalCounterArr.append("InternalCounter eq '\(item.InternalCounter)'")
            equipCategoryArr.append("EquipCategory eq '\(item.EquipCategory)'")
            funcLocCategoryArr.append("FuncLocCategory eq '\(item.FuncLocCategory)'")
            controlKeyArr.append("ControlKey eq '\(item.ControlKey)'")
        }
        let orderTypeStr = orderTypeArr.uniqued().joined(separator: " or ")
        let taskListTypeStr = taskListTypeArr.uniqued().joined(separator: " or ")
        let groupStr = groupArr.uniqued().joined(separator: " or ")
        let groupCounterStr = groupCounterArr.uniqued().joined(separator: " or ")
        let internalCounterStr = internalCounterArr.uniqued().joined(separator: " or ")
        let equipCategoryStr = equipCategoryArr.uniqued().joined(separator: " or ")
        let funcLocCategoryStr = funcLocCategoryArr.uniqued().joined(separator: " or ")
        let controlKeyStr = controlKeyArr.uniqued().joined(separator: " or ")
        let defineQuery = "\(formAssingmentSet)?$filter=((\(controlKeyStr)) and (\(orderTypeStr)) and (\(taskListTypeStr)) and (\(groupStr)) and (\(groupCounterStr)) and (\(internalCounterStr)) and (\(equipCategoryStr)) and (\(funcLocCategoryStr)))&$orderby=Mandatory"
        return defineQuery
    }
    public static func getAssignementType7Query() -> String{
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var queryStr = ""
        for item in oprArray{
            if item.ControlKey != "" && item.OrderType != ""{
                if queryStr.count == 0{
                    queryStr = queryStr + "(OprNum eq '\(item.OperationNum)'"
                }else{
                    queryStr = queryStr + "or " + "OprNum eq '\(item.OperationNum)'"
                }
            }
        }
        if queryStr.count != 0{
            queryStr = queryStr + ") and " + "WorkOrderNum eq '\(singleWorkOrder.WorkOrderNum)'"
        }
        return queryStr
    }
    public static func getAssignmentType8Query() -> String{
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var queryStr = ""
        for item in oprArray{
            if item.Equipment != ""{
                if queryStr.count == 0{
                    queryStr = queryStr + "Equipment eq '\(item.EquipCategory)'"
                }else{
                    queryStr = queryStr + "or " + "Equipment eq '\(item.EquipCategory)'"
                }
            }
        }
        return queryStr
    }
    public static func getAssignmentType9Query() -> String{
        let oprArray = allOperationsArray.filter{$0.WorkOrderNum == "\(selectedworkOrderNumber)"}
        var queryStr = ""
        for item in oprArray{
            if item.FuncLoc != ""{
                if queryStr.count == 0{
                    queryStr = queryStr + "FuncLoc eq '\(item.EquipCategory)'"
                }else{
                    queryStr = queryStr + "or " + "FuncLoc eq '\(item.EquipCategory)'"
                }
            }
        }
        return queryStr
    }
    // MARK: - Global Method
    func getWorkFlowForAction(event:String,orderType:String,from:String) -> Any {
        var level = String()
        if from == "WorkOrder" {
            if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "1"{
                level = WorkorderLevel
            }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                level = OperationLevel
            }else{
                level = WORKORDER_ASSIGNMENT_TYPE
            }
        }else if from == "Notification" {
            if NOTIFICATION_ASSIGNMENT_TYPE == "1" {
                level = NotificationLevel
            }else if NOTIFICATION_ASSIGNMENT_TYPE == "2"{
                level = NotificationLevel
            }
        }else{
            level = from
        }
        var workflowObj : Any?
        var filteredArray = workFlowListArray.filter{$0.Event == event && $0.ObjectCategory == level && ($0.ObjectType == orderType || $0.Active == "X")}
        if filteredArray.count == 0 {
            filteredArray = workFlowListArray.filter{$0.Event == event && $0.ObjectCategory == level && ($0.ObjectType == "X" || $0.Active == "X")}
        }
        if filteredArray.count > 0 {
            workflowObj = filteredArray[0]
        }else {
            workflowObj = nil
        }
        return workflowObj as Any
    }
    public static func getPriorityImage(priority:String) -> UIImage{
        if priority == "1"{
            return UIImage(named: "Priority_Red")!
        }else if priority == "2"{
            return UIImage(named: "Priority_Orage")!
        }else if priority == "3"{
            return UIImage(named: "Priority_Blue")!
        }else if priority == "4"{
            return UIImage(named: "Priority_Green")!
        }else{
            return UIImage(named: "Priority_Black")!
        }
    }
    public static func setPriorityFilterColor(priority:String) -> UIColor{
        if priority == "1"{
            return UIColor.systemRed
        }else if priority == "2"{
            return UIColor.systemOrange
        }else if priority == "3"{
            return UIColor.systemBlue
        }else if priority == "4"{
            return UIColor.systemGreen
        }else if priority == ""{
            return UIColor.black
        }else{
            return UIColor.black
        }
    }
    public static func setColor(count:Int) -> UIColor{
        mJCLogger.log("Starting", Type: "info")
        let color = colorArray[count % colorArray.count]
        mJCLogger.log("Ended", Type: "info")
        return UIColor.init(hexString: color)
    }
    static func setMandatoryLabel(label:UILabel){
        let text = label.text! + " *"
        let range = (text as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:text)
        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        attributedString.addAttributes(yourAttributes, range: range)
        label.attributedText = attributedString;
    }
    static func removeMandatoryLabel(label:UILabel){
        label.text = label.text?.replacingLastOccurrenceOfString(" *", with: "")
    }
    func getUniqueIDsFromArrayOfObjects(list:[Any])->[String]{
        var numbers = [String]()
        if let arr = list as? [WoHeaderModel]{
            let workorderNums = arr.map{$0.WorkOrderNum}
            let Numberset = Set(workorderNums)
            numbers = Array(Numberset)
        }else if let arr = list as? [WoOperationModel]{
            let workorderNums = arr.map{$0.WorkOrderNum }
            let Numberset = Set(workorderNums)
            numbers = Array(Numberset)
        }
        return numbers
    }
    func getEquipmentWarrantyInfo(EquipObj:EquipmentModel) -> String{
        var warrantyString = String()
        if EquipObj.CusWarrantyStatus == "" && EquipObj.VenWarrantyStatus == "" {
            warrantyString = "No_Warranty_Info_Available".localized()
        }else if EquipObj.CusWarrantyStatus == "" && EquipObj.VenWarrantyStatus == "InActive" {
            warrantyString = "VenWarranty_Has_Expired_and_No_Info_for_the_CusWarranty".localized()
        }else if EquipObj.CusWarrantyStatus == "" && EquipObj.VenWarrantyStatus == "Active" {
            warrantyString = "VenWarranty_is_Active_and_No_Warranty_Info_for_the_CusWarranty".localized()
        }else if EquipObj.CusWarrantyStatus == "InActive" && EquipObj.VenWarrantyStatus == "" {
            warrantyString = "VenWarranty_is_Not_Available_and_CusWarranty_is_Expired".localized()
        }else if EquipObj.CusWarrantyStatus == "Active" && EquipObj.VenWarrantyStatus == "" {
            warrantyString = "VenWarranty_is_Not_Available_and_CusWarranty_is_Active".localized()
        }else if EquipObj.CusWarrantyStatus == "Active" && EquipObj.VenWarrantyStatus == "InActive" {
            warrantyString = "VenWarranty_is_InActive_and_CusWarranty_is_Active".localized()
        }else if EquipObj.CusWarrantyStatus == "Active" && EquipObj.VenWarrantyStatus == "Active" {
            warrantyString = "Equipment_Warranty_is_Available".localized()
        }else if EquipObj.CusWarrantyStatus == "InActive" && EquipObj.VenWarrantyStatus == "Active" {
            warrantyString = "VenWarranty_is_Active_and_CusWarranty_is_InActive".localized()
        }else if EquipObj.CusWarrantyStatus == "InActive" && EquipObj.VenWarrantyStatus == "InActive" {
            warrantyString = "Warranty_has_Expired".localized()
        }else{
            warrantyString = ""
        }
        return warrantyString
    }
    func getObjectByAppendingZero(Max : Int,Num:String) -> String {
        let remainCount = Max - Num.count
        var FinalNumber = String()
        if remainCount == 0{
            return Num
        }
        if remainCount > 0 {
            FinalNumber = Num
            for _ in 0..<remainCount {
                FinalNumber = "0\(FinalNumber)"
            }
        }
        return FinalNumber
    }
    func setPersonRespronsible(detailArr:Array<UserDetailsModel>,from:Bool) {
        let user = detailArr[0]
        if from == true{
            let userArr = globalPersonRespArray.filter{$0.PersonnelNo == user.PersonnelNo}
            if userArr.count > 0{
                let user1 = userArr[0]
                userSystemID =  user1.SystemID
            }
            if userSystemID == ""{
                userSystemID =  strUser
            }
            userDisplayName = userSystemID
            userPersonnelNo = user.PersonnelNo
            WORKORDER_ASSIGNMENT_TYPE = user.WORKORDER_ASSIGNMENT_TYPE
            NOTIFICATION_ASSIGNMENT_TYPE = user.NOTIFICATION_ASSIGNMENT_TYPE
            userWorkcenter = user.WorkCenter
            OpWorkCentter = user.OpWorkCentter
            userPlant = user.Plant
            userPersonnelArea = user.PersonnelArea
            userCOArea = user.COArea
            userBusinessArea = user.BusinessArea
            isSupervisor = user.Supervisor
            if user.ADD_ASSIGNMENT_TYPE == "1"{
                isSupervisor = "X"
            }
            Role_ID = user.Role_ID
            let userdetails = NSMutableDictionary()
            userdetails.setValue(userPersonnelNo, forKey: "userPersonnelNo")
            userdetails.setValue(userPlant, forKey: "userPlant")
            userdetails.setValue(userWorkcenter, forKey: "userWorkcenter")
            userdetails.setValue(isSupervisor, forKey: "isSupervisor")
            userdetails.setValue(userSystemID, forKey: "SystemID")
            UserDefaults.standard.setValue(userdetails, forKey: "userDetails")
        }else{
            if((UserDefaults.standard.value(forKey:"userDetails")) != nil){
                let olduserdetails = UserDefaults.standard.object(forKey: "userDetails") as! NSDictionary
                let oldsystemID =  olduserdetails.value(forKey: "SystemID")as! String
                let oldplant = olduserdetails.value(forKey: "userPlant") as! String
                let oldsupervisor = olduserdetails.value(forKey: "isSupervisor")as! String
                let oldWorkcenter = olduserdetails.value(forKey: "userWorkcenter") as! String
                let userArr = globalPersonRespArray.filter{$0.PersonnelNo == user.PersonnelNo}
                if userArr.count > 0{
                    let user1 = userArr[0]
                    let newSystemId = user1.SystemID
                    let newPlant = user.Plant
                    let newWorkCenter = user.WorkCenter
                    let newSupervisor = user.Supervisor
                    if oldsystemID == newSystemId{

                    }else{
                        if oldplant != newPlant{
                            let filterarr = offlinestoreListArray.filter{$0.Flush == "2" && $0.Refresh == "2" && $0.WC_Clear == "3"}
                            var isRemove = Bool()
                            for store in filterarr{

                            }
                            if isRemove == true{
                                //create low and highvolume
                            }else{
                                // error msg
                            }
                        }
                        if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "4"{
                            if oldWorkcenter == newWorkCenter{
                            }else{
                            }
                        }else{
                        }
                        if oldsupervisor == "X" && newSupervisor == ""{
                        }else if newSupervisor == "X" && oldsupervisor == ""{
                            //open supervisor
                        }else if newSupervisor == oldsupervisor && (oldsupervisor == "X" || newSupervisor == "X"){
                        }
                    }
                }
            }else{

                let userArr = globalPersonRespArray.filter{$0.PersonnelNo == user.PersonnelNo}
                if userArr.count > 0{
                    let user1 = userArr[0]
                    userSystemID =  user1.SystemID
                }
                if userSystemID == ""{
                    userSystemID =  strUser
                }
                userDisplayName = user.Userdisplayname
                userPersonnelNo = user.PersonnelNo
                isSupervisor = user.Supervisor
                userWorkcenter = user.WorkCenter
                OpWorkCentter = user.OpWorkCentter
                userPlant = user.Plant
                userPersonnelArea = user.PersonnelArea
                userCOArea = user.COArea
                userBusinessArea = user.BusinessArea
                let userdetails = NSMutableDictionary()
                userdetails.setValue(userPersonnelNo, forKey: "userPersonnelNo")
                userdetails.setValue(userPlant, forKey: "userPlant")
                userdetails.setValue(userWorkcenter, forKey: "userWorkcenter")
                userdetails.setValue(isSupervisor, forKey: "isSupervisor")
                userdetails.setValue(userSystemID, forKey: "SystemID")
                UserDefaults.standard.setValue(userdetails, forKey: "userDetails")
            }
        }
    }
    func getActionFlow(event:String,orderType:String,from:String) -> Any {
        var level = String()
        if from == "WorkOrder" {
            if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "1"{
                level = WorkorderLevel
            }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                level = OperationLevel
            }else{
                level = WORKORDER_ASSIGNMENT_TYPE
            }
        }else {
            level = from
        }
        var workflowObj : Any?
        var filteredArray = workFlowListArray.filter{$0.Event == event && $0.ObjectCategory == level && ($0.ObjectType == orderType || $0.Active == "X")}
        if filteredArray.count == 0 {
            filteredArray = workFlowListArray.filter{$0.Event == event && $0.ObjectCategory == level && ($0.ObjectType == "X" || $0.Active == "X")}
        }
        if filteredArray.count > 0 {
            workflowObj = filteredArray[0]
        }else {
            workflowObj = nil
        }
        return workflowObj as Any
    }
    func getStatuses(statusVisible:String,StatuscCategory:String,ObjectType:String) -> Array<StatusCategoryModel> {
        var statusCategory = String()
        if StatuscCategory == "1" || StatuscCategory == "3"{
            statusCategory = WorkorderLevel
        }else if StatuscCategory == "2" || StatuscCategory == "4" || StatuscCategory == "5"{
            statusCategory = OperationLevel
        }else{
            statusCategory = StatuscCategory
        }
        var finalArr = Array<StatusCategoryModel>()
        if statusVisible == "X"{
            finalArr = statusCategoryArr.filter{$0.StatuscCategory == "\(statusCategory)" && $0.ObjectType == "\(ObjectType)" && $0.StatusVisible == "X" && $0.Active == "X"} //
            if finalArr.count == 0 {
                finalArr = statusCategoryArr.filter{$0.StatuscCategory == "\(statusCategory)" && $0.ObjectType == "X" && $0.StatusVisible == "X" && $0.Active == "X"} //
            }
        }else{
            finalArr = statusCategoryArr.filter{$0.StatuscCategory == "\(statusCategory)" && $0.ObjectType == "X" && $0.Active == "X"}
        }
        return finalArr.unique{$0.StatusCode}
    }
    func getActiveDetails(type:String){
        var strQuery = String()
        var strQuery1 = String()
        var defineQuery = String()
        var headerSet = String()
        var statusArray = Array<StatusCategoryModel>()
        if type == "Notification"{
            statusArray = self.getStatuses(statusVisible: "X", StatuscCategory: NotificationLevel, ObjectType: "X")
        }else{
            statusArray = self.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE , ObjectType: "X")
        }
        let activeStatusArr = statusArray.filter{$0.InProcess == true}
        if type == "Notification"{
            for status in activeStatusArr{
                if strQuery.count == 0{
                    strQuery = "startswith(UserStatus,'" + status.StatusCode + "') eq true";
                    strQuery1 = "startswith(MobileStatus,'" + status.StatusCode + "') eq true";
                }else{
                    strQuery = strQuery + " or " + "startswith(UserStatus,'" + status.StatusCode + "') eq true";
                    strQuery1 = strQuery1 + " or " + "startswith(MobileStatus,'" + status.StatusCode + "') eq true";
                }
                defineQuery = "\(notificationHeaderSet)?$filter= (" + strQuery + ")"
                headerSet = notificationHeaderSet
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                for status in activeStatusArr{
                    if strQuery.count == 0{
                        strQuery = "startswith(UserStatus,'" + status.StatusCode + "') eq true";
                        strQuery1 = "startswith(MobileStatus,'" + status.StatusCode + "') eq true";
                    }else{
                        strQuery = strQuery + " or " + "startswith(UserStatus,'" + status.StatusCode + "') eq true";
                        strQuery1 = strQuery1 + " or " + "startswith(MobileStatus,'" + status.StatusCode + "') eq true";
                    }
                    defineQuery = "\(woOperationSet)?$filter= (" + strQuery + " and (SubOperation eq '' or SubOperation eq null) " + " and startswith(SystemStatus,'" + "DLT" + "') ne true)"
                    headerSet = woOperationSet
                }
            }else{
                for status in activeStatusArr{
                    if strQuery.count == 0{
                        strQuery = "startswith(UserStatus,'" + status.StatusCode + "') eq true";
                        strQuery1 = "startswith(MobileObjStatus,'" + status.StatusCode + "') eq true";
                    }else{
                        strQuery = strQuery + " or " + "startswith(UserStatus,'" + status.StatusCode + "') eq true";
                        strQuery1 = strQuery1 + " or " + "startswith(MobileObjStatus,'" + status.StatusCode + "') eq true";
                    }
                    defineQuery = "WoHeaderSet?$filter= (" + strQuery + ")"
                    headerSet = "WoHeaderSet"
                }
            }
        }
        mJCLogger.log(defineQuery, Type: "Debug")
        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == headerSet}
        if storeArray.count > 0{
            let store = storeArray[0]
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName, completionHandler: { (response, error)  in
                if(error == nil) {
                    if type == "Notification"{
                        let totaldic =  ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: response), entityModelClassType: NotificationModel.self)
                        let  activeNoArray = totaldic["data"] as! [NotificationModel]
                        if activeNoArray.count > 0{
                            var Nodict : [String: Any] = [:]
                            let ActiveNo = activeNoArray[0]
                            Nodict["Notification"] = ActiveNo.Notification
                            Nodict["NotificationStatus"] = ActiveNo.UserStatus
                            UserDefaults.standard.setValue(Nodict, forKey: "active_details")
                            mJCLogger.log("Active No Details - \(Nodict)", Type: "Debug")
                        }else{
                            UserDefaults.standard.removeObject(forKey: "active_details")
                        }
                    }else{
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            let totaldic = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: response), entityModelClassType: WoOperationModel.self)
                            let  activeOprArray = totaldic["data"] as! [WoOperationModel]
                            if activeOprArray.count > 0{
                                var opdict : [String: Any] = [:]
                                let Activeopr = activeOprArray[0]
                                opdict["WorkorderNum"] = Activeopr.WorkOrderNum
                                opdict["WorkorderStatus"] = ""
                                opdict["OperationStatus"] = Activeopr.MobileStatus
                                opdict["OperationNum"] = Activeopr.OperationNum
                                UserDefaults.standard.setValue(opdict, forKey: "active_details")
                                mJCLogger.log("Active Opr Details - \(opdict)", Type: "Debug")
                            }else{
                                UserDefaults.standard.removeObject(forKey: "active_details")
                            }
                        }else{
                            let totaldic = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: response), entityModelClassType: WoHeaderModel.self)
                            let  activeWoArray = totaldic["data"] as! [WoHeaderModel]
                            if activeWoArray.count > 0{
                                var Wodict : [String: Any] = [:]
                                let ActiveWo = activeWoArray[0]
                                Wodict["WorkorderNum"] = ActiveWo.WorkOrderNum
                                Wodict["WorkorderStatus"] = ActiveWo.UserStatus
                                Wodict["OperationStatus"] = ""
                                Wodict["OperationNum"] = ""
                                UserDefaults.standard.setValue(Wodict, forKey: "active_details")
                                mJCLogger.log("Active Wo Details - \(Wodict)", Type: "Debug")
                            }else{
                                UserDefaults.standard.removeObject(forKey: "active_details")
                            }
                        }
                    }
                }else {
                    if error?.code == 10{
                        mJCLogger.log("Store open Failed", Type: "Debug")
                    }else if error?.code == 1227{
                        mJCLogger.log("Entity set not found", Type: "Debug")
                    }else{
                        mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            })
        }
    }
    func checkEntityisLocal(Entity : SODataEntityDefault) -> Bool {
        var islocal : Bool
        islocal = false
        if Entity.annotationNames != nil {
            if Entity.annotationNames.count > 0{
                let islocalvar = (Entity.annotationNames[0] as! SODataAnnotationName).name
                if islocalvar == "isLocal" && Entity.etag != nil{
                    islocal = true
                }else{
                    islocal = false
                }
            }
        }
        return islocal
    }
    func getRecordPointDefineRequestString(detailarray:NSMutableDictionary) -> String {
        var str = String()
        let arr = NSMutableArray()
        if let  workorderdata = detailarray.value(forKey: "Workorder") as? NSMutableArray{
            arr.addObjects(from: workorderdata as! [Any])
        }
        if let  operationdata = detailarray.value(forKey: "Operations") as? NSMutableArray{
            arr.addObjects(from: operationdata as! [Any])
        }
        for i in 0..<arr.count{
            let allpointclass = arr[i] as! EquipFuncLocMeasurementModel
            if allpointclass.Equipment != "" {
                if str.count == 0{
                    str = str + "Equipment eq" + " '\(allpointclass.Equipment)'"
                }else{
                    str = str + "or" + " " + "Equipment eq" + " '\(allpointclass.Equipment)'"
                }
            }
            if allpointclass.FunctionalLocation != "" {
                if str.count == 0{
                    str = str + "FunctionalLocation eq" + " '\(allpointclass.FunctionalLocation)'"
                }else{
                    str = str + "or" + " " + "FunctionalLocation eq" + " '\(allpointclass.FunctionalLocation)'"
                }
            }
        }
        return str
    }
    public static func getEquipmentQuery(equipArr: [String]) -> String{
        var str = ""
        for item in equipArr{
            if item != ""{
                if str.count == 0{
                    str = str + "Equipment eq" + " '\(item)'"
                }else{
                    str = str + "or" + " " + "Equipment eq" + " '\(item)'"
                }
            }
        }
        return str
    }
    public static func presentWorkOrderInfoView(woObject:WoHeaderModel){
        DispatchQueue.main.async{
            let popView = Bundle.main.loadNibNamed("workOrderInfoView", owner: self, options: nil)?.last as! workOrderInfoView
            popView.WorkorderNumberLbl.text = "Work_order_Number".localized() + " : \(woObject.WorkOrderNum)"
            popView.WoNameLbl .text = "\(woObject.Name)"
            if woObject.PhoneNumber != "" {
                popView.WoContactAddressLbl .text = "\(woObject.Address) \n \(woObject.PhoneNumber)"
            }else{
                popView.WoContactAddressLbl .text = "\(woObject.Address)"
            }
            popView.WoPrioorityLbl.text = "\(woObject.Priority)"
            popView.WoOrderTypeLbl.text = "\(woObject.OrderType)"

            if woObject.CreatedOn != nil{
                let  date = woObject.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                popView.WoCreatedOnLbl.text = "\(date)"
            }else{
                popView.WoCreatedOnLbl.text = ""
            }
            popView.WoDescriptionLbl.text = "\(woObject.ShortText)"
            let barcodeImg = UIImage(barcode: woObject.WorkOrderNum)
            popView.barCodeImg.image = barcodeImg
            popView.workOrderNumer = woObject.WorkOrderNum
            popView.frame = UIScreen.main.bounds
            popView.popUpViewUI()
            UIApplication.shared.windows.first!.addSubview(popView)
        }
    }

    //MARK: - Share logs
    func shareLogFiles(sender: UIButton,screen: UIViewController,fwLogs:Bool,from:String, userId:String){
        var subject = "Application_Title".localized() + " " + "Device_Logs_for".localized() + " \(userId)" + " : " + "\(Role_ID)"
        var body = "Please_define_error_reproduction_steps_here_and_any_others_screenshots_that_can_help_us_analyses_resolve_the_issue".localized()
        if from == "Login"{
            subject = "Login Failed for \(userId)"
            body = "Login Failed for user ID \(userId)"
        }
        let mailComposeViewController = configureMailComposer(fwLogs: fwLogs,subject: subject,body: body)
        if MFMailComposeViewController.canSendMail(){
            screen.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            let fileeURLArr = self.getLogAttachmentArray(fwLogs: fwLogs)
            let activityViewController = UIActivityViewController(activityItems: fileeURLArr, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = sender
            activityViewController.excludedActivityTypes = [.postToFacebook,.postToTwitter,.postToWeibo,.message,.print,.copyToPasteboard,.assignToContact,.saveToCameraRoll,.addToReadingList,.postToFlickr,
                                                            .postToVimeo,.postToTencentWeibo,.openInIBooks,.markupAsPDF]
            activityViewController.setValue(subject, forKey: "Subject")
            screen.present(activityViewController, animated: true, completion: nil)
        }
    }
    func configureMailComposer(fwLogs:Bool,subject: String, body: String) -> MFMailComposeViewController{

        mJCLogger.log("Starting", Type: "info")
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients([""])
        mailComposeVC.setSubject(subject)
        mailComposeVC.setMessageBody(body, isHTML: true)
        let fileeURLArr = self.getLogAttachmentArray(fwLogs: fwLogs)
        for item in fileeURLArr{
            let fileName = item.lastPathComponent
            if let fileData = NSData(contentsOf: item) {
                mailComposeVC.addAttachmentData(fileData as Data, mimeType: "text/txt", fileName: fileName)
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return mailComposeVC
    }
    func getLogAttachmentArray(fwLogs:Bool) -> [URL]{

        var path = String()
        var url = NSURL()
        var DemoPath = String()
        var fileURLArr = [URL]()
        if fwLogs == true {
            path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
            url = NSURL(fileURLWithPath: path)
            DemoPath = url.appendingPathComponent("FWLogs")!.path
        }else{
            path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            url = NSURL(fileURLWithPath: path)
            DemoPath = url.appendingPathComponent("Logs")!.path
        }
        do {
            let directoryContents = try myAsset.fileManager.contentsOfDirectory(at: URL(string:DemoPath)!, includingPropertiesForKeys: nil)
            let textFiles = directoryContents.filter{ $0.pathExtension == "txt" }
            if textFiles.count != 0 {
                if textFiles.count >= 2 {
                    let lastTwoFilePaths = textFiles.suffix(2)
                    for item in lastTwoFilePaths {
                        let filePath = item
                        fileURLArr.append(filePath)
                    }
                }else {
                    let filePath = textFiles[0]
                    fileURLArr.append(filePath)
                }
                return fileURLArr
            }else {
                mJCLogger.log("Reason :"+"File_Data_Not_Found".localized(), Type: "Error")
                print("File_Data_Not_Found".localized())
                return fileURLArr
            }
        }catch {
            mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
            return fileURLArr
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        mJCLogger.log("Starting", Type: "info")
        controller.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getLocalDateFormate(formate:String) -> String{
        switch formate {
            case "DD.MM.YYYY","TT.MM.JJJJ","JJ.MM.AAAA","GG.MM.AAAA","DD.MM.JJJJ","DD.MM.AAAA" : return "dd.MM.yyyy"
            case "MM/DD/YYYY","MM/TT/JJJJ","MM/JJ/AAAA","MM/GG/AAAA","MM/DD/JJJJ","MM/DD/AAAA" : return "MM/dd/yyyy"
            case "MM-DD-YYYY","MM-TT-JJJJ","MM-JJ-AAAA","MM-GG-AAAA","MM-DD-JJJJ","MM-DD-AAAA" : return "MM-dd-yyyy"
            case "YYYY.MM.DD","GYY.MM.DD","JJJJ.MM.TT","GJJ.MM.TT","AAAA.MM.JJ","GAA.MM.JJ","AAAA.MM.GG","JJJJ.MM.DD","AAAA.MM.DD" : return "yyyy.MM.dd"
            case "YYYY/MM/DD","GYY/MM/DD","JJJJ/MM/TT","GJJ/MM/TT","AAAA/MM/JJ","GAA/MM/JJ","AAA/MM/JJ","AAAA/MM/GG","JJJJ/MM/DD","AAAA/MM/DD" : return "yyyy/MM/dd"
            case "YYYY-MM-DD","GYY-MM-DD","JJJJ-MM-TT","GJJ-MM-TT","AAAA-MM-JJ","GAA-MM-JJ","AAAA-MM-GG","JJJJ-MM-DD","AAAA-MM-DD" : return "yyyy-MM-dd"

        default: return localDateFormate

        }
    }
    
    //MARK: - Password Delegates
    func provideUsernamePassword(forAuthChallenge authChallenge: URLAuthenticationChallenge!, completionBlock: username_password_provider_completion_t!) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if let dict =  UserDefaults.standard.value(forKey:"login_Details") as? NSDictionary {
                let username = dict.value(forKey: "userName") as! String
                let password = dict.value(forKey: "password") as! String
                mJCLogger.log("Login@@login_Details \(username) \(password)",Type: "")
                let credential = URLCredential(user: username, password: password, persistence: .forSession)
                completionBlock(credential, nil)
            }
        }
    }
    func provideSAML2Configuration(for url: URL!, completionBlock: saml2_config_provider_completion_t!) {
        var https = "https"
        if isHttps == false{
            https = "http"
        }
        let samlUrlString = "\(https)://\(serverIP)/SAMLAuthLauncher"
        completionBlock("com.sap.cloud.security.login", samlUrlString, "finishEndpointParam")
    }
    //MARK: - Auto config serverDetails
    public static func autoConfigSettings(){
        if let path = Bundle.main.path(forResource: "mJCConfig", ofType: "plist") {
            if let configDict = NSDictionary(contentsOfFile: path){
                if let appConfigDetails =  configDict["AutoConfig"]{
                    if appConfigDetails as? Bool == true{
                        autoConfig = true
                    }else{
                        autoConfig = false
                    }
                }
                if autoConfig == true{
                    if let serverPort = configDict["ServerPort"] as? String{
                        portNumber = Int(serverPort) ?? 443
                    }
                    if let environment = configDict["Environment"] as? String{
                        if environment == "1"{
                            if let ipaddress = configDict["ServerIPAddress1"] as? String{
                                serverIP = ipaddress
                            }
                            if  let applicationId = configDict["ApplicationId1"] as? String{
                                ApplicationID = applicationId
                            }
                        }else if environment == "2"{
                            if let ipaddress = configDict["ServerIPAddress2"] as? String{
                                serverIP = ipaddress
                            }
                            if  let applicationId = configDict["ApplicationId2"] as? String{
                                ApplicationID = applicationId
                            }
                        }else if environment == "3"{
                            if let ipaddress = configDict["ServerIPAddress3"] as? String{
                                serverIP = ipaddress
                            }
                            if  let applicationId = configDict["ApplicationId3"] as? String{
                                ApplicationID = applicationId
                            }
                        }
                    }
                }
                if let serverType = configDict["ServerType"]{
                    if serverType as? String == "Cloud"{
                        isHttps = true
                    }else{
                        isHttps = false
                    }
                }
                if let authenticationType =  configDict["AuthenticationType"] as? String{
                    authType = authenticationType
                }else{
                    authType = "Basic"
                }
                if let serverPopup =  configDict["ServerPop"] as? Bool{
                    serverPopupRequired = serverPopup
                }
            }
        }
    }
    //MARK: - Clear user data
    func resetUserData(){
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_POPUP_LOGOUT", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let unFlushData = mJCStoreHelper.checkForUnflushedData()
                logoutValue = true
                if logoutValue == true {
                    if unFlushData == true && demoModeEnabled != true{
                        let actionSheet : UIAlertController = UIAlertController(title: alerttitle, message: "There_are_pending_requests_to_be_sent_to_server_please_perform_transmit_before_you_logout".localized(), preferredStyle: .alert)
                        let saveActionButton: UIAlertAction = UIAlertAction(title: okay, style: .cancel) { action -> Void in
                        }
                        actionSheet.addAction(saveActionButton)
                        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
                    }else {
                        let actionSheet : UIAlertController = UIAlertController(title: alerttitle, message: "You_are_logging_out_from_the_app_do_u_want_continue".localized(), preferredStyle: .alert)
                        let saveActionButton: UIAlertAction = UIAlertAction(title: Yesalert, style: .cancel) { action -> Void in
                            self.logoutUserWithClearData()
                        }
                        actionSheet.addAction(saveActionButton)
                        let cancelActionButton: UIAlertAction = UIAlertAction(title: Noalert, style: .default) { action -> Void in
                        }
                        actionSheet.addAction(cancelActionButton)
                        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
                    }
                }else {
                    self.logoutUserWithClearData()
                }
            }
        }
    }
    func logoutUserWithClearData(){
        mJCLoader.startAnimating(status: "Reseting_User_Data_Please_wait".localized())
        if ENABLE_PUSH_SUBCRIPTION == false{
            self.pushSubscriptionDeleted()
        }else if mJCStoreHelper.checkStoreStatus(StoreName: ApplicationID){
            self.deletePushSubscription()
        }else{
            self.openOfflineStoreToClearUserData(storeName: ApplicationID, serviceName: ApplicationID)
        }
    }
    func openOfflineStoreToClearUserData(storeName:String,serviceName:String) {
        print("\(storeName) open Started --\(Date().localDate())")
        mJCLogger.log("\(storeName) open Started --\(Date().localDate())", Type: "")
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(self)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        var optionDict = Dictionary<String,Any>()
        optionDict["Host"] = serverIP
        optionDict["port"] = portNumber
        optionDict["https"] = isHttps
        optionDict["httpManager"] = httpConvMan
        if demoModeEnabled == true{
            optionDict["demoMode"] = true
        }else{
            optionDict["demoMode"] = false
        }
        var defineRequestArray = NSMutableArray()
        if UserDefaults.standard.value(forKey: "AppSettingDefineReq") != nil{
            let definerequest = UserDefaults.standard.value(forKey: "AppSettingDefineReq") as! NSArray
            defineRequestArray = NSMutableArray(array: definerequest)
        }else{
            defineRequestArray = NSMutableArray()
        }
        mJCLogger.log("\(storeName) DefineReq -- \n \(defineRequestArray)", Type: "")
        optionDict["defineReq"] = defineRequestArray
        ODSStoreHelper.uniqueInstance.OpenOfflineStore(storeName: storeName, serviceName: serviceName, options: optionDict)
    }
    func offlineStoreOpenFailed(storeName: String, error: Error!) {
        print("\(storeName) open faild -- \(String(describing: error))")
        mJCLogger.log("\(storeName) open faild --\(Date().localDate()) \n Error: \(String(describing: error))", Type: "")
        if storeName == ApplicationID{
            self.deletePushSubscription()
        }
    }
    func ODSStoreStatus(storeStatus: String) {
        print(storeStatus)
    }
    func offlineStoreOpenFinished(storeName: String) {
        print("\(storeName) open finished --\(Date().localDate())")
        if storeName == ApplicationID{
            self.deletePushSubscription()
        }
    }
    func deletePushSubscription(){
        mjcPushHelper.deletePushSubscription(queryRequest: "SubscriptionCollection", StoreName: ApplicationID, pushDeletedelegate: self) { (response, error) in
            if error != nil{
                self.pushSubscriptionDeleted()
            }
        }
    }
    func pushSubscriptionDeleted(){
        if UserDefaults.standard.value(forKey: "StoreNames") != nil{
            let storeNames = UserDefaults.standard.value(forKey: "StoreNames") as! [String]
            let storeRemove = mJCStoreHelper.removeOfflineStores(storeNameArr: storeNames)
            mJCLogger.log("storeRemove status \(storeRemove)", Type: "Debug")
            if storeRemove == true{
                if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                    let dict =  UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
                    let serverIP = dict.value(forKey :"serverIP") as! String
                    let portNumber = (dict.value(forKey :"portNumber") as? Int) ?? 443
                    let ApplicationID = dict.value(forKey :"ApplicationId") as! String
                    let connectionID = dict.value(forKey :"ApplicationConnectionId") as! String
                    let httpConvMan = HttpConversationManager.init()
                    let commonfig = CommonAuthenticationConfigurator.init()
                    if authType == "Basic"{
                        commonfig.addUsernamePasswordProvider(self)
                    }else if authType == "SAML"{
                        commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                    }
                    commonfig.configureManager(httpConvMan)
                    var serverurl = String()
                    if isHttps == true{
                        serverurl = "https://\(serverIP):\(portNumber)"
                    }else{
                        serverurl = "http://\(serverIP):\(portNumber)"
                    }
                    mJCLoginHelper.deleteUserRegistration(connectionID, with: httpConvMan, fromServer: serverurl, withAppId: ApplicationID){ data,response,error,success  in
                        mJCLogger.log("User Delete Response --> \(success) --> \(String(describing: error))", Type: "Debug")
                        self.clearUserData()
                    }
                }else{
                    self.clearUserData()
                }
            }else{
                self.clearUserData()
            }
        }else{
            self.clearUserData()
        }
    }
    func clearUserData(){

        mJCLoader.stopAnimating()
        UserDefaults.standard.removeObject(forKey: "login_Details")
        UserDefaults.standard.removeObject(forKey: "lastSyncDate")
        UserDefaults.standard.removeObject(forKey: "lastSyncDate_Master")
        UserDefaults.standard.removeObject(forKey: "pushsubscribe")
        UserDefaults.standard.removeObject(forKey: "active_details")
        UserDefaults.standard.removeObject(forKey: "StoreNames")
        UserDefaults.standard.removeObject(forKey: "touchIDEnable")

        for cookie in HTTPCookieStorage.shared.cookies ?? [] {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
        URLCache.shared.removeAllCachedResponses()
        let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                }
                catch let error as NSError {
                    mJCLogger.log("Cache file deletion failed : \(error)", Type: "Debug")
                }
            }
        } catch let error as NSError {
            mJCLogger.log("Cache file deletion failed : \(error.localizedDescription)", Type: "Debug")
        }
        self.logOut()
    }
    func updateSlidemenuDelegates(delegateVC: UIViewController,menu:String? = ""){

        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = menu ?? ""
        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
        myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
        myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = delegateVC as UIViewController as? SlideMenuControllerSelectDelegate
        myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
        self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
        self.appDeli.window?.makeKeyAndVisible()
        myAssetDataManager.uniqueInstance.navigationController?.pushViewController(delegateVC, animated: true)
    }
    // end
}
//...END...//
public extension UISearchBar {
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }
    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            return textField
        } else {
            return UITextField()
        }
    }
}
