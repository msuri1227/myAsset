//
//  SODataGuid.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Represents an EDM.Guid OData value.
 */
@interface SODataGuid : NSObject <NSCoding>

/**
 * Custom initializer
 * @param guid string value to init the Guid with
 */
-(SODataGuid*) initWithString32:(NSString*)guid;

/**
 * Custom initializer
 * @param guid string value to init the Guid with
 */
-(SODataGuid*) initWithString36:(NSString*)guid;

/**
 * Custom initializer
 * @param guid binary data to init the Guid with
 */
-(SODataGuid*) initWithBinary:(NSData*)guid;

/**
 * Returns the guid as a 32 character string.
 */
-(NSString*) guidAsString32;

/**
 * Returns the guid as a 36 character string.
 */
-(NSString*) guidAsString36;

/**
 * Returns the value of the Guid in binary data format
 */
-(NSData*)   guidAsBinary;

@end
