//
//  Constant.swift
//

import Foundation
import ODSFoundation
import FormsEngine
import mJCLib

public let SCREEN_MAX_LENGTH   = Int( max(screenWidth, screenHeight) )
public let SCREEN_MIN_LENGTH   = Int( min(screenWidth, screenHeight) )
public let IS_IPHONE_XS_MAX    = ((DeviceType == iPhone) && SCREEN_MAX_LENGTH == 812) || ((DeviceType == iPhone) && SCREEN_MAX_LENGTH == 896)
// app constants

var serverIP = String()
var portNumber : Int = 0443
var ApplicationID = String()
var serverURL = String()
var addressPlistPath : URL?
var localDateFormate = "dd-MM-yyyy"
var localTimeFormat = "HH:mm"
var localDateTimeFormate = "dd-MM-yyyy HH:mm"
var globalDateTimeFormate = "yyyy-MM-dd'T'HH:mm:ss"
var isHttps = Bool()
var authType = String()
var autoConfig = Bool()
var serverPopupRequired = Bool()
let GoogleAPIKey = "AIzaSyC4h3YkzNzpQ2Zo1dziVsSJtxOsQvD79Qs"
var demoModeEnabled = false

// Global Array values

var globalPlanningPlantArray = Array<MaintencePlantModel>()
var globalPriorityArray = Array<PriorityListModel>()
var globalWorkCtrArray = Array<WorkCenterModel>()
var globalPersonRespArray = Array<PersonResponseModel>()
var statusCategoryArr = Array<StatusCategoryModel>()
var globalStatusArray = [WorkOrderStatusModel]()
var workFlowListArray = Array<LtWorkFlowModel>()
var attachmentTypeListArray = Array<AttachmentTypeModel>()
var catlogArray = NSMutableArray()
var globalWoAttachmentArr = [String]()
var globalNoAttachmentArr = [String]()
var offlinestoreDefineReqArray = [ServiceConfigModel]()
var offlinestoreListArray = [AppStoreModel]()
var offlinestoreNameArray = [String]()
var allworkorderArray = [WoHeaderModel]()
var allNotficationArray = [NotificationModel]()
var allOperationsArray = [WoOperationModel]()
var entitySetKeysArray = Array<EntityKeysModel>()
var flushErrorsArray = NSMutableArray()
var orderTypeFeatureDict = NSMutableDictionary()
var notificationTypeArray = [NotificationTypeModel]()
var applicationFeatureArrayKeys = Array<String>()
var workOrderCreateDictionary = NSMutableDictionary()
var funcLocationArray = [FunctionalLocationModel]()
var funcLocationListArray = [String]()
var totalEquipmentArray = [EquipmentModel]()
var totalEquipmentListArray = [String]()
var currentuserdetails = Array<UserDetailsModel>()
var woOperationsArray = [WoOperationModel]()
var woWorkOrder = String()

// background sync variables

var EventBased_Sync = String()
var TimeBased_Sync = String()
var EventBased_Sync_Type = String()
var TimeBased_Sync_Type = String()
var BG_SYNC_TIME_INTERVAL  = String()
var BG_SYNC_RETRY_COUNT = String()
var BG_SYNC_RETRY_INTERVAL  = String()
var MasterData_BG_Refresh_Retry_Interval_In_Min = String()
var MasterData_BG_Refresh_Retry_Attempts = String()
var MasterData_BG_Refresh_Interval_Value = String()
var MasterData_BG_Refresh_Unit_In_Hours = Bool()
var MasterData_BG_Refresh_Enable = Bool()
var flushStatus = Bool()

// App Config constants

