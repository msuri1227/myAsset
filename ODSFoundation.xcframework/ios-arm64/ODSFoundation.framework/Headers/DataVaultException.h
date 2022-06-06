//
//  DataVaultException.h
//  Datavault
//

#import <Foundation/Foundation.h>

extern NSString* const DataVaultExceptionName; ///< Name of the exception thrown for DataVault errors

/**
 Error codes for general kinds of DataVaultExceptions thrown.
 */
extern const NSUInteger kDataVaultExceptionErrorCodeUnknown;              ///< Unknown error occured, no further info is available.
extern const NSUInteger kDataVaultExceptionErrorCodeAlreadyExists;        ///< Data Vault with the specified identifier already exists.
extern const NSUInteger kDataVaultExceptionErrorCodeConversionError;      ///< Error performing data conversion.
extern const NSUInteger kDataVaultExceptionErrorCodeDoesNotExist;         ///< Data Vault with the specified identifier does not exist.
extern const NSUInteger kDataVaultExceptionErrorCodeInvalidArg;           ///< Invalid argument specified. Check the reason message.
extern const NSUInteger kDataVaultExceptionErrorCodeInvalidPassword;      ///< Invalid password specified.
extern const NSUInteger kDataVaultExceptionErrorCodeIOReadError;          ///< Error reading data from the storage. Observe the cause and the reason for the details.
extern const NSUInteger kDataVaultExceptionErrorCodeIOWriteError;         ///< Error writing data to the storage. Observe the cause and the reason for the details.
extern const NSUInteger kDataVaultExceptionErrorCodeLocked;               ///< The Data Vault is locked.
extern const NSUInteger kDataVaultExceptionErrorCodeNameTooLong;          ///< The specified name is too long.
extern const NSUInteger kDataVaultExceptionErrorCodeValueTooLarge;        ///< The specified value is too large.
extern const NSUInteger kDataVaultExceptionErrorCodeDataTypeErrror;       ///< Data type error occured.
extern const NSUInteger kDataVaultExceptionErrorCodeOutOfMemory;          ///< Ran out of memory in the middle of the operation.

/**
 Error codes for password policy violation specific DataVaultExceptions.
 */
extern const NSUInteger kDataVaultExceptionErrorCodePasswordRequired;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordUnderMinLength;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordRequiresDigit;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordRequiresUpper;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordRequiresLower;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordRequiresSpecial;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordUnderMinUnique;
extern const NSUInteger kDataVaultExceptionErrorCodePasswordExpired;

/**
 Reason messages for general kinds of errors.
 */
extern NSString* const kDataVaultExceptionReasonAlreadyExists;
extern NSString* const kDataVaultExceptionReasonDoesNotExist;
extern NSString* const kDataVaultExceptionReasonInvalidArg;
extern NSString* const kDataVaultExceptionReasonInvalidPassword;
extern NSString* const kDataVaultExceptionReasonLocked;
extern NSString* const kDataVaultExceptionReasonDataTypeError;
extern NSString* const kDataVaultExceptionReasonOutOfMemory;
extern NSString* const kDataVaultExceptionReasonNameTooLong;

/**
 Reason messages for password policy violations.
 */
extern NSString* const kDataVaultExceptionReasonPasswordRequired;
extern NSString* const kDataVaultExceptionReasonPasswordUnderMinLength;
extern NSString* const kDataVaultExceptionReasonPasswordRequiresDigit;
extern NSString* const kDataVaultExceptionReasonPasswordRequiresUpper;
extern NSString* const kDataVaultExceptionReasonPasswordRequiresLower;
extern NSString* const kDataVaultExceptionReasonPasswordRequiresSpecial;
extern NSString* const kDataVaultExceptionReasonPasswordUnderMinUniqueChars;
extern NSString* const kDataVaultExceptionReasonIORead;
extern NSString* const kDataVaultExceptionReasonIOWrite;
extern NSString* const kDataVaultExceptionReasonPasswordExpired;

/**
 Constants for causing errors.
 */
extern const NSUInteger kDataVaultExceptionCauseUnknown;   ///< The cause is not known. No further information is available.
extern const NSUInteger kDataVaultExceptionCauseKeyChain;  ///< The user info dictionary contains the 'kDataVaultExceptionCauseInfo_KeyChainStatus' key holding the 'OSStatus' code of the failed KeyChain call.
extern const NSUInteger kDataVaultExceptionCauseCryptor;   ///< The user info dictionary contains the 'kDataVaultExceptionCauseInfo_CryptorStatus' key holding the 'CCCryptorStatus' code of the failed KeyChain call.

extern NSString* const kDataVaultExceptionCauseInfo_KeyChainStatus;     ///< Key to access the user info dictionary of a 'DataVaultException' with to get the KeyChain status code.
extern NSString* const kDataVaultExceptionCauseInfo_CryptorStatus;      ///< Key to access the user info dictionary of a 'DataVaultException' with to get the CCCryptor status code.

/**
 Data Vault exception class utilized by this library. Calls to this API result in exceptions being thrown in case serious errors are detected.
 <p>
 The error condition is described by the <code>errorCode</code> and the associated reason message. Certain error codes also provide further insight into
 the actual error via the <code>cause</code> property and the user info dictionary. Consult the documentation of the supported error codes, reason messages
 and causes for the details. All the related constants start with the <code>kDataVaultException*</code> prefix.
 </p>
 */
@interface DataVaultException : NSException

/**
 No default initialization.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 No default initialization.
 */
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Error code. One of the <code>kDataVaultExceptionErrorCode*</code> constants.
 */
@property (nonatomic, readonly) NSUInteger errorCode;

/**
 The condition that caused the error to occur. One of the <code>kDataVaultExceptionCause*</code> constants. Depending on what the causing error condition
 was the user info dictionary may contain further info about the error. Check the documentation of the constants.
 <p>
 If the cause is unknown for any reason then this value defaults to the <code>kDataVaultExceptionCauseUnknown</code> constant.
 </p>
 */
@property (nonatomic, readonly) NSUInteger cause;

@end
