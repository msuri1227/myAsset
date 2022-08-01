//
//  SODataAnnotationName.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Representation for annotation name. An annotation name consists of annotation namespace and the local name.
 */
@protocol SODataAnnotationName <NSObject, NSCopying>

/**
 Name of the annotation.
 */
@property (readonly, nonatomic, copy) NSString* name;

/**
 Namespace of the annotation.
 */
@property (readonly, nonatomic, copy) NSString* annotationNamespace;

@end
