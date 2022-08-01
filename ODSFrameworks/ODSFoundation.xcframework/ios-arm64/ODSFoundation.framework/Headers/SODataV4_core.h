//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_CORE_H
#define SODATAV4_CORE_H


@class SODataV4_AnyAsObject;
@class SODataV4_AnyIsObject;
@class SODataV4_Assert;
@class SODataV4_AtomicBoolean; /* internal */
@class SODataV4_AtomicInt; /* internal */
@class SODataV4_Base16Binary;
@class SODataV4_Base64Binary;
@class SODataV4_BinaryConstant;
@class SODataV4_BinaryDefault; /* internal */
@class SODataV4_BinaryFunction;
@class SODataV4_BinaryOperator;
@class SODataV4_BlockingQueue; /* internal */
@class SODataV4_BooleanArray;
@class SODataV4_BooleanDefault; /* internal */
@class SODataV4_BooleanFunction;
@class SODataV4_BooleanOperator;
@class SODataV4_ByteBuffer;
@class SODataV4_ByteConstant;
@class SODataV4_ByteDefault; /* internal */
@class SODataV4_ByteFunction;
@class SODataV4_ByteMath; /* internal */
@class SODataV4_ByteOperator;
@class SODataV4_CharBuffer;
@class SODataV4_CharDefault; /* internal */
@class SODataV4_CharFunction;
@class SODataV4_CharOperator;
@class SODataV4_CheckProperty;
@class SODataV4_ClassName; /* internal */
@class SODataV4_Comparer;
@class SODataV4_ConditionVariable; /* internal */
@class SODataV4_CountingSemaphore; /* internal */
@class SODataV4_CurrentProcess; /* internal */
@class SODataV4_CurrentThread; /* internal */
@class SODataV4_DebugConsole;
@class SODataV4_DebugConsole_FlushThread; /* internal */
@class SODataV4_DebugWriter; /* internal */
@class SODataV4_DecimalConstant;
@class SODataV4_DecimalDefault; /* internal */
@class SODataV4_DecimalFunction;
@class SODataV4_DecimalMath; /* internal */
@class SODataV4_DecimalOperator;
@class SODataV4_DoubleConstant;
@class SODataV4_DoubleDefault; /* internal */
@class SODataV4_DoubleFunction;
@class SODataV4_DoubleMath; /* internal */
@class SODataV4_DoubleOperator;
@class SODataV4_Equality;
@class SODataV4_ErrorFunction;
@class SODataV4_FloatConstant;
@class SODataV4_FloatDefault; /* internal */
@class SODataV4_FloatFunction;
@class SODataV4_FloatMath; /* internal */
@class SODataV4_FloatOperator;
@class SODataV4_GUID;
@class SODataV4_Ignore;
@class SODataV4_IntConstant;
@class SODataV4_IntDefault; /* internal */
@class SODataV4_IntFunction;
@class SODataV4_IntMath; /* internal */
@class SODataV4_IntOperator;
@class SODataV4_IntegerConstant;
@class SODataV4_IntegerDefault; /* internal */
@class SODataV4_IntegerFunction;
@class SODataV4_IntegerMath; /* internal */
@class SODataV4_IntegerOperator;
@class SODataV4_Logger;
@class SODataV4_LoggerFactory;
@class SODataV4_LongConstant;
@class SODataV4_LongDefault; /* internal */
@class SODataV4_LongFunction;
@class SODataV4_LongMath; /* internal */
@class SODataV4_LongOperator;
@class SODataV4_MapIteratorFromObject;
@class SODataV4_MapIteratorFromString;
@class SODataV4_MutableBoolean; /* internal */
@class SODataV4_MutableInt; /* internal */
@class SODataV4_MutableLong; /* internal */
@class SODataV4_NullableBinary;
@class SODataV4_NullableBoolean;
@class SODataV4_NullableByte;
@class SODataV4_NullableChar;
@class SODataV4_NullableDecimal;
@class SODataV4_NullableDouble;
@class SODataV4_NullableFloat;
@class SODataV4_NullableInt;
@class SODataV4_NullableInteger;
@class SODataV4_NullableLong;
@class SODataV4_NullableObject;
@class SODataV4_NullableShort;
@class SODataV4_NullableString;
@class SODataV4_NumberParser; /* internal */
@class SODataV4_ObjectAsAny;
@class SODataV4_ObjectFactory;
@class SODataV4_ObjectFunction;
@class SODataV4_ObjectIsAny;
@class SODataV4_ObjectOperator;
@class SODataV4_OutOfMemory; /* internal */
@class SODataV4_PearsonHashing; /* internal */
@class SODataV4_ReentrantMutex; /* internal */
@class SODataV4_RunAction; /* internal */
@class SODataV4_RunFunction; /* internal */
@class SODataV4_SchemaFormat; /* internal */
@class SODataV4_ShortConstant;
@class SODataV4_ShortDefault; /* internal */
@class SODataV4_ShortFunction;
@class SODataV4_ShortMath; /* internal */
@class SODataV4_ShortOperator;
@class SODataV4_StringComparer;
@class SODataV4_StringConstant;
@class SODataV4_StringDefault; /* internal */
@class SODataV4_StringEquality;
@class SODataV4_StringFunction;
@class SODataV4_StringOperator;
@class SODataV4_SystemClock; /* internal */
@class SODataV4_SystemConsole; /* internal */
@class SODataV4_SystemError; /* internal */
@class SODataV4_SystemProcess; /* internal */
@class SODataV4_ThreadLocal;
@class SODataV4_ThreadSleep;
@class SODataV4_ThreadStart;
@class SODataV4_UTF16; /* internal */
@class SODataV4_UTF8; /* internal */
@class SODataV4_UnicodeClass; /* internal */
@class SODataV4_UntypedList;
@class SODataV4_UntypedMap;
@class SODataV4_UntypedSet;
@class SODataV4_EmptyList;
@class SODataV4_EmptySet;
@class SODataV4_ExceptionBase;
@class SODataV4_InstanceLogger; /* internal */
@class SODataV4_LogToConsole; /* internal */
@class SODataV4_MapFromObject;
@class SODataV4_MapFromString;
@class SODataV4_StringComparerIgnoreCase; /* internal */
@class SODataV4_StringEqualityIgnoreCase; /* internal */
@class SODataV4_UndefinedComparer; /* internal */
@class SODataV4_UndefinedEquality; /* internal */
@class SODataV4_EmptyMapFromObject;
@class SODataV4_EmptyMapFromString;
@class SODataV4_FatalException;
@class SODataV4_StackDumpException; /* internal */
@class SODataV4_UTF8Exception; /* internal */
@class SODataV4_AbstractFunctionException; /* internal */
@class SODataV4_AbstractPropertyException; /* internal */
@class SODataV4_AssertException;
@class SODataV4_BinaryIndexException; /* internal */
@class SODataV4_CastException;
@class SODataV4_EmptyListException;
@class SODataV4_FormatException; /* internal */
@class SODataV4_ImmutableException; /* internal */
@class SODataV4_InfinityException; /* internal */
@class SODataV4_ListIndexException;
@class SODataV4_MissingEntryException;
@class SODataV4_NotImplementedException; /* internal */
@class SODataV4_NotUniqueException;
@class SODataV4_NullValueException; /* internal */
@class SODataV4_OverflowException; /* internal */
@class SODataV4_UndefinedException;
@class SODataV4_UnexpectedException; /* internal */
@class SODataV4_UsageException; /* internal */
@class SODataV4_VersionMismatchException; /* internal */

#ifndef imported_SODataV4__AnyAsObject_public
#define imported_SODataV4__AnyAsObject_public
/// @internal
///
@interface SODataV4_AnyAsObject : SODataV4_ObjectBase
{
}
+ (nonnull NSObject*) cast :(nullable NSObject*)value;
@end
#endif

#ifndef imported_SODataV4__AnyIsObject_public
#define imported_SODataV4__AnyIsObject_public
/// @internal
///
@interface SODataV4_AnyIsObject : SODataV4_ObjectBase
{
}
+ (SODataV4_boolean) check :(nullable NSObject*)value;
@end
#endif

#ifndef imported_SODataV4__Assert_public
#define imported_SODataV4__Assert_public
/// @internal
///
@interface SODataV4_Assert : SODataV4_ObjectBase
{
}
/// @internal
///
+ (void) error :(nonnull NSString*)message;
/// @brief Log and throw an `SODataV4_AssertException`, with the specified `message`.
///
///
/// @param message Assertion message (e.g. source file and line number).
/// @param cause Optional cause of the assertion failure.
+ (void) error :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log and throw an `SODataV4_AssertException`, if `condition` is not `true`.
///
///
/// @param condition Condition which must be `false` to avoid an assertion failure.
/// @param message Assertion message (e.g. source file and line number).
/// @see `SODataV4_Assert`.`error`.
+ (void) isFalse :(SODataV4_boolean)condition :(nonnull NSString*)message;
/// @brief Log and throw an `SODataV4_AssertException`, if `condition` is not `true`.
///
///
/// @param condition Condition which must be `true` to avoid an assertion failure.
/// @param message Assertion message (e.g. source file and line number).
/// @see `SODataV4_Assert`.`error`.
+ (void) isTrue :(SODataV4_boolean)condition :(nonnull NSString*)message;
/// @brief Execute `action()` and throw an `SODataV4_AssertException`, if `action()` did not itself throw an exception, or threw an exception that does not match the `check`.
///
///
/// @param action Action to be executed, which is expected to throw an exception.
/// @param check Validation check for the expected exception. Should return `true` if the exception has the expected form.
/// @param message Assertion message (e.g. source file and line number).
/// @see `SODataV4_Assert`.`error`.
+ (void) mustThrow :(void(^ _Nonnull)(void))action :(SODataV4_boolean(^ _Nonnull)(NSException* _Nonnull))check :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__AtomicBoolean_internal
#ifndef imported_SODataV4__AtomicBoolean_internal
#define imported_SODataV4__AtomicBoolean_public
/* internal */
/// @brief An atomic (thread-safe, mutable) `ValueType` value.
///
///
@interface SODataV4_AtomicBoolean : SODataV4_ObjectBase
{
    @private SODataV4_boolean value;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AtomicBoolean*) new;
/// @internal
///
- (void) _init;
/// @brief Change the current value if it matches an expected value. Otherwise leave the value unchanged.
///
///
/// @return `true` if the value was changed, `false` otherwise.
/// @param expect Expected value.
/// @param update New value.
- (SODataV4_boolean) compareAndSet :(SODataV4_boolean)expect :(SODataV4_boolean)update;
/// @return The current value.
///
- (SODataV4_boolean) get;
/// @brief Get and set the current value.
///
///
/// @return The previous value.
/// @param newValue New value.
- (SODataV4_boolean) getAndSet :(SODataV4_boolean)newValue;
/// @brief Set the current value.
///
///
/// @param newValue New value.
- (void) set :(SODataV4_boolean)newValue;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
@end
#endif
#endif

#ifdef import_SODataV4__AtomicInt_internal
#ifndef imported_SODataV4__AtomicInt_internal
#define imported_SODataV4__AtomicInt_public
/* internal */
/// @brief An atomic (thread-safe, mutable) `ValueType` value.
///
///
@interface SODataV4_AtomicInt : SODataV4_ObjectBase
{
    @private SODataV4_int value;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AtomicInt*) new;
/// @internal
///
- (void) _init;
/// @brief Change the current value if it matches an expected value. Otherwise leave the value unchanged.
///
///
/// @return `true` if the value was changed, `false` otherwise.
/// @param expect Expected value.
/// @param update New value.
- (SODataV4_boolean) compareAndSet :(SODataV4_int)expect :(SODataV4_int)update;
/// @return The current value.
///
- (SODataV4_int) get;
/// @brief Get and set the current value.
///
///
/// @return The previous value.
/// @param newValue New value.
- (SODataV4_int) getAndSet :(SODataV4_int)newValue;
/// @brief Set the current value.
///
///
/// @param newValue New value.
- (void) set :(SODataV4_int)newValue;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
@end
#endif
#endif

#ifndef imported_SODataV4__Base16Binary_public
#define imported_SODataV4__Base16Binary_public
/// @internal
///
@interface SODataV4_Base16Binary : SODataV4_ObjectBase
{
}
/// @brief Parse base-16 encoded binary value.
///
///
/// @throw `SODataV4_FormatException` (fatal) if the text has invalid base-16 format.
/// @param text Base-16 encoded binary data.
+ (nonnull NSData*) convert :(nonnull NSString*)text;
/// @return `data` encoded in base-16 binary format.
/// @param data Binary value.
+ (nonnull NSString*) format :(nonnull NSData*)data;
/// @internal
///
+ (SODataV4_int) getCharAsInt :(SODataV4_char)c;
/// @internal
///
+ (SODataV4_char) getIntAsChar :(SODataV4_int)i;
/// @brief Parse base-16 encoded binary value.
///
///
/// @return Binary value, or `null' if `text` has an incorrect format.
/// @param text Base-16 encoded binary data.
+ (nullable NSData*) parse :(nonnull NSString*)text;
@end
#endif

#ifndef imported_SODataV4__Base64Binary_public
#define imported_SODataV4__Base64Binary_public
/// @internal
///
@interface SODataV4_Base64Binary : SODataV4_ObjectBase
{
}
/// @brief Parse base-64 encoded binary value.
///
///
/// @throw `SODataV4_FormatException` (fatal) if the text has invalid base-64 format.
/// @param text Base-64 encoded binary data.
+ (nonnull NSData*) convert :(nonnull NSString*)text;
/// @return `data` encoded in base-64 binary format.
/// @param data Binary value.
+ (nonnull NSString*) format :(nonnull NSData*)data;
/// @return `data` encoded in base-64 binary format, with optional padding and optional URL-safe alphabet.
/// @param data Binary value.
/// @param pad `true` if the encoded data must be padded with '=' characters (see [padding](https://en.wikipedia.org/wiki/Base64#Padding)).
/// @param safe `true` if the encoded data must use a [URL-safe alphabet](https://tools.ietf.org/html/rfc4648#page-7).
+ (nonnull NSString*) formatPadSafe :(nonnull NSData*)data :(SODataV4_boolean)pad :(SODataV4_boolean)safe;
/// @internal
///
+ (SODataV4_int) getCharAsInt :(SODataV4_char)c;
/// @internal
///
+ (SODataV4_char) getIntAsChar :(SODataV4_int)i :(SODataV4_boolean)safe;
/// @brief Parse base-64 encoded binary value.
///
///
/// @return Binary value, or `null' if `text` has an incorrect format.
/// @param text Base-64 encoded binary data.
+ (nullable NSData*) parse :(nonnull NSString*)text;
@end
#endif

#ifndef imported_SODataV4__BinaryConstant_public
#define imported_SODataV4__BinaryConstant_public
/// @internal
///
@interface SODataV4_BinaryConstant : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (nonnull NSData*) empty;
@end
#define SODataV4_BinaryConstant_empty [SODataV4_BinaryConstant empty]
#endif

#ifdef import_SODataV4__BinaryDefault_internal
#ifndef imported_SODataV4__BinaryDefault_internal
#define imported_SODataV4__BinaryDefault_public
/* internal */
/// @brief Static functions to apply default values of type `binary`.
///
///
@interface SODataV4_BinaryDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return empty string.
/// @param value Nullable value.
+ (nonnull NSData*) emptyIfNull :(nullable NSData*)value;
/// @return `value` if it is not `nil` or empty, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull NSData*) ifEmpty :(nullable NSData*)value :(nonnull NSData*)defaultValue;
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull NSData*) ifNull :(nullable NSData*)value :(nonnull NSData*)defaultValue;
/// @return `nil` if `value` is `nil` or empty, otherwise return `value`.
/// @param value Nullable value.
+ (nullable NSData*) nullIfEmpty :(nullable NSData*)value;
@end
#endif
#endif

#ifndef imported_SODataV4__BinaryFunction_public
#define imported_SODataV4__BinaryFunction_public
/// @internal
///
@interface SODataV4_BinaryFunction : SODataV4_ObjectBase
{
}
/// @return The byte at `index` in `value`.
/// @param value Source value.
/// @param index Zero-based index.
+ (SODataV4_byte) byteAt :(nonnull NSData*)value :(SODataV4_int)index;
/// @brief Compare binary `value` with `other` binary value.
///
///
/// @return Negative result if `value < other`, zero result if `value == other`, positive result if `value > other`.
/// @param value Source value.
/// @param other Other string value for comparison.
+ (SODataV4_int) compareTo :(nonnull NSData*)value :(nonnull NSData*)other;
/// @return A hash code for `value`.
/// @param value Source value.
/// @see `SODataV4_PearsonHashing`.
+ (SODataV4_int) hashCode :(nonnull NSData*)value;
/// @internal
///
+ (SODataV4_int) indexOf :(nonnull NSData*)value :(nonnull NSData*)find;
/// @brief Locates `find` within `value`, searching forwards from `start`.
///
///
/// @return Zero-based index where `text` is found within `value`, or -1 if not found.
/// @param value Source value.
/// @param find Text to be located.
/// @param start Optional start position (defaults to 0).
/// @see JavaScript [String.prototype.indexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf).
+ (SODataV4_int) indexOf :(nonnull NSData*)value :(nonnull NSData*)find :(SODataV4_int)start;
/// @internal
///
+ (nonnull NSData*) slice :(nonnull NSData*)value :(SODataV4_int)start;
/// @return A section of `value` beginning at `start`, through to `end`. Allows negative values for `start` / `end` to specify end-relative positions.
/// @param value Source value.
/// @param start The zero-based index at which to begin extraction from the source value. If negative, it is treated as `value.length + start`.
/// @param end Optional. The zero-based index at which to end extraction from the source value. If omitted, `slice` extracts to the end of the value. If negative, it is treated as `value.length + end`.
+ (nonnull NSData*) slice :(nonnull NSData*)value :(SODataV4_int)start :(SODataV4_int)end;
/// @return A string value with simple (numeric value) mapping of source bytes to target Unicode character values. Use only when character values are limited to [ISO-8859-1](https://en.wikipedia.org/wiki/ISO/IEC_8859-1) (the first 256 code points of Unicode).
/// @param value Source value.
/// @see `SODataV4_UTF8`.`toString`.
+ (nonnull NSString*) toString :(nonnull NSData*)value;
@end
#endif

#ifndef imported_SODataV4__BinaryOperator_public
#define imported_SODataV4__BinaryOperator_public
/// @internal
///
@interface SODataV4_BinaryOperator : SODataV4_ObjectBase
{
}
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(nonnull NSData*)left :(nonnull NSData*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nonnull NSData*)left :(nonnull NSData*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(nonnull NSData*)left :(nonnull NSData*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(nonnull NSData*)left :(nonnull NSData*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(nonnull NSData*)left :(nonnull NSData*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(nonnull NSData*)left :(nonnull NSData*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nonnull NSData*)left :(nonnull NSData*)right;
@end
#endif

#ifdef import_SODataV4__BlockingQueue_internal
#ifndef imported_SODataV4__BlockingQueue_internal
#define imported_SODataV4__BlockingQueue_public
/* internal */
/// @brief A thread-safe blocking queue.
///
///
@interface SODataV4_BlockingQueue : SODataV4_ObjectBase
{
    @private SODataV4_UntypedList* _Nonnull queue_;
    @private SODataV4_int getIndex;
    @private SODataV4_int putIndex;
    @private SODataV4_int maxCount;
    @private SODataV4_int count;
    @private SODataV4_ReentrantMutex* _Nonnull mutex_;
    @private SODataV4_ConditionVariable* _Nonnull notEmpty_;
    @private SODataV4_ConditionVariable* _Nonnull notFull_;
}
- (nonnull id) init;
/// @brief Construct a new queue with the specified maximum number of items.
///
///
+ (nonnull SODataV4_BlockingQueue*) new;
/// @brief Construct a new queue with the specified maximum number of items.
///
///
/// @param size (optional) Maximum number of items. Defaults to 16.
+ (nonnull SODataV4_BlockingQueue*) new :(SODataV4_int)size;
/// @internal
///
- (void) _init :(SODataV4_int)size;
/// @brief Remove an item from the start of the queue, blocking the current thread while the queue is empty.
///
///
/// @return Item that was removed.
- (nullable NSObject*) dequeue;
/// @brief Add an item to the end of the queue, blocking the current thread while the queue is full.
///
///
/// @param item Item to be added.
- (void) enqueue :(nullable NSObject*)item;
@end
#endif
#endif

#ifdef import_SODataV4__BlockingQueue_private
#ifndef imported_SODataV4__BlockingQueue_private
#define imported_SODataV4__BlockingQueue_private
@interface SODataV4_BlockingQueue (private)
- (nonnull SODataV4_ReentrantMutex*) mutex;
- (nonnull SODataV4_ConditionVariable*) notEmpty;
- (nonnull SODataV4_ConditionVariable*) notFull;
- (nonnull SODataV4_UntypedList*) queue;
- (void) setMutex :(nonnull SODataV4_ReentrantMutex*)value;
- (void) setNotEmpty :(nonnull SODataV4_ConditionVariable*)value;
- (void) setNotFull :(nonnull SODataV4_ConditionVariable*)value;
- (void) setQueue :(nonnull SODataV4_UntypedList*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ReentrantMutex* mutex;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ConditionVariable* notEmpty;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ConditionVariable* notFull;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_UntypedList* queue;
@end
#endif
#endif

#ifndef imported_SODataV4__BooleanArray_public
#define imported_SODataV4__BooleanArray_public
/// @internal
///
@interface SODataV4_BooleanArray : SODataV4_ObjectBase
{
    @private SODataV4_boolean* _buffer;
    @private SODataV4_int _length;
}
- (nonnull id) init;
/// @brief Construct a new array with a specified `size`. Array items will be initially `false`.
///
///
/// @param size Array length.
+ (nonnull SODataV4_BooleanArray*) new :(SODataV4_int)size;
/// @internal
///
- (void) _init :(SODataV4_int)size;
- (void) dealloc;
/// @return The element of this array at `index`.
/// @param index Zero-based index.
- (SODataV4_boolean) get :(SODataV4_int)index;
/// @brief Length of the array.
///
///
- (SODataV4_int) length;
/// @brief Set the element of this buffer at `index`.
///
///
/// @param index Zero-based index.
/// @param value Element value.
- (void) set :(SODataV4_int)index :(SODataV4_boolean)value;
/// @brief Length of the array.
///
///
@property (nonatomic, readonly) SODataV4_int length;
@end
#endif

#ifdef import_SODataV4__BooleanArray_private
#ifndef imported_SODataV4__BooleanArray_private
#define imported_SODataV4__BooleanArray_private
@interface SODataV4_BooleanArray (private)
- (void) checkIndex :(SODataV4_int)index;
@end
#endif
#endif

#ifdef import_SODataV4__BooleanDefault_internal
#ifndef imported_SODataV4__BooleanDefault_internal
#define imported_SODataV4__BooleanDefault_public
/* internal */
/// @brief Static functions to apply default values of type `boolean`.
///
///
@interface SODataV4_BooleanDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `false`.
/// @param value Nullable value.
+ (SODataV4_boolean) falseIfNull :(SODataV4_nullable_boolean)value;
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_boolean) ifNull :(SODataV4_nullable_boolean)value :(SODataV4_boolean)defaultValue;
/// @return `value` if it is not `nil`, otherwise return `false`.
/// @param value Nullable value.
+ (SODataV4_boolean) trueIfNull :(SODataV4_nullable_boolean)value;
@end
#endif
#endif

#ifndef imported_SODataV4__BooleanFunction_public
#define imported_SODataV4__BooleanFunction_public
/// @internal
///
@interface SODataV4_BooleanFunction : SODataV4_ObjectBase
{
}
/// @return `value` converted to string ("true" or "false").
/// @param value Source value.
+ (nonnull NSString*) toString :(SODataV4_boolean)value;
@end
#endif

#ifndef imported_SODataV4__BooleanOperator_public
#define imported_SODataV4__BooleanOperator_public
/// @internal
///
@interface SODataV4_BooleanOperator : SODataV4_ObjectBase
{
}
/// @brief Compare `left` operand with `right` operand. For the purpose of comparison, `false` < `true`.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_boolean)left :(SODataV4_boolean)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_boolean)left :(SODataV4_boolean)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_boolean)left :(SODataV4_boolean)right;
@end
#endif

#ifndef imported_SODataV4__ByteBuffer_public
#define imported_SODataV4__ByteBuffer_public
/// @internal
///
@interface SODataV4_ByteBuffer : SODataV4_ObjectBase
{
    @private SODataV4_byte* _buffer;
    @private SODataV4_int _capacity;
    @private SODataV4_int _length;
}
- (nonnull SODataV4_byte*) pointer;
- (nonnull id) init;
/// @brief Construct a new buffer with a `SODataV4_ByteBuffer`.`length` of zero and specified initial `capacity`.
///
/// A buffer can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the buffer's maximum length.
+ (nonnull SODataV4_ByteBuffer*) new;
/// @brief Construct a new buffer with a `SODataV4_ByteBuffer`.`length` of zero and specified initial `capacity`.
///
/// A buffer can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the buffer's maximum length.
///
/// @param capacity (optional) Initial capacity. Defaults to 16.
+ (nonnull SODataV4_ByteBuffer*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add a byte to the end of this buffer.
///
///
/// @param value Byte value to be added.
- (void) add :(SODataV4_byte)value;
/// @brief Append a binary value to the end of this buffer.
///
///
/// @param data Binary value. If `nil`, then "null" is appended to the buffer.
- (void) append :(nullable NSData*)data;
/// @brief Set `SODataV4_ByteBuffer`.`length` to zero.
///
///
- (void) clear;
- (void) dealloc;
/// @return The byte of this buffer at `index`.
/// @throw An exception if the index is out of range `0 .. this.length - 1`.
/// @param index Zero-based index.
- (SODataV4_byte) get :(SODataV4_int)index;
/// @return A range of bytes from this buffer.
/// @throw An exception if `start` or `end` is out of range `0 .. this.length`.
/// @param start Zero-based starting index (inclusive).
/// @param end Zero-based ending index (exclusive).
- (nonnull NSData*) getRange :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Length of the buffer (the number of bytes that will appear in `this.toBinary()`.
///
///
- (SODataV4_int) length;
/// @brief reverse the bytes of this buffer.
///
///
- (void) reverse;
/// @brief Set the byte of this buffer at `index`.
///
///
/// @throw An exception if `index` is out of range `0 .. this.length - 1`.
/// @param index Zero-based index.
/// @param value Byte value.
- (void) set :(SODataV4_int)index :(SODataV4_byte)value;
/// @brief Length of the buffer (the number of bytes that will appear in `this.toBinary()`.
///
///
- (void) setLength :(SODataV4_int)value;
/// @brief Copy a range of bytes from a binary value into this buffer, starting at `index`.
///
///
/// @throw An exception if `index` is out of range `0 .. this.length - 1` or `index + value.length` is out of range `0 .. this.length`.
/// @param index Zero-based starting index.
/// @param value Binary value.
- (void) setRange :(SODataV4_int)index :(nonnull NSData*)value;
/// @return A binary value with the `SODataV4_ByteBuffer`.`length` bytes of this buffer.
///
- (nonnull NSData*) toBinary;
/// @brief Length of the buffer (the number of bytes that will appear in `this.toBinary()`.
///
///
@property (nonatomic, readwrite) SODataV4_int length;
@end
#endif

#ifdef import_SODataV4__ByteBuffer_private
#ifndef imported_SODataV4__ByteBuffer_private
#define imported_SODataV4__ByteBuffer_private
@interface SODataV4_ByteBuffer (private)
- (void) checkIndex :(SODataV4_int)index;
@end
#endif
#endif

#ifndef imported_SODataV4__ByteConstant_public
#define imported_SODataV4__ByteConstant_public
/// @internal
///
@interface SODataV4_ByteConstant : SODataV4_ObjectBase
{
}
#define SODataV4_ByteConstant_MIN_VALUE SODataV4_BYTE(-128)
#define SODataV4_ByteConstant_MAX_VALUE SODataV4_BYTE(127)
@end
#endif

#ifdef import_SODataV4__ByteDefault_internal
#ifndef imported_SODataV4__ByteDefault_internal
#define imported_SODataV4__ByteDefault_public
/* internal */
/// @brief Static functions to apply default values of type `byte`.
///
///
@interface SODataV4_ByteDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_byte) ifNull :(SODataV4_nullable_byte)value :(SODataV4_byte)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (SODataV4_byte) zeroIfNull :(SODataV4_nullable_byte)value;
@end
#endif
#endif

#ifndef imported_SODataV4__ByteFunction_public
#define imported_SODataV4__ByteFunction_public
/// @internal
///
@interface SODataV4_ByteFunction : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) toString :(SODataV4_byte)value;
/// @return `value` converted to string, with caller-specified `radix`.
/// @param value Source value.
/// @param radix (optional) Radix, from 2 to 36.
+ (nonnull NSString*) toString :(SODataV4_byte)value :(SODataV4_int)radix;
/// @return `value` converted to unsigned `int`.
/// @param value Source value.
+ (SODataV4_int) toUnsigned :(SODataV4_byte)value;
@end
#endif

#ifdef import_SODataV4__ByteMath_internal
#ifndef imported_SODataV4__ByteMath_internal
#define imported_SODataV4__ByteMath_public
/* internal */
/// @brief A subset of JavaScript's [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) functions applicable to type `byte`.
///
///
@interface SODataV4_ByteMath : SODataV4_ObjectBase
{
}
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
/// @throw `SODataV4_OverflowException` if `x == byte.MIN_VALUE`.
+ (SODataV4_byte) abs :(SODataV4_byte)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_byte) max :(SODataV4_byte)x :(SODataV4_byte)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_byte) min :(SODataV4_byte)x :(SODataV4_byte)y;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(SODataV4_byte)x;
@end
#endif
#endif

#ifndef imported_SODataV4__ByteOperator_public
#define imported_SODataV4__ByteOperator_public
/// @internal
///
@interface SODataV4_ByteOperator : SODataV4_ObjectBase
{
}
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `byte`.
+ (SODataV4_byte) add :(SODataV4_byte)left :(SODataV4_byte)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_byte)left :(SODataV4_byte)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `byte`.
+ (SODataV4_byte) divide :(SODataV4_byte)left :(SODataV4_byte)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_byte)left :(SODataV4_byte)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_byte)left :(SODataV4_byte)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_byte)left :(SODataV4_byte)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_byte)left :(SODataV4_byte)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_byte)left :(SODataV4_byte)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `byte`.
+ (SODataV4_byte) multiply :(SODataV4_byte)left :(SODataV4_byte)right;
/// @return `-value`.
/// @param value Operand value.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `byte`.
+ (SODataV4_byte) negate :(SODataV4_byte)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_byte)left :(SODataV4_byte)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `byte`.
+ (SODataV4_byte) remainder :(SODataV4_byte)left :(SODataV4_byte)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `byte`.
+ (SODataV4_byte) subtract :(SODataV4_byte)left :(SODataV4_byte)right;
@end
#endif

