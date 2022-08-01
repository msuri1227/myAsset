//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_DATA_2_H
#define SODATAV4_DATA_2_H


@class SODataV4_DataContext;
@class SODataV4_ExpectedItem;
@class SODataV4_QueryFormatter;
@class SODataV4_QueryParser;
@class SODataV4_QueryToken; /* internal */
@class SODataV4_QueryTokenRange; /* internal */
@class SODataV4_QueryTokenLists_PathComparer; /* internal */
@class SODataV4_ValueToStringContext; /* internal */
@class SODataV4_ExpectedItemList; /* internal */
@class SODataV4_QueryTokenList; /* internal */
@class SODataV4_QueryTokenLists; /* internal */
@class SODataV4_Any_as_data_ExpectedItem_in_data; /* internal */
@class SODataV4_Any_as_data_QueryTokenList_in_data; /* internal */
@class SODataV4_Any_as_data_QueryToken_in_data; /* internal */
@class SODataV4_Default_empty_TransformValueList_in_data; /* internal */
@class SODataV4_Default_new_DataValueMap_in_data; /* internal */
@class SODataV4_Default_new_SelectItemList_in_data; /* internal */

#ifndef imported_SODataV4__DataContext_public
#define imported_SODataV4__DataContext_public
/// @internal
///
@interface SODataV4_DataContext : SODataV4_ObjectBase
{
    @private SODataV4_ExpectedItemList* _Nonnull expectedStack;
    @private SODataV4_CsdlDocument* _Nonnull csdlDocument_;
    @private SODataV4_int versionCode_;
    @private SODataV4_int bindOptions_;
    @private SODataV4_DataQuery* _Nullable dataQuery_;
    @private SODataV4_StructureType* _Nullable derivedType_;
    @private SODataV4_boolean followNext_;
    @private SODataV4_DataValueMap* _Nullable aliasValues_;
    @private NSString* _Nullable avoidInPaths_;
}
- (nonnull id) init;
/// @brief Construct a new data context.
///
///
/// @param csdl CSDL document (OData service metadata).
+ (nonnull SODataV4_DataContext*) new :(nonnull SODataV4_CsdlDocument*)csdl;
/// @internal
///
- (void) _init :(nonnull SODataV4_CsdlDocument*)csdl;
/// @brief Alias values needed for query formatting with special characters.
///
///
/// @see <https://issues.oasis-open.org/browse/ODATA-1033>.
- (nullable SODataV4_DataValueMap*) aliasValues;
/// @brief Characters that should be avoided in request paths.
///
///
/// @see <https://tools.ietf.org/html/rfc3986#section-7.3>.
- (nullable NSString*) avoidInPaths;
/// @brief Bind options: a bit mask of flags for binding, formatting and parsing.
///
///
/// @see [constants](#constants).
- (SODataV4_int) bindOptions;
/// @brief CSDL document (OData service metadata).
///
///
- (nonnull SODataV4_CsdlDocument*) csdlDocument;
/// @brief Data query for evaluation of select items, or `nil` if all properties should be selected.
///
///
- (nullable SODataV4_DataQuery*) dataQuery;
/// @brief Derived type for expected query results, or `nil` if no derived type is expected.
///
///
- (nullable SODataV4_StructureType*) derivedType;
/// @return The actual complex type, which may be a subtype of the formal complex type.
/// @param formalType Complex type expected by a caller.
/// @param typeName Type name, which may be for a subtype of the formal type.
+ (nullable SODataV4_ComplexType*) findActualComplex :(nonnull SODataV4_ComplexType*)formalType :(nonnull NSString*)typeName;
/// @return The actual entity type, which may be a subtype of the formal entity type.
/// @param formalType Entity type expected by a caller.
/// @param typeName Type name, which may be for a subtype of the formal type.
+ (nullable SODataV4_EntityType*) findActualEntity :(nonnull SODataV4_EntityType*)formalType :(nonnull NSString*)typeName;
/// @brief Follow next links? (defaults to true)
///
///
- (SODataV4_boolean) followNext;
/// @return A data context which can be used to convert structured (complex/entity) values to strings.
///
+ (nonnull SODataV4_DataContext*) forConversionToString;
/// @return The complex type with the specified name.
/// @param name Complex type name.
/// @throw `SODataV4_UsageException` if no such complex type exists.
- (nonnull SODataV4_ComplexType*) getComplexType :(nonnull NSString*)name;
/// @return The data method with the specified name.
/// @param name Data method name.
/// @throw `SODataV4_UsageException` if no such data method exists.
- (nonnull SODataV4_DataMethod*) getDataMethod :(nonnull NSString*)name;
/// @return The entity set with the specified name.
/// @param name Entity set name.
/// @throw `SODataV4_UsageException` if no such entity set exists.
- (nonnull SODataV4_EntitySet*) getEntitySet :(nonnull NSString*)name;
/// @return The entity type with the specified name.
/// @param name Entity type name.
/// @throw `SODataV4_UsageException` if no such entity type exists.
- (nonnull SODataV4_EntityType*) getEntityType :(nonnull NSString*)name;
/// @return The data method with the specified name, or `nil` if no such data method exists.
/// @param name Data method name.
- (nullable SODataV4_DataMethod*) getOptionalDataMethod :(nonnull NSString*)name;
/// @return The entity set with the specified name, or `nil` if no such entity set exists.
/// @param name Entity set name.
- (nullable SODataV4_EntitySet*) getOptionalEntitySet :(nonnull NSString*)name;
/// @return The service root URL for the OData service.
///
- (nonnull NSString*) getServiceRoot;
/// @return `true` if this context has metadata.
///
- (SODataV4_boolean) hasMetadata;
/// @return `true` if the metadata of this context has a structure (complex/entity) type with the specified `name`.
/// @param name Type name.
- (SODataV4_boolean) hasStructureType :(nonnull NSString*)name;
/// @brief Change the `SODataV4_DataContext`.`bindOptions` for this context to include IS_REQUEST_PAYLOAD.
///
///
/// @return This context.
/// @see `SODataV4_DataVersion`.
- (nonnull SODataV4_DataContext*) inRequest;
/// @brief Change the `SODataV4_DataContext`.`bindOptions` for this context to exclude IS_REQUEST_PAYLOAD.
///
///
/// @return This context.
/// @see `SODataV4_DataVersion`.
- (nonnull SODataV4_DataContext*) inResponse;
/// @brief If this context has no *expected entity set*, then infer it from the context URL (and push it).
///
///
/// @return `true` if the expected entity set was inferred from the context URL.
/// @param url Optional context URL.
/// @see `SODataV4_DataContext`.`pushExpected`.
- (SODataV4_boolean) inferEntitySet :(nullable NSString*)url;
/// @return The `url` parameter, converted from an absolute URL to a relative URL (if possible), otherwise `nil`.
/// @param url URL, which may be absolute, relative, or `nil`.
- (nullable NSString*) makeRelative :(nullable NSString*)url;
/// @return The `url` parameter, converted from an absolute URL to a relative URL (if possible), otherwise `url`.
/// @param url URL, which may be absolute, relative, or `nil`.
- (nullable NSString*) maybeRelative :(nullable NSString*)url;
/// @brief Pop the top *expected entity set* from the context stack.
///
///
- (void) popExpected;
/// @internal
///
- (void) prepareToFormat :(nullable SODataV4_DataValue*)value;
/// @internal
///
- (void) prepareToPatch :(nullable SODataV4_DataValue*)value :(nullable SODataV4_DataValue*)old;
/// @internal
///
- (void) pushExpected :(nonnull SODataV4_EntitySet*)entitySet;
/// @brief Push an expected entity set onto the context stack.
///
///
/// @param entitySet New top *expected entity set*.
/// @param derivedType (optional) Derived type for query results.
- (void) pushExpected :(nonnull SODataV4_EntitySet*)entitySet :(nullable SODataV4_StructureType*)derivedType;
/// @return The data type with the specified name, or `nil` if no such type exists.
/// @param name Data type qualified name.
- (nullable SODataV4_DataType*) resolveAnyType :(nonnull NSString*)name;
/// @brief Alias values needed for query formatting with special characters.
///
///
/// @see <https://issues.oasis-open.org/browse/ODATA-1033>.
- (void) setAliasValues :(nullable SODataV4_DataValueMap*)value;
/// @brief Characters that should be avoided in request paths.
///
///
/// @see <https://tools.ietf.org/html/rfc3986#section-7.3>.
- (void) setAvoidInPaths :(nullable NSString*)value;
/// @brief Bind options: a bit mask of flags for binding, formatting and parsing.
///
///
/// @see [constants](#constants).
- (void) setBindOptions :(SODataV4_int)value;
/// @brief CSDL document (OData service metadata).
///
///
- (void) setCsdlDocument :(nonnull SODataV4_CsdlDocument*)value;
/// @brief Data query for evaluation of select items, or `nil` if all properties should be selected.
///
///
- (void) setDataQuery :(nullable SODataV4_DataQuery*)value;
/// @brief Derived type for expected query results, or `nil` if no derived type is expected.
///
///
- (void) setDerivedType :(nullable SODataV4_StructureType*)value;
/// @brief Follow next links? (defaults to true)
///
///
- (void) setFollowNext :(SODataV4_boolean)value;
/// @brief Data version.
///
///
/// @see `SODataV4_DataVersion`.
- (void) setVersionCode :(SODataV4_int)value;
/// @return the top *expected item* from the context stack, or an item with `SODataV4_EntitySet`.`undefined` if the stack is empty.
///
- (nonnull SODataV4_ExpectedItem*) topExpected;
/// @brief Data version.
///
///
/// @see `SODataV4_DataVersion`.
- (SODataV4_int) versionCode;
/// @internal
///
- (nonnull SODataV4_DataContext*) withExpected :(nonnull SODataV4_EntitySet*)entitySet;
/// @brief Push an expected entity set onto the context stack.
///
///
/// @return This context.
/// @param entitySet New top *expected entity set*.
/// @param derivedType (optional) Derived type for query results.
- (nonnull SODataV4_DataContext*) withExpected :(nonnull SODataV4_EntitySet*)entitySet :(nullable SODataV4_StructureType*)derivedType;
/// @brief Change the `SODataV4_DataContext`.`versionCode` for this context.
///
///
/// @return This context.
/// @param options Bind options.
- (nonnull SODataV4_DataContext*) withOptions :(SODataV4_int)options;
/// @brief Change the `SODataV4_DataContext`.`versionCode` for this context.
///
///
/// @return This context.
/// @param version Data version.
/// @see `SODataV4_DataVersion`.
- (nonnull SODataV4_DataContext*) withVersion :(SODataV4_int)version;
#define SODataV4_DataContext_KEY_ONLY 1
#define SODataV4_DataContext_CHANGES_ONLY 2
#define SODataV4_DataContext_KEY_AND_CHANGES 4
#define SODataV4_DataContext_SEND_TO_CLIENT 8
#define SODataV4_DataContext_VALUE_TO_STRING 16
#define SODataV4_DataContext_FULL_METADATA 32
#define SODataV4_DataContext_REQUIRES_TYPE 64
#define SODataV4_DataContext_SUPPORTS_ALIAS 128
#define SODataV4_DataContext_IN_REQUEST_PATH 256
#define SODataV4_DataContext_IN_QUERY_STRING 512
#define SODataV4_DataContext_IS_DELTA_RESPONSE 1024
#define SODataV4_DataContext_SAP_ENTITY_STATE_ANNOTATIONS 2048
#define SODataV4_DataContext_SAP_OLD_ENTITY_VALUES 4096
#define SODataV4_DataContext_REQUIRES_ID 8192
#define SODataV4_DataContext_IEEE_754_COMPATIBLE 16384
#define SODataV4_DataContext_IS_REQUEST_PAYLOAD 32768
#define SODataV4_DataContext_RECEIVE_FROM_CLIENT 65536
#define SODataV4_DataContext_ISO_8601_COMPATIBLE 131072
/// @brief Alias values needed for query formatting with special characters.
///
///
/// @see <https://issues.oasis-open.org/browse/ODATA-1033>.
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataValueMap* aliasValues;
/// @brief Characters that should be avoided in request paths.
///
///
/// @see <https://tools.ietf.org/html/rfc3986#section-7.3>.
@property (nonatomic, readwrite, strong, nullable) NSString* avoidInPaths;
/// @brief Bind options: a bit mask of flags for binding, formatting and parsing.
///
///
/// @see [constants](#constants).
@property (nonatomic, readwrite) SODataV4_int bindOptions;
/// @brief CSDL document (OData service metadata).
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* csdlDocument;
/// @brief Data query for evaluation of select items, or `nil` if all properties should be selected.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataQuery* dataQuery;
/// @brief Derived type for expected query results, or `nil` if no derived type is expected.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_StructureType* derivedType;
/// @brief Follow next links? (defaults to true)
///
///
@property (nonatomic, readwrite) SODataV4_boolean followNext;
/// @brief Data version.
///
///
/// @see `SODataV4_DataVersion`.
@property (nonatomic, readwrite) SODataV4_int versionCode;
@end
#endif

