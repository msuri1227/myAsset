//
//  ScreenManager.swift
//  myJobCard
//
//  Created by Suri on 13/09/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import AVFoundation

class ScreenManager: NSObject {
    
    class var uniqueInstance : ScreenManager {
        struct Static {
            static let instance : ScreenManager = ScreenManager()
        }
        return Static.instance
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override init() {
        super.init()
    }
    // MARK: Screens
    static func getLoginScreen() -> LoginVC{
        if DeviceType == iPad{
            return LoginVC.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return LoginVC.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getDashBoardScreen() -> DashboardStyle2{
        if DeviceType == iPad{
            return DashboardStyle2.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return DashboardStyle2.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getListSplitScreen() -> ListSplitVC{
        return ListSplitVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
    }
    static func getMasterListScreen() -> MasterListVC{
        if DeviceType == iPad{
            return MasterListVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return MasterListVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCreateOperationScreen() -> CreateOperationVC{
        if DeviceType == iPad{
            return CreateOperationVC.instantiate(fromAppStoryboard:.iPad_CreateSB)
        }else{
            return CreateOperationVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getCreateNotificationScreen() -> CreateNotificationVC{
        if DeviceType == iPad{
            return CreateNotificationVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return CreateNotificationVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getOperationScreen() -> OperationsVC{
        if DeviceType == iPad{
            return OperationsVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return OperationsVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getFilledCheckSheetListScreen() -> FilledCheckSheetListVC{
        if DeviceType == iPad{
            return FilledCheckSheetListVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return FilledCheckSheetListVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getUploadAttachmentLowScreen() -> UploadAttachmentLowVC{
        if DeviceType == iPad{
            return UploadAttachmentLowVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return UploadAttachmentLowVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCheckSheetListScreen()-> CheckSheetListVC{
        if DeviceType == iPad{
            return CheckSheetListVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return CheckSheetListVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCheckSheetAssignmentScreen() -> CheckSheetAssignmentVC{
        if DeviceType == iPad{
            return CheckSheetAssignmentVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return CheckSheetAssignmentVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getManageCheckSheetScreen() -> ManageCheckSheetVC{
        if DeviceType == iPad{
            return ManageCheckSheetVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return ManageCheckSheetVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCheckSheetAvailabilityScreen() -> CheckSheetAvailabilityVC{
        if DeviceType == iPad{
            return CheckSheetAvailabilityVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return CheckSheetAvailabilityVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getCheckSheetViewerScreen() -> CheckSheetViewerVC{
        if DeviceType == iPad{
            return CheckSheetViewerVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return CheckSheetViewerVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getGeneralCheckSheetScreen() -> GeneralCheckSheetListVC{
        if DeviceType == iPad{
            return GeneralCheckSheetListVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return GeneralCheckSheetListVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getWorkOrderAttachmentScreen() -> WorkOrderAttachmentVC{
        if DeviceType == iPad{
            return WorkOrderAttachmentVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return WorkOrderAttachmentVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getMapSplitScreen() -> MapSplitVC{
        if DeviceType == iPad{
            return MapSplitVC.instantiate(fromAppStoryboard: .iPad_GMapSB)
        }else{
            return MapSplitVC.instantiate(fromAppStoryboard: .iPhone_GMapSB)
        }
    }
    static func getObjectScreen() -> ObjectsVC{
        if DeviceType == iPad{
            return ObjectsVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return ObjectsVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getFunctionaLocationListScreen() -> FunctionaLocationListVC{
        if DeviceType == iPad{
            return FunctionaLocationListVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return FunctionaLocationListVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getFlocEquipDetialsScreen() -> FlocEquipDetialsVC{
        if DeviceType == iPad{
            return FlocEquipDetialsVC.instantiate(fromAppStoryboard: .iPad_FlocEquipSB)
        }else{
            return FlocEquipDetialsVC.instantiate(fromAppStoryboard: .iPhone_FlocEquipSB)
        }
    }
    static func getFlocEquipOverViewScreen() -> FlocEquipOverviewVC{
        if DeviceType == iPad{
            return FlocEquipOverviewVC.instantiate(fromAppStoryboard: .iPad_FlocEquipSB)
        }else{
            return FlocEquipOverviewVC.instantiate(fromAppStoryboard: .iPhone_FlocEquipSB)
        }
    }
    static func getInstalledEquipmentScreen() -> InstalledEquipmentVC{
        if DeviceType == iPad{
            return InstalledEquipmentVC.instantiate(fromAppStoryboard: .iPad_FlocEquipSB)
        }else{
            return InstalledEquipmentVC.instantiate(fromAppStoryboard: .iPhone_FlocEquipSB)
        }
    }
    static func getClassificationScreen() -> FlocEquipClassificationListVC{
        if DeviceType == iPad{
            return FlocEquipClassificationListVC.instantiate(fromAppStoryboard: .iPad_FlocEquipSB)
        }else{
            return FlocEquipClassificationListVC.instantiate(fromAppStoryboard: .iPhone_FlocEquipSB)
        }
    }

    static func getNotificationOverViewScreen() -> NotificationOverViewVC{
        if DeviceType == iPad{
            return NotificationOverViewVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return NotificationOverViewVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getWorkOrderTransferScreen() -> TransferRejectVC{
        if DeviceType == iPad{
            return TransferRejectVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return TransferRejectVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getWorkOrderHoldScreen() -> WorkOrderHoldVC{
        if DeviceType == iPad{
            return WorkOrderHoldVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return WorkOrderHoldVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getFlushErrorsScreen() -> FlushErrorsVC{
        if DeviceType == iPad{
            return FlushErrorsVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return FlushErrorsVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getTimeSheetScreen() -> TimeSheetVC{
        if DeviceType == iPad{
            return TimeSheetVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return TimeSheetVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getMapMasterListScreen() -> MapMasterListVC{
        if DeviceType == iPad{
            return MapMasterListVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return MapMasterListVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getAttachmentViewerScreen() -> AttachmentViewerVC{
        if DeviceType == iPad{
            return AttachmentViewerVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return AttachmentViewerVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getSingleNotificationScreen() -> SingleNotificationVC{
        if DeviceType == iPad{
            return SingleNotificationVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return SingleNotificationVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getAttendanceTypeListScreen() -> AttendanceTypeListVC{
        if DeviceType == iPad{
            return AttendanceTypeListVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return AttendanceTypeListVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getInstallEquipOrFLScreen() -> InstallEquipFlocVC{
        if DeviceType == iPad{
            return InstallEquipFlocVC.instantiate(fromAppStoryboard: .iPad_FlocEquipSB)
        }else{
            return InstallEquipFlocVC.instantiate(fromAppStoryboard: .iPhone_FlocEquipSB)
        }
    }
    static func getCreateTimeSheetScreen() -> CreateTimeSheetVC{
        if DeviceType == iPad{
            return CreateTimeSheetVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return CreateTimeSheetVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getLongTextListScreen() -> LongTextListVC{
        if DeviceType == iPad{
            return LongTextListVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return LongTextListVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getCreateWorkOrderScreen() -> CreateWorkOrderVC{
        if DeviceType == iPad{
            return CreateWorkOrderVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return CreateWorkOrderVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getWorkOrderOverViewScreen() -> WorkOrderOverViewVC{
        if DeviceType == iPad{
            return WorkOrderOverViewVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return WorkOrderOverViewVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getMasterListDetailScreen() -> MasterListDetailVC{
        if DeviceType == iPad{
            return MasterListDetailVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return MasterListDetailVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getSettingsScreen() -> SettingsVC{
        if DeviceType == iPad{
            return SettingsVC.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return SettingsVC.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getSettingsDetailsScreen() -> SettingsDetailsVC{
        if DeviceType == iPad{
            return SettingsDetailsVC.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return SettingsDetailsVC.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getStoreStatusScreen() -> StoreStatusVC{
        if DeviceType == iPad{
            return StoreStatusVC.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return StoreStatusVC.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getChangePasswordScreen() -> ChangePasswordVC{
        if DeviceType == iPad{
            return ChangePasswordVC.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return ChangePasswordVC.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getPersonResponsibleListScreen() -> PersonResponsibleListVC{
        if DeviceType == iPad{
            return PersonResponsibleListVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return PersonResponsibleListVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getAssetHierarchyScreen() -> AssetHierarchyVC{
        if DeviceType == iPad{
            return AssetHierarchyVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return AssetHierarchyVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getFlocEquipHierarchyScreen() -> FlocEquipHierarchyVC{
        if DeviceType == iPad{
            return FlocEquipHierarchyVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return FlocEquipHierarchyVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getBreakDownReportScreen() -> BreakDownReportVC{
        if DeviceType == iPad{
            return BreakDownReportVC.instantiate(fromAppStoryboard: .iPad_FlocEquipSB)
        }else{
            return BreakDownReportVC.instantiate(fromAppStoryboard: .iPhone_FlocEquipSB)
        }
    }
    static func getWorkOrderSuspendScreen() -> WorkOrderSuspendVC{
        if DeviceType == iPad{
            return WorkOrderSuspendVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return WorkOrderSuspendVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCreateFinalConfirmationScreen() -> CreateFinalConfirmationVC{
        if DeviceType == iPad{
            return CreateFinalConfirmationVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return CreateFinalConfirmationVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getNotesCaptureScreen() -> NotesCaptureVC{
        if DeviceType == iPad{
            return NotesCaptureVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return NotesCaptureVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getSignatureCaptureScreen() -> SignatureCaptureVC{
        if DeviceType == iPad{
            return SignatureCaptureVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return SignatureCaptureVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCapacityAssignmentScreen() -> CapacityAssignmentVC{
        if DeviceType == iPad{
            return CapacityAssignmentVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return CapacityAssignmentVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getFormApprovalScreen() -> FormApprovalVC{
        if DeviceType == iPad{
            return FormApprovalVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return FormApprovalVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getFormApprovalStatusScreen() -> FormApprovalStatusVC{
        if DeviceType == iPad{
            return FormApprovalStatusVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return FormApprovalStatusVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getListFilterScreen() -> ListFilterVC{
        if DeviceType == iPad{
            return ListFilterVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return ListFilterVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getReviewerScreen() -> ReviewerVC{
        if DeviceType == iPad{
            return ReviewerVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return ReviewerVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getRequestDemoScreen() -> RequestDemoVC{
        if DeviceType == iPad{
            return RequestDemoVC.instantiate(fromAppStoryboard: .iPad_LoginSB)
        }else{
            return RequestDemoVC.instantiate(fromAppStoryboard: .iPhone_LoginSB)
        }
    }
    static func getPDFViewerScreen() -> PDFViewerVC{
        if DeviceType == iPad{
            return PDFViewerVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return PDFViewerVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getCreateJobScreen() -> CreateJobVC{
        if DeviceType == iPad{
            return CreateJobVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return CreateJobVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getMapDeatilsScreen() -> MapDeatilsVC{
        if DeviceType == iPad{
            return MapDeatilsVC.instantiate(fromAppStoryboard: .iPad_GMapSB)
        }else{
            return MapDeatilsVC.instantiate(fromAppStoryboard: .iPhone_GMapSB)
        }
    }
    static func getAssetHierarchyOverViewScreen() -> AssetHierarchyOverViewVC{
        if DeviceType == iPad{
            return AssetHierarchyOverViewVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return AssetHierarchyOverViewVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    static func getOperationListScreen() -> OperationListVC{
        if DeviceType == iPad{
            return OperationListVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return OperationListVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }
    static func getItemCauseCompleteScreen() -> ItemCauseCompleteVC{
        if DeviceType == iPad{
            return ItemCauseCompleteVC.instantiate(fromAppStoryboard: .iPad_CreateSB)
        }else{
            return ItemCauseCompleteVC.instantiate(fromAppStoryboard: .iPhone_CreateSB)
        }
    }
    @available(iOS 13.0, *)
    static func getUploadAttachmentScreen() -> UploadAttachmentVC{
        if DeviceType == iPad{
            return UploadAttachmentVC.instantiate(fromAppStoryboard: .iPad_MainListSB)
        }else{
            return UploadAttachmentVC.instantiate(fromAppStoryboard: .iPhone_MainListSB)
        }
    }

    //MARK: UITableViewCells
    static func registerDBStyle4ListCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.customDBCell, bundle: nil), forCellReuseIdentifier: customCell.customDBCell)
    }
    static func getDBStyle4ListCell(tableView:UITableView) -> CustomDBCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.DBListCell) as! CustomDBCell
        return cell
    }
    static func registerDBStyle3ListCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.customDBCell, bundle: nil), forCellReuseIdentifier: customCell.customDBCell)
    }
    static func getDBStyle3ListCell(tableView:UITableView) -> CustomDBCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.DBListCell) as! CustomDBCell
        return cell
    }
    static func registerDBStyle2ListCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.DBListCell, bundle: nil), forCellReuseIdentifier: customCell.DBListCell)
    }
    static func getDBStyle2ListCell(tableView:UITableView) -> WorkOrderCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.DBListCell) as! WorkOrderCell
        return cell
    }
    static func registerWorkOrderCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.workOrderCell, bundle: nil), forCellReuseIdentifier: customCell.workOrderCell)
    }
    static func getWorkOrderCell(tableView:UITableView) -> WorkOrderCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.workOrderCell) as! WorkOrderCell
        return cell
    }
    static func registerTimeSheetsCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.timeSheetsCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.timeSheetsCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.timeSheetsCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.timeSheetsCell)_iPhone")
        }
    }
    static func getTimeSheetsCell(tableView:UITableView) -> TimeSheetsCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.timeSheetsCell)_iPad") as! TimeSheetsCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.timeSheetsCell)_iPhone") as! TimeSheetsCell
            return cell
        }
    }
    static func registerBreakdownReportTableViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.breakdownReportTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.breakdownReportTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.breakdownReportTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.breakdownReportTableViewCell)_iPhone")
        }
    }
    static func getBreakdownReportTableViewCell(tableView:UITableView) -> BreakdownReportTableViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.breakdownReportTableViewCell)_iPad") as! BreakdownReportTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.breakdownReportTableViewCell)_iPhone") as! BreakdownReportTableViewCell
            return cell
        }
    }
    static func registerFilterVCCell(collectionView: UICollectionView){
        collectionView.register(UINib(nibName: customCell.filterVCCell, bundle: nil), forCellWithReuseIdentifier: customCell.filterVCCell)
    }
    static func getFilterVCCell(collectionView: UICollectionView,indexPath: IndexPath) -> FilterVCCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCell.filterVCCell, for: indexPath) as! FilterVCCell
        return cell
    }
    static func registerTabCell(collectionView: UICollectionView){
        collectionView.register(UINib(nibName: customCell.tabCell, bundle: nil), forCellWithReuseIdentifier: customCell.tabCell)
    }
    static func getTabCell(collectionView: UICollectionView,indexPath: IndexPath) -> TabCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCell.tabCell, for: indexPath) as! TabCell
        return cell
    }
    static func registerObjectsTableViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.objectsTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.objectsTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.objectsTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.objectsTableViewCell)_iPhone")
        }
    }
    static func getObjectsTableViewCell(tableView:UITableView) -> ObjectsTableViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.objectsTableViewCell)_iPad") as! ObjectsTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.objectsTableViewCell)_iPhone") as! ObjectsTableViewCell
            return cell
        }
    }
    static func registerCapacityTableViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.capacityTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.capacityTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.capacityTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.capacityTableViewCell)_iPhone")
        }
    }
    static func getCapacityTableViewCell(tableView:UITableView) -> CapacityTableViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.capacityTableViewCell)_iPad") as! CapacityTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.capacityTableViewCell)_iPhone") as! CapacityTableViewCell
            return cell
        }
    }
    static func registerReadingpointsTableViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.readingpointsTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.readingpointsTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.readingpointsTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.readingpointsTableViewCell)_iPhone")
        }
    }
    static func registerHistoryAndPendingOperationOverViewCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.historyAndPendingOperationOverViewCell, bundle: nil), forCellReuseIdentifier: customCell.historyAndPendingOperationOverViewCell)
    }
    static func registerHistoryCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.historyCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.historyCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.historyCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.historyCell)_iPhone")
        }
    }
    static func registerApprovalTableViewCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.approvalTableViewCell, bundle: nil), forCellReuseIdentifier: customCell.approvalTableViewCell)
    }
    static func getApprovalTableViewCell(tableView:UITableView) -> ApprovalTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.approvalTableViewCell) as! ApprovalTableViewCell
        return cell
    }
    static func registerFormTableViewCell(tableView:UITableView){
        tableView.register(UINib(nibName: "\(customCell.checkSheetTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.checkSheetTableViewCell)_iPhone")
    }
    static func getFormTableViewCell(tableView:UITableView) -> CheckSheetTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.checkSheetTableViewCell)_iPhone") as! CheckSheetTableViewCell
        return cell
    }
    static func registerFormFilledCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.checkSheetFilledCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.checkSheetFilledCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.checkSheetFilledCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.checkSheetFilledCell)_iPhone")
        }
    }
    static func getFormFilledCell(tableView:UITableView) -> CheckSheetFilledCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.checkSheetFilledCell)_iPad") as! CheckSheetFilledCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.checkSheetFilledCell)_iPhone") as! CheckSheetFilledCell
            return cell
        }
    }
    static func registerAttachmentsCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.attachmentsCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.attachmentsCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.attachmentsCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.attachmentsCell)_iPhone")
        }
    }
    static func getAttachmentsCell(tableView:UITableView) -> AttachmentsCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.attachmentsCell)_iPad") as! AttachmentsCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.attachmentsCell)_iPhone") as! AttachmentsCell
            return cell
        }
    }
    static func registerLoadingTableViewCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.loadingTableViewCell, bundle: nil), forCellReuseIdentifier: customCell.loadingTableViewCell)
    }
    static func getLoadingTableViewCell(tableView:UITableView) -> LoadingTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.loadingTableViewCell) as! LoadingTableViewCell
        return cell
    }
    static func registerCheckSheetOptionsCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.checkSheetOptionsCell, bundle: nil), forCellReuseIdentifier: customCell.checkSheetOptionsCell)
    }
    static func getCheckSheetOptionsCell(tableView:UITableView) -> CheckSheetOptionsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.checkSheetOptionsCell) as! CheckSheetOptionsCell
        return cell
    }
    static func registerInspectionCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.inspectionCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.inspectionCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.inspectionCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.inspectionCell)_iPhone")
        }
    }
    static func registerTreeViewCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.treeViewCell, bundle: nil), forCellReuseIdentifier: customCell.treeViewCell)
    }
    static func getTreeViewCell(tableView:UITableView) -> TreeViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.treeViewCell) as! TreeViewCell
        return cell
    }
    static func registerAssetHierarchyOverViewCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.assetHierarchyOverViewCell, bundle: nil), forCellReuseIdentifier: customCell.assetHierarchyOverViewCell)
    }
    static func getAssetHierarchyOverViewCell(tableView:UITableView) -> AssetHierarchyOverViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.assetHierarchyOverViewCell) as! AssetHierarchyOverViewCell
        return cell
    }
    static func registerTeamTimesheetCell(tableView:UITableView){
        tableView.register(UINib(nibName: customCell.teamTimesheetCell, bundle: nil), forCellReuseIdentifier: customCell.teamTimesheetCell)
    }
    static func getTeamTimesheetCell(tableView:UITableView) -> TeamTimesheetCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.teamTimesheetCell) as! TeamTimesheetCell
        return cell
    }
    static func registerWoOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.assetAndDatesCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.assetAndDatesCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.customerInfoOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.customerInfoOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.additionalDataOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.additionalDataOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.assetAndDatesCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.assetAndDatesCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.customerInfoOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.customerInfoOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.additionalDataOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.additionalDataOverViewCell)_iPhone")
        }
    }
    static func getAssetAndDatesCell(tableView:UITableView) -> AssetAndDatesCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.assetAndDatesCell)_iPad") as! AssetAndDatesCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.assetAndDatesCell)_iPhone") as! AssetAndDatesCell
            return cell
        }
    }
    static func getCustomerInfoOverViewCell(tableView:UITableView) -> CustomerInfoOverViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.customerInfoOverViewCell)_iPad") as! CustomerInfoOverViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.customerInfoOverViewCell)_iPhone") as! CustomerInfoOverViewCell
            return cell
        }
    }
    static func getAdditionalDataOverViewCell(tableView:UITableView) -> AdditionalDataOverViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.additionalDataOverViewCell)_iPad") as! AdditionalDataOverViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.additionalDataOverViewCell)_iPhone") as! AdditionalDataOverViewCell
            return cell
        }
    }
    static func registerOperationOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.operationOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.operationOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.operationDatesCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.operationDatesCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.operationAdditionalDataCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.operationAdditionalDataCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.operationOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.operationOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.operationDatesCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.operationDatesCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.operationAdditionalDataCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.operationAdditionalDataCell)_iPhone")
        }
    }
    static func getOperationOverViewCell(tableView:UITableView) -> OperationOverViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.operationOverViewCell)_iPad") as! OperationOverViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.operationOverViewCell)_iPhone") as! OperationOverViewCell
            return cell
        }
    }
    static func getOperationDatesCell(tableView:UITableView) -> OperationDatesCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.operationDatesCell)_iPad") as! OperationDatesCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.operationDatesCell)_iPhone") as! OperationDatesCell
            return cell
        }
    }
    static func getOperationAdditionalDataCell(tableView:UITableView) -> OperationAdditionalDataCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.operationAdditionalDataCell)_iPad") as! OperationAdditionalDataCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.operationAdditionalDataCell)_iPhone") as! OperationAdditionalDataCell
            return cell
        }
    }
    static func registerOnlineWoOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.customerInfoOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.customerInfoOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.otherInfoTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.otherInfoTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.customerInfoOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.customerInfoOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.otherInfoTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.otherInfoTableViewCell)_iPhone")
        }
    }
    static func registerNoOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.notificationWorkOrderAndMaterialCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationWorkOrderAndMaterialCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.notificationDatesCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationDatesCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.notificationLocationAndContactCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationLocationAndContactCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.notificationAdditionalDataCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationAdditionalDataCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.notificationWorkOrderAndMaterialCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationWorkOrderAndMaterialCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.notificationDatesCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationDatesCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.notificationLocationAndContactCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationLocationAndContactCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.notificationAdditionalDataCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationAdditionalDataCell)_iPhone")
        }
    }
    static func getNotificationOverViewCell(tableView:UITableView) -> NotificationOverViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationOverViewCell)_iPad") as! NotificationOverViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationOverViewCell)_iPhone") as! NotificationOverViewCell
            return cell
        }
    }
    static func getNotificationWorkOrderAndMaterialCell(tableView:UITableView) -> NotificationWorkOrderAndMaterialCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationWorkOrderAndMaterialCell)_iPad") as! NotificationWorkOrderAndMaterialCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationWorkOrderAndMaterialCell)_iPhone") as! NotificationWorkOrderAndMaterialCell
            return cell
        }
    }
    static func getNotificationDatesCell(tableView:UITableView) -> NotificationDatesCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationDatesCell)_iPad") as! NotificationDatesCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationDatesCell)_iPhone") as! NotificationDatesCell
            return cell
        }
    }
    static func getNotificationLocationAndContactCell(tableView:UITableView) -> NotificationLocationAndContactCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationLocationAndContactCell)_iPad") as! NotificationLocationAndContactCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationLocationAndContactCell)_iPhone") as! NotificationLocationAndContactCell
            return cell
        }
    }
    static func getNotificationAdditionalDataCell(tableView:UITableView) -> NotificationAdditionalDataCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationAdditionalDataCell)_iPad") as! NotificationAdditionalDataCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.notificationAdditionalDataCell)_iPhone") as! NotificationAdditionalDataCell
            return cell
        }
    }
    static func registerComponentOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.componentOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.componentOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.componentAdditionalDataCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.componentAdditionalDataCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.componentOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.componentOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.componentAdditionalDataCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.componentAdditionalDataCell)_iPhone")
        }
    }
    static func registerNotificationTaskOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationTaskOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationTaskOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationTaskOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationTaskOverViewCell)_iPhone")
        }
    }
    static func registerItemOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.itemOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.itemOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.itemPartsDetailsCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.itemPartsDetailsCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.itemDamageDetailsCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.itemDamageDetailsCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.itemOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.itemOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.itemPartsDetailsCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.itemPartsDetailsCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.itemDamageDetailsCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.itemDamageDetailsCell)_iPhone")
        }
    }
    static func registerItemCausesOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationItemCausesTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationItemCausesTableViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.notificationActivityOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationActivityOverViewCell)_iPad")
            tableView.register(UINib(nibName: "\(customCell.notificationTaskOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationTaskOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationItemCausesTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationItemCausesTableViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.notificationActivityOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationActivityOverViewCell)_iPhone")
            tableView.register(UINib(nibName: "\(customCell.notificationTaskOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationTaskOverViewCell)_iPhone")
        }
    }
    static func registerNotificationItemCausesTableViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationItemCausesTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationItemCausesTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationItemCausesTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationItemCausesTableViewCell)_iPhone")
        }
    }
    static func registerNotificationActivityOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationActivityOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationActivityOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationActivityOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationActivityOverViewCell)_iPhone")
        }
    }
    static func registerClassificationListCell(tableView:UITableView){
        tableView.register(UINib(nibName: "\(customCell.classificationListCell)", bundle: nil), forCellReuseIdentifier: "\(customCell.classificationListCell)")
    }
    static func registerEquipmentOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.equipmentOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.equipmentOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.equipmentOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.equipmentOverViewCell)_iPhone")
        }
    }
    static func registerEquipmentAdditionalCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.equipmentAdditionalCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.equipmentAdditionalCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.equipmentAdditionalCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.equipmentAdditionalCell)_iPhone")
        }
    }
    static func registerInstalledEqupFLdetailsTableViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.installedEqupFLdetailsTableViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.installedEqupFLdetailsTableViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.installedEqupFLdetailsTableViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.installedEqupFLdetailsTableViewCell)_iPhone")
        }
    }
    static func registerClassificationCharacteristicsCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.classificationCharacteristicsCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.classificationCharacteristicsCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.classificationCharacteristicsCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.classificationCharacteristicsCell)_iPhone")
        }
    }
    static func registerEquipmentWarrantyInfoCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.equipmentWarrantyInfoCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.equipmentWarrantyInfoCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.equipmentWarrantyInfoCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.equipmentWarrantyInfoCell)_iPhone")
        }
    }
    static func getClassificationListCell(tableView:UITableView) -> ClassificationListCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.classificationListCell)") as! ClassificationListCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.classificationListCell)") as! ClassificationListCell
            return cell
        }
    }
    static func getEquipmentOverViewCell(tableView:UITableView) -> EquipmentOverViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.equipmentOverViewCell)_iPad") as! EquipmentOverViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.equipmentOverViewCell)_iPhone") as! EquipmentOverViewCell
            return cell
        }
    }
    static func getEquipmentAdditionalCell(tableView:UITableView) -> EuipmentAdditionalCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.equipmentAdditionalCell)_iPad") as! EuipmentAdditionalCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.equipmentAdditionalCell)_iPhone") as! EuipmentAdditionalCell
            return cell
        }
    }
    static func getInstalledEqupFLdetailsTableViewCell(tableView:UITableView) -> InstalledEqupFLdetailsTableViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.installedEqupFLdetailsTableViewCell)_iPad") as! InstalledEqupFLdetailsTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.installedEqupFLdetailsTableViewCell)_iPhone") as! InstalledEqupFLdetailsTableViewCell
            return cell
        }
    }
    static func getClassificationCharacteristicsCell(tableView:UITableView) -> ClassificationCharacteristicsCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.classificationCharacteristicsCell)_iPad") as! ClassificationCharacteristicsCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.classificationCharacteristicsCell)_iPhone") as! ClassificationCharacteristicsCell
            return cell
        }
    }
    static func getEquipmentWarrantyInfoCell(tableView:UITableView) -> EquipmentWarrantyInfoCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.equipmentWarrantyInfoCell)_iPad") as! EquipmentWarrantyInfoCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.equipmentWarrantyInfoCell)_iPhone") as! EquipmentWarrantyInfoCell
            return cell
        }
    }
    static func registerFunctionalLocationOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.functionalLocationOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.functionalLocationOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.functionalLocationOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.functionalLocationOverViewCell)_iPhone")
        }
    }
    static func registerFunctionalLocationAdditionalInfoCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.functionalLocationAdditionalInfoCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.functionalLocationAdditionalInfoCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.functionalLocationAdditionalInfoCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.functionalLocationAdditionalInfoCell)_iPhone")
        }
    }
    static func getFunctionalLocationOverViewCell(tableView:UITableView) -> FunctionalLocationOverViewCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.functionalLocationOverViewCell)_iPad") as! FunctionalLocationOverViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.functionalLocationOverViewCell)_iPhone") as! FunctionalLocationOverViewCell
            return cell
        }
    }
    static func getFunctionalLocationAdditionalInfoCell(tableView:UITableView) -> FunctionalLocationAdditionalInfoCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.functionalLocationAdditionalInfoCell)_iPad") as! FunctionalLocationAdditionalInfoCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.functionalLocationAdditionalInfoCell)_iPhone") as! FunctionalLocationAdditionalInfoCell
            return cell
        }
    }
    static func registerNotificationItemCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationItemCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationItemCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationItemCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationItemCell)_iPhone")
        }
    }
    static func registerOnlineOperationsCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.onlineOperationsCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.onlineOperationsCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.onlineOperationsCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.onlineOperationsCell)_iPhone")
        }
    }
    static func registerOnlineNotificationOverViewCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.notificationOverViewCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationOverViewCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.notificationOverViewCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.notificationOverViewCell)_iPhone")
        }
    }
    static func registerOnlineNotificationOtherInfoCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.onlineNotificationOtherInfoCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.onlineNotificationOtherInfoCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.onlineNotificationOtherInfoCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.onlineNotificationOtherInfoCell)_iPhone")
        }
    }
    static func registerCheckSheetListCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.checkSheetListCell)", bundle: nil), forCellReuseIdentifier: "\(customCell.checkSheetListCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.checkSheetListCell)", bundle: nil), forCellReuseIdentifier: "\(customCell.checkSheetListCell)")
        }
    }
    static func getCheckSheetListCell(tableView:UITableView) -> CheckSheetListCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.checkSheetListCell)_iPad") as! CheckSheetListCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.checkSheetListCell)_iPhone") as! CheckSheetListCell
            return cell
        }
    }
    static func registerReviewerCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.reviewerCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.reviewerCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.reviewerCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.reviewerCell)_iPhone")
        }
    }
    static func getReviewerCell(tableView:UITableView) -> ReviewerCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.reviewerCell)_iPad") as! ReviewerCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.reviewerCell)_iPhone") as! ReviewerCell
            return cell
        }
    }
    static func registerTotalOperationCountCell(tableView:UITableView){
        if DeviceType == iPad{
            tableView.register(UINib(nibName: "\(customCell.totalOperationCountCell)_iPad", bundle: nil), forCellReuseIdentifier: "\(customCell.totalOperationCountCell)_iPad")
        }else{
            tableView.register(UINib(nibName: "\(customCell.totalOperationCountCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.totalOperationCountCell)_iPhone")
        }
    }
    static func getTotalOperationCountCell(tableView:UITableView) -> TotalOperationCountCell{
        if DeviceType == iPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.totalOperationCountCell)_iPad") as! TotalOperationCountCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.totalOperationCountCell)_iPhone") as! TotalOperationCountCell
            return cell
        }
    }
    static func registerAdditionalOperationCountCell(tableView:UITableView){
        tableView.register(UINib(nibName: "\(customCell.totalOperationCountCell)_iPhone", bundle: nil), forCellReuseIdentifier: "\(customCell.totalOperationCountCell)_iPhone")
    }
    static func getAdditionalOperationCountCell(tableView:UITableView) -> TotalOperationCountCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(customCell.totalOperationCountCell)_iPhone") as! TotalOperationCountCell
        return cell
    }
}
