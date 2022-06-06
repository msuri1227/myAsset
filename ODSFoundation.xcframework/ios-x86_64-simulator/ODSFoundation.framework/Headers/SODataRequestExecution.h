//
//  SODataRequestExecutionl.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

/**
 Status of the execution of request.
 */
typedef enum SODataRequestExecutionStatus {
    SODataRequestExecutionStatusInitialized,
    SODataRequestExecutionStatusInProgress,
    SODataRequestExecutionStatusComplete,
    SODataRequestExecutionStatusCanceled,
    SODataRequestExecutionStatusError
} SODataRequestExecutionStatus;

@protocol SODataRequestParam;
@protocol SODataPayload;
@protocol SODataResponse;

/**
 Request execution object, which is responsible for the execution of the OData request
 */
@protocol SODataRequestExecution <NSObject>

/**
 Identifier of the request.
 */
@property (readonly, nonatomic, copy) NSString* uniqueId;

/**
 The actual status of the request. \sa SODataRequestExecutionStatus
 */
@property (readonly, nonatomic, assign) SODataRequestExecutionStatus status;

/**
 The actual request.
 */
@property (readonly, nonatomic, strong) id<SODataRequestParam> request;

/**
 The response to the request, if available.
 */
@property (readonly, nonatomic, strong) id<SODataResponse> response;

/**
 Constructs a SODataRequestExecution
 @param request the request
 */
- (instancetype) initWithRequest:(id<SODataRequestParam>)request;

/**
 Cancels the execution of the request. The request will not change it's status after this call.
 */
- (void) cancelExecution;

/**
 * Check whether the cache is in passive mode or in active
 */
-(BOOL)isCachePassive;

/**
 Check whether the previously saved payload was updated or not
 */
-(BOOL)updatedPayload;

@end
