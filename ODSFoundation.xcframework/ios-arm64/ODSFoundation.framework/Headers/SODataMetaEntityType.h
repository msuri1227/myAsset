//
//  SODataMetaEntityType.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaAnnotable.h"

@protocol SODataMetaProperty;
@protocol SODataMetaNavigationProperty;
@protocol SODataAnnotationName;

/**
 Represents an entity type in the entity model (edm:EntityType).
 Entity types are nominal structural types with a key that consists of one or more references to structural properties. An entity type by definition has an independent existence and can be created, 
 updated or deleted independently of any other types. An entity type is the template for an entity: any uniquely identifiable record such as a customer or order. An entity type can define two types of 
 properties. A structural property is a named reference to a primitive or complex type, or a collection of primitive or complex types. A navigation property is a named reference to another entity type or 
 collection of entity types. All properties MUST have a unique name. Properties MUST NOT have the same name as the declaring entity type. An open entity type allows properties to be added to an instance 
 of the type dynamically. Any request for the value of a missing property on an open entity type MUST return nil.
 */
@protocol SODataMetaEntityType <SODataMetaAnnotable, NSObject>

/**
 Retrieves the name of the entity type.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Indicates whether the Entity is Media Entity or not.
 */
@property (readonly, nonatomic, assign) BOOL isMediaEntity;

/**
 Retrieves the set of property names.
 */
@property (readonly, nonatomic, strong) NSArray* propertyNames;

/**
 Retrieves the set of key property names.
 */
@property (readonly, nonatomic, strong) NSArray* keyPropertyNames;

/**
 Retrieves the set of navigation property names.
 */
@property (readonly, nonatomic, strong) NSArray* navigationPropertyNames;

/**
 Retrieves the set of annotation names of the entity type.
*/
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Retrieves the metadata representation of a property by name.
 @param propertyName the name of the property
 @return SODataMetaProperty
 */
- (id<SODataMetaProperty>)propertyForName:(NSString*)propertyName;

/**
 Retrieves the metadata representation of a navigation property specified by its name.
 @param navigationPropertyName the name of the navigation property
 @return SODataMetaNavigationProperty */
- (id<SODataMetaNavigationProperty>) navigationPropertyForName:(NSString*)navigationPropertyName;

/**
 Retrieves the annotation value of the entity set specified by the given fully qualified annotation name.
 @param annotationName the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName;

/**
 Retrieves the annotation value of the entity set specified by the given annotation namespace and localname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;

@end
