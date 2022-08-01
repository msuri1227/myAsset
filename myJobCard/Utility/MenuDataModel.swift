//
//  MenuDataModel.swift
//  myJobCard
//
//  Created by Navdeep Singla on 07/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import UIKit
import mJCLib
import ODSFoundation
import FormsEngine

public class menuDataModel: NSObject {
    class var uniqueInstance : menuDataModel {
        struct Static {
            static let instance : menuDataModel = menuDataModel()
        }
        return Static.instance
    }
    let menudropDown = DropDown()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    //MARK: - Menu Methods..
    public func presentMenu(menuArr: [String], imgArr: [UIImage]? = [], sender: Any,vc:UIViewController? = UIViewController()) {
        menudropDown.dataSource = menuArr
        if (imgArr?.count != 0) && (menuArr.count == imgArr?.count){
            customizeDropDown(imgArry: imgArr!)
        }
        menudropDown.anchorView = sender as? UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 220.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedMenuItemAction(title: item,vc: vc!)
        }
    }
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.isHidden = false
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func selectedMenuItemAction(title:String,vc:UIViewController){
        if title == "Sync_Application".localized() {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {
                    mJCLoader.startAnimating(status: "Uploading".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
                    })
                }
            }
        }else if title == "Log_Out".localized() {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "LOGOUT", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    myAssetDataManager.uniqueInstance.logOutApp()
                    mJCLogger.log("Logout Button Tapped".localized(), Type: "")
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if title == "Log_Out_Clear_Data".localized(){
            myAssetDataManager.uniqueInstance.resetUserData()
        }else if title == "Share_logs".localized() {
            if let viewc = vc as? DashboardStyle2{
                viewc.shareLogs(fwLogs: false)
            }
        }else if title == "Error_Logs".localized() {
            myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
        }else if title == "Master_Data_Refresh".localized(){
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {
                    mJCLoader.startAnimating(status: "Uploading".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                    })
                }
            }
        }else if title == "Change_Logs".localized(){
            DispatchQueue.main.async{
                let lotPopUp = Bundle.main.loadNibNamed("ChangeLogsView", owner: self, options: nil)?.last as! ChangeLogsView
                let windows = UIApplication.shared.windows
                let firstWindow = windows.first
                lotPopUp.loadNibView()
                lotPopUp.frame = UIScreen.main.bounds
                firstWindow?.addSubview(lotPopUp)
            }
        }else if title == "Notifications".localized() {
            menuDataModel.uniqueInstance.presentListSplitScreen(type: "Notification")
        }else if title == "Work_Orders".localized() {
            mJCLogger.log("listButtonAction".localized(), Type: "")
            menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
            mJCLogger.log("Ended", Type: "info")
        }else if title == "Time_Sheet".localized() {
            DispatchQueue.main.async {
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                currentMasterView = "TimeSheet"
                UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
                menuDataModel.uniqueInstance.presentTimeSheetScreen()
            }
        }else if title == "Asset_Map".localized() {
            ASSETMAP_TYPE = "ESRIMAP"
            assetmapVC.openmappage(id: "")
        }else if title == "Settings".localized() {
            let settingsVC = ScreenManager.getSettingsScreen()
            settingsVC.modalPresentationStyle = .fullScreen
            vc.present(settingsVC, animated: false) {}
//            menuDataModel.uniqueInstance.presentSettingsScreen(vc: self)
        }else if title == "Supervisor_View".localized() {
            self.presentSupervisorSplitScreen()
        }else if title == "Team".localized() {
            currentMasterView = "Team"
            UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
            let newSplit = ScreenManager.getTeamSplitScreen()
            self.appDeli.window?.rootViewController = newSplit
            self.appDeli.window?.makeKeyAndVisible()
        }else if title == "Map".localized() {
            ASSETMAP_TYPE = ""
            assetmapVC.openmappage(id: "")
        }else if title == "Home".localized() {
            self.presentDashboardScreen()
        }else if title == "Job_Location".localized() {
            self.presentMapSplitScreen()
        }
    }
    //MARK: - Create Screen Methods..
    public static func presentCreateJobScreen(vc:UIViewController, delegate:Bool? = false, isFromMap: Bool? = false, equipNo: String? = "", equipFromPoints: String? = "", funcLocFromPoints: String? = "", isScreen:String? = "WorkOrder"){
        let createNewJobVC = ScreenManager.getCreateJobScreen()
        createNewJobVC.isFromEdit = false
        createNewJobVC.isScreen = isScreen!
        if delegate == true{
            createNewJobVC.createUpdateDelegate = vc as? CreateUpdateDelegate
        }
        if isFromMap == true{
            createNewJobVC.isFromMap = isFromMap!
        }
        if equipNo != ""{
            createNewJobVC.equipmentStr = equipNo!
        }
        if equipFromPoints != ""{
            createNewJobVC.equipmentfrompoints = equipFromPoints!
        }else {
            createNewJobVC.equipmentfrompoints = ""
        }
        if funcLocFromPoints != ""{
            createNewJobVC.funclocfrompoints = funcLocFromPoints!
        }else {
            createNewJobVC.funclocfrompoints = ""
        }
        createNewJobVC.modalPresentationStyle = .fullScreen
        vc.present(createNewJobVC, animated: false)
    }
    public static func presentCreateWorkorderScreen(vc:UIViewController,isScreen:String? = "",notificationNum:String? = "",AllowedFollOnObjTypArray:[AllowedFollowOnObjectTypeModel]? = [], fromfollowOnWo: Bool? = false, isFromEdit: Bool? = false, notificationType: String? = "", delegateVC: UIViewController? = UIViewController(), isFromError: Bool? = false, errorWorkorder: WoHeaderModel? = WoHeaderModel()){
        let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
        if isFromEdit == true {
            createWorkOrderVC.isFromEdit = true
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                createWorkOrderVC.createUpdateDelegate = vc as? CreateUpdateDelegate
            }else
            {
                createWorkOrderVC.createUpdateDelegate = delegate as? CreateUpdateDelegate
            }
        }
        if isScreen != ""{
            createWorkOrderVC.isScreen = isScreen!
        }
        if notificationNum != ""{
            createWorkOrderVC.notificationNum = singleNotification.Notification
        }
        if notificationType != ""{
            createWorkOrderVC.notificationType = notificationType!
        }
        if AllowedFollOnObjTypArray?.count ?? 0 > 0 {
            createWorkOrderVC.AllowedFollOnObjTypArray = AllowedFollOnObjTypArray!
        }
        if fromfollowOnWo == true {
            createWorkOrderVC.isfromfollowOnWo = fromfollowOnWo!
        }
        if isFromError == true {
            createWorkOrderVC.isFromError = isFromError!
        }
        if let errorWO = errorWorkorder {
            createWorkOrderVC.errorWorkorder = errorWO
        }
        createWorkOrderVC.modalPresentationStyle = .fullScreen
        vc.present(createWorkOrderVC, animated: false) {}
    }
    public static func presentCreateNotificationScreen(vc:UIViewController, notificationCls: NotificationModel? = NotificationModel(), isFromEdit: Bool? = false, delegateVC: UIViewController? = UIViewController(), isFromError: Bool? = false, errorNotification: NotificationModel? = NotificationModel()){
        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
        createNotificationVC.isFromWorkOrder = true
        if isFromEdit == true {
            createNotificationVC.isFromEdit = true
        }
        if let notifiCls = notificationCls {
            createNotificationVC.notificationClass = notifiCls
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                createNotificationVC.createUpdateDelegate = vc as? CreateUpdateDelegate
            }else
            {
                createNotificationVC.createUpdateDelegate = delegate as? CreateUpdateDelegate
            }
        }
        if isFromError == true {
            createNotificationVC.isFromError = isFromError!
        }
        if let errorNO = errorNotification {
            createNotificationVC.errorNotifiation = errorNO
        }
        createNotificationVC.modalPresentationStyle = .fullScreen
        vc.present(createNotificationVC, animated: false) {}
    }
    public static func presentCreateOperationScreen(vc:UIViewController, isScreen:String? = "Operation", delegate:Bool? = false, operationCls: WoOperationModel? = WoOperationModel(), isFromEdit: Bool? = false, isFromError: Bool? = false, errorOperation: WoOperationModel? = WoOperationModel(), operationNmbr: String? = "", newWorkOrderNotes: String? = "", propertyWOArray: NSMutableArray? = [], WOrderType: String? = ""){
        let addOperationVC = ScreenManager.getCreateOperationScreen()
        if delegate == true{
            addOperationVC.delegate = vc as? operationCreationDelegate
        }
        if isScreen != ""{
            addOperationVC.isFromScreen = isScreen!
        }
        if isFromEdit == true {
            addOperationVC.isFromEdit = true
        }
        if isFromError == true {
            addOperationVC.isFromError = isFromError!
        }
        if let errorOP = errorOperation {
            addOperationVC.errorOperation = errorOP
        }
        if let singleOperationCls = operationCls {
            addOperationVC.singleOperationClass = singleOperationCls
        }
        if operationNmbr != "" {
            addOperationVC.operationNumber = operationNmbr!
        }
        if newWorkOrderNotes != "" {
            addOperationVC.NewWorkorderNotes = newWorkOrderNotes!
        }
        if let woArr = propertyWOArray {
            if woArr.count > 0 {
                addOperationVC.propertyWorkOrderArray = woArr
            }
        }
        if WOrderType != "" {
            addOperationVC.WOOrdertype = WOrderType!
        }
        addOperationVC.modalPresentationStyle = .fullScreen
        vc.present(addOperationVC, animated: false) {}
    }
    public static func presentCreateComponentScreen(vc: UIViewController, isFromEdit: Bool? = false, isFromError: Bool? = false, errorComponent: WoComponentModel? = WoComponentModel(), delegateVC: UIViewController? = UIViewController(), selectedCmpnt: WoComponentModel? = WoComponentModel()) {
        let createComponentVC = ScreenManager.getCreateComponentScreen()
        let sortnumber = String.random(length: 4, type: "Number")
        createComponentVC.sortNumber = sortnumber
        createComponentVC.isFromScreen = "Component"
        if isFromEdit == true {
            createComponentVC.isFromEdit = true
        }
        if isFromError == true {
            createComponentVC.isFromError = isFromError!
        }
        if let errComponent = errorComponent {
            createComponentVC.errorComponent = errComponent
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                createComponentVC.createUpdateDelegate = vc as? CreateUpdateDelegate
            }else
            {
                createComponentVC.createUpdateDelegate = delegate as? CreateUpdateDelegate
            }
        }
        if let singleCoomponentCls = selectedCmpnt {
            createComponentVC.selectedComp = singleCoomponentCls
        }
        createComponentVC.modalPresentationStyle = .fullScreen
        vc.present(createComponentVC, animated: false) {}
    }
    public static func presentCreateItemScreen(vc: UIViewController, isFromEdit: Bool? = false, isFromError: Bool? = false, errorItem: NotificationItemsModel? = NotificationItemsModel(), delegateVC: UIViewController? = UIViewController(), selectedItem: NotificationItemsModel? = NotificationItemsModel(), notificationFrom: String? = "", sortCount: String? = "") {
        let createItemVC = ScreenManager.getCreateItemScreen()
        if isFromEdit == true {
            createItemVC.isFromEdit = true
        }
        if isFromError == true {
            createItemVC.isFromError = isFromError!
        }
        if let errItem = errorItem {
            createItemVC.errorItemClass = errItem
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                createItemVC.delegate = vc as? CreateUpdateDelegate
            }else
            {
                createItemVC.delegate = delegate as? CreateUpdateDelegate
            }
        }
        if sortCount != "" {
            createItemVC.sortNumber = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: sortCount!)
        }
        if let singleItemCls = selectedItem {
            createItemVC.itemClass = singleItemCls
        }
        if notificationFrom != "" {
            createItemVC.notificationFrom = notificationFrom!
        }
        createItemVC.modalPresentationStyle = .fullScreen
        vc.present(createItemVC, animated: false) {}
    }
    public static func presentCreateActivityScreen(vc: UIViewController, isFromEdit: Bool? = false, activityCls: NotificationActivityModel? = NotificationActivityModel(), delegateVC: UIViewController? = UIViewController(), sortCount: String? = "", notificationFrom: String? = "", itemNumber: Bool? = false, itemActivity: Bool? = false) {
        let createActivityVC = ScreenManager.getCreateActivityScreen()
        if isFromEdit == true {
            createActivityVC.isFromEdit = true
        }
        if let actCls = activityCls {
            createActivityVC.activityClass = actCls
            if actCls.Item != "0000" || actCls.Item != "" {
                isItemActivity = true
            }else{
                isItemActivity = false
            }
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                createActivityVC.delegate = vc as? CreateUpdateDelegate
            }else
            {
                createActivityVC.delegate = delegate as? CreateUpdateDelegate
            }
        }
        if sortCount != "" {
            createActivityVC.sortNumber = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: sortCount!)
        }
        if isSingleNotification == true {
            createActivityVC.notificationFrom = "FromWorkorder"
        }else{
            createActivityVC.notificationFrom = ""
        }
        if notificationFrom != "" {
            createActivityVC.notificationFrom = notificationFrom!
        }
        if itemNumber == true {
            createActivityVC.itemNum = selectedItem
        }
        if itemActivity == true {
            isItemActivity = true
        }
        createActivityVC.modalPresentationStyle = .fullScreen
        vc.present(createActivityVC, animated: false) {}
    }
    public static func presentIssueComponentScreen(vc: UIViewController, cmpntCls: WoComponentModel? = WoComponentModel()) {
        let issueComponentVC = ScreenManager.getIssueComponentScreen()
        if let component = cmpntCls {
            issueComponentVC.componentClass = component
        }
        issueComponentVC.modalPresentationStyle = .fullScreen
        vc.present(issueComponentVC, animated: false) {}
    }
    public static func presentCreateItemCauseScreen(vc: UIViewController, isFromEdit: Bool? = false, causeCls: NotificationItemCauseModel? = NotificationItemCauseModel(), sortCount: String? = "", notificationFrom: String? = "", itemCause: Bool? = false) {
        let createItemCause = ScreenManager.getCreateItemCauseScreen()
        if isFromEdit == true {
            createItemCause.isFromEdit = true
        }
        if let Cls = causeCls {
            createItemCause.causeClass = Cls
        }
        if sortCount != "" {
            createItemCause.sortNumber = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: sortCount!)
        }
        if isSingleNotification == true {
            createItemCause.notificationFrom = "FromWorkorder"
        }else{
            createItemCause.notificationFrom = ""
        }
        if notificationFrom != "" {
            createItemCause.notificationFrom = notificationFrom!
        }
        if itemCause == true {
            isItemCause = true
        }
        createItemCause.modalPresentationStyle = .fullScreen
        vc.present(createItemCause, animated: false) {}
    }
    public static func presentCreateTaskScreen(vc: UIViewController, isFromEdit: Bool? = false, delegateVC: UIViewController? = UIViewController(), taskCls: NotificationTaskModel? = NotificationTaskModel(), sortCount: String? = "", fromWo: String? = "", itemTask: Bool? = false, itemNum: String? = "") {
        let createTaskVC = ScreenManager.getCreateTaskScreen()
        if isFromEdit == true {
            createTaskVC.isFromEdit = true
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                createTaskVC.delegate = vc as? CreateUpdateDelegate
            }else
            {
                createTaskVC.delegate = delegate as? CreateUpdateDelegate
            }
        }
        if let Cls = taskCls {
            createTaskVC.taskClass = Cls
            if Cls.Item != "0000" || Cls.Item != "" {
                isItemTask = true
            }else{
                isItemTask = false
            }
        }
        if sortCount != "" {
            createTaskVC.sortNumber = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: sortCount!)
        }
        if isSingleNotification == true{
            createTaskVC.isfromWo = "FromWorkorder"
        }else{
            createTaskVC.isfromWo = ""
        }
        if fromWo != "" {
            createTaskVC.isfromWo = fromWo!
        }
        if itemTask == true {
            isItemTask = true
        }
        if itemNum != "" {
            createTaskVC.itemNum = itemNum!
        }
        createTaskVC.modalPresentationStyle = .fullScreen
        vc.present(createTaskVC, animated: false) {}
    }
    public static func presentCreateTimeSheetScreen(vc: UIViewController, isFromScrn:String? = "", delegateVC: UIViewController? = UIViewController(), timeSheetCls: TimeSheetModel? = TimeSheetModel(), cellIndex: Int? = Int(), selectedWONumber: String? = "", statusCategoryCls: StatusCategoryModel? = StatusCategoryModel()) {
        let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
        if isFromScrn != "" {
            addTimeEntryVC.screenType = isFromScrn!
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                addTimeEntryVC.timeSheetDelegate = vc as? timeSheetDelegate
            }else
            {
                addTimeEntryVC.timeSheetDelegate = delegate as? timeSheetDelegate
            }
        }
        if let Cls = timeSheetCls {
            addTimeEntryVC.timeSheetClass = Cls
        }
        if let index = cellIndex {
            addTimeEntryVC.cellIndex = index
        }
        if selectedWONumber != "" {
            addTimeEntryVC.selectedworkOrder = selectedWONumber!
        }
        if let statusCategory = statusCategoryCls {
            addTimeEntryVC.statusCategoryCls = statusCategory
        }
        addTimeEntryVC.modalPresentationStyle = .fullScreen
        vc.present(addTimeEntryVC, animated: false) {}
    }
    //MARK: - List Screens
    public func presentDashboardScreen() {
        mJCLogger.log("Starting", Type: "info")
        singleWorkOrder = WoHeaderModel()
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    public func presentListSplitScreen(type: String? = "", isFromMapScrn: Bool? = false) {
        selectedworkOrderNumber = ""
        selectedOperationNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = type!
        if isFromMapScrn == true {
            isfromMapScreen = true
        }
        UserDefaults.standard.removeObject(forKey: "ListFilter")
        UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
        let splitVC = ScreenManager.getListSplitScreen()
        let detailVc = ScreenManager.getMasterListDetailScreen()
        let master = (splitVC.viewControllers.first as! UINavigationController).viewControllers.first as? MasterListVC
        master?.delegate = detailVc
        splitVC.showDetailViewController(detailVc, sender: splitVC)
        self.appDeli.window?.rootViewController = splitVC
        self.appDeli.window?.makeKeyAndVisible()
    }
    public func presentManageCheckSheetScreen(vc: UIViewController) {
        let manageAssignment = ScreenManager.getManageCheckSheetScreen()
        manageAssignment.modalPresentationStyle = .fullScreen
        vc.present(manageAssignment, animated: false)
    }
    public func presentCheckSheetAvailabilityScreen(vc: UIViewController, isFrm: String? = "", delegateVC: UIViewController? = UIViewController(), selectedCls: FormAssignDataModel? = FormAssignDataModel(), previousCheckSheetListArr: [FormAssignDataModel]? = [], previousSelectedCheckSheetListArr: [FormMasterMetaDataModel]? = [], checkSheetListMasterArr: [FormMasterMetaDataModel]? = []) {
        mJCLogger.log("Starting", Type: "info")
        let checkSheetAvailabilityVc = ScreenManager.getCheckSheetAvailabilityScreen()
        if isFrm != "" {
            checkSheetAvailabilityVc.isFrom = isFrm!
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                checkSheetAvailabilityVc.delegate = vc as? checkSheetSelectionDelegate
            }else
            {
                checkSheetAvailabilityVc.delegate = delegate as? checkSheetSelectionDelegate
            }
        }
        if let cls = selectedCls {
            checkSheetAvailabilityVc.selectedCheckSheet = cls
        }
        if let arr = previousCheckSheetListArr {
            if arr.count > 0 {
                checkSheetAvailabilityVc.previousCheckListArr = arr
            }
        }
        if let arr = previousSelectedCheckSheetListArr {
            if arr.count > 0 {
                checkSheetAvailabilityVc.previousSelectedCheckSheetList = arr
            }
        }
        if let arr = checkSheetListMasterArr {
            if arr.count > 0 {
                checkSheetAvailabilityVc.checkListMasterArr = arr
            }
        }
        checkSheetAvailabilityVc.modalPresentationStyle = .overFullScreen
        vc.present(checkSheetAvailabilityVc, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    public func presentCheckSheetViewerScreen(vc: UIViewController, isFromScrn: String? = "", isFromEdit: Bool? = false, delegateVC: UIViewController? = UIViewController(), reviewerFormResponseCls: FormReviewerResponseModel? = FormReviewerResponseModel(), formResponseCaptureCls: FormResponseCaptureModel? = FormResponseCaptureModel(), formCls: FormAssignDataModel? = FormAssignDataModel(), statusCategoryCls: StatusCategoryModel? = StatusCategoryModel()) {
        let newformsVC = ScreenManager.getCheckSheetViewerScreen()
        if isFromEdit == true {
            newformsVC.isFromEditScreen = true
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                newformsVC.createUpdateDelegate = vc as? CreateUpdateDelegate
            }else
            {
                newformsVC.createUpdateDelegate = delegate as? CreateUpdateDelegate
            }
        }
        if isFromScrn != ""{
            newformsVC.fromScreen = isFromScrn!
        }
        if let cls = reviewerFormResponseCls {
            newformsVC.reviewerFormResponseClass = cls
        }
        if let cls = formResponseCaptureCls {
            newformsVC.formResponseCaptureClass = cls
        }
        if let cls = formCls {
            newformsVC.formClass = cls
        }
        if let cls = statusCategoryCls {
            newformsVC.statusCategoryCls = cls
        }
        newformsVC.modalPresentationStyle = .fullScreen
        vc.present(newformsVC, animated: false) {}
    }
    public func presentMapSplitScreen() {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "MapSplitViewController"
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        ASSETMAP_TYPE = ""
        let mapSplitVC = ScreenManager.getMapSplitScreen()
        self.appDeli.window?.rootViewController = mapSplitVC
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    public func presentFlocEquipDetialsScreen(vc: UIViewController, flocOrEquipObjType: String? = "", flocOrEquipObjText: String? = "", classificationType: String? = "") {
        let equipmentVC = ScreenManager.getFlocEquipDetialsScreen()
        if flocOrEquipObjType != ""{
            equipmentVC.flocEquipObjType = flocOrEquipObjType!
        }
        if flocOrEquipObjText != ""{
            equipmentVC.flocEquipObjText = flocOrEquipObjText!
        }
        if classificationType != ""{
            equipmentVC.classificationType = classificationType!
        }
        equipmentVC.modalPresentationStyle = .fullScreen
        vc.present(equipmentVC, animated: false) {}

    }
    public func presentWorkOrderTransferScreen(vc: UIViewController, screenFrom: String? = "", rejectStr: String? = "", presentPrsn: String? = "", priorityVal: String? = "", transferOperationCls: WoOperationModel? = WoOperationModel(), statusCategoryCls: StatusCategoryModel? = StatusCategoryModel()) {
        mJCLogger.log("Starting", Type: "info")
        let transferVC = ScreenManager.getWorkOrderTransferScreen()
        if rejectStr != ""{
            transferVC.rejectString = rejectStr! as NSString
        }
        if presentPrsn != ""{
            transferVC.presentPerson = presentPrsn!
        }
        if priorityVal != ""{
            transferVC.priorityValue = priorityVal!
        }
        if let cls = transferOperationCls {
            transferVC.transferOperationClass = cls
        }
        if screenFrom != ""{
            transferVC.screenfrom = screenFrom!
        }
        if let cls = statusCategoryCls {
            transferVC.statusCategoryCls = cls
        }
        transferVC.modalPresentationStyle = .fullScreen
        vc.present(transferVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    public func presentTimeSheetScreen() {
        let timeSheetVC = ScreenManager.getTimeSheetScreen()
        self.appDeli.window?.rootViewController = timeSheetVC
        self.appDeli.window?.makeKeyAndVisible()
    }
    public func presentAttachmentViewerScreen(vc: UIViewController, attachmentImage: UIImage? = UIImage(), attachmentType: String? = "", pdfUrl: NSURL? = NSURL()) {
        let attachmentViewer = ScreenManager.getAttachmentViewerScreen()
        attachmentViewer.attachmenttype = "image"
        if let img = attachmentImage {
            attachmentViewer.attachmentImage = img
        }
        if attachmentType != nil {
            attachmentViewer.attachmenttype = attachmentType!
        }
        if let url = pdfUrl {
            attachmentViewer.pdfURL = url
        }
        attachmentViewer.modalPresentationStyle = .fullScreen
        vc.present(attachmentViewer, animated: false){}
    }
    public func presentSingleNotificationScreen(vc: UIViewController, woClass: WoHeaderModel? = WoHeaderModel(), selectedNONumber: String? = "") {
        let singlenotificationVC = ScreenManager.getSingleNotificationScreen()
        currentMasterView = "Notification"
        UserDefaults.standard.removeObject(forKey: "ListFilter")
        if let woCls = woClass {
            selectedNotificationNumber = woCls.NotificationNum
            isSingleNotification = true
        }
        if selectedNONumber != "" {
            selectedNotificationNumber = selectedNONumber!
            isSingleNotification = true
        }
        singlenotificationVC.modalPresentationStyle = .fullScreen
        vc.present(singlenotificationVC, animated: false) {}
    }
    public func presentNotificationItemCausesScreen(vc: UIViewController, isFromScrn: String? = "", selectedItemCauses: String? = "") {
        let notificationItemCausesVC = ScreenManager.getNotificationItemCausesScreen()
        if selectedItemCauses != "" {
            notificationItemCausesVC.notificationItemCausesViewModel.selectedItemCauses = selectedItemCauses!
        }
        if isFromScrn != "" {
            notificationItemCausesVC.isFromScreen = isFromScrn!
        }
        if isSingleNotification == true {
            notificationItemCausesVC.notificationFrom = "FromWorkorder"
        }
        notificationItemCausesVC.modalPresentationStyle = .fullScreen
        vc.present(notificationItemCausesVC, animated: false, completion: nil)
    }
    public func presentSupervisorSplitScreen(isFromMapScrn: Bool? = false) {
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        tabSelectedIndex = 0
        currentMasterView = "Supervisor"
        if isFromMapScrn == true {
            isfromMapScreen = true
        }
        UserDefaults.standard.removeObject(forKey: "ListFilter")
        UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
        let splitVC = ScreenManager.getSupervisorSplitScreen()
        self.appDeli.window?.rootViewController = splitVC
        self.appDeli.window?.makeKeyAndVisible()
    }
    public func presentSettingsScreen(vc: UIViewController) {
        let settingsVC = ScreenManager.getSettingsScreen()
        vc.navigationController?.pushViewController(settingsVC, animated: true)
    }
    public func presentPersonResponsibleListScreen(vc: UIViewController, isFrm: String? = "", delegateVC: UIViewController? = UIViewController()) {
        mJCLogger.log("Starting", Type: "info")
        let personRespVC = ScreenManager.getPersonResponsibleListScreen()
        if let delegate = delegateVC {
            if delegate == vc.self {
                personRespVC.delegate = vc as? personResponsibleDelegate
            }else
            {
                personRespVC.delegate = delegate as? personResponsibleDelegate
            }
        }
        if isFrm != "" {
            personRespVC.isFrom = isFrm!
        }
        personRespVC.modalPresentationStyle = .fullScreen
        vc.present(personRespVC, animated: false)
        mJCLogger.log("Ended", Type: "info")
    }
    public func presentFlocEquipHierarchyScreen(vc: UIViewController, select: String? = "", delegateVC: UIViewController? = UIViewController(), workCenter: String? = "", planningPlant: String? = "", selectedFuncLoc: String? = "", maintenancePlant: String? = "") {
        mJCLogger.log("Starting", Type: "info")
        let functionaLocationListVC = ScreenManager.getFlocEquipHierarchyScreen()
        if let delegate = delegateVC {
            if delegate == vc.self {
                functionaLocationListVC.delegate = vc as? FuncLocEquipSelectDelegate
            }else
            {
                functionaLocationListVC.delegate = delegate as? FuncLocEquipSelectDelegate
            }
        }
        if select != "" {
            functionaLocationListVC.isSelect = select!
        }
        if workCenter != "" {
            let arr = workCenter!.components(separatedBy: " - ")
            if arr.count > 0{
                functionaLocationListVC.workCenter = arr[0]
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            functionaLocationListVC.workCenter = workCenter!
        }
        if planningPlant != "" {
            let arr1 = planningPlant!.components(separatedBy: " - ")
            if arr1.count > 0{
                functionaLocationListVC.planningPlant = arr1[0]
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            functionaLocationListVC.planningPlant = planningPlant!
        }
        if maintenancePlant != "" {
            let arr = maintenancePlant!.components(separatedBy: " - ")
            if arr.count > 0{
                let plantFilteredArray = (vc as! CreateNotificationVC).maintPlantArray.filter({$0.Plant == arr[0] && $0.Name1 == arr[1]})
                if plantFilteredArray.count > 0{
                    mJCLogger.log("Response:\(plantFilteredArray[0])", Type: "Debug")
                    let plantClass = plantFilteredArray[0]
                    functionaLocationListVC.planningPlant = plantClass.PlanningPlant
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }

        }
        if selectedFuncLoc != "" {
            functionaLocationListVC.selectedFunLoc = selectedFuncLoc!
        }
        functionaLocationListVC.modalPresentationStyle = .fullScreen
        vc.present(functionaLocationListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    public func presentWorkOrderSuspendScreen(vc: UIViewController, isFromScrn: String? = "", delegateVC: UIViewController? = UIViewController(), referenceNum: String? = "", statusCategoryClass: StatusCategoryModel? = StatusCategoryModel()) {
        let workOrderSuspendVC = ScreenManager.getWorkOrderSuspendScreen()
        if isFromScrn != "" {
            workOrderSuspendVC.isFromScreen = isFromScrn!
        }
        if referenceNum != "" {
            workOrderSuspendVC.refNum = referenceNum!
        }
        if let cls = statusCategoryClass {
            workOrderSuspendVC.statusCategoryCls = cls
        }
        workOrderSuspendVC.modalPresentationStyle = .fullScreen
        vc.present(workOrderSuspendVC, animated: false)
    }
    public func presentListFilterScreen(vc: UIViewController, isFrm: String? = "", delegateVC: UIViewController? = UIViewController(), priorityArr: [String]? = [], statusArr: [String]? = []) {
        let filterVC = ScreenManager.getListFilterScreen()
        if isFrm != "" {
            filterVC.isfrom = isFrm!
        }
        if let delegate = delegateVC {
            if delegate == vc.self {
                filterVC.delegate = vc as? filterDelegate
            }else
            {
                filterVC.delegate = delegate as? filterDelegate
            }
        }
        if let arr = priorityArr {
            filterVC.filterViewModel.priorityArray = arr
        }
        if let arr = statusArr {
            filterVC.filterViewModel.statusArray = arr
        }
        filterVC.modalPresentationStyle = .fullScreen
        vc.present(filterVC, animated: false) {}
    }
}