#ifdef import_SODataV4__ByteOperator_internal
#ifndef imported_SODataV4__ByteOperator_internal
#define imported_SODataV4__ByteOperator_internal
@interface SODataV4_ByteOperator (internal)
+ (SODataV4_byte) check :(SODataV4_int)value;
@end
#endif
#endif

#ifndef imported_SODataV4__CharBuffer_public
#define imported_SODataV4__CharBuffer_public
/// @internal
///
@interface SODataV4_CharBuffer : SODataV4_ObjectBase
{
    @private SODataV4_char* _buffer;
    @private SODataV4_int _capacity;
    @private SODataV4_int _length;
}
- (nonnull SODataV4_char*) pointer;
- (nonnull id) init;
/// @brief Construct a new buffer with a `SODataV4_CharBuffer`.`length` of zero and specified initial `capacity`.
///
/// A buffer can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the buffer's maximum length.
+ (nonnull SODataV4_CharBuffer*) new;
/// @brief Construct a new buffer with a `SODataV4_CharBuffer`.`length` of zero and specified initial `capacity`.
///
/// A buffer can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the buffer's maximum length.
///
/// @param capacity (optional) Initial capacity. Defaults to 16.
+ (nonnull SODataV4_CharBuffer*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add a character value to the end of this buffer.
///
///
/// @param value Character value to be added.
- (void) add :(SODataV4_char)value;
/// @brief Append a string value to the end of this buffer.
///
///
/// @param text String value. If `nil`, then "null" is appended to the buffer.
- (void) append :(nullable NSString*)text;
/// @brief Set `SODataV4_CharBuffer`.`length` to zero.
///
///
- (void) clear;
- (void) dealloc;
/// @return The character of this buffer at `index`.
/// @throw An exception if `index` is out of range `0 .. this.length - 1`.
/// @param index Zero-based index.
- (SODataV4_char) get :(SODataV4_int)index;
/// @return A range of characters from this buffer.
/// @throw An exception if `start` or `end` is out of range `0 .. this.length`.
/// @param start Zero-based starting index (inclusive).
/// @param end Zero-based ending index (exclusive).
- (nonnull NSString*) getRange :(SODataV4_int)start :(SODataV4_int)end;
/// @return the concatenation of 2 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
+ (nonnull NSString*) join2 :(nullable NSString*)text1 :(nullable NSString*)text2;
/// @return the concatenation of 3 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
+ (nonnull NSString*) join3 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3;
/// @return the concatenation of 4 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
/// @param text4 Fourth string value.
+ (nonnull NSString*) join4 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3 :(nullable NSString*)text4;
/// @return the concatenation of 5 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
/// @param text4 Fourth string value.
/// @param text5 Fifth string value.
+ (nonnull NSString*) join5 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3 :(nullable NSString*)text4 :(nullable NSString*)text5;
/// @return the concatenation of 6 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
/// @param text4 Fourth string value.
/// @param text5 Fifth string value.
/// @param text6 Sixth string value.
+ (nonnull NSString*) join6 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3 :(nullable NSString*)text4 :(nullable NSString*)text5 :(nullable NSString*)text6;
/// @return the concatenation of 7 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
/// @param text4 Fourth string value.
/// @param text5 Fifth string value.
/// @param text6 Sixth string value.
/// @param text7 Seventh string value.
+ (nonnull NSString*) join7 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3 :(nullable NSString*)text4 :(nullable NSString*)text5 :(nullable NSString*)text6 :(nullable NSString*)text7;
/// @return the concatenation of 8 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
/// @param text4 Fourth string value.
/// @param text5 Fifth string value.
/// @param text6 Sixth string value.
/// @param text7 Seventh string value.
/// @param text8 Eighth string value.
+ (nonnull NSString*) join8 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3 :(nullable NSString*)text4 :(nullable NSString*)text5 :(nullable NSString*)text6 :(nullable NSString*)text7 :(nullable NSString*)text8;
/// @return the concatenation of 9 string values, using `append`.
/// @param text1 First string value.
/// @param text2 Second string value.
/// @param text3 Third string value.
/// @param text4 Fourth string value.
/// @param text5 Fifth string value.
/// @param text6 Sixth string value.
/// @param text7 Seventh string value.
/// @param text8 Eighth string value.
/// @param text9 Ninth string value.
+ (nonnull NSString*) join9 :(nullable NSString*)text1 :(nullable NSString*)text2 :(nullable NSString*)text3 :(nullable NSString*)text4 :(nullable NSString*)text5 :(nullable NSString*)text6 :(nullable NSString*)text7 :(nullable NSString*)text8 :(nullable NSString*)text9;
/// @brief Length of the buffer (the number of characters that will appear in `this.toString()`.
///
///
- (SODataV4_int) length;
/// @brief Reverse the characters of this buffer.
///
///
- (void) reverse;
/// @brief Set the character of this buffer at `index`.
///
///
/// @throw An exception if `index` is out of range `0 .. this.length - 1`.
/// @param index Zero-based index.
/// @param value Byte value.
- (void) set :(SODataV4_int)index :(SODataV4_char)value;
/// @brief Length of the buffer (the number of characters that will appear in `this.toString()`.
///
///
- (void) setLength :(SODataV4_int)value;
/// @brief Copy a range of characters from a string value into this buffer, starting at `index`.
///
///
/// @throw An exception if `index` is out of range `0 .. this.length - 1` or `index + value.length` is out of range `0 .. this.length`.
/// @param index Zero-based starting index.
/// @param value String value.
- (void) setRange :(SODataV4_int)index :(nonnull NSString*)value;
/// @return A string value with the `SODataV4_CharBuffer`.`length` characters of this buffer.
///
- (nonnull NSString*) toString;
/// @brief Length of the buffer (the number of characters that will appear in `this.toString()`.
///
///
@property (nonatomic, readwrite) SODataV4_int length;
@end
#endif

#ifdef import_SODataV4__CharBuffer_private
#ifndef imported_SODataV4__CharBuffer_private
#define imported_SODataV4__CharBuffer_private
@interface SODataV4_CharBuffer (private)
- (void) checkIndex :(SODataV4_int)index;
@end
#endif
#endif

#ifdef import_SODataV4__CharDefault_internal
#ifndef imported_SODataV4__CharDefault_internal
#define imported_SODataV4__CharDefault_public
/* internal */
/// @brief Static functions to apply default values of type `boolean`.
///
///
@interface SODataV4_CharDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_boolean) ifNull :(SODataV4_nullable_boolean)value :(SODataV4_boolean)defaultValue;
@end
#endif
#endif

#ifndef imported_SODataV4__CharFunction_public
#define imported_SODataV4__CharFunction_public
/// @internal
///
@interface SODataV4_CharFunction : SODataV4_ObjectBase
{
}
/// @return `true` if `value` is a valid decimal digit (0..9), otherwise `false`.
/// @param value Source value.
+ (SODataV4_boolean) isDigit :(SODataV4_char)value;
/// @return `true` if `value` is a valid hexadecimal digit (0..9, a..f, A..F), otherwise `false`.
/// @param value Source value.
+ (SODataV4_boolean) isHexDigit :(SODataV4_char)value;
/// @return `true` if `value` is a lower-case character, otherwise `false`.
/// @param value Source value.
+ (SODataV4_boolean) isLowerCase :(SODataV4_char)value;
/// @return `true` if `value` is unreserved in a URI.
/// @param value Source value.
/// @see [Unreserved Characters](https://tools.ietf.org/html/rfc3986#section-2.3)
+ (SODataV4_boolean) isUnreservedInURI :(SODataV4_char)value;
/// @return `true` if `value` is an upper-case character, otherwise `false`.
/// @param value Source value.
+ (SODataV4_boolean) isUpperCase :(SODataV4_char)value;
/// @return `true` if `value` is whitespace according to the definition of JavaScript [String.prototype.trim](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trim).
/// @param value Source value.
+ (SODataV4_boolean) isWhitespace :(SODataV4_char)value;
/// @return `value` converted to lower-case.
/// @param value Source value.
+ (SODataV4_char) toLowerCase :(SODataV4_char)value;
/// @return `value` converted to string.
/// @param value Source value.
+ (nonnull NSString*) toString :(SODataV4_char)value;
/// @return `value` converted to upper-case.
/// @param value Source value.
+ (SODataV4_char) toUpperCase :(SODataV4_char)value;
/// @return Character formatted as Unicode "{U+XXXX}", where "XXXX" is hexadecimal encoding.
/// @param value Character to be formatted.
+ (nonnull NSString*) unicodePlus :(SODataV4_char)value;
@end
#endif

#ifndef imported_SODataV4__CharOperator_public
#define imported_SODataV4__CharOperator_public
/// @internal
///
@interface SODataV4_CharOperator : SODataV4_ObjectBase
{
}
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_char)left :(SODataV4_char)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_char)left :(SODataV4_char)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_char)left :(SODataV4_char)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_char)left :(SODataV4_char)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_char)left :(SODataV4_char)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_char)left :(SODataV4_char)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_char)left :(SODataV4_char)right;
@end
#endif

#ifndef imported_SODataV4__CheckProperty_public
#define imported_SODataV4__CheckProperty_public
/// @internal
///
@interface SODataV4_CheckProperty : SODataV4_ObjectBase
{
}
/// @return `value` if it is non-null.
/// @param name Property name.
/// @param value Nullable value.
/// @throw `SODataV4_UndefinedException` if `value` is `nil`.
+ (nonnull NSObject*) isDefined :(nonnull NSObject*)owner :(nonnull NSString*)name :(nullable NSObject*)value;
@end
#endif

#ifdef import_SODataV4__ClassName_internal
#ifndef imported_SODataV4__ClassName_internal
#define imported_SODataV4__ClassName_public
/* internal */
/// @brief Utility for accessing class names.
///
///
@interface SODataV4_ClassName : SODataV4_ObjectBase
{
}
/// @return The class name of `value`, or "null" if `value` is `nil`.
/// @param value Value for which the class name will be returned.
+ (nonnull NSString*) of :(nullable NSObject*)value;
/// @return The unqualified class name of `value`, or "null" if `value` is `nil`.
/// @param value Value for which the class name will be returned.
+ (nonnull NSString*) unqualified :(nullable NSObject*)value;
@end
#endif
#endif

#ifndef imported_SODataV4__Comparer_public
#define imported_SODataV4__Comparer_public
/// @internal
///
@interface SODataV4_Comparer : SODataV4_ObjectBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_Comparer*) new;
/// @internal
///
- (void) _init;
/// @brief Compare two values for sorting.
///
///
/// @return A zero value if `left` is equal to `right` in sorted order, left negative value (e.g. -1) if `left` is less than `right` in sorted order, or left positive value (e.g. 1) if `left` is greater than `right` in sorted order.
/// @param left First value for comparison.
/// @param right Second value for comparison.
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
/// @brief Represents an undefined comparer, which will throw `SODataV4_UndefinedException` if its `SODataV4_Comparer`.`compare` function is called.
///
///
+ (nonnull SODataV4_Comparer*) undefined;
/// @brief Represents an undefined comparer, which will throw `SODataV4_UndefinedException` if its `SODataV4_Comparer`.`compare` function is called.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Comparer* undefined;
@end
#endif

#ifdef import_SODataV4__ConditionVariable_internal
#ifndef imported_SODataV4__ConditionVariable_internal
#define imported_SODataV4__ConditionVariable_public
/* internal */
/// @brief A [condition variable](https://en.wikipedia.org/wiki/Monitor_(synchronization)#Condition_variables_2).
///
///
@interface SODataV4_ConditionVariable : SODataV4_ObjectBase
{
    @private pthread_cond_t condition;
    @private SODataV4_ReentrantMutex* _Nonnull mutex_;
}
- (nonnull id) init;
/// @brief Construct a new condition variable, associated with `mutex`.
///
///
/// @param mutex Associated reentrant mutex.
+ (nonnull SODataV4_ConditionVariable*) new :(nonnull SODataV4_ReentrantMutex*)mutex;
/// @internal
///
- (void) _init :(nonnull SODataV4_ReentrantMutex*)mutex;
/// @brief Wait until the condition variable is signaled.
///
/// Before calling this function, the caller must `SODataV4_ReentrantMutex`.`lock` the associated mutex.
- (void) await;
/// @brief Wake up one thread that is currently awaiting this condition variable.
///
/// Before calling this function, the caller must `SODataV4_ReentrantMutex`.`lock` the associated mutex.
- (void) signal;
@end
#endif
#endif

#ifdef import_SODataV4__ConditionVariable_private
#ifndef imported_SODataV4__ConditionVariable_private
#define imported_SODataV4__ConditionVariable_private
@interface SODataV4_ConditionVariable (private)
- (nonnull SODataV4_ReentrantMutex*) mutex;
- (void) setMutex :(nonnull SODataV4_ReentrantMutex*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ReentrantMutex* mutex;
@end
#endif
#endif

#ifdef import_SODataV4__CountingSemaphore_internal
#ifndef imported_SODataV4__CountingSemaphore_internal
#define imported_SODataV4__CountingSemaphore_public
/* internal */
/// @brief A [counting semaphore](https://en.wikipedia.org/wiki/Semaphore_(programming)).
///
///
@interface SODataV4_CountingSemaphore : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Construct a new semaphpore with the specified number of `permits`.
///
///
/// @param permits Number of permits.
+ (nonnull SODataV4_CountingSemaphore*) new :(SODataV4_int)permits;
/// @internal
///
- (void) _init :(SODataV4_int)permits;
/// @brief Acquire the semaphore, blocking if needed until a permit is available.
///
///
- (void) acquire;
/// @brief Release the semaphore which was acquired by the current thread using `SODataV4_CountingSemaphore`.`acquire` or `SODataV4_CountingSemaphore`.`tryAcquire`.
///
///
- (void) release_;
/// @return `true` if the semaphore was acquired without blocking for longer than `timeout` milliseconds, otherwise `false` (in which case the semaphore was not acquired).
/// @param timeout Timeout in milliseconds.
- (SODataV4_boolean) tryAcquire :(SODataV4_int)timeout;
@end
#endif
#endif

#ifdef import_SODataV4__CurrentProcess_internal
#ifndef imported_SODataV4__CurrentProcess_internal
#define imported_SODataV4__CurrentProcess_public
/* internal */
/// @brief Obtain information about the current process.
///
///
@interface SODataV4_CurrentProcess : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @brief The current process host.
///
///
+ (nonnull NSString*) host;
/// @brief The current "id@host".
///
///
/// @see `SODataV4_CurrentProcess`.`id_`, `SODataV4_CurrentProcess`.`host`.
+ (nonnull NSString*) idAtHost;
/// @brief The current process id.
///
///
+ (SODataV4_long) id_;
/// @brief The current process host.
///
///
@property (nonatomic, readonly, class, strong, nonnull) NSString* host;
/// @brief The current "id@host".
///
///
/// @see `SODataV4_CurrentProcess`.`id_`, `SODataV4_CurrentProcess`.`host`.
@property (nonatomic, readonly, class, strong, nonnull) NSString* idAtHost;
/// @brief The current process id.
///
///
@property (nonatomic, readonly, class) SODataV4_long id_;
@end
#endif
#endif

#ifdef import_SODataV4__CurrentProcess_private
#ifndef imported_SODataV4__CurrentProcess_private
#define imported_SODataV4__CurrentProcess_private
@interface SODataV4_CurrentProcess (private)
+ (nonnull NSString*) initIdAtHost;
@end
#endif
#endif

#ifdef import_SODataV4__CurrentThread_internal
#ifndef imported_SODataV4__CurrentThread_internal
#define imported_SODataV4__CurrentThread_public
/* internal */
/// @brief Obtain informationabout the current thread.
///
///
@interface SODataV4_CurrentThread : SODataV4_ObjectBase
{
}
/// @return the current thread name.
///
+ (nonnull NSString*) getName;
/// @brief The current thread id.
///
///
+ (SODataV4_long) id_;
/// @brief The current thread id.
///
///
@property (nonatomic, readonly, class) SODataV4_long id_;
@end
#endif
#endif

#ifndef imported_SODataV4__DebugConsole_public
#define imported_SODataV4__DebugConsole_public
/// @internal
///
@interface SODataV4_DebugConsole : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @brief Start copying debug console output to `file` (append mode).
///
///
/// @param file File for captured debug console output (created if it doesn't exist already).
+ (void) append :(nonnull NSString*)file;
/// @brief Close the file opened by `SODataV4_DebugConsole`.`open` or `SODataV4_DebugConsole`.`append`. Has no effect if file was not open.
///
///
+ (void) close;
/// @internal
///
+ (void) debug :(nonnull NSString*)message;
/// @internal
///
+ (void) debug :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a DEBUG message to the debug console.
///
///
/// @param message Message text.
/// @param cause Optional exception.
/// @param dump (optional) True to dump `cause` stack trace.
+ (void) debug :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
+ (void) dumpStack;
/// @brief Dump the current thread's stack frames to the debug console.
///
///
/// @param message (optional) Debug message (defaults to "Stack Dump").
+ (void) dumpStack :(nonnull NSString*)message;
/// @internal
///
+ (void) error :(nonnull NSString*)message;
/// @internal
///
+ (void) error :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log an ERROR message to the debug console.
///
///
/// @param message Message text.
/// @param cause Optional exception.
/// @param dump (optional) True to dump `cause` stack trace.
+ (void) error :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Flush any buffered output written to a file.
///
///
/// @see `SODataV4_DebugConsole`.`open`, `SODataV4_DebugConsole`.`append`.
+ (void) flush;
/// @return Captured debug console output.
/// @see `SODataV4_DebugConsole`.`startCapture`, `SODataV4_DebugConsole`.`stopCapture`.
+ (nonnull NSString*) getCaptured;
/// @internal
///
+ (void) info :(nonnull NSString*)message;
/// @internal
///
+ (void) info :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log an INFO message to the debug console.
///
///
/// @param message Message text.
/// @param cause Optional exception.
/// @param dump (optional) True to dump `cause` stack trace.
+ (void) info :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
+ (void) log :(nonnull NSString*)message;
/// @internal
///
+ (void) log :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a DEBUG message to the debug console.
///
///
/// @param message Message text.
/// @param cause Optional exception.
/// @param dump (optional) True to dump `cause` stack trace.
+ (void) log :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
+ (void) mainException :(nonnull NSException*)cause;
/// @brief Start copying debug console output to `file` (create mode).
///
///
/// @param file File for captured debug console output (recreated if it does exist already).
+ (void) open :(nonnull NSString*)file;
/// @brief Start capturing debug console output to an internal buffer.
///
///
+ (void) startCapture;
/// @brief Stop capturing debug console output to an internal buffer.
///
///
+ (void) stopCapture;
/// @internal
///
+ (void) trace :(nonnull NSString*)message;
/// @internal
///
+ (void) trace :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a TRACE message to the debug console.
///
///
/// @param message Message text.
/// @param cause Optional exception.
/// @param dump (optional) True to dump `cause` stack trace.
+ (void) trace :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Trace an exception to the debug console.
///
///
/// @param cause Exception traced.
+ (void) traceEx :(nonnull NSException*)cause;
/// @brief Trace a function entry to the debug console.
///
///
/// @param method Function name.
+ (void) traceIn :(nonnull NSString*)method;
/// @brief Trace a function exit to the debug console.
///
///
/// @param method Function name.
+ (void) traceOut :(nonnull NSString*)method;
/// @internal
///
+ (void) warn :(nonnull NSString*)message;
/// @internal
///
+ (void) warn :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a WARN message to the debug console.
///
///
/// @param message Message text.
/// @param cause Optional exception.
/// @param dump (optional) True to dump `cause` stack trace.
+ (void) warn :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
@end
#endif

#ifdef import_SODataV4__DebugConsole_private
#ifndef imported_SODataV4__DebugConsole_private
#define imported_SODataV4__DebugConsole_private
@interface SODataV4_DebugConsole (private)
+ (void) addCaptured :(nonnull NSString*)line;
/// @internal
///
+ (void) formatAndLog :(nonnull NSString*)level :(nonnull NSString*)message :(nullable NSException*)cause;
+ (void) formatAndLog :(nonnull NSString*)level :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
+ (nonnull NSString*) getSpaces;
+ (SODataV4_int) indent;
+ (SODataV4_boolean) mainConsole;
+ (void) setIndent :(SODataV4_int)value;
+ (nonnull NSString*) threadInfo;
+ (nonnull NSString*) timePrefix;
+ (void) write :(nonnull NSString*)text :(SODataV4_boolean)isError;
+ (void) writeChar :(SODataV4_char)c :(SODataV4_boolean)isError;
+ (void) writeLine :(nonnull NSString*)text :(SODataV4_boolean)isError;
@property (nonatomic, readwrite, class) SODataV4_int indent;
@end
#endif
#endif

#ifdef import_SODataV4__DebugConsole_FlushThread_internal
#ifndef imported_SODataV4__DebugConsole_FlushThread_internal
#define imported_SODataV4__DebugConsole_FlushThread_public
/* internal */
@interface SODataV4_DebugConsole_FlushThread : SODataV4_ObjectBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_DebugConsole_FlushThread*) new;
/// @internal
///
- (void) _init;
- (void) run;
- (void) start;
+ (void) startOnce;
@end
#endif
#endif

