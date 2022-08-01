//
//  SAML2WebStrategyResolver.h
//  HttpConvAuthFlows
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#ifndef SAML2WebStrategyResolver_h
#define SAML2WebStrategyResolver_h

#include "SAML2WebStrategy.h"

/**
 Strategy resolver that can be registered with <code>WebStrategies</code> to resolve <code>SAML2WebStrategy</code> objects for a given finish endpoint and finish
 endpoint parameter.
 <p>
 If a resolver fails to return a strategy then the next one is tried in the row. If no resolver returned a strategy then <code>WebStrategies</code> falls
 back to using a default one which uses a <code>WKWebView</code> to do the job.
 </p>
 */
@protocol SAML2WebStrategyResolver <NSObject>

/**
 Resolves the strategy that is to be used for the given parameters.
 
 @param finishEndpoint the finish endpoint, must be non-null
 @param finishParameters the finish endpoint param, must be non-null
 @return the resolved strategy or nil
 */
-(id<SAML2WebStrategy>)resolve:(NSString*)finishEndpoint withParam:(NSString*)finishParameters;

@end

#endif /* SAML2WebStrategyResolver_h */
