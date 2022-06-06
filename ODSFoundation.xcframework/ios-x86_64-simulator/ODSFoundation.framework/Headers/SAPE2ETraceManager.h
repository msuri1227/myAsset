//
//  SAPE2ETraceManaging.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SAPE2ETrace.h"
#import "SAPE2ETraceTransaction.h"
#import "SAPE2ETraceStep.h"
#import "SupportabilityUploading.h"

@protocol SAPE2ETraceManager <NSObject>

/**
 * Trace level to be sent to the server.
 * Possible values and meaning can be found in SAP_E2E_TRACELEVEL
 */
@property (nonatomic, assign, getter = getE2ETraceLevel) SAP_E2E_TRACELEVEL traceLevel;

/**
 *  Retrieves the singleton E2E trace manager instance
 *
 *  @return E2E trace manager instance
 */
+(id<SAPE2ETraceManager>) sharedInstance;

#pragma mark - Trace action accessors
/**
 *  Returns the E2ETrace instance
 *
 *  @return E2ETrace instance
 */
-(id<SAPE2ETrace>) getActiveTrace;

/**
 *  Retrieves the current transaction
 *
 *  @return current transaction instance; note that active transaction's state can be ended so that transaction can't start new steps
 */
-(id<SAPE2ETraceTransaction>) getActiveTransaction;

/**
 *  Retrieves the current business step
 *
 *  @return current business step instance
 */
-(id<SAPE2ETraceStep>) getActiveStep;

#pragma mark - Transaction management
/**
 *  Creates and starts a transaction
 *  If there is already a transaction running, the old one will be removed from the memory and a new one will be created.
 *
 *  @param transactionName_in unique transaction identifier
 *  @param error error description in case of failure
 *
 *  @return valid E2ETrace transaction or nil on failure
 */
-(id<SAPE2ETraceTransaction>) startTransaction:(NSString*)transactionName_in error:(NSError**)error;

/**
 *  Ends an E2E transaction
 *
 *  @param error error description in case of failure
 *
 *  @return YES on success, NO otherwise
 */
-(BOOL) endTransaction:(id<SAPE2ETraceTransaction>)transaction_in error:(NSError**)error;

#pragma mark - Business transaction and E2E trace payload

/**
 *  Retrieves the Busines Transction XML
 *
 *  @param error error description in case of failure
 *
 *  @return valid Busines Transction XML or nil on failure
 */
-(NSString*)getBTX:(NSError**)error;

/**
 *  Uploads the Busines Transction XML to the server
 *
 *  @param uploader network request used to POST the BTX
 *  @param completion The completion block to call back
 *
 */
-(void) uploadBTX:(id<SupportabilityUploading>)uploader completion:(void(^)(NSError* error))completion;

@end

