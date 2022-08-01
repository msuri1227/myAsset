//
//  NSURLAuthenticationChallenge+HttpConversation.h
//  HttpConversation
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import "HttpConversationContextProtocol.h"

/**
 Category extension on <code>NSURLAuthenticationChallenge</code> to provide access to the conversation context.
 */
@interface NSURLAuthenticationChallenge (HttpConversation) <HttpConversationContextProtocol>

@end
