//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_HTTP_2_H
#define SODATAV4_HTTP_2_H


@class SODataV4_HttpCookies;
@class SODataV4_HttpHandler;
@class SODataV4_HttpHandlerType; /* internal */
@class SODataV4_HttpHeaders;
@class SODataV4_HttpRequest;
@class SODataV4_HttpSendThread; /* internal */
@class SODataV4_HttpTraceContent; /* internal */
@class SODataV4_HttpUploadStream; /* internal */
@class SODataV4_HttpVersion; /* internal */
@class SODataV4_MimePart; /* internal */
@class SODataV4_MimeType; /* internal */
@class SODataV4_ConcurrentHttpCookies; /* internal */
@class SODataV4_ConcurrentHttpHeaders; /* internal */
@class SODataV4_MimePartList; /* internal */
@class SODataV4_HttpInputCounter; /* internal */
@class SODataV4_HttpReadBytes; /* internal */
@class SODataV4_HttpInputTracing; /* internal */
@class SODataV4_Any_as_core_ByteBuffer_in_http; /* internal */
@class SODataV4_Any_as_http_MimePart_in_http; /* internal */
@class SODataV4_Default_empty_HttpHeaders_in_http; /* internal */

#ifndef imported_SODataV4__HttpCookies_public
#define imported_SODataV4__HttpCookies_public
/// @brief Encapsulates a map of HTTP cookies.
///
///
@interface SODataV4_HttpCookies : SODataV4_ObjectBase
{
    @private SODataV4_StringMap* _Nonnull values;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpCookies*) new;
/// @internal
///
- (void) _init;
/// @brief Clear all the cookies.
///
///
- (void) clear;
/// @return a thread-safe cookies object that delegates to this cookies object.
/// A regular HttpCookies object is not thread-safe for concurrent read/write access. This function will return a thread-safe wrapper.
- (nonnull SODataV4_HttpCookies*) concurrent;
/// @return A copy of these cookies.
///
- (nonnull SODataV4_HttpCookies*) copy;
/// @brief Delete the value of a cookie, if present.
///
///
/// @return `true` if a cookie was deleted.
/// @param name Cookie name.
- (SODataV4_boolean) delete_ :(nonnull NSString*)name;
/// @brief An immutable empty map of HTTP cookies.
///
///
+ (nonnull SODataV4_HttpCookies*) empty;
/// @return The cookie entries (name/value pairs).
///
- (nonnull SODataV4_StringMap_EntryList*) entries;
/// @return The value of a cookie, or `nil` if not found.
/// @param name Cookie name.
- (nullable NSString*) get :(nonnull NSString*)name;
/// @return `true` if a specified cookie exists.
/// @param name Cookie name.
- (SODataV4_boolean) has :(nonnull NSString*)name;
/// @return The cookie names.
///
- (nonnull SODataV4_StringList*) keys;
/// @brief Set the value of a cookie.
///
///
/// @param name Cookie name.
/// @param value Cookie value.
- (void) set :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief The number of cookies.
///
///
- (SODataV4_int) size;
/// @return The cookie entries (name/value pairs) sorted by name (case insensitive).
///
- (nonnull SODataV4_StringMap_EntryList*) sortedEntries;
/// @return Cookies as a JSON string.
///
- (nonnull NSString*) toString;
/// @brief An immutable empty map of HTTP cookies.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_HttpCookies* empty;
/// @brief The number of cookies.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif

#ifdef import_SODataV4__HttpCookies_private
#ifndef imported_SODataV4__HttpCookies_private
#define imported_SODataV4__HttpCookies_private
@interface SODataV4_HttpCookies (private)
+ (nonnull SODataV4_HttpCookies*) _new1 :(nonnull SODataV4_StringMap*)p1;
+ (nonnull SODataV4_StringMap_Entry*) _new2 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
@end
#endif
#endif

#ifdef import_SODataV4__HttpCookies_internal
#ifndef imported_SODataV4__HttpCookies_internal
#define imported_SODataV4__HttpCookies_internal
@interface SODataV4_HttpCookies (internal)
- (nonnull SODataV4_JsonObject*) toJsonObject;
@end
#endif
#endif

#ifndef imported_SODataV4__HttpHandler_public
#define imported_SODataV4__HttpHandler_public
/// @internal
///
@interface SODataV4_HttpHandler : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpHandler*) new;
/// @internal
///
- (void) _init;
/// @brief Override the `SODataV4_HttpRequest`.`close` function.
///
///
/// @param request HTTP request whose `close` method will be overridden.
- (void) close :(nonnull SODataV4_HttpRequest*)request;
/// @brief Indicates whether the handler takes care of cookie handling or not.
///
/// Returns `false` by default.
- (SODataV4_boolean) hasCookieHandling;
/// @brief Override the `SODataV4_HttpRequest`.`send` function.
///
///
/// @param request HTTP request whose `send` method will be overridden.
- (void) send :(nonnull SODataV4_HttpRequest*)request;
/// @brief Type of handler (external or internal).
///
///
/// @see `SODataV4_HttpHandlerType`.
- (SODataV4_int) type;
/// @brief Indicates whether the handler takes care of cookie handling or not.
///
/// Returns `false` by default.
@property (nonatomic, readonly) SODataV4_boolean hasCookieHandling;
/// @brief Type of handler (external or internal).
///
///
/// @see `SODataV4_HttpHandlerType`.
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifdef import_SODataV4__HttpHandlerType_internal
#ifndef imported_SODataV4__HttpHandlerType_internal
#define imported_SODataV4__HttpHandlerType_public
/* internal */
/// @brief HTTP handler types.
///
///
/// @see `SODataV4_HttpHandler`.`type`.
@interface SODataV4_HttpHandlerType : SODataV4_ObjectBase
{
}
#define SODataV4_HttpHandlerType_EXTERNAL_HANDLER 1
#define SODataV4_HttpHandlerType_INTERNAL_HANDLER 2
@end
#endif
#endif

#ifndef imported_SODataV4__HttpHeaders_public
#define imported_SODataV4__HttpHeaders_public
/// @brief Encapsulates a map of HTTP headers, allowing case-insensitive lookup.
///
///
@interface SODataV4_HttpHeaders : SODataV4_ObjectBase
{
    @private SODataV4_StringMap* _Nonnull names;
    @private SODataV4_StringMap* _Nonnull values;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpHeaders*) new;