var WO_NOTES_POST_IN_OP = Bool();
var AUTO_NOTES_ON_STATUS = Bool();
var AUTO_NOTES_TEXT_LINE1 = String();
var AUTO_NOTES_TEXT_LINE2 = String();
var AUTO_NOTES_TEXT_LINE3 = String();
var AUTO_NOTES_TEXT_LINE4 = String();
var OPERATION_COMPLETE_TEXT = String()
var ATT_TYPE_HOURS_OF_COSTING = String()
var OPERATION_INCOMPLETE_TEXT = String()
var CREATE_WORKORDER_WITH_OPERATION = Bool()
var WORKORDER_ASSIGNMENT_TYPE = String()
var NOTIFICATION_ASSIGNMENT_TYPE = String()
var ADD_ASSIGNMENT_TYPE = String()
var FORM_ASSIGNMENT_TYPE = String()
var ENABLE_OPERATION_MEASUREMENTPOINT_READINGS = Bool()
var SHOW_DEFAULT_TIMESHEET_ENTRY_IN_LIST = Bool()
var GOOGLE_MAP_API_CALL_ENABLED = Bool()
var Attachment_Service_URL = String()
var SAP_Host = String()
var Tx_Service_Suffix = String()
var ACTIVITY_TYPE_TRAVEL_TIME = String()
var ACTIVITY_TYPE_ACCESS_TIME = String()
var ACTIVITY_TYPE_WORK_TIME = String()
var COMPONENT_ISSUE_REQUIRED = Bool()
var MPOINT_READING_REQUIRED = Bool()
var Device_Log_File_Name_Format = String()
var Device_Log_File_Name_Extension = String()
var Error_Desription_Display_Separator = String()
var ENABLE_POST_DEVICE_LOCATION_NOTES  = Bool()
var SERVER_PING_URL = String()
var TX_SERVICE_NAME = String()
var LOW_VOLUME_MD_SERVICE_NAME = String()
var HIGH_VOLUME_MD_SERVICE_NAME = String()
var FORMS_ENGINE_SERVICE_NAME = String()
var SUPERVISOR_SERVICE_NAME =  String()
var ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION = Bool()
var WO_OP_OBJS_DISPLAY = String()
var AUTO_DISPLAY_ERROR_SCREEN = Bool()
var DEVICE_LOG_FILE_SIZE = String()
var DEVICE_LOG_AUTO_DELETION_DAYS = String()
var ENABLE_PUSH_SUBCRIPTION = Bool()
var isCreateNotificationThroughForms = false
var ENABLE_CAPTURE_TEAM_TIMESHEET = Bool()
var ENABLE_CREATE_FINAL_CONFIRMATION = Bool()
var ENABLE_CAPTURE_DURATION = Bool()
var WO_OBJS_DISPLAY = String()
var DEFAULT_STATUS_TO_CHANGE = String()
var DEFAULT_STATUS_TO_SEND1 = String()
var OPR_INSP_ENABLE_STATUS = String()
var OPR_INSP_RESULT_RECORDED_STATUS = String()
var TIMESHEET_FETCH_INTERVAL = String()
let LONG_TEXT_TYPE_COMPONENT = "MATK";
let LONG_TEXT_TYPE_NOTIFICATION = "QMEL";
let LONG_TEXT_TYPE_OPERATION = "AVOT";
let LONG_TEXT_TYPE_WO = "AUFK";
let LONG_TEXT_TYPE_NOTIFICATION_ITEM = "QMFE"
let LONG_TEXT_TYPE_NOTIFICATION_ACTIVITY = "QMMA"
let LONG_TEXT_TYPE_NOTIFICATION_TASK = "QMSM"
let LONG_TEXT_TYPE_NOTIFICATION_ITEM_CAUSE = "QMUR"
var DEFAULT_PREMIUM_ID  = String()
var DEFAULT_PREMIUM_NO  = String()
var DOWNLOAD_CREATEDBY_WO = String()
var DOWNLOAD_CREATEDBY_NOTIF = String()
let STATUS_HOLD = "HOLD";
let STATUS_TRANSFER = "TRANSFER";
let STATUS_SET_FLAG = "X";
let STATUS_REJECT = "REJECT";
var ASSETMAP_TYPE = "ESRIMAP";
var ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO = Bool()
var NO_TASK_COMP_STATUS = String()
var CATALOGCODE_DAMAGE = String()
var CATALOGCODE_CAUSE = String()
var CATALOGCODE_ITEM = String()
var CATALOGCODE_ACTIVITY = String()
var CATALOGCODE_TASK = String()
var CATALOGCODE_SYMPTOM = String()
let OPERATION_STATUS_TO_MARK_INCOMPLETE  = "CRTD";
let ENABLE_LOCAL_STATUS_CHANGE = true
let DEFAULT_STATUS_TO_SEND = "CRTD"
let ENABLE_LOCAL_NO_TO_WO = true
var Show_Postal_Code = false
var EDIT_NO_SCREEN_IN_COMPLETION = true
var ENABLE_REPORTEDBY_IN_CRATEJOB_SCREEN = false
var DISPLAY_EQUIP_FLOC_LIST_IN_DASHBOARD_FILTER = false
var SHOW_DEMO_MODE = true
var ENABLE_PARTDETAILS_IN_CREATEJOB_SCREEN = false
var KILL_APP_ON_LOGOUT = false
var SHOW_CREATEJOB_ON_CREATENOTIF_IN_LIST_SCREEN = false
var ENABLE_CANCEL_FINAL_CONFIRMATION = false


