//
//  SODataResponseChangesetDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataResponseChangeset.h"

/**
 Represents an OData changeset response
 */
@interface SODataResponseChangesetDefault : NSObject <SODataResponseChangeset>

/**
 * Custom initializer
 * @param responses_in the responses to init the response changeset with
 */
- (instancetype)initWithResponses:(NSArray*)responses_in;

@end
