//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_HTTP_1_H
#define SODATAV4_HTTP_1_H


@class SODataV4_HttpAddress; /* internal */
@class SODataV4_HttpMethod; /* internal */
@class SODataV4_HttpStatus; /* internal */
@class SODataV4_HttpStatusText; /* internal */
@class SODataV4_HttpException; /* internal */

#ifdef import_SODataV4__HttpAddress_internal
#ifndef imported_SODataV4__HttpAddress_internal
#define imported_SODataV4__HttpAddress_public
/* internal */
/// @brief Encapsulates a parsed HTTP URL.
///
///
/// @see [RFC 3986](http://tools.ietf.org/html/rfc3986#section-3).
@interface SODataV4_HttpAddress : SODataV4_ObjectBase
{
    @private SODataV4_boolean absolute_;
    @private NSString* _Nonnull scheme_;
    @private NSString* _Nullable authority_;
    @private NSString* _Nonnull host_;
    @private SODataV4_int port_;
    @private NSString* _Nullable path_;
    @private NSString* _Nullable query_;
    @private NSString* _Nullable fragment_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpAddress*) new;
/// @internal
///
- (void) _init;
/// @brief True for absolute URL, `false` for relative URL.
///
///
- (SODataV4_boolean) absolute;
/// @brief Authority component, e.g. host ("myhost") or host and port ("myhost:8080").
///
///
- (nullable NSString*) authority;
/// @brief Optional fragment component, e.g. "#myfragment".
///
///
- (nullable NSString*) fragment;
/// @brief Host subcomponent of `SODataV4_HttpAddress`.`authority`, e.g. "myhost".
///
///
- (nonnull NSString*) host;
/// @return `true` if `address` is absolute.
/// @param address Absolute or relative URL.
+ (SODataV4_boolean) isAbsolute :(nonnull NSString*)address;
/// @return `true` if `address` is relative.
/// @param address Absolute or relative URL.
+ (SODataV4_boolean) isRelative :(nonnull NSString*)address;
/// @internal
///
+ (nonnull SODataV4_HttpAddress*) parse :(nonnull NSString*)url;
/// @brief Parse a URL.
///
///
/// @return A new parsed HTTP address.
/// @param url The address URL.
/// @param absolute (optional) `true` if the `url` must be absolute. False if the `url` may be relative.
/// @see [URL](http://en.wikipedia.org/wiki/Uniform_resource_locator).
+ (nonnull SODataV4_HttpAddress*) parse :(nonnull NSString*)url :(SODataV4_boolean)absolute;
/// @brief Optional path component, e.g. "/mypath".
///
///
- (nullable NSString*) path;
/// @return The path and query portions of the address, e.g. "/mypath?myquery".
///
- (nonnull NSString*) pathAndQuery;
/// @brief Port subcomponent of `SODataV4_HttpAddress`.`authority`, e.g. 8080.
///
///
- (SODataV4_int) port;
/// @brief Optional query component, e.g. "?myquery".
///
///
- (nullable NSString*) query;
/// @brief If this address is absolute, then return it. If this address is relative, then apply it to `other` and rerturn the resulting address.
///
///
/// @return This address (if absolute), or this address applied to `other`.
/// @param other Other HTTP address.
- (nonnull SODataV4_HttpAddress*) relativeTo :(nonnull SODataV4_HttpAddress*)other;
/// @brief Scheme component, e.g. "http" or "https".
///
///
- (nonnull NSString*) scheme;
/// @return The scheme and authority portions of the address, e.g. "http://myhost:8080".
///
- (nonnull NSString*) schemeAndAuthority;
/// @brief True for absolute URL, `false` for relative URL.
///
///
- (void) setAbsolute :(SODataV4_boolean)value;
/// @brief Authority component, e.g. host ("myhost") or host and port ("myhost:8080").
///
///
- (void) setAuthority :(nullable NSString*)value;
/// @brief Optional fragment component, e.g. "#myfragment".
///
///
- (void) setFragment :(nullable NSString*)value;
/// @brief Host subcomponent of `SODataV4_HttpAddress`.`authority`, e.g. "myhost".
///
///
- (void) setHost :(nonnull NSString*)value;
/// @brief Optional path component, e.g. "/mypath".
///
///
- (void) setPath :(nullable NSString*)value;
/// @brief Port subcomponent of `SODataV4_HttpAddress`.`authority`, e.g. 8080.
///
///
- (void) setPort :(SODataV4_int)value;
/// @brief Optional query component, e.g. "?myquery".
///
///
- (void) setQuery :(nullable NSString*)value;
/// @brief Scheme component, e.g. "http" or "https".
///
///
- (void) setScheme :(nonnull NSString*)value;
/// @return The URL in string form, e.g. "http://myhost:8080/path?query#fragment".
///
- (nonnull NSString*) toString;
/// @brief True for absolute URL, `false` for relative URL.
///
///
@property (nonatomic, readwrite) SODataV4_boolean absolute;
/// @brief Authority component, e.g. host ("myhost") or host and port ("myhost:8080").
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* authority;
/// @brief Optional fragment component, e.g. "#myfragment".
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* fragment;
/// @brief Host subcomponent of `SODataV4_HttpAddress`.`authority`, e.g. "myhost".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* host;
/// @brief Optional path component, e.g. "/mypath".
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* path;
/// @brief Port subcomponent of `SODataV4_HttpAddress`.`authority`, e.g. 8080.
///
///
@property (nonatomic, readwrite) SODataV4_int port;
/// @brief Optional query component, e.g. "?myquery".
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* query;
/// @brief Scheme component, e.g. "http" or "https".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* scheme;
@end
#endif
#endif