//MARK:- APP Colors

let compactButtonBG = UIColor(red: 210.0/255.0, green: 115.0/255.0, blue: 55.0/255.0, alpha: 1.0)
let appColor = UIColor(red: 87.0/255.0, green: 137.0/255.0, blue: 173.0/255.0, alpha: 1.0)
let selectionBgColor = UIColor(red: 87.0/255.0, green: 137.0/255.0, blue: 173.0/255.0, alpha: 0.7)
let filledCountColor = UIColor(red: 240.0/255.0, green: 155.0/255.0, blue: 60.0/255.0, alpha: 1.0)
let dbfilterBgColor = UIColor.init(red: 212.0/255.0, green: 227.0/255.0, blue: 233.0/255.0, alpha: 1.0)
let mapMarkerColor = UIColor.init(red:0.0/255.0,  green:255.0/255.0,  blue:255.0/255.0, alpha:1)

//MARK:- userDetails..

var userSystemID = String()
var userDisplayName = String()
var userPersonnelNo = String()
var isSupervisor = String()
var userWorkcenter = String()
var OpWorkCentter = String()
var userPlant = String()
var userPersonnelArea = String()
var userCOArea = String()
var userBusinessArea = String()
var Role_ID = String()
var User_ID_MinLength = 5;
var User_PSWD_MinLength = 5;
var userLocation_LatLong = String()


//MARK:-  global Variable

