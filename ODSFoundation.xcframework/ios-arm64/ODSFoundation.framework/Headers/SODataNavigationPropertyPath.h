//
//  SODataNavigationPropertyPath.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SODataNavigationPropertyPath : NSObject <NSCoding>

/*
 * Custom initializer
 * @param navigationPropertyPath the path to init the NavigationPropertyPath with
 */
-(SODataNavigationPropertyPath*)initWithNavigationPropertyPath:(NSString*)navigationPropertyPath;

/**
 The path of the NavigationProperty.
 */
@property (nonatomic, copy) NSString* navigationPropertyPath;


@end
