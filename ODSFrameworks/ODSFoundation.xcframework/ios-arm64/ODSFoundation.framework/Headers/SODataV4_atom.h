//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_ATOM_H
#define SODATAV4_ATOM_H


@class SODataV4_AtomLink; /* internal */
@class SODataV4_AtomValue;
@class SODataV4_GeoAtom;
@class SODataV4_AtomDeltaStream;
@class SODataV4_AtomException;
@class SODataV4_Any_as_data_ComplexType_in_atom; /* internal */
@class SODataV4_Any_as_data_ComplexValueList_in_atom; /* internal */
@class SODataV4_Any_as_data_ComplexValue_in_atom; /* internal */
@class SODataV4_Any_as_data_DataValueList_in_atom; /* internal */
@class SODataV4_Any_as_data_DoubleValue_in_atom; /* internal */
@class SODataV4_Any_as_data_EntityType_in_atom; /* internal */
@class SODataV4_Any_as_data_EntityValueList_in_atom; /* internal */
@class SODataV4_Any_as_data_EntityValue_in_atom; /* internal */
@class SODataV4_Any_as_data_EnumType_in_atom; /* internal */
@class SODataV4_Any_as_data_FloatValue_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyCollection_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyLineString_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyMultiLineString_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyMultiPoint_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyMultiPolygon_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyPoint_in_atom; /* internal */
@class SODataV4_Any_as_data_GeographyPolygon_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryCollection_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryLineString_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryMultiLineString_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryMultiPoint_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryMultiPolygon_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryPoint_in_atom; /* internal */
@class SODataV4_Any_as_data_GeometryPolygon_in_atom; /* internal */
@class SODataV4_Any_as_data_LocalTime_in_atom; /* internal */
@class SODataV4_Any_as_xml_XmlElement_in_atom; /* internal */
@class SODataV4_Default_undefined_EntitySet_in_atom; /* internal */

#ifdef import_SODataV4__AtomLink_internal
#ifndef imported_SODataV4__AtomLink_internal
#define imported_SODataV4__AtomLink_public
/* internal */
@interface SODataV4_AtomLink : SODataV4_ObjectBase
{
    @private SODataV4_int type_;
    @private NSString* _Nonnull url_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AtomLink*) new;
/// @internal
///
- (void) _init;
- (void) setType :(SODataV4_int)value;
- (void) setUrl :(nonnull NSString*)value;
- (SODataV4_int) type;
- (nonnull NSString*) url;
#define SODataV4_AtomLink_DELTA_LINK 1
#define SODataV4_AtomLink_NEXT_LINK 2
#define SODataV4_AtomLink_READ_LINK 3
@property (nonatomic, readwrite) SODataV4_int type;
@property (nonatomic, readwrite, strong, nonnull) NSString* url;
@end
#endif
#endif