#ifdef import_SODataV4__DebugWriter_internal
#ifndef imported_SODataV4__DebugWriter_internal
#define imported_SODataV4__DebugWriter_public
/* internal */
/// @brief Externalize DebugConsole's dependency on file package to avoid build circularity.
///
/// (the file package is compiled after the core package).
@interface SODataV4_DebugWriter : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_DebugWriter*) new;
/// @internal
///
- (void) _init;
+ (nullable SODataV4_DebugWriter*) append :(nonnull NSString*)file;
- (void) close;
- (void) flush;
+ (nullable SODataV4_DebugWriter*) open :(nonnull NSString*)file;
- (void) write :(nonnull NSString*)line;
@end
#endif
#endif

#ifndef imported_SODataV4__DecimalConstant_public
#define imported_SODataV4__DecimalConstant_public
/// @internal
///
@interface SODataV4_DecimalConstant : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (nonnull SODataV4_BigDecimal*) zero;
@end
#define SODataV4_DecimalConstant_zero [SODataV4_DecimalConstant zero]
#endif

#ifdef import_SODataV4__DecimalDefault_internal
#ifndef imported_SODataV4__DecimalDefault_internal
#define imported_SODataV4__DecimalDefault_public
/* internal */
/// @brief Static functions to apply default values of type `decimal`.
///
///
@interface SODataV4_DecimalDefault : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull SODataV4_BigDecimal*) ifNull :(nullable SODataV4_BigDecimal*)value :(nonnull SODataV4_BigDecimal*)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (nonnull SODataV4_BigDecimal*) zeroIfNull :(nullable SODataV4_BigDecimal*)value;
@end
#endif
#endif

#ifdef import_SODataV4__DecimalDefault_private
#ifndef imported_SODataV4__DecimalDefault_private
#define imported_SODataV4__DecimalDefault_private
@interface SODataV4_DecimalDefault (private)
+ (nonnull SODataV4_BigDecimal*) DECIMAL_ZERO;
@end
#define SODataV4_DecimalDefault_DECIMAL_ZERO [SODataV4_DecimalDefault DECIMAL_ZERO]
#endif
#endif

#ifndef imported_SODataV4__DecimalFunction_public
#define imported_SODataV4__DecimalFunction_public
/// @internal
///
@interface SODataV4_DecimalFunction : SODataV4_ObjectBase
{
}
/// @return `value` converted to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromByte :(SODataV4_byte)value;
/// @return `value` converted (rounded to 4 decimal places) to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromDouble :(SODataV4_double)value;
/// @return `value` converted (rounded to 4 decimal places) to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromFloat :(SODataV4_float)value;
/// @return `value` converted to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromInt :(SODataV4_int)value;
/// @return `value` converted to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromInteger :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromLong :(SODataV4_long)value;
/// @return `value` converted to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) fromShort :(SODataV4_short)value;
/// @return `value` converted to type `byte`.
/// @param value Source value.
+ (SODataV4_byte) toByte :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `double`.
/// @param value Source value.
+ (SODataV4_double) toDouble :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `float`.
/// @param value Source value.
+ (SODataV4_float) toFloat :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `int`.
/// @param value Source value.
+ (SODataV4_int) toInt :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) toInteger :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `long`.
/// @param value Source value.
+ (SODataV4_long) toLong :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `short`.
/// @param value Source value.
+ (SODataV4_short) toShort :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `string`.
/// @param value Source value.
+ (nonnull NSString*) toString :(nonnull SODataV4_BigDecimal*)value;
@end
#endif

#ifdef import_SODataV4__DecimalMath_internal
#ifndef imported_SODataV4__DecimalMath_internal
#define imported_SODataV4__DecimalMath_public
/* internal */
/// @brief A subset of JavaScript's [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) functions applicable to type `decimal`.
///
///
@interface SODataV4_DecimalMath : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
+ (nonnull SODataV4_BigDecimal*) abs :(nonnull SODataV4_BigDecimal*)x;
/// @return [Math.ceil](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/ceil)(x).
/// @param x Argument value.
+ (nonnull SODataV4_BigDecimal*) ceil :(nonnull SODataV4_BigDecimal*)x;
/// @return [Math.floor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/floor)(x).
/// @param x Argument value.
+ (nonnull SODataV4_BigDecimal*) floor :(nonnull SODataV4_BigDecimal*)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (nonnull SODataV4_BigDecimal*) max :(nonnull SODataV4_BigDecimal*)x :(nonnull SODataV4_BigDecimal*)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (nonnull SODataV4_BigDecimal*) min :(nonnull SODataV4_BigDecimal*)x :(nonnull SODataV4_BigDecimal*)y;
/// @internal
///
+ (nonnull SODataV4_BigDecimal*) round :(nonnull SODataV4_BigDecimal*)x;
/// @return [Math.round](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)(x).
/// @param x Argument value.
/// @param scale (optional) Decimal scale (number of fractional digits after the decimal point).
+ (nonnull SODataV4_BigDecimal*) round :(nonnull SODataV4_BigDecimal*)x :(SODataV4_int)scale;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(nonnull SODataV4_BigDecimal*)x;
@end
#endif
#endif

#ifdef import_SODataV4__DecimalMath_private
#ifndef imported_SODataV4__DecimalMath_private
#define imported_SODataV4__DecimalMath_private
@interface SODataV4_DecimalMath (private)
+ (nonnull SODataV4_BigDecimal*) DECIMAL_ZERO;
@end
#define SODataV4_DecimalMath_DECIMAL_ZERO [SODataV4_DecimalMath DECIMAL_ZERO]
#endif
#endif

#ifndef imported_SODataV4__DecimalOperator_public
#define imported_SODataV4__DecimalOperator_public
/// @internal
///
@interface SODataV4_DecimalOperator : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigDecimal*) add :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigDecimal*) divide :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigDecimal*) multiply :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @return `-value`.
/// @param value Operand value.
+ (nonnull SODataV4_BigDecimal*) negate :(nonnull SODataV4_BigDecimal*)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigDecimal*) remainder :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigDecimal*) subtract :(nonnull SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
@end
#endif

#ifdef import_SODataV4__DecimalOperator_private
#ifndef imported_SODataV4__DecimalOperator_private
#define imported_SODataV4__DecimalOperator_private
@interface SODataV4_DecimalOperator (private)
+ (nonnull SODataV4_BigDecimal*) DECIMAL_ZERO;
@end
#define SODataV4_DecimalOperator_DECIMAL_ZERO [SODataV4_DecimalOperator DECIMAL_ZERO]
#endif
#endif

#ifndef imported_SODataV4__DoubleConstant_public
#define imported_SODataV4__DoubleConstant_public
/// @internal
///
@interface SODataV4_DoubleConstant : SODataV4_ObjectBase
{
}
/// @return NaN (not-a-number) for type `double`.
///
+ (SODataV4_double) nan;
/// @return Negative infinity for type `double`.
///
+ (SODataV4_double) negativeInfinity;
/// @return Positive infinity for type `double`.
///
+ (SODataV4_double) positiveInfinity;
@end
#endif

#ifdef import_SODataV4__DoubleDefault_internal
#ifndef imported_SODataV4__DoubleDefault_internal
#define imported_SODataV4__DoubleDefault_public
/* internal */
/// @brief Static functions to apply default values of type `double`.
///
///
@interface SODataV4_DoubleDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_double) ifNull :(SODataV4_nullable_double)value :(SODataV4_double)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (SODataV4_double) zeroIfNull :(SODataV4_nullable_double)value;
@end
#endif
#endif

#ifndef imported_SODataV4__DoubleFunction_public
#define imported_SODataV4__DoubleFunction_public
/// @internal
///
@interface SODataV4_DoubleFunction : SODataV4_ObjectBase
{
}
/// @return `value` converted to type `byte`.
/// @param value Source value.
+ (SODataV4_byte) byteValue :(SODataV4_double)value;
/// @return `value` converted to type `int`.
/// @param value Source value.
+ (SODataV4_int) intValue :(SODataV4_double)value;
/// @return `true` if `value` is finite.
/// @param value Source value.
+ (SODataV4_boolean) isFinite :(SODataV4_double)value;
/// @return `true` if `value` is infinite.
/// @param value Source value.
+ (SODataV4_boolean) isInfinite :(SODataV4_double)value;
/// @return `true` if `value` is not-a-number.
/// @param value Source value.
+ (SODataV4_boolean) isNaN :(SODataV4_double)value;
/// @return `value` converted to type `long`.
/// @param value Source value.
+ (SODataV4_long) longValue :(SODataV4_double)value;
/// @return `value` converted to type `short`.
/// @param value Source value.
+ (SODataV4_short) shortValue :(SODataV4_double)value;
/// @internal
///
+ (nonnull NSString*) toExponential :(SODataV4_double)value;
/// @brief @param value Source value.
///
/// @param fractionDigits (optional) Number of fractional digits after the decimal point (defaults to 16).
/// @see JavaScript [Number.prototype.toExponential](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toExponential).
+ (nonnull NSString*) toExponential :(SODataV4_double)value :(SODataV4_int)fractionDigits;
/// @return `value` converted to type `string` in fixed-point format.
/// @param value Source value.
/// @param fractionDigits Number of fractional digits after the decimal point.
/// @see JavaScript [Number.prototype.toFixed](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed).
+ (nonnull NSString*) toFixed :(SODataV4_double)value :(SODataV4_int)fractionDigits;
/// @return `value` converted to type `string` in XML Schema format.
/// @param value Source value.
/// @see `SODataV4_SchemaFormat`.`formatDouble`.
+ (nonnull NSString*) toString :(SODataV4_double)value;
@end
#endif

#ifdef import_SODataV4__DoubleMath_internal
#ifndef imported_SODataV4__DoubleMath_internal
#define imported_SODataV4__DoubleMath_public
/* internal */
/// @brief Contains all constants and functions from JavaScript [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) Object, for type `double`.
///
///
@interface SODataV4_DoubleMath : SODataV4_ObjectBase
{
}
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
+ (SODataV4_double) abs :(SODataV4_double)x;
/// @return [Math.acos](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/acos)(x).
/// @param x Argument value.
+ (SODataV4_double) acos :(SODataV4_double)x;
/// @return [Math.asin](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/asin)(x).
/// @param x Argument value.
+ (SODataV4_double) asin :(SODataV4_double)x;
/// @return [Math.atan](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan)(x).
/// @param x Argument value.
+ (SODataV4_double) atan :(SODataV4_double)x;
/// @return [Math.atan2](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan2)(x).
/// @param y y-coordinate.
/// @param x x-coordinate.
+ (SODataV4_double) atan2 :(SODataV4_double)y :(SODataV4_double)x;
/// @return [Math.ceil](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/ceil)(x).
/// @param x Argument value.
+ (SODataV4_double) ceil :(SODataV4_double)x;
/// @return [Math.cos](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/cos)(x).
/// @param x Argument value.
+ (SODataV4_double) cos :(SODataV4_double)x;
/// @return [Math.exp](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/exp)(x).
/// @param x Argument value.
+ (SODataV4_double) exp :(SODataV4_double)x;
/// @return [Math.floor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/floor)(x).
/// @param x Argument value.
+ (SODataV4_double) floor :(SODataV4_double)x;
/// @return [Math.log](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/log)(x).
/// @param x Argument value.
+ (SODataV4_double) log :(SODataV4_double)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_double) max :(SODataV4_double)x :(SODataV4_double)y;
/// @return [Math.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_double) min :(SODataV4_double)x :(SODataV4_double)y;
/// @return [Math.pow](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/pow)(x).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_double) pow :(SODataV4_double)x :(SODataV4_double)y;
/// @return [Math.random](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random)(x).
///
+ (SODataV4_double) random;
/// @return [Math.round](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)(x).
/// @param x Argument value.
+ (SODataV4_double) round :(SODataV4_double)x;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(SODataV4_double)x;
/// @return [Math.sin](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sin)(x).
/// @param x Argument value.
+ (SODataV4_double) sin :(SODataV4_double)x;
/// @return [Math.sqrt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sqrt)(x).
/// @param x Argument value.
+ (SODataV4_double) sqrt :(SODataV4_double)x;
/// @return [Math.tan](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/tan)(x).
/// @param x Argument value.
+ (SODataV4_double) tan :(SODataV4_double)x;
#define SODataV4_DoubleMath_E 2.7182818284590452
#define SODataV4_DoubleMath_LN2 0.6931471805599453
#define SODataV4_DoubleMath_LN10 2.3025850929940460
#define SODataV4_DoubleMath_LOG2E 1.4426950408889634
#define SODataV4_DoubleMath_LOG10E 0.4342944819032518
#define SODataV4_DoubleMath_PI 3.1415926535897932
#define SODataV4_DoubleMath_SQRT1_2 0.7071067811865476
#define SODataV4_DoubleMath_SQRT2 1.4142135623730951
@end
#endif
#endif

#ifndef imported_SODataV4__DoubleOperator_public
#define imported_SODataV4__DoubleOperator_public
/// @internal
///
@interface SODataV4_DoubleOperator : SODataV4_ObjectBase
{
}
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `double`.
+ (SODataV4_double) add :(SODataV4_double)left :(SODataV4_double)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_double)left :(SODataV4_double)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `double`.
+ (SODataV4_double) divide :(SODataV4_double)left :(SODataV4_double)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_double)left :(SODataV4_double)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_double)left :(SODataV4_double)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_double)left :(SODataV4_double)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_double)left :(SODataV4_double)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_double)left :(SODataV4_double)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `double`.
+ (SODataV4_double) multiply :(SODataV4_double)left :(SODataV4_double)right;
/// @return `-value`.
/// @param value Operand value.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `double`.
+ (SODataV4_double) negate :(SODataV4_double)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_double)left :(SODataV4_double)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `double`.
+ (SODataV4_double) remainder :(SODataV4_double)left :(SODataV4_double)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `double`.
+ (SODataV4_double) subtract :(SODataV4_double)left :(SODataV4_double)right;
@end
#endif

#ifdef import_SODataV4__DoubleOperator_internal
#ifndef imported_SODataV4__DoubleOperator_internal
#define imported_SODataV4__DoubleOperator_internal
@interface SODataV4_DoubleOperator (internal)
+ (SODataV4_double) check :(SODataV4_double)value;
@end
#endif
#endif

#ifndef imported_SODataV4__Equality_public
#define imported_SODataV4__Equality_public
/// @internal
///
@interface SODataV4_Equality : SODataV4_ObjectBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_Equality*) new;
/// @internal
///
- (void) _init;
/// @brief Compare two values for equality.
///
///
/// @return `true` if `left` is equal to `right`, otherwise `false`.
/// @param left First value for comparison.
/// @param right Second value for comparison.
- (SODataV4_boolean) equal :(nullable NSObject*)left :(nullable NSObject*)right;
/// @brief Represents an undefined equality, which will throw `SODataV4_UndefinedException` if its `SODataV4_Equality`.`equal` function is called.
///
///
+ (nonnull SODataV4_Equality*) undefined;
/// @brief Represents an undefined equality, which will throw `SODataV4_UndefinedException` if its `SODataV4_Equality`.`equal` function is called.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Equality* undefined;
@end
#endif

#ifndef imported_SODataV4__ErrorFunction_public
#define imported_SODataV4__ErrorFunction_public
/// @internal
///
@interface SODataV4_ErrorFunction : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nullable NSException*)left :(nullable NSException*)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (nonnull NSException*) getValue :(nullable NSException*)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(nullable NSException*)left :(nonnull NSException*)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(nullable NSException*)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nullable NSException*)left :(nullable NSException*)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(nullable NSException*)value;
/// @return The `nil` `exception` value.
///
+ (nullable NSException*) nullValue;
/// @brief Convert `value` to a `string`.
///
///
/// @param value Source value.
+ (nonnull NSString*) toString :(nullable NSException*)value;
/// @return `value`, converted to a nullable `exception`.
/// @param value Argument value.
+ (nullable NSException*) withValue :(nonnull NSException*)value;
@end
#endif

#ifndef imported_SODataV4__FloatConstant_public
#define imported_SODataV4__FloatConstant_public
/// @internal
///
@interface SODataV4_FloatConstant : SODataV4_ObjectBase
{
}
/// @return NaN (not-a-number) for type `float`.
///
+ (SODataV4_float) nan;
/// @return Negative infinity for type `float`.
///
+ (SODataV4_float) negativeInfinity;
/// @return Positive infinity for type `float`.
///
+ (SODataV4_float) positiveInfinity;
@end
#endif

#ifdef import_SODataV4__FloatDefault_internal
#ifndef imported_SODataV4__FloatDefault_internal
#define imported_SODataV4__FloatDefault_public
/* internal */
/// @brief Static functions to apply default values of type `float`.
///
///
@interface SODataV4_FloatDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_float) ifNull :(SODataV4_nullable_float)value :(SODataV4_float)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (SODataV4_float) zeroIfNull :(SODataV4_nullable_float)value;
@end
#endif
#endif

#ifndef imported_SODataV4__FloatFunction_public
#define imported_SODataV4__FloatFunction_public
/// @internal
///
@interface SODataV4_FloatFunction : SODataV4_ObjectBase
{
}
/// @return `value` converted to type `byte`.
/// @param value Source value.
+ (SODataV4_byte) byteValue :(SODataV4_float)value;
/// @return `value` converted to type `int`.
/// @param value Source value.
+ (SODataV4_int) intValue :(SODataV4_float)value;
/// @return `true` if `value` is finite.
/// @param value Source value.
+ (SODataV4_boolean) isFinite :(SODataV4_float)value;
/// @return `true` if `value` is infinite.
/// @param value Source value.
+ (SODataV4_boolean) isInfinite :(SODataV4_float)value;
/// @return `true` if `value` is not-a-number.
/// @param value Source value.
+ (SODataV4_boolean) isNaN :(SODataV4_float)value;
/// @return `value` converted to type `long`.
/// @param value Source value.
+ (SODataV4_long) longValue :(SODataV4_float)value;
/// @return `value` converted to type `short`.
/// @param value Source value.
+ (SODataV4_short) shortValue :(SODataV4_float)value;
/// @internal
///
+ (nonnull NSString*) toExponential :(SODataV4_float)value;
/// @return `value` converted to type `string` in exponential format.
/// @param value Source value.
/// @param fractionDigits (optional) Number of fractional digits after the decimal point (defaults to 8).
/// @see JavaScript [Number.prototype.toExponential](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toExponential).
+ (nonnull NSString*) toExponential :(SODataV4_float)value :(SODataV4_int)fractionDigits;
/// @return `value` converted to type `string` in fixed-point format.
/// @param value Source value.
/// @param fractionDigits Number of fractional digits after the decimal point.
/// @see JavaScript [Number.prototype.toFixed](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed).
+ (nonnull NSString*) toFixed :(SODataV4_float)value :(SODataV4_int)fractionDigits;
/// @return `value` converted to type `string` in XML Schema format.
/// @param value Source value.
/// @see `SODataV4_SchemaFormat`.`formatFloat`.
+ (nonnull NSString*) toString :(SODataV4_float)value;
@end
#endif

#ifdef import_SODataV4__FloatMath_internal
#ifndef imported_SODataV4__FloatMath_internal
#define imported_SODataV4__FloatMath_public
/* internal */
/// @brief Contains all constants and functions from JavaScript [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) Object, for type `float`.
///
///
@interface SODataV4_FloatMath : SODataV4_ObjectBase
{
}
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
+ (SODataV4_float) abs :(SODataV4_float)x;
/// @return [Math.acos](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/acos)(x).
/// @param x Argument value.
+ (SODataV4_float) acos :(SODataV4_float)x;
/// @return [Math.asin](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/asin)(x).
/// @param x Argument value.
+ (SODataV4_float) asin :(SODataV4_float)x;
/// @return [Math.atan](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan)(x).
/// @param x Argument value.
+ (SODataV4_float) atan :(SODataV4_float)x;
/// @return [Math.atan2](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan2)(y, x).
/// @param y y-coordinate.
/// @param x x-coordinate.
+ (SODataV4_float) atan2 :(SODataV4_float)y :(SODataV4_float)x;
/// @return [Math.ceil](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/ceil)(x).
/// @param x Argument value.
+ (SODataV4_float) ceil :(SODataV4_float)x;
/// @return [Math.cos](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/cos)(x).
/// @param x Argument value.
+ (SODataV4_float) cos :(SODataV4_float)x;
/// @return [Math.exp](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/exp)(x).
/// @param x Argument value.
+ (SODataV4_float) exp :(SODataV4_float)x;
/// @return [Math.floor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/floor)(x).
/// @param x Argument value.
+ (SODataV4_float) floor :(SODataV4_float)x;
/// @return [Math.log](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/log)(x).
/// @param x Argument value.
+ (SODataV4_float) log :(SODataV4_float)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_float) max :(SODataV4_float)x :(SODataV4_float)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_float) min :(SODataV4_float)x :(SODataV4_float)y;
/// @return [Math.pow](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/pow)(x).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_float) pow :(SODataV4_float)x :(SODataV4_float)y;
/// @return [Math.random](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random)(x).
///
+ (SODataV4_float) random;
/// @return [Math.round](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)(x).
/// @param x Argument value.
+ (SODataV4_float) round :(SODataV4_float)x;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(SODataV4_float)x;
/// @return [Math.sin](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sin)(x).
/// @param x Argument value.
+ (SODataV4_float) sin :(SODataV4_float)x;
/// @return [Math.sqrt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sqrt)(x).
/// @param x Argument value.
+ (SODataV4_float) sqrt :(SODataV4_float)x;
/// @return [Math.tan](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/tan)(x).
/// @param x Argument value.
+ (SODataV4_float) tan :(SODataV4_float)x;
#define SODataV4_FloatMath_E 2.7182818284590452f
#define SODataV4_FloatMath_LN2 0.6931471805599453f
#define SODataV4_FloatMath_LN10 2.3025850929940460f
#define SODataV4_FloatMath_LOG2E 1.4426950408889634f
#define SODataV4_FloatMath_LOG10E 0.4342944819032518f
#define SODataV4_FloatMath_PI 3.1415926535897932f
#define SODataV4_FloatMath_SQRT1_2 0.7071067811865476f
#define SODataV4_FloatMath_SQRT2 1.4142135623730951f
@end
#endif
#endif

#ifndef imported_SODataV4__FloatOperator_public
#define imported_SODataV4__FloatOperator_public
/// @internal
///
@interface SODataV4_FloatOperator : SODataV4_ObjectBase
{
}
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `float`.
+ (SODataV4_float) add :(SODataV4_float)left :(SODataV4_float)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_float)left :(SODataV4_float)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `float`.
+ (SODataV4_float) divide :(SODataV4_float)left :(SODataV4_float)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_float)left :(SODataV4_float)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_float)left :(SODataV4_float)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_float)left :(SODataV4_float)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_float)left :(SODataV4_float)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_float)left :(SODataV4_float)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `float`.
+ (SODataV4_float) multiply :(SODataV4_float)left :(SODataV4_float)right;
/// @return `-value`.
/// @param value Operand value.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `float`.
+ (SODataV4_float) negate :(SODataV4_float)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_float)left :(SODataV4_float)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `float`.
+ (SODataV4_float) remainder :(SODataV4_float)left :(SODataV4_float)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `float`.
+ (SODataV4_float) subtract :(SODataV4_float)left :(SODataV4_float)right;
@end
#endif

