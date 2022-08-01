//
//  SODataResponseChangeset.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataResponseBatchItem.h"

/**
 Representation of a change set in a batch response. A change set can contain only the responses of the CUD requests.
 */
@protocol SODataResponseChangeset <SODataResponseBatchItem>

/**
 Responses contains single respones @see SODataResponseSingle
 */
@property (readonly, nonatomic, strong) NSArray* responses;

@end
