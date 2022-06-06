//
//  SAPE2ETraceManagerDefault.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import "SAPE2ETraceManager.h"

#pragma mark - Default SAPE2ETraceManager Implementation

@interface SAPE2ETraceManager : NSObject<SAPE2ETraceManager>

@property (nonatomic, strong) NSData* rootId;                ///< root id used in SAP extended passport
@property (nonatomic, readonly) NSUInteger stepCount;      ///< current step count
@property (nonatomic, readonly) NSUInteger requestCount;   ///< current request count
@property (nonatomic, readonly, strong) NSData* terminalId;  ///< terminal id used in SAP extended passport

/**
 *  Returns the string representation of the trace flags associated with the current trace level
 *
 *  @return two bytes containing predefined values associated with the specific trace level
 */
+(instancetype) sharedInstance;

/**
 *  Returns the string representation of the trace flags associated with the current trace level
 *
 *  @return two bytes containing predefined values associated with the specific trace level
 */
- (NSString*) traceFlagsAsString;

/**
 *  Increments step counter
 */
- (void) incrementStep;

/**
 *  Increments request counter
 */
- (void) incrementRequest;

@end
