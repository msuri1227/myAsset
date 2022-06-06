// *****************************************************
// Copyright (c) 2013 SAP AG or an SAP affiliate company. All rights reserved.
// *****************************************************

#import "SODataOfflineProgressStatus.h"

@class SODataOfflineStore;

/**
 * A delegate used to get progress updates of a refresh operation.
 */
@protocol SODataOfflineStoreRefreshDelegate <NSObject>
@optional
/**
 * Called when a refresh has started
 *
 * @param store the Offline Store being refreshed
 */
- (void) offlineStoreRefreshStarted:(SODataOfflineStore*) store;
/**
 * Called when a refresh has finished.
 * Guaranteed to be invoked at the end of the refresh processing regardless of the outcome of the refresh.
 *
 * @param store the Offline Store being refreshed
 */
- (void) offlineStoreRefreshFinished:(SODataOfflineStore*) store;

/**
 * Called every time when there is an update while the store is being refreshed.
 *
 * @param store the Offline Store being refreshed.
 * @param progressStatus the progress status updated from store.
 */
- (void) offlineStoreRefresh:(SODataOfflineStore*) store
              progressStatus:(SODataOfflineProgressStatus) progressStatus;
@required
/**
 * Called when a refresh has finished successfully
 *
 * @param store the Offline Store being refreshed
 */
- (void) offlineStoreRefreshSucceeded:(SODataOfflineStore*) store;
/**
 * Called when a refresh has failed
 *
 * @param store the Offline Store being refreshed
 * @param error the error that occurred 
 */
- (void) offlineStoreRefreshFailed:(SODataOfflineStore*) store
                             error:(NSError*) error;
@end

