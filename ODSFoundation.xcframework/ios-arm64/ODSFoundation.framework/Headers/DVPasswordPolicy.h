//
//  DVPasswordPolicy.h
//  Datavault
//

#import <Foundation/Foundation.h>

extern const NSInteger kDVUnlimitedRetriesAllowed; ///< Use this constant for 'retryLimit' if unlimited failure attempts can be allowed during unlock
extern const NSInteger kDVNoLockTimeout; ///< Use this constant for 'lockTimeout' if application requires user to enter PIN everytime the app is launched

/**
 Default values for password policy attributes

 TODO Make these 'extern NSString* const'
 */
extern const NSInteger kPwdPolicyDefValueDefPwdAllowed; ///< Default password policy allowed: YES
extern const NSInteger kPwdPolicyDefValueMinLength; ///< Minimum length for user password: 8
extern const NSInteger kPwdPolicyDefValueHasDigits; ///< Passwords must contain a minimum of 1 numeric character [0-9]: NO
extern const NSInteger kPwdPolicyDefValueHasUpper; ///< Passwords must contain a minimum of 1 upper case letter [A-Z]: NO
extern const NSInteger kPwdPolicyDefValueHasLower; ///< Passwords must contain a minimum of 1 lower case letter [a-z]: NO

extern const NSInteger kPwdPolicyDefValueHasSpecial; ///< Passwords must contain a minimum of 1 special character: NO
extern const NSInteger kPwdPolicyDefValueExpirationDays; ///< Password policy expiration (in days): ∞
extern const NSInteger kPwdPolicyDefValueMinUniqueChars; ///< Min. number of unique characters that the password shall contain: 0
extern const NSInteger kPwdPolicyDefValueLockTimeout; ///< Default lock timeout is set to disabled.
extern const NSInteger kPwdPolicyDefValueRetryLimit; ///< Default retry limit is unlimited.
extern const NSInteger kPwdPolicyDefValueFingerprintAllowed; ///< Fingerprint Reader allowed: YES

@interface DVPasswordPolicy : NSObject <NSSecureCoding>

@property( nonatomic, readonly ) BOOL isDefaultPolicy; ///< returns whether the instance contains exclusively default values

@property (nonatomic, assign) BOOL defaultPasswordAllowed;
@property (nonatomic, assign) NSInteger minLength;
@property (nonatomic, assign) BOOL hasDigits;
@property (nonatomic, assign) BOOL hasUpper;
@property (nonatomic, assign) BOOL hasLower;
@property (nonatomic, assign) BOOL hasSpecial;
@property (nonatomic, assign) NSInteger expirationDays;
@property (nonatomic, assign) NSInteger minUniqueChars;
@property (nonatomic, assign) NSInteger lockTimeout;
@property (nonatomic, assign) NSInteger retryLimit;
@property (nonatomic, assign) BOOL fingerprintAllowed;

/**
 Validates the specified password. Throws a <code>DataVaultException</code> if validation fails for a reason.
 The error code describes the actual cause.

 @param password the password to validate, can be nil which represents the default passcode
 */
-(void)validatePassword:(NSString*)password;

@end
