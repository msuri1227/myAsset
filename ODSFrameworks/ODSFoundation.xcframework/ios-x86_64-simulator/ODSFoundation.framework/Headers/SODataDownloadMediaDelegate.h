//
//  SODataDownloadMediaDelegate.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

@protocol SODataDownloadMediaExecution;
@protocol SODataDownloadMediaResult;

/**
 This delegate is called when an Odata request is being executed
 */
@protocol SODataDownloadMediaDelegate <NSObject>

@required

/**
 * This delegate is called when the request was successful and the result is coming from the server
 */
- (void) mediaDownloadServerResponse:(id<SODataDownloadMediaExecution>)requestExecution result:(id<SODataDownloadMediaResult>)result;

/**
 * This delegate is called when the request failed
 */
- (void) mediaDownloadFailed:(id<SODataDownloadMediaExecution>)requestExecution error:(NSError*)error;

@optional

/**
 * This delegate is called when the request has started
 */
- (void) mediaDownloadStarted:(id<SODataDownloadMediaExecution>)requestExecution;

/**
 * This delegate is called when the request was succesdful and the result is coming from the technical cache
 */
- (void) mediaDownloadCacheResponse:(id<SODataDownloadMediaExecution>)requestExecution result:(id<SODataDownloadMediaResult>)result;

/**
 * This delegate is called when the request finished
 */
- (void) mediaDownloadFinished:(id<SODataDownloadMediaExecution>)requestExecution;


@end
