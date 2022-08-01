//
//  SODataMetaNavigationProperty.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaAnnotable.h"

/**
 Metadata of an OData Navigation Property (edm:NavigationProperty). A navigation property allows navigation from an entity to related entities.
 */
@protocol SODataMetaNavigationProperty <SODataMetaAnnotable, NSObject>

/**
 Retrieves the name of the navigation property.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Retrieves the fully qualified entity type name of the navigation property end point.
 */
@property (readonly, nonatomic, copy) NSString* targetEntityType;

/**
 Retrieves whether the navigation property points to an entity set or entity.
 */
@property (readonly, nonatomic, assign) BOOL isEntitySet;

@end
