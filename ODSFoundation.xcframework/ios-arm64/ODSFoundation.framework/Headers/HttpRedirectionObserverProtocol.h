//
//  HttpRedirectionObserverProtocol.h
//  HttpConversation
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import "HttpRedirectionObserverProtocol.h"

#import "HttpConversationObserverProtocol.h"

/**
 Observer protocol using which HTTP redirections can be observed which occur during the conversations fired by a particular
 <code>HttpConversationManager</code>. It is different from the <code>URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler</code> delegate method
 that this object gets called when the final decision about a particular redirection has been made by the delegate and/or the conversation manager
 (i.e. by redirect filters).
 */
@protocol HttpRedirectionObserverProtocol <HttpConversationObserverProtocol>

/**
 Invoked when a redirection happens in the given task which leads to the specified URL. The task is guaranteed to belong to a conversation whose ID
 is accessible using the <code>conversationId</code> property defined by the library-specific<code>HttpConversation</code> category of the 
 <code>NSURLSessionTask</code> class.
 <p>
 This method is not invoked if the redirection is swallowed, that is, the response with the 3xx status code is returned verbatim as any other HTTP response. 
 </p>
 
 @param task the task in which the redirection occured
 @param url the URL to which the conversation has been redirected, must be non-null
 */
-(void) redirectionOccuredInTask:(NSURLSessionTask*)task toURL:(NSURL*)url;

@end
