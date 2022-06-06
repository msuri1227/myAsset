//
//  CustomURLSchemeHandler.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Block type to be used during the initialization of a <code>CustomURLSchemeHandler</code>. When registered with the manager, this
 block is invoked with the URL that is to be opened.
 */
typedef void (^custom_url_scheme_handler_t)(NSURL* url);

/**
 Custom URL scheme handler which is actually a wrapper for the <code>custom_url_scheme_handler_t</code> block type. Instances of this
 type are to be registered with the <code>CustomURLSchemeManager</code> class.
 <p>
 As long as a strong reference exists to an object of this type its block will keep on receiving calls whenever URLs with custom schemes
 are opened. Therefore, the period when these notifications are relevant can be controlled using the lifecycle of a handler object.
 </p>
 */
@interface CustomURLSchemeHandler : NSObject

/**
 Initializes this handler with the specified block which will be kept on notified about new URL opening events as long as this handler
 is in memory and is registered with the manager.
 
 @param block the block to invoke when a new URL opening event occurs, must be non-nil
 */
-(instancetype)initWithBlock:(custom_url_scheme_handler_t)block;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
