//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_XML_H
#define SODATAV4_XML_H


@class SODataV4_XmlAttribute;
@class SODataV4_XmlDocument;
@class SODataV4_XmlDuration;
@class SODataV4_XmlElementMap_Entry;
@class SODataV4_XmlName;
@class SODataV4_XmlNode;
@class SODataV4_XmlParser;
@class SODataV4_XmlPretty;
@class SODataV4_XmlComment;
@class SODataV4_XmlElement;
@class SODataV4_XmlElementMap;
@class SODataV4_XmlText;
@class SODataV4_XmlAttributeList;
@class SODataV4_XmlCommentList;
@class SODataV4_XmlElementList;
@class SODataV4_XmlElementMap_EntryList;
@class SODataV4_XmlNodeList;
@class SODataV4_XmlException;
@class SODataV4_Any_as_core_MapFromString_in_xml; /* internal */
@class SODataV4_Any_as_xml_XmlAttribute_in_xml; /* internal */
@class SODataV4_Any_as_xml_XmlComment_in_xml; /* internal */
@class SODataV4_Any_as_xml_XmlElementMap_Entry_in_xml; /* internal */
@class SODataV4_Any_as_xml_XmlElement_in_xml; /* internal */
@class SODataV4_Any_as_xml_XmlNode_in_xml; /* internal */
@class SODataV4_Any_as_xml_XmlText_in_xml; /* internal */

#ifndef imported_SODataV4__XmlAttribute_public
#define imported_SODataV4__XmlAttribute_public
/// @internal
///
@interface SODataV4_XmlAttribute : SODataV4_ObjectBase
{
    @private NSString* _Nonnull name_;
    @private NSString* _Nullable prefix_;
    @private NSString* _Nonnull localName_;
    @private NSString* _Nullable namespaceURI_;
    @private NSString* _Nonnull value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlAttribute*) new;
/// @internal
///
- (void) _init;
/// @brief Convenience function for modifying the value of an attribute.
///
///
/// @return This attribute.
/// @param value Attribute value.
/// ### Example
/// ```` xs
/// let a = XmlAttribute.withName("a").andValue("v");
/// ````
- (nonnull SODataV4_XmlAttribute*) andValue :(nonnull NSString*)value;
/// @brief Is `SODataV4_XmlAttribute`.`prefix` non-null?
///
///
- (SODataV4_boolean) hasPrefix;
/// @brief Local element name, without namespace prefix, e.g. "MyAttribute".
///
///
- (nonnull NSString*) localName;
/// @brief Attribute name, possibly qualified by namespace prefix, e.g. "MyAttribute" or "myns:MyAttribute".
///
///
- (nonnull NSString*) name;
/// @brief Namespace URI, if known. Will not be valid unless `SODataV4_XmlElement`.`resolveNamespaces` has been called for the element hierarchy containing this attribute.
///
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
- (nullable NSString*) namespaceURI;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
- (nullable NSString*) prefix;
/// @brief Local element name, without namespace prefix, e.g. "MyAttribute".
///
///
- (void) setLocalName :(nonnull NSString*)value;
/// @brief Attribute name, possibly qualified by namespace prefix, e.g. "MyAttribute" or "myns:MyAttribute".
///
///
- (void) setName :(nonnull NSString*)value;
/// @brief Namespace URI, if known. Will not be valid unless `SODataV4_XmlElement`.`resolveNamespaces` has been called for the element hierarchy containing this attribute.
///
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
- (void) setNamespaceURI :(nullable NSString*)value;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
- (void) setPrefix :(nullable NSString*)value;
/// @brief Attribute value.
///
///
- (void) setValue :(nonnull NSString*)value;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Attribute value.
///
///
- (nonnull NSString*) value;
/// @brief Convenience function for constructing an attribute with a specified name.
///
///
/// @return A new XML attribute node.
/// @param name Attribute name.
/// ### Example
/// ```` xs
/// let a = XmlAttribute.withName("a");
/// ````
+ (nonnull SODataV4_XmlAttribute*) withName :(nonnull NSString*)name;
/// @brief Convenience function for constructing an attribute node with specified name.
///
///
/// @return A new XML element node.
/// @param name The attribute name.
/// @see `SODataV4_XmlAttribute`.`withName`.
+ (nonnull SODataV4_XmlAttribute*) withQName :(nonnull SODataV4_XmlName*)name;
/// @brief Is `SODataV4_XmlAttribute`.`prefix` non-null?
///
///
@property (nonatomic, readonly) SODataV4_boolean hasPrefix;
/// @brief Local element name, without namespace prefix, e.g. "MyAttribute".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* localName;
/// @brief Attribute name, possibly qualified by namespace prefix, e.g. "MyAttribute" or "myns:MyAttribute".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* name;
/// @brief Namespace URI, if known. Will not be valid unless `SODataV4_XmlElement`.`resolveNamespaces` has been called for the element hierarchy containing this attribute.
///
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
@property (nonatomic, readwrite, strong, nullable) NSString* namespaceURI;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* prefix;
/// @brief Attribute value.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* value;
@end
#endif

#ifdef import_SODataV4__XmlAttribute_private
#ifndef imported_SODataV4__XmlAttribute_private
#define imported_SODataV4__XmlAttribute_private
@interface SODataV4_XmlAttribute (private)
+ (nonnull SODataV4_XmlAttribute*) _new1 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlDocument_public
#define imported_SODataV4__XmlDocument_public
/// @internal
///
@interface SODataV4_XmlDocument : SODataV4_ObjectBase
{
    @private NSString* _Nullable declaration_;
    @private SODataV4_XmlElement* _Nonnull rootElement_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlDocument*) new;
