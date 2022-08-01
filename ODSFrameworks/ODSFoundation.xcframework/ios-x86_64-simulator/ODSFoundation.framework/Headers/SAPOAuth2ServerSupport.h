//
//  SAPOAuth2ServerSupport.h
//  HttpConvAuthFlows
//
//  Copyright © 2017. SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OAuth2ServerSupportProtocol.h"

/**
 This class implements the OAuth2 server support protocol and allows for performing OAuth2 authorization against
 SAP Cloud Platform and SAP CP Mobile Services.
 <p>
 An object of this type should be initialized with a particular host, port and scheme which points to the server to work with.
 This information is either known upfront by the application developer or can be obtained using any solution that can configure
 an application on the device.
 </p>
 <p>
 Its <code>transformRequestURLToStorageURL:</code> method makes sure that in case SAPcpms is used then the relevant tokens are
 stored in a token storage per client ID. Therefore, the transformation it implements is independent of its argument and always yields
 the following virtual URL for an instance of this type:
 <code>&lt;token endpoint URL&gt;?client_id=&lt;client identifier&gt;</code>
 This implies that one object of this type should be initialized for one client which is, in most of the cases, one application.
 </p>
 <p>
 If that is not the case then create a subclass of this class and override the <code>isGovernedByOAuth2Client:</code> method. Check out
 its API documentation for the details.
 </p>
 */
@interface SAPOAuth2ServerSupport : NSObject <OAuth2ServerSupportProtocol>

/**
 Convenience initializer which takes only the server URL.
 <p>
 This method derives the OAuth2 authorization and token endpoint URLs by targeting the <code>oauthasservices</code> application using the tenant ID taken from
 the server URL. The endpoints are expected at the <code>/oauth2/api/v1/authorize</code> and <code>/oauth2/api/v1/token</code> paths respectively. The redirect URI,
 if not specified, is derived similarly.
 </p>
 
 @param serverUrl the URL pointing to the SAPcp server, must be non-nil
 @param clientId the OAuth2 client ID, must be non-nil
 @param clientSecret the OAuth2 client secret, can be nil
 @param scope the scope, can be nil
 @param redirectUri the redirect URI, can be nil
 @return self
 */
-(instancetype)initWithURL:(NSURL*)serverUrl withClientId:(NSString*)clientId withClientSecret:(NSString*)clientSecret withScope:(NSString*)scope withRedirectUri:(NSURL*)redirectUri;

/**
 Initializes an object of this type that works with the specified server. This intializer allows for setting up all the OAuth2-related parameters.

 @param serverUrl the URL pointing to the SAPcp server, must be non-nil
 @param authorizationEndpoint the authorization endpoint URL, must be non-nil
 @param tokenEndpoint the authorization endpoint URL, must be non-nil
 @param clientId the OAuth2 client ID, must be non-nil
 @param clientSecret the OAuth2 client secret, can be nil
 @param scope the scope, can be nil
 @param redirectUri the redirect URI, must be non-nil
 @return self
 */
-(instancetype)initWithURL:(NSURL*)serverUrl authorizationEndpoint:(NSURL*)authorizationEndpoint tokenEndpoint:(NSURL*)tokenEndpoint withClientId:(NSString*)clientId withClientSecret:(NSString*)clientSecret withScope:(NSString*)scope withRedirectUri:(NSURL*)redirectUri NS_DESIGNATED_INITIALIZER;

/**
 Default initialization is not possible.
 */
-(instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 Decides whether the specified URL is indeed governed by the OAuth2 client ID that this server support object has been initialized with.
 &quot;tGovern&quot; here means that when an access token is acquired using the OAuth2 configuration of this object, it will be usable
 to access the specified URL.
 <p>
 This method is invoked by <code>isSupportedEndpoint:completion:</code> and causes it to return NO if this method returns NO.
 </p>
 <p>
 By default, this method returns YES which is handy in case you work with a single client ID per server (i.e. scheme + host + port).
 </p>
 <p>
 Subclasses might override this behaviour if they'd like to narrow down the set of URLs for which the access token is valid. Suppose
 that you have an application registered on SAPcpms under the application ID <code>com.mycompany.fancyapp</code> for which 2 OData
 backends belong that are accessible via the <code>com.mycompany.fancyapp.conn1</code> and <code>com.mycompany.fancyapp.conn2</code>
 connections. Now, the OData request URLs will contain those connection identifiers. Below is an example subclass:
 </p>
 <pre>
 // Specify the subclass.
 @interface FancyAppOAuth2ServerSupport : SAPOAuth2ServerSupport

 -(instancetype)init;

 @end
 @implementation FancyAppOAuth2ServerSupport

 -(instancetype)init {
   // Initialize using superclass initializer method. Arguments are not expanded here for brevity
   return [super initWithURL:...]);
 }

 -(BOOL)isGovernedByOAuth2Client:(NSURL*)url {
   return [url.path containsString:@"/com.mycompany.fancyapp/"] ||
          [url.path containsString:@"/com.mycompany.fancyapp.conn1/"] ||
          [url.path containsString:@"/com.mycompany.fancyapp.conn2/"];
 }

 @end

 // Create configurator and add OAuth2 support for it.
 CommonAuthenticationConfigurator* configurator = [CommonAuthenticationConfigurator new];
 [configurator addOAuth2ServerSupport:[FancyAppOAuth2ServerSupport new]];

 // Configure a conversation manager. HTTP requests fired with this manager against the server
 // will handle OAuth2 authorization properly, provided that the request targets a path that
 // satisfies the above conditions.
 HttpConversationManager* manager = [HttpConversationManager new];configurator.configure(new HttpConversationManager(...));
 </pre>
 <p>
 This OAuth2 server support will be used to acquire tokens (either from the server or from storage) in case the request goes to a path which
 contains one of the specified connection identifiers. Otherwise, this server support object will not take part in request processing.
 </p>
 <p>
 Also note that the above implementation of <code>isGovernedByOAuth2Client:</code> also checks for the application ID. This is to ensure that
 this server support object is used when performing application registration.
 </p>
 <p>
 If you use multiple client IDs with different application and connection identifiers then you can make another subclass for those by following
 the above example pattern.
 </p>

 @param url the URL to test, must be non-nil
 @return YES if the access token acquired using this server support object can be used to access the resource on the specified URL, NO otherwise
 */
-(BOOL)isGovernedByOAuth2Client:(NSURL*)url;

@end