/// @internal
///
- (void) _init;
/// @brief Clear all the headers.
///
///
- (void) clear;
/// @return a thread-safe headers object that delegates to `self` headers object.
/// An HttpHeaders object is not thread-safe for concurrent read/write access. This function will return a thread-safe wrapper.
- (nonnull SODataV4_HttpHeaders*) concurrent;
/// @return A copy of these headers.
///
- (nonnull SODataV4_HttpHeaders*) copy;
/// @brief Delete the value of a header, if present.
///
///
/// @return `true` if a cookie was deleted.
/// @param name Header name.
- (SODataV4_boolean) delete_ :(nonnull NSString*)name;
/// @brief An immutable empty map of HTTP headers.
///
///
+ (nonnull SODataV4_HttpHeaders*) empty;
/// @brief Construct an empty HttpHeaders if the `headers` parameter is `nil`.
///
///
/// @return The `headers` parameter, if non-`nil`. Otherwise an empty HttpHeaders.
/// @param headers HttpHeaders to be checked.
+ (nonnull SODataV4_HttpHeaders*) emptyIfNull :(nullable SODataV4_HttpHeaders*)headers;
/// @return The header entries (name/value pairs).
///
- (nonnull SODataV4_StringMap_EntryList*) entries;
/// @return The value of a header, or `nil` if not found.
/// @param name Header name.
- (nullable NSString*) get :(nonnull NSString*)name;
/// @return `true` if a specified header exists.
/// @param name Header name.
- (SODataV4_boolean) has :(nonnull NSString*)name;
/// @return The header names.
///
- (nonnull SODataV4_StringList*) keys;
/// @internal
///
- (void) parse :(nonnull NSString*)text :(nullable SODataV4_HttpRequest*)request;
/// @brief Set the value of a header.
///
///
/// @param name Header name.
/// @param value Header value.
- (void) set :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief The number of headers.
///
///
- (SODataV4_int) size;
/// @return The header entries (name/value pairs) sorted by name (case insensitive).
///
- (nonnull SODataV4_StringMap_EntryList*) sortedEntries;
/// @return Headers as a JSON string.
///
- (nonnull NSString*) toString;
/// @brief An immutable empty map of HTTP headers.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_HttpHeaders* empty;
/// @brief The number of headers.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif

#ifdef import_SODataV4__HttpHeaders_private
#ifndef imported_SODataV4__HttpHeaders_private
#define imported_SODataV4__HttpHeaders_private
@interface SODataV4_HttpHeaders (private)
+ (nonnull SODataV4_HttpHeaders*) _new1 :(nonnull SODataV4_StringMap*)p1 :(nonnull SODataV4_StringMap*)p2;
+ (nonnull SODataV4_StringMap_Entry*) _new2 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
@end
#endif
#endif

#ifdef import_SODataV4__HttpHeaders_internal
#ifndef imported_SODataV4__HttpHeaders_internal
#define imported_SODataV4__HttpHeaders_internal
@interface SODataV4_HttpHeaders (internal)
- (nonnull SODataV4_JsonObject*) toJsonObject;
@end
#endif
#endif