#ifdef import_SODataV4__DataContext_private
#ifndef imported_SODataV4__DataContext_private
#define imported_SODataV4__DataContext_private
@interface SODataV4_DataContext (private)
+ (nonnull SODataV4_ExpectedItem*) _new1 :(nullable SODataV4_StructureType*)p1 :(nonnull SODataV4_EntitySet*)p2;
@end
#endif
#endif

#ifdef import_SODataV4__DataContext_internal
#ifndef imported_SODataV4__DataContext_internal
#define imported_SODataV4__DataContext_internal
@interface SODataV4_DataContext (internal)
- (nonnull NSString*) addAlias :(nullable SODataV4_DataValue*)value;
- (nonnull SODataV4_DataContext*) allowAlias :(SODataV4_boolean)allow;
@end
#endif
#endif

#ifndef imported_SODataV4__ExpectedItem_public
#define imported_SODataV4__ExpectedItem_public
/// @internal
///
@interface SODataV4_ExpectedItem : SODataV4_ObjectBase
{
    @private SODataV4_EntitySet* _Nonnull entitySet_;
    @private SODataV4_StructureType* _Nullable derivedType_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_ExpectedItem*) new;
/// @internal
///
- (void) _init;
/// @brief Optional derived type.
///
///
- (nullable SODataV4_StructureType*) derivedType;
/// @brief Expected entity set.
///
///
- (nonnull SODataV4_EntitySet*) entitySet;
/// @brief Optional derived type.
///
///
- (void) setDerivedType :(nullable SODataV4_StructureType*)value;
/// @brief Expected entity set.
///
///
- (void) setEntitySet :(nonnull SODataV4_EntitySet*)value;
/// @brief Optional derived type.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_StructureType* derivedType;
/// @brief Expected entity set.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_EntitySet* entitySet;
@end
#endif

