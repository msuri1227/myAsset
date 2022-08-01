//
//  ClientLogLevel.h
//  ClientLog
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

typedef NS_ENUM(NSUInteger, E_CLIENT_LOG_LEVEL) {
    AllClientLogLevel = 0,
    DebugClientLogLevel,
    InfoClientLogLevel,
    WarningClientLogLevel,
    ErrorClientLogLevel,
    FatalClientLogLevel,
    NoneClientLogLevel
};