/// @internal
///
- (void) _init;
/// @internal
///
- (void) appendTo :(nonnull SODataV4_CharBuffer*)buffer;
/// @brief Append the textual representation of this document to a buffer.
///
///
/// @param buffer Buffer to receive textual representation.
/// @param indent (optional) Indent level for indented pretty-printing. Use -1 to disable pretty-printing.
/// @see `SODataV4_XmlPretty`.
- (void) appendTo :(nonnull SODataV4_CharBuffer*)buffer :(SODataV4_int)indent;
/// @brief The XML declaration, or `nil`.
///
///
- (nullable NSString*) declaration;
/// @brief Parse a string to a document. Equivalent to `parseMixed(xml, false)`.
///
///
/// @return Parsed document.
/// @param xml Text to be parsed.
/// @see `SODataV4_XmlDocument`.`parseMixed`.
+ (nonnull SODataV4_XmlDocument*) parse :(nonnull NSString*)xml;
/// @brief Parse a string to a document.
///
///
/// @return Parsed document.
/// @param xml Text to be parsed.
/// @param mixed `true` if mixed content is permitted, `false` otherwise. Parsing may be faster with `mixed` = `false`, since text nodes can be omitted from elements which have non-text content.
+ (nonnull SODataV4_XmlDocument*) parseMixed :(nonnull NSString*)xml :(SODataV4_boolean)mixed;
/// @brief Traverse the element hierachy starting at the `SODataV4_XmlDocument`.`rootElement`, ensuring that
///
/// every node has the `SODataV4_XmlElement`.`namespaceURI` set according to the "xmlns"
/// attributes and namespace prefixes encountered in the nodes.
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
- (void) resolveNamespaces;
/// @brief The document root element.
///
///
- (nonnull SODataV4_XmlElement*) rootElement;
/// @brief The XML declaration, or `nil`.
///
///
- (void) setDeclaration :(nullable NSString*)value;
/// @brief The document root element.
///
///
- (void) setRootElement :(nonnull SODataV4_XmlElement*)value;
/// @return The element, with an XML declaration.
/// @see `SODataV4_XmlElement`.`toString`.
- (nonnull NSString*) toString;
/// @brief The XML declaration, or `nil`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* declaration;
/// @brief The document root element.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlElement* rootElement;
@end
#endif

#ifndef imported_SODataV4__XmlDuration_public
#define imported_SODataV4__XmlDuration_public
/// @internal
///
@interface SODataV4_XmlDuration : SODataV4_ObjectBase
{
    @private SODataV4_byte _sign;
    @private SODataV4_YearMonthDuration* _Nonnull _yearMonth_;
    @private SODataV4_DayTimeDuration* _Nonnull _dayTime_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlDuration*) new;
/// @internal
///
- (void) _init;
/// @brief Day and time fields.
///
///
- (nonnull SODataV4_DayTimeDuration*) dayTime;
/// @brief Days field of duration (non-negative).
///
///
- (SODataV4_int) days;
/// @brief Compare two duration values.
///
///
/// @return `true` if `left` is equal to `right`, otherwise `false`.
/// @param left The first duration for comparison.
/// @param right The second duration for comparison.
+ (SODataV4_boolean) equal :(nullable SODataV4_XmlDuration*)left :(nullable SODataV4_XmlDuration*)right;
/// @brief Hours field of duration (non-negative).
///
///
- (SODataV4_int) hours;
/// @brief Minutes field of duration (non-negative).
///
///
- (SODataV4_int) minutes;
/// @brief Months field of duration (non-negative).
///
///
- (SODataV4_int) months;
/// @brief Nanoseconds field of duration (non-negative).
///
///
- (SODataV4_int) nanos;
/// @brief Compare two duration values.
///
///
/// @return `true` if `left` is not equal to `right`, otherwise `false`.
/// @param left The first duration for comparison.
/// @param right The second duration for comparison.
+ (SODataV4_boolean) notEqual :(nullable SODataV4_XmlDuration*)left :(nullable SODataV4_XmlDuration*)right;
/// @return A new XML duration.
/// @param sign The sign field (+1, 0 or -1).
/// @param years The years field (non-negative).
/// @param months The months field (non-negative).
/// @param days The days field (non-negative).
/// @param hours The hours field (non-negative).
/// @param minutes The minutes field (non-negative).
/// @param seconds The seconds field (non-negative).
/// @param nanos The nanos field (non-negative, `<= 999999999`).
+ (nonnull SODataV4_XmlDuration*) of :(SODataV4_int)sign :(SODataV4_int)years :(SODataV4_int)months :(SODataV4_int)days :(SODataV4_int)hours :(SODataV4_int)minutes :(SODataV4_int)seconds :(SODataV4_int)nanos;
/// @return Value parsed from [XML Schema format](http://www.w3.org/TR/xmlschema11-2/#duration), or `nil` if `text` has invalid duration format.
/// @param text Value in XML Schema format.
+ (nullable SODataV4_XmlDuration*) parse :(nonnull NSString*)text;
/// @brief Seconds field of duration (non-negative).
///
///
- (SODataV4_int) seconds;
/// @brief Sign of the duration (+1, 0 or -1).
///
///
- (SODataV4_int) sign;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @return This duration expressed as a local time (e.g. 00:00:00 to 23:59:59.999*; 24:00:00 for PT24H), or `nil` if this duration is not expressible as a local time.
///
- (nullable SODataV4_LocalTime*) toTime;
/// @brief Year and month fields.
///
///
- (nonnull SODataV4_YearMonthDuration*) yearMonth;
/// @brief Years field of duration (non-negative).
///
///
- (SODataV4_int) years;
/// @brief Day and time fields.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_DayTimeDuration* dayTime;
/// @brief Days field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int days;
/// @brief Hours field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int hours;
/// @brief Minutes field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int minutes;
/// @brief Months field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int months;
/// @brief Nanoseconds field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int nanos;
/// @brief Seconds field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int seconds;
/// @brief Sign of the duration (+1, 0 or -1).
///
///
@property (nonatomic, readonly) SODataV4_int sign;
/// @brief Year and month fields.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_YearMonthDuration* yearMonth;
/// @brief Years field of duration (non-negative).
///
///
@property (nonatomic, readonly) SODataV4_int years;
@end
#endif

#ifdef import_SODataV4__XmlDuration_private
#ifndef imported_SODataV4__XmlDuration_private
#define imported_SODataV4__XmlDuration_private
@interface SODataV4_XmlDuration (private)
- (nonnull SODataV4_DayTimeDuration*) _dayTime;
- (nonnull SODataV4_YearMonthDuration*) _yearMonth;
+ (nonnull SODataV4_DayTimeDuration*) dayTimeZero;
- (void) set_dayTime :(nonnull SODataV4_DayTimeDuration*)value;
- (void) set_yearMonth :(nonnull SODataV4_YearMonthDuration*)value;
+ (nonnull SODataV4_YearMonthDuration*) yearMonthZero;
+ (nonnull SODataV4_XmlDuration*) _new1 :(nonnull SODataV4_YearMonthDuration*)p1 :(SODataV4_byte)p2 :(nonnull SODataV4_DayTimeDuration*)p3;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DayTimeDuration* _dayTime;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_YearMonthDuration* _yearMonth;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_DayTimeDuration* dayTimeZero;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_YearMonthDuration* yearMonthZero;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlElementMap_Entry_public
#define imported_SODataV4__XmlElementMap_Entry_public
/// @brief A key/value pair for map entries.
///
///
@interface SODataV4_XmlElementMap_Entry : SODataV4_ObjectBase
{
    @private NSString* _Nonnull key_;
    @private SODataV4_XmlElement* _Nonnull value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlElementMap_Entry*) new;
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
- (void) setValue :(nonnull SODataV4_XmlElement*)value;
/// @brief Map entry value.
///
///
- (nonnull SODataV4_XmlElement*) value;
/// @brief Map entry key.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* key;
/// @brief Map entry value.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlElement* value;
@end
#endif