#ifndef imported_SODataV4__AtomValue_public
#define imported_SODataV4__AtomValue_public
/// @internal
///
@interface SODataV4_AtomValue : SODataV4_ObjectBase
{
}
/// @return An entity value converted into an ATOM entry, wrapped as an XML document.
/// @param entity Entity value to be converted into ATOM format.
/// @param context Data context.
+ (nonnull SODataV4_XmlDocument*) entryDocument :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return A parsed error response.
/// @param element Error response in ATOM representation.
/// @param context Data context.
+ (nonnull SODataV4_ErrorResponse*) errorResponse :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_DataContext*)context;
/// @return An entity list converted into an ATOM feed, wrapped as an XML document.
/// @param list Entity list to be converted into ATOM format.
/// @param context Data context.
+ (nonnull SODataV4_XmlDocument*) feedDocument :(nonnull SODataV4_EntityValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @return An action invocation request body in XML format.
/// @param call Action invocation.
/// @param context Data context.
+ (nonnull SODataV4_XmlDocument*) formatCall :(nonnull SODataV4_DataMethodCall*)call :(nonnull SODataV4_DataContext*)context;
/// @return A data value formatted in OData ATOM representation.
/// @param value Data value.
/// @param context Data context.
+ (nonnull SODataV4_XmlDocument*) formatDocument :(nonnull SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
/// @return An entity reference formatted in OData ATOM representation.
/// @param entity Entity value.
/// @param context Data context.
+ (nonnull SODataV4_XmlDocument*) formatLink :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @brief Convert a basic list to ATOM format.
///
///
/// @param element XML element to receive the ATOM format.
/// @param list Value to be converted into ATOM format.
/// @param context Data context.
+ (void) fromBasicList :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_DataValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @brief Convert a complex list to ATOM format.
///
///
/// @param element XML element to receive the ATOM format.
/// @param list Value to be converted into ATOM format.
/// @param context Data context.
+ (void) fromComplexList :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_ComplexValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @brief Convert a complex value to ATOM format.
///
///
/// @param element XML element to receive the ATOM format.
/// @param complex Value to be converted into ATOM format.
/// @param context Data context.
+ (void) fromComplexValue :(nonnull SODataV4_XmlElement*)element :(nullable SODataV4_ComplexValue*)complex :(nonnull SODataV4_DataContext*)context;
/// @brief Convert a data value to ATOM format.
///
///
/// @param element XML element to receive the ATOM format.
/// @param value Value to be converted into ATOM format.
/// @param context Data context.
+ (void) fromDataValue :(nonnull SODataV4_XmlElement*)element :(nullable SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
/// @brief Convert an entity list to ATOM format.
///
///
/// @param feed XML element to receive the ATOM format.
/// @param list Value to be converted into ATOM format.
/// @param context Data context.
+ (void) fromEntityList :(nonnull SODataV4_XmlElement*)feed :(nonnull SODataV4_EntityValueList*)list :(nonnull SODataV4_DataContext*)context;
/// @brief Convert an entity value to ATOM format.
///
///
/// @param entry XML element to receive the ATOM format.
/// @param entity Value to be converted into ATOM format.
/// @param context Data context.
+ (void) fromEntityValue :(nonnull SODataV4_XmlElement*)entry :(nullable SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return A data value (basic, basic list, complex list, entity, entity list) parsed from OData ATOM representation.
/// @param element Value in ATOM representation.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_DataValue*) parseDocument :(nullable SODataV4_XmlElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return An entity reference parsed from OData ATOM representation.
/// The reference will have `SODataV4_EntityValue`.`isReference` == `true` and `SODataV4_EntityValue`.`readLink` != `nil`.
/// @param element Value in ATOM representation.
/// @param type Entity type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_EntityValue*) parseLink :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_EntityType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A list of entity references parsed from OData ATOM representation.
/// Each reference will have `SODataV4_EntityValue`.`isReference` == `true` and `SODataV4_EntityValue`.`readLink` != `nil`.
/// @param element Value in ATOM representation.
/// @param type Entity type for the expected parsed result.
/// @param context Data context.
/// @see `SODataV4_AtomValue`.`parseLink`.
+ (nonnull SODataV4_EntityValueList*) parseLinks :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_EntityType*)type :(nonnull SODataV4_DataContext*)context;
/// @internal
///
+ (nonnull SODataV4_EntityValue*) parseReference :(nonnull NSString*)uri :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_EntitySet*)entitySet :(nonnull SODataV4_DataContext*)context;
/// @return An entity reference parsed from OData ATOM reference representation.
/// The reference will have `SODataV4_EntityValue`.`isReference` == `true`, `SODataV4_EntityValue`.`readLink` != `nil`,
/// and `SODataV4_EntityValue`.`hasKey` will be true if the URI was in canonical URL format.
/// @param uri Entity reference URI.
/// @param entityType Entity type for the expected parsed result.
/// @param entitySet Entity set for the expected parsed result.
/// @param context Data context.
/// @param binding (optional) Is the reference for a "bind operation"?
+ (nonnull SODataV4_EntityValue*) parseReference :(nonnull NSString*)uri :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_EntitySet*)entitySet :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)binding;
/// @return A basic list parsed from ATOM format.
/// @param element Value in ATOM format.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_DataValueList*) toBasicList :(nullable SODataV4_XmlElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A complex list parsed from ATOM format.
/// @param element Value in ATOM format.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_ComplexValueList*) toComplexList :(nullable SODataV4_XmlElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A complex value parsed from ATOM format.
/// @param element Value in ATOM format.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_ComplexValue*) toComplexValue :(nullable SODataV4_XmlElement*)element :(nonnull SODataV4_ComplexType*)type :(nonnull SODataV4_DataContext*)context;
/// @return A data value parsed from ATOM format.
/// @param element Value in ATOM format.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_DataValue*) toDataValue :(nullable SODataV4_XmlElement*)element :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return An entity list parsed from ATOM format.
/// @param feed Value in ATOM format.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nonnull SODataV4_EntityValueList*) toEntityList :(nullable SODataV4_XmlElement*)feed :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
/// @return An entity value parsed from ATOM format.
/// @param entry Value in ATOM format.
/// @param type Data type for the expected parsed result.
/// @param context Data context.
+ (nullable SODataV4_EntityValue*) toEntityValue :(nullable SODataV4_XmlElement*)entry :(nonnull SODataV4_EntityType*)type :(nonnull SODataV4_DataContext*)context;
@end
#endif

