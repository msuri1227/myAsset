//
//  SAPE2ETraceStepDefault.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import "SAPE2ETraceStep.h"

#pragma mark - SAPE2ETraceStep Default Implementation

/**
 *  Provides default SAPE2ETraceStep implementation
 */
@interface SAPE2ETraceStep : NSObject<SAPE2ETraceStep>

@property (nonatomic, retain) NSMutableArray* requestList;

@end
