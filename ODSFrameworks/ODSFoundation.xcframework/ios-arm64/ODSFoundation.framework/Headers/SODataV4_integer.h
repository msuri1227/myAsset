//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_INTEGER_H
#define SODATAV4_INTEGER_H


@class SODataV4_BigInteger;

#ifndef imported_SODataV4__BigInteger_public
#define imported_SODataV4__BigInteger_public
@interface SODataV4_BigInteger : SODataV4_ObjectBase
{
    @private SODataV4_int _length;
    @private SODataV4_int* _digits;
    @private SODataV4_byte _sign;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return The absolute value of this value (0 for zero, otherwise positive).
///
- (nonnull SODataV4_BigInteger*) abs;
/// @return The sum of this value and another value.
///
- (nonnull SODataV4_BigInteger*) add :(nonnull SODataV4_BigInteger*)p_y;
/// @return This value converted to type `byte'.
///
- (SODataV4_byte) byteValue;
/// @return This value compared to another value (-1 if `this < other`, 0 if `this == other`, 1 if `this > other`).
///
- (SODataV4_int) compareTo :(nonnull SODataV4_BigInteger*)p_y;
- (void) dealloc;
/// @return This value divided by another value.
///
- (nonnull SODataV4_BigInteger*) divide :(nonnull SODataV4_BigInteger*)p_y;
/// @return This value converted to type `double'.
///
- (SODataV4_double) doubleValue;
/// @return `true` if this value is equal to another value.
///
- (SODataV4_boolean) equalTo :(nonnull SODataV4_BigInteger*)y;
/// @return This value converted to type `float'.
///
- (SODataV4_float) floatValue;
/// @return `value` converted from type `byte`.
/// @param value Byte value.
+ (nonnull SODataV4_BigInteger*) fromByte :(SODataV4_byte)value;
/// @return `value` converted from type `double`.
/// @param value Double value.
+ (nonnull SODataV4_BigInteger*) fromDouble :(SODataV4_double)value;
/// @return `value` converted from type `float`.
/// @param value Float value.
+ (nonnull SODataV4_BigInteger*) fromFloat :(SODataV4_float)value;
/// @return `value` converted from type `int`.
/// @param value Int value.
+ (nonnull SODataV4_BigInteger*) fromInt :(SODataV4_int)value;
/// @return `value` converted from type `long`.
/// @param value Long value.
+ (nonnull SODataV4_BigInteger*) fromLong :(SODataV4_long)value;
/// @return `value` converted from type `short`.
/// @param value Short value.
+ (nonnull SODataV4_BigInteger*) fromShort :(SODataV4_short)value;
/// @return `true` if this value is greater than or equal to another value.
///
- (SODataV4_boolean) greaterEqual :(nonnull SODataV4_BigInteger*)y;
/// @return `true` if this value is greater than another value.
///
- (SODataV4_boolean) greaterThan :(nonnull SODataV4_BigInteger*)y;
/// @return This value converted to type `int'.
///
- (SODataV4_int) intValue;
/// @return `true` if this value is less than or equal to another value.
///
- (SODataV4_boolean) lessEqual :(nonnull SODataV4_BigInteger*)y;
/// @return `true` if this value is less than another value.
///
- (SODataV4_boolean) lessThan :(nonnull SODataV4_BigInteger*)y;
/// @return This value converted to type `long'.
///
- (SODataV4_long) longValue;
/// @return The product of this value and another value.
///
- (nonnull SODataV4_BigInteger*) multiply :(nonnull SODataV4_BigInteger*)p_y;
/// @return The negation of this value.
///
- (nonnull SODataV4_BigInteger*) negate;
/// @return `true` if this value is not equal to another value.
///
- (SODataV4_boolean) notEqual :(nonnull SODataV4_BigInteger*)y;
/// @return `value` parsed from `text` in XML Schema lexical form, or `nil` if `text` is not in that form.
/// @param text Text string using XML Schema lexical representation for this type.
+ (nullable SODataV4_BigInteger*) parse :(nonnull NSString*)text;
/// @return The remainder of this value divided by another value.
///
- (nonnull SODataV4_BigInteger*) remainder :(nonnull SODataV4_BigInteger*)y;
/// @return This value converted to type `short'.
///
- (SODataV4_short) shortValue;
/// @return The sign of this value (-1 for negative, 0 for zero, 1 for positive).
///
- (SODataV4_int) sign;
/// @return The difference between this value and another value.
///
- (nonnull SODataV4_BigInteger*) subtract :(nonnull SODataV4_BigInteger*)p_y;
/// @return String representation of this value (using XML Schema canonical form).
///
- (nonnull NSString*) toString;
@end
#endif

#ifdef import_SODataV4__BigInteger_private
#ifndef imported_SODataV4__BigInteger_private
#define imported_SODataV4__BigInteger_private
@interface SODataV4_BigInteger (private)
+ (nonnull SODataV4_BigInteger*) new;
+ (nonnull SODataV4_BigInteger*) ONE;
+ (nonnull SODataV4_BigInteger*) TWO;
+ (nonnull SODataV4_BigInteger*) ZERO;
- (SODataV4_int) compareAbs :(nonnull SODataV4_BigInteger*)y;
- (nonnull SODataV4_BigInteger*) copyDigits;
+ (SODataV4_int) digitDiv :(SODataV4_long)x :(SODataV4_long)y;
+ (SODataV4_long) digitMul :(SODataV4_long)x :(SODataV4_long)y;
+ (SODataV4_int) digitRem :(SODataV4_long)x :(SODataV4_long)y;
- (SODataV4_int) getDigit :(SODataV4_int)i;
+ (SODataV4_int) highDigit :(SODataV4_long)x;
- (SODataV4_int) highIndex;
/// @internal
///
- (void) initDigits :(SODataV4_int)min;
- (void) initDigits :(SODataV4_int)min :(SODataV4_int)max;
+ (SODataV4_int) intAbs :(SODataV4_int)x;
+ (SODataV4_int) intMax :(SODataV4_int)x :(SODataV4_int)y;
+ (SODataV4_int) intMin :(SODataV4_int)x :(SODataV4_int)y;
+ (SODataV4_int) lowDigit :(SODataV4_long)x;
+ (nonnull SODataV4_BigInteger*) makeMutable :(SODataV4_int)max :(SODataV4_int)low :(SODataV4_int)sign;
+ (nonnull SODataV4_BigInteger*) makeNumber :(SODataV4_int)low :(SODataV4_int)sign;
/// @internal
///
+ (nonnull SODataV4_BigInteger*) mutableZero;
+ (nonnull SODataV4_BigInteger*) mutableZero :(SODataV4_int)max;
- (SODataV4_boolean) oneDigit;
- (void) setDigit :(SODataV4_int)i :(SODataV4_int)v;
+ (SODataV4_byte) toByte :(SODataV4_int)value;
+ (SODataV4_short) toShort :(SODataV4_int)value;
- (nonnull SODataV4_BigInteger*) withSign :(SODataV4_int)sign;
#define SODataV4_BigInteger_DIGIT_SIZE 6
#define SODataV4_BigInteger_SINGLE_ZERO 0
#define SODataV4_BigInteger_DOUBLE_ZERO SODataV4_LONG(0)
#define SODataV4_BigInteger_SINGLE_BASE 1000000
#define SODataV4_BigInteger_DOUBLE_BASE SODataV4_LONG(1000000000000)
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigInteger* ONE;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigInteger* TWO;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigInteger* ZERO;
@end
#endif
#endif

#endif
