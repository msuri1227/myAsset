//
//  SODataLinkList.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

/**
 Represents a set of links pointing to arbitrary resources.
 */
@protocol SODataLinkList <SODataPayload>

/**
 Array of links. \sa SODataLink
 */
@property (readonly, nonatomic, strong) NSMutableArray* links;

@end