#ifndef imported_SODataV4__QueryFormatter_public
#define imported_SODataV4__QueryFormatter_public
/// @internal
///
@interface SODataV4_QueryFormatter : SODataV4_ObjectBase
{
}
/// @return A formatted data query for use in an OData URL.
/// @param query Data query.
/// @param context Data context.
+ (nonnull NSString*) format :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context;
/// @internal
///
+ (nonnull NSString*) formatCanonicalURL :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return The canonical URL of an entity (relative by default, absolute if specified).
/// @param entity Entity value.
/// @param context Data context.
/// @param absolute (optional) Is absolute URL required? (defaults to `false`, resulting in relative URL).
/// @see [Canonical URL](http://docs.oasis-open.org/odata/odata/v4.0/os/part2-url-conventions/odata-v4.0-os-part2-url-conventions.html#_Toc372793775) (OData V4).
+ (nonnull NSString*) formatCanonicalURL :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context :(SODataV4_boolean)absolute;
/// @return A formatted data value for use in an OData URL.
/// @param value Data value.
/// @param context Data context.
+ (nonnull NSString*) formatDataValue :(nullable SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
/// @return The exit link of an entity (if set) or the entity's canonical URL.
/// @param entity Entity value.
/// @param context Data context.
+ (nonnull NSString*) formatEditLink :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return The formatted ID of an entity for use in a URL, i.e. `entity.entityID` (if set) or the entity's canonical URL.
/// @param entity Entity value.
/// @param context Data context.
+ (nonnull NSString*) formatEntityID :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
/// @return The formatted key of an entity for use in a URL, e.g. "(123)" or "(n=123,s='xyz')".
/// @param entityKey Entity key.
/// @param entityType Entity type.
/// @param context Data context.
+ (nonnull NSString*) formatEntityKey :(nonnull SODataV4_EntityKey*)entityKey :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_DataContext*)context;
/// @return The read link of an entity (if set) or the entity's canonical URL.
/// @param entity Entity value.
/// @param context Data context.
+ (nonnull NSString*) formatReadLink :(nonnull SODataV4_EntityValue*)entity :(nonnull SODataV4_DataContext*)context;
@end
#endif

