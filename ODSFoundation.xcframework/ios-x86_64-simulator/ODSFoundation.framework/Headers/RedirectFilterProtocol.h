//
//  RedirectFilterProtocol.h
//  HttpConversation
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Block type of redirect filters to be invoked at the end of processing. 
 
 @param handled if YES then the redirect is to be handled given the new request. NO means that the filter invoking this block did not handle the redirect and the next filter
                is going to be tried.
 @param newRequest the new request to actually redirect to. Matters only if the <code>handled</code> argument is YES. If set to nil then no redirection happens and the
                   original redirection response is returned as the response of the entire conversation.
 */
typedef void (^redirect_filter_completion_t)(BOOL handled, NSURLRequest* newRequest);

/**
 Protocol implemented by redirect filters which can be configured on a <code>HttpConversationManager</code>. Its purpose is to decide what the fate of a particular
 redirect should be.
 <p>
 The conversation manager calls a chain of these kind of filters whenever a redirect is detected. The first one to handle the redirect wins. If no filters handle
 the redirect then the manager tries to call the session task delegate, if any has been set. If the redirect is still left unhandled then the conversation manager
 will simply accept the original redirect request.
 </p>
 <p>
 Implementations are recommended to be stateless and not store any internal state as properties or ivars. This is because a filter of this type might be invoked
 by different threads if multiple conversations are running at the same time. If there's a need to store conversation-specific state for whatever reasons then
 use the <code>HttpConversationContextProtocol</code> and the <code>HttpConversation</code> category of the <code>NSHTTPURLResponse</code> class which implements
 that protocol. It contains methods for storing arbitrary object in conversation scope.
 </p>
 */
@protocol RedirectFilterProtocol <NSObject>

/**
 Processes the specified redirect. The completion handler must be invoked with the verdict.
 
 @param response the HTTP response, must be non-nil
 @param newRequest the redirected request whose fate should be decided, must be non-nil
 @param completion the block to invoke with the decision, must be non-nil
 */
-(void)processRedirectResponse:(NSHTTPURLResponse*)response newRequest:(NSURLRequest*)newRequest completion:(redirect_filter_completion_t)completion;

@end
