//
//  SODataUploadMediaDefault.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import "SODataUploadMedia.h"

@interface SODataUploadMediaDefault : NSObject<SODataUploadMedia>

/**
 * Custom initializer
 * @param filePath the path of the file to upload
 * @param contentType the content type of the media stream
 */
- (instancetype) initWithFileAtPath:(NSString*)filePath contentType:(NSString*)contentType;


/**
 * Custom initializer
 * @param data the data to upload
 * @param contentType the content type of the media stream
 */
- (instancetype) initWithData:(NSData*)data contentType:(NSString*)contentType;

@end
