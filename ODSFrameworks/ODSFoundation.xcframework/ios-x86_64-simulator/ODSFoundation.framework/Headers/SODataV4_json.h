//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_JSON_H
#define SODATAV4_JSON_H


@class SODataV4_Map_sortedEntries_JsonObject_in_json_KeyComparer; /* internal */
@class SODataV4_GeoJson;
@class SODataV4_JsonElement;
@class SODataV4_JsonElementFrame; /* internal */
@class SODataV4_JsonElementStream;
@class SODataV4_JsonObject_Entry;
@class SODataV4_JsonOutputStream;
@class SODataV4_JsonPretty;
@class SODataV4_JsonToken;
@class SODataV4_JsonTokenStream;
@class SODataV4_JsonValue;
@class SODataV4_JsonArray;
@class SODataV4_JsonBeginArray; /* internal */
@class SODataV4_JsonBeginObject; /* internal */
@class SODataV4_JsonBoolean;
@class SODataV4_JsonBooleanToken;
@class SODataV4_JsonColonChar; /* internal */
@class SODataV4_JsonCommaChar; /* internal */
@class SODataV4_JsonEndArray; /* internal */
@class SODataV4_JsonEndObject; /* internal */
@class SODataV4_JsonEndStream; /* internal */
@class SODataV4_JsonNullValue; /* internal */
@class SODataV4_JsonNumber;
@class SODataV4_JsonNumberToken;
@class SODataV4_JsonObject;
@class SODataV4_JsonObject_FieldOrdering;
@class SODataV4_JsonOutputStreamWithBuffer; /* internal */
@class SODataV4_JsonString;
@class SODataV4_JsonStringToken;
@class SODataV4_JsonDeltaStream;
@class SODataV4_JsonElementStack; /* internal */
@class SODataV4_JsonObject_EntryList;
@class SODataV4_JsonObject_FieldOrdering_ODataV3; /* internal */
@class SODataV4_JsonObject_FieldOrdering_ODataV4; /* internal */
@class SODataV4_JsonObject_FieldOrdering_ODataV4_01; /* internal */
@class SODataV4_JsonTickString; /* internal */
@class SODataV4_JsonException;
@class SODataV4_Any_asNullable_json_JsonElement_in_json; /* internal */
@class SODataV4_Any_as_core_MapFromString_in_json; /* internal */
@class SODataV4_Any_as_data_ComplexType_in_json; /* internal */
@class SODataV4_Any_as_data_ComplexValueList_in_json; /* internal */
@class SODataV4_Any_as_data_ComplexValue_in_json; /* internal */
@class SODataV4_Any_as_data_DataValueList_in_json; /* internal */
@class SODataV4_Any_as_data_DoubleValue_in_json; /* internal */
@class SODataV4_Any_as_data_EntityType_in_json; /* internal */
@class SODataV4_Any_as_data_EntityValueList_in_json; /* internal */
@class SODataV4_Any_as_data_EntityValue_in_json; /* internal */
@class SODataV4_Any_as_data_EnumType_in_json; /* internal */
@class SODataV4_Any_as_data_FloatValue_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyCollection_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyLineString_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyMultiLineString_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyMultiPoint_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyMultiPolygon_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyPoint_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyPolygon_in_json; /* internal */
@class SODataV4_Any_as_data_GeographyValue_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryCollection_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryLineString_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryMultiLineString_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryMultiPoint_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryMultiPolygon_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryPoint_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryPolygon_in_json; /* internal */
@class SODataV4_Any_as_data_GeometryValue_in_json; /* internal */
@class SODataV4_Any_as_data_GlobalDateTime_in_json; /* internal */
@class SODataV4_Any_as_data_LocalDateTime_in_json; /* internal */
@class SODataV4_Any_as_data_LocalTime_in_json; /* internal */
@class SODataV4_Any_as_data_StreamLink_in_json; /* internal */
@class SODataV4_Any_as_json_JsonArray_in_json; /* internal */
@class SODataV4_Any_as_json_JsonBooleanToken_in_json; /* internal */
@class SODataV4_Any_as_json_JsonElementFrame_in_json; /* internal */
@class SODataV4_Any_as_json_JsonNumberToken_in_json; /* internal */
@class SODataV4_Any_as_json_JsonObject_Entry_in_json; /* internal */
@class SODataV4_Any_as_json_JsonObject_FieldOrdering_in_json; /* internal */
@class SODataV4_Any_as_json_JsonObject_in_json; /* internal */
@class SODataV4_Any_as_json_JsonStringToken_in_json; /* internal */
@class SODataV4_Any_as_json_JsonString_in_json; /* internal */
@class SODataV4_Default_undefined_EntitySet_in_json; /* internal */
@class SODataV4_Map_sortedEntries_JsonObject_in_json; /* internal */
@class SODataV4_Map_sortedKeys_JsonObject_in_json; /* internal */
@class SODataV4_Map_sortedValues_JsonObject_in_json; /* internal */

