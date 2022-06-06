//
//  SAPSupportabilityFacade.h
//  Supportability
//
//  Copyright (c) 2014 SAP. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol SAPE2ETrace;
@protocol SAPE2ETraceManager;
@protocol SAPClientLogger;
@protocol SAPClientLogManager;

@protocol SAPSupportabilityFacade <NSObject>

+ (id<SAPSupportabilityFacade>)sharedManager;

/**
 Will return an instance of the Clientlogger.
 @param identifier the identifier of the logger instance
 @returns the logger instance according to the identifier
 */
- (id<SAPClientLogger>)getClientLogger:(NSString *)identifier;

/**
 *  Returns the a log manager instance, which exposes logger management APIs. \sa SAPClientLogManager
 *
 *  @return the instance of SAPClientLogManager
 */
- (id<SAPClientLogManager>)getClientLogManager;

/**
 *  Returns a trace manager instance, which exposes E2E trace management APIs.
 *
 *  @return SAPE2ETraceManager
 */
- (id<SAPE2ETraceManager>)getE2ETraceManager;

/**
 *  Returns the E2ETrace instance. Clients should use the APIs exposed by the SAPE2ETrace interface to cover their end-to-end tracing requirements. \sa SAPE2ETrace
 *
 *  @return the SAPE2ETrace instance
 */
- (id<SAPE2ETrace>)getE2ETrace;


@end

#pragma mark - Default implementation

@interface SAPSupportabilityFacade : NSObject <SAPSupportabilityFacade>

@property (nonatomic, strong) id<SAPClientLogManager> clientLogManager;
@property (nonatomic, strong) id<SAPE2ETraceManager> traceManager;

@end

