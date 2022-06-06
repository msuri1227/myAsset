//
//  DataVault.h
//  Datavault
//

#import <Foundation/Foundation.h>

#import "DVPasswordPolicy.h"
#import "DataVaultDataTypes.h"
#import "DataVaultException.h"

extern NSString* const kDataVaultErrorDomain;
extern const NSInteger kRandomSaltGeneratorErrorCode;
extern const NSInteger kStreamOpenErrorCode;

/**
 Immutable object representing a particular data entry in the Data Vault.
 */
@interface DVDataName : NSObject

/**
 The name (i.e. the key) of the data entry.
 */
@property (nonatomic, readonly, strong) NSString* name;

/**
 The type of the data.
 */
@property (nonatomic, readonly, assign) DVDataType type;

/**
 No default instantiation.
 */
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 No default initialization.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end

/**
 Central class that can be used to securely store arbitrary key-value pairs persistently. Uses the
 iOS KeyChain under the hood.
 <p>
 A particular Data Vault is uniquely identified by a string that usually follows the reverse-domain syntax. This
 is referred to as the <i>Data Vault ID</i> hereafter. Use the class-level methods of this class to create or
 open new or existing Data Vaults with these IDs.
 </p>
 <p>
 The Data Vault may be protected by a password that must optionally adhere to a password policy. When the password
 is supplied properly the Data Vault can be unlocked which authorizes all its data accessor methods to read/write
 the underlying data store. When the Data Vault is not to be used for an extended period of time, it should be
 closed (i.e. locked).
 </p>
 <p>
 The class-level methods ensure that for a particular Data Vault ID a single instance of this class is
 maintained.
 </p>
 <p>
 The methods of this class are thread-safe.
 </p>
 */
@interface DataVault : NSObject

#pragma mark - Initialization

/**
 No default initialization.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 No default initialization.
 */
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark - Properties

/**
 Indicates whether the Data Vault is open (i.e. unlocked) or closed (i.e. locked).
 */
@property (nonatomic, getter=isLocked, readonly) BOOL locked;

/**
 Indicates if the default password (i.e. nil) is being used. If YES then the Data Vault
 can be opened by simply calling the unlock operations with a nil password.
 <p>
 If the Data Vault is still of an older version (pre-V2) then the unlock operation also
 requires a salt value. Even in case the Data Vault is openable with a nil password the
 proper salt must be provided if it's other than nil. If that is the case this property
 will indicate NO.
 </p>
 */
@property (nonatomic, getter=isDefaultPasswordUsed, readonly) BOOL defaultPasswordUsed;

/**
 Represents a snapshot of the current data contents of the Data Vault. Requires an unlocked Data Vault.
 */
@property (nonatomic, getter=getDataNames, readonly, copy) NSArray<DVDataName*>* dataNames;

/**
 The password policy. In locked state does not contain the days of password expiration and
 lock timeout fields and does not let these fields to be updated.
 <p>
 In locked state, this property might have the value of the default policy in case the
 Data Vault has just been obtained, is of an earlier version that V4 but not opened yet.
 </p>
 <p>
 Writing this property is possible only in unlocked state.
 </p>
 */
@property (nonatomic, getter=getPasswordPolicy, strong) DVPasswordPolicy* passwordPolicy;

/**
 Provides access to the lock timeout policy field separately.
 <p>
 Writing this property is possible only in unlocked state.
 </p>
 */
@property (nonatomic, getter=getLockTimeout, setter=setLockTimeout:) NSInteger lockTimeout DEPRECATED_MSG_ATTRIBUTE("Use 'lockTimeout' member in the 'DVPasswordPolicy' object instead.");

/**
 Provides access to the retry limit policy field separately.
 <p>
 Writing this property is possible only in unlocked state.
 </p>
 */
@property (nonatomic, getter=getRetryLimit, setter=setRetryLimit:) NSInteger retryLimit DEPRECATED_MSG_ATTRIBUTE("Use 'retryLimit' member in the 'DVPasswordPolicy' object instead.");