#ifdef import_SODataV4__Map_sortedEntries_JsonObject_in_json_KeyComparer_internal
#ifndef imported_SODataV4__Map_sortedEntries_JsonObject_in_json_KeyComparer_internal
#define imported_SODataV4__Map_sortedEntries_JsonObject_in_json_KeyComparer_public
/* internal */
@interface SODataV4_Map_sortedEntries_JsonObject_in_json_KeyComparer : SODataV4_Comparer
{
    @private SODataV4_Comparer* _Nonnull comparer_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_Map_sortedEntries_JsonObject_in_json_KeyComparer*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
- (nonnull SODataV4_Comparer*) comparer;
- (void) setComparer :(nonnull SODataV4_Comparer*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Comparer* comparer;
@end
#endif
#endif

#ifndef imported_SODataV4__GeoJson_public
#define imported_SODataV4__GeoJson_public
/// @internal
///
@interface SODataV4_GeoJson : SODataV4_ObjectBase
{
}
/// @return A geography/geometry value in GeoJson representation (as a text string).
/// @param value Data value with a geography or geometry type.
+ (nonnull NSString*) format :(nullable SODataV4_DataValue*)value;
/// @return A geography/geometry value in GeoJson representation (as a JSON object).
/// @param value Data value with a geography or geometry type.
+ (nonnull SODataV4_JsonObject*) formatObject :(nonnull SODataV4_DataValue*)value;
/// @return A geography/geometry value parsed from GeoJson representation.
/// @param text Value in GeoJson representation (as a text string).
/// @param type Data type for the expected parsed result.
+ (nullable SODataV4_DataValue*) parse :(nonnull NSString*)text :(nonnull SODataV4_DataType*)type;
/// @return A geography/geometry value parsed from GeoJson representation.
/// @param geo Value in GeoJson representation (as a JSON object).
/// @param type Data type for the expected parsed result.
+ (nonnull SODataV4_DataValue*) parseObject :(nonnull SODataV4_JsonObject*)geo :(nonnull SODataV4_DataType*)type;
@end
#endif

#ifdef import_SODataV4__GeoJson_private
#ifndef imported_SODataV4__GeoJson_private
#define imported_SODataV4__GeoJson_private
@interface SODataV4_GeoJson (private)
+ (nonnull SODataV4_JsonArray*) formatLineString :(nonnull SODataV4_LineStringCoordinates*)value;
+ (nonnull SODataV4_JsonArray*) formatMultiLineString :(nonnull SODataV4_MultiLineStringCoordinates*)value;
+ (nonnull SODataV4_JsonArray*) formatMultiPoint :(nonnull SODataV4_MultiPointCoordinates*)value;
+ (nonnull SODataV4_JsonArray*) formatMultiPolygon :(nonnull SODataV4_MultiPolygonCoordinates*)value;
+ (nonnull SODataV4_JsonArray*) formatPoint :(nonnull SODataV4_PointCoordinates*)value;
+ (nonnull SODataV4_JsonArray*) formatPolygon :(nonnull SODataV4_PolygonCoordinates*)value;
+ (void) formatSRID :(nonnull SODataV4_JsonObject*)geo :(SODataV4_int)srid :(SODataV4_int)defaultSRID;
+ (nonnull SODataV4_GeographyValue*) parseGeography :(nonnull SODataV4_JsonObject*)geo :(SODataV4_int)tc :(nonnull SODataV4_GeographyValue*)gv;
+ (nonnull SODataV4_GeometryValue*) parseGeometry :(nonnull SODataV4_JsonObject*)geo :(SODataV4_int)tc :(nonnull SODataV4_GeometryValue*)gv;
+ (nonnull SODataV4_LineStringCoordinates*) parseLineString :(nonnull SODataV4_JsonArray*)array;
+ (nonnull SODataV4_MultiLineStringCoordinates*) parseMultiLineString :(nonnull SODataV4_JsonArray*)array;
+ (nonnull SODataV4_MultiPointCoordinates*) parseMultiPoint :(nonnull SODataV4_JsonArray*)array;
+ (nonnull SODataV4_MultiPolygonCoordinates*) parseMultiPolygon :(nonnull SODataV4_JsonArray*)array;
+ (nonnull SODataV4_PointCoordinates*) parsePoint :(nonnull SODataV4_JsonArray*)array;
+ (nonnull SODataV4_PolygonCoordinates*) parsePolygon :(nonnull SODataV4_JsonArray*)array;
+ (SODataV4_int) parseSRID :(nonnull SODataV4_JsonObject*)geo :(SODataV4_int)defaultSRID;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonElement_public
#define imported_SODataV4__JsonElement_public
/// @internal
///
@interface SODataV4_JsonElement : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonElement*) new;
/// @internal
///
- (void) _init;
/// @brief Apply `version` (recursively) to all `SODataV4_JsonObject` instances within `toElement`.
///
///
/// @return `toElement`.
/// @param version Data version.
/// @param toElement Element to which version should be applied.
/// @see `SODataV4_DataVersion`, `SODataV4_JsonObject`.`withVersion`.
+ (nullable SODataV4_JsonElement*) applyVersion :(SODataV4_int)version :(nullable SODataV4_JsonElement*)toElement;
/// @return JSON element (including `nil`) converted to a string.
/// @param element JSON element.
+ (nonnull NSString*) format :(nullable SODataV4_JsonElement*)element;
/// @return String converted to parsed JSON element (including `nil`).
/// @param text Text to be parsed. Must be in JSON element format (null, boolean, number, string, array or object).
+ (nullable SODataV4_JsonElement*) parse :(nonnull NSString*)text;
/// @return String converted to parsed JSON array.
/// @param text Text to be parsed. Must be in JSON array format.
+ (nonnull SODataV4_JsonArray*) parseArray :(nonnull NSString*)text;
/// @return String converted to parsed JSON object.
/// @param text Text to be parsed. Must be in JSON object format.
+ (nonnull SODataV4_JsonObject*) parseObject :(nonnull NSString*)text;
/// @return String converted to parsed JSON element (including `nil`).
/// If `optimized` is `true`, any returned JSON objects will use `SODataV4_JsonObject`.`optimizedEntries` to
/// contain key/value pairs for all JSON fields whose name does not contain "@", rather than regular map entries.
/// @param text Text to be parsed. Must be in JSON element format (null, boolean, number, string, array or object).
/// @param optimized Should "property" (non-annotation) entries of JSON objects be held in `SODataV4_JsonObject`.`optimizedEntries`.
+ (nullable SODataV4_JsonElement*) parseOptimized :(nonnull NSString*)text :(SODataV4_boolean)optimized;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of JSON element.
///
///
/// @see constants.
- (SODataV4_int) type;
#define SODataV4_JsonElement_TYPE_BOOLEAN 1
#define SODataV4_JsonElement_TYPE_NUMBER 2
#define SODataV4_JsonElement_TYPE_STRING 3
#define SODataV4_JsonElement_TYPE_ARRAY 4
#define SODataV4_JsonElement_TYPE_OBJECT 5
/// @brief Type of JSON element.
///
///
/// @see constants.
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifdef import_SODataV4__JsonElementFrame_internal
#ifndef imported_SODataV4__JsonElementFrame_internal
#define imported_SODataV4__JsonElementFrame_public
/* internal */
@interface SODataV4_JsonElementFrame : SODataV4_ObjectBase
{
    @private SODataV4_JsonArray* _Nullable theArray_;
    @private SODataV4_JsonObject* _Nullable theObject_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonElementFrame*) new;
/// @internal
///
- (void) _init;
- (void) setTheArray :(nullable SODataV4_JsonArray*)value;
- (void) setTheObject :(nullable SODataV4_JsonObject*)value;
- (nullable SODataV4_JsonArray*) theArray;
- (nullable SODataV4_JsonObject*) theObject;
@property (nonatomic, readwrite, strong, nullable) SODataV4_JsonArray* theArray;
@property (nonatomic, readwrite, strong, nullable) SODataV4_JsonObject* theObject;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonElementStream_public
#define imported_SODataV4__JsonElementStream_public
/// @internal
///
@interface SODataV4_JsonElementStream : SODataV4_ObjectBase
{
    @private SODataV4_JsonTokenStream* _Nonnull tokenStream_;
    @private SODataV4_boolean isOptimized;
    @private SODataV4_JsonElementStack* _Nonnull stack;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return A new JSON array, after consuming the '[' token. Or return `nil` if the next token is not the start of an array.
///
- (nullable SODataV4_JsonArray*) beginArray;
/// @return A new JSON object, after consuming the '{' token. Or return `nil` if the next token is not the start of an object.
///
- (nullable SODataV4_JsonObject*) beginObject;
/// @brief Expect the next token to be a ']' (end of array), and consume the token.
///
///
- (void) endArray;
/// @brief Expect the next token to be a '}' (end of object), and consume the token.
///
///
- (void) endObject;
/// @return The next token.
/// Expect the next token to be a boolean value, and consume the token.
- (nonnull SODataV4_JsonBooleanToken*) expectBoolean;
/// @brief Expect the next token to be a colon, and consume the token.
///
///
- (void) expectColon;
/// @brief Expect the next token to be a comma, and consume the token.
///
///
- (void) expectComma;
/// @return The next token.
/// Expect the next token to be a number value, and consume the token.
- (nonnull SODataV4_JsonNumberToken*) expectNumber;
/// @return The next token.
/// Expect the next token to be a string value, and consume the token.
- (nonnull SODataV4_JsonStringToken*) expectString;
/// @internal
///
+ (nonnull SODataV4_JsonElementStream*) fromStream :(nonnull SODataV4_CharStream*)stream;
/// @return A new content stream taking input from `stream`.
/// @param stream Input stream.
/// @param optimized (optional) See `SODataV4_JsonElement`.`parseOptimized`.
+ (nonnull SODataV4_JsonElementStream*) fromStream :(nonnull SODataV4_CharStream*)stream :(SODataV4_boolean)optimized;
/// @internal
///
+ (nonnull SODataV4_JsonElementStream*) fromString :(nonnull NSString*)text;
/// @return A new content stream taking input from `text`.
/// @param text Input text.
/// @param optimized (optional) See `SODataV4_JsonElement`.`parseOptimized`.
+ (nonnull SODataV4_JsonElementStream*) fromString :(nonnull NSString*)text :(SODataV4_boolean)optimized;
/// @internal
///
+ (nonnull SODataV4_JsonElementStream*) fromTokens :(nonnull SODataV4_JsonTokenStream*)tokens;
/// @return A new content stream taking input from `tokens`.
/// @param tokens Input tokens.
/// @param optimized (optional) See `SODataV4_JsonElement`.`parseOptimized`.
+ (nonnull SODataV4_JsonElementStream*) fromTokens :(nonnull SODataV4_JsonTokenStream*)tokens :(SODataV4_boolean)optimized;
/// @return `true` if the next token indicates the the end of an array (']').
///
- (SODataV4_boolean) isEndArray;
/// @return `true` if the next token indicates the the end of an object ('}').
///
- (SODataV4_boolean) isEndObject;
/// @return `true` if the next token has the specfied type.
/// @param type Token type.
/// @see `SODataV4_JsonToken`.`type`.
- (SODataV4_boolean) lookingAt :(SODataV4_int)type;
/// @return The next JSON array read from the stream.
///
- (nonnull SODataV4_JsonArray*) readArray;
/// @return The next JSON value (null, boolean, number, string, array, object) read from the stream.
///
- (nullable SODataV4_JsonElement*) readElement;
/// @return The next JSON object read from the stream.
///
- (nonnull SODataV4_JsonObject*) readObject;
/// @return The next JSON string read from the stream.
///
- (nonnull NSString*) readString;
@end
#endif

#ifdef import_SODataV4__JsonElementStream_private
#ifndef imported_SODataV4__JsonElementStream_private
#define imported_SODataV4__JsonElementStream_private
@interface SODataV4_JsonElementStream (private)
+ (nonnull SODataV4_JsonElementStream*) new;
- (SODataV4_boolean) forever;
- (void) popStackFrame;
- (void) setTokenStream :(nonnull SODataV4_JsonTokenStream*)value;
- (nonnull SODataV4_JsonTokenStream*) tokenStream;
- (nonnull SODataV4_JsonElementFrame*) topStackFrame;
+ (nonnull SODataV4_JsonElementFrame*) _new1 :(nullable SODataV4_JsonArray*)p1;
+ (nonnull SODataV4_JsonElementFrame*) _new2 :(nullable SODataV4_JsonObject*)p1;
+ (nonnull SODataV4_JsonElementStream*) _new3 :(SODataV4_boolean)p1 :(nonnull SODataV4_JsonTokenStream*)p2;
+ (nonnull SODataV4_JsonObject_Entry*) _new4 :(nullable SODataV4_JsonElement*)p1 :(nonnull NSString*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_JsonTokenStream* tokenStream;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonObject_Entry_public
#define imported_SODataV4__JsonObject_Entry_public
/// @brief A key/value pair for map entries.
///
///
@interface SODataV4_JsonObject_Entry : SODataV4_ObjectBase
{
    @private NSString* _Nonnull key_;
    @private SODataV4_JsonElement* _Nullable value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonObject_Entry*) new;
/// @internal
///
- (void) _init;
/// @brief Map entry key.
///
///
- (nonnull NSString*) key;
/// @brief Map entry key.
///
///
- (void) setKey :(nonnull NSString*)value;
/// @brief Map entry value.
///
///
- (void) setValue :(nullable SODataV4_JsonElement*)value;
/// @brief Map entry value.
///
///
- (nullable SODataV4_JsonElement*) value;
/// @brief Map entry key.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* key;
/// @brief Map entry value.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_JsonElement* value;
@end
#endif

#ifndef imported_SODataV4__JsonOutputStream_public
#define imported_SODataV4__JsonOutputStream_public
/// @internal
///
@interface SODataV4_JsonOutputStream : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonOutputStream*) new;
/// @internal
///
- (void) _init;
/// @brief Clear the output stream.
///
///
- (void) clear;
/// @return The number of characters written.
///
- (SODataV4_int) length;
/// @return The output in JSON format.
///
- (nonnull NSString*) toString;
/// @return A new JSON output stream which writes to an in-memory buffer.
///
+ (nonnull SODataV4_JsonOutputStream*) withBuffer;
/// @brief Write a character to the stream.
///
///
/// @param c Character to write.
- (void) writeChar :(SODataV4_char)c;
/// @brief Write a JSON element (null, boolean, number, string, array, object) to the stream.
///
///
/// @param element Element to write.
- (void) writeElement :(nullable SODataV4_JsonElement*)element;
/// @brief Write the characters of a string to the stream, with surrounding quotes and escape sequences (as appropriate).
///
///
/// @param text String to write.
- (void) writeString :(nonnull NSString*)text;
/// @brief Write the characters of a string to the stream, without surrounding quotes.
///
///
/// @param text String to write.
- (void) writeVerbatim :(nonnull NSString*)text;
/// @return The number of characters written.
///
@property (nonatomic, readonly) SODataV4_int length;
@end
#endif

#ifdef import_SODataV4__JsonOutputStream_private
#ifndef imported_SODataV4__JsonOutputStream_private
#define imported_SODataV4__JsonOutputStream_private
@interface SODataV4_JsonOutputStream (private)
- (void) writeEscaped :(nonnull NSString*)text;
- (void) writeHex4 :(SODataV4_int)h;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonPretty_public
#define imported_SODataV4__JsonPretty_public
/// @internal
///
@interface SODataV4_JsonPretty : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) print :(nullable SODataV4_JsonElement*)value;
/// @return JSON representation converted to a pretty printed string.
/// @param value JSON representation.
/// @param indent Optional starting indentation level. Defaults to zero; nested items are indented by 4.
+ (nonnull NSString*) print :(nullable SODataV4_JsonElement*)value :(SODataV4_int)indent;
@end
#endif

#ifdef import_SODataV4__JsonPretty_private
#ifndef imported_SODataV4__JsonPretty_private
#define imported_SODataV4__JsonPretty_private
@interface SODataV4_JsonPretty (private)
+ (SODataV4_boolean) allBasic :(nullable SODataV4_JsonElement*)value;
+ (SODataV4_boolean) isEmpty :(nullable SODataV4_JsonElement*)value;
/// @internal
///
+ (nonnull NSString*) write :(nullable SODataV4_JsonElement*)value;
/// @return JSON representation converted to a pretty printed string.
/// @param value JSON representation.
/// @param indent Optional starting indentation level. Defaults to zero; nested items are indented by 4.
+ (nonnull NSString*) write :(nullable SODataV4_JsonElement*)value :(SODataV4_int)indent;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonToken_public
#define imported_SODataV4__JsonToken_public
/// @internal
///
@interface SODataV4_JsonToken : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonToken*) new;
/// @internal
///
- (void) _init;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
#define SODataV4_JsonToken_NULL_VALUE 0
#define SODataV4_JsonToken_BOOLEAN_VALUE 1
#define SODataV4_JsonToken_NUMBER_VALUE 2
#define SODataV4_JsonToken_STRING_VALUE 3
#define SODataV4_JsonToken_COLON_CHAR 4
#define SODataV4_JsonToken_COMMA_CHAR 5
#define SODataV4_JsonToken_BEGIN_ARRAY 6
#define SODataV4_JsonToken_END_ARRAY 7
#define SODataV4_JsonToken_BEGIN_OBJECT 8
#define SODataV4_JsonToken_END_OBJECT 9
#define SODataV4_JsonToken_END_STREAM 10
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifdef import_SODataV4__JsonToken_internal
#ifndef imported_SODataV4__JsonToken_internal
#define imported_SODataV4__JsonToken_internal
@interface SODataV4_JsonToken (internal)
- (void) throwExpected :(nonnull NSString*)what;
#define SODataV4_JsonToken_TICK_VALUE 11
@end
#endif
#endif

