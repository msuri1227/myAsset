// *****************************************************
// Copyright (c) 2013 SAP AG or an SAP affiliate company. All rights reserved.
// *****************************************************

@class SODataOfflineStore;
#import "SODataRequestExecution.h"

/**
 * A delegate used to get notifications about requests that failed against the backend OData Producer.
 * Modify requests executed against the Offline Store are applied to the local store and are stored in the request queue.
 * When the request queue is flushed by invoking scheduleFlushQueuedRequestsWithDelegate these pending requests are 
 * sent to the server and applied to the backend OData Producer.
 * In the event that one of these flushed requests fails against the backend OData Producer the details of the request
 * are stored in the Error Archive and this delegate is called.
 * Note that the flush operation will report a successful result even if some requests have failed against the backend OData Producer.
 */
@protocol SODataOfflineStoreRequestErrorDelegate <NSObject>
@required
/**
 * During a flush, called once for each request that fails against the backend OData Producer.
 *
 * @param store the Offline Store being flushed
 * @param requestExecution the request execution object for the request that failed
 * @param error the reason for the request failure
 */
- (void) offlineStoreRequestFailed:(SODataOfflineStore*) store
                           request:(id<SODataRequestExecution>) requestExecution 
                             error:(NSError*) error;
@end


