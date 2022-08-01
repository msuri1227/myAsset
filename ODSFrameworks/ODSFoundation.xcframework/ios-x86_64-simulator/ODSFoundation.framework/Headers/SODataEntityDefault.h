//
//  SODataEntityDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataEntity.h"

/**
 Represents an OData entity
 */
@interface SODataEntityDefault : NSObject <SODataEntity>

/**
 * Custom initializer
 * @param type type of the Entity
 */
- (instancetype) initWithType:(NSString*)type;

/**
 * Custom initializer
 * @param type type of the Entity
 * @param annotations the annotations of the Entity
 */
- (instancetype) initWithType:(NSString*)type annotations:(NSDictionary *)annotations;


@end
