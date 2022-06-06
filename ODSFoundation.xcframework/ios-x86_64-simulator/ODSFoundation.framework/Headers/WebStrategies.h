//
//  WebStrategies.h
//  HttpConvAuthFlows
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAML2WebStrategyResolver.h"
#import "OAuth2WebStrategyResolver.h"
#import "OTPWebStrategyResolver.h"

/**
 Singleton holding the registration of various web strategy objects. These are added using strategy resolver objects which are
 responsible for returning a strategy for a given set of parameters. This class effectively manages an ordered list of
 resolvers per authentication type and invokes them in order whenever a strategy is needed. The first non-null object returned is going to be used.
 <p>
 A particular strategy is an object that belongs to a web-based authentication mechanism and governs how the authentication process executes. This
 class is used internally by filters configured on a conversation manager by the <code>CommonAuthenticationConfigurator</code>. Application developers
 should only deal with this class if they'd like to customize the execution of the web-based authentication flows. For example, by registering a
 custom strategy object one can take over the execution of the entire flow and run it using a 3rd-party web view implementation. 
 </p>
 <p>
 This class always provides the default strategies for all kinds of authentication types at all times. Therefore, its various
 <code>resolve*</code> methods never return nil. These default strategies make use of the <code>UserInteractionMultiplexer</code> library and
 submit the execution of a particular authentication flow to the default multiplexer (accessible via the <code>[UserInteractionMultiplexer defaultMultiplexer]</code>
 call).
 </p>
 <p>
 Currently, this class supports registration of strategy resolvers for the following authentication types. These correspond to the various web-based authentication
 types that <code>CommonAuthenticationConfigurator</code> supports:
 <ul>
 <li>SAML2WebStrategyResolver</li>
 <li>OAuth2WebStrategyResolver</li>
 <li>OTPWebStrategyResolver</li>
 </ul>
 </p>
 <p>
 For simplicity, this class itself implements the above protocols and acts as the main resolver. As it also manages the default strategies, it is guaranteed to
 always return one.
 </p>
 <p>
 Managing strategy registrations is not thread-safe. Callers must make sure that strategy resolver registrations do not interleave with
 actual resolution.
 </p>
 */
@interface WebStrategies : NSObject <SAML2WebStrategyResolver, OAuth2WebStrategyResolver, OTPWebStrategyResolver>

/**
 Returns the shared strategy instance.

 @return the strategy instance, always non-nil
 */
+(instancetype)sharedInstance;

/**
 Registers the specified resolver. Does nothing if the resolver happens to be this singleton.

 @param resolver the resolver, must be non-nil
 */
-(void)registerSAML2Resolver:(id<SAML2WebStrategyResolver>)resolver;

/**
 Registers the specified resolver. Does nothing if the resolver happens to be this singleton.

 @param resolver the resolver, must be non-nil
 */
-(void)registerOAuth2Resolver:(id<OAuth2WebStrategyResolver>)resolver;

/**
 Registers the specified resolver. Does nothing if the resolver happens to be this singleton.

 @param resolver the resolver, must be non-nil
 */
-(void)registerOTPResolver:(id<OTPWebStrategyResolver>)resolver;

@end