#ifdef import_SODataV4__FloatOperator_internal
#ifndef imported_SODataV4__FloatOperator_internal
#define imported_SODataV4__FloatOperator_internal
@interface SODataV4_FloatOperator (internal)
+ (SODataV4_float) check :(SODataV4_float)value;
@end
#endif
#endif

#ifndef imported_SODataV4__GUID_public
#define imported_SODataV4__GUID_public
/// @internal
///
@interface SODataV4_GUID : SODataV4_ObjectBase
{
    @private NSData* _Nonnull bytes;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return GUID parsed from binary format (16 bytes), or `nil` if the data is not a valid GUID.
/// @param data Data to be parsed.
+ (nullable SODataV4_GUID*) fromBinary :(nonnull NSData*)data;
/// @return GUID parsed from string format (32 or 36 hexadecimal digits), or `nil` if the text is not a valid GUID.
/// @param text Text to be parsed.
+ (nullable SODataV4_GUID*) fromString :(nonnull NSString*)text;
/// @return a new type 4 (random) GUID.
///
+ (nonnull SODataV4_GUID*) newRandom;
/// @return This GUID in binary format (16 bytes).
///
- (nonnull NSData*) toBinary;
/// @return This GUID in string format (36 characters).
/// @see `SODataV4_GUID`.`toString36`.
- (nonnull NSString*) toString;
/// @return This GUID in string format (32 characters).
///
- (nonnull NSString*) toString32;
/// @return This GUID in string format (36 characters).
///
- (nonnull NSString*) toString36;
@end
#endif

#ifdef import_SODataV4__GUID_private
#ifndef imported_SODataV4__GUID_private
#define imported_SODataV4__GUID_private
@interface SODataV4_GUID (private)
+ (nonnull SODataV4_GUID*) new;
/// @brief Generate version 4 UUID bytes, "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
///
/// where "x" is hex, "y" is 8/9/A/B.
+ (nonnull NSData*) toVersion4 :(nonnull NSData*)bytes;
+ (nonnull SODataV4_GUID*) _new1 :(nonnull NSData*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__Ignore_public
#define imported_SODataV4__Ignore_public
/// @internal
///
@interface SODataV4_Ignore : SODataV4_ObjectBase
{
}
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_any :(nullable NSObject*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_binary :(nonnull NSData*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_boolean :(SODataV4_boolean)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_byte :(SODataV4_byte)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_char :(SODataV4_char)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_decimal :(nonnull SODataV4_BigDecimal*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_double :(SODataV4_double)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_error :(nullable NSException*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_float :(SODataV4_float)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_int :(SODataV4_int)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_integer :(nonnull SODataV4_BigInteger*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_long :(SODataV4_long)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableBinary :(nullable NSData*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableBoolean :(SODataV4_nullable_boolean)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableByte :(SODataV4_nullable_byte)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableChar :(SODataV4_nullable_char)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableDecimal :(nullable SODataV4_BigDecimal*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableDouble :(SODataV4_nullable_double)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableFloat :(SODataV4_nullable_float)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableInt :(SODataV4_nullable_int)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableInteger :(nullable SODataV4_BigInteger*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableLong :(SODataV4_nullable_long)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableShort :(SODataV4_nullable_short)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_nullableString :(nullable NSString*)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_short :(SODataV4_short)value;
/// @brief Call this function when you are marking intentional ignoring of a value, and you want to avoid compiler errors.
///
///
/// @param value Will be ignored.
+ (void) valueOf_string :(nonnull NSString*)value;
@end
#endif

#ifndef imported_SODataV4__IntConstant_public
#define imported_SODataV4__IntConstant_public
/// @internal
///
@interface SODataV4_IntConstant : SODataV4_ObjectBase
{
}
#define SODataV4_IntConstant_MIN_VALUE SODataV4_INT_MIN
#define SODataV4_IntConstant_MAX_VALUE 2147483647
@end
#endif

#ifdef import_SODataV4__IntDefault_internal
#ifndef imported_SODataV4__IntDefault_internal
#define imported_SODataV4__IntDefault_public
/* internal */
/// @brief Static functions to apply default values of type `int`.
///
///
@interface SODataV4_IntDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_int) ifNull :(SODataV4_nullable_int)value :(SODataV4_int)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (SODataV4_int) zeroIfNull :(SODataV4_nullable_int)value;
@end
#endif
#endif

#ifndef imported_SODataV4__IntFunction_public
#define imported_SODataV4__IntFunction_public
/// @internal
///
@interface SODataV4_IntFunction : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) toString :(SODataV4_int)value;
/// @return `value` converted to string, with caller-specified `radix`.
/// @param value Source value.
/// @param radix (optional) Radix, from 2 to 36.
+ (nonnull NSString*) toString :(SODataV4_int)value :(SODataV4_int)radix;
/// @return Character formatted as Unicode "{U+XXXX}", where "XXXX" is hexadecimal encoding.
/// @param value Character to be formatted.
+ (nonnull NSString*) unicodePlus :(SODataV4_int)value;
@end
#endif

#ifdef import_SODataV4__IntFunction_internal
#ifndef imported_SODataV4__IntFunction_internal
#define imported_SODataV4__IntFunction_internal
@interface SODataV4_IntFunction (internal)
+ (void) checkRadix :(SODataV4_int)radix;
/// @return The character representation of a digit `value` ('0'..'9', 'A'..'Z').
/// @param value Value from 0 to 35.
+ (SODataV4_char) toDigit :(SODataV4_int)value;
@end
#endif
#endif

#ifdef import_SODataV4__IntMath_internal
#ifndef imported_SODataV4__IntMath_internal
#define imported_SODataV4__IntMath_public
/* internal */
/// @brief A subset of JavaScript's [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) functions applicable to type `int`.
///
///
@interface SODataV4_IntMath : SODataV4_ObjectBase
{
}
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
/// @throw `SODataV4_OverflowException` if `x == int.MIN_VALUE`.
+ (SODataV4_int) abs :(SODataV4_int)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_int) max :(SODataV4_int)x :(SODataV4_int)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_int) min :(SODataV4_int)x :(SODataV4_int)y;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(SODataV4_int)x;
@end
#endif
#endif

#ifndef imported_SODataV4__IntOperator_public
#define imported_SODataV4__IntOperator_public
/// @internal
///
@interface SODataV4_IntOperator : SODataV4_ObjectBase
{
}
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `int`.
+ (SODataV4_int) add :(SODataV4_int)left :(SODataV4_int)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_int)left :(SODataV4_int)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `int`.
+ (SODataV4_int) divide :(SODataV4_int)left :(SODataV4_int)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_int)left :(SODataV4_int)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_int)left :(SODataV4_int)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_int)left :(SODataV4_int)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_int)left :(SODataV4_int)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_int)left :(SODataV4_int)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `int`.
+ (SODataV4_int) multiply :(SODataV4_int)left :(SODataV4_int)right;
/// @return `-value`.
/// @param value Operand value.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `int`.
+ (SODataV4_int) negate :(SODataV4_int)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_int)left :(SODataV4_int)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `int`.
+ (SODataV4_int) remainder :(SODataV4_int)left :(SODataV4_int)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `int`.
+ (SODataV4_int) subtract :(SODataV4_int)left :(SODataV4_int)right;
@end
#endif

#ifdef import_SODataV4__IntOperator_internal
#ifndef imported_SODataV4__IntOperator_internal
#define imported_SODataV4__IntOperator_internal
@interface SODataV4_IntOperator (internal)
+ (SODataV4_int) check :(SODataV4_long)value;
@end
#endif
#endif

#ifndef imported_SODataV4__IntegerConstant_public
#define imported_SODataV4__IntegerConstant_public
/// @internal
///
@interface SODataV4_IntegerConstant : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (nonnull SODataV4_BigInteger*) zero;
@end
#define SODataV4_IntegerConstant_zero [SODataV4_IntegerConstant zero]
#endif

#ifdef import_SODataV4__IntegerDefault_internal
#ifndef imported_SODataV4__IntegerDefault_internal
#define imported_SODataV4__IntegerDefault_public
/* internal */
/// @brief Static functions to apply default values of type `integer`.
///
///
@interface SODataV4_IntegerDefault : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull SODataV4_BigInteger*) ifNull :(nullable SODataV4_BigInteger*)value :(nonnull SODataV4_BigInteger*)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (nonnull SODataV4_BigInteger*) zeroIfNull :(nullable SODataV4_BigInteger*)value;
@end
#endif
#endif

#ifdef import_SODataV4__IntegerDefault_private
#ifndef imported_SODataV4__IntegerDefault_private
#define imported_SODataV4__IntegerDefault_private
@interface SODataV4_IntegerDefault (private)
+ (nonnull SODataV4_BigInteger*) INTEGER_ZERO;
@end
#define SODataV4_IntegerDefault_INTEGER_ZERO [SODataV4_IntegerDefault INTEGER_ZERO]
#endif
#endif

#ifndef imported_SODataV4__IntegerFunction_public
#define imported_SODataV4__IntegerFunction_public
/// @internal
///
@interface SODataV4_IntegerFunction : SODataV4_ObjectBase
{
}
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromByte :(SODataV4_byte)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromDecimal :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromDouble :(SODataV4_double)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromFloat :(SODataV4_float)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromInt :(SODataV4_int)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromLong :(SODataV4_long)value;
/// @return `value` converted to type `integer`.
/// @param value Source value.
+ (nonnull SODataV4_BigInteger*) fromShort :(SODataV4_short)value;
/// @return `value` converted to type `byte`.
/// @param value Source value.
+ (SODataV4_byte) toByte :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `decimal`.
/// @param value Source value.
+ (nonnull SODataV4_BigDecimal*) toDecimal :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `double`.
/// @param value Source value.
+ (SODataV4_double) toDouble :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `float`.
/// @param value Source value.
+ (SODataV4_float) toFloat :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `int`.
/// @param value Source value.
+ (SODataV4_int) toInt :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `long`.
/// @param value Source value.
+ (SODataV4_long) toLong :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `short`.
/// @param value Source value.
+ (SODataV4_short) toShort :(nonnull SODataV4_BigInteger*)value;
/// @return `value` converted to type `string`.
/// @param value Source value.
+ (nonnull NSString*) toString :(nonnull SODataV4_BigInteger*)value;
@end
#endif

#ifdef import_SODataV4__IntegerMath_internal
#ifndef imported_SODataV4__IntegerMath_internal
#define imported_SODataV4__IntegerMath_public
/* internal */
/// @brief A subset of JavaScript's [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) functions applicable to type `integer`.
///
///
@interface SODataV4_IntegerMath : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
+ (nonnull SODataV4_BigInteger*) abs :(nonnull SODataV4_BigInteger*)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (nonnull SODataV4_BigInteger*) max :(nonnull SODataV4_BigInteger*)x :(nonnull SODataV4_BigInteger*)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (nonnull SODataV4_BigInteger*) min :(nonnull SODataV4_BigInteger*)x :(nonnull SODataV4_BigInteger*)y;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(nonnull SODataV4_BigInteger*)x;
@end
#endif
#endif

#ifdef import_SODataV4__IntegerMath_private
#ifndef imported_SODataV4__IntegerMath_private
#define imported_SODataV4__IntegerMath_private
@interface SODataV4_IntegerMath (private)
+ (nonnull SODataV4_BigInteger*) INTEGER_ZERO;
@end
#define SODataV4_IntegerMath_INTEGER_ZERO [SODataV4_IntegerMath INTEGER_ZERO]
#endif
#endif

#ifndef imported_SODataV4__IntegerOperator_public
#define imported_SODataV4__IntegerOperator_public
/// @internal
///
@interface SODataV4_IntegerOperator : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigInteger*) add :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigInteger*) divide :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigInteger*) multiply :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @return `-value`.
/// @param value Operand value.
+ (nonnull SODataV4_BigInteger*) negate :(nonnull SODataV4_BigInteger*)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigInteger*) remainder :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
+ (nonnull SODataV4_BigInteger*) subtract :(nonnull SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
@end
#endif

#ifdef import_SODataV4__IntegerOperator_private
#ifndef imported_SODataV4__IntegerOperator_private
#define imported_SODataV4__IntegerOperator_private
@interface SODataV4_IntegerOperator (private)
+ (nonnull SODataV4_BigInteger*) INTEGER_ZERO;
@end
#define SODataV4_IntegerOperator_INTEGER_ZERO [SODataV4_IntegerOperator INTEGER_ZERO]
#endif
#endif

#ifndef imported_SODataV4__Logger_public
#define imported_SODataV4__Logger_public
/// @brief Logger facade.
///
/// API adapted from [SLF4J Logger](http://www.slf4j.org/api/org/slf4j/Logger.html).
@interface SODataV4_Logger : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_Logger*) new;
/// @internal
///
- (void) _init;
/// @internal
///
- (void) debug :(nonnull NSString*)message;
/// @internal
///
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at DEBUG level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) error :(nonnull NSString*)message;
/// @internal
///
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at ERROR level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) info :(nonnull NSString*)message;
/// @internal
///
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at INFO level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Is DEBUG level logging enabled?
///
///
- (SODataV4_boolean) isDebugEnabled;
/// @brief Is ERROR level logging enabled?
///
///
- (SODataV4_boolean) isErrorEnabled;
/// @brief Is INFO level logging enabled?
///
///
- (SODataV4_boolean) isInfoEnabled;
/// @brief Is TRACE level logging enabled?
///
///
- (SODataV4_boolean) isTraceEnabled;
/// @brief Is WARN level logging enabled?
///
///
- (SODataV4_boolean) isWarnEnabled;
/// @brief Logger name.
///
///
- (nonnull NSString*) name;
/// @internal
///
- (void) trace :(nonnull NSString*)message;
/// @internal
///
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at TRACE level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) warn :(nonnull NSString*)message;
/// @internal
///
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at WARN level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Is DEBUG level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isDebugEnabled;
/// @brief Is ERROR level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isErrorEnabled;
/// @brief Is INFO level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isInfoEnabled;
/// @brief Is TRACE level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isTraceEnabled;
/// @brief Is WARN level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isWarnEnabled;
/// @brief Logger name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* name;
@end
#endif

#ifndef imported_SODataV4__LoggerFactory_public
#define imported_SODataV4__LoggerFactory_public
/// @brief Logger factory.
///
/// API adapted from [SLF4J LoggerFactory](http://www.slf4j.org/api/org/slf4j/LoggerFactory.html).
@interface SODataV4_LoggerFactory : SODataV4_ObjectBase
{
}
/// @return A new logger.
/// @param name Logger name.
+ (nonnull SODataV4_Logger*) getLogger :(nonnull NSString*)name;
@end
#endif

#ifndef imported_SODataV4__LongConstant_public
#define imported_SODataV4__LongConstant_public
/// @internal
///
@interface SODataV4_LongConstant : SODataV4_ObjectBase
{
}
#define SODataV4_LongConstant_MIN_VALUE SODataV4_LONG_MIN
#define SODataV4_LongConstant_MAX_VALUE SODataV4_LONG(9223372036854775807)
@end
#endif

#ifdef import_SODataV4__LongDefault_internal
#ifndef imported_SODataV4__LongDefault_internal
#define imported_SODataV4__LongDefault_public
/* internal */
/// @brief Static functions to apply default values of type `long`.
///
///
@interface SODataV4_LongDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_long) ifNull :(SODataV4_nullable_long)value :(SODataV4_long)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (SODataV4_long) zeroIfNull :(SODataV4_nullable_long)value;
@end
#endif
#endif

#ifndef imported_SODataV4__LongFunction_public
#define imported_SODataV4__LongFunction_public
/// @internal
///
@interface SODataV4_LongFunction : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) toString :(SODataV4_long)value;
/// @return `value` converted to string, with caller-specified `radix`.
/// @param value Source value.
/// @param radix (optional) Radix, from 2 to 36.
+ (nonnull NSString*) toString :(SODataV4_long)value :(SODataV4_int)radix;
@end
#endif

#ifdef import_SODataV4__LongMath_internal
#ifndef imported_SODataV4__LongMath_internal
#define imported_SODataV4__LongMath_public
/* internal */
/// @brief A subset of JavaScript's [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) functions applicable to type `long`.
///
///
@interface SODataV4_LongMath : SODataV4_ObjectBase
{
}
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
/// @throw `SODataV4_OverflowException` if `x == long.MIN_VALUE`.
+ (SODataV4_long) abs :(SODataV4_long)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_long) max :(SODataV4_long)x :(SODataV4_long)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_long) min :(SODataV4_long)x :(SODataV4_long)y;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(SODataV4_long)x;
@end
#endif
#endif

#ifndef imported_SODataV4__LongOperator_public
#define imported_SODataV4__LongOperator_public
/// @internal
///
@interface SODataV4_LongOperator : SODataV4_ObjectBase
{
}
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `long`.
+ (SODataV4_long) add :(SODataV4_long)left :(SODataV4_long)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_long)left :(SODataV4_long)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `long`.
+ (SODataV4_long) divide :(SODataV4_long)left :(SODataV4_long)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_long)left :(SODataV4_long)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_long)left :(SODataV4_long)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_long)left :(SODataV4_long)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_long)left :(SODataV4_long)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_long)left :(SODataV4_long)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `long`.
+ (SODataV4_long) multiply :(SODataV4_long)left :(SODataV4_long)right;
/// @return `-value`.
/// @param value Operand value.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `long`.
+ (SODataV4_long) negate :(SODataV4_long)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_long)left :(SODataV4_long)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `long`.
+ (SODataV4_long) remainder :(SODataV4_long)left :(SODataV4_long)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `long`.
+ (SODataV4_long) subtract :(SODataV4_long)left :(SODataV4_long)right;
@end
#endif

#ifdef import_SODataV4__LongOperator_internal
#ifndef imported_SODataV4__LongOperator_internal
#define imported_SODataV4__LongOperator_internal
@interface SODataV4_LongOperator (internal)
+ (SODataV4_long) check :(nonnull SODataV4_BigInteger*)value;
@end
#endif
#endif

#ifndef imported_SODataV4__MapIteratorFromObject_public
#define imported_SODataV4__MapIteratorFromObject_public
/// @internal
///
@interface SODataV4_MapIteratorFromObject : SODataV4_ObjectBase
{
    @private NSDictionary* _dictionary;
    @private NSEnumerator* _iterator;
    @private NSObject* _Nullable _key;
    @private NSObject* _Nullable _value;
}
- (nonnull id) init;
/// @internal
///
- (void) _init :(nonnull NSObject*)map;
- (nullable NSObject*) key;
- (SODataV4_boolean) next;
- (nullable NSObject*) value;
@property (nonatomic, readonly, strong, nullable) NSObject* key;
@property (nonatomic, readonly, strong, nullable) NSObject* value;
@end
#endif

#ifdef import_SODataV4__MapIteratorFromObject_private
#ifndef imported_SODataV4__MapIteratorFromObject_private
#define imported_SODataV4__MapIteratorFromObject_private
@interface SODataV4_MapIteratorFromObject (private)
+ (nonnull SODataV4_MapIteratorFromObject*) new :(nonnull NSObject*)map;
@end
#endif
#endif

#ifndef imported_SODataV4__MapIteratorFromString_public
#define imported_SODataV4__MapIteratorFromString_public
/// @internal
///
@interface SODataV4_MapIteratorFromString : SODataV4_ObjectBase
{
    @private NSDictionary* _dictionary;
    @private NSEnumerator* _iterator;
    @private NSString* _Nonnull _key;
    @private NSObject* _Nullable _value;
}
- (nonnull id) init;
/// @internal
///
- (void) _init :(nonnull NSObject*)map;
- (nonnull NSString*) key;
- (SODataV4_boolean) next;
- (nullable NSObject*) value;
@property (nonatomic, readonly, strong, nonnull) NSString* key;
@property (nonatomic, readonly, strong, nullable) NSObject* value;
@end
#endif

#ifdef import_SODataV4__MapIteratorFromString_private
#ifndef imported_SODataV4__MapIteratorFromString_private
#define imported_SODataV4__MapIteratorFromString_private
@interface SODataV4_MapIteratorFromString (private)
+ (nonnull SODataV4_MapIteratorFromString*) new :(nonnull NSObject*)map;
@end
#endif
#endif

#ifdef import_SODataV4__MutableBoolean_internal
#ifndef imported_SODataV4__MutableBoolean_internal
#define imported_SODataV4__MutableBoolean_public
/* internal */
/// @brief Mutable value of type `boolean`.
///
///
@interface SODataV4_MutableBoolean : SODataV4_ObjectBase
{
    @private SODataV4_boolean value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_MutableBoolean*) new;
/// @internal
///
- (void) _init;
/// @brief Mutable `boolean` value.
///
///
- (void) setValue :(SODataV4_boolean)value;
/// @brief Mutable `boolean` value.
///
///
- (SODataV4_boolean) value;
/// @brief Mutable `boolean` value.
///
///
@property (nonatomic, readwrite) SODataV4_boolean value;
@end
#endif
#endif

#ifdef import_SODataV4__MutableInt_internal
#ifndef imported_SODataV4__MutableInt_internal
#define imported_SODataV4__MutableInt_public
/* internal */
/// @brief Mutable value of type `int`.
///
///
@interface SODataV4_MutableInt : SODataV4_ObjectBase
{
    @private SODataV4_int value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_MutableInt*) new;
/// @internal
///
- (void) _init;
/// @brief Increment the valueer.
///
///
/// @param value Increment value.
- (void) add :(SODataV4_int)value;
/// @brief Mutable `int` value.
///
///
- (void) setValue :(SODataV4_int)value;
/// @brief Mutable `int` value.
///
///
- (SODataV4_int) value;
/// @brief Mutable `int` value.
///
///
@property (nonatomic, readwrite) SODataV4_int value;
@end
#endif
#endif

#ifdef import_SODataV4__MutableLong_internal
#ifndef imported_SODataV4__MutableLong_internal
#define imported_SODataV4__MutableLong_public
/* internal */
/// @brief Mutable value of type `long`.
///
///
@interface SODataV4_MutableLong : SODataV4_ObjectBase
{
    @private SODataV4_long value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_MutableLong*) new;
/// @internal
///
- (void) _init;
/// @brief Increment the valueer.
///
///
/// @param value Increment value.
- (void) add :(SODataV4_long)value;
/// @brief Mutable `long` value.
///
///
- (void) setValue :(SODataV4_long)value;
/// @brief Mutable `long` value.
///
///
- (SODataV4_long) value;
/// @brief Mutable `long` value.
///
///
@property (nonatomic, readwrite) SODataV4_long value;
@end
#endif
#endif

#ifndef imported_SODataV4__NullableBinary_public
#define imported_SODataV4__NullableBinary_public
/// @internal
///
@interface SODataV4_NullableBinary : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nullable NSData*)left :(nullable NSData*)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (nonnull NSData*) getValue :(nullable NSData*)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(nullable NSData*)left :(nonnull NSData*)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(nullable NSData*)value;
/// @return `value.length` if value is non-null, otherwise return `defaultLength`.
/// @param value Nullable value.
/// @param defaultLength Default length.
+ (SODataV4_int) lengthWithDefault :(nullable NSData*)value :(SODataV4_int)defaultLength;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nullable NSData*)left :(nullable NSData*)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(nullable NSData*)value;
/// @return The `nil` `binary` value.
///
+ (nullable NSData*) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(nullable NSData*)value;
/// @return `value`, converted to a nullable `binary`.
/// @param value Argument value.
+ (nullable NSData*) withValue :(nonnull NSData*)value;
@end
#endif

#ifndef imported_SODataV4__NullableBoolean_public
#define imported_SODataV4__NullableBoolean_public
/// @internal
///
@interface SODataV4_NullableBoolean : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_boolean)left :(SODataV4_nullable_boolean)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_boolean) getValue :(SODataV4_nullable_boolean)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_boolean)left :(SODataV4_boolean)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_boolean)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_boolean)left :(SODataV4_nullable_boolean)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_boolean)value;
/// @return The `nil` `boolean` value.
///
+ (SODataV4_nullable_boolean) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_boolean)value;
/// @return `value`, converted to a nullable `boolean`.
/// @param value Argument value.
+ (SODataV4_nullable_boolean) withValue :(SODataV4_boolean)value;
@end
#endif

#ifndef imported_SODataV4__NullableByte_public
#define imported_SODataV4__NullableByte_public
/// @internal
///
@interface SODataV4_NullableByte : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_byte)left :(SODataV4_nullable_byte)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_byte) getValue :(SODataV4_nullable_byte)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_byte)left :(SODataV4_byte)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_byte)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_byte)left :(SODataV4_nullable_byte)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_byte)value;
/// @return The `nil` `byte` value.
///
+ (SODataV4_nullable_byte) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_byte)value;
/// @return `value`, converted to a nullable `byte`.
/// @param value Argument value.
+ (SODataV4_nullable_byte) withValue :(SODataV4_byte)value;
@end
#endif

