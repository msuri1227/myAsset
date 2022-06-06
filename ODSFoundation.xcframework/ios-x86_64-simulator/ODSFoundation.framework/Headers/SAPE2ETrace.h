//
//  SAPE2ETracing.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import "SAPE2ETraceRequest.h"

/**
 * Defines the Trace levels
 * The verbosity of the E2E trace can be set using these trace levels
 */
typedef NS_ENUM(NSUInteger, SAP_E2E_TRACELEVEL)
{
    SAPTraceLevelUndefined = 0,  ///< value not defined
	SAPTraceLevelLow = 1,	///< Focus on response-time distribution analysis (how much time is spent on each server component or where is the bottleneck)
	SAPTraceLevelMedium,	///< Focus on perfromance analysis; performance traces are triggered on server-side (e.g. Introscope transaction trace, ABAP trace, SQL traces, etc.)
	SAPTraceLevelHigh,		///< Functional analysis - activation of detailed functional logging and tracing in SAP J2EE and ABAP system
	SAPTraceLevelNone,     ///< Focus on client side analysis. No traces are triggered on erver side at all
};

/**
 *  Declares SAPE2ETrace APIs
 *  @remark Default implementation provided with the same name
 */
@protocol SAPE2ETrace <NSObject>

/**
 *  Returns the Singleton instance
 *
 *  @return shared SAPE2ETrace instance
 */
+(id<SAPE2ETrace>) sharedInstance;

-(SAP_E2E_TRACELEVEL) getE2ETraceLevel;   ///< retrieves the current E2ETrace level

/**
 *  Ends the request
 *
 *  @param request_in a valid E2ETrace request
 *  @param error error description in case of issues
 *
 *  @return YES on success, NO otherwise
 */
-(BOOL) endTraceRequest:(id<SAPE2ETraceRequest>)request_in error:(NSError**)error;

/**
 *  Creates an E2E trace request and inserts it to the current step
 *  @remark The returned trace request is initialized to default values; the owner is responsible for providing meaningful values
 *
 *  @param error error description in case of issues
 *  @return E2E trace request initialized to defaults
 */
-( id<SAPE2ETraceRequest> ) createTraceRequest:(NSError**)error;

@end
