//
//  HttpConversationManager.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestFilterProtocol.h"
#import "ResponseFilterProtocol.h"
#import "ChallengeFilterProtocol.h"
#import "HttpConversationObserverProtocol.h"
#import "RedirectFilterProtocol.h"
#import "RedirectWhitelistProtocol.h"
#import "NSMutableURLRequest+HttpConversation.h"
#import "NSHTTPURLResponse+HttpConversation.h"
#import "NSURLSessionTask+HttpConversation.h"

/**
 The <code>HttpConversationManager</code> is the central class of the <code>HttpConversation</code> library. It is essentially a wrapper around the built-in
 <code>NSURLSession</code> API adding additional features and services to what the iOS platform provides out of the box.
 <h1>Philosophy</h1>
 <p>
 To access certain servers often authentication and authorization steps must be conducted before the actual requests can be sent. The <code>NSURLSession</code>
 API allows for handling these challenges via the various session delegate and session task delegate methods. However, this means that whoever is
 firing the request must also be capable of handling these duties.
 </p>
 <p>
 The conversation manager can be though of as an intelligent factory of requests (called HTTP conversations) which can then be executed. Intelligence here refers
 to that before starting conversations, the manager can be configured with a series of user exits called filters which are invoked at well-defined phases during
 conversation execution and can alter the currently running request as needed.
 </p>
 <p>
 By implementing these filters, one can add pre- and post-processing hooks to a <code>HttpConversationManager</code> instance which will then be utilized by
 each and every request (i.e. conversation) started with it. This way, if a set of filters are added to handle certain authentication challenges, the client of a
 particular well-configured manager instance no longer has to bother with authentication challenges as the filters will take care of them.
 </p>
 <p>
 As a result, the application can be structured into one set of components which are capable of configuring conversation managers with such user exits and another
 set of components which make use of such managers to fire actual HTTP requests. It is one way to separate these concerns nicely.
 </p>
 <h1>Filters</h1>
 <p>
 The following kinds of filters are supported by this class. Each has a corresponding protocol which can be implemented and then registered with the conversation
 manager using one of the <code>add*Filter:</code> methods.
 </p>
 <ul>
 <li>Request filter (<code>RequestFilterProtocol</code>): These are executed before any request is sent out. Use these to modify the <code>NSMutableURLRequest</code>
 object by adding extra parameters, request headers, etc..</li>
 <li>Response filter (<code>ResponseFilterProtocol</code>): These are executed after the response has been received and are very handy to perform post-processing
 of the response before it is returned to the component that initiated the request. A very important capability of response filters is that they have the
 right to restart the conversation from its very beginning. This will instruct the flow to send the request again. The advantage of this mechanism is that
 it can be used to implement the detection of custom authentication challenges for example. After the challenge has been processed and the credentials have been
 acquired the conversation can be restarted with some additional parameters. The initiator of the original request will be notified of the final response only if
 none of the response filters have restarted the conversation.</li>
 <li>Challenge filter (<code>ChallengeFilterProtocol</code>): Certain authentication types are supported by the <code>NSURLSession</code> class. These include
 HTTP BasicAuth and X.509 Client Certificate authentication types, to name the two most important ones. When an authentication challenge of these kinds is
 received the <code>NSURLSession</code> sends a notification which contains an <code>NSAuthenticationChallenge</code> which should be answered with a particular
 <code>NSURLCredential</code>. Challenge filters can be used to hook into this special mechanism.</li>
 <li>Redirect filter (<code>RedirectFilterProtocol</code>): When an HTTP request runs into a redirect, the <code>NSURLSession</code> sends another notification
 using which the fate of the redirect can be decided by certain hooks. The conversation manager delegates this notification to the set of registered redirect filters.
 These then can decide what to do with the redirect. The first challenge filter to respond with an actual result will make the decision.</li>
 </ul>
 <h1>Filter chains</h1>
 <p>
 More than one instance can be added from each type of filter to a conversation manager. As new filters are added they are appended to the end of their respective chain.
 Since there are four different types of filters there are four corresponding chains. The logic of these is however always similar.
 </p>
 <p>
 Filter chains are executed at the right time during request processing, one after the other. Each registered filter therefore gets a chance to interfere with
 the currently executing request. Certain filters have the ability to halt the execution of the chain. For example, response filters can signal that the conversation
 should be restarted. In this case the yet unexecuted response filters after the current one in the chain will be omitted from the iteration.
 </p>
 <p>
 It's best to consult the documentation of each filter protocol to understand the signature and the exact mechanism as to what a filter can and must do. Note that
 all filters are inherently asynchronous and their APIs are block-based. This makes them very flexible. For example, a particular challenge filter implementation
 might display a UI for a HTTP BasicAuth challenge and return the credentials the user entered. All this can happen within the boundaries of a single conversation
 without the caller seeing anything from this mechanism.
 </p>
 <h1>The conversation flow</h1>
 <p>
 The complex flow which begins with sending a request, involves the execution of filters and then ends with the final delegate or block getting called is called
 a <i>conversation</i>. This process might run multiple times if one of the challenge filters or response filters reported an outcome that caused it to restart.
 The key is that from the aspect of the caller the complex conversation flow is not visible. The final call, which is either a delegate method call if the
 delegate-based API is used or a call to a completion block, is going to be made only once with the final results.
 </p>
 <p>
 An important implication is therefore during a single conversation multiple HTTP requests may be fired.
 </p>
 <p>
 Below is the actual flow in details. A single execution of this flow is called an <i>iteration</i>:
 </p>
 <ol>
 <li>A request is fired with one of the <code>execute*</code> methods of this class. These can be found in the <code>HttpConversationRequestExecution</code> category.</li>
 <li>The request filter chain is executed which gives a chance to each filter to alter the <code>NSMutableURLRequest</code> before it is sent out.</li>
 <li>After the request filters have completed execution and the final URL request object is at hand, the underlying <code>NSURLSession</code> is instructed to
 fire the request.</li>
 <li>During request execution, redirects and supported authentication challenges may occur which will then be propagated to redirect and challenge filters, respectively.
 Both of these filters might cause the running request execution to restart, however these restarts are unlike complete conversation restarts as these are handled by
 the <code>NSURLSession</code>. This implies that <b>request filters are not re-executed when redirect and challenge filters instruct the library to retry the
 request!</b></li>
 <li>After the response has been received the chain of response filters is executed. Should any of the filters in the chain return a restart signal then the
 conversation flow will jump back to step no. 2. Otherwise the response processing continues.</li>
 <li>At the very end, after all filters have been processed and restarts have settled down, the final callback is invoked which can be either a delegate method
 or a completion block. This depends on which <code>execute*</code> method has been called in step no. 1.</li>
 </ol>
 <h1>State management</h1>
 <p>
 A very important guideline when implementing any of the filters is that they must be stateless, that is, they should not try to store conversation-specific state
 in properties or ivars. This is because a conversation manager reuses filter instances during the execution of different conversations. One would have to implement
 complex state management routines to circumvent this.
 </p>
 <p>
 The only possible kind of information that should be stored by instance variables of filters should be configuration related which are only read during the actual
 execution of the filter.
 </p>
 <p>
 However, in certain cases it might be necessary for a filter to store some information scoped to the currently running conversation. This is especially important
 if a given response filter would like to share information with one of the request filters. An example for such a scenario could be a requset/response filter pair which
 are capable of recognizing custom authentication challenges. When the response filter detects the challenge it handles it and then tells the request filter what to
 put into the next request after the conversation restart to fulfill the challenge. Therefore, a mechanism is needed that allows them to communicate.
 </p>
 <p>
 This mechanism is implemented via the <code>HttpConversationContextProtocol</code>. An instance of that type represents the so-called conversation context of which
 there's exactly one for a given conversation. Consult the documentation of this protocol to understand which classes conform to it and how can filter implementations
 get a pointer to the context of the currently running conversation. Think of this as a storage that requires request and conversation restarts but lives no longer
 than the entire conversation itself.
 </p>
 <h1>Thread-safety</h1>
 <p>
 As long as the above guidelines are honored, the <code>HttpConversationManager</code> is thread-safe and can be used to run multiple parallel requests as needed.
 The configuration methods will not interfere with conversation executions either. Say that a particular filter is added to the manager meanwhile some conversations
 are already running. This is not a problem as the newly added filter is going to be used only by conversations executed afterwards.
 </p>
 <p>
 There's one important guideline that must be taken into consideration at all times. No matter whether a request is fired with delegate- or block-based APIs, the
 configured delegate/block is always going to be invoked by the session delegates of the underlying <code>NSURLSession</code>. Since <code>NSURLSession</code> executes
 its delegates in a so-called delegate queue which is always serial, it is highly discouraged to block the execution of the aforementioned delegate or block callbacks
 for a longer period of time as it delays the delivery of events pertaining to other conversations.
 </p>
 <p>
 The biggest problem can be caused by firing a conversation with, for example, a block based API (like <code>executeRequest:completionHandler:</code> and then from the
 completion block firing another request with the same conversation manager but synchronously waiting for it to finish. This will cause that the first conversation will
 not be able to fully complete as it forcefully blocks the same serial queue the second conversation is trying to use. Obviously, such a situation is a deadlock and is a
 direct consequence of the serial nature of delegate queues of <code>NSURLSession</code> objects.
 </p>
 <p>
 The best practice is to keep the execution of delegate- and block-based methods as short as possible. If the computation is likely going to take a long time and/or will
 have to wait for another process to finish then the recommendation is to off-load these computations to other threads using GCD or other thread management mechanisms.
 </p>
 <p>
 The same guidelines apply to filter implementations as well as the filters themselves are called by <code>NSURLSession</code> delegate methods and therefore are
 running under the jurisdiction of the serial delegate queue.
 </p>
 <h1>Further reading</h1>
 <p>
 To become familiar with this library, take a closer look at the documentation of the various categories of this class. Also, check out the
 <code>ManagerConfiguratorProtocol</code> which introduces a standard abstraction for configuring conversation managers.
 </p>
 */
