//
//  SODataLink.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

@protocol SODataAnnotationName;

/**
 Represents a link to a particular resource within a store.
 */
@protocol SODataLink <SODataPayload>

/**
 Returns the relative path of the resource which is to be interpreted relative to the base URL of the service.
 */
@property (readonly, nonatomic, copy) NSString* resourcePath;

/**
 Retrieves the annotation names of the link.
 Not implemented in ODataOnline, will retreive empty array.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Retrieves the annotation value of the link specified by the given fully qualified annotation name.
 Not implemented in ODataOnline, will return nil.
 @param annotationName the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName;

/**
 Retrieves the annotation value of the link with the given annotation namespace and localname.
 Not implemented in ODataOnline, will return nil.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;


@end
