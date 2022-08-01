//
//  customEnums.swift
//  myJobCard
//
//  Created by Rover Software on 20/04/18.
//  Copyright © 2018 Ondevice Solutions. All rights reserved.
//

import Foundation
import UIKit

public struct status {
    var Name = String()
    var Code = String()
    var imgPath = String()
    var DoesActive = Bool()
    init(Name: String,Code: String,imgPath: String,DoesActive: Bool ) {
        self.Name = Name
        self.Code = Code
        self.imgPath = imgPath
        self.DoesActive = DoesActive
    }
}

struct mobilestatus{
    static let ASSIGNED = status.init(Name: "ASSIGNED", Code: "ASGD", imgPath: "", DoesActive: false)
    static let RECEIVED = status.init(Name: "RECEIVED", Code: "MOBI", imgPath: "", DoesActive:false)
    static let ENROUTE = status.init(Name: "ENROUTE", Code: "ENRT", imgPath: "", DoesActive: true)
    static let ARRIVED = status.init(Name: "ARRIVED", Code: "ARRI", imgPath: "", DoesActive: true)
    static let ACCEPT = status.init(Name: "ACCEPTED", Code: "ACCP", imgPath: "", DoesActive: false)
    static let START = status.init(Name: "STARTED", Code: "STRT", imgPath: "", DoesActive: true)
    static let HOLD = status.init(Name: "HOLD", Code: "HOLD", imgPath: "", DoesActive: false)
    static let SUSPEND = status.init(Name: "SUSPENDED", Code: "SUSP", imgPath: "", DoesActive: false)
    static let COMPLETE = status.init(Name: "COMPLETED", Code: "COMP", imgPath: "", DoesActive: false)
    static let REJECT = status.init(Name: "REJECTED", Code: "REJC", imgPath: "", DoesActive: false)
    static let TRANSFER = status.init(Name: "TRANSFER", Code: "TRNS", imgPath: "", DoesActive: false)
    static let all:[status] = [ASSIGNED,RECEIVED,ENROUTE,ARRIVED,ACCEPT,START,HOLD,SUSPEND,COMPLETE,REJECT,TRANSFER]
}

enum TravelModes: Int {
    case driving
    case walking
    case bicycling
}
enum BusinessProcess{
    static let Maintenance1 = ["Unplanned  Maintenance Work Order","PROCESS1","ZPM1",true,false,false] as [Any]
    static let Maintenance2 = ["Unplanned  Maintenance Work Order", "img1", "PROCESS1", "ZPM1",true,false,false] as [Any]
    static let CustomerService = ["Customer Service Order", "img1", "PROCESS3", "ZOCS",true,false,true] as [Any]
    static let ServiceManager = ["Customer Service Order", "img1", "PROCESS5", "ZSM1",true,false,true] as [Any]
    static let RoundManager = ["Round Manager Work Order", "img1", "PROCESS4", "ZRM1",true,true,false] as [Any]
    static let Inspection = ["Inspection Work Order", "img1", "PROCESS6", "ZRM1",true,true,false] as [Any]
    static let NONE = ["","img1","","",false, false,false] as [Any]
}

enum Features{
    static let OPERATION = ["OPERATION","OPERATION"]
    static let COMPONENT = ["COMPONENT","COMPONENT"]
    static let ATTACHMENT = ["ATTACHMENT","ATTACHMENT"]
    static let FORMS = ["FORMS","FORMS"]
    static let RECORDPOINTS = ["RECORDPOINTS","RECORDPOINTS"]
    static let SIGNATURESCREEN = ["SIGNATURESCREEN","SIGNATURESCREEN"]
}
enum OrderFeaturs{
    
}

struct AppFontName {
    static let regular  = "Roboto-Regular"
    static let bold     = "Roboto-Bold"
    static let italic   = "Roboto-Italic"
    static let Medium   = "Roboto-Medium"
    static let SemiBold = "Roboto-Medium"
}

