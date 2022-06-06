//
//  SAPE2EExtendedPassport.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import "SAPE2ETrace.h"
#import "SAPE2ETraceConstants.h"

@interface SAPE2EExtendedPassport : NSObject

@property (nonatomic, readonly) NSString* passportHttpHeader;      ///< “SAP-PASSPORT“ header value
@property (nonatomic, readonly) NSString* correlationIdHttpHeader; ///< “X-CorrelationID“ header value

/**
 * Initializes a Passport object
 * @remark transportId and terminalId will be set to nil
 */
- (instancetype) initWithRootId:(NSData*)rootId_in andTraceLevel:(SAP_E2E_TRACELEVEL)traceLevel_in;

/**
 * Initializes a Passport object
 */
- (instancetype) initWithRootId:(NSData*)rootId_in
		andTraceLevel:(SAP_E2E_TRACELEVEL)traceLevel_in
	   andTransportId:(NSData*)transportId_in
		andTerminalId:(NSData*)terminalId_in;

@end
