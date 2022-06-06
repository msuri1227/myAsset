//
//  SAPE2ETraceRequest.h
//  E2ETrace2
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//
#import <Foundation/Foundation.h>

#pragma mark - E2ETrace Status Constants
typedef NS_ENUM(NSUInteger, SAP_E2E_TRACE_STATUS){
    SAP_E2E_Trace_Status_Started = 0,
    SAP_E2E_Trace_Status_Ended = 1
};

/**
 *  Declares SAPE2ETraceRequest public APIs
 *  @remark Default implementation provided with the same name
 */
@protocol SAPE2ETraceRequest <NSObject>

/**
 * Status of the E2E request.
 * Possible values can be found in SAP_E2E_TRACE_STATUS
 */
@property (nonatomic, readonly, assign) SAP_E2E_TRACE_STATUS status;

/**
 *  Creates and starts an E2E trace request
 *
 *  @return valid SAPE2ETraceRequest instance
 */
-(id<SAPE2ETraceRequest>) init;

/**
 *  Closes the request
 *
 *  @param error error description
 *
 *  @return YES is request could be successfully ended
 */
-(BOOL) endRequest:(NSError**)error;

/**
 *  Retrieves the SAP Extended Passport HTTP header
 *
 *  @return SAP Ext Passport
 */
-(NSString*) getPassportHTTPHeader;

/**
 *  Retrieves the @“X-CorrelationID“ header value.
 *
 *  @return Correlation ID HTTP header
 */
-(NSString*) getCorrelationIdHTTPHeader;

/**
 *  Retrieves the TransactionID.
 *
 *  @return TransactionID
 */
-(NSString*) getTransactionID;

/**
 *  Marks request sending start
 *  Should be called before the request is sent out.
 */
-(BOOL) markSending:(NSError**)error;

/**
 *  Marks data sending completion
 *  Should be called as soon as the data is being sent.
 */
-(BOOL) markSent:(NSError**)error;

/**
 *  Marks data receive start
 *  Should be called when the first byte is being received
 */
-(BOOL) markReceiving:(NSError**)error;

/**
 *  Marks request sending start
 *  Should be called when all data from the response have been received
 */
-(BOOL) markReceived:(NSError**)error;

/**
 *  Sets the request headers
 *
 *  @param requestHeaders_in request headers
 */
-(void) setRequestHeaders:(NSString*) requestHeaders_in;

/**
 *  Sets the request headers key value pairs in a dictionary
 *
 *  @param requestHeaders_in request headers
 */
-(void) setRequestHeadersDictionary:(NSDictionary*) requestHeaders_in;

/**
 *  Sets the response headers
 *
 *  @param responseHeaders_in response headers
 */
-(void) setResponseHeaders:(NSString*) responseHeaders_in;

/**
 *  Sets the response headers key value pairs in a dictionary
 *
 *  @param responseHeaders_in request headers
 */
-(void) setResponseHeadersDictionary:(NSDictionary*) responseHeaders_in;

/**
 *  Sets the request line
 *
 *  @param requestLine_in request line
 */
-(void) setRequestLine:(NSString*) requestLine_in;

/**
 *  Sets request duration
 *
 *  @param duration_in duration in millisec
 */
-(void) setDuration:(NSUInteger) duration_in;

/**
 * @param returnCode_in returnCode of the request
 */
-(void) setReturnCode:(NSString*)returnCode_in;

-(void) setByteCountSent:(NSUInteger)byteCount;         ///< The total number of bytes sent

-(void) setByteCountReceived:(NSUInteger)byteCount;     ///< The total number of bytes received

/**
 *  Creates and returns the Transaction Request XML
 *  This will be appended to the Transaction Step XML, which in turn is appended to the Busieness transaction XML
 *  @return Transaction Request XML as string
 */
- (NSString *) getXML;

@end
