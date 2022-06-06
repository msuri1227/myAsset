//
//  OAuth2WebStrategyResolver.h
//  HttpConvAuthFlows
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuth2WebStrategy.h"

/**
 Strategy resolver that can be registered with <code>WebStrategies</code> to resolve <code>OAuth2WebStrategy</code> objects for a given configuration.
 <p>
 If a resolver fails to return a strategy then the next one is tried in the row. If no resolver returned a strategy then <code>WebStrategies</code> falls
 back to using a default one which uses a <code>WKWebView</code> to do the job.
 </p>
 */
@protocol OAuth2WebStrategyResolver <NSObject>

/**
 Resolves the strategy for the specified arguments.

 @param config the OAuth2 configuration, must be non-nil
 @return the resolved strategy or nil
 */
-(id<OAuth2WebStrategy>)resolveForConfiguration:(OAuth2Config*)config;

@end
