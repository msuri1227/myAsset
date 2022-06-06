//
//  SODataAnnotation.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import "SODataAnnotationTerm.h"

@protocol SODataAnnotation <NSObject, NSCoding>

/**
 The Term of the annotation. \sa SODataAnnotationTerm
 */
@property (readonly, nonatomic, assign) id<SODataAnnotationTerm> annotationTerm;

/**
 The value of the annotation.
 */
@property (readonly, nonatomic, strong) NSObject* value;

/**
 The qualifier of the annotation.
 */
@property (readonly, nonatomic, copy) NSString* qualifier;



@end
