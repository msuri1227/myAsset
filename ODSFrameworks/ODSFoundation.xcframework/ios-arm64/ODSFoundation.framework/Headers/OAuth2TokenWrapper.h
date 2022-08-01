//
//  OAuth2TokenWrapper.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Immutable value object used primarily via <code>OAuth2TokenStorageProtocol</code> objects to store access and refresh tokens.
 
 TODO NSSecureCoding
 */
@interface OAuth2TokenWrapper : NSObject

/**
 The access token. Always non-nil.
 */
@property (nonatomic, readonly, strong) NSString* accessToken;

/**
 The refresh token. May be nil if no refresh token was acquired during the authorization flow that produced the access token.
 */
@property (nonatomic, readonly, strong) NSString* refreshToken;

/**
 Initializes this wrapper with the specified tokens.
 
 @param accessToken the access token, must be non-nil and non-empty
 @param refreshToken the refresh token, can be nil
 @return self
 */
-(instancetype)initWithAccessToken:(NSString*)accessToken refreshToken:(NSString*)refreshToken;

/**
 Default initialization of this class is not available.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
