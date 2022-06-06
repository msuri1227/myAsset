//
//  SODataResponseSingle.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataResponse.h"
#import "SODataResponseBatchItem.h"

/**
 ODataResponseSingle defines a single response as the result of a single request (ODataRequestParamSingle).
 */
@protocol SODataResponseSingle <SODataResponse, SODataResponseBatchItem>

/**
 Payload of the response @see SODataPayload
 */
@property (readonly, nonatomic, strong) id<SODataPayload> payload;

/**
 Type of the response payload. \sa SODataTypes
 */
@property (readonly, nonatomic, assign) SODataTypes payloadType;

@end