#ifdef import_SODataV4__AtomValue_private
#ifndef imported_SODataV4__AtomValue_private
#define imported_SODataV4__AtomValue_private
@interface SODataV4_AtomValue (private)
+ (nonnull SODataV4_ComplexType*) actualComplexType :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_ComplexType*)formalType :(nonnull SODataV4_DataContext*)context;
+ (nonnull SODataV4_EntityType*) actualEntityType :(nonnull SODataV4_XmlElement*)category :(nonnull SODataV4_EntityType*)formalType :(nonnull SODataV4_DataContext*)context;
+ (nullable NSString*) actualTypeName :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)attName;
+ (void) addCountAndLinks :(nonnull SODataV4_XmlElement*)element :(SODataV4_nullable_long)totalCount :(nullable NSString*)readLink :(nullable NSString*)nextLink;
+ (nullable NSString*) checkEntityTag :(nullable NSString*)tag;
+ (void) deepInsert :(nonnull SODataV4_XmlElement*)entry :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(nonnull SODataV4_EntityValue*)parent;
+ (void) deepUpdate :(nonnull SODataV4_XmlElement*)entry :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(nonnull SODataV4_EntityValue*)parent;
/// @brief Get EnumValue from member name/number.
///
///
+ (nonnull SODataV4_EnumValue*) enumValue :(nonnull SODataV4_EnumType*)type :(nonnull NSString*)name;
/// @internal
///
+ (void) expandChildren :(nonnull SODataV4_XmlElement*)entry :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(nonnull SODataV4_EntityValue*)parent;
/// @internal
///
+ (void) expandChildren :(nonnull SODataV4_XmlElement*)entry :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(nonnull SODataV4_EntityValue*)parent :(SODataV4_boolean)deepInsert;
+ (void) expandChildren :(nonnull SODataV4_XmlElement*)entry :(nonnull SODataV4_Property*)property :(nullable SODataV4_DataValue*)dv :(nonnull SODataV4_DataContext*)context :(nonnull SODataV4_EntityValue*)parent :(SODataV4_boolean)deepInsert :(SODataV4_boolean)deepUpdate;
+ (SODataV4_boolean) isNull :(nullable SODataV4_XmlElement*)element;
/// @brief Map type code to OData type name.
///
///
+ (nonnull NSString*) odataName :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
+ (nullable SODataV4_LocalDateTime*) parseLocalDT :(nonnull NSString*)text;
+ (nullable SODataV4_LocalTime*) parseTimeV3 :(nonnull NSString*)text;
+ (nonnull SODataV4_DataType*) resolveOpenType :(nullable NSString*)type :(nonnull SODataV4_DataContext*)context;
/// @internal
///
+ (nonnull SODataV4_XmlElement*) rootElement :(nonnull NSString*)name :(nonnull SODataV4_DataContext*)context;
+ (nonnull SODataV4_XmlElement*) rootElement :(nonnull NSString*)name :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)atomNS;
+ (void) setNull :(nonnull SODataV4_XmlElement*)element;
+ (nonnull SODataV4_XmlDocument*) _new1 :(nonnull SODataV4_XmlElement*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__AtomValue_internal
#ifndef imported_SODataV4__AtomValue_internal
#define imported_SODataV4__AtomValue_internal
@interface SODataV4_AtomValue (internal)
/// @brief Adds the dynamic properties of the old structure to the dynamic properties of the structure.
///
/// After that the dynamic properties of the structure will be added to the XML element.
///
/// @param element XML element to add the dynamic properties to.
/// @param old The structure whose dynamic properties will be added to the structure parameter.
/// @param structure The structure whose dynamic properties will be added to the element parameter.
/// @param isPatch True if the request type is patch.
/// @param context The `SODataV4_DataContext` describing the patch options.
+ (void) addDynamicProperties :(nonnull SODataV4_XmlElement*)element :(nullable SODataV4_StructureBase*)old :(nonnull SODataV4_StructureBase*)structure :(SODataV4_boolean)isPatch :(nonnull SODataV4_DataContext*)context;
/// @return Tries to get the attribute name of a given XmlElement. Returns the attribute
/// name if it exists, otherwise return null.
/// @param element The XmlElement to be examined.
/// @param name The attribute name.
+ (nullable NSString*) getOptionalAttribute :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
+ (nonnull NSString*) getRequiredAttribute :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
#define SODataV4_AtomValue_ATOM_ENTRY @"application/atom+xml;type=entry"
#define SODataV4_AtomValue_ATOM_FEED @"application/atom+xml;type=feed"
#define SODataV4_AtomValue_AUTHOR @"author"
#define SODataV4_AtomValue_CONTENT @"content"
#define SODataV4_AtomValue_CONTEXT @"context"
#define SODataV4_AtomValue_COUNT @"count"
#define SODataV4_AtomValue_EDIT @"edit"
#define SODataV4_AtomValue_EDIT_MEDIA @"edit-media"
#define SODataV4_AtomValue_ENTRY @"entry"
#define SODataV4_AtomValue_DELETED_ENTRY @"deleted-entry"
#define SODataV4_AtomValue_DELETED_LINK @"deleted-link"
#define SODataV4_AtomValue_DELTA @"delta"
#define SODataV4_AtomValue_D_URI @"d:uri"
#define SODataV4_AtomValue_ETAG @"etag"
#define SODataV4_AtomValue_FEED @"feed"
#define SODataV4_AtomValue_HREF @"href"
#define SODataV4_AtomValue_ID @"id"
#define SODataV4_AtomValue_INLINE @"inline"
#define SODataV4_AtomValue_M_CONTEXT @"m:context"
#define SODataV4_AtomValue_M_COUNT @"m:count"
#define SODataV4_AtomValue_M_DELETED_LINK @"m:deleted-link"
#define SODataV4_AtomValue_M_ELEMENT @"m:element"
#define SODataV4_AtomValue_M_ETAG @"m:etag"
#define SODataV4_AtomValue_M_INLINE @"m:inline"
#define SODataV4_AtomValue_M_LINK @"m:link"
#define SODataV4_AtomValue_M_NULL @"m:null"
#define SODataV4_AtomValue_M_REF @"m:ref"
#define SODataV4_AtomValue_M_TYPE @"m:type"
#define SODataV4_AtomValue_NS_DELTA @"http://docs.oasis-open.org/odata/ns/delta"
#define SODataV4_AtomValue_NO_KEY_HREF @"https://tools.ietf.org/html/rfc4287#section-4.2.7.1"
#define SODataV4_AtomValue_LINK @"link"
#define SODataV4_AtomValue_NAME @"name"
#define SODataV4_AtomValue_NEXT @"next"
#define SODataV4_AtomValue_REASON @"reason"
#define SODataV4_AtomValue_PROPERTIES @"properties"
#define SODataV4_AtomValue_REF @"ref"
#define SODataV4_AtomValue_REL @"rel"
#define SODataV4_AtomValue_RELATIONSHIP @"relationship"
#define SODataV4_AtomValue_SCHEME @"scheme"
#define SODataV4_AtomValue_SOURCE @"source"
#define SODataV4_AtomValue_SELF @"self"
#define SODataV4_AtomValue_SRC @"src"
#define SODataV4_AtomValue_SUMMARY @"summary"
#define SODataV4_AtomValue_T_DELETED_ENTRY @"t:deleted-entry"
#define SODataV4_AtomValue_TARGET @"target"
#define SODataV4_AtomValue_TERM @"term"
#define SODataV4_AtomValue_TITLE @"title"
#define SODataV4_AtomValue_TYPE @"type"
#define SODataV4_AtomValue_UPDATED @"updated"
#define SODataV4_AtomValue_V3_EDIT_MEDIA @"http://schemas.microsoft.com/ado/2007/08/dataservices/edit-media/"
#define SODataV4_AtomValue_V3_MEDIARESOURCE @"http://schemas.microsoft.com/ado/2007/08/dataservices/mediaresource/"
#define SODataV4_AtomValue_V3_RELATED @"http://schemas.microsoft.com/ado/2007/08/dataservices/related/"
#define SODataV4_AtomValue_V3_SCHEME @"http://schemas.microsoft.com/ado/2007/08/dataservices/scheme"
#define SODataV4_AtomValue_V4_EDIT_MEDIA @"http://docs.oasis-open.org/odata/ns/edit-media/"
#define SODataV4_AtomValue_V4_MEDIARESOURCE @"http://docs.oasis-open.org/odata/ns/mediaresource/"
#define SODataV4_AtomValue_V4_RELATED @"http://docs.oasis-open.org/odata/ns/related/"
#define SODataV4_AtomValue_V4_SCHEME @"http://docs.oasis-open.org/odata/ns/scheme"
@end
#endif
#endif

#ifndef imported_SODataV4__GeoAtom_public
#define imported_SODataV4__GeoAtom_public
/// @internal
///
@interface SODataV4_GeoAtom : SODataV4_ObjectBase
{
}
/// @brief Convert a geography/geometry value into GML representation.
///
///
/// @param geo XML element to receive the GML representation.
/// @param value Data value with a geography or geometry type.
+ (void) format :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_DataValue*)value;
/// @return A geography/geometry value parsed from GML representation.
/// @param geo Value in GML representation.
/// @param type Data type for the expected parsed result.
+ (nonnull SODataV4_DataValue*) parse :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_DataType*)type;
/// @brief Tries to parse the type of the given XmlNode. (Maps it to a meaningful GeoAtom type).
///
///
/// @param geoNode XmlNode of which type should be parsed.
/// @param type A type which determines if the XmlNode should be parsed to e geography or a
/// geometry type.
+ (nonnull NSString*) parseType :(nonnull SODataV4_XmlNode*)geoNode :(nonnull SODataV4_DataType*)type;
@end
#endif

