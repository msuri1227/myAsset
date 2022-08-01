//
//  UsernamePasswordProvider.h
//  HttpConvAuthFlows
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsernamePasswordProviderProtocol.h"
#import <UIKit/UIKit.h>

/**
 Alert view based implementation of the <code>UsernamePasswordProviderProtocol</code>. Internally, it ensures that at most one alert view is displayed at a
 time. This is important in case multiple conversation managers configured with this provider happen to run into BasicAuth challenges simultaneously.
 <p>
 To use an object of this type, simply instantiate it and add it to an instance of <code>CommonAuthenticationConfigurator</code> using its
 <code>addUsernamePasswordProvider:</code> method. After that, when a conversation manager is next configured with this configurator the provider will be in
 place and will be listening for challenges.
 </p>
*/
@interface AlertViewBasedUsernamePasswordProvider : NSObject <UsernamePasswordProviderProtocol>

@end
