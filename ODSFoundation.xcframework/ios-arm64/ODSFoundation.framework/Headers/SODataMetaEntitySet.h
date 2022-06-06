//
//  SODataMetaEntitySet.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaAnnotable.h"

@protocol SODataAnnotationName;
@protocol SODataAnnotation;

/**
 Metadata (edm:EntitySet) element is a nominal type that represents an entity set in an entity model.
 An entity set contains entity types specified by the edm:EntityType attribute.
 */
@protocol SODataMetaEntitySet <SODataMetaAnnotable, NSObject>

/**
 Retrieves the name of the entity set.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Retrieves the fully qualified entity type name which this set contains.
 */
@property (readonly, nonatomic, copy) NSString* entityType;

/**
 Retrieves the annotation names of the entity set.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Retrieves the annotation value of the entity set specified by the given fully qualified annotation name.
 @param annotationName the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName;

/**
 Retrieves the annotation value of the entity set with the given annotation namespace and localname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;


@end
