// *****************************************************
// Copyright (c) 2013 SAP AG or an SAP affiliate company. All rights reserved.
// *

typedef enum SODataOfflineProgressState {
    /**
     * Downloading offline store.
     */
    SODataStoreDownloading,

    /**
     * Refreshing offline store.
     */
    SODataStoreRefreshing,

    /**
     * Offline store schema upgraded.
     */
    SODataStoreSchemaUpgraded,

    /**
     * Flushing request queue.
     */
    SODataStoreFlushingRequestQueue,

    /*
     * Sending offline store.
     */
    SODataStoreSending,

    /**
     * Opening, Refreshing, FlusingRequestQueue progress is completed.
     */
    SODataStoreDone
} SODataOfflineProgressState;

/**
 * Offline OData store progress status.
 * This progress status contains updates from Offline Store during opening, refresh and flush request queue.
 */

typedef struct SODataOfflineProgressStatus
{
    /**
     * Number of bytes sent to server
     */
    unsigned long long int      BytesSent;

    /**
     * Number of bytes received from server
     */
    unsigned long long int      BytesRecv;

    /**
     * Store size in number of bytes
     */
    unsigned long long int      FileSize;

    /**
     * Progress state
     */
    SODataOfflineProgressState  ProgressState;
} SODataOfflineProgressStatus; 

