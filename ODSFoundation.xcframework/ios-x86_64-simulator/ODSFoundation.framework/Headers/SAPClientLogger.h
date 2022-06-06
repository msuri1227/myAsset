//
//  SAPClientLogger.h
//  ClientLog
//
//  Copyright (c) 2014 SAP. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "SAPClientLogLevel.h"
#import "SAPClientLogDestination.h"

#pragma mark - Convenience macros for logging

#ifndef SourceLocationInfoString
#define SourceLocationInfoString [NSString stringWithFormat:@"File:%@ Function:%@ Line:%d Thread:%@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
[NSString stringWithUTF8String:__PRETTY_FUNCTION__], \
__LINE__, \
[NSThread currentThread]]
#endif

/**
 *  Logs a message. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param level      log level
 *  @param identifier logger identifier
 *  @param msg        message to log
 */
#ifndef SAPLOG
#define SAPLOG(level, identifier, ...) [[[SAPSupportabilityFacade sharedManager] getClientLogger:identifier] log:level withMessage:[NSString stringWithFormat:@"%@ %@", [NSString stringWithFormat:__VA_ARGS__], SourceLocationInfoString]]
#endif

/**
 *  Logs a message with FatalClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param msg        message to log
 */
#ifndef SAPLOGFATAL
#define SAPLOGFATAL(identifier, ...) SAPLOG(FatalClientLogLevel, identifier, __VA_ARGS__)
#endif

/**
 *  Logs a message with ErrorClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param msg        message to log
 */
#ifndef SAPLOGERROR
#define SAPLOGERROR(identifier, ...) SAPLOG(ErrorClientLogLevel, identifier, __VA_ARGS__)
#endif

/**
 *  Logs a message with WarningClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param msg        message to log
 */
#ifndef SAPLOGWARNING
#define SAPLOGWARNING(identifier, ...) SAPLOG(WarningClientLogLevel, identifier, __VA_ARGS__)
#endif

/**
 *  Logs a message with InfoClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param msg        message to log
 */
#ifndef SAPLOGINFO
#define SAPLOGINFO(identifier, ...) SAPLOG(InfoClientLogLevel, identifier, __VA_ARGS__)
#endif

/**
 *  Logs a message with DebugClientLogLevel priority. Log message will be enhanced with file name, 
 *  function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param msg        message to log
 */
#ifndef SAPLOGDEBUG
#define SAPLOGDEBUG(identifier, ...) SAPLOG(DebugClientLogLevel, identifier, __VA_ARGS__)
#endif

/**
 *  Logs a message. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param level      log level
 *  @param identifier logger identifier
 *  @param transactionID transactionID for E2ETrace
 *  @param correlationID correlationID for E2ETrace, if not specified the one generated by CLientLogManager will be used
 *  @param msg        message to log
 */
#ifndef SAPLOGExtended
#define SAPLOGExtended(level, identifier, transactionID, correlationID, ...) [[[SAPSupportabilityFacade sharedManager] getClientLogger:identifier] log:level withMessage:[NSString stringWithFormat:@"%@ %@", [NSString stringWithFormat:__VA_ARGS__], SourceLocationInfoString] withTransactionId: transactionID withCorrelationId:correlationID]
#endif

/**
 *  Logs a message with ErrorClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param transactionID transactionID for E2ETrace
 *  @param correlationID correlationID for E2ETrace, if not specified the one generated by CLientLogManager will be used
 *  @param msg        message to log
 */
#ifndef SAPLOGERRORExtended
#define SAPLOGERRORExtended(identifier, transactionID, correlationID, ...) SAPLOGExtended(ErrorClientLogLevel, identifier, transactionID, correlationID, __VA_ARGS__)
#endif

/**
 *  Logs a message with WarningClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param transactionID transactionID for E2ETrace
 *  @param correlationID correlationID for E2ETrace, if not specified the one generated by CLientLogManager will be used
 *  @param msg        message to log
 */
#ifndef SAPLOGWARNINGExtended
#define SAPLOGWARNINGExtended(identifier, transactionID, correlationID, ...) SAPLOGExtended(WarningClientLogLevel, identifier, transactionID, correlationID, __VA_ARGS__)
#endif

/**
 *  Logs a message with InfoClientLogLevel priority. Log message will be enhanced with file name, function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param transactionID transactionID for E2ETrace
 *  @param correlationID correlationID for E2ETrace, if not specified the one generated by CLientLogManager will be used
 *  @param msg        message to log
 */