#ifndef imported_SODataV4__HttpRequest_public
#define imported_SODataV4__HttpRequest_public
/// @brief A cross-platform HTTP API modeled after [XMLHttpRequest](http://en.wikipedia.org/wiki/XMLHttpRequest).
///
/// Supports streaming of request and response content.
///
/// 
/// #### Example
/// 
/// ```` oc
/// - (void) classExample
/// {
///     SODataV4_HttpRequest* request = [SODataV4_HttpRequest new];
///     [request open:SODataV4_HttpMethod_GET:@"http://google.com"];
///     [request send];
///     NSString* text = request.responseText;
///     [request close];
///     [Example show:@[@"google.com home page text: ",text]];
/// }
/// ````
@interface SODataV4_HttpRequest : SODataV4_ObjectBase
{
    @private NSData* _Nullable _requestData;
    @private SODataV4_ByteStream* _Nullable _responseBytes;
    @private NSData* _Nullable _responseData;
    @private SODataV4_ByteStream* _Nullable requestBytes_;
    @private SODataV4_CharStream* _Nullable _responseChars;
    @private NSString* _Nullable _responseText;
    @private SODataV4_CharStream* _Nullable requestChars_;
    @private NSString* _Nullable requestText_;
    @private SODataV4_boolean _headersReady;
    @private SODataV4_ReentrantMutex* _Nonnull _headersReadyRM_;
    @private SODataV4_ConditionVariable* _Nonnull _headersReadyCV_;
    @private NSString* _Nullable _sendException;
    @private SODataV4_HttpException* _Nullable sendException_;
    @private SODataV4_boolean isActive_;
    @private SODataV4_Logger* _Nonnull logger_;
    @private NSString* _Nullable _serviceName;
    @private SODataV4_boolean _traceRequest;
    @private SODataV4_boolean _traceHeaders;
    @private SODataV4_boolean _traceContent;
    @private SODataV4_boolean _traceBytes;
    @private SODataV4_boolean _prettyPrint;
    @private SODataV4_MutableLong* _Nonnull _requestDataCounter;
    @private SODataV4_MutableLong* _Nonnull _requestGzipCounter;
    @private SODataV4_MutableLong* _Nonnull _responseDataCounter;
    @private SODataV4_MutableLong* _Nonnull _responseGzipCounter;
    @private SODataV4_boolean _gzipAccepted;
    @private SODataV4_HttpReadBytes* _Nonnull _inputStream_;
    @private SODataV4_HttpHandler* _Nullable handler_;
    @private SODataV4_int version_;
    @private NSString* _Nonnull method_;
    @private NSString* _Nonnull url_;
    @private NSString* _Nullable username_;
    @private NSString* _Nullable password_;
    @private SODataV4_boolean compressResponse_;
    @private SODataV4_boolean streamRequest_;
    @private SODataV4_boolean streamResponse_;
    @private SODataV4_boolean unzipResponse_;
    @private SODataV4_RequestOptions* _Nonnull requestOptions_;
    @private SODataV4_HttpCookies* _Nonnull requestCookies_;
    @private SODataV4_HttpHeaders* _Nonnull requestHeaders_;
    @private SODataV4_HttpCookies* _Nonnull responseCookies_;
    @private SODataV4_HttpHeaders* _Nonnull responseHeaders_;
    @private SODataV4_int status_;
    @private NSString* _Nonnull statusText_;
}
+ (void) initialize;
- (nonnull id) init;
+ (nonnull SODataV4_HttpRequest*) new;
/// @internal
///
- (void) _init;
/// @brief Close this HTTP request, and any response stream that may have been opened by `SODataV4_HttpRequest`.`send`.
///
/// If an application calls `SODataV4_HttpRequest`.`send`, then it must also call this function to avoid resource leaks.
- (void) close;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish the server to compress the response content (using "gzip").
///
/// True by default.
- (SODataV4_boolean) compressResponse;
/// @brief Enable HTTP request tracing. Call this before calling `SODataV4_HttpRequest`.`send`.
///
///
/// @param serviceName Name of the service which this request will be sent to.
/// @param traceRequest Trace the request (URL), and basic request/response flow. Note: this may result in tracing of sensitive data, such as URL query parameters.
/// @param traceHeaders Trace the headers. Note: this may result in tracing of sensitive data, such as authentication information or cookie values.
/// @param traceContent Trace the content. Note: this may result in tracing of sensitive data.
/// @param prettyPrint If `traceContent` is `true` and `SODataV4_HttpRequest`.`streamResponse` is `false`, then content tracing of JSON or XML will be pretty-printed.
- (void) enableTrace :(nullable NSString*)serviceName :(SODataV4_boolean)traceRequest :(SODataV4_boolean)traceHeaders :(SODataV4_boolean)traceContent :(SODataV4_boolean)prettyPrint;
/// @brief Get a request cookie value. For use by servers.
///
///
/// @return Request cookie value, or `nil` if not found.
/// @param name Cookie name.
/// @see `SODataV4_HttpRequest`.`requestCookies`.
- (nullable NSString*) getRequestCookie :(nonnull NSString*)name;
/// @brief Get a request header value. For use by servers.
///
///
/// @return Request header value, or `nil` if not found.
/// @param name Header name.
/// @see `SODataV4_HttpRequest`.`requestHeaders`.
- (nullable NSString*) getRequestHeader :(nonnull NSString*)name;
/// @brief Get a response cookie value. Call this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @return Response cookie value, or `nil` if not found.
/// @param name Cookie name.
/// @see `SODataV4_HttpRequest`.`responseCookies`.
- (nullable NSString*) getResponseCookie :(nonnull NSString*)name;
/// @brief Get a response header value. Call this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @return Response header value, or `nil` if not found.
/// @param name Header name.
/// @see `SODataV4_HttpRequest`.`responseHeaders`.
- (nullable NSString*) getResponseHeader :(nonnull NSString*)name;
/// @brief The optional internal handler for this request.
///
///
/// @see `SODataV4_HttpHandlerType`.
- (nullable SODataV4_HttpHandler*) handler;
/// @brief Does this request have a byte stream response already set?
///
///
- (SODataV4_boolean) hasResponseBytes;
/// @brief Does this request have a text stream response already set?
///
///
- (SODataV4_boolean) hasResponseChars;
/// @brief Does this request have a binary (data) response already set?
///
///
- (SODataV4_boolean) hasResponseData;
/// @brief Does this request have a string (text) response already set?
///
///
- (SODataV4_boolean) hasResponseText;
/// @brief Is a connection active (`SODataV4_HttpRequest`.`send` was called, but `SODataV4_HttpRequest`.`close` has not yet been called)?
///
///
- (SODataV4_boolean) isActive;
/// @brief Specify the HTTP basic credentials. Call this before calling `SODataV4_HttpRequest`.`send` if the server requires HTTP basic authentication.
///
///
/// @param username Username for HTTP basic authentication.
/// @param password Password for HTTP basic authentication.
- (void) login :(nonnull NSString*)username :(nonnull NSString*)password;
/// @brief The HTTP method for this request. Set this using the `SODataV4_HttpRequest`.`open` function.
///
///
/// @see [constants](#constants).
- (nonnull NSString*) method;
/// @brief Specify the HTTP `SODataV4_HttpRequest`.`method` and `SODataV4_HttpRequest`.`url`. Call this before calling `SODataV4_HttpRequest`.`send`.
///
///
/// @param method Value for `SODataV4_HttpRequest`.`method`.
/// @param url Value for `SODataV4_HttpRequest`.`url`.
- (void) open :(nonnull NSString*)method :(nonnull NSString*)url;
/// @brief The password for this request. Set this using the `SODataV4_HttpRequest`.`login` function.
///
///
- (nullable NSString*) password;
/// @brief Is this request enabled for pretty-printed tracing?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
- (SODataV4_boolean) prettyPrint;
/// @brief Request data stream. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (nullable SODataV4_ByteStream*) requestBytes;
/// @brief Request text stream. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (nullable SODataV4_CharStream*) requestChars;
/// @brief HTTP request cookies. Set request cookies before calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull SODataV4_HttpCookies*) requestCookies;
/// @brief Request data for a non-streamed request. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (nullable NSData*) requestData;
/// @brief HTTP request headers. Set request headers before calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull SODataV4_HttpHeaders*) requestHeaders;
/// @brief Caller's request options.
///
///
- (nonnull SODataV4_RequestOptions*) requestOptions;
/// @brief Request text for a non-streamed request. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (nullable NSString*) requestText;
/// @brief Response data stream. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull SODataV4_ByteStream*) responseBytes;
/// @brief Response text stream. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull SODataV4_CharStream*) responseChars;
/// @brief HTTP response cookies. Access response cookies after calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull SODataV4_HttpCookies*) responseCookies;
/// @brief Response data for a non-streamed response. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @see `SODataV4_HttpRequest`.`streamResponse`.
- (nonnull NSData*) responseData;
/// @brief Response data counter. Counts received content data length in bytes.
///
///
- (SODataV4_long) responseDataCount;
/// @brief Response gzip counter. Counts received content gzip length in bytes.
///
///
- (SODataV4_long) responseGzipCount;
/// @brief HTTP response headers. Access response headers after calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull SODataV4_HttpHeaders*) responseHeaders;
/// @brief Response text for a non-streamed response. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @see `SODataV4_HttpRequest`.`streamResponse`.
- (nonnull NSString*) responseText;
/// @brief Send this HTTP request to the server, and wait for a response.
///
/// If `SODataV4_HttpRequest`.`streamResponse` is `true`, then waiting is only until response headers come back, and response content may be streamed as it is accessed.
/// If an application calls this function, then it must also call `SODataV4_HttpRequest`.`close` after accessing all desired response content, to avoid resource leaks.
///
/// @see `SODataV4_HttpException`.
- (void) send;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish the server to compress the response content (using "gzip").
///
/// True by default.
- (void) setCompressResponse :(SODataV4_boolean)value;
/// @brief The optional internal handler for this request.
///
///
/// @see `SODataV4_HttpHandlerType`.
- (void) setHandler :(nullable SODataV4_HttpHandler*)value;
/// @brief Is a connection active (`SODataV4_HttpRequest`.`send` was called, but `SODataV4_HttpRequest`.`close` has not yet been called)?
///
///
- (void) setIsActive :(SODataV4_boolean)value;
/// @brief The HTTP method for this request. Set this using the `SODataV4_HttpRequest`.`open` function.
///
///
/// @see [constants](#constants).
- (void) setMethod :(nonnull NSString*)value;
/// @brief The password for this request. Set this using the `SODataV4_HttpRequest`.`login` function.
///
///
- (void) setPassword :(nullable NSString*)value;
/// @brief Request data stream. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setRequestBytes :(nullable SODataV4_ByteStream*)value;
/// @brief Request text stream. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setRequestChars :(nullable SODataV4_CharStream*)value;
/// @brief Set a request cookie. Call this before calling `SODataV4_HttpRequest`.`send`.
///
///
/// @param name Cookie name.
/// @param value Cookie value.
/// @see `SODataV4_HttpRequest`.`requestCookies`.
- (void) setRequestCookie :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief HTTP request cookies. Set request cookies before calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setRequestCookies :(nonnull SODataV4_HttpCookies*)value;
/// @brief Request data for a non-streamed request. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setRequestData :(nullable NSData*)value;
/// @brief Set a request header. Call this before calling `SODataV4_HttpRequest`.`send`.
///
///
/// @param name Header name.
/// @param value Header value.
/// @see `SODataV4_HttpRequest`.`requestHeaders`.
- (void) setRequestHeader :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief HTTP request headers. Set request headers before calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setRequestHeaders :(nonnull SODataV4_HttpHeaders*)value;
/// @brief Caller's request options.
///
///
- (void) setRequestOptions :(nonnull SODataV4_RequestOptions*)value;
/// @brief Request text for a non-streamed request. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setRequestText :(nullable NSString*)value;
/// @brief Response data stream. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setResponseBytes :(nonnull SODataV4_ByteStream*)value;
/// @brief Response text stream. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setResponseChars :(nonnull SODataV4_CharStream*)value;
/// @brief Set a response cookie. For use by servers.
///
///
/// @param name Cookie name.
/// @param value Cookie value.
/// @see `SODataV4_HttpRequest`.`responseCookies`.
- (void) setResponseCookie :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief HTTP response cookies. Access response cookies after calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setResponseCookies :(nonnull SODataV4_HttpCookies*)value;
/// @brief Response data for a non-streamed response. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @see `SODataV4_HttpRequest`.`streamResponse`.
- (void) setResponseData :(nonnull NSData*)value;
/// @brief Set a response header. For use by servers.
///
///
/// @param name Header name.
/// @param value Header value.
/// @see `SODataV4_HttpRequest`.`responseHeaders`.
- (void) setResponseHeader :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief HTTP response headers. Access response headers after calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setResponseHeaders :(nonnull SODataV4_HttpHeaders*)value;
/// @brief Response text for a non-streamed response. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @see `SODataV4_HttpRequest`.`streamResponse`.
- (void) setResponseText :(nonnull NSString*)value;
/// @brief HTTP response status code. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setStatus :(SODataV4_int)value;
/// @brief HTTP response status text. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (void) setStatusText :(nonnull NSString*)value;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish to stream the request content.
///
/// True by default.
- (void) setStreamRequest :(SODataV4_boolean)value;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish to stream the response content.
///
/// True by default.
- (void) setStreamResponse :(SODataV4_boolean)value;
/// @brief Does response need to be unzipped? Should be set by `SODataV4_HttpHandler` subclasses.
///
///
- (void) setUnzipResponse :(SODataV4_boolean)value;
/// @brief The URL for this request. Set this using the `SODataV4_HttpRequest`.`open` function.
///
///
- (void) setUrl :(nonnull NSString*)value;
/// @brief The username for this request. Set this using the `SODataV4_HttpRequest`.`login` function.
///
///
- (void) setUsername :(nullable NSString*)value;
/// @brief The HTTP version for this request. Defaults to HTTP 1.1.
///
///
/// @see `SODataV4_HttpVersion`.
- (void) setVersion :(SODataV4_int)value;
/// @brief HTTP response status code. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (SODataV4_int) status;
/// @brief HTTP response status text. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
- (nonnull NSString*) statusText;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish to stream the request content.
///
/// True by default.
- (SODataV4_boolean) streamRequest;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish to stream the response content.
///
/// True by default.
- (SODataV4_boolean) streamResponse;
/// @brief Is this request enabled for tracing of request/response content?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
- (SODataV4_boolean) traceContent;
/// @brief Is this request enabled for tracing of request/response headers?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
- (SODataV4_boolean) traceHeaders;
/// @brief Is this request enabled for request/response tracing?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
- (SODataV4_boolean) traceRequest;
/// @brief Does response need to be unzipped? Should be set by `SODataV4_HttpHandler` subclasses.
///
///
- (SODataV4_boolean) unzipResponse;
/// @brief The URL for this request. Set this using the `SODataV4_HttpRequest`.`open` function.
///
///
- (nonnull NSString*) url;
/// @brief The username for this request. Set this using the `SODataV4_HttpRequest`.`login` function.
///
///
- (nullable NSString*) username;
/// @brief The HTTP version for this request. Defaults to HTTP 1.1.
///
///
/// @see `SODataV4_HttpVersion`.
- (SODataV4_int) version;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish the server to compress the response content (using "gzip").
///
/// True by default.
@property (nonatomic, readwrite) SODataV4_boolean compressResponse;
/// @brief The optional internal handler for this request.
///
///
/// @see `SODataV4_HttpHandlerType`.
@property (nonatomic, readwrite, strong, nullable) SODataV4_HttpHandler* handler;
/// @brief Does this request have a byte stream response already set?
///
///
@property (nonatomic, readonly) SODataV4_boolean hasResponseBytes;
/// @brief Does this request have a text stream response already set?
///
///
@property (nonatomic, readonly) SODataV4_boolean hasResponseChars;
/// @brief Does this request have a binary (data) response already set?
///
///
@property (nonatomic, readonly) SODataV4_boolean hasResponseData;
/// @brief Does this request have a string (text) response already set?
///
///
@property (nonatomic, readonly) SODataV4_boolean hasResponseText;
/// @brief Is a connection active (`SODataV4_HttpRequest`.`send` was called, but `SODataV4_HttpRequest`.`close` has not yet been called)?
///
///
@property (nonatomic, readwrite) SODataV4_boolean isActive;
/// @brief The HTTP method for this request. Set this using the `SODataV4_HttpRequest`.`open` function.
///
///
/// @see [constants](#constants).
@property (nonatomic, readwrite, strong, nonnull) NSString* method;
/// @brief The password for this request. Set this using the `SODataV4_HttpRequest`.`login` function.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* password;
/// @brief Is this request enabled for pretty-printed tracing?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
@property (nonatomic, readonly) SODataV4_boolean prettyPrint;
/// @brief Request data stream. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_ByteStream* requestBytes;
/// @brief Request text stream. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_CharStream* requestChars;
/// @brief HTTP request cookies. Set request cookies before calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpCookies* requestCookies;
/// @brief Request data for a non-streamed request. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSData* requestData;
/// @brief HTTP request headers. Set request headers before calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpHeaders* requestHeaders;
/// @brief Caller's request options.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_RequestOptions* requestOptions;
/// @brief Request text for a non-streamed request. Set this before calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* requestText;
/// @brief Response data stream. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ByteStream* responseBytes;
/// @brief Response text stream. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CharStream* responseChars;
/// @brief HTTP response cookies. Access response cookies after calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpCookies* responseCookies;
/// @brief Response data for a non-streamed response. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @see `SODataV4_HttpRequest`.`streamResponse`.
@property (nonatomic, readwrite, strong, nonnull) NSData* responseData;
/// @brief Response data counter. Counts received content data length in bytes.
///
///
@property (nonatomic, readonly) SODataV4_long responseDataCount;
/// @brief Response gzip counter. Counts received content gzip length in bytes.
///
///
@property (nonatomic, readonly) SODataV4_long responseGzipCount;
/// @brief HTTP response headers. Access response headers after calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpHeaders* responseHeaders;
/// @brief Response text for a non-streamed response. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
/// @see `SODataV4_HttpRequest`.`streamResponse`.
@property (nonatomic, readwrite, strong, nonnull) NSString* responseText;
/// @brief HTTP response status code. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite) SODataV4_int status;
/// @brief HTTP response status text. Access this after calling `SODataV4_HttpRequest`.`send`.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* statusText;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish to stream the request content.
///
/// True by default.
@property (nonatomic, readwrite) SODataV4_boolean streamRequest;
/// @brief Set to `false` before calling `SODataV4_HttpRequest`.`send` if the caller does not wish to stream the response content.
///
/// True by default.
@property (nonatomic, readwrite) SODataV4_boolean streamResponse;
/// @brief Is this request enabled for tracing of request/response content?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
@property (nonatomic, readonly) SODataV4_boolean traceContent;
/// @brief Is this request enabled for tracing of request/response headers?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
@property (nonatomic, readonly) SODataV4_boolean traceHeaders;
/// @brief Is this request enabled for request/response tracing?
///
///
/// @see `SODataV4_HttpRequest`.`enableTrace`.
@property (nonatomic, readonly) SODataV4_boolean traceRequest;
/// @brief Does response need to be unzipped? Should be set by `SODataV4_HttpHandler` subclasses.
///
///
@property (nonatomic, readwrite) SODataV4_boolean unzipResponse;
/// @brief The URL for this request. Set this using the `SODataV4_HttpRequest`.`open` function.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* url;
/// @brief The username for this request. Set this using the `SODataV4_HttpRequest`.`login` function.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* username;
/// @brief The HTTP version for this request. Defaults to HTTP 1.1.
///
///
/// @see `SODataV4_HttpVersion`.
@property (nonatomic, readwrite) SODataV4_int version;
@end
#endif

