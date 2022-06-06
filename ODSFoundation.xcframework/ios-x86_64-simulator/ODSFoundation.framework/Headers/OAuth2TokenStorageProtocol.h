//
//  OAuth2TokenStorageProtocol.h
//  HttpConvAuthFlows
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2TokenWrapper.h"

/**
 Protocol that is used to specify the abstraction of a simple OAuth2 access and refresh token storage that can persist and retrieve tokens for multiple resource
 servers which are identified by so-caled <i>token storage keys</i>.
 <p>
 When reading from or writing to a storage, the OAuth2 functionality of this library first calls the <code>transformRequestURLToStorageURL:</code> of the
 <code>OAuth2ServerSupportProtocol</code> object. Then, using the class name of the server support protocol implementation in question forms the opaque token
 storage key. This key is then used when calling the methods of this object to access the tokens.
 </p>
 <p>
 An implementation can be as simple as an <code>NSMutableDictionary</code> but can be more sophisticated that ensures the secure storage of the tokens via
 an encrypted file or the keychain, for example.
 </p>
 <p>
 Implementations should be thread-safe.
 </p>
 */
@protocol OAuth2TokenStorageProtocol <NSObject>

/**
 Returns the token wrapper object for the specified opaque token storage key.
 
 @param tokenStorageKey the opaque token storage key to return the tokens for, must be non-nil
 @param completion the handler to be called with the wrapper object containing the tokens or nil if no tokens are stored for the specified key
 */
-(void)tokensForKey:(NSString*)tokenStorageKey completion:(void(^)(OAuth2TokenWrapper* tokens))completion;

/**
 Saves the tokens carried by the specified wrapper for the given opaque token storage key.
 
 @param tokens the token wrapper whose contents are to be saved, must be non-nil
 @param tokenStorageKey the opaque token storage key to save the tokens for, must be non-nil
 @param completion the handler called with YES or NO depending on whether storing the token succeeded or not, must be non-nil
 */
-(void)saveTokens:(OAuth2TokenWrapper*)tokens forKey:(NSString*)tokenStorageKey completion:(void(^)(BOOL success))completion;

/**
 Removes all the tokens in this storage.

 @param completion the block invoked with YES if removal succeeds or NO if a problem occured
 */
-(void)removelAllTokensWithCompletion:(void(^)(BOOL success))completion;

@end
