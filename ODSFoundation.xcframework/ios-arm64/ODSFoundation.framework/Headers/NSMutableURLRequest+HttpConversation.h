//
//  NSMutableURLRequest+HttpConversation.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpConversationConstants.h"
#import "HttpConversationContextProtocol.h"

/**
 Special block type used by <code>NSMutableURLRequest</code> when doing upload requests. This method can be used with
 <code>executeStreamedUploadRequest:completionHandler:</code> of <code>HttpConversationManager</code> to (re-)create
 the input stream when the conversation is restarted.
 <p>
 This block is expected to always produce a valid stream. A nil return value yields undefined behaviour.
 </p>

 @return the input stream, not yet opened, always non-nil
 */
typedef NSInputStream* (^input_stream_creator_t)();

/**
 ChangeSet definition
*/
@interface ChangeSet : NSObject

@property (strong) NSMutableArray* changeRequests;

@end

/**
 Category extension for <code>NSMutableURLRequest</code> to support batch request sending and the conversation context protocol.
 */
@interface NSMutableURLRequest (HttpConversation) <HttpConversationContextProtocol>

/**
 Contains batch requests, which are NSMutableURLRequest instances
 */
@property (strong) NSMutableArray* batchElements;

/**
 Defines where to put the Content-ID within the request; only applies for batch requests

 @remark Some server implementations may fail with the default setting, which is ContentIdLocationMultipart as of SMP SDK 3.0 SP11; in such cases try to override the default by
         setting this property to ContentIdLocationSingle. For details check the specification at http://www.odata.org/documentation/odata-version-2-0/batch-processing/ -> 2.2.1. 
         Referencing Requests in a Change Set
 @see SODataOnlineStoreOptions, SODataRequestExecutionBatchDefault
 */
@property(assign, nonatomic) SDContentIDLocations contentIDLocation;

/**
 Optional input stream creator. Very handy in case of streamed uploads if one must account for conversation restarts.
 */
@property (nonatomic, strong) input_stream_creator_t inputStreamCreator;

/**
 Generates batch request content, call before sending a batch request
 */
-(void) prepareBatchRequest;

/**
 Makes a copy of the specified request using <code>mutableCopy</code> but taking care of the additional
 properties this category adds to the <code>NSMutableURLRequest</code> class.

 @param request the request object to copy, must be non-nil
 @param zone the zone to use during copying, can be nil
 @return the mutable copy of the specified request with the additional properties taken care of, always non-nil
 */
+(instancetype)mutableCopyWithAdditionalProperties:(NSURLRequest*)request withZone:(NSZone*)zone;

@end
