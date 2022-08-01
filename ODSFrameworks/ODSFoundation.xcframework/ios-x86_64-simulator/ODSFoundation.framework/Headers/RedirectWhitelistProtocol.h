//
//  RedirectWhitelistProtocol.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Use this protocol to implement a custom redirect whitelist. An object of this type then can be configured for a <code>HttpConversationManager</code> by
 setting its <code>redirectWhitelistImplementation</code> property. Whenever a redirect is encountered the <code>isValidUrl:</code> method is going to be called
 and if it returns NO then the redirect is going to be rejected. Note that in this case the redirect filters are not executed either.
 <p>
 Rejecting the redirect means that the corresponding HTTP 3xx response is going to be returned verbatim to the caller who initiated the conversation.
 </p>
 */
@protocol RedirectWhitelistProtocol <NSObject>

/**
 Invoked when a redirect is about to happen to a new URL.

 @param aURL the URL that needs to be validated, must be non-nil
 @return YES if the URL is valid, NO if it should be rejected
 */
-(BOOL)isValidUrl:(NSURL*)aURL;

@end
