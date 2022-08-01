//
//  Federation.h
//  Federation
//
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class represents a shared storage among application intended for storing <code>SecIdentityRef</code> objects (i.e, typically
 certificates). A particular identity may be stored for a given string key.
 <p>
 Under the hood, the Keychain Services API is used to create a so-called <i>shared keychain</i> which may be shared among multiple apps.
 Make sure to read the relevant Apple documentation as to what is required to set this up properly. In short: all participating applications
 must be signed with the same developer certificate and should add the <code>federationEntitlements</code> entitlement to the application
 bundle.
 </p>
 <p>
 This class works only on a real device. To obtain an instance of this type use either the <code>createWithPasscode:error:</code> or the
 <code>openWithPasscode:error:</code> methods. Trying to acquire more than one object of this type is not recommended and the behaviour
 is undefined.
 </p>
 <p>
 This class is not thread-safe.
 </p>
 */
@interface Federation : NSObject

/**
 Default instantiation is not possible.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 Default instantiation is not possible.
 */
-(instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Returns whether the federated storage exists. Use this method to decide whether to create a new or open an existing store.

 @return returns YES if the storage exists, NO otherwise
 */
+(BOOL)exists;

/**
 Tries to open an existing store and creates a Federation instance upon success. An error is returned if the store does not exist.

 @param passcode the passcode which was used to create the store, can be nil
 @param error the parameter using which errors are returned, can be nil
 @return the freshly opened store or nil if an error occured
 */
+(Federation*)openWithPasscode:(NSString*)passcode error:(NSError**)error;

/**
 Tries to create a new store and creates a Federation instance upon success. An error is returned if the store already exists.

 @param passcode the passcode to protect the store with, can be nil
 @param error the parameter using which errors are returned, can be nil
 @return the freshly created store or nil if an error occured
 */
+(Federation*)createWithPasscode:(NSString*)passcode error:(NSError**)error;

/**
 Removes the federation store. Any existing Federation objects should be released. Does nothing if the store does not exist.
 
 @param error the parameter using which errors are returned, can be nil
 @return YES if removal is successful, NO if an error occured
 */
+(BOOL)removeWithResultingError:(NSError**)error;

/**
 Stores the identity in the store for the given key.

 @param identity the identity to store, must be non-nil
 @param key the key to associate the identity with, must be non-nil
 @param error the parameter using which errors are returned, can be nil
 @return YES if storing the identity was successful, NO if an error occured
 */
-(BOOL)setIdentity:(SecIdentityRef)identity forKey:(NSString*)key error:(NSError**)error;

/**
 Retrieves a stored identity for the given key.

 @param key the key to retrieve the identity for, must be non-nil
 @param error the parameter using which errors are returned, can be nil
 @return the idenity or nil if it was not found or an error occured
 */
-(SecIdentityRef)identityForKey:(NSString*)key error:(NSError**)error;

/**
 Removes a stored identity for the key. Does nothing if the key is not associated with an identity.

 @param key the key to retrieve the identity for, must be non-nil
 @param error the parameter using which errors are returned, can be nil
 @return YES if removal of the identity was successful or it does not exist, NO if an error occured
 */
-(BOOL)removeIdentityForKey:(NSString*)key error:(NSError**)error;

@end