#ifdef import_SODataV4__QueryFormatter_private
#ifndef imported_SODataV4__QueryFormatter_private
#define imported_SODataV4__QueryFormatter_private
@interface SODataV4_QueryFormatter (private)
+ (nonnull NSString*) jsonInURL :(nonnull SODataV4_DataValue*)value :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) singleQuotedText :(nonnull NSString*)text;
+ (void) v3ExpandPaths :(nonnull SODataV4_ExpandItem*)item :(nonnull SODataV4_StringList*)paths :(nonnull NSString*)prefix;
@end
#endif
#endif

#ifdef import_SODataV4__QueryFormatter_internal
#ifndef imported_SODataV4__QueryFormatter_internal
#define imported_SODataV4__QueryFormatter_internal
@interface SODataV4_QueryFormatter (internal)
+ (nonnull NSString*) formatAggregation :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatCall :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataMethodCall*)call :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) formatCustom :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
/// @brief Return the OData URL path expression syntax for a data path ('/'-separated segments, percent-encoded).
///
///
/// @param path Data path which will be converted to URL path
/// @param context DataContext used to generate url representation of DataPath if needed.
+ (nonnull NSString*) formatDataPath :(nonnull SODataV4_DataPath*)path :(nonnull SODataV4_DataContext*)context;
/// @return A formatted data type for use in an OData URL.
/// @param context Data context.
+ (nonnull NSString*) formatDataType :(nonnull SODataV4_DataType*)type :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) formatExpand :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatExpandItem :(nonnull SODataV4_ExpandItem*)item :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) formatFilter :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatInlineCount :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatOrderBy :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatPageSize :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatQueryFunction :(nonnull SODataV4_QueryFunctionCall*)call :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) formatQueryOperator :(nonnull SODataV4_QueryOperatorCall*)call :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) formatSearch :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatSelect :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatSelectItem :(nonnull SODataV4_SelectItem*)item :(nonnull SODataV4_DataContext*)context;
+ (nonnull NSString*) formatSkipTop :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_DataContext*)context :(SODataV4_char)separator;
+ (nonnull NSString*) formatTransformValue :(nonnull SODataV4_TransformValue*)transformValue :(nonnull SODataV4_DataContext*)context;
@end
#endif
#endif

