//
//  SODataMetaAnnotable.h
//  ODataAPI
//
//  Copyright (c) 2015 SAP. All rights reserved.
//

#import "SODataMetaAnnotable.h"

@interface SODataMetaAnnotableDefault :NSObject<SODataMetaAnnotable>

/**
 * Custom initializer
 * @param vocabularyAnnotations the V4 annotations
 */
- (id) initWithVocabularyAnnotations:(NSDictionary*)vocabularyAnnotations;

@end
