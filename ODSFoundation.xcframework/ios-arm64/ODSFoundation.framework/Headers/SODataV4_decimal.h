//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_DECIMAL_H
#define SODATAV4_DECIMAL_H


@class SODataV4_BigDecimal;

#ifndef imported_SODataV4__BigDecimal_public
#define imported_SODataV4__BigDecimal_public
@interface SODataV4_BigDecimal : SODataV4_ObjectBase
{
    @private SODataV4_int _length;
    @private SODataV4_int* _digits;
    @private SODataV4_byte _sign;
    @private SODataV4_short _scale;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return The absolute value of this value (0 for zero, otherwise positive).
///
- (nonnull SODataV4_BigDecimal*) abs;
/// @return The sum of this value and another value.
///
- (nonnull SODataV4_BigDecimal*) add :(nonnull SODataV4_BigDecimal*)p_y;
/// @return This value converted to type `byte'.
///
- (SODataV4_byte) byteValue;
/// @return This value rounded up to the nearest integer value.
///
- (nonnull SODataV4_BigDecimal*) ceiling;
/// @return This value compared to another value (-1 if `this < other`, 0 if `this == other`, 1 if `this > other`).
///
- (SODataV4_int) compareTo :(nonnull SODataV4_BigDecimal*)p_y;
- (void) dealloc;
/// @return This value divided by another value.
///
- (nonnull SODataV4_BigDecimal*) divide :(nonnull SODataV4_BigDecimal*)p_y;
/// @return This value converted to type `double'.
///
- (SODataV4_double) doubleValue;
/// @return `true` if this value is equal to another value.
///
- (SODataV4_boolean) equalTo :(nonnull SODataV4_BigDecimal*)y;
/// @return This value converted to type `float'.
///
- (SODataV4_float) floatValue;
/// @return This value rounded down to the nearest integer value.
///
- (nonnull SODataV4_BigDecimal*) floor;
/// @return `value` converted from type `byte`.
/// @param value Byte value.
+ (nonnull SODataV4_BigDecimal*) fromByte :(SODataV4_byte)value;
/// @return `value` converted from type `double`.
/// @param value Double value.
+ (nonnull SODataV4_BigDecimal*) fromDouble :(SODataV4_double)value;
/// @return `value` converted from type `float`.
/// @param value Float value.
+ (nonnull SODataV4_BigDecimal*) fromFloat :(SODataV4_float)value;
/// @return `value` converted from type `int`.
/// @param value Int value.
+ (nonnull SODataV4_BigDecimal*) fromInt :(SODataV4_int)value;
/// @return `value` converted from type `long`.
/// @param value Long value.
+ (nonnull SODataV4_BigDecimal*) fromLong :(SODataV4_long)value;
/// @return `value` converted from type `short`.
/// @param value Short value.
+ (nonnull SODataV4_BigDecimal*) fromShort :(SODataV4_short)value;
/// @return `true` if this value is greater than or equal to another value.
///
- (SODataV4_boolean) greaterEqual :(nonnull SODataV4_BigDecimal*)y;
/// @return `true` if this value is greater than another value.
///
- (SODataV4_boolean) greaterThan :(nonnull SODataV4_BigDecimal*)y;
/// @return This value converted to type `int'.
///
- (SODataV4_int) intValue;
/// @return `true` if this value is less than or equal to another value.
///
- (SODataV4_boolean) lessEqual :(nonnull SODataV4_BigDecimal*)y;
/// @return `true` if this value is less than another value.
///
- (SODataV4_boolean) lessThan :(nonnull SODataV4_BigDecimal*)y;
/// @return This value converted to type `long'.
///
- (SODataV4_long) longValue;
/// @return The product of this value and another value.
///
- (nonnull SODataV4_BigDecimal*) multiply :(nonnull SODataV4_BigDecimal*)p_y;
/// @return The negation of this value.
///
- (nonnull SODataV4_BigDecimal*) negate;
/// @return `true` if this value is not equal to another value.
///
- (SODataV4_boolean) notEqual :(nonnull SODataV4_BigDecimal*)y;
/// @return `value` parsed from `text` in XML Schema lexical form, or `nil` if `text` is not in that form.
/// @param text Text string using XML Schema lexical representation for this type.
+ (nullable SODataV4_BigDecimal*) parse :(nonnull NSString*)text;
/// @return The remainder of this value divided by another value.
///
- (nonnull SODataV4_BigDecimal*) remainder :(nonnull SODataV4_BigDecimal*)y;
/// @internal
///
- (nonnull SODataV4_BigDecimal*) round;
/// @return This value rounded to the specified scale (number of digits to the right of the decimnal point).
///
- (nonnull SODataV4_BigDecimal*) round :(SODataV4_int)scale;
/// @return The scale of this value (number of places to the right of the decimal point).
///
- (SODataV4_int) scale;
/// @return This value converted to type `short'.
///
- (SODataV4_short) shortValue;
/// @return The sign of this value (-1 for negative, 0 for zero, 1 for positive).
///
- (SODataV4_int) sign;
/// @return The difference between this value and another value.
///
- (nonnull SODataV4_BigDecimal*) subtract :(nonnull SODataV4_BigDecimal*)p_y;
/// @return String representation of this value (using XML Schema canonical form).
///
- (nonnull NSString*) toString;
/// @return This value with fraction truncated.
///
- (nonnull SODataV4_BigDecimal*) truncate;
#define SODataV4_BigDecimal_ROUND_NONE 0
#define SODataV4_BigDecimal_ROUND_DOWN 1
#define SODataV4_BigDecimal_ROUND_EVEN 2
#define SODataV4_BigDecimal_ROUND_UP 3
@end
#endif

#ifdef import_SODataV4__BigDecimal_private
#ifndef imported_SODataV4__BigDecimal_private
#define imported_SODataV4__BigDecimal_private
@interface SODataV4_BigDecimal (private)
+ (nonnull SODataV4_BigDecimal*) new;
+ (nonnull SODataV4_BigDecimal*) DEC_10;
+ (nonnull SODataV4_BigDecimal*) DEC_100;
+ (nonnull SODataV4_BigDecimal*) DEC_1000;
+ (nonnull SODataV4_BigDecimal*) DEC_10000;
+ (nonnull SODataV4_BigDecimal*) DEC_100000;
+ (nonnull SODataV4_BigDecimal*) ONE;
+ (nonnull SODataV4_BigDecimal*) TWO;
+ (nonnull SODataV4_BigDecimal*) ZERO;
- (SODataV4_int) compareAbs :(nonnull SODataV4_BigDecimal*)y;
- (nonnull SODataV4_BigDecimal*) copyDigits;
+ (SODataV4_int) digitDiv :(SODataV4_long)x :(SODataV4_long)y;
+ (SODataV4_long) digitMul :(SODataV4_long)x :(SODataV4_long)y;
+ (SODataV4_int) digitRem :(SODataV4_long)x :(SODataV4_long)y;
- (SODataV4_int) getDigit :(SODataV4_int)i;
+ (SODataV4_int) highDigit :(SODataV4_long)x;
- (SODataV4_int) highIndex;
+ (SODataV4_int) indexOf :(nonnull NSString*)value :(nonnull NSString*)find;
/// @internal
///
- (void) initDigits :(SODataV4_int)min;
- (void) initDigits :(SODataV4_int)min :(SODataV4_int)max;
+ (SODataV4_int) intAbs :(SODataV4_int)x;
+ (SODataV4_int) intMax :(SODataV4_int)x :(SODataV4_int)y;
+ (SODataV4_int) intMin :(SODataV4_int)x :(SODataV4_int)y;
+ (SODataV4_int) lowDigit :(SODataV4_long)x;
+ (nonnull SODataV4_BigDecimal*) makeMutable :(SODataV4_int)max :(SODataV4_int)low :(SODataV4_int)sign :(SODataV4_int)scale;
+ (nonnull SODataV4_BigDecimal*) makeNumber :(SODataV4_int)low :(SODataV4_int)sign :(SODataV4_int)scale;
/// @internal
///
+ (nonnull SODataV4_BigDecimal*) mutableZero;
+ (nonnull SODataV4_BigDecimal*) mutableZero :(SODataV4_int)max;
- (SODataV4_boolean) oneDigit;
- (void) setDigit :(SODataV4_int)i :(SODataV4_int)v;
- (nonnull SODataV4_BigDecimal*) signScale :(SODataV4_int)sign :(SODataV4_int)scale;
+ (nonnull NSString*) slice :(nonnull NSString*)value :(SODataV4_int)start :(SODataV4_int)end;
+ (SODataV4_byte) toByte :(SODataV4_int)value;
+ (SODataV4_short) toShort :(SODataV4_int)value;
- (nonnull SODataV4_BigDecimal*) withScale :(SODataV4_int)scale :(SODataV4_int)p_mode;
- (nonnull SODataV4_BigDecimal*) withSign :(SODataV4_int)sign;
#define SODataV4_BigDecimal_DIGIT_SIZE 6
#define SODataV4_BigDecimal_SINGLE_ZERO 0
#define SODataV4_BigDecimal_DOUBLE_ZERO SODataV4_LONG(0)
#define SODataV4_BigDecimal_SINGLE_BASE 1000000
#define SODataV4_BigDecimal_DOUBLE_BASE SODataV4_LONG(1000000000000)
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* DEC_10;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* DEC_100;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* DEC_1000;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* DEC_10000;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* DEC_100000;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* ONE;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* TWO;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_BigDecimal* ZERO;
@end
#endif
#endif

#endif
