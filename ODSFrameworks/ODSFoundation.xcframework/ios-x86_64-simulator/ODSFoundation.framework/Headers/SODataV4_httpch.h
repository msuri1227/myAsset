//
//  SODataV4_httpch.h
//  ODataV4On
//
//  Copyright (c) 2017 SAP AG. All rights reserved.
//
#import "HttpConversationManager.h"

@class SODataV4_HttpConversationHandler;
@class SODataV4_ByteStreamFromInputStream;

/**
 A handler class to provide a layer between the <code>SODataV4_OnlineODataProvider</code> class and the <code>HttpConversationManager</code> class. If it is used (added as handler to the <code>SODataV4_OnlineODataProvider</code>), then the network requests will be executed by the <code>HttpConversationManager</code> and will not be executed internally by the <code>SODataV4_OnlineODataProvider</code> self.
*/
@interface SODataV4_HttpConversationHandler : SODataV4_HttpHandler

/**
 Initializes an instance of this class without adding <code>HttpConversationManager</code> object. Before using the class instance a <code>HttpConversationManager</code> object must be added to the <code>[HttpConversationManager manager] property</code>.
 
  @return the initialized class instance.
*/
- (nonnull id) init;

/**
 Creates an instance of this class without adding <code>HttpConversationManager</code> object. Before using the class instance a <code>HttpConversationManager</code> object must be added to the <code>[HttpConversationManager manager] property</code>.
 
 @return the created class instance.
 */
+ (nonnull SODataV4_HttpConversationHandler*) new;

/**
 Initializes an instance of this class without adding <code>HttpConversationManager</code> object. Before using this class instance a <code>HttpConversationManager</code> object must be added to the <code>[HttpConversationManager manager] property</code>.
 */
- (void) _init;

/**
 Initializes an instance of this class with a <code>HttpConversationManager</code> instance.
 
 @param manager an HttpConversationManager object which will handle the
     network requests.
 @return the initialized class instance.
 */
- (nonnull id) initWithManager:(nonnull HttpConversationManager*) manager;

/**
 Creates an instance of this class with a <code>HttpConversationManager</code> instance.
 
 @param manager an HttpConversationManager object which will handle the
 network requests.
 @return the created class instance.
 */
+ (nonnull SODataV4_HttpConversationHandler*) new:(nonnull HttpConversationManager*)manager;

/**
 Initializes an instance of this class with a <code>HttpConversationManager</code> instance.
 
 @param manager an HttpConversationManager object which will handle the
 network requests.
 */
- (void) _initWithManager:(nonnull HttpConversationManager*)manager;


- (nonnull HttpConversationManager*) manager;

/**
 Allows you to add the <code>HttpConversationManager</code> object, if it is not already done at class initialization.
 */
@property (nonatomic, nonnull) HttpConversationManager* manager;

/**
 This method is called when the <code>SODataV4_HttpRequest</code> is closing itself. Additional function can be added here.
 
 @param request the <code>SODataV4_HttpRequest</code> instance which is closing itself.
 */
- (void) close:(nonnull SODataV4_HttpRequest*)request;

/**
 Send a http request to the server using the execute methods of the <code>HttpConversationManager</code>. Adds the http response to the request object which was accepted as argument.
 
 @param request the <code>HttpConversationManager</code> instance which includes the request. The response of the http request will be added to this instance, too.
 */
- (void) send:(nonnull SODataV4_HttpRequest*)request;

/**
 Processes the response if it is containing NSData response payload, and calls the processResponse function when it is finished the end.
 @param data the content of the payload in NSData form.
 @param response the response object containing response headers and status info.
 @param error an object containing error information if an error occured.
 @param semaphore the semaphore object used to stopping the caller thread until a response arrives.
 */
- (void) processDataResponse:(nonnull SODataV4_HttpRequest*)request
                        data:(nullable NSData*)data
                    response:(nullable NSURLResponse*)response
                       error:(nullable NSError*)error
                   semaphore:(nonnull dispatch_semaphore_t)semaphore;

/**
 Processes the response if it is containing NSInputStream response payload, and calls the processResponse function when it is finished the end.
 @param stream the content of the payload in NSData form.
 @param response the response object containing response headers and status info.
 @param error an object containing error information if an error occured.
 @param semaphore the semaphore object used to stopping the caller thread until a response arrives.
 */
