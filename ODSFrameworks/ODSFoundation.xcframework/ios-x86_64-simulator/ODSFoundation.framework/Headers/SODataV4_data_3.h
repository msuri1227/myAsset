//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_DATA_3_H
#define SODATAV4_DATA_3_H


@protocol SODataV4_DataServiceProvider;
@class SODataV4_ChangeSet;
@class SODataV4_DataService;
@class SODataV4_DataSession; /* internal */
@class SODataV4_DataSession_RequestInfo; /* internal */
@class SODataV4_DataSession_SessionInfo; /* internal */
@class SODataV4_JsonEntityProvider;
@class SODataV4_MetadataOnlyProvider;
@class SODataV4_NetworkOptions;
@class SODataV4_OnlineODataProvider;
@class SODataV4_PathResolver;
@class SODataV4_ProviderInternal;
@class SODataV4_ProxyInternal;
@class SODataV4_RequestBatch;
@class SODataV4_ServiceOptions;
@class SODataV4_SystemTables; /* internal */
@class SODataV4_ToJSON;
@class SODataV4_AtomContext; /* internal */
@class SODataV4_CloseRequest; /* internal */
@class SODataV4_FromJSON;
@class SODataV4_GetMetadata; /* internal */
@class SODataV4_JsonContext; /* internal */
@class SODataV4_SharedSession; /* internal */
@class SODataV4_GetByteStream; /* internal */
@class SODataV4_GetCharStream; /* internal */
@class SODataV4_Any_as_data_ChangeSet_in_data; /* internal */
@class SODataV4_Any_as_data_DataQuery_in_data; /* internal */
@class SODataV4_Any_as_data_DeltaStream_in_data; /* internal */
@class SODataV4_Any_as_data_RequestOptions_in_data; /* internal */
@class SODataV4_Any_as_http_HttpHeaders_in_data; /* internal */
@class SODataV4_List_count_EntityValueList_in_data; /* internal */
@class SODataV4_List_filter_EntityValueList_in_data; /* internal */
@class SODataV4_List_filter_PropertyList_in_data; /* internal */

#ifndef imported_SODataV4__DataServiceProvider_public
#define imported_SODataV4__DataServiceProvider_public
/// @brief A provider interface for data services.
///
/// Where applicable, client applications should use the `SODataV4_DataService` wrapper to invoke provider functions.
@protocol SODataV4_DataServiceProvider
- (nonnull id) init;
/// @brief Create an entity in the target system.
///
/// Automatically calls `SODataV4_CsdlDocument`.`resolveEntity` to ensure that `SODataV4_EntityValue`.`entitySet` is available.
///
/// @throw `SODataV4_DataServiceException` if the entity set hasn't been explicitly provided before calling `createEntity` and there isn't a unique entity set for the entity type.
/// @param entity Entity to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_EntityValue`.`ofType`, `SODataV4_EntityValue`.`inSet`.
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be created.
/// @param property Source navigation property for the link to be created.
/// @param to Target entity for the link to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a media entity with the specified content in the target system.
///
/// If the `entity` has non-stream structural properties in addition to the key properties and media content, such as `label` in the examples below,
/// then this function will send two requests to the server: a first request to upload (POST) the media stream,
/// and a second request (PATCH/PUT) to update the non-stream properties. It is not currently supported to make these two calls *atomic*.
/// *Caution*: Having too many threads simultaneously creating streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity to be created.
/// @param content Initial content. Must be a `SODataV4_ByteStream` or `SODataV4_CharStream`. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute query to delete data from the target system.
///
///
/// @param query Data query specifying the information to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete an entity from the target system.
///
///
/// @param entity Entity to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be deleted.
/// @param property Source navigation property for the link to be deleted.
/// @param to Target entity for the link to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete the content of a stream property from the target system.
///
///
/// @param entity Entity containing the stream property whose content is to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @param link Stream link for the stream to be deleted.
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a media entity from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a media entity. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity whose content is to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a stream property from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a stream property. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity containing the stream property whose content is to be downloaded.
/// @param link Stream link for the stream to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data method (action or function) in the target system.
///
/// Actions may have backend side-effects.
/// Functions should not have backend side-effects.
///
/// @return The method result, or `nil` if the method has no result.
/// @throw `SODataV4_DataServiceException` or `SODataV4_DataNetworkException` if an error occurs during action invocation.
/// @param method Data method.
/// @param parameters Method parameters.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data query to get data from the target system.
///
///
/// @return The query result.
/// @param query Data query specifying the information to be returned.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_DataServiceProvider`.`loadMetadata`.
- (SODataV4_boolean) hasMetadata;
/// @brief Load service metadata (if not already loaded).
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_DataServiceProvider`.`metadata`, `SODataV4_DataServiceProvider`.`hasMetadata`.
- (void) loadMetadata :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service metadata.
///
///
/// @see `SODataV4_DataServiceProvider`.`loadMetadata`.
- (nonnull SODataV4_CsdlDocument*) metadata;
/// @brief Ping the server.
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) pingServer :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a request batch in the target system.
///
///
/// @param batch The request batch.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service name.
///
///
- (nonnull NSString*) serviceName;
/// @brief Service metadata.
///
///
/// @see `SODataV4_DataServiceProvider`.`loadMetadata`.
- (void) setMetadata :(nonnull SODataV4_CsdlDocument*)value;
/// @brief Unload service metadata (if previously loaded).
///
///
/// @see `SODataV4_DataServiceProvider`.`metadata`, `SODataV4_DataServiceProvider`.`hasMetadata`.
- (void) unloadMetadata;
/// @brief Update an entity in the target system.
///
///
/// @param entity Entity to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Update a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be updated.
/// @param property Source navigation property for the link to be updated. This must be a one-to-one navigation property.
/// @param to Target entity for the link to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a media entity to the target system
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
/// Note: this function cannot be used to create a media entity. See `SODataV4_DataService`.`createMedia`.
///
/// @param entity Entity whose content is to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a stream property to the target system.
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity containing the stream property whose content is to be uploaded.
/// @param link Stream link for the stream to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_DataServiceProvider`.`loadMetadata`.
@property (nonatomic, readonly) SODataV4_boolean hasMetadata;
/// @brief Service metadata.
///
///
/// @see `SODataV4_DataServiceProvider`.`loadMetadata`.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* metadata;
/// @brief Service name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* serviceName;
@end
#endif

#ifndef imported_SODataV4__ChangeSet_public
#define imported_SODataV4__ChangeSet_public
/// @brief Encapsulates an [OData](http://odata.org) change set.
///
/// A change set is used to group a set of entity or link changes into a single
/// unit of work, like an atomic database transaction.
///
/// @see `SODataV4_DataService`, `SODataV4_RequestBatch`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) applyChangesExample
/// {
///     NorthwindService* service = self.service;
///     Supplier__List* suppliers = [service getSuppliers:[[SODataV4_DataQuery new] top:2]];
///     Product__List* products = [service getProducts:[[SODataV4_DataQuery new] top:3]];
///     Product* product1 = [[products get:0] copy];
///     Product* product2 = [[products get:1] copy];
///     Product* product3 = [[products get:2] copy];
///     product1.productName = @"Blueberry Muffins";
///     product2.productName = @"Strawberry Yoghurt";
///     product3.productName = @"Raspberry Pie";
///     SODataV4_ChangeSet* entityCreates = [SODataV4_ChangeSet new];
///     [entityCreates createEntity:product1];
///     [entityCreates createEntity:product2];
///     [entityCreates createEntity:product3];
///     [service applyChanges:entityCreates];
///     SODataV4_ChangeSet* entityChanges = [SODataV4_ChangeSet new];
///     product2.productName = @"Blackberry Yoghurt";
///     [entityChanges updateEntity:product2];
///     [entityChanges deleteEntity:product3];
///     [service applyChanges:entityChanges];
///     SODataV4_ChangeSet* linkChanges = [SODataV4_ChangeSet new];
///     Supplier* supplier1 = [suppliers get:0];
///     Supplier* supplier2 = [suppliers get:1];
///     [linkChanges createLink:product1:Product.supplier:supplier1];
///     [linkChanges updateLink:product1:Product.supplier:supplier2];
///     [linkChanges deleteLink:product1:Product.supplier];
///     [service applyChanges:linkChanges];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) applyChangesExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* suppliersEntitySet = [service getEntitySet:@"Suppliers"];
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* productEntityType = productsEntitySet.entityType;
///     SODataV4_Property* productNameProperty = [productEntityType getProperty:@"ProductName"];
///     SODataV4_Property* supplierProperty = [productEntityType getProperty:@"Supplier"];
///     SODataV4_EntityValueList* suppliers = [[service executeQuery:[[[SODataV4_DataQuery new] from:suppliersEntitySet] top:2]] getEntityList];
///     SODataV4_EntityValueList* products = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:3]] getEntityList];
///     SODataV4_EntityValue* product1 = [[products get:0] copyEntity];
///     SODataV4_EntityValue* product2 = [[products get:1] copyEntity];
///     SODataV4_EntityValue* product3 = [[products get:1] copyEntity];
///     [productNameProperty setString:product1:@"Blueberry Yoghurt"];
///     [productNameProperty setString:product2:@"Strawberry Yoghurt"];
///     [productNameProperty setString:product3:@"Raspberry Pie"];
///     SODataV4_ChangeSet* entityCreates = [SODataV4_ChangeSet new];
///     [entityCreates createEntity:product1];
///     [entityCreates createEntity:product2];
///     [entityCreates createEntity:product3];
///     [service applyChanges:entityCreates];
///     SODataV4_ChangeSet* entityChanges = [SODataV4_ChangeSet new];
///     [productNameProperty setString:product2:@"Blackberry Yoghurt"];
///     [entityChanges updateEntity:product2];
///     [entityChanges deleteEntity:product3];
///     [service applyChanges:entityChanges];
///     SODataV4_ChangeSet* linkChanges = [SODataV4_ChangeSet new];
///     SODataV4_EntityValue* supplier1 = [suppliers get:0];
///     SODataV4_EntityValue* supplier2 = [suppliers get:1];
///     [linkChanges createLink:product1:supplierProperty:supplier1];
///     [linkChanges updateLink:product1:supplierProperty:supplier2];
///     [linkChanges deleteLink:product1:supplierProperty];
///     [service applyChanges:linkChanges];
/// }
/// ````
@interface SODataV4_ChangeSet : SODataV4_ObjectBase
{
    @private SODataV4_ObjectList* _Nonnull _changes;
    @private SODataV4_ObjectList* _Nonnull _headers;
    @private SODataV4_ObjectList* _Nonnull _options;
    @private SODataV4_AnyList* _Nonnull _actionResults;
    @private SODataV4_int _actionNumber;
    @private SODataV4_int status_;
    @private SODataV4_DataServiceException* _Nullable error_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ChangeSet*) new;
/// @internal
///
- (void) _init;
/// @brief Add a query result for action to this changeset.
///
///
/// @param query Data query for action, which must have been previously added to this changeset using `invokeAction`.
/// @param result Query result.
- (void) addActionResult :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryResult*)result;
/// @internal
///
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a pending created entity to the change set.
///
/// The entity will be created when this change set is submitted.
///
/// @param entity Entity to be created.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to;
/// @internal
///
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a pending created link to the change set.
///
/// The link will be created when this change set is submitted.
///
/// @param from Source entity for the link to be created.
/// @param property Source navigation property for the link to be created.
/// @param to Target entity for the link to be created.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createRelatedEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property;
/// @internal
///
- (void) createRelatedEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a pending created entity to the change set, related to a parent entity via a parent navigation property.
///
/// The entity will be created when this change set is submitted.
///
/// @param entity Entity to be created.
/// @param parent Previously created parent entity.
/// @param property Parent's navigation property.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createRelatedEntityInChangeSetExample
/// {
///     NorthwindService* service = self.service;
///     Customer__List* customers = [service getCustomers:[[SODataV4_DataQuery new] filter:[Customer.customerID equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))]]];
///     Order__List* orders = [service getOrders:[[SODataV4_DataQuery new] top:2]];
///     SODataV4_ChangeSet* changes = [SODataV4_ChangeSet new];
///     Customer* newCustomer = [[customers first] copy];
///     [changes createEntity:newCustomer];
///     Order* firstOrder = [[orders first] copy];
///     Order* secondOrder = [[orders last] copy];
///     [changes createRelatedEntity:firstOrder:newCustomer:Customer.orders];
///     [changes createRelatedEntity:secondOrder:newCustomer:Customer.orders];
///     [service applyChanges:changes];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createRelatedEntityInChangeSetExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntitySet* ordersEntitySet = [service getEntitySet:@"Orders"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* customerIDProperty = [customerEntityType getProperty:@"CustomerID"];
///     SODataV4_Property* ordersProperty = [customerEntityType getProperty:@"Orders"];
///     SODataV4_EntityValueList* customers = [[service executeQuery:[[[SODataV4_DataQuery new] from:customersEntitySet] filter:[customerIDProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))]]] getEntityList];
///     SODataV4_EntityValueList* orders = [[service executeQuery:[[[SODataV4_DataQuery new] from:ordersEntitySet] top:2]] getEntityList];
///     SODataV4_ChangeSet* changes = [SODataV4_ChangeSet new];
///     SODataV4_EntityValue* newCustomer = [[customers first] copyEntity];
///     [changes createEntity:newCustomer];
///     SODataV4_EntityValue* firstOrder = [[orders first] copyEntity];
///     SODataV4_EntityValue* secondOrder = [[orders last] copyEntity];
///     [changes createRelatedEntity:firstOrder:newCustomer:ordersProperty];
///     [changes createRelatedEntity:secondOrder:newCustomer:ordersProperty];
///     [service applyChanges:changes];
/// }
/// ````
- (void) createRelatedEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a pending deleted entity to the change set.
///
/// The entity will be deleted when this change set is submitted.
///
/// @param entity Entity to be deleted.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property;
/// @internal
///
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to;
/// @internal
///
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a pending deleted link to the change set.
///
/// The link will be deleted when this change set is submitted.
///
/// @param from Source entity for the link to be deleted.
/// @param property Source navigation property for the link to be deleted.
/// @param to (optional) Target entity for the link to be deleted.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Error if `status` does not represent a successful response.
///
///
- (nullable SODataV4_DataServiceException*) error;
/// @return The DataQuery for the action, if `isAction(index)` is `true`, otherwise throws `undefined`
/// @param index From zero to `size - 1`
- (nonnull SODataV4_DataQuery*) getAction :(SODataV4_int)index;
/// @return The QueryResult for the action. Throws `UsageException` if the result cannot be found for the query.
/// @param actionQuery The DataQuery containing the action call.
- (nonnull SODataV4_QueryResult*) getActionResult :(nonnull SODataV4_DataQuery*)actionQuery;
/// @return The changed entity, if `isEntity(index)` is `true`, otherwise throws `undefined`.
/// The `SODataV4_EntityValue`.`isCreated`, `SODataV4_EntityValue`.`isUpdated` and `SODataV4_EntityValue`.`isDeleted` properties can be accessed on the resulting entity value to determine the type of change.
/// @param index From zero to `size - 1`.
/// 
/// #### Example
/// 
/// ```` oc
/// - (void) showChangedEntities :(nonnull SODataV4_ChangeSet*)changes
/// {
///     SODataV4_int n = changes.size;
///     {
///         SODataV4_int i = 0;
///         for (; (i < n); i++)
///         {
///             if ([changes isEntity:i])
///             {
///                 SODataV4_EntityValue* change = [changes getEntity:i];
///                 if (change.isCreated)
///                 {
///                     [Example show:@[@"created entity"]];
///                 }
///                 else if (change.isUpdated)
///                 {
///                     [Example show:@[@"updated entity"]];
///                 }
///                 else if (change.isDeleted)
///                 {
///                     [Example show:@[@"deleted entity"]];
///                 }
///             }
///         }
///     }
/// }
/// ````
- (nonnull SODataV4_EntityValue*) getEntity :(SODataV4_int)index;
/// @return The HTTP headers for the change at `index`.
/// @param index From zero to `size - 1`.
- (nonnull SODataV4_HttpHeaders*) getHeaders :(SODataV4_int)index;
/// @return The changed link, if `isLink(index)` is `true`, otherwise throws `undefined`.
/// The `SODataV4_ChangedLink`.`isCreated`, `SODataV4_ChangedLink`.`isUpdated` and `SODataV4_ChangedLink`.`isDeleted` properties can be accessed on the resulting changed link to determine the type of change.
/// @param index From zero to `size - 1`.
/// 
/// #### Example
/// 
/// ```` oc
/// - (void) showChangedLinks :(nonnull SODataV4_ChangeSet*)changes
/// {
///     SODataV4_int n = changes.size;
///     {
///         SODataV4_int i = 0;
///         for (; (i < n); i++)
///         {
///             if ([changes isLink:i])
///             {
///                 SODataV4_ChangedLink* change = [changes getLink:i];
///                 if (change.isCreated)
///                 {
///                     [Example show:@[@"created link"]];
///                 }
///                 else if (change.isUpdated)
///                 {
///                     [Example show:@[@"updated link"]];
///                 }
///                 else if (change.isDeleted)
///                 {
///                     [Example show:@[@"deleted link"]];
///                 }
///             }
///         }
///     }
/// }
/// ````
- (nonnull SODataV4_ChangedLink*) getLink :(SODataV4_int)index;
/// @return The request options for the change at `index`.
/// @param index From zero to `size - 1`.
- (nonnull SODataV4_RequestOptions*) getOptions :(SODataV4_int)index;
/// @internal
///
- (nonnull SODataV4_DataQuery*) invokeAction :(nonnull SODataV4_DataMethod*)method;
/// @internal
///
- (nonnull SODataV4_DataQuery*) invokeAction :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters;
/// @internal
///
- (nonnull SODataV4_DataQuery*) invokeAction :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add an action to the change set. If the method is not an action throws an `undefined`.
///
///
/// @return Data query for this action invocation. After invocation, this may be passed to `SODataV4_ChangeSet`.`getActionResult`.
/// @param method Action to be called.
/// @param parameters (optional) Method parameters.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
/// @see `SODataV4_DataQuery`.`bind`, for setting the binding parameter for a bound action.
- (nonnull SODataV4_DataQuery*) invokeAction :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @return `true` if `index` is a valid change index, and the change is for an action
/// @param index From zero to `size - 1`
- (SODataV4_boolean) isAction :(SODataV4_int)index;
/// @return `true` if `index` is a valid change index, and the change is for a created, updated or deleted entity; otherwise `false`.
/// @param index From zero to `size - 1`.
- (SODataV4_boolean) isEntity :(SODataV4_int)index;
/// @return `true` if `index` is a valid change index, and the change is for a created, updated or deleted link; otherwise `false`.
/// @param index From zero to `size - 1`.
- (SODataV4_boolean) isLink :(SODataV4_int)index;
/// @internal
///
- (void) saveEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) saveEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Call `SODataV4_ChangeSet`.`createEntity`, if `entity.isNew == true`, otherwise call `SODataV4_ChangeSet`.`updateEntity`.
///
///
/// @param entity Entity to be created or updated.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) saveEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Error if `status` does not represent a successful response.
///
///
- (void) setError :(nullable SODataV4_DataServiceException*)value;
/// @brief Response status (e.g. HTTP status code 200 = OK).
///
///
- (void) setStatus :(SODataV4_int)value;
/// @brief The number of changes in this change set.
///
///
- (SODataV4_int) size;
/// @brief Response status (e.g. HTTP status code 200 = OK).
///
///
- (SODataV4_int) status;
/// @internal
///
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add an updated entity to the change set.
///
/// The entity will be updated when this change set is submitted.
///
/// @param entity Entity to be updated.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to;
/// @internal
///
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a pending updated link to the change set.
///
/// The link will be updated when this change set is submitted.
///
/// @param from Source entity for the link to be updated.
/// @param property Source navigation property for the link to be updated. This must be a one-to-one navigation property.
/// @param to Target entity for the link to be updated.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Error if `status` does not represent a successful response.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataServiceException* error;
/// @brief The number of changes in this change set.
///
///
@property (nonatomic, readonly) SODataV4_int size;
/// @brief Response status (e.g. HTTP status code 200 = OK).
///
///
@property (nonatomic, readwrite) SODataV4_int status;
@end
#endif

#ifdef import_SODataV4__ChangeSet_private
#ifndef imported_SODataV4__ChangeSet_private
#define imported_SODataV4__ChangeSet_private
@interface SODataV4_ChangeSet (private)
- (nonnull SODataV4_HttpHeaders*) headersModifiedByOptions :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
+ (nonnull SODataV4_ChangedLink*) _new1 :(SODataV4_boolean)p1 :(nonnull SODataV4_Property*)p2 :(nonnull SODataV4_EntityValue*)p3 :(nonnull SODataV4_EntityValue*)p4;
+ (nonnull SODataV4_ChangedLink*) _new2 :(SODataV4_boolean)p1 :(nonnull SODataV4_Property*)p2 :(nonnull SODataV4_EntityValue*)p3 :(nonnull SODataV4_EntityValue*)p4;
+ (nonnull SODataV4_ChangedLink*) _new3 :(nonnull SODataV4_Property*)p1 :(SODataV4_boolean)p2 :(nonnull SODataV4_EntityValue*)p3 :(nonnull SODataV4_EntityValue*)p4;
@end
#endif
#endif