@interface HttpConversationManager : NSObject <NSCopying>

/**
 Redirect whitelist implementation that hooks into the redirection process and decides how a given redirect is to be handled.
 */
@property (strong) id<RedirectWhitelistProtocol> redirectWhitelistImplementation;

/**
 Allows you to set your class as <code>NSURLSessionTaskDelegate</code>. If you set this the manager will proxy events it receives to this delegate.
 */
@property (strong) id<NSURLSessionTaskDelegate> sessionTaskDelegate;

/**
 Allows you to set your class as <code>NSURLSessionDataDelegate</code>. If you set this the manager will proxy events it receives to this delegate.
 */
@property (strong) id<NSURLSessionDataDelegate> sessionDataDelegate;

/**
 Allows you to set your class as <code>NSURLSessionDownloadDelegate</code>. If you set this the manager will proxy events it receives to this delegate.
 */
@property (strong) id<NSURLSessionDownloadDelegate> sessionDownloadDelegate;

/**
 The session configuration this manager has been initialized with.
 */
@property (nonatomic, readonly, copy) NSURLSessionConfiguration* sessionConfiguration;

/**
 Initialize an instance of HttpConversationManager with <code>[NSURLSessionConfiguration defaultSessionConfiguration]</code>.
 */
-(instancetype)init;

