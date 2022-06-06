//
//  UserInteractionMultiplexer.h
//  UserInteractionMultiplexer
//
//  Copyright © 2016. SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInteractionHandlerProtocol.h"

/**
 Block type used by the <code>UserInteractionMultiplexer</code> when signaling the results of a particular interaction. The result
 object can be anything and it depends on the request and the user interaction handler.
 <p>
 If the interaction has been cancelled then the result object is guaranteed to be nil. However, a non-cancelled interaction
 may or may not have a result object at the end. Again, this is request and handler dependent.
 </p>
 
 @param request the original request object the results of which are fulfilled by the call to this block
 @param result the result object, as produced by the user interaction handler
 @param cancelled YES if the interaction has been cancelled, NO otherwise
 */
typedef void (^user_interaction_result_block)(id request, id result, BOOL cancelled);

/**
 This is the entry point of the user-interaction multiplexer library. Using this class one can easily collect a bunch of UI interaction
 requests and display a single interaction that is capable of fulfilling all of them. This is typically used for authentication and
 authorization purposes where the user's attention needs to be caught. As multiple components might need the resulting auth. information,
 each of them hands in a request for an interaction to start. To prevent annoying the user with the same interaction multiple times, this
 class simply combines related requests into one and displays a single window that can fulfill all of them.
 <p>
 A single instance of this class manages exactly one <code>UIWindow</code> that is displayed whenever a new interaction request comes in. In most
 cases, the window contains a view controller with a single 'Cancel' button in a toolbar to stop the interaction with. The content of the window
 depends on the request. Other kinds of view controllers may be used as the root for the window. How this is possible is clarified below.
 </p>
 <p>
 A request is an arbitrary object conforming to the <code>NSObject</code> protocol. Incoming requests are placed in a FIFO queue
 but first a check is made whether a similar request is already in the queue. This check is performed using the <code>isEqual:</code> method.
 If a request is already in the queue then its completion block is added to the set of blocks to be notified upon the completion of the request.
 Along with the comnpletion block the original request object is stored as well, even if another one is already in the queue. However, this
 request object is used only when calling back to the corresponding block. This is because it's possible that different request objects are
 equal to each other, as of <code>isEqual:</code> but do actually contain additional internal state that is not part of the equality check.
 If the request is not in the queue yet then it's placed in it which means the corresponding UI interaction will start when the request is
 picked for execution.
 </p>
 <p>
 To submit a request to the multiplexer, invoke the <code>expressNeedForUserInteractionWith:completion:</code> method. In most cases,
 request object are simple parameter objects containing information about the user interaction itself and how it should be started.
 </p>
 <p>
 The interactions are managed by objects that conform to the <code>UserInteractionHandlerProtocol</code> protocol. These are responsible for creating
 the view controllers to be included as the content of the window managed by the multiplexer. Such handlers can be registered with a multiplexer
 using the <code>registerHandler:</code> method. The order of registration matters as handlers are sent the <code>canHandleRequest:</code> message
 once a user interaction request is about to be processed.
 </p>
 <p>
 The simplest use of this class is via the <code>defaultMultiplexer</code> method which returns a singleton multiplexer. Should there be any need,
 however, one can easily create a new instance of this type using the default initializers.
 </p>
 <p>
 This class is thread-safe.
 </p>
 <p>
 This library itself works with a couple of resources. Make sure you add the <code>UserInteractionMultiplexer.bundle</code> to the application
 (usually in the 'Copy Bundle Resource' build phase).
 </p>
 */
@interface UserInteractionMultiplexer : NSObject

/**
 Returns the process-wide multiplexer.
 
 @return the multiplexer, always non-nil
 */
+(instancetype)defaultMultiplexer;

/**
 Use this method to express the need for a particular user interaction to take place given the specified request. The naming refers to
 that this might not trigger the request immediately as other interactions might be still running in the meantime.
 <p>
 The specified block is going to be invoked with the exact same request object once the interaction completes. This is the case even if
 another request which is equal to the currently submitted one is already in the queue.
 </p>
 <p>
 If no registered user interaction handlers can tackle with the submitted request then the interaction is cancelled immediately (i.e. the
 specified block is invoked) and an error is logged.
 </p>
 <p>
 Make no assumptions about what thread the specified completion block is going to be invoked on.
 </p>
 
 @param request the user interaction request object, must be non-nil
 @param completion the block to execute when the request completes, must be non-nil
 */
-(void)expressNeedForUserInteractionWith:(id)request completion:(user_interaction_result_block)completion;

/**
 Registers a user interaction handler. The handler is placed to the end of the list of handlers.
 
 @param handler the handler to register, must be non-nil
 */
-(void)registerHandler:(id<UserInteractionHandlerProtocol>)handler;

@end
