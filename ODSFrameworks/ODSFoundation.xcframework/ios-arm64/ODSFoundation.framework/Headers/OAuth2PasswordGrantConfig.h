//
//  OAuth2PasswordGrantConfig.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2Config.h"

/**
 The username/password provider is nil.
 */
extern const NSInteger kHCAFOAuth2Config_UsernamePasswordProviderInvalid;


@class OAuth2PasswordGrantConfig;

/**
 Specialized asynchronous username/password provider to be used together with a <code>OAuth2PasswordGrantConfig</code> instance.
 */
@protocol OAuth2UsernamePasswordProviderProtocol <NSObject>

/**
 Invoked when the credentials are required for the OAuth2 Password grant. Should the completion block be called with any arguments that
 are nil then the authorization fails.
 
 @param config the configuration, must be non-nil
 @param completionBlock the block to invoke with the credentials, must be non-nil
 */
-(void)provideUsernamePasswordFor:(OAuth2PasswordGrantConfig*)config completion:(void(^)(NSString* username, NSString* password))completionBlock;

@end

/**
 Concrete subclass of <code>OAuth2Config</code> for the password grant type.
 */
@interface OAuth2PasswordGrantConfig : OAuth2Config

/**
 The username/password provider.
 */
@property (nonatomic, readonly, strong) id<OAuth2UsernamePasswordProviderProtocol> provider;

/**
 Initializes an config object of this type. Make sure to properly adhere to the parameter contracts.

 @param tokenEndpoint the token endpoint, must be non-nil
 @param scope the scope, can be nil
 @param clientId the client ID, must be non-nil and non-empty
 @param provider the provider, must be non-nil
 @param configurator the configurator to use (see superclass documentation), can be nil
 @param error the pointer to the error to report any problems with, can be nil
 @return self or nil if an error occured
 */
-(instancetype)initWithTokenEndpoint:(NSURL*)tokenEndpoint
               scope:(NSString*)scope
               clientId:(NSString*)clientId
               provider:(id<OAuth2UsernamePasswordProviderProtocol>)provider
               configurator:(id<ManagerConfiguratorProtocol>)configurator
               error:(NSError**)error;

@end
