//
//  OAuth2ServerSupportProtocol.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2Config.h"

/**
 The <code>OAuth2ServerSupportProtocol</code> is adopted by those classes which encompass the logic how the OAuth2 authorization flow is to be configured and
 executed against one or more resource servers protected with OAuth2.
 <p>
 An instance of this type can be registered with a <code>CommonAuthenticationConfigurator</code> object via the <code>addOAuth2ServerSupport:</code>
 method. From then on, the conversation managers configured with the configurator will have OAuth2 server support enabled and will start an OAuth2 Authorization Code
 flow whenever it's necessary.
 </p>
 <p>
 Think of a class of this type as one that holds the OAuth2-related knowledge about certain servers and what to do to acquire the proper credentials to access
 resources on it. Refer to the documentation of the methods of this protocol to understand when and how they are used in the overall OAuth2 flow implemented
 in this library.
 </p>
 <p>
 For convenience, when working with SAP-specific server solutions the built-in <code>SAPOAuth2ServerSupport</code> class can be an option. Refer to its documentation
 to check which servers can it support and how to use it.
 </p>
 */
@protocol OAuth2ServerSupportProtocol <NSObject>

/**
 Determines whether the endpoint specified by the given URL is one that this server support object can handle in terms of OAuth2 authentication. This method is
 asynchronous which allows implementations to employ complex mechanisms (for ex. pinging the server) to auto-detect whether the targeted endpoint is on a supported
 server or not.
 <p>
 However, repeatedly issuing time-consuming auto-detection mechanisms is discouraged as this method is invoked quite often during response processing.
 </p>
 <p>
 During the analysis of a response, this library calls the registered server support objects one after the other until one is found that returns YES from this
 method. From then on, the found server support object is marked as the winning one and is assumed to be able to assist in the remaining steps of the OAuth2
 authorization flow. In other words, this is the first method that gets called on an object of this type and the rest of the methods are called only if this one
 returns YES.
 </p>
 <p>
 Mainly, this method is called whenever a HTTP response with status code between 400 and 500 is received as the first step of analizing the response to decide if it's
 an OAuth2 challenge or not. Furthermore, this method is invoked before every request when attempting to find a suitable access token in the storage.
 </p>
 
 @param url the URL of the endpoint concerning which an assessment is needed, must be non-nil
 @param completionBlock the block to be invoked with YES or NO, depending on whether the endpoint is a supported one or not
 */
-(void)isSupportedEndpoint:(NSURL*)url completion:(void(^)(BOOL supported))completionBlock;

/**
 This method attempts to determing whether the particular response is to be treated as an OAuth2 challenge, meaning that the targeted resource can be accessed
 only by acquiring an access token first. The response URL is one that is found to be supported as of <code>isSupportedEndpoint:completion:</code>.
 <p>
 The way certain resource servers indicate that proper OAuth2 authorization is required might vary from server to server. This method holds the knowledge with respect
 to a particular set of servers and is capable of recognizing their specific way of telling the client that the proper access token must be obtained beforehand.
 </p>
 
 @param response the HTTP response containing a status code between 400 and 500, must be non-nil
 @return YES if the specified response indicates that its an OAuth2 challenge, NO otherwise
 */
-(BOOL)canRecognizeChallengeInResponse:(NSHTTPURLResponse*)response;

/**
 During the OAuth2 authorization flow, if no access or refresh tokens are available, the authorization code flow needs to be started. This method is
 invoked to return the specific configuration object containing important parameters such as the authorization endpoint, token endpoint, client IDs and
 secrets, etc..
 <p>
 If this method returns a nil configuration via the completion handler then it is considered as a fatal error causing the OAuth2 authorization to come to a
 full stop in the current conversation. The same error occurs if the returned configuration is not one of the <code>Oauth2Config</code> subclasses shipped with
 this library.
 </p>
 
 @param challengeResponse the challenge response for which the <code>canRecognizeChallengeInResponse:</code> returned YES previously, must be non-nil
 @param completionBlock the block to be invoked with the OAuth2 configuration, must be non-nil
 */
-(void)configForChallenge:(NSHTTPURLResponse*)challengeResponse completion:(void(^)(OAuth2Config* config))completionBlock;

/**
 After the access and refresh tokens have been acquired, the OAuth2 functionality of this library will make an attempt to persist said tokens via the
 <code>OAuth2TokenStoreProtocol</code> object this server support object has been registered together with. However, the tokens need to be stored in a server-specific
 manner.
 <p>
 This method is called when this library attempts to either read or persist the tokens from/to a token storage. Implementors can use it to transform a specific request URL
 to another URL that then can be used as a key for storing and retrieving a token. Note that the transformed URL is purely virtual and serves only identification purposes, it
 is never attempted to be opened or accessed in any way.
 </p>
 <p>
 The transformation realized by this method is what implicitly determines the scope of the tokens. For example, if an implementor would like to store the tokens for
 <code>example.com/foo/...</code> and <code>example.com/bar/...</code> URLs separately then the corresponding suffix should be trimmed off of the specified URL.
 Calling this method then with <code>http://example.com/foo/a/b/c/resource</code> will yield <code>http://example.com/foo</code>. Note that the implementor must pay attention
 to the used URL scheme as the returned URL is used as-is as a key to store the tokens.
 </p>
 <p>
 Returning the argument without modifications will cause the corresponding tokens to be used only when the request URL exactly matches the one which they have been
 acquired for.
 </p>
 <p>
 This library ensures that tokens acquired with the help of different <code>OAuth2ServerSupportProtocol</code> objects cannot be intermixed with each other
 within a single <code>OAuth2TokenStorageProtocol</code> object.
 </p>
 
 @param requestUrl the URL for which either a challenge has been received and tokens need to be read or OAuth2 authorization has completed successfully and the
                   tokens must be stored, must be non-nil
 @return the transformed URL to use as a key when persisting or reading access and refresh tokens, always non-nil
 */
-(NSURL*)transformRequestURLToStorageURL:(NSURL*)requestUrl;

@end