/**
 Initializes this conversation manager to work with the specified session configuration. In case you would like to execute requests in
 the background for instance based on a Push Notification you must create a background session configuration.

 @param configuration the configuration object to use, must be non-nil
 */
-(instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration*)configuration;

@end


/**
 Category of <code>HttpConversationManager</code> containing methods using which user exits can be configured.
 */
@interface HttpConversationManager (HttpConversationUserExits)

/**
 Returns the user exits (filters, observers) registered with this manager using one of the <code>add*</code> methods which are of the specified type.
 
 @param userExitType the class to perform the search with, must be non-nil
 @return a set of registered user exits or nil if none is found for the given type
 */
-(NSSet*)getRegisteredUserExitsOfType:(Class)userExitType;

/**
 Adds a new request filter to this manager.

 @param requestFilter the filter, must be non-nil
*/
-(void)addRequestFilter:(id<RequestFilterProtocol>)requestFilter;

/**
 Removes the specified request filter from this manager.

 @param requestFilter the filter, must be non-nil
 */
-(void)removeRequestFilter:(id<RequestFilterProtocol>)requestFilter;

/**
 Returns all registered request filters. The returned array is a copy and is not backed by this object.
 
 @return the array containing all the filters, always non-nil
*/
-(NSArray<id<RequestFilterProtocol>>*)allRequestFilters;

