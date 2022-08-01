//
//  SODataMetaPropertyDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaProperty.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of an OData property
 */
@interface SODataMetaPropertyDefault : SODataMetaAnnotableDefault<SODataMetaProperty>

/**
 * Custom initializer
 * @param name name of the property
 * @param type property type
 * @param typeName name of the property type
 * @param facets the facets of the property
 * @param annotations the annotations of the property
 * @param isKey indicates whether this is a key property or not
 */
- (instancetype) initWithName:(NSString*)name type:(SODataEDMTypes)type typeName:(NSString*)typeName facets:(NSDictionary*)facets annotations:(NSDictionary*)annotations isKey:(BOOL)isKey;

/**
 * Custom initializer
 * @param name name of the property
 * @param type property type
 * @param typeName name of the property type
 * @param facets the facets of the property
 * @param annotations the annotations of the property as NSString
 * @param vocabularyAnnotations the V4 annotations of the property
 * @param isKey indicates whether this is a key property or not
 */
- (id) initWithName:(NSString*)name type:(SODataEDMTypes)type typeName:(NSString*)typeName facets:(NSDictionary*)facets annotations:(NSDictionary*)annotations vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations isKey:(BOOL)isKey;

@end
