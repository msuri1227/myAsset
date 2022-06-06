//
//  SAPClientLogManager.h
//  ClientLog
//
//  Copyright (c) 2014 SAP. All rights reserved.
//
#import "SAPClientLogLevel.h"
#import "SAPClientLogDestination.h"

@protocol SAPClientLogger;
@protocol SupportabilityUploading;
@class SAPClientLogEntry;

/**
 * Using the ClientLogManager, an application can adjust the current log level, and thus determine whether
 * log message calls made by the application, or client SDK component, are actually logged or just ignored.
 */
@protocol SAPClientLogManager <NSObject>

/**
 * Correlation ID generated for log messages. To be used only if E2ETrace is not active. If E2ETrace is active, E2ETraceRequest can provide the correlationID (getCorrelationIdHTTPHeader).
 */
@property (nonatomic, strong, readonly, getter = getSMPCorrelationID) NSString* SMPcorrelationID;

+ (id<SAPClientLogManager>)sharedManager;

/**
 *  Retrieves a logger associated with the given ID. Internally it must be ensured that successive calls to this API using the same ID will return the same logger instance.
 *
 *  @param identifier the logger identifier
 *
 *  @return SAPClientLogger instance with the specified identifier
 */
- (id<SAPClientLogger>)getLogger:(NSString *)identifier;
/**
 *  Sets the overall log level.
 *
 *  @param level the log level
 */
- (void)setLogLevel:(E_CLIENT_LOG_LEVEL)level;
/**
 *  Sets the log level for the logger instance with the specified identifier.
 *
 *  @param level      the log level
 *  @param identifier the logger identifier
 */
- (void)setLogLevel:(E_CLIENT_LOG_LEVEL)level forIdentifier:(NSString *)identifier;
/**
 *  Tells where all logger messages should be output; applied to all active loggers. Accepted values are defined in the E_CLIENT_LOG_DESTINATION enumeration; multiple targets can be set by logically combining these values using the OR operator. For now the supported value are CONSOLE, FILESYSTEM or both (CONSOLE I FILESYSTEM).
 *
 *  @param mask the log destination mask
 */
- (void)setLogDestination:(E_CLIENT_LOG_DESTINATION)mask;
/**
 *  Tells where all logger messages should be output; applied to the logger specified by the identifier.
 *
 *  @param mask       the log destination mask
 *  @param identifier the logger identifier
 */
- (void)setLogDestination:(E_CLIENT_LOG_DESTINATION)mask forIdentifier:(NSString *)identifier;
/**
 *  Retrieves log entries with the given level produced during the current session till the point the API was called.
 *
 *  @param level the log level
 *
 *  @return array of the specified log data
 */
- (NSArray *)getLogEntries:(E_CLIENT_LOG_LEVEL)level __deprecated_msg("use - (BOOL)getLogEntries:(E_CLIENT_LOG_LEVEL)level outputStream:(NSOutputStream**)stream_outRef error:(NSError**)error_out");
/**
 *  Retrieves log entries with the given level produced during the current session till the point the API was called.
 *
 *  @param level the log level
 *  @param stream_outRef An NSOutputStream reference. Initialized instance writes to disk, uninitialized reference writes to memory. Passing nil causes error.
 *                       Note: if small amount of log expected, passing an uninitialized instance gives performance boost.
 *  @param error_out     Error description.
 *
 *  @return indication of successful operation
 *  @code
 *   // create logfile in temporary directory
 *   NSString *path = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"saplogdata.txt"];
 *   NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
 *   NSError *error = nil;
 *   if([m_LogManager getLogEntries:AllClientLogLevel outputStream:&outStream error:&error]) {
 *       // process the contents of the file
 *   } else {
 *       NSLog(@"Error in getting log data: %@", [error description]);
 *   }
 *   // clean up the file
 *   [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
 *  @endcode
 *  If only a few log entries expected, you can use the memory to dump the log entries as passing an uninitialized NSOutputStream:
 *  @code
 *  NSOutputStream *outStream = nil;
 *  NSError *error = nil;
 *  if([m_LogManager getLogEntries:AllClientLogLevel outputStream:&outStream error:&error]) {
 *      NSData *logData = [outStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
 *      // process the contents
 *  } else {
 *      NSLog(@"Error in getting log data: %@", [error description]);
 *  }
 *  @endcode
 */
- (BOOL)getLogEntries:(E_CLIENT_LOG_LEVEL)level outputStream:(NSOutputStream**)stream_outRef error:(NSError**)error_out;
/**
 *  Retrieves all log entries produced by a specific logger during the current session till the point the API was called.
 *
 *  @param identifier the logger identifier
 *  @param level      the log level
 *
 *  @return array of the specified log data
 */
