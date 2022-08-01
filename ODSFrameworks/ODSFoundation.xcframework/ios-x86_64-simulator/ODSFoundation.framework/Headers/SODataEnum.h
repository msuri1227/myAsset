//
//  SODataEnum.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Represents a value with Enum type
 */
@interface SODataEnum : NSObject <NSCoding>

/*
 * Custom initializer
 * @param value string value to init the Enum with
 * @param localName the local name to init the Enum with
 * @param qualifiedName the fully qualified name to init the Enum with
 * @param availableValues Array of the available values to init the Enum with
 * @param isFlags flag indicator to init the Enum with
 */
-(SODataEnum*)initWithValue:(NSString*)value localName:(NSString*)localName qualifiedName:(NSString*)qualifiedName availableValues:(NSArray*)availableValues isFlags:(BOOL)isFlags;

/**
 The string value of the Enum.
 */
@property (nonatomic, copy) NSString* value;

/**
 The local name of the Enum.
 */
@property (nonatomic, copy) NSString* localName;

/**
 The fully qualified name of the Enum.
 */
@property (nonatomic, copy) NSString* qualifiedName;

/**
 The available values of the Enum.
 */
@property (nonatomic, strong) NSArray* availableValues;

/**
 Indicates whether it is a flag or not.
 */
@property (nonatomic, assign) BOOL isFlags;

@end
