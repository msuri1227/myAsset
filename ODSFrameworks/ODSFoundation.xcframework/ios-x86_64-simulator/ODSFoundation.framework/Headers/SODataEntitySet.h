//
//  SODataEntitySet.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

/**
 Payload type representing an OData feed. Contains all the properties of the feed itself as well as the accessors for the contained entities.
 */
@protocol SODataEntitySet <SODataPayload>


/**
 * Returns the total number of entities in this feed.
 */
@property (readonly, nonatomic, strong) NSNumber* count;

/**
 * Returns the list of entities in this entity set.
 */
@property (nonatomic, strong) NSMutableArray* entities;

/**
 * Retrieves the set of the deleted entities in the entity set. It can be provided by a service in case of delta queries.
 */
@property (nonatomic, strong) NSMutableArray* deletedEntities;

/**
 * Returns the resource path of the collection the corresponding feed was taken from.
 */
@property (nonatomic, copy) NSString* resourcePath;

/**
 * Get the next resourcePath of ODataEntity. Used for partial listing of the Collection of Entities.
 */
@property (nonatomic, copy) NSString* nextResourcePath;

/**
 * Returns the delta path for the entity set if exist.
 */
@property (nonatomic, copy) NSString* deltaPath;

@end
