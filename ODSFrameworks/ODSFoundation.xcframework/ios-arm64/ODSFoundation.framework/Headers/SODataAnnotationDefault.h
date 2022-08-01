//
//  SODataAnnotationDefault.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import "SODataAnnotation.h"
#import "SODataAnnotationTerm.h"

/**
 Represents the metadata of an OData property
 */
@interface SODataAnnotationDefault : NSObject<SODataAnnotation>

/**
 * Custom initializer
 * @param annotationTerm the Term of the Annotation \sa SODataAnnotationTerm
 * @param value the value of the annotation
 */
- (id) initWithAnnotationTerm:(id<SODataAnnotationTerm>)annotationTerm value:(NSObject*)value qualifier:(NSString*)qualifier;

@end
