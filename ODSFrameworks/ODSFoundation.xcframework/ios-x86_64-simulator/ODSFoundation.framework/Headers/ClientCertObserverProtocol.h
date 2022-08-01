//
//  ClientCertObserverProtocol.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConversationObserverProtocol.h"

/**
 Observer which is notified when an X.509 client certificate challenge is fulfilled during an SSL/TLS handshake.
 */
@protocol ClientCertObserverProtocol <HttpConversationObserverProtocol>

/**
 Called when an authentication challenge is to be handled using a client certificate.

 @param secIdRef the certificate that is to be sent to the server for verification
 */
-(void)observeClientCertificate:(SecIdentityRef)secIdRef;

@end
