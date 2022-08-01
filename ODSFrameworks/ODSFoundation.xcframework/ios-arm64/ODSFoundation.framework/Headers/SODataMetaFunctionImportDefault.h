//
//  SODataMetaFunctionImportDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaFunctionImport.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of a FunctionImport
 */
@interface SODataMetaFunctionImportDefault : SODataMetaAnnotableDefault <SODataMetaFunctionImport>

/**
 * Custom initializer
 * @param name name of the function import
 * @param returnTypeName name of the return type
 * @param isReturnCollection indicates whether the result is a collection or not
 * @param returnEntitySetName name of the entity set which will be returned
 * @param callMethod type of the call method
 * @param parametersDict the function import parameters
 * @param annotationsDict annotations of the function import
 */
- (instancetype)initWithName:(NSString*)name returnTypeName:(NSString*)returnTypeName isReturnCollection:(BOOL)isReturnCollection returnEntitySetName:(NSString*)returnEntitySetName callMethod:(NSString*)callMethod parameters:(NSDictionary*)parametersDict annotations:(NSDictionary*)annotationsDict;

/**
 * Custom initializer
 * @param name name of the function import
 * @param returnTypeName name of the return type
 * @param isReturnCollection indicates whether the result is a collection or not
 * @param returnEntitySetName name of the entity set which will be returned
 * @param callMethod type of the call method
 * @param parametersDict the function import parameters
 * @param annotationsDict annotations of the function import
 * @param vocabularyAnnotations the V4 annotations of the function import
 */
- (id)initWithName:(NSString*)name returnTypeName:(NSString*)returnTypeName isReturnCollection:(BOOL)isReturnCollection returnEntitySetName:(NSString*)returnEntitySetName callMethod:(NSString*)callMethod parameters:(NSDictionary*)parametersDict annotations:(NSDictionary*)annotationsDict vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;


@end
