//
//  SAPE2ETraceRequestDefault.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import "SAPE2ETraceRequest.h"

#pragma mark - SAPE2ETraceRequest Default Implementation

/**
 *  Provides default SAPE2ETraceRequest implementation
 */
@interface SAPE2ETraceRequest : NSObject<SAPE2ETraceRequest>

@property (nonatomic, assign) NSUInteger byteCountSent;     ///< The total number of bytes sent

@property (nonatomic, assign) NSUInteger byteCountReceived; ///< The total number of bytes received

@end
