//
//  OAuth2AuthCodeGrantConfig.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2Config.h"

/**
 The authorization endpoint is nil.
 */
extern const NSInteger kHCAFOAuth2Config_AuthorizationEndpointInvalid;

/**
 The specified redirect URI is nil.
 */
extern const NSInteger kHCAFOAuth2Config_RedirectURIInvalid;

/**
 The URI scheme of the redirect URI is a custom one but it's not supported by this application.
 */
extern const NSInteger kHCAFOAuth2Config_RedirectURISchemeNotSupported;

/**
 Concrete subclass of <code>OAuth2Config</code> which contains the additional parameters required to configure an Authorization Code grant type.
 Just like its superclass, it allows one to set a nil Client Secret. This is because the best practice accepted by the industry is to use
 the Authorization Code flow without a Client Secret rather than the Implicit grant type. This implementation follows this guideline.
 <p>
 The OAuth2 functionality in this library allows one to set non-HTTP URLs for the authorization endpoint and the redirect URI. This can be used
 to open other applications on the same device using their custom URI schemes. However, the redirect URI is validated against the custom URI schemes
 registered in the 'Info.plist' of this application when necessary. If the initializer finds that this app does not support the specified scheme then this means
 that the targeted application has no chance of channeling the authorization code back to this one, therefore the OAuth2 flow cannot complete in any way.
 This is signaled using an error with the corresponding error code and description. This check is omitted if both the authorization endpoint and the redirect URI
 use an HTTP scheme.
 </p>
 <p>
 When using non-HTTP URLs for the authorization endpoint then the <code>CustomURLSchemeManagement</code> class has to be used to channel the
 authorization code back to this application. Read the documentation of that class for what needs to be done for all components to be wired up correctly.
 </p>
 */
@interface OAuth2AuthCodeGrantConfig : OAuth2Config

/**
 The Authorization Endpoint (as defined by the OAuth2 standard). Always non-nil.
 */
@property (nonatomic, readonly, strong) NSURL* authorizationEndpoint;

/**
 The Client Secret (as defined by the OAuth2 standard). May be nil.
 */
@property (nonatomic, readonly, strong) NSString* clientSecret;

/**
 The Redirect URL (as defined by the OAuth2 standard). Always non-nil.
 */
@property (nonatomic, readonly, strong) NSURL* redirectUri;

/**
 Initializes an config object of this type. Make sure to properly adhere to the parameter contracts.

 @param authorizationEndpoint the authorization endpoint, must be non-nil
 @param tokenEndpoint the token endpoint, must be non-nil
 @param scope the scope, can be nil
 @param clientId the client ID, must be non-nil and non-empty
 @param clientSecret the client secret, may be nil or empty
 @param redirectUri the redirect URI, must be non-nil
 @param configurator the configurator to use (see superclass documentation), can be nil
 @param error the pointer to the error to report any problems with, can be nil
 @return self or nil if an error occured
 */
-(instancetype)initWithAuthorizationEndpoint:(NSURL*)authorizationEndpoint
               tokenEndpoint:(NSURL*)tokenEndpoint
               scope:(NSString*)scope
               clientId:(NSString*)clientId
               clientSecret:(NSString*)clientSecret
               redirectUri:(NSURL*)redirectUri
               configurator:(id<ManagerConfiguratorProtocol>)configurator
               error:(NSError**)error;

/**
 Method returning the URL derived from the authorization endpoint and the rest of the OAuth2 configuration parameters.
 This is what needs to be be sent the HTTP GET request to commence the OAuth2 Authorization Code flow.

 @param state the state parameter of the request, can be nil
 @return the authorization request URL pointing to the authorization endpoint, always non-nil
 */
-(NSURL*)authorizationRequestUrlWithState:(NSString*)state;

@end
