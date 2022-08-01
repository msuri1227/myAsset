//
//  CommonAuthenticationConfigurator.h
//  HttpConvAuthFlows
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerConfiguratorProtocol.h"
#import "UsernamePasswordProviderProtocol.h"
#import "ClientCertProviderProtocol.h"
#import "SAML2ConfigProviderProtocol.h"
#import "OAuth2ServerSupportProtocol.h"
#import "OAuth2TokenStorageProtocol.h"
#import "OAuth2TokenManager.h"
#import "OTPConfigProviderProtocol.h"

/**
 Configurator which contains the common authentication methods: basic, client certificate, OAuth and SAML. Invoking the <code>configureManager:</code> method
 configures the specified manager by adding the necessary filters and other user exits that make use of the configured provider.
 <p>
 If an already configured manager is configured again then only those providers are added to the conversation manager which are not already present. Consequently,
 this operation is idempotent. This means that configuring the manager with the exact same set of providers multiple times has no effect.
 </p>
 <p>
 The web-based authentication flows supported by this class (SAML2, OAuth2 and OTP) can be further customized using the <code>WebStrategies</code> class.
 Consult its API documentation for the details. Moreover, the OTP authentication type, when using the default strategy, relies on the <code>CustomURLSchemeManager</code>
 class which might require additional steps from the application developer before the OTP authentication can operate. Read its API documentation as to what needs to be
 done.
 </p>
 <p>
 In short, it is possible to rely on the default web strategies and not care about the API of the <code>WebStrategies</code> class. In that case the application needs to
 be linked to the <code>UserInteractionMultiplexer</code> library and the <code>UserInteractionMultiplexer.bundle</code> also needs to be added as bundle resource to the
 application. Missing to do so will result in linkage or run-time errors.
 </p>
 */
@interface CommonAuthenticationConfigurator : NSObject <ManagerConfiguratorProtocol>

/**
 The token storage that is used to persist and retrieve OAuth2 access and refresh tokens. Its value is never nil. If set to nil then it is reset to the
 default in-memory storage implementation.
 */
@property (nonatomic, strong) id<OAuth2TokenStorageProtocol> tokenStorage;

/**
 The token manager that can be used to access the access and refresh tokens managed by the <code>HttpConversationManager</code>s configured using this
 configurator. Note that this property is nil if no server support objects have been configured yet, that is <code>addOAuth2ServerSupport:</code> has
 not been called yet.
 <p>
 Also note that the returned manager will make use of the token storage and the configured server support objects which were set at the time this property
 is accessed. If the token storage or the server support objects change in this configurator object afterwards then those changes will not be reflected by
 the returned token manager.
 </p>
 */
@property (nonatomic, readonly, strong) OAuth2TokenManager* tokenManager;

/**
 Indicates whether SAPcpms/SMP/Gateway server specific CSRF token support is enabled. To be compliant with the behaviour of the <code>HttpConversationManager</code>
 of earlier versions, this property is by default enabled.
 <p>
 This functionality will ensure that whenever the OData endpoints of a particular SAPcpms/SMP/Gateway server is accessed with POST/PUT/DELETE/... requests the
 CSRF token is going to be fetched and included in the request as appropriate. This mechanism is completely transparent and requires no external
 configuration on top of this property. Should the CSRF token support be disabled on the server side then this functionality will not interfere with
 normal request execution.
 </p>
 */
@property (nonatomic, assign) BOOL enableSMPCSRFTokenSupport;

/**
 Disables registration of custom NSHTTPURLProtocol implementation.
 <p>
 This method is deprecated and is now a no-op as the <code>NSURLProtocol</code> replacement has been taken out of this library as it was prone
 to producing more problems.
 </p>
 */
+(void)disableNSHTTPURLProtocolReplacement:(BOOL)disable DEPRECATED_ATTRIBUTE;


/**
 Returns if registration of NSHTTPURLProtocol is enabled or not.
 <p>
 This method is deprecated and is now a no-op as the <code>NSURLProtocol</code> replacement has been taken out of this library as it was prone
 to producing more problems. It always returns NO.
 </p>
 */
+(BOOL)isNSHTTPURLProtocolReplacementEnabled DEPRECATED_ATTRIBUTE;

/**
 Registers a new username/password provider.

 @param usernamePasswordProvider the new provider to register, must be non-nil
*/
-(void)addUsernamePasswordProvider:(id<UsernamePasswordProviderProtocol>)usernamePasswordProvider;

/**
 Registers a new X.509 client certificate provider.

 @param clientCertProvider the new provider to register, must be non-nil
 */
-(void)addClientCertProvider:(id<ClientCertProviderProtocol>)clientCertProvider;

/**
 Registers a new SAML2 config provider. As this is a web-based authentication mechanism, make sure to read the corresponding
 notes documented in the header documentation of this class.

 @param samlConfigProvider the new provider to register, must be non-nil
 */
-(void)addSAML2ConfigProvider:(id<SAML2ConfigProviderProtocol>)samlConfigProvider;

/**
 Registers a new OAuth2 server support. As this is a web-based authentication mechanism, make sure to read the corresponding notes documented in
 the header documentation of this class.

 @param serverSupport the server support object, must be non-nil
 */
-(void)addOAuth2ServerSupport:(id<OAuth2ServerSupportProtocol>)serverSupport;

/**
 Registers a new OTP config provider. As this is a web-based authentication mechanism, make sure to read the corresponding
 notes documented in the header documentation of this class.

 @param otpConfigProvider the new provider to register, must be non-nil
 */
-(void)addOTPConfigProvider:(id<OTPConfigProviderProtocol>)otpConfigProvider;

@end
