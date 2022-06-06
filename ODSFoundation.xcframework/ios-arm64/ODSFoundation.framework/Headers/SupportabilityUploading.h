//
//  SupportabilityUploading.h
//  Supportability
//
//  Copyright (c) 2014 SAP. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "NSMutableURLRequest+HttpConversation.h"

typedef NS_ENUM(NSUInteger, PAYLOAD_TYPE) {
    PAYLOAD_TYPE_TRACE = 0,
    PAYLOAD_TYPE_LOG = 1
};

@protocol SupportabilityUploading <NSObject>

/**
 * Method for sending trace/log files
 *
 * @param contentType The content type of the request
 * @param headers The headers to be set for the upload request
 * @param payloadType The type of payload to be uploaded
 * @param payload The payload to be uploaded. Trace or log content.
 * @param completion The block to be called back if the upload ended.
 *
 */
-(void) sendWithContentType:(NSString*)contentType headers:(NSDictionary*)headers payloadType:(PAYLOAD_TYPE)payloadType payload:(NSString*)payload completion:(void(^)(NSError*))completion DEPRECATED_ATTRIBUTE;

/**
 * Method for sending trace/log files
 *
 * @param contentType The content type of the request
 * @param headers The headers to be set for the upload request
 * @param payloadType The type of payload to be uploaded
 * @param payloadStream The stream for payload to be uploaded or an <code>input_stream_creator_t</code> that can create one. Trace or log content.
 * @param completion The block to be called back if the upload ended.
 *
 */
-(void) sendWithContentType:(NSString*)contentType headers:(NSDictionary*)headers payloadType:(PAYLOAD_TYPE)payloadType payloadStream:(id)payloadStream completion:(void(^)(NSError*))completion;

@end
