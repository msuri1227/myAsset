//
//  WorkOrderDataManegeClass.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/12/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class WorkOrderDataManegeClass: NSObject,BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate,viewModelDelegate {
    class var uniqueInstance : WorkOrderDataManegeClass {
        struct Static {
            static let instance : WorkOrderDataManegeClass = WorkOrderDataManegeClass()
        }
        return Static.instance
    }
    var mobileStatusDec = String()
    var mobileStatusCode = String()
    weak var scanDelegate: barcodeDelegate?
    var scanObject = String()
    var woLongTextVM = woLongTextViewModel()
    var noLongTextVM = noLongTextViewModel()
    var statusObject : AnyObject?
    var statusTextArr = [String]()
    var woNotesOprStatus = String()
    
    //MARK:- Get WorkOrder Mobile Status..
    func getWorkOrderStatus(type : String) {
        if (type == "INCP") {
            mobileStatusDec = "INCOMPLETE"
            mobileStatusCode = "INCP"
        }else if (type == "REL") {
            mobileStatusDec = "Released"
            mobileStatusCode = "REL"
        }else if (type == "CNF") {
            mobileStatusDec = "CONFIRMED"
            mobileStatusCode = "CNF"
        }else if (type == "DLT") {
            mobileStatusDec = "Deleted"
            mobileStatusCode = "DLT"
        }else if (type == "NTST") {
            mobileStatusDec = "NotSet"
            mobileStatusCode = "NTST"
        }
    }
    func woMobileStatusDec(status : String) -> String {
        let arr = statusCategoryArr.filter{$0.StatuscCategory == "\(WorkorderLevel)" && $0.StatusCode == "\(status)"}
        if arr.count > 0{
            return arr[0].StatusDescKey
        }else{
            return ""
        }
    }
    func oprMobileStatusDec(status : String) -> String {
        let arr = statusCategoryArr.filter{$0.StatuscCategory == "\(OperationLevel)"}
        if arr.count > 0{
            return arr[0].StatusDescKey
        }else{
            return ""
        }
    }
    func noMobileStatusDec(status : String) -> String {
        let arr = statusCategoryArr.filter{$0.StatuscCategory == "\(NotificationLevel)"}
        if arr.count > 0{
            return arr[0].StatusDescKey
        }else{
            return ""
        }
    }
    func getMobileStatusCode(status : String) -> String {
        self.getWorkOrderStatus(type: status)
        return mobileStatusCode
    }
    func getConsidereAsActive(status:String,from : String) -> Bool {
        var statusCategory = String()
        if from == "WorkOrder"{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                statusCategory = WorkorderLevel
            }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                statusCategory = OperationLevel
            }
        }else if from == "Notification"{
            statusCategory = NotificationLevel
        }else{
            statusCategory = from
        }
        var statusArray = Array<StatusCategoryModel>()
        statusArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "", StatuscCategory: statusCategory , ObjectType: "X")
        var activeStatusArr = Array<StatusCategoryModel>()
        if  statusCategory == NotificationTaskLevel {
            if singleNotification.UserStatus == "INPR" {
                activeStatusArr = statusArray.filter{$0.InProcess == true && $0.StatusCode == "\(status)"}
            }
        }else {
            activeStatusArr = statusArray.filter{$0.InProcess == true && $0.StatusCode == "\(status)"}
        }
        if activeStatusArr.count ==  1{
            return true
        }else{
            if from == "Notification"{ // Condition added for clariant
                return true
            }else{
                return false
            }
        }
    }
    func setWorkOrderStatus(userStatus: String, mobileStatus: String , woClass: WoHeaderModel) -> String {
        let statusarr = DEFAULT_STATUS_TO_CHANGE.components(separatedBy: ",")
        if mobileStatus != ""{
            if statusarr.contains(mobileStatus){
                if onlineSearch == false{
                    self.updateObjectStatus(statusReason: "", objStatus: DEFAULT_STATUS_TO_SEND1, objClass: woClass, flushRequired: false)
                }
                return DEFAULT_STATUS_TO_SEND1
            }else{
                return mobileStatus
            }
        }else if userStatus != "" && mobileStatus == ""{
            if statusarr.contains(userStatus){
                if onlineSearch == false{
                    self.updateObjectStatus(statusReason: "", objStatus: DEFAULT_STATUS_TO_SEND1, objClass: woClass, flushRequired: false)
                }
                return DEFAULT_STATUS_TO_SEND1
            }else if (userStatus.count > 4) {
                let fullNameArr = userStatus.components(separatedBy: " ")
                let firstStatus : String = fullNameArr[0]
                return firstStatus
                
            }else{
                return mobileStatus
            }
        }else{
            return mobileStatus
        }
    }
    func setOperationStatus(userStatus: String, mobileStatus: String , oprClass: WoOperationModel) -> String {
        let statusarr = DEFAULT_STATUS_TO_CHANGE.components(separatedBy: ",")
        if mobileStatus != ""{
            if statusarr.contains(mobileStatus){
                if onlineSearch == false{
                    self.updateObjectStatus(statusReason: "", objStatus: DEFAULT_STATUS_TO_SEND1, objClass: oprClass, flushRequired: false)
                }
                return DEFAULT_STATUS_TO_SEND1
            }else{
                return mobileStatus
            }
        }else if userStatus != "" && mobileStatus == ""{
            if statusarr.contains(userStatus){
                if onlineSearch == false{
                    self.updateObjectStatus(statusReason: "", objStatus: DEFAULT_STATUS_TO_SEND1, objClass: oprClass, flushRequired: false)
                }
                return DEFAULT_STATUS_TO_SEND1
            }else if (userStatus.count > 4) {
                let fullNameArr = userStatus.components(separatedBy: " ")
                let firstStatus : String = fullNameArr[0]
                return firstStatus
            }else{
                return mobileStatus
            }
        }else{
            return mobileStatus
        }
    }
    
    func updateObjectStatus(statusReason: String, objStatus: String, objClass: AnyObject,flushRequired:Bool) {
        
        if let workorder = objClass as? WoHeaderModel {
            var strNoteText = String()
            var strReasonText = String()
            let status = WorkOrderDataManegeClass.uniqueInstance.woMobileStatusDec(status: objStatus)
            switch status {
            case "TRANSFER" :
                (workorder.entity.properties["TransferFlag"] as! SODataProperty).value = STATUS_SET_FLAG as NSObject
                (workorder.entity.properties["StatusFlag"] as? SODataProperty)?.value = "" as NSObject
                workorder.TransferFlag = STATUS_SET_FLAG
                workorder.StatusFlag = STATUS_SET_FLAG
                break
            default :
                (workorder.entity.properties["StatusFlag"] as? SODataProperty)?.value = STATUS_SET_FLAG as NSObject
                break
            }
            (workorder.entity.properties["MobileObjectType"] as! SODataProperty).value = "X" as NSObject
            (workorder.entity.properties["MobileObjStatus"] as! SODataProperty).value = objStatus as NSObject
            (workorder.entity.properties["UserStatus"] as! SODataProperty).value = objStatus as NSObject
            woLongTextVM.delegate = self
            woLongTextVM.woObj = workorder
            self.statusObject = workorder
            self.statusTextArr.removeAll()
            if AUTO_NOTES_ON_STATUS == true{
                let currentDate = Date().localDate().toString(format: .custom("yyyy-MM-dd HH:mm:ss"))
                strNoteText = "\(AUTO_NOTES_TEXT_LINE1) \(status) \(AUTO_NOTES_TEXT_LINE2) \(userSystemID.uppercased()) \(AUTO_NOTES_TEXT_LINE3) \(currentDate)"
                if statusReason != "" {
                    strReasonText = "\(AUTO_NOTES_TEXT_LINE4) \(statusReason)"
                    if ENABLE_POST_DEVICE_LOCATION_NOTES == true{
                        strNoteText = strNoteText + " (" + userLocation_LatLong + ")"
                    }
                    strReasonText = strReasonText + "$@@$" + strNoteText
                    self.statusTextArr.append(strReasonText)
                    self.statusTextArr.append(strNoteText)
                    self.woLongTextVM.getWoLongText(postText: true, textArr: self.statusTextArr)
                }else{
                    if ENABLE_POST_DEVICE_LOCATION_NOTES == true{
                        strNoteText = strNoteText + " (" + userLocation_LatLong + ")"
                    }
                    self.woLongTextVM.getWoLongText(postText: true, textArr: [strNoteText])
                }
            }else{
                if statusReason != "" {
                    strReasonText = "\(AUTO_NOTES_TEXT_LINE4) \(statusReason)"
                    self.woLongTextVM.getWoLongText(postText: true, textArr: [strReasonText])
                }else{
                    self.updateStatus(ObjectClass: workorder)
                }
            }
        }else if let operation = objClass as? WoOperationModel{
            var strNoteText = String()
            var strReasonText = String()
            let statusdes = WorkOrderDataManegeClass.uniqueInstance.oprMobileStatusDec(status: objStatus)
            switch statusdes {
            case "TRANSFER" :
                (operation.entity.properties["TransferFlag"] as! SODataProperty).value = STATUS_SET_FLAG as NSObject
                (operation.entity.properties["StatusFlag"] as? SODataProperty)?.value = "" as NSObject
                break
            default :
                (operation.entity.properties["StatusFlag"] as? SODataProperty)?.value = STATUS_SET_FLAG as NSObject
                break
            }
            (operation.entity.properties["UserStatus"] as! SODataProperty).value = objStatus as NSObject
            (operation.entity.properties["MobileStatus"] as! SODataProperty).value = objStatus as NSObject
            (operation.entity.properties["MobileObjectType"] as! SODataProperty).value = "X" as NSObject
            woLongTextVM.delegate = self
            woLongTextVM.woObj = singleWorkOrder
            woLongTextVM.oprObj = operation
            self.statusObject = operation
            self.statusTextArr.removeAll()
            if AUTO_NOTES_ON_STATUS == true{
                let currentDate = Date().localDate().toString(format: .custom("yyyy-MM-dd HH:mm:ss"))
                if applicationFeatureArrayKeys.contains("POST_WO_NOTES_IN_OPR_STATUS_CHANGE"){
                    var oprtext = String()
                    if operation.SubOperation != ""{
                        oprtext = "\(operation.OperationNum)" + " "  + "QR1-Of-9s7".localized() + " \(operation.SubOperation)"
                    }else{
                        oprtext = "\(operation.OperationNum)"
                    }
                    woNotesOprStatus = "\(AUTO_NOTES_TEXT_LINE1) \(objStatus) for \(oprtext) \(AUTO_NOTES_TEXT_LINE2) \(userSystemID.uppercased()) \(AUTO_NOTES_TEXT_LINE3) \(currentDate)"
                    strNoteText = "\(AUTO_NOTES_TEXT_LINE1) \(objStatus) \(AUTO_NOTES_TEXT_LINE2) \(userSystemID.uppercased()) \(AUTO_NOTES_TEXT_LINE3) \(currentDate)"
                }else{
                    strNoteText = "\(AUTO_NOTES_TEXT_LINE1) \(objStatus) \(AUTO_NOTES_TEXT_LINE2) \(userSystemID.uppercased()) \(AUTO_NOTES_TEXT_LINE3) \(currentDate)"
                }
                if statusReason != "" {
                    strReasonText = "\(AUTO_NOTES_TEXT_LINE4) \(statusReason)"
                    if ENABLE_POST_DEVICE_LOCATION_NOTES == true{
                        strNoteText = strNoteText + " (" + userLocation_LatLong + ")"
                    }
                    self.statusTextArr.append(strReasonText)
                    self.statusTextArr.append(strNoteText)
                    if applicationFeatureArrayKeys.contains("POST_WO_NOTES_IN_OPR_STATUS_CHANGE"){
                        self.woLongTextVM.getWoLongText(postText: true, textArr: [woNotesOprStatus])
                    }else{
                        if operation.SubOperation == ""{
                            self.woLongTextVM.getOprLongText(postText: true, textArr: self.statusTextArr)
                        }else{
                            self.woLongTextVM.getSubOprLongText(postText: true, textArr: self.statusTextArr)
                        }
                    }
                }else{
                    if ENABLE_POST_DEVICE_LOCATION_NOTES == true{
                        strNoteText = strNoteText + " (" + userLocation_LatLong + ")"
                    }
                    self.statusTextArr.append(strNoteText)
                    if applicationFeatureArrayKeys.contains("POST_WO_NOTES_IN_OPR_STATUS_CHANGE"){
                        self.woLongTextVM.getWoLongText(postText: true, textArr: [woNotesOprStatus])
                    }else{
                        if operation.SubOperation == ""{
                            self.woLongTextVM.getOprLongText(postText: true, textArr: self.statusTextArr)
                        }else{
                            self.woLongTextVM.getSubOprLongText(postText: true, textArr: self.statusTextArr)
                        }
                    }
                }
            }else{
                if statusReason != "" {
                    strReasonText = "\(AUTO_NOTES_TEXT_LINE4) \(statusReason)"
                    self.woLongTextVM.getOprLongText(postText: true, textArr: [strReasonText])
                }else{
                    self.updateStatus(ObjectClass: operation)
                }
            }
        }else if let notificationClass = objClass as? NotificationModel{
            (notificationClass.entity.properties["StatusFlag"] as? SODataProperty)?.value = STATUS_SET_FLAG as NSObject
            (notificationClass.entity.properties["UserStatus"] as! SODataProperty).value = objStatus as NSObject
            (notificationClass.entity.properties["MobileStatus"] as! SODataProperty).value = objStatus as NSObject
            if let mobile = (notificationClass.entity.properties["MobileObjectType"] as? SODataProperty){
                mobile.value = "X" as NSObject
            }
            var strNoteText = String()
            
            if AUTO_NOTES_ON_STATUS == true{
                self.noLongTextVM.delegate = self
                self.noLongTextVM.noObj = notificationClass
                if isSingleNotification{
                    self.noLongTextVM.woNotification = true
                }else{
                    self.noLongTextVM.woNotification = false
                }
                self.statusTextArr.removeAll()
                let status = WorkOrderDataManegeClass.uniqueInstance.noMobileStatusDec(status: objStatus)
                let currentDate = Date().toString(format: .custom("yyyy-MM-dd HH:mm:ss"))
                strNoteText = "\(AUTO_NOTES_TEXT_LINE1) \(status) \(AUTO_NOTES_TEXT_LINE2) \(userSystemID.uppercased()) \(AUTO_NOTES_TEXT_LINE3) \(currentDate)"
                if ENABLE_POST_DEVICE_LOCATION_NOTES == true{
                    strNoteText = strNoteText + " (" + userLocation_LatLong + ")"
                }
                self.noLongTextVM.getNoLongText(postText: true, textArr: [strNoteText])
            }else{
                self.updateStatus(ObjectClass: notificationClass)
            }
        }else if let notificationTaskClass = objClass as? NotificationTaskModel{
            (notificationTaskClass.entity.properties["StatusFlag"] as? SODataProperty)?.value = STATUS_SET_FLAG as NSObject
            var status = notificationTaskClass.UserStatus
            if notificationTaskClass.UserStatus.count > 4{
                let newStr = status.prefix(4)
                status = status.replacingOccurrences(of: newStr, with: objStatus)
            }else{
                status = objStatus
            }
            (notificationTaskClass.entity.properties["UserStatus"] as! SODataProperty).value = status as NSObject
            (notificationTaskClass.entity.properties["MobileStatus"] as! SODataProperty).value = objStatus as NSObject
            (notificationTaskClass.entity.properties["MobileObjectType"] as! SODataProperty).value = "X" as NSObject
            self.updateStatus(ObjectClass: notificationTaskClass)
        }
    }
    func updateStatus(ObjectClass: AnyObject){
        if let workorder = ObjectClass as? WoHeaderModel {
            WoHeaderModel.updateWorkorderEntity(entity:workorder.entity,flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Work Order Update Success".localized(), Type: "Debug")
                    if workorder.WorkOrderNum.contains(find: "L") && ENABLE_LOCAL_STATUS_CHANGE == true{
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"storeFlushAndRefreshDone"), object: "")
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "StatusUpdated"), object: "")
                    }else{
                        let newWoArray = allworkorderArray.filter{ $0.WorkOrderNum == workorder.WorkOrderNum}
                        if let transferprop = (workorder.entity.properties["TransferFlag"] as? SODataProperty){
                            workorder.TransferFlag = (transferprop.value ?? "" as NSObject) as! String
                        }
                        if let statusprop = (workorder.entity.properties["StatusFlag"] as? SODataProperty){
                            workorder.StatusFlag = (statusprop.value ?? "" as NSObject) as! String
                        }
                        if let statusProp = (workorder.entity.properties["MobileObjStatus"] as? SODataProperty){
                            workorder.MobileObjStatus = (statusProp.value ?? "" as NSObject) as! String
                            workorder.UserStatus = (statusProp.value ?? "" as NSObject) as! String
                        }
                        myAssetDataManager.uniqueInstance.getActiveDetails(type: "")
                        if newWoArray.count > 0 {
                            let index = allworkorderArray.firstIndex(of: newWoArray[0])
                            allworkorderArray[index!] =  workorder
                        }
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "StatusUpdated"), object: "")
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "dataSetSuccessfully"), object: "DataSetMasterView")
                        }
                    }
                }else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }else if let operation = ObjectClass as? WoOperationModel {
            WoOperationModel.updateOperationEntity(entity: operation.entity,flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    mJCLogger.log("Operation Update Success".localized(), Type: "Debug")
                    if operation.OperationNum.contains(find: "L") && ENABLE_LOCAL_STATUS_CHANGE == true{
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "StatusUpdated"), object: "")
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "dataSetSuccessfully"), object: "DataSetMasterView")
                        }
                    }else{
                        let newoprArray = allOperationsArray.filter{ $0.WorkOrderNum == operation.WorkOrderNum && $0.OperationNum == operation.OperationNum}
                        if newoprArray.count > 0{
                            let index = allOperationsArray.firstIndex(of: newoprArray[0])
                            if let transferprop = (operation.entity.properties["TransferFlag"] as? SODataProperty){
                                operation.TransferFlag = (transferprop.value ?? "" as NSObject) as! String
                            }
                            if let statusprop = (operation.entity.properties["StatusFlag"] as? SODataProperty){
                                operation.StatusFlag = (statusprop.value ?? "" as NSObject) as! String
                            }
                            allOperationsArray[index!] = operation
                            myAssetDataManager.uniqueInstance.getActiveDetails(type: "")
                            if let statusProp = (operation.entity.properties["MobileStatus"] as? SODataProperty){
                                operation.MobileStatus = (statusProp.value ?? "" as NSObject) as! String
                                operation.UserStatus = (statusProp.value ?? "" as NSObject) as! String
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "StatusUpdated"), object: "")
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "dataSetSuccessfully"), object: "DataSetMasterView")
                            }
                        }
                    }
                }else {
                    print("status updation failed")
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            })
        }else if let notificationClass = ObjectClass as? NotificationModel{
            NotificationModel.updateNotificationEntity(entity: notificationClass.entity,flushRequired: true, options: nil, completionHandler: { (response, error) in
                if(error == nil) {
                    print("notifiactio  status updateds")
                    DispatchQueue.main.async {
                        if let statusprop = (notificationClass.entity.properties["StatusFlag"] as? SODataProperty){
                            notificationClass.StatusFlag = (statusprop.value ?? "" as NSObject) as! String
                        }
                        if let statusProp = (notificationClass.entity.properties["MobileStatus"] as? SODataProperty){
                            notificationClass.MobileStatus = (statusProp.value ?? "" as NSObject) as! String
                            notificationClass.UserStatus = (statusProp.value ?? "" as NSObject) as! String
                        }
                        myAssetDataManager.uniqueInstance.getActiveDetails(type: "Notification")
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "StatusUpdated"), object: "")
                    }
                }
            })
        }else if let notificationTaskClass = ObjectClass as? NotificationTaskModel{
            NotificationTaskModel.updateNotificationTaskEntity(entity: notificationTaskClass.entity,flushRequired: true,options: nil){ (response, error) in
                if(error == nil) {
                    print("notifiactio  status updateds")
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "TaskStatusUpdated"), object: "")
                    }
                }
            }
        }
    }
    func presentBarCodeScaner(scanObjectType:String,delegate:barcodeDelegate,controller:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let scannerVC = BarcodeScannerViewController()
            scannerVC.codeDelegate = self
            scannerVC.errorDelegate = self
            scannerVC.dismissalDelegate = self
            scanObject = scanObjectType
            self.scanDelegate = delegate
            controller.present(scannerVC, animated: true)
        }else {
            DispatchQueue.main.async {
                mJCAlertHelper.showAlert(controller,title: sorrytitle, message: "There_is_no_camera_available_on_this_device".localized() , button: okay)
            }
        }
    }
    // MARK: - Barcode scanner
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print("Barcode Scan error \(error)")
    }
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        mJCLogger.log("Starting", Type: "info")
        if scanObject == "Floc"{
            let model = FlocEquipOverViewModel()
            model.delegate = self
            model.flocEquipObjText = code
            model.getFunctionalLocationDetails()
        }else if scanObject == "Equip"{
            let model = FlocEquipOverViewModel()
            model.delegate = self
            model.flocEquipObjText = code
            model.getEquipmentDetails()
        }else if scanObject == "Material"{
            let model = ComponentAvailabilityViewModel()
            model.delegate = self
            model.getMaterialDetails(material: "\(code)")
        }else{
            scanDelegate?.scanCompleted?(type: "success", barCode: "\(code)", object: [])
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: viewModelDelegate
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "floc"{
            var selectedFloc = FunctionalLocationModel()
            if let objDict = object[0] as? FunctionalLocationModel{
                selectedFloc = objDict
            }else{
                selectedFloc = FunctionalLocationModel()
            }
            scanDelegate?.scanCompleted?(type: "success", barCode: "Floc", object: selectedFloc)
        }else if type == "equip"{
            var selectedEquip = EquipmentModel()
            if let objDict = object[0] as? EquipmentModel{
                selectedEquip = objDict
            }else{
                selectedEquip = EquipmentModel()
            }
            scanDelegate?.scanCompleted?(type: "success", barCode: "Equip", object: selectedEquip)
        }else if type == "Material"{
            var material = ComponentAvailabilityModel()
            if let objDict = object[0] as? ComponentAvailabilityModel{
                material = objDict
            }else{
                material = ComponentAvailabilityModel()
            }
            scanDelegate?.scanCompleted?(type: "success", barCode: "Material", object: material)
        }else if type == "multipleWoLongTextPosted"{
            if let obj = self.statusObject as? WoOperationModel{
                if applicationFeatureArrayKeys.contains("POST_WO_NOTES_IN_OPR_STATUS_CHANGE"){
                    if obj.SubOperation == ""{
                        self.woLongTextVM.getOprLongText(postText: true, textArr: self.statusTextArr)
                    }else{
                        self.woLongTextVM.getSubOprLongText(postText: true, textArr: self.statusTextArr)
                    }
                }else{
                    self.updateStatus(ObjectClass: statusObject!)
                }
            }else{
                self.updateStatus(ObjectClass: statusObject!)
            }
        }else if type == "multipleOprLongTextPosted"{
            self.updateStatus(ObjectClass: statusObject!)
        }else if type == "multipleSubOprLongTextPosted"{
            self.updateStatus(ObjectClass: statusObject!)
        }
    }
}
