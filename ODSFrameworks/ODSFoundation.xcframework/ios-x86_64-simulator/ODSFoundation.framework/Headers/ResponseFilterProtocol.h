//
//  ResponsePluginProtocol.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpConversationManager;

/**
 Block type used by response filters. It is called at the very end of response post-processing by a given filter. If the argument is set to YES then no other
 filters are invoked in the chain and the conversation is restarted immediately.
 
 @param shouldRestartRequest if YES then the conversation is restarted immediately, NO keeps it running
 */
typedef void (^response_filter_completion_t)(BOOL shouldRestartRequest);

/**
 Response filter protocol which can be implemented by classes which want to perform HTTP response post-processing. Objects of this type can
 be configured on a <code>HttpConversationManager</code> which will call them in a chain before finally returning the response to the caller
 who originally started the conversation.
 <p>
 Each response filter has the power to restart the conversation. This is an important feature leveraged by response filters which implement
 some kind of authentication mechanisms and respond to challenges which cannot be handled using a <code>ChallengeFilterProtocol</code> object.
 </p>
 <p>
 Implementations are recommended to be stateless and not store any internal state as properties or ivars. This is because a filter of this type might be invoked
 by different threads if multiple conversations are running at the same time. If there's a need to store conversation-specific state for whatever reasons then
 use the <code>HttpConversationContextProtocol</code> and the <code>HttpConversation</code> category of the <code>NSHTTPURLResponse</code> class which implements
 that protocol. It contains methods for storing arbitrary object in conversation scope.
 </p>
*/
@protocol ResponseFilterProtocol <NSObject>

/**
 Processes the received response which can always be cast to the <code>NSHTTPURLResponse</code> type. The specified manager has the 
 same session configuration as the one which executes this filter currently.

 @param urlResponse contains the HTTP response, must be non-nil
 @param responseData contains the data returned for the finished request, must be non-nil
 @param conversationManager copy of HttpConversationManager instance, can be used for starting additional requests, must be non-nil
 @param completionBlock block to invoke at the end of response post-processing, must be non-nil
*/
-(void)processResponse:(NSURLResponse*)urlResponse responseData:(NSData*)responseData
       conversationManager:(HttpConversationManager*)conversationManager
       completionBlock:(response_filter_completion_t)completionBlock;

@end