#ifdef import_SODataV4__HttpAddress_private
#ifndef imported_SODataV4__HttpAddress_private
#define imported_SODataV4__HttpAddress_private
@interface SODataV4_HttpAddress (private)
+ (nonnull SODataV4_HttpAddress*) _new1 :(nullable NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3 :(SODataV4_int)p4 :(SODataV4_boolean)p5 :(nullable NSString*)p6 :(nullable NSString*)p7 :(nonnull NSString*)p8;
@end
#endif
#endif

#ifdef import_SODataV4__HttpMethod_internal
#ifndef imported_SODataV4__HttpMethod_internal
#define imported_SODataV4__HttpMethod_public
/* internal */
/// @brief Constants for HTTP methods.
///
///
@interface SODataV4_HttpMethod : SODataV4_ObjectBase
{
}
#define SODataV4_HttpMethod_CONNECT @"CONNECT"
#define SODataV4_HttpMethod_DELETE @"DELETE"
#define SODataV4_HttpMethod_GET @"GET"
#define SODataV4_HttpMethod_HEAD @"HEAD"
#define SODataV4_HttpMethod_OPTIONS @"OPTIONS"
#define SODataV4_HttpMethod_PATCH @"PATCH"
#define SODataV4_HttpMethod_POST @"POST"
#define SODataV4_HttpMethod_PUT @"PUT"
#define SODataV4_HttpMethod_TRACE @"TRACE"
@end
#endif
#endif

#ifdef import_SODataV4__HttpStatus_internal
#ifndef imported_SODataV4__HttpStatus_internal
#define imported_SODataV4__HttpStatus_public
/* internal */
/// @brief Constants for HTTP status code.
///
///
@interface SODataV4_HttpStatus : SODataV4_ObjectBase
{
}
#define SODataV4_HttpStatus_OK 200
#define SODataV4_HttpStatus_CREATED 201
#define SODataV4_HttpStatus_ACCEPTED 202
#define SODataV4_HttpStatus_NO_CONTENT 204
#define SODataV4_HttpStatus_NOT_MODIFIED 304
#define SODataV4_HttpStatus_BAD_REQUEST 400
#define SODataV4_HttpStatus_UNAUTHORIZED 401
#define SODataV4_HttpStatus_FORBIDDEN 403
#define SODataV4_HttpStatus_NOT_FOUND 404
#define SODataV4_HttpStatus_CONFLICT 409
#define SODataV4_HttpStatus_PRECONDITION_FAILED 412
#define SODataV4_HttpStatus_METHOD_NOT_ALLOWED 405
#define SODataV4_HttpStatus_INTERNAL_SERVER_ERROR 500
#define SODataV4_HttpStatus_NOT_IMPLEMENTED 501
@end
#endif
#endif

#ifdef import_SODataV4__HttpStatusText_internal
#ifndef imported_SODataV4__HttpStatusText_internal
#define imported_SODataV4__HttpStatusText_public
/* internal */
/// @brief Constants for HTTP status text.
///
///
@interface SODataV4_HttpStatusText : SODataV4_ObjectBase
{
}
/// @brief Return the standard status text message for an HTTP status code.
///
///
/// @param code HTTP status code.
+ (nonnull NSString*) forCode :(SODataV4_int)code;
@end
#endif
#endif

#ifdef import_SODataV4__HttpException_internal
#ifndef imported_SODataV4__HttpException_internal
#define imported_SODataV4__HttpException_public
/* internal */
/// @brief An exception thrown if `HttpRequest.send` cannot be completed due to a network error,
///
/// or when one of the HTTP functions is used in an inappropriate manner or with invalid parameters.
@interface SODataV4_HttpException : SODataV4_DataNetworkException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_HttpException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified root cause.
/// @param cause Root cause.
+ (nonnull SODataV4_HttpException*) withCause :(nonnull NSException*)cause;
/// @return A new exception with the specified root cause and message text.
/// @param cause Root cause.
/// @param message Message text.
+ (nonnull SODataV4_HttpException*) withCauseAndMessage :(nonnull NSException*)cause :(nonnull NSString*)message;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_HttpException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__HttpException_private
#ifndef imported_SODataV4__HttpException_private
#define imported_SODataV4__HttpException_private
@interface SODataV4_HttpException (private)
+ (nonnull SODataV4_HttpException*) _new1 :(nullable NSException*)p1;
+ (nonnull SODataV4_HttpException*) _new2 :(nullable NSException*)p1 :(nullable NSString*)p2;
+ (nonnull SODataV4_HttpException*) _new3 :(nullable NSString*)p1;
@end
#endif
#endif

#endif