#pragma mark - Public methods - lifecycle

/**
 Retrieves the array of Data Vault identifiers within the given access group.

 @param accessGroup the access group to narrow down to, can be nil
 @return the array of Data Vault identifiers, always non-nil
 */
+(NSArray<NSString*>*)dataVaultIdsForAccessGroup:(NSString*)accessGroup;

/**
 Sets the KeyChain access group to use. Modifying this setting affects newly opened or created Data Vaults after this call.

 @param accessGroup the KeyChain access group identifier, must be non-nil
 */
+(void)setAccessGroup:(NSString*)accessGroup;

/**
 Creates a Data Vault with the specified identifier. If a Data Vault already exists with this
 ID then throws a <code>DataVaultException</code> with error code
 <code>kDataVaultExceptionReasonAlreadyExists</code>.
 <p>
 The created vault is returned in unlocked state.
 </p>

 @param dataVaultId the DV identifier, must be non-nil
 @param password the password, can be nil (to use the default)
 @return the created Data Vault, always non-nil
 */
+(DataVault*)createVault:(NSString*)dataVaultId password:(NSString*)password;

/**
 Deprecated. Use <code>createVault:password:</code>.
 */
+(DataVault*)createVault:(NSString*)dataVaultId password:(NSString*)password salt:(NSString*)salt DEPRECATED_MSG_ATTRIBUTE("Use 'createVault:password:' for new development");

/**
 Looks up and returns an existing Data Vault. The returned vault is in locked state, unless an instance for the specified
 Data Vault ID is already at hand. In that case the lock state of the returned object is unknown. Throws a
 <code>DataVaultException</code> with error code <code>kDataVaultExceptionReasonDoesNotExist</code>
 if the specified vault does not exist.

 @param dataVaultId the DV identifier, must be non-nil
 @return the found Data Vault, always non-nil
 */
+(DataVault*)getVault:(NSString*)dataVaultId;

/**
 Returns whether the specified Data Vault exists.

 @param dataVaultId the DV identifier, must be non-nil
 @return YES if it exists, NO if not
 */
+(BOOL)vaultExists:(NSString*)dataVaultId;

/**
 Returns the version number of a specific Data Vault.
 
 @param dataVaultId the DV identifier, must be non-nil
 @return the VersionNumber as NSInteger
 */
+(NSInteger)getVaultVersion:(NSString*)dataVaultId;

/**
 Deprecated. Use <code>vaultExists:</code>
 */
+(BOOL)vaultExists2:(NSString*)dataVaultId DEPRECATED_MSG_ATTRIBUTE("Use 'vaultExists:' for new development");

/**
 Deletes the specified Data Vault. Throws a <code>DataVaultException</code> with error code
 <code>kDataVaultExceptionReasonDoesNotExist</code> if there's no such vault.

 @param dataVaultId the DV identifier, must be non-nil
 */
+(void)deleteVault:(NSString*)dataVaultId;

#pragma mark - Public methods - access control

/**
 Attempts to unlock this Data Vault given the specified password. Does nothing if the vault is
 already open.
 <p>
 Throws a <code>DataVaultException</code> with error code
 <code>kDataVaultExceptionReasonInvalidPassword</code> if the password is incorrect,
 <code>kDataVaultExceptionErrorCodeDoesNotExist</code> if the maximum number of retries has
 been reached and the Data Vault destroyed itself or
 <code>kDataVaultExceptionErrorCodePasswordExpired</code> if the password has expired and
 needs to be changed with <code>changePassword:</code>.

 @param password the password, can be nil (to open with the default password)
 </p>
 */
-(void)unlock:(NSString*)password;

/**
 Deprecated. Use <code>unlock:</code>. Should only be used when the Data Vault is of an earlier
 version and for the unlock procedure an externally supplied salt is necessary. Note that after that
 call this object will migrate the underlying storage to the new version and from that point onward the
 salt will no longer be needed.
 */
-(void)unlock:(NSString*)password salt:(NSString*)salt DEPRECATED_MSG_ATTRIBUTE("Use 'unlock:' for new development.");

