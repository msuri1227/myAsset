//
//  SODataRequestDelegate.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

@protocol SODataRequestExecution;

/**
 This delegate is called when an Odata request is being executed
 */
@protocol SODataRequestDelegate <NSObject>

@required

/**
 * This delegate is called when the request failed
 */
- (void) requestFailed:(id<SODataRequestExecution>)requestExecution error:(NSError*)error;

/**
 * This delegate is called when the server responsed to the request
 */
- (void) requestServerResponse:(id<SODataRequestExecution>)requestExecution;

@optional

/**
 * This delegate is called when the request started
 */
- (void) requestStarted:(id<SODataRequestExecution>)requestExecution;

/**
 * This delegate is called when the request finished
 */
- (void) requestFinished:(id<SODataRequestExecution>)requestExecution;


/**
 * This delegate is called when the cache responsed to the request
 */
- (void) requestCacheResponse:(id<SODataRequestExecution>)requestExecution;

@end
