//
//  HttpConversationConstants.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

/**
 * Defines the location of the Content ID, default is ContentIdLocationMultipart
 * @remark Note that not all server implementations adhere to the specification. Override the default with ContentIdLocationSingle may solve the issue
 * For details check http://www.odata.org/documentation/odata-version-2-0/batch-processing/ -> 2.2.1. Referencing Requests in a Change
 */
typedef NS_ENUM(NSInteger, SDContentIDLocations )
{
    ContentIdLocationMultipart, ///< default as per specification
    ContentIdLocationSingle,    ///< use for servers which report failure for the default setting
};

#pragma mark - Error domains

extern NSString* const UploaderE2ETraceErrorDomain;
extern NSString* const UploaderClientLogErrorDomain;

#pragma mark - Error codes

extern NSInteger const UploaderErrorCodeWrongContentType;
extern NSInteger const UploaderErrorCodeAuthenticationFailure;
extern NSInteger const UploaderErrorCodeRegistrationFailure;
extern NSInteger const UploaderErrorCodeWrongRegistrationID;
extern NSInteger const UploaderErrorCodeWrongHTTPOperation;