//
//  SODataValueCollection.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetaProperty.h"

@interface SODataValueCollection : NSObject <NSCoding>
/*
 * Custom initializer
 * @param values the value array to initialize the collection with
 * @param type the type of the collection \sa SODataEDMTypes
 */
-(SODataValueCollection*)initWithValues:(NSArray*)values type:(SODataEDMTypes)type;

/**
 The values of the collection.
 */
@property (nonatomic, strong) NSArray* values;

/**
 The values of the collection.
 */
@property (nonatomic, assign) SODataEDMTypes type;

@end