#ifndef imported_SODataV4__NullableChar_public
#define imported_SODataV4__NullableChar_public
/// @internal
///
@interface SODataV4_NullableChar : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_char)left :(SODataV4_nullable_char)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_char) getValue :(SODataV4_nullable_char)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_char)left :(SODataV4_char)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_char)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_char)left :(SODataV4_nullable_char)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_char)value;
/// @return The `nil` `char` value.
///
+ (SODataV4_nullable_char) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_char)value;
/// @return `value`, converted to a nullable `char`.
/// @param value Argument value.
+ (SODataV4_nullable_char) withValue :(SODataV4_char)value;
@end
#endif

#ifndef imported_SODataV4__NullableDecimal_public
#define imported_SODataV4__NullableDecimal_public
/// @internal
///
@interface SODataV4_NullableDecimal : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nullable SODataV4_BigDecimal*)left :(nullable SODataV4_BigDecimal*)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (nonnull SODataV4_BigDecimal*) getValue :(nullable SODataV4_BigDecimal*)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(nullable SODataV4_BigDecimal*)left :(nonnull SODataV4_BigDecimal*)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(nullable SODataV4_BigDecimal*)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nullable SODataV4_BigDecimal*)left :(nullable SODataV4_BigDecimal*)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(nullable SODataV4_BigDecimal*)value;
/// @return The `nil` `decimal` value.
///
+ (nullable SODataV4_BigDecimal*) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(nullable SODataV4_BigDecimal*)value;
/// @return `value`, converted to a nullable `decimal`.
/// @param value Argument value.
+ (nullable SODataV4_BigDecimal*) withValue :(nonnull SODataV4_BigDecimal*)value;
@end
#endif

#ifndef imported_SODataV4__NullableDouble_public
#define imported_SODataV4__NullableDouble_public
/// @internal
///
@interface SODataV4_NullableDouble : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_double)left :(SODataV4_nullable_double)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_double) getValue :(SODataV4_nullable_double)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_double)left :(SODataV4_double)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_double)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_double)left :(SODataV4_nullable_double)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_double)value;
/// @return The `nil` `double` value.
///
+ (SODataV4_nullable_double) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_double)value;
/// @return `value`, converted to a nullable `double`.
/// @param value Argument value.
+ (SODataV4_nullable_double) withValue :(SODataV4_double)value;
@end
#endif

#ifndef imported_SODataV4__NullableFloat_public
#define imported_SODataV4__NullableFloat_public
/// @internal
///
@interface SODataV4_NullableFloat : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_float)left :(SODataV4_nullable_float)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_float) getValue :(SODataV4_nullable_float)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_float)left :(SODataV4_float)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_float)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_float)left :(SODataV4_nullable_float)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_float)value;
/// @return The `nil` `float` value.
///
+ (SODataV4_nullable_float) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_float)value;
/// @return `value`, converted to a nullable `float`.
/// @param value Argument value.
+ (SODataV4_nullable_float) withValue :(SODataV4_float)value;
@end
#endif

#ifndef imported_SODataV4__NullableInt_public
#define imported_SODataV4__NullableInt_public
/// @internal
///
@interface SODataV4_NullableInt : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_int)left :(SODataV4_nullable_int)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_int) getValue :(SODataV4_nullable_int)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_int)left :(SODataV4_int)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_int)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_int)left :(SODataV4_nullable_int)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_int)value;
/// @return The `nil` `int` value.
///
+ (SODataV4_nullable_int) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_int)value;
/// @return `value`, converted to a nullable `int`.
/// @param value Argument value.
+ (SODataV4_nullable_int) withValue :(SODataV4_int)value;
@end
#endif

#ifndef imported_SODataV4__NullableInteger_public
#define imported_SODataV4__NullableInteger_public
/// @internal
///
@interface SODataV4_NullableInteger : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nullable SODataV4_BigInteger*)left :(nullable SODataV4_BigInteger*)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (nonnull SODataV4_BigInteger*) getValue :(nullable SODataV4_BigInteger*)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(nullable SODataV4_BigInteger*)left :(nonnull SODataV4_BigInteger*)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(nullable SODataV4_BigInteger*)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nullable SODataV4_BigInteger*)left :(nullable SODataV4_BigInteger*)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(nullable SODataV4_BigInteger*)value;
/// @return The `nil` `integer` value.
///
+ (nullable SODataV4_BigInteger*) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(nullable SODataV4_BigInteger*)value;
/// @return `value`, converted to a nullable `integer`.
/// @param value Argument value.
+ (nullable SODataV4_BigInteger*) withValue :(nonnull SODataV4_BigInteger*)value;
@end
#endif

#ifndef imported_SODataV4__NullableLong_public
#define imported_SODataV4__NullableLong_public
/// @internal
///
@interface SODataV4_NullableLong : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_long)left :(SODataV4_nullable_long)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_long) getValue :(SODataV4_nullable_long)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_long)left :(SODataV4_long)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_long)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_long)left :(SODataV4_nullable_long)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_long)value;
/// @return The `nil` `long` value.
///
+ (SODataV4_nullable_long) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_long)value;
/// @return `value`, converted to a nullable `long`.
/// @param value Argument value.
+ (SODataV4_nullable_long) withValue :(SODataV4_long)value;
@end
#endif

#ifndef imported_SODataV4__NullableObject_public
#define imported_SODataV4__NullableObject_public
/// @internal
///
@interface SODataV4_NullableObject : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nullable NSObject*)left :(nullable NSObject*)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (nonnull NSObject*) getValue :(nullable NSObject*)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(nullable NSObject*)left :(nonnull NSObject*)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(nullable NSObject*)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nullable NSObject*)left :(nullable NSObject*)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(nullable NSObject*)value;
/// @return The `nil` `object` value.
///
+ (nullable NSObject*) nullValue;
/// @internal
///
+ (nonnull NSString*) toJSON :(nullable NSObject*)value;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(nullable NSObject*)value;
/// @return `value`, converted to a nullable `object`.
/// @param value Argument value.
+ (nullable NSObject*) withValue :(nonnull NSObject*)value;
@end
#endif

#ifndef imported_SODataV4__NullableShort_public
#define imported_SODataV4__NullableShort_public
/// @internal
///
@interface SODataV4_NullableShort : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_nullable_short)left :(SODataV4_nullable_short)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (SODataV4_short) getValue :(SODataV4_nullable_short)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(SODataV4_nullable_short)left :(SODataV4_short)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(SODataV4_nullable_short)value;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_nullable_short)left :(SODataV4_nullable_short)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(SODataV4_nullable_short)value;
/// @return The `nil` `short` value.
///
+ (SODataV4_nullable_short) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(SODataV4_nullable_short)value;
/// @return `value`, converted to a nullable `short`.
/// @param value Argument value.
+ (SODataV4_nullable_short) withValue :(SODataV4_short)value;
@end
#endif

#ifndef imported_SODataV4__NullableString_public
#define imported_SODataV4__NullableString_public
/// @internal
///
@interface SODataV4_NullableString : SODataV4_ObjectBase
{
}
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nullable NSString*)left :(nullable NSString*)right;
/// @return Non-`nil` value.
/// @param value Nullable value.
/// @throw `SODataV4_NullValueException` if `value` is `nil`.
+ (nonnull NSString*) getValue :(nullable NSString*)value;
/// @return `true` if `left == right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) hasValue :(nullable NSString*)left :(nonnull NSString*)right;
/// @return `true` if `value` is `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) isNull :(nullable NSString*)value;
/// @return `value.length` if value is non-null, otherwise return `defaultLength`.
/// @param value Nullable value.
/// @param defaultLength Default length.
+ (SODataV4_int) lengthWithDefault :(nullable NSString*)value :(SODataV4_int)defaultLength;
/// @return `true` if `left != right`, otherwise `false`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nullable NSString*)left :(nullable NSString*)right;
/// @return `true` if `value` is not `nil`, otherwise `false`.
/// @param value Argument value.
+ (SODataV4_boolean) notNull :(nullable NSString*)value;
/// @return The `nil` `string` value.
///
+ (nullable NSString*) nullValue;
/// @return "null" if `value` is `nil`, otherwise `value.toString()`.
/// @param value Argument value.
+ (nonnull NSString*) toString :(nullable NSString*)value;
/// @return `value`, converted to a nullable `string`.
/// @param value Argument value.
+ (nullable NSString*) withValue :(nonnull NSString*)value;
@end
#endif

#ifdef import_SODataV4__NumberParser_internal
#ifndef imported_SODataV4__NumberParser_internal
#define imported_SODataV4__NumberParser_public
/* internal */
/// @brief Parser for numeric values.
///
///
@interface SODataV4_NumberParser : SODataV4_ObjectBase
{
}
/// @brief Check if `value` is a valid value of type `byte`.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isByte :(nonnull NSString*)value;
/// @brief Check if `value` is a valid value of type `decimal`.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isDecimal :(nonnull NSString*)value;
/// @brief Check if `value` is a valid value of type `int`, in hexadecimnal format.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isHex :(nonnull NSString*)value;
/// @brief Check if `value` is a valid value of type `int`, in decimal or hexadecimal format.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isInt :(nonnull NSString*)value;
/// @brief Check if `value` is a valid value of type `integer`.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isInteger :(nonnull NSString*)value;
/// @brief Check if `value` is a valid value of type `long`.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isLong :(nonnull NSString*)value;
/// @brief Check if `value` is a valid value of type `short`.
///
///
/// @param value Numeric value in string format.
+ (SODataV4_boolean) isShort :(nonnull NSString*)value;
/// @return `value` parsed as a signed `byte`.
/// @param value Numeric value in string format.
+ (SODataV4_nullable_byte) parseByte :(nonnull NSString*)value;
/// @return `value` parsed as an `int` in unsigned hexadecimal format.
/// @param value Numeric value in string format, starting with "0x" or "0X".
+ (SODataV4_nullable_int) parseHex :(nonnull NSString*)value;
/// @internal
///
+ (SODataV4_nullable_int) parseInt :(nonnull NSString*)value;
/// @return `value` parsed as a signed `int` in the specified `radix`.
/// @param value Numeric value in string format.
/// @param radix (optional) Radix, 2 to 36.
+ (SODataV4_nullable_int) parseInt :(nonnull NSString*)value :(SODataV4_int)radix;
/// @return `value` parsed as a signed `long`.
/// @param value Numeric value in string format.
+ (SODataV4_nullable_long) parseLong :(nonnull NSString*)value;
/// @return `value` parsed as a signed `short`.
/// @param value Numeric value in string format.
+ (SODataV4_nullable_short) parseShort :(nonnull NSString*)value;
#define SODataV4_NumberParser_MIN_BYTE @"-128"
#define SODataV4_NumberParser_MAX_BYTE @"127"
#define SODataV4_NumberParser_MIN_SHORT @"-32768"
#define SODataV4_NumberParser_MAX_SHORT @"32767"
#define SODataV4_NumberParser_MIN_INT @"-2147483648"
#define SODataV4_NumberParser_MAX_INT @"2147483647"
#define SODataV4_NumberParser_MIN_LONG @"-9223372036854775808"
#define SODataV4_NumberParser_MAX_LONG @"9223372036854775807"
@end
#endif
#endif

#ifdef import_SODataV4__NumberParser_private
#ifndef imported_SODataV4__NumberParser_private
#define imported_SODataV4__NumberParser_private
@interface SODataV4_NumberParser (private)
+ (SODataV4_int) getDigit :(SODataV4_char)c;
+ (SODataV4_boolean) isIntegral :(nonnull NSString*)value :(nonnull NSString*)min :(nonnull NSString*)max;
+ (SODataV4_boolean) isNumber :(nonnull NSString*)value :(nonnull NSString*)min :(nonnull NSString*)max :(SODataV4_boolean)allowDot;
@end
#endif
#endif

#ifndef imported_SODataV4__ObjectAsAny_public
#define imported_SODataV4__ObjectAsAny_public
/// @internal
///
@interface SODataV4_ObjectAsAny : SODataV4_ObjectBase
{
}
+ (nullable NSObject*) cast :(nullable NSObject*)value;
@end
#endif

#ifndef imported_SODataV4__ObjectFactory_public
#define imported_SODataV4__ObjectFactory_public
/// @internal
///
@interface SODataV4_ObjectFactory : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ObjectFactory*) new;
/// @internal
///
- (void) _init;
/// @return Newly created object.
///
- (nonnull NSObject*) create;
@end
#endif

#ifndef imported_SODataV4__ObjectFunction_public
#define imported_SODataV4__ObjectFunction_public
/// @internal
///
@interface SODataV4_ObjectFunction : SODataV4_ObjectBase
{
}
/// @brief Convert `value` to [JSON](http://json.org) representation.
///
///
/// @param value Value to be formatted, which should be a subtype of `DataValue`.
+ (nonnull NSString*) toJSON :(nonnull NSObject*)value;
/// @brief Convert `value` to a `string`.
///
///
/// @param value Source value.
+ (nonnull NSString*) toString :(nonnull NSObject*)value;
@end
#endif

#ifndef imported_SODataV4__ObjectIsAny_public
#define imported_SODataV4__ObjectIsAny_public
/// @internal
///
@interface SODataV4_ObjectIsAny : SODataV4_ObjectBase
{
}
+ (SODataV4_boolean) check :(nullable NSObject*)value;
@end
#endif

#ifndef imported_SODataV4__ObjectOperator_public
#define imported_SODataV4__ObjectOperator_public
/// @internal
///
@interface SODataV4_ObjectOperator : SODataV4_ObjectBase
{
}
/// @brief Compare `left` operand with `right` operand, using [reference equality](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators).
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nonnull NSObject*)left :(nonnull NSObject*)right;
/// @brief Compare `left` operand with `right` operand, using [reference equality](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators).
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nonnull NSObject*)left :(nonnull NSObject*)right;
@end
#endif

#ifdef import_SODataV4__OutOfMemory_internal
#ifndef imported_SODataV4__OutOfMemory_internal
#define imported_SODataV4__OutOfMemory_public
/* internal */
@interface SODataV4_OutOfMemory : SODataV4_ObjectBase
{
}
+ (void) logErrorAndAbort;
@end
#endif
#endif

#ifdef import_SODataV4__PearsonHashing_internal
#ifndef imported_SODataV4__PearsonHashing_internal
#define imported_SODataV4__PearsonHashing_public
/* internal */
/// @brief An implementation of "Fast Hashing of Variable-Length Text Strings".
///
/// See [Communications of the ACM, June 1990 Volume 33 Number 6](http://cs.mwsu.edu/~griffin/courses/2133/downloads/Spring11/p677-pearson.pdf).
@interface SODataV4_PearsonHashing : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @brief Hash `data` using the Pearson Hashing algorithm.
///
///
/// @return Hash value (between int.MIN_VALUE and int.MAX_VALUE).
/// @param data Value to be hashed.
+ (SODataV4_int) hashBinary :(nonnull NSData*)data;
/// @brief Hash `text` using the Pearson Hashing algorithm.
///
///
/// @return Hash value (between int.MIN_VALUE and int.MAX_VALUE).
/// @param text Value to be hashed.
+ (SODataV4_int) hashString :(nonnull NSString*)text;
@end
#endif
#endif

#ifdef import_SODataV4__PearsonHashing_private
#ifndef imported_SODataV4__PearsonHashing_private
#define imported_SODataV4__PearsonHashing_private
@interface SODataV4_PearsonHashing (private)
+ (nonnull NSData*) TABLE;
@end
#define SODataV4_PearsonHashing_TABLE [SODataV4_PearsonHashing TABLE]
#endif
#endif

#ifdef import_SODataV4__ReentrantMutex_internal
#ifndef imported_SODataV4__ReentrantMutex_internal
#define imported_SODataV4__ReentrantMutex_public
/* internal */
/// @brief A [reentrant mutex](https://en.wikipedia.org/wiki/Reentrant_mutex).
///
///
@interface SODataV4_ReentrantMutex : SODataV4_ObjectBase
{
    /* internal */ @public pthread_mutex_t mutex;
}
- (nonnull id) init;
+ (nonnull SODataV4_ReentrantMutex*) new;
/// @internal
///
- (void) _init;
- (void) dealloc;
/// @brief Lock the mutex, blocking until it can be locked.
///
///
- (void) lock;
/// @return `true` (and lock the mutex) if the mutex can be locked without blocking, otherwise `false`.
///
- (SODataV4_boolean) tryLock;
/// @brief Unlock the mutex, which must have previously been locked by the current thread using `SODataV4_ReentrantMutex`.`lock` or `SODataV4_ReentrantMutex`.`tryLock`.
///
///
- (void) unlock;
@end
#endif
#endif

#ifdef import_SODataV4__RunAction_internal
#ifndef imported_SODataV4__RunAction_internal
#define imported_SODataV4__RunAction_public
/* internal */
/// @brief Abstract base class for parameterless actions.
///
///
@interface SODataV4_RunAction : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_RunAction*) new;
/// @internal
///
- (void) _init;
/// @brief Execute a parameterless action.
///
///
- (void) run;
@end
#endif
#endif

#ifdef import_SODataV4__RunFunction_internal
#ifndef imported_SODataV4__RunFunction_internal
#define imported_SODataV4__RunFunction_public
/* internal */
/// @brief Abstract base class for parameterless actions.
///
///
@interface SODataV4_RunFunction : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_RunFunction*) new;
/// @internal
///
- (void) _init;
/// @brief Execute a parameterless function.
///
///
/// @return The function result.
- (nullable NSObject*) run;
@end
#endif
#endif

#ifdef import_SODataV4__SchemaFormat_internal
#ifndef imported_SODataV4__SchemaFormat_internal
#define imported_SODataV4__SchemaFormat_public
/* internal */
/// @brief Provides static functions for converting data values to and from the lexical representations defined in [XML Schema Part 2: Datatypes](http://www.w3.org/TR/xmlschema11-2/).
///
///
@interface SODataV4_SchemaFormat : SODataV4_ObjectBase
{
}
/// @return `value` formatted using XML Schema lexical representation for type `boolean`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatBoolean :(SODataV4_boolean)value;
/// @return `value` formatted using XML Schema lexical representation for type `byte`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatByte :(SODataV4_byte)value;
/// @return `value` formatted using XML Schema lexical representation for type `decimal`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatDecimal :(nonnull SODataV4_BigDecimal*)value;
/// @return `value` formatted using XML Schema lexical representation for type `double`, or "NaN" / "Infinity" / "-Infinity".
/// @param value Value to be formatted.
+ (nonnull NSString*) formatDouble :(SODataV4_double)value;
/// @return `value` formatted using XML Schema lexical representation for type `float`, or "NaN" / "Infinity" / "-Infinity".
/// @param value Value to be formatted.
+ (nonnull NSString*) formatFloat :(SODataV4_float)value;
/// @return `value` formatted using XML Schema lexical representation for type `int`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatInt :(SODataV4_int)value;
/// @return `value` formatted using XML Schema lexical representation for type `integer`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatInteger :(nonnull SODataV4_BigInteger*)value;
/// @return `value` formatted using XML Schema lexical representation for type `long`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatLong :(SODataV4_long)value;
/// @return `value` formatted using XML Schema lexical representation for type `short`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatShort :(SODataV4_short)value;
/// @return `value` formatted using XML Schema lexical representation for type `unsignedByte`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatUnsignedByte :(SODataV4_int)value;
/// @return `value` formatted using XML Schema lexical representation for type `unsignedByte`.
/// @param value Value to be formatted.
+ (nonnull NSString*) formatUnsignedShort :(SODataV4_int)value;
/// @return `value` parsed from XML Schema lexical representation for type `boolean`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_boolean) parseBoolean :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `byte`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_byte) parseByte :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `decimal`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (nullable SODataV4_BigDecimal*) parseDecimal :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `double`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_double) parseDouble :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `float`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_float) parseFloat :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `int`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_int) parseInt :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `integer`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (nullable SODataV4_BigInteger*) parseInteger :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `long`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_long) parseLong :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `short`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_short) parseShort :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `unsignedByte`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_int) parseUnsignedByte :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `unsignedSHort`.
/// @throw `SODataV4_FormatException` (non-fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_nullable_int) parseUnsignedShort :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `boolean`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_boolean) toBoolean :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `byte`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_byte) toByte :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `decimal`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (nonnull SODataV4_BigDecimal*) toDecimal :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `double`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_double) toDouble :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `float`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_float) toFloat :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `int`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_int) toInt :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `integer`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (nonnull SODataV4_BigInteger*) toInteger :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `long`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_long) toLong :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `short`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_short) toShort :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `unsignedByte`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_int) toUnsignedByte :(nonnull NSString*)text;
/// @return `value` parsed from XML Schema lexical representation for type `unsignedSHort`.
/// @throw `SODataV4_FormatException` (fatal) if the value is not in the expected format.
/// @param text XML Schema lexical representation for value to be parsed.
+ (SODataV4_int) toUnsignedShort :(nonnull NSString*)text;
@end
#endif
#endif

#ifdef import_SODataV4__SchemaFormat_internal
#ifndef imported_SODataV4__SchemaFormat_internal
#define imported_SODataV4__SchemaFormat_internal
@interface SODataV4_SchemaFormat (internal)
+ (nonnull NSString*) prettyExponential :(nonnull NSString*)text;
@end
#endif
#endif

#ifndef imported_SODataV4__ShortConstant_public
#define imported_SODataV4__ShortConstant_public
/// @internal
///
@interface SODataV4_ShortConstant : SODataV4_ObjectBase
{
}
#define SODataV4_ShortConstant_MIN_VALUE SODataV4_SHORT(-32768)
#define SODataV4_ShortConstant_MAX_VALUE SODataV4_SHORT(32767)
@end
#endif

#ifdef import_SODataV4__ShortDefault_internal
#ifndef imported_SODataV4__ShortDefault_internal
#define imported_SODataV4__ShortDefault_public
/* internal */
/// @brief Static functions to apply default values of type `short`.
///
///
@interface SODataV4_ShortDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_short) ifNull :(SODataV4_nullable_short)value :(SODataV4_short)defaultValue;
/// @return `value` if it is not `nil`, otherwise return zero.
/// @param value Nullable value.
+ (SODataV4_short) zeroIfNull :(SODataV4_nullable_short)value;
@end
#endif
#endif

#ifndef imported_SODataV4__ShortFunction_public
#define imported_SODataV4__ShortFunction_public
/// @internal
///
@interface SODataV4_ShortFunction : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) toString :(SODataV4_short)value;
/// @return `value` converted to string, with caller-specified `radix`.
/// @param value Source value.
/// @param radix (optional) Radix, from 2 to 36.
+ (nonnull NSString*) toString :(SODataV4_short)value :(SODataV4_int)radix;
/// @return `value` converted to unsigned `int`.
/// @param value Source value.
+ (SODataV4_int) toUnsigned :(SODataV4_short)value;
@end
#endif

#ifdef import_SODataV4__ShortMath_internal
#ifndef imported_SODataV4__ShortMath_internal
#define imported_SODataV4__ShortMath_public
/* internal */
/// @brief A subset of JavaScript's [Math](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Math) functions applicable to type `short`.
///
///
@interface SODataV4_ShortMath : SODataV4_ObjectBase
{
}
/// @return [Math.abs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs)(x).
/// @param x Argument value.
/// @throw `SODataV4_OverflowException` if `x == short.MIN_VALUE`.
+ (SODataV4_short) abs :(SODataV4_short)x;
/// @return [Math.max](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_short) max :(SODataV4_short)x :(SODataV4_short)y;
/// @return [Math.min](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min)(x, y).
/// @param x First argument.
/// @param y Second argument.
+ (SODataV4_short) min :(SODataV4_short)x :(SODataV4_short)y;
/// @return [Math.sign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign)(x).
/// @param x Argument value.
+ (SODataV4_int) sign :(SODataV4_short)x;
@end
#endif
#endif

#ifndef imported_SODataV4__ShortOperator_public
#define imported_SODataV4__ShortOperator_public
/// @internal
///
@interface SODataV4_ShortOperator : SODataV4_ObjectBase
{
}
/// @return `left + right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `short`.
+ (SODataV4_short) add :(SODataV4_short)left :(SODataV4_short)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(SODataV4_short)left :(SODataV4_short)right;
/// @return `left / right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `short`.
+ (SODataV4_short) divide :(SODataV4_short)left :(SODataV4_short)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(SODataV4_short)left :(SODataV4_short)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(SODataV4_short)left :(SODataV4_short)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(SODataV4_short)left :(SODataV4_short)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(SODataV4_short)left :(SODataV4_short)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(SODataV4_short)left :(SODataV4_short)right;
/// @return `left * right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `short`.
+ (SODataV4_short) multiply :(SODataV4_short)left :(SODataV4_short)right;
/// @return `-value`.
/// @param value Operand value.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `short`.
+ (SODataV4_short) negate :(SODataV4_short)value;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(SODataV4_short)left :(SODataV4_short)right;
/// @return `left % right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `short`.
+ (SODataV4_short) remainder :(SODataV4_short)left :(SODataV4_short)right;
/// @return `left - right`.
/// @param left Left operand.
/// @param right Right operand.
/// @throw `SODataV4_OverflowException` if the result is out of range for type `short`.
+ (SODataV4_short) subtract :(SODataV4_short)left :(SODataV4_short)right;
@end
#endif

