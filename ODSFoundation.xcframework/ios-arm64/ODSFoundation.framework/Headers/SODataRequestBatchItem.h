//
//  SODataRequestBatchItem.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Representation of an item in a batch request. This is a marker interface. This can be a single request (ODataRequestParamSingle) or a change set (ODataRequestChangeSet).
 */
@protocol SODataRequestBatchItem <NSObject>

@end
