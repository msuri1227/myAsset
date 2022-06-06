//
//  OTPWebStrategy.h
//  HttpConvAuthFlows
//
//  Copyright © 2016 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Static class containing the helper methods that compliant <code>OTPWebStrategy</code> protocol implementors must use. Consult
 the documentation of the protocol in order to understand how the entire OTP flow fits together. Actually, the static methods
 in this class establish a more-or-less linear workflow with one method producing the input required for the other. Make sure
 to become familiar with the concepts layed down in this class and in the protocol before venturing into writing your own
 OTP flow implementation.
 */
@interface OTPWebStrategyHelper : NSObject

/**
 Returns the passcode parameter from the URL provided that it has the <code>sapauthenticator://</code> scheme. If the URL is
 not of the correct format or is nil then nil is returned.
 
 @param url the URL to extract the name of the passcode parameter from, can be nil
 @return the name of the passcode parameter if the URL met every format requirement, may be nil
 */
+(NSString*)extractPasscodeParameterNameFrom:(NSURL*)url;

/**
 Extracts the passcode from the specified URL. This should be invoked on the URL that SAP Authenticator used to call back the
 application. The passcode parameter is the one that has been obtained using the <code>extractPasscodeParameterNameFrom:</code>
 method.
 
 @param callbackUrl the URL SAP Authenticator called back with, can be nil
 @param passcodeParameterName the name of the passcode parameter, must be non-nil
 @return the extracted passcode if everything was okay or nil otherwise
 */
+(NSString*)extractPasscodeFrom:(NSURL*)callbackUrl withParameterName:(NSString*)passcodeParameterName;

/**
 Creates the OTP form URL containing the passcode properly added to it as a query parameter.
 
 @param url the original OTP form URL that was used to extract the passcode parameter name with successfully, must be non-nil
 @param passcode the acquired passcode, must be non-nil
 @return the OTP form URL or nil if there was a problem with the arguments
 */
+(NSURL*)createOTPFormURLFrom:(NSURL*)url withPasscode:(NSString*)passcode;

/**
 Determines whether the URL is the one to which the closing redirect should be sent given the specified finish endpoint.
 
 @param url the URL to test, can be nil
 @param finishEndpoint the finish endpoint, must be non-nil
 @return YES if the URL is indeed the closing redirect of the OTP flow parametrized with the given finish endpoint, NO otherwise
 */
+(BOOL)isClosingRedirect:(NSURL*)url withFinishEndpoint:(NSString*)finishEndpoint;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

@end

/**
 Protocol defining the strategy how to open the URL that leads to the OTP authentication screen.
 */
@protocol OTPWebStrategy <NSObject>

/**
 Starts the OTP authentication using the specified arguments. As the OTP flow has certain steps that are implementation-independent,
 implementors are expected to make use of the <code>OTPWebStrategyHelper</code> class. Below are the steps what make up the flow:
 <ol>
 <li>The strategy should open the specified URL in one way or the other. It is assumed to be obtained from an OTP challenge which
 is actually an HTTP redirect. The URL points to the OTP login form.</li>
 <li>After the form has been opened the implementor must monitor when the web flow attempts to open the SAP Authenticator application
 using the <code>[OTPWebStrategyHelper extractPasscodeParameterNameFrom:]</code> method.</li>
 <li>At this point the user should be interacting with the SAP Authenticator application the end result of which is the passcode.
 It might happen that the SAP Authenticator is opened and the passcode is fetched in a different way (for ex. via copy-pasting it
 from the SAP Authenticator app without opening it with a link). If that is the case then these steps are missing.</li>
 <li>When the SAP Authenticator returns the passcode to the application, it does so by opening an URL with the <code>&lt;app.
 bundle ID&gt;.xcallbackurl</code> scheme. This application must have this scheme registered in the <code>Info.plist</code> file
 appropriately. The easiest way to use this is to follow the guidance of the <code>CustomURLSchemeManager</code> class of this
 library. The goal is to extract the passcode from this callback URL using the
 <code>[OTPWebStrategyHelper extractPasscodeFrom:withParameterName:</code></li> method.
 <li>If the one-time passcode is at hand then the OTP form should be reloaded. Use the
 <code>[OTPWebStrategyHelper createOTPFormURLFrom:withPasscode:]</code> method to get this URL.</li>
 <li>The strategy implementation then should load this URL and then wait for a request which contains the finish endpoint. To
 achieve this, use the <code>[OTPWebStrategyHelper isClosingRedirect:withFinishEndpoint:]</code> method and complete the flow if it returns true.
 Note that in case the user manually copy-pastes the passcode into the OTP form then this is the only step in the process as no
 custom-URL-scheme-driven mechanisns are going to be used to communicate between this application and the SAP Authenticator.</li>
 </ol>
 <p>
 As can be seen, implementations are required to follow quite a strict pattern in order to comply with the contracts of this protocol.
 This is because the OTP flow supported is very strongly tied to web-based flows. Consequently, implementations usually differ based
 on how they implement the web flow. The default implementation, for example, makes use of the built-in <code>WKWebView</code> and the
 <code>UserInteractionMultiplexer</code> library. Possible implementations could be using different web view implementations or other means
 to display the OTP form and implement the flow.
 </p>

 @param url the URL to which the request whose response contained the OTP challenge has been redirected needed, must be non-nil
 @param finishEndpoint the finish endpoint, must be non-nil
 @param otpUrlAdditionalParams the additional params to use, can be nil
 @param completionBlock the block that is invoked at the end of the operation with a flag indicating success or failure
 */
-(void)startOTPAuthenticationForURL:(NSURL*)url
       withFinishEndpoint:(NSString*)finishEndpoint
       andParams:(NSString*)otpUrlAdditionalParams
       completion:(void (^)(BOOL))completionBlock;

@end
