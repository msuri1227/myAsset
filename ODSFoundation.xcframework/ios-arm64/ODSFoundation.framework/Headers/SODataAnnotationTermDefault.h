//
//  SODataAnnotationTermDefault.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import "SODataAnnotationTerm.h"
#import "SODataMetaProperty.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of an OData property
 */
@interface SODataAnnotationTermDefault : SODataMetaAnnotableDefault <SODataAnnotationTerm>

/**
 * Custom initializer
 * @param name the name of the AnnotationTerm
 * @param localName the local name of the AnnotationTerm
 * @param qualifiedName the fully qualified name of the AnnotationTerm
 * @param type the type of the related Annotation \sa SODataEDMTypes
 * @param typeName the type name of the AnnotationTerm
 * @param facets the facets of the AnnotationTerm
 * @param baseTerm the base term of the AnnotationTerm
 * @param defaultValue the default value of the AnnotationTerm
 * @param appliesTo the items of the AnnotationTerm to apply to
 * @param vocabularyAnnotations the V4 annotations of the AnnotationTerm
 */
- (id) initWithName:(NSString*)name localName:(NSString*)localName qualifiedName:(NSString*)qualifiedName type:(SODataEDMTypes)type typeName:(NSString*)typeName facets:(NSDictionary*)facets baseTerm:(id<SODataAnnotationTerm>)baseTerm defaultValue:(NSObject*)defaultValue appliesTo:(NSMutableArray*)appliesTo vocabularyAnnotations:(NSDictionary *)vocabularyAnnotations;

@end