#ifdef import_SODataV4__GeoAtom_private
#ifndef imported_SODataV4__GeoAtom_private
#define imported_SODataV4__GeoAtom_private
@interface SODataV4_GeoAtom (private)
+ (nonnull SODataV4_AtomException*) cannotParse :(nonnull SODataV4_XmlElement*)element;
+ (void) findAll :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name :(nonnull SODataV4_XmlElementList*)list;
+ (nullable SODataV4_XmlElement*) findOne :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
+ (void) formatLineString :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_LineStringCoordinates*)value :(SODataV4_int)srsCode :(nullable NSString*)srsName :(SODataV4_boolean)isNested;
+ (void) formatMultiGeography :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_GeographyValueList*)value;
+ (void) formatMultiGeometry :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_GeometryValueList*)value;
+ (void) formatMultiLineString :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_MultiLineStringCoordinates*)value :(SODataV4_int)srsCode :(nullable NSString*)srsName :(SODataV4_boolean)isNested;
+ (void) formatMultiPoint :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_MultiPointCoordinates*)value :(SODataV4_int)srsCode :(nullable NSString*)srsName :(SODataV4_boolean)isNested;
+ (void) formatMultiPolygon :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_MultiPolygonCoordinates*)value :(SODataV4_int)srsCode :(nullable NSString*)srsName :(SODataV4_boolean)isNested;
+ (void) formatPoint :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_PointCoordinates*)value :(SODataV4_int)srsCode :(nullable NSString*)srsName :(SODataV4_boolean)isNested;
+ (void) formatPolygon :(nonnull SODataV4_XmlElement*)geo :(nonnull SODataV4_PolygonCoordinates*)value :(SODataV4_int)srsCode :(nullable NSString*)srsName :(SODataV4_boolean)isNested;
+ (nonnull SODataV4_XmlElement*) formatPos :(nonnull SODataV4_PointCoordinates*)pc :(SODataV4_int)srsCode;
+ (nonnull SODataV4_XmlElement*) formatPosListLineString :(nonnull SODataV4_LineStringCoordinates*)curve :(SODataV4_int)srsCode;
+ (nonnull SODataV4_XmlElement*) formatPosListMultiPoint :(nonnull SODataV4_MultiPointCoordinates*)mpc :(SODataV4_int)srsCode;
+ (nonnull NSString*) formatPosText :(nonnull SODataV4_PointCoordinates*)pc :(SODataV4_int)srsCode;
+ (nonnull NSString*) formatSRS :(SODataV4_int)srsCode :(nullable NSString*)srsName;
+ (nonnull SODataV4_GeographyValue*) parseGeography :(nonnull SODataV4_XmlElement*)geo :(SODataV4_int)tc :(nonnull SODataV4_GeographyValue*)gv;
+ (nonnull SODataV4_GeographyValueList*) parseGeographyValueList :(nonnull SODataV4_XmlElement*)geo;
+ (nonnull SODataV4_GeometryValue*) parseGeometry :(nonnull SODataV4_XmlElement*)geo :(SODataV4_int)tc :(nonnull SODataV4_GeometryValue*)gv;
+ (nonnull SODataV4_GeometryValueList*) parseGeometryValueList :(nonnull SODataV4_XmlElement*)geo;
+ (nonnull SODataV4_LineStringCoordinates*) parseLineString :(nonnull SODataV4_XmlElement*)geo :(nullable SODataV4_DataValue*)dv;
+ (nonnull SODataV4_StringList*) parseList :(nonnull NSString*)text;
+ (nonnull SODataV4_MultiLineStringCoordinates*) parseMultiLineString :(nonnull SODataV4_XmlElement*)geo :(nullable SODataV4_DataValue*)dv;
+ (nonnull SODataV4_MultiPointCoordinates*) parseMultiPoint :(nonnull SODataV4_XmlElement*)geo :(nullable SODataV4_DataValue*)dv;
+ (nonnull SODataV4_MultiPolygonCoordinates*) parseMultiPolygon :(nonnull SODataV4_XmlElement*)geo :(nullable SODataV4_DataValue*)dv;
+ (nonnull SODataV4_PointCoordinates*) parsePoint :(nonnull SODataV4_XmlElement*)geo :(nullable SODataV4_DataValue*)dv;
+ (SODataV4_double) parsePointCoordinate :(nonnull NSString*)text;
+ (nonnull SODataV4_PolygonCoordinates*) parsePolygon :(nonnull SODataV4_XmlElement*)geo :(nullable SODataV4_DataValue*)dv;
+ (void) parseSRS :(nonnull SODataV4_XmlElement*)element :(nullable SODataV4_DataValue*)dv;
#define SODataV4_GeoAtom_COORDINATES @"coordinates"
#define SODataV4_GeoAtom_EXTERIOR @"exterior"
#define SODataV4_GeoAtom_GEOMETRY_MEMBER @"geometryMember"
#define SODataV4_GeoAtom_GEOMETRY_MEMBER_LC @"geometrymember"
#define SODataV4_GeoAtom_GEOMETRY_MEMBERS @"geometryMembers"
#define SODataV4_GeoAtom_GEOMETRY_MEMBERS_LC @"geometrymembers"
#define SODataV4_GeoAtom_LINE_STRING @"LineString"
#define SODataV4_GeoAtom_LINE_STRING_LC @"linestring"
#define SODataV4_GeoAtom_LINEAR_RING @"LinearRing"
#define SODataV4_GeoAtom_MULTI_LINE_STRING @"MultiLineString"
#define SODataV4_GeoAtom_MULTI_CURVE @"MultiCurve"
#define SODataV4_GeoAtom_MULTI_CURVE_LC @"multicurve"
#define SODataV4_GeoAtom_MULTI_POINT @"MultiPoint"
#define SODataV4_GeoAtom_MULTI_POINT_LC @"multipoint"
#define SODataV4_GeoAtom_MULTI_POLYGON @"MultiPolygon"
#define SODataV4_GeoAtom_MULTI_SURFACE @"MultiSurface"
#define SODataV4_GeoAtom_MULTI_SURFACE_LC @"multisurface"
#define SODataV4_GeoAtom_MULTI_GEOMETRY @"MultiGeometry"
#define SODataV4_GeoAtom_MULTI_GEOMETRY_LC @"multigeometry"
#define SODataV4_GeoAtom_POINT @"Point"
#define SODataV4_GeoAtom_POINT_LC @"point"
#define SODataV4_GeoAtom_POLYGON @"Polygon"
#define SODataV4_GeoAtom_POLYGON_LC @"polygon"
#define SODataV4_GeoAtom_POS @"pos"
#define SODataV4_GeoAtom_POS_LIST @"posList"
#define SODataV4_GeoAtom_SRS_NAME @"srsName"
@end
#endif
#endif

