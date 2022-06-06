//
//  SODataRequestParamSingle.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"
#import "SODataRequestParam.h"
#import "SODataRequestBatchItem.h"

/**
 Mode enumeration. It can be:
 Read - represents an OData read operation (HTTP GET)
 Create - represents an OData create operation (HTTP POST)
 Update - represents an OData update operation (HTTP PUT)
 Patch - represents an OData update operation (HTTP MERGE)
 Delete - represents an OData update operation (HTTP DELETE)
 */
typedef enum SODataRequestModes {
    SODataRequestModeRead = 1,
    SODataRequestModeCreate = 2,
    SODataRequestModeUpdate = 3,
    SODataRequestModePatch = 4,
    SODataRequestModeDelete = 5
} SODataRequestModes;

/**
 Request options.
 */
#define kSODataUseCache @"com.sap.client.option.UseCache"

@protocol SODataPayload;

/**
 ODataRequestParamSingle defines a single request used to perform a CRUD operation.
 */
@protocol SODataRequestParamSingle <SODataRequestParam, SODataRequestBatchItem>

/**
 The mode of the request. \sa SODataRequestModes
 */
@property (readonly, nonatomic, assign) SODataRequestModes mode;

/**
 Custom values associated with the request
 */
@property (nonatomic, strong) NSDictionary* options;

/**
 The resource path of the request.
 */
@property (readonly, nonatomic, copy) NSString* resourcePath;

/**
 The payload (see ODataPayload) of the request.
 */
@property (nonatomic, strong) id<SODataPayload> payload;

/**
 Identifier of the content.
 */
@property (nonatomic, copy) NSString* contentID;

/**
 The ETag of the request.
 */
@property (nonatomic, copy) NSString* etag;

/**
 * Constructor method with request mode and resourcePath
 */
- (instancetype)initWithMode:(SODataRequestModes)mode resourcePath:(NSString*)resourcePath;

@end