#ifndef imported_SODataV4__XmlName_public
#define imported_SODataV4__XmlName_public
/// @internal
///
@interface SODataV4_XmlName : SODataV4_ObjectBase
{
    @private NSString* _Nullable prefix_;
    @private NSString* _Nonnull localName_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlName*) new;
/// @internal
///
- (void) _init;
/// @brief Full name. Equal to `SODataV4_XmlName`.`localName` if `SODataV4_XmlName`.`prefix` is `nil`. Otherwise "prefix:localName".
///
///
- (nonnull NSString*) fullName;
/// @brief Name suffix, e.g. "MyElement".
///
///
- (nonnull NSString*) localName;
/// @brief Parse an XML name string with optional namespace prefix.
///
///
/// @return XML name.
/// @param name Name string with optional namespace prefix, e.g. "myns:MyAttribute".
+ (nonnull SODataV4_XmlName*) parse :(nonnull NSString*)name;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
- (nullable NSString*) prefix;
/// @brief Full name. Equal to `SODataV4_XmlName`.`localName` if `SODataV4_XmlName`.`prefix` is `nil`. Otherwise "prefix:localName".
///
///
- (void) setFullName :(nonnull NSString*)value;
/// @brief Name suffix, e.g. "MyElement".
///
///
- (void) setLocalName :(nonnull NSString*)value;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
- (void) setPrefix :(nullable NSString*)value;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief Full name. Equal to `SODataV4_XmlName`.`localName` if `SODataV4_XmlName`.`prefix` is `nil`. Otherwise "prefix:localName".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* fullName;
/// @brief Name suffix, e.g. "MyElement".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* localName;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* prefix;
@end
#endif

