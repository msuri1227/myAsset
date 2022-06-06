//
//  OAuth2TokenManager.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2TokenWrapper.h"

/**
 OAuth2 token manager using which the acquired access and refresh tokens can be managed.
 <p>
 The OAuth2 flow can be configured using an instance of <code>CommonAuthenticationConfigurator</code> by calling its <code>addOAuth2ServerSupport:</code> and adding
 so-called server support objects. Refer to the documentation of the <code>OAuth2ServerSupportProtocol</code> and of the adder method to understand how it works. In short:
 this allows for teaching the configurator how to orchestrate the OAuth2 authorization flow with a particular server.
 </p>
 <p>
 Using the prepared <code>CommonAuthenticationConfigurator</code> (where 'prepared' means that the appropriate OAuth2 server support objects have been added to it), one can
 then configure a <code>HttpConversationManager</code>. When the OAuth2 authorization flows run as part of the HTTP requests executed via this manager, the acquired tokens
 are going to be stored in the storage specified for the configurator using its <code>tokenStorage</code> property. The below example summarizes all this:
 </p>
 <pre>
 CommonAuthenticationConfigurator* configurator = [CommonAuthenticationConfigurator new];
 [configurator addOAuth2ServerSupport:[SAPOAuth2ServerSupport alloc] initWithURL ...];
 configurator.tokenStorage = [CustomOAuth2TokenStorage new];
 HttpConversationManager* manager = [HttpConversationManager new];
 [configurator configureManager:manager];
 </pre>
 <p>
 In this example, a single OAuth2 server support, the <code>SAPOAuth2ServerSupport</code> is added. This knows how to orchestrate the OAuth2 flow against SAPcp servers. For
 the token storage, a new instance of <code>CustomOAuth2TokenStorage</code>. This is just an example and assumes that this storage is implemented by the application. It could
 be left out in case of which a default in-memory storage would be used.
 </p>
 <p>
 Now, after the above <code>configureManager:</code> call the <code>manager</code> instance stands ready to fire requests against the server. If an OAuth2 challenge is detected
 then it will be handled using the configured support object and the tokens will be stored in the above specified storage.
 </p>
 <p>
 The OAuth2 token manager enters the picture at this point. It can be obtained using the <code>tokenManager</code> property of the above configurator instance. It also contains the
 token storage and all the server support objects added to the configuration but uses them for the purpose of managing the tokens.
 </p>
 <p>
 This class is needed as a configurator is usually a short-lived object which is used only for configuring a <code>HttpConversationManager</code> instance. After that, it can be
 thrown away. If the application wants to manage the access and refresh tokens acquired during the OAuth2 authorization flows manually then before throwing away the configurator
 its token manager instance should be saved. From then on, the token manager and the configured conversation manager will belong together: the application can fire requests using
 the latter and have access to the tokens using the former. Read on for the method-level documentations of this class for the details.
 </p>
 */
@interface OAuth2TokenManager : NSObject

/**
 Instantiation is not possible from the outside. Use <code>CommonAuthenticationConfigurator.tokenManager</code> to get an instance of this class.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 Instantiation is not possible from the outside. Use <code>CommonAuthenticationConfigurator.tokenManager</code> to get an instance of this class.
 */
-(instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Removes the tokens for the specified URL. This can be handy if the client wants to 'log out' the application by throwing away the tokens.
 The completion block is invoked if removal is successful. Note that a missing token also counts as a successful removal.

 @param url the URL for which access and refresh tokens should be removed, must be non-nil
 @param completion the block invoked with YES or NO if removal succeeded or failed, can be nil
 */
-(void)deleteTokensForUrl:(NSURL*)url completion:(void(^)(BOOL))completion;

/**
 Removes all the tokens in the underlying storage. This is merely for convenience to prevent the application from having to keep a reference
 to the underlying token storage object.

 @param completion the block invoked with YES if removal succeeds or NO if a problem occured, can be nil
 */
-(void)removelAllTokensWithCompletion:(void(^)(BOOL success))completion;

/**
 Returns the access and refresh tokens in the form of a wrapper object for the specified URL.

 @param url the URL for which access and refresh tokens should be acquired, must be non-nil
 @param completion the completion invoked with the wrapper or nil if the tokens were not found, must be non-nil
 */
-(void)tokensForUrl:(NSURL*)url completion:(void(^)(OAuth2TokenWrapper*))completion;

@end