#ifndef imported_SODataV4__DataService_public
#define imported_SODataV4__DataService_public
/// @brief Encapsulates an [OData](http://odata.org) data service.
///
///
/// @see `SODataV4_DataQuery`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) dataServiceExample
/// {
///     SODataV4_OnlineODataProvider* provider = [SODataV4_OnlineODataProvider new:@"NorthwindService":@"http://services.odata.org/V4/Northwind/Northwind.svc/"];
///     NorthwindService* service = [NorthwindService new:provider];
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] select:@[Customer.customerID,Customer.companyName,Customer.contactName]] orderBy:Customer.companyName];
///     Customer__List* customers = [service getCustomers:query];
///     [self showCustomers:customers];
///     Customer* customer = [[customers first] copy];
///     customer.companyName = @"Created Inc.";
///     [service createEntity:customer];
///     customer.companyName = @"Updated Inc.";
///     [service updateEntity:customer];
///     [service deleteEntity:customer];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) dataServiceExample
/// {
///     SODataV4_OnlineODataProvider* provider = [SODataV4_OnlineODataProvider new:@"NorthwindService":@"http://services.odata.org/V4/Northwind/Northwind.svc/"];
///     SODataV4_DataService* service = [SODataV4_DataService new:provider];
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* customerIDProperty = [customerEntityType getProperty:@"CustomerID"];
///     SODataV4_Property* companyNameProperty = [customerEntityType getProperty:@"CompanyName"];
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] select:@[customerIDProperty,companyNameProperty,contactNameProperty]] from:customersEntitySet] orderBy:companyNameProperty];
///     SODataV4_EntityValueList* customers = [[service executeQuery:query] getEntityList];
///     [self showCustomers:customers];
///     SODataV4_EntityValue* customer = [[customers first] copyEntity];
///     [companyNameProperty setString:customer:@"Created Inc."];
///     [service createEntity:customer];
///     [companyNameProperty setString:customer:@"Updated Inc."];
///     [service updateEntity:customer];
///     [service deleteEntity:customer];
/// }
/// ````
@interface SODataV4_DataService : SODataV4_ObjectBase
{
    @private id<SODataV4_DataServiceProvider> _Nonnull _provider_;
}
- (nonnull id) init;
/// @brief Construct a new data service using a specified provider.
///
///
/// @param provider Data service provider.
+ (nonnull SODataV4_DataService*) new :(nonnull id<SODataV4_DataServiceProvider>)provider;
/// @internal
///
- (void) _init :(nonnull id<SODataV4_DataServiceProvider>)provider;
/// @internal
///
- (void) applyChanges :(nonnull SODataV4_ChangeSet*)changes;
/// @internal
///
- (void) applyChanges :(nonnull SODataV4_ChangeSet*)changes :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Apply the changes from a change set to the target system.
///
///
/// @param changes The change set.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_DataService`.`processBatch`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) applyChangesExample
/// {
///     NorthwindService* service = self.service;
///     Supplier__List* suppliers = [service getSuppliers:[[SODataV4_DataQuery new] top:2]];
///     Product__List* products = [service getProducts:[[SODataV4_DataQuery new] top:3]];
///     Product* product1 = [[products get:0] copy];
///     Product* product2 = [[products get:1] copy];
///     Product* product3 = [[products get:2] copy];
///     product1.productName = @"Blueberry Muffins";
///     product2.productName = @"Strawberry Yoghurt";
///     product3.productName = @"Raspberry Pie";
///     SODataV4_ChangeSet* entityCreates = [SODataV4_ChangeSet new];
///     [entityCreates createEntity:product1];
///     [entityCreates createEntity:product2];
///     [entityCreates createEntity:product3];
///     [service applyChanges:entityCreates];
///     SODataV4_ChangeSet* entityChanges = [SODataV4_ChangeSet new];
///     product2.productName = @"Blackberry Yoghurt";
///     [entityChanges updateEntity:product2];
///     [entityChanges deleteEntity:product3];
///     [service applyChanges:entityChanges];
///     SODataV4_ChangeSet* linkChanges = [SODataV4_ChangeSet new];
///     Supplier* supplier1 = [suppliers get:0];
///     Supplier* supplier2 = [suppliers get:1];
///     [linkChanges createLink:product1:Product.supplier:supplier1];
///     [linkChanges updateLink:product1:Product.supplier:supplier2];
///     [linkChanges deleteLink:product1:Product.supplier];
///     [service applyChanges:linkChanges];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) applyChangesExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* suppliersEntitySet = [service getEntitySet:@"Suppliers"];
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* productEntityType = productsEntitySet.entityType;
///     SODataV4_Property* productNameProperty = [productEntityType getProperty:@"ProductName"];
///     SODataV4_Property* supplierProperty = [productEntityType getProperty:@"Supplier"];
///     SODataV4_EntityValueList* suppliers = [[service executeQuery:[[[SODataV4_DataQuery new] from:suppliersEntitySet] top:2]] getEntityList];
///     SODataV4_EntityValueList* products = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:3]] getEntityList];
///     SODataV4_EntityValue* product1 = [[products get:0] copyEntity];
///     SODataV4_EntityValue* product2 = [[products get:1] copyEntity];
///     SODataV4_EntityValue* product3 = [[products get:1] copyEntity];
///     [productNameProperty setString:product1:@"Blueberry Yoghurt"];
///     [productNameProperty setString:product2:@"Strawberry Yoghurt"];
///     [productNameProperty setString:product3:@"Raspberry Pie"];
///     SODataV4_ChangeSet* entityCreates = [SODataV4_ChangeSet new];
///     [entityCreates createEntity:product1];
///     [entityCreates createEntity:product2];
///     [entityCreates createEntity:product3];
///     [service applyChanges:entityCreates];
///     SODataV4_ChangeSet* entityChanges = [SODataV4_ChangeSet new];
///     [productNameProperty setString:product2:@"Blackberry Yoghurt"];
///     [entityChanges updateEntity:product2];
///     [entityChanges deleteEntity:product3];
///     [service applyChanges:entityChanges];
///     SODataV4_ChangeSet* linkChanges = [SODataV4_ChangeSet new];
///     SODataV4_EntityValue* supplier1 = [suppliers get:0];
///     SODataV4_EntityValue* supplier2 = [suppliers get:1];
///     [linkChanges createLink:product1:supplierProperty:supplier1];
///     [linkChanges updateLink:product1:supplierProperty:supplier2];
///     [linkChanges deleteLink:product1:supplierProperty];
///     [service applyChanges:linkChanges];
/// }
/// ````
- (void) applyChanges :(nonnull SODataV4_ChangeSet*)changes :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Create an entity in the target system.
///
/// Automatically calls `SODataV4_CsdlDocument`.`resolveEntity` to ensure that `SODataV4_EntityValue`.`entitySet` is available.
///
/// @param entity Entity to be created.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_EntityValue`.`ofType`, `SODataV4_EntityValue`.`inSet`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createEntityExample
/// {
///     NorthwindService* service = self.service;
///     Customer* customer = [Customer new];
///     customer.companyName = @"Enterprise Inc.";
///     customer.contactName = @"Jean-Luc Picard";
///     [service createEntity:customer];
/// }
/// ````
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createEntityInSetExample
/// {
///     NorthwindService* service = self.service;
///     Customer* customer = [Customer new];
///     customer.companyName = @"Voyager Inc.";
///     customer.contactName = @"Kathryn Janeway";
///     [service createEntity:[customer inSet:NorthwindServiceMetadata_EntitySets.customers]];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createEntityExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* companyNameProperty = [customerEntityType getProperty:@"CompanyName"];
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_EntityValue* customer = [SODataV4_EntityValue ofType:customerEntityType];
///     [companyNameProperty setString:customer:@"Enterprise Inc."];
///     [contactNameProperty setString:customer:@"Jean-Luc Picard"];
///     [service createEntity:customer];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createEntityInSetExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* companyNameProperty = [customerEntityType getProperty:@"CompanyName"];
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_EntityValue* customer = [SODataV4_EntityValue ofType:customerEntityType];
///     [companyNameProperty setString:customer:@"Voyager Inc."];
///     [contactNameProperty setString:customer:@"Kathryn Janeway"];
///     [service createEntity:[customer inSet:customersEntitySet]];
/// }
/// ````
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to;
/// @internal
///
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Create a link from a source entity to a target entity in the target system.
///
///
/// @param from Source entity for the link to be created.
/// @param property Source navigation property for the link to be created.
/// @param to Target entity for the link to be created.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createLinkExample
/// {
///     NorthwindService* service = self.service;
///     Category* category = [service getCategory:[[[SODataV4_DataQuery new] skip:1] top:1]];
///     Product* product = [service getProduct:[[SODataV4_DataQuery new] top:1]];
///     [service createLink:category:Category.products:product];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createLinkExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* categoriesEntitySet = [service getEntitySet:@"Categories"];
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* categoryEntityType = categoriesEntitySet.entityType;
///     SODataV4_Property* productsProperty = [categoryEntityType getProperty:@"Products"];
///     SODataV4_EntityValue* category = [[service executeQuery:[[[[SODataV4_DataQuery new] from:categoriesEntitySet] skip:1] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* product = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:1]] getRequiredEntity];
///     [service createLink:category:productsProperty:product];
/// }
/// ````
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content;
/// @internal
///
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Create a media entity with the specified content.
///
/// If the `entity` has non-stream structural properties in addition to the key properties and media content, such as `label` in the examples below,
/// then this function will send two requests to the server: a first request to upload (POST) the media stream,
/// and a second request (PATCH/PUT) to update the non-stream properties. It is not currently supported to make these two calls *atomic*.
/// *Caution*: Having too many threads simultaneously creating streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity to be created.
/// @param content Initial content. Must be a `SODataV4_ByteStream` or `SODataV4_CharStream`. Will be closed before this function returns.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createMediaExample
/// {
///     MediaService* service = self.service;
///     Image* image = [Image new];
///     image.label = @"Smiley";
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"3A2D29"]];
///     content.mediaType = @"text/plain";
///     [service createMedia:image:content];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createMediaExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* imagesEntitySet = [service getEntitySet:@"Images"];
///     SODataV4_EntityType* imageEntityType = imagesEntitySet.entityType;
///     SODataV4_Property* labelProperty = [imageEntityType getProperty:@"label"];
///     SODataV4_EntityValue* image = [SODataV4_EntityValue ofType:imageEntityType];
///     [labelProperty setString:image:@"Smiley"];
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"3A2D29"]];
///     content.mediaType = @"text/plain";
///     [service createMedia:image:content];
/// }
/// ````
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createRelatedEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property;
/// @internal
///
- (void) createRelatedEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Create an entity in the target system, related to a parent entity via a parent navigation property.
///
///
/// @param entity Entity to be created.
/// @param parent Previously created parent entity.
/// @param property Parent's navigation property.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_ChangeSet`.`createRelatedEntity`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createRelatedEntityExample
/// {
///     NorthwindService* service = self.service;
///     Customer* customer = [service getCustomer:[[[SODataV4_DataQuery new] top:1] filter:[Customer.customerID equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))]]];
///     Order__List* orders = [service getOrders:[[SODataV4_DataQuery new] top:1]];
///     Order* newOrder = [[orders first] copy];
///     [service createRelatedEntity:newOrder:customer:Customer.orders];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createRelatedEntityExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntitySet* ordersEntitySet = [service getEntitySet:@"Orders"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* customerIDProperty = [customerEntityType getProperty:@"CustomerID"];
///     SODataV4_Property* ordersProperty = [customerEntityType getProperty:@"Orders"];
///     SODataV4_EntityValueList* customers = [[service executeQuery:[[[SODataV4_DataQuery new] from:customersEntitySet] filter:[customerIDProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))]]] getEntityList];
///     SODataV4_EntityValueList* orders = [[service executeQuery:[[[SODataV4_DataQuery new] from:ordersEntitySet] top:1]] getEntityList];
///     SODataV4_EntityValue* customer = [customers first];
///     SODataV4_EntityValue* newOrder = [[orders first] copyEntity];
///     [service createRelatedEntity:newOrder:customer:ordersProperty];
/// }
/// ````
- (void) createRelatedEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) createRelatedMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property;
/// @internal
///
- (void) createRelatedMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Create an media entity in the target system, related to a parent entity via a parent navigation property.
///
///
/// @param entity Entity to be created.
/// @param content Initial content. Must be a `SODataV4_ByteStream` or `SODataV4_CharStream`. Will be closed before this function returns.
/// @param parent Previously created parent entity.
/// @param property Parent's navigation property.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) createRelatedMediaExample
/// {
///     MediaService* service = self.service;
///     Artist* artist = [Artist new];
///     artist.firstName = @"Salvador";
///     artist.lastName = @"Dali";
///     artist.dateOfBirth = [SODataV4_LocalDate of:1904:5:11];
///     artist.placeOfBirth = [SODataV4_GeographyPoint withLatitudeLongitude:42.266667:2.965];
///     [service createEntity:artist];
///     Image* image = [Image new];
///     image.label = @"Dream";
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"447265616D204361757365642062792074686520466C69676874206F662061204265652061726F756E64206120506F6D656772616E6174652061205365636F6E64204265666F7265204177616B656E696E67"]];
///     content.mediaType = @"text/plain";
///     [service createRelatedMedia:image:content:artist:Artist.images];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) createRelatedMediaExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* artistsEntitySet = [service getEntitySet:@"Artists"];
///     SODataV4_EntityType* artistEntityType = artistsEntitySet.entityType;
///     SODataV4_Property* firstNameProperty = [artistEntityType getProperty:@"firstName"];
///     SODataV4_Property* lastNameProperty = [artistEntityType getProperty:@"lastName"];
///     SODataV4_Property* dateOfBirthProperty = [artistEntityType getProperty:@"dateOfBirth"];
///     SODataV4_Property* placeOfBirthProperty = [artistEntityType getProperty:@"placeOfBirth"];
///     SODataV4_Property* imagesProperty = [artistEntityType getProperty:@"images"];
///     SODataV4_EntitySet* imagesEntitySet = [service getEntitySet:@"Images"];
///     SODataV4_EntityType* imageEntityType = imagesEntitySet.entityType;
///     SODataV4_Property* labelProperty = [imageEntityType getProperty:@"label"];
///     SODataV4_EntityValue* artist = [SODataV4_EntityValue ofType:artistEntityType];
///     [firstNameProperty setString:artist:@"Maurits"];
///     [lastNameProperty setString:artist:@"Escher"];
///     [dateOfBirthProperty setValue:artist:[SODataV4_LocalDate of:1898:6:17]];
///     [placeOfBirthProperty setValue:artist:[SODataV4_GeographyPoint withLatitudeLongitude:53.2:5.783333]];
///     [service createEntity:artist];
///     SODataV4_EntityValue* image = [SODataV4_EntityValue ofType:imageEntityType];
///     [labelProperty setString:image:@"Hands"];
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"44726177696E672048616E6473"]];
///     content.mediaType = @"text/plain";
///     [service createRelatedMedia:image:content:artist:imagesProperty];
/// }
/// ````
- (void) createRelatedMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_EntityValue*)parent :(nonnull SODataV4_Property*)property :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Execute query to delete data from the target system.
///
///
/// @param query Data query specifying the information to be deleted.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Delete an entity from the target system.
///
///
/// @param entity Entity to be deleted.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) deleteEntityExample
/// {
///     NorthwindService* service = self.service;
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] top:1] selectKey] filter:[Customer.contactName equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"William Riker"]))]];
///     Customer* customer = [service getCustomer:query];
///     [service deleteEntity:customer];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) deleteEntityExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_DataQuery* query = [[[[[SODataV4_DataQuery new] top:1] selectKey] from:customersEntitySet] filter:[contactNameProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"William Riker"]))]];
///     SODataV4_EntityValue* customer = [[service executeQuery:query] getRequiredEntity];
///     [service deleteEntity:customer];
/// }
/// ````
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property;
/// @internal
///
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to;
/// @internal
///
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Delete a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be deleted.
/// @param property Source navigation property for the link to be deleted.
/// @param to (optional) Target entity for the link to be deleted. Can be omitted for a single-valued navigation property.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) deleteLinkExample1
/// {
///     NorthwindService* service = self.service;
///     Product* product = [service getProduct:[[SODataV4_DataQuery new] top:1]];
///     [service deleteLink:product:Product.supplier];
/// }
/// ````
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) deleteLinkExample2
/// {
///     NorthwindService* service = self.service;
///     Category* category = [service getCategory:[[[SODataV4_DataQuery new] skip:1] top:1]];
///     Product* product = [service getProduct:[[SODataV4_DataQuery new] top:1]];
///     [service deleteLink:category:Category.products:product];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) deleteLinkExample1
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* productEntityType = productsEntitySet.entityType;
///     SODataV4_Property* supplierProperty = [productEntityType getProperty:@"Supplier"];
///     SODataV4_EntityValue* product = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:1]] getRequiredEntity];
///     [service deleteLink:product:supplierProperty];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) deleteLinkExample2
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* categoriesEntitySet = [service getEntitySet:@"Categories"];
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* categoryEntityType = categoriesEntitySet.entityType;
///     SODataV4_Property* productsProperty = [categoryEntityType getProperty:@"Products"];
///     SODataV4_EntityValue* category = [[service executeQuery:[[[[SODataV4_DataQuery new] from:categoriesEntitySet] skip:1] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* product = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:1]] getRequiredEntity];
///     [service deleteLink:category:productsProperty:product];
/// }
/// ````
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link;
/// @internal
///
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Delete the content of a stream property from the target system.
///
///
/// @param entity Entity containing the stream property whose content is to be deleted.
/// @param link Stream link for the stream to be deleted.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Obtain a stream for downloading the content of a media entity from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a media entity. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity whose content is to be downloaded.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) downloadMediaExample
/// {
///     MediaService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] filter:[Image.label equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Smiley"]))]] top:1];
///     Image* image = [service getImage:query];
///     SODataV4_ByteStream* stream = [service downloadMedia:image];
///     NSData* data = [stream readAndClose];
///     [SODataV4_Assert isTrue:[SODataV4_BinaryOperator equal:data:[SODataV4_Base16Binary convert:@"3B2D29"]]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:96:9"];
///     [SODataV4_Assert isTrue:[SODataV4_NullableString hasValue:stream.mediaType:@"text/plain"]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:97:9"];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) downloadMediaExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* imagesEntitySet = [service getEntitySet:@"Images"];
///     SODataV4_EntityType* imageEntityType = imagesEntitySet.entityType;
///     SODataV4_Property* labelProperty = [imageEntityType getProperty:@"label"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] from:imagesEntitySet] filter:[labelProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Smiley"]))]] top:1];
///     SODataV4_EntityValue* image = [[service executeQuery:query] getRequiredEntity];
///     SODataV4_ByteStream* stream = [service downloadMedia:image];
///     NSData* data = [stream readAndClose];
///     [SODataV4_Assert isTrue:[SODataV4_BinaryOperator equal:data:[SODataV4_Base16Binary convert:@"3B2D29"]]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:115:9"];
///     [SODataV4_Assert isTrue:[SODataV4_NullableString hasValue:stream.mediaType:@"text/plain"]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:116:9"];
/// }
/// ````
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link;
/// @internal
///
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Obtain a stream for downloading the content of a stream property from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a stream property. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity containing the stream property whose content is to be downloaded.
/// @param link Stream link for the stream to be downloaded.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) downloadStreamExample
/// {
///     MediaService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] filter:[Video.label equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Happier"]))]] top:1];
///     Video* video = [service getVideo:query];
///     SODataV4_ByteStream* stream = [service downloadStream:video:video.content];
///     NSData* data = [stream readAndClose];
///     [SODataV4_Assert isTrue:[SODataV4_BinaryOperator equal:data:[SODataV4_Base16Binary convert:@"2E2E2E"]]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:129:9"];
///     [SODataV4_Assert isTrue:[SODataV4_NullableString hasValue:stream.mediaType:@"text/plain"]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:130:9"];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) downloadStreamExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* videosEntitySet = [service getEntitySet:@"Videos"];
///     SODataV4_EntityType* videoEntityType = videosEntitySet.entityType;
///     SODataV4_Property* labelProperty = [videoEntityType getProperty:@"label"];
///     SODataV4_Property* contentProperty = [videoEntityType getProperty:@"content"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] from:videosEntitySet] filter:[labelProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Happier"]))]] top:1];
///     SODataV4_EntityValue* video = [[service executeQuery:query] getRequiredEntity];
///     SODataV4_StreamLink* link = [contentProperty getStreamLink:video];
///     SODataV4_ByteStream* stream = [service downloadStream:video:link];
///     NSData* data = [stream readAndClose];
///     [SODataV4_Assert isTrue:[SODataV4_BinaryOperator equal:data:[SODataV4_Base16Binary convert:@"2E2E2E"]]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:158:9"];
///     [SODataV4_Assert isTrue:[SODataV4_NullableString hasValue:stream.mediaType:@"text/plain"]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:159:9"];
/// }
/// ````
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method;
/// @internal
///
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters;
/// @internal
///
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Execute a data method (action or function) in the target system.
///
/// Actions may have backend side-effects.
/// Functions should not have backend side-effects.
///
/// @return The method result, or `nil` if the method has no result.
/// @param method Data method.
/// @param parameters (optional) Method parameters.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Execute a data query to get data from the target system.
///
///
/// @return The query result.
/// @param query Data query specifying the information to be returned.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Lookup a data method by qualified name (for function/action definitions) or by unqualified name (for function/action imports).
///
/// If the data method does not exist it indicates a fundamental implementation problem, therefore a non-catchable `FatalException`
/// will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up data methods before calling this function like in the
/// following code snippet:
///
/// @return The data method, which must exist.
/// @param name Name of the data method to be returned.
/// 
/// #### Example checking if a data method exists
/// 
/// ```` oc
/// - (void) checkDataMethodExistsExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_CsdlDocument* csdlDocument = service.metadata;
///     if ([csdlDocument.dataMethods has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Person.UpdatePersonLastName"])
///     {
///         [SODataV4_Ignore valueOf_any:[service getDataMethod:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Person.UpdatePersonLastName"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_DataService`.`metadata`.`dataMethods`, for looking up data methods that might not exist.
- (nonnull SODataV4_DataMethod*) getDataMethod :(nonnull NSString*)name;
/// @brief Lookup an entity set (or singleton entity) by name. If the entity set does not exist it indicates a fundamental
///
/// implementation problem, therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up entity sets before calling this method like in the
/// following code snippet:
/// Note that OData singleton entities are represented by entity sets where `SODataV4_EntitySet`.`isSingleton` is `true`.
///
/// @return The entity set, which must exist.
/// @param name Name of the entity set to be returned.
/// 
/// #### Example checking if an entity set exists
/// 
/// ```` oc
/// - (void) checkEntitySetExistsExample
/// {
///     SODataV4_DataService* service = self.service;
///     if ([service.metadata.entitySets has:@"Categories"])
///     {
///         [SODataV4_Ignore valueOf_any:[service getEntitySet:@"Categories"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_DataService`.`metadata`.`entitySets`, for looking up entity sets that might not exist.
- (nonnull SODataV4_EntitySet*) getEntitySet :(nonnull NSString*)name;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_DataService`.`loadMetadata`.
- (SODataV4_boolean) hasMetadata;
/// @internal
///
- (void) loadEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) loadEntity :(nonnull SODataV4_EntityValue*)entity :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (void) loadEntity :(nonnull SODataV4_EntityValue*)entity :(nullable SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Reload an existing entity from the target system.
///
///
/// @param entity Previously loaded entity, whose properties will be modified to reflect the loaded state.
/// @param query Optional data query, to specify loading criteria (especially for navigation properties).
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) loadEntityExample
/// {
///     NorthwindService* service = self.service;
///     Customer* customer = [Customer new];
///     customer.customerID = @"ALFKI";
///     [service loadEntity:customer];
///     [self showCustomer:customer];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) loadEntityExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* customerIDProperty = [customerEntityType getProperty:@"CustomerID"];
///     SODataV4_EntityValue* customer = [SODataV4_EntityValue ofType:customerEntityType];
///     [customerIDProperty setString:customer:@"ALFKI"];
///     [service loadEntity:customer];
///     [self showCustomer:customer];
/// }
/// ````
- (void) loadEntity :(nonnull SODataV4_EntityValue*)entity :(nullable SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) loadMetadata;
/// @internal
///
- (void) loadMetadata :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Load service metadata (if not already loaded).
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_DataService`.`metadata`, `SODataV4_DataService`.`hasMetadata`.
- (void) loadMetadata :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) loadProperty :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)into;
/// @internal
///
- (void) loadProperty :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)into :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (void) loadProperty :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)into :(nullable SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Load the value of a property into an existing entity.
///
/// This can be applied to both structural and navigation properties.
///
/// @param property Property to load.
/// @param into Existing entity.
/// @param query Optional data query, to specify loading criteria (especially for navigation properties).
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) loadPropertyExample
/// {
///     NorthwindService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] select:@[Customer.customerID,Customer.companyName,Customer.contactName]] filter:[[Customer.customerID equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))] or:[Customer.customerID equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ANATR"]))]]];
///     Customer__List* customers = [service getCustomers:query];
///     SODataV4_int countOrders = 0;
///     // for (let customer of customers)
///     {
///         SODataV4_int customer_count = customers.length;
///         SODataV4_int customer_index;
///         for (customer_index = 0; customer_index < customer_count; customer_index++)
///         {
///             Customer* customer = [customers get:customer_index];
///             [self showCustomer:customer];
///             [service loadProperty:Customer.orders:customer];
///             Order__List* orders = customer.orders;
///             // for (let order of orders)
///             {
///                 SODataV4_int order_count = orders.length;
///                 SODataV4_int order_index;
///                 for (order_index = 0; order_index < order_count; order_index++)
///                 {
///                     Order* order = [orders get:order_index];
///                     SODataV4_int orderID = order.orderID;
///                     [Example show:@[@"  Order ",[Example formatInt:orderID]]];
///                     countOrders++;
///                 }
///             }
///         }
///     }
///     [SODataV4_Assert isTrue:(countOrders > 0):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindProxyClient.xs:451:9"];
/// }
/// ````
/// 
/// #### Example using proxy classes (in request batch)
/// 
/// ```` oc
/// - (void) loadPropertyInBatchExample
/// {
///     NorthwindService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] select:@[Customer.customerID,Customer.companyName,Customer.contactName]] filter:[[Customer.customerID equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))] or:[Customer.customerID equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ANATR"]))]]];
///     Customer__List* customers = [service getCustomers:query];
///     Customer* customer1 = [customers get:0];
///     Customer* customer2 = [customers get:1];
///     SODataV4_DataQuery* query1 = [[SODataV4_DataQuery new] load:customer1:Customer.orders];
///     SODataV4_DataQuery* query2 = [[SODataV4_DataQuery new] load:customer2:Customer.orders];
///     SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
///     [batch addQuery:query1];
///     [batch addQuery:query2];
///     [service processBatch:batch];
///     SODataV4_QueryResult* result1 = [batch getQueryResult:query1];
///     SODataV4_QueryResult* result2 = [batch getQueryResult:query2];
///     Order__List* orders1 = [Order list:[result1 getEntityList]];
///     Order__List* orders2 = [Order list:[result2 getEntityList]];
///     [SODataV4_Assert isTrue:(orders1.length != 0):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindProxyClient.xs:474:9"];
///     [SODataV4_Assert isTrue:(orders2.length != 0):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindProxyClient.xs:475:9"];
///     customer1.orders = orders1;
///     customer2.orders = orders2;
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) loadPropertyExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* customerIDProperty = [customerEntityType getProperty:@"CustomerID"];
///     SODataV4_Property* companyNameProperty = [customerEntityType getProperty:@"CompanyName"];
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_Property* ordersProperty = [customerEntityType getProperty:@"Orders"];
///     SODataV4_Property* orderIDProperty = [ordersProperty.itemEntityType getProperty:@"OrderID"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] select:@[customerIDProperty,companyNameProperty,contactNameProperty]] from:customersEntitySet] filter:[[customerIDProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))] or:[customerIDProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ANATR"]))]]];
///     SODataV4_EntityValueList* customers = [[service executeQuery:query] getEntityList];
///     SODataV4_int countOrders = 0;
///     // for (let customer of customers)
///     {
///         SODataV4_int customer_count = customers.length;
///         SODataV4_int customer_index;
///         for (customer_index = 0; customer_index < customer_count; customer_index++)
///         {
///             SODataV4_EntityValue* customer = [customers get:customer_index];
///             [self showCustomer:customer];
///             [service loadProperty:ordersProperty:customer];
///             SODataV4_EntityValueList* orders = [ordersProperty getEntityList:customer];
///             // for (let order of orders)
///             {
///                 SODataV4_int order_count = orders.length;
///                 SODataV4_int order_index;
///                 for (order_index = 0; order_index < order_count; order_index++)
///                 {
///                     SODataV4_EntityValue* order = [orders get:order_index];
///                     SODataV4_int orderID = [orderIDProperty getInt:order];
///                     [Example show:@[@"  Order ",[Example formatInt:orderID]]];
///                     countOrders++;
///                 }
///             }
///         }
///     }
///     [SODataV4_Assert isTrue:(countOrders > 0):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindClient.xs:502:9"];
/// }
/// ````
/// 
/// #### Example using dynamic API (in request batch)
/// 
/// ```` oc
/// - (void) loadPropertyInBatchExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* customerIDProperty = [customerEntityType getProperty:@"CustomerID"];
///     SODataV4_Property* companyNameProperty = [customerEntityType getProperty:@"CompanyName"];
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_Property* ordersProperty = [customerEntityType getProperty:@"Orders"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] select:@[customerIDProperty,companyNameProperty,contactNameProperty]] from:customersEntitySet] filter:[[customerIDProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ALFKI"]))] or:[customerIDProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"ANATR"]))]]];
///     SODataV4_EntityValueList* customers = [[service executeQuery:query] getEntityList];
///     SODataV4_EntityValue* customer1 = [customers get:0];
///     SODataV4_EntityValue* customer2 = [customers get:1];
///     SODataV4_DataQuery* query1 = [[SODataV4_DataQuery new] load:customer1:ordersProperty];
///     SODataV4_DataQuery* query2 = [[SODataV4_DataQuery new] load:customer2:ordersProperty];
///     SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
///     [batch addQuery:query1];
///     [batch addQuery:query2];
///     [service processBatch:batch];
///     SODataV4_QueryResult* result1 = [batch getQueryResult:query1];
///     SODataV4_QueryResult* result2 = [batch getQueryResult:query2];
///     SODataV4_EntityValueList* orders1 = [result1 getEntityList];
///     SODataV4_EntityValueList* orders2 = [result2 getEntityList];
///     [SODataV4_Assert isTrue:(orders1.length != 0):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindClient.xs:532:9"];
///     [SODataV4_Assert isTrue:(orders2.length != 0):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindClient.xs:533:9"];
///     [ordersProperty setEntityList:customer1:orders1];
///     [ordersProperty setEntityList:customer2:orders2];
/// }
/// ````
/// @see `SODataV4_DataQuery`.`load`.
- (void) loadProperty :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)into :(nullable SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service metadata.
///
///
/// @see `SODataV4_DataService`.`loadMetadata`.
- (nonnull SODataV4_CsdlDocument*) metadata;
/// @brief Service name.
///
///
- (nonnull NSString*) name;
/// @internal
///
- (void) pingServer;
/// @internal
///
- (void) pingServer :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Ping the server.
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) pingServer :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch;
/// @internal
///
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Execute a request batch in the target system.
///
///
/// @param batch The request batch.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_RequestBatch`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) processBatchExample
/// {
///     NorthwindService* service = self.service;
///     Supplier* supplier1 = [service getSupplier:[[SODataV4_DataQuery new] top:1]];
///     Supplier* supplier2 = [supplier1 copy];
///     Supplier* supplier3 = [supplier1 copy];
///     Supplier* supplier4 = [supplier1 copy];
///     supplier2.companyName = @"Alpha Inc.";
///     supplier3.companyName = @"Beta Inc.";
///     [service createEntity:supplier2];
///     [service createEntity:supplier3];
///     supplier3.companyName = @"Gamma Inc.";
///     Product* product1 = [service getProduct:[[SODataV4_DataQuery new] top:1]];
///     Product* product2 = [product1 copy];
///     product2.productName = @"Delta Cake";
///     SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
///     SODataV4_ChangeSet* changes = [SODataV4_ChangeSet new];
///     [changes createEntity:supplier4];
///     [changes updateEntity:supplier3];
///     [changes deleteEntity:supplier2];
///     [changes createEntity:product2];
///     [changes createLink:product2:Product.supplier:supplier4];
///     SODataV4_DataQuery* query = [[SODataV4_DataQuery new] from:NorthwindServiceMetadata_EntitySets.suppliers];
///     [batch addChanges:changes];
///     [batch addQuery:query];
///     [service processBatch:batch];
///     Supplier__List* suppliers = [Supplier list:[[batch getQueryResult:query] getEntityList]];
///     [Example show:@[@"There are now ",[Example formatInt:suppliers.length],@" suppliers."]];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) processBatchExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* suppliersEntitySet = [service getEntitySet:@"Suppliers"];
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* supplierEntityType = suppliersEntitySet.entityType;
///     SODataV4_Property* companyNameProperty = [supplierEntityType getProperty:@"CompanyName"];
///     SODataV4_EntityType* productEntityType = productsEntitySet.entityType;
///     SODataV4_Property* productNameProperty = [productEntityType getProperty:@"ProductName"];
///     SODataV4_Property* supplierProperty = [productEntityType getProperty:@"Supplier"];
///     SODataV4_EntityValue* supplier1 = [[service executeQuery:[[[SODataV4_DataQuery new] from:suppliersEntitySet] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* supplier2 = [supplier1 copyEntity];
///     SODataV4_EntityValue* supplier3 = [supplier1 copyEntity];
///     SODataV4_EntityValue* supplier4 = [supplier1 copyEntity];
///     [companyNameProperty setString:supplier2:@"Alpha Inc."];
///     [companyNameProperty setString:supplier3:@"Beta Inc."];
///     [service createEntity:supplier2];
///     [service createEntity:supplier3];
///     [companyNameProperty setString:supplier3:@"Gamma Inc."];
///     SODataV4_EntityValue* product1 = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* product2 = [product1 copyEntity];
///     [productNameProperty setString:product2:@"Delta Cake"];
///     SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
///     SODataV4_ChangeSet* changes = [SODataV4_ChangeSet new];
///     [changes createEntity:supplier4];
///     [changes updateEntity:supplier3];
///     [changes deleteEntity:supplier2];
///     [changes createEntity:product2];
///     [changes createLink:product2:supplierProperty:supplier4];
///     SODataV4_DataQuery* query = [[SODataV4_DataQuery new] from:suppliersEntitySet];
///     [batch addChanges:changes];
///     [batch addQuery:query];
///     [service processBatch:batch];
///     SODataV4_EntityValueList* suppliers = [[batch getQueryResult:query] getEntityList];
///     [Example show:@[@"There are now ",[Example formatInt:suppliers.length],@" suppliers."]];
/// }
/// ````
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief The data service provider.
///
///
- (nonnull id<SODataV4_DataServiceProvider>) provider;
/// @brief Reload latest metadata from the backend server. If the metadata was previously loaded (or was obtained from generated proxy classes), then a compatibility check is performed.
///
/// If the latest metadata is not compatible with the previous metadata, `SODataV4_CsdlException` will be thrown.
/// If the latest metadata is compatible with the previous metadata, the latest metadata will be applied.
/// It is generally recommended to use this function during application startup to check if the server's metadata
/// has been updated since the client application was constructed.
/// 
/// Compatible metadata changes include:
/// - Adding structural/navigation properties to complex/entity types.
/// - Adding new types (enumeration, simple, complex, entity).
/// - Adding new entity sets or singletons.
/// - Adding new actions or functions.
/// 
/// Other additions, changes, and removals are considered incompatible by default, including:
/// - Adding members to an enumeration type.
/// - Changing the base type for any type.
/// - Changing the value of an enumeration member.
/// - Changing the type (or nullability) of any structural/navigation property.
/// - Changing the type (or nullability) of any action/function parameter or result.
/// - Removing the definition of a model element.
/// - Removing members from an enumeration type.
/// - Removing structural/navigation properties from a complex/entity type.
/// 
/// Addition of enumeration members can be pre-approved by a caller using the dynamic API before calling `refreshMetadata` (see `SODataV4_CsdlDocument`.`hasOpenEnumerations`).
/// If an application uses generated proxy classes, then generating them with the "-open:enumerations" option
/// will automate the necessary pre-approval. The `hasOpenEnumerations` flag should only be explicitly set when using the dynamic API.
/// Explicitly setting the `hasOpenEnumerations` flag when using generated proxy classes (generated without the "-open:enumerations" option) could result in runtime exceptions.
/// 
/// Changes to model elements can be pre-approved by a caller using the dynamic API before calling `refreshMetadata` (see `SODataV4_CsdlDocument`.`canChangeAnything`).
/// Applications using generated proxy classes should not pre-approve such changes, as they are likely to result in application instability.
/// For example, if a property's data type is changed, it could result in runtime exceptions since proxy class properties have a pre-determined
/// type that is embedded into the application's compiled code.
/// 
/// Removal of model elements can be pre-approved by the caller before calling `refreshMetadata` (see `SODataV4_CsdlDocument`.`canRemoveAnything`),
/// or preferably by setting the `canBeRemoved` flag  on model elements that the application is prepared for the removal of.
/// Application developers should take care not to pre-approve the removal of model elements unless the application
/// is coded to check at runtime for the possible removal of those elements. The allowance for removals is intended to support "newer"
/// versions of client applications communicating with "older" service implementations but in the general case may require the application to have
/// some embedded knowledge of the changes that were made to the service metadata between the older and newer service implementations. If a newer client
/// application makes unconditional use of a model element that did not exist in an older service implementation, then the non-existence of that model element
/// after calling `refreshMetadata` could result in runtime exceptions.
/// 
/// If refreshMetadata succeeds, then any added model elements will have `isExtension == true`, and any removed model elements will have `isRemoved == true`.
/// Changed model elements will not be distinguishable.
/// 
///
/// @see `SODataV4_Property`.`isExtension`, `SODataV4_StructureType`.`extensionProperties`, `SODataV4_StructureType`.`isExtension`, `SODataV4_SimpleType`.`isExtension`, `SODataV4_EnumType`.`isExtension`, `SODataV4_DataMethod`.`isExtension`, `SODataV4_EntitySet`.`isExtension`.
- (void) refreshMetadata;
/// @internal
///
- (void) saveEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) saveEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Create (if `SODataV4_EntityValue`.`isNew`) or update (if existing) an entity in the target system.
///
///
/// @param entity Entity to be created or updated.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) saveEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Unload service metadata (if previously loaded).
///
///
/// @see `SODataV4_DataService`.`metadata`, `SODataV4_DataService`.`hasMetadata`.
- (void) unloadMetadata;
/// @internal
///
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Update an entity in the target system.
///
///
/// @param entity Entity to be updated.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) updateEntityExample
/// {
///     NorthwindService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] top:1] filter:[Customer.contactName equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Jean-Luc Picard"]))]];
///     Customer* customer = [service getCustomer:query];
///     customer.contactName = @"Beverly Crusher";
///     [service updateEntity:customer];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) updateEntityExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] top:1] from:customersEntitySet] filter:[contactNameProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Jean-Luc Picard"]))]];
///     SODataV4_EntityValue* customer = [[service executeQuery:query] getRequiredEntity];
///     [contactNameProperty setString:customer:@"Beverly Crusher"];
///     [service updateEntity:customer];
/// }
/// ````
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) updateEntityWithReplaceExample
/// {
///     NorthwindService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] top:1] filter:[Customer.contactName equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Beverly Crusher"]))]];
///     Customer* customer = [service getCustomer:query];
///     customer.contactName = @"William Riker";
///     SODataV4_RequestOptions* options = [SODataV4_RequestOptions new];
///     options.updateMode = SODataV4_UpdateMode.replace;
///     [service updateEntity:customer:SODataV4_HttpHeaders.empty:options];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) updateEntityWithReplaceExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* customersEntitySet = [service getEntitySet:@"Customers"];
///     SODataV4_EntityType* customerEntityType = customersEntitySet.entityType;
///     SODataV4_Property* contactNameProperty = [customerEntityType getProperty:@"ContactName"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] top:1] from:customersEntitySet] filter:[contactNameProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Beverly Crusher"]))]];
///     SODataV4_EntityValue* customer = [[service executeQuery:query] getRequiredEntity];
///     [contactNameProperty setString:customer:@"William Riker"];
///     SODataV4_RequestOptions* options = [SODataV4_RequestOptions new];
///     options.updateMode = SODataV4_UpdateMode.replace;
///     [service updateEntity:customer:SODataV4_HttpHeaders.empty:options];
/// }
/// ````
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to;
/// @internal
///
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Update a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be updated.
/// @param property Source navigation property for the link to be updated. This must be a one-to-one navigation property.
/// @param to Target entity for the link to be updated.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) updateLinkExample
/// {
///     NorthwindService* service = self.service;
///     Product* product = [service getProduct:[[SODataV4_DataQuery new] top:1]];
///     Category* category = [service getCategory:[[[SODataV4_DataQuery new] skip:2] top:1]];
///     [service updateLink:product:Product.category:category];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) updateLinkExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntitySet* categoriesEntitySet = [service getEntitySet:@"Categories"];
///     SODataV4_EntityType* productEntityType = productsEntitySet.entityType;
///     SODataV4_Property* categoryProperty = [productEntityType getProperty:@"Category"];
///     SODataV4_EntityValue* product = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* category = [[service executeQuery:[[[[SODataV4_DataQuery new] from:categoriesEntitySet] skip:2] top:1]] getRequiredEntity];
///     [service updateLink:product:categoryProperty:category];
/// }
/// ````
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content;
/// @internal
///
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Upload content for a media entity to the target system.
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
/// Note: this function cannot be used to create a media entity. See `SODataV4_DataService`.`createMedia`.
///
/// @param content Upload stream content. Will be closed before this function returns.
/// @param entity Entity whose content is to be uploaded.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) uploadMediaExample
/// {
///     MediaService* service = self.service;
///     SODataV4_DataQuery* query = [[[SODataV4_DataQuery new] filter:[Image.label equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Smiley"]))]] top:1];
///     Image* image = [service getImage:query];
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"3B2D29"]];
///     content.mediaType = @"text/plain";
///     [service uploadMedia:image:content];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) uploadMediaExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* imagesEntitySet = [service getEntitySet:@"Images"];
///     SODataV4_EntityType* imageEntityType = imagesEntitySet.entityType;
///     SODataV4_Property* labelProperty = [imageEntityType getProperty:@"label"];
///     SODataV4_DataQuery* query = [[[[SODataV4_DataQuery new] from:imagesEntitySet] filter:[labelProperty equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:@"Smiley"]))]] top:1];
///     SODataV4_EntityValue* image = [[service executeQuery:query] getRequiredEntity];
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"3B2D29"]];
///     content.mediaType = @"text/plain";
///     [service uploadMedia:image:content];
/// }
/// ````
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content;
/// @internal
///
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Upload content for a stream property to the target system.
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity containing the stream property whose content is to be uploaded.
/// @param link Stream link for the stream to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) uploadStreamExample
/// {
///     MediaService* service = self.service;
///     Video* video = [Video new];
///     video.label = @"Happy";
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"2E2E2E"]];
///     content.mediaType = @"text/plain";
///     [service createEntity:video];
///     NSString* contentETagAfterCreate = video.content.entityTag;
///     [SODataV4_Assert isTrue:(contentETagAfterCreate == nil):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:110:9"];
///     [service uploadStream:video:video.content:content];
///     [service loadEntity:video];
///     NSString* contentETagAfterUpload = video.content.entityTag;
///     [SODataV4_Assert isTrue:(contentETagAfterUpload != nil):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:114:9"];
///     video.label = @"Happier";
///     [service updateEntity:video];
///     NSString* contentETagAfterUpdate = video.content.entityTag;
///     [SODataV4_Assert isTrue:[SODataV4_NullableString equal:contentETagAfterUpdate:contentETagAfterUpload]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaProxyClient.xs:118:9"];
/// }
/// ````
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) uploadStreamExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* videosEntitySet = [service getEntitySet:@"Videos"];
///     SODataV4_EntityType* videoEntityType = videosEntitySet.entityType;
///     SODataV4_Property* labelProperty = [videoEntityType getProperty:@"label"];
///     SODataV4_Property* contentProperty = [videoEntityType getProperty:@"content"];
///     SODataV4_EntityValue* video = [SODataV4_EntityValue ofType:videoEntityType];
///     [labelProperty setString:video:@"Happy"];
///     SODataV4_ByteStream* content = [SODataV4_ByteStream fromBinary:[SODataV4_Base16Binary convert:@"2E2E2E"]];
///     content.mediaType = @"text/plain";
///     [service createEntity:video];
///     SODataV4_StreamLink* link = [contentProperty getStreamLink:video];
///     NSString* contentETagAfterCreate = link.entityTag;
///     [SODataV4_Assert isTrue:(contentETagAfterCreate == nil):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:134:9"];
///     [service uploadStream:video:link:content];
///     [service loadEntity:video];
///     NSString* contentETagAfterUpload = link.entityTag;
///     [SODataV4_Assert isTrue:(contentETagAfterUpload != nil):@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:138:9"];
///     [labelProperty setString:video:@"Happier"];
///     [service updateEntity:video];
///     NSString* contentETagAfterUpdate = link.entityTag;
///     [SODataV4_Assert isTrue:[SODataV4_NullableString equal:contentETagAfterUpdate:contentETagAfterUpload]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.MediaClient.xs:142:9"];
/// }
/// ````
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_DataService`.`loadMetadata`.
@property (nonatomic, readonly) SODataV4_boolean hasMetadata;
/// @brief Service metadata.
///
///
/// @see `SODataV4_DataService`.`loadMetadata`.
@property (nonatomic, readonly, strong, nonnull) SODataV4_CsdlDocument* metadata;
/// @brief Service name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* name;
/// @brief The data service provider.
///
///
@property (nonatomic, readonly, strong, nonnull) id<SODataV4_DataServiceProvider> provider;
@end
#endif

#ifdef import_SODataV4__DataService_private
#ifndef imported_SODataV4__DataService_private
#define imported_SODataV4__DataService_private
@interface SODataV4_DataService (private)
- (nonnull id<SODataV4_DataServiceProvider>) _provider;
- (void) requiresMetadata;
- (void) set_provider :(nonnull id<SODataV4_DataServiceProvider>)value;
@property (nonatomic, readwrite, strong, nonnull) id<SODataV4_DataServiceProvider> _provider;
@end
#endif
#endif

#ifdef import_SODataV4__DataSession_internal
#ifndef imported_SODataV4__DataSession_internal
#define imported_SODataV4__DataSession_public
/* internal */
/// @brief Contains session-level settings (cookies, headers, credentials) for a data service.
///
///
@interface SODataV4_DataSession : SODataV4_ObjectBase
{
    @private SODataV4_ThreadLocal* _Nonnull threadLocalRequestInfo_;
    @private SODataV4_ThreadLocal* _Nonnull threadLocalSessionInfo_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_DataSession*) new;
/// @internal
///
- (void) _init;
/// @brief For error messages.
///
///
- (nullable NSString*) currentFunction;
/// @brief For usage checking.
///
///
- (nullable SODataV4_HttpRequest*) currentRequest;
- (nonnull SODataV4_HttpCookies*) httpCookies;
- (nonnull SODataV4_HttpHeaders*) httpHeaders;
- (nullable SODataV4_LoginCredentials*) loginCredentials;
- (nullable SODataV4_HttpRequest*) mustCloseRequest;
/// @brief For error messages.
///
///
- (void) setCurrentFunction :(nullable NSString*)value;
/// @brief For usage checking.
///
///
- (void) setCurrentRequest :(nullable SODataV4_HttpRequest*)value;
- (void) setLoginCredentials :(nullable SODataV4_LoginCredentials*)value;
/// @brief For error messages.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* currentFunction;
/// @brief For usage checking.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_HttpRequest* currentRequest;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpCookies* httpCookies;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpHeaders* httpHeaders;
@property (nonatomic, readwrite, strong, nullable) SODataV4_LoginCredentials* loginCredentials;
@end
#endif
#endif

#ifdef import_SODataV4__DataSession_private
#ifndef imported_SODataV4__DataSession_private
#define imported_SODataV4__DataSession_private
@interface SODataV4_DataSession (private)
- (void) setThreadLocalRequestInfo :(nonnull SODataV4_DataSession_RequestInfo*)value;
- (void) setThreadLocalSessionInfo :(nonnull SODataV4_DataSession_SessionInfo*)value;
- (nonnull SODataV4_DataSession_RequestInfo*) threadLocalRequestInfo;
- (nonnull SODataV4_DataSession_SessionInfo*) threadLocalSessionInfo;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataSession_RequestInfo* threadLocalRequestInfo;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataSession_SessionInfo* threadLocalSessionInfo;
@end
#endif
#endif

#ifdef import_SODataV4__DataSession_RequestInfo_internal
#ifndef imported_SODataV4__DataSession_RequestInfo_internal
#define imported_SODataV4__DataSession_RequestInfo_public
/* internal */
/// @internal
///
@interface SODataV4_DataSession_RequestInfo : SODataV4_ObjectBase
{
    @private NSString* _Nullable currentFunction_;
    @private SODataV4_HttpRequest* _Nullable currentRequest_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_DataSession_RequestInfo*) new;
/// @internal
///
- (void) _init;
- (nullable NSString*) currentFunction;
- (nullable SODataV4_HttpRequest*) currentRequest;
- (void) setCurrentFunction :(nullable NSString*)value;
- (void) setCurrentRequest :(nullable SODataV4_HttpRequest*)value;
@property (nonatomic, readwrite, strong, nullable) NSString* currentFunction;
@property (nonatomic, readwrite, strong, nullable) SODataV4_HttpRequest* currentRequest;
@end
#endif
#endif

#ifdef import_SODataV4__DataSession_SessionInfo_internal
#ifndef imported_SODataV4__DataSession_SessionInfo_internal
#define imported_SODataV4__DataSession_SessionInfo_public
/* internal */
/// @internal
///
@interface SODataV4_DataSession_SessionInfo : SODataV4_ObjectBase
{
    @private SODataV4_HttpCookies* _Nonnull httpCookies_;
    @private SODataV4_HttpHeaders* _Nonnull httpHeaders_;
    @private SODataV4_LoginCredentials* _Nullable loginCredentials_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_DataSession_SessionInfo*) new;
/// @internal
///
- (void) _init;
- (nonnull SODataV4_HttpCookies*) httpCookies;
- (nonnull SODataV4_HttpHeaders*) httpHeaders;
- (nullable SODataV4_LoginCredentials*) loginCredentials;
- (void) setLoginCredentials :(nullable SODataV4_LoginCredentials*)value;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpCookies* httpCookies;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpHeaders* httpHeaders;
@property (nonatomic, readwrite, strong, nullable) SODataV4_LoginCredentials* loginCredentials;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonEntityProvider_public
#define imported_SODataV4__JsonEntityProvider_public
/// @internal
///
@interface SODataV4_JsonEntityProvider : SODataV4_ObjectBase<SODataV4_DataServiceProvider>
{
    @private id<SODataV4_DataServiceProvider> _Nonnull provider_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Create an entity in the target system.
///
/// Automatically calls `SODataV4_CsdlDocument`.`resolveEntity` to ensure that `SODataV4_EntityValue`.`entitySet` is available.
///
/// @throw `SODataV4_DataServiceException` if the entity set hasn't been explicitly provided before calling `createEntity` and there isn't a unique entity set for the entity type.
/// @param entity Entity to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_EntityValue`.`ofType`, `SODataV4_EntityValue`.`inSet`.
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be created.
/// @param property Source navigation property for the link to be created.
/// @param to Target entity for the link to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a media entity with the specified content in the target system.
///
/// If the `entity` has non-stream structural properties in addition to the key properties and media content, such as `label` in the examples below,
/// then this function will send two requests to the server: a first request to upload (POST) the media stream,
/// and a second request (PATCH/PUT) to update the non-stream properties. It is not currently supported to make these two calls *atomic*.
/// *Caution*: Having too many threads simultaneously creating streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity to be created.
/// @param content Initial content. Must be a `SODataV4_ByteStream` or `SODataV4_CharStream`. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute query to delete data from the target system.
///
///
/// @param query Data query specifying the information to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete an entity from the target system.
///
///
/// @param entity Entity to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be deleted.
/// @param property Source navigation property for the link to be deleted.
/// @param to Target entity for the link to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete the content of a stream property from the target system.
///
///
/// @param entity Entity containing the stream property whose content is to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @param link Stream link for the stream to be deleted.
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a media entity from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a media entity. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity whose content is to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a stream property from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a stream property. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity containing the stream property whose content is to be downloaded.
/// @param link Stream link for the stream to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data method (action or function) in the target system.
///
/// Actions may have backend side-effects.
/// Functions should not have backend side-effects.
///
/// @return The method result, or `nil` if the method has no result.
/// @throw `SODataV4_DataServiceException` or `SODataV4_DataNetworkException` if an error occurs during action invocation.
/// @param method Data method.
/// @param parameters Method parameters.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data query to get data from the target system.
///
///
/// @return The query result.
/// @param query Data query specifying the information to be returned.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_JsonEntityProvider`.`loadMetadata`.
- (SODataV4_boolean) hasMetadata;
/// @brief Load service metadata (if not already loaded).
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_JsonEntityProvider`.`metadata`, `SODataV4_JsonEntityProvider`.`hasMetadata`.
- (void) loadMetadata :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service metadata.
///
///
/// @see `SODataV4_JsonEntityProvider`.`loadMetadata`.
- (nonnull SODataV4_CsdlDocument*) metadata;
/// @brief Ping the server.
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) pingServer :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a request batch in the target system.
///
///
/// @param batch The request batch.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service name.
///
///
- (nonnull NSString*) serviceName;
/// @brief Service metadata.
///
///
/// @see `SODataV4_JsonEntityProvider`.`loadMetadata`.
- (void) setMetadata :(nonnull SODataV4_CsdlDocument*)value;
/// @brief Unload service metadata (if previously loaded).
///
///
/// @see `SODataV4_JsonEntityProvider`.`metadata`, `SODataV4_JsonEntityProvider`.`hasMetadata`.
- (void) unloadMetadata;
/// @brief Update an entity in the target system.
///
///
/// @param entity Entity to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Update a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be updated.
/// @param property Source navigation property for the link to be updated. This must be a one-to-one navigation property.
/// @param to Target entity for the link to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a media entity to the target system
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
/// Note: this function cannot be used to create a media entity. See `SODataV4_DataService`.`createMedia`.
///
/// @param entity Entity whose content is to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a stream property to the target system.
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity containing the stream property whose content is to be uploaded.
/// @param link Stream link for the stream to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @return A new provider that wraps `metadata`.
/// @param metadata Service metadata.
+ (nonnull SODataV4_JsonEntityProvider*) withMetadata :(nonnull SODataV4_CsdlDocument*)metadata;
/// @return A new provider that wraps `provider`.
/// @param provider Service provider.
+ (nonnull SODataV4_JsonEntityProvider*) withProvider :(nonnull id<SODataV4_DataServiceProvider>)provider;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_JsonEntityProvider`.`loadMetadata`.
@property (nonatomic, readonly) SODataV4_boolean hasMetadata;
/// @brief Service metadata.
///
///
/// @see `SODataV4_JsonEntityProvider`.`loadMetadata`.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* metadata;
/// @brief Service name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* serviceName;
@end
#endif