/**
 Adds a new response filter to this manager.

 @param responseFilter the filter, must be non-nil
 */
-(void)addResponseFilter:(id<ResponseFilterProtocol>)responseFilter;

/**
 Removes the specified response filter from this manager.

 @param responseFilter the filter, must be non-nil
 */
-(void)removeResponseFilter:(id<ResponseFilterProtocol>)responseFilter;

/**
 Returns all registered response filters. The returned array is a copy and is not backed by this object.

 @return the array containing all the filters, always non-nil
 */
-(NSArray<id<ResponseFilterProtocol>>*)allResponseFilters;

/**
 Adds a new challenge filter to this manager.

 @param challengeFilter the filter, must be non-nil
 */
-(void)addChallengeFilter:(id<ChallengeFilterProtocol>)challengeFilter;

/**
 Removes the specified challenge filter from this manager.

 @param challengeFilter the filter, must be non-nil
 */
-(void)removeChallengeFilter:(id<ChallengeFilterProtocol>)challengeFilter;

/**
 Returns all registered challenge filters. The returned array is a copy and is not backed by this object.

 @return the array containing all the filters, always non-nil
 */
-(NSArray<id<ChallengeFilterProtocol>>*)allChallengeFilters;

/**
 Adds a new redirect filter to this manager.

 @param redirectFilter the filter, must be non-nil
 */
-(void)addRedirectFilter:(id<RedirectFilterProtocol>)redirectFilter;

/**
 Removes the specified redirect filter from this manager.

 @param redirectFilter the filter, must be non-nil
 */
-(void)removeRedirectFilter:(id<RedirectFilterProtocol>)redirectFilter;

/**
 Returns all registered redirect filters. The returned array is a copy and is not backed by this object.

 @return the array containing all the filters, always non-nil
 */
-(NSArray<id<RedirectFilterProtocol>>*)allRedirectFilters;

/**
 Adds a new observer to this conversation manager.
*/
-(void)addObserver:(id<HttpConversationObserverProtocol>)observer;

/**
 Removes the specified observer from this conversation manager.
 */
-(void)removeObserver:(id<HttpConversationObserverProtocol>)observer;

/**
 Returns all registered observers. The returned array is a copy and is not backed by this object.

 @return the array containing all the observers, always non-nil
 */
-(NSArray<id<HttpConversationObserverProtocol>>*)allObservers;

@end


/**
 Category of <code>HttpConversationManager</code> containing methods using which request execution can be managed.
 */
@interface HttpConversationManager (HttpConversationRequestExecution)

/**
 Executes the specified <code>NSMutableURLRequest</code> instance using this manager. This method is robust enough to work even in cases when this object has been
 initialized with a background session configuration. Normally, <code>NSURLSession</code> does not allow the use of the block-based APIs when a background config is used.
 This method however turns around this problem by using delegates internally but still utilizing the specified completion handler even in case of a background
 session config.

 @param urlRequest the URL request to fire, must be non-nil
 @param completionHandler will be called when the request is finished. Contains the response, the received data, and in case of any error the root cause, must be non-nil
 @return the conversation identifier
 */
