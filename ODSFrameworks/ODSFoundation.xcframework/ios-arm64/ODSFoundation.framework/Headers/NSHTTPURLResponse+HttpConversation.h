//
//  NSURLResponse+HttpConversation.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpConversationContextProtocol.h"

/**
 Category extension on <code>NSHTTPURLResponse</code> to support batch response handling and provide access to the conversation context.
 */
@interface NSHTTPURLResponse (HttpConversation) <HttpConversationContextProtocol>

/**
 Contains the received data after request execution
*/
@property (strong) NSData* responseData;

/**
 Contains batch response objects
*/
-(NSArray*)responses;

@end