- (NSArray *)getLogEntriesForLogger:(NSString *)identifier withLevel:(E_CLIENT_LOG_LEVEL)level __deprecated_msg("use - (BOOL)getLogEntriesForLogger:(NSString *)identifier withLevel:(E_CLIENT_LOG_LEVEL)level outputStream:(NSOutputStream**)stream_outRef error:(NSError**)error_out");
/**
 *  Retrieves all log entries produced by a specific logger during the current session till the point the API was called.
 *
 *  @param identifier the logger identifier
 *  @param level the log level
 *  @param stream_outRef An NSOutputStream reference. Initialized instance writes to disk, uninitialized instance writes to memory. Passing nil causes error.
 *                       Note: if small amount of log expected, passing an uninitialized instance gives performance boost.
 *  @param error_out     Error description.
 *
 *  @return indication of successful operation
 *  @code
 *  NSString *MYAPP_LOGGER = @"com.sap.myapp.logger";
 *  NSString *path = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"saplogdata.txt"];
 *  NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
 *  NSError *error = nil;
 *  if([m_LogManager getLogEntriesForLogger:MYAPP_LOGGER withLevel:AllClientLogLevel outputStream:&outStream error:&error]) {
 *      // process the contents of the file
 *  } else {
 *      NSLog(@"Error in getting log data: %@", [error description]);
 *  }
 *  // clean up the file
 *  [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
 *  @endcode
 *  If only a few log entries expected, you can use the memory to dump the log entries as passing an uninitialized NSOutputStream:
 *  @code
 *  NSString *MYAPP_LOGGER = @"com.sap.myapp.logger";
 *  NSOutputStream *outStream = nil;
 *  NSError *error = nil;
 *  if([m_LogManager getLogEntriesForLogger:MYAPP_LOGGER withLevel:AllClientLogLevel outputStream:&outStream error:&error]) {
 *      NSData *logData = [outStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
 *      // process the contents
 *  } else {
 *      NSLog(@"Error in getting log data: %@", [error description]);
 *  }
 *  @endcode
 */
- (BOOL)getLogEntriesForLogger:(NSString *)identifier withLevel:(E_CLIENT_LOG_LEVEL)level outputStream:(NSOutputStream**)stream_outRef error:(NSError**)error_out;
/**
 *  Uploads current logs to the server. The API expects a valid network request instance (the Supportability component should not manage any networking or authentication related tasks).
 *
 *  @param uploader the uploader to use
 *  @param completion completion block to receive notification about the status of upload
 */
- (void)uploadClientLogs:(id<SupportabilityUploading>)uploader completion:(void(^)(NSError* error))completion;
/**
 *  Returns the log data
 *
 *  @return all log data for further processing, such as upload
 */
- (NSData *)getRawLogData __deprecated_msg("use - (BOOL)getRawLogData:(NSOutputStream**)stream_outRef error:(NSError**)error_out");
/**
 *  Returns the log data
 *
 *  @param stream_outRef An NSOutputStream reference. Initialized instance writes to disk, uninitialized reference writes to memory. Passing nil causes error.
 *                       Note: if small amount of log expected, passing an uninitialized instance gives performance boost.
 *  @param error_out     Error description.
 *
 *  @return indication of successful operation
 *  @code
 *  NSError *error = nil;
 *  NSString *path = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"saplogdata.txt"];
 *  NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
 *  if([m_LogManager getRawLogData:&outStream error:&error]) {
 *      // process the contents of the file
 *  } else {
 *      NSLog(@"Error in getting log data: %@", [error description]);
 *  }
 *  // clean up the file
 *  [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
 *  @endcode
 *  If only a few log entries expected, you can use the memory to dump the log entries as passing an uninitialized NSOutputStream:
 *  @code
 *  NSError *error = nil;
 *  NSOutputStream *outStream = nil;
 *  if([m_LogManager getRawLogData:&outStream error:&error]) {
 *      NSData *logData = [outStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
 *      // process the contents of the file
 *  } else {
 *      NSLog(@"Error in getting log data: %@", [error description]);
 *  }
 *  @endcode
 */
- (BOOL)getRawLogData:(NSOutputStream**)stream_outRef error:(NSError**)error_out;
/**
 *  Sets the root context id on all loggers. Calling this setter implies the activation of E2ETrace session, in which all the loggers set to Debug log level. Callint this setter with nil value indicates the end of the active trace session. All the loggers are set back to the log level before the trace.
 *
 *  @param rootContextId value of the root context id, or nil to indicate the end of the trace
 */
- (void)setRootContextId:(NSString *)rootContextId;
/**
 * Wipes all log entries from the persistent store. Returns error when attempting to wipe logs during ongoing upload activity.
 *
 * @param completion	completion block to receive status update of wipe operation
 */
-(void)wipeClientLogs:(void(^)(NSError*))completion;

@end

