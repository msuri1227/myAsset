//
//  SODataV4_SDKLogger.h
//  ODataV4OnlineCore
//
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPClientLogManager.h"
#import "SAPSupportabilityFacade.h"

@class SODataV4_SDKLogger;

/**
 Represents the Logger of ODataV4OnlineCore
 */
@interface SODataV4_SDKLogger : SODataV4_Logger

/*
 * The identifier of the Logger
 */
@property (nonatomic, readonly, nonnull) NSString* name;

/*
 * The Logger itself
 */
@property (nonatomic, strong, nonnull) id<SAPClientLogger> sdkLogger;

/**
 * Custom initializer
 * @param name the identifier to initialize the Logger with
 */
-(nonnull instancetype) initWithName: (nonnull NSString*) name;

/**
 * Returns whether the Debug log level is anebled or not
 */
- (SODataV4_boolean) isDebugEnabled;

/**
 * Returns whether the Error log level is anebled or not
 */
- (SODataV4_boolean) isErrorEnabled;

/**
 * Returns whether the Info log level is anebled or not
 */
- (SODataV4_boolean) isInfoEnabled;

/**
 * Returns whether the Trace log level is anebled or not
 */
- (SODataV4_boolean) isTraceEnabled;

/**
 * Returns whether the Warning log level is anebled or not
 */
- (SODataV4_boolean) isWarnEnabled;

/**
 * Log a debug message with the Logger
 * @param message The description to log
 * @param cause The Exception, if there's any
 * @param dump Indicate whether to log the stack trace in case of Exception or not
 */
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;

/**
 * Log an error message with the Logger
 * @param message The description to log
 * @param cause The Exception, if there's any
 * @param dump Indicate whether to log the stack trace in case of Exception or not
 */
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;

/**
 * Log an info message with the Logger
 * @param message The description to log
 * @param cause The Exception, if there's any
 * @param dump Indicate whether to log the stack trace in case of Exception or not
 */
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;

/**
 * Log a trace message with the Logger
 * @param message The description to log
 * @param cause The Exception, if there's any
 * @param dump Indicate whether to log the stack trace in case of Exception or not
 */
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;

/**
 * Log a warning message with the Logger
 * @param message The description to log
 * @param cause The Exception, if there's any
 * @param dump Indicate whether to log the stack trace in case of Exception or not
 */
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;

@end
