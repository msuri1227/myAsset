//
//  SODataDownloadMediaResult.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * Represents a media content.
 *
 */
@protocol SODataDownloadMediaResult <NSObject>

/**
 Retrieves the stream of the media content.
 */
@property (nonatomic, strong) NSInputStream* inputStream;

/**
 Retrieves the content type of the media content.
 */
@property (nonatomic, copy) NSString* contentType;

/**
 Retrieves the content lenth of the media content.
 */
@property (nonatomic, assign) NSInteger contentLength;

/**
 Retrieves the ETag of the media content.
 */
@property (nonatomic, copy) NSString* ETag;

/** 
 Headers of the media response.
 */
@property (nonatomic, strong) NSMutableDictionary* allHttpHeaders;


@end