#ifdef import_SODataV4__ShortOperator_internal
#ifndef imported_SODataV4__ShortOperator_internal
#define imported_SODataV4__ShortOperator_internal
@interface SODataV4_ShortOperator (internal)
+ (SODataV4_short) check :(SODataV4_int)value;
@end
#endif
#endif

#ifndef imported_SODataV4__StringComparer_public
#define imported_SODataV4__StringComparer_public
/// @internal
///
@interface SODataV4_StringComparer : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @brief Comparer for `string` values with case-insensitive comparison.
///
///
+ (nonnull SODataV4_Comparer*) ignoreCase;
/// @brief Comparer for `string` values with case-insensitive comparison.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Comparer* ignoreCase;
@end
#endif

#ifndef imported_SODataV4__StringConstant_public
#define imported_SODataV4__StringConstant_public
/// @internal
///
@interface SODataV4_StringConstant : SODataV4_ObjectBase
{
}
#define SODataV4_StringConstant_empty @""
@end
#endif

#ifdef import_SODataV4__StringDefault_internal
#ifndef imported_SODataV4__StringDefault_internal
#define imported_SODataV4__StringDefault_public
/* internal */
/// @brief Static functions to apply default values of type `string`.
///
///
@interface SODataV4_StringDefault : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return empty string.
/// @param value Nullable value.
+ (nonnull NSString*) emptyIfNull :(nullable NSString*)value;
/// @return `value` if it is not `nil` or empty, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull NSString*) ifEmpty :(nullable NSString*)value :(nonnull NSString*)defaultValue;
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull NSString*) ifNull :(nullable NSString*)value :(nonnull NSString*)defaultValue;
/// @return `nil` if `value` is `nil` or empty, otherwise return `value`.
/// @param value Nullable value.
+ (nullable NSString*) nullIfEmpty :(nullable NSString*)value;
@end
#endif
#endif

#ifndef imported_SODataV4__StringEquality_public
#define imported_SODataV4__StringEquality_public
/// @internal
///
@interface SODataV4_StringEquality : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @brief Equality for `string` values with case-insensitive equality.
///
///
+ (nonnull SODataV4_Equality*) ignoreCase;
/// @brief Equality for `string` values with case-insensitive equality.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Equality* ignoreCase;
@end
#endif

#ifndef imported_SODataV4__StringFunction_public
#define imported_SODataV4__StringFunction_public
/// @internal
///
@interface SODataV4_StringFunction : SODataV4_ObjectBase
{
}
/// @return The characters of `value` after the first occurrence of `text`, or an empty string if `text` is not found.
/// @param value Source string.
/// @param text String to search for.
+ (nonnull NSString*) afterFirst :(nonnull NSString*)value :(nonnull NSString*)text;
/// @return The characters of `value` after the last occurrence of `text`, or an empty string if `text` is not found.
/// @param value Source string.
/// @param text String to search for.
+ (nonnull NSString*) afterLast :(nonnull NSString*)value :(nonnull NSString*)text;
/// @return The characters of `value` before the first occurrence of `text`, or all of `value` if `text` is not found.
/// @param value Source string.
/// @param text String to search for.
+ (nonnull NSString*) beforeFirst :(nonnull NSString*)value :(nonnull NSString*)text;
/// @return The characters of `value` before the last occurrence of `text`, or all of `value` if `text` is not found.
/// @param value Source string.
/// @param text String to search for.
+ (nonnull NSString*) beforeLast :(nonnull NSString*)value :(nonnull NSString*)text;
/// @brief Compare string `value` with `other` string value.
///
///
/// @return Negative result if `value < other`, zero result if `value == other`, positive result if `value > other`.
/// @param value Source string.
/// @param other Other string value for comparison.
+ (SODataV4_int) compareTo :(nonnull NSString*)value :(nonnull NSString*)other;
/// @internal
///
+ (SODataV4_boolean) endsWith :(nonnull NSString*)value :(nonnull NSString*)suffix;
/// @brief Determine whether `value` ends with the characters of `text`, returning `true` or `false` as appropriate.
///
///
/// @return `true` if `value` (ending at `end`) ends with `suffix`.
/// @param value Source string.
/// @param suffix Suffix to check for.
/// @param end Optional end position (defaults to `value.length`).
/// @see JavaScript [String.prototype.endsWith](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/endsWith).
+ (SODataV4_boolean) endsWith :(nonnull NSString*)value :(nonnull NSString*)suffix :(SODataV4_int)end;
/// @brief Compare string `value` for equality with `other` string value, ignoring case.
///
///
/// @return `true` if the values are equal (ignoring case), otherwise `false`.
/// @param value Source string.
/// @param other Other string value for comparison.
+ (SODataV4_boolean) equalsIgnoreCase :(nonnull NSString*)value :(nonnull NSString*)other;
/// @return A hash code for `value`.
/// @param value Source string.
/// @see `SODataV4_PearsonHashing`.
+ (SODataV4_int) hashCode :(nonnull NSString*)value;
/// @return A copy of `value` with HTML reserved characters replaced with HTML entity escapes. Other characters are unchanged.
/// @param value Source string.
+ (nonnull NSString*) htmlEscape :(nonnull NSString*)value;
/// @internal
///
+ (SODataV4_boolean) includes :(nonnull NSString*)value :(nonnull NSString*)text;
/// @brief Determine whether `text` may be found within `value`, returning `true` or `false` as appropriate.
///
///
/// @return `true` if `text` is found within `value`.
/// @param value Source string.
/// @param text Text to be located.
/// @param start Optional start position (defaults to 0).
/// @see JavaScript [String.prototype.includes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes).
+ (SODataV4_boolean) includes :(nonnull NSString*)value :(nonnull NSString*)text :(SODataV4_int)start;
/// @brief Determine if any of `chars` may be found within `value`, returning `true` or `false` as appropriate.
///
///
/// @return `true' if `value` contains any of `chars'.
/// @param value Source string.
/// @param chars Match characters.
+ (SODataV4_boolean) includesAny :(nonnull NSString*)value :(nonnull NSString*)chars;
/// @internal
///
+ (SODataV4_boolean) includesChar :(nonnull NSString*)value :(SODataV4_char)text;
/// @brief Determine whether `text` may be found within `value`, returning `true` or `false` as appropriate.
///
///
/// @return `true` if `text` is found within `value`.
/// @param value Source string.
/// @param text Character to be located.
/// @param start Optional start position (defaults to 0).
/// @see JavaScript [String.prototype.includes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes).
+ (SODataV4_boolean) includesChar :(nonnull NSString*)value :(SODataV4_char)text :(SODataV4_int)start;
/// @internal
///
+ (SODataV4_int) indexOf :(nonnull NSString*)value :(nonnull NSString*)find;
/// @brief Locates `find` within `value`, searching forwards from `start`.
///
///
/// @return Zero-based index where `text` is found within `value`, or -1 if not found.
/// @param value Source string.
/// @param find Text to be located.
/// @param start Optional start position (defaults to 0).
/// @see JavaScript [String.prototype.indexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf).
+ (SODataV4_int) indexOf :(nonnull NSString*)value :(nonnull NSString*)find :(SODataV4_int)start;
/// @internal
///
+ (SODataV4_int) indexOfAny :(nonnull NSString*)value :(nonnull NSString*)chars;
/// @return The first index within `value` containing one of `chars`, or -1 if not found.
/// @param value Source string.
/// @param chars Match characters.
/// @param start Optional start position (defaults to 0).
+ (SODataV4_int) indexOfAny :(nonnull NSString*)value :(nonnull NSString*)chars :(SODataV4_int)start;
/// @internal
///
+ (SODataV4_int) indexOfChar :(nonnull NSString*)value :(SODataV4_char)find;
/// @brief Locates `find` within `value`, searching forwards from `start`.
///
///
/// @return Zero-based index where `text` is found within `value`, or -1 if not found.
/// @param value Source string.
/// @param find Text to be located.
/// @param start Optional start position (defaults to 0).
/// @see JavaScript [String.prototype.indexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf).
+ (SODataV4_int) indexOfChar :(nonnull NSString*)value :(SODataV4_char)find :(SODataV4_int)start;
/// @return The string with the inserted value.
/// @param value The source string.
/// @param insert The string to be inserted.
/// @param index The index where the value should be inserted. If index is negative it will be insterted to the beginning of the value, if index is higher than the length of the value, it will be inserted to the end of the value.
+ (nonnull NSString*) insert :(nonnull NSString*)value :(nonnull NSString*)insert :(SODataV4_int)index;
/// @return `true` if `value` is empty.
/// @param value Source string.
+ (SODataV4_boolean) isEmpty :(nonnull NSString*)value;
/// @internal
///
+ (SODataV4_int) lastIndexOf :(nonnull NSString*)value :(nonnull NSString*)find;
/// @brief Locates `text` within `value`, searching backwards from `start`.
///
///
/// @return Zero-based index where `text` is found within `value`, or -1 if not found.
/// @param value Source string.
/// @param find Text to be located.
/// @param start Optional start position (defaults to `value.length`).
/// @see JavaScript [String.prototype.lastIndexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/lastIndexOf).
+ (SODataV4_int) lastIndexOf :(nonnull NSString*)value :(nonnull NSString*)find :(SODataV4_int)start;
/// @internal
///
+ (SODataV4_int) lastIndexOfAny :(nonnull NSString*)value :(nonnull NSString*)chars;
/// @return The last index within `value` containing one of `chars`, or -1 if not found.
/// @param value Source string.
/// @param chars Match characters.
/// @param start Optional start position (defaults to `value.length`).
+ (SODataV4_int) lastIndexOfAny :(nonnull NSString*)value :(nonnull NSString*)chars :(SODataV4_int)start;
/// @internal
///
+ (SODataV4_int) lastIndexOfChar :(nonnull NSString*)value :(SODataV4_char)find;
/// @brief Locates `text` within `value`, searching backwards from `start`.
///
///
/// @return Zero-based index where `text` is found within `value`, or -1 if not found.
/// @param value Source string.
/// @param find Text to be located.
/// @param start Optional start position (defaults to `value.length`).
/// @see JavaScript [String.prototype.lastIndexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/lastIndexOf).
+ (SODataV4_int) lastIndexOfChar :(nonnull NSString*)value :(SODataV4_char)find :(SODataV4_int)start;
/// @return A copy of `value` with the first character (if any) converted to lower case.
/// @param value String to be converted.
+ (nonnull NSString*) lowerFirst :(nonnull NSString*)value;
/// @internal
///
+ (nonnull NSString*) padLeft :(nonnull NSString*)value :(SODataV4_int)maxLength;
/// @return A copy of `value` padded on the left with `fillStr` up to maximum length `maxLength`.
/// @param value Source string.
/// @param maxLength Maximum length.
/// @param fillStr Optional. Fill string. Defaults to " ".
/// @see [strawman:string_padding](http://wiki.ecmascript.org/doku.php?id=strawman:string_padding).
+ (nonnull NSString*) padLeft :(nonnull NSString*)value :(SODataV4_int)maxLength :(nonnull NSString*)fillStr;
/// @internal
///
+ (nonnull NSString*) padRight :(nonnull NSString*)value :(SODataV4_int)maxLength;
/// @return A copy of `value` padded on the right with `fillStr` up to maximum length `maxLength`.
/// @param value Source string.
/// @param maxLength Maximum length.
/// @param fillStr Optional. Fill string. Defaults to " ".
/// @see [strawman:string_padding](http://wiki.ecmascript.org/doku.php?id=strawman:string_padding).
+ (nonnull NSString*) padRight :(nonnull NSString*)value :(SODataV4_int)maxLength :(nonnull NSString*)fillStr;
/// @brief Percent-decode a URI component. See [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt) section 2.4.
///
///
/// @return Decoded string.
/// @param value Source string.
+ (nonnull NSString*) percentDecode :(nonnull NSString*)value;
/// @brief Percent-encode a URI component. See [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt) section 2.4.
///
///
/// @return Encoded string.
/// @param value Source string.
+ (nonnull NSString*) percentEncode :(nonnull NSString*)value;
/// @brief Percent-encoding normalization of a URI component. See [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt) section 6.2.2.2.
///
///
/// @return Normalized string.
/// @param value Source string.
+ (nonnull NSString*) percentNormal :(nonnull NSString*)value;
/// @return The `value` converted to a pretty name (using camel-case).
/// @param value Source string.
/// @param upperFirst Should the target name start with upper case?
+ (nonnull NSString*) prettyName :(nonnull NSString*)value :(SODataV4_boolean)upperFirst;
/// @return A copy of `value` which omits the specified `prefix`, if present.
/// @param value Source string.
/// @param prefix Prefix to be removed, if present.
+ (nonnull NSString*) removePrefix :(nonnull NSString*)value :(nonnull NSString*)prefix;
/// @return A copy of `value` which omits the specified `suffix`, if present.
/// @param value Source string.
/// @param suffix Suffix to be removed, if present.
+ (nonnull NSString*) removeSuffix :(nonnull NSString*)value :(nonnull NSString*)suffix;
/// @return A new string which contains `count` copies of `value`, concatenated together.
/// @param value Source string.
/// @param count Repeat count.
/// @see JavaScript [String.prototype.repeat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/repeat).
+ (nonnull NSString*) repeat :(nonnull NSString*)value :(SODataV4_int)count;
/// @return A copy of `value` with the first occurrence of `text` replaced with `newText`.
/// @param value Source string.
/// @param text Search text.
/// @param newText Replacement text.
/// @see JavaScript [String.prototype.replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace).
+ (nonnull NSString*) replace :(nonnull NSString*)value :(nonnull NSString*)text :(nonnull NSString*)newText;
/// @return A copy of `value` with all occurrences of `text` replaced with `newText`.
/// @param value Source string.
/// @param text Search text.
/// @param newText Replacement text.
/// @see JavaScript [String.prototype.replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace).
+ (nonnull NSString*) replaceAll :(nonnull NSString*)value :(nonnull NSString*)text :(nonnull NSString*)newText;
/// @internal
///
+ (nonnull NSString*) slice :(nonnull NSString*)value :(SODataV4_int)start;
/// @return A section of `value` beginning at `start`, through to `end`. Allows negative values for `start` / `end` to specify end-relative positions.
/// @param value Source string.
/// @param start The zero-based index at which to begin extraction from the source string. If negative, it is treated as `value.length + start`.
/// @param end Optional. The zero-based index at which to end extraction from the source string. If omitted, `slice` extracts to the end of the value. If negative, it is treated as `value.length + end`.
/// @see JavaScript [String.prototype.slice](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/slice).
+ (nonnull NSString*) slice :(nonnull NSString*)value :(SODataV4_int)start :(SODataV4_int)end;
/// @internal
///
+ (SODataV4_boolean) startsWith :(nonnull NSString*)value :(nonnull NSString*)prefix;
/// @brief Determine whether `value` starts with the characters of `text`, returning `true` or `false` as appropriate.
///
///
/// @return `true` if `value` (starting at `start`) starts with `prefix`.
/// @param value Source string.
/// @param prefix Prefix to check for.
/// @param start Optional start position (defaults to 0).
/// @see JavaScript [String.prototype.startsWith](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/startsWith).
+ (SODataV4_boolean) startsWith :(nonnull NSString*)value :(nonnull NSString*)prefix :(SODataV4_int)start;
/// @internal
///
+ (nonnull NSString*) substr :(nonnull NSString*)value :(SODataV4_int)start;
/// @return A section of `value` beginning at `start`, with `length` characters.
/// @param value Source string.
/// @param start The zero-based index at which to begin extraction from the source string. If negative, it is treated as `value.length + start`.
/// @param length Optional. The number of characters to extract. If omitted, `substr` extracts to the end of the value.
/// @see JavaScript [String.prototype.substr](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substr).
+ (nonnull NSString*) substr :(nonnull NSString*)value :(SODataV4_int)start :(SODataV4_int)length;
/// @internal
///
+ (nonnull NSString*) substring :(nonnull NSString*)value :(SODataV4_int)start;
/// @return A section of `value` beginning at `start`, through to `end`.
/// @param value Source string.
/// @param start The zero-based index at which to begin extraction from the source string. If negative, it is treated as 0.
/// @param end Optional. The zero-based index at which to end extraction from the source string. If omitted, `substring` extracts to the end of the value. If negative, it is treated as 0.
/// @see JavaScript [String.prototype.substring](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring).
+ (nonnull NSString*) substring :(nonnull NSString*)value :(SODataV4_int)start :(SODataV4_int)end;
/// @return The string `value` converted to `StringValue`.
/// @param value Source string.
+ (nullable NSObject*) toAny :(nonnull NSString*)value;
/// @return A binary value with simple (numeric value) mapping of source Unicode character values to target bytes. Use only when character values are limited to [ISO-8859-1](https://en.wikipedia.org/wiki/ISO/IEC_8859-1) (the first 256 code points of Unicode).
/// @param value Source value.
/// @see `SODataV4_UTF8`.`toBinary`.
+ (nonnull NSData*) toBinary :(nonnull NSString*)value;
/// @return The first character of `value`, or a NUL character if the string is empty.
/// @param value Source string.
+ (SODataV4_char) toChar :(nonnull NSString*)value;
/// @return The string `value` converted to [JSON](http://json.org) representation.
/// @param value Source string.
+ (nonnull NSString*) toJSON :(nonnull NSString*)value;
/// @return A copy of `value` with upper-case characters converted to lower-case.
/// @param value Source string.
/// @see JavaScript [String.prototype.toLowerCase](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toLowerCase).
+ (nonnull NSString*) toLowerCase :(nonnull NSString*)value;
/// @return The string `value`.
/// @param value Source string.
+ (nonnull NSString*) toString :(nonnull NSString*)value;
/// @return A copy of `value` with lower-case characters converted to upper-case.
/// @param value Source string.
/// @see JavaScript [String.prototype.toUpperCase](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toUpperCase).
+ (nonnull NSString*) toUpperCase :(nonnull NSString*)value;
/// @return A copy of `value` with leading and trailing whitespace removed.
/// @param value Source string.
/// @see JavaScript [String.prototype.trim](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trim).
+ (nonnull NSString*) trim :(nonnull NSString*)value;
/// @return A copy of `value` with leading whitespace removed.
/// @param value Source string.
/// @see JavaScript [String.prototype.trimLeft](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trimLeft).
+ (nonnull NSString*) trimLeft :(nonnull NSString*)value;
/// @return A copy of `value` with trailing whitespace removed.
/// @param value Source string.
/// @see JavaScript [String.prototype.trimRight](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trimRight).
+ (nonnull NSString*) trimRight :(nonnull NSString*)value;
/// @return A copy of `value` with the first character (if any) converted to upper case.
/// @param value String to be converted.
+ (nonnull NSString*) upperFirst :(nonnull NSString*)value;
/// @return A copy of `value` which adds the specified `prefix`, if not already present.
/// @param value Source string.
/// @param prefix Prefix to be added, if not already present.
+ (nonnull NSString*) withPrefix :(nonnull NSString*)value :(nonnull NSString*)prefix;
/// @return A copy of `value` which adds the specified `suffix`, if not already present.
/// @param value Source string.
/// @param suffix Suffix to be added, if not already present.
+ (nonnull NSString*) withSuffix :(nonnull NSString*)value :(nonnull NSString*)suffix;
/// @return A copy of `value` with XML reserved characters replaced with XML entity escapes. Other characters are unchanged.
/// @param value Source string.
+ (nonnull NSString*) xmlEscape :(nonnull NSString*)value;
@end
#endif

#ifdef import_SODataV4__StringFunction_private
#ifndef imported_SODataV4__StringFunction_private
#define imported_SODataV4__StringFunction_private
@interface SODataV4_StringFunction (private)
+ (nonnull NSString*) getRange :(nonnull NSString*)value :(SODataV4_int)start :(SODataV4_int)end;
@end
#endif
#endif

#ifndef imported_SODataV4__StringOperator_public
#define imported_SODataV4__StringOperator_public
/// @internal
///
@interface SODataV4_StringOperator : SODataV4_ObjectBase
{
}
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compare :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand, treating lower case characters as upper case.
///
///
/// @return Negative result if `left < right`, zero result if `left == right`, positive result if `left > right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_int) compareIgnoreCase :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equal :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand, treating lower case characters as upper case.
///
///
/// @return `true` if `left == right`, `false` if `left != right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) equalIgnoreCase :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left >= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterEqual :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left > right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) greaterThan :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left <= right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessEqual :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left < right`, `false` otherwise.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) lessThan :(nonnull NSString*)left :(nonnull NSString*)right;
/// @brief Compare `left` operand with `right` operand.
///
///
/// @return `true` if `left != right`, `false` if `left == right`.
/// @param left Left operand.
/// @param right Right operand.
+ (SODataV4_boolean) notEqual :(nonnull NSString*)left :(nonnull NSString*)right;
@end
#endif

#ifdef import_SODataV4__SystemClock_internal
#ifndef imported_SODataV4__SystemClock_internal
#define imported_SODataV4__SystemClock_public
/* internal */
/// @brief Utility functions for accessing time since startup of the current application process.
///
///
@interface SODataV4_SystemClock : SODataV4_ObjectBase
{
}
/// @return Time since process startup, measured in microseconds.
///
+ (SODataV4_long) microTime;
/// @return Time since process startup, measured in milliseconds.
///
+ (SODataV4_long) milliTime;
/// @return Time since process startup, measured in nanoseconds.
///
+ (SODataV4_long) nanoTime;
@end
#endif
#endif

#ifdef import_SODataV4__SystemConsole_internal
#ifndef imported_SODataV4__SystemConsole_internal
#define imported_SODataV4__SystemConsole_public
/* internal */
/// @brief Utility functions for writing to the system console.
///
///
@interface SODataV4_SystemConsole : SODataV4_ObjectBase
{
}
/// @brief Write `text` to the system console.
///
///
/// @param text Text to be written to the console.
+ (void) write :(nonnull NSString*)text;
/// @brief Write `text` and a newline to the system console.
///
///
/// @param text Text to be written to the console.
+ (void) writeLine :(nonnull NSString*)text;
@end
#endif
#endif

#ifdef import_SODataV4__SystemError_internal
#ifndef imported_SODataV4__SystemError_internal
#define imported_SODataV4__SystemError_public
/* internal */
@interface SODataV4_SystemError : SODataV4_ObjectBase
{
}
+ (nonnull NSString*) errorCode :(SODataV4_int)code;
+ (nonnull NSString*) gaiMessage :(SODataV4_int)code;
+ (nonnull NSString*) getMessage :(SODataV4_int)code;
+ (SODataV4_int) s_errno;
+ (nonnull NSString*) tcpMessage :(SODataV4_int)code;
@end
#endif
#endif

#ifdef import_SODataV4__SystemProcess_internal
#ifndef imported_SODataV4__SystemProcess_internal
#define imported_SODataV4__SystemProcess_public
/* internal */
/// @brief Functions for managing the current application process.
///
///
@interface SODataV4_SystemProcess : SODataV4_ObjectBase
{
}
/// @brief Exit the current application process with the specified `status`.
///
///
/// @param status Exit status.
+ (void) exit :(SODataV4_int)status;
#define SODataV4_SystemProcess_EXIT_SUCCESS 0
#define SODataV4_SystemProcess_EXIT_FAILURE 1
@end
#endif
#endif

#ifndef imported_SODataV4__ThreadLocal_public
#define imported_SODataV4__ThreadLocal_public
/// @internal
///
@interface SODataV4_ThreadLocal : SODataV4_ObjectBase
{
    @private NSString* _Nonnull _key;
}
+ (void) initialize;
- (nonnull id) init;
+ (nonnull SODataV4_ThreadLocal*) new;
/// @internal
///
- (void) _init;
/// @brief Get the value of this thread-local for the current thread.
///
///
/// @return Value, or `nil` if no value has been set for this thread.
- (nullable NSObject*) get;
/// @brief Get the value of this thread-local for the current thread.
///
///
/// @param value New value.
- (void) set :(nullable NSObject*)value;
@end
#endif

#ifdef import_SODataV4__ThreadLocal_private
#ifndef imported_SODataV4__ThreadLocal_private
#define imported_SODataV4__ThreadLocal_private
@interface SODataV4_ThreadLocal (private)
+ (nonnull NSString*) nextKey;
@end
#endif
#endif

