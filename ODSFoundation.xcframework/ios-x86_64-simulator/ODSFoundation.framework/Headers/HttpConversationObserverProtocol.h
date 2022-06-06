//
//  HttpConversationObserverProtocol.h
//  HttpConversation
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Protocol which is the root of the hierarchy of observers, a concept with special significance in this library. Observers are objects which can be
 registered with a <code>HttpConversationManager</code> instance using its <code>addObserver:</code> method. These observers are notified when
 certain events occur. These events are different for each sub-protocol deriving from this one.
 <p>
 The <code>ClientCertObserverProtocol</code> and <code>HttpRedirectionObserverProtocol</code> are built-in sub-protocols intended for catching
 notification concerning X.509 client certificate authentication and HTTP 3xx redirection events, respectively. Consult their documentation
 for the details.
 </p>
 <p>
 Typically, instances of these protocols are used (i.e. invoked) by filter implementations or by the core pieces of this library. It is possible
 to create custom sub-protocols. These then can be accessed via the <code>HttpConversationContextProtocol</code> objects and imvoked as needed.
 </p>
*/
@protocol HttpConversationObserverProtocol <NSObject>

@end
