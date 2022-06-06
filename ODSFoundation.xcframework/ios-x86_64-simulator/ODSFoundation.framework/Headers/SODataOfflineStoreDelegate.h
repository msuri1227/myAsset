// *****************************************************
// Copyright (c) 2013 SAP AG or an SAP affiliate company. All rights reserved.
// *****************************************************

#import "SODataOfflineProgressStatus.h"

@class SODataOfflineStore;

/**
 * Offline OData store opening states.
 * These states represent the major activities during initialization and opening of the Offline Store.
 */
typedef enum SODataOfflineStoreState {
    /** The store has started to open */
    SODataOfflineStoreOpening,
    /** Initializing the resources for a new store */
    SODataOfflineStoreInitializing,
    /** Populating the store */
    SODataOfflineStorePopulating,
    /** Downloading the store */
    SODataOfflineStoreDownloading,
    /** The store has opened successfully */
    SODataOfflineStoreOpen,
    /** The store has been closed by the user while opening */
    SODataOfflineStoreClosed
} SODataOfflineStoreState;

/**
 * Offline OData store notifications.
 * Notifications are hints to the application about the current state of the Offline Store.
 * They indicate that either a refresh or flush operation was previously interrupted and 
 * may be recovered if performed again.
 */
typedef enum SODataOfflineStoreNotification {
    /** The store was closed while performing a refresh.  
     * It may be possible to continue the pending refresh by triggering a new refresh. */
    SODataOfflineStorePendingRefresh,
    /** The store was closed while flushing the request queue.  
     * It may be possible to continue the pending flush by triggering a new flush. */
    SODataOfflineStorePendingFlush,     
} SODataOfflineStoreNotification;

/**
 * A delegate used to get progress updates while an Offline Store is opening.
 */
@protocol SODataOfflineStoreDelegate <NSObject>
@required

/**
 * Called whenever the store state changes during the initialization and opening of the Offline Store.
 *
 * @param store the Offline Store being opened
 * @param newState the new state of the store
 *
 * \sa SODataOfflineStoreState
 */
- (void) offlineStoreStateChanged:(SODataOfflineStore*) store 
                            state:(SODataOfflineStoreState) newState;
/**
 * Called if the store fails to open
 *
 * @param store the Offline Store being opened
 * @param error the error that occurred 
 */
- (void) offlineStoreOpenFailed:(SODataOfflineStore*) store
                          error:(NSError*) error;
@optional
/**
 * Called when the store finishes opening.
 * This is guaranteed to be invoked at the end of the open processing regardless of the outcome of the open.
 *
 * @param store the Offline Store being opened
 */
- (void) offlineStoreOpenFinished:(SODataOfflineStore*) store;
/**
 * Called once for each notification that is available while opening the store.
 *
 * @param store the Offline Store being opened
 * @param notification the notification
 *
 * \sa SODataOfflineStoreNotification
 */
- (void) offlineStoreNotification:(SODataOfflineStore*) store
                     notification:(SODataOfflineStoreNotification) notification;

/**
 * Called every time when there is an update while the store is being opened.
 *
 * @param store the Offline Store being opened.
 * @param progressStatus the progress status updated from store.
 */
- (void) offlineStoreOpen:(SODataOfflineStore*) store
           progressStatus:(SODataOfflineProgressStatus) progressStatus;
@end

