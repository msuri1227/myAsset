//
//  SODataMetaAnnotable.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SODataAnnotationName;
@protocol SODataAnnotation;

/**
 * The Interface Annotable. Base interface for metadata elements supports Odata v4.0 vocabulary-based annotation
 */
@protocol SODataMetaAnnotable <NSObject, NSCoding>

/**
 Retrieves the V4 annotation names.
 */
@property (readonly, nonatomic, strong) NSArray* vocabularyAnnotationNames;

/**
 Retrieves the annotation value specified by the given fully qualified annotation name.
 @param annotationName the name of the annotation
 @return id<SODataAnnotation>
 */
- (id<SODataAnnotation>)vocabularyAnnotationForAnnotationName:(id<SODataAnnotationName>)annotationName;

/**
 Retrieves the annotation value with the given annotation namespace and localname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return id<SODataAnnotation>
 */
- (id<SODataAnnotation>)vocabularyAnnotationForName:(NSString*)name namespace:(NSString*)aNamespace;

@end