#ifdef import_SODataV4__HttpRequest_private
#ifndef imported_SODataV4__HttpRequest_private
#define imported_SODataV4__HttpRequest_private
@interface SODataV4_HttpRequest (private)
- (nonnull SODataV4_ConditionVariable*) _headersReadyCV;
- (nonnull SODataV4_ReentrantMutex*) _headersReadyRM;
- (nonnull SODataV4_HttpReadBytes*) _inputStream;
- (nonnull NSObject*) httpDelegate;
- (SODataV4_boolean) prettyTrace :(SODataV4_boolean)isResponse;
+ (void) setThreadLocalHttpDelegate :(nullable NSObject*)value;
- (void) set_headersReadyCV :(nonnull SODataV4_ConditionVariable*)value;
- (void) set_headersReadyRM :(nonnull SODataV4_ReentrantMutex*)value;
- (void) set_inputStream :(nonnull SODataV4_HttpReadBytes*)value;
+ (nonnull SODataV4_Logger*) staticLogger;
+ (nullable NSObject*) threadLocalHttpDelegate;
- (SODataV4_boolean) useWorkerThread;
#define SODataV4_HttpRequest_PRETTY_MIXED NO
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ConditionVariable* _headersReadyCV;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ReentrantMutex* _headersReadyRM;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpReadBytes* _inputStream;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Logger* staticLogger;
@property (nonatomic, readwrite, class, strong, nullable) NSObject* threadLocalHttpDelegate;
@end
#endif
#endif

