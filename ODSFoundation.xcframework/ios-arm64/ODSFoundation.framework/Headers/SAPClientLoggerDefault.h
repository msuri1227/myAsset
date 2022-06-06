//
//  SAPClientLoggerDefault.h
//  ClientLog
//
//  Copyright (c) 2015 SAP. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "SAPClientLogger.h"
#import "sqlite3.h"

#pragma mark - Default implementation

@interface SAPClientLogger : NSObject<SAPClientLogger>

- (id) initWithQueue:(dispatch_queue_t) queue;

/**
 *  The API will allow clients to determine the current log level.  This is useful in circumstances
 *  where a client knows that to generate a log message might be expensive, and if the message is to
 *  be ignored (because the log level is set to a level below that of the log call) then the client
 *  can avoid generating the message in the first place.  This is most useful for debug or trace
 *  level messages, which typically are emitted often and so might impose an unacceptable
 *  performance burden if emitted under all circumstances.
 */
@property (readonly, getter = getLogLevel, nonatomic) E_CLIENT_LOG_LEVEL logLevel;

/**
 *  Identifier of the logger instance.
 */
@property (readonly, getter = getIdentifier, nonatomic) NSString* identifier;

/**
 *  Log destination. \sa SAPClientLogDestination
 */
@property (readonly, nonatomic) E_CLIENT_LOG_DESTINATION destinationMask;

/**
 *  Indicates that there is an active E2ETrace session. In this case, log level is automatically set
 *  to DebugClientLogLevel. Upon the E2ETrace session has finished - and this flag set to NO -
 *  the log level is set back to the level was active befire the trace.
 */
@property (nonatomic, assign) BOOL e2eTraceActive;

@end
