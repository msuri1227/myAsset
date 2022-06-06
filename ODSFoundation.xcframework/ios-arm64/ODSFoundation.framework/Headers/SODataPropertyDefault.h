//
//  SODataPropertyDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataProperty.h"

/**
 Individual data values of the entity are represented as elements where the name of the element is the name of the entity property within the OData Data Namespace.
 */
@interface SODataPropertyDefault : NSObject <SODataProperty>

/**
 * Custom initializer
 * @param name name of the property
 */
- (instancetype) initWithName:(NSString*)name;

@end