enum Filters {
    case Priority,
         NoPriority,
         ControlKey,
         Status,
         UserStatus,
         SystemStatus,
         OrderType,
         WorkCenter,
         PlanningPlant,
         MaintenancePlant,
         MantActivityType,
         Date,
         PlannedForToday,
         PlannedForTomorrow,
         PlannedforNextWeek,
         OverdueForLastTwodays,
         OverdueForAWeek,
         AllOverdue,
         CreatedInLast30Days,
         SchedulingComplaint,
         SchedulingNonComplaint,
         FunctionalLocation,
         Equipment,
         PlannerGroup,
         TechID,
         Technician,
         Location,
         NotificationType,
         WorkorderConversion,
         WorkorderCreated,
         WorkorderNotCreated,
         CreatedOrAssigned,
         AssignedToMe,
         CreatedByMe,
         Unassignged,
         InspectionLot,
         InspectionCompleted,
         InspectionPending,
         CSStatus,
         CSApproved,
         CSRejected,
         CSNotReviewed,
         CSCorrectionRequired
    
    var value : String {
        get {
            switch(self) {
            case .Priority:
                return "Priority".localized()
            case .NoPriority:
                return "No_Priority".localized()
            case .Status:
                return "Status".localized()
            case . ControlKey:
                return "Control_Key".localized()
            case .UserStatus:
                return "User_Status".localized()
            case .SystemStatus:
                return "System_Status".localized()
            case .OrderType:
                return "Order_Type".localized()
            case .WorkCenter:
                return "WorkCenter".localized()
            case .PlanningPlant:
                return "Planning_Plant".localized()
            case .MaintenancePlant:
                return "Maintenance_Plant".localized()
            case .MantActivityType:
                return "Mant.Activity_Type".localized()
            case .Date:
                return "Date".localized()
            case .FunctionalLocation:
                return "Functional_Location".localized()
            case .Equipment:
                return "Equipment".localized()
            case .PlannerGroup:
                return "Planner_Group".localized()
            case .TechID:
                return "Tech_ID".localized()
            case .Technician:
                return "Technician".localized()
            case .Location:
                return "Location".localized()
            case .PlannedForToday:
                return "Planned_For_Today".localized()
            case .PlannedForTomorrow:
                return "Planned_For_Tomorrow".localized()
            case .PlannedforNextWeek:
                return "Planned_for_Next_Week".localized()
            case .OverdueForAWeek:
                return "Overdue_for_a_Week".localized()
            case .OverdueForLastTwodays:
                return "Overdue_For_Last_2_days".localized()
            case .AllOverdue:
                return "All_Overdue".localized()
            case .CreatedInLast30Days:
                return "Created_in_last_30_Dates".localized()
            case .SchedulingComplaint:
                return "Scheduling_Complaint".localized()
            case .SchedulingNonComplaint:
                return "Scheduling_Non_Complaint".localized()
            case .NotificationType:
                return "Notification_Type".localized()
            case .WorkorderConversion:
                return "Work_order_Conversion".localized()
            case .WorkorderCreated:
                return "Work_order_Created".localized()
            case .WorkorderNotCreated:
                return "Work_order_Not_Created".localized()
            case .AssignedToMe:
                return "Assigned_To_Me".localized()
            case .CreatedByMe:
                return "Created_By_Me".localized()
            case .CreatedOrAssigned:
                return "Created_or_Assigned".localized()
            case .Unassignged:
                return "Unassigned".localized()
            case .InspectionLot:
                return "InspectionLot".localized()
            case .InspectionCompleted:
                return "Inspection_Completed".localized()
            case .InspectionPending:
                return "Inspection_Pending".localized()
            case .CSStatus:
                return "CSStatus".localized()
            case .CSApproved:
                return "CSApproved".localized()
            case .CSRejected:
                return "CSRejected".localized()
            case .CSNotReviewed:
                return "CSNotReviewed".localized()
            case .CSCorrectionRequired:
                return "CSCorrectionRequired".localized()
            }
        }
    }
}
enum AppStoryboard : String {
    case MainListSB_iPad,
         CreateSB_iPad,
         LoginSB_iPad,
         GMapSB_iPad,
         AssetMapSB_iPad,
         SupervisorSB_iPad,
         OnlineSB_iPad,
         FlocEquipSB_iPad,
         WorkorderSB_iPad,
         NotificationSB_iPad,
         ChecksheetSB_iPad,
         MainListSB_iPhone,
         CreateSB_iPhone,
         LoginSB_iPhone,
         GMapSB_iPhone,
         AssetMapSB_iPhone,
         SupervisorSB_iPhone,
         OnlineSB_iPhone,
         FlocEquipSB_iPhone,
         WorkorderSB_iPhone,
         NotificationSB_iPhone,
         ChecksheetSB_iPhone,
         myAsset_iPhone,
         myAsset_iPad,
         iPhone_LoginSB,
         iPad_LoginSB,
         iPhone_MainListSB,
         iPad_MainListSB,
         iPhone_CreateSB,
         iPad_CreateSB,
         iPhone_GMapSB,
         iPad_GMapSB,
         iPhone_FlocEquipSB,
         iPad_FlocEquipSB
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
enum customCell {
    static let DBListCell = "DashBoardListCell"
    static let customDBCell = "CustomDBCell"
    static let workOrderCell = "WorkOrderCell"
    static let timeSheetsCell = "TimeSheetsCell"
    static let teamTimesheetCell = "TeamTimesheetCell"
    static let filterVCCell = "FilterVCCell"
    static let tabCell = "TabCell"
    static let objectsTableViewCell = "ObjectsTableViewCell"
    static let capacityTableViewCell = "CapacityTableViewCell"
    static let readingpointsTableViewCell = "ReadingpointsTableViewCell"
    static let historyAndPendingOperationOverViewCell = "HistoryAndPendingOperationOverViewCell"
    static let historyCell = "HistoryCell"
    static let approvalTableViewCell = "ApprovalTableViewCell"
    static let checkSheetTableViewCell = "CheckSheetTableViewCell"
    static let checkSheetFilledCell = "CheckSheetFilledCell"
    static let checkSheetOptionsCell = "CheckSheetOptionsCell"
    static let attachmentsCell = "AttachmentsCell"
    static let loadingTableViewCell = "LoadingTableViewCell"
    static let inspectionCell = "InspectionCell"
    static let treeViewCell = "TreeViewCell"
    static let assetHierarchyOverViewCell = "AssetHierarchyOverViewCell"
    static let breakdownReportTableViewCell = "BreakdownReportTableViewCell"
    static let reviewerCell = "ReviewerCell"
    static let totalOperationCountCell = "TotalOperationCountCell"
    static let assetAndDatesCell = "AssetAndDatesCell"
    static let customerInfoOverViewCell = "CustomerInfoOverViewCell"
    static let additionalDataOverViewCell = "AdditionalDataOverViewCell"
    static let otherInfoTableViewCell = "OtherInfoTableViewCell"
    static let operationOverViewCell = "OperationOverViewCell"
    static let operationDatesCell = "OperationDatesCell"
    static let operationAdditionalDataCell = "OperationAdditionalDataCell"
    static let notificationOverViewCell = "NotificationOverViewCell"
    static let notificationWorkOrderAndMaterialCell = "NotificationWorkOrderAndMaterialCell"
    static let notificationDatesCell = "NotificationDatesCell"
    static let notificationLocationAndContactCell = "NotificationLocationAndContactCell"
    static let notificationAdditionalDataCell = "NotificationAdditionalDataCell"
    static let componentOverViewCell = "ComponentOverViewCell"
    static let componentAdditionalDataCell = "ComponentAdditionalDataCell"
    static let itemOverViewCell = "ItemOverViewCell"
    static let itemPartsDetailsCell = "ItemPartsDetailsCell"
    static let itemDamageDetailsCell = "ItemDamageDetailsCell"
    static let notificationItemCausesTableViewCell = "NotificationItemCausesTableViewCell"
    static let notificationActivityOverViewCell = "NotificationActivityOverViewCell"
    static let notificationTaskOverViewCell = "NotificationTaskOverViewCell"
    static let notificationItemCell = "NotificationItemCell"
    static let onlineOperationsCell = "OnlineOperationsCell"
    static let onlineNotificationOtherInfoCell = "OnlineNotificationOtherInfoCell"
    static let equipmentOverViewCell = "EquipmentOverViewCell"
    static let equipmentAdditionalCell = "EuipmentAdditionalCell"
    static let installedEqupFLdetailsTableViewCell = "InstalledEqupFLdetailsTableViewCell"
    static let classificationCharacteristicsCell = "ClassificationCharacteristicsCell"
    static let equipmentWarrantyInfoCell = "EquipmentWarrantyInfoCell"
    static let classificationListCell = "ClassificationListCell"
    static let functionalLocationOverViewCell = "FunctionalLocationOverViewCell"
    static let functionalLocationAdditionalInfoCell = "FunctionalLocationAdditionalInfoCell"
    static let checkSheetListCell = "CheckSheetListCell"
    static let inspectedCell = "SearchAssetCell"
}
