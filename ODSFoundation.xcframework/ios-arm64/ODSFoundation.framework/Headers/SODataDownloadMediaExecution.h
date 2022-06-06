//
//  SODataDownloadMediaExecution.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

/**
 Status of the execution of request.
 */
typedef enum SODataDownloadMediaExecutionStatus {
    SODataDownloadMediaExecutionStatusInProgress,
    SODataDownloadMediaExecutionStatusComplete,
    SODataDownloadMediaExecutionStatusSuccess,
    SODataDownloadMediaExecutionStatusCanceled,
    SODataDownloadMediaExecutionStatusError
} SODataDownloadMediaExecutionStatus;

@protocol SODataDownloadMediaResult;

/**
 Media Request execution object, which is responsible for the execution of the media requests.
 */
@protocol SODataDownloadMediaExecution <NSObject>

/**
 Identifier of the media request.
 */
@property (readonly, nonatomic, copy) NSString* uniqueId;

/**
 The actual status of the media request. \sa SODataDownloadMediaExecutionStatus
 */
@property (readonly, nonatomic, assign) SODataDownloadMediaExecutionStatus status;

/**
 The url of the media request.
 */
@property (readonly, nonatomic, copy) NSURL* url;

/**
 Constructs a SODataDownloadMediaExecution
 @param url the url of the media request
 */
- (id) initWithURL:(NSURL*)url;

/**
 Cancels the execution of the request. The request will not change it's status after this call.
 */
- (void) cancelExecution;

@end
