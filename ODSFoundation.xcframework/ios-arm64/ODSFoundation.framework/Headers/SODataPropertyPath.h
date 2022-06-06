//
//  SODataPropertyPath.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SODataPropertyPath : NSObject <NSCoding>

/*
 * Custom initializer
 * @param propertyPath the path to init the PropertyPath with
 */
-(SODataPropertyPath*)initWithPropertyPath:(NSString*)propertyPath;

/**
 The path of the property.
 */
@property (nonatomic, copy) NSString* propertyPath;


@end
