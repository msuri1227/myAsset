//
//  SODataRequestChangeSet.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataRequestParamSingle.h"
#import "SODataRequestBatchItem.h"

/**
 Representation of a change set in a batch request. A change set can contain only CUD requests. The execution of a change set is atomic (either all executed successfully, or all failed).
 */
@protocol SODataRequestChangeset <SODataRequestBatchItem>

/**
 This array contains the RequestParamSingles inside of the changeset.
 */
@property (readonly, nonatomic, strong) NSMutableArray* requestParams;

@end