#ifndef imported_SODataV4__ThreadSleep_public
#define imported_SODataV4__ThreadSleep_public
/// @internal
///
@interface SODataV4_ThreadSleep : SODataV4_ObjectBase
{
}
/// @brief Sleep the current thread for `time` microseconds.
///
///
/// @param time Sleep time (in microseconds).
+ (void) forMicroseconds :(SODataV4_long)time;
/// @brief Sleep the current thread for `time` milliseconds.
///
///
/// @param time Sleep time (in milliseconds).
+ (void) forMilliseconds :(SODataV4_long)time;
/// @brief Sleep the current thread for `time` nanoseconds.
///
///
/// @param time Sleep time (in nanoseconds).
+ (void) forNanoseconds :(SODataV4_long)time;
/// @brief Sleep the current thread for `time` seconds.
///
///
/// @param time Sleep time (in seconds).
+ (void) forSeconds :(SODataV4_long)time;
/// @brief Sleep the current thread forever.
///
///
+ (void) forever;
@end
#endif

#ifndef imported_SODataV4__ThreadStart_public
#define imported_SODataV4__ThreadStart_public
/// @internal
///
@interface SODataV4_ThreadStart : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ThreadStart*) new;
/// @internal
///
- (void) _init;
@end
#endif

#ifdef import_SODataV4__ThreadStart_private
#ifndef imported_SODataV4__ThreadStart_private
#define imported_SODataV4__ThreadStart_private
@interface SODataV4_ThreadStart (private)
#define SODataV4_ThreadStart_UNHANDLED_EXCEPTION @"Unhandled Thread Exception"
@end
#endif
#endif

#ifdef import_SODataV4__UTF16_internal
#ifndef imported_SODataV4__UTF16_internal
#define imported_SODataV4__UTF16_public
/* internal */
/// @brief Utility functions for UTF-16 processing.
///
///
@interface SODataV4_UTF16 : SODataV4_ObjectBase
{
}
/// @brief CVombined high and low surrogates to character value.
///
///
/// @return Combined surrogate pair.
/// @param high High surrogate.
/// @param low Low surrogate.
+ (SODataV4_int) combineHighLow :(SODataV4_char)high :(SODataV4_char)low;
/// @return `true` if `value` is a UTF-16 high surrogate.
/// @param value Code unit.
+ (SODataV4_boolean) isHighSurrogate :(SODataV4_char)value;
/// @return `true` if `value` is a UTF-16 low surrogate.
/// @param value Code unit.
+ (SODataV4_boolean) isLowSurrogate :(SODataV4_char)value;
/// @return `true` if `value` is a UTF-16 surrogate (high or low).
/// @param value Code unit.
+ (SODataV4_boolean) isSurrogate :(SODataV4_char)value;
@end
#endif
#endif

#ifdef import_SODataV4__UTF8_internal
#ifndef imported_SODataV4__UTF8_internal
#define imported_SODataV4__UTF8_public
/* internal */
/// @brief Utility functions for UTF-8 conversion bwetween `string` and `binary` types.
///
///
@interface SODataV4_UTF8 : SODataV4_ObjectBase
{
}
/// @brief Search from the end of `buffer` for the last complete UTF-8 sequence (expecting 1-4 byte UTF-8 sequences).
///
///
/// @return The zero-based index after the last complete UTF-8 sequence; zero if no sequence is found.
/// @param bytes Byte buffer.
+ (SODataV4_int) endLast :(nonnull SODataV4_ByteBuffer*)bytes;
/// @brief Convert `text` from string to UTF-8 binary format.
///
///
/// @param text Text to be converted to UTF-8.
/// @throw `SODataV4_UTF8Exception` if `text` is not convertible to UTF-8 format.
+ (nonnull NSData*) toBinary :(nonnull NSString*)text;
/// @brief Convert `data` from UTF-8 binary format to string.
///
///
/// @param data UTF-8 formatted binary data.
/// @throw `SODataV4_UTF8Exception` if `data` is not convertible from UTF-8 format.
+ (nonnull NSString*) toString :(nonnull NSData*)data;
@end
#endif
#endif

#ifdef import_SODataV4__UnicodeClass_internal
#ifndef imported_SODataV4__UnicodeClass_internal
#define imported_SODataV4__UnicodeClass_public
/* internal */
/// @brief A set of functions for determining membership of Unicode code points in character classes (categories).
///
///
/// @see http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
/// @see http://unicode.org/reports/tr44/ (5.7.1 General Category Values)
@interface SODataV4_UnicodeClass : SODataV4_ObjectBase
{
}
/// @return `true` if `c` has class Other (Cc | Cf | Cs | Co | Cn).
/// @param c Unicode code point.
+ (SODataV4_boolean) isC :(SODataV4_int)c;
/// @return `true` if `c` has class Control (a C0 or C1 control code).
/// @param c Unicode code point.
+ (SODataV4_boolean) isCc :(SODataV4_int)c;
/// @return `true` if `c` has class Format (a format control character).
/// @param c Unicode code point.
+ (SODataV4_boolean) isCf :(SODataV4_int)c;
/// @return `true` if `c` has class Private_Use (a private-use character).
/// @param c Unicode code point.
+ (SODataV4_boolean) isCo :(SODataV4_int)c;
/// @return `true` if `c` has class Surrogate (a surrogate code point).
/// @param c Unicode code point.
+ (SODataV4_boolean) isCs :(SODataV4_int)c;
/// @return `true` if `c` has class Letter (Lu | Ll | Lt | Lm | Lo).
/// @param c Unicode code point.
+ (SODataV4_boolean) isL :(SODataV4_int)c;
/// @return `true` if `c` has class Cased_Letter (Lu | Ll | Lt).
/// @param c Unicode code point.
+ (SODataV4_boolean) isLC :(SODataV4_int)c;
/// @return `true` if `c` has class Lowercase_Letter (a lowercase letter).
/// @param c Unicode code point.
+ (SODataV4_boolean) isLl :(SODataV4_int)c;
/// @return `true` if `c` has class Modifier_Letter (a modifier letter).
/// @param c Unicode code point.
+ (SODataV4_boolean) isLm :(SODataV4_int)c;
/// @return `true` if `c` has class Other_Letter (other letters, including syllables and ideographs).
/// @param c Unicode code point.
+ (SODataV4_boolean) isLo :(SODataV4_int)c;
/// @return `true` if `c` has class Titlecase_Letter (a digraphic character, with first part uppercase).
/// @param c Unicode code point.
+ (SODataV4_boolean) isLt :(SODataV4_int)c;
/// @return `true` if `c` has class Uppercase_Letter (an uppercase letter).
/// @param c Unicode code point.
+ (SODataV4_boolean) isLu :(SODataV4_int)c;
/// @return `true` if `c` has class Mark (Mn | Mc | Me).
/// @param c Unicode code point.
+ (SODataV4_boolean) isM :(SODataV4_int)c;
/// @return `true` if `c` has class Spacing_Mark (a spacing combining mark (positive advance width)).
/// @param c Unicode code point.
+ (SODataV4_boolean) isMc :(SODataV4_int)c;
/// @return `true` if `c` has class Enclosing_Mark (an enclosing combining mark).
/// @param c Unicode code point.
+ (SODataV4_boolean) isMe :(SODataV4_int)c;
/// @return `true` if `c` has class Nonspacing_Mark (a nonspacing combining mark (zero advance width)).
/// @param c Unicode code point.
+ (SODataV4_boolean) isMn :(SODataV4_int)c;
/// @return `true` if `c` has class Number (Nd | Nl | No).
/// @param c Unicode code point.
+ (SODataV4_boolean) isN :(SODataV4_int)c;
/// @return `true` if `c` has class Decimal_Number (a decimal digit).
/// @param c Unicode code point.
+ (SODataV4_boolean) isNd :(SODataV4_int)c;
/// @return `true` if `c` has class Letter_Number (a letterlike numeric character).
/// @param c Unicode code point.
+ (SODataV4_boolean) isNl :(SODataV4_int)c;
/// @return `true` if `c` has class Other_Number (a numeric character of other type).
/// @param c Unicode code point.
+ (SODataV4_boolean) isNo :(SODataV4_int)c;
/// @return `true` if `c` has class Punctuation (Pc | Pd | Ps | Pe | Pi | Pf | Po).
/// @param c Unicode code point.
+ (SODataV4_boolean) isP :(SODataV4_int)c;
/// @return `true` if `c` has class Connector_Punctuation (a connecting punctuation mark, like a tie).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPc :(SODataV4_int)c;
/// @return `true` if `c` has class Dash_Punctuation (a dash or hyphen punctuation mark).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPd :(SODataV4_int)c;
/// @return `true` if `c` has class Close_Punctuation (a closing punctuation mark (of a pair)).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPe :(SODataV4_int)c;
/// @return `true` if `c` has class Final_Punctuation (a final quotation mark).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPf :(SODataV4_int)c;
/// @return `true` if `c` has class Initial_Punctuation (an initial quotation mark).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPi :(SODataV4_int)c;
/// @return `true` if `c` has class Other_Punctuation (a punctuation mark of other type).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPo :(SODataV4_int)c;
/// @return `true` if `c` has class Open_Punctuation (an opening punctuation mark (of a pair)).
/// @param c Unicode code point.
+ (SODataV4_boolean) isPs :(SODataV4_int)c;
/// @return `true` if `c` has class Symbol (Sm | Sc | Sk | So).
/// @param c Unicode code point.
+ (SODataV4_boolean) isS :(SODataV4_int)c;
/// @return `true` if `c` has class Currency_Symbol (a currency sign).
/// @param c Unicode code point.
+ (SODataV4_boolean) isSc :(SODataV4_int)c;
/// @return `true` if `c` has class Modifier_Symbol (a non-letterlike modifier symbol).
/// @param c Unicode code point.
+ (SODataV4_boolean) isSk :(SODataV4_int)c;
/// @return `true` if `c` has class Math_Symbol (a symbol of mathematical use).
/// @param c Unicode code point.
+ (SODataV4_boolean) isSm :(SODataV4_int)c;
/// @return `true` if `c` has class Other_Symbol (a symbol of other type).
/// @param c Unicode code point.
+ (SODataV4_boolean) isSo :(SODataV4_int)c;
/// @return `true` if `c` has class Separator (Zs | Zl | Zp).
/// @param c Unicode code point.
+ (SODataV4_boolean) isZ :(SODataV4_int)c;
/// @return `true` if `c` has class Line_Separator (U+2028 LINE SEPARATOR only).
/// @param c Unicode code point.
+ (SODataV4_boolean) isZl :(SODataV4_int)c;
/// @return `true` if `c` has class Paragraph_Separator (U+2029 PARAGRAPH SEPARATOR only).
/// @param c Unicode code point.
+ (SODataV4_boolean) isZp :(SODataV4_int)c;
/// @return `true` if `c` has class Space_Separator (a space character (of various non-zero widths)).
/// @param c Unicode code point.
+ (SODataV4_boolean) isZs :(SODataV4_int)c;
@end
#endif
#endif

#ifndef imported_SODataV4__UntypedList_public
#define imported_SODataV4__UntypedList_public
/// @internal
///
@interface SODataV4_UntypedList : SODataV4_ObjectBase
{
    @private NSMutableArray* _list;
    @private SODataV4_Comparer* _Nonnull _comparer_;
    @private SODataV4_Equality* _Nonnull _equality_;
}
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_UntypedList`.`length` of zero and specified initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Initial capacity.
+ (nonnull SODataV4_UntypedList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Append `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nullable NSObject*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_UntypedList*)list;
/// @brief Add a number of `nil` values to the end of this list.
///
///
/// @param count Number of null values to be added.
- (void) addNulls :(SODataV4_int)count;
/// @brief Add a range of items of `list` to the end of this list. Equivalent to `this.addAll(list.slice(start, end)`.
///
///
/// @param list List containing items to be added.
/// @param start Starting index in `list` (inclusive).
/// @param end Ending index in `list` (exclusive).
- (void) addRange :(nonnull SODataV4_UntypedList*)list :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Remove all items from this list.
///
///
- (void) clear;
/// @return The starting point for a range, as indicated by `end`.
/// @param end Ending index. May be negative for ending point relative to the end of this list.
- (SODataV4_int) endRange :(SODataV4_int)end;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nullable NSObject*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_UntypedList`.`length` - 1).
- (nullable NSObject*) get :(SODataV4_int)index;
/// @internal
///
- (SODataV4_int) indexOf :(nullable NSObject*)item;
/// @return First index in this list of `item`, or -1 if not found.
/// @param item Item for comparison.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
/// @see `SODataV4_UntypedList`.`use`.
- (SODataV4_int) indexOf :(nullable NSObject*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_UntypedList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_UntypedList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_UntypedList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nullable NSObject*)item;
/// @brief `true` if this list contains no items.
///
///
- (SODataV4_boolean) isEmpty;
/// @brief `true` if this list is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nullable NSObject*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nullable NSObject*)item;
/// @return Last index in this list of `item`, or -1 if not found.
/// @param item Item for comparison.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
/// @see `SODataV4_UntypedList`.`use`.
- (SODataV4_int) lastIndexOf :(nullable NSObject*)item :(SODataV4_int)start;
/// @brief The number of items in this list.
///
///
- (SODataV4_int) length;
/// @return The last item in this list (which is removed from the list).
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nullable NSObject*) pop;
/// @brief Add `item` to the end of this list.
///
///
/// @return The resulting `SODataV4_UntypedList`.`length`.
/// @param item Item to be added.
- (SODataV4_int) push :(nullable NSObject*)item;
/// @brief Remove an item from the specified index in this list.
///
///
/// @param index Index of the item to be removed.
- (void) removeAt :(SODataV4_int)index;
/// @brief Remove the first item (if any) from this list.
///
///
- (void) removeFirst;
/// @brief Remove the last item (if any) from this list.
///
///
- (void) removeLast;
/// @brief Remove a range of items from this list.
///
///
/// @param start Starting index (inclusive) for items to be removed.
/// @param end Ending index (exclusive) for items to be removed.
- (void) removeRange :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Request that this list can hold `capacity` items without needing incremental expansion.
///
///
/// @param capacity Recommended capacity.
- (void) reserve :(SODataV4_int)capacity;
/// @brief Reverse the order of the items in this list.
///
///
- (void) reverse;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nullable NSObject*)item;
/// @return The first item in this list (which is removed from the list).
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nullable NSObject*) shift;
/// @return The expected single item in this list.
/// @throw `SODataV4_NotUniqueException` if the list does not have one item.
- (nullable NSObject*) single;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive).
/// @param end Zero-based ending index (exclusive).
/// @throw `SODataV4_ListIndexException` if `start` is out of range (0 to `SODataV4_UntypedList`.`length`).
- (nonnull SODataV4_UntypedList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Sort the items in this list.
///
///
/// @see `SODataV4_UntypedList`.`use`.
- (void) sort;
/// @brief Sort the items in this list, using the `comparer` argument for ordering.
///
///
/// @param comparer Ordering function.
- (void) sortWith :(nonnull SODataV4_Comparer*)comparer;
/// @return The starting point for a range, as indicated by `start`.
/// @param start Starting index. May be negative for starting point relative to the end of this list.
- (SODataV4_int) startRange :(SODataV4_int)start;
/// @return A string representation of this list.
///
- (nonnull NSString*) toString;
/// @brief Register ordering and equality functions with this list, for use by functions that do sorting and searching.
///
///
/// @param comparer Ordering function.
/// @param equality Equality function.
- (void) use :(nonnull SODataV4_Comparer*)comparer :(nonnull SODataV4_Equality*)equality;
/// @brief `true` if this list contains no items.
///
///
@property (nonatomic, readonly) SODataV4_boolean isEmpty;
/// @brief `true` if this list is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
/// @brief The number of items in this list.
///
///
@property (nonatomic, readonly) SODataV4_int length;
@end
#endif

#ifdef import_SODataV4__UntypedList_private
#ifndef imported_SODataV4__UntypedList_private
#define imported_SODataV4__UntypedList_private
@interface SODataV4_UntypedList (private)
- (nonnull SODataV4_Comparer*) _comparer;
- (nonnull SODataV4_Equality*) _equality;
- (void) merge :(nonnull SODataV4_UntypedList*)temp :(SODataV4_int)left :(SODataV4_int)right :(SODataV4_int)end :(nonnull SODataV4_Comparer*)comparer;
- (void) mergeSort :(nonnull SODataV4_UntypedList*)temp :(SODataV4_int)left :(SODataV4_int)right :(nonnull SODataV4_Comparer*)comparer;
- (void) set_comparer :(nonnull SODataV4_Comparer*)value;
- (void) set_equality :(nonnull SODataV4_Equality*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Comparer* _comparer;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Equality* _equality;
@end
#endif
#endif

#ifndef imported_SODataV4__UntypedMap_public
#define imported_SODataV4__UntypedMap_public
/// @internal
///
@interface SODataV4_UntypedMap : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UntypedMap*) new;
/// @internal
///
- (void) _init;
/// @brief Remove all entries from this map.
///
///
- (void) clear;
/// @brief Copy the keys in this map to the `list` argument.
///
///
/// @param list List to receive copied keys.
- (void) copyKeysTo :(nonnull SODataV4_UntypedList*)list;
/// @brief Copy the values in this map to the `list` argument.
///
///
/// @param list List to receive copied values.
- (void) copyValuesTo :(nonnull SODataV4_UntypedList*)list;
/// @brief Delete the entry with the specified `key` (if found).
///
///
/// @return `true` if an entry with the specified `key` was found (and deleted).
/// @param key Entry key.
- (SODataV4_boolean) delete_ :(nullable NSObject*)key;
/// @return The entry with the specified `key` (if found), otherwise `nil`.
/// @param key Entry key.
- (nullable NSObject*) get :(nullable NSObject*)key;
/// @return The entry with the specified `key` (if found).
/// @throw `SODataV4_MissingEntryException` if no entry is found for the specified key.
/// @param key Entry key.
- (nonnull NSObject*) getRequired :(nullable NSObject*)key;
/// @return `true` if this map has an entry with the specified `key`, otherwise `false`.
/// @param key Entry key.
- (SODataV4_boolean) has :(nullable NSObject*)key;
/// @brief `true` if this map contains no entries.
///
///
- (SODataV4_boolean) isEmpty;
/// @brief `true` if this map is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @return A list of the entry keys in this map.
///
- (nonnull SODataV4_UntypedList*) keys;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @param key Entry key.
/// @param value Entry value.
- (void) set :(nullable NSObject*)key :(nullable NSObject*)value;
/// @brief The number of entries in this map.
///
///
- (SODataV4_int) size;
/// @return A string representation of this map.
///
- (nonnull NSString*) toString;
/// @return A list of the entry values in this map.
///
- (nonnull SODataV4_UntypedList*) values;
/// @brief `true` if this map contains no entries.
///
///
@property (nonatomic, readonly) SODataV4_boolean isEmpty;
/// @brief `true` if this map is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
/// @brief The number of entries in this map.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif

#ifndef imported_SODataV4__UntypedSet_public
#define imported_SODataV4__UntypedSet_public
/// @internal
///
@interface SODataV4_UntypedSet : SODataV4_ObjectBase
{
    @private NSMutableDictionary* _set;
    @private SODataV4_boolean _hasNull;
}
- (nonnull SODataV4_ObjectHashWrapper*) hashWrapper:(nullable NSObject*)value;
- (nonnull id) init;
/// @brief Construct a new set with `SODataV4_UntypedSet`.`size` of zero and specified initial `capacity`.
///
/// A set can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the set's maximum size.
///
/// @param capacity Initial capacity.
+ (nonnull SODataV4_UntypedSet*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `value` into this set.
///
///
/// @param value Value to be added.
- (void) add :(nullable NSObject*)value;
/// @brief Remove all values from this set.
///
///
- (void) clear;
/// @brief Copy the values in this set to the `list` argument.
///
///
/// @param list List to receive copied values.
- (void) copyValuesTo :(nonnull SODataV4_UntypedList*)list;
/// @brief Delete `value` from this set.
///
///
/// @return `true` if the value was found (and deleted).
/// @param value Value to be deleted.
- (SODataV4_boolean) delete_ :(nullable NSObject*)value;
/// @return `true` if this set contains `value`.
/// @param value Value to be found.
- (SODataV4_boolean) has :(nullable NSObject*)value;
/// @brief `true` if this set contains no entries.
///
///
- (SODataV4_boolean) isEmpty;
/// @brief `true` if this set is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @brief The number of values in this set.
///
///
- (SODataV4_int) size;
/// @return A string representation of this set.
///
- (nonnull NSString*) toString;
/// @return A list of the values in this set.
///
- (nonnull SODataV4_UntypedList*) values;
/// @brief `true` if this set contains no entries.
///
///
@property (nonatomic, readonly) SODataV4_boolean isEmpty;
/// @brief `true` if this set is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
/// @brief The number of values in this set.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif

#ifndef imported_SODataV4__EmptyList_public
#define imported_SODataV4__EmptyList_public
/// @internal
///
@interface SODataV4_EmptyList : SODataV4_UntypedList
{
}
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_EmptyList`.`length` of zero and specified initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_EmptyList*) new;
/// @internal
///
- (void) _init;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param item Ignored.
- (void) append :(nullable NSObject*)item;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param list Ignored.
- (void) appendAll :(nonnull SODataV4_UntypedList*)list;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param list Ignored.
/// @param start Ignored.
/// @param end Ignored.
- (void) appendRange :(nonnull SODataV4_UntypedList*)list :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (void) clear;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param index Ignored.
/// @param list Ignored.
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_UntypedList*)list;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param index Ignored.
/// @param item Ignored.
- (void) insertAt :(SODataV4_int)index :(nullable NSObject*)item;
/// @brief `true` if this list is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (nullable NSObject*) pop;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param item Ignored.
- (SODataV4_int) push :(nullable NSObject*)item;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param index Ignored.
- (void) removeAt :(SODataV4_int)index;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param start Ignored.
/// @param end Ignored.
- (void) removeRange :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (void) reverse;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param index Ignored.
/// @param item Ignored.
- (void) set :(SODataV4_int)index :(nullable NSObject*)item;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (nullable NSObject*) shift;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (void) sort;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param comparer Ignored.
- (void) sortWith :(nonnull SODataV4_Comparer*)comparer;
/// @brief `true` if this list is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
@end
#endif

#ifndef imported_SODataV4__EmptySet_public
#define imported_SODataV4__EmptySet_public
/// @internal
///
@interface SODataV4_EmptySet : SODataV4_UntypedSet
{
}
- (nonnull id) init;
/// @brief Construct a new set with `SODataV4_EmptySet`.`size` of zero and specified initial `capacity`.
///
/// A set can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the set's maximum size.
+ (nonnull SODataV4_EmptySet*) new;
/// @internal
///
- (void) _init;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param value Ignored.
- (void) add :(nullable NSObject*)value;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (void) clear;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param value Ignored.
- (SODataV4_boolean) delete_ :(nullable NSObject*)value;
/// @brief `true` if this set is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @brief `true` if this set is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
@end
#endif

#ifndef imported_SODataV4__ExceptionBase_public
#define imported_SODataV4__ExceptionBase_public
/// @internal
///
@interface SODataV4_ExceptionBase : NSException
{
    @private NSException* _Nullable cause_;
    @private NSString* _Nullable message_;
}
+ (BOOL) setOrThrow :(SODataV4_out_NSError)error :(nonnull NSException*)exception;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ExceptionBase*) new;
/// @internal
///
- (void) _init;
/// @brief Root cause of this exception.
///
///
- (nullable NSException*) cause;
+ (nullable NSString*) getReason :(nullable NSException*)cause :(nullable NSString*)message;
/// @brief Message text for this exception.
///
///
- (nullable NSString*) message;
/// @brief Root cause of this exception.
///
///
- (void) setCause :(nullable NSException*)value;
/// @brief Message text for this exception.
///
///
- (void) setMessage :(nullable NSString*)value;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Root cause of this exception.
///
///
@property (nonatomic, readwrite, strong, nullable) NSException* cause;
/// @brief Message text for this exception.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* message;
@end
#endif

#ifdef import_SODataV4__InstanceLogger_internal
#ifndef imported_SODataV4__InstanceLogger_internal
#define imported_SODataV4__InstanceLogger_public
/* internal */
/// @brief Wrap a logger to include an instance name in all log messages.
///
///
@interface SODataV4_InstanceLogger : SODataV4_Logger
{
    @private NSString* _Nonnull instance;
    @private SODataV4_Logger* _Nonnull logger_;
}
- (nonnull id) init;
/// @brief Construct a new instance logger.
///
///
/// @param instance Instance name.
/// @param logger Delegate logger.
+ (nonnull SODataV4_InstanceLogger*) new :(nonnull NSString*)instance :(nonnull SODataV4_Logger*)logger;
/// @internal
///
- (void) _init :(nonnull NSString*)instance :(nonnull SODataV4_Logger*)logger;
/// @internal
///
- (void) debug :(nonnull NSString*)message;
/// @internal
///
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at DEBUG level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) error :(nonnull NSString*)message;
/// @internal
///
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at ERROR level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) info :(nonnull NSString*)message;
/// @internal
///
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at INFO level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Is DEBUG level logging enabled?
///
///
- (SODataV4_boolean) isDebugEnabled;
/// @brief Is ERROR level logging enabled?
///
///
- (SODataV4_boolean) isErrorEnabled;
/// @brief Is INFO level logging enabled?
///
///
- (SODataV4_boolean) isInfoEnabled;
/// @brief Is TRACE level logging enabled?
///
///
- (SODataV4_boolean) isTraceEnabled;
/// @brief Is WARN level logging enabled?
///
///
- (SODataV4_boolean) isWarnEnabled;
/// @brief Logger name.
///
///
- (nonnull NSString*) name;
/// @internal
///
- (void) trace :(nonnull NSString*)message;
/// @internal
///
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at TRACE level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) warn :(nonnull NSString*)message;
/// @internal
///
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at WARN level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Is DEBUG level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isDebugEnabled;
/// @brief Is ERROR level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isErrorEnabled;
/// @brief Is INFO level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isInfoEnabled;
/// @brief Is TRACE level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isTraceEnabled;
/// @brief Is WARN level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isWarnEnabled;
/// @brief Logger name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* name;
@end
#endif
#endif

