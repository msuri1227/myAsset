//
//  SODataAnnotationTerm.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import "SODataMetaProperty.h"
#import "SODataMetaAnnotable.h"

@protocol SODataAnnotationTerm <NSObject, SODataMetaAnnotable, NSCoding>

/**
 * The name of the AnnotationTerm.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 * The local name of the AnnotationTerm.
 */
@property (readonly, nonatomic, copy) NSString* localName;

/**
 * The fully qualified name of the AnnotationTerm.
 */
@property (readonly, nonatomic, copy) NSString* qualifiedName;

/**
 Type of the realted annotation. \sa SODataEDMTypes
 */
@property (readonly, nonatomic, assign) SODataEDMTypes type;

/**
 * The name of the Annotation type.
 */
@property (readonly, nonatomic, copy) NSString* typeName;

/**
 Retrieves the set of existing facet's names in the AnnotationTerm.
 */
@property (readonly, nonatomic, strong) NSArray* facetNames;

/**
 Retrieves the set of existing facets in the AnnotationTerm.
 */
@property (readonly, nonatomic, strong) NSDictionary* facets;

/**
 The base AnnotationTerm.
 */
@property (readonly, nonatomic, strong) id<SODataAnnotationTerm> baseTerm;

/**
 The default value of the AnnotationTerm.
 */
@property (readonly, nonatomic, strong) NSObject* defaultValue;

/**
 The items the AnnotationTerm applies to.
 */
@property (readonly, nonatomic, strong) NSMutableArray* appliesTo;

@end
