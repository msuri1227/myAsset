//
//  SAPE2ETraceRequest.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SAPE2ETraceStep.h"
#import "SAPE2ETraceRequest.h"

/**
 *  Declares SAPE2ETraceRequest public APIs
 *  @remark Default implementation provided with the same name
 */
@protocol SAPE2ETraceStep <NSObject>

/**
 * Status of the E2E step.
 * Possible values can be found in SAP_E2E_TRACE_STATUS
 */
@property (nonatomic, readonly, assign) SAP_E2E_TRACE_STATUS status;

#pragma mark - E2E Step Methods
/**
 *  Creates and starts a business step
 *
 *  @return object representing a business step
 */
-(id<SAPE2ETraceStep>) init;

/**
 *  Closes the step
 *
 *  @param error error description
 *
 *  @return YES is step could be successfully ended
 */
-(BOOL) endStep:(NSError**)error;

#pragma mark - E2E Request Methods

/**
 *  Creates and starts an E2E trace request
 *
 *  @return object representing an E2E request
 */
-(id<SAPE2ETraceRequest>) startRequest:(NSError**)error;

/**
 *  Ends the request
 *
 *  @param request the give request to end
 *  @param error error description
 *
 *  @return YES is request could be successfully ended
 */
-(BOOL) endRequest:(id<SAPE2ETraceRequest>)request error:(NSError**)error;

/**
 *  Returns all currently active E2E trace requests belonging to the step
 *
 *  @return array< id<SAPE2ETraceRequest> >
 */
-(NSArray*) getRequests;


#pragma mark - Step XML Fragment Methods

/**
 *  Retrieves the XML fragment for this very step
 *  This will be appended to the Business transaction XML
 *
 *  @param error error description
 *
 *  @return Transaction Step XML as string
 */
-(NSString*) getXML:(NSError**)error;

@end
