//
//  SODataPayload.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

/**
 Enumeration for the possible kinds of OData payloads.
 */
#ifndef NS_ENUM
#import <Foundation/Foundation.h>
#endif
typedef NS_ENUM(unsigned int, SODataTypes)  {
    SODataTypeNone,
    SODataTypeRaw,
    SODataTypeProperty,
    SODataTypeEntity,
    SODataTypeEntitySet,
    SODataTypeLink,
    SODataTypeLinkList,
    SODataTypeUploadMedia,
    SODataTypeMetadata,
    SODataTypeError,
    SODataTypeBatchResponse
};

/**
 Marker interface for all kinds of payloads that can be sent over the wire. The specific payload types are described by the nested ODataPayload.Type enumeration. The library supports only the specified 
 payload types and the corresponding provided implementations.
 */
@protocol SODataPayload <NSObject, NSCoding>

@end
