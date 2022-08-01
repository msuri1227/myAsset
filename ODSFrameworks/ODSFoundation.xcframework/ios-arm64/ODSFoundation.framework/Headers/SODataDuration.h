//
//  SODataDuration.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//
#import <Foundation/Foundation.h>
/**
 Represents some time duration
 */
@interface SODataDuration : NSObject <NSCoding>

/**
 Years of the duration
 */
@property (nonatomic, strong) NSNumber* years;

/**
 Months of the duration
 */
@property (nonatomic, strong) NSNumber* months;

/**
 Days of the duration
 */
@property (nonatomic, strong) NSNumber* days;

/**
 Hours of the duration
 */
@property (nonatomic, strong) NSNumber* hours;

/**
 Minutes of the duration
 */
@property (nonatomic, strong) NSNumber* minutes;

/**
 Seconds of the duration
 */
@property (nonatomic, strong) NSNumber* seconds;

/**
 Shows whether it is a negative duration
 */
@property (nonatomic, assign) BOOL isNegativeDuration;

/**
 Sets the year, month, day, hour, minute, second values to zero.
 */
-(void) reset;

@end