#ifndef imported_SODataV4__AtomDeltaStream_public
#define imported_SODataV4__AtomDeltaStream_public
/// @internal
///
@interface SODataV4_AtomDeltaStream : SODataV4_DeltaStream
{
    @private SODataV4_DataContext* _Nonnull dataContext_;
    @private SODataV4_CharStream* _Nonnull charStream_;
    @private SODataV4_XmlParser* _Nonnull atomStream_;
    @private SODataV4_boolean endElement;
    @private SODataV4_boolean firstItem;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
- (void) abort;
- (void) close;
/// @brief Convert a character stream containing OData delta ATOM encoding into a stream of delta items.
///
///
/// @param stream Character stream.
/// @param context Data context.
+ (nonnull SODataV4_AtomDeltaStream*) fromStream :(nonnull SODataV4_CharStream*)stream :(nonnull SODataV4_DataContext*)context;
- (SODataV4_boolean) next;
@end
#endif

#ifdef import_SODataV4__AtomDeltaStream_private
#ifndef imported_SODataV4__AtomDeltaStream_private
#define imported_SODataV4__AtomDeltaStream_private
@interface SODataV4_AtomDeltaStream (private)
+ (nonnull SODataV4_AtomDeltaStream*) new;
- (nonnull SODataV4_XmlParser*) atomStream;
- (nonnull SODataV4_CharStream*) charStream;
- (nonnull SODataV4_DataContext*) dataContext;
- (void) setAtomStream :(nonnull SODataV4_XmlParser*)value;
- (void) setCharStream :(nonnull SODataV4_CharStream*)value;
- (void) setDataContext :(nonnull SODataV4_DataContext*)value;
+ (nonnull SODataV4_AtomDeltaStream*) _new1 :(nonnull SODataV4_CharStream*)p1 :(nonnull SODataV4_DataContext*)p2 :(nonnull SODataV4_XmlParser*)p3 :(SODataV4_boolean)p4;
+ (nonnull SODataV4_AtomLink*) _new2 :(SODataV4_int)p1 :(nonnull NSString*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlParser* atomStream;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CharStream* charStream;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataContext* dataContext;
@end
#endif
#endif

#ifdef import_SODataV4__AtomDeltaStream_internal
#ifndef imported_SODataV4__AtomDeltaStream_internal
#define imported_SODataV4__AtomDeltaStream_internal
@interface SODataV4_AtomDeltaStream (internal)
/// @internal
///
+ (nullable NSObject*) parseItem :(nonnull SODataV4_XmlElement*)item :(nonnull SODataV4_DataContext*)context;
+ (nullable NSObject*) parseItem :(nonnull SODataV4_XmlElement*)item :(nonnull SODataV4_DataContext*)context :(nullable SODataV4_EntityType*)defaultEntityType;
@end
#endif
#endif

#ifndef imported_SODataV4__AtomException_public
#define imported_SODataV4__AtomException_public
/// @internal
///
@interface SODataV4_AtomException : SODataV4_DataFormatException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AtomException*) new;
/// @internal
///
- (void) _init;
/// @brief Thrown when a value cannot be parsed from ATOM format.
///
///
/// @param value Text of value that could not be parsed.
/// @param type Name of expected data type.
+ (nonnull SODataV4_AtomException*) cannotParse :(nonnull NSString*)value :(nonnull NSString*)type;
/// @return A new exception with the specified root cause.
/// @param cause Root cause.
+ (nonnull SODataV4_AtomException*) withCause :(nonnull NSException*)cause;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_AtomException*) withMessage :(nonnull NSString*)message;
@end
#endif

