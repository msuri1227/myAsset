//
//  SODataMetaEntitySetDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaEntitySet.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of an entity set
 */
@interface SODataMetaEntitySetDefault : SODataMetaAnnotableDefault <SODataMetaEntitySet>

/**
 * Custom initializer
 * @param name name of the metaentity set
 * @param entityType type of the metaentity set
 * @param annotations the annotations of the metaentity set
 */
- (instancetype) initWithName:(NSString*)name entityType:(NSString*)entityType annotations:(NSDictionary*)annotations;

/**
 * Custom initializer
 * @param name name of the metaentity set
 * @param entityType type of the metaentity set
 * @param annotations the annotations of the metaentity set
 * @param vocabularyAnnotations the V4 annotations of the metaentity set
 */
- (id) initWithName:(NSString*)name entityType:(NSString*)entityType annotations:(NSDictionary*)annotations vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;


@end
