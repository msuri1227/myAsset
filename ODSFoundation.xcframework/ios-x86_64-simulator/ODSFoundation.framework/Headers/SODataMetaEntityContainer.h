//
//  SODataMetaEntityContainer.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaEntitySet.h"
#import "SODataMetaFunctionImport.h"
#import "SODataMetaAnnotable.h"

/**
 Represents the metadata of an entity container (edm:EntityContainer).
 The edm:EntityContainer element represents an entity container in an entity model. It corresponds to a logical data store and contains zero or more entity sets (edm:EntitySet) or function imports 
 (edm:FunctionImport) elements.
 */
@protocol SODataMetaEntityContainer <SODataMetaAnnotable, NSObject>

/**
 Retrieves the set of function import names.
 */
@property (readonly, nonatomic, strong) NSArray* functionImportNames;

/**
 Retrieves the metadata representation of function import specified by the given name.
 @param name the name of the functionImport
 @return SODataMetaFunctionImport
 */
- (id<SODataMetaFunctionImport>) functionImportForName:(NSString*)name;

/**
 Retrieves the names of the entity sets.
 */
@property (readonly, nonatomic, strong) NSArray* entitySetNames;

/**
 Retrieves the entity set specified by the given name.
 @param name the name of the metaEntitySet
 @return SODataMetaEntitySet
 */
-(id<SODataMetaEntitySet>)metaEntitySetForName:(NSString*)name;

/**
 Retrieves the set of annotation names belonging to the entity container.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Used to retrieve the annotation by name.
 @param annotationName the namespace and the name of the annotation E.g.: "m:name" if you use the "m" namespace and "name" as annotation name
 @deprecated Use instead -(NSString *)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName_in; method
 @return NSString
 */
- (NSString*)annotation:(NSString*)annotationName DEPRECATED_ATTRIBUTE;

/**
 Retrieves the annotation value specified by the given annotation name.
 @param annotationName_in the name of the annotation
 @see SODataAnnotationName
 @return NSString
 */
-(NSString *)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName_in;

/**
 Retrieves the annotation value specified by the given annotation namespace and loccalname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;

@end
