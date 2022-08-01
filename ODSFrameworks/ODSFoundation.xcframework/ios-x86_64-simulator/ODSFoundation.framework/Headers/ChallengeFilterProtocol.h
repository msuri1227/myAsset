//
//  ChallengeFilterProtocol.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpConversationManager;

/**
 Block type used by challenge filters. A block of this type is called once with the results of the filter execution.
 
 @param useCredential if YES then the specified credentials are going to be used. If NO is specified then the next filter is invoked and the credential argument is discarded.
 @param credential the credential object to respond to the challenge with. If nil then the <code>NSURLSession</code> will try to handle it at its own discretion.
 */
typedef void (^challenge_filter_completion_t)(BOOL useCredential, NSURLCredential* credential);

/**
 A challenge filter is a special kind of object that can be added to a <code>HttpConversationManager</code>. It is invoked whenever the request processing
 runs into task-level authentication challenges supported by <code>NSURLSession</code> out of the box.
 <p>
 During challenge processing, a chain of these filters get invoked and the first one to handle the challenge wins. If the conversation manager runs out of
 challenge filters then it either tries default handling or, if it's not possible, cancels the conversation. 
 </p>
 <p>
 Implementations are recommended to be stateless and not store any internal state as properties or ivars. This is because a filter of this type might be invoked
 by different threads if multiple conversations are running at the same time. If there's a need to store conversation-specific state for whatever reasons then
 use the <code>HttpConversationContextProtocol</code> and the <code>HttpConversation</code> category of the <code>NSURLAuthenticationChallenge</code> class which implements
 that protocol. It contains methods for storing arbitrary object in conversation scope.
 </p>
 */
@protocol ChallengeFilterProtocol <NSObject>

/**
 This method is called when an authentication challenge is detected. The specified manager has the same session configuration
 as the one which executes this filter currently.

 @param challenge the authentication challenge, must be non-nil
 @param conversationManager copy of HttpConversationManager instance, can be used for starting additional requests, must be non-nil
 @param completionBlock call the block when the filter finished its job. <br> Return YES, and a NSURLCredential object, if the challenge is handled, or return NO and nil, if the challenge is not handled. If return YES and NSURLCredential object is nil, it will be handled as no credential provided.
 */
-(void)handleChallenge:(NSURLAuthenticationChallenge*)challenge
       conversationManager:(HttpConversationManager*)conversationManager
       completionBlock:(challenge_filter_completion_t)completionBlock;

@end