#ifdef import_SODataV4__HttpRequest_internal
#ifndef imported_SODataV4__HttpRequest_internal
#define imported_SODataV4__HttpRequest_internal
@interface SODataV4_HttpRequest (internal)
- (void) addRequestCounts :(SODataV4_long)dataCount :(SODataV4_long)gzipCount;
- (void) addResponseCounts :(SODataV4_long)dataCount :(SODataV4_long)gzipCount;
- (void) endInputStream;
- (SODataV4_boolean) getHeadersReady;
- (SODataV4_boolean) hasGzippedResponse;
- (void) internalSend :(SODataV4_boolean)inWorkerThread;
- (nonnull SODataV4_Logger*) logger;
- (nullable SODataV4_HttpException*) sendException;
- (void) setHeadersReady;
- (void) setLogger :(nonnull SODataV4_Logger*)value;
- (void) setSendException :(nullable SODataV4_HttpException*)value;
- (void) waitForHeaders;
- (void) wrapResponseBytes;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Logger* logger;
@property (atomic, readwrite, strong, nullable) SODataV4_HttpException* sendException;
@end
#endif
#endif

#ifdef import_SODataV4__HttpSendThread_internal
#ifndef imported_SODataV4__HttpSendThread_internal
#define imported_SODataV4__HttpSendThread_public
/* internal */
@interface SODataV4_HttpSendThread : SODataV4_ObjectBase
{
    @private SODataV4_HttpRequest* _Nonnull request_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_HttpSendThread*) getInstance :(nonnull SODataV4_HttpRequest*)request;
- (nonnull SODataV4_HttpRequest*) request;
- (void) run;
- (void) setRequest :(nonnull SODataV4_HttpRequest*)value;
- (void) start;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpRequest* request;
@end
#endif
#endif