#ifndef imported_SODataV4__QueryParser_public
#define imported_SODataV4__QueryParser_public
/// @internal
///
@interface SODataV4_QueryParser : SODataV4_ObjectBase
{
    @private SODataV4_DataContext* _Nonnull context_;
    @private SODataV4_boolean isNested;
    @private SODataV4_QueryTokenLists* _Nonnull expandMore;
    @private SODataV4_DataType* _Nullable expectedType;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new parser with the specified `context`.
///
///
/// @param context Data context.
+ (nonnull SODataV4_QueryParser*) new :(nonnull SODataV4_DataContext*)context;
/// @internal
///
- (void) _init :(nonnull SODataV4_DataContext*)context;
/// @brief Attempt to determine the entity set of the object referenced by `url`.
///
///
/// @return Inferred entity set, or `nil` if it cannot be determined.
/// @param url Context URL.
/// @param context Data context.
+ (nullable SODataV4_EntitySet*) inferEntitySet :(nonnull NSString*)url :(nonnull SODataV4_DataContext*)context;
/// @brief Parse a query with the specified request path and query string.
///
///
/// @return Parsed query.
/// @param requestPath Request path from query URL.
/// @param queryString Query string from query URL.
/// @see [Uniform Resource Locator Syntax](https://en.wikipedia.org/wiki/Uniform_Resource_Locator#Syntax) (path and query).
- (nonnull SODataV4_DataQuery*) parse :(nullable NSString*)requestPath :(nullable NSString*)queryString;
/// @brief Parse a canonical URL.
///
///
/// @return Entity value with all key properties set, or `nil` if `url` isn't a canonical URL.
/// @param url Resource location.
/// @param context Data context.
+ (nullable SODataV4_EntityValue*) parseCanonicalURL :(nonnull NSString*)url :(nonnull SODataV4_DataContext*)context;
/// @brief Parse an entity ID.
///
///
/// @return Entity value with all key properties set, or `nil` if `uri` isn't a canonical URL.
/// @param uri Resource identifier.
/// @param context Data context.
+ (nullable SODataV4_EntityValue*) parseEntityID :(nonnull NSString*)uri :(nonnull SODataV4_DataContext*)context;
@end
#endif

#ifdef import_SODataV4__QueryParser_private
#ifndef imported_SODataV4__QueryParser_private
#define imported_SODataV4__QueryParser_private
@interface SODataV4_QueryParser (private)
- (SODataV4_double) amountToDouble :(nonnull SODataV4_DataValue*)value :(nonnull SODataV4_QueryTokenList*)amountTokens;
- (SODataV4_int) amountToInt :(nonnull SODataV4_DataValue*)value :(nonnull SODataV4_QueryTokenList*)amountTokens;
- (nonnull NSString*) appendTokens :(nonnull SODataV4_QueryTokenList*)tokens;
- (nonnull SODataV4_DataContext*) context;
- (nullable SODataV4_DataValue*) convertValue :(nullable SODataV4_DataValue*)value :(nonnull SODataV4_DataType*)type;
- (SODataV4_int) findCloseParen :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)from :(SODataV4_int)to;
- (nullable SODataV4_ExpandItem*) findExpand :(nonnull NSString*)path :(nonnull NSString*)pathPrefix :(nullable SODataV4_ExpandItemList*)expandItems;
- (SODataV4_int) ifPercentThen2 :(SODataV4_char)value;
- (SODataV4_boolean) isGuidValue :(nonnull NSString*)text :(SODataV4_int)start;
- (SODataV4_boolean) isNamePart :(SODataV4_char)value;
- (SODataV4_boolean) isNamePartAt :(SODataV4_int)index :(nonnull NSString*)text;
- (SODataV4_boolean) isNameStart :(SODataV4_char)value;
- (SODataV4_boolean) isNameStartAt :(SODataV4_int)index :(nonnull NSString*)text;
- (nonnull NSString*) jsonInURL :(SODataV4_int)index :(nonnull NSString*)text :(nonnull NSString*)start :(nonnull NSString*)end;
/// @brief Like Assert.isTrue, but throws a non-fatal exception.
///
///
- (void) mustBeTrue :(SODataV4_boolean)condition;
- (nonnull SODataV4_AggregateValue*) parseAggregate :(nullable SODataV4_QueryTokenList*)aggregateTokens;
- (void) parseAggregateFrom :(nonnull SODataV4_AggregateExpression*)aggregateExpression :(nonnull SODataV4_QueryTokenList*)aggregateTokens;
- (nonnull SODataV4_AmountTransform*) parseAmountTransform :(nonnull SODataV4_QueryTokenList*)amountTokens :(nonnull NSString*)transformName;
- (nonnull SODataV4_DataValueList*) parseArguments :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)from :(SODataV4_int)to;
- (nonnull NSString*) parseCustom :(nonnull SODataV4_DataQuery*)query :(nonnull NSString*)queryString;
- (nonnull SODataV4_ExpandItemList*) parseExpand :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryTokenList*)tokens;
- (nonnull SODataV4_ExpandTransform*) parseExpandTransform :(nonnull SODataV4_QueryTokenList*)expandTokens;
- (nonnull SODataV4_QueryFilter*) parseFilter :(nonnull SODataV4_QueryTokenList*)tokens;
- (SODataV4_int) parseFormat :(nonnull SODataV4_QueryTokenList*)tokens;
- (void) parseFunctionCall :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryTokenList*)parameterTokens;
- (void) parseFunctionCallV3 :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryTokenList*)parameterTokens;
- (nonnull SODataV4_GroupTransform*) parseGroupBy :(nullable SODataV4_QueryTokenList*)groupByTokens;
- (nullable SODataV4_DataValue*) parseJSON :(nonnull NSString*)text;
- (nonnull SODataV4_EntityKey*) parseKeyPredicate :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_QueryTokenList*)keyTokens;
- (nonnull SODataV4_SortItemList*) parseOrderBy :(nonnull SODataV4_QueryTokenList*)tokens;
- (void) parsePropertyPath :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_StringList*)pathSegments;
/// @internal
///
- (nonnull SODataV4_DataPath*) parsePropertyPathSegment :(nonnull NSString*)segment :(nullable SODataV4_StructureType*)context;
- (nonnull SODataV4_DataPath*) parsePropertyPathSegment :(nonnull NSString*)segment :(nullable SODataV4_StructureType*)context :(nullable SODataV4_DataPath*)parentPath;
- (void) parseQueryString :(nonnull SODataV4_DataQuery*)query :(nonnull NSString*)queryString;
- (void) parseQueryStringTokens :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryTokenList*)tokens;
- (void) parseRequestPath :(nonnull SODataV4_DataQuery*)query :(nonnull NSString*)requestPath;
- (void) parseRequestPathTokens :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryTokenList*)tokens;
- (nonnull SODataV4_SelectItemList*) parseSelect :(nonnull SODataV4_DataQuery*)query :(nonnull SODataV4_QueryTokenList*)tokens;
- (nonnull SODataV4_TransformValueList*) parseTransformValues :(nonnull SODataV4_QueryTokenList*)tokens;
/// @internal
///
- (nullable SODataV4_DataValue*) parseValue :(nonnull SODataV4_QueryTokenList*)tokens;
/// @internal
///
- (nullable SODataV4_DataValue*) parseValue :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)from;
- (nullable SODataV4_DataValue*) parseValue :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)from :(SODataV4_int)to;
/// @internal
///
- (nullable SODataV4_DataValue*) parseValueAllowAlias :(nonnull SODataV4_QueryTokenList*)tokens;
/// @internal
///
- (nullable SODataV4_DataValue*) parseValueAllowAlias :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)from;
- (nullable SODataV4_DataValue*) parseValueAllowAlias :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)from :(SODataV4_int)to;
- (nullable SODataV4_QueryTokenRange*) rangeOf :(nonnull NSString*)option :(nonnull SODataV4_QueryTokenList*)tokens;
- (void) setContext :(nonnull SODataV4_DataContext*)value;
- (nullable SODataV4_QueryTokenList*) takeOut :(nonnull NSString*)option :(nonnull SODataV4_QueryTokenList*)tokens;
- (nullable SODataV4_QueryTokenList*) takeParanthesis :(nonnull SODataV4_QueryTokenList*)tokens;
- (nonnull SODataV4_QueryTokenList*) tokenize :(nonnull NSString*)text :(SODataV4_int)start;
+ (nonnull SODataV4_DataQuery*) _new1 :(nullable NSObject*)p1;
+ (nonnull SODataV4_QueryToken*) _new2 :(nonnull NSString*)p1 :(SODataV4_int)p2;
+ (nonnull SODataV4_ExpandItem*) _new3 :(nonnull SODataV4_DataPath*)p1;
+ (nonnull SODataV4_Parameter*) _new4 :(nonnull NSString*)p1 :(nonnull SODataV4_DataType*)p2 :(nullable SODataV4_DataValue*)p3;
+ (nonnull SODataV4_SortItem*) _new5 :(nonnull SODataV4_QueryValue*)p1 :(nonnull SODataV4_SortOrder*)p2;
+ (nonnull SODataV4_DataMethodCall*) _new6 :(nonnull SODataV4_DataMethod*)p1 :(nonnull SODataV4_ParameterList*)p2;
+ (nonnull SODataV4_SelectItem*) _new7 :(nonnull SODataV4_DataPath*)p1;
+ (nonnull SODataV4_QueryAlias*) _new8 :(nonnull NSString*)p1;
#define SODataV4_QueryParser_AMP '&'
#define SODataV4_QueryParser_EQ '='
#define SODataV4_QueryParser_PERCENT '%'
#define SODataV4_QueryParser_SPACE ' '
#define SODataV4_QueryParser_TAB SODataV4_CHAR(0x0009)
#define SODataV4_QueryParser_AT '@'
#define SODataV4_QueryParser_COLON ':'
#define SODataV4_QueryParser_COMMA ','
#define SODataV4_QueryParser_PLUS '+'
#define SODataV4_QueryParser_SEMI ';'
#define SODataV4_QueryParser_STAR '*'
#define SODataV4_QueryParser_SQUOTE '\''
#define SODataV4_QueryParser_OPEN '('
#define SODataV4_QueryParser_CLOSE ')'
#define SODataV4_QueryParser_SLASH '/'
#define SODataV4_QueryParser_PERCENT_SPACE @"%20"
#define SODataV4_QueryParser_PERCENT_TAB @"%09"
#define SODataV4_QueryParser_PERCENT_AT @"%40"
#define SODataV4_QueryParser_PERCENT_COLON @"%3A"
#define SODataV4_QueryParser_PERCENT_COMMA @"%2C"
#define SODataV4_QueryParser_PERCENT_PLUS @"%2B"
#define SODataV4_QueryParser_PERCENT_SEMI @"%3B"
#define SODataV4_QueryParser_PERCENT_STAR @"%2A"
#define SODataV4_QueryParser_PERCENT_DQUOTE @"%22"
#define SODataV4_QueryParser_PERCENT_SQUOTE @"%27"
#define SODataV4_QueryParser_PERCENT_OPEN @"%28"
#define SODataV4_QueryParser_PERCENT_CLOSE @"%29"
#define SODataV4_QueryParser_PERCENT_SLASH @"%2F"
#define SODataV4_QueryParser_PERCENT_BACKSLASH @"%5C"
#define SODataV4_QueryParser_BEGIN_ARRAY @"%5B"
#define SODataV4_QueryParser_BEGIN_OBJECT @"%7B"
#define SODataV4_QueryParser_END_ARRAY @"%5D"
#define SODataV4_QueryParser_END_OBJECT @"%7D"
+ (nonnull SODataV4_BigInteger*) MIN_LONG;
+ (nonnull SODataV4_BigInteger*) MAX_LONG;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataContext* context;
@end
#define SODataV4_QueryParser_MIN_LONG [SODataV4_QueryParser MIN_LONG]
#define SODataV4_QueryParser_MAX_LONG [SODataV4_QueryParser MAX_LONG]
#endif
#endif

