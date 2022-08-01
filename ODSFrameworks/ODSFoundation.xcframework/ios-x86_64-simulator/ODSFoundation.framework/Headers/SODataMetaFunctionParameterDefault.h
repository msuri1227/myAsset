//
//  SODataMetaFunctionParameterDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaFunctionParameter.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of a parameter of a FunctionImport
 */
@interface SODataMetaFunctionParameterDefault : SODataMetaAnnotableDefault <SODataMetaFunctionParameter>

/**
 * Custom initializer
 * @param name name of the function import parameter
 * @param typeName name of the function import parameter type
 * @param isCollection indicates whether the result is a collection or not
 * @param facetsDict the facets of the function import parameter
 * @param annotationsDict annotations of the function import parameter
 * @param mode mode of the function import parameter
 */
- (instancetype) initWithName:(NSString*)name typeName:(NSString*)typeName isCollection:(BOOL)isCollection facets:(NSDictionary*)facetsDict annotations:(NSDictionary*)annotationsDict mode:(SODataParameterModes)mode;

/**
 * Custom initializer
 * @param name name of the function import parameter
 * @param typeName name of the function import parameter type
 * @param isCollection indicates whether the result is a collection or not
 * @param facetsDict the facets of the function import parameter
 * @param annotationsDict annotations of the function import parameter
 * @param mode mode of the function import parameter
 * @param vocabularyAnnotations the V4 annotations of the function import parameter 
 */
- (id) initWithName:(NSString*)name typeName:(NSString*)typeName isCollection:(BOOL)isCollection facets:(NSDictionary*)facetsDict annotations:(NSDictionary*)annotationsDict mode:(SODataParameterModes)mode vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;


@end