#ifdef import_SODataV4__XmlName_private
#ifndef imported_SODataV4__XmlName_private
#define imported_SODataV4__XmlName_private
@interface SODataV4_XmlName (private)
- (nonnull NSString*) createFullName;
+ (nonnull SODataV4_XmlName*) _new1 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlNode_public
#define imported_SODataV4__XmlNode_public
/// @internal
///
@interface SODataV4_XmlNode : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlNode*) new;
/// @internal
///
- (void) _init;
/// @brief A numeric code to represent this node type.
///
///
/// @see [constants](#constants).
- (SODataV4_int) type;
#define SODataV4_XmlNode_TYPE_COMMENT 1
#define SODataV4_XmlNode_TYPE_ELEMENT 2
#define SODataV4_XmlNode_TYPE_TEXT 3
/// @brief A numeric code to represent this node type.
///
///
/// @see [constants](#constants).
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifndef imported_SODataV4__XmlParser_public
#define imported_SODataV4__XmlParser_public
/// @internal
///
@interface SODataV4_XmlParser : SODataV4_ObjectBase
{
    @private SODataV4_CharStream* _Nonnull stream;
    @private SODataV4_CharBuffer* _Nonnull buffer;
    @private SODataV4_boolean mixed;
    @private SODataV4_boolean elementOnly;
    @private SODataV4_int line;
    @private SODataV4_boolean hasRoot;
    @private NSString* _Nullable declaration_;
    @private SODataV4_XmlElement* _Nonnull rootElement_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief The parsed XML declaration.
///
///
- (nullable NSString*) declaration;
/// @return The next child node of `element`, or `nil` if `element` has ended.
/// @param element Parent element, which must have already been started.
/// @param parseNested `true` if child elements should be `SODataV4_XmlParser`.`parseElement`, `false` if they should be `SODataV4_XmlParser`.`startElement`.
- (nullable SODataV4_XmlNode*) nextChild :(nonnull SODataV4_XmlElement*)element :(SODataV4_boolean)parseNested;
/// @return The next child element of `element`, or `nil` if `element` has ended.
/// Any non-element child nodes (e.g. comment nodes, text nodes) will be ignored.
/// @param element Parent element, which must have already been started.
/// @param parseNested `true` if child elements should be `SODataV4_XmlParser`.`parseElement`, `false` if they should be `SODataV4_XmlParser`.`startElement`.
- (nullable SODataV4_XmlElement*) nextChildElement :(nonnull SODataV4_XmlElement*)element :(SODataV4_boolean)parseNested;
/// @brief Assuming an element appears next in the stream, parse its start tag.
///
///
/// @return Element with only the start tag parsed.
/// @see `SODataV4_XmlParser`.`startDocument`, `SODataV4_XmlParser`.`startElement`.
- (nonnull SODataV4_XmlElement*) nextElement;
/// @internal
///
+ (nonnull SODataV4_XmlDocument*) parseDocument :(nonnull SODataV4_CharStream*)stream;
/// @brief Parse a stream to a document.
///
///
/// @return Parsed document.
/// @param stream Stream to be parsed.
/// @param mixed (optional) `true` if mixed content is permitted, otherwise `false`. Parsing may be faster with `mixed` = `false`, since text nodes can be omitted from elements which have non-text content.
+ (nonnull SODataV4_XmlDocument*) parseDocument :(nonnull SODataV4_CharStream*)stream :(SODataV4_boolean)mixed;
/// @internal
///
+ (nonnull SODataV4_XmlElement*) parseElement :(nonnull SODataV4_CharStream*)stream;
/// @brief Parse a stream to an element.
///
///
/// @return Parsed element.
/// @param stream Stream to be parsed.
/// @param mixed (optional) `true` if mixed content is permitted, otherwise `false`. Parsing may be faster with `mixed` = `false`, since text nodes can be omitted from elements which have non-text content.
+ (nonnull SODataV4_XmlElement*) parseElement :(nonnull SODataV4_CharStream*)stream :(SODataV4_boolean)mixed;
/// @return The next element in the stream.
/// @see `SODataV4_XmlParser`.`startDocument`, `SODataV4_XmlParser`.`startElement`.
- (nonnull SODataV4_XmlElement*) parseElement;
/// @brief Read all of the children of a started element, and read the element's end tag.
///
///
/// @param element Parent element, which must have already been started.
/// @see `SODataV4_XmlParser`.`startDocument`, `SODataV4_XmlParser`.`startElement`.
- (void) readChildren :(nonnull SODataV4_XmlElement*)element;
/// @brief The parsed root element.
///
///
- (nonnull SODataV4_XmlElement*) rootElement;
/// @brief The parsed XML declaration.
///
///
- (void) setDeclaration :(nullable NSString*)value;
/// @brief The parsed root element.
///
///
- (void) setRootElement :(nonnull SODataV4_XmlElement*)value;
/// @internal
///
+ (nonnull SODataV4_XmlParser*) startDocument :(nonnull SODataV4_CharStream*)stream;
/// @brief Start parsing a stream to a document.
///
///
/// @return Document with only the start tag parsed.
/// @param stream Stream to be parsed.
/// @param mixed (optional) `true` if mixed content is permitted, otherwise `false`. Parsing may be faster with `mixed` = `false`, since text nodes can be omitted from elements which have non-text content.
+ (nonnull SODataV4_XmlParser*) startDocument :(nonnull SODataV4_CharStream*)stream :(SODataV4_boolean)mixed;
/// @internal
///
+ (nonnull SODataV4_XmlParser*) startElement :(nonnull SODataV4_CharStream*)stream;
/// @brief Start parsing a stream to an element.
///
///
/// @return Element with only the start tag parsed.
/// @param stream Stream to be parsed.
/// @param mixed (optional) `true` if mixed content is permitted, otherwise `false`. Parsing may be faster with `mixed` = `false`, since text nodes can be omitted from elements which have non-text content.
+ (nonnull SODataV4_XmlParser*) startElement :(nonnull SODataV4_CharStream*)stream :(SODataV4_boolean)mixed;
/// @brief The parsed XML declaration.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* declaration;
/// @brief The parsed root element.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlElement* rootElement;
@end
#endif

#ifdef import_SODataV4__XmlParser_private
#ifndef imported_SODataV4__XmlParser_private
#define imported_SODataV4__XmlParser_private
@interface SODataV4_XmlParser (private)
+ (nonnull SODataV4_XmlParser*) new;
- (void) expectNext :(SODataV4_char)match :(SODataV4_boolean)space;
- (nonnull SODataV4_XmlException*) getException :(nonnull NSString*)message;
- (SODataV4_char) read;
- (void) readCData;
- (nonnull NSString*) readComment;
- (SODataV4_boolean) readMatch :(SODataV4_char)match :(SODataV4_boolean)space;
- (nullable SODataV4_XmlName*) readQName :(nonnull NSString*)kind :(SODataV4_boolean)required :(SODataV4_boolean)space;
- (nonnull NSString*) readValue;
- (SODataV4_char) readXChar;
- (SODataV4_char) readXHash;
- (nonnull NSString*) readXmlPI;
- (void) unread :(SODataV4_char)c;
+ (nonnull SODataV4_XmlParser*) _new1 :(nonnull SODataV4_CharStream*)p1 :(SODataV4_boolean)p2;
+ (nonnull SODataV4_XmlDocument*) _new2 :(nonnull SODataV4_XmlElement*)p1 :(nullable NSString*)p2;
+ (nonnull SODataV4_XmlParser*) _new3 :(SODataV4_boolean)p1 :(nonnull SODataV4_CharStream*)p2 :(SODataV4_boolean)p3;
+ (nonnull SODataV4_XmlName*) _new4 :(nonnull NSString*)p1;
+ (nonnull SODataV4_XmlName*) _new5 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3;
#define SODataV4_XmlParser_EXPECTED_ROOT @"Expected root element."
@end
#endif
#endif

#ifndef imported_SODataV4__XmlPretty_public
#define imported_SODataV4__XmlPretty_public
/// @internal
///
@interface SODataV4_XmlPretty : SODataV4_ObjectBase
{
}
/// @internal
///
+ (nonnull NSString*) printDocument :(nonnull SODataV4_XmlDocument*)document;
/// @return XML element converted to a pretty printed string.
/// @param document XML document.
/// @param indent Optional starting indentation level. Defaults to zero; nested items are indented by 4.
+ (nonnull NSString*) printDocument :(nonnull SODataV4_XmlDocument*)document :(SODataV4_int)indent;
/// @internal
///
+ (nonnull NSString*) printElement :(nonnull SODataV4_XmlElement*)element;
/// @return XML element converted to a pretty printed string.
/// @param element XML element.
/// @param indent Optional starting indentation level. Defaults to zero; nested items are indented by 4.
+ (nonnull NSString*) printElement :(nonnull SODataV4_XmlElement*)element :(SODataV4_int)indent;
@end
#endif

#ifndef imported_SODataV4__XmlComment_public
#define imported_SODataV4__XmlComment_public
/// @internal
///
@interface SODataV4_XmlComment : SODataV4_XmlNode
{
    @private NSString* _Nonnull text_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlComment*) new;
/// @internal
///
- (void) _init;
/// @brief Comment text.
///
///
- (void) setText :(nonnull NSString*)value;
/// @brief Comment text.
///
///
- (nonnull NSString*) text;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief XmlNode.TYPE_COMMENT.
///
///
- (SODataV4_int) type;
/// @brief Convenience function for constructing a comment node with specified text.
///
///
/// @return A new XML comment node.
/// @param text The comment text.
+ (nonnull SODataV4_XmlComment*) withText :(nonnull NSString*)text;
/// @brief Comment text.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* text;
/// @brief XmlNode.TYPE_COMMENT.
///
///
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifdef import_SODataV4__XmlComment_private
#ifndef imported_SODataV4__XmlComment_private
#define imported_SODataV4__XmlComment_private
@interface SODataV4_XmlComment (private)
+ (nonnull SODataV4_XmlComment*) _new1 :(nonnull NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlElement_public
#define imported_SODataV4__XmlElement_public
/// @internal
///
@interface SODataV4_XmlElement : SODataV4_XmlNode
{
    @private SODataV4_boolean isEmpty_;
    @private SODataV4_boolean hasElements_;
    @private SODataV4_XmlAttributeList* _Nullable _attributes;
    @private SODataV4_XmlNodeList* _Nullable _childNodes;
    @private NSString* _Nonnull name_;
    @private NSString* _Nullable prefix_;
    @private NSString* _Nonnull localName_;
    @private NSString* _Nullable namespaceURI_;
    @private SODataV4_int lineNumber_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlElement*) new;
/// @internal
///
- (void) _init;
/// @brief Add an attribute to this element.
///
///
/// @return This element.
/// @param name Attribute name.
/// @param value Attribute value.
/// @see `SODataV4_XmlElement`.`attributes`.
- (nonnull SODataV4_XmlElement*) addAttribute :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief Add an attribute to this element.
///
///
/// @return This element.
/// @param name Attribute name.
/// @param value Attribute value.
/// @see `SODataV4_XmlElement`.`attributes`.
- (nonnull SODataV4_XmlElement*) addAttributeWithQName :(nonnull SODataV4_XmlName*)name :(nonnull NSString*)value;
/// @brief Add a child node to this element.
///
///
/// @return This element.
/// @param child Child node.
/// @see `SODataV4_XmlElement`.`childNodes`.
- (nonnull SODataV4_XmlElement*) addChild :(nonnull SODataV4_XmlNode*)child;
/// @brief Add a comment node to this element.
///
///
/// @return This element.
/// @param text Comment text.
/// @see `SODataV4_XmlElement`.`childNodes`.
- (nonnull SODataV4_XmlElement*) addComment :(nonnull NSString*)text;
/// @brief Add an element node to this element.
///
///
/// @return This element.
/// @param child Child element.
/// @see `SODataV4_XmlElement`.`childNodes`.
- (nonnull SODataV4_XmlElement*) addElement :(nonnull SODataV4_XmlElement*)child;
/// @brief Add a list of elements to this element.
///
///
/// @return This element.
/// @param elements Child elements.
/// @see `SODataV4_XmlElement`.`childNodes`.
- (nonnull SODataV4_XmlElement*) addElements :(nonnull SODataV4_XmlElementList*)elements;
/// @brief Add a text node to this element.
///
///
/// @return This element.
/// @param text Text value.
/// @see `SODataV4_XmlElement`.`childNodes`.
- (nonnull SODataV4_XmlElement*) addText :(nonnull NSString*)text;
/// @internal
///
- (void) appendTo :(nonnull SODataV4_CharBuffer*)buffer;
/// @brief Append the textual representation of this element to a buffer.
///
///
/// @param buffer Buffer to receive textual representation.
/// @param indent (optional) Indent level for indented pretty-printing. Pass -1 to disable pretty-printing.
/// @see `SODataV4_XmlPretty`.
- (void) appendTo :(nonnull SODataV4_CharBuffer*)buffer :(SODataV4_int)indent;
/// @brief List of attributes for this element.
///
///
- (nonnull SODataV4_XmlAttributeList*) attributes;
/// @brief List of child nodes for this element.
///
///
- (nonnull SODataV4_XmlNodeList*) childNodes;
/// @brief A list of the comment nodes in this element.
///
/// Note: the list is recalculated every time this property is accessed. For best performance, callers are advised to save the resulting value if it will be used multiple times.
- (nonnull SODataV4_XmlCommentList*) comments;
/// @brief A list of the element nodes in this element.
///
/// Note: the list is recalculated every time this property is accessed. For best performance, callers are advised to save the resulting value if it will be used multiple times.
- (nonnull SODataV4_XmlElementList*) elements;
/// @brief Lookup all child elements with a specified name.
///
///
/// @return The matching element nodes. An empty list is returned if no matches are found.
/// @param name Element name, to be compared with `SODataV4_XmlElement`.`name` and `SODataV4_XmlElement`.`localName` of child elements when matching.
/// @see `SODataV4_XmlElement`.`childNodes`, `SODataV4_XmlElement`.`elements`.
- (nonnull SODataV4_XmlElementList*) elementsNamed :(nonnull NSString*)name;
/// @brief Lookup the value for the attribute with a specified name.
///
///
/// @return The matching attribute value, or `nil` if no match is found.
/// @param name Attribute name, to be compared with `SODataV4_XmlElement`.`name` and `SODataV4_XmlElement`.`localName` of attributes when matching.
/// @see `SODataV4_XmlElement`.`attributes`.
- (nullable NSString*) getAttribute :(nonnull NSString*)name;
/// @brief Lookup first child element with a specified name.
///
///
/// @return The matching child element. A `nil` element is returned if no match is found.
/// @param name Element name, to be compared with `SODataV4_XmlElement`.`name` and `SODataV4_XmlElement`.`localName` of child elements when matching.
/// @see `SODataV4_XmlElement`.`childNodes`, `SODataV4_XmlElement`.`elements`.
- (nullable SODataV4_XmlElement*) getElement :(nonnull NSString*)name;
/// @brief Lookup the value for the attribute with a specified name.
///
///
/// @return The matching attribute value.
/// @throw `SODataV4_XmlException` if no match is found.
/// @param name Attribute name, to be compared with `SODataV4_XmlElement`.`name` and `SODataV4_XmlElement`.`localName` of attributes when matching.
/// @see `SODataV4_XmlElement`.`attributes`.
- (nonnull NSString*) getRequiredAttribute :(nonnull NSString*)name;
/// @brief Lookup first child element with a specified name.
///
///
/// @return The matching child element.
/// @throw `SODataV4_XmlException` if no match is found.
/// @param name Element name, to be compared with `SODataV4_XmlElement`.`name` and `SODataV4_XmlElement`.`localName` of child elements when matching.
/// @see `SODataV4_XmlElement`.`childNodes`, `SODataV4_XmlElement`.`elements`.
- (nonnull SODataV4_XmlElement*) getRequiredElement :(nonnull NSString*)name;
/// @brief Is `SODataV4_XmlElement`.`prefix` non-null?
///
///
- (SODataV4_boolean) hasPrefix;
/// @brief Line number (starting at 1) if this element was parsed from a file. Otherwise zero.
///
///
- (SODataV4_int) lineNumber;
/// @brief Local element name, without namespace prefix, e.g. "MyElement".
///
///
- (nonnull NSString*) localName;
/// @brief Element name, possibly qualified by namespace prefix, e.g. "MyElement" or "myns:MyElement".
///
///
- (nonnull NSString*) name;
/// @brief Namespace URI, if known. Will not be valid unless `SODataV4_XmlElement`.`resolveNamespaces` has been called for the element hierarchy containing this element.
///
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
- (nullable NSString*) namespaceURI;
/// @brief Parse a string to an element. Equivalent to `parseMixed(xml, false)`
///
///
/// @return Parsed element.
/// @param xml Text to be parsed.
/// @see `SODataV4_XmlElement`.`parseMixed`.
+ (nonnull SODataV4_XmlElement*) parse :(nonnull NSString*)xml;
/// @internal
///
+ (nonnull SODataV4_XmlElement*) parseMixed :(nonnull NSString*)xml;
/// @brief Parse a string to an element.
///
///
/// @return Parsed element.
/// @param xml Text to be parsed.
/// @param mixed (optional) `true` if mixed content is permitted, `false` otherwise. Parsing may be faster with `mixed` = `false`, since text nodes can be omitted from elements which have non-text content.
+ (nonnull SODataV4_XmlElement*) parseMixed :(nonnull NSString*)xml :(SODataV4_boolean)mixed;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
- (nullable NSString*) prefix;
/// @brief Remove the value for the attribute with a specified name.
///
///
/// @param name Attribute name, to be compared with `SODataV4_XmlElement`.`name` and `SODataV4_XmlElement`.`localName` of attributes when matching.
/// @see `SODataV4_XmlElement`.`attributes`.
- (void) removeAttribute :(nonnull NSString*)name;
/// @brief Traverse the element hierachy starting at this element, ensuring that
///
/// every node has the `SODataV4_XmlElement`.`namespaceURI` set according to the "xmlns"
/// attributes and namespace prefixes encountered in the nodes.
- (void) resolveNamespaces;
/// @brief Set an attribute of this element (replace attribute value if the attribute is already defined, otherwise add the attribute).
///
///
/// @return This element.
/// @param name Attribute name.
/// @param value Attribute value.
/// @see `SODataV4_XmlElement`.`attributes`.
- (nonnull SODataV4_XmlElement*) setAttribute :(nonnull NSString*)name :(nonnull NSString*)value;
/// @brief Set an attribute of this element (replace attribute value if the attribute is already defined, otherwise add the attribute).
///
///
/// @return This element.
/// @param name Attribute name.
/// @param value Attribute value.
/// @see `SODataV4_XmlElement`.`attributes`.
- (nonnull SODataV4_XmlElement*) setAttributeWithQName :(nonnull SODataV4_XmlName*)name :(nonnull NSString*)value;
/// @brief List of attributes for this element.
///
///
- (void) setAttributes :(nonnull SODataV4_XmlAttributeList*)value;
/// @brief List of child nodes for this element.
///
///
- (void) setChildNodes :(nonnull SODataV4_XmlNodeList*)value;
/// @brief Line number (starting at 1) if this element was parsed from a file. Otherwise zero.
///
///
- (void) setLineNumber :(SODataV4_int)value;
/// @brief Local element name, without namespace prefix, e.g. "MyElement".
///
///
- (void) setLocalName :(nonnull NSString*)value;
/// @brief Element name, possibly qualified by namespace prefix, e.g. "MyElement" or "myns:MyElement".
///
///
- (void) setName :(nonnull NSString*)value;
/// @brief Namespace URI, if known. Will not be valid unless `SODataV4_XmlElement`.`resolveNamespaces` has been called for the element hierarchy containing this element.
///
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
- (void) setNamespaceURI :(nullable NSString*)value;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
- (void) setPrefix :(nullable NSString*)value;
/// @brief A combination of all the text nodes in this element.
///
/// Note: the text is recalculated every time this property is accessed. For best performance, callers are advised to save the resulting value if it will be used multiple times.
- (nonnull NSString*) text;
/// @return The element, without an XML declaration.
/// @see `SODataV4_XmlDocument`.`toString`.
- (nonnull NSString*) toString;
/// @brief XmlNode.TYPE_ELEMENT.
///
///
- (SODataV4_int) type;
/// @brief Convenience function for constructing an element node with specified name.
///
///
/// @return A new XML element node.
/// @param name The element name.
/// ### Example
/// ```` xs
/// let e = XmlAttribute.withName("e")
///     .addAttribute(XmlAttribute.withName("a").andValue("v"))
///     .addComment("c")
///     .addElement(XmlElement.withName("x"))
///     .addText("t");
/// ````
+ (nonnull SODataV4_XmlElement*) withName :(nonnull NSString*)name;
/// @brief Convenience function for constructing an element node with specified name.
///
///
/// @return A new XML element node.
/// @param name The element name.
/// @see `SODataV4_XmlElement`.`withName`.
+ (nonnull SODataV4_XmlElement*) withQName :(nonnull SODataV4_XmlName*)name;
/// @brief List of attributes for this element.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlAttributeList* attributes;
/// @brief List of child nodes for this element.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlNodeList* childNodes;
/// @brief A list of the comment nodes in this element.
///
/// Note: the list is recalculated every time this property is accessed. For best performance, callers are advised to save the resulting value if it will be used multiple times.
@property (nonatomic, readonly, strong, nonnull) SODataV4_XmlCommentList* comments;
/// @brief A list of the element nodes in this element.
///
/// Note: the list is recalculated every time this property is accessed. For best performance, callers are advised to save the resulting value if it will be used multiple times.
@property (nonatomic, readonly, strong, nonnull) SODataV4_XmlElementList* elements;
/// @brief Is `SODataV4_XmlElement`.`prefix` non-null?
///
///
@property (nonatomic, readonly) SODataV4_boolean hasPrefix;
/// @brief Line number (starting at 1) if this element was parsed from a file. Otherwise zero.
///
///
@property (nonatomic, readwrite) SODataV4_int lineNumber;
/// @brief Local element name, without namespace prefix, e.g. "MyElement".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* localName;
/// @brief Element name, possibly qualified by namespace prefix, e.g. "MyElement" or "myns:MyElement".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* name;
/// @brief Namespace URI, if known. Will not be valid unless `SODataV4_XmlElement`.`resolveNamespaces` has been called for the element hierarchy containing this element.
///
///
/// @see `SODataV4_XmlElement`.`resolveNamespaces`.
@property (nonatomic, readwrite, strong, nullable) NSString* namespaceURI;
/// @brief Optional namespace prefix, e.g. "myns" or `nil`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* prefix;
/// @brief A combination of all the text nodes in this element.
///
/// Note: the text is recalculated every time this property is accessed. For best performance, callers are advised to save the resulting value if it will be used multiple times.
@property (nonatomic, readonly, strong, nonnull) NSString* text;
/// @brief XmlNode.TYPE_ELEMENT.
///
///
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifdef import_SODataV4__XmlElement_private
#ifndef imported_SODataV4__XmlElement_private
#define imported_SODataV4__XmlElement_private
@interface SODataV4_XmlElement (private)
- (void) resolve :(nonnull SODataV4_StringMap*)map :(nullable NSString*)xmlns;
- (void) writeText :(nonnull SODataV4_CharBuffer*)buffer :(nonnull NSString*)chars;
+ (nonnull SODataV4_XmlElement*) _new1 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3;
@end
#endif
#endif

#ifdef import_SODataV4__XmlElement_internal
#ifndef imported_SODataV4__XmlElement_internal
#define imported_SODataV4__XmlElement_internal
@interface SODataV4_XmlElement (internal)
+ (void) addIndent :(nonnull SODataV4_CharBuffer*)buffer :(SODataV4_int)indent;
- (SODataV4_boolean) hasElements;
- (SODataV4_boolean) isEmpty;
- (void) setHasElements :(SODataV4_boolean)value;
- (void) setIsEmpty :(SODataV4_boolean)value;
@property (nonatomic, readwrite) SODataV4_boolean hasElements;
@property (nonatomic, readwrite) SODataV4_boolean isEmpty;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlElementMap_public
#define imported_SODataV4__XmlElementMap_public
/// @internal
///
@interface SODataV4_XmlElementMap : SODataV4_MapBase
{
    @private SODataV4_MapFromString* _Nonnull _untyped_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_XmlElementMap`.`size` of zero and optional initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
+ (nonnull SODataV4_XmlElementMap*) new;
/// @brief Construct a new map with `SODataV4_XmlElementMap`.`size` of zero and optional initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_XmlElementMap*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Delete the entry with the specified `key` (if found).
///
///
/// @return `true` if an entry with the specified `key` was found (and deleted).
/// @param key Entry key.
- (SODataV4_boolean) delete_ :(nonnull NSString*)key;
/// @brief An immutable empty `SODataV4_XmlElementMap`.
///
///
+ (nonnull SODataV4_XmlElementMap*) empty;
/// @return A list of the entries (key/value pairs) in this map.
///
- (nonnull SODataV4_XmlElementMap_EntryList*) entries;
/// @return The value from the entry with the specified `key` (if found), otherwise `nil`.
/// @param key Entry key.
- (nullable SODataV4_XmlElement*) get :(nonnull NSString*)key;
/// @return The value from the entry with the specified `key` (if found).
/// @throw `SODataV4_MissingEntryException` if no entry is found for the specified key.
/// @param key Entry key.
- (nonnull SODataV4_XmlElement*) getRequired :(nonnull NSString*)key;
/// @return `true` if this map has an entry with the specified `key`, otherwise `false`.
/// @param key Entry key.
- (SODataV4_boolean) has :(nonnull NSString*)key;
/// @return A list of the entry keys in this map.
///
- (nonnull SODataV4_StringList*) keys;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @param value Entry value.
/// @param key Entry key.
- (void) set :(nonnull NSString*)key :(nonnull SODataV4_XmlElement*)value;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @return This map.
/// @param key Entry key.
/// @param value Entry value.
- (nonnull SODataV4_XmlElementMap*) setThis :(nonnull NSString*)key :(nonnull SODataV4_XmlElement*)value;
/// @brief The underlying untyped map of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
- (nonnull SODataV4_UntypedMap*) untypedMap;
/// @return A list of the entry values in this map.
///
- (nonnull SODataV4_XmlElementList*) values;
/// @brief An immutable empty `SODataV4_XmlElementMap`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_XmlElementMap* empty;
/// @brief The underlying untyped map of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_UntypedMap* untypedMap;
@end
#endif

#ifdef import_SODataV4__XmlElementMap_private
#ifndef imported_SODataV4__XmlElementMap_private
#define imported_SODataV4__XmlElementMap_private
@interface SODataV4_XmlElementMap (private)
- (nonnull SODataV4_MapFromString*) _untyped;
- (void) set_untyped :(nonnull SODataV4_MapFromString*)value;
+ (nonnull SODataV4_XmlElementMap_Entry*) _new1 :(nonnull SODataV4_XmlElement*)p1 :(nonnull NSString*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_MapFromString* _untyped;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlText_public
#define imported_SODataV4__XmlText_public
/// @internal
///
@interface SODataV4_XmlText : SODataV4_XmlNode
{
    @private NSString* _Nonnull text_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlText*) new;
/// @internal
///
- (void) _init;
/// @brief The text value.
///
///
- (void) setText :(nonnull NSString*)value;
/// @brief The text value.
///
///
- (nonnull NSString*) text;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
/// @brief XmlNode.TYPE_TEXT.
///
///
- (SODataV4_int) type;
/// @brief Convenience function for constructing a text node with specified text.
///
///
/// @return A new XML text node.
/// @param text The text value.
+ (nonnull SODataV4_XmlText*) withText :(nonnull NSString*)text;
/// @brief The text value.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* text;
/// @brief XmlNode.TYPE_TEXT.
///
///
@property (nonatomic, readonly) SODataV4_int type;
@end
#endif

#ifdef import_SODataV4__XmlText_private
#ifndef imported_SODataV4__XmlText_private
#define imported_SODataV4__XmlText_private
@interface SODataV4_XmlText (private)
+ (nonnull SODataV4_XmlText*) _new1 :(nonnull NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__XmlAttributeList_public
#define imported_SODataV4__XmlAttributeList_public
/// @internal
///
@interface SODataV4_XmlAttributeList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_XmlAttributeList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_XmlAttributeList*) new;
/// @brief Construct a new list with `SODataV4_XmlAttributeList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_XmlAttributeList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_XmlAttribute*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_XmlAttributeList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_XmlAttributeList*) addThis :(nonnull SODataV4_XmlAttribute*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_XmlAttributeList*) copy;
/// @brief An immutable empty `SODataV4_XmlAttributeList`.
///
///
+ (nonnull SODataV4_XmlAttributeList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlAttribute*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlAttributeList`.`length` - 1).
- (nonnull SODataV4_XmlAttribute*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlAttributeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlAttribute`.
- (SODataV4_boolean) includes :(nonnull SODataV4_XmlAttribute*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlAttribute*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlAttributeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlAttribute`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlAttribute*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlAttributeList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_XmlAttributeList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlAttributeList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_XmlAttribute*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlAttribute*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlAttribute*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlAttributeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlAttribute`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlAttribute*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_XmlAttribute*)item;
/// @brief Return a new `SODataV4_XmlAttributeList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_XmlAttribute` will be removed.
///
/// @return A new list of item type `SODataV4_XmlAttribute`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_XmlAttributeList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_XmlAttribute*) single;
/// @internal
///
- (nonnull SODataV4_XmlAttributeList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_XmlAttributeList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_XmlAttributeList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_XmlAttributeList* empty;
@end
#endif

#ifndef imported_SODataV4__XmlCommentList_public
#define imported_SODataV4__XmlCommentList_public
/// @internal
///
@interface SODataV4_XmlCommentList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_XmlCommentList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_XmlCommentList*) new;
/// @brief Construct a new list with `SODataV4_XmlCommentList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_XmlCommentList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_XmlComment*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_XmlCommentList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_XmlCommentList*) addThis :(nonnull SODataV4_XmlComment*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_XmlCommentList*) copy;
/// @brief An immutable empty `SODataV4_XmlCommentList`.
///
///
+ (nonnull SODataV4_XmlCommentList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlComment*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlCommentList`.`length` - 1).
- (nonnull SODataV4_XmlComment*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlCommentList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlComment`.
- (SODataV4_boolean) includes :(nonnull SODataV4_XmlComment*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlComment*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlCommentList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlComment`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlComment*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlCommentList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_XmlCommentList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlCommentList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_XmlComment*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlComment*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlComment*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlCommentList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlComment`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlComment*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_XmlComment*)item;
/// @brief Return a new `SODataV4_XmlCommentList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_XmlComment` will be removed.
///
/// @return A new list of item type `SODataV4_XmlComment`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_XmlCommentList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_XmlComment*) single;
/// @internal
///
- (nonnull SODataV4_XmlCommentList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_XmlCommentList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_XmlCommentList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_XmlCommentList* empty;
@end
#endif

#ifndef imported_SODataV4__XmlElementList_public
#define imported_SODataV4__XmlElementList_public
/// @internal
///
@interface SODataV4_XmlElementList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_XmlElementList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_XmlElementList*) new;
/// @brief Construct a new list with `SODataV4_XmlElementList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_XmlElementList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_XmlElement*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_XmlElementList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_XmlElementList*) addThis :(nonnull SODataV4_XmlElement*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_XmlElementList*) copy;
/// @brief An immutable empty `SODataV4_XmlElementList`.
///
///
+ (nonnull SODataV4_XmlElementList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlElement*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlElementList`.`length` - 1).
- (nonnull SODataV4_XmlElement*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlElementList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlElement`.
- (SODataV4_boolean) includes :(nonnull SODataV4_XmlElement*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlElement*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlElementList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlElement`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlElement*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlElementList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_XmlElementList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlElementList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_XmlElement*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlElement*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlElement*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlElementList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlElement`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlElement*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_XmlElement*)item;
/// @brief Return a new `SODataV4_XmlElementList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_XmlElement` will be removed.
///
/// @return A new list of item type `SODataV4_XmlElement`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_XmlElementList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_XmlElement*) single;
/// @internal
///
- (nonnull SODataV4_XmlElementList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_XmlElementList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_XmlElementList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_XmlElementList* empty;
@end
#endif

#ifndef imported_SODataV4__XmlElementMap_EntryList_public
#define imported_SODataV4__XmlElementMap_EntryList_public
/// @brief A list of item type `SODataV4_XmlElementMap_Entry`.
///
///
@interface SODataV4_XmlElementMap_EntryList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_XmlElementMap_EntryList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_XmlElementMap_EntryList*) new;
/// @brief Construct a new list with `SODataV4_XmlElementMap_EntryList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_XmlElementMap_EntryList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_XmlElementMap_EntryList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_XmlElementMap_EntryList*) addThis :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_XmlElementMap_EntryList*) copy;
/// @brief An immutable empty `SODataV4_XmlElementMap_EntryList`.
///
///
+ (nonnull SODataV4_XmlElementMap_EntryList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlElementMap_Entry*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlElementMap_EntryList`.`length` - 1).
- (nonnull SODataV4_XmlElementMap_Entry*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlElementMap_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlElementMap_Entry`.
- (SODataV4_boolean) includes :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlElementMap_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlElementMap_Entry`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlElementMap_Entry*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlElementMap_EntryList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_XmlElementMap_EntryList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlElementMap_EntryList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlElementMap_Entry*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlElementMap_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlElementMap_Entry`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlElementMap_Entry*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_XmlElementMap_Entry*)item;
/// @brief Return a new `SODataV4_XmlElementMap_EntryList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_XmlElementMap_Entry` will be removed.
///
/// @return A new list of item type `SODataV4_XmlElementMap_Entry`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_XmlElementMap_EntryList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_XmlElementMap_Entry*) single;
/// @internal
///
- (nonnull SODataV4_XmlElementMap_EntryList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_XmlElementMap_EntryList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_XmlElementMap_EntryList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_XmlElementMap_EntryList* empty;
@end
#endif

#ifndef imported_SODataV4__XmlNodeList_public
#define imported_SODataV4__XmlNodeList_public
/// @internal
///
@interface SODataV4_XmlNodeList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_XmlNodeList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_XmlNodeList*) new;
/// @brief Construct a new list with `SODataV4_XmlNodeList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_XmlNodeList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_XmlNode*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_XmlNodeList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_XmlNodeList*) addThis :(nonnull SODataV4_XmlNode*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_XmlNodeList*) copy;
/// @brief An immutable empty `SODataV4_XmlNodeList`.
///
///
+ (nonnull SODataV4_XmlNodeList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlNode*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlNodeList`.`length` - 1).
- (nonnull SODataV4_XmlNode*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlNodeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlNode`.
- (SODataV4_boolean) includes :(nonnull SODataV4_XmlNode*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlNode*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlNodeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlNode`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_XmlNode*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlNodeList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_XmlNodeList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_XmlNodeList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_XmlNode*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_XmlNode*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlNode*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_XmlNodeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_XmlNode`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_XmlNode*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_XmlNode*)item;
/// @brief Return a new `SODataV4_XmlNodeList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_XmlNode` will be removed.
///
/// @return A new list of item type `SODataV4_XmlNode`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_XmlNodeList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_XmlNode*) single;
/// @internal
///
- (nonnull SODataV4_XmlNodeList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_XmlNodeList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_XmlNodeList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_XmlNodeList* empty;
@end
#endif

#ifndef imported_SODataV4__XmlException_public
#define imported_SODataV4__XmlException_public
/// @internal
///
@interface SODataV4_XmlException : SODataV4_DataFormatException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_XmlException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_XmlException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__XmlException_private
#ifndef imported_SODataV4__XmlException_private
#define imported_SODataV4__XmlException_private
@interface SODataV4_XmlException (private)
+ (nonnull SODataV4_XmlException*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_core_MapFromString_in_xml_internal
#ifndef imported_SODataV4__Any_as_core_MapFromString_in_xml_internal
#define imported_SODataV4__Any_as_core_MapFromString_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_core_MapFromString_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_MapFromString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlAttribute_in_xml_internal
#ifndef imported_SODataV4__Any_as_xml_XmlAttribute_in_xml_internal
#define imported_SODataV4__Any_as_xml_XmlAttribute_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlAttribute_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlAttribute*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlComment_in_xml_internal
#ifndef imported_SODataV4__Any_as_xml_XmlComment_in_xml_internal
#define imported_SODataV4__Any_as_xml_XmlComment_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlComment_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlComment*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlElementMap_Entry_in_xml_internal
#ifndef imported_SODataV4__Any_as_xml_XmlElementMap_Entry_in_xml_internal
#define imported_SODataV4__Any_as_xml_XmlElementMap_Entry_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlElementMap_Entry_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlElementMap_Entry*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlElement_in_xml_internal
#ifndef imported_SODataV4__Any_as_xml_XmlElement_in_xml_internal
#define imported_SODataV4__Any_as_xml_XmlElement_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlElement_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlElement*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlNode_in_xml_internal
#ifndef imported_SODataV4__Any_as_xml_XmlNode_in_xml_internal
#define imported_SODataV4__Any_as_xml_XmlNode_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlNode_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlNode*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlText_in_xml_internal
#ifndef imported_SODataV4__Any_as_xml_XmlText_in_xml_internal
#define imported_SODataV4__Any_as_xml_XmlText_in_xml_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlText_in_xml : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlText*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#endif
