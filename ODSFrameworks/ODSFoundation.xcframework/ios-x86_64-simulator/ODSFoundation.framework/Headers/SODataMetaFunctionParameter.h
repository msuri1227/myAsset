//
//  SODataMetaFunctionParameter.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaAnnotable.h"

/**
 A value of In, Out, or InOut MAY be provided to the function parameter. These values correspond to the modality of parameters passed to stored procedures in relational databases.
 */
typedef enum SODataParameterModes{
    SODataParameterModeIN,
    SODataParameterModeOUT,
    SODataParameterModeINOUT
} SODataParameterModes;

@protocol SODataAnnotationName;

/**
 Metadata of an OData Function Parameter (edm:Parameter) allows one or more parameters to be passed to the function. This enables the function to return a dynamic set of instances.
 For example, the top-selling products by year. In this case the year must be specified as a parameter to the function with the edm:Parameter element.
 */
@protocol SODataMetaFunctionParameter <SODataMetaAnnotable, NSObject>

/**
 Retrieves the name of the function parameter.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Retrieves the set of existing facet's names in the parameter.
 */
@property (readonly, nonatomic, strong) NSArray* facetNames;

/**
 Retrieves the set of annotation names of the parameter.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Retrieves the type name of the parameter.
 */
@property (readonly, nonatomic, copy) NSString* typeName;

/**
 Retrieves whether the parameter is collection.
 */
@property (readonly, nonatomic, assign) BOOL isCollection;

/**
 Retrieves the parameter mode.
 */
@property (readonly, nonatomic, assign) SODataParameterModes mode;

/**
 Retrieves facet value of the parameter specified by the given facet name.
 @param name the name of the facet
 @return NSString
 */
- (NSString*)facetForName:(NSString*)name;

/**
 Retrieves one annotation value specified by the given fully qualified annotation name.
 @param name the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)name;

/**
 Retrieves annotation value of the parameter specified by the given annotation namespace and annotation localname.
 @param aNamespace the namespace of the annotation
 @param name the name of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;

@end
