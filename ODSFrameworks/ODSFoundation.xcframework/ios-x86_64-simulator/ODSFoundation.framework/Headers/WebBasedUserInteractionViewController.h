//
//  WebBasedUserInteractionViewController.h
//  UserInteractionMultiplexer
//
//  Copyright © 2016. SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseWebBasedUserInteractionDelegate.h"

/**
 This class is there to help build web-based user interactions in which the entire interaction takes place inside a web view
 covering the entire screen. Specific <code>UserInteractionHandlerProtocol</code> implementations may use this class to create
 a view controller in the <code>createInteractionForRequest:completion:</code> method.
 */
@interface WebBasedUserInteractionViewController : UIViewController

/**
 Initializes this view controller with the specified URL request and delegate object to which a strong reference is maintained.
 
 @param request the URL request to open in the web view, must be non-nil
 @param delegate the delegate object to work with, must be non-nil
 */
-(instancetype)initWithRequest:(NSURLRequest*)request andDelegate:(BaseWebBasedUserInteractionDelegate*)delegate;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
