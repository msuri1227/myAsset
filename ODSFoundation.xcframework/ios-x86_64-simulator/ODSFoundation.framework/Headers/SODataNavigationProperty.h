//
//  SODataNavigationLink.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//
#import <Foundation/Foundation.h>
/**
 The class represents an association.
 */
typedef enum SODataNavigationPropertyTypes
{
    SODataNavigationPropertyTypeEmpty,
    SODataNavigationPropertyTypeResourcePath,
    SODataNavigationPropertyTypeEntity,
    SODataNavigationPropertyTypeEntitySet
} SODataNavigationPropertyTypes;

/**
 An OData navigation property.
 */
@protocol SODataNavigationProperty <NSObject>

/**
 Context of the navigation.
 */
@property (nonatomic, strong) NSObject* navigationContent;

/**
 Indicates wether this instance contents inline navigation or not.
 */
@property (readonly, nonatomic) BOOL hasNavigationInline;

/**
 Type of the navigation. \sa SODataNavigationPropertyTypes
 */
@property (readonly, nonatomic, assign) SODataNavigationPropertyTypes navigationType;

/**
 Gets the association resource path.
 */
@property (nonatomic, copy) NSString* associationResourcePath;

@end