/**
 Locks the Data Vault. This method is idempotent.
 */
-(void)lock;

#pragma mark - Public methods - password management

/**
 Changes the password. Validates it against the policy which if fails a <code>DataVaultException</code> is
 thrown with one of the <code>kDataVaultExceptionReasonPassword*</code> error codes.
 <p>
 This method is usable only in unlocked state.
 </p>

 @param newPassword the password, can be nil (to use the default password)
 */
-(void)changePassword:(NSString*)newPassword;

/**
 Deprecated. Use <code>changePassword:</code>.
 */
-(void)changePassword:(NSString*)newPassword salt:(NSString*)newSalt DEPRECATED_MSG_ATTRIBUTE("Use 'changePassword:' for new development.");

/**
 Does the same as <code>changePassword:</code> but performs an unlock beforehand.

 @param currentPassword the current password, can be nil (to use the default password)
 @param newPassword the new password, can be nil (to use the default password)
 */
-(void)changePassword:(NSString*)currentPassword newPassword:(NSString*)newPassword;

/**
 Deprecated. Use <code>changePassword:newPassword:</code>.
 */
-(void)changePassword:(NSString*)currentPassword currentSalt:(NSString*)currentSalt newPassword:(NSString*)newPassword newSalt:(NSString*)newSalt DEPRECATED_MSG_ATTRIBUTE("Use 'changePassword:newPassword:' for new development.");

#pragma mark - Public methods - data accessors

/**
 Returns the value for the given name (key) or nil if no such data is stored. Throws a
 <code>DataVaultException</code> with the appropriate error code if this runs into some
 problems.
 <p>
 The Data Vault must be in unlocked state.
 </p>

 @param name the name to look up, must be non-nil
 @return the found value or nil
 */
-(NSData*)getValue:(NSString*)name;

/**
 Saves the specified value for the given name. If nil is specified then the given key-value
 association is deleted.

 @param name the name to save the data for, must be non-nil
 @param value the data to save, can be nil
 */
-(void)setValue:(NSString*)name value:(NSData*)value;

/**
 Returns the value for the given name (key) or nil if no such data is stored. Throws a
 <code>DataVaultException</code> with the appropriate error code if this runs into some
 problems.
 <p>
 The Data Vault must be in unlocked state.
 </p>

 @param name the name to look up, must be non-nil
 @return the found value or nil
 */
-(NSString*)getString:(NSString*)name;

/**
 Saves the specified value for the given name. If nil is specified then the given key-value
 association is deleted.

 @param name the name to save the data for, must be non-nil
 @param value the data to save, can be nil
 */
-(void)setString:(NSString*)name value:(NSString*)value;

/**
 Deletes the specified value associated with the given name if there's any stored
 in the Data Vault, regardless of which setter it was saved with. Throws a
 <code>DataVaultException</code> with the appropriate error code if this runs into some
 problems.
 <p>
 The Data Vault must be in unlocked state.
 </p>

 @param name the name to delete the association with, must be non-nil
 */
-(void)deleteValue:(NSString*)name;

#pragma mark - Public methods - policy management

/**
 Resets the lock timeout effectively extending the timeout period from now. Can be used
 only in unlocked state.
 */
-(void)resetLockTimeout;

#pragma mark - Encrypt / decrypt APIs for custom data

/**
 Encrypts data using an AES 256 encryption key. For large data use the stream-based method.
 <p>
 The encryption key used is specific to this Data Vault and is valid 'till the vault gets
 deleted. If later on another Data Vault is recreated with the same identifier, the corresponding
 encryption key used by this method will be different!
 </p>

 @param data data to encrypt, must be non-nil
 @param error the error output variable, can be nil
 @return the encrypted data or nil if an error occured
 */
-(NSData*)encrypt:(NSData*)data error:(NSError**)error;

