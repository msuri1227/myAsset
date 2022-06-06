//
//  ODataStore.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataRequestParamSingle.h"

@protocol SODataEntity;
@protocol SODataMetadata;

/**
 Enumeration for property allocation modes. It can be:
 Keys - only the key properties are allocated
 Mandatory - only the mandatory properties are allocated
 Optional- only the optional properties are allocated
 All- all properties are allocated
 */
typedef enum SODataPropModeFlags {
    SODataPropModeKeys = 0x01,
    SODataPropModeMandatory = 0x02,
    SODataPropModeOptional = 0x04,
    SODataPropModeAll = 0x08,
} SODataPropModeFlags;


/**
 Represents an OData Store which is the abstraction for any service endpoint that can be interacted with via the OData protocol. The different implementations use different strategies for handling OData-
 related operations. Some might be purely online (that is, served by a remote server over some protocol such as HTTP). Some might have a local cache backing a remote store. The idea is that the 
 application running locally can execute OData-like queries against the store, and the store determines how to fulfill the request. Due to the various possible ways of how a store can be built the actual 
 methods implementing OData operations are not defined by this interface.
 
 Store Types
 It is possible to have a variety of store types:
 
 Pure 'online' store. Here all data is always queried remotely. Data returned from queries is always 'reference' data (see below). If a client asks for 'locally modified entries' this would return an 
 error (or maybe just an empty set)
 Document-cache store which is backed by some remote storage. The local store is defined with a suitable OData query that clearly defines the extent of the entity set. Queries against the store must 
 always use this query - otherwise an error is returned. Updates can be executed against the store and these create locally modified entries which then can be merged into the reference copies. Update 
 requests are added to the request queue. Each request results in a new locally modified entry. Locally modified entries are only removed when the store is refreshed.
 RDB-style store. Again there is a remote backing store. The DB is created through some initialization process. Queries are flexible and always fulfilled locally - but results are merged with locally 
 modified entries, if they are present. Update requests are added top the request queue and locally modified entries get added to the store. Locally modified entries remain until the store is 
 resynchronized.
 Pure local store. Here the data is always retrieved from the local store. Updates are immediately executed against the store. The request queue will always be empty. There will never be locally modified 
 entries.
 
 Technical Cache:
 The technical cache is an enhancement of the Harmonized OData API to optimize the server communication for online stores. The cached responses of previous OData requests enable the library to perform 
 conditional request – either by HTTP or OData provided mechanism – to optimize the bandwidth utilization. The library should only perform this conditional request if the feature is enabled on the server. 
 Additionally an application can use the provided cache content to improve the user experience. It is in the responsibility of the application developer to use this feature and add the necessary 
 implementation. From the library perspective it should make no difference if the callbacks are used or skipped by the application.
 Technical cache is an optional feature and some store implementation (e.g. offline store) may not implement it.
 */
@protocol SODataStore <NSObject>

/**
 Allocates properties of OData Entity.
 @param entity the entity
 @param mode the mode for the property (it can be more mode with binary OR)
 \sa SODataPropModes
 @param error the error
 */
- (id<SODataEntity>)allocatePropertiesOfEntity:(id<SODataEntity>)entity mode:(uint16_t)mode error:(NSError**)error;

/**
 Retrieves the Metadata describing the OData service.
 */
@property (readonly, nonatomic, strong) NSObject<SODataMetadata>* metadata;

/**
 ** According to the given resource path and HTTP method mode it determines the target object (Entity, EntitySet, Link, Property etc.) based on the metadata.
 @param resourcePath The resourcePath of the Odata object
 @param mode The mode (GET, UPDATE, etc.)
 @param error Any returned error
 @return The type (as an enumeration)
 **/
- (SODataTypes) determineODataTypeFromResourcePath:(NSString *)resourcePath mode:(SODataRequestModes)mode error:(NSError **)error;

/**
 ** According to the given resource path it determines the target entity type based on the metadata.
 @param resourcePath The resourcePath of the Odata object
 @param error Any returned error
 @return The entity type as a string (that can be passed to metaEntityForName)
 **/
- (NSString *) determineEntityTypeFromResourcePath:(NSString *)resourcePath error:(NSError **)error;

/**
 ** According to the given resource path it determines the target entity set (collection, feed) name based on the metadata.
 @param resourcePath The resourcePath of the Odata object
 @param error Any returned error
 @return The entity set name as a string
 **/
- (NSString *) determineEntitySetFromResourcePath:(NSString *)resourcePath error:(NSError **)error;

/**
 Allocates navigation properties of the entity.
 
 @note Entity should be a valid SODataEntity. At least the key properties needs to be allocated and initialized properly.

 Sample code:
 <br>
 <pre>
	SODataEntityDefault* entity = [[SODataEntityDefault alloc] initWithEntityID:@"id" type:@"entity.type"];
 	NSError* error = nil;
	[oDataStore allocatePropertiesOfEntity:entity mode:SODataPropModeAll error:&error];
	if (error) { // error processing }
	[[[entity properties] propertyForName:key] setValue:[propKeyValues objectForKey:key]]; // set property values of the entity
	error = nil;
	id<SODataEntity> entityOut = [oDataStore allocateNavigationProperties:entity error:&error];
	if (error) { // error processing }
 </pre>
 @see allocatePropertiesOfEntity
 @param entity the entity
 @param error the error
 */
- (id<SODataEntity>)allocateNavigationProperties:(id<SODataEntity>)entity error:(NSError**)error;


@end
