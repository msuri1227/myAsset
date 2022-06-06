//
//  SODataComplexValueCollection.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SODataComplexValueCollection : NSObject <NSCoding>

/*
 * Custom initializer
 * @param values the values to init the collection with
 */
-(SODataComplexValueCollection*)initWithValues:(NSArray*)values;

/**
 The values of the collection.
 */
@property (nonatomic, strong) NSArray* values;

@end
