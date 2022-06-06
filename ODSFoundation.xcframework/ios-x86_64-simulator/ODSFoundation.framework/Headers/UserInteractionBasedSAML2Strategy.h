//
//  UserInteractionBasedSAML2Strategy.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAML2WebStrategy.h"

#import "UserInteractionMultiplexer.h"

/**
 This is an implementation of the <code>SAML2WebStrategy</code> protocol that makes use of the <code>UserInteractionMultiplexer</code> library
 to orchestrate the SAML2 authentication flow. It is best used for strategy implementations which require some user interaction in order to
 perform the authentication.
 <p>
 An object of this type is initialized for a particular <code>UserInteractionMultiplexer</code> instance and a token value. When a SAML2 authentication
 is to be started then this object simply creates a new <code>SAML2AuthInteractionRequest</code> object with the SAML2 config parameters and the
 token this object has been initialized with. Then, the interaction request is submitted to the multiplexer that has been passed to the initializer.
 </p>
 <p>
 This class is also an abstract implementation of the <code>UserInteractionHandlerProtocol</code> which can handle those <code>SAML2AuthInteractionRequest</code>
 objects which were created with the token passed to the initializer. Practically, this means that this class fits into both the web strategy abstraction of
 this library and into the user interaction handler abstraction of the <code>UserInteractionMultiplexer</code> library.
 </p>
 <p>
 For everything to be wired up correctly, the initializer of this method immediately registers itself as a user interaction handler with the specified
 multiplexer. Therefore, most subclasses are better off being implemented as singletons or instantiated only once. Creating multiple strategy objects of this
 type with the same token and multiplexer yields undefined behaviour as to which one is going to actually handle the <code>SAML2AuthInteractionRequest</code>
 object that the <code>startSAML2Authentication:withParam:completion:</code> method submits.
 </p>
 <p>
 Being an abstract class, the <code>createInteractionForRequest:completion:</code> method must be implemented by subclasses. Implementations usually kick
 off some kind of UI logic to perform the SAML2 authentication. The result object of the interaction is irrelevant. Only the cancellation flag is used to decide
 whether the operation was successful or not.
 </p>
 <p>
 The built-in default SAML2 web strategy implementation is a subclass of this type. It executes the entire SAML2 auth. flow inside a <code>WKWebView</code>
 and works with the default multiplexer.
 </p>
 <p>
 By contract, subclasses may not override neither the <code>startSAML2Authentication:withParam:completion:</code> nor the
 <code>createInteractionForRequest:completion:</code> methods. To implement a strategy that kicks in only for certain types of finish endpoints, for example,
 it is best implemented in the strategy resolver object that returns an instance of this type. Consult the documentation of <code>SAML2WebStrategyResolver</code>
 for the details.
 </p>
 */
@interface UserInteractionBasedSAML2Strategy : NSObject <SAML2WebStrategy, UserInteractionHandlerProtocol>

/**
 Initializes a strategy of this type which will submit <code>SAML2AuthInteractionRequest</code> objects initialized with the given token
 to the specified multiplexer whenever this object is called to start a SAML2 authentication flow.
 
 @param multiplexer the multiplexer to submit to, must ben non-nil
 @param token the token to create SAML2 interaction request objects with, must be non-nil
 @return self
 */
-(instancetype)initWithMultiplexer:(UserInteractionMultiplexer*)multiplexer andToken:(void*)token;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
