// *****************************************************
// Copyright (c) 2013 SAP AG or an SAP affiliate company. All rights reserved.
// *****************************************************

#import "SODataOfflineProgressStatus.h"

@class SODataOfflineStore;

/**
 * A delegate used to get progress updates of a flush operation.
 * A flush operation is considered a success if the flush process 
 * succeeds.  The flush process may report a success even if some pending requests being flushed fail 
 * against the backend OData Producer.
 * Set a request error delegate or check the Error Archive to be notified if pending
 * requests have failed.
 *
 */
@protocol SODataOfflineStoreFlushDelegate <NSObject>
@optional
/**
 * Called when a flush operation has started.
 *
 * @param store the Offline Store being flushed
 */
- (void) offlineStoreFlushStarted:(SODataOfflineStore*) store;
/**
 * Called when a flush operation has finished.
 * Guaranteed to be invoked at the end of the flush processing regardless of the outcome of the flush.
 *
 * @param store the Offline Store being flushed
 */
- (void) offlineStoreFlushFinished:(SODataOfflineStore*) store;

/**
 * Called every time when there is an update while the store is being flushed.
 *
 * @param store the Offline Store being flushed.
 * @param progressStatus the progress status updated from store.
 */
- (void) offlineStoreFlush: (SODataOfflineStore*) store
            progressStatus: (SODataOfflineProgressStatus) progressStatus;
@required
/**
 * Called when a flush operation has finished successfully.
 *
 * @param store the Offline Store being flushed
 */
- (void) offlineStoreFlushSucceeded:(SODataOfflineStore*) store;
/**
 * Called when a flush operation has failed.
 *
 * @param store the Offline Store being flushed
 * @param error the error that occurred 
 */
- (void) offlineStoreFlushFailed:(SODataOfflineStore*) store
                           error:(NSError*) error;
@end


