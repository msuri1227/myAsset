//
//  ClientCertAuthProviderProtocol.h
//  HttpConvAuthFlows
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Block type used by <code>ClientCertProviderProtocol</code> implementations which is to be called when the process of attempting
 to acquire credentials completes either successfully or with an error.
 <p>
 To indicate success, call this block with a non-nil credential object and a nil error object. Any other parametrization is considered
 as failure.
 </p>

 @param credentials the acquired credentials or nil if no X.509 certificate could have been collected, can be nil
 @param error the error that describes a failure, can be nil
 */
typedef void (^client_cert_provider_completion_t)(NSURLCredential* credentials, NSError* error);

/**
 X.509 client certificate provider protocol implemented by classes that are capable of returning credentials asynchronously. Objects conforming to this protocol
 are called in the middle of HTTP request processing when a client certificate challenge is detected.
 <p>
 To make use of a provider implementation, register it with a <code>CommonAuthenticationConfigurator</code> and then use it to configure a conversation manager.
 </p>
 */
@protocol ClientCertProviderProtocol <NSObject>

/**
 This method is invoked when a X.509 client certificate challenge is detected during the execution of a conversation. The specified block is to be
 invoked when the credentials are available or when the challenge handling cannot be fulfilled.

 @param authChallenge the authentication challenge initialized with a certificate, must be non-nil
 @param completionBlock the block to invoke with the results, must be non-nil*/
-(void)provideClientCertForAuthChallenge:(NSURLAuthenticationChallenge*)authChallenge completionBlock:(client_cert_provider_completion_t)completionBlock;

@end
