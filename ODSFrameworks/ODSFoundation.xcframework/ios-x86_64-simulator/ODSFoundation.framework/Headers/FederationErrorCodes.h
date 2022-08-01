//
//  Header.h
//  Federation
//
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Security/SecBase.h>

extern NSString* const kFederationErrorDomain;

typedef NSInteger FederationError;
NS_ENUM(FederationError) {
    errFederationInvalidParameter=1,
    errFederationConsistencyError,
    errFederationStoreWrongPasscode,
    errFederationStoreDoesntExist,
    errFederationStoreAlreadyExists,
    errFederationStoreFailedtoAddItem,
    errFederationStoreFailedtoReadItem,
    errFederationStoreFailedtoRemoveItem,
    errFederationFailedToCreateIdentity,
    errFederationFailedtoCreatePKCS12,
    errFederationFailedToCreateBase64,
    errFederationFailedToProcessPrivateKey,
    errFederationFailedToExportCertificateData,
    errFederationFailedToExportPrivateKey
};
