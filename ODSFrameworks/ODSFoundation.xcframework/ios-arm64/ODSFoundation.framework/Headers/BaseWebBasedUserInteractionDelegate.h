//
//  BaseWebBasedUserInteractionDelegate.h
//  UserInteractionMultiplexer
//
//  Copyright © 2016. SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

#import "UserInteractionHandlerProtocol.h"

/**
 Abstract base class for delegates of the <code>WebBasedUserInteractionViewController</code> class. Subclasses should implement the
 methods of the web view delegate protocol to follow how's the user interaction going in the web view. Typically, implementations make
 use of the <code>WKwebView:decidePolicyForNavigationAction:decisionHandler:</code> method to detect certain page loads events and react accordingly.
 <p>
 By convention, implementations decide when a particular interaction running in a web view is considered running, complete or cancelled. If
 the interaction has finished then either the <code>completeWithResult:</code> or the <code>cancel</code> method should be invoked to
 finish the interaction. After that no other calls are going to be made to this object.
 </p>
 <p>
 An implementation may also restart the web-based interaction by calling the <code>restartWithURL:</code> method.
 </p>
 <p>
 An actual instance of this type is instantiated usually by the <code>createInteractionForRequest:completion:</code> method of a
 <code>UserInteractionHandlerProtocol</code> implementation. Then, the instance is passed to the initializer of a <code>WebBasedUserInteractionViewController</code>
 and then the controller is returned as part of the <code>UserInteractionDescriptor</code> to drive the interaction.
 </p>
 <p>
 This class is not thread-safe but if the protected methods are invoked only from within the <code>WKNavigationDelegate</code> methods then no thread-safety
 issues should arise. If a subclass implements a logic that may involve the usage of other threads then it must properly synchronise these calls.
 </p>
 */
@interface BaseWebBasedUserInteractionDelegate : NSObject <WKNavigationDelegate>

/**
 The interaction request object this object has been initialized with.
 */
@property (nonatomic, readonly, strong) id request;

#pragma mark - Initialization

/**
 Initializes this delegate using the specified interaction request and completion handler. This method is to be invoked by user interaction handler
 objects when creating an interaction descriptor of a request. The arguments should actually be the same as the ones received in the
 <code>createInteractionForRequest:completion:</code> method of the handler.
 
 @param request the interaction request which is to be handled with a particular web-based interaction with
 @param completion the completion block to invoke at the end of the interaction
 */
-(instancetype)initWithInteractionRequest:(id)request completion:(user_interaction_handling_complete_block)completion;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

#pragma mark - Protected methods to be called by implementors

/**
 Completes the interaction with the specified result object by calling the completion handler this object has been initialized
 with. This signals successful completion.
 
 @param result the result object
 */
-(void)completeWithResult:(id)result;

/**
 Cancels the interaction by calling the completion handler this object has been initialized with. This usually signals failure.
 */
-(void)cancel;

/**
 Restarts the interaction given the specified request. If the argument is nil then the original URL is used to do the restart. This will
 cause the web view to stop processing the current page and start loading the one on the specified URL.
 
 @param request the URL request to restart the interaction with or nil to use the original request object
 */
-(void)restartWithURLRequest:(NSURLRequest*)request;

/**
  Synchorize the Cookie storage between <code>WKHTTPCookieStore</code> and <code>NSHTTPCookieStorage</code> for <code>WKWebView</code> integration. Only the non-exist Cookies were copied from <code>WKHTTPCookieStore</code> to <code>NSHTTPCookieStorage</code>
 As the <code>WKHTTPCookieStoreObserver</code> can't work with method cookiesDidChangeInCookieStore sometimes, so, to expose the method to consumer for explicit calling.
 */
-(void)handleCookieStore;

@end
