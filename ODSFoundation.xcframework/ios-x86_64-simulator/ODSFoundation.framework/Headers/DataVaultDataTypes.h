//
//  DataVaultDataTypes.h
//  Datavault
//

#import <Foundation/Foundation.h>

/**
 Enumeration of the various data types utilized by the Data Vault. Each entry saved belongs to one
 of these types.
 */
typedef NS_ENUM(NSInteger, DVDataType) {
    /**
     Unknown data type, effectively binary. Used only by older versions of the Data Vault and as such
     is present only to maintain compatibility.
     */
    kDVDataTypeUnknown,

    /**
     String type.
     */
    kDVDataTypeString,

    /**
     Unstructured binary data.
     */
    kDVDataTypeBinary
};
