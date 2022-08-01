//
//  SODataResponseBatch.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataResponse.h"

/**
 Representation for a batch response. A batch response can contain batch items (ODataResponseBatchItem). A batch item can be either a single read response (ODataResponseSingle) or a change set 
 (ODataResponseChangeSet).
 */
@protocol SODataResponseBatch <SODataResponse>

/**
 Response array which contains SODataResponseBatchItems @see SODataResponseBatchItem
 */
@property (readonly, nonatomic, strong) NSArray* responses;

@end