#ifndef SAPLOGINFOExtended
#define SAPLOGINFOExtended(identifier, transactionID, correlationID, ...) SAPLOGExtended(InfoClientLogLevel, identifier, transactionID, correlationID, __VA_ARGS__)
#endif

/**
 *  Logs a message with DebugClientLogLevel priority. Log message will be enhanced with file name, 
 *  function name, line number and thread id.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param identifier logger identifier
 *  @param transactionID transactionID for E2ETrace
 *  @param correlationID correlationID for E2ETrace, if not specified the one generated by CLientLogManager will be used
 *  @param msg        message to log
 */
#ifndef SAPLOGDEBUGExtended
#define SAPLOGDEBUGExtended(identifier, transactionID, correlationID, ...) SAPLOGExtended(DebugClientLogLevel, identifier, transactionID, correlationID, __VA_ARGS__)
#endif

@protocol SAPClientLogger <NSObject>

/**
 *  The base logging method.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param level   the logging level
 *  @param message the message to log
 */
- (void)log:(E_CLIENT_LOG_LEVEL)level withMessage:(NSString *)message;
/**
 *  The base logging method.
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param level   		 the logging level
 *  @param message 		 the message to log
 *  @param transactionId SAP Passport
 *  @param correlationId id generated by client for each request to server
 */
- (void)log:(E_CLIENT_LOG_LEVEL)level withMessage:(NSString *)message withTransactionId:(NSString *)transactionId withCorrelationId:(NSString *)correlationId;

/**
 *  Convenience method to log with FatalClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message the message to log
 */
- (void)logFatal:(NSString *)message;
/**
 *  Convenience method to log with FatalClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 *  @param transactionId SAP Passport
 *  @param correlationId id generated by client for each request to server
 */
- (void)logFatal:(NSString *)message withTransactionId:(NSString *)transactionId withCorrelationId:(NSString *)correlationId;
/**
 *  Convenience method to log with ErrorClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 */
- (void)logError:(NSString *)message;
/**
 *  Convenience method to log with ErrorClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 *  @param transactionId SAP Passport
 *  @param correlationId id generated by client for each request to server
 */
- (void)logError:(NSString *)message withTransactionId:(NSString *)transactionId withCorrelationId:(NSString *)correlationId;
/**
 *  Convenience method to log with WarningClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 */
- (void)logWarning:(NSString *)message;
/**
 *  Convenience method to log with WarningClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 *  @param transactionId SAP Passport
 *  @param correlationId id generated by client for each request to server
 */
- (void)logWarning:(NSString *)message withTransactionId:(NSString *)transactionId withCorrelationId:(NSString *)correlationId;
/**
 *  Convenience method to log with InfoClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 */
- (void)logInfo:(NSString *)message;
/**
 *  Convenience method to log with InfoClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 *  @param transactionId SAP Passport
 *  @param correlationId id generated by client for each request to server
 */
- (void)logInfo:(NSString *)message withTransactionId:(NSString *)transactionId withCorrelationId:(NSString *)correlationId;

/**
 *  Convenience method to log with DebugClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 */
- (void)logDebug:(NSString *)message;
/**
 *  Convenience method to log with DebugClientLogLevel level. \sa ClientLogLevel
 *
 *  @note This API function shall not be used to log sensitive data, such as authentication data (passwords, tokens, crypto keys),
 *  personal data (user’s name, address, gender, age etc.), or business confidential data (request data). Only necessary metadata about the client
 *  program’s execution behavior and not about server behavior and error information shall be written to the log.
 *
 *  @param message 		 the message to log
 *  @param transactionId SAP Passport
 *  @param correlationId id generated by client for each request to server
 */
- (void)logDebug:(NSString *)message withTransactionId:(NSString *)transactionId withCorrelationId:(NSString *)correlationId;
/**
 *  Query the logger wether the supplied destination mask is set.
 *
 *  @param destination destination mask \sa E_CLIENT_LOG_DESTINATION
 *
 *  @return YES if the destination mask is valid for logging in this logger
 */
- (BOOL)isDestinationSet:(E_CLIENT_LOG_DESTINATION)destination;
/**
 *  Retrieves the current log level assigned to the logger. Newly created logger instances set to log level ERROR by default
 *  - unless a global destination was set via SAPCLientLogManager setLogDestination(E_CLIENT_LOG_DESTINATION).
 *
 *  @return the log level currently active
 */
- (E_CLIENT_LOG_LEVEL)getLogLevel;
@end
