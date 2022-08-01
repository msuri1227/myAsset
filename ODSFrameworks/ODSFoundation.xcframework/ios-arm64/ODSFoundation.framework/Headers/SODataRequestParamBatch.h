//
//  SODataRequestParamBatch.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataRequestBatchItem.h"
#import "SODataRequestParam.h"

/**
 Representation for a batch request. A batch request can contain batch items (ODataRequestBatchItem). A batch item can be single read request (ODataRequestParamSingle) or a change set 
 (ODataRequestChangeSet).
 */
@protocol SODataRequestParamBatch <SODataRequestParam>

/**
 This array contains the bachItems of the batch request.
 */
@property (readonly, nonatomic, strong) NSMutableArray* batchItems;

@end
