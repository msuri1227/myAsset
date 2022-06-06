//
//  OAuth2Config.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ManagerConfiguratorProtocol.h"

/**
 The error reported by initializers of <code>OAuth2Config</code> classes.
 */
extern NSString* const kHCAFOAuth2ConfigErrorDomain;

/**
 The specified token endpoint is nil.
 */
extern const NSInteger kHCAFOAuth2Config_TokenEndpointInvalid;

/**
 The specified token endpoint has an URI scheme that is not <code>http</code> or <code>https</code>.
 */
extern const NSInteger kHCAFOAuth2Config_TokenEndpointNonHttpScheme;

/**
 The specified client ID is nil or empty.
 */
extern const NSInteger kHCAFOAuth2Config_ClientIdInvalid;

/**
 Immutable value-object returned by classes conforming to the <code>OAuth2ServerSupportProtocol</code>. It contains the common parameters for all configuration types.
 Being an abstract class, it cannot be instantiated directly. Instead, use the specific subclasses corresponding to the various supported OAuth2 grant types.
 <p>
 This class performs validation of its parameters during initialization. Any returned error will use the <code>kHCAFOAuth2ConfigErrorDomain</code> and the error codes
 defined by the <code>kHCAFOAuth2Config_*</code> constants. This also applies to subclasses.
 </p>
 <p>
 The <code>ManagerConfiguratorProtocol</code> object that may be provided to the initializer is used to configure those conversation managers that are used when sending
 access and refresh token requests. Certain backends might require authentication on these backends. The configurator returned can be used to prepare the conversation
 manager for the possible authentication challenges.
 </p>
 
 TODO NSSecureCoding
 */
@interface OAuth2Config : NSObject

/**
 Property that indicates whether the specified configuration is web-based, that is, requires that a request be sent in a browser window
 to allow for the user to interact with the authorization flow.
 */
@property (nonatomic, readonly, assign) BOOL webBased;

/**
 The Token Endpoint (as defined by the OAuth2 standard). Always non-nil.
 */
@property (nonatomic, readonly, strong) NSURL* tokenEndpoint;

/**
 The scope of authorization (as defined by the OAuth2 standard). May be nil.
 */
@property (nonatomic, readonly, strong) NSString* scope;

/**
 The Client ID (as defined by the OAuth2 standard). Always non-nil.
 */
@property (nonatomic, readonly, strong) NSString* clientId;

/**
 The configurator to use when configuring the <code>HttpConversationManager</code> object that is used for sending access
 and refresh token requests.
 */
@property (nonatomic, readonly, strong) id<ManagerConfiguratorProtocol> configurator;

/**
 Initializes an config object of this type. Make sure to properly adhere to the parameter contracts.

 @param tokenEndpoint the token endpoint, must be non-nil
 @param scope the scope, can be nil
 @param clientId the client ID, must be non-nil and non-empty
 @param configurator the configurator used to configure <code>HttpConversationManager</code> objects used during OAuth2 request sending, can be nil
 @param error the pointer to the error to report any problems with, can be nil
 @return self or nil if an error occured
 */
-(instancetype)initWithTokenEndpoint:(NSURL*)tokenEndpoint
               scope:(NSString*)scope
               clientId:(NSString*)clientId
               configurator:(id<ManagerConfiguratorProtocol>)configurator
               error:(NSError**)error;

/**
 Default initialization of this class is not available.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
