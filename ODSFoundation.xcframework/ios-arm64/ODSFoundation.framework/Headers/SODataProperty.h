//
//  SODataProperty.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

/**
 Individual data values of the entity are represented as elements where the name of the element is the name of the entity property within the OData Data Namespace.
 */
@protocol SODataProperty <SODataPayload>

/**
 Name of the property.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Indicates wether the property is complex or not.
 */
@property (readonly, nonatomic, assign) BOOL isComplex;

/**
 The value of the property.
 */
@property (nonatomic, strong) NSObject* value;

@end
