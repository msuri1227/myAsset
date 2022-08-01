//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

//import to MAFLogonHandler
#import "HttpConversationManager.h"
#import "CommonAuthenticationConfigurator.h"
#import <dispatch/dispatch.h>
#import "SODataStore.h"
#import "SODataStoreAsync.h"
#import "SODataRequestDelegate.h"
#import "SODataRequestExecution.h"
#import "SODataResponseSingle.h"
#import "SODataError.h"
#import "SODataRequestParamSingleDefault.h"
#import "SODataResponseSingleDefault.h"
#import "SODataPropertyDefault.h"
#import "SODataEntityDefault.h"
#import "SODataRequestParamBatchDefault.h"
#import "SODataMetadata.h"
#import "SODataMetadataDefault.h"
#import "SODataRawValueDefault.h"
#import "SODataEntitySet.h"
#import "SODataEntity.h"
#import "SODataProperty.h"
#import "SODataUploadMediaDefault.h"
#import "applications.h"
#import "SODataV4_runtime.h"
#import "SODataRequestChangeset.h"
#import "SODataResponseChangesetDefault.h"
#import "SODataRequestChangesetDefault.h"

// Newly added for online search
#import "SODataNavigationProperty.h"
#import "SODataNavigationPropertyDefault.h"
#import "SODataEntitySetDefault.h"
#import "SODataResponseBatch.h"


//TODO: BEGIN (UNCOMMENT OFFLINE ODATA EXERCISE) ######################################
#import "SODataOfflineStoreOptions.h"
#import "SODataOfflineStore.h"
#import "SODataDuration.h"

// TODO: BEGIN (Required imports) for logging
#import "SAPSupportabilityFacade.h"
#import "SAPClientLoggerDefault.h"
#import "SAPClientLogManager.h"
#import "SAPClientLogger.h"
#import "SAPE2ETraceManager.h"
#import "SAPE2ETrace.h"
#import "SAPE2ETraceRequest.h"
#import "SupportabilityUploader.h"
#import "SupportabilityUploading.h"
#import "SAPClientLogDestination.h"
// TODO: END (Required imports)

// Utilities

#import "ODSXMLReader.h"
#import "ODSReachability.h"
#import "ODSTryCatch.h"
#import "PJRSignatureView.h"
//JTCalendar
#import "JTCalendar.h"
#import "JTCalendarDelegate.h"
#import "JTCalendarManager.h"
#import "JTCalendarSettings.h"
#import "JTDateHelper.h"
#import "JTCalendarDelegateManager.h"
#import "JTCalendarScrollManager.h"
#import "JTCalendarDay.h"
#import "JTCalendarPage.h"
#import "JTCalendarWeek.h"
#import "JTCalendarWeekDay.h"
#import "JTContent.h"
#import "JTMenu.h"
#import "JTCalendarDayView.h"
#import "JTCalendarMenuView.h"
#import "JTCalendarPageView.h"
#import "JTCalendarWeekDayView.h"
#import "JTCalendarWeekView.h"
#import "JTHorizontalCalendarView.h"
#import "JTVerticalCalendarView.h"
