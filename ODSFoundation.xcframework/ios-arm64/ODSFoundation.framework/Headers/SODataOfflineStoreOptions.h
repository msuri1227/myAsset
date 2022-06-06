// *****************************************************
// Copyright (c) 2013 SAP AG or an SAP affiliate company. All rights reserved.
// *****************************************************

#import <Foundation/Foundation.h>

@class HttpConversationManager;

/**
 * An Offline Store Options object contains the configuration details required
 * to open an Offline Store.
 *
 */
@interface SODataOfflineStoreOptions : NSObject

/**
 * An HTTP Conversation Manager to handle network authentication.
 * This is a required property.
 */
@property(atomic,strong)        HttpConversationManager * conversationManager;
/**
 * The service root of the OData Producer.
 * When the server is an instance of SMP or Hana Mobile Cloud this value depends on the "Rewrite Mode" configuration in server application.
 * If Rewrite Mode is set to "Rewrite URL in SMP/SAPcpms" then this is the name of the application backend connector.
 * If Rewrite Mode is set to "Rewrite URL in Backend System" then this is the path of the backend OData endpoint.
 *
 * For example, if the application is configured with a connector named "myconn" to an OData endpoint of "http://myhost:80/odata/endpoint"
 * then the serviceRoot should be "myconn" for "Rewrite URL in SMP/SAPcpms" and "odata/endpoint" for "Rewrite URL in Backend System".
 * 
 * This is a required property.
 */
@property(atomic,copy)          NSString*               serviceRoot;
/**
 * A dictionary of defining requests.  
 * The keys (names) of the defining requests are arbitrary and are used when performing refreshes with subsets.
 * The values (requests) are defining request URLs.
 * This is a required property.
 *
 * A defining request is an OData read request that targets the OData endpoint associated with the Offline Store 
 * and retrieves a subset of the OData endpoint data. Multiple defining requests can be defined for each OData endpoint.
 * Defining requests are a subset of data from the OData Producer that is sent to the client, either during initialization 
 * of the Offline Store or during a refresh.
 * 
 * Note that defining requests become fixed for an Offline Store the first time it is opened.  
 *
 */
@property(atomic,readonly)      NSMutableDictionary*    definingRequests __attribute__((deprecated));
/**
 * An arbitrary name to identify this store.
 * This is an optional property. 
 * If omitted a default name will be chosen.
 */
@property(atomic,copy)          NSString*               storeName;
/**
 * The file system path to store the local data store.
 * This is an optional property. 
 * If omitted a default location will be chosen.
 */
@property(atomic,copy)          NSString*               storePath;
/**
 * A key to use to encrypt the local data store.
 * This is an optional property. 
 * WARNING: If this property is omitted the store will be created without 
 * encrypting the data on the device.
 *
 */
@property(atomic,copy)          NSString*               storeEncryptionKey;
/**
 * The host of the server.
 * This is a required property.
 */
@property(atomic,copy)          NSString*               host;
/**
 * The port of the server.
 * This is a required property.
 */
@property(atomic,assign)        NSInteger               port;
/**
 * The URL suffix path to the server.
 * Specify the suffix to add to the URL of each HTTP request sent to the server.
 * When connecting through a proxy or web server, the urlSuffix may be necessary to find the server.
 * This is an optional property. 
 */
@property(atomic,copy)          NSString*               urlSuffix;
/**
 * Additional advanced stream parameters.
 * This is an optional property. 
 */
@property(atomic,copy)          NSString*               extraStreamParms;
/**
 * A dictionary of custom headers to add to all HTTP communications.
 * These are added to HTTP requests between the Offline Store and server
 * and to HTTP requests between the server and the backend OData Producer.
 * The keys are header names.
 * The values are header values.
 * This is an optional property. 
 */
@property(atomic,readonly)      NSMutableDictionary*    customHeaders;
/**
 * A dictionary of custom cookies to add to all HTTP communications.
 * These are added to HTTP requests between the Offline Store and server
 * and to HTTP requests between the server and the backend OData Producer.
 * The keys are cookie names.
 * The values are cookie values.
 * This is an optional property. 
 */
@property(atomic,readonly)      NSMutableDictionary*    customCookies;
/**
 * Specifies whether to use HTTP or HTTPS to communicate with the server.
 * This is an optional property. 
 * The default is to use unencrypted HTTP.
 */
@property(atomic,assign)        bool                    enableHttps;
/**
 * Specifies whether the backend OData Producer supports repeatable requests.
 *
 * Repeatable requests (or idempotent requests) is a feature of some OData Producers that ensures
 * OData requests are applied only once even if they are received multiple times.
 * This is useful in cases where OData responses may be lost due to intermittent network connectivity
 * and is required by the Offline Store in order to guarantee that requests are applied exactly once
 * to the backend OData Producer.
 */
