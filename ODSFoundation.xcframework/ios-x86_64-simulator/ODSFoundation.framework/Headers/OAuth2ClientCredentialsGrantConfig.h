//
//  OAuth2ClientCredentialsGrantConfig.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2Config.h"

/**
 The client secret is nil.
 */
extern const NSInteger kHCAFOAuth2Config_ClientSecretInvalid;

/**
 Concrete subclass of <code>OAuth2Config</code> for the client credentials grant type.
 */
@interface OAuth2ClientCredentialsGrantConfig : OAuth2Config

/**
 The Client Secret (as defined by the OAuth2 standard). May be nil.
 */
@property (nonatomic, readonly, strong) NSString* clientSecret;

/**
 Initializes an config object of this type. Make sure to properly adhere to the parameter contracts.

 @param tokenEndpoint the token endpoint, must be non-nil
 @param scope the scope, can be nil
 @param clientId the client ID, must be non-nil and non-empty
 @param clientSecret the client secret, must be non-nil and non-empty
 @param configurator the configurator to use (see superclass documentation), can be nil
 @param error the pointer to the error to report any problems with, can be nil
 @return self or nil if an error occured
 */
-(instancetype)initWithTokenEndpoint:(NSURL*)tokenEndpoint
               scope:(NSString*)scope
               clientId:(NSString*)clientId
               clientSecret:(NSString*)clientSecret
               configurator:(id<ManagerConfiguratorProtocol>)configurator
               error:(NSError**)error;

@end
