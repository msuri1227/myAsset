//
//  CDSProvider.h
//  CDSProvider
//
//  Copyright (c) 2015 SAP. All rights reserved.
//


#include "CertificateProvider.h"

extern NSString* const kCDSProviderErrorDomain;

extern const int errGetOAuthToken;
extern const int errCDSProviderCreateKeys;
extern const int errCDSProviderGetCertAttr;
extern const int errCDSProviderParseCertAttr;
extern const int errCDSProviderCreateCSR;
extern const int errCDSProviderGetCert;
extern const int errCDSProviderParseCert;
extern const int errCDSProviderGetStoredCertificate;
extern const int errCDSProviderParseParams;

/**
 Certificate provider which is capable of connecting to the SAP MobileSecure Certificate Discovery Service (CDS). Essentially, this provider is an implementation
 of SCEP: it generates a new Certificate Signing Request (CSR) along with the corresponding key pair and then sends the CSR to MobileSecure which then signs the
 certificate and returns it.
 <p>
 The signing mechanism is protected by OAuth2 on the SAP MobileSecure side. Therefore, the user has to log in and authorize this application for the certificate
 retrieval to work properly. Internally, this provider uses the <code>HttpConvAuthFlows</code> library to deal with OAuth2 authorization.
 </p>
 <p>
 The returned certificate is stored in the keychain and is kept there 'till it is deleted using the <code>deleteStoredCertificateWithError:</code> method.
 </p>
 <p>
 To properly configure this provider, the following parameters must be specified in the dictionary that can be passed to <code>initialize:withCompletion:</code> or
 <code>setParameters:failedWithError:</code>. The example is written in the Objective-C dictionary literal format for easier reading:
 </p>
 <pre>
 NSDictionary params = @{
   @"com.sap.mobilesecure.certificateService.attributesEndpoint" : @"<the SAP MobileSecure CDS certificate attributes endpoint, ex. https://abcd1234.next.sapmobileplace.com/product-api.svc/UserCertificates/getUserCertificateAttributes>",
   @"com.sap.mobilesecure.certificateService.requestEndpoint" : @"<the SAP MobileSecure CDS certificate request endpoint, ex. https://abcd1234.next.sapmobileplace.com/product-api.svc/UserCertificates/requestUserCertificate>",
   @"scope" : @"<the OAuth2 scope, optional>",
   @"com.sap.mobilesecure.certificateService.authType" : @{
     @"authorizationEndpoint" : @"<the OAuth2 authorization endpoint, ex. https://abcd1234.next.sapmobileplace.com/oauth/authorize>",
     @"client_id" : @"<the OAuth2 Client ID>",
     @"redirect_uri" : @"<the OAuth2 Redirect URI>",
     @"tokenEndpoint" : @"the OAuth2 token endpoint, ex. https://abcd1234.next.sapmobileplace.com/oauth/token"
   }
 }
 </pre>
 <p>
 This class is not thread-safe and is not intended to be instantiated multiple times within the same application. Make sure at most only one instance is in use
 at a time and by only a single thread.
 </p>
 */
@interface CDSProvider : NSObject <CertificateProvider>

@end