var sideSelectedMenu = String()
var isMasterHidden = Bool()
var currentMasterView = String()
var currentsubView = String()
var isSingleNotifFromOperation : Bool = false
var isSingleNotifFromWorkOrder : Bool = false
var isSupportPortait : Bool = false
var attachmentuploadTab : Bool = false
var strUser = ""
var operationTableCountSelectedCell = -1
var isActiveWorkOrder = Bool()
var isActiveNotification = Bool()
var singleWorkOrder = WoHeaderModel()
var singleOperation = WoOperationModel()
var isfromMapScreen = Bool()
var onlineSearch = false
var onlineSearchArray = [Any]()
var searchType = String()
var inStockAvailable = Bool()
var deletionValue = false
var logoutValue = false
var selectedIndex = Int()
var scrollingIndex = 0
var WorkOrderTimeSpan = 30
var NotificationTimeSpan = 30
var fromSupervisorWorkOrder = Bool()
var selectedworkOrderNumber = String()
var selectedOperationNumber = String()
var selectedComponentNumber = String()
var selectedNotificationNumber = String()
var selectedItem = String()
var selectedTask = String()
var selectedAcitivity = String()
var selectedItemActivity = String()
var selectedItemTask = String()
var selectedItemCause = String()
var selectedEquipment = String()
var HistoryAndPendingWoOpr = String()
var HistoryAndPendingWoOprFrom = String()
var TechnicianName = String()
var tempSelectedFunctionalLocation = String()
var tempSelectedEquipment = String()
var componentClass = ComponentAvailabilityModel()
var formCaptureClass = FormResponseCaptureModel()
var finalReadingpointsArray = Array<MeasurementPointModel>()
var currentRecordPointArray = Array<MeasurementPointModel>()
var singleNotification = NotificationModel()
var alltechnicianListArray = Array<SupervisorTechnicianModel>()
var isSingleNotification = Bool()
var isItemActivity = Bool()
var isItemTask = Bool()
var isItemCause = Bool()
var snackBar : OdsProgressBarView?
var isOperationDone = false
var isComponentIssueDone = false
var isAttachmentDone = false
var isFormFilledDone = false
var isRecordPointDone = false
var isOperationCreated = false
var isWOCreated = false
var isFormCreatedThroughNotification = false
var masterDataLoadingItems = 50
var loginAttempts = 0
var selectedEqFLoc = String()
var GroupUser = String()
var totalWorkorders = NSMutableArray()
var filterWorkorders = NSMutableArray()
var totalNotifications = NSMutableArray()
var filterNotifications = NSMutableArray()
var dashboardFilterDic = [String:Any]()
var fileManager = FileManager.default
var documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
var libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] as String
//MARK:- Create entity Variables
let CreateEntityBase_App        = "ODS_SAP_WM_AP_DLITE_SRV."
let createEntityBase_TxS        = "ODS_SAP_WM_DLITE_SRV."
let createEntityBase_FrmS       = "ODSMFE_PR_FORMUI_SRV."
let createEntityBase_High_Vol   = "ODS_SAP_WM_HT_DLITE_SRV."
let createEntityBase_QM         = "ODS_PR_QM_CALIBRATION_SRV."

let woHeader_Entity = "\(createEntityBase_TxS)WoHeader"
let Password_Entity = "\(CreateEntityBase_App)ChangePassword"
let PushNotificationSubscription = "SubscriptionCollection"
let PushNotificationSubscription_Entity = "\(CreateEntityBase_App)Subscription"
var workOrderAttachmentUploadentity = "\(createEntityBase_TxS)UploadWOAttachmentContent"
var woComponentSetEntity = "\(createEntityBase_TxS)WOComponent";
var woComponentIssueSetEntity = "\(createEntityBase_TxS)WOComponentIssue";
var woOperationEntity = "\(createEntityBase_TxS)WOOperation";
var woNotificationTaskCollectionEntity = "\(createEntityBase_TxS)WONotificationTask"
var woNotificationActivityCollectionEntity = "\(createEntityBase_TxS)WONotificationActivity"
var woNotificationItemCollectionEntity = "\(createEntityBase_TxS)WONotificationItem"
let woNotificationItemCausesCollectionEntity = "\(createEntityBase_TxS)WONotificationItemCauses"
let woNotificationLongTextSetEntity = "\(createEntityBase_TxS)WONotificationLongText";
let workOrderConfirmationEntity = "\(createEntityBase_TxS)WOConfirmation";
let woLongTextSetEntity = "\(createEntityBase_TxS)WOLongText"//...Done...
let measurementPointReadingSetEntity = "\(createEntityBase_TxS)MeasurementPointReading"
var manualCheckSheetCreateEntity = "\(createEntityBase_FrmS)FormManualAssignment"
var approverCheckSheetCreateEntity = "\(createEntityBase_FrmS)FormResponseApprovalStatus"
let notificationHeaderSetEntity = "\(createEntityBase_TxS)NotificationHeader"
let notificationActivitySetEntity = "\(createEntityBase_TxS)NotificationActivity"
let notificationItemSetEntity = "\(createEntityBase_TxS)NotificationItem"
let notificationItemCausesSetEntity = "\(createEntityBase_TxS)NotificationItemCauses"
let notificationTaskSetEntity = "\(createEntityBase_TxS)NotificationTask"
let uploadNOAttachmentContentSetEntity = "\(createEntityBase_TxS)UploadNOAttachmentContent"
let uploadFormContentSetEntity = "\(createEntityBase_FrmS)FormAttachment"
let notificationLongTextSetEntity = "\(createEntityBase_TxS)NotificationLongText";
let catsRecordSetEntity = "\(createEntityBase_TxS)GETCATSRecods";
let installEquipmentEntity = "\(createEntityBase_TxS)InstallEquipment"
let equipmentDismantleEntity = "\(createEntityBase_TxS)EquipmentDismantle"
let responseCaptureSetEntity = "\(createEntityBase_FrmS)ResponseCapture"
let formApprovalSetEntity = "\(createEntityBase_FrmS)FormApprover"
var inspectionResultEntity = "\(createEntityBase_QM)InspectionResultsGet"

