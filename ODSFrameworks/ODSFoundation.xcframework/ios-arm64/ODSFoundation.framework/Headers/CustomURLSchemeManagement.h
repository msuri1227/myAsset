//
//  CustomURLSchemeManagement.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomURLSchemeHandler.h"

/**
 This singleton manages all the functionality which relies on custom URL scheme callbacks. Some authentication flows configurable using the
 <code>CommonAuthenticationConfigurator</code> class await for such callbacks at certain points in the flow. This class helps these components
 and the application integrating this library to easily deliver the callbacks to their respective listeners.
 <p>
 When an application registers one or more custom schemes in its <code>Info.plist</code> then the iOS system calls the
 <code>application:openURL:options:</code> method of the <code>UIApplicationDelegate</code> whenever someone tries to open an URL
 with the registered scheme. Defining this method is the responsibility of the application developer. Depending on the use of additional technologies, the
 below possibilities exist:
 <ul>
 <li>If this application also uses the <code>MAFLogonManagerNG</code> library then no extra steps are required to integrate this singleton with the
 custom URL scheme opening mechanism, provided that MAF Logon itself is properly integrated with the app already. Check the documentation of the Logon Manager
 to see what needs to be done for it to receive custom URL scheme opening events. If this is done properly then MAF Logon will ensure that this class also
 receive the same notifications.</li>
 <li>If this application is a Cordova Hybrid Application then no extra steps are required as this class automatically integrates with the URL opening
 mechanism implemented in the Cordova Framework.</li>
 <li>In any other case, make sure that the <code>handleOpenURL:</code> method of this singleton is called from the application delegate when an external
 URL is opened.</li>
 </ul>
 As the above suggest, what matters is that eventually this class be notified about when the application is asked to open an URL with a custom scheme.
 </p>
 <p>
 Notifications are handled by <code>CustomURLSchemeHandler</code> objects registered using the <code>subscribeHandler:</code> method. There is no
 deregister/unsubscribe method offered as this class keeps only weak references to these handlers. This implies that handlers are notified as long as
 a strong reference is maintained to them by another component.
 </p>
 */
@interface CustomURLSchemeManagement : NSObject

/**
 Returns the singleton.
 
 @return the singleton, always non-nil
 */
+(instancetype)sharedInstance;

/**
 Method to be invoked from the application delegate to notify this class about a new URL to be opened. It is not necessary when the application is
 using a properly integrated <code>MAFLogonManagerNG</code> library and/or is built-on top of the Cordova Framework.
 
 @param url the URL the system asked this application to open, must be non-nil
 */
-(void)handleOpenURL:(NSURL*)url;

/**
 Subscribes the handler to receive open URL notifications.
 
 @param handler the handler to subscribe, must be non-nil
 */
-(void)subscribeHandler:(CustomURLSchemeHandler*)handler;

@end