#ifdef import_SODataV4__QueryToken_internal
#ifndef imported_SODataV4__QueryToken_internal
#define imported_SODataV4__QueryToken_public
/* internal */
@interface SODataV4_QueryToken : SODataV4_ObjectBase
{
    @private SODataV4_int type_;
    @private NSString* _Nonnull text_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_QueryToken*) new;
/// @internal
///
- (void) _init;
- (SODataV4_boolean) hasName :(nonnull NSString*)name;
- (SODataV4_boolean) hasSymbol :(SODataV4_char)symbol;
- (SODataV4_boolean) isBoolean;
- (SODataV4_boolean) isFalse;
- (SODataV4_boolean) isGuid;
- (SODataV4_boolean) isJson;
- (SODataV4_boolean) isName;
- (SODataV4_boolean) isNull;
- (SODataV4_boolean) isNumber;
- (SODataV4_boolean) isPath;
- (SODataV4_boolean) isSpace;
- (SODataV4_boolean) isString;
- (SODataV4_boolean) isSymbol;
- (SODataV4_boolean) isTrue;
- (void) setText :(nonnull NSString*)value;
- (void) setType :(SODataV4_int)value;
- (nonnull NSString*) text;
/// @return A string representation of this object.
///
- (nonnull NSString*) toString;
- (SODataV4_int) type;
#define SODataV4_QueryToken_TYPE_NAME 1
#define SODataV4_QueryToken_TYPE_NUMBER 2
#define SODataV4_QueryToken_TYPE_PATH 3
#define SODataV4_QueryToken_TYPE_STRING 4
#define SODataV4_QueryToken_TYPE_SYMBOL 5
#define SODataV4_QueryToken_TYPE_SPACE 6
#define SODataV4_QueryToken_TYPE_GUID 7
#define SODataV4_QueryToken_TYPE_JSON 8
@property (nonatomic, readonly) SODataV4_boolean isBoolean;
@property (nonatomic, readonly) SODataV4_boolean isFalse;
@property (nonatomic, readonly) SODataV4_boolean isGuid;
@property (nonatomic, readonly) SODataV4_boolean isJson;
@property (nonatomic, readonly) SODataV4_boolean isName;
@property (nonatomic, readonly) SODataV4_boolean isNull;
@property (nonatomic, readonly) SODataV4_boolean isNumber;
@property (nonatomic, readonly) SODataV4_boolean isPath;
@property (nonatomic, readonly) SODataV4_boolean isSpace;
@property (nonatomic, readonly) SODataV4_boolean isString;
@property (nonatomic, readonly) SODataV4_boolean isSymbol;
@property (nonatomic, readonly) SODataV4_boolean isTrue;
@property (nonatomic, readwrite, strong, nonnull) NSString* text;
@property (nonatomic, readwrite) SODataV4_int type;
@end
#endif
#endif

#ifdef import_SODataV4__QueryToken_private
#ifndef imported_SODataV4__QueryToken_private
#define imported_SODataV4__QueryToken_private
@interface SODataV4_QueryToken (private)
+ (nonnull SODataV4_DataContext*) TO_STRING_CONTEXT;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_DataContext* TO_STRING_CONTEXT;
@end
#endif
#endif