#ifndef imported_SODataV4__JsonTokenStream_public
#define imported_SODataV4__JsonTokenStream_public
/// @internal
///
@interface SODataV4_JsonTokenStream : SODataV4_ObjectBase
{
    @private SODataV4_CharStream* _Nonnull stream;
    @private SODataV4_CharBuffer* _Nonnull buffer;
    @private SODataV4_JsonToken* _Nullable next;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return `true` if the next token is the end of an array (']').
///
- (SODataV4_boolean) endArray;
/// @return `true` if the next token is the end of an object ('}').
///
- (SODataV4_boolean) endObject;
/// @return A new token stream taking input from `stream`.
/// @param stream Input stream.
+ (nonnull SODataV4_JsonTokenStream*) fromStream :(nonnull SODataV4_CharStream*)stream;
/// @return A new token stream taking input from `text`.
/// @param text Input text.
+ (nonnull SODataV4_JsonTokenStream*) fromString :(nonnull NSString*)text;
/// @return `true` if the next token has the specfied type.
/// @param type Token type.
/// @see `SODataV4_JsonToken`.`type`.
- (SODataV4_boolean) nextIs :(SODataV4_int)type;
/// @return The next token, which is not consumed. Or a token with type JsonToken.END_STREAM at end of stream.
///
- (nonnull SODataV4_JsonToken*) peek;
/// @return The next token, which is consumed. Or a token with type JsonToken.END_STREAM at end of stream.
///
- (nonnull SODataV4_JsonToken*) read;
/// @brief Undo the last token read, so it can be read again. Only one token can be unread.
///
///
/// @param token The token to be read again.
- (void) undoRead :(nonnull SODataV4_JsonToken*)token;
@end
#endif

#ifdef import_SODataV4__JsonTokenStream_private
#ifndef imported_SODataV4__JsonTokenStream_private
#define imported_SODataV4__JsonTokenStream_private
@interface SODataV4_JsonTokenStream (private)
+ (nonnull SODataV4_JsonTokenStream*) new;
- (void) badNumber :(nonnull SODataV4_CharBuffer*)n :(SODataV4_char)c;
- (nonnull NSString*) badToken4 :(SODataV4_char)c1 :(SODataV4_char)c2 :(SODataV4_char)c3 :(SODataV4_char)c4;
- (nonnull NSString*) badToken5 :(SODataV4_char)c1 :(SODataV4_char)c2 :(SODataV4_char)c3 :(SODataV4_char)c4 :(SODataV4_char)c5;
- (SODataV4_int) parseHex1 :(SODataV4_char)c;
- (SODataV4_int) parseHex4 :(SODataV4_char)c1 :(SODataV4_char)c2 :(SODataV4_char)c3 :(SODataV4_char)c4;
- (nonnull SODataV4_JsonNumberToken*) readNumber :(SODataV4_char)x;
- (nonnull SODataV4_JsonStringToken*) readString;
+ (nonnull SODataV4_JsonTokenStream*) _new1 :(nonnull SODataV4_CharStream*)p1;
#define SODataV4_JsonTokenStream_END_STREAM SODataV4_CHAR(0xFFFF)
@end
#endif
#endif

#ifndef imported_SODataV4__JsonValue_public
#define imported_SODataV4__JsonValue_public
/// @internal
///
@interface SODataV4_JsonValue : SODataV4_ObjectBase
{
}
+ (void) initialize;
/// @return A parsed error response.
/// @param document Error response in JSON representation.
/// @param context Data context.
+ (nonnull SODataV4_ErrorResponse*) errorResponse :(nonnull SODataV4_JsonElement*)document :(nonnull SODataV4_DataContext*)context;
/// @return An action invocation request body in JSON format.
/// @param call Action invocation.
/// @param context Data context.
+ (nonnull SODataV4_JsonElement*) formatCall :(nonnull SODataV4_DataMethodCall*)call :(nonnull SODataV4_DataContext*)context;
/// @return A data value formatted in OData JSON representation.
/// @param value Data value.
/// @param context Data context.
+ (nonnull SODataV4_JsonElement*) formatDocument :(nonnull SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
/// @return An entity reference formatted in OData JSON representation.
/// @param entity Entity value.
/// @param context Data context.
+ (nonnull SODataV4_JsonElement*) formatLink :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return The `value` argument.
/// @param value A JSON array.
+ (nonnull SODataV4_JsonElement*) fromArray :(nonnull SODataV4_JsonArray*)value;
/// @return An OData JSON representation of a value list.
/// @param list Value to be represented in OData JSON format.
/// @param context Data context.
+ (nonnull SODataV4_JsonElement*) fromBasicList :(nonnull SODataV4_DataValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @return A `SODataV4_JsonString` representation of `value`, using URL-safe base-64 encoding.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromBinary :(nonnull NSData*)value;
/// @return A `SODataV4_JsonBoolean` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromBoolean :(SODataV4_boolean)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromByte :(SODataV4_byte)value;
/// @return A `SODataV4_JsonString` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromChar :(SODataV4_char)value;
/// @return An OData JSON representation of a complex list.
/// @param list Value to be represented in OData JSON format.
/// @param context Data context.
+ (nonnull SODataV4_JsonElement*) fromComplexList :(nonnull SODataV4_ComplexValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @return An OData JSON representation of a complex value.
/// @param complex Value to be represented in OData JSON format.
/// @param context Data context.
+ (nullable SODataV4_JsonElement*) fromComplexValue :(nullable SODataV4_ComplexValue*)complex :(nonnull SODataV4_DataContext*)context;
/// @return An OData JSON representation of a data value.
/// @param value Value to be represented in OData JSON format.
/// @param context Data context.
+ (nullable SODataV4_JsonElement*) fromDataValue :(nullable SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromDecimal :(nonnull SODataV4_BigDecimal*)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromDouble :(SODataV4_double)value;
/// @return An OData JSON representation of an entity list.
/// @param list Value to be represented in OData JSON format.
/// @param context Data context.
+ (nonnull SODataV4_JsonElement*) fromEntityList :(nonnull SODataV4_EntityValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @return An OData JSON representation of an entity value.
/// @param entity Value to be represented in OData JSON format.
/// @param context Data context.
+ (nullable SODataV4_JsonElement*) fromEntityValue :(nullable SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromFloat :(SODataV4_float)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromInt :(SODataV4_int)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromInteger :(nonnull SODataV4_BigInteger*)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromLong :(SODataV4_long)value;
/// @return A `SODataV4_JsonString` representation of `value`, using URL-safe base-64 encoding.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableBinary :(nullable NSData*)value;
/// @return A `SODataV4_JsonBoolean` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableBoolean :(SODataV4_nullable_boolean)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableByte :(SODataV4_nullable_byte)value;
/// @return A `SODataV4_JsonString` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableChar :(SODataV4_nullable_char)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableDecimal :(nullable SODataV4_BigDecimal*)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableDouble :(SODataV4_nullable_double)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableFloat :(SODataV4_nullable_float)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableInt :(SODataV4_nullable_int)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableInteger :(nullable SODataV4_BigInteger*)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableLong :(SODataV4_nullable_long)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableShort :(SODataV4_nullable_short)value;
/// @return A `SODataV4_JsonString` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nullable SODataV4_JsonElement*) fromNullableString :(nullable NSString*)value;
/// @return The `value` argument.
/// @param value A JSON object.
+ (nonnull SODataV4_JsonElement*) fromObject :(nonnull SODataV4_JsonObject*)value;
/// @return A `SODataV4_JsonNumber` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromShort :(SODataV4_short)value;
/// @return A `SODataV4_JsonString` representation of `value`.
/// @param value Value to be represented as JSON.
+ (nonnull SODataV4_JsonElement*) fromString :(nonnull NSString*)value;
/// @return A data value (basic, basic list, complex, complex list, entity, entity list) parsed from OData JSON representation.
/// @param document Value in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_DataValue*) parseDocument :(nullable SODataV4_JsonElement*)document :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return An entity reference parsed from OData JSON link representation.
/// The reference will have `SODataV4_EntityValue`.`isReference` == `true`, `SODataV4_EntityValue`.`readLink` != `nil`,
/// and `SODataV4_EntityValue`.`hasKey` will be true if the URI was in canonical URL format.
/// @param document Value in JSON representation.
/// @param type Entity type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_EntityValue*) parseLink :(nonnull SODataV4_JsonElement*)document :(nonnull SODataV4_EntityType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A list of entity references parsed from OData JSON links representation.
/// Each reference will have `SODataV4_EntityValue`.`isReference` == `true`, `SODataV4_EntityValue`.`readLink` != `nil`,
/// and `SODataV4_EntityValue`.`hasKey` will be true if the URI was in canonical URL format.
/// @param document Value in JSON representation.
/// @param type Entity type for the expected parsed result.
/// @param context Data context.
/// @see `SODataV4_JsonValue`.`parseLink`.
+ (nonnull SODataV4_EntityValueList*) parseLinks :(nonnull SODataV4_JsonElement*)document :(nonnull SODataV4_EntityType*)type :(nonnull SODataV4_DataContext*)context;
/// @internal
///
+ (nonnull SODataV4_EntityValue*) parseReference :(nonnull NSString*)uri :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_EntitySet*)entitySet :(nonnull SODataV4_DataContext*)context;
/// @return An entity reference parsed from OData JSON reference representation.
/// The reference will have `SODataV4_EntityValue`.`isReference` == `true`, `SODataV4_EntityValue`.`readLink` != `nil`,
/// and `SODataV4_EntityValue`.`hasKey` will be true if the URI was in canonical URL format.
/// @param uri Entity reference URI.
/// @param entityType Entity type for the expected parsed result.
/// @param entitySet Entity set for the expected parsed result.
/// @param context Data context.
/// @param binding (optional) Is the reference for a "bind operation"?
+ (nonnull SODataV4_EntityValue*) parseReference :(nonnull NSString*)uri :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_EntitySet*)entitySet :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)binding;
/// @return A value list parsed from OData JSON representation.
/// @param element Element in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_DataValueList*) toBasicList :(nullable SODataV4_JsonElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return Binary value parsed from a JSON string.
/// @param element Element, which is expected to have type `SODataV4_JsonString`, and be in base-64 format.
+ (nonnull NSData*) toBinary :(nullable SODataV4_JsonElement*)element;
/// @return Boolean value parsed from a JSON boolean.
/// @param element Element, which is expected to have type `SODataV4_JsonBoolean`.
+ (SODataV4_boolean) toBoolean :(nullable SODataV4_JsonElement*)element;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (SODataV4_byte) toByte :(nullable SODataV4_JsonElement*)element;
/// @return Character value parsed from a JSON string.
/// @param element Element, which is expected to have type `SODataV4_JsonString`.
+ (SODataV4_char) toChar :(nullable SODataV4_JsonElement*)element;
/// @return A complex list parsed from OData JSON representation.
/// @param element Element in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_ComplexValueList*) toComplexList :(nullable SODataV4_JsonElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A complex value parsed from OData JSON representation.
/// @param element Element in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_ComplexValue*) toComplexValue :(nullable SODataV4_JsonElement*)element :(nonnull SODataV4_ComplexType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A data value parsed from OData JSON representation.
/// @param element Element in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_DataValue*) toDataValue :(nullable SODataV4_JsonElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (nonnull SODataV4_BigDecimal*) toDecimal :(nullable SODataV4_JsonElement*)element;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (SODataV4_double) toDouble :(nullable SODataV4_JsonElement*)element;
/// @return An entity list parsed from OData JSON representation.
/// @param element Element in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_EntityValueList*) toEntityList :(nullable SODataV4_JsonElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return An entity value parsed from OData JSON representation.
/// @param element Element in JSON representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_EntityValue*) toEntityValue :(nullable SODataV4_JsonElement*)element :(nonnull SODataV4_EntityType*)type :(nonnull SODataV4_DataContext*)context;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (SODataV4_float) toFloat :(nullable SODataV4_JsonElement*)element;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (SODataV4_int) toInt :(nullable SODataV4_JsonElement*)element;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (nonnull SODataV4_BigInteger*) toInteger :(nullable SODataV4_JsonElement*)element;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (SODataV4_long) toLong :(nullable SODataV4_JsonElement*)element;
/// @return Nullable string value parsed from a JSON string or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonString` in base-64 format.
+ (nullable NSData*) toNullableBinary :(nullable SODataV4_JsonElement*)element;
/// @return Nullable boolean value parsed from a JSON boolean or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonBoolean`.
+ (SODataV4_nullable_boolean) toNullableBoolean :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (SODataV4_nullable_byte) toNullableByte :(nullable SODataV4_JsonElement*)element;
/// @return Nullable character value parsed from a JSON string or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonString`.
+ (SODataV4_nullable_char) toNullableChar :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (nullable SODataV4_BigDecimal*) toNullableDecimal :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (SODataV4_nullable_double) toNullableDouble :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (SODataV4_nullable_float) toNullableFloat :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (SODataV4_nullable_int) toNullableInt :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (nullable SODataV4_BigInteger*) toNullableInteger :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (SODataV4_nullable_long) toNullableLong :(nullable SODataV4_JsonElement*)element;
/// @return Nullable number value parsed from a JSON number or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonNumber`.
+ (SODataV4_nullable_short) toNullableShort :(nullable SODataV4_JsonElement*)element;
/// @return Nullable string value parsed from a JSON string or JSON null.
/// @param element Element, which is expected to be `nil` or to have type `SODataV4_JsonString`.
+ (nullable NSString*) toNullableString :(nullable SODataV4_JsonElement*)element;
/// @return Number value parsed from a JSON number (or JSON string).
/// @param element Element, which is expected to have type `SODataV4_JsonNumber`.
+ (SODataV4_short) toShort :(nullable SODataV4_JsonElement*)element;
/// @return String value parsed from a JSON string.
/// @param element Element, which is expected to have type `SODataV4_JsonString`.
+ (nonnull NSString*) toString :(nullable SODataV4_JsonElement*)element;
@end
#endif

#ifdef import_SODataV4__JsonValue_private
#ifndef imported_SODataV4__JsonValue_private
#define imported_SODataV4__JsonValue_private
@interface SODataV4_JsonValue (private)
+ (nonnull SODataV4_GlobalDateTime*) GDT_1970;
+ (nonnull SODataV4_LocalDateTime*) LDT_1970;
+ (nonnull SODataV4_ComplexType*) actualComplexType :(nonnull SODataV4_JsonObject*)element :(nonnull SODataV4_ComplexType*)formalType :(nonnull SODataV4_DataContext*)context;
+ (nonnull SODataV4_EntityType*) actualEntityType :(nonnull SODataV4_JsonObject*)element :(nonnull SODataV4_EntityType*)formalType :(nonnull SODataV4_DataContext*)context;
+ (nullable NSString*) actualTypeName :(nonnull SODataV4_JsonObject*)element :(nonnull SODataV4_DataContext*)context;
+ (nullable NSString*) checkEntityTag :(nullable NSString*)tag;
+ (void) deepInsert :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context;
+ (void) deepUpdate :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context;
/// @brief Get EnumValue from member name/number.
///
///
+ (nonnull SODataV4_EnumValue*) enumValue :(nonnull SODataV4_EnumType*)type :(nonnull NSString*)name;
/// @internal
///
+ (void) expandChildren :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context;
/// @internal
///
+ (void) expandChildren :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)deepInsert;
+ (void) expandChildren :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)deepInsert :(SODataV4_boolean)deepUpdate;
+ (void) fromStream :(nonnull SODataV4_Property*)property :(nonnull SODataV4_StreamLink*)link :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_DataContext*)context;
+ (void) fromStructureProperties :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_StructureBase*)structure :(nonnull SODataV4_StructureType*)structureType :(nonnull SODataV4_DataContext*)context;
/// @brief Special case to handle numbers received as JSON number or JSON string.
///
/// Some OData V1-V3 services use incorrect encoding.
+ (nonnull NSString*) getNumberText :(nullable SODataV4_JsonElement*)element;
/// @brief Get expected JSON string text.
///
///
+ (nonnull NSString*) getStringText :(nullable SODataV4_JsonElement*)element;
+ (nonnull SODataV4_DataType*) inferDataTypeFromValue :(nullable SODataV4_JsonElement*)value;
/// @brief Map type code to OData type name.
///
///
+ (nonnull NSString*) odataName :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
+ (nullable SODataV4_LocalDateTime*) parseLocalDT :(nonnull NSString*)text;
+ (nullable SODataV4_GlobalDateTime*) parseTicksGDT :(nonnull NSString*)text;
+ (nullable SODataV4_LocalDateTime*) parseTicksLDT :(nonnull NSString*)text;
+ (nullable SODataV4_GlobalDateTime*) parseTicksMS :(nonnull NSString*)text;
+ (nullable SODataV4_LocalTime*) parseTimeV3 :(nonnull NSString*)text;
+ (nonnull SODataV4_DataType*) resolveOpenType :(nullable NSString*)type :(nullable SODataV4_JsonElement*)value :(nonnull SODataV4_DataContext*)context;
+ (void) setDynamicType :(nonnull SODataV4_JsonObject*)map :(nonnull NSString*)name :(nullable SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
+ (void) toStructureProperties :(nonnull SODataV4_JsonObject*)map :(nonnull SODataV4_StructureBase*)structure :(nonnull SODataV4_StructureType*)structureType :(nonnull SODataV4_DataContext*)context;
+ (nonnull SODataV4_JsonElement*) unwrapDocument :(nonnull SODataV4_JsonElement*)document :(nonnull SODataV4_DataContext*)context;
+ (nonnull SODataV4_JsonElement*) wrapDocument :(nonnull SODataV4_JsonElement*)document :(nonnull SODataV4_DataContext*)context;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_GlobalDateTime* GDT_1970;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_LocalDateTime* LDT_1970;
@end
#endif
#endif

#ifdef import_SODataV4__JsonValue_internal
#ifndef imported_SODataV4__JsonValue_internal
#define imported_SODataV4__JsonValue_internal
@interface SODataV4_JsonValue (internal)
+ (nonnull NSString*) valueField :(SODataV4_int)version;
#define SODataV4_JsonValue_AT_ODATA_ASSOCIATION_LINK @"@odata.associationLink"
#define SODataV4_JsonValue_AT_ODATA_BIND @"@odata.bind"
#define SODataV4_JsonValue_AT_ODATA_CONTEXT @"@odata.context"
#define SODataV4_JsonValue_AT_ODATA_COUNT @"@odata.count"
#define SODataV4_JsonValue_AT_ODATA_DELTA_LINK @"@odata.deltaLink"
#define SODataV4_JsonValue_AT_ODATA_EDIT_LINK @"@odata.editLink"
#define SODataV4_JsonValue_AT_ODATA_ETAG @"@odata.etag"
#define SODataV4_JsonValue_AT_ODATA_ID @"@odata.id"
#define SODataV4_JsonValue_AT_ODATA_MEDIA_EDIT_LINK @"@odata.mediaEditLink"
#define SODataV4_JsonValue_AT_ODATA_MEDIA_ENTITY_TAG @"@odata.mediaETag"
#define SODataV4_JsonValue_AT_ODATA_MEDIA_READ_LINK @"@odata.mediaReadLink"
#define SODataV4_JsonValue_AT_ODATA_MEDIA_CONTENT_TYPE @"@odata.mediaContentType"
#define SODataV4_JsonValue_AT_ODATA_NAVIGATION_LINK @"@odata.navigationLink"
#define SODataV4_JsonValue_AT_ODATA_NEXT_LINK @"@odata.nextLink"
#define SODataV4_JsonValue_AT_ODATA_READ_LINK @"@odata.readLink"
#define SODataV4_JsonValue_AT_ODATA_TYPE @"@odata.type"
#define SODataV4_JsonValue_AT_SAP_IS_NEW @"@sap.isNew"
#define SODataV4_JsonValue_AT_SAP_IS_LOCAL @"@sap.isLocal"
#define SODataV4_JsonValue_AT_SAP_IS_CREATED @"@sap.isCreated"
#define SODataV4_JsonValue_AT_SAP_IS_UPDATED @"@sap.isUpdated"
#define SODataV4_JsonValue_AT_SAP_IS_DELETED @"@sap.isDeleted"
#define SODataV4_JsonValue_AT_SAP_IN_ERROR_STATE @"@sap.inErrorState"
#define SODataV4_JsonValue_AT_SAP_MEDIA_IS_OFFLINE @"@sap.mediaIsOffline"
#define SODataV4_JsonValue_AT_SAP_OLD_ENTITY_VALUES @"@sap.oldEntity"
#define SODataV4_JsonValue_AT_SAP_HAS_PENDING_CHANGES @"@sap.hasPendingChanges"
#define SODataV4_JsonValue_AT_SAP_HAS_LOCAL_RELATIVES @"@sap.hasLocalRelatives"
#define SODataV4_JsonValue_AT_SAP_HAS_RELATIVES_WITH_PENDING_CHANGES @"@sap.hasRelativesWithPendingChanges"
#define SODataV4_JsonValue_V3_CONTENT_TYPE @"content_type"
#define SODataV4_JsonValue_V3_COUNT @"__count"
#define SODataV4_JsonValue_V3_DEFERRED @"__deferred"
#define SODataV4_JsonValue_V3_DELTA @"__delta"
#define SODataV4_JsonValue_V3_EDIT_MEDIA @"edit_media"
#define SODataV4_JsonValue_V3_ETAG @"etag"
#define SODataV4_JsonValue_V3_ID @"id"
#define SODataV4_JsonValue_V3_MEDIA_ETAG @"media_etag"
#define SODataV4_JsonValue_V3_MEDIA_SRC @"media_src"
#define SODataV4_JsonValue_V3_MEDIARESOURCE @"__mediaresource"
#define SODataV4_JsonValue_V3_METADATA @"__metadata"
#define SODataV4_JsonValue_V3_NEXT @"__next"
#define SODataV4_JsonValue_V3_READ @"__read"
#define SODataV4_JsonValue_V3_TYPE @"type"
#define SODataV4_JsonValue_V3_URI @"uri"
@end
#endif
#endif

#ifndef imported_SODataV4__JsonArray_public
#define imported_SODataV4__JsonArray_public
/// @internal
///
@interface SODataV4_JsonArray : SODataV4_JsonElement
{
    @private SODataV4_UntypedList* _Nonnull _untyped_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_JsonArray`.`length` of zero and specified initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_JsonArray*) new;
/// @brief Construct a new list with `SODataV4_JsonArray`.`length` of zero and specified initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity (optional) Initial capacity.
+ (nonnull SODataV4_JsonArray*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nullable SODataV4_JsonElement*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_JsonArray*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_JsonArray*) addThis :(nullable SODataV4_JsonElement*)item;
/// @brief Remove all items from this list.
///
///
- (void) clear;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_JsonArray*) copy;
/// @brief An immutable empty `SODataV4_JsonArray`.
///
///
+ (nonnull SODataV4_JsonArray*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nullable SODataV4_JsonElement*) first;
/// @return The 'value' cast as a `SODataV4_JsonArray`.
/// @throw `SODataV4_JsonException` if `value` is not an instanceof of `SODataV4_JsonArray`.
/// @param value Element value.
+ (nonnull SODataV4_JsonArray*) fromElement :(nullable SODataV4_JsonElement*)value;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonArray`.`length` - 1).
- (nullable SODataV4_JsonElement*) get :(SODataV4_int)index;
/// @return An item of this array cast as a `SODataV4_JsonArray`.
/// @param index Item index.
- (nonnull SODataV4_JsonArray*) getArray :(SODataV4_int)index;
/// @return An item of this array cast as a `SODataV4_JsonObject`.
/// @param index Item index.
- (nonnull SODataV4_JsonObject*) getObject :(SODataV4_int)index;
/// @return An item of this array cast as a `string`.
/// @param index Item index.
- (nonnull NSString*) getString :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison.
- (SODataV4_boolean) includes :(nullable SODataV4_JsonElement*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nullable SODataV4_JsonElement*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nullable SODataV4_JsonElement*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonArray`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_JsonArray*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonArray`.`length`).
- (void) insertAt :(SODataV4_int)index :(nullable SODataV4_JsonElement*)item;
/// @brief `true` if this list contains no items.
///
///
- (SODataV4_boolean) isEmpty;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nullable SODataV4_JsonElement*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nullable NSObject*)item;
/// @return Last index in this list of `item`, or -1 if not found.
/// @param item Item for comparison.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nullable NSObject*)item :(SODataV4_int)start;
/// @brief The number of items in this list.
///
///
- (SODataV4_int) length;
/// @brief Remove an item from the specified index in this list.
///
///
/// @param index Index of the item to be removed.
- (void) removeAt :(SODataV4_int)index;
/// @brief Remove a range of items from this list.
///
///
/// @param start Starting index (inclusive) for items to be removed.
/// @param end Ending index (exclusive) for items to be removed.
- (void) removeRange :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Reverse the order of the items in this list.
///
///
- (void) reverse;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nullable SODataV4_JsonElement*)item;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nullable SODataV4_JsonElement*) single;
/// @internal
///
- (nonnull SODataV4_JsonArray*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_JsonArray*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief Sort the items in this list.
///
///
- (void) sort;
/// @return The array in [JSON](http://json.org) format.
///
- (nonnull NSString*) toString;
/// @brief Type of JSON element.
///
///
/// @see constants.
- (SODataV4_int) type;
/// @brief The underlying untyped list of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
- (nonnull SODataV4_UntypedList*) untypedList;
/// @brief An immutable empty `SODataV4_JsonArray`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonArray* empty;
/// @brief `true` if this list contains no items.
///
///
@property (nonatomic, readonly) SODataV4_boolean isEmpty;
/// @brief The number of items in this list.
///
///
@property (nonatomic, readonly) SODataV4_int length;
/// @brief Type of JSON element.
///
///
/// @see constants.
@property (nonatomic, readonly) SODataV4_int type;
/// @brief The underlying untyped list of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_UntypedList* untypedList;
@end
#endif

#ifdef import_SODataV4__JsonArray_private
#ifndef imported_SODataV4__JsonArray_private
#define imported_SODataV4__JsonArray_private
@interface SODataV4_JsonArray (private)
- (nonnull SODataV4_UntypedList*) _untyped;
- (void) set_untyped :(nonnull SODataV4_UntypedList*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_UntypedList* _untyped;
@end
#endif
#endif

#ifdef import_SODataV4__JsonBeginArray_internal
#ifndef imported_SODataV4__JsonBeginArray_internal
#define imported_SODataV4__JsonBeginArray_public
/* internal */
@interface SODataV4_JsonBeginArray : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonBeginArray_private
#ifndef imported_SODataV4__JsonBeginArray_private
#define imported_SODataV4__JsonBeginArray_private
@interface SODataV4_JsonBeginArray (private)
+ (nonnull SODataV4_JsonBeginArray*) new;
@end
#endif
#endif

#ifdef import_SODataV4__JsonBeginObject_internal
#ifndef imported_SODataV4__JsonBeginObject_internal
#define imported_SODataV4__JsonBeginObject_public
/* internal */
@interface SODataV4_JsonBeginObject : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonBeginObject_private
#ifndef imported_SODataV4__JsonBeginObject_private
#define imported_SODataV4__JsonBeginObject_private
@interface SODataV4_JsonBeginObject (private)
+ (nonnull SODataV4_JsonBeginObject*) new;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonBoolean_public
#define imported_SODataV4__JsonBoolean_public
/// @internal
///
@interface SODataV4_JsonBoolean : SODataV4_JsonElement
{
    @private SODataV4_boolean value_;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Immutable element with `false` value.
///
///
+ (nonnull SODataV4_JsonBoolean*) FALSE_;
/// @brief Immutable element with `true` value.
///
///
+ (nonnull SODataV4_JsonBoolean*) TRUE_;
/// @return A boolean element with the specified `value`.
/// @param value Boolean value.
+ (nonnull SODataV4_JsonBoolean*) of :(SODataV4_boolean)value;
/// @return The boolean `SODataV4_JsonBoolean`.`value` in [JSON](http://json.org) format.
///
- (nonnull NSString*) toString;
/// @brief JsonElement.TYPE_BOOLEAN.
///
///
- (SODataV4_int) type;
/// @brief Value of this element.
///
///
- (SODataV4_boolean) value;
/// @brief Immutable element with `false` value.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonBoolean* FALSE_;
/// @brief Immutable element with `true` value.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonBoolean* TRUE_;
/// @brief JsonElement.TYPE_BOOLEAN.
///
///
@property (nonatomic, readonly) SODataV4_int type;
/// @brief Value of this element.
///
///
@property (nonatomic, readonly) SODataV4_boolean value;
@end
#endif

#ifdef import_SODataV4__JsonBoolean_private
#ifndef imported_SODataV4__JsonBoolean_private
#define imported_SODataV4__JsonBoolean_private
@interface SODataV4_JsonBoolean (private)
+ (nonnull SODataV4_JsonBoolean*) new;
+ (nonnull SODataV4_JsonBoolean*) _new1 :(SODataV4_boolean)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonBooleanToken_public
#define imported_SODataV4__JsonBooleanToken_public
/// @internal
///
@interface SODataV4_JsonBooleanToken : SODataV4_JsonToken
{
    @private SODataV4_boolean value_;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return A new boolean token with the specified `value`.
/// @param value Boolean value.
+ (nonnull SODataV4_JsonBooleanToken*) of :(SODataV4_boolean)value;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief JsonToken.BOOLEAN_VALUE.
///
///
- (SODataV4_int) type;
/// @brief Value of this token.
///
///
- (SODataV4_boolean) value;
/// @brief JsonToken.BOOLEAN_VALUE.
///
///
@property (nonatomic, readonly) SODataV4_int type;
/// @brief Value of this token.
///
///
@property (nonatomic, readonly) SODataV4_boolean value;
@end
#endif

#ifdef import_SODataV4__JsonBooleanToken_private
#ifndef imported_SODataV4__JsonBooleanToken_private
#define imported_SODataV4__JsonBooleanToken_private
@interface SODataV4_JsonBooleanToken (private)
+ (nonnull SODataV4_JsonBooleanToken*) new;
+ (nonnull SODataV4_JsonBooleanToken*) _new1 :(SODataV4_boolean)p1;
@end
#endif
#endif

#ifdef import_SODataV4__JsonBooleanToken_internal
#ifndef imported_SODataV4__JsonBooleanToken_internal
#define imported_SODataV4__JsonBooleanToken_internal
@interface SODataV4_JsonBooleanToken (internal)
+ (nonnull SODataV4_JsonBooleanToken*) FALSE_;
+ (nonnull SODataV4_JsonBooleanToken*) TRUE_;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonBooleanToken* FALSE_;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonBooleanToken* TRUE_;
@end
#endif
#endif

#ifdef import_SODataV4__JsonColonChar_internal
#ifndef imported_SODataV4__JsonColonChar_internal
#define imported_SODataV4__JsonColonChar_public
/* internal */
@interface SODataV4_JsonColonChar : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonColonChar_private
#ifndef imported_SODataV4__JsonColonChar_private
#define imported_SODataV4__JsonColonChar_private
@interface SODataV4_JsonColonChar (private)
+ (nonnull SODataV4_JsonColonChar*) new;
@end
#endif
#endif

#ifdef import_SODataV4__JsonCommaChar_internal
#ifndef imported_SODataV4__JsonCommaChar_internal
#define imported_SODataV4__JsonCommaChar_public
/* internal */
@interface SODataV4_JsonCommaChar : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonCommaChar_private
#ifndef imported_SODataV4__JsonCommaChar_private
#define imported_SODataV4__JsonCommaChar_private
@interface SODataV4_JsonCommaChar (private)
+ (nonnull SODataV4_JsonCommaChar*) new;
@end
#endif
#endif

#ifdef import_SODataV4__JsonEndArray_internal
#ifndef imported_SODataV4__JsonEndArray_internal
#define imported_SODataV4__JsonEndArray_public
/* internal */
@interface SODataV4_JsonEndArray : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonEndArray_private
#ifndef imported_SODataV4__JsonEndArray_private
#define imported_SODataV4__JsonEndArray_private
@interface SODataV4_JsonEndArray (private)
+ (nonnull SODataV4_JsonEndArray*) new;
@end
#endif
#endif

#ifdef import_SODataV4__JsonEndObject_internal
#ifndef imported_SODataV4__JsonEndObject_internal
#define imported_SODataV4__JsonEndObject_public
/* internal */
@interface SODataV4_JsonEndObject : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonEndObject_private
#ifndef imported_SODataV4__JsonEndObject_private
#define imported_SODataV4__JsonEndObject_private
@interface SODataV4_JsonEndObject (private)
+ (nonnull SODataV4_JsonEndObject*) new;
@end
#endif
#endif

#ifdef import_SODataV4__JsonEndStream_internal
#ifndef imported_SODataV4__JsonEndStream_internal
#define imported_SODataV4__JsonEndStream_public
/* internal */
@interface SODataV4_JsonEndStream : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonEndStream_private
#ifndef imported_SODataV4__JsonEndStream_private
#define imported_SODataV4__JsonEndStream_private
@interface SODataV4_JsonEndStream (private)
+ (nonnull SODataV4_JsonEndStream*) new;
@end
#endif
#endif

#ifdef import_SODataV4__JsonNullValue_internal
#ifndef imported_SODataV4__JsonNullValue_internal
#define imported_SODataV4__JsonNullValue_public
/* internal */
@interface SODataV4_JsonNullValue : SODataV4_JsonToken
{
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonToken*) TOKEN;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonToken* TOKEN;
/// @brief Type of token.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__JsonNullValue_private
#ifndef imported_SODataV4__JsonNullValue_private
#define imported_SODataV4__JsonNullValue_private
@interface SODataV4_JsonNullValue (private)
+ (nonnull SODataV4_JsonNullValue*) new;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonNumber_public
#define imported_SODataV4__JsonNumber_public
/// @internal
///
@interface SODataV4_JsonNumber : SODataV4_JsonElement
{
    @private NSString* _Nonnull value_;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return A number element with the specified `value`.
/// @param value Number value, expressed as a string to retain all precision. The string must contain valid [JSON](http://json.org) number syntax.
+ (nonnull SODataV4_JsonNumber*) of :(nonnull NSString*)value;
/// @return The number `SODataV4_JsonNumber`.`value` in [JSON](http://json.org) format.
///
- (nonnull NSString*) toString;
/// @brief JsonElement.TYPE_NUMBER.
///
///
- (SODataV4_int) type;
/// @brief Value of this element, expressed as a string to retain all precision.
///
///
- (nonnull NSString*) value;
/// @brief Immutable element with value zero.
///
///
+ (nonnull SODataV4_JsonNumber*) zero;
/// @brief JsonElement.TYPE_NUMBER.
///
///
@property (nonatomic, readonly) SODataV4_int type;
/// @brief Value of this element, expressed as a string to retain all precision.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* value;
/// @brief Immutable element with value zero.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumber* zero;
@end
#endif

#ifdef import_SODataV4__JsonNumber_private
#ifndef imported_SODataV4__JsonNumber_private
#define imported_SODataV4__JsonNumber_private
@interface SODataV4_JsonNumber (private)
+ (nonnull SODataV4_JsonNumber*) new;
+ (nonnull SODataV4_JsonNumber*) _new1 :(nonnull NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonNumberToken_public
#define imported_SODataV4__JsonNumberToken_public
/// @internal
///
@interface SODataV4_JsonNumberToken : SODataV4_JsonToken
{
    @private NSString* _Nonnull value_;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return A new boolean token with the specified `value`.
/// @param value Number value, expressed as a string to retain all precision. The string contain valid [JSON](http://json.org) number syntax.
+ (nonnull SODataV4_JsonNumberToken*) of :(nonnull NSString*)value;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief JsonToken.NUMBER_VALUE.
///
///
- (SODataV4_int) type;
/// @brief Value of this token, expressed as a string to retain all precision.
///
///
- (nonnull NSString*) value;
/// @brief JsonToken.NUMBER_VALUE.
///
///
@property (nonatomic, readonly) SODataV4_int type;
/// @brief Value of this token, expressed as a string to retain all precision.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* value;
@end
#endif

#ifdef import_SODataV4__JsonNumberToken_private
#ifndef imported_SODataV4__JsonNumberToken_private
#define imported_SODataV4__JsonNumberToken_private
@interface SODataV4_JsonNumberToken (private)
+ (nonnull SODataV4_JsonNumberToken*) new;
+ (nonnull SODataV4_JsonNumberToken*) _new1 :(nonnull NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__JsonNumberToken_internal
#ifndef imported_SODataV4__JsonNumberToken_internal
#define imported_SODataV4__JsonNumberToken_internal
@interface SODataV4_JsonNumberToken (internal)
+ (nonnull SODataV4_JsonNumberToken*) EIGHT;
+ (nonnull SODataV4_JsonNumberToken*) FIVE;
+ (nonnull SODataV4_JsonNumberToken*) FOUR;
+ (nonnull SODataV4_JsonNumberToken*) NINE;
+ (nonnull SODataV4_JsonNumberToken*) ONE;
+ (nonnull SODataV4_JsonNumberToken*) SEVEN;
+ (nonnull SODataV4_JsonNumberToken*) SIX;
+ (nonnull SODataV4_JsonNumberToken*) THREE;
+ (nonnull SODataV4_JsonNumberToken*) TWO;
+ (nonnull SODataV4_JsonNumberToken*) ZERO;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* EIGHT;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* FIVE;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* FOUR;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* NINE;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* ONE;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* SEVEN;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* SIX;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* THREE;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* TWO;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonNumberToken* ZERO;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonObject_public
#define imported_SODataV4__JsonObject_public
/// @internal
///
@interface SODataV4_JsonObject : SODataV4_JsonElement
{
    @private SODataV4_MapFromString* _Nonnull _untyped_;
    @private SODataV4_JsonObject_FieldOrdering* _Nullable customOrdering_;
    @private SODataV4_JsonObject_EntryList* _Nonnull optimizedEntries_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_JsonObject`.`size` of zero and optional initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
+ (nonnull SODataV4_JsonObject*) new;
/// @brief Construct a new map with `SODataV4_JsonObject`.`size` of zero and optional initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_JsonObject*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Remove all entries from this map.
///
///
- (void) clear;
/// @brief Ordering constraints for JSON formatting. By default, fields may appear in arbitrary order.
///
///
- (nullable SODataV4_JsonObject_FieldOrdering*) customOrdering;
/// @brief Delete the entry with the specified `key` (if found).
///
///
/// @return `true` if an entry with the specified `key` was found (and deleted).
/// @param key Entry key.
- (SODataV4_boolean) delete_ :(nonnull NSString*)key;
/// @brief An immutable empty `SODataV4_JsonObject`.
///
///
+ (nonnull SODataV4_JsonObject*) empty;
/// @return A list of the entries (key/value pairs) in this map.
///
- (nonnull SODataV4_JsonObject_EntryList*) entries;
/// @return The 'value' cast as a `SODataV4_JsonObject`.
/// @throw `SODataV4_JsonException` if `value` is not an instanceof of `SODataV4_JsonObject`.
/// @param value Element value.
+ (nonnull SODataV4_JsonObject*) fromElement :(nullable SODataV4_JsonElement*)value;
/// @return The value from the entry with the specified `key` (if found), otherwise `nil`.
/// @param key Entry key.
- (nullable SODataV4_JsonElement*) get :(nonnull NSString*)key;
/// @return A field of this object cast as a `SODataV4_JsonArray`.
/// @param name Field name.
- (nonnull SODataV4_JsonArray*) getArray :(nonnull NSString*)name;
/// @return A field of this object cast as a nullable `SODataV4_JsonArray`.
/// @param name Field name.
- (nullable SODataV4_JsonArray*) getNullableArray :(nonnull NSString*)name;
/// @return A field of this object cast as a nullable `SODataV4_JsonObject`.
/// @param name Field name.
- (nullable SODataV4_JsonObject*) getNullableObject :(nonnull NSString*)name;
/// @return A field of this object cast as a nullable `string`.
/// @param name Field name.
- (nullable NSString*) getNullableString :(nonnull NSString*)name;
/// @return A field of this object cast as a `SODataV4_JsonObject`.
/// @param name Field name.
- (nonnull SODataV4_JsonObject*) getObject :(nonnull NSString*)name;
/// @return The value from the entry with the specified `key` (if found).
/// @throw `SODataV4_MissingEntryException` if no entry is found for the specified key.
/// @param key Entry key.
- (nullable SODataV4_JsonElement*) getRequired :(nonnull NSString*)key;
/// @return The value of a required field of this object.
/// @param field Field name.
- (nullable SODataV4_JsonElement*) getRequiredField :(nonnull NSString*)field;
/// @return A field of this object cast as a `string`.
/// @param name Field name.
- (nonnull NSString*) getString :(nonnull NSString*)name;
/// @return `true` if this map has an entry with the specified `key`, otherwise `false`.
/// @param key Entry key.
- (SODataV4_boolean) has :(nonnull NSString*)key;
/// @return A list of the entry keys in this map.
///
- (nonnull SODataV4_StringList*) keys;
/// @brief Set for objects parsed with `SODataV4_JsonElement`.`parseOptimized`, to include all json field/value pairs where the field name does not contain "@". Otherwise empty.
///
/// The optimization is that adding entries to a list can be more efficient than adding them to a map, so long as the list consumer doesn't require by-name lookup.
- (nonnull SODataV4_JsonObject_EntryList*) optimizedEntries;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @param value Entry value.
/// @param key Entry key.
- (void) set :(nonnull NSString*)key :(nullable SODataV4_JsonElement*)value;
/// @brief Set a field of this object to a JSON array.
///
///
/// @param name Field name.
/// @param value Field value.
- (void) setArray :(nonnull NSString*)name :(nonnull SODataV4_JsonArray*)value;
/// @brief Ordering constraints for JSON formatting. By default, fields may appear in arbitrary order.
///
///
- (void) setCustomOrdering :(nullable SODataV4_JsonObject_FieldOrdering*)value;
/// @brief Set a field of this object to a JSON object.
///
///
/// @param name Field name.
/// @param value Field value.
- (void) setObject :(nonnull NSString*)name :(nonnull SODataV4_JsonObject*)value;
/// @brief Set for objects parsed with `SODataV4_JsonElement`.`parseOptimized`, to include all json field/value pairs where the field name does not contain "@". Otherwise empty.
///
/// The optimization is that adding entries to a list can be more efficient than adding them to a map, so long as the list consumer doesn't require by-name lookup.
- (void) setOptimizedEntries :(nonnull SODataV4_JsonObject_EntryList*)value;
/// @brief Set a field of this object to a JSON string.
///
///
/// @param name Field name.
/// @param value Field value.
- (void) setString :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @return This map.
/// @param key Entry key.
/// @param value Entry value.
- (nonnull SODataV4_JsonObject*) setThis :(nonnull NSString*)key :(nullable SODataV4_JsonElement*)value;
/// @brief The number of items in this map.
///
///
- (SODataV4_int) size;
/// @return The entries of this map sorted by key.
/// @see `SODataV4_JsonObject`.`customOrdering`, which can be used to override the ordering.
- (nonnull SODataV4_JsonObject_EntryList*) sortedEntries;
/// @return The sorted keys of this map.
///
- (nonnull SODataV4_StringList*) sortedKeys;
/// @return The sorted values of this map.
///
- (nonnull SODataV4_JsonArray*) sortedValues;
/// @return The object in [JSON](http://json.org) format.
///
- (nonnull NSString*) toString;
/// @brief Type of JSON element.
///
///
/// @see constants.
- (SODataV4_int) type;
/// @brief The underlying untyped map of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
- (nonnull SODataV4_UntypedMap*) untypedMap;
/// @return A list of the entry values in this map.
///
- (nonnull SODataV4_JsonArray*) values;
/// @brief Sets `SODataV4_JsonObject`.`customOrdering` according to the specified `version`.
///
///
/// @return This object.
/// @param version Data version.
/// @see `SODataV4_DataVersion`.
- (nonnull SODataV4_JsonObject*) withVersion :(SODataV4_int)version;
/// @brief Ordering constraints for JSON formatting. By default, fields may appear in arbitrary order.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_JsonObject_FieldOrdering* customOrdering;
/// @brief An immutable empty `SODataV4_JsonObject`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonObject* empty;
/// @brief Set for objects parsed with `SODataV4_JsonElement`.`parseOptimized`, to include all json field/value pairs where the field name does not contain "@". Otherwise empty.
///
/// The optimization is that adding entries to a list can be more efficient than adding them to a map, so long as the list consumer doesn't require by-name lookup.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_JsonObject_EntryList* optimizedEntries;
/// @brief The number of items in this map.
///
///
@property (nonatomic, readonly) SODataV4_int size;
/// @brief Type of JSON element.
///
///
/// @see constants.
@property (nonatomic, readonly) SODataV4_int type;
/// @brief The underlying untyped map of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_UntypedMap* untypedMap;
@end
#endif

#ifdef import_SODataV4__JsonObject_private
#ifndef imported_SODataV4__JsonObject_private
#define imported_SODataV4__JsonObject_private
@interface SODataV4_JsonObject (private)
- (nonnull SODataV4_MapFromString*) _untyped;
- (void) set_untyped :(nonnull SODataV4_MapFromString*)value;
+ (nonnull SODataV4_JsonObject_Entry*) _new1 :(nullable SODataV4_JsonElement*)p1 :(nonnull NSString*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_MapFromString* _untyped;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonObject_FieldOrdering_public
#define imported_SODataV4__JsonObject_FieldOrdering_public
/// @brief Comparer for JSON object field ordering.
///
///
@interface SODataV4_JsonObject_FieldOrdering : SODataV4_Comparer
{
    @private SODataV4_PropertyMap* _Nullable propertyMap_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonObject_FieldOrdering*) new;
/// @internal
///
- (void) _init;
/// @brief Map of properties (metadata), useful if payload ordering constraints might require that knowledge. Initially an immutable map.
///
///
- (nullable SODataV4_PropertyMap*) propertyMap;
/// @brief Map of properties (metadata), useful if payload ordering constraints might require that knowledge. Initially an immutable map.
///
///
- (void) setPropertyMap :(nullable SODataV4_PropertyMap*)value;
/// @brief Map of properties (metadata), useful if payload ordering constraints might require that knowledge. Initially an immutable map.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_PropertyMap* propertyMap;
@end
#endif

#ifdef import_SODataV4__JsonOutputStreamWithBuffer_internal
#ifndef imported_SODataV4__JsonOutputStreamWithBuffer_internal
#define imported_SODataV4__JsonOutputStreamWithBuffer_public
/* internal */
@interface SODataV4_JsonOutputStreamWithBuffer : SODataV4_JsonOutputStream
{
    @private SODataV4_CharBuffer* _Nonnull buffer;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonOutputStreamWithBuffer*) new;
/// @internal
///
- (void) _init;
/// @brief Clear the output stream.
///
///
- (void) clear;
/// @return The number of characters written.
///
- (SODataV4_int) length;
/// @return The output in JSON format.
///
- (nonnull NSString*) toString;
/// @brief Write a character to the stream.
///
///
/// @param c Character to write.
- (void) writeChar :(SODataV4_char)c;
/// @brief Write the characters of a string to the stream, without surrounding quotes.
///
///
/// @param text String to write.
- (void) writeVerbatim :(nonnull NSString*)text;
/// @return The number of characters written.
///
@property (nonatomic, readonly) SODataV4_int length;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonString_public
#define imported_SODataV4__JsonString_public
/// @internal
///
@interface SODataV4_JsonString : SODataV4_JsonElement
{
    @private NSString* _Nonnull _value_;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Immutable element with empty value.
///
///
+ (nonnull SODataV4_JsonString*) empty;
/// @return A string element with the specified `value`.
/// @param value String value.
+ (nonnull SODataV4_JsonString*) of :(nonnull NSString*)value;
/// @return The string `SODataV4_JsonString`.`value` in [JSON](http://json.org) format.
///
- (nonnull NSString*) toString;
/// @brief JsonElement.TYPE_STRING.
///
///
- (SODataV4_int) type;
/// @brief Value of this element.
///
///
- (nonnull NSString*) value;
/// @brief Immutable element with empty value.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonString* empty;
/// @brief JsonElement.TYPE_STRING.
///
///
@property (nonatomic, readonly) SODataV4_int type;
/// @brief Value of this element.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* value;
@end
#endif

#ifdef import_SODataV4__JsonString_private
#ifndef imported_SODataV4__JsonString_private
#define imported_SODataV4__JsonString_private
@interface SODataV4_JsonString (private)
+ (nonnull SODataV4_JsonString*) _new1 :(nonnull NSString*)p1;
- (nonnull NSString*) _value;
@property (nonatomic, readonly, strong, nonnull) NSString* _value;
@end
#endif
#endif

#ifdef import_SODataV4__JsonString_internal
#ifndef imported_SODataV4__JsonString_internal
#define imported_SODataV4__JsonString_internal
@interface SODataV4_JsonString (internal)
+ (nonnull SODataV4_JsonString*) new;
- (SODataV4_boolean) isTick;
- (nonnull NSString*) unquoted;
@property (nonatomic, readonly) SODataV4_boolean isTick;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonStringToken_public
#define imported_SODataV4__JsonStringToken_public
/// @internal
///
@interface SODataV4_JsonStringToken : SODataV4_JsonToken
{
    @private NSString* _Nonnull value_;
}
+ (void) initialize;
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @return A new string boolean token with the specified `value`.
/// @param value Number value, expressed as a string to retain all precision. The string contain valid [JSON](http://json.org) number syntax.
+ (nonnull SODataV4_JsonStringToken*) of :(nonnull NSString*)value;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief JsonToken.STRING_VALUE.
///
///
- (SODataV4_int) type;
/// @brief Value of this token.
///
///
- (nonnull NSString*) value;
/// @brief JsonToken.STRING_VALUE.
///
///
@property (nonatomic, readonly) SODataV4_int type;
/// @brief Value of this token.
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* value;
@end
#endif

#ifdef import_SODataV4__JsonStringToken_private
#ifndef imported_SODataV4__JsonStringToken_private
#define imported_SODataV4__JsonStringToken_private
@interface SODataV4_JsonStringToken (private)
+ (nonnull SODataV4_JsonStringToken*) new;
+ (nonnull SODataV4_JsonStringToken*) _new1 :(nonnull NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__JsonStringToken_internal
#ifndef imported_SODataV4__JsonStringToken_internal
#define imported_SODataV4__JsonStringToken_internal
@interface SODataV4_JsonStringToken (internal)
+ (nonnull SODataV4_JsonStringToken*) EMPTY;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonStringToken* EMPTY;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonDeltaStream_public
#define imported_SODataV4__JsonDeltaStream_public
/// @internal
///
@interface SODataV4_JsonDeltaStream : SODataV4_DeltaStream
{
    @private SODataV4_DataContext* _Nonnull dataContext_;
    @private SODataV4_CharStream* _Nonnull charStream_;
    @private SODataV4_JsonElementStream* _Nonnull jsonStream_;
    @private SODataV4_boolean firstItem;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
- (void) abort;
- (void) close;
/// @brief Convert a character stream containing OData delta JSON encoding into a stream of delta items.
///
///
/// @param stream Character stream.
/// @param context Data context.
+ (nonnull SODataV4_JsonDeltaStream*) fromStream :(nonnull SODataV4_CharStream*)stream :(nonnull SODataV4_DataContext*)context;
- (SODataV4_boolean) next;
@end
#endif

#ifdef import_SODataV4__JsonDeltaStream_private
#ifndef imported_SODataV4__JsonDeltaStream_private
#define imported_SODataV4__JsonDeltaStream_private
@interface SODataV4_JsonDeltaStream (private)
+ (nonnull SODataV4_JsonDeltaStream*) new;
- (nonnull SODataV4_CharStream*) charStream;
- (nonnull SODataV4_DataContext*) dataContext;
- (nonnull SODataV4_JsonElementStream*) jsonStream;
- (void) setCharStream :(nonnull SODataV4_CharStream*)value;
- (void) setDataContext :(nonnull SODataV4_DataContext*)value;
- (void) setJsonStream :(nonnull SODataV4_JsonElementStream*)value;
+ (nonnull SODataV4_JsonDeltaStream*) _new1 :(nonnull SODataV4_CharStream*)p1 :(nonnull SODataV4_DataContext*)p2 :(nonnull SODataV4_JsonElementStream*)p3 :(SODataV4_boolean)p4;
+ (nonnull SODataV4_ChangedLink*) _new2 :(SODataV4_boolean)p1;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CharStream* charStream;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataContext* dataContext;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_JsonElementStream* jsonStream;
@end
#endif
#endif

#ifdef import_SODataV4__JsonDeltaStream_internal
#ifndef imported_SODataV4__JsonDeltaStream_internal
#define imported_SODataV4__JsonDeltaStream_internal
@interface SODataV4_JsonDeltaStream (internal)
/// @internal
///
+ (nullable NSObject*) parseItem :(nonnull SODataV4_JsonObject*)item :(nonnull SODataV4_DataContext*)context;
+ (nullable NSObject*) parseItem :(nonnull SODataV4_JsonObject*)item :(nonnull SODataV4_DataContext*)context :(nullable SODataV4_EntityType*)defaultEntityType;
@end
#endif
#endif

#ifdef import_SODataV4__JsonElementStack_internal
#ifndef imported_SODataV4__JsonElementStack_internal
#define imported_SODataV4__JsonElementStack_public
/* internal */
/// @brief A list of item type `SODataV4_JsonElementFrame`.
///
///
@interface SODataV4_JsonElementStack : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_JsonElementStack`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_JsonElementStack*) new;
/// @brief Construct a new list with `SODataV4_JsonElementStack`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_JsonElementStack*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_JsonElementFrame*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_JsonElementStack*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_JsonElementStack*) addThis :(nonnull SODataV4_JsonElementFrame*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_JsonElementStack*) copy;
/// @brief An immutable empty `SODataV4_JsonElementStack`.
///
///
+ (nonnull SODataV4_JsonElementStack*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_JsonElementFrame*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonElementStack`.`length` - 1).
- (nonnull SODataV4_JsonElementFrame*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_JsonElementStack`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_JsonElementFrame`.
- (SODataV4_boolean) includes :(nonnull SODataV4_JsonElementFrame*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_JsonElementFrame*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_JsonElementStack`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_JsonElementFrame`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_JsonElementFrame*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonElementStack`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_JsonElementStack*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonElementStack`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_JsonElementFrame*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_JsonElementFrame*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_JsonElementFrame*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_JsonElementStack`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_JsonElementFrame`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_JsonElementFrame*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_JsonElementFrame*)item;
/// @brief Return a new `SODataV4_JsonElementStack` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_JsonElementFrame` will be removed.
///
/// @return A new list of item type `SODataV4_JsonElementFrame`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_JsonElementStack*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_JsonElementFrame*) single;
/// @internal
///
- (nonnull SODataV4_JsonElementStack*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_JsonElementStack*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_JsonElementStack`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonElementStack* empty;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonObject_EntryList_public
#define imported_SODataV4__JsonObject_EntryList_public
/// @brief A list of item type `SODataV4_JsonObject_Entry`.
///
///
@interface SODataV4_JsonObject_EntryList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_JsonObject_EntryList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_JsonObject_EntryList*) new;
/// @brief Construct a new list with `SODataV4_JsonObject_EntryList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_JsonObject_EntryList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_JsonObject_Entry*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_JsonObject_EntryList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_JsonObject_EntryList*) addThis :(nonnull SODataV4_JsonObject_Entry*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_JsonObject_EntryList*) copy;
/// @brief An immutable empty `SODataV4_JsonObject_EntryList`.
///
///
+ (nonnull SODataV4_JsonObject_EntryList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_JsonObject_Entry*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonObject_EntryList`.`length` - 1).
- (nonnull SODataV4_JsonObject_Entry*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_JsonObject_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_JsonObject_Entry`.
- (SODataV4_boolean) includes :(nonnull SODataV4_JsonObject_Entry*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_JsonObject_Entry*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_JsonObject_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_JsonObject_Entry`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_JsonObject_Entry*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonObject_EntryList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_JsonObject_EntryList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_JsonObject_EntryList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_JsonObject_Entry*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_JsonObject_Entry*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_JsonObject_Entry*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_JsonObject_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_JsonObject_Entry`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_JsonObject_Entry*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_JsonObject_Entry*)item;
/// @brief Return a new `SODataV4_JsonObject_EntryList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_JsonObject_Entry` will be removed.
///
/// @return A new list of item type `SODataV4_JsonObject_Entry`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_JsonObject_EntryList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_JsonObject_Entry*) single;
/// @internal
///
- (nonnull SODataV4_JsonObject_EntryList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_JsonObject_EntryList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_JsonObject_EntryList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_JsonObject_EntryList* empty;
@end
#endif

#ifdef import_SODataV4__JsonObject_FieldOrdering_ODataV3_internal
#ifndef imported_SODataV4__JsonObject_FieldOrdering_ODataV3_internal
#define imported_SODataV4__JsonObject_FieldOrdering_ODataV3_public
/* internal */
@interface SODataV4_JsonObject_FieldOrdering_ODataV3 : SODataV4_JsonObject_FieldOrdering
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonObject_FieldOrdering_ODataV3*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifdef import_SODataV4__JsonObject_FieldOrdering_ODataV3_private
#ifndef imported_SODataV4__JsonObject_FieldOrdering_ODataV3_private
#define imported_SODataV4__JsonObject_FieldOrdering_ODataV3_private
@interface SODataV4_JsonObject_FieldOrdering_ODataV3 (private)
- (SODataV4_int) order :(nonnull NSString*)field;
@end
#endif
#endif

#ifdef import_SODataV4__JsonObject_FieldOrdering_ODataV4_internal
#ifndef imported_SODataV4__JsonObject_FieldOrdering_ODataV4_internal
#define imported_SODataV4__JsonObject_FieldOrdering_ODataV4_public
/* internal */
@interface SODataV4_JsonObject_FieldOrdering_ODataV4 : SODataV4_JsonObject_FieldOrdering
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonObject_FieldOrdering_ODataV4*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifdef import_SODataV4__JsonObject_FieldOrdering_ODataV4_private
#ifndef imported_SODataV4__JsonObject_FieldOrdering_ODataV4_private
#define imported_SODataV4__JsonObject_FieldOrdering_ODataV4_private
@interface SODataV4_JsonObject_FieldOrdering_ODataV4 (private)
- (SODataV4_int) order :(nonnull NSString*)field;
@end
#endif
#endif

#ifdef import_SODataV4__JsonObject_FieldOrdering_ODataV4_01_internal
#ifndef imported_SODataV4__JsonObject_FieldOrdering_ODataV4_01_internal
#define imported_SODataV4__JsonObject_FieldOrdering_ODataV4_01_public
/* internal */
@interface SODataV4_JsonObject_FieldOrdering_ODataV4_01 : SODataV4_JsonObject_FieldOrdering
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonObject_FieldOrdering_ODataV4_01*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
@end
#endif
#endif

#ifdef import_SODataV4__JsonObject_FieldOrdering_ODataV4_01_private
#ifndef imported_SODataV4__JsonObject_FieldOrdering_ODataV4_01_private
#define imported_SODataV4__JsonObject_FieldOrdering_ODataV4_01_private
@interface SODataV4_JsonObject_FieldOrdering_ODataV4_01 (private)
- (SODataV4_int) order :(nonnull NSString*)field;
@end
#endif
#endif

#ifdef import_SODataV4__JsonTickString_internal
#ifndef imported_SODataV4__JsonTickString_internal
#define imported_SODataV4__JsonTickString_public
/* internal */
/// @brief For OData V3- compatibility with the ill-defined "tick" format.
///
///
@interface SODataV4_JsonTickString : SODataV4_JsonString
{
    @private NSString* _Nonnull tick;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
+ (nonnull SODataV4_JsonTickString*) ofTick :(nonnull NSString*)value;
/// @return The string `SODataV4_JsonTickString`.`value` in [JSON](http://json.org) format.
///
- (nonnull NSString*) toString;
/// @brief @override
///
///
- (nonnull NSString*) value;
/// @brief @override
///
///
@property (nonatomic, readonly, strong, nonnull) NSString* value;
@end
#endif
#endif

#ifdef import_SODataV4__JsonTickString_private
#ifndef imported_SODataV4__JsonTickString_private
#define imported_SODataV4__JsonTickString_private
@interface SODataV4_JsonTickString (private)
+ (nonnull SODataV4_JsonTickString*) new;
+ (nonnull SODataV4_JsonTickString*) _new1 :(nonnull NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__JsonTickString_internal
#ifndef imported_SODataV4__JsonTickString_internal
#define imported_SODataV4__JsonTickString_internal
@interface SODataV4_JsonTickString (internal)
- (SODataV4_boolean) isTick;
- (nonnull NSString*) unquoted;
@property (nonatomic, readonly) SODataV4_boolean isTick;
@end
#endif
#endif

#ifndef imported_SODataV4__JsonException_public
#define imported_SODataV4__JsonException_public
/// @internal
///
@interface SODataV4_JsonException : SODataV4_DataFormatException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_JsonException*) new;
/// @internal
///
- (void) _init;
/// @brief Thrown when a value cannot be parsed from JSON format.
///
///
/// @param value Text of value that could not be parsed.
/// @param type Name of expected data type.
+ (nonnull SODataV4_JsonException*) cannotParse :(nonnull NSString*)value :(nonnull NSString*)type;
/// @return A new exception with the specified root cause.
/// @param cause Root cause.
+ (nonnull SODataV4_JsonException*) withCause :(nonnull NSException*)cause;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_JsonException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__JsonException_private
#ifndef imported_SODataV4__JsonException_private
#define imported_SODataV4__JsonException_private
@interface SODataV4_JsonException (private)
+ (nonnull SODataV4_JsonException*) _new1 :(nullable NSException*)p1;
+ (nonnull SODataV4_JsonException*) _new2 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__Any_asNullable_json_JsonElement_in_json_internal
#ifndef imported_SODataV4__Any_asNullable_json_JsonElement_in_json_internal
#define imported_SODataV4__Any_asNullable_json_JsonElement_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to nullable target type.
///
///
@interface SODataV4_Any_asNullable_json_JsonElement_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to `SODataV4_JsonElement`?, or `nil` if `value` is `nil`.
/// @throw `SODataV4_CastException` if `value` is not of type `AsType`.
+ (nullable SODataV4_JsonElement*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_core_MapFromString_in_json_internal
#ifndef imported_SODataV4__Any_as_core_MapFromString_in_json_internal
#define imported_SODataV4__Any_as_core_MapFromString_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_core_MapFromString_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_MapFromString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexType_in_json_internal
#ifndef imported_SODataV4__Any_as_data_ComplexType_in_json_internal
#define imported_SODataV4__Any_as_data_ComplexType_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexType_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexValueList_in_json_internal
#ifndef imported_SODataV4__Any_as_data_ComplexValueList_in_json_internal
#define imported_SODataV4__Any_as_data_ComplexValueList_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexValueList_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexValueList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexValue_in_json_internal
#ifndef imported_SODataV4__Any_as_data_ComplexValue_in_json_internal
#define imported_SODataV4__Any_as_data_ComplexValue_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexValue_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DataValueList_in_json_internal
#ifndef imported_SODataV4__Any_as_data_DataValueList_in_json_internal
#define imported_SODataV4__Any_as_data_DataValueList_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DataValueList_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DataValueList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DoubleValue_in_json_internal
#ifndef imported_SODataV4__Any_as_data_DoubleValue_in_json_internal
#define imported_SODataV4__Any_as_data_DoubleValue_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DoubleValue_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DoubleValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityType_in_json_internal
#ifndef imported_SODataV4__Any_as_data_EntityType_in_json_internal
#define imported_SODataV4__Any_as_data_EntityType_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityType_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityValueList_in_json_internal
#ifndef imported_SODataV4__Any_as_data_EntityValueList_in_json_internal
#define imported_SODataV4__Any_as_data_EntityValueList_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityValueList_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityValueList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityValue_in_json_internal
#ifndef imported_SODataV4__Any_as_data_EntityValue_in_json_internal
#define imported_SODataV4__Any_as_data_EntityValue_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityValue_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EnumType_in_json_internal
#ifndef imported_SODataV4__Any_as_data_EnumType_in_json_internal
#define imported_SODataV4__Any_as_data_EnumType_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EnumType_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EnumType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_FloatValue_in_json_internal
#ifndef imported_SODataV4__Any_as_data_FloatValue_in_json_internal
#define imported_SODataV4__Any_as_data_FloatValue_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_FloatValue_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_FloatValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyCollection_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyCollection_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyCollection_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyCollection_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyCollection*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyLineString_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyLineString_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyLineString_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyLineString_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyMultiLineString_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyMultiLineString_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyMultiLineString_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyMultiLineString_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyMultiLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyMultiPoint_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyMultiPoint_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyMultiPoint_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyMultiPoint_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyMultiPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyMultiPolygon_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyMultiPolygon_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyMultiPolygon_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyMultiPolygon_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyMultiPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyPoint_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyPoint_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyPoint_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyPoint_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyPolygon_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyPolygon_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyPolygon_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyPolygon_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyValue_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeographyValue_in_json_internal
#define imported_SODataV4__Any_as_data_GeographyValue_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyValue_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryCollection_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryCollection_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryCollection_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryCollection_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryCollection*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryLineString_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryLineString_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryLineString_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryLineString_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryMultiLineString_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryMultiLineString_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryMultiLineString_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryMultiLineString_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryMultiLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryMultiPoint_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryMultiPoint_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryMultiPoint_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryMultiPoint_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryMultiPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryMultiPolygon_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryMultiPolygon_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryMultiPolygon_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryMultiPolygon_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryMultiPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryPoint_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryPoint_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryPoint_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryPoint_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryPolygon_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryPolygon_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryPolygon_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryPolygon_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryValue_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GeometryValue_in_json_internal
#define imported_SODataV4__Any_as_data_GeometryValue_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryValue_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GlobalDateTime_in_json_internal
#ifndef imported_SODataV4__Any_as_data_GlobalDateTime_in_json_internal
#define imported_SODataV4__Any_as_data_GlobalDateTime_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GlobalDateTime_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GlobalDateTime*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_LocalDateTime_in_json_internal
#ifndef imported_SODataV4__Any_as_data_LocalDateTime_in_json_internal
#define imported_SODataV4__Any_as_data_LocalDateTime_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_LocalDateTime_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_LocalDateTime*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_LocalTime_in_json_internal
#ifndef imported_SODataV4__Any_as_data_LocalTime_in_json_internal
#define imported_SODataV4__Any_as_data_LocalTime_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_LocalTime_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_LocalTime*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_StreamLink_in_json_internal
#ifndef imported_SODataV4__Any_as_data_StreamLink_in_json_internal
#define imported_SODataV4__Any_as_data_StreamLink_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_StreamLink_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_StreamLink*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonArray_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonArray_in_json_internal
#define imported_SODataV4__Any_as_json_JsonArray_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonArray_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonArray*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonBooleanToken_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonBooleanToken_in_json_internal
#define imported_SODataV4__Any_as_json_JsonBooleanToken_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonBooleanToken_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonBooleanToken*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonElementFrame_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonElementFrame_in_json_internal
#define imported_SODataV4__Any_as_json_JsonElementFrame_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonElementFrame_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonElementFrame*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonNumberToken_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonNumberToken_in_json_internal
#define imported_SODataV4__Any_as_json_JsonNumberToken_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonNumberToken_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonNumberToken*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonObject_Entry_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonObject_Entry_in_json_internal
#define imported_SODataV4__Any_as_json_JsonObject_Entry_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonObject_Entry_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonObject_Entry*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonObject_FieldOrdering_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonObject_FieldOrdering_in_json_internal
#define imported_SODataV4__Any_as_json_JsonObject_FieldOrdering_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonObject_FieldOrdering_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonObject_FieldOrdering*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonObject_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonObject_in_json_internal
#define imported_SODataV4__Any_as_json_JsonObject_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonObject_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonObject*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonStringToken_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonStringToken_in_json_internal
#define imported_SODataV4__Any_as_json_JsonStringToken_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonStringToken_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonStringToken*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_json_JsonString_in_json_internal
#ifndef imported_SODataV4__Any_as_json_JsonString_in_json_internal
#define imported_SODataV4__Any_as_json_JsonString_in_json_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_json_JsonString_in_json : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_JsonString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Default_undefined_EntitySet_in_json_internal
#ifndef imported_SODataV4__Default_undefined_EntitySet_in_json_internal
#define imported_SODataV4__Default_undefined_EntitySet_in_json_public
/* internal */
/// @brief Static function to apply default undefined values of type `SODataV4_EntitySet`.
///
///
@interface SODataV4_Default_undefined_EntitySet_in_json : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return a new `SODataV4_EntitySet`.
/// @param value Nullable value.
+ (nonnull SODataV4_EntitySet*) ifNull :(nullable SODataV4_EntitySet*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Map_sortedEntries_JsonObject_in_json_internal
#ifndef imported_SODataV4__Map_sortedEntries_JsonObject_in_json_internal
#define imported_SODataV4__Map_sortedEntries_JsonObject_in_json_public
/* internal */
@interface SODataV4_Map_sortedEntries_JsonObject_in_json : SODataV4_ObjectBase
{
}
/// @return Sorted entries from `value` (in sorted order of `value.keys()`).
/// @param value Map for which sorted entries should be returned.
+ (nonnull SODataV4_JsonObject_EntryList*) call :(nonnull SODataV4_JsonObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Map_sortedEntries_JsonObject_in_json_private
#ifndef imported_SODataV4__Map_sortedEntries_JsonObject_in_json_private
#define imported_SODataV4__Map_sortedEntries_JsonObject_in_json_private
@interface SODataV4_Map_sortedEntries_JsonObject_in_json (private)
+ (nonnull SODataV4_Map_sortedEntries_JsonObject_in_json_KeyComparer*) _new1 :(nonnull SODataV4_Comparer*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__Map_sortedKeys_JsonObject_in_json_internal
#ifndef imported_SODataV4__Map_sortedKeys_JsonObject_in_json_internal
#define imported_SODataV4__Map_sortedKeys_JsonObject_in_json_public
/* internal */
@interface SODataV4_Map_sortedKeys_JsonObject_in_json : SODataV4_ObjectBase
{
}
/// @return Sorted keys from `value`.
/// @param value Map for which sorted keys should be returned.
+ (nonnull SODataV4_StringList*) call :(nonnull SODataV4_JsonObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Map_sortedValues_JsonObject_in_json_internal
#ifndef imported_SODataV4__Map_sortedValues_JsonObject_in_json_internal
#define imported_SODataV4__Map_sortedValues_JsonObject_in_json_public
/* internal */
@interface SODataV4_Map_sortedValues_JsonObject_in_json : SODataV4_ObjectBase
{
}
/// @return Sorted values from `value`.
/// @param value Map for which sorted values should be returned.
+ (nonnull SODataV4_JsonArray*) call :(nonnull SODataV4_JsonObject*)value;
@end
#endif
#endif

#endif
