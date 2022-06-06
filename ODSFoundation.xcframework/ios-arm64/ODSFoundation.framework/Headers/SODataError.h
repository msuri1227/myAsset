//
//  SODataError.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

/**
 Represents an error reported by the server over OData.
 */
@protocol SODataError <SODataPayload>

/**
 The reported error code.
 */
@property (readonly, nonatomic, copy) NSString* code;

/**
 Detailed message of the error.
 */
@property (readonly, nonatomic, copy) NSString* message;

@end
