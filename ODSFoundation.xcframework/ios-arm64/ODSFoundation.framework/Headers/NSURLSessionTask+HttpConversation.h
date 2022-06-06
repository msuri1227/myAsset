//
//  NSURLSessionTask+HttpConversation.h
//  HttpConversation
//

#import <Foundation/Foundation.h>

#import "HttpConversationContextProtocol.h"

/**
 Category of the <code>NSURLSessionTask</code> that adds the new <code>conversationId</code> property to the task when it's created
 and executed by a <code>HttpConversationManager</code>.
 */
@interface NSURLSessionTask (HttpConversation) <HttpConversationContextProtocol>

@end
