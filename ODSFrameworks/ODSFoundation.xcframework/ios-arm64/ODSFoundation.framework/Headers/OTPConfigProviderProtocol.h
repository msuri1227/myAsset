//
//  OTPConfigProviderProtocol.h
//  HttpConvAuthFlows
//
//  Created by Palfi, Andras on 09/10/15.
//  Copyright © 2015 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Block type used by the OTP config provider through which the configuration itself is returned. A valid configuration is one for which
 the mandatory fields are all non-nil. If a provider is unable to return a configuration then it should invoke this block with nil
 arguments.
 
 @param responseHeaderKey the name of the HTTP response header which is to be read to check for the type of challenge, must be non-nil
 @param responseHeaderValue the value of the HTTP response header with the name indicated by the <code>responseHeaderKey</code> argument
                            indicating an OTP challenge, must be non-nil
 @param otpUrlAdditionalParams additional parameters appended to the URL when loading the  OTP form in the webView. Can be nil. It should be
                               a proper URL encoded query string without the leading ? or & character. Can contain more key/value pairs.
 @param finishEndpoint string representing the URL query parameter list which if loaded in the webView indicates a successful OTP authentication.
                       Must be non-nil and must be properly URL encoded.
 */
typedef void(^otp_config_provider_completion_t)(NSString* responseHeaderKey, NSString* responseHeaderValue, NSString* otpUrlAdditionalParams, NSString* finishEndpoint);

/**
 Protocol implemented by classes which are capable of returning OTP configurations. Such a config is essential in being able to detect an OTP challenge and
 commence the corresponding OTP authentication flow.
 <p>
 Instances of this type are registered using the <code>addOTPConfigProvider:</code> method of the <code>CommonAuthenticationConfigurator</code> class. During
 conversation execution, its provider method is then called whenever an HTTP redirect is received. As multiple providers might be added to the configurator, the
 first one to return a valid configuration wins.
 </p>
 */
@protocol OTPConfigProviderProtocol <NSObject>

/**
 Invoked when the filters during conversation execution receive an HTTP redirect and need an OTP configuration for checking whether it is an OTP challenge or not.

 @param anUrl the URL to which the request has been sent and for which a redirect has been received. must be non-nil
 @param completion block to be called with the configuration, must be non-nil
 */
-(void)OTPConfigForURL:(NSURL*)anUrl completion:(otp_config_provider_completion_t)completion;

@end
