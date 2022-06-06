//
//  SODataStoreSync.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

@protocol SODataStore;
@protocol SODataPayload;
@protocol SODataRequestParam;
@protocol SODataEntity;
@protocol SODataEntitySet;
@protocol SODataResponse;
@protocol SODataResponseSingle;

/**
 Synchronous API of the ODataStore
 */
@protocol SODataStoreSync <SODataStore>

/**
 * Execute a request
 * @param request the request for execution
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponse>) executeRequest:(id<SODataRequestParam>)request error:(NSError**)error;

/**
 * Execute a query
 * @param entity the entity
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadEntity:(id<SODataEntity>)entity options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadEntityWithResourcePath:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadEntitySet:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param entity the entity
 * @param collectionPath the collectionPath
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeCreateEntity:(id<SODataEntity>)entity collectionPath:(NSString*)collectionPath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param entity the entity
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeUpdateEntity:(id<SODataEntity>)entity options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param entity the entity
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executePatchEntity:(id<SODataEntity>)entity options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param entity the entity
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeDeleteEntity:(id<SODataEntity>)entity options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resourcePath of the entity to delete
 * @param etag ETag of the entity
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeDeleteEntity:(NSString*)resourcePath etag:(NSString*)etag options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadPropertyPrimitive:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadPropertyComplex:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadPropertyRaw:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadLinkSet:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeReadLink:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a query
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param error the error object passed back in case of an error
 */
- (id<SODataResponseSingle>) executeFunction:(NSString*)resourcePath options:(NSDictionary*)options error:(NSError**)error;

/**
 * Execute a batch of request
 * @param requests the requests for execution
 * @param error the error object passed back in case of an error
 */
//- (id<SODataResponse>) executeRequestBatch:(NSArray*)requests error:(NSError**)error;

@end
