//
//  SAPE2ETraceDefault.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import "SAPE2ETrace.h"

#pragma mark - SAPE2ETrace Default Implementation
/**
 *  Provides default SAPE2ETrace implementation
 */
@interface SAPE2ETrace : NSObject<SAPE2ETrace>

/**
 *  Returns the Singleton instance
 *
 *  @return shared SAPE2ETrace instance
 */
+(instancetype) sharedInstance;


@property (nonatomic, readonly, getter = getE2ETraceLevel ) SAP_E2E_TRACELEVEL E2ETraceLevel; ///< retrieves the current E2ETrace level

@end