-(NSUInteger)executeRequest:(NSMutableURLRequest*)urlRequest completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completionHandler;

/**
 Executes the specified <code>NSMutableURLRequest</code> instance using this manager. This method expects that this conversation manager is configured with the proper
 delegates, otherwise the caller will be unable to track the progress of the request.

 @param urlRequest the URL request to fire, must be non-nil
 @return the conversation identifier
 */
-(NSUInteger)executeRequest:(NSMutableURLRequest*)urlRequest;

/**
 Executes the specified <code>NSMutableURLRequest</code> instance as a download request using this manager. This method expects that this conversation manager is
 configured with the proper delegates, otherwise the caller will be unable to track the progress of the request. This method is handy when performing background
 downloads using background session configurations.

 @param urlRequest the URL request to fire, must be non-nil
 @return the conversation identifier
 */
-(NSUInteger)executeDownloadRequest:(NSMutableURLRequest*)urlRequest;

/**
 Resumes the execution of a download request using the specified resume data. The argument must have been acquired using the
 <code>cancelDownloadRequest:withBlock:</code> method. The resume data is not defined any closer as it is produced by the underlying
 <code>NSURLSession</code>.

 @param resumeData the resume data acquired from a previously cancelled download request, must be non-nil
 @return the conversation identifier
 */
-(NSUInteger)executeDownloadRequestWithResumeData:(NSData*)resumeData;

/**
 Executes a download request by producing a stream. The specified block is invoked with the stream from which the HTTP response body can be read.

 @param urlRequest the URL request to fire, must be non-nil
 @param completionHandler called when the request execution completes either successfully or with an error. Any potential errors are reported via the <code>error</code> argument.
                          Upon success, the payload stream can be used to read the HTTP response body. Must be non-nil.
 @return the conversation identifier
 */
-(NSUInteger)executeStreamedDownloadRequest:(NSMutableURLRequest*)urlRequest completionHandler:(void (^)(NSInputStream* payloadStream, NSURLResponse* response, NSError* error))completionHandler;

/**
 Cancels the specified download request. If no such task is running or the specified task is not a download task created with the <code>executeDownloadRequest:</code>
 or <code>executeStreanedDownloadRequest:completionHandler:</code> methods then this method does nothing.
 
 @param conversationId the conversation ID of the download task to cancel
 @param block the block through which the produced resume data is returned. It is called with nil if cancellation failed due to one of the above stated reasons. This argument must be non-nil
 */
-(void)cancelDownloadRequest:(NSUInteger)conversationId withBlock:(void(^)(NSData* resumeData))block;

/**
 Executes the specified <code>NSMutableURLRequest</code> instance as an upload request using this manager. This method expects that this conversation manager is
 configured with the proper delegates, otherwise the caller will be unable to track the progress of the request. This method is handy when performing background
 uploads using background session configurations.

 @param urlRequest the URL request to fire, must be non-nil
 @return the conversation identifier
 */
-(NSUInteger)executeUploadRequest:(NSMutableURLRequest*)urlRequest;

/**
 Executes an upload request that has a valid <code>HTTPBodyStream</code> set. Alternatively (and that's the better option), the <code>inputStreamCreator</code> method of the
 specified mutable request can be specified. This is more robust as it can provide an input stream in case the conversation is restarted (due to authentication challenges, for
 example).

 @param urlRequest the URL request to fire, must be non-nil
 @param completionHandler called when the request execution completes either successfully or with an error. Any potential errors are reported via the <code>error</code> argument.
                          Upon success the error argument is nil. Must be non-nil.
 @return the conversation identifier
 */
-(NSUInteger)executeStreamedUploadRequest:(NSMutableURLRequest*)urlRequest completionHandler:(void (^)(NSURLResponse* response, NSError* error))completionHandler;

@end
