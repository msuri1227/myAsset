//
//  OAuth2WebStrategy.h
//  HttpConvAuthFlows
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2AuthCodeGrantConfig.h"

/**
 Static class used by <code>OAuth2WebStrategy</code> implementations for tasks common to all implementations.
 */
@interface OAuth2WebStrategyHelper : NSObject

/**
 Determines whether the specified URL is the closing redirect signaling the end of the OAuth2 authorization flow given the specified
 configuration which is expected to come from the OAuth2 configuration the flow has been started with.

 @param url the URL to test, can be nil
 @param config thr OAuth2 configuration, must be non-nil
 @return the authorization code if it is the closing redirect or nil otherwise
 */
+(NSString*)examineIfClosingRedirect:(NSURL*)url withConfig:(OAuth2Config*)config;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end

/**
 Protocol defining the strategy how to open the URL that starts the OAuth2 Authorization Code flow to acquire the access token.
 */
@protocol OAuth2WebStrategy <NSObject>

/**
 Starts the OAuth2 flow for performing the authentication given the specified parameters.
 
 @param config the OAuth2 configuration, must be non-nil
 @param completionBlock the completion block that is to be invoked at the end of the flow. It is invoked with the access token or nil if authentication failed.
 */
-(void)startAuthorizationCodeFlowWith:(OAuth2AuthCodeGrantConfig*)config completion:(void (^)(NSString*))completionBlock;

@end