@property(atomic,assign)        bool                    enableRepeatableRequests;
/**
 * Specifies the maximum number of entities that can be returned in a single read request.
 *
 * Reading an entity set will return at most this many entities in its response payload.  
 * If the response is a partial set of entities then a "next link" to the next part of the response will be provided.
 */
@property(atomic,assign)        NSInteger               pageSize;
/**
 * Specifies whether or not the backend server supports bind operations. If the server does not support bind
 * operations, the following will occur if a bind operation is used:
 *
 * 1) If the bind operation is included in a dependent entity for a relationship that specifies a referential
 *    constraint, the bind operation will be replaced by setting the dependent properties directly.
 *
 * 2) If the bind operation is included in a principal entity for a relationship that specifies a referential
 *    constraint, the request will be rejected with an error.
 *
 * 3) If the bind operation is included in an entity for a relationship that does not specify a referential
 *    constraint, the relationship will be created locally but the bind will be omitted from the request that
 *    is sent to the OData backend.
 */
@property(atomic,assign)        bool                    serverSupportsBind;
/**
 * Specifies whether or not to enable deleting of individual entities from
 * the ErrorArchive; the entity set which contains information about failed
 * requests during the last upload.
 * <p>
 * The value is 'false' by default.
 * <p>
 * By default, when one failed request is deleted from the ErrorArchive, the
 * whole entity set is cleared along with the associated requests in the request
 * queue.  By setting this option to 'true', the app can choose exactly which
 * failed requests to delete.  Deleting an individual failed request from the
 * ErrorArchive will cause that request and any following requests in the request
 * queue (sent or unsent) that depend on the failed request to be deleted as
 * well.
 * <p>
 * For example, imagine the following requests are made by the app
 * some of which fail when they are executed on the backend:
 * <p>
 * <pre>
 * {@code
 *
 * // Request 1: Update customer101 which will fail in the backend
 * offlineODataProvider.updateEntity( customer101, HttpHeaders.empty, RequestOptions.none );
 *
 * // Request 2: Update customer102 which will fail in the backend
 * offlineODataProvider.updateEntity( customer102, HttpHeaders.empty, RequestOptions.none );
 *
 * // Request 3: Update customer101 again
 * offlineODataProvider.updateEntity( customer101, HttpHeaders.empty, RequestOptions.none );
 *
 * // Upload requests 1 - 3
 * offlineODataProvider.upload( successHandler, failureHandler );
 *
 * // Request 4: Update customer102 again
 * offlineODataProvider.updateEntity( customer102, HttpHeaders.empty, RequestOptions.none );
 * }</pre>
 * <p>
 * During the upload, the first two requests fail due to issues in the backend.
 * The third request (the second customer101 update) will not be sent to the
 * backend at all because a request it depends on (the first customer101 update)
 * failed.  At the end of the upload, the ErrorArchive will have three error
 * requests, one for each failed request in the upload.
 * <p>
 * With enableIndividualErrorArchiveDeletion set to 'false', deleting any entity
 * from the ErrorArchive will result in requests 1, 2, and 3 being removed but
 * will leave request 4 in the request queue unchanged.
 * <p>
 * With enableIndividualErrorArchiveDeletion set to 'true', the app decides which
 * failed requests to delete explicitly.  If the app chooses to delete failed
 * request 3, request 3 is the only request that will be deleted because no other
 * requests after it in the request queue depend on it.  If the app chooses to
 * delete failed request 1, both request 1 and request 3 will be removed from the
 * request queue because request 3 depends on request 1.  If failed request 2 is
 * deleted, both request 2 and request 4 will be deleted because even though
 * request 4 has not yet been upload, it depends on request 2.
 * @return 'true' if enabled deleting individual request error entity.
 */
@property(atomic,assign)        bool                    enableIndividualErrorArchiveDeletion;
/**
 * Adds a new defining request.
 * A defining request is an OData read request that targets the OData endpoint associated with the Offline Store 
 * and retrieves a subset of the OData endpoint data. Multiple defining requests can be defined for each OData endpoint.
 * Defining requests are a subset of data from the OData Producer that is sent to the client, either during initialization 
 * of the Offline Store or during a refresh.
 * 
 * Note that defining requests become fixed for an Offline Store the first time it is opened.  
 *
 * @param name an arbitrary and unique name associated with the defining request.  The name is used to refresh subsets of defining requests.
 * @param url the URL of the GET request used to target the data to store offline.
 * @param retrieveStreams whether to retrieve and store any media streams associated with the data targeted by this defining request.
 *            This must be set to false if the URL does not target any media entities.
 *
 */
- (void) addDefiningRequestWithName:(NSString*)name
                                url:(NSString*) url
                    retrieveStreams:(bool) retrieveStreams;


@end