//MARK:- Assignment types

var OperationLevel = "OPERATIONLEVEL"
var WorkcenterHeadeLevel = "WORKCENTERHEADERLEVEL"
var WorkcenterOperationLevel = "WORKCENTEROPERATIONLEVEL"
var WorkorderLevel = "WORKORDERLEVEL"
var NotificationLevel = "NOTIFICATIONLEVEL"
var checkSheetLevel = "CHECKSHEETLEVEL"
var NotificationWorkcenterLevel = "NOTIFICATIONWORKCENTERLEVEL"
var NotificationTaskLevel = "NOTIFICATIONTASKLEVEL"

//MARK:- workorder count varialbles

var OprCount = String()
var OprColor : UIColor? = UIColor.red
var cmpCount = String()
var cmpColor : UIColor? = UIColor.red
var inspCount = String()
var InspColor : UIColor? = UIColor.red
var formCount = String()
var formColor : UIColor? = UIColor.red
var attchmentCount = String()
var attchmentColor : UIColor? = appColor
var rpCount = String()
var rpColor : UIColor? = UIColor.red
var objectCount = String()
var approvedCheckSheetCount = String()
var approvedCheckSheetColor : UIColor? = appColor
var rejectedCheckSheetCount = String()
var rejectedCheckSheetColor : UIColor? = appColor
var yetToBeCheckSheetCount = String()
var yetToBeCheckSheetColor : UIColor? = appColor

//MARK:- Notification count varialbles

var ItemCount = String()
var ItemColor : UIColor? = appColor
var ItemTaskCount = String()
var ItemTaskColor : UIColor? = appColor
var ItemActvityCount = String()
var ItemActvityColor : UIColor? = appColor
var ItemCauseCount = String()
var ItemCauseColor : UIColor? = appColor
var ActvityCount = String()
var ActvityColor : UIColor? = appColor
var TaskCount = String()
var TaskColor : UIColor? = appColor
var NOItemCount = Int()
var NOItemCauseCount = Int()
var inCompTaskCount = Int()
var noAttchmentCount = String()
var noAttchmentColor : UIColor? = appColor

//MARK:- Localization strings

