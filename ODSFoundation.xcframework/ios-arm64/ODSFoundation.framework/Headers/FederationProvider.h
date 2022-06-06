//
//  FederationProvider.h
//  FederationProvider
//
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CertificateProvider.h"

/**
 Certificate provider implementation that uses an object of <code>Federation</code> underneath to provision certificates shared in a group of applications. Make sure
 to read the documentation of the <code>Federation</code> class prior to making use of this provider. It is especially important as the necessary configurations
 required to set a provider of this type up are identical to what is documented for the aforementioned class.
 <p>
 As an object of this type initializes a <code>Federation</code> object under the hood, multiple instances should not be created. If done so, the resulting behaviour
 is undefined. Likewise, do not attempt to use this class in a thread-unsafe manner. Proper synchronization needs to be put in place to ensure correct behaviour.
 </p>
 <p>
 Shortly speaking, the idea of this provider implementation is as follows: it initializes a so-called <i>underlying certificate provider</i> which is also an
 implementation of the <code>CertificateProvider</code> protocol, uses it to acquire a certificate and then shares it among multiple applications using federation.
 </p>
 <p>
 The underlying provider is configured via both the options dictionary of this provider and the <code>Info.plist</code> file of the application. Here's how:
 <ul>
 <li>Specify an identifier and place it in the option/parameter dictionary under the <code>federated_certificate</code> key. The associated identifier must be
 an entry in the info dictionary.</li>
 <li>Specify the resolved identifier in the info dictionary and associate it with the name of the class that you want to use as an underlying certificate provider.
 Of course, that class needs to conform to the <code>CertificateProvider</code> protocol.</li>
 </ul>
 </p>
 <p>
 Essentially, the above mechanism is a double-lookup of the class name of the underlying provider. First, an info dictionary key needs to be placed in the option
 dictionary and then that key will be resolved to the actual class name.
 </p>
 <p>
 The underlying provider is initialized whenever <code>initialize:withCompletion:</code> or <code>setParameters:failedWithError:</code> is invoked. The specified
 option/parameter dictionary is passed on to the underlying provider. If it requires any options, just set them as if the provider was instantiated and initialized
 directly.
 </p>
 <p>
 During certificate provisioning, this class will always try first to get the certificate from federation. When that fails it turns to the underlying provider, returns
 the certificate and places it into federation again. The asynchronous flow (that is, the flow implemented by <code>initialize:withCompletion:</code>) is slightly
 more complex: if it can return a stored certificate (either stored in federation or by the underlying provider) then it first displays a consent screen whether
 the user wants to use the federated certificate or start acquiring a new one.
 </p>
 <p>
 The <code>getStoredCertificate:error:</code> method therefore looks into federation first and then into the underlying provider. Federation will not be checked
 if it has not been initialized, that is, no call to <code>initialize:withCompletion:</code> or <code>setParameters:failedWithError:</code> has been made yet. Moreover,
 the latter method will only initialize federation if one already exists. The former method is the one that can create a new federation store if none exists. Therefore,
 to ensure that the <code>getStoredCertificate:error:</code> method first looks into the existing federation store, make sure to set the parameters first.
 </p>
 <p>
 It's important to highlight that <code>deleteStoredCertificateWithError:</code> deletes the certificate in the underlying provider but does not delete the
 certificate in federation. This is to ensure that other applications can keep on using the old certificate as long as one of them decides to start an asynchronous
 flow again and acquire a new certificate. Note that during this flow this class will call <code>deleteStoredCertificateWithError:</code> internally on the underlying
 provider if the user wishes to provision a new certificate.
 </p>
 <p>
 Applications in the same group using a provider of this type are not required to use the same kind of underlying provider. This is not validated in any way. Application
 developers therefore can leverage this flexibility as long as it makes sense in their scenario. For example, one particular application might provision a certificate
 from an MDM solution whereas another one can read it from a file hard-coded in the application bundle. As long as these certificates are usable for the application the
 flow should be fine. It is however up to the application developer to properly understand the implications of this class. This means that the certificate provisioned
 by this provider depends on the underlying providers and the applications in the same group. One must carefully connect such a family of providers in the same group
 to understand how, when and what kind of certificates are going to be provisioned.
 </p>
 */
@interface FederationProvider : NSObject <CertificateProvider>

@end
