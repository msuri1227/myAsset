//
//  SODataMetaComplexType.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaAnnotable.h"

@protocol SODataMetaProperty;

/**
 Represents a complex type in an entity model (edm:ComplexType).
 Complex types are keyless nominal structured types. The lack of a key means that complex types cannot be created, updated or deleted independently of an entity type. Complex types allow entity models to 
 group properties into common structures if the group of properties does not need to be managed independently. All properties MUST have a unique name. Properties MUST NOT have the same name as the 
 declaring complex type.
 */
@protocol SODataMetaComplexType <SODataMetaAnnotable, NSObject>

/**
 The set of the property names.
 */
@property (readonly, nonatomic, strong) NSArray* propertyNames;

/**
 Retrieves the metadata representation of one property specified by the given property name.
 @param propertyName Name of the property.
 @return SODataMetaProperty the property.
 */
- (id<SODataMetaProperty>)propertyForName:(NSString*)propertyName;

@end
