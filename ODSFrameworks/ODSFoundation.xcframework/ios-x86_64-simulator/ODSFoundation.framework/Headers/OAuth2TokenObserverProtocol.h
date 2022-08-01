//
//  OAuthTokenObserverProtocol.h
//  HttpConvAuthFlows
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConversationObserverProtocol.h"
#import "OAuth2TokenWrapper.h"

/**
 Protocol adpoted by classes which would like to observe when a particular access/refresh token pair is used to successfully authorize against
 a particular endpoint.
*/
@protocol OAuth2TokenObserverProtocol <HttpConversationObserverProtocol>

/**
 Invoked when the authorization to the specified URL succeeds with the specified tokens.

 @param tokens the wrapper that contains the necessary tokens, must be non-nil
 @param requestUrl the URL for which a request passed the authorization using the the specified access token, must be non-nil
*/
-(void)observeTokens:(OAuth2TokenWrapper*)tokens thatSucceededForURL:(NSURL*)requestUrl;

@end
