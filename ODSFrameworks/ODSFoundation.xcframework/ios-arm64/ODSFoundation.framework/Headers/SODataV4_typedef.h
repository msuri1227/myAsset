#ifndef SODataV4_TYPEDEF_H
#define SODataV4_TYPEDEF_H

#define SODataV4_in_NSError NSError * _Nullable
#define SODataV4_out_NSError NSError * _Nullable * _Nullable

#import <stdint.h>
#include <pthread.h>

// Use #defines, not typedefs, to avoid XCode debugging issues!

#define SODataV4_boolean BOOL
#define SODataV4_char unichar
#define SODataV4_byte signed char
#define SODataV4_short int16_t
#define SODataV4_int int32_t
#define SODataV4_long int64_t
#define SODataV4_float float
#define SODataV4_double double
#define SODataV4_integer SODataV4_BigInteger*
#define SODataV4_decimal SODataV4_BigDecimal*

@class SODataV4_BigInteger;
@class SODataV4_BigDecimal;

#define SODataV4_ubyte unsigned char
#define SODataV4_ushort uint16_t
#define SODataV4_uint uint32_t
#define SODataV4_ulong uint64_t

#define SODataV4_CHAR(c) ((SODataV4_char)(c))
#define SODataV4_BYTE(value) ((SODataV4_byte)value)
#define SODataV4_SHORT(value) ((SODataV4_short)value)
#define SODataV4_INT(value) ((SODataV4_int)value)
#define SODataV4_LONG(value) value##LL

#define SODataV4_BYTE_MIN ((SODataV4_byte)-128)
#define SODataV4_BYTE_MAX ((sx_byte)127)
#define SODataV4_SHORT_MIN ((SODataV4_short)-32768)
#define SODataV4_SHORT_MAX ((SODataV4_short)32767)
#define SODataV4_INT_MIN ((SODataV4_int)0x80000000)
#define SODataV4_INT_MAX ((SODataV4_int)2147483647)
#define SODataV4_LONG_MIN SODataV4_LONG(0x8000000000000000)
#define SODataV4_LONG_MAX SODataV4_LONG(9223372036854775807)

#define SODataV4_NULLABLE_TYPE(NullableStruct, NullableType, ValueType) \
    struct NullableStruct \
    { \
        SODataV4_boolean isNull; \
        ValueType value; \
    }; \
    typedef struct NullableStruct NullableType

SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_BOOLEAN, SODataV4_nullable_boolean, SODataV4_boolean);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_CHAR, SODataV4_nullable_char, SODataV4_char);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_BYTE, SODataV4_nullable_byte, SODataV4_byte);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_SHORT, SODataV4_nullable_short, SODataV4_short);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_INT, SODataV4_nullable_int, SODataV4_int);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_LONG, SODataV4_nullable_long, SODataV4_long);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_FLOAT, SODataV4_nullable_float, SODataV4_float);
SODataV4_NULLABLE_TYPE(SODataV4_NULLABLE_DOUBLE, SODataV4_nullable_double, SODataV4_double);
#define SODataV4_nullable_integer SODataV4_BigInteger*
#define SODataV4_nullable_decimal SODataV4_BigDecimal*

#define SODataV4_NULL_STRING nil
#define SODataV4_NULL_BINARY nil
#define SODataV4_NULL_BOOLEAN ((SODataV4_nullable_boolean){YES,(SODataV4_boolean)0})
#define SODataV4_NULL_CHAR ((SODataV4_nullable_char){YES,(SODataV4_char)0})
#define SODataV4_NULL_BYTE ((SODataV4_nullable_byte){YES,(SODataV4_byte)0})
#define SODataV4_NULL_SHORT ((SODataV4_nullable_short){YES,(SODataV4_short)0})
#define SODataV4_NULL_INT ((SODataV4_nullable_int){YES,(SODataV4_int)0})
#define SODataV4_NULL_LONG ((SODataV4_nullable_long){YES,(SODataV4_long)0})
#define SODataV4_NULL_FLOAT ((SODataV4_nullable_float){YES,(SODataV4_float)0})
#define SODataV4_NULL_DOUBLE ((SODataV4_nullable_double){YES,(SODataV4_double)0})
#define SODataV4_NULL_INTEGER nil
#define SODataV4_NULL_DECIMAL nil

@interface SODataV4_ObjectBase : NSObject
{
}
- (nonnull NSString*) description;
- (NSUInteger) hash;
- (SODataV4_int) hashCode;
- (nonnull NSString*) toString;
@end

@interface SODataV4_ObjectHashWrapper : NSObject<NSCopying>
{
    @private NSUInteger hash_;
    @private NSString* text_;
    @private NSObject* value_;
}
+ (nonnull SODataV4_ObjectHashWrapper*) new :(nullable NSObject*)value;
- (nonnull id) copyWithZone :(nullable NSZone*)zone;
- (BOOL) isEqual :(nullable id)value;
- (NSUInteger) hash;
- (nullable NSObject*)value;
@property (nullable, readonly, strong) NSObject* value;
@end

#define SODataV4_MALLOC_CHECK(var, type, count) \
    { var = (type*)malloc(count * sizeof(type)); if (var == 0) [SODataV4_OutOfMemory logErrorAndAbort]; }

#endif
