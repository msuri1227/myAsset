//
//  SODataMetaFunctionImport.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaProperty.h"

@protocol SODataMetaFunctionParameter;

/**
 The OData Function Import (edm:FunctionImport) is a nominal type that represents a Function or Action in an entity model. Functions MUST NOT have observable side-effects and MUST return a single or
 collection of primitive types or nominal structured types. Functions MAY be composable.
 Actions MAY have side-effects and MAY return a single or collection of primitive types or nominal structured types. Actions are not composable.
 The function import MAY specify a return type using the edm:ReturnType element. The return type must be a scalar, entity or complex type, or a collection of scalar, entity or complex types.
 The function import may also define zero or more function parameter (edm:Parameter) elements to be used during the execution of the function.
 */
@protocol SODataMetaFunctionImport <SODataMetaAnnotable, NSObject>

/**
 Name of the FunctionImport.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Retrieves the HTTP method name (GET, POST, ...).
 */
@property (readonly, nonatomic, copy) NSString* callMethod;

/**
 Retrieves the return type name (part of edm:ReturnType attribute).
 */
@property (readonly, nonatomic, copy) NSString* returnTypeName;

/**
 Retrieves the entity set name of the return type.
 */
@property (readonly, nonatomic, copy) NSString* returnEntitySetName;

/**
 Return YES if it points to an EntitySet
 */
@property (readonly, nonatomic, assign) BOOL isEntitySet;

/**
 Checks if the return type is collection.
 */
@property (readonly, nonatomic, assign) BOOL isReturnCollection;

/**
 Retrieves the set of parameter names of the function import.
 */
@property (readonly, nonatomic, strong) NSArray* parameterNames;

/**
 Retrieves the function parameter specified by the given name.
 @param parameterName name of the parameter
 @return SODataMetaFunctionParameter
 */
- (id<SODataMetaFunctionParameter>) parameterForName:(NSString*)parameterName;

/**
 Retrieves the set of annotation names of the entity set.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Retrieves the annotation value of the function import specified by the given fully qualified annotation name.
 @param annotationName the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName;

/**
 Retrieves the annotation value of the function import specified by the given annotation namespace and localname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;

@end
