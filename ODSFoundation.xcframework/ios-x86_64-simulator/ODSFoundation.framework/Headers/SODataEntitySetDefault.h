//
//  SODataEntitySetDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataEntitySet.h"

/**
 Represents an OData feed
 */
@interface SODataEntitySetDefault : NSObject<SODataEntitySet>

/**
 * Custom initializer
 * @param count size of the EntitySet
 */
-(instancetype)initWithCount:(NSNumber*)count;

@end
