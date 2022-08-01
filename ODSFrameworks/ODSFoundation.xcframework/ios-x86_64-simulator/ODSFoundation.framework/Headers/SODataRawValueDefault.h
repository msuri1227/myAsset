//
//  SODataRawValueDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataRawValue.h"

/**
 Represents the raw value of an OData property
 */
@interface SODataRawValueDefault : NSObject <SODataRawValue>

/**
 * Custom initializer
 * @param value the value to init the raw value with
 */
-(instancetype)initWithValue:(NSString*)value;

@end
