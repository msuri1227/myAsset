//
//  SODataMetaComplexTypeDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaComplexType.h"
#import "SODataMetaAnnotableDefault.h"

/**
 The SODataMetaComplexType element represents a complex type in an entity model. It contains zero or more properties describing properties of the complex type.
 */
@interface SODataMetaComplexTypeDefault : SODataMetaAnnotableDefault<SODataMetaComplexType>

/**
 * Custom initializer
 * @param properties the properties to initialize the Complex Type with
 */
- (instancetype)initWithProperties:(NSDictionary*)properties;

/**
 * Custom initializer
 * @param properties the properties to initialize the Complex Type with
 * @param vocabularyAnnotations the V4 annotations to initialize the Complex Type with
 */
- (id)initWithProperties:(NSDictionary*)properties vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;

@end
