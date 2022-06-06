//
//  SAPE2ETraceTransactionDefault.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import "SAPE2ETraceTransaction.h"

#pragma mark - SAPE2ETraceTransaction Default Implementation

/**
 *  Provides default SAPE2ETraceTransaction implementation
 */
@interface SAPE2ETraceTransaction : NSObject<SAPE2ETraceTransaction>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSMutableArray* steps;
@property (nonatomic, strong) NSDictionary* attributes;

@end
