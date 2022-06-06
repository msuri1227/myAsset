//
//  SAPE2ETraceConstants.h
//  E2ETrace2
//  Created by Nyisztor Karoly on 2014.05.15..
//  Copyright 2014 SAP AG. All rights reserved.
//
#import <Foundation/Foundation.h>
#pragma mark - SAPE2ETrace Error domain
extern NSString* const SAPE2ETraceErrorDomain; ///< NSError domain for E2ETrace2 lib

#pragma mark - E2ETrace Error Codes
/**
 * error codes returned in NSError instances
 */
typedef NS_ENUM(NSUInteger, SAP_E2E_TRACE_ERROR_CODES)
{
    SAP_E2E_TRACE_ERROR_INITERROR = 0,
    SAP_E2E_TRACE_ERROR_TRANSACTION_NOT_ACTIVE = 1,
    SAP_E2E_TRACE_ERROR_STEP_NOT_ACTIVE = 2,
    SAP_E2E_TRACE_ERROR_REQUEST_NOT_ACTIVE = 3,
    SAP_E2E_TRACE_ERROR_NO_BTX = 4,
    SAP_E2E_TRACE_ERROR_PREVIOUS_STEP_NOT_CLOSED = 5
};

