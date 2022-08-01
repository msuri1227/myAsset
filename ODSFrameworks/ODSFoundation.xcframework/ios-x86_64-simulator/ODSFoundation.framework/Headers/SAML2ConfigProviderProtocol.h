//
//  SAMLConfigProviderProtocol.h
//  HttpConvAuthFlows
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Block type used SAML2 config providers to return the configuration. A valid configuration is one for which
 the mandatory fields are all non-nil. If a provider is unable to return a configuration then it should invoke this block with nil
 arguments.
 
 @param responseHeader the name of the HTTP response header whose presence indicates a SAML2 challenge, can be nil
 @param finishEndpoint the full URL at which the SAML2 authentication starts and finishes, must be non-nil
 @param finishParameters the URL query parameter that if present when the web view loads the finish endpoint indicates the end of the SAML2 auth. flow, must be non-nil
 */
typedef void (^saml2_config_provider_completion_t)(NSString* responseHeader, NSString* finishEndpoint, NSString* finishParameters);

/**
 Protocol implemented by classes which are capable of returning SAML2 configurations. Such a config is essential in being able to detect an SAML2 challenge and
 commence the corresponding SAML2 authentication flow.
 <p>
 Instances of this type are registered using the <code>addSAML2ConfigProvider:</code> method of the <code>CommonAuthenticationConfigurator</code> class. During
 conversation execution, its provider method is then called whenever an HTTP response is received. As multiple providers might be added to the configurator, the
 first one to return a valid configuration wins.
 </p>
 */
@protocol SAML2ConfigProviderProtocol <NSObject>

/**
 Invoked when the filters during conversation execution receive an HTTP response and need a SAML2 configuration for checking whether it is a SAML2 challenge or not.

 @param url the URL to which an HTTP request has been sent and a response has just been received, must be non-nil
 @param completionBlock block to be called with the configuration, must be non-nil
 */
-(void)provideSAML2ConfigurationForURL:(NSURL*)url completionBlock:(saml2_config_provider_completion_t)completionBlock;

@end
