//
//  SupportabilityUploader.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SupportabilityUploading.h"
#import "HttpConversationManager.h"

/**
 SupportabilityUploader implementation, used for E2ETrace and ClientLog uploading
*/
@interface SupportabilityUploader : NSObject <SupportabilityUploading>

/**
 Initialize SupportabilityUploader class.
 @param conversationManager
 @param mutableURLRequest: request instance which is prepared for log uploading
*/
-(instancetype)initWithHttpConversationManager:(HttpConversationManager*)conversationManager urlRequest:(NSMutableURLRequest*)mutableURLRequest;

@end