let inactiveWorkorderAlertMessage = "You_are_not_actively_working_on_the_selected_Work_Order_hence_this_action_is_not_allowed".localized()
let inactiveOperationAlertMessage = "You_are_not_actively_working_on_the_selected_Operation_hence_this_action_is_not_allowed".localized()
let inactiveNotificationAlertMessage = "You_are_not_actively_working_on_the_selected_Notification_hence_this_action_is_not_allowed".localized()
let inactiveWorkorderAlertTitle = "Inactive_Work_Order".localized()
let inactiveOperationAlertTitle = "Inactive_Operation".localized()
let inactiveNotificationAlertTitle = "Inactive_Notification".localized()
let deleteWOAlert = "You_cannot_mark_this_workorder_as_deleted".localized()
let notificationViewAlert = "Changes_to_Workorder_notification_item_are_not_allowed_You_can_view_item_Activities_Tasks_and_Causes".localized()
let formFilledAlert = "You_have_already_reached_the_maximum_submissions_possible".localized()
let functionalocationAlert = "couldn’t_find_functional_location_for_id".localized()
let equipmentAlert = "couldn’t_find_equipment_for_id".localized()
let ComponetitemAlert = "couldn’t_find_Material_for_id".localized()
let loginAlert = "Welcome_Validating_your_credentials_Registration_is_in_progress".localized()
let loginSuccessAlert = "We_are_keeping_the_things_ready_Please_wait".localized()
let loginUsernameBlankAlert = "Please_enter_username".localized()
let loginUsernameShortAlert = "Username_is_too_short".localized()
let loginPasswordBlankAlert = "Please_enter_Password".localized()
let loginPasswordShortAlert = "Password_is_too_short".localized()
let loginPasswordNotMatchAlert = "Password_does_not_match".localized()
let DescriptionAlert = "Please_enter_description".localized()
let SelectDateTimeAlert = "Please_select_end_date_and_time".localized()
let SelectFunctionLocation = "Please_Add_Function_Location".localized()
let SelectEquipment = "Please_Add_Equipment".localized()
let NotesSaved = "Notes_Saved_Successfully".localized()
let TimeSheetSaved = "Timesheet_Data_Saved_Successfully".localized()
let BusinessAreaAlert = "Please_select_Business_Area".localized()
let WorkCenterAlert = "Please_select_WorkCenter".localized()
let StrtDateAlert = "Start_date_can't_fall_after_finish".localized()
let cameraAlert = "There_is_no_camera_available_on_this_device".localized()
let somethingwrongalert = "Something_went_wrong_please_try_again".localized()
let alerttitle = "Alert".localized()
let okay = "Ok".localized()
let locationAlert = "Please_on_location_services".localized()
let MessageTitle = "Message".localized()
let AddressAlert = "Address_Not_Found".localized()
let sorrytitle = "Sorry".localized()
let errorTitle = "Error".localized()
let WarningAlert = "Warning".localized()
let Yesalert = "YES".localized()
let Noalert = "NO".localized()
let selectStr = "--Select--".localized()
let noInternetAlert = "The_Internet_connection_appears_to_be_offline".localized()
let ServerDownAlert = "Unable to connect with server"
let loginOtherUserAlert = "was_logged_in_earlier_Any_pending_changes_will_be_lost_Do_you_still_want_to_continue".localized()