#ifdef import_SODataV4__HttpSendThread_private
#ifndef imported_SODataV4__HttpSendThread_private
#define imported_SODataV4__HttpSendThread_private
@interface SODataV4_HttpSendThread (private)
+ (nonnull SODataV4_HttpSendThread*) new;
+ (nonnull SODataV4_HttpSendThread*) _new1 :(nonnull SODataV4_HttpRequest*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__HttpTraceContent_internal
#ifndef imported_SODataV4__HttpTraceContent_internal
#define imported_SODataV4__HttpTraceContent_public
/* internal */
@interface SODataV4_HttpTraceContent : SODataV4_ObjectBase
{
}
+ (void) traceChunk :(nonnull SODataV4_Logger*)logger :(nonnull SODataV4_ByteBuffer*)buffer :(nullable NSData*)chunk;
+ (void) traceData :(nonnull SODataV4_Logger*)logger :(nonnull SODataV4_ByteBuffer*)data;
+ (void) traceLine :(nonnull SODataV4_Logger*)logger :(nonnull SODataV4_CharBuffer*)hex :(nonnull SODataV4_CharBuffer*)asc;
@end
#endif
#endif

#ifdef import_SODataV4__HttpUploadStream_internal
#ifndef imported_SODataV4__HttpUploadStream_internal
#define imported_SODataV4__HttpUploadStream_public
/* internal */
@interface SODataV4_HttpUploadStream : NSInputStream<NSStreamDelegate>
{
    @private
    id<NSStreamDelegate> _Nullable myDelegate;
    NSStreamStatus myStatus;
    NSMutableDictionary* _Nonnull myProperties;
    @private SODataV4_HttpRequest* _Nonnull xsRequest_;
    @private SODataV4_ByteStream* _Nonnull byteStream_;
}
- (nonnull id) init;
+ (nonnull SODataV4_HttpUploadStream*) new :(nonnull SODataV4_HttpRequest*)request :(nonnull SODataV4_ByteStream*)stream;
/// @internal
///
- (void) _init :(nonnull SODataV4_HttpRequest*)request :(nonnull SODataV4_ByteStream*)stream;
@end
#endif
#endif

#ifdef import_SODataV4__HttpUploadStream_private
#ifndef imported_SODataV4__HttpUploadStream_private
#define imported_SODataV4__HttpUploadStream_private
@interface SODataV4_HttpUploadStream (private)
- (nonnull SODataV4_ByteStream*) byteStream;
- (void) setByteStream :(nonnull SODataV4_ByteStream*)value;
- (void) setXsRequest :(nonnull SODataV4_HttpRequest*)value;
- (nonnull SODataV4_HttpRequest*) xsRequest;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ByteStream* byteStream;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpRequest* xsRequest;
@end
#endif
#endif

#ifdef import_SODataV4__HttpVersion_internal
#ifndef imported_SODataV4__HttpVersion_internal
#define imported_SODataV4__HttpVersion_public
/* internal */
/// @brief Constants and functions for HTTP version numbers/strings.
///
///
@interface SODataV4_HttpVersion : SODataV4_ObjectBase
{
}
/// @return The name of an HTTP version (e.g. "HTTP/1.1").
/// @param version HTTP version.
+ (nonnull NSString*) getName :(SODataV4_int)version;
#define SODataV4_HttpVersion_HTTP_1_0 10
#define SODataV4_HttpVersion_HTTP_1_1 11
@end
#endif
#endif

#ifdef import_SODataV4__MimePart_internal
#ifndef imported_SODataV4__MimePart_internal
#define imported_SODataV4__MimePart_public
/* internal */
/// @brief Encapsulates a parsed MIME part.
///
///
@interface SODataV4_MimePart : SODataV4_ObjectBase
{
    @private SODataV4_HttpHeaders* _Nonnull headers_;
    @private NSString* _Nonnull content_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_MimePart*) new;
/// @internal
///
- (void) _init;
/// @brief MIME part content.
///
///
- (nonnull NSString*) content;
/// @brief MIME part headers.
///
///
- (nonnull SODataV4_HttpHeaders*) headers;
/// @return `true` if `headers` indicates a multipart/mixed MIME content type.
/// @param headers MIME part headers.
+ (SODataV4_boolean) isMultipart :(nonnull SODataV4_HttpHeaders*)headers;
/// @return A new MIME part with the specified headers and content.
/// @param headers MIME part headers.
/// @param content MIME part content.
+ (nonnull SODataV4_MimePart*) parse :(nonnull SODataV4_HttpHeaders*)headers :(nonnull NSString*)content;
/// @return A new MIME part list with the specified headers and content.
/// @param headers MIME part headers.
/// @param content MIME part content.
+ (nonnull SODataV4_MimePartList*) parseList :(nonnull SODataV4_HttpHeaders*)headers :(nonnull NSString*)content;
/// @brief MIME part content.
///
///
- (void) setContent :(nonnull NSString*)value;
/// @brief MIME part headers.
///
///
- (void) setHeaders :(nonnull SODataV4_HttpHeaders*)value;
/// @brief MIME part content.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* content;
/// @brief MIME part headers.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpHeaders* headers;
@end
#endif
#endif

#ifdef import_SODataV4__MimePart_private
#ifndef imported_SODataV4__MimePart_private
#define imported_SODataV4__MimePart_private
@interface SODataV4_MimePart (private)
+ (nonnull SODataV4_MimePart*) _new1 :(nonnull SODataV4_HttpHeaders*)p1 :(nonnull NSString*)p2;
@end
#endif
#endif

#ifdef import_SODataV4__MimeType_internal
#ifndef imported_SODataV4__MimeType_internal
#define imported_SODataV4__MimeType_public
/* internal */
/// @brief Constants and functions for representing and parsing MIME content types.
///
///
@interface SODataV4_MimeType : SODataV4_ObjectBase
{
}
/// @brief Parse MIME content type to obtain an optional parameter value.
///
/// For example, parsing type="multipart/mixed;boundary=ABC" with name="boundary" would return "ABC".
/// Parameter names are case-insensitive, values are case-sensitive.
///
/// @return Parameter value, or `nil` if the parameter is not found.
/// @param type MIME content type.
/// @param name Parameter name.
+ (nullable NSString*) getParameter :(nonnull NSString*)type :(nonnull NSString*)name;
#define SODataV4_MimeType_TEXT_HTML @"text/html;charset=utf-8"
#define SODataV4_MimeType_TEXT_PLAIN @"text/plain;charset=utf-8"
@end
#endif
#endif

#ifdef import_SODataV4__ConcurrentHttpCookies_internal
#ifndef imported_SODataV4__ConcurrentHttpCookies_internal
#define imported_SODataV4__ConcurrentHttpCookies_public
/* internal */
/// @brief Wrap an HttpCookies object for thread-safe concurrent access.
///
///
@interface SODataV4_ConcurrentHttpCookies : SODataV4_HttpCookies
{
    @private SODataV4_HttpCookies* _Nonnull cookies_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init :(nonnull SODataV4_HttpCookies*)cookies;
/// @brief Clear all the cookies.
///
///
- (void) clear;
/// @return a thread-safe cookies object that delegates to this cookies object.
/// A regular HttpCookies object is not thread-safe for concurrent read/write access. This function will return a thread-safe wrapper.
- (nonnull SODataV4_HttpCookies*) concurrent;
/// @brief Delete the value of a cookie, if present.
///
///
/// @return `true` if a cookie was deleted.
/// @param name Cookie name.
- (SODataV4_boolean) delete_ :(nonnull NSString*)name;
/// @return The cookie entries (name/value pairs).
///
- (nonnull SODataV4_StringMap_EntryList*) entries;
/// @return The value of a cookie, or `nil` if not found.
/// @param name Cookie name.
- (nullable NSString*) get :(nonnull NSString*)name;
/// @return `true` if a specified cookie exists.
/// @param name Cookie name.
- (SODataV4_boolean) has :(nonnull NSString*)name;
/// @return The cookie names.
///
- (nonnull SODataV4_StringList*) keys;
/// @brief Set the value of a cookie.
///
///
/// @param name Cookie name.
/// @param value Cookie value.
- (void) set :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief The number of cookies.
///
///
- (SODataV4_int) size;
/// @return The cookie entries (name/value pairs) sorted by name (case insensitive).
///
- (nonnull SODataV4_StringMap_EntryList*) sortedEntries;
/// @return Cookies as a JSON string.
///
- (nonnull NSString*) toString;
/// @brief The number of cookies.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif
#endif

#ifdef import_SODataV4__ConcurrentHttpCookies_private
#ifndef imported_SODataV4__ConcurrentHttpCookies_private
#define imported_SODataV4__ConcurrentHttpCookies_private
@interface SODataV4_ConcurrentHttpCookies (private)
- (nonnull SODataV4_HttpCookies*) cookies;
- (void) setCookies :(nonnull SODataV4_HttpCookies*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpCookies* cookies;
@end
#endif
#endif

#ifdef import_SODataV4__ConcurrentHttpCookies_internal
#ifndef imported_SODataV4__ConcurrentHttpCookies_internal
#define imported_SODataV4__ConcurrentHttpCookies_internal
@interface SODataV4_ConcurrentHttpCookies (internal)
+ (nonnull SODataV4_ConcurrentHttpCookies*) new :(nonnull SODataV4_HttpCookies*)cookies;
@end
#endif
#endif

#ifdef import_SODataV4__ConcurrentHttpHeaders_internal
#ifndef imported_SODataV4__ConcurrentHttpHeaders_internal
#define imported_SODataV4__ConcurrentHttpHeaders_public
/* internal */
/// @brief Wrap an HttpHeaders object for thread-safe concurrent access.
///
///
@interface SODataV4_ConcurrentHttpHeaders : SODataV4_HttpHeaders
{
    @private SODataV4_HttpHeaders* _Nonnull headers_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init :(nonnull SODataV4_HttpHeaders*)headers;
/// @brief Clear all the headers.
///
///
- (void) clear;
/// @return a thread-safe headers object that delegates to `self` headers object.
/// An HttpHeaders object is not thread-safe for concurrent read/write access. This function will return a thread-safe wrapper.
- (nonnull SODataV4_HttpHeaders*) concurrent;
/// @brief Delete the value of a header, if present.
///
///
/// @return `true` if a cookie was deleted.
/// @param name Header name.
- (SODataV4_boolean) delete_ :(nonnull NSString*)name;
/// @return The header entries (name/value pairs).
///
- (nonnull SODataV4_StringMap_EntryList*) entries;
/// @return The value of a header, or `nil` if not found.
/// @param name Header name.
- (nullable NSString*) get :(nonnull NSString*)name;
/// @return `true` if a specified header exists.
/// @param name Header name.
- (SODataV4_boolean) has :(nonnull NSString*)name;
/// @return The header names.
///
- (nonnull SODataV4_StringList*) keys;
/// @brief Set the value of a header.
///
///
/// @param name Header name.
/// @param value Header value.
- (void) set :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief The number of headers.
///
///
- (SODataV4_int) size;
/// @return The header entries (name/value pairs) sorted by name (case insensitive).
///
- (nonnull SODataV4_StringMap_EntryList*) sortedEntries;
/// @return Headers as a JSON string.
///
- (nonnull NSString*) toString;
/// @brief The number of headers.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif
#endif

#ifdef import_SODataV4__ConcurrentHttpHeaders_private
#ifndef imported_SODataV4__ConcurrentHttpHeaders_private
#define imported_SODataV4__ConcurrentHttpHeaders_private
@interface SODataV4_ConcurrentHttpHeaders (private)
- (nonnull SODataV4_HttpHeaders*) headers;
- (void) setHeaders :(nonnull SODataV4_HttpHeaders*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_HttpHeaders* headers;
@end
#endif
#endif

#ifdef import_SODataV4__ConcurrentHttpHeaders_internal
#ifndef imported_SODataV4__ConcurrentHttpHeaders_internal
#define imported_SODataV4__ConcurrentHttpHeaders_internal
@interface SODataV4_ConcurrentHttpHeaders (internal)
+ (nonnull SODataV4_ConcurrentHttpHeaders*) new :(nonnull SODataV4_HttpHeaders*)headers;
@end
#endif
#endif

#ifdef import_SODataV4__MimePartList_internal
#ifndef imported_SODataV4__MimePartList_internal
#define imported_SODataV4__MimePartList_public
/* internal */
/// @brief A list of item type `SODataV4_MimePart`.
///
///
@interface SODataV4_MimePartList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_MimePartList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_MimePartList*) new;
/// @brief Construct a new list with `SODataV4_MimePartList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_MimePartList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_MimePart*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_MimePartList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_MimePartList*) addThis :(nonnull SODataV4_MimePart*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_MimePartList*) copy;
/// @brief An immutable empty `SODataV4_MimePartList`.
///
///
+ (nonnull SODataV4_MimePartList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_MimePart*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_MimePartList`.`length` - 1).
- (nonnull SODataV4_MimePart*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_MimePartList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_MimePart`.
- (SODataV4_boolean) includes :(nonnull SODataV4_MimePart*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_MimePart*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_MimePartList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_MimePart`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_MimePart*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_MimePartList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_MimePartList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_MimePartList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_MimePart*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_MimePart*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_MimePart*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_MimePartList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_MimePart`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_MimePart*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_MimePart*)item;
/// @brief Return a new `SODataV4_MimePartList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_MimePart` will be removed.
///
/// @return A new list of item type `SODataV4_MimePart`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_MimePartList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_MimePart*) single;
/// @internal
///
- (nonnull SODataV4_MimePartList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_MimePartList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_MimePartList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_MimePartList* empty;
@end
#endif
#endif

#ifdef import_SODataV4__HttpInputCounter_internal
#ifndef imported_SODataV4__HttpInputCounter_internal
#define imported_SODataV4__HttpInputCounter_public
/* internal */
@interface SODataV4_HttpInputCounter : SODataV4_ByteStream
{
    @private SODataV4_ByteStream* _Nonnull input_;
    @private SODataV4_MutableLong* _Nonnull count_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpInputCounter*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) readByte;
+ (nonnull SODataV4_HttpInputCounter*) wrapAndCount :(nonnull SODataV4_ByteStream*)input :(nonnull SODataV4_MutableLong*)count;
@end
#endif
#endif

#ifdef import_SODataV4__HttpInputCounter_private
#ifndef imported_SODataV4__HttpInputCounter_private
#define imported_SODataV4__HttpInputCounter_private
@interface SODataV4_HttpInputCounter (private)
+ (nonnull SODataV4_HttpInputCounter*) _new1 :(nonnull SODataV4_ByteStream*)p1 :(nonnull SODataV4_MutableLong*)p2;
@end
#endif
#endif

#ifdef import_SODataV4__HttpInputCounter_internal
#ifndef imported_SODataV4__HttpInputCounter_internal
#define imported_SODataV4__HttpInputCounter_internal
@interface SODataV4_HttpInputCounter (internal)
- (nonnull SODataV4_MutableLong*) count;
- (nonnull SODataV4_ByteStream*) input;
- (void) setCount :(nonnull SODataV4_MutableLong*)value;
- (void) setInput :(nonnull SODataV4_ByteStream*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_MutableLong* count;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ByteStream* input;
@end
#endif
#endif

#ifdef import_SODataV4__HttpReadBytes_internal
#ifndef imported_SODataV4__HttpReadBytes_internal
#define imported_SODataV4__HttpReadBytes_public
/* internal */
@interface SODataV4_HttpReadBytes : SODataV4_ByteStream
{
    @private SODataV4_ubyte* fastBuffer;
    @private SODataV4_boolean end;
    @private SODataV4_ByteBuffer* _Nonnull buffer_;
    @private SODataV4_int offset;
    @private SODataV4_int length;
    @private SODataV4_BlockingQueue* _Nonnull queue_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
- (void) addBuffer :(nonnull SODataV4_ByteBuffer*)buffer;
- (void) close;
- (void) endStream;
+ (nonnull SODataV4_HttpReadBytes*) getInstance;
- (SODataV4_int) readByte;
- (void) readMore;
@end
#endif
#endif

#ifdef import_SODataV4__HttpReadBytes_private
#ifndef imported_SODataV4__HttpReadBytes_private
#define imported_SODataV4__HttpReadBytes_private
@interface SODataV4_HttpReadBytes (private)
+ (nonnull SODataV4_HttpReadBytes*) new;
- (nonnull SODataV4_ByteBuffer*) buffer;
- (nonnull SODataV4_BlockingQueue*) queue;
- (void) setBuffer :(nonnull SODataV4_ByteBuffer*)value;
- (void) setQueue :(nonnull SODataV4_BlockingQueue*)value;
+ (nonnull SODataV4_HttpReadBytes*) _new1 :(SODataV4_int)p1 :(SODataV4_int)p2 :(SODataV4_boolean)p3 :(nonnull SODataV4_BlockingQueue*)p4;
#define SODataV4_HttpReadBytes_QUEUE_SIZE 5
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ByteBuffer* buffer;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_BlockingQueue* queue;
@end
#endif
#endif

#ifdef import_SODataV4__HttpInputTracing_internal
#ifndef imported_SODataV4__HttpInputTracing_internal
#define imported_SODataV4__HttpInputTracing_public
/* internal */
@interface SODataV4_HttpInputTracing : SODataV4_HttpInputCounter
{
    @private SODataV4_Logger* _Nonnull logger_;
    @private SODataV4_ByteBuffer* _Nonnull trace_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpInputTracing*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) readByte;
+ (nonnull SODataV4_HttpInputCounter*) wrapAndTrace :(nonnull SODataV4_Logger*)logger :(nonnull SODataV4_ByteStream*)input :(nonnull SODataV4_MutableLong*)count;
@end
#endif
#endif

#ifdef import_SODataV4__HttpInputTracing_private
#ifndef imported_SODataV4__HttpInputTracing_private
#define imported_SODataV4__HttpInputTracing_private
@interface SODataV4_HttpInputTracing (private)
- (nonnull SODataV4_Logger*) logger;
- (void) setLogger :(nonnull SODataV4_Logger*)value;
+ (nonnull SODataV4_HttpInputTracing*) _new1 :(nonnull SODataV4_ByteStream*)p1 :(nonnull SODataV4_Logger*)p2 :(nonnull SODataV4_MutableLong*)p3;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Logger* logger;
@end
#endif
#endif

#ifdef import_SODataV4__HttpInputTracing_internal
#ifndef imported_SODataV4__HttpInputTracing_internal
#define imported_SODataV4__HttpInputTracing_internal
@interface SODataV4_HttpInputTracing (internal)
- (void) setTrace :(nonnull SODataV4_ByteBuffer*)value;
- (nonnull SODataV4_ByteBuffer*) trace;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ByteBuffer* trace;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_core_ByteBuffer_in_http_internal
#ifndef imported_SODataV4__Any_as_core_ByteBuffer_in_http_internal
#define imported_SODataV4__Any_as_core_ByteBuffer_in_http_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_core_ByteBuffer_in_http : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ByteBuffer*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_http_MimePart_in_http_internal
#ifndef imported_SODataV4__Any_as_http_MimePart_in_http_internal
#define imported_SODataV4__Any_as_http_MimePart_in_http_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_http_MimePart_in_http : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_MimePart*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Default_empty_HttpHeaders_in_http_internal
#ifndef imported_SODataV4__Default_empty_HttpHeaders_in_http_internal
#define imported_SODataV4__Default_empty_HttpHeaders_in_http_public
/* internal */
/// @brief Static function to apply default `empty` values of type `SODataV4_HttpHeaders`.
///
///
@interface SODataV4_Default_empty_HttpHeaders_in_http : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `T.empty`.
/// @param value Nullable value.
+ (nonnull SODataV4_HttpHeaders*) ifNull :(nullable SODataV4_HttpHeaders*)value;
@end
#endif
#endif

#endif
