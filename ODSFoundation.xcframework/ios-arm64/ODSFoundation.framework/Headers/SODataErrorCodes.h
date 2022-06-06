//
//  SODataErrorCodes.h
//  ODataOnline
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

/**
 * Constants for error domains
 */
#define kSODataParserErrorDomain @"ParserDomain"
#define kSODataNetworkErrorDomain @"NetworkDomain"
#define kSODataContractViolationErrorDomain @"ContractViolationDomain"

/**
 * Error codes for errors in parser error domain
 */
typedef enum SODataParserDomainErrorCodes {
    SODataParserDomainErrorCodeDataSerializationError = 1,
    SODataParserDomainErrorCodeDataDeserializationError = 2,
    SODataParserDomainErrorCodeMetadataDeserializationError = 3,
    SODataParserDomainErrorCodeValidationError = 4,
    SODataParserDomainErrorCodeInternalError = 5,
    SODataParserDomainErrorCodeODataErrorDeserializationError = 6
} SODataParserDomainErrorCodes;

/**
 * Error codes for errors in network error domain
 */
typedef enum SODataNetworkDomainErrorCodes {
    SODataNetworkDomainErrorCodeCacheError = 1,
    SODataNetworkDomainErrorCodeInternalError = 2,
    SODataNetworkDomainErrorCodeNetworkError = 3,
    SODataNetworkDomainErrorCodeResponseError = 4
} SODataNetworkDomainErrorCodes;

/**
 * Error codes for errors in ContractViolation error domain
 */
typedef enum SODataContractViolationDomainErrorCodes {
    SODataContractViolationDomainMissingStoreDelegate = 1,
    SODataContractViolationDomainMissingURL = 2,
    SODataContractViolationDomainMissingResourcePath = 3,
    SODataContractViolationDomainMissingRequestMode = 4,
    SODataContractViolationDomainInvalidResourcePath = 5,
    SODataContractViolationDomainUnknownPayloadType = 6,
    SODataContractViolationDomainWrongRequestMode = 7,
    SODataContractViolationDomainMissingBatchItems = 8,
    SODataContractViolationDomainWrongResponseType = 9,
    SODataContractViolationDomainStoreNotOpen = 10,
    SODataContractViolationDomainStoreAlreadyOpen = 11,
    SODataContractViolationDomainStoreClosed = 12,
    SODataContractViolationDomainInvalidStoreOptionValue = 13,
    SODataContractViolationDomainMissingStoreOptions = 14,
    SODataContractViolationDomainInvalidInputParameters = 15,
    SODataContractViolationDomainWrongPropertyType = 16,
    SODataContractViolationDomainInvalidPayloadValue = 17,
    SODataContractViolationDomainCacheNotEnabled = 18,
    SODataContractViolationDomainCacheClosed = 19,
    SODataContractViolationDomainCacheAlreadyOpen = 20,
    SODataContractViolationDomainCachePassiveMode = 21,
    SODataContractViolationDomainUnexpectedError = 999
} SODataContractViolationDomainErrorCodes;