#ifdef import_SODataV4__QueryTokenRange_internal
#ifndef imported_SODataV4__QueryTokenRange_internal
#define imported_SODataV4__QueryTokenRange_public
/* internal */
@interface SODataV4_QueryTokenRange : SODataV4_ObjectBase
{
    @private SODataV4_int start_;
    @private SODataV4_int end_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_QueryTokenRange*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) end;
+ (nonnull SODataV4_QueryTokenRange*) of :(SODataV4_int)start :(SODataV4_int)end;
- (void) setEnd :(SODataV4_int)value;
- (void) setStart :(SODataV4_int)value;
- (SODataV4_int) start;
@property (nonatomic, readwrite) SODataV4_int end;
@property (nonatomic, readwrite) SODataV4_int start;
@end
#endif
#endif

#ifdef import_SODataV4__QueryTokenRange_private
#ifndef imported_SODataV4__QueryTokenRange_private
#define imported_SODataV4__QueryTokenRange_private
@interface SODataV4_QueryTokenRange (private)
+ (nonnull SODataV4_QueryTokenRange*) _new1 :(SODataV4_int)p1 :(SODataV4_int)p2;
@end
#endif
#endif

#ifdef import_SODataV4__QueryTokenLists_PathComparer_internal
#ifndef imported_SODataV4__QueryTokenLists_PathComparer_internal
#define imported_SODataV4__QueryTokenLists_PathComparer_public
/* internal */
@interface SODataV4_QueryTokenLists_PathComparer : SODataV4_Comparer
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_QueryTokenLists_PathComparer*) new;
/// @internal
///
- (void) _init;
- (SODataV4_int) compare :(nullable NSObject*)left :(nullable NSObject*)right;
+ (nonnull SODataV4_QueryTokenLists_PathComparer*) singleton;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_QueryTokenLists_PathComparer* singleton;
@end
#endif
#endif

#ifdef import_SODataV4__ValueToStringContext_internal
#ifndef imported_SODataV4__ValueToStringContext_internal
#define imported_SODataV4__ValueToStringContext_public
/* internal */
@interface SODataV4_ValueToStringContext : SODataV4_DataContext
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new data context.
///
///
+ (nonnull SODataV4_ValueToStringContext*) new;
/// @internal
///
- (void) _init;
/// @return `true` if this context has metadata.
///
- (SODataV4_boolean) hasMetadata;
@end
#endif
#endif

#ifdef import_SODataV4__ValueToStringContext_private
#ifndef imported_SODataV4__ValueToStringContext_private
#define imported_SODataV4__ValueToStringContext_private
@interface SODataV4_ValueToStringContext (private)
+ (nonnull SODataV4_CsdlDocument*) EMPTY_CSDL;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlDocument* EMPTY_CSDL;
@end
#endif
#endif

