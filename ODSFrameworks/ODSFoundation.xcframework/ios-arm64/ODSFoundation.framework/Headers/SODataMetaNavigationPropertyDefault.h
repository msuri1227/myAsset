//
//  SODataMetaNavigationPropertyDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaNavigationProperty.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of a navigation property
 */
@interface SODataMetaNavigationPropertyDefault : SODataMetaAnnotableDefault <SODataMetaNavigationProperty>

/**
 * Custom initializer
 * @param name name of the navigatin property
 * @param targetEntityType type of the targer entity
 * @param isEntitySet indicates whether the taget is entity set or entity
 */
-(instancetype) initWithName:(NSString*)name targetEntityType:(NSString*)targetEntityType isEntitySet:(BOOL)isEntitySet;

/**
 * Custom initializer
 * @param name name of the navigatin property
 * @param targetEntityType type of the targer entity
 * @param isEntitySet indicates whether the taget is entity set or entity
 * @param vocabularyAnnotations the V4 annotations of the navigation property
 */
-(id) initWithName:(NSString*)name targetEntityType:(NSString*)targetEntityType isEntitySet:(BOOL)isEntitySet vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;

@end
