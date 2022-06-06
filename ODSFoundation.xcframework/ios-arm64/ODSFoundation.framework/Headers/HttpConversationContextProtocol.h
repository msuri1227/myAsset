//
//  HttpConversationContextProtocol.h
//  HttpConversation
//

#import "HttpConversationObserverProtocol.h"

/**
 Protocol representing the context of a running conversation. Its lifecycle starts from the point the conversation is fired (i.e. when
 one of the <code>execute*</code> methods is invoked on a <code>HttpConversationManager</code>) and completes when the conversation is
 finished. An object of this type remains the same across conversation restarts commanded by response filters.
 <p>
 This protocol is implemented by the built-in classes <code>NSHTTPURLResponse</code>, <code>NSMutableURLRequest</code> and <code>NSURLSessionTask</code>
 via categories.
 </p>
 <p>
 An object of this type is meant to be accessed solely from delegates, completion blocks of request executions, observers and filter implementations.
 </p>
 */
@protocol HttpConversationContextProtocol <NSObject>

/**
 The ID of the running conversation. This identifier is returned also by the <code>execute*</code> methods of the
 <code>HttpConversationManager</code> class. Its main purpose is to allow for <code>NSURLSession</code> delegate implementors
 to associate a particular delegate method call getting an <code>NSURLSessionTask</code> reference with a particular request
 execution.
 <p>
 This identifier remains the same across conversation restarts even if the underlying session task changes. In other words, this property
 is constant throughout the lifecycle of a single context object.
 </p>
 */
@property (nonatomic, readonly, assign) NSUInteger conversationId;

/**
 Context dictionary into which filters, delegates and other user exits having access to this context object may write additional info. Its sole purpose
 is to store information which can survive conversation restarts. This storage is destroyed when the conversation completes.
 <p>
 Keys and values may be arbitrarily chosen. A typical usage of this dictionary is to store some state information which is relevant only within the
 context of a single conversation. For example, a response filter restarting the request may signal some additional info that request filters in the
 next iteration may use.
 </p>
 */
@property (nonatomic, readonly, strong) NSMutableDictionary<NSString*, id>* contextMap;

/**
 Retrieves all the observers which conform to the specified observer protocol and are registered with the conversation manager that started
 the conversation to which this context object belongs. The argument is expected to be a protocol which adopts the <code>HttpConversationObserverProtocol</code>.
 If no observers conform to the specified observer protocol or if the argument violates the above contract then nil is returned.
 <p>
 The returned array does not contain those observers which conform only to the built-in observer protocols, namely <code>
 ClientCertObserverProtocol</code> and <code>HttpConversationObserverProtocol</code>. This is because they are handled specially
 by the <code>HttpConversationManager</code> itself.
 </p>
 
 @param protocol the concrete observer protocol to filter for, must be non-nil
 @return the array of conforming protocol implementations, can be nil
 */
-(NSArray<id<HttpConversationObserverProtocol>>*)observersConformingTo:(Protocol*)protocol;

@end
