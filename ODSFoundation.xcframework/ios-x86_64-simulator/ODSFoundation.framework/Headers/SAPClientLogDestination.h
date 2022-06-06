//
//  ClientLogDestination.h
//  ClientLog
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, E_CLIENT_LOG_DESTINATION) {
  	CONSOLE =  1 << 1,
    FILESYSTEM = 1 << 2
};

