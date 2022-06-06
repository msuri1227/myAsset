//
//  SODataLinkDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataLink.h"

/**
 Represents a relationship to a resource.
 */
@interface SODataLinkDefault : NSObject<SODataLink>

/**
 * Custom initializer
 * @param resourcePath the path to initialize the link with
 */
- (instancetype) initWithResourcePath:(NSString*)resourcePath;

@end
