//
//  ManagerConfigurator.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConversationManager.h"
#import <UIKit/UIKit.h>

/**
 A configurator is a simple object that carries the knowledge how a particular <code>HttpConversationManager</code> should be configured. The SDK ships with an
 implementation of this interface in the <code>HttpConvAuthFlows</code> library. It is recommended to check what that library offers on top of
 <code>HttpConversation</code>.
 <p>
 Think of a configurator as an object that knows what kind of filters and other user exists should be configured on a particular conversation manager. Although
 this protocol defines only the <code>configureManager:</code> method, implementations typically expose other APIs using which the set of filters can be configured.
 </p>
 <p>
 Application developers seldom need to create their own configurator implementations. The use of this protocol is completely voluntary and fits those use cases the
 best when certain conversation managers are always configured more or less the same way. The related code can then be refactored into a class implementing this
 protocol.
 </p>
 <p>
 Imagine an application which has its own settings screen where certain network-related stuff can be configured such as what credentials to use, which authentication
 methods are enabled. All these settings will translate into actual filter objects to be configured on a <code>HttpConversationManager</code>. Now, if the screen
 is invoked from many places in the app allowing for individual configuration of these settings before requests are fired then the related view controller can
 adapt this protocol. The screens displaying that view controller will then show it and after it has been dismissed call <code>configureManager:</code> to have
 a new conversation manager properly configured for them based on what has been entered on the screen.
 </p>
 */
@protocol ManagerConfiguratorProtocol <NSObject>

/**
 Performs the configuration of the specified conversation manager by adding the filters and other user exits to it as needed. The behaviour of this method
 is highly dependent on the implementation. Read the header documentation of this protocol to get the idea.

 @param manager HttpConversationManager instance to be configured, must be non-nil
 */
-(void)configureManager:(HttpConversationManager*)manager;

@end
