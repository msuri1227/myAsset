//
//  SODataResponseBatchDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataResponseBatch.h"

/**
 Represents an OData batch response
 */
@interface SODataResponseBatchDefault : NSObject <SODataResponseBatch>

/**
 Initializer method
 @param customTag the custom tag
 @param responses the array of the responses
 */
- (instancetype)initWithCustomTag:(NSString*)customTag responses:(NSArray*)responses;

@end
