//
//  SSODataMetaProperty.h
//  SODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaAnnotable.h"

@protocol SODataAnnotationName;
@protocol SODataAnnotation;

/**
 Entity Data Model elementary types.
 */
typedef enum SODataEDMTypes {
    SODataEDMTypeNull,
    SODataEDMTypeBinary,
    SODataEDMTypeBoolean,
    SODataEDMTypeSByte,
    SODataEDMTypeByte,
    SODataEDMTypeInt16,
    SODataEDMTypeInt32,
    SODataEDMTypeInt64,
    SODataEDMTypeSingle,
    SODataEDMTypeDouble,
    SODataEDMTypeDecimal,
    SODataEDMTypeString,
    SODataEDMTypeGuid,
    SODataEDMTypeDateTime,
    SODataEDMTypeTime,
    SODataEDMTypeDateTimeOffset,
    SODataEDMTypeComplex
} SODataEDMTypes;

/**
 Metadata of an OData Property (edm:Property). It allows the construction of structural types from a scalar value or a collection of scalar values.
 */
@protocol SODataMetaProperty <SODataMetaAnnotable, NSObject>

/**
 Retrieves the name of the mataProperty.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Retrieves the facet names of this property.
 */
@property (readonly, nonatomic, strong) NSArray* facetNames;

/**
 Retrieves the set of annotation names of the entity set.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Indicates whether it is a key Property or not.
 */
@property (readonly, nonatomic, assign) BOOL isKey;

/**
 Type of the property. \sa SODataEDMTypes
 */
@property (readonly, nonatomic, assign) SODataEDMTypes type;

/**
 Retrieves the name of the type if the type is complex, otherwise it is nil.
 */
@property (readonly, nonatomic, copy) NSString* typeName;

/**
 Retrieves the facet value specified by the given facet name.
 @param name the name of the facet
 @return NSString
*/
- (NSString*)facetForName:(NSString*)name;

/**
 Retrieves the annotation value of the entity set specified by the given fully qualified annotation name.
 @param name the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)name;

/**
 Retrieves the annotation value of the entity set specified by the given annotation namespace and localname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;


@end