// DashBoard static Array
var dateDropArray = [Filters.PlannedForToday.value, Filters.PlannedForTomorrow.value,Filters.PlannedforNextWeek.value,Filters.OverdueForLastTwodays.value,Filters.OverdueForAWeek.value,Filters.AllOverdue.value,Filters.CreatedInLast30Days.value,Filters.SchedulingComplaint.value,Filters.SchedulingNonComplaint.value]
var WoFilterArray = [selectStr,Filters.Priority.value,Filters.Status.value,Filters.UserStatus.value,Filters.WorkCenter.value,Filters.MantActivityType.value,Filters.InspectionLot.value,Filters.FunctionalLocation.value,Filters.Equipment.value,Filters.Date.value,Filters.TechID.value]
//Filters.SystemStatus.value, Filters.Location.value,Filters.CSStatus.value,Filters.TechID.value,
var NoFilterArray = [selectStr,Filters.Priority.value,Filters.Status.value,Filters.UserStatus.value,Filters.WorkCenter.value,Filters.WorkorderConversion.value,Filters.FunctionalLocation.value,Filters.Equipment.value,Filters.Date.value,Filters.TechID.value]
//Filters.SystemStatus.value,Filters.Location.value,Filters.TechID.value
var typeArray = [Filters.AssignedToMe.value,Filters.CreatedByMe.value]
var CSStatusArry = [Filters.CSApproved.value ,Filters.CSRejected.value,Filters.CSNotReviewed.value ,Filters.CSCorrectionRequired.value]
var colorArray = ["#f68b1f","#0083ca","#72bf44","#FFCDD2","#ab218e","#b21212","#FFECB3","#004990","#008a3b","#f7bf8d","#52247f","#cb4d2c","#f0ab00","#00a1e4","#808080","#b2b2b2"]
var dashBoardArray = ["DASHBOARD_REVIWER_TILE","DASH_ASSET_HIE_TILE","ASSET_HIERARCHY","DASH_GENERAL_FORM_TILE","DASH_TIMESHEET_TILE","DASH_ONLINE_SEARCH_TILE"]
var dashBoardMenuArray = ["Sync_Application".localized(),"Master_Data_Refresh".localized(), "Error_Logs".localized(),"Share_logs".localized(),"Change_Logs".localized(),"Log_Out".localized(),"Log_Out_Clear_Data".localized()]
var dashBoardMenuimgArray = [#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "share_logs"),#imageLiteral(resourceName: "what'sNew"),#imageLiteral(resourceName: "LogOutBlack"),#imageLiteral(resourceName: "LogOutBlack")]

var imgExtensions = ["jpeg","jpg","png","image/jpeg","image/png"]
var docExtensions = ["doc","docm","docx","dotx","html","rtf","txt","xml","ppt"]
var excelExtensions = ["xlsx","xls","csv","xlt"]
var videoExtensios = ["application/mp4","mov",".mov","mp4"]
var defaultImageType = "jpg"

var filteredWorkorders = [WoHeaderModel]()
var filteredOperations = [WoOperationModel]()
var filteredNotifications = [NotificationModel]()


var supervisorWoSideMenuArr = ["Home".localized(),"Job_Location".localized(), "Notifications".localized(), "Time_Sheet".localized(),"Supervisor_View".localized(),"Team".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Error_Logs".localized(),"Log_Out".localized()]
var supervisorWoSideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]

var supervisorNoSideMenuArr = ["Home".localized(),"Job_Location".localized(), "Work_Orders".localized(), "Time_Sheet".localized,"Supervisor_View".localized(),"Team".localized(),"Master_Data_Refresh".localized(), "Asset_Map".localized(), "Settings".localized(),"Error_Logs".localized(),"Log_Out".localized()]
var supervisorNoSideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]

var workorderSideMenuArr = ["Home".localized(),"Master_Data_Refresh".localized(), "Settings".localized(),"Error_Logs".localized(),"Log_Out".localized()]
var workorderSideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]

var notificationSideMenuArr = ["Home".localized(),"Job_Location".localized(), "Work_Orders".localized(), "Time_Sheet".localized, "Master_Data_Refresh".localized(), "Asset_Map".localized(), "Settings".localized(),"Error_Logs".localized(),"Log_Out".localized()]
var notificationSideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]

var workorderChildSideMenuArr = ["Overview".localized(), "Assests".localized(), "Attachments".localized(),"Checklists".localized()]
var workorderChildSideMenuImgArr = [#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "Operations"),#imageLiteral(resourceName: "Attachments"),#imageLiteral(resourceName: "Forms")]

var operationChildSideMenuArr = ["Overview".localized(),"Attachments".localized(), "Checklists".localized()]
var operationChildSideMenuImgArr = [#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "Attachments"),#imageLiteral(resourceName: "Forms")]

var notificationChildSideMenuArr = ["Home".localized(),"Overview".localized(), "Items".localized(), "Activities".localized(), "Tasks".localized(), "Attachments".localized(), "History".localized(), "Pending".localized()]
var notificationChildSideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "OverView"), #imageLiteral(resourceName: "ItemsNF"),#imageLiteral(resourceName: "RecordPonits"),#imageLiteral(resourceName: "TasksNF"),#imageLiteral(resourceName: "AttachementsNF"),#imageLiteral(resourceName: "History"),#imageLiteral(resourceName: "PendingNF")]

var attachmentMenuArr = ["Capture_Image".localized(),"Capture_Video".localized(),"Upload_Image".localized(),"Upload_Document".localized(),"Upload_Url".localized()]
var attachmentMenuImgArr = [#imageLiteral(resourceName: "captureImage"),#imageLiteral(resourceName: "uploadVideo"),#imageLiteral(resourceName: "uploadimage"),#imageLiteral(resourceName: "uploadURL"),#imageLiteral(resourceName: "uploadURL")]