/**
 Decrypts data previously encoded using <code>encrypt:error:</code>. For large data use the
 stream-based method.
 <p>
 The encryption key used is specific to this Data Vault and is valid 'till the vault gets
 deleted. If later on another Data Vault is recreated with the same identifier, the corresponding
 encryption key used by this method will be different!
 </p>

 @param data the data to decrypt, must be non-nil
 @param error the error output variable, can be nil
 @return the decrypted data or nil if an error occured
 */
-(NSData*)decrypt:(NSData*)data error:(NSError**)error;

/**
 Encrypts streamed data. Use for large data sets. It is recommended that the stream parameters
 be mapped to files to avoid low memory conditions.

 Usage example:
 @code
 // Open and unlock the Data Vault.
 DataVault* dataVault = [DataVault getVault:...];
 [dataVault unlock:nil];

 // Prepare file mapped input stream pointing to data to be encrypted.
 NSString* inputPath = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"plainTextData.txt"];
 NSInputStream* inputStream = [NSInputStream inputStreamWithFileAtPath:inputPath];
 [inputStream open];

 // Prepare file mapped output stream for encrypted data.
 NSString* outputPath = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"encryptedData.txt"];
 NSOutputStream* outputStream = [NSOutputStream outputStreamToFileAtPath:outputPath append:NO];
 [outputStream open];

 // Encrypt the data.
 [dataVault encrypt:inputStream toStream:outputStream completion:^(NSError* error) {
     if (error) {
        NSString* errMessage = [NSString stringWithFormat:@"Error occured while encrypting: %@", error.debugDescription);
     } else {
        // Data has been succesfully encrypted to file "encryptedData.txt".
        ...
     }

     [inputStream close];
     [outputStream close];
 }];
 @endcode
 <p>
 The encryption key used is specific to this Data Vault and is valid 'till the vault gets
 deleted. If later on another Data Vault is recreated with the same identifier, the corresponding
 encryption key used by this method will be different!
 </p>

 @param unencryptedStream the stream pointing to data to be encrypted, must be non-nil
 @param encryptedStream data gets written to this stream, must be non-nil
 @param completionBlock the block to invoke when the operation completes, must be non-nil
 */
-(void) encrypt:(NSInputStream*)unencryptedStream
        toStream:(NSOutputStream*)encryptedStream
        completion:(void (^)(NSError* error))completionBlock;

/**
 Decrypts streamed data. Use for large data sets. It is recommended that both stream parameters be
 mapped to files to avoid low memory conditions.

 Usage example:
 @code
 // Open and unlock the Data Vault.
 DataVault* dataVault = [DataVault getVault:...];
 [dataVault unlock:nil];

 // Prepare file mapped input stream pointing to encrypted data.
 NSString* inputPath = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"encryptedData.txt"];
 NSInputStream* inputStream = [NSInputStream inputStreamWithFileAtPath:inputPath];
 [inputStream open];

 // Prepare file mapped output stream for unencrypted data.
 NSString* outputPath = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"plainTextData.txt"];
 NSOutputStream* outputStream = [NSOutputStream outputStreamToFileAtPath:outputPath append:NO];
 [outputStream open];

 // Decrypt the data.
 [dataVault decrypt:inputStream toStream:outputStream completion:^(NSError* error) {
     if (error) {
         NSString* errMessage = [NSString stringWithFormat:@"Error occured while decrypting: %@", [error debugDescription]);
     } else {
        // Data has been succesfully unencrypted to file "plainTextData.txt".
        ...
     }

     [inputStream close];
     [outputStream close];
 }];
 @endcode
 <p>
 The encryption key used is specific to this Data Vault and is valid 'till the vault gets
 deleted. If later on another Data Vault is recreated with the same identifier, the corresponding
 encryption key used by this method will be different!
 </p>

 @param encryptedStream stream pointing to data to be encrypted, must be non-nil
 @param unencryptedStream decrypted data gets written to this stream, must be non-nil
 @param completionBlock the block to invoke when the operation completes, must be non-nil
 */
-(void) decrypt:(NSInputStream*)encryptedStream
        toStream:(NSOutputStream*)unencryptedStream
        completion:(void (^)(NSError* error))completionBlock;

@end
