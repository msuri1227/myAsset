//
//  SAPE2ETraceRequest.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "SAPE2ETrace.h"
#import "SAPE2ETraceStep.h"

/**
 *  Declares SAPE2ETraceTransaction public APIs
 *  @remark Default implementation provided with the same name
 */
@protocol SAPE2ETraceTransaction <NSObject>

/**
 * Status of the E2E transaction.
 * Possible values can be found in SAP_E2E_TRACE_STATUS
 */
@property (nonatomic, readonly, assign) SAP_E2E_TRACE_STATUS status;

#pragma mark - Transaction Lifecycle Methods
/**
 *  Creates a new E2E transaction
 *  @remark Only one active transaction can exist at a time
 *
 *  @param transactionName_in unique transaction name
 *
 *  @return valid E2E transaction instance
 */
-(id<SAPE2ETraceTransaction>) initWithName:(NSString*)transactionName_in;

/**
 *  Terminates the given transaction
 *
 *  @param error error description in case of issues
 *
 *  @return YES if successful
 */
-(BOOL) endTransaction:(NSError**)error;

#pragma mark - Business Step Methods

/**
 *  Retrieves the currently active busieness step
 *
 *  @return current step of the transaction; note that active step's status can be ended so that the step can't start new requests
 */
-(id<SAPE2ETraceStep>) getActiveStep;

/**
 *  Creates and starts a business step
 *
 *  @return object representing a business step
 */
-(id<SAPE2ETraceStep>) startStep:(NSError**)error_in;

/**
 *  Closes the step
 *
 *  @param error error description
 *
 *  @return YES is step could be successfully ended
 */
-(BOOL) endStep:(NSError**)error;

#pragma mark - BTX Methods

/**
 *  Retrieves the Business Transaction XML
 *
 *  @param error error description in case of failures
 *
 *  @return The Business Transaction XML
 */
-(NSString*) getBTX:(NSError**)error;

@end