- (void) processStreamResponse:(nonnull SODataV4_HttpRequest*)request
                        stream:(nullable NSInputStream*)stream
                      response:(nullable NSURLResponse*)response
                         error:(nullable NSError*)error
                     semaphore:(nonnull dispatch_semaphore_t)semaphore;

/**
 Processes the response if it is not containing response payload.
 @param response the response object containing response headers and status info.
 @param error an object containing error information if an error occured.
 @param semaphore the semaphore object used to stopping the caller thread until a response arrives.
 */
- (void)  processResponse:(nonnull SODataV4_HttpRequest*)request
                 response:(nullable NSURLResponse*)response
                    error:(nullable NSError*)error
                semaphore:(nonnull dispatch_semaphore_t)semaphore;

@end

/* internal */
/**
 A converter class which converts an NSInputStream to SODataV4_ByteStream. The class is the descendant of the SODataV4_ByteStream class and simply wraps the NSIputStream instance. It provides methods to read the wrapped  NSInputStream. It also have a reference to the SODataV4_HttpRequest object which were used to download the stream, because it can trace the lenght of the stream.
 */
@interface SODataV4_ByteStreamFromInputStream : SODataV4_ByteStream
{
/**
 The maximum length of bytes to be read.
 */
@private NSUInteger bufferSize;
    
/**
 The <code>SODataV4_HttpRequest</code> object which resulted the stream.
 */
@private SODataV4_HttpRequest* _Nonnull request;
    
/**
 The <code>NSInputStream</code> to be converted.
 */
@private NSInputStream* input;
    
/**
 Count of the already read bytes.
 */
@private int64_t count;
}

/**
 Initializes an instance of this class without adding the <code>NSInputStream</code> and the <code>SODataV4_HttpRequest</code>. These objects must be added to the properties.
 
 @return the initialized class instance.
 */
- (nonnull id) init;

/**
 Creates an instance of this class without adding the <code>NSInputStream</code> and the <code>SODataV4_HttpRequest</code>. These objects must be added to the properties.
 
 @return the created class instance.
 */
+ (nonnull SODataV4_ByteStreamFromInputStream*) new;

/**
 Initializes an instance of this class without adding the <code>NSInputStream</code> and the <code>SODataV4_HttpRequest</code>. These objects must be added to the properties.
 */
- (void) _init;

/**
 Initializes an instance of this class.
 
 @param request the <code>SODataV4_HttpRequest</code> object which resulted the stream.
 @param inputStream the <code>NSInputStream</code> object which will be converted
 @return the initialized class instance.
 */
- (nonnull id) init:(nullable SODataV4_HttpRequest*)request
        inputStream:(nonnull NSInputStream*)inputStream;

/**
 Creates an instance of this class.
 
 @param request the <code>SODataV4_HttpRequest</code> object which resulted the stream.
 @param inputStream the <code>NSInputStream</code> object which will be converted
 @return the created class instance.
 */
+ (nonnull SODataV4_ByteStreamFromInputStream*) new:(nullable SODataV4_HttpRequest*)request
                                        inputStream:(nonnull NSInputStream*)inputStream;

/**
 Initializes an instance of this class.
 
 @param request the <code>SODataV4_HttpRequest</code> object which resulted the stream.
 @param inputStream the <code>NSInputStream</code> object which will be converted
 */
- (void) _init:(nullable SODataV4_HttpRequest*)request
   inputStream:(nonnull NSInputStream*)inputStream;

/**
 This method is called when the stream is closinfg. Additional function can be added here.
 */
- (void) close;

/**
 Reads one byte of data from the stream and returns it as <code>SODataV4_int</code>.
 
 @return the read byte in form of <code>SODataV4_int</code>, or -1 if the stream contains no more bytes.
 */
- (SODataV4_int) readByte;

/**
 Reads bytes of the stream and returns it as <code>NSData</code> object. The number of bytes to read can be maximized in the length argument, and it is also limited by the <code>[SODataV4_ByteStreamFromInputStream bufferSize]</code> property.
 
 @param length the maximum number of bytes to read (It is also limited by the <code>[SODataV4_ByteStreamFromInputStream bufferSize]</code> propery)
 @return the read bytes in form of <code>NSData</code>
 */
- (nullable NSData*) readBinary :(SODataV4_int)length;

/**
 Adds the number of read bytes to the <code>SODataV4_HttpRequest</code> object's response byte counter.
 */
- (void) addCounts;
@end
