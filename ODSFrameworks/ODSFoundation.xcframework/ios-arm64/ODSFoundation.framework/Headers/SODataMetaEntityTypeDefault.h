//
//  SODataMetaEntityTypeDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataMetaEntityType.h"
#import "SODataMetaAnnotableDefault.h"

/**
 Represents the metadata of an entity type
 */
@interface SODataMetaEntityTypeDefault : SODataMetaAnnotableDefault<SODataMetaEntityType>

/**
 * Custom initializer
 * @param name the name of the metaEntityType
 * @param isMediaEntity indicates whether this is media entityType or not
 * @param properties the properties of the metaEntityType
 * @param keyPropertyNames the names of the key properties
 * @param navigationProperties the navigationProperties of the metaEntityType
 * @param annotations the annotations of the metaEntityType
 */
- (instancetype) initWithName:(NSString*)name isMediaEntity:(BOOL)isMediaEntity properties:(NSDictionary*)properties keyPropertyNames:(NSArray*)keyPropertyNames navigationProperties:(NSDictionary*)navigationProperties annotations:(NSDictionary*)annotations;

/**
 * Custom initializer
 * @param name the name of the metaEntityType
 * @param isMediaEntity indicates whether this is media entityType or not
 * @param properties the properties of the metaEntityType
 * @param keyPropertyNames the names of the key properties
 * @param navigationProperties the navigationProperties of the metaEntityType
 * @param annotations the annotations of the metaEntityType
 * @param vocabularyAnnotations the V4 annotations of the metaEntityType
 */
- (id) initWithName:(NSString*)name isMediaEntity:(BOOL)isMediaEntity properties:(NSDictionary*)properties keyPropertyNames:(NSArray*)keyPropertyNames navigationProperties:(NSDictionary*)navigationProperties annotations:(NSDictionary*)annotations vocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;

@end
