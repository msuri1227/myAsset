//
//  SODataResponse.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

/**
 Representation for an OData response. This can be either a single response ODataResponseSingle or a batch response ODataResponseBatch.
*/
@protocol SODataResponse <NSObject>

/**
 Constants for headers dictionary keys
 */
#define kSODataResponseHeaderCode @"http.code"
#define kSODataResponseHeaderLocation @"http.location"
#define kSODataResponseHeaderETag @"http.etag"
#define kSODataResponseHeaderContentType @"http.content-type"
#define kSODataResponseHeaderContentLength @"http.content-length"

/**
 The customTag.
 */
@property (readonly, nonatomic, copy) NSString* customTag;

/**
 Headers dictionary which contains all the response headers.
 */
@property (readonly, nonatomic, strong) NSMutableDictionary* headers;

/**
 Indicates whether the response is batch or not.
 */
@property (readonly, nonatomic, assign) BOOL isBatch;

@end
