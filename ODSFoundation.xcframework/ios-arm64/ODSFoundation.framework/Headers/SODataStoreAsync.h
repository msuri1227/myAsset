//
//  SODataStoreAsync.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

@protocol SODataRequestExecution;
@protocol SODataRequestParam;
@protocol SODataRequestDelegate;
@protocol SODataDownloadMediaDelegate;
@protocol SODataEntity;
@protocol SODataStore;
@protocol SODataDownloadMediaExecution;

/**
 The asynchronous API of the ODataStore
 */
@protocol SODataStoreAsync <SODataStore>

#pragma mark - Delegate based APIs
/**
 * Schedule a request for execution
 * @param request the request for execution
 * @param delegate the delegate, which should be called back
 */
- (id<SODataRequestExecution>) scheduleRequest:(id<SODataRequestParam>)request delegate:(id<SODataRequestDelegate>)delegate;

/**
 * Schedule a media request for execution
 * @param url the url to send the media reuqest to /sa SODataEntity mediaLink
 * @param delegate the delegate, which should be called back /sa SODataDownloadMediaDelegate
 */
- (id<SODataDownloadMediaExecution>) scheduleMediaDownload:(NSURL*)url delegate:(id<SODataDownloadMediaDelegate>)delegate;


/**
 * Scheduling method for reading an Entity set.
 * @param resourcePath the resource path
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadEntitySet:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a query for execution
 * @param resourcePath the resource path
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadEntityWithResourcePath:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a query for execution
 * @param entity the entity to read
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadEntity:(id<SODataEntity>)entity delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule an insert for execution
 * @param entity the entity to create
 * @param collectionPath the collection path
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleCreateEntity:(id<SODataEntity>)entity collectionPath:(NSString*)collectionPath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule an update for execution
 * @param entity the entity to update
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleUpdateEntity:(id<SODataEntity>)entity delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a patch for execution
 * @param entity the entity to patch
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) schedulePatchEntity:(id<SODataEntity>)entity delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a delete for execution
 * @param entity the entity to delete
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleDeleteEntity:(id<SODataEntity>)entity delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a delete for execution
 * @param resourcePath the resourcePath of the entity to delete
 * @param etag ETag of the entity
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleDeleteEntity:(NSString*)resourcePath etag:(NSString*)etag delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a read for a list of links
 * @param resourcePath the path of the resource
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadLinkSet:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a read for a list of links
 * @param resourcePath the path of the resource
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadLink:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a read for a simple property
 * @param resourcePath the path of the resource
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadPropertyPrimitive:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a read for a complex property
 * @param resourcePath the path of the resource
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadPropertyComplex:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a read for a raw property
 * @param resourcePath the path of the resource
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleReadPropertyRaw:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;

/**
 * Schedule a FunctionImport
 * Supported return types are Entiy or EntitySet. Please check the metadata because e.g. Complex Type is an unsupported return type.
 * @param resourcePath the path of the resource with FunctionImport
 * @param delegate the delegate, which should be called back
 * @param options additional paramaters dictionary
 */
- (id<SODataRequestExecution>) scheduleFunction:(NSString*)resourcePath delegate:(id<SODataRequestDelegate>)delegate options:(NSDictionary*)options;


@optional
#pragma mark - Block based APIs
// ------------------------------------------------------------------
// Completion-block based API alternatives, provided for convenience
// Completion blocks provide a more straightforward and succint syntax
// ------------------------------------------------------------------

/**
 * Schedule a request for execution
 * @param request the request for execution
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleRequest:(id<SODataRequestParam>)request
                                    completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Scheduling method for reading an Entity set.
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadEntitySet:(NSString*)resourcePath
                                             options:(NSDictionary*)options
                                          completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a query for execution
 * @param resourcePath the resource path
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadEntityWithResourcePath:(NSString*)resourcePath
                                                          options:(NSDictionary*)options
                                                       completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a query for execution
 * @param entity the entity to read
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadEntity:(id<SODataEntity>)entity
                                          options:(NSDictionary*)options
                                       completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule an insert for execution
 * @param entity the entity to create
 * @param collectionPath the collection path
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleCreateEntity:(id<SODataEntity>)entity
                                     collectionPath:(NSString*)collectionPath
                                            options:(NSDictionary*)options
                                         completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule an update for execution
 * @param entity the entity to update
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleUpdateEntity:(id<SODataEntity>)entity
                                            options:(NSDictionary*)options completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a patch for execution
 * @param entity the entity to patch
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) schedulePatchEntity:(id<SODataEntity>)entity
                                           options:(NSDictionary*)options
                                        completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a delete for execution
 * @param entity the entity to delete
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleDeleteEntity:(id<SODataEntity>)entity
                                            options:(NSDictionary*)options
                                         completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a delete for execution
 * @param resourcePath the resourcePath of the entity to delete
 * @param etag ETag of the entity
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleDeleteEntity:(NSString*)resourcePath
                                               etag:(NSString*)etag options:(NSDictionary*)options
                                         completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a read for a list of links
 * @param resourcePath the path of the resource
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadLinkSet:(NSString*)resourcePath
                                           options:(NSDictionary*)options
                                        completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a read for a list of links
 * @param resourcePath the path of the resource
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadLink:(NSString*)resourcePath
                                        options:(NSDictionary*)options
                                     completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a read for a simple property
 * @param resourcePath the path of the resource
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadPropertyPrimitive:(NSString*)resourcePath
                                                     options:(NSDictionary*)options
                                                  completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a read for a complex property
 * @param resourcePath the path of the resource
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadPropertyComplex:(NSString*)resourcePath
                                                   options:(NSDictionary*)options
                                                completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a read for a raw property
 * @param resourcePath the path of the resource
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleReadPropertyRaw:(NSString*)resourcePath
                                               options:(NSDictionary*)options
                                            completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

/**
 * Schedule a FunctionImport
 * Supported return types are Entiy or EntitySet. Please check the metadata because e.g. Complex Type is an unsupported return type. 
 * @param resourcePath the path of the resource with FunctionImport
 * @param options additional paramaters dictionary
 * @param completionBlock block called once execution completes
 */
- (id<SODataRequestExecution>) scheduleFunction:(NSString*)resourcePath
                                        options:(NSDictionary*)options
                                     completion:(void (^)(id<SODataRequestExecution> requestExecution, NSError *error))completionBlock;

@end
