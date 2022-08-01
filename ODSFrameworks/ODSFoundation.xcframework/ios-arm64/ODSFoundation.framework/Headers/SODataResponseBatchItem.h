//
//  SODataResponseBatchItem.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Representation of an item in a batch response. This is a marker interface. This can be a single response (ODataResponseSingle) or a change set (ODataResponseChangeSet).
 */
@protocol SODataResponseBatchItem <NSObject>

@end
