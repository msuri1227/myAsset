//
//  SAML2AuthInteractionRequest.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Immutable value object used as the interaction request object for commencing SAML2 authentication. To comply with the
 contracts of the <code>UserInteractionMultiplexer</code> library, this class implements the <code>isEqual:</code> method
 which returns true if an object of this type is compared with another object having the same type and equal properties.
 <p>
 This equality will ensure that when multiple HTTP requests run into the SAML2 challenge then only one web view is going to
 be displayed for all of them, provided that all the SAML2 configuration parameters and the token are the same.
 </p>
 <p>
 An object of this type is used by the default SAML2 web strategy.
 </p>
 */
@interface SAML2AuthInteractionRequest : NSObject

/**
 The token value this object has been initialized with.
 */
@property (nonatomic, readonly, assign) void* token;

/**
 The finish endpoint, as coming from the SAML2 config. This is practically a complete URL at which the
 SAML2 authentication flow begins.
 */
@property (nonatomic, readonly, strong) NSURL* finishEndpoint;

/**
 The finish endpoint parameter as coming from the SAML2 config.
 */
@property (nonatomic, readonly, strong) NSString* finishParameters;

/**
 Initializes this SAML2 auth. interaction request given the specified arguments. The token can be used by
 <code>UserInteractionHandlerProtocol</code> implementations to filter which interaction requests to handle. Its value
 is irrelevant, as a pointer it is never dereferenced and is meant only for identification of a family of related interaction
 requests. It is best initialized with a pointer to an arbitrary static variable.

 @param token the token, must be non-nil
 @param finishEndpoint the finish endpoint, as coming from the SAML2 config, must be non-nil
 @param finishParameters the finish parameters, as coming from the SAML2 config, must be non-nil
 @return self
 */
-(instancetype)initWithToken:(void*)token andFinishEndpoint:(NSString*)finishEndpoint andParameters:(NSString*)finishParameters;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