#ifdef import_SODataV4__AtomException_private
#ifndef imported_SODataV4__AtomException_private
#define imported_SODataV4__AtomException_private
@interface SODataV4_AtomException (private)
+ (nonnull SODataV4_AtomException*) _new1 :(nullable NSException*)p1;
+ (nonnull SODataV4_AtomException*) _new2 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexType_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_ComplexType_in_atom_internal
#define imported_SODataV4__Any_as_data_ComplexType_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexType_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexValueList_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_ComplexValueList_in_atom_internal
#define imported_SODataV4__Any_as_data_ComplexValueList_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexValueList_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexValueList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexValue_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_ComplexValue_in_atom_internal
#define imported_SODataV4__Any_as_data_ComplexValue_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexValue_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DataValueList_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_DataValueList_in_atom_internal
#define imported_SODataV4__Any_as_data_DataValueList_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DataValueList_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DataValueList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DoubleValue_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_DoubleValue_in_atom_internal
#define imported_SODataV4__Any_as_data_DoubleValue_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DoubleValue_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DoubleValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityType_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_EntityType_in_atom_internal
#define imported_SODataV4__Any_as_data_EntityType_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityType_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityValueList_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_EntityValueList_in_atom_internal
#define imported_SODataV4__Any_as_data_EntityValueList_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityValueList_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityValueList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityValue_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_EntityValue_in_atom_internal
#define imported_SODataV4__Any_as_data_EntityValue_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityValue_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EnumType_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_EnumType_in_atom_internal
#define imported_SODataV4__Any_as_data_EnumType_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EnumType_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EnumType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_FloatValue_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_FloatValue_in_atom_internal
#define imported_SODataV4__Any_as_data_FloatValue_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_FloatValue_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_FloatValue*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyCollection_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyCollection_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyCollection_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyCollection_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyCollection*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyLineString_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyLineString_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyLineString_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyLineString_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyMultiLineString_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyMultiLineString_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyMultiLineString_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyMultiLineString_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyMultiLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyMultiPoint_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyMultiPoint_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyMultiPoint_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyMultiPoint_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyMultiPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyMultiPolygon_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyMultiPolygon_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyMultiPolygon_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyMultiPolygon_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyMultiPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyPoint_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyPoint_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyPoint_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyPoint_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeographyPolygon_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeographyPolygon_in_atom_internal
#define imported_SODataV4__Any_as_data_GeographyPolygon_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeographyPolygon_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeographyPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryCollection_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryCollection_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryCollection_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryCollection_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryCollection*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryLineString_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryLineString_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryLineString_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryLineString_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryMultiLineString_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryMultiLineString_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryMultiLineString_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryMultiLineString_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryMultiLineString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryMultiPoint_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryMultiPoint_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryMultiPoint_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryMultiPoint_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryMultiPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryMultiPolygon_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryMultiPolygon_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryMultiPolygon_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryMultiPolygon_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryMultiPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryPoint_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryPoint_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryPoint_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryPoint_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryPoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_GeometryPolygon_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_GeometryPolygon_in_atom_internal
#define imported_SODataV4__Any_as_data_GeometryPolygon_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_GeometryPolygon_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_GeometryPolygon*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_LocalTime_in_atom_internal
#ifndef imported_SODataV4__Any_as_data_LocalTime_in_atom_internal
#define imported_SODataV4__Any_as_data_LocalTime_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_LocalTime_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_LocalTime*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_xml_XmlElement_in_atom_internal
#ifndef imported_SODataV4__Any_as_xml_XmlElement_in_atom_internal
#define imported_SODataV4__Any_as_xml_XmlElement_in_atom_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_xml_XmlElement_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_XmlElement*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Default_undefined_EntitySet_in_atom_internal
#ifndef imported_SODataV4__Default_undefined_EntitySet_in_atom_internal
#define imported_SODataV4__Default_undefined_EntitySet_in_atom_public
/* internal */
/// @brief Static function to apply default undefined values of type `SODataV4_EntitySet`.
///
///
@interface SODataV4_Default_undefined_EntitySet_in_atom : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return a new `SODataV4_EntitySet`.
/// @param value Nullable value.
+ (nonnull SODataV4_EntitySet*) ifNull :(nullable SODataV4_EntitySet*)value;
@end
#endif
#endif

#endif
