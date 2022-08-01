//
//  FederationProviderErrorCodes.h
//  FederationProvider
//
//  Copyright © 2016 SAP. All rights reserved.
//

#import "FederationErrorCodes.h"

extern NSString* const kFederationProviderErrorDomain;

typedef NSInteger FederationProviderError;
NS_ENUM(FederationProviderError) {
    errFederationProviderInvalidParameter=1,
    errFederationProviderCancelled,
    errFederationProviderConsistencyError,
    errFederationProviderNoFederatedProvider
};