#ifdef import_SODataV4__InstanceLogger_private
#ifndef imported_SODataV4__InstanceLogger_private
#define imported_SODataV4__InstanceLogger_private
@interface SODataV4_InstanceLogger (private)
- (nonnull NSString*) addInstanceBefore :(nonnull NSString*)message;
- (nonnull SODataV4_Logger*) logger;
- (void) setLogger :(nonnull SODataV4_Logger*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Logger* logger;
@end
#endif
#endif

#ifdef import_SODataV4__LogToConsole_internal
#ifndef imported_SODataV4__LogToConsole_internal
#define imported_SODataV4__LogToConsole_public
/* internal */
@interface SODataV4_LogToConsole : SODataV4_Logger
{
    @private NSString* _Nonnull fullName;
    @private NSString* _Nonnull shortName;
}
- (nonnull id) init;
/// @internal
///
- (void) _init :(nonnull NSString*)name;
/// @internal
///
- (void) debug :(nonnull NSString*)message;
/// @internal
///
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at DEBUG level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) debug :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) error :(nonnull NSString*)message;
/// @internal
///
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at ERROR level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) error :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) info :(nonnull NSString*)message;
/// @internal
///
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at INFO level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) info :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Is DEBUG level logging enabled?
///
///
- (SODataV4_boolean) isDebugEnabled;
/// @brief Is ERROR level logging enabled?
///
///
- (SODataV4_boolean) isErrorEnabled;
/// @brief Is INFO level logging enabled?
///
///
- (SODataV4_boolean) isInfoEnabled;
/// @brief Is TRACE level logging enabled?
///
///
- (SODataV4_boolean) isTraceEnabled;
/// @brief Is WARN level logging enabled?
///
///
- (SODataV4_boolean) isWarnEnabled;
/// @brief Logger name.
///
///
- (nonnull NSString*) name;
/// @internal
///
- (void) trace :(nonnull NSString*)message;
/// @internal
///
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at TRACE level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) trace :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @internal
///
- (void) warn :(nonnull NSString*)message;
/// @internal
///
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause;
/// @brief Log a message at WARN level.
///
///
/// @param message Message text.
/// @param cause (optional) Exception cause.
/// @param dump (optional) Dump stack trace?
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause :(SODataV4_boolean)dump;
/// @brief Is DEBUG level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isDebugEnabled;
/// @brief Is ERROR level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isErrorEnabled;
/// @brief Is INFO level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isInfoEnabled;
/// @brief Is TRACE level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isTraceEnabled;
/// @brief Is WARN level logging enabled?
///
///
@property (nonatomic, readonly) SODataV4_boolean isWarnEnabled;
/// @brief Logger name.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* name;
@end
#endif
#endif

#ifdef import_SODataV4__LogToConsole_private
#ifndef imported_SODataV4__LogToConsole_private
#define imported_SODataV4__LogToConsole_private
@interface SODataV4_LogToConsole (private)
- (nonnull NSString*) addNameBefore :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__LogToConsole_internal
#ifndef imported_SODataV4__LogToConsole_internal
#define imported_SODataV4__LogToConsole_internal
@interface SODataV4_LogToConsole (internal)
+ (nonnull SODataV4_LogToConsole*) new :(nonnull NSString*)name;
@end
#endif
#endif

#ifndef imported_SODataV4__MapFromObject_public
#define imported_SODataV4__MapFromObject_public
/// @internal
///
@interface SODataV4_MapFromObject : SODataV4_UntypedMap
{
    @private NSMutableDictionary* _map;
}
- (nonnull SODataV4_ObjectHashWrapper*) hashWrapper:(nullable NSObject*)key;
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_MapFromObject`.`size` of zero and specified initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
///
/// @param capacity Initial capacity.
+ (nonnull SODataV4_MapFromObject*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Remove all entries from this map.
///
///
- (void) clear;
/// @brief Copy the keys in this map to the `list` argument.
///
///
/// @param list List to receive copied keys.
- (void) copyKeysTo :(nonnull SODataV4_UntypedList*)list;
/// @brief Copy the values in this map to the `list` argument.
///
///
/// @param list List to receive copied values.
- (void) copyValuesTo :(nonnull SODataV4_UntypedList*)list;
/// @brief Delete the entry with the specified `key` (if found).
///
///
/// @return `true` if an entry with the specified `key` was found (and deleted).
/// @param key Entry key.
- (SODataV4_boolean) delete_ :(nullable NSObject*)key;
/// @return The entry with the specified `key` (if found), otherwise `nil`.
/// @param key Entry key.
- (nullable NSObject*) get :(nullable NSObject*)key;
/// @return The entry with the specified `key` (if found).
/// @throw `SODataV4_MissingEntryException` if no entry is found for the specified key.
/// @param key Entry key.
- (nonnull NSObject*) getRequired :(nullable NSObject*)key;
/// @return `true` if this map has an entry with the specified `key`, otherwise `false`.
/// @param key Entry key.
- (SODataV4_boolean) has :(nullable NSObject*)key;
/// @brief `true` if this map contains no entries.
///
///
- (SODataV4_boolean) isEmpty;
/// @brief `true` if this map is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @internal
///
- (nonnull SODataV4_MapIteratorFromObject*) iteratorFromObject;
/// @return A list of the entry keys in this map.
///
- (nonnull SODataV4_UntypedList*) keys;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @param key Entry key.
/// @param value Entry value.
- (void) set :(nullable NSObject*)key :(nullable NSObject*)value;
/// @brief The number of entries in this map.
///
///
- (SODataV4_int) size;
/// @return A string representation of this map.
///
- (nonnull NSString*) toString;
/// @return A list of the entry values in this map.
///
- (nonnull SODataV4_UntypedList*) values;
/// @brief `true` if this map contains no entries.
///
///
@property (nonatomic, readonly) SODataV4_boolean isEmpty;
/// @brief `true` if this map is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
/// @brief The number of entries in this map.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif

#ifndef imported_SODataV4__MapFromString_public
#define imported_SODataV4__MapFromString_public
/// @internal
///
@interface SODataV4_MapFromString : SODataV4_UntypedMap
{
    @private NSMutableDictionary* _map;
}
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_MapFromString`.`size` of zero and specified initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
///
/// @param capacity Initial capacity.
+ (nonnull SODataV4_MapFromString*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Remove all entries from this map.
///
///
- (void) clear;
/// @brief Copy the keys in this map to the `list` argument.
///
///
/// @param list List to receive copied keys.
- (void) copyKeysTo :(nonnull SODataV4_UntypedList*)list;
/// @brief Copy the values in this map to the `list` argument.
///
///
/// @param list List to receive copied values.
- (void) copyValuesTo :(nonnull SODataV4_UntypedList*)list;
/// @internal
///
- (SODataV4_boolean) deleteWithString :(nonnull NSString*)key;
/// @brief Delete the entry with the specified `key` (if found).
///
///
/// @return `true` if an entry with the specified `key` was found (and deleted).
/// @param key Entry key.
- (SODataV4_boolean) delete_ :(nullable NSObject*)key;
/// @return The entry with the specified `key` (if found), otherwise `nil`.
/// @param key Entry key.
- (nullable NSObject*) get :(nullable NSObject*)key;
/// @return The entry with the specified `key` (if found).
/// @throw `SODataV4_MissingEntryException` if no entry is found for the specified key.
/// @param key Entry key.
- (nonnull NSObject*) getRequired :(nullable NSObject*)key;
/// @internal
///
- (nonnull NSObject*) getRequiredWithString :(nonnull NSString*)key;
/// @internal
///
- (nullable NSObject*) getWithString :(nonnull NSString*)key;
/// @return `true` if this map has an entry with the specified `key`, otherwise `false`.
/// @param key Entry key.
- (SODataV4_boolean) has :(nullable NSObject*)key;
/// @internal
///
- (SODataV4_boolean) hasWithString :(nonnull NSString*)key;
/// @brief `true` if this map contains no entries.
///
///
- (SODataV4_boolean) isEmpty;
/// @brief `true` if this map is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @internal
///
- (nonnull SODataV4_MapIteratorFromString*) iteratorFromString;
/// @return A list of the entry keys in this map.
///
- (nonnull SODataV4_UntypedList*) keys;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @param key Entry key.
/// @param value Entry value.
- (void) set :(nullable NSObject*)key :(nullable NSObject*)value;
/// @internal
///
- (void) setWithString :(nonnull NSString*)key :(nullable NSObject*)value;
/// @brief The number of entries in this map.
///
///
- (SODataV4_int) size;
/// @return A string representation of this map.
///
- (nonnull NSString*) toString;
/// @return A list of the entry values in this map.
///
- (nonnull SODataV4_UntypedList*) values;
/// @brief `true` if this map contains no entries.
///
///
@property (nonatomic, readonly) SODataV4_boolean isEmpty;
/// @brief `true` if this map is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
/// @brief The number of entries in this map.
///
///
@property (nonatomic, readonly) SODataV4_int size;
@end
#endif

#ifdef import_SODataV4__StringComparerIgnoreCase_internal
#ifndef imported_SODataV4__StringComparerIgnoreCase_internal
#define imported_SODataV4__StringComparerIgnoreCase_public
/* internal */
@interface SODataV4_StringComparerIgnoreCase : SODataV4_Comparer
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_StringComparerIgnoreCase*) new;
/// @internal
///
- (void) _init;
/// @brief Compare two values for sorting.
///
///
/// @return A zero value if `left` is equal to `right` in sorted order, left negative value (e.g. -1) if `left` is less than `right` in sorted order, or left positive value (e.g. 1) if `left` is greater than `right` in sorted order.
/// @param left First value for comparison.
/// @param right Second value for comparison.
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifdef import_SODataV4__StringEqualityIgnoreCase_internal
#ifndef imported_SODataV4__StringEqualityIgnoreCase_internal
#define imported_SODataV4__StringEqualityIgnoreCase_public
/* internal */
@interface SODataV4_StringEqualityIgnoreCase : SODataV4_Equality
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_StringEqualityIgnoreCase*) new;
/// @internal
///
- (void) _init;
/// @brief Compare two values for equality.
///
///
/// @return `true` if `left` is equal to `right`, otherwise `false`.
/// @param left First value for comparison.
/// @param right Second value for comparison.
- (SODataV4_boolean) equal :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifdef import_SODataV4__UndefinedComparer_internal
#ifndef imported_SODataV4__UndefinedComparer_internal
#define imported_SODataV4__UndefinedComparer_public
/* internal */
@interface SODataV4_UndefinedComparer : SODataV4_Comparer
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UndefinedComparer*) new;
/// @internal
///
- (void) _init;
/// @brief Compare two values for sorting.
///
///
/// @return A zero value if `left` is equal to `right` in sorted order, left negative value (e.g. -1) if `left` is less than `right` in sorted order, or left positive value (e.g. 1) if `left` is greater than `right` in sorted order.
/// @param left First value for comparison.
/// @param right Second value for comparison.
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifdef import_SODataV4__UndefinedEquality_internal
#ifndef imported_SODataV4__UndefinedEquality_internal
#define imported_SODataV4__UndefinedEquality_public
/* internal */
@interface SODataV4_UndefinedEquality : SODataV4_Equality
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UndefinedEquality*) new;
/// @internal
///
- (void) _init;
/// @brief Compare two values for equality.
///
///
/// @return `true` if `left` is equal to `right`, otherwise `false`.
/// @param left First value for comparison.
/// @param right Second value for comparison.
- (SODataV4_boolean) equal :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifndef imported_SODataV4__EmptyMapFromObject_public
#define imported_SODataV4__EmptyMapFromObject_public
/// @internal
///
@interface SODataV4_EmptyMapFromObject : SODataV4_MapFromObject
{
}
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_EmptyMapFromObject`.`size` of zero and specified initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
+ (nonnull SODataV4_EmptyMapFromObject*) new;
/// @internal
///
- (void) _init;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (void) clear;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param key Ignored.
- (SODataV4_boolean) delete_ :(nullable NSObject*)key;
/// @brief `true` if this map is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @brief Throw `SODataV4_ImmutableException`.
///
/// @param key Ignored.
/// @param value Ignored.
- (void) set :(nullable NSObject*)key :(nullable NSObject*)value;
/// @brief `true` if this map is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
@end
#endif

#ifndef imported_SODataV4__EmptyMapFromString_public
#define imported_SODataV4__EmptyMapFromString_public
/// @internal
///
@interface SODataV4_EmptyMapFromString : SODataV4_MapFromString
{
}
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_EmptyMapFromString`.`size` of zero and specified initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
+ (nonnull SODataV4_EmptyMapFromString*) new;
/// @internal
///
- (void) _init;
/// @brief Throw `SODataV4_ImmutableException`.
///
///
- (void) clear;
/// @internal
///
- (SODataV4_boolean) deleteWithString :(nonnull NSString*)key;
/// @brief `true` if this map is mutable.
///
///
- (SODataV4_boolean) isMutable;
/// @internal
///
- (void) setWithString :(nonnull NSString*)key :(nullable NSObject*)value;
/// @brief `true` if this map is mutable.
///
///
@property (nonatomic, readonly) SODataV4_boolean isMutable;
@end
#endif

#ifndef imported_SODataV4__FatalException_public
#define imported_SODataV4__FatalException_public
/// @internal
///
@interface SODataV4_FatalException : SODataV4_ExceptionBase
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_FatalException*) new;
/// @internal
///
- (void) _init;
@end
#endif

#ifdef import_SODataV4__StackDumpException_internal
#ifndef imported_SODataV4__StackDumpException_internal
#define imported_SODataV4__StackDumpException_public
/* internal */
@interface SODataV4_StackDumpException : SODataV4_ExceptionBase
{
}
+ (nonnull SODataV4_StackDumpException*) new;
/// @internal
///
- (void) _init;
@end
#endif
#endif

#ifdef import_SODataV4__UTF8Exception_internal
#ifndef imported_SODataV4__UTF8Exception_internal
#define imported_SODataV4__UTF8Exception_public
/* internal */
/// @brief Exception thrown for failures in UTF-8 conversion (decoding and encoding).
///
///
@interface SODataV4_UTF8Exception : SODataV4_ExceptionBase
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UTF8Exception*) new;
/// @internal
///
- (void) _init;
/// @brief Exception thrown when binary content cannot be decoded from UTF-8 format.
///
///
+ (nonnull SODataV4_UTF8Exception*) cannotDecode;
/// @brief Exception thrown when string content cannot be encoded in UTF-8 format.
///
///
+ (nonnull SODataV4_UTF8Exception*) cannotEncode;
@end
#endif
#endif

#ifdef import_SODataV4__UTF8Exception_private
#ifndef imported_SODataV4__UTF8Exception_private
#define imported_SODataV4__UTF8Exception_private
@interface SODataV4_UTF8Exception (private)
+ (nonnull SODataV4_UTF8Exception*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__AbstractFunctionException_internal
#ifndef imported_SODataV4__AbstractFunctionException_internal
#define imported_SODataV4__AbstractFunctionException_public
/* internal */
@interface SODataV4_AbstractFunctionException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AbstractFunctionException*) new;
/// @internal
///
- (void) _init;
@end
#endif
#endif

#ifdef import_SODataV4__AbstractPropertyException_internal
#ifndef imported_SODataV4__AbstractPropertyException_internal
#define imported_SODataV4__AbstractPropertyException_public
/* internal */
@interface SODataV4_AbstractPropertyException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AbstractPropertyException*) new;
/// @internal
///
- (void) _init;
@end
#endif
#endif

#ifndef imported_SODataV4__AssertException_public
#define imported_SODataV4__AssertException_public
/// @internal
///
@interface SODataV4_AssertException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AssertException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_AssertException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__AssertException_private
#ifndef imported_SODataV4__AssertException_private
#define imported_SODataV4__AssertException_private
@interface SODataV4_AssertException (private)
+ (nonnull SODataV4_AssertException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__BinaryIndexException_internal
#ifndef imported_SODataV4__BinaryIndexException_internal
#define imported_SODataV4__BinaryIndexException_public
/* internal */
/// @brief Exception thrown when `SODataV4_BinaryFunction`.`byteAt` is called with an out-of-bounds index.
///
///
@interface SODataV4_BinaryIndexException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_BinaryIndexException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_BinaryIndexException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__BinaryIndexException_private
#ifndef imported_SODataV4__BinaryIndexException_private
#define imported_SODataV4__BinaryIndexException_private
@interface SODataV4_BinaryIndexException (private)
+ (nonnull SODataV4_BinaryIndexException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__CastException_public
#define imported_SODataV4__CastException_public
/// @internal
///
@interface SODataV4_CastException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CastException*) new;
/// @internal
///
- (void) _init;
/// @return A CastException indicating that `value` cannot be cast to `type`.
/// @param value Any value, including `nil`.
/// @param type Cast target type.
+ (nonnull SODataV4_CastException*) cannotCast :(nullable NSObject*)value :(nonnull NSString*)type;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_CastException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__CastException_private
#ifndef imported_SODataV4__CastException_private
#define imported_SODataV4__CastException_private
@interface SODataV4_CastException (private)
+ (nonnull SODataV4_CastException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__EmptyListException_public
#define imported_SODataV4__EmptyListException_public
/// @internal
///
@interface SODataV4_EmptyListException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_EmptyListException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_EmptyListException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__EmptyListException_private
#ifndef imported_SODataV4__EmptyListException_private
#define imported_SODataV4__EmptyListException_private
@interface SODataV4_EmptyListException (private)
+ (nonnull SODataV4_EmptyListException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__FormatException_internal
#ifndef imported_SODataV4__FormatException_internal
#define imported_SODataV4__FormatException_public
/* internal */
/// @brief Exception thrown when a value cannot cannot be parsed because it does not match the expected format.
///
///
@interface SODataV4_FormatException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_FormatException*) new;
/// @internal
///
- (void) _init;
/// @internal
///
+ (nonnull SODataV4_FormatException*) badFormat :(nonnull NSString*)type;
/// @return A new exception to indicate a bad `value` of the specified `type`.
/// @param type Type name.
/// @param value Optional value.
+ (nonnull SODataV4_FormatException*) badFormat :(nonnull NSString*)type :(nullable NSString*)value;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_FormatException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__FormatException_private
#ifndef imported_SODataV4__FormatException_private
#define imported_SODataV4__FormatException_private
@interface SODataV4_FormatException (private)
+ (nonnull SODataV4_FormatException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__ImmutableException_internal
#ifndef imported_SODataV4__ImmutableException_internal
#define imported_SODataV4__ImmutableException_public
/* internal */
/// @brief Exception thrown when a mutator function is invoked on an immutable object.
///
///
@interface SODataV4_ImmutableException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ImmutableException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_ImmutableException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__ImmutableException_private
#ifndef imported_SODataV4__ImmutableException_private
#define imported_SODataV4__ImmutableException_private
@interface SODataV4_ImmutableException (private)
+ (nonnull SODataV4_ImmutableException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__InfinityException_internal
#ifndef imported_SODataV4__InfinityException_internal
#define imported_SODataV4__InfinityException_public
/* internal */
/// @brief Exception thrown when a numeric operation produces an infinite result.
///
///
@interface SODataV4_InfinityException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_InfinityException*) new;
/// @internal
///
- (void) _init;
@end
#endif
#endif

#ifndef imported_SODataV4__ListIndexException_public
#define imported_SODataV4__ListIndexException_public
/// @internal
///
@interface SODataV4_ListIndexException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ListIndexException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_ListIndexException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__ListIndexException_private
#ifndef imported_SODataV4__ListIndexException_private
#define imported_SODataV4__ListIndexException_private
@interface SODataV4_ListIndexException (private)
+ (nonnull SODataV4_ListIndexException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__MissingEntryException_public
#define imported_SODataV4__MissingEntryException_public
/// @internal
///
@interface SODataV4_MissingEntryException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_MissingEntryException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_MissingEntryException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__MissingEntryException_private
#ifndef imported_SODataV4__MissingEntryException_private
#define imported_SODataV4__MissingEntryException_private
@interface SODataV4_MissingEntryException (private)
+ (nonnull SODataV4_MissingEntryException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__NotImplementedException_internal
#ifndef imported_SODataV4__NotImplementedException_internal
#define imported_SODataV4__NotImplementedException_public
/* internal */
/// @brief Exception thrown when the application attempts to access a function or property (getter/setter) that has not been implemented.
///
///
@interface SODataV4_NotImplementedException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_NotImplementedException*) new;
/// @internal
///
- (void) _init;
/// @brief Throw an instance of this exception (fatal).
///
///
+ (void) throwMe;
@end
#endif
#endif

#ifndef imported_SODataV4__NotUniqueException_public
#define imported_SODataV4__NotUniqueException_public
/// @internal
///
@interface SODataV4_NotUniqueException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_NotUniqueException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_NotUniqueException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__NotUniqueException_private
#ifndef imported_SODataV4__NotUniqueException_private
#define imported_SODataV4__NotUniqueException_private
@interface SODataV4_NotUniqueException (private)
+ (nonnull SODataV4_NotUniqueException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__NullValueException_internal
#ifndef imported_SODataV4__NullValueException_internal
#define imported_SODataV4__NullValueException_public
/* internal */
/// @brief Exception thrown when the application attempts to access a property or function on a `nil` value.
///
///
@interface SODataV4_NullValueException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_NullValueException*) new;
/// @internal
///
- (void) _init;
@end
#endif
#endif

#ifdef import_SODataV4__OverflowException_internal
#ifndef imported_SODataV4__OverflowException_internal
#define imported_SODataV4__OverflowException_public
/* internal */
/// @brief Exception thrown when a numeric operation overflows the range of the target type.
///
///
@interface SODataV4_OverflowException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_OverflowException*) new;
/// @internal
///
- (void) _init;
@end
#endif
#endif

#ifndef imported_SODataV4__UndefinedException_public
#define imported_SODataV4__UndefinedException_public
/// @internal
///
@interface SODataV4_UndefinedException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UndefinedException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_UndefinedException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__UndefinedException_private
#ifndef imported_SODataV4__UndefinedException_private
#define imported_SODataV4__UndefinedException_private
@interface SODataV4_UndefinedException (private)
+ (nonnull SODataV4_UndefinedException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__UnexpectedException_internal
#ifndef imported_SODataV4__UnexpectedException_internal
#define imported_SODataV4__UnexpectedException_public
/* internal */
/// @brief Wraps an unexpected exception as a fatal exception.
///
///
@interface SODataV4_UnexpectedException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UnexpectedException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified root cause.
/// @param cause Root cause.
+ (nonnull SODataV4_UnexpectedException*) withCause :(nonnull NSException*)cause;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_UnexpectedException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__UnexpectedException_private
#ifndef imported_SODataV4__UnexpectedException_private
#define imported_SODataV4__UnexpectedException_private
@interface SODataV4_UnexpectedException (private)
+ (nonnull SODataV4_UnexpectedException*) _new1 :(nullable NSException*)p1;
+ (nonnull SODataV4_UnexpectedException*) _new2 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__UsageException_internal
#ifndef imported_SODataV4__UsageException_internal
#define imported_SODataV4__UsageException_public
/* internal */
/// @brief Exception thrown when the application makes incorrect usage of an API.
///
///
@interface SODataV4_UsageException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_UsageException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_UsageException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__UsageException_private
#ifndef imported_SODataV4__UsageException_private
#define imported_SODataV4__UsageException_private
@interface SODataV4_UsageException (private)
+ (nonnull SODataV4_UsageException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__VersionMismatchException_internal
#ifndef imported_SODataV4__VersionMismatchException_internal
#define imported_SODataV4__VersionMismatchException_public
/* internal */
/// @brief An exception that is thrown when a version miamatch is detected.
///
///
/// @see `SODataV4_Assert`.
@interface SODataV4_VersionMismatchException : SODataV4_FatalException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_VersionMismatchException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_VersionMismatchException*) withMessage :(nonnull NSString*)message;
@end
#endif
#endif

#ifdef import_SODataV4__VersionMismatchException_private
#ifndef imported_SODataV4__VersionMismatchException_private
#define imported_SODataV4__VersionMismatchException_private
@interface SODataV4_VersionMismatchException (private)
+ (nonnull SODataV4_VersionMismatchException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#endif