#ifdef import_SODataV4__ExpectedItemList_internal
#ifndef imported_SODataV4__ExpectedItemList_internal
#define imported_SODataV4__ExpectedItemList_public
/* internal */
/// @brief A list of item type `SODataV4_ExpectedItem`.
///
///
@interface SODataV4_ExpectedItemList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_ExpectedItemList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_ExpectedItemList*) new;
/// @brief Construct a new list with `SODataV4_ExpectedItemList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_ExpectedItemList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_ExpectedItem*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_ExpectedItemList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_ExpectedItemList*) addThis :(nonnull SODataV4_ExpectedItem*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_ExpectedItemList*) copy;
/// @brief An immutable empty `SODataV4_ExpectedItemList`.
///
///
+ (nonnull SODataV4_ExpectedItemList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_ExpectedItem*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_ExpectedItemList`.`length` - 1).
- (nonnull SODataV4_ExpectedItem*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_ExpectedItemList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_ExpectedItem`.
- (SODataV4_boolean) includes :(nonnull SODataV4_ExpectedItem*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_ExpectedItem*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_ExpectedItemList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_ExpectedItem`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_ExpectedItem*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_ExpectedItemList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_ExpectedItemList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_ExpectedItemList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_ExpectedItem*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_ExpectedItem*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_ExpectedItem*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_ExpectedItemList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_ExpectedItem`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_ExpectedItem*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_ExpectedItem*)item;
/// @brief Return a new `SODataV4_ExpectedItemList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_ExpectedItem` will be removed.
///
/// @return A new list of item type `SODataV4_ExpectedItem`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_ExpectedItemList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_ExpectedItem*) single;
/// @internal
///
- (nonnull SODataV4_ExpectedItemList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_ExpectedItemList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_ExpectedItemList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_ExpectedItemList* empty;
@end
#endif
#endif

#ifdef import_SODataV4__QueryTokenList_internal
#ifndef imported_SODataV4__QueryTokenList_internal
#define imported_SODataV4__QueryTokenList_public
/* internal */
/// @brief A list of item type `SODataV4_QueryToken`.
///
///
@interface SODataV4_QueryTokenList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_QueryTokenList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_QueryTokenList*) new;
/// @brief Construct a new list with `SODataV4_QueryTokenList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_QueryTokenList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_QueryToken*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_QueryTokenList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_QueryTokenList*) addThis :(nonnull SODataV4_QueryToken*)item;
- (nonnull SODataV4_QueryTokenList*) after :(SODataV4_int)type :(nonnull NSString*)text;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_QueryTokenList*) copy;
/// @brief An immutable empty `SODataV4_QueryTokenList`.
///
///
+ (nonnull SODataV4_QueryTokenList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_QueryToken*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_QueryTokenList`.`length` - 1).
- (nonnull SODataV4_QueryToken*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_QueryTokenList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_QueryToken`.
- (SODataV4_boolean) includes :(nonnull SODataV4_QueryToken*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_QueryToken*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_QueryTokenList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_QueryToken`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_QueryToken*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_QueryTokenList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_QueryTokenList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_QueryTokenList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_QueryToken*)item;
/// @internal
///
- (nonnull NSString*) join;
- (nonnull NSString*) join :(nonnull NSString*)separator;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_QueryToken*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_QueryToken*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_QueryTokenList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_QueryToken`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_QueryToken*)item :(SODataV4_int)start;
/// @internal
///
- (nonnull SODataV4_IntList*) match :(nonnull SODataV4_QueryToken*)token;
/// @internal
///
- (nonnull SODataV4_IntList*) match :(nonnull SODataV4_QueryToken*)token :(SODataV4_boolean)stopAtFirst;
/// @internal
///
- (nonnull SODataV4_IntList*) match :(nonnull SODataV4_QueryToken*)token :(SODataV4_boolean)stopAtFirst :(SODataV4_nullable_int)from;
- (nonnull SODataV4_IntList*) match :(nonnull SODataV4_QueryToken*)token :(SODataV4_boolean)stopAtFirst :(SODataV4_nullable_int)from :(SODataV4_nullable_int)to;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_QueryToken*)item;
/// @brief Return a new `SODataV4_QueryTokenList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_QueryToken` will be removed.
///
/// @return A new list of item type `SODataV4_QueryToken`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_QueryTokenList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_QueryToken*) single;
/// @internal
///
- (nonnull SODataV4_QueryTokenList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_QueryTokenList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_QueryTokenList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_QueryTokenList* empty;
@end
#endif
#endif

#ifdef import_SODataV4__QueryTokenLists_internal
#ifndef imported_SODataV4__QueryTokenLists_internal
#define imported_SODataV4__QueryTokenLists_public
/* internal */
/// @brief A list of item type `SODataV4_QueryTokenList`.
///
///
@interface SODataV4_QueryTokenLists : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_QueryTokenLists`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_QueryTokenLists*) new;
/// @brief Construct a new list with `SODataV4_QueryTokenLists`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_QueryTokenLists*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_QueryTokenList*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_QueryTokenLists*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_QueryTokenLists*) addThis :(nonnull SODataV4_QueryTokenList*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_QueryTokenLists*) copy;
/// @brief An immutable empty `SODataV4_QueryTokenLists`.
///
///
+ (nonnull SODataV4_QueryTokenLists*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_QueryTokenList*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_QueryTokenLists`.`length` - 1).
- (nonnull SODataV4_QueryTokenList*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_QueryTokenLists`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_QueryTokenList`.
- (SODataV4_boolean) includes :(nonnull SODataV4_QueryTokenList*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_QueryTokenList*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_QueryTokenLists`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_QueryTokenList`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_QueryTokenList*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_QueryTokenLists`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_QueryTokenLists*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_QueryTokenLists`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_QueryTokenList*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_QueryTokenList*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_QueryTokenList*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_QueryTokenLists`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_QueryTokenList`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_QueryTokenList*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_QueryTokenList*)item;
/// @brief Return a new `SODataV4_QueryTokenLists` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_QueryTokenList` will be removed.
///
/// @return A new list of item type `SODataV4_QueryTokenList`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_QueryTokenLists*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_QueryTokenList*) single;
/// @internal
///
- (nonnull SODataV4_QueryTokenLists*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_QueryTokenLists*) slice :(SODataV4_int)start :(SODataV4_int)end;
- (void) sortByPath;
+ (nonnull SODataV4_QueryTokenLists*) split :(nonnull SODataV4_QueryTokenList*)tokens :(SODataV4_int)type :(nonnull NSString*)text;
/// @brief An immutable empty `SODataV4_QueryTokenLists`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_QueryTokenLists* empty;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ExpectedItem_in_data_internal
#ifndef imported_SODataV4__Any_as_data_ExpectedItem_in_data_internal
#define imported_SODataV4__Any_as_data_ExpectedItem_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ExpectedItem_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ExpectedItem*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_QueryTokenList_in_data_internal
#ifndef imported_SODataV4__Any_as_data_QueryTokenList_in_data_internal
#define imported_SODataV4__Any_as_data_QueryTokenList_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_QueryTokenList_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_QueryTokenList*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_QueryToken_in_data_internal
#ifndef imported_SODataV4__Any_as_data_QueryToken_in_data_internal
#define imported_SODataV4__Any_as_data_QueryToken_in_data_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_QueryToken_in_data : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_QueryToken*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Default_empty_TransformValueList_in_data_internal
#ifndef imported_SODataV4__Default_empty_TransformValueList_in_data_internal
#define imported_SODataV4__Default_empty_TransformValueList_in_data_public
/* internal */
/// @brief Static function to apply default `empty` values of type `SODataV4_TransformValueList`.
///
///
@interface SODataV4_Default_empty_TransformValueList_in_data : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `T.empty`.
/// @param value Nullable value.
+ (nonnull SODataV4_TransformValueList*) ifNull :(nullable SODataV4_TransformValueList*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Default_new_DataValueMap_in_data_internal
#ifndef imported_SODataV4__Default_new_DataValueMap_in_data_internal
#define imported_SODataV4__Default_new_DataValueMap_in_data_public
/* internal */
/// @brief Static function to apply default new values of type `SODataV4_DataValueMap`.
///
///
@interface SODataV4_Default_new_DataValueMap_in_data : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return a new `SODataV4_DataValueMap`.
/// @param value Nullable value.
+ (nonnull SODataV4_DataValueMap*) ifNull :(nullable SODataV4_DataValueMap*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Default_new_SelectItemList_in_data_internal
#ifndef imported_SODataV4__Default_new_SelectItemList_in_data_internal
#define imported_SODataV4__Default_new_SelectItemList_in_data_public
/* internal */
/// @brief Static function to apply default new values of type `SODataV4_SelectItemList`.
///
///
@interface SODataV4_Default_new_SelectItemList_in_data : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return a new `SODataV4_SelectItemList`.
/// @param value Nullable value.
+ (nonnull SODataV4_SelectItemList*) ifNull :(nullable SODataV4_SelectItemList*)value;
@end
#endif
#endif

#endif
