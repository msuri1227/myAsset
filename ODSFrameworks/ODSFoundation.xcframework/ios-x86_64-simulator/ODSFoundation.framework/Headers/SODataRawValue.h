//
//  SODataRawValue.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

/**
 Represents the raw value of an OData property.
 */
@protocol SODataRawValue <SODataPayload>

/**
 Returns the raw value returned by the server.
 */
@property (readonly, nonatomic, copy) NSString* value;

@end
