//
//  UserInteractionHandlerProtocol.h
//  UserInteractionMultiplexer
//
//  Copyright © 2016. SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserInteractionDescriptor.h"

/**
 Block type used by user interaction handlers to signal the completion of the interaction with.
 
 @param result the result object
 @param cancelled YES if the interaction has been cancelled, NO otherwise
 */
typedef void (^user_interaction_handling_complete_block)(id result, BOOL cancelled);

/**
 Protocol representing a user interaction handler that can be registered with an instance of <code>UserInteractionMultiplexer</code>.
 */
@protocol UserInteractionHandlerProtocol <NSObject>

/**
 Tests whether this handler can actually handle the specified request object.
 
 @param request the request, must be non-nil
 @return YES if this handler can handle the request, NO otherwise
 */
-(BOOL)canHandleRequest:(id)request;

/**
 Creates the descriptor containing the view controller that can orchestrate the user interaction for the specified request. Along with
 the controller itself the returned object also contains a series of flags controlling how the view controller is to be shown.
 This method is invoked by a multiplexer on the main thread. The request object is guaranteed to have passed the <code>canHandlerRequest:</code>
 test of this object positively.
 <p>
 The specified block can be invoked at the very end of the interaction to signal the results. The result object is handler specific and
 is not defined by this API any closer.
 </p>
 
 @param request the request object this object claimed to be able to handle (as of <code>canHandleRequest:</code>), must be non-nil
 @param completion the block to be invoked by the interaction when it completes
 @return the interaction descriptor object, always non-nil
 */
-(UserInteractionDescriptor*)createInteractionForRequest:(id)request completion:(user_interaction_handling_complete_block)completion;

@end
