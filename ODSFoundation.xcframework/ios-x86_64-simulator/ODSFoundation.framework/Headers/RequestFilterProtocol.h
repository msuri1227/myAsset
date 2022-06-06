//
//  HttpConversationPluginDelegate.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpConversationManager;

/**
 Protocol using which request filters can be implemented. Such filters can perform request pre-processing before they are sent. Typically, implementations modify
 certain parameters of the mutable request by adding request headers, for example.
 <p>
 Implementations are recommended to be stateless and not store any internal state as properties or ivars. This is because a filter of this type might be invoked
 by different threads if multiple conversations are running at the same time. If there's a need to store conversation-specific state for whatever reasons then
 use the <code>HttpConversationContextProtocol</code> and the <code>HttpConversation</code> category of the <code>NSMutableURLRequest</code> class which implements
 that protocol. It contains methods for storing arbitrary object in conversation scope.
 </p>
*/
@protocol RequestFilterProtocol <NSObject>

/**
 Prepares the request by making modification as appropriate. The specified manager has the same session configuration
 as the one which executes this filter currently.

 @param mutableRequest the request instance which will be executed, must be non-nil
 @param conversationManager copy of HttpConversationManager instance, can be used for starting additional requests, must be non-nil
 @param completionBlock block to be invoked at the end of filter processing, must be non-nil
*/
-(void)prepareRequest:(NSMutableURLRequest*)mutableRequest conversationManager:(HttpConversationManager*)conversationManager completionBlock:(void (^)())completionBlock;

@end