#ifdef import_SODataV4__JsonEntityProvider_private
#ifndef imported_SODataV4__JsonEntityProvider_private
#define imported_SODataV4__JsonEntityProvider_private
@interface SODataV4_JsonEntityProvider (private)
+ (nonnull SODataV4_JsonEntityProvider*) new;
- (nonnull id<SODataV4_DataServiceProvider>) provider;
- (void) setProvider :(nonnull id<SODataV4_DataServiceProvider>)value;
+ (nonnull SODataV4_JsonEntityProvider*) _new1 :(nonnull id<SODataV4_DataServiceProvider>)p1;
@property (nonatomic, readwrite, strong, nonnull) id<SODataV4_DataServiceProvider> provider;
@end
#endif
#endif

#ifndef imported_SODataV4__MetadataOnlyProvider_public
#define imported_SODataV4__MetadataOnlyProvider_public
/// @brief A data service provider that only provdes service metadata.
///
///
@interface SODataV4_MetadataOnlyProvider : SODataV4_ObjectBase<SODataV4_DataServiceProvider>
{
    @private SODataV4_boolean _hasMetadata;
    @private SODataV4_CsdlDocument* _Nonnull _metadata;
    @private NSString* _Nonnull _name;
}
- (nonnull id) init;
/// @brief Construct a new metadata-only service provider.
///
///
/// @param name Service name.
+ (nonnull SODataV4_MetadataOnlyProvider*) new :(nonnull NSString*)name;
/// @internal
///
- (void) _init :(nonnull NSString*)name;
/// @brief Create an entity in the target system.
///
/// Automatically calls `SODataV4_CsdlDocument`.`resolveEntity` to ensure that `SODataV4_EntityValue`.`entitySet` is available.
///
/// @throw `SODataV4_DataServiceException` if the entity set hasn't been explicitly provided before calling `createEntity` and there isn't a unique entity set for the entity type.
/// @param entity Entity to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_EntityValue`.`ofType`, `SODataV4_EntityValue`.`inSet`.
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be created.
/// @param property Source navigation property for the link to be created.
/// @param to Target entity for the link to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a media entity with the specified content in the target system.
///
/// If the `entity` has non-stream structural properties in addition to the key properties and media content, such as `label` in the examples below,
/// then this function will send two requests to the server: a first request to upload (POST) the media stream,
/// and a second request (PATCH/PUT) to update the non-stream properties. It is not currently supported to make these two calls *atomic*.
/// *Caution*: Having too many threads simultaneously creating streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity to be created.
/// @param content Initial content. Must be a `SODataV4_ByteStream` or `SODataV4_CharStream`. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute query to delete data from the target system.
///
///
/// @param query Data query specifying the information to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete an entity from the target system.
///
///
/// @param entity Entity to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be deleted.
/// @param property Source navigation property for the link to be deleted.
/// @param to Target entity for the link to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete the content of a stream property from the target system.
///
///
/// @param entity Entity containing the stream property whose content is to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @param link Stream link for the stream to be deleted.
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a media entity from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a media entity. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity whose content is to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a stream property from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a stream property. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity containing the stream property whose content is to be downloaded.
/// @param link Stream link for the stream to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data method (action or function) in the target system.
///
/// Actions may have backend side-effects.
/// Functions should not have backend side-effects.
///
/// @return The method result, or `nil` if the method has no result.
/// @throw `SODataV4_DataServiceException` or `SODataV4_DataNetworkException` if an error occurs during action invocation.
/// @param method Data method.
/// @param parameters Method parameters.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data query to get data from the target system.
///
///
/// @return The query result.
/// @param query Data query specifying the information to be returned.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_MetadataOnlyProvider`.`loadMetadata`.
- (SODataV4_boolean) hasMetadata;
/// @brief Load service metadata (if not already loaded).
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_MetadataOnlyProvider`.`metadata`, `SODataV4_MetadataOnlyProvider`.`hasMetadata`.
- (void) loadMetadata :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service metadata.
///
///
/// @see `SODataV4_MetadataOnlyProvider`.`loadMetadata`.
- (nonnull SODataV4_CsdlDocument*) metadata;
/// @brief Construct a new metadata-only service provider if the `provider` parameter is `nil`.
///
///
/// @return The `provider` parameter, if non-`nil`. Otherwise a new metadata-only service provider.
/// @param provider Service provider.
/// @param name Service name.
+ (nonnull id<SODataV4_DataServiceProvider>) newIfNull :(nullable id<SODataV4_DataServiceProvider>)provider :(nonnull NSString*)name;
/// @brief Ping the server.
///
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
- (void) pingServer :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a request batch in the target system.
///
///
/// @param batch The request batch.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Service name.
///
///
- (nonnull NSString*) serviceName;
/// @brief Service metadata.
///
///
/// @see `SODataV4_MetadataOnlyProvider`.`loadMetadata`.
- (void) setMetadata :(nonnull SODataV4_CsdlDocument*)value;
/// @brief Unload service metadata (if previously loaded).
///
///
/// @see `SODataV4_MetadataOnlyProvider`.`metadata`, `SODataV4_MetadataOnlyProvider`.`hasMetadata`.
- (void) unloadMetadata;
/// @brief Update an entity in the target system.
///
///
/// @param entity Entity to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Update a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be updated.
/// @param property Source navigation property for the link to be updated. This must be a one-to-one navigation property.
/// @param to Target entity for the link to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a media entity to the target system
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
/// Note: this function cannot be used to create a media entity. See `SODataV4_DataService`.`createMedia`.
///
/// @param entity Entity whose content is to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a stream property to the target system.
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity containing the stream property whose content is to be uploaded.
/// @param link Stream link for the stream to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Has service metadata been loaded.
///
///
/// @see `SODataV4_MetadataOnlyProvider`.`loadMetadata`.
@property (nonatomic, readonly) SODataV4_boolean hasMetadata;
/// @brief Service metadata.
///
///
/// @see `SODataV4_MetadataOnlyProvider`.`loadMetadata`.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* metadata;
/// @brief Service name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* serviceName;
@end
#endif

#ifndef imported_SODataV4__NetworkOptions_public
#define imported_SODataV4__NetworkOptions_public
/// @brief Options for interaction with a data network.
///
///
@interface SODataV4_NetworkOptions : SODataV4_ObjectBase
{
    @private SODataV4_HttpHandler* _Nullable httpHandler_;
    @private SODataV4_boolean compressResponses_;
    @private SODataV4_boolean streamDownloads_;
    @private SODataV4_boolean streamUploads_;
    @private SODataV4_boolean allowTunneling_;
    @private SODataV4_StringList* _Nonnull tunneledMethods_;
    @private NSString* _Nonnull tunnelingHeader_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_NetworkOptions*) new;
/// @internal
///
- (void) _init;
/// @brief Should HTTP verb tunneling be allowed in preference to OData batch requests?
///
/// Defaults to `false`.
///
/// @see `SODataV4_NetworkOptions`.`tunneledMethods`, `SODataV4_NetworkOptions`.`tunnelingHeader`.
- (SODataV4_boolean) allowTunneling;
/// @brief Should responses be compressed (if this is supported by the client and by the server)?
///
/// True by default.
- (SODataV4_boolean) compressResponses;
/// @brief A handler for all HTTP requests made by the data service.
///
///
- (nullable SODataV4_HttpHandler*) httpHandler;
/// @brief Should HTTP verb tunneling be allowed in preference to OData batch requests?
///
/// Defaults to `false`.
///
/// @see `SODataV4_NetworkOptions`.`tunneledMethods`, `SODataV4_NetworkOptions`.`tunnelingHeader`.
- (void) setAllowTunneling :(SODataV4_boolean)value;
/// @brief Should responses be compressed (if this is supported by the client and by the server)?
///
/// True by default.
- (void) setCompressResponses :(SODataV4_boolean)value;
/// @brief A handler for all HTTP requests made by the data service.
///
///
- (void) setHttpHandler :(nullable SODataV4_HttpHandler*)value;
/// @brief Should downloads be streamed? Set this to `false` to force the use of non-streamed downloads.
///
/// True by default.
///
/// @see `SODataV4_DataService`.`downloadMedia`, `SODataV4_DataService`.`downloadStream`.
- (void) setStreamDownloads :(SODataV4_boolean)value;
/// @brief Should uploads be streamed? Set this to `false` to force the use of non-streamed uploads.
///
/// True by default.
///
/// @see `SODataV4_DataService`.`createMedia`, `SODataV4_DataService`.`uploadMedia`, `SODataV4_DataService`.`uploadStream`.
- (void) setStreamUploads :(SODataV4_boolean)value;
/// @brief Which HTTP methods must be tunneled in HTTP POST due to proxy/firewall issues?
///
///
/// @see `SODataV4_NetworkOptions`.`allowTunneling`.
- (void) setTunneledMethods :(nonnull SODataV4_StringList*)value;
/// @brief Which HTTP header can be used for tunneling, if it is required?
///
/// Defaults to "X-HTTP-Method".
///
/// @see `SODataV4_NetworkOptions`.`allowTunneling`.
- (void) setTunnelingHeader :(nonnull NSString*)value;
/// @brief Should downloads be streamed? Set this to `false` to force the use of non-streamed downloads.
///
/// True by default.
///
/// @see `SODataV4_DataService`.`downloadMedia`, `SODataV4_DataService`.`downloadStream`.
- (SODataV4_boolean) streamDownloads;
/// @brief Should uploads be streamed? Set this to `false` to force the use of non-streamed uploads.
///
/// True by default.
///
/// @see `SODataV4_DataService`.`createMedia`, `SODataV4_DataService`.`uploadMedia`, `SODataV4_DataService`.`uploadStream`.
- (SODataV4_boolean) streamUploads;
/// @brief Which HTTP methods must be tunneled in HTTP POST due to proxy/firewall issues?
///
///
/// @see `SODataV4_NetworkOptions`.`allowTunneling`.
- (nonnull SODataV4_StringList*) tunneledMethods;
/// @brief Which HTTP header can be used for tunneling, if it is required?
///
/// Defaults to "X-HTTP-Method".
///
/// @see `SODataV4_NetworkOptions`.`allowTunneling`.
- (nonnull NSString*) tunnelingHeader;
/// @brief Should HTTP verb tunneling be allowed in preference to OData batch requests?
///
/// Defaults to `false`.
///
/// @see `SODataV4_NetworkOptions`.`tunneledMethods`, `SODataV4_NetworkOptions`.`tunnelingHeader`.
@property (nonatomic, readwrite) SODataV4_boolean allowTunneling;
/// @brief Should responses be compressed (if this is supported by the client and by the server)?
///
/// True by default.
@property (nonatomic, readwrite) SODataV4_boolean compressResponses;
/// @brief A handler for all HTTP requests made by the data service.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_HttpHandler* httpHandler;
/// @brief Should downloads be streamed? Set this to `false` to force the use of non-streamed downloads.
///
/// True by default.
///
/// @see `SODataV4_DataService`.`downloadMedia`, `SODataV4_DataService`.`downloadStream`.
@property (nonatomic, readwrite) SODataV4_boolean streamDownloads;
/// @brief Should uploads be streamed? Set this to `false` to force the use of non-streamed uploads.
///
/// True by default.
///
/// @see `SODataV4_DataService`.`createMedia`, `SODataV4_DataService`.`uploadMedia`, `SODataV4_DataService`.`uploadStream`.
@property (nonatomic, readwrite) SODataV4_boolean streamUploads;
/// @brief Which HTTP methods must be tunneled in HTTP POST due to proxy/firewall issues?
///
///
/// @see `SODataV4_NetworkOptions`.`allowTunneling`.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_StringList* tunneledMethods;
/// @brief Which HTTP header can be used for tunneling, if it is required?
///
/// Defaults to "X-HTTP-Method".
///
/// @see `SODataV4_NetworkOptions`.`allowTunneling`.
@property (nonatomic, readwrite, strong, nonnull) NSString* tunnelingHeader;
@end
#endif

#ifndef imported_SODataV4__OnlineODataProvider_public
#define imported_SODataV4__OnlineODataProvider_public
/// @brief A data service provider for online OData.
///
///
@interface SODataV4_OnlineODataProvider : SODataV4_ObjectBase<SODataV4_DataServiceProvider>
{
    @private SODataV4_boolean _hasMetadata;
    @private SODataV4_CsdlDocument* _Nonnull _metadata_;
    @private NSString* _Nullable _metadataText;
    @private SODataV4_DataMetric* _Nonnull _offlineMetadataLoadTime_;
    @private SODataV4_DataMetric* _Nonnull _onlineMetadataLoadTime_;
    @private SODataV4_DataMetric* _Nonnull _onlineMetadataFetchGzip_;
    @private SODataV4_DataMetric* _Nonnull _onlineMetadataFetchSize_;
    @private SODataV4_DataMetric* _Nonnull _onlineMetadataFetchTime_;
    @private SODataV4_DataMetric* _Nonnull _onlineMetadataParseTime_;
    @private SODataV4_DataMetric* _Nonnull _pingServerTime_;
    @private SODataV4_DataSession* _Nonnull _currentSession_;
    @private SODataV4_Logger* _Nonnull logger_;
    @private NSString* _Nonnull _name;
    @private NSString* _Nonnull _location;
    @private NSString* _Nullable _redirect;
    @private SODataV4_int _dataVersion;
    @private SODataV4_ThreadLocal* _Nonnull _fetchGzip_;
    @private SODataV4_ThreadLocal* _Nonnull _fetchSize_;
    @private SODataV4_ThreadLocal* _Nonnull _fetchTime_;
    @private SODataV4_EntitySetMap* _Nonnull dataTables_;
    @private SODataV4_long debugAtomParseTime_;
    @private SODataV4_long debugAtomValueTime_;
    @private SODataV4_long debugJsonValueTime_;
    @private SODataV4_long debugJsonParseTime_;
    @private SODataV4_NetworkOptions* _Nonnull networkOptions_;
    @private SODataV4_ServiceOptions* _Nonnull serviceOptions_;
    @private SODataV4_boolean prettyTracing_;
    @private SODataV4_boolean traceRequests_;
    @private SODataV4_boolean traceWithData_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Constructs an online OData provider.
///
///
/// @param serviceName Service name.
/// @param serviceRoot Service root URL.
+ (nonnull SODataV4_OnlineODataProvider*) new :(nonnull NSString*)serviceName :(nonnull NSString*)serviceRoot;
/// @brief Constructs an online OData provider.
///
///
/// @param serviceName Service name.
/// @param serviceRoot Service root URL.
/// @param httpHandler (optional) HTTP handler (optional).
+ (nonnull SODataV4_OnlineODataProvider*) new :(nonnull NSString*)serviceName :(nonnull NSString*)serviceRoot :(nullable SODataV4_HttpHandler*)httpHandler;
/// @internal
///
- (void) _init :(nonnull NSString*)serviceName :(nonnull NSString*)serviceRoot :(nullable SODataV4_HttpHandler*)httpHandler;
/// @brief If this data service requires a security token, then acquire it now.
///
///
/// @see `SODataV4_ServiceOptions`.`requiresToken`.
- (void) acquireToken;
/// @brief Create an entity in the target system.
///
/// Automatically calls `SODataV4_CsdlDocument`.`resolveEntity` to ensure that `SODataV4_EntityValue`.`entitySet` is available.
///
/// @throw `SODataV4_DataServiceException` if the entity set hasn't been explicitly provided before calling `createEntity` and there isn't a unique entity set for the entity type.
/// @param entity Entity to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_EntityValue`.`ofType`, `SODataV4_EntityValue`.`inSet`.
- (void) createEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be created.
/// @param property Source navigation property for the link to be created.
/// @param to Target entity for the link to be created.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Create a media entity with the specified content in the target system.
///
/// If the `entity` has non-stream structural properties in addition to the key properties and media content, such as `label` in the examples below,
/// then this function will send two requests to the server: a first request to upload (POST) the media stream,
/// and a second request (PATCH/PUT) to update the non-stream properties. It is not currently supported to make these two calls *atomic*.
/// *Caution*: Having too many threads simultaneously creating streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity to be created.
/// @param content Initial content. Must be a `SODataV4_ByteStream` or `SODataV4_CharStream`. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) createMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute query to delete data from the target system.
///
///
/// @param query Data query specifying the information to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteByQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete an entity from the target system.
///
///
/// @param entity Entity to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be deleted.
/// @param property Source navigation property for the link to be deleted.
/// @param to Target entity for the link to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) deleteLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Delete the content of a stream property from the target system.
///
///
/// @param entity Entity containing the stream property whose content is to be deleted.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @param link Stream link for the stream to be deleted.
- (void) deleteStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a query and obtain the result as a stream of delta items.
///
///
/// @return Delta stream.
/// @param query Data query.
- (nonnull SODataV4_DeltaStream*) deltaStream :(nonnull SODataV4_DataQuery*)query;
/// @brief Obtain a stream for downloading the content of a media entity from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a media entity. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity whose content is to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_ByteStream*) downloadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Obtain a stream for downloading the content of a stream property from the target system.
///
/// *Caution*: streams are often used for large content that may not fit (all at once) in available application memory.
/// Having too many threads simultaneously downloading streams, or using `SODataV4_ByteStream`.`readAndClose`,
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @return A stream for downloading the content of a stream property. This must be closed by the caller, or else a resource leak may occur.
/// @param entity Entity containing the stream property whose content is to be downloaded.
/// @param link Stream link for the stream to be downloaded.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (nonnull SODataV4_ByteStream*) downloadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull SODataV4_DataContext*) entityContext :(nonnull SODataV4_EntitySet*)entitySet;
/// @internal
///
- (nonnull SODataV4_DataContext*) entityContext :(nonnull SODataV4_EntitySet*)entitySet :(nullable SODataV4_StructureType*)derivedType;
/// @internal
///
- (nonnull SODataV4_DataContext*) entityContext :(nonnull SODataV4_EntitySet*)entitySet :(nullable SODataV4_StructureType*)derivedType :(SODataV4_int)format;
/// @internal
///
- (nonnull SODataV4_DataContext*) entityContext :(nonnull SODataV4_EntitySet*)entitySet :(nullable SODataV4_StructureType*)derivedType :(SODataV4_int)format :(SODataV4_int)version;
/// @brief Execute a query and obtain the result as a stream of entity values.
///
///
/// @return Entity stream.
/// @param query Data query.
- (nonnull SODataV4_EntityStream*) entityStream :(nonnull SODataV4_DataQuery*)query;
/// @brief Execute a data method (action or function) in the target system.
///
/// Actions may have backend side-effects.
/// Functions should not have backend side-effects.
///
/// @return The method result, or `nil` if the method has no result.
/// @throw `SODataV4_DataServiceException` or `SODataV4_DataNetworkException` if an error occurs during action invocation.
/// @param method Data method.
/// @param parameters Method parameters.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nullable SODataV4_DataValue*) executeMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Execute a data query to get data from the target system.
///
///
/// @return The query result.
/// @param query Data query specifying the information to be returned.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (nonnull SODataV4_QueryResult*) executeQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief `true` if the service metadata has been loaded by `SODataV4_OnlineODataProvider`.`loadMetadata`, or is automatically available in a generated DataService proxy class.
///
///
- (SODataV4_boolean) hasMetadata;
/// @brief HTTP cookies that were returned by previous online requests.
///
///
- (nonnull SODataV4_HttpCookies*) httpCookies;
/// @brief HTTP headers which should be sent in future online requests.
///
///
- (nonnull SODataV4_HttpHeaders*) httpHeaders;
/// @brief Load the [OData](http://odata.org) CSDL metadata for this data service into memory.
///
/// If the meta-data was previously loaded into memory (by the current process), then calling
/// this function will have no effect (except to log a warning).
/// If the meta-data was loaded by a previous instance of the current application, or if the
/// `SODataV4_ServiceOptions`.`metadataFile` or `SODataV4_ServiceOptions`.`metadataText` is non-null, then metadata may be loaded from the local
/// file system or the provided text. Otherwise the metadata will be retrieved from the remote data service.
/// If another DataService function that requires metadata is called before metadata has been
/// loaded, the metadata will be automatically loaded by an implicit call to `loadMetadata`.
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_OnlineODataProvider`.`hasMetadata`
- (void) loadMetadata :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief The OData CSDL document (service metadata).
///
///
- (nonnull SODataV4_CsdlDocument*) metadata;
/// @brief Options for network communication, which for OData uses HTTP or HTTPS.
///
///
- (nonnull SODataV4_NetworkOptions*) networkOptions;
/// @brief Ping the server, by sending a non-changing request that the server can respond to quickly.
///
/// The default ping behaviour is to send a HEAD request for the service document.
///
/// @param headers Optional request-specific headers.
/// @param options Optional request-specific options.
/// @see `SODataV4_ServiceOptions`.`pingMethod`, `SODataV4_ServiceOptions`.`pingResource`, `SODataV4_ServiceOptions`.`pingAccept`.
- (void) pingServer :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Should `SODataV4_OnlineODataProvider`.`traceWithData` show pretty-printed JSON/XML content? Defaults to `false`.
///
///
- (SODataV4_boolean) prettyTracing;
/// @brief Execute a request batch in the target system.
///
///
/// @param batch The request batch.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) processBatch :(nonnull SODataV4_RequestBatch*)batch :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull SODataV4_DataContext*) queryContext;
/// @internal
///
- (nonnull SODataV4_DataContext*) queryContext :(SODataV4_int)version;
/// @brief The service name.
///
///
- (nonnull NSString*) serviceName;
/// @brief Options for this data service, both client-side and server-side.
///
///
- (nonnull SODataV4_ServiceOptions*) serviceOptions;
/// @brief The service root URL.
///
/// The service root URL always terminates with a forward slash.
- (nonnull NSString*) serviceRoot;
/// @brief The OData CSDL document (service metadata).
///
///
- (void) setMetadata :(nonnull SODataV4_CsdlDocument*)value;
/// @brief Should `SODataV4_OnlineODataProvider`.`traceWithData` show pretty-printed JSON/XML content? Defaults to `false`.
///
///
- (void) setPrettyTracing :(SODataV4_boolean)value;
/// @brief The service root URL.
///
/// The service root URL always terminates with a forward slash.
- (void) setServiceRoot :(nonnull NSString*)value;
/// @brief Should all requests for this data service be traced? Defaults to `false`.
///
///
- (void) setTraceRequests :(SODataV4_boolean)value;
/// @brief If `SODataV4_OnlineODataProvider`.`traceRequests` is also `true`, should all requests for this data service be traced with data? Defaults to `false`.
///
/// Note that care must be taken when enabling tracing with data, as the resulting log files may contain sensitive information.
/// On the other hand, tracing with data may sometimes be invaluable for troubleshooting purposes.
- (void) setTraceWithData :(SODataV4_boolean)value;
/// @brief Should all requests for this data service be traced? Defaults to `false`.
///
///
- (SODataV4_boolean) traceRequests;
/// @brief If `SODataV4_OnlineODataProvider`.`traceRequests` is also `true`, should all requests for this data service be traced with data? Defaults to `false`.
///
/// Note that care must be taken when enabling tracing with data, as the resulting log files may contain sensitive information.
/// On the other hand, tracing with data may sometimes be invaluable for troubleshooting purposes.
- (SODataV4_boolean) traceWithData;
/// @brief Unload the [OData](http://odata.org) CSDL metadata for this data service from memory.
///
/// If metadata was not already loaded into memory, this function has no effect.
///
/// @see `SODataV4_OnlineODataProvider`.`loadMetadata`.
- (void) unloadMetadata;
/// @brief Update an entity in the target system.
///
///
/// @param entity Entity to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateEntity :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Update a link from a source entity to a target entity.
///
///
/// @param from Source entity for the link to be updated.
/// @param property Source navigation property for the link to be updated. This must be a one-to-one navigation property.
/// @param to Target entity for the link to be updated.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) updateLink :(nonnull SODataV4_EntityValue*)from :(nonnull SODataV4_Property*)property :(nonnull SODataV4_EntityValue*)to :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a media entity to the target system
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
/// Note: this function cannot be used to create a media entity. See `SODataV4_DataService`.`createMedia`.
///
/// @param entity Entity whose content is to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
- (void) uploadMedia :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Upload content for a stream property to the target system.
///
/// *Caution*: Having too many threads simultaneously uploading streams
/// may result in out-of-memory conditions on memory-constrained devices.
///
/// @param entity Entity containing the stream property whose content is to be uploaded.
/// @param link Stream link for the stream to be uploaded.
/// @param content Upload stream content. Will be closed before this function returns.
/// @param headers Request-specific headers.
/// @param options Request-specific options.
/// @see `SODataV4_Property`.`getStreamLink`.
- (void) uploadStream :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_StreamBase*)content :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief `true` if the service metadata has been loaded by `SODataV4_OnlineODataProvider`.`loadMetadata`, or is automatically available in a generated DataService proxy class.
///
///
@property (nonatomic, readonly) SODataV4_boolean hasMetadata;
/// @brief HTTP cookies that were returned by previous online requests.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpCookies* httpCookies;
/// @brief HTTP headers which should be sent in future online requests.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpHeaders* httpHeaders;
/// @brief The OData CSDL document (service metadata).
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* metadata;
/// @brief Options for network communication, which for OData uses HTTP or HTTPS.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_NetworkOptions* networkOptions;
/// @brief Should `SODataV4_OnlineODataProvider`.`traceWithData` show pretty-printed JSON/XML content? Defaults to `false`.
///
///
@property (atomic, readwrite) SODataV4_boolean prettyTracing;
/// @brief The service name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* serviceName;
/// @brief Options for this data service, both client-side and server-side.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_ServiceOptions* serviceOptions;
/// @brief The service root URL.
///
/// The service root URL always terminates with a forward slash.
@property (nonatomic, readwrite, strong, nonnull) NSString* serviceRoot;
/// @brief Should all requests for this data service be traced? Defaults to `false`.
///
///
@property (atomic, readwrite) SODataV4_boolean traceRequests;
/// @brief If `SODataV4_OnlineODataProvider`.`traceRequests` is also `true`, should all requests for this data service be traced with data? Defaults to `false`.
///
/// Note that care must be taken when enabling tracing with data, as the resulting log files may contain sensitive information.
/// On the other hand, tracing with data may sometimes be invaluable for troubleshooting purposes.
@property (atomic, readwrite) SODataV4_boolean traceWithData;
@end
#endif

#ifdef import_SODataV4__OnlineODataProvider_private
#ifndef imported_SODataV4__OnlineODataProvider_private
#define imported_SODataV4__OnlineODataProvider_private
@interface SODataV4_OnlineODataProvider (private)
- (nonnull SODataV4_DataSession*) _currentSession;
- (SODataV4_long) _fetchGzip;
- (SODataV4_long) _fetchSize;
- (SODataV4_long) _fetchTime;
- (nonnull SODataV4_CsdlDocument*) _metadata;
- (nonnull SODataV4_DataMetric*) _offlineMetadataLoadTime;
- (nonnull SODataV4_DataMetric*) _onlineMetadataFetchGzip;
- (nonnull SODataV4_DataMetric*) _onlineMetadataFetchSize;
- (nonnull SODataV4_DataMetric*) _onlineMetadataFetchTime;
- (nonnull SODataV4_DataMetric*) _onlineMetadataLoadTime;
- (nonnull SODataV4_DataMetric*) _onlineMetadataParseTime;
- (nonnull SODataV4_DataMetric*) _pingServerTime;
- (void) addCookies :(nonnull SODataV4_HttpRequest*)request;
- (void) addHttpCookies :(nonnull SODataV4_HttpRequest*)request;
- (void) addHttpHeaders :(nonnull SODataV4_HttpRequest*)request :(nonnull SODataV4_HttpHeaders*)headers;
- (void) appendHeaders :(nonnull SODataV4_CharBuffer*)buffer :(nonnull SODataV4_HttpHeaders*)headers;
/// @internal
///
- (void) applyChanges :(nonnull SODataV4_ChangeSet*)changes;
/// @internal
///
- (void) applyChanges :(nonnull SODataV4_ChangeSet*)changes :(nonnull SODataV4_HttpHeaders*)headers;
- (void) applyChanges :(nonnull SODataV4_ChangeSet*)changes :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
- (void) applyNewEntityID :(nonnull SODataV4_EntityValue*)entity :(nullable NSString*)entityID;
- (void) checkAndClose :(nonnull SODataV4_HttpRequest*)httpRequest;
- (void) clearBindings :(nonnull SODataV4_StructureBase*)structure;
- (void) clearSystemFlags :(nullable SODataV4_EntityValue*)entity :(SODataV4_int)flags;
- (nonnull SODataV4_DataSession*) currentSession;
- (nonnull SODataV4_DataServiceException*) errorAfterClosing :(nonnull SODataV4_HttpRequest*)request;
- (nonnull SODataV4_DataServiceException*) errorWithMessage :(nonnull NSString*)message;
- (nonnull SODataV4_DataServiceException*) errorWithStatus :(SODataV4_int)status :(nullable NSString*)message;
/// @brief Follow all next links in result (recursively).
///
///
- (void) followNext :(nonnull NSString*)fromURL :(nullable SODataV4_DataValue*)result :(SODataV4_int)format :(nonnull SODataV4_DataContext*)context :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
- (nonnull NSString*) formatHttpDate :(nonnull SODataV4_GlobalDateTime*)dateTime;
- (nonnull SODataV4_HttpRequest*) getHttpRequest :(nonnull NSString*)method :(nonnull NSString*)url :(nonnull SODataV4_RequestOptions*)options;
- (nullable NSString*) getNextLink :(nullable SODataV4_DataValue*)value;
- (nonnull SODataV4_Logger*) logger;
- (nonnull SODataV4_EntitySet*) lookupInternal :(nonnull NSString*)name;
- (void) mergeInternal;
- (void) mergeReturnedProperties :(nonnull SODataV4_EntityValue*)intoEntity :(nonnull SODataV4_EntityValue*)fromResult;
- (nullable SODataV4_DataValue*) methodResult :(nonnull NSString*)url :(nonnull SODataV4_DataMethodCall*)methodCall :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
- (nonnull NSString*) offlineLinks1;
- (void) offlineLinks2;
- (void) parseMetadata :(nonnull NSString*)text :(nonnull NSString*)url :(nullable NSString*)saveToCache;
- (void) parseNewLocation :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context :(nullable NSString*)location;
- (void) processResponseCookies :(nonnull SODataV4_HttpRequest*)request;
- (void) processResponseHeaders :(nonnull SODataV4_HttpRequest*)request;
- (void) readMetadata :(nonnull NSString*)file :(nullable NSString*)saveToCache;
- (void) rememberOldRecursively :(nonnull SODataV4_EntityValue*)entity;
- (void) requiresMetadata;
/// @internal
///
- (nonnull NSString*) resolveEditLink :(nonnull NSString*)rootURL :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
- (nonnull NSString*) resolveEditLink :(nonnull NSString*)rootURL :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)inBatch;
- (nonnull SODataV4_EntitySet*) resolveEntitySet :(nonnull SODataV4_EntityValue*)entity;
/// @internal
///
- (nonnull NSString*) resolveReadLink :(nonnull NSString*)rootURL :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
- (nonnull NSString*) resolveReadLink :(nonnull NSString*)rootURL :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)inBatch;
- (void) sendHttpRequest :(nonnull SODataV4_HttpRequest*)request :(nonnull SODataV4_HttpHeaders*)headers;
- (void) setCurrentSession :(nonnull SODataV4_DataSession*)value;
- (void) setLogger :(nonnull SODataV4_Logger*)value;
- (void) setNextLink :(nullable SODataV4_DataValue*)value :(nullable NSString*)link;
- (void) setODataVersion :(nonnull SODataV4_HttpRequest*)request;
- (void) set_currentSession :(nonnull SODataV4_DataSession*)value;
- (void) set_fetchGzip :(SODataV4_long)value;
- (void) set_fetchSize :(SODataV4_long)value;
- (void) set_fetchTime :(SODataV4_long)value;
- (void) set_metadata :(nonnull SODataV4_CsdlDocument*)value;
- (void) set_offlineMetadataLoadTime :(nonnull SODataV4_DataMetric*)value;
- (void) set_onlineMetadataFetchGzip :(nonnull SODataV4_DataMetric*)value;
- (void) set_onlineMetadataFetchSize :(nonnull SODataV4_DataMetric*)value;
- (void) set_onlineMetadataFetchTime :(nonnull SODataV4_DataMetric*)value;
- (void) set_onlineMetadataLoadTime :(nonnull SODataV4_DataMetric*)value;
- (void) set_onlineMetadataParseTime :(nonnull SODataV4_DataMetric*)value;
- (void) set_pingServerTime :(nonnull SODataV4_DataMetric*)value;
+ (nonnull SODataV4_Logger*) staticLogger;
- (SODataV4_boolean) useAtomFormat;
- (nonnull NSString*) useContentType;
- (nonnull NSString*) useContentTypeForLink;
+ (nonnull SODataV4_CloseRequest*) _new1 :(nonnull SODataV4_OnlineODataProvider*)p1 :(nonnull SODataV4_HttpRequest*)p2;
+ (nonnull SODataV4_GetByteStream*) _new2 :(nonnull SODataV4_OnlineODataProvider*)p1 :(nullable SODataV4_DataMetric*)p2 :(nonnull SODataV4_HttpRequest*)p3 :(nullable NSString*)p4 :(SODataV4_long)p5 :(nonnull SODataV4_ByteStream*)p6 :(nullable NSString*)p7;
+ (nonnull SODataV4_ErrorResponse*) _new3 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3 :(nullable NSString*)p4;
+ (nonnull SODataV4_ErrorResponse*) _new4 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3;
+ (nonnull SODataV4_GetCharStream*) _new5 :(nonnull SODataV4_OnlineODataProvider*)p1 :(nullable SODataV4_DataMetric*)p2 :(nullable SODataV4_DataMetric*)p3 :(nonnull SODataV4_HttpRequest*)p4 :(SODataV4_long)p5 :(nonnull SODataV4_CharStream*)p6 :(nullable SODataV4_DataMetric*)p7;
+ (nonnull SODataV4_GetMetadata*) _new6 :(nonnull SODataV4_OnlineODataProvider*)p1;
+ (nonnull SODataV4_CsdlParser*) _new7 :(nullable SODataV4_CsdlFetcher*)p1 :(nonnull SODataV4_DataSchemaList*)p2 :(SODataV4_boolean)p3 :(nullable NSString*)p4 :(SODataV4_int)p5;
#define SODataV4_OnlineODataProvider_ACCEPT @"Accept"
#define SODataV4_OnlineODataProvider_APPLICATION_ATOM @"application/atom+xml"
#define SODataV4_OnlineODataProvider_APPLICATION_JSON @"application/json"
#define SODataV4_OnlineODataProvider_APPLICATION_JSON_VERBOSE @"application/json;odata=verbose"
#define SODataV4_OnlineODataProvider_APPLICATION_XML @"application/xml"
#define SODataV4_OnlineODataProvider_CONTENT_LANGUAGE @"Content-Language"
#define SODataV4_OnlineODataProvider_CONTENT_TYPE @"Content-Type"
#define SODataV4_OnlineODataProvider_ETAG @"ETag"
#define SODataV4_OnlineODataProvider_IF_MATCH @"If-Match"
#define SODataV4_OnlineODataProvider_LOCATION @"Location"
#define SODataV4_OnlineODataProvider_ODATA_ENTITY_ID @"OData-EntityId"
#define SODataV4_OnlineODataProvider_PREFER @"Prefer"
#define SODataV4_OnlineODataProvider_X_HTTP_METHOD @"X-HTTP-Method"
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataSession* _currentSession;
@property (nonatomic, readwrite) SODataV4_long _fetchGzip;
@property (nonatomic, readwrite) SODataV4_long _fetchSize;
@property (nonatomic, readwrite) SODataV4_long _fetchTime;
@property (atomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* _metadata;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _offlineMetadataLoadTime;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _onlineMetadataFetchGzip;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _onlineMetadataFetchSize;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _onlineMetadataFetchTime;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _onlineMetadataLoadTime;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _onlineMetadataParseTime;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataMetric* _pingServerTime;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataSession* currentSession;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Logger* logger;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Logger* staticLogger;
@end
#endif
#endif

#ifdef import_SODataV4__OnlineODataProvider_internal
#ifndef imported_SODataV4__OnlineODataProvider_internal
#define imported_SODataV4__OnlineODataProvider_internal
@interface SODataV4_OnlineODataProvider (internal)
- (void) closeHttpRequest :(nonnull SODataV4_HttpRequest*)request;
- (nonnull NSString*) currentServicePath;
- (nonnull NSString*) currentServiceRoot;
/// @brief User-visible and system-internal `SODataV4_EntitySet` which are stored in the local database.
///
///
- (nonnull SODataV4_EntitySetMap*) dataTables;
- (SODataV4_long) debugAtomParseTime;
- (SODataV4_long) debugAtomValueTime;
- (SODataV4_long) debugJsonParseTime;
- (SODataV4_long) debugJsonValueTime;
- (nullable SODataV4_XmlElement*) getAtomValue :(nullable NSString*)url :(nonnull SODataV4_DataType*)dataType :(nullable NSString*)response :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
- (nonnull SODataV4_CharStream*) getCharStream :(nonnull NSString*)url :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options :(nonnull SODataV4_DataMetric*)timeTaken :(nonnull SODataV4_DataMetric*)bytesRead :(nonnull SODataV4_DataMetric*)gzipBytes;
/// @brief Lookup a data method by qualified name (for function/action definitions) or by unqualified name (for function/action imports).
///
///
/// @return The data method.
/// @param name Name of the data method to be returned.
- (nonnull SODataV4_DataMethod*) getDataMethod :(nonnull NSString*)name;
/// @brief Lookup an entity set (or singleton entity) by name.
///
/// Note that OData singleton entities are represented by entity sets where `SODataV4_EntitySet`.`isSingleton` is `true`.
///
/// @return The entity set.
/// @param name Name of the entity set to be returned.
- (nonnull SODataV4_EntitySet*) getEntitySet :(nonnull NSString*)name;
- (nullable SODataV4_JsonElement*) getJsonValue :(nullable NSString*)url :(nonnull SODataV4_DataType*)dataType :(nullable NSString*)response :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
- (nonnull NSString*) getMetadata :(nonnull NSString*)url;
- (nullable SODataV4_DataValue*) getRawValue :(nullable NSString*)url :(nonnull SODataV4_DataType*)dataType :(nullable NSString*)response :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
- (nonnull SODataV4_EntityValue*) getReturnEntity :(nonnull NSString*)responseText :(nonnull SODataV4_EntitySet*)entitySet;
/// @brief Set the credentials to be used for HTTP (or HTTPS) BASIC authentication.
///
/// If credentials are required by the remote data service, they must be set before
/// any function calls (such as `SODataV4_OnlineODataProvider`.`loadMetadata`) which may make a network request.
///
/// @param username Client's username.
/// @param password Client's password.
/// @see `SODataV4_OnlineODataProvider`.`setCredentials`.
- (void) login :(nonnull NSString*)username :(nonnull NSString*)password;
- (SODataV4_int) selectedVersionCode;
/// @brief Set the credentials to be used for HTTP (or HTTPS) BASIC authentication.
///
/// If credentials are required by the remote data service, they must be set before
/// any function calls (such as `SODataV4_OnlineODataProvider`.`loadMetadata`) which may make a network request.
///
/// @param credentials Username and password credentials.
/// @see `SODataV4_OnlineODataProvider`.`login`.
- (void) setCredentials :(nonnull SODataV4_LoginCredentials*)credentials;
/// @brief User-visible and system-internal `SODataV4_EntitySet` which are stored in the local database.
///
///
- (void) setDataTables :(nonnull SODataV4_EntitySetMap*)value;
- (void) setDebugAtomParseTime :(SODataV4_long)value;
- (void) setDebugAtomValueTime :(SODataV4_long)value;
- (void) setDebugJsonParseTime :(SODataV4_long)value;
- (void) setDebugJsonValueTime :(SODataV4_long)value;
/// @brief User-visible and system-internal `SODataV4_EntitySet` which are stored in the local database.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_EntitySetMap* dataTables;
@property (nonatomic, readwrite) SODataV4_long debugAtomParseTime;
@property (nonatomic, readwrite) SODataV4_long debugAtomValueTime;
@property (nonatomic, readwrite) SODataV4_long debugJsonParseTime;
@property (nonatomic, readwrite) SODataV4_long debugJsonValueTime;
@property (nonatomic, readonly) SODataV4_int selectedVersionCode;
@end
#endif
#endif

#ifndef imported_SODataV4__PathResolver_public
#define imported_SODataV4__PathResolver_public
/// @internal
///
@interface SODataV4_PathResolver : SODataV4_ObjectBase
{
}
+ (void) resolveChildPaths :(nonnull SODataV4_CsdlDocument*)metadata :(nonnull SODataV4_StructureBase*)parent :(nonnull SODataV4_DataContext*)dataContext :(nullable NSString*)parentPath;
/// @internal
///
+ (void) resolvePaths :(nonnull SODataV4_CsdlDocument*)metadata :(nonnull SODataV4_DataContext*)dataContext :(nullable SODataV4_DataValue*)value;
+ (void) resolvePaths :(nonnull SODataV4_CsdlDocument*)metadata :(nonnull SODataV4_DataContext*)dataContext :(nullable SODataV4_DataValue*)value :(nullable NSString*)path;
@end
#endif

#ifndef imported_SODataV4__ProviderInternal_public
#define imported_SODataV4__ProviderInternal_public
/// @internal
///
@interface SODataV4_ProviderInternal : SODataV4_ObjectBase
{
}
+ (SODataV4_long) providerDebugJsonParseTime :(nonnull SODataV4_OnlineODataProvider*)provider;
+ (SODataV4_long) providerDebugJsonValueTime :(nonnull SODataV4_OnlineODataProvider*)provider;
+ (void) resetProviderDebugJsonParseTime :(nonnull SODataV4_OnlineODataProvider*)provider;
+ (void) resetProviderDebugJsonValueTime :(nonnull SODataV4_OnlineODataProvider*)provider;
@end
#endif

#ifndef imported_SODataV4__ProxyInternal_public
#define imported_SODataV4__ProxyInternal_public
/// @internal
///
@interface SODataV4_ProxyInternal : SODataV4_ObjectBase
{
}
/// @brief Check that proxy classes were generated using same framework version.
///
///
/// @param metadata Service metadata.
+ (void) checkVersion :(nonnull SODataV4_CsdlDocument*)metadata;
/// @brief Variant of `SODataV4_DataService`.`refreshMetadata` for use by proxy classes.
///
///
+ (void) noRefreshMetadata;
/// @brief Variant of `SODataV4_DataService`.`refreshMetadata` for use by proxy classes.
///
///
/// @param service Data service.
/// @param fetcher CSDL fetcher.
/// @param options CSDL options.
+ (void) refreshMetadata :(nonnull SODataV4_DataService*)service :(nullable SODataV4_CsdlFetcher*)fetcher :(SODataV4_nullable_int)options;
@end
#endif

#ifndef imported_SODataV4__RequestBatch_public
#define imported_SODataV4__RequestBatch_public
/// @brief Encapsulates an [OData](http://odata.org) batch request.
///
///
/// @see `SODataV4_ChangeSet`, `SODataV4_DataQuery`, `DataService.processBatch`.
/// 
/// #### Example using dynamic API
/// 
/// ```` oc
/// - (void) processBatchExample
/// {
///     SODataV4_DataService* service = self.service;
///     SODataV4_EntitySet* suppliersEntitySet = [service getEntitySet:@"Suppliers"];
///     SODataV4_EntitySet* productsEntitySet = [service getEntitySet:@"Products"];
///     SODataV4_EntityType* supplierEntityType = suppliersEntitySet.entityType;
///     SODataV4_Property* companyNameProperty = [supplierEntityType getProperty:@"CompanyName"];
///     SODataV4_EntityType* productEntityType = productsEntitySet.entityType;
///     SODataV4_Property* productNameProperty = [productEntityType getProperty:@"ProductName"];
///     SODataV4_Property* supplierProperty = [productEntityType getProperty:@"Supplier"];
///     SODataV4_EntityValue* supplier1 = [[service executeQuery:[[[SODataV4_DataQuery new] from:suppliersEntitySet] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* supplier2 = [supplier1 copyEntity];
///     SODataV4_EntityValue* supplier3 = [supplier1 copyEntity];
///     SODataV4_EntityValue* supplier4 = [supplier1 copyEntity];
///     [companyNameProperty setString:supplier2:@"Alpha Inc."];
///     [companyNameProperty setString:supplier3:@"Beta Inc."];
///     [service createEntity:supplier2];
///     [service createEntity:supplier3];
///     [companyNameProperty setString:supplier3:@"Gamma Inc."];
///     SODataV4_EntityValue* product1 = [[service executeQuery:[[[SODataV4_DataQuery new] from:productsEntitySet] top:1]] getRequiredEntity];
///     SODataV4_EntityValue* product2 = [product1 copyEntity];
///     [productNameProperty setString:product2:@"Delta Cake"];
///     SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
///     SODataV4_ChangeSet* changes = [SODataV4_ChangeSet new];
///     [changes createEntity:supplier4];
///     [changes updateEntity:supplier3];
///     [changes deleteEntity:supplier2];
///     [changes createEntity:product2];
///     [changes createLink:product2:supplierProperty:supplier4];
///     SODataV4_DataQuery* query = [[SODataV4_DataQuery new] from:suppliersEntitySet];
///     [batch addChanges:changes];
///     [batch addQuery:query];
///     [service processBatch:batch];
///     SODataV4_EntityValueList* suppliers = [[batch getQueryResult:query] getEntityList];
///     [Example show:@[@"There are now ",[Example formatInt:suppliers.length],@" suppliers."]];
/// }
/// ````
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) processBatchExample
/// {
///     NorthwindService* service = self.service;
///     Supplier* supplier1 = [service getSupplier:[[SODataV4_DataQuery new] top:1]];
///     Supplier* supplier2 = [supplier1 copy];
///     Supplier* supplier3 = [supplier1 copy];
///     Supplier* supplier4 = [supplier1 copy];
///     supplier2.companyName = @"Alpha Inc.";
///     supplier3.companyName = @"Beta Inc.";
///     [service createEntity:supplier2];
///     [service createEntity:supplier3];
///     supplier3.companyName = @"Gamma Inc.";
///     Product* product1 = [service getProduct:[[SODataV4_DataQuery new] top:1]];
///     Product* product2 = [product1 copy];
///     product2.productName = @"Delta Cake";
///     SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
///     SODataV4_ChangeSet* changes = [SODataV4_ChangeSet new];
///     [changes createEntity:supplier4];
///     [changes updateEntity:supplier3];
///     [changes deleteEntity:supplier2];
///     [changes createEntity:product2];
///     [changes createLink:product2:Product.supplier:supplier4];
///     SODataV4_DataQuery* query = [[SODataV4_DataQuery new] from:NorthwindServiceMetadata_EntitySets.suppliers];
///     [batch addChanges:changes];
///     [batch addQuery:query];
///     [service processBatch:batch];
///     Supplier__List* suppliers = [Supplier list:[[batch getQueryResult:query] getEntityList]];
///     [Example show:@[@"There are now ",[Example formatInt:suppliers.length],@" suppliers."]];
/// }
/// ````
@interface SODataV4_RequestBatch : SODataV4_ObjectBase
{
    @private SODataV4_ObjectList* _Nonnull _requests;
    @private SODataV4_AnyList* _Nonnull _results;
    @private SODataV4_ObjectList* _Nonnull _headers;
    @private SODataV4_ObjectList* _Nonnull _options;
    @private SODataV4_int status_;
    @private SODataV4_DataServiceException* _Nullable error_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_RequestBatch*) new;
/// @internal
///
- (void) _init;
/// @internal
///
- (void) addChanges :(nonnull SODataV4_ChangeSet*)changes;
/// @internal
///
- (void) addChanges :(nonnull SODataV4_ChangeSet*)changes :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a change set to this request batch.
///
///
/// @param changes Change set.
/// @param headers (optional) Change set headers.
/// @param options (optional) Change set options.
- (void) addChanges :(nonnull SODataV4_ChangeSet*)changes :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @internal
///
- (void) addQuery :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (void) addQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a data query to this request batch.
///
///
/// @param query Data query.
/// @param headers (optional) Data query headers.
/// @param options (optional) Data query options.
- (void) addQuery :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @brief Add a query result to this request batch.
///
///
/// @param query Data query, which must have been previously added to this batch using `addQuery`.
/// @param result Query result.
- (void) addQueryResult :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryResult*)result;
/// @brief Error if `status` does not represent a successful response.
///
///
- (nullable SODataV4_DataServiceException*) error;
/// @return The change set, if `isChangeSet(index)` is `true`; otherwise throws `undefined`.
/// @param index From zero to `size - 1`.
- (nonnull SODataV4_ChangeSet*) getChangeSet :(SODataV4_int)index;
/// @return The data query, if `isDataQuery(index)` is `true`; otherwise throws `undefined`.
/// @param index From zero to `size - 1`.
- (nonnull SODataV4_DataQuery*) getDataQuery :(SODataV4_int)index;
/// @return The DataQuery for the Function, if `isFunction(index)` is `true`; otherwise throws `undefined`
/// @param index From zero to `size - 1`
- (nonnull SODataV4_DataQuery*) getFunction :(SODataV4_int)index;
/// @return The HTTP headers for the request at `index`.
/// @param index From zero to `size - 1`.
- (nonnull SODataV4_HttpHeaders*) getHeaders :(SODataV4_int)index;
/// @return The request options for the request at `index`.
/// @param index From zero to `size - 1`.
- (nonnull SODataV4_RequestOptions*) getOptions :(SODataV4_int)index;
/// @return The result of a data query within this batch.
/// @param query Data query.
/// @see `SODataV4_RequestBatch`.`addQuery`.
- (nonnull SODataV4_QueryResult*) getQueryResult :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull SODataV4_DataQuery*) invokeFunction :(nonnull SODataV4_DataMethod*)method;
/// @internal
///
- (nonnull SODataV4_DataQuery*) invokeFunction :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters;
/// @internal
///
- (nonnull SODataV4_DataQuery*) invokeFunction :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Add a function to the batch. If the method is not a function, throws an `undefined`.
///
///
/// @return The DataQuery with the function to be invoked in the batch request.
/// @param method Function to be called.
/// @param parameters (optional) Method parameters.
/// @param headers (optional) Request-specific headers.
/// @param options (optional) Request-specific options.
/// @see `SODataV4_DataQuery`.`bind`, for setting the binding parameter for a bound function. You can set it on the returned DataQuery by calling load method.
- (nonnull SODataV4_DataQuery*) invokeFunction :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_ParameterList*)parameters :(nonnull SODataV4_HttpHeaders*)headers :(nonnull SODataV4_RequestOptions*)options;
/// @return `true` if `index` is a valid request index, and the request at that index is a `SODataV4_ChangeSet`; otherwise `false`.
/// @param index From zero to `size - 1`.
- (SODataV4_boolean) isChangeSet :(SODataV4_int)index;
/// @return `true` if `index` is a valid request index, and the request at that index is a `SODataV4_DataQuery`; otherwise `false`.
/// @param index From zero to `size - 1`.
- (SODataV4_boolean) isDataQuery :(SODataV4_int)index;
/// @return `true` if `index` is a valid change index, and the request at that index is for a function
/// @param index From zero to `size - 1`
- (SODataV4_boolean) isFunction :(SODataV4_int)index;
/// @brief Error if `status` does not represent a successful response.
///
///
- (void) setError :(nullable SODataV4_DataServiceException*)value;
/// @brief Response status (e.g. HTTP status code 200 = OK).
///
///
- (void) setStatus :(SODataV4_int)value;
/// @brief The number of requests in this request batch.
///
///
- (SODataV4_int) size;
/// @brief Response status (e.g. HTTP status code 200 = OK).
///
///
- (SODataV4_int) status;
/// @brief Error if `status` does not represent a successful response.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataServiceException* error;
/// @brief The number of requests in this request batch.
///
///
@property (nonatomic, readonly) SODataV4_int size;
/// @brief Response status (e.g. HTTP status code 200 = OK).
///
///
@property (nonatomic, readwrite) SODataV4_int status;
@end
#endif

#ifndef imported_SODataV4__ServiceOptions_public
#define imported_SODataV4__ServiceOptions_public
/// @brief Options for interaction with a data service.
///
///
@interface SODataV4_ServiceOptions : SODataV4_ObjectBase
{
    @private NSString* _Nullable clientID_;
    @private SODataV4_int dataFormat_;
    @private SODataV4_int dataVersion_;
    @private SODataV4_boolean checkQueries_;
    @private SODataV4_boolean checkResults_;
    @private SODataV4_boolean checkVersion_;
    @private SODataV4_boolean databaseOnly_;
    @private SODataV4_boolean logErrors_;
    @private SODataV4_boolean logWarnings_;
    @private SODataV4_CsdlFetcher* _Nullable csdlFetcher_;
    @private SODataV4_int csdlOptions_;
    @private SODataV4_DataSchemaList* _Nonnull includeSchemas_;
    @private NSString* _Nullable metadataFile_;
    @private NSString* _Nullable metadataText_;
    @private NSString* _Nullable metadataURL_;
    @private NSString* _Nullable avoidInPaths_;
    @private SODataV4_boolean cacheMetadata_;
    @private NSString* _Nonnull pingMethod_;
    @private NSString* _Nonnull pingResource_;
    @private NSString* _Nonnull pingAccept_;
    @private NSString* _Nullable requiresToken_;
    @private SODataV4_boolean requiresType_;
    @private SODataV4_boolean supportsAlias_;
    @private SODataV4_boolean supportsBatch_;
    @private SODataV4_boolean supportsBind_;
    @private SODataV4_boolean supportsDelta_;
    @private SODataV4_boolean supportsPatch_;
    @private SODataV4_boolean supportsNext_;
    @private SODataV4_boolean supportsUnbind_;
    @private SODataV4_boolean fixMissingNullValues_;
    @private SODataV4_boolean fixMissingEmptyLists_;
    @private SODataV4_boolean createReturnsContent_;
    @private SODataV4_boolean updateReturnsContent_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ServiceOptions*) new;
/// @internal
///
- (void) _init;
/// @brief Characters that must be avoided in the path component of URLs (e.g. in OData key predicates or function parameters), even when percent-encoded.
///
/// This mey be the case with certain client or server environments which limit the characters permitted in paths (usually due to security concerns).
/// When this option is set, other options (e.g. `SODataV4_ServiceOptions`.`supportsAlias`, `SODataV4_ServiceOptions`.`supportsBatch`) may be required to enable such characters to be passed in another way.
///
/// @see <https://tools.ietf.org/html/rfc3986#section-7.3>.
- (nullable NSString*) avoidInPaths;
/// @brief Should loaded service metadata be cached in a local file?
///
/// If `SODataV4_ServiceOptions`.`metadataFile` is non-null, then the cache file name will be `SODataV4_ServiceOptions`.`metadataFile` with ".cache" appended.
/// If `SODataV4_ServiceOptions`.`metadataFile` is `nil`, then the cache file name will be the service name with ".csdl.cache" appended.
///
/// @see `DataService.loadMetadata`.
- (SODataV4_boolean) cacheMetadata;
/// @brief Check data queries before sending them to the server. Defaults to `true`.
///
///
/// @see `DataQuery.check`.
- (SODataV4_boolean) checkQueries;
/// @brief Check query results after receiving them from the server. Defaults to `true`.
///
///
/// @see `QueryResult.check`.
- (SODataV4_boolean) checkResults;
/// @brief Check version header in OData responses. Defaults to `true`.
///
///
- (SODataV4_boolean) checkVersion;
/// @brief Globally unique client identifier for the client, used to provide a default value for the "ClientID" HTTP header.
///
///
/// @see [Universally unique identifier](https://en.wikipedia.org/wiki/Universally_unique_identifier).
- (nullable NSString*) clientID;
/// @brief Do createEntity calls return resulting entity state in response payload? Defaults to `true`.
///
///
- (SODataV4_boolean) createReturnsContent;
/// @brief CSDL fetcher which can resolve CSDL references when loading metadata.
///
/// This overrides a data service's default mechanism to load metadata over HTTP.
- (nullable SODataV4_CsdlFetcher*) csdlFetcher;
/// @brief CSDL options for parsing.
///
///
/// @see `SODataV4_CsdlOption`.
- (SODataV4_int) csdlOptions;
/// @brief Format to be used for data interchange (ATOM or JSON). Defaults to JSON.
///
///
/// @see `SODataV4_DataFormat`.
- (SODataV4_int) dataFormat;
/// @brief Version to be used for data interchange. If non-zero, this overrides any version specified in the service metadata.
///
///
/// @see `SODataV4_DataVersion`.
- (SODataV4_int) dataVersion;
/// @brief Is this service only to be used with a local database?
///
/// By default, a service can be used both online (remote service) and offline (local database).
- (SODataV4_boolean) databaseOnly;
/// @brief If set to true and the server returns no value for a collection-typed property of an entity then parser will return an empty collection and validation will not fail.
///
/// Note: this property is only considered if checkResults is set to true and the property to be queried is selected or expanded in the query
/// False by default.
- (SODataV4_boolean) fixMissingEmptyLists;
/// @brief If set to true and the server returns no value for a non collection-typed property of an entity then parser will return a null value and validation will not fail.
///
/// Note: this property is only considered if checkResults is set to true and the property to be queried is selected or expanded in the query
/// False by default.
- (SODataV4_boolean) fixMissingNullValues;
/// @brief Pre-parsed CSDL schemas, which may be referenced by the service metadata.
///
///
- (nonnull SODataV4_DataSchemaList*) includeSchemas;
/// @brief Should data service error messages be logged? Defaults to `true`.
///
///
- (SODataV4_boolean) logErrors;
/// @brief Should data service warning messages be logged? Defaults to `true`.
///
///
- (SODataV4_boolean) logWarnings;
/// @brief Name of local file containing OData CSDL service metadata for the data service.
///
/// If this is `nil`, then metadata will be fetched from the remote service.
///
/// @see `SODataV4_ServiceOptions`.`cacheMetadata`, `SODataV4_ServiceOptions`.`metadataText`.
- (nullable NSString*) metadataFile;
/// @brief Text of the service metadata, provider by the caller so it does not need to be loaded.
///
///
/// @see `SODataV4_ServiceOptions`.`cacheMetadata`, `SODataV4_ServiceOptions`.`metadataFile`.
- (nullable NSString*) metadataText;
/// @brief Alternate location of OData CSDL service metadata.
///
/// Can be an absolute URL, or a relative URL (relative to the service root URL).
/// Use this if the preferred service metadata document appears at a URL other than that formed by appending "$metadata" to the service root URL.
- (nullable NSString*) metadataURL;
/// @brief Response type accepted by `SODataV4_DataService`.`pingServer`. Defaults to "application/json,application/xml,application/atomsvc+xml".
///
///
- (nonnull NSString*) pingAccept;
/// @brief HTTP method used by `SODataV4_DataService`.`pingServer`. Defaults to "HEAD".
///
///
- (nonnull NSString*) pingMethod;
/// @brief Resource path used by `SODataV4_DataService`.`pingServer`. Defaults to "/" (the service document).
///
///
- (nonnull NSString*) pingResource;
/// @brief Does the service require a security token for change requests? Defaults to "X-CSRF-Token".
///
/// A token is obtained, implicitly if needed, by a call to `SODataV4_DataService`.`pingServer`.
- (nullable NSString*) requiresToken;
/// @brief Does the service always require type metadata in client-sent complex/entity values.
///
///
- (SODataV4_boolean) requiresType;
/// @brief Characters that must be avoided in the path component of URLs (e.g. in OData key predicates or function parameters), even when percent-encoded.
///
/// This mey be the case with certain client or server environments which limit the characters permitted in paths (usually due to security concerns).
/// When this option is set, other options (e.g. `SODataV4_ServiceOptions`.`supportsAlias`, `SODataV4_ServiceOptions`.`supportsBatch`) may be required to enable such characters to be passed in another way.
///
/// @see <https://tools.ietf.org/html/rfc3986#section-7.3>.
- (void) setAvoidInPaths :(nullable NSString*)value;
/// @brief Should loaded service metadata be cached in a local file?
///
/// If `SODataV4_ServiceOptions`.`metadataFile` is non-null, then the cache file name will be `SODataV4_ServiceOptions`.`metadataFile` with ".cache" appended.
/// If `SODataV4_ServiceOptions`.`metadataFile` is `nil`, then the cache file name will be the service name with ".csdl.cache" appended.
///
/// @see `DataService.loadMetadata`.
- (void) setCacheMetadata :(SODataV4_boolean)value;
/// @brief Check data queries before sending them to the server. Defaults to `true`.
///
///
/// @see `DataQuery.check`.
- (void) setCheckQueries :(SODataV4_boolean)value;
/// @brief Check query results after receiving them from the server. Defaults to `true`.
///
///
/// @see `QueryResult.check`.
- (void) setCheckResults :(SODataV4_boolean)value;
/// @brief Check version header in OData responses. Defaults to `true`.
///
///
- (void) setCheckVersion :(SODataV4_boolean)value;
/// @brief Globally unique client identifier for the client, used to provide a default value for the "ClientID" HTTP header.
///
///
/// @see [Universally unique identifier](https://en.wikipedia.org/wiki/Universally_unique_identifier).
- (void) setClientID :(nullable NSString*)value;
/// @brief Do createEntity calls return resulting entity state in response payload? Defaults to `true`.
///
///
- (void) setCreateReturnsContent :(SODataV4_boolean)value;
/// @brief CSDL fetcher which can resolve CSDL references when loading metadata.
///
/// This overrides a data service's default mechanism to load metadata over HTTP.
- (void) setCsdlFetcher :(nullable SODataV4_CsdlFetcher*)value;
/// @brief CSDL options for parsing.
///
///
/// @see `SODataV4_CsdlOption`.
- (void) setCsdlOptions :(SODataV4_int)value;
/// @brief Format to be used for data interchange (ATOM or JSON). Defaults to JSON.
///
///
/// @see `SODataV4_DataFormat`.
- (void) setDataFormat :(SODataV4_int)value;
/// @brief Version to be used for data interchange. If non-zero, this overrides any version specified in the service metadata.
///
///
/// @see `SODataV4_DataVersion`.
- (void) setDataVersion :(SODataV4_int)value;
/// @brief Is this service only to be used with a local database?
///
/// By default, a service can be used both online (remote service) and offline (local database).
- (void) setDatabaseOnly :(SODataV4_boolean)value;
/// @brief If set to true and the server returns no value for a collection-typed property of an entity then parser will return an empty collection and validation will not fail.
///
/// Note: this property is only considered if checkResults is set to true and the property to be queried is selected or expanded in the query
/// False by default.
- (void) setFixMissingEmptyLists :(SODataV4_boolean)value;
/// @brief If set to true and the server returns no value for a non collection-typed property of an entity then parser will return a null value and validation will not fail.
///
/// Note: this property is only considered if checkResults is set to true and the property to be queried is selected or expanded in the query
/// False by default.
- (void) setFixMissingNullValues :(SODataV4_boolean)value;
/// @brief Pre-parsed CSDL schemas, which may be referenced by the service metadata.
///
///
- (void) setIncludeSchemas :(nonnull SODataV4_DataSchemaList*)value;
/// @brief Should data service error messages be logged? Defaults to `true`.
///
///
- (void) setLogErrors :(SODataV4_boolean)value;
/// @brief Should data service warning messages be logged? Defaults to `true`.
///
///
- (void) setLogWarnings :(SODataV4_boolean)value;
/// @brief Name of local file containing OData CSDL service metadata for the data service.
///
/// If this is `nil`, then metadata will be fetched from the remote service.
///
/// @see `SODataV4_ServiceOptions`.`cacheMetadata`, `SODataV4_ServiceOptions`.`metadataText`.
- (void) setMetadataFile :(nullable NSString*)value;
/// @brief Text of the service metadata, provider by the caller so it does not need to be loaded.
///
///
/// @see `SODataV4_ServiceOptions`.`cacheMetadata`, `SODataV4_ServiceOptions`.`metadataFile`.
- (void) setMetadataText :(nullable NSString*)value;
/// @brief Alternate location of OData CSDL service metadata.
///
/// Can be an absolute URL, or a relative URL (relative to the service root URL).
/// Use this if the preferred service metadata document appears at a URL other than that formed by appending "$metadata" to the service root URL.
- (void) setMetadataURL :(nullable NSString*)value;
/// @brief Response type accepted by `SODataV4_DataService`.`pingServer`. Defaults to "application/json,application/xml,application/atomsvc+xml".
///
///
- (void) setPingAccept :(nonnull NSString*)value;
/// @brief HTTP method used by `SODataV4_DataService`.`pingServer`. Defaults to "HEAD".
///
///
- (void) setPingMethod :(nonnull NSString*)value;
/// @brief Resource path used by `SODataV4_DataService`.`pingServer`. Defaults to "/" (the service document).
///
///
- (void) setPingResource :(nonnull NSString*)value;
/// @brief Does the service require a security token for change requests? Defaults to "X-CSRF-Token".
///
/// A token is obtained, implicitly if needed, by a call to `SODataV4_DataService`.`pingServer`.
- (void) setRequiresToken :(nullable NSString*)value;
/// @brief Does the service always require type metadata in client-sent complex/entity values.
///
///
- (void) setRequiresType :(SODataV4_boolean)value;
/// @brief Does the service support parameter aliases?
///
/// True by default.
- (void) setSupportsAlias :(SODataV4_boolean)value;
/// @brief Does the service support OData batch requests?
///
/// True by default.
///
/// @see `SODataV4_DataService`.`processBatch`
- (void) setSupportsBatch :(SODataV4_boolean)value;
/// @brief Does the service support bind operations.
///
/// True by default.
///
/// @see `SODataV4_EntityValue`.`bindEntity`.
- (void) setSupportsBind :(SODataV4_boolean)value;
/// @brief Does the service support server-side change tracking (e.g. with delta links)?
///
/// True by default.
- (void) setSupportsDelta :(SODataV4_boolean)value;
/// @brief Does the service support the following of next-links using the $skiptoken system query option.
///
/// True by default.
- (void) setSupportsNext :(SODataV4_boolean)value;
/// @brief Does the service support OData PATCH requests (or MERGE for OData versions < 3.0).
///
/// True by default.
- (void) setSupportsPatch :(SODataV4_boolean)value;
/// @brief Does the service support unbind operations (unbind navigation property from an existing entity in delete)?
///
/// True by default.
///
/// @see `SODataV4_EntityValue`.`unbindEntity`.
- (void) setSupportsUnbind :(SODataV4_boolean)value;
/// @brief Do updateEntity calls return resulting entity state in response payload? Defaults to `true`.
///
///
- (void) setUpdateReturnsContent :(SODataV4_boolean)value;
/// @brief Does the service support parameter aliases?
///
/// True by default.
- (SODataV4_boolean) supportsAlias;
/// @brief Does the service support OData batch requests?
///
/// True by default.
///
/// @see `SODataV4_DataService`.`processBatch`
- (SODataV4_boolean) supportsBatch;
/// @brief Does the service support bind operations.
///
/// True by default.
///
/// @see `SODataV4_EntityValue`.`bindEntity`.
- (SODataV4_boolean) supportsBind;
/// @brief Does the service support server-side change tracking (e.g. with delta links)?
///
/// True by default.
- (SODataV4_boolean) supportsDelta;
/// @brief Does the service support the following of next-links using the $skiptoken system query option.
///
/// True by default.
- (SODataV4_boolean) supportsNext;
/// @brief Does the service support OData PATCH requests (or MERGE for OData versions < 3.0).
///
/// True by default.
- (SODataV4_boolean) supportsPatch;
/// @brief Does the service support unbind operations (unbind navigation property from an existing entity in delete)?
///
/// True by default.
///
/// @see `SODataV4_EntityValue`.`unbindEntity`.
- (SODataV4_boolean) supportsUnbind;
/// @brief Do updateEntity calls return resulting entity state in response payload? Defaults to `true`.
///
///
- (SODataV4_boolean) updateReturnsContent;
/// @brief Characters that must be avoided in the path component of URLs (e.g. in OData key predicates or function parameters), even when percent-encoded.
///
/// This mey be the case with certain client or server environments which limit the characters permitted in paths (usually due to security concerns).
/// When this option is set, other options (e.g. `SODataV4_ServiceOptions`.`supportsAlias`, `SODataV4_ServiceOptions`.`supportsBatch`) may be required to enable such characters to be passed in another way.
///
/// @see <https://tools.ietf.org/html/rfc3986#section-7.3>.
@property (atomic, readwrite, strong, nullable) NSString* avoidInPaths;
/// @brief Should loaded service metadata be cached in a local file?
///
/// If `SODataV4_ServiceOptions`.`metadataFile` is non-null, then the cache file name will be `SODataV4_ServiceOptions`.`metadataFile` with ".cache" appended.
/// If `SODataV4_ServiceOptions`.`metadataFile` is `nil`, then the cache file name will be the service name with ".csdl.cache" appended.
///
/// @see `DataService.loadMetadata`.
@property (atomic, readwrite) SODataV4_boolean cacheMetadata;
/// @brief Check data queries before sending them to the server. Defaults to `true`.
///
///
/// @see `DataQuery.check`.
@property (atomic, readwrite) SODataV4_boolean checkQueries;
/// @brief Check query results after receiving them from the server. Defaults to `true`.
///
///
/// @see `QueryResult.check`.
@property (atomic, readwrite) SODataV4_boolean checkResults;
/// @brief Check version header in OData responses. Defaults to `true`.
///
///
@property (atomic, readwrite) SODataV4_boolean checkVersion;
/// @brief Globally unique client identifier for the client, used to provide a default value for the "ClientID" HTTP header.
///
///
/// @see [Universally unique identifier](https://en.wikipedia.org/wiki/Universally_unique_identifier).
@property (atomic, readwrite, strong, nullable) NSString* clientID;
/// @brief Do createEntity calls return resulting entity state in response payload? Defaults to `true`.
///
///
@property (atomic, readwrite) SODataV4_boolean createReturnsContent;
/// @brief CSDL fetcher which can resolve CSDL references when loading metadata.
///
/// This overrides a data service's default mechanism to load metadata over HTTP.
@property (atomic, readwrite, strong, nullable) SODataV4_CsdlFetcher* csdlFetcher;
/// @brief CSDL options for parsing.
///
///
/// @see `SODataV4_CsdlOption`.
@property (atomic, readwrite) SODataV4_int csdlOptions;
/// @brief Format to be used for data interchange (ATOM or JSON). Defaults to JSON.
///
///
/// @see `SODataV4_DataFormat`.
@property (atomic, readwrite) SODataV4_int dataFormat;
/// @brief Version to be used for data interchange. If non-zero, this overrides any version specified in the service metadata.
///
///
/// @see `SODataV4_DataVersion`.
@property (atomic, readwrite) SODataV4_int dataVersion;
/// @brief Is this service only to be used with a local database?
///
/// By default, a service can be used both online (remote service) and offline (local database).
@property (atomic, readwrite) SODataV4_boolean databaseOnly;
/// @brief If set to true and the server returns no value for a collection-typed property of an entity then parser will return an empty collection and validation will not fail.
///
/// Note: this property is only considered if checkResults is set to true and the property to be queried is selected or expanded in the query
/// False by default.
@property (atomic, readwrite) SODataV4_boolean fixMissingEmptyLists;
/// @brief If set to true and the server returns no value for a non collection-typed property of an entity then parser will return a null value and validation will not fail.
///
/// Note: this property is only considered if checkResults is set to true and the property to be queried is selected or expanded in the query
/// False by default.
@property (atomic, readwrite) SODataV4_boolean fixMissingNullValues;
/// @brief Pre-parsed CSDL schemas, which may be referenced by the service metadata.
///
///
@property (atomic, readwrite, strong, nonnull) SODataV4_DataSchemaList* includeSchemas;
/// @brief Should data service error messages be logged? Defaults to `true`.
///
///
@property (atomic, readwrite) SODataV4_boolean logErrors;
/// @brief Should data service warning messages be logged? Defaults to `true`.
///
///
@property (atomic, readwrite) SODataV4_boolean logWarnings;
/// @brief Name of local file containing OData CSDL service metadata for the data service.
///
/// If this is `nil`, then metadata will be fetched from the remote service.
///
/// @see `SODataV4_ServiceOptions`.`cacheMetadata`, `SODataV4_ServiceOptions`.`metadataText`.
@property (atomic, readwrite, strong, nullable) NSString* metadataFile;
/// @brief Text of the service metadata, provider by the caller so it does not need to be loaded.
///
///
/// @see `SODataV4_ServiceOptions`.`cacheMetadata`, `SODataV4_ServiceOptions`.`metadataFile`.
@property (atomic, readwrite, strong, nullable) NSString* metadataText;
/// @brief Alternate location of OData CSDL service metadata.
///
/// Can be an absolute URL, or a relative URL (relative to the service root URL).
/// Use this if the preferred service metadata document appears at a URL other than that formed by appending "$metadata" to the service root URL.
@property (atomic, readwrite, strong, nullable) NSString* metadataURL;
/// @brief Response type accepted by `SODataV4_DataService`.`pingServer`. Defaults to "application/json,application/xml,application/atomsvc+xml".
///
///
@property (atomic, readwrite, strong, nonnull) NSString* pingAccept;
/// @brief HTTP method used by `SODataV4_DataService`.`pingServer`. Defaults to "HEAD".
///
///
@property (atomic, readwrite, strong, nonnull) NSString* pingMethod;
/// @brief Resource path used by `SODataV4_DataService`.`pingServer`. Defaults to "/" (the service document).
///
///
@property (atomic, readwrite, strong, nonnull) NSString* pingResource;
/// @brief Does the service require a security token for change requests? Defaults to "X-CSRF-Token".
///
/// A token is obtained, implicitly if needed, by a call to `SODataV4_DataService`.`pingServer`.
@property (atomic, readwrite, strong, nullable) NSString* requiresToken;
/// @brief Does the service always require type metadata in client-sent complex/entity values.
///
///
@property (atomic, readwrite) SODataV4_boolean requiresType;
/// @brief Does the service support parameter aliases?
///
/// True by default.
@property (atomic, readwrite) SODataV4_boolean supportsAlias;
/// @brief Does the service support OData batch requests?
///
/// True by default.
///
/// @see `SODataV4_DataService`.`processBatch`
@property (atomic, readwrite) SODataV4_boolean supportsBatch;
/// @brief Does the service support bind operations.
///
/// True by default.
///
/// @see `SODataV4_EntityValue`.`bindEntity`.
@property (atomic, readwrite) SODataV4_boolean supportsBind;
/// @brief Does the service support server-side change tracking (e.g. with delta links)?
///
/// True by default.
@property (atomic, readwrite) SODataV4_boolean supportsDelta;
/// @brief Does the service support the following of next-links using the $skiptoken system query option.
///
/// True by default.
@property (atomic, readwrite) SODataV4_boolean supportsNext;
/// @brief Does the service support OData PATCH requests (or MERGE for OData versions < 3.0).
///
/// True by default.
@property (atomic, readwrite) SODataV4_boolean supportsPatch;
/// @brief Does the service support unbind operations (unbind navigation property from an existing entity in delete)?
///
/// True by default.
///
/// @see `SODataV4_EntityValue`.`unbindEntity`.
@property (atomic, readwrite) SODataV4_boolean supportsUnbind;
/// @brief Do updateEntity calls return resulting entity state in response payload? Defaults to `true`.
///
///
@property (atomic, readwrite) SODataV4_boolean updateReturnsContent;
@end
#endif

#ifdef import_SODataV4__SystemTables_internal
#ifndef imported_SODataV4__SystemTables_internal
#define imported_SODataV4__SystemTables_public
/* internal */
@interface SODataV4_SystemTables : SODataV4_ObjectBase
{
}
#define SODataV4_SystemTables_CSDL @"@trimLines\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:DataServices DataServiceVersion=\"4.0\" >\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"xscript.sql.system\">\r\n      <EntityType Name=\"DeltaLink\">\r\n        <Key>\r\n          <PropertyRef Name=\"name\"/>\r\n        </Key>\r\n        <Property Name=\"name\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <Property Name=\"link\" Type=\"Edm.String\" Nullable=\"false\" />\r\n      </EntityType>\r\n      <EntityType Name=\"ChangeRow\">\r\n        <Key>\r\n          <PropertyRef Name=\"changeSet\"/>\r\n          <PropertyRef Name=\"itemIndex\"/>\r\n        </Key>\r\n    \t<Property Name=\"changeSet\" Type=\"Edm.Int64\" Nullable=\"false\" />\r\n    \t<Property Name=\"itemIndex\" Type=\"Edm.Int32\" Nullable=\"false\" />\r\n    \t<Property Name=\"changeType\" Type=\"Edm.String\" MaxLength=\"1\" Nullable=\"false\" />\r\n    \t<Property Name=\"sourceSet\" Type=\"Edm.String\" Nullable=\"false\" />\r\n    \t<Property Name=\"sourceKey\" Type=\"Edm.Int64\" Nullable=\"false\" />\r\n    \t<Property Name=\"sourceLink\" Type=\"Edm.String\" Nullable=\"true\" />\r\n    \t<Property Name=\"targetSet\" Type=\"Edm.String\" Nullable=\"true\" />\r\n    \t<Property Name=\"targetKey\" Type=\"Edm.Int64\" Nullable=\"true\" />\r\n      </EntityType>\r\n      <EntityType Name=\"ChangeSet\">\r\n        <Key>\r\n          <PropertyRef Name=\"created\"/>\r\n          <!-- TODO: better key for certain uniqueness -->\r\n        </Key>\r\n        <Property Name=\"created\" Type=\"Edm.DateTimeOffset\" Nullable=\"false\" />\r\n        <Property Name=\"group\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <Property Name=\"label\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <Property Name=\"submitted\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\" />\r\n        <Property Name=\"status\" Type=\"Edm.Int32\" Nullable=\"true\" />\r\n        <Property Name=\"error\" Type=\"Edm.String\" Nullable=\"true\" />\r\n      </EntityType>\r\n      <EntityType Name=\"EntityLink\">\r\n        <Key>\r\n          <PropertyRef Name=\"sourceKey\"/>\r\n          <PropertyRef Name=\"targetKey\"/>\r\n        </Key>\r\n        <Property Name=\"sourceKey\" Type=\"Edm.Int64\" Nullable=\"false\" />\r\n        <Property Name=\"targetKey\" Type=\"Edm.Int64\" Nullable=\"false\" />\r\n      </EntityType>\r\n      <EntityContainer Name=\"SystemTables\">\r\n        <EntitySet Name=\"DeltaLinks\" EntityType=\"xscript.sql.DeltaLink\" />\r\n        <EntitySet Name=\"ChangeRows\" EntityType=\"xscript.sql.ChangeRow\" />\r\n        <EntitySet Name=\"ChangeSets\" EntityType=\"xscript.sql.ChangeSet\" />\r\n        <!-- OfflineLinks -->\r\n      </EntityContainer>\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
@end
#endif
#endif

#ifndef imported_SODataV4__ToJSON_public
#define imported_SODataV4__ToJSON_public
/// @brief A utility class for formatting OData values as JSON strings.
///
///
@interface SODataV4_ToJSON : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) complex :(nonnull SODataV4_ComplexValue*)value;
/// @brief Format a complex value as a JSON string, including structural and navigation properties.
///
///
/// @return JSON string.
/// @param value Complex value.
/// @param options (optional) Additional bind options. See `SODataV4_DataContext` constants.
+ (nonnull NSString*) complex :(nonnull SODataV4_ComplexValue*)value :(SODataV4_int)options;
/// @internal
///
+ (nonnull NSString*) complexList :(nonnull SODataV4_ComplexValueList*)value;
/// @brief Format a complex list as a JSON string, including structural and navigation properties.
///
///
/// @return JSON string.
/// @param value Complex list.
/// @param options (optional) Additional bind options. See `SODataV4_DataContext` constants.
+ (nonnull NSString*) complexList :(nonnull SODataV4_ComplexValueList*)value :(SODataV4_int)options;
/// @internal
///
+ (nonnull NSString*) entity :(nonnull SODataV4_EntityValue*)value;
/// @brief Format an entity value as a JSON string, including structural and navigation properties.
///
///
/// @return JSON string.
/// @param value Entity value.
/// @param options (optional) Additional bind options. See `SODataV4_DataContext` constants.
/// 
/// #### Example using proxy classes
/// 
/// ```` oc
/// - (void) jsonEntityExample
/// {
///     NorthwindService* service = self.service;
///     Customer* customer = [Customer new:NO];
///     customer.customerID = @"123";
///     customer.contactName = @"Four Five Six";
///     customer.companyName = @"JSON Inc.";
///     customer.oldEntity = [customer copy];
///     customer.old.contactName = @"One Two Three";
///     [self showCustomer:customer];
///     NSString* json = [SODataV4_ToJSON entity:customer];
///     [Example show:@[json]];
///     Customer* restoredCustomer = [service getCustomer:[SODataV4_FromJSON entity:json]];
///     [self showCustomer:restoredCustomer];
///     [SODataV4_Assert isTrue:[SODataV4_StringOperator equal:[customer toString]:[restoredCustomer toString]]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindProxyClient.xs:890:9"];
///     [SODataV4_Assert isTrue:[SODataV4_StringOperator equal:[customer.old toString]:[restoredCustomer.old toString]]:@"/data/home/ppurple/prod-build18010/w/naasmobile-odata-core-framework/NAAS-Mobile-com.sap.odata.core.framework-OD-darwinintel64_ent_indirectshipment-darwinintel64_ent/src/main/xs/examples/example.NorthwindProxyClient.xs:891:9"];
/// }
/// ````
+ (nonnull NSString*) entity :(nonnull SODataV4_EntityValue*)value :(SODataV4_int)options;
/// @internal
///
+ (nonnull NSString*) entityKey :(nonnull SODataV4_EntityValue*)value;
/// @brief Format an entity value as a JSON string, including only key properties.
///
///
/// @return JSON string.
/// @param value Entity value.
/// @param options (optional) Additional bind options. See `SODataV4_DataContext` constants.
+ (nonnull NSString*) entityKey :(nonnull SODataV4_EntityValue*)value :(SODataV4_int)options;
/// @internal
///
+ (nonnull NSString*) entityList :(nonnull SODataV4_EntityValueList*)value;
/// @brief Format an entity list as a JSON string, including structural and navigation properties.
///
///
/// @return JSON string.
/// @param value Entity list.
/// @param options (optional) Additional bind options. See `SODataV4_DataContext` constants.
+ (nonnull NSString*) entityList :(nonnull SODataV4_EntityValueList*)value :(SODataV4_int)options;
@end
#endif

#ifdef import_SODataV4__ToJSON_private
#ifndef imported_SODataV4__ToJSON_private
#define imported_SODataV4__ToJSON_private
@interface SODataV4_ToJSON (private)
+ (nonnull SODataV4_DataContext*) dataContext :(SODataV4_int)options;
@end
#endif
#endif

#ifdef import_SODataV4__AtomContext_internal
#ifndef imported_SODataV4__AtomContext_internal
#define imported_SODataV4__AtomContext_public
/* internal */
@interface SODataV4_AtomContext : SODataV4_DataContext
{
    @private SODataV4_OnlineODataProvider* _Nonnull dataService_;
    @private NSString* _Nullable cachedServicePath_;
    @private NSString* _Nullable cachedServiceRoot_;
}
- (nonnull id) init;
+ (nonnull SODataV4_AtomContext*) new :(nonnull SODataV4_OnlineODataProvider*)dataService;
/// @internal
///
- (void) _init :(nonnull SODataV4_OnlineODataProvider*)dataService;
- (nullable NSString*) cachedServicePath;
- (nullable NSString*) cachedServiceRoot;
- (nonnull SODataV4_OnlineODataProvider*) dataService;
- (nonnull NSString*) getServicePath;
- (nonnull NSString*) getServiceRoot;
- (void) setCachedServicePath :(nullable NSString*)value;
- (void) setCachedServiceRoot :(nullable NSString*)value;
- (void) setDataService :(nonnull SODataV4_OnlineODataProvider*)value;
@property (nonatomic, readwrite, strong, nullable) NSString* cachedServicePath;
@property (nonatomic, readwrite, strong, nullable) NSString* cachedServiceRoot;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_OnlineODataProvider* dataService;
@end
#endif
#endif

#ifdef import_SODataV4__CloseRequest_internal
#ifndef imported_SODataV4__CloseRequest_internal
#define imported_SODataV4__CloseRequest_public
/* internal */
@interface SODataV4_CloseRequest : SODataV4_RunAction
{
    @private SODataV4_OnlineODataProvider* _Nonnull dataService_;
    @private SODataV4_HttpRequest* _Nonnull httpRequest_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CloseRequest*) new;
/// @internal
///
- (void) _init;
- (nonnull SODataV4_OnlineODataProvider*) dataService;
- (nonnull SODataV4_HttpRequest*) httpRequest;
- (void) run;
- (void) setDataService :(nonnull SODataV4_OnlineODataProvider*)value;
- (void) setHttpRequest :(nonnull SODataV4_HttpRequest*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_OnlineODataProvider* dataService;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpRequest* httpRequest;
@end
#endif
#endif

#ifndef imported_SODataV4__FromJSON_public
#define imported_SODataV4__FromJSON_public
/// @brief A data query subclass for queries that obtain a response from caller-supplied JSON text.
///
///
@interface SODataV4_FromJSON : SODataV4_DataQuery
{
    @private NSString* _Nonnull text_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_FromJSON*) new;
/// @internal
///
- (void) _init;
/// @return A query that obtains a single entity from the provided JSON text.
/// @param text JSON text.
+ (nonnull SODataV4_DataQuery*) entity :(nonnull NSString*)text;
/// @return A query that obtains a single entity from the provided JSON text.
/// @param text JSON text, which is expected to only include key properties.
+ (nonnull SODataV4_DataQuery*) entityKey :(nonnull NSString*)text;
/// @return A query that obtains an entity list from the provided JSON text.
/// @param text JSON text.
+ (nonnull SODataV4_DataQuery*) entityList :(nonnull NSString*)text;
/// @brief Caller-supplied JSON text.
///
///
- (void) setText :(nonnull NSString*)value;
/// @brief Caller-supplied JSON text.
///
///
- (nonnull NSString*) text;
/// @brief Caller-supplied JSON text.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* text;
@end
#endif

#ifdef import_SODataV4__FromJSON_private
#ifndef imported_SODataV4__FromJSON_private
#define imported_SODataV4__FromJSON_private
@interface SODataV4_FromJSON (private)
+ (nonnull SODataV4_FromJSON*) _new1 :(nonnull NSString*)p1 :(SODataV4_boolean)p2;
@end
#endif
#endif

#ifdef import_SODataV4__GetMetadata_internal
#ifndef imported_SODataV4__GetMetadata_internal
#define imported_SODataV4__GetMetadata_public
/* internal */
@interface SODataV4_GetMetadata : SODataV4_CsdlFetcher
{
    @private SODataV4_OnlineODataProvider* _Nonnull provider_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_GetMetadata*) new;
/// @internal
///
- (void) _init;
- (nonnull NSString*) fetch :(nonnull NSString*)uri :(nonnull NSString*)ns;
- (nonnull SODataV4_OnlineODataProvider*) provider;
- (void) setProvider :(nonnull SODataV4_OnlineODataProvider*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_OnlineODataProvider* provider;
@end
#endif
#endif

#ifdef import_SODataV4__JsonContext_internal
#ifndef imported_SODataV4__JsonContext_internal
#define imported_SODataV4__JsonContext_public
/* internal */
@interface SODataV4_JsonContext : SODataV4_DataContext
{
    @private SODataV4_OnlineODataProvider* _Nonnull dataService_;
    @private NSString* _Nullable cachedServicePath_;
    @private NSString* _Nullable cachedServiceRoot_;
}
- (nonnull id) init;
+ (nonnull SODataV4_JsonContext*) new :(nonnull SODataV4_OnlineODataProvider*)dataService;
/// @internal
///
- (void) _init :(nonnull SODataV4_OnlineODataProvider*)dataService;
- (nullable NSString*) cachedServicePath;
- (nullable NSString*) cachedServiceRoot;
- (nonnull SODataV4_OnlineODataProvider*) dataService;
- (nonnull NSString*) getServicePath;
- (nonnull NSString*) getServiceRoot;
- (void) setCachedServicePath :(nullable NSString*)value;
- (void) setCachedServiceRoot :(nullable NSString*)value;
- (void) setDataService :(nonnull SODataV4_OnlineODataProvider*)value;
@property (nonatomic, readwrite, strong, nullable) NSString* cachedServicePath;
@property (nonatomic, readwrite, strong, nullable) NSString* cachedServiceRoot;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_OnlineODataProvider* dataService;
@end
#endif
#endif

#ifdef import_SODataV4__SharedSession_internal
#ifndef imported_SODataV4__SharedSession_internal
#define imported_SODataV4__SharedSession_public
/* internal */
@interface SODataV4_SharedSession : SODataV4_DataSession
{
    @private SODataV4_HttpCookies* _Nonnull sharedCookies_;
    @private SODataV4_HttpHeaders* _Nonnull sharedHeaders_;
    @private SODataV4_LoginCredentials* _Nullable sharedCredentials_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_SharedSession*) new;
/// @internal
///
- (void) _init;
- (nonnull SODataV4_HttpCookies*) httpCookies;
- (nonnull SODataV4_HttpHeaders*) httpHeaders;
- (nullable SODataV4_LoginCredentials*) loginCredentials;
- (void) setLoginCredentials :(nullable SODataV4_LoginCredentials*)value;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpCookies* httpCookies;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpHeaders* httpHeaders;
@property (nonatomic, readwrite, strong, nullable) SODataV4_LoginCredentials* loginCredentials;
@end
#endif
#endif

#ifdef import_SODataV4__SharedSession_private
#ifndef imported_SODataV4__SharedSession_private
#define imported_SODataV4__SharedSession_private
@interface SODataV4_SharedSession (private)
- (void) setSharedCredentials :(nullable SODataV4_LoginCredentials*)value;
- (nonnull SODataV4_HttpCookies*) sharedCookies;
- (nullable SODataV4_LoginCredentials*) sharedCredentials;
- (nonnull SODataV4_HttpHeaders*) sharedHeaders;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpCookies* sharedCookies;
@property (atomic, readwrite, strong, nullable) SODataV4_LoginCredentials* sharedCredentials;
@property (nonatomic, readonly, strong, nonnull) SODataV4_HttpHeaders* sharedHeaders;
@end
#endif
#endif

#ifdef import_SODataV4__GetByteStream_internal
#ifndef imported_SODataV4__GetByteStream_internal
#define imported_SODataV4__GetByteStream_public
/* internal */
/// @brief A byte stream implemented via GET of an HTTP resource.
///
///
@interface SODataV4_GetByteStream : SODataV4_ByteStream
{
    @private SODataV4_OnlineODataProvider* _Nonnull dataService_;
    @private SODataV4_HttpRequest* _Nonnull httpRequest_;
    @private SODataV4_ByteStream* _Nonnull innerStream_;
    @private SODataV4_long startTime_;
    @private SODataV4_DataMetric* _Nullable timeTaken_;
    @private SODataV4_DataMetric* _Nullable bytesRead_;
    @private SODataV4_DataMetric* _Nullable gzipBytes_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_GetByteStream*) new;
/// @internal
///
- (void) _init;
- (nullable SODataV4_DataMetric*) bytesRead;
- (void) close;
- (nonnull SODataV4_OnlineODataProvider*) dataService;
- (nullable SODataV4_DataMetric*) gzipBytes;
- (nonnull SODataV4_HttpRequest*) httpRequest;
- (nonnull SODataV4_ByteStream*) innerStream;
/// @internal
///
- (nullable NSData*) readBinary;
- (nullable NSData*) readBinary :(SODataV4_int)length;
- (SODataV4_int) readByte;
- (void) setBytesRead :(nullable SODataV4_DataMetric*)value;
- (void) setDataService :(nonnull SODataV4_OnlineODataProvider*)value;
- (void) setGzipBytes :(nullable SODataV4_DataMetric*)value;
- (void) setHttpRequest :(nonnull SODataV4_HttpRequest*)value;
- (void) setInnerStream :(nonnull SODataV4_ByteStream*)value;
- (void) setStartTime :(SODataV4_long)value;
- (void) setTimeTaken :(nullable SODataV4_DataMetric*)value;
- (SODataV4_long) startTime;
- (nullable SODataV4_DataMetric*) timeTaken;
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataMetric* bytesRead;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_OnlineODataProvider* dataService;
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataMetric* gzipBytes;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpRequest* httpRequest;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ByteStream* innerStream;
@property (nonatomic, readwrite) SODataV4_long startTime;
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataMetric* timeTaken;
@end
#endif
#endif

#ifdef import_SODataV4__GetCharStream_internal
#ifndef imported_SODataV4__GetCharStream_internal
#define imported_SODataV4__GetCharStream_public
/* internal */
/// @brief A character stream implemented via GET of an HTTP resource.
///
///
@interface SODataV4_GetCharStream : SODataV4_CharStream
{
    @private SODataV4_OnlineODataProvider* _Nonnull dataService_;
    @private SODataV4_HttpRequest* _Nonnull httpRequest_;
    @private SODataV4_CharStream* _Nonnull innerStream_;
    @private SODataV4_long startTime_;
    @private SODataV4_DataMetric* _Nullable timeTaken_;
    @private SODataV4_DataMetric* _Nullable bytesRead_;
    @private SODataV4_DataMetric* _Nullable gzipBytes_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_GetCharStream*) new;
/// @internal
///
- (void) _init;
- (nullable SODataV4_DataMetric*) bytesRead;
- (void) close;
- (nonnull SODataV4_OnlineODataProvider*) dataService;
- (nullable SODataV4_DataMetric*) gzipBytes;
- (nonnull SODataV4_HttpRequest*) httpRequest;
- (nonnull SODataV4_CharStream*) innerStream;
- (SODataV4_int) readChar;
/// @internal
///
- (nullable NSString*) readString;
- (nullable NSString*) readString :(SODataV4_int)length;
- (void) setBytesRead :(nullable SODataV4_DataMetric*)value;
- (void) setDataService :(nonnull SODataV4_OnlineODataProvider*)value;
- (void) setGzipBytes :(nullable SODataV4_DataMetric*)value;
- (void) setHttpRequest :(nonnull SODataV4_HttpRequest*)value;
- (void) setInnerStream :(nonnull SODataV4_CharStream*)value;
- (void) setStartTime :(SODataV4_long)value;
- (void) setTimeTaken :(nullable SODataV4_DataMetric*)value;
- (SODataV4_long) startTime;
- (nullable SODataV4_DataMetric*) timeTaken;
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataMetric* bytesRead;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_OnlineODataProvider* dataService;
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataMetric* gzipBytes;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpRequest* httpRequest;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CharStream* innerStream;
@property (nonatomic, readwrite) SODataV4_long startTime;
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataMetric* timeTaken;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ChangeSet_in_data_internal
#ifndef imported_SODataV4__Any_as_data_ChangeSet_in_data_internal
#define imported_SODataV4__Any_as_data_ChangeSet_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ChangeSet_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ChangeSet*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DataQuery_in_data_internal
#ifndef imported_SODataV4__Any_as_data_DataQuery_in_data_internal
#define imported_SODataV4__Any_as_data_DataQuery_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DataQuery_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DataQuery*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DeltaStream_in_data_internal
#ifndef imported_SODataV4__Any_as_data_DeltaStream_in_data_internal
#define imported_SODataV4__Any_as_data_DeltaStream_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DeltaStream_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DeltaStream*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_RequestOptions_in_data_internal
#ifndef imported_SODataV4__Any_as_data_RequestOptions_in_data_internal
#define imported_SODataV4__Any_as_data_RequestOptions_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_RequestOptions_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_RequestOptions*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_http_HttpHeaders_in_data_internal
#ifndef imported_SODataV4__Any_as_http_HttpHeaders_in_data_internal
#define imported_SODataV4__Any_as_http_HttpHeaders_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_http_HttpHeaders_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_HttpHeaders*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__List_count_EntityValueList_in_data_internal
#ifndef imported_SODataV4__List_count_EntityValueList_in_data_internal
#define imported_SODataV4__List_count_EntityValueList_in_data_public
/* internal */
@interface SODataV4_List_count_EntityValueList_in_data : SODataV4_ObjectBase
{
}
/// @brief Count items in a list matching a predicate.
///
///
/// @return Matching count.
/// @param value List to be processed.
/// @param fun Item predicate.
+ (SODataV4_int) call :(nonnull SODataV4_EntityValueList*)value :(SODataV4_boolean(^ _Nonnull)(SODataV4_EntityValue* _Nonnull))fun;
@end
#endif
#endif

#ifdef import_SODataV4__List_filter_EntityValueList_in_data_internal
#ifndef imported_SODataV4__List_filter_EntityValueList_in_data_internal
#define imported_SODataV4__List_filter_EntityValueList_in_data_public
/* internal */
@interface SODataV4_List_filter_EntityValueList_in_data : SODataV4_ObjectBase
{
}
/// @brief Filter a list using an arrow function for item filtering.
///
///
/// @return New filtered list.
/// @param value List to be filtered.
/// @param fun Arrow function for item filtering.
+ (nonnull SODataV4_EntityValueList*) call :(nonnull SODataV4_EntityValueList*)value :(SODataV4_boolean(^ _Nonnull)(SODataV4_EntityValue* _Nonnull))fun;
@end
#endif
#endif

#ifdef import_SODataV4__List_filter_PropertyList_in_data_internal
#ifndef imported_SODataV4__List_filter_PropertyList_in_data_internal
#define imported_SODataV4__List_filter_PropertyList_in_data_public
/* internal */
@interface SODataV4_List_filter_PropertyList_in_data : SODataV4_ObjectBase
{
}
/// @brief Filter a list using an arrow function for item filtering.
///
///
/// @return New filtered list.
/// @param value List to be filtered.
/// @param fun Arrow function for item filtering.
+ (nonnull SODataV4_PropertyList*) call :(nonnull SODataV4_PropertyList*)value :(SODataV4_boolean(^ _Nonnull)(SODataV4_Property* _Nonnull))fun;
@end
#endif
#endif

#endif
