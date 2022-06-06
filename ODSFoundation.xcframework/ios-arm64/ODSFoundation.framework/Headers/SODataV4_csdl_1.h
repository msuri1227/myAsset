//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_CSDL_1_H
#define SODATAV4_CSDL_1_H


@class SODataV4_AnnotationToResolve; /* internal */
@class SODataV4_CsdlAssociation; /* internal */
@class SODataV4_CsdlAssociationMap_Entry; /* internal */
@class SODataV4_CsdlCompatibilityChecker;
@class SODataV4_CsdlDocument;
@class SODataV4_CsdlFetcher;
@class SODataV4_CsdlIdentifier;
@class SODataV4_CsdlOption;
@class SODataV4_CsdlOwner; /* internal */
@class SODataV4_CsdlParser;
@class SODataV4_CsdlReference;
@class SODataV4_CsdlReference_Include;
@class SODataV4_CsdlAssociationMap; /* internal */
@class SODataV4_AnnotationToResolveList; /* internal */
@class SODataV4_CsdlAssociationList; /* internal */
@class SODataV4_CsdlAssociationMap_EntryList; /* internal */
@class SODataV4_CsdlOwnerList; /* internal */
@class SODataV4_CsdlReferenceList;
@class SODataV4_CsdlReference_IncludeList;
@class SODataV4_CsdlException;
@class SODataV4_CsdlNavigation; /* internal */
@class SODataV4_Any_as_core_MapFromString_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_AnnotationToResolve_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_CsdlAssociationMap_Entry_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_CsdlAssociation_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_CsdlNavigation_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_CsdlOwner_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_CsdlReference_Include_in_csdl; /* internal */
@class SODataV4_Any_as_csdl_CsdlReference_in_csdl; /* internal */
@class SODataV4_Any_as_data_ComplexType_in_csdl; /* internal */
@class SODataV4_Any_as_data_DataType_in_csdl; /* internal */
@class SODataV4_Any_as_data_EntityType_in_csdl; /* internal */
@class SODataV4_Any_as_data_EnumType_in_csdl; /* internal */
@class SODataV4_Any_isNullable_data_ComplexValue_in_csdl; /* internal */
@class SODataV4_Any_isNullable_data_EntityValue_in_csdl; /* internal */
@class SODataV4_ApplyDefault_TypeFacets_in_csdl; /* internal */
@class SODataV4_ApplyDefault_boolean_in_csdl; /* internal */
@class SODataV4_ApplyDefault_int_in_csdl; /* internal */
@class SODataV4_List_count_EntitySetList_in_csdl; /* internal */
@class SODataV4_List_map_PropertyList_StringList_in_csdl; /* internal */

#ifdef import_SODataV4__AnnotationToResolve_internal
#ifndef imported_SODataV4__AnnotationToResolve_internal
#define imported_SODataV4__AnnotationToResolve_public
/* internal */
@interface SODataV4_AnnotationToResolve : SODataV4_ObjectBase
{
    @private SODataV4_XmlElement* _Nonnull element_;
    @private SODataV4_AnnotationTerm* _Nonnull term_;
    @private SODataV4_Annotation* _Nonnull ann_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_AnnotationToResolve*) new;
/// @internal
///
- (void) _init;
- (nonnull SODataV4_Annotation*) ann;
- (nonnull SODataV4_XmlElement*) element;
- (void) setAnn :(nonnull SODataV4_Annotation*)value;
- (void) setElement :(nonnull SODataV4_XmlElement*)value;
- (void) setTerm :(nonnull SODataV4_AnnotationTerm*)value;
- (nonnull SODataV4_AnnotationTerm*) term;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Annotation* ann;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlElement* element;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_AnnotationTerm* term;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlAssociation_internal
#ifndef imported_SODataV4__CsdlAssociation_internal
#define imported_SODataV4__CsdlAssociation_public
/* internal */
@interface SODataV4_CsdlAssociation : SODataV4_ObjectBase
{
    @private NSString* _Nonnull localName_;
    @private NSString* _Nonnull qualifiedName_;
    @private NSString* _Nullable endType1_;
    @private NSString* _Nullable endRole1_;
    @private SODataV4_boolean endMany1_;
    @private SODataV4_boolean endZero1_;
    @private NSString* _Nullable endType2_;
    @private NSString* _Nullable endRole2_;
    @private SODataV4_boolean endMany2_;
    @private SODataV4_boolean endZero2_;
    @private SODataV4_int onDelete1_;
    @private SODataV4_int onDelete2_;
    @private NSString* _Nullable partner1_;
    @private NSString* _Nullable partner2_;
    @private SODataV4_StringMap* _Nonnull referentialConstraints_;
    @private NSString* _Nullable dependentRole_;
    @private NSString* _Nullable principalRole_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlAssociation*) new;
/// @internal
///
- (void) _init;
- (nullable NSString*) dependentRole;
- (SODataV4_boolean) endMany1;
- (SODataV4_boolean) endMany2;
- (nullable NSString*) endRole1;
- (nullable NSString*) endRole2;
- (nullable NSString*) endType1;
- (nullable NSString*) endType2;
- (SODataV4_boolean) endZero1;
- (SODataV4_boolean) endZero2;
- (nonnull NSString*) localName;
- (SODataV4_int) onDelete1;
- (SODataV4_int) onDelete2;
- (nullable NSString*) partner1;
- (nullable NSString*) partner2;
- (nullable NSString*) principalRole;
- (nonnull NSString*) qualifiedName;
- (nonnull SODataV4_StringMap*) referentialConstraints;
- (void) setDependentRole :(nullable NSString*)value;
- (void) setEndMany1 :(SODataV4_boolean)value;
- (void) setEndMany2 :(SODataV4_boolean)value;
- (void) setEndRole1 :(nullable NSString*)value;
- (void) setEndRole2 :(nullable NSString*)value;
- (void) setEndType1 :(nullable NSString*)value;
- (void) setEndType2 :(nullable NSString*)value;
- (void) setEndZero1 :(SODataV4_boolean)value;
- (void) setEndZero2 :(SODataV4_boolean)value;
- (void) setLocalName :(nonnull NSString*)value;
- (void) setOnDelete1 :(SODataV4_int)value;
- (void) setOnDelete2 :(SODataV4_int)value;
- (void) setPartner1 :(nullable NSString*)value;
- (void) setPartner2 :(nullable NSString*)value;
- (void) setPrincipalRole :(nullable NSString*)value;
- (void) setQualifiedName :(nonnull NSString*)value;
- (void) setReferentialConstraints :(nonnull SODataV4_StringMap*)value;
@property (nonatomic, readwrite, strong, nullable) NSString* dependentRole;
@property (nonatomic, readwrite) SODataV4_boolean endMany1;
@property (nonatomic, readwrite) SODataV4_boolean endMany2;
@property (nonatomic, readwrite, strong, nullable) NSString* endRole1;
@property (nonatomic, readwrite, strong, nullable) NSString* endRole2;
@property (nonatomic, readwrite, strong, nullable) NSString* endType1;
@property (nonatomic, readwrite, strong, nullable) NSString* endType2;
@property (nonatomic, readwrite) SODataV4_boolean endZero1;
@property (nonatomic, readwrite) SODataV4_boolean endZero2;
@property (nonatomic, readwrite, strong, nonnull) NSString* localName;
@property (nonatomic, readwrite) SODataV4_int onDelete1;
@property (nonatomic, readwrite) SODataV4_int onDelete2;
@property (nonatomic, readwrite, strong, nullable) NSString* partner1;
@property (nonatomic, readwrite, strong, nullable) NSString* partner2;
@property (nonatomic, readwrite, strong, nullable) NSString* principalRole;
@property (nonatomic, readwrite, strong, nonnull) NSString* qualifiedName;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_StringMap* referentialConstraints;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlAssociationMap_Entry_internal
#ifndef imported_SODataV4__CsdlAssociationMap_Entry_internal
#define imported_SODataV4__CsdlAssociationMap_Entry_public
/* internal */
/// @brief A key/value pair for map entries.
///
///
@interface SODataV4_CsdlAssociationMap_Entry : SODataV4_ObjectBase
{
    @private NSString* _Nonnull key_;
    @private SODataV4_CsdlAssociation* _Nonnull value_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlAssociationMap_Entry*) new;
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
- (void) setValue :(nonnull SODataV4_CsdlAssociation*)value;
/// @brief Map entry value.
///
///
- (nonnull SODataV4_CsdlAssociation*) value;
/// @brief Map entry key.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* key;
/// @brief Map entry value.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlAssociation* value;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlCompatibilityChecker_public
#define imported_SODataV4__CsdlCompatibilityChecker_public
/// @brief OData CSDL compatibility checker.
///
///
@interface SODataV4_CsdlCompatibilityChecker : SODataV4_ObjectBase
{
    @private SODataV4_CsdlDocument* _Nonnull oldMetadata_;
    @private SODataV4_CsdlDocument* _Nonnull newMetadata_;
    @private SODataV4_StringList* _Nonnull acceptChanges;
    @private SODataV4_ObjectList* _Nonnull applyRemovals;
    @private SODataV4_StringList* _Nonnull errorMessages;
}
- (nonnull id) init;
/// @brief Construct a CSDL compatibility checker.
///
///
/// @param oldMetadata Old service metadata.
/// @param newMetadata New service metadata.
/// @see `SODataV4_CsdlOption`.
+ (nonnull SODataV4_CsdlCompatibilityChecker*) new :(nonnull SODataV4_CsdlDocument*)oldMetadata :(nonnull SODataV4_CsdlDocument*)newMetadata;
/// @internal
///
- (void) _init :(nonnull SODataV4_CsdlDocument*)oldMetadata :(nonnull SODataV4_CsdlDocument*)newMetadata;
/// @brief Check if `SODataV4_CsdlCompatibilityChecker`.`newMetadata` is backwards-compatible with `SODataV4_CsdlCompatibilityChecker`.`oldMetadata`.
///
/// Adding structural/navigation properties, types and entity sets is backwards compatible.
- (void) check;
@end
#endif

#ifdef import_SODataV4__CsdlCompatibilityChecker_private
#ifndef imported_SODataV4__CsdlCompatibilityChecker_private
#define imported_SODataV4__CsdlCompatibilityChecker_private
@interface SODataV4_CsdlCompatibilityChecker (private)
- (void) acceptOrReject :(nonnull NSString*)message;
- (void) checkBase :(nonnull SODataV4_DataType*)forType :(nullable SODataV4_DataType*)oldBase :(nullable SODataV4_DataType*)newBase;
- (void) checkComplex :(nonnull SODataV4_ComplexType*)oldComplexType :(nonnull SODataV4_ComplexType*)newComplexType;
- (void) checkEntity :(nonnull SODataV4_EntityType*)oldEntityType :(nonnull SODataV4_EntityType*)newEntityType;
- (void) checkEntitySet :(nonnull SODataV4_EntitySet*)oldEntitySet :(nonnull SODataV4_EntitySet*)newEntitySet;
- (void) checkEnum :(nonnull SODataV4_EnumType*)oldEnumType :(nonnull SODataV4_EnumType*)newEnumType;
- (void) checkMethod :(nonnull SODataV4_DataMethod*)oldMethod :(nonnull SODataV4_DataMethod*)newMethod;
- (void) checkProperty :(nonnull SODataV4_StructureType*)parent :(nonnull SODataV4_Property*)oldProperty :(nonnull SODataV4_Property*)newProperty;
- (void) checkSimple :(nonnull SODataV4_SimpleType*)oldSimpleType :(nonnull SODataV4_SimpleType*)newSimpleType;
- (void) checkSingleton :(nonnull SODataV4_EntitySet*)oldEntitySet :(nonnull SODataV4_EntitySet*)newEntitySet;
- (void) checkStructure :(nonnull SODataV4_StructureType*)oldStructureType :(nonnull SODataV4_StructureType*)newStructureType;
- (nonnull NSString*) dataMethodKind :(nonnull SODataV4_DataMethod*)dataMethod;
- (nonnull NSString*) maybeOverloaded :(nonnull SODataV4_DataMethod*)dataMethod;
- (nonnull SODataV4_CsdlDocument*) newMetadata;
- (nonnull SODataV4_CsdlDocument*) oldMetadata;
- (void) setNewMetadata :(nonnull SODataV4_CsdlDocument*)value;
- (void) setOldMetadata :(nonnull SODataV4_CsdlDocument*)value;
- (nonnull NSString*) showTypeName :(nonnull SODataV4_DataType*)type :(SODataV4_boolean)isNullable;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* newMetadata;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* oldMetadata;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlDocument_public
#define imported_SODataV4__CsdlDocument_public
/// @brief Encapsulates the definitions from a parsed Open Data Protocol ([OData](http://odata.org/)) service metadata ([CSDL](http://docs.oasis-open.org/odata/odata/v4.0/os/part3-csdl/odata-v4.0-os-part3-csdl.html)) document.
///
///
/// @see `SODataV4_CsdlParser`.
@interface SODataV4_CsdlDocument : SODataV4_ObjectBase
{
    @private SODataV4_CsdlOwnerList* _Nonnull _owners_;
    @private SODataV4_boolean canChangeAnything_;
    @private SODataV4_boolean canRemoveAnything_;
    @private SODataV4_boolean hasGeneratedProxies_;
    @private SODataV4_boolean hasOpenEnumerations_;
    @private NSString* _Nullable proxyVersion_;
    @private SODataV4_int versionCode_;
    @private NSString* _Nonnull versionText_;
    @private NSString* _Nullable originalText_;
    @private NSString* _Nullable resolvedText_;
    @private SODataV4_DataSchema* _Nullable mainSchema_;
    @private SODataV4_EntityContainer* _Nullable defaultContainer_;
    @private SODataV4_boolean trackChanges_;
    @private SODataV4_StringMap* _Nonnull topAliases_;
    @private SODataV4_CsdlReferenceList* _Nonnull topReferences_;
    @private SODataV4_DataSchemaList* _Nonnull topSchemas_;
    @private SODataV4_DataSchemaMap* _Nonnull dataSchemas_;
    @private SODataV4_DataMethodMap* _Nonnull dataMethods_;
    @private SODataV4_DataTypeMap* _Nonnull builtinTypes_;
    @private SODataV4_SimpleTypeMap* _Nonnull simpleTypes_;
    @private SODataV4_EnumTypeMap* _Nonnull enumTypes_;
    @private SODataV4_ComplexTypeMap* _Nonnull complexTypes_;
    @private SODataV4_EntityTypeMap* _Nonnull entityTypes_;
    @private SODataV4_EntitySetMap* _Nonnull entitySets_;
    @private SODataV4_EntitySetMap* _Nonnull singletons_;
    @private SODataV4_AnnotationTermMap* _Nonnull annotationTerms_;
    @private SODataV4_PathAnnotationsMap* _Nonnull pathAnnotations_;
    @private SODataV4_EntityContainerMap* _Nonnull entityContainers_;
    @private SODataV4_StringMap* _Nonnull xmlNamespaces_;
    @private SODataV4_DataMethodMap* _Nonnull lookupMethods_;
    @private SODataV4_EntitySetMap* _Nonnull lookupSets_;
    @private SODataV4_EntitySetMap* _Nonnull lookupSingletons_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlDocument*) new;
/// @internal
///
- (void) _init;
/// @brief Register `owner` as an owner of this metadata document.
///
///
/// @param owner Metadata owner.
- (void) addOwner :(nonnull NSObject*)owner;
/// @brief Map of annotation terms defined by the CSDL.
///
///
- (nonnull SODataV4_AnnotationTermMap*) annotationTerms;
/// @brief Map of predefined CSDL data types.
///
///
- (nonnull SODataV4_DataTypeMap*) builtinTypes;
/// @brief Allows any model element to be changed in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability (depending on the changes) if the application uses proxy classes!
- (SODataV4_boolean) canChangeAnything;
/// @brief Allows any model element to be removed in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability unless the application checks `isRemoved` flags on model elements!
- (SODataV4_boolean) canRemoveAnything;
/// @brief Map of complex types defined by the CSDL.
///
///
- (nonnull SODataV4_ComplexTypeMap*) complexTypes;
/// @brief Map of data methods (actions, functions) defined by the CSDL.
///
///
- (nonnull SODataV4_DataMethodMap*) dataMethods;
/// @brief Map of data schemas defined by the CSDL.
///
///
- (nonnull SODataV4_DataSchemaMap*) dataSchemas;
/// @brief Default entity container defined by the CSDL (or `nil` if there are no containers defined).
///
///
- (nullable SODataV4_EntityContainer*) defaultContainer;
/// @brief Map of entity containers defined by the CSDL.
///
///
- (nonnull SODataV4_EntityContainerMap*) entityContainers;
/// @brief Map of entity sets defined by the CSDL.
///
///
- (nonnull SODataV4_EntitySetMap*) entitySets;
/// @brief Map of entity types defined by the CSDL.
///
///
- (nonnull SODataV4_EntityTypeMap*) entityTypes;
/// @brief Map of enum types defined by the CSDL.
///
///
- (nonnull SODataV4_EnumTypeMap*) enumTypes;
/// @return The metadata xml, excluding server-only elements.
/// @param alias Optional alias for the vocabulary defining the `ServerOnly` annotation.
/// @param xml Metadata XML.
+ (nonnull SODataV4_XmlDocument*) excludingServerOnlyElements :(nullable NSString*)alias :(nonnull SODataV4_XmlDocument*)xml;
/// @brief Lookup a complex type by qualified name. If the complex type does not exist it indicates a fundamental implementation problem,
///
/// therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up simplet types before calling this method like in the
/// following code snippet:
///
/// @return The complex type, which must exist.
/// @param name Name of the complex type to be returned.
/// 
/// #### Example checking if a complex type exists
/// 
/// ```` oc
/// - (void) checkComplexTypeExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.complexTypes has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.EventLocation"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getComplexType:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.EventLocation"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`complexTypes`, for looking up types that might not exist.
- (nonnull SODataV4_ComplexType*) getComplexType :(nonnull NSString*)name;
/// @brief Lookup a data method by qualified name (for function/action definitions) or by unqualified name (for function/action imports).
///
/// If the data method does not exist it indicates a fundamental implementation problem, therefore a non-catchable
/// `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up data methods before calling this method like in the
/// following code snippet:
///
/// @return The data method, which must exist.
/// @param name Name of the data method to be returned.
/// 
/// #### Example checking if a data method exists
/// 
/// ```` oc
/// - (void) checkDataMethodInCsdlDocumentExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.lookupMethods has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Person.UpdatePersonLastName"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getDataMethod:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Person.UpdatePersonLastName"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`dataMethods`, for looking up methods that might not exist.
- (nonnull SODataV4_DataMethod*) getDataMethod :(nonnull NSString*)name;
/// @brief Lookup a data schema by name. If the data schema does not exist it indicates a fundamental
///
/// implementation problem, therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up data schemas before calling this method like in the
/// following code snippet:
///
/// @return The data schema, which must exist.
/// @param name Name of the data schema to be returned.
/// 
/// #### Example checking if a data schema exists
/// 
/// ```` oc
/// - (void) checkDataSchemaExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.dataSchemas has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getDataSchema:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`dataSchemas`, for looking up schemas that might not exist.
- (nonnull SODataV4_DataSchema*) getDataSchema :(nonnull NSString*)name;
/// @brief Lookup an entity set (or singleton entity) by name. If the entity set does not exist it indicates a fundamental implementation problem,
///
/// therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up simplet types before calling this method like in the
/// following code snippet:
/// Note that OData singleton entities are represented by entity sets where `SODataV4_EntitySet`.`isSingleton` is `true`.
///
/// @return The entity set, which must exist.
/// @param name Name of the entity set to be returned.
/// 
/// #### Example checking if a entity set exists
/// 
/// ```` oc
/// - (void) checkEntitySetInCsdlDocumentExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.entitySets has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Airlines"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getEntitySet:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Airlines"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`entitySets`, for looking up sets that might not exist.
- (nonnull SODataV4_EntitySet*) getEntitySet :(nonnull NSString*)name;
/// @brief Lookup an entity type by qualified name. If the entity type does not exist it indicates a fundamental implementation problem,
///
/// therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up simplet types before calling this method like in the
/// following code snippet:
///
/// @return The entity type, which must exist.
/// @param name Name of the entity type to be returned.
/// 
/// #### Example checking if a entity type exists
/// 
/// ```` oc
/// - (void) checkEntityTypeExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.entityTypes has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Airport"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getEntityType:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Airport"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`entityTypes`, for looking up types that might not exist.
- (nonnull SODataV4_EntityType*) getEntityType :(nonnull NSString*)name;
/// @brief Lookup an enum type by qualified name. If the enum type does not exist it indicates a fundamental implementation problem,
///
/// therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up simplet types before calling this method like in the
/// following code snippet:
///
/// @return The enum type, which must exist.
/// @param name Name of the enum type to be returned.
/// 
/// #### Example checking if an enum type exists
/// 
/// ```` oc
/// - (void) checkEnumTypeExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.enumTypes has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.PersonGender"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getEnumType:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.PersonGender"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`enumTypes`, for looking up types that might not exist.
- (nonnull SODataV4_EnumType*) getEnumType :(nonnull NSString*)name;
/// @brief Return all the current registered owners of this metadata document.
///
///
- (nonnull SODataV4_ObjectList*) getOwners;
/// @brief Lookup a simple type by qualified name. If the simple type does not exist it indicates a fundamental implementation problem,
///
/// therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up simplet types before calling this method like in the
/// following code snippet:
///
/// @return The simple type, which must exist.
/// @param name Name of the simple type to be returned.
/// 
/// #### Example checking if a simple type exists
/// 
/// ```` oc
/// - (void) checkSimpleTypeExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.simpleTypes has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.MySimpleType"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getSimpleType:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.MySimpleType"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`simpleTypes`, for looking up types that might not exist.
- (nonnull SODataV4_SimpleType*) getSimpleType :(nonnull NSString*)name;
/// @brief Lookup a singleton entity by name. If the singleton entity does not exist it indicates a fundamental implementation problem,
///
/// therefore a non-catchable `FatalException` will be thrown, and the app intentionally crashes.
/// The reason behind this drastic behaviour is to avoid mismatch between server and client.
/// It is still possible to avoid the `FatalException` by looking up simplet types before calling this method like in the
/// following code snippet:
/// Note that OData singleton entities are represented by entity sets where `SODataV4_EntitySet`.`isSingleton` is `true`.
///
/// @return The entity set, which must exist.
/// @param name Name of the entity set to be returned.
/// 
/// #### Example checking if a ingleton entity exists
/// 
/// ```` oc
/// - (void) checkSingletonExistsExample
/// {
///     SODataV4_CsdlDocument* csdlDocument = self.service.metadata;
///     if ([csdlDocument.singletons has:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Container/Me"])
///     {
///         [SODataV4_Ignore valueOf_any:[csdlDocument getSingleton:@"Microsoft.OData.Service.Sample.TrippinInMemory.Models.Container/Me"]];
///     }
///     else
///     {
///     }
/// }
/// ````
/// @see `SODataV4_CsdlDocument`.`entitySets`, for looking up sets that might not exist.
- (nonnull SODataV4_EntitySet*) getSingleton :(nonnull NSString*)name;
/// @brief `true` if this metadata is associated with generated proxy classes. Defaults to `false` (generated proxies will override to `true`).
///
///
- (SODataV4_boolean) hasGeneratedProxies;
/// @brief Allows addition of enumeration members in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability if the application uses proxy classes without "-open:enumerations".
- (SODataV4_boolean) hasOpenEnumerations;
/// @internal
///
- (nonnull SODataV4_DataMethodMap*) lookupMethods;
/// @internal
///
- (nonnull SODataV4_EntitySetMap*) lookupSets;
/// @internal
///
- (nonnull SODataV4_EntitySetMap*) lookupSingletons;
/// @brief Main data schema defined by the CSDL (or `nil` if there are no schemas defined).
///
///
- (nullable SODataV4_DataSchema*) mainSchema;
/// @brief Original CSDL (XML) text.
///
///
/// @see CsdlOption.RETAIN_ORIGINAL_TEXT.
- (nullable NSString*) originalText;
/// @brief Map of path annotations defined by the CSDL (where the `TargetPath` does not directly reference a model element).
///
///
- (nonnull SODataV4_PathAnnotationsMap*) pathAnnotations;
/// @brief If this metadata was parsed by generated proxy classes, then the framework version that generated the proxies. Otherwise `nil`.
///
///
- (nullable NSString*) proxyVersion;
/// @brief Unregister `owner` as an owner of this metadata document.
///
///
/// @param owner Metadata owner.
- (void) removeOwner :(nonnull NSObject*)owner;
/// @brief Resolve the `EntityValue.entitySet` of `entity' (if it is not already set).
///
///
/// @throw `SODataV4_DataServiceException` if `entity.entitySet` is not set, and is not unique (i.e. multiple entity sets use the same entity type)
/// or there is a circular dependency in related entities (parent entity is set as child as well)
/// or an entity is resolved multiple times meaning that it is embedded as child more than once.
/// @param entity Entity to resolve.
- (void) resolveEntity :(nonnull SODataV4_EntityValue*)entity;
/// @brief Resolved CSDL (XML) text, with inline references and expanded aliases.
///
///
/// @see CsdlOption.RETAIN_RESOLVED_TEXT.
- (nullable NSString*) resolvedText;
/// @brief Allows any model element to be changed in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability (depending on the changes) if the application uses proxy classes!
- (void) setCanChangeAnything :(SODataV4_boolean)value;
/// @brief Allows any model element to be removed in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability unless the application checks `isRemoved` flags on model elements!
- (void) setCanRemoveAnything :(SODataV4_boolean)value;
/// @brief Default entity container defined by the CSDL (or `nil` if there are no containers defined).
///
///
- (void) setDefaultContainer :(nullable SODataV4_EntityContainer*)value;
/// @brief `true` if this metadata is associated with generated proxy classes. Defaults to `false` (generated proxies will override to `true`).
///
///
- (void) setHasGeneratedProxies :(SODataV4_boolean)value;
/// @brief Allows addition of enumeration members in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability if the application uses proxy classes without "-open:enumerations".
- (void) setHasOpenEnumerations :(SODataV4_boolean)value;
/// @brief Main data schema defined by the CSDL (or `nil` if there are no schemas defined).
///
///
- (void) setMainSchema :(nullable SODataV4_DataSchema*)value;
/// @brief Original CSDL (XML) text.
///
///
/// @see CsdlOption.RETAIN_ORIGINAL_TEXT.
- (void) setOriginalText :(nullable NSString*)value;
/// @brief If this metadata was parsed by generated proxy classes, then the framework version that generated the proxies. Otherwise `nil`.
///
///
- (void) setProxyVersion :(nullable NSString*)value;
/// @brief Resolved CSDL (XML) text, with inline references and expanded aliases.
///
///
/// @see CsdlOption.RETAIN_RESOLVED_TEXT.
- (void) setResolvedText :(nullable NSString*)value;
/// @brief Is change tracking explicitly enabled for one or more entity sets?
///
///
- (void) setTrackChanges :(SODataV4_boolean)value;
/// @brief Code for the OData version, e.g. 400.
///
/// If the OData version is considered as a decimal number (e.g. 4.0), then multiplying by 100 will give the code (e.g. 400).
///
/// @see `SODataV4_DataVersion`.
- (void) setVersionCode :(SODataV4_int)value;
/// @brief Text for the OData version, e.g. "4.0".
///
///
- (void) setVersionText :(nonnull NSString*)value;
/// @brief Map of simple types defined by the CSDL.
///
///
- (nonnull SODataV4_SimpleTypeMap*) simpleTypes;
/// @brief Map of singletons defined by the CSDL.
///
/// Each singleton is represented by an `SODataV4_EntitySet` with `isSingleton == true`
- (nonnull SODataV4_EntitySetMap*) singletons;
/// @brief Top-level aliases defined by the CSDL.
///
/// This is a map from schema namespace to schema alias.
- (nonnull SODataV4_StringMap*) topAliases;
/// @brief Top-level references defined by the CSDL.
///
///
- (nonnull SODataV4_CsdlReferenceList*) topReferences;
/// @brief Top-level schemas defined by the CSDL.
///
///
- (nonnull SODataV4_DataSchemaList*) topSchemas;
/// @brief Is change tracking explicitly enabled for one or more entity sets?
///
///
- (SODataV4_boolean) trackChanges;
/// @brief Code for the OData version, e.g. 400.
///
/// If the OData version is considered as a decimal number (e.g. 4.0), then multiplying by 100 will give the code (e.g. 400).
///
/// @see `SODataV4_DataVersion`.
- (SODataV4_int) versionCode;
/// @brief Text for the OData version, e.g. "4.0".
///
///
- (nonnull NSString*) versionText;
/// @brief Map of XML namespaces defined by the CSDL.
///
///
- (nonnull SODataV4_StringMap*) xmlNamespaces;
/// @brief Map of annotation terms defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_AnnotationTermMap* annotationTerms;
/// @brief Map of predefined CSDL data types.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_DataTypeMap* builtinTypes;
/// @brief Allows any model element to be changed in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability (depending on the changes) if the application uses proxy classes!
@property (nonatomic, readwrite) SODataV4_boolean canChangeAnything;
/// @brief Allows any model element to be removed in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability unless the application checks `isRemoved` flags on model elements!
@property (nonatomic, readwrite) SODataV4_boolean canRemoveAnything;
/// @brief Map of complex types defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_ComplexTypeMap* complexTypes;
/// @brief Map of data methods (actions, functions) defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_DataMethodMap* dataMethods;
/// @brief Map of data schemas defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_DataSchemaMap* dataSchemas;
/// @brief Default entity container defined by the CSDL (or `nil` if there are no containers defined).
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_EntityContainer* defaultContainer;
/// @brief Map of entity containers defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_EntityContainerMap* entityContainers;
/// @brief Map of entity sets defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_EntitySetMap* entitySets;
/// @brief Map of entity types defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_EntityTypeMap* entityTypes;
/// @brief Map of enum types defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_EnumTypeMap* enumTypes;
/// @brief `true` if this metadata is associated with generated proxy classes. Defaults to `false` (generated proxies will override to `true`).
///
///
@property (nonatomic, readwrite) SODataV4_boolean hasGeneratedProxies;
/// @brief Allows addition of enumeration members in the latest service metadata before calling `DataService.refreshMetadata`. Defaults to `false`.
///
/// Warning: enabling this option can result in application instability if the application uses proxy classes without "-open:enumerations".
@property (nonatomic, readwrite) SODataV4_boolean hasOpenEnumerations;
/// @internal
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_DataMethodMap* lookupMethods;
/// @internal
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_EntitySetMap* lookupSets;
/// @internal
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_EntitySetMap* lookupSingletons;
/// @brief Main data schema defined by the CSDL (or `nil` if there are no schemas defined).
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_DataSchema* mainSchema;
/// @brief Original CSDL (XML) text.
///
///
/// @see CsdlOption.RETAIN_ORIGINAL_TEXT.
@property (nonatomic, readwrite, strong, nullable) NSString* originalText;
/// @brief Map of path annotations defined by the CSDL (where the `TargetPath` does not directly reference a model element).
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_PathAnnotationsMap* pathAnnotations;
/// @brief If this metadata was parsed by generated proxy classes, then the framework version that generated the proxies. Otherwise `nil`.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* proxyVersion;
/// @brief Resolved CSDL (XML) text, with inline references and expanded aliases.
///
///
/// @see CsdlOption.RETAIN_RESOLVED_TEXT.
@property (nonatomic, readwrite, strong, nullable) NSString* resolvedText;
/// @brief Map of simple types defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_SimpleTypeMap* simpleTypes;
/// @brief Map of singletons defined by the CSDL.
///
/// Each singleton is represented by an `SODataV4_EntitySet` with `isSingleton == true`
@property (nonatomic, readonly, strong, nonnull) SODataV4_EntitySetMap* singletons;
/// @brief Top-level aliases defined by the CSDL.
///
/// This is a map from schema namespace to schema alias.
@property (nonatomic, readonly, strong, nonnull) SODataV4_StringMap* topAliases;
/// @brief Top-level references defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_CsdlReferenceList* topReferences;
/// @brief Top-level schemas defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_DataSchemaList* topSchemas;
/// @brief Is change tracking explicitly enabled for one or more entity sets?
///
///
@property (nonatomic, readwrite) SODataV4_boolean trackChanges;
/// @brief Code for the OData version, e.g. 400.
///
/// If the OData version is considered as a decimal number (e.g. 4.0), then multiplying by 100 will give the code (e.g. 400).
///
/// @see `SODataV4_DataVersion`.
@property (nonatomic, readwrite) SODataV4_int versionCode;
/// @brief Text for the OData version, e.g. "4.0".
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* versionText;
/// @brief Map of XML namespaces defined by the CSDL.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_StringMap* xmlNamespaces;
@end
#endif

#ifdef import_SODataV4__CsdlDocument_private
#ifndef imported_SODataV4__CsdlDocument_private
#define imported_SODataV4__CsdlDocument_private
@interface SODataV4_CsdlDocument (private)
- (SODataV4_boolean) checkAnnotation :(nonnull NSString*)target :(nonnull SODataV4_Annotation*)annotation :(nonnull SODataV4_DataType*)expected;
+ (SODataV4_boolean) dropServerOnlyElements :(nullable NSString*)vocabularyAlias :(nonnull SODataV4_XmlElement*)element;
+ (nonnull SODataV4_CsdlOwner*) _new1 :(nullable NSObject*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlDocument_internal
#ifndef imported_SODataV4__CsdlDocument_internal
#define imported_SODataV4__CsdlDocument_internal
@interface SODataV4_CsdlDocument (internal)
- (nonnull SODataV4_CsdlOwnerList*) _owners;
/// @brief Sets isResolved flag to false for all of the entities on navigation paths.
///
///
- (void) clearResolvedEntity :(nonnull SODataV4_EntityValue*)entity;
/// @brief Resolve the `EntityValue.entitySet` of `entity' (if it is not already set).
///
///
/// @throw `SODataV4_DataServiceException` if `entity.entitySet` is not set, and is not unique (i.e. multiple entity sets use the same entity type)
/// or there is a circular dependency in related entities (parent entity is set as child as well)
/// or an entity is resolved multiple times meaning that it is embedded as child more than once.
/// @param entity Entity to resolve.
- (void) internalResolveEntity :(nonnull SODataV4_EntityValue*)entity;
- (void) set_owners :(nonnull SODataV4_CsdlOwnerList*)value;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlOwnerList* _owners;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlFetcher_public
#define imported_SODataV4__CsdlFetcher_public
/// @brief Callback which can locate and fetch the text of an Open Data Protocol ([OData](http://odata.org/)) service metadata ([CSDL](http://docs.oasis-open.org/odata/odata/v4.0/os/part3-csdl/odata-v4.0-os-part3-csdl.html)) document.
///
///
/// @see `SODataV4_CsdlParser`.`csdlFetcher`.
@interface SODataV4_CsdlFetcher : SODataV4_ObjectBase
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlFetcher*) new;
/// @internal
///
- (void) _init;
/// @return `true` if this fetcher accepts a location (or associated namespace), meaning that a `SODataV4_CsdlFetcher`.`fetch` call would be expected to succeed.
/// This function returns `false` by default for OData standard vocabulary namespaces (Org.OData.*), otherwise this function returns `true`.
/// Override this function in subclasses to return `true` only for those well-known location/namespace values that the fetcher expects that it can resolve to a service metadata document.
/// @param uri Location of document to be read.
/// @param ns Namespace for schema to be read.
- (SODataV4_boolean) accept :(nonnull NSString*)uri :(nonnull NSString*)ns;
/// @return The XML content of a service metadata document at the specified URL.
/// @throw `SODataV4_CsdlException` if the document cannot be fetched.
/// @param uri Location of document to be read.
/// @param ns Namespace for schema to be read.
- (nonnull NSString*) fetch :(nonnull NSString*)uri :(nonnull NSString*)ns;
/// @return `true` if this fetcher wants to force the `SODataV4_CsdlParser` to ignore a reference.
/// This function returns `false` by default.
/// Override this function in subclasses to return `true` only for those well-known location/namespace values that the fetcher wants to suppress fetching for.
/// @param uri Location of document to be read.
/// @param ns Namespace for schema to be read.
- (SODataV4_boolean) ignore :(nonnull NSString*)uri :(nonnull NSString*)ns;
@end
#endif

#ifndef imported_SODataV4__CsdlIdentifier_public
#define imported_SODataV4__CsdlIdentifier_public
/// @internal
///
@interface SODataV4_CsdlIdentifier : SODataV4_ObjectBase
{
}
/// @brief Fix an invalid OData identifier (if it is invalid).
///
/// Invalid leading/trailing characters will be removed.
/// All other invalid characters will be changed to "_".
///
/// @return Fixed identifier (or original identifier, if it was already valid).
/// @param name Element identifier.
+ (nonnull NSString*) fix :(nonnull NSString*)name;
/// @brief Fix an invalid OData namespace (if it is invalid).
///
/// Forward slashes will be changed to ".".
/// Invalid leading/trailing characters will be removed.
/// All other invalid characters will be changed to "_".
///
/// @return Fixed namespace (or original identifier, if it was already valid).
/// @param name Namespace identifier.
+ (nonnull NSString*) fixNamespace :(nonnull NSString*)name;
@end
#endif

#ifdef import_SODataV4__CsdlIdentifier_private
#ifndef imported_SODataV4__CsdlIdentifier_private
#define imported_SODataV4__CsdlIdentifier_private
@interface SODataV4_CsdlIdentifier (private)
/// @brief See OData 4.0 odata-abnf-construction-rules.txt (or http://docs.oasis-open.org/odata/odata/v4.0/os/schemas/edm.xsd).
///
/// identifierCharacter = ALPHA / "_" / DIGIT; plus Unicode characters from the categories L, Nl, Nd, Mn, Mc, Pc, or Cf
///
/// @return `true` if `value` is a valid OData identifier non-leading character.
/// @param value Character value.
+ (SODataV4_boolean) isValidCharacter :(SODataV4_int)value;
/// @brief See OData 4.0 odata-abnf-construction-rules.txt (or http://docs.oasis-open.org/odata/odata/v4.0/os/schemas/edm.xsd).
///
/// identifierLeadingCharacter = ALPHA / "_"; plus Unicode characters from the categories L or Nl
///
/// @return `true` if `value` is a valid OData identifier leading character.
/// @param value Character value.
+ (SODataV4_boolean) isValidLeadingCharacter :(SODataV4_int)value;
+ (nonnull NSString*) seeTypeDefinition;
+ (nonnull NSString*) showInvalidCharacter :(SODataV4_int)value;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlIdentifier_internal
#ifndef imported_SODataV4__CsdlIdentifier_internal
#define imported_SODataV4__CsdlIdentifier_internal
@interface SODataV4_CsdlIdentifier (internal)
/// @internal
///
+ (void) check :(nonnull SODataV4_CsdlParser*)parser :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)attribute :(nonnull NSString*)name;
+ (void) check :(nonnull SODataV4_CsdlParser*)parser :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)attribute :(nonnull NSString*)name :(nullable NSString*)nameInError;
+ (void) checkNamespace :(nonnull SODataV4_CsdlParser*)parser :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)attribute :(nonnull NSString*)name;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlOption_public
#define imported_SODataV4__CsdlOption_public
/// @brief Bitmask flags for `SODataV4_CsdlParser`.`csdlOptions`.
///
///
@interface SODataV4_CsdlOption : SODataV4_ObjectBase
{
}
#define SODataV4_CsdlOption_PROCESS_MIXED_VERSIONS 1
#define SODataV4_CsdlOption_RETAIN_ORIGINAL_TEXT 2
#define SODataV4_CsdlOption_RETAIN_RESOLVED_TEXT 4
#define SODataV4_CsdlOption_IGNORE_EXTERNAL_REFERENCES 8
#define SODataV4_CsdlOption_IGNORE_INTERNAL_REFERENCES 16
#define SODataV4_CsdlOption_IGNORE_STANDARD_REFERENCES 32
#define SODataV4_CsdlOption_IGNORE_ALL_REFERENCES 56
#define SODataV4_CsdlOption_IGNORE_EDM_ANNOTATIONS 64
#define SODataV4_CsdlOption_IGNORE_XML_ANNOTATIONS 128
#define SODataV4_CsdlOption_IGNORE_ALL_ANNOTATIONS 192
#define SODataV4_CsdlOption_IGNORE_UNDEFINED_TERMS 256
#define SODataV4_CsdlOption_RESOLVE_UNDEFINED_TERMS 512
#define SODataV4_CsdlOption_WARN_ABOUT_UNDEFINED_TERMS 1024
#define SODataV4_CsdlOption_TRACE_PARSING_OF_ELEMENTS 2048
#define SODataV4_CsdlOption_DISABLE_NAME_VALIDATION 4096
#define SODataV4_CsdlOption_ALLOW_CASE_CONFLICTS 8192
#define SODataV4_CsdlOption_DEFAULT_VARIABLE_SCALE 32768
#define SODataV4_CsdlOption_DEFAULT_VARIABLE_SRID 65536
#define SODataV4_CsdlOption_DISABLE_FACET_WARNINGS 131072
#define SODataV4_CsdlOption_STRICT_FACET_WARNINGS 262144
#define SODataV4_CsdlOption_DISABLE_LOGGING_OF_ERRORS 524288
#define SODataV4_CsdlOption_DISABLE_LOGGING_OF_WARNINGS 1048576
#define SODataV4_CsdlOption_FAIL_IF_PROVIDER_INCOMPATIBLE 2097152
#define SODataV4_CsdlOption_WARN_IF_PROVIDER_INCOMPATIBLE 4194304
#define SODataV4_CsdlOption_LOG_WITH_UNQUALIFIED_FILE_NAMES 8388608
#define SODataV4_CsdlOption_EXCLUDE_SERVER_ONLY_ELEMENTS 16777216
@end
#endif

#ifdef import_SODataV4__CsdlOwner_internal
#ifndef imported_SODataV4__CsdlOwner_internal
#define imported_SODataV4__CsdlOwner_public
/* internal */
@interface SODataV4_CsdlOwner : SODataV4_ObjectBase
{
    @private NSObject* _Nullable __weak reference_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlOwner*) new;
/// @internal
///
- (void) _init;
- (nullable NSObject*) reference;
- (void) setReference :(nullable NSObject*)value;
@property (nonatomic, readwrite, weak, nullable) NSObject* reference;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlParser_public
#define imported_SODataV4__CsdlParser_public
/// @brief Parser for Open Data Protocol ([OData](http://odata.org/)) service metadata documents ([CSDL](http://docs.oasis-open.org/odata/odata/v4.0/os/part3-csdl/odata-v4.0-os-part3-csdl.html)).
///
/// A new parser should be created for each `SODataV4_CsdlParser`.`parse` call. A parser should not be shared by multiple threads.
@interface SODataV4_CsdlParser : SODataV4_ObjectBase
{
    @private SODataV4_Logger* _Nonnull logger_;
    @private SODataV4_StringMap* _Nonnull aliasToNamespace_;
    @private SODataV4_StringSet* _Nonnull alreadyLoaded_;
    @private SODataV4_AnnotationToResolveList* _Nonnull annotationsToResolve;
    @private SODataV4_boolean badRecursion;
    @private NSString* _Nullable baseURL;
    @private SODataV4_CsdlAssociationMap* _Nonnull csdlAssociations_;
    @private SODataV4_EntityType* _Nullable currentEntity;
    @private SODataV4_DataSchema* _Nonnull currentSchema_;
    @private SODataV4_CsdlDocument* _Nonnull document_;
    @private SODataV4_XmlElementMap* _Nonnull entitySetElements;
    @private SODataV4_XmlElementMap* _Nonnull entityTypeElements;
    @private SODataV4_ComplexTypeMap* _Nonnull finalComplex_;
    @private SODataV4_EntityContainerMap* _Nonnull finalContainer_;
    @private SODataV4_EntityTypeMap* _Nonnull finalEntity_;
    @private SODataV4_boolean fixedPoint;
    @private SODataV4_XmlElementMap* _Nonnull importedMethodElements;
    @private SODataV4_int inferenceLevel;
    @private SODataV4_ComplexValueList* _Nonnull inferredRecords;
    @private SODataV4_EntityContainer* _Nullable lastContainer;
    @private NSString* _Nullable myURL;
    @private SODataV4_int phase;
    @private SODataV4_DataTypeMap* _Nonnull primitives;
    @private SODataV4_XmlElement* _Nonnull rootElement_;
    @private SODataV4_XmlElementList* _Nonnull includeReferences_;
    @private SODataV4_DataSchemaList* _Nonnull includeSchemas_;
    @private SODataV4_CsdlFetcher* _Nullable csdlFetcher_;
    @private SODataV4_int csdlOptions_;
    @private SODataV4_boolean logErrors_;
    @private SODataV4_boolean logWarnings_;
    @private SODataV4_boolean traceRequests_;
    @private SODataV4_boolean excludeServerOnly_;
    @private NSString* _Nullable serviceName_;
    @private SODataV4_StringSet* _Nonnull allVersions;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlParser*) new;
/// @internal
///
- (void) _init;
/// @brief A callback which will be used to resolve any CSDL Reference that is encountered during parsing, in order to fetch the referenced metadata.
///
/// Must be set before `SODataV4_CsdlParser`.`parse` is called, or else any CSDL Reference that is encountered during parsing will result in a `SODataV4_CsdlException` being thrown.
- (nullable SODataV4_CsdlFetcher*) csdlFetcher;
/// @brief A bitmask of CSDL parser options.
///
///
/// @see `SODataV4_CsdlOption`.
- (SODataV4_int) csdlOptions;
/// @brief Skip server-only elements in the csdl xml to be parsed and added to CsdlDocument.
///
/// An element is server-only if it contains the <Annotation Term="com.sap.cloud.server.odata.sql.v1.ServerOnly"/> child element.
- (SODataV4_boolean) excludeServerOnly;
/// @internal
///
- (void) includeNamespace :(nonnull NSString*)ns;
/// @brief Add to `SODataV4_CsdlParser`.`includeReferences` a supplementary CSDL edmx:Reference (with embedded edmx:Include).
///
/// Call this function before `SODataV4_CsdlParser`.`parse` if the document to be parsed is missing expected edmx:Reference elements for well-known schemas.
/// This function generates an edmx:Reference with a fabricated "Uri" (with value "include/`ns`.xml").
/// It can be used together with a `SODataV4_CsdlParser`.`csdlFetcher` which resolves documents either by fabricated location (include/`ns`.xml) or by namespace (`ns`).
///
/// @param ns For the "Namespace" attribute of "edmx:Include".
/// @param alias (optional) For the "Alias" attribute of "edmx:Include".
/// @see `SODataV4_CsdlParser`.`csdlOptions`, `SODataV4_CsdlParser`.`includeReference`.
- (void) includeNamespace :(nonnull NSString*)ns :(nullable NSString*)alias;
/// @internal
///
- (void) includeReference :(nonnull NSString*)uri :(nonnull NSString*)ns;
/// @brief Add to `SODataV4_CsdlParser`.`includeReferences` a supplementary CSDL edmx:Reference (with embedded edmx:Include).
///
/// Call this function before `SODataV4_CsdlParser`.`parse` if the document to be parsed is missing expected edmx:Reference elements for well-known schemas.
/// This function generates an edmx:Reference with a caller-specified "Uri".
/// It can be used together with a `SODataV4_CsdlParser`.`csdlFetcher` which resolves documents either by caller-specified location (`uri`) or by namespace (`ns`).
///
/// @param uri For the "Uri" attribute of "edmx:Reference".
/// @param ns For the "Namespace" attribute of "edmx:Include".
/// @param alias (optional) For the "Alias" attribute of "edmx:Include".
/// @see `SODataV4_CsdlParser`.`csdlOptions`, `SODataV4_CsdlParser`.`includeNamespace`.
- (void) includeReference :(nonnull NSString*)uri :(nonnull NSString*)ns :(nullable NSString*)alias;
/// @brief Include the definitions of a pre-parsed schema into the document to be parsed.
///
/// Call this function before `SODataV4_CsdlParser`.`parse` if the document to be parsed has an edmx:Reference element for a well-known schema,
/// and the pre-parsed schema should be used rather than loading the referenced schema over the network.
///
/// @param schema Pre-parsed schema.
- (void) includeSchema :(nonnull SODataV4_DataSchema*)schema;
/// @brief Should parser errors be logged before they are thrown?
///
///
- (SODataV4_boolean) logErrors;
/// @brief Should parser warnings be logged?
///
///
- (SODataV4_boolean) logWarnings;
/// @brief Parse the text of an Open Data Protocol ([OData](http://odata.org/)) service metadata ([CSDL](http://docs.oasis-open.org/odata/odata/v4.0/os/part3-csdl/odata-v4.0-os-part3-csdl.html)) document.
///
/// Supports OData versions 1.0 to 4.0.
///
/// @return Parsed CSDL document.
/// @param text Text of the service metadata document.
/// @param url URL of the service metadata document. Used for resolving relative URLs if any CSDL Reference is encountered during parsing. May also be included in exception messages.
- (nonnull SODataV4_CsdlDocument*) parse :(nonnull NSString*)text :(nonnull NSString*)url;
/// @internal
///
- (nonnull SODataV4_CsdlDocument*) parseInProxy :(nonnull NSString*)text :(nonnull NSString*)url;
/// @internal
///
+ (nullable NSString*) resolveToLocalSAPVocabulary :(nonnull NSString*)ns;
/// @brief Data service name. If data metrics are required, this property should be set before `SODataV4_CsdlParser`.`parse` is called,
///
/// so that all `SODataV4_DataMethod` and `SODataV4_EntitySet`
/// in the parsed document will have appropriately named metrics.
- (nullable NSString*) serviceName;
/// @brief A callback which will be used to resolve any CSDL Reference that is encountered during parsing, in order to fetch the referenced metadata.
///
/// Must be set before `SODataV4_CsdlParser`.`parse` is called, or else any CSDL Reference that is encountered during parsing will result in a `SODataV4_CsdlException` being thrown.
- (void) setCsdlFetcher :(nullable SODataV4_CsdlFetcher*)value;
/// @brief A bitmask of CSDL parser options.
///
///
/// @see `SODataV4_CsdlOption`.
- (void) setCsdlOptions :(SODataV4_int)value;
/// @brief Skip server-only elements in the csdl xml to be parsed and added to CsdlDocument.
///
/// An element is server-only if it contains the <Annotation Term="com.sap.cloud.server.odata.sql.v1.ServerOnly"/> child element.
- (void) setExcludeServerOnly :(SODataV4_boolean)value;
/// @brief Should parser errors be logged before they are thrown?
///
///
- (void) setLogErrors :(SODataV4_boolean)value;
/// @brief Should parser warnings be logged?
///
///
- (void) setLogWarnings :(SODataV4_boolean)value;
/// @brief Data service name. If data metrics are required, this property should be set before `SODataV4_CsdlParser`.`parse` is called,
///
/// so that all `SODataV4_DataMethod` and `SODataV4_EntitySet`
/// in the parsed document will have appropriately named metrics.
- (void) setServiceName :(nullable NSString*)value;
/// @brief Should parsing requests be traced?
///
///
- (void) setTraceRequests :(SODataV4_boolean)value;
/// @brief Should parsing requests be traced?
///
///
- (SODataV4_boolean) traceRequests;
/// @brief A callback which will be used to resolve any CSDL Reference that is encountered during parsing, in order to fetch the referenced metadata.
///
/// Must be set before `SODataV4_CsdlParser`.`parse` is called, or else any CSDL Reference that is encountered during parsing will result in a `SODataV4_CsdlException` being thrown.
@property (nonatomic, readwrite, strong, nullable) SODataV4_CsdlFetcher* csdlFetcher;
/// @brief A bitmask of CSDL parser options.
///
///
/// @see `SODataV4_CsdlOption`.
@property (nonatomic, readwrite) SODataV4_int csdlOptions;
/// @brief Skip server-only elements in the csdl xml to be parsed and added to CsdlDocument.
///
/// An element is server-only if it contains the <Annotation Term="com.sap.cloud.server.odata.sql.v1.ServerOnly"/> child element.
@property (nonatomic, readwrite) SODataV4_boolean excludeServerOnly;
/// @brief Should parser errors be logged before they are thrown?
///
///
@property (nonatomic, readwrite) SODataV4_boolean logErrors;
/// @brief Should parser warnings be logged?
///
///
@property (nonatomic, readwrite) SODataV4_boolean logWarnings;
/// @brief Data service name. If data metrics are required, this property should be set before `SODataV4_CsdlParser`.`parse` is called,
///
/// so that all `SODataV4_DataMethod` and `SODataV4_EntitySet`
/// in the parsed document will have appropriately named metrics.
@property (nonatomic, readwrite, strong, nullable) NSString* serviceName;
/// @brief Should parsing requests be traced?
///
///
@property (nonatomic, readwrite) SODataV4_boolean traceRequests;
@end
#endif

#ifdef import_SODataV4__CsdlParser_private
#ifndef imported_SODataV4__CsdlParser_private
#define imported_SODataV4__CsdlParser_private
@interface SODataV4_CsdlParser (private)
+ (nonnull SODataV4_TypeFacets*) DEFAULT_FACETS;
- (nonnull NSString*) abbreviatedElement :(nonnull SODataV4_XmlElement*)element;
- (void) addPrimitiveType :(nonnull SODataV4_DataTypeMap*)map :(nonnull NSString*)name :(SODataV4_int)code;
- (nonnull SODataV4_DataType*) adjustIfInteger :(nonnull SODataV4_DataType*)type :(SODataV4_int)scale;
- (nonnull SODataV4_StringMap*) aliasToNamespace;
- (nonnull SODataV4_StringSet*) alreadyLoaded;
- (void) checkForClash :(nonnull SODataV4_XmlElement*)parent :(nonnull NSString*)nameAttribute;
- (nullable NSString*) checkPartnerPath :(nonnull SODataV4_StringList*)path :(nonnull SODataV4_StructureType*)type;
- (void) checkPartnerPaths;
- (void) checkPathBindings;
- (void) copyDataMethod :(nonnull SODataV4_DataMethod*)source :(nonnull SODataV4_DataMethod*)target;
- (void) copyDataMethods;
/// @brief Return a PropertyList whose capacity equals its length (reduces memory utilization).
///
///
- (nonnull SODataV4_PropertyList*) copyPropertyList :(nonnull SODataV4_PropertyList*)list;
- (nonnull SODataV4_CsdlAssociationMap*) csdlAssociations;
- (nonnull SODataV4_DataSchema*) currentSchema;
- (nonnull SODataV4_CsdlDocument*) document;
- (nonnull NSString*) fetch :(nonnull NSString*)uri :(nonnull NSString*)ns;
- (nonnull SODataV4_ComplexTypeMap*) finalComplex;
- (nonnull SODataV4_EntityContainerMap*) finalContainer;
- (nonnull SODataV4_EntityTypeMap*) finalEntity;
- (void) fixInferredRecords;
- (nonnull NSString*) getBoundName :(nonnull SODataV4_XmlElement*)element :(SODataV4_boolean)isAction;
- (nonnull SODataV4_PropertyList*) getCollectionProperties :(nonnull SODataV4_PropertyList*)list;
- (nonnull SODataV4_PropertyList*) getComplexProperties :(nonnull SODataV4_PropertyList*)list;
- (nullable NSString*) getOptionalAttribute :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
- (nullable SODataV4_XmlElement*) getOptionalElement :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
- (nonnull SODataV4_DataTypeMap*) getPrimitiveTypes;
- (nonnull NSString*) getRequiredAttribute :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
- (nonnull SODataV4_XmlElement*) getRequiredElement :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
- (nonnull SODataV4_Property*) getRequiredProperty :(nonnull SODataV4_StructureType*)type :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_PropertyList*) getStreamProperties :(nonnull SODataV4_PropertyList*)list;
- (nullable NSString*) getValidAttribute :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name;
- (nonnull SODataV4_DataType*) inferCollectionType :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)refKind :(nonnull NSString*)refName;
- (nonnull SODataV4_ComplexType*) inferComplexType :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)defaultName;
- (nonnull SODataV4_EnumType*) inferEnumType :(nonnull NSString*)value :(nullable SODataV4_XmlElement*)element;
- (nonnull SODataV4_DataType*) inferTermType :(nonnull NSString*)name :(nonnull NSString*)value :(nonnull SODataV4_AnnotationTerm*)term :(nullable SODataV4_XmlElement*)element;
- (SODataV4_boolean) isCustomAttribute :(nonnull SODataV4_XmlAttribute*)attribute;
- (SODataV4_boolean) isEdmNamespace :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmNamespaceV2 :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmNamespaceV4 :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmOrEdmxNamespace :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmOrEdmxNamespaceV2 :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmOrEdmxNamespaceV4 :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmxNamespace :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmxNamespaceV2 :(nonnull NSString*)uri;
- (SODataV4_boolean) isEdmxNamespaceV4 :(nonnull NSString*)uri;
- (nonnull SODataV4_Logger*) logger;
- (void) markForeignKeys;
- (nullable SODataV4_Annotation*) parseAnnotation :(nonnull SODataV4_XmlElement*)element;
- (void) parseAnnotationTerm :(nonnull SODataV4_AnnotationTerm*)term :(nonnull SODataV4_XmlElement*)element;
- (void) parseAnnotationsElement :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_CsdlAssociation*) parseAssociation :(nonnull SODataV4_XmlElement*)element;
- (void) parseAssociationSet :(nonnull SODataV4_XmlElement*)element;
- (SODataV4_boolean) parseBooleanFacet :(nonnull NSString*)name :(nonnull NSString*)value :(nonnull SODataV4_XmlElement*)element;
- (void) parseComplexType :(nonnull SODataV4_ComplexType*)complexType :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_Annotation*) parseCustomAttribute :(nonnull SODataV4_XmlAttribute*)attribute;
- (void) parseDataMethod :(nonnull SODataV4_DataMethod*)method :(nonnull SODataV4_XmlElement*)element :(SODataV4_boolean)isAction;
- (void) parseDataServices :(nonnull SODataV4_XmlElement*)element;
- (nullable SODataV4_DataValue*) parseDefaultValue :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_DataType*)type :(nullable NSString*)value;
- (void) parseEdmx :(nonnull SODataV4_XmlElement*)edmx;
- (void) parseEntityContainer :(nonnull SODataV4_EntityContainer*)entityContainer :(nonnull SODataV4_XmlElement*)element;
- (void) parseEntitySet :(nonnull SODataV4_EntitySet*)entitySet :(nonnull SODataV4_XmlElement*)element;
- (void) parseEntityType :(nonnull SODataV4_EntityType*)entityType :(nonnull SODataV4_XmlElement*)element;
- (void) parseEnumType :(nonnull SODataV4_EnumType*)nt :(nonnull SODataV4_XmlElement*)element;
- (nullable SODataV4_TypeFacets*) parseFacets :(nonnull SODataV4_XmlElement*)element :(nullable SODataV4_DataType*)dt;
- (void) parseInclude :(nonnull SODataV4_XmlElement*)element :(nullable SODataV4_CsdlReference*)topReference;
- (void) parseIncludeAnnotations :(nonnull SODataV4_XmlElement*)element;
- (SODataV4_int) parseIntFacet :(nonnull NSString*)name :(nonnull NSString*)value :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_Property*) parseNavigationProperty :(nonnull SODataV4_XmlElement*)element;
- (SODataV4_int) parseOnDelete :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_Parameter*) parseParameter :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_StringList*) parsePath :(nonnull NSString*)path;
- (nonnull SODataV4_Property*) parseProperty :(nonnull SODataV4_XmlElement*)element;
- (nonnull NSString*) parsePropertyRef :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_StringList*) parsePropertyRefsIn :(nonnull SODataV4_XmlElement*)element;
- (void) parseReference :(nonnull SODataV4_XmlElement*)element;
- (void) parseSchema :(nonnull SODataV4_XmlElement*)element;
- (void) parseSimpleType :(nonnull SODataV4_SimpleType*)simpleType :(nonnull SODataV4_XmlElement*)element;
- (nullable SODataV4_DataValue*) parseTermElement :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_DataType*)type;
- (nullable SODataV4_DataValue*) parseTermLiteral :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)name :(nonnull SODataV4_DataType*)type :(nonnull NSString*)value;
- (void) processAnnotations :(nonnull SODataV4_AnnotationMap*)map :(nonnull SODataV4_XmlElement*)element;
- (void) processInPhases :(nonnull SODataV4_XmlElement*)edmx;
- (void) registerNamespaces :(nonnull SODataV4_XmlElement*)element;
- (nonnull NSString*) resolveAlias :(nonnull NSString*)name;
- (void) resolveAnnotation :(nonnull SODataV4_XmlElement*)element :(nonnull SODataV4_AnnotationTerm*)term :(nonnull SODataV4_Annotation*)ann;
- (void) resolveAnnotations;
- (nonnull SODataV4_ComplexType*) resolveComplexType :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_DataType*) resolveDataType :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_EntitySet*) resolveEntitySet :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_EntityType*) resolveEntityType :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (nonnull SODataV4_EnumType*) resolveEnumType :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (void) resolveImmutables;
- (void) resolveReference :(nonnull SODataV4_XmlElement*)element;
- (void) resolveReferences :(nonnull SODataV4_XmlElement*)root :(nonnull NSString*)url;
- (nonnull NSObject*) resolveTargetPath :(nonnull SODataV4_StringList*)segments :(nonnull SODataV4_XmlElement*)element;
/// @internal
///
- (nullable SODataV4_AnnotationTerm*) resolveTerm :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
- (nullable SODataV4_AnnotationTerm*) resolveTerm :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element :(SODataV4_boolean)required;
- (nonnull SODataV4_XmlElement*) rootElement;
- (void) setAliasToNamespace :(nonnull SODataV4_StringMap*)value;
- (void) setAlreadyLoaded :(nonnull SODataV4_StringSet*)value;
- (void) setCsdlAssociations :(nonnull SODataV4_CsdlAssociationMap*)value;
- (void) setCurrentSchema :(nonnull SODataV4_DataSchema*)value;
- (void) setDocument :(nonnull SODataV4_CsdlDocument*)value;
- (void) setFinalComplex :(nonnull SODataV4_ComplexTypeMap*)value;
- (void) setFinalContainer :(nonnull SODataV4_EntityContainerMap*)value;
- (void) setFinalEntity :(nonnull SODataV4_EntityTypeMap*)value;
- (void) setLogger :(nonnull SODataV4_Logger*)value;
- (void) setPartnerPaths;
- (void) setRootElement :(nonnull SODataV4_XmlElement*)value;
+ (nonnull SODataV4_Logger*) staticLogger;
/// @internal
///
- (void) traceElement :(nonnull SODataV4_XmlElement*)element;
- (void) traceElement :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)caller;
- (void) validateNamespaces :(nonnull SODataV4_XmlElement*)element;
- (void) warnUnqualified :(nonnull SODataV4_DataType*)type :(nonnull NSString*)name :(nonnull SODataV4_XmlElement*)element;
+ (nonnull SODataV4_DataMethod*) _new1 :(nonnull NSString*)p1 :(SODataV4_boolean)p2 :(nonnull NSString*)p3 :(SODataV4_boolean)p4;
+ (nonnull SODataV4_ComplexType*) _new2 :(nonnull NSString*)p1 :(nonnull SODataV4_PropertyList*)p2 :(nonnull NSString*)p3 :(nonnull SODataV4_PropertyList*)p4 :(nonnull SODataV4_PropertyList*)p5 :(nonnull SODataV4_PropertyList*)p6 :(nonnull SODataV4_PropertyList*)p7 :(nonnull SODataV4_PropertyMap*)p8 :(SODataV4_boolean)p9;
+ (nonnull SODataV4_EnumType*) _new3 :(nonnull NSString*)p1 :(nonnull SODataV4_EnumValueMap*)p2 :(nonnull SODataV4_EnumValueList*)p3 :(nonnull NSString*)p4 :(nonnull SODataV4_DataType*)p5 :(SODataV4_boolean)p6;
+ (nonnull SODataV4_Annotation*) _new4 :(nullable NSString*)p1 :(nonnull SODataV4_AnnotationTerm*)p2;
+ (nonnull SODataV4_AnnotationToResolve*) _new5 :(nonnull SODataV4_Annotation*)p1 :(nonnull SODataV4_AnnotationTerm*)p2 :(nonnull SODataV4_XmlElement*)p3;
+ (nonnull SODataV4_PathAnnotations*) _new6 :(nonnull SODataV4_DataPath*)p1;
+ (nonnull SODataV4_CsdlAssociation*) _new7 :(nonnull NSString*)p1;
+ (nonnull SODataV4_AnnotationTerm*) _new8 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(nonnull SODataV4_DataType*)p3 :(nullable NSString*)p4;
+ (nonnull SODataV4_Annotation*) _new9 :(nonnull SODataV4_AnnotationTerm*)p1 :(nullable SODataV4_DataValue*)p2;
+ (nonnull SODataV4_DataMethod*) _new10 :(nonnull NSString*)p1 :(SODataV4_boolean)p2 :(SODataV4_boolean)p3 :(SODataV4_boolean)p4 :(nonnull NSString*)p5 :(nonnull NSString*)p6 :(SODataV4_boolean)p7 :(nonnull NSString*)p8 :(SODataV4_boolean)p9 :(nonnull SODataV4_ParameterList*)p10 :(nonnull SODataV4_DataType*)p11;
+ (nonnull SODataV4_StreamProperty*) _new11 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull NSString*)p3 :(SODataV4_int)p4 :(nonnull SODataV4_DataType*)p5;
+ (nonnull SODataV4_Property*) _new12 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(SODataV4_int)p3 :(nonnull SODataV4_DataType*)p4 :(SODataV4_int)p5;
+ (nonnull SODataV4_CsdlReference_Include*) _new13 :(nonnull NSString*)p1 :(nullable NSString*)p2;
+ (nonnull SODataV4_CsdlNavigation*) _new14 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(nonnull NSString*)p3 :(nonnull SODataV4_DataType*)p4 :(nonnull NSString*)p5 :(SODataV4_int)p6 :(nonnull SODataV4_StringMap*)p7;
+ (nonnull SODataV4_NavigationProperty*) _new15 :(nonnull NSString*)p1 :(nullable NSString*)p2 :(nonnull SODataV4_DataType*)p3 :(SODataV4_int)p4;
+ (nonnull SODataV4_Parameter*) _new16 :(SODataV4_int)p1 :(nonnull NSString*)p2 :(nonnull SODataV4_DataType*)p3;
+ (nonnull SODataV4_StreamProperty*) _new17 :(nonnull NSString*)p1 :(nonnull SODataV4_DataType*)p2;
+ (nonnull SODataV4_Property*) _new18 :(nonnull NSString*)p1 :(nonnull SODataV4_DataType*)p2;
+ (nonnull SODataV4_Property*) _new19 :(nonnull NSString*)p1 :(nonnull SODataV4_DataType*)p2 :(SODataV4_int)p3;
+ (nonnull SODataV4_CsdlReference*) _new20 :(nonnull NSString*)p1 :(SODataV4_int)p2;
+ (nonnull SODataV4_DataSchema*) _new21 :(nonnull NSString*)p1 :(nullable NSString*)p2;
+ (nonnull SODataV4_SimpleType*) _new22 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_EnumType*) _new23 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_ComplexType*) _new24 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_EntityType*) _new25 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_AnnotationTerm*) _new26 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_DataMethod*) _new27 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_EntityContainer*) _new28 :(nonnull NSString*)p1 :(nonnull NSString*)p2;
+ (nonnull SODataV4_EntitySet*) _new29 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(SODataV4_boolean)p3;
+ (nonnull SODataV4_DataMethod*) _new30 :(nonnull NSString*)p1 :(SODataV4_boolean)p2 :(nonnull NSString*)p3;
+ (nonnull SODataV4_Property*) _new31 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(SODataV4_int)p3 :(nonnull SODataV4_DataType*)p4;
+ (nonnull SODataV4_AnnotationTerm*) _new32 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(nonnull SODataV4_DataType*)p3;
+ (nonnull SODataV4_AnnotationTerm*) _new33 :(nonnull NSString*)p1 :(nonnull NSString*)p2 :(nonnull SODataV4_DataType*)p3 :(SODataV4_boolean)p4;
#define SODataV4_CsdlParser_ABSTRACT @"Abstract"
#define SODataV4_CsdlParser_ACTION @"Action"
#define SODataV4_CsdlParser_ACTION_IMPORT @"ActionImport"
#define SODataV4_CsdlParser_ALIAS @"Alias"
#define SODataV4_CsdlParser_ANNOTATION @"Annotation"
#define SODataV4_CsdlParser_ANNOTATIONS @"Annotations"
#define SODataV4_CsdlParser_ASSOCIATION @"Association"
#define SODataV4_CsdlParser_ASSOCIATION_SET @"AssociationSet"
#define SODataV4_CsdlParser_BAG @"Bag"
#define SODataV4_CsdlParser_BASE_TYPE @"BaseType"
#define SODataV4_CsdlParser_CASCADE @"Cascade"
#define SODataV4_CsdlParser_COLLECTION @"Collection"
#define SODataV4_CsdlParser_COLLECTION_KIND @"CollectionKind"
#define SODataV4_CsdlParser_COMPLEX_TYPE @"ComplexType"
#define SODataV4_CsdlParser_CONTAINS_TARGET @"ContainsTarget"
#define SODataV4_CsdlParser_DATA_SERVICE_VERSION @"DataServiceVersion"
#define SODataV4_CsdlParser_DATA_SERVICES @"DataServices"
#define SODataV4_CsdlParser_DEPENDENT @"Dependent"
#define SODataV4_CsdlParser_END @"End"
#define SODataV4_CsdlParser_ENTITY_CONTAINER @"EntityContainer"
#define SODataV4_CsdlParser_ENTITY_SET @"EntitySet"
#define SODataV4_CsdlParser_ENTITY_TYPE @"EntityType"
#define SODataV4_CsdlParser_ENUM_MEMBER @"EnumMember"
#define SODataV4_CsdlParser_ENUM_TYPE @"EnumType"
#define SODataV4_CsdlParser_ERROR_URL @"$URL"
#define SODataV4_CsdlParser_EXTENDS @"Extends"
#define SODataV4_CsdlParser_FIXED @"Fixed"
#define SODataV4_CsdlParser_FROM_ROLE @"FromRole"
#define SODataV4_CsdlParser_FUNCTION @"Function"
#define SODataV4_CsdlParser_FUNCTION_IMPORT @"FunctionImport"
#define SODataV4_CsdlParser_INCLUDE @"Include"
#define SODataV4_CsdlParser_INCLUDE_ANNOTATIONS @"IncludeAnnotations"
#define SODataV4_CsdlParser_IS_BOUND @"IsBound"
#define SODataV4_CsdlParser_KEY @"Key"
#define SODataV4_CsdlParser_LIST @"List"
#define SODataV4_CsdlParser_MEMBER @"Member"
#define SODataV4_CsdlParser_MODE @"Mode"
#define SODataV4_CsdlParser_MULTIPLICITY @"Multiplicity"
#define SODataV4_CsdlParser_NAME @"Name"
#define SODataV4_CsdlParser_NAMESPACE @"Namespace"
#define SODataV4_CsdlParser_NAVIGATION_PROPERTY @"NavigationProperty"
#define SODataV4_CsdlParser_NAVIGATION_PROPERTY_BINDING @"NavigationPropertyBinding"
#define SODataV4_CsdlParser_NONE @"None"
#define SODataV4_CsdlParser_NULLABLE @"Nullable"
#define SODataV4_CsdlParser_ON_DELETE @"OnDelete"
#define SODataV4_CsdlParser_OPEN_TYPE @"OpenType"
#define SODataV4_CsdlParser_PARAMETER @"Parameter"
#define SODataV4_CsdlParser_PARTNER @"Partner"
#define SODataV4_CsdlParser_PATH @"Path"
#define SODataV4_CsdlParser_PRINCIPAL @"Principal"
#define SODataV4_CsdlParser_PROPERTY @"Property"
#define SODataV4_CsdlParser_PROPERTY_REF @"PropertyRef"
#define SODataV4_CsdlParser_PROPERTY_VALUE @"PropertyValue"
#define SODataV4_CsdlParser_QUALIFIER @"Qualifier"
#define SODataV4_CsdlParser_RECORD @"Record"
#define SODataV4_CsdlParser_REFERENCE @"Reference"
#define SODataV4_CsdlParser_REFERENCED_PROPERTY @"ReferencedProperty"
#define SODataV4_CsdlParser_REFERENTIAL_CONSTRAINT @"ReferentialConstraint"
#define SODataV4_CsdlParser_RELATIONSHIP @"Relationship"
#define SODataV4_CsdlParser_RETURN_TYPE @"ReturnType"
#define SODataV4_CsdlParser_ROLE @"Role"
#define SODataV4_CsdlParser_SCHEMA @"Schema"
#define SODataV4_CsdlParser_SET_DEFAULT @"SetDefault"
#define SODataV4_CsdlParser_SET_NULL @"SetNull"
#define SODataV4_CsdlParser_SINGLETON @"Singleton"
#define SODataV4_CsdlParser_TARGET @"Target"
#define SODataV4_CsdlParser_TERM @"Term"
#define SODataV4_CsdlParser_TO_ROLE @"ToRole"
#define SODataV4_CsdlParser_TOP_LEVEL @"$TopLevel"
#define SODataV4_CsdlParser_TYPE @"Type"
#define SODataV4_CsdlParser_TYPE_DEFINITION @"TypeDefinition"
#define SODataV4_CsdlParser_TYPE_REF @"TypeRef"
#define SODataV4_CsdlParser_UNDERLYING_TYPE @"UnderlyingType"
#define SODataV4_CsdlParser_URL_REF @"UrlRef"
#define SODataV4_CsdlParser_VALUE @"Value"
#define SODataV4_CsdlParser_VERSION @"Version"
#define SODataV4_CsdlParser_IGNORE @"ignore_"
#define SODataV4_CsdlParser_TEXT_FALSE @"false"
#define SODataV4_CsdlParser_TEXT_TRUE @"true"
#define SODataV4_CsdlParser_NS_EDMX_V2 @"http://schemas.microsoft.com/ado/2007/06/edmx"
#define SODataV4_CsdlParser_NS_EDMX_V4 @"http://docs.oasis-open.org/odata/ns/edmx"
#define SODataV4_CsdlParser_MINIMUM_PHASE 1
#define SODataV4_CsdlParser_MAXIMUM_PHASE 12
#define SODataV4_CsdlParser_DEFINE_SCHEMAS 1
#define SODataV4_CsdlParser_DEFINE_ASSOCIATIONS 2
#define SODataV4_CsdlParser_DEFINE_TERMS 3
#define SODataV4_CsdlParser_DEFINE_TYPES 3
#define SODataV4_CsdlParser_DEFINE_METHODS 3
#define SODataV4_CsdlParser_PARSE_BASIC 4
#define SODataV4_CsdlParser_PARSE_TERMS 5
#define SODataV4_CsdlParser_PARSE_TYPES 6
#define SODataV4_CsdlParser_PARSE_METHODS 6
#define SODataV4_CsdlParser_DEFINE_CONTAINERS 7
#define SODataV4_CsdlParser_PARSE_CONTAINERS 8
#define SODataV4_CsdlParser_DEFINE_SETS 9
#define SODataV4_CsdlParser_PARSE_SETS 10
#define SODataV4_CsdlParser_PARSE_ASSOCIATIONS 11
#define SODataV4_CsdlParser_IMPORT_METHODS 11
#define SODataV4_CsdlParser_PARSE_ANNOTATIONS 12
#define SODataV4_CsdlParser_EMPTY_EDMX @"<Edmx/>"
#define SODataV4_CsdlParser_NAMESPACE_1 @"Org.OData.Aggregation.V1"
#define SODataV4_CsdlParser_NAMESPACE_2 @"Org.OData.Authorization.V1"
#define SODataV4_CsdlParser_NAMESPACE_3 @"Org.OData.Capabilities.V1"
#define SODataV4_CsdlParser_NAMESPACE_4 @"Org.OData.Core.V1"
#define SODataV4_CsdlParser_NAMESPACE_5 @"Org.OData.Measures.V1"
#define SODataV4_CsdlParser_NAMESPACE_6 @"Org.OData.Temporal.V1"
#define SODataV4_CsdlParser_NAMESPACE_7 @"Org.OData.Validation.V1"
#define SODataV4_CsdlParser_SAP_NAMESPACE_1 @"com.sap.vocabularies.Analytics.v1"
#define SODataV4_CsdlParser_SAP_NAMESPACE_2 @"com.sap.vocabularies.Common.v1"
#define SODataV4_CsdlParser_SAP_NAMESPACE_3 @"com.sap.vocabularies.Communication.v1"
#define SODataV4_CsdlParser_SAP_NAMESPACE_4 @"com.sap.vocabularies.Hierarchy.v1"
#define SODataV4_CsdlParser_SAP_NAMESPACE_5 @"com.sap.vocabularies.PersonalData.v1"
#define SODataV4_CsdlParser_SAP_NAMESPACE_6 @"com.sap.vocabularies.UI.v1"
#define SODataV4_CsdlParser_SERVER_NAMESPACE_1 @"com.sap.cloud.server.odata.security.v1"
#define SODataV4_CsdlParser_SERVER_NAMESPACE_2 @"com.sap.cloud.server.odata.sql.v1"
#define SODataV4_CsdlParser_VOCABULARY_1 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - OData Extension for Data Aggregation Version 4.0 Aggregation Vocabulary.\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This vocabulary defines terms to describe which data in a given entity model can be aggregated, and how.\r\n\r\n-->\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Namespace=\"Org.OData.Core.V1\" Alias=\"Core\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Aggregation.V1\" Alias=\"Aggregation\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms to describe which data in a given entity model can be aggregated, and how.</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggregation.V1.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"alternate\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggregation.V1.json\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://github.com/oasis-tcs/odata-vocabularies/blob/master/vocabularies/Org.OData.Aggregation.V1.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"ApplySupported\" Type=\"Aggregation.ApplySupportedType\" AppliesTo=\"EntityType ComplexType EntityContainer\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>This structured type or entity container supports the $apply system query option</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"ApplySupportedType\">\r\n        <Property Name=\"Transformations\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Transformations that can be used in $apply\" />\r\n        </Property>\r\n        <Property Name=\"CustomAggregationMethods\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Qualified names of custom aggregation methods that can be used in aggregate(...with...)\" />\r\n        </Property>\r\n        <Property Name=\"Rollup\" DefaultValue=\"MultipleHierarchies\" Type=\"Aggregation.RollupType\">\r\n          <Annotation Term=\"Core.Description\" String=\"The service supports rollup hierarchies in a groupby transformation\" />\r\n        </Property>\r\n        <Property Name=\"PropertyRestrictions\" DefaultValue=\"false\" Type=\"Edm.Boolean\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Only properties tagged as Groupable can be used in the groupby transformation, and only those tagged as Aggregatable can be used in the aggregate transformation\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"RollupType\">\r\n        <Annotation Term=\"Core.Description\" String=\"The number of rollup operators allowed in a groupby transformation\" />\r\n        <Member Name=\"None\">\r\n          <Annotation Term=\"Core.Description\" String=\"No rollup support\" />\r\n        </Member>\r\n        <Member Name=\"SingleHierarchy\">\r\n          <Annotation Term=\"Core.Description\" String=\"Only one rollup operator per groupby\" />\r\n        </Member>\r\n        <Member Name=\"MultipleHierarchies\">\r\n          <Annotation Term=\"Core.Description\" String=\"Full rollup support\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"Groupable\" Type=\"Core.Tag\" AppliesTo=\"Property NavigationProperty\" DefaultValue=\"true\">\r\n        <Annotation Term=\"Core.Description\" String=\"This property can be used in the groupby transformation\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Aggregatable\" Type=\"Core.Tag\" AppliesTo=\"Property NavigationProperty\" DefaultValue=\"true\">\r\n        <Annotation Term=\"Core.Description\" String=\"This property can be used in the aggregate transformation\" />\r\n      </Term>\r\n\r\n      <Term Name=\"CustomAggregate\" Type=\"Edm.String\" AppliesTo=\"EntityType ComplexType EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Dynamic property that can be used in the aggregate transformation\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"This term MUST be applied with a Qualifier, the Qualifier value is the name of the dynamic property. The value of the annotation MUST be the qualified name of a primitive type. The aggregated values will be of that type.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"ContextDefiningProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\" AppliesTo=\"Property Annotation\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The annotated property or custom aggregate is only well-defined in the context of these properties\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>The context-defining properties need either be part of the result entities, or be restricted to a single value by a pre-filter operation. Examples are postal codes within a country, or monetary amounts whose context is the unit of currency.</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"LeveledHierarchy\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\" AppliesTo=\"EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Defines a leveled hierarchy by defining an ordered list of properties in the hierarchy\" />\r\n      </Term>\r\n\r\n      <Term Name=\"RecursiveHierarchy\" Type=\"Aggregation.RecursiveHierarchyType\" AppliesTo=\"EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Defines a recursive hierarchy.\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"RecursiveHierarchyType\">\r\n        <Property Name=\"NodeProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the hierarchy node value\" />\r\n        </Property>\r\n        <Property Name=\"ParentNavigationProperty\" Type=\"Edm.NavigationPropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property for navigating to the parent node\" />\r\n        </Property>\r\n        <Property Name=\"DistanceFromRootProperty\" Type=\"Edm.PropertyPath\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the number of edges between the node and the root node\" />\r\n        </Property>\r\n        <Property Name=\"IsLeafProperty\" Type=\"Edm.PropertyPath\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.RequiresType\" String=\"Edm.Boolean\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Property indicating whether the node is a leaf of the hierarchy\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Function Name=\"isroot\" IsBound=\"true\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Returns true, if and only if the value of the node property of the specified hierarchy is the root of the hierarchy\" />\r\n        <Parameter Name=\"Entity\" Type=\"Edm.EntityType\" Nullable=\"false\" />\r\n        <Parameter Name=\"Hierarchy\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <ReturnType Type=\"Edm.Boolean\" Nullable=\"false\" />\r\n      </Function>\r\n\r\n      <Function Name=\"isdescendant\" IsBound=\"true\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Returns true, if and only if the value of the node property of the specified hierarchy is a descendant of the given parent node with a distance of less than or equal to the optionally specified maximum distance\" />\r\n        <Parameter Name=\"Entity\" Type=\"Edm.EntityType\" Nullable=\"false\" />\r\n        <Parameter Name=\"Hierarchy\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <Parameter Name=\"Node\" Type=\"Edm.PrimitiveType\" Nullable=\"false\" />\r\n        <Parameter Name=\"MaxDistance\" Type=\"Edm.Int16\" />\r\n        <ReturnType Type=\"Edm.Boolean\" Nullable=\"false\" />\r\n      </Function>\r\n\r\n      <Function Name=\"isancestor\" IsBound=\"true\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Returns true, if and only if the value of the node property of the specified hierarchy is an ancestor of the given child node with a distance of less than or equal to the optionally specified maximum distance\" />\r\n        <Parameter Name=\"Entity\" Type=\"Edm.EntityType\" Nullable=\"false\" />\r\n        <Parameter Name=\"Hierarchy\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <Parameter Name=\"Node\" Type=\"Edm.PrimitiveType\" Nullable=\"false\" />\r\n        <Parameter Name=\"MaxDistance\" Type=\"Edm.Int16\" />\r\n        <ReturnType Type=\"Edm.Boolean\" Nullable=\"false\" />\r\n      </Function>\r\n\r\n      <Function Name=\"issibling\" IsBound=\"true\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Returns true, if and only if the value of the node property of the specified hierarchy has the same parent node as the specified node\" />\r\n        <Parameter Name=\"Entity\" Type=\"Edm.EntityType\" Nullable=\"false\" />\r\n        <Parameter Name=\"Hierarchy\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <Parameter Name=\"Node\" Type=\"Edm.PrimitiveType\" Nullable=\"false\" />\r\n        <ReturnType Type=\"Edm.Boolean\" Nullable=\"false\" />\r\n      </Function>\r\n\r\n      <Function Name=\"isleaf\" IsBound=\"true\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Returns true, if and only if the value of the node property of the specified hierarchy has no descendants\" />\r\n        <Parameter Name=\"Entity\" Type=\"Edm.EntityType\" Nullable=\"false\" />\r\n        <Parameter Name=\"Hierarchy\" Type=\"Edm.String\" Nullable=\"false\" />\r\n        <ReturnType Type=\"Edm.Boolean\" Nullable=\"false\" />\r\n      </Function>\r\n\r\n      <Term Name=\"AvailableOnAggregates\" Type=\"Aggregation.AvailableOnAggregatesType\" AppliesTo=\"Action Function\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"This action or function is available on aggregated entities if the RequiredProperties are still defined\" />\r\n      </Term>\r\n      <ComplexType Name=\"AvailableOnAggregatesType\">\r\n        <Property Name=\"RequiredProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Properties required to apply this action or function\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_VOCABULARY_2 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - None\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This document contains terms for describing a web authorization flow.\r\n\r\n-->\r\n<edmx:Edmx Version=\"4.0\" xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Namespace=\"Org.OData.Core.V1\" Alias=\"Core\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Authorization.V1\" Alias=\"Auth\">\r\n      <Annotation Term=\"Core.Description\" String=\"The Authorization Vocabulary provides terms for describing authorization requirements of the service\" />\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"alternate\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.json\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://github.com/oasis-tcs/odata-vocabularies/blob/master/vocabularies/Org.OData.Authorization.V1.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"SecuritySchemes\" Type=\"Collection(Auth.SecurityScheme)\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"At least one of the specified security schemes are required to make a request against the service\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"SecurityScheme\">\r\n        <Property Name=\"Authorization\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"The name of a required authorization scheme\" />\r\n        </Property>\r\n        <Property Name=\"RequiredScopes\" Type=\"Collection(Edm.String)\">\r\n          <Annotation Term=\"Core.Description\" String=\"The names of scopes required from this authorization scheme\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Authorizations\" Type=\"Collection(Auth.Authorization)\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Lists the methods supported by the service to authorize access\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"Authorization\" Abstract=\"true\">\r\n        <Annotation Term=\"Core.Description\" String=\"Base type for all Authorization types\" />\r\n        <Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Name that can be used to reference the authorization scheme\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Description of the authorization scheme\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"OpenIDConnect\" BaseType=\"Auth.Authorization\">\r\n        <Property Name=\"IssuerUrl\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Issuer location for the OpenID Provider. Configuration information can be obtained by appending `/.well-known/openid-configuration` to this Url.\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"Http\" BaseType=\"Auth.Authorization\">\r\n        <Property Name=\"Scheme\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"HTTP Authorization scheme to be used in the Authorization header, as per RFC7235\" />\r\n        </Property>\r\n        <Property Name=\"BearerFormat\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Format of the bearer token\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"OAuthAuthorization\" BaseType=\"Auth.Authorization\" Abstract=\"true\">\r\n        <Property Name=\"Scopes\" Type=\"Collection(Auth.AuthorizationScope)\">\r\n          <Annotation Term=\"Core.Description\" String=\"Available scopes\" />\r\n        </Property>\r\n        <Property Name=\"RefreshUrl\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Refresh Url\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"OAuth2ClientCredentials\" BaseType=\"Auth.OAuthAuthorization\">\r\n        <Property Name=\"TokenUrl\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Token Url\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"OAuth2Implicit\" BaseType=\"Auth.OAuthAuthorization\">\r\n        <Property Name=\"AuthorizationUrl\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Authorization URL\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"OAuth2Password\" BaseType=\"Auth.OAuthAuthorization\">\r\n        <Property Name=\"TokenUrl\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Token Url\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"OAuth2AuthCode\" BaseType=\"Auth.OAuthAuthorization\">\r\n        <Property Name=\"AuthorizationUrl\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Authorization URL\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"TokenUrl\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Token Url\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"AuthorizationScope\">\r\n        <Property Name=\"Scope\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Scope name\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Description of the scope\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"ApiKey\" BaseType=\"Auth.Authorization\">\r\n        <Property Name=\"KeyName\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"The name of the header or query parameter\" />\r\n        </Property>\r\n        <Property Name=\"Location\" Type=\"Auth.KeyLocation\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Whether the API Key is passed in the header or as a query option\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"KeyLocation\">\r\n        <Member Name=\"Header\">\r\n          <Annotation Term=\"Core.Description\" String=\"API Key is passed in the header\" />\r\n        </Member>\r\n        <Member Name=\"QueryOption\">\r\n          <Annotation Term=\"Core.Description\" String=\"API Key is passed as a query option\" />\r\n        </Member>\r\n        <Member Name=\"Cookie\">\r\n          <Annotation Term=\"Core.Description\" String=\"API Key is passed as a cookie\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_VOCABULARY_3 @"﻿<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - OData Version 4.0 Vocabulary components: OData Capabilities Vocabulary.\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This document contains terms describing capabilities of an OData service.\r\n\r\n-->\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml\">\r\n    <edmx:Include Alias=\"Validation\" Namespace=\"Org.OData.Validation.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Capabilities.V1\" Alias=\"Capabilities\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms describing capabilities of a service</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"alternate\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.json\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://github.com/oasis-tcs/odata-vocabularies/blob/master/vocabularies/Org.OData.Capabilities.V1.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.LongDescription\">\r\n        <String>\r\nThere are some capabilities which are strongly recommended for services to support even\r\nthough they are optional. Support for $top and $skip is a good example as\r\nsupporting these query options helps with performance of a service and are essential. Such\r\ncapabilities are assumed to be default capabilities of an OData service even in\r\nthe case that a capabilities annotation doesn’t exist. Capabilities annotations are\r\nmainly expected to be used to explicitly specify that a service doesn’t support such\r\ncapabilities. Capabilities annotations can as well be used to declaratively\r\nspecify the support of such capabilities.\r\n\r\nOn the other hand, there are some capabilities that a service may choose to support or\r\nnot support and in varying degrees. $filter and $orderby are such good examples.\r\nThis vocabulary aims to define terms to specify support or no support for such\r\ncapabilities.\r\n\r\nA service is assumed to support by default the following capabilities even though an\r\nannotation doesn’t exist:\r\n- Countability ($count)\r\n- Client pageability ($top, $skip)\r\n- Expandability ($expand)\r\n- Indexability by key\r\n- Batch support ($batch)\r\n- Navigability of navigation properties\r\n\r\nA service is expected to support the following capabilities. If not supported, the\r\nservice is expected to call out the restrictions using annotations:\r\n- Filterability ($filter)\r\n- Sortability ($orderby)\r\n- Queryability of top level entity sets\r\n- Query functions\r\n\r\nA client cannot assume that a service supports certain capabilities. A client can try, but\r\nit needs to be prepared to handle an error in case the following capabilities are not\r\nsupported:\r\n- Insertability\r\n- Updatability\r\n- Deletability\r\n        </String>\r\n      </Annotation>\r\n\r\n      <!-- Conformance Level -->\r\n\r\n      <Term Name=\"ConformanceLevel\" Type=\"Capabilities.ConformanceLevelType\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"The conformance level achieved by this service\" />\r\n      </Term>\r\n      <EnumType Name=\"ConformanceLevelType\">\r\n        <Member Name=\"Minimal\">\r\n          <Annotation Term=\"Core.Description\" String=\"Minimal conformance level\" />\r\n        </Member>\r\n        <Member Name=\"Intermediate\">\r\n          <Annotation Term=\"Core.Description\" String=\"Intermediate conformance level\" />\r\n        </Member>\r\n        <Member Name=\"Advanced\">\r\n          <Annotation Term=\"Core.Description\" String=\"Advanced conformance level\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <!-- Request Capabilities -->\r\n\r\n      <Term Name=\"SupportedFormats\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Media types of supported formats, including format parameters\" />\r\n        <Annotation Term=\"Core.IsMediaType\" />\r\n      </Term>\r\n\r\n      <Term Name=\"SupportedMetadataFormats\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Media types of supported formats for $metadata, including format parameters\" />\r\n        <Annotation Term=\"Core.IsMediaType\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AcceptableEncodings\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"List of acceptable compression methods for ($batch) requests, e.g. gzip\" />\r\n      </Term>\r\n\r\n      <!-- Supported Preferences -->\r\n\r\n      <Term Name=\"AsynchronousRequestsSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Service supports the asynchronous request preference\" />\r\n      </Term>\r\n\r\n      <Term Name=\"BatchContinueOnErrorSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Service supports the continue on error preference. Supports $batch requests. Services that apply the BatchContinueOnErrorSupported term should also specify the ContinueOnErrorSupported property from the BatchSupport term.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsolationSupported\" Type=\"Capabilities.IsolationLevel\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supported odata.isolation levels\" />\r\n      </Term>\r\n      <EnumType Name=\"IsolationLevel\" IsFlags=\"true\">\r\n        <Member Name=\"Snapshot\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"All data returned for a request, including multiple requests within a batch or results retrieved across multiple pages, will be consistent as of a single point in time\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"CrossJoinSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supports cross joins for the entity sets in this container\" />\r\n      </Term>\r\n\r\n      <Term Name=\"CallbackSupported\" Type=\"Capabilities.CallbackType\" AppliesTo=\"EntityContainer EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supports callbacks for the specified protocols\" />\r\n      </Term>\r\n      <ComplexType Name=\"CallbackType\">\r\n        <Property Name=\"CallbackProtocols\" Type=\"Collection(Capabilities.CallbackProtocol)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of supported callback protocols, e.g. `http` or `wss`\" />\r\n        </Property>\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A non-empty collection lists the full set of supported protocols. A empty collection means 'only HTTP is supported'\" />\r\n      </ComplexType>\r\n      <ComplexType Name=\"CallbackProtocol\">\r\n        <Property Name=\"Id\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Protocol Identifier\" />\r\n        </Property>\r\n        <Property Name=\"UrlTemplate\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"URL Template including parameters. Parameters are enclosed in curly braces {} as defined in RFC6570\" />\r\n        </Property>\r\n        <Property Name=\"DocumentationUrl\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Human readable description of the meaning of the URL Template parameters\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"ChangeTracking\" Type=\"Capabilities.ChangeTrackingType\" AppliesTo=\"EntityContainer EntitySet Singleton Function FunctionImport NavigationProperty\">\r\n        <Annotation Term=\"Core.Description\" String=\"Change tracking capabilities of this service or entity set\" />\r\n      </Term>\r\n      <ComplexType Name=\"ChangeTrackingType\">\r\n        <Property Name=\"Supported\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"This entity set supports the odata.track-changes preference\" />\r\n        </Property>\r\n        <Property Name=\"FilterableProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Change tracking supports filters on these properties\" />\r\n        </Property>\r\n        <Property Name=\"ExpandableProperties\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Change tracking supports these properties expanded\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <!--Query Capabilities -->\r\n\r\n      <Term Name=\"CountRestrictions\" Type=\"Capabilities.CountRestrictionsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on /$count path suffix and $count=true system query option\" />\r\n      </Term>\r\n      <ComplexType Name=\"CountRestrictionsType\">\r\n        <Property Name=\"Countable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Entities can be counted\" />\r\n        </Property>\r\n        <Property Name=\"NonCountableProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These collection properties do not allow /$count segments\" />\r\n        </Property>\r\n        <Property Name=\"NonCountableNavigationProperties\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These navigation properties do not allow /$count segments\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"NavigationRestrictions\" Type=\"Capabilities.NavigationRestrictionsType\" AppliesTo=\"EntitySet Singleton\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on navigating properties according to OData URL conventions\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Restrictions specified on an entity set are valid whether the request is directly to the entity set or through a navigation property bound to that entity set. Services can specify a different set of restrictions specific to a path, in which case the more specific restrictions take precedence.\" />\r\n      </Term>\r\n      <ComplexType Name=\"NavigationRestrictionsType\">\r\n        <Property Name=\"Navigability\" Type=\"Capabilities.NavigationType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supported Navigability\" />\r\n        </Property>\r\n        <Property Name=\"RestrictedProperties\" Type=\"Collection(Capabilities.NavigationPropertyRestriction)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of navigation properties with restrictions\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"NavigationPropertyRestriction\">\r\n        <Property Name=\"NavigationProperty\" Type=\"Edm.NavigationPropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"Navigation properties can be navigated\" />\r\n        </Property>\r\n        <Property Name=\"Navigability\" Type=\"Capabilities.NavigationType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Navigation properties can be navigated to this level\" />\r\n        </Property>\r\n        <Property Name=\"FilterFunctions\" Type=\"Collection(Edm.String)\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"List of functions and operators supported in $filter. If null, all functions and operators may be attempted.\" />\r\n        </Property>\r\n        <Property Name=\"FilterRestrictions\" Type=\"Capabilities.FilterRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on $filter expressions\" />\r\n        </Property>\r\n        <Property Name=\"SearchRestrictions\" Type=\"Capabilities.SearchRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on $search expressions\" />\r\n        </Property>\r\n        <Property Name=\"SortRestrictions\" Type=\"Capabilities.SortRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on $orderby expressions\" />\r\n        </Property>\r\n        <Property Name=\"TopSupported\" Type=\"Core.Tag\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supports $top\" />\r\n        </Property>\r\n        <Property Name=\"SkipSupported\" Type=\"Core.Tag\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supports $skip\" />\r\n        </Property>\r\n        <Property Name=\"IndexableByKey\" Type=\"Core.Tag\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supports key values according to OData URL conventions\" />\r\n        </Property>\r\n        <Property Name=\"InsertRestrictions\" Type=\"Capabilities.InsertRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on insert operations\" />\r\n        </Property>\r\n        <Property Name=\"DeepInsertSupport\" Type=\"Capabilities.DeepInsertSupportType\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Deep Insert Support of the annotated resource (the whole service, an entity set, or a collection-valued resource)\" />\r\n        </Property>\r\n        <Property Name=\"UpdateRestrictions\" Type=\"Capabilities.UpdateRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on update operations\" />\r\n        </Property>\r\n        <Property Name=\"DeleteRestrictions\" Type=\"Capabilities.DeleteRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on delete operations\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <EnumType Name=\"NavigationType\">\r\n        <Member Name=\"Recursive\">\r\n          <Annotation Term=\"Core.Description\" String=\"Navigation properties can be recursively navigated\" />\r\n        </Member>\r\n        <Member Name=\"Single\">\r\n          <Annotation Term=\"Core.Description\" String=\"Navigation properties can be navigated to a single level\" />\r\n        </Member>\r\n        <Member Name=\"None\">\r\n          <Annotation Term=\"Core.Description\" String=\"Navigation properties are not navigable\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"IndexableByKey\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supports key values according to OData URL conventions\" />\r\n      </Term>\r\n\r\n      <Term Name=\"TopSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supports $top\" />\r\n      </Term>\r\n      <Term Name=\"SkipSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supports $skip\" />\r\n      </Term>\r\n\r\n      <Term Name=\"BatchSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Supports $batch requests. Services that apply the BatchSupported term should also apply the more comprehensive BatchSupport term.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"BatchSupport\" Type=\"Capabilities.BatchSupportType\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Batch Support for the service\" />\r\n      </Term>\r\n      <ComplexType Name=\"BatchSupportType\">\r\n        <Property Name=\"Supported\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service supports requests to $batch\" />\r\n        </Property>\r\n        <Property Name=\"ContinueOnErrorSupported\" Type=\"Edm.Boolean\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service supports the continue on error preference\" />\r\n        </Property>\r\n        <Property Name=\"ReferencesInRequestBodiesSupported\" Type=\"Edm.Boolean\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service supports Content-ID referencing in request bodies\" />\r\n        </Property>\r\n        <Property Name=\"ReferencesAcrossChangeSetsSupported\" Type=\"Edm.Boolean\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service supports Content-ID referencing across change sets\" />\r\n        </Property>\r\n        <Property Name=\"EtagReferencesSupported\" Type=\"Edm.Boolean\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service supports referencing Etags from previous requests\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"FilterFunctions\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"List of functions and operators supported in $filter\" />\r\n      </Term>\r\n\r\n      <Term Name=\"FilterRestrictions\" Type=\"Capabilities.FilterRestrictionsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on $filter expressions\" />\r\n      </Term>\r\n      <ComplexType Name=\"FilterRestrictionsType\">\r\n        <Property Name=\"Filterable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"$filter is supported\" />\r\n        </Property>\r\n        <Property Name=\"RequiresFilter\" Type=\"Edm.Boolean\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"$filter is required\" />\r\n        </Property>\r\n        <Property Name=\"RequiredProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"These properties must be specified in the $filter clause (properties of derived types are not allowed here)\" />\r\n        </Property>\r\n        <Property Name=\"NonFilterableProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These structural properties cannot be used in $filter expressions\" />\r\n        </Property>\r\n        <Property Name=\"FilterExpressionRestrictions\" Type=\"Collection(Capabilities.FilterExpressionRestrictionType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These properties only allow a subset of expressions\" />\r\n        </Property>\r\n        <Property Name=\"MaxLevels\" Type=\"Edm.Int32\" DefaultValue=\"-1\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"The maximum number of levels (including recursion) that can be traversed in a $filter expression. A value of -1 indicates there is no restriction.\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"FilterExpressionRestrictionType\">\r\n        <Property Name=\"Property\" Type=\"Edm.PropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to the restricted property\" />\r\n        </Property>\r\n        <Property Name=\"AllowedExpressions\" Type=\"Capabilities.FilterExpressionType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Allowed subset of expressions\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <TypeDefinition Name=\"FilterExpressionType\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Validation.AllowedValues\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"SingleValue\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Property can be used in a single eq clause\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"MultiValue\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Property can be used in a single in clause\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"SingleRange\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Property can be used in at most one ge and/or one le clause, separated by and\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"SearchExpression\" />\r\n              <Annotation Term=\"Core.Description\" String=\"String property can be used as first operand in startswith, endswith, and contains clauses\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"MultiRange\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Property can be compared to a union of one or more closed, half-open, or open intervals\" />\r\n              <Annotation Term=\"Core.LongDescription\"\r\n                String=\"The filter expression for this property consists of one or more interval expressions combined by OR. A single interval expression is either a single comparison of the property and a literal value with eq, le, lt, ge, or gt, or pair of boundaries combined by AND and enclosed in parentheses. The lower boundary is either ge or gt, the upper boundary either le or lt.\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"MultiRangeOrSearchExpression\" />\r\n              <Annotation Term=\"Core.Description\"\r\n                String=\"Property can be compared to a union of zero or more closed, half-open, or open intervals plus zero or more simple string patterns\" />\r\n              <Annotation Term=\"Core.LongDescription\"\r\n                String=\"The filter expression for this property consists of one or more interval expressions or string comparison functions combined by OR. See MultiRange for a definition of an interval expression. See SearchExpression for the allowed string comparison functions.\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"SortRestrictions\" Type=\"Capabilities.SortRestrictionsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on $orderby expressions\" />\r\n      </Term>\r\n      <ComplexType Name=\"SortRestrictionsType\">\r\n        <Property Name=\"Sortable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"$orderby is supported\" />\r\n        </Property>\r\n        <Property Name=\"AscendingOnlyProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These properties can only be used for sorting in Ascending order\" />\r\n        </Property>\r\n        <Property Name=\"DescendingOnlyProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These properties can only be used for sorting in Descending order\" />\r\n        </Property>\r\n        <Property Name=\"NonSortableProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These structural properties cannot be used in $orderby expressions\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"ExpandRestrictions\" Type=\"Capabilities.ExpandRestrictionsType\" AppliesTo=\"EntitySet Singleton\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on $expand expressions\" />\r\n      </Term>\r\n      <ComplexType Name=\"ExpandRestrictionsType\">\r\n        <Property Name=\"Expandable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"$expand is supported\" />\r\n        </Property>\r\n        <Property Name=\"NonExpandableProperties\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These properties cannot be used in $expand expressions\" />\r\n        </Property>\r\n        <Property Name=\"MaxLevels\" Type=\"Edm.Int32\" DefaultValue=\"-1\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"The maximum number of levels that can be expanded in a $expand expression. A value of -1 indicates there is no restriction.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"SearchRestrictions\" Type=\"Capabilities.SearchRestrictionsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on $search expressions\" />\r\n      </Term>\r\n      <ComplexType Name=\"SearchRestrictionsType\">\r\n        <Property Name=\"Searchable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"$search is supported\" />\r\n        </Property>\r\n        <Property Name=\"UnsupportedExpressions\" Type=\"Capabilities.SearchExpressions\" DefaultValue=\"none\">\r\n          <Annotation Term=\"Core.Description\" String=\"Expressions not supported in $search\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <EnumType Name=\"SearchExpressions\" IsFlags=\"true\">\r\n        <Member Name=\"none\" Value=\"0\">\r\n          <Annotation Term=\"Core.Description\" String=\"Single search term\" />\r\n        </Member>\r\n        <Member Name=\"AND\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Multiple search terms separated by AND\" />\r\n        </Member>\r\n        <Member Name=\"OR\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Multiple search terms separated by OR\" />\r\n        </Member>\r\n        <Member Name=\"NOT\" Value=\"4\">\r\n          <Annotation Term=\"Core.Description\" String=\"Search terms preceded by NOT\" />\r\n        </Member>\r\n        <Member Name=\"phrase\" Value=\"8\">\r\n          <Annotation Term=\"Core.Description\" String=\"Search phrases enclosed in double quotes\" />\r\n        </Member>\r\n        <Member Name=\"group\" Value=\"16\">\r\n          <Annotation Term=\"Core.Description\" String=\"Precedence grouping of search expressions with parentheses\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"KeyAsSegmentSupported\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Supports [key-as-segment convention](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_KeyasSegmentConvention) for addressing entities within a collection\" />\r\n      </Term>\r\n\r\n      <!-- Data Modification Capabilities -->\r\n\r\n      <Term Name=\"InsertRestrictions\" Type=\"Capabilities.InsertRestrictionsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on insert operations\" />\r\n      </Term>\r\n      <ComplexType Name=\"InsertRestrictionsType\">\r\n        <Property Name=\"Insertable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Entities can be inserted\" />\r\n        </Property>\r\n        <Property Name=\"NonInsertableNavigationProperties\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These navigation properties do not allow deep inserts\" />\r\n        </Property>\r\n        <Property Name=\"MaxLevels\" Type=\"Edm.Int32\" DefaultValue=\"-1\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"The maximum number of navigation properties that can be traversed when addressing the collection to insert into. A value of -1 indicates there is no restriction.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"DeepInsertSupport\" Type=\"Capabilities.DeepInsertSupportType\" AppliesTo=\"EntityContainer EntitySet\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Deep Insert Support of the annotated resource (the whole service, an entity set, or a collection-valued resource)\" />\r\n      </Term>\r\n      <ComplexType Name=\"DeepInsertSupportType\">\r\n        <Property Name=\"Supported\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Annotation target supports deep inserts\" />\r\n        </Property>\r\n        <Property Name=\"ContentIDSupported\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Annotation target supports accepting and returning nested entities annotated with the `Core.ContentID` instance annotation.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"UpdateRestrictions\" Type=\"Capabilities.UpdateRestrictionsType\" AppliesTo=\"EntitySet Singleton\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on update operations\" />\r\n      </Term>\r\n      <ComplexType Name=\"UpdateRestrictionsType\">\r\n        <Property Name=\"Updatable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Entities can be updated\" />\r\n        </Property>\r\n        <Property Name=\"NonUpdatableNavigationProperties\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These navigation properties do not allow rebinding\" />\r\n        </Property>\r\n        <Property Name=\"MaxLevels\" Type=\"Edm.Int32\" DefaultValue=\"-1\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"The maximum number of navigation properties that can be traversed when addressing the collection or entity to update. A value of -1 indicates there is no restriction.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"DeleteRestrictions\" Type=\"Capabilities.DeleteRestrictionsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Restrictions on delete operations\" />\r\n      </Term>\r\n      <ComplexType Name=\"DeleteRestrictionsType\">\r\n        <Property Name=\"Deletable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Entities can be deleted\" />\r\n        </Property>\r\n        <Property Name=\"NonDeletableNavigationProperties\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"These navigation properties do not allow DeleteLink requests\" />\r\n        </Property>\r\n        <Property Name=\"MaxLevels\" Type=\"Edm.Int32\" DefaultValue=\"-1\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"The maximum number of navigation properties that can be traversed when addressing the collection to delete from or the entity to delete. A value of -1 indicates there is no restriction.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"CollectionPropertyRestrictions\" Type=\"Collection(Capabilities.CollectionPropertyRestrictionsType)\" AppliesTo=\"EntitySet Singleton\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes restrictions on operations applied to collection-valued structural properties\" />\r\n      </Term>\r\n      <ComplexType Name=\"CollectionPropertyRestrictionsType\">\r\n        <Property Name=\"CollectionProperty\" Type=\"Edm.PropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restricted Collection-valued property\" />\r\n        </Property>\r\n        <Property Name=\"FilterFunctions\" Type=\"Collection(Edm.String)\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"List of functions and operators supported in $filter. If null, all functions and operators may be attempted\" />\r\n        </Property>\r\n        <Property Name=\"FilterRestrictions\" Type=\"Capabilities.FilterRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on $filter expressions\" />\r\n        </Property>\r\n        <Property Name=\"SearchRestrictions\" Type=\"Capabilities.SearchRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on $search expressions\" />\r\n        </Property>\r\n        <Property Name=\"SortRestrictions\" Type=\"Capabilities.SortRestrictionsType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Restrictions on $orderby expressions\" />\r\n        </Property>\r\n        <Property Name=\"TopSupported\" Type=\"Core.Tag\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supports $top\" />\r\n        </Property>\r\n        <Property Name=\"SkipSupported\" Type=\"Core.Tag\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supports $skip\" />\r\n        </Property>\r\n        <Property Name=\"Insertable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"This collection supports positional inserts\" />\r\n        </Property>\r\n        <Property Name=\"Updatable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Members of this ordered collection can be updated by ordinal\" />\r\n        </Property>\r\n        <Property Name=\"Deletable\" Type=\"Edm.Boolean\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Members of this ordered collection can be deleted by ordinal\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_VOCABULARY_4 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - OData Version 4.0 Vocabulary components: OData Core Vocabulary.\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This vocabulary contains Core terms needed to write vocabularies.\r\n\r\n-->\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml\">\r\n    <edmx:Include Alias=\"Validation\" Namespace=\"Org.OData.Validation.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Core.V1\" Alias=\"Core\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Core terms needed to write vocabularies</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"alternate\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.json\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://github.com/oasis-tcs/odata-vocabularies/blob/master/vocabularies/Org.OData.Core.V1.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <!-- Versioning -->\r\n\r\n      <Term Name=\"ODataVersions\" Type=\"Edm.String\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A space-separated list of supported versions of the OData Protocol. Note that 4.0 is implied by 4.01 and does not need to be separately listed.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"SchemaVersion\" Type=\"Edm.String\" AppliesTo=\"Schema Reference\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Service-defined value representing the version of the schema. Services MAY use semantic versioning, but clients MUST NOT assume this is the case.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Revisions\" Type=\"Collection(Core.RevisionType)\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\" String=\"List of revisions of a model element\" />\r\n      </Term>\r\n      <ComplexType Name=\"RevisionType\">\r\n        <Property Name=\"Version\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"The schema version with which this revision was first published\" />\r\n        </Property>\r\n        <Property Name=\"Kind\" Type=\"Core.RevisionKind\">\r\n          <Annotation Term=\"Core.Description\" String=\"The kind of revision\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Text describing the reason for the revision\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <EnumType Name=\"RevisionKind\">\r\n        <Member Name=\"Added\">\r\n          <Annotation Term=\"Core.Description\" String=\"Model element was added\" />\r\n        </Member>\r\n        <Member Name=\"Modified\">\r\n          <Annotation Term=\"Core.Description\" String=\"Model element was modified\" />\r\n        </Member>\r\n        <Member Name=\"Deprecated\">\r\n          <Annotation Term=\"Core.Description\" String=\"Model element was deprecated\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <!--Documentation -->\r\n\r\n      <Term Name=\"Description\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"A brief description of a model element\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n      </Term>\r\n\r\n      <Term Name=\"LongDescription\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"A lengthy description of a model element\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Links\" Type=\"Collection(Core.Link)\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\" String=\"Link to related information\" />\r\n      </Term>\r\n      <ComplexType Name=\"Link\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The Link term is inspired by the `atom:link` element, see [RFC4287](https://tools.ietf.org/html/rfc4287#section-4.2.7), and the `Link` HTTP header, see [RFC5988](https://tools.ietf.org/html/rfc5988)\" />\r\n        <Property Name=\"rel\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Link relation type, see [IANA Link Relations](http://www.iana.org/assignments/link-relations/link-relations.xhtml)\" />\r\n        </Property>\r\n        <Property Name=\"href\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.IsURL\" />\r\n          <Annotation Term=\"Core.Description\" String=\"URL of related information\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <!-- Error, warning, and info messages in a (mostly) successful response -->\r\n\r\n      <Term Name=\"Messages\" Type=\"Collection(Core.MessageType)\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\" String=\"Instance annotation for warning and info messages\" />\r\n      </Term>\r\n      <ComplexType Name=\"MessageType\">\r\n        <Property Name=\"code\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Machine-readable, language-independent message code\" />\r\n        </Property>\r\n        <Property Name=\"message\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Human-readable, language-dependent message text\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"severity\" Type=\"Core.MessageSeverity\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Severity of the message\" />\r\n        </Property>\r\n        <Property Name=\"target\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"A path to the target of the message detail, relative to the annotated instance\" />\r\n        </Property>\r\n        <Property Name=\"details\" Type=\"Collection(Core.MessageType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of detail messages\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <TypeDefinition Name=\"MessageSeverity\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Validation.AllowedValues\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"success\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Positive feedback - no action required\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"info\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Additional information - no action required\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"warning\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Warning - action may be required\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" String=\"error\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Error - action is required\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </TypeDefinition>\r\n\r\n      <!-- Localization -->\r\n\r\n      <Term Name=\"IsLanguageDependent\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Term Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"Properties and terms annotated with this term are language-dependent\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <TypeDefinition Name=\"Tag\" UnderlyingType=\"Edm.Boolean\">\r\n        <Annotation Term=\"Core.Description\" String=\"This is the type to use for all tagging terms\" />\r\n      </TypeDefinition>\r\n\r\n      <!-- Term Restrictions -->\r\n\r\n      <Term Name=\"RequiresType\" Type=\"Edm.String\" AppliesTo=\"Term\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Terms annotated with this term can only be applied to elements that have a type that is identical to or derived from the given type name\" />\r\n      </Term>\r\n\r\n      <!--Resource Paths -->\r\n\r\n      <Term Name=\"ResourcePath\" Type=\"Edm.String\" AppliesTo=\"EntitySet Singleton ActionImport FunctionImport\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Resource path for entity container child, can be relative to xml:base and the request URL\" />\r\n        <Annotation Term=\"Core.IsURL\" />\r\n      </Term>\r\n\r\n      <Term Name=\"DereferenceableIDs\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Entity-ids are URLs that locate the identified entity\" />\r\n      </Term>\r\n\r\n      <Term Name=\"ConventionalIDs\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer\">\r\n        <Annotation Term=\"Core.Description\" String=\"Entity-ids follow OData URL conventions\" />\r\n      </Term>\r\n\r\n      <!-- Permissions -->\r\n\r\n      <Term Name=\"Permissions\" Type=\"Core.Permission\"\r\n        AppliesTo=\"Property ComplexType TypeDefinition EntityType EntitySet NavigationProperty Action Function\"\r\n      >\r\n        <Annotation Term=\"Core.Description\" String=\"Permissions for accessing a resource\" />\r\n      </Term>\r\n      <EnumType Name=\"Permission\" IsFlags=\"true\">\r\n        <Member Name=\"None\" Value=\"0\">\r\n          <Annotation Term=\"Core.Description\" String=\"No permissions\" />\r\n        </Member>\r\n        <Member Name=\"Read\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Read permission\" />\r\n        </Member>\r\n        <Member Name=\"Write\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Write permission\" />\r\n        </Member>\r\n        <Member Name=\"ReadWrite\" Value=\"3\">\r\n          <Annotation Term=\"Core.Description\" String=\"Read and write permission\" />\r\n        </Member>\r\n        <Member Name=\"Invoke\" Value=\"4\">\r\n          <Annotation Term=\"Core.Description\" String=\"Permission to invoke actions\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <!-- Batch Content ID -->\r\n\r\n      <Term Name=\"ContentID\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"A unique identifier for nested entities within a request.\" />\r\n      </Term>\r\n\r\n      <!-- Metadata Extensions -->\r\n\r\n      <Term Name=\"DefaultNamespace\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Schema Include\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Functions, actions and types in this namespace can be referenced in URLs with or without namespace- or alias- qualification.\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Data Modelers should ensure uniqueness of schema children across all default namespaces, and should avoid naming bound functions, actions, or derived types with the same name as a structural or navigational property of the type.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Immutable\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A value for this non-key property can be provided by the client on insert and remains unchanged on update\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Computed\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"A value for this property is generated on both insert and update\" />\r\n      </Term>\r\n\r\n      <Term Name=\"ComputedDefaultValue\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A value for this property can be provided by the client on insert and update. If no value is provided on insert, a non-static default value is generated\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsURL\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property Term\">\r\n        <Annotation Term=\"Core.Description\" String=\"Properties and terms annotated with this term MUST contain a valid URL\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AcceptableMediaTypes\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityType Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Lists the MIME types acceptable for the annotated entity type marked with HasStream=&quot;true&quot; or the annotated stream property\" />\r\n        <Annotation Term=\"Core.IsMediaType\" />\r\n      </Term>\r\n\r\n      <Term Name=\"MediaType\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"The media type of a binary resource\" />\r\n        <Annotation Term=\"Core.IsMediaType\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.Binary\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsMediaType\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property Term\">\r\n        <Annotation Term=\"Core.Description\" String=\"Properties and terms annotated with this term MUST contain a valid MIME type\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"OptimisticConcurrency\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Data modification requires the use of ETags. A non-empty collection contains the set of properties that are used to compute the ETag.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AdditionalProperties\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Instances of this type may contain properties in addition to those declared in $metadata\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"If specified as false clients can assume that instances will not contain dynamic properties, irrespective of the value of the OpenType attribute.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AutoExpand\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"NavigationProperty\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The service will automatically expand this navigation property even if not requested with $expand\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AutoExpandReferences\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"NavigationProperty\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The service will automatically expand this navigation property as entity references even if not requested with $expand=.../$ref\" />\r\n      </Term>\r\n\r\n      <Term Name=\"MayImplement\" Type=\"Collection(Core.QualifiedTypeName)\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A collection of qualified type names outside of the type hierarchy that instances of this type might be addressable as by using a type-cast segment.\" />\r\n      </Term>\r\n\r\n      <TypeDefinition Name=\"QualifiedTypeName\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"The qualified name of a type in scope.\" />\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"Ordered\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property NavigationProperty EntitySet ReturnType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Collection has a stable order. Ordered collections of primitive or complex types can be indexed by ordinal.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"PositionalInsert\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property NavigationProperty EntitySet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Items can be inserted at a given ordinal index.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AlternateKeys\" AppliesTo=\"EntityType EntitySet NavigationProperty\" Type=\"Collection(Core.AlternateKey)\"\r\n        Nullable=\"false\"\r\n      >\r\n        <Annotation Term=\"Core.Description\" String=\"Communicates available alternate keys\" />\r\n      </Term>\r\n      <ComplexType Name=\"AlternateKey\">\r\n        <Property Type=\"Collection(Core.PropertyRef)\" Name=\"Key\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"The set of properties that make up this key\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"PropertyRef\">\r\n        <Property Type=\"Edm.PropertyPath\" Name=\"Name\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"A path expression resolving to a primitive property of the entity type itself or to a primitive property of a complex or navigation property (recursively) of the entity type. The names of the properties in the path are joined together by forward slashes.\" />\r\n        </Property>\r\n        <Property Type=\"Edm.String\" Name=\"Alias\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"A SimpleIdentifier that MUST be unique within the set of aliases, structural and navigation properties of the containing entity type that MUST be used in the key predicate of URLs\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"Dictionary\" OpenType=\"true\">\r\n        <Annotation Term=\"Core.Description\" String=\"A dictionary of name-value pairs. Names must be valid property names, values may be restricted to a list of types via an annotation with term `Validation.OpenPropertyTypeConstraint`.\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>\r\nProperty|Type\r\n:-------|:---\r\nAny simple identifier | Any type listed in `Validation.OpenPropertyTypeConstraint`, or any type if there is no constraint\r\n</String>\r\n        </Annotation>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"OptionalParameter\" Type=\"Core.OptionalParameterType\" AppliesTo=\"Parameter\">\r\n        <Annotation Term=\"Core.Description\" String=\"Supplying a value for the parameter is optional.\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"All parameters marked as optional must come after any parameters not marked as optional. The binding parameter must not be marked as optional.\" />\r\n      </Term>\r\n      <ComplexType Name=\"OptionalParameterType\">\r\n        <Property Name=\"DefaultValue\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Default value for an optional parameter of primitive or enumeration type, using the same rules as the `cast` function in URLs.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"OperationAvailable\" Type=\"Edm.Boolean\" Nullable=\"true\" DefaultValue=\"true\" AppliesTo=\"Action Function\">\r\n        <Annotation Term=\"Core.Description\" String=\"Action or function is available\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The annotation value will usually be an expression, e.g. using properties of the binding parameter type for instance-dependent availability, or using properties of a singleton for global availability. The static value `null` means that availability cannot be determined upfront and is instead expressed as an operation advertisement.\" />\r\n      </Term>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_VOCABULARY_5 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - OData Version 4.0 Vocabulary components: OData Measures Vocabulary.\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This document contains terms describing monetary amounts and measured quantities.\r\n\r\n-->\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Measures.V1\" Alias=\"Measures\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms describing monetary amounts and measured quantities</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"alternate\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.json\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://github.com/oasis-tcs/odata-vocabularies/blob/master/vocabularies/Org.OData.Measures.V1.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"ISOCurrency\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"The currency for this monetary amount as an ISO 4217 currency code\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Scale\" Type=\"Edm.Byte\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The number of significant decimal places in the scale part (less than or equal to the number declared in the Scale facet)\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.Decimal\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Unit\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"The unit of measure for this measured quantity, e.g. cm for centimeters or % for percentages\" />\r\n      </Term>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_VOCABULARY_6 @"﻿<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Patched (evan.ireland@sap.com) - 19 May 2017 - see https://issues.oasis-open.org/browse/ODATA-1079\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - None.\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This vocabulary defines terms to describe which data in a given entity model is time-dependent, and in which dimensions.\r\n\r\n-->\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Namespace=\"Org.OData.Core.V1\" Alias=\"Core\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Temporal.V1\" Alias=\"Temporal\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms to describe which data in a given entity model is time-dependent, and in which dimensions.</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Temporal.V1.xml\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n\r\n      <!-- Metadata annotations -->\r\n\r\n      <Term Name=\"TemporalSupported\" Type=\"Temporal.TemporalSupportedType\" AppliesTo=\"EntityContainer EntitySet NavigationProperty\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>This entity container, entity set, or navigation property supports the temporal system query option</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <ComplexType Name=\"TemporalSupportedType\">\r\n        <Property Name=\"ApplicationTime\" Type=\"Temporal.TimeDimensionType\" />\r\n        <Property Name=\"SystemTime\" Type=\"Temporal.TimeDimensionGranularityDateTimeOffset\" />\r\n        <Property Name=\"NonTemporalProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Properties whose value changes over time are not tracked\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"TimeDimensionType\" Abstract=\"true\">\r\n        <Property Name=\"SupportedQueries\" Type=\"Temporal.QueryType\" />\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"TimeDimensionGranularityDateTimeOffset\" BaseType=\"Temporal.TimeDimensionType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Granularity of this time dimension is DateTimeOffset\" />\r\n        <Property Name=\"Precision\" Type=\"Edm.Byte\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Precision of Edm.DateTimeOffset values for granularity DateTimeOffset\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"TimeDimensionGranularityDate\" BaseType=\"Temporal.TimeDimensionType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Granularity of this time dimension is Date\" />\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"QueryType\" IsFlags=\"true\">\r\n        <Member Name=\"TimeTravel\" Value=\"1\" />\r\n        <Member Name=\"TimeSeries\" Value=\"2\" />\r\n      </EnumType>\r\n\r\n\r\n      <!-- Metadata annotations that can also appear as instance annotations -->\r\n\r\n      <Term Name=\"From\" Type=\"Edm.PrimitiveType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Lower boundary (inclusive) of application time. Date or DateTimeOffset value, or String with values min or now\" />\r\n      </Term>\r\n\r\n      <Term Name=\"To\" Type=\"Edm.PrimitiveType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Upper boundary (exclusive) of application time. Date or DateTimeOffset value, or String with values now or max\" />\r\n      </Term>\r\n\r\n      <Term Name=\"SystemFrom\" Type=\"Edm.PrimitiveType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Read-only lower boundary (inclusive) of system time. DateTimeOffset value or String with value min\" />\r\n      </Term>\r\n\r\n      <Term Name=\"SystemTo\" Type=\"Edm.PrimitiveType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Read-only upper boundary (exclusive) of system time. DateTimeOffset value or String with value max\" />\r\n      </Term>\r\n\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_VOCABULARY_7 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<!--\r\n\r\n  Technical Committee:\r\n  OASIS Open Data Protocol (OData) TC\r\n  https://www.oasis-open.org/committees/odata\r\n\r\n  Chairs:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n\r\n  Editors:\r\n  - Ralf Handl (ralf.handl@sap.com), SAP SE\r\n  - Ram Jeyaraman (Ram.Jeyaraman@microsoft.com), Microsoft\r\n  - Michael Pizzo (mikep@microsoft.com), Microsoft\r\n\r\n  Additional artifacts:\r\n  This vocabulary is one component of a Work Product that also includes the following vocabulary components:\r\n  - OData Core Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml.\r\n  - OData Measures Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Measures.V1.xml.\r\n  - OData Capabilities Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Capabilities.V1.xml.\r\n  - OData Validation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml.\r\n  - OData Aggregation Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggretation.V1.xml.\r\n  - OData Authorization Vocabulary. Latest version: https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Authorization.V1.xml.\r\n\r\n  Related work:\r\n  This vocabulary replaces or supersedes:\r\n  - None.\r\n  This vocabulary is related to:\r\n  - OData Version 4.01 Part 1: Protocol. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html.\r\n  - OData Version 4.01 Part 2: URL Conventions. Latest version: http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html.\r\n  - OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-json/v4.01/odata-csdl-json-v4.01.html.\r\n  - OData Common Schema Definition Language (CSDL) XML Representation Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html.\r\n  - OData JSON Format Version 4.01. Latest version: http://docs.oasis-open.org/odata/odata-json-format/v4.01/odata-json-format-v4.01.html.\r\n  - OData Extension for Data Aggregation Version 4.0. Latest version: http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/odata-data-aggregation-ext-v4.0.html.\r\n\r\n  Abstract:\r\n  This document contains terms describing validation rules.\r\n\r\n-->\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"Org.OData.Validation.V1\" Alias=\"Validation\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms describing validation rules</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"alternate\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.json\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://github.com/oasis-tcs/odata-vocabularies/blob/master/vocabularies/Org.OData.Validation.V1.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"Pattern\" Type=\"Edm.String\" AppliesTo=\"Property Parameter Term\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The pattern that a string property, parameter, or term must match. This SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect.\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Minimum\" Type=\"Edm.Decimal\" Scale=\"variable\" AppliesTo=\"Property Parameter Term\">\r\n        <Annotation Term=\"Core.Description\" String=\"Minimum value that a property, parameter, or term can have.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Maximum\" Type=\"Edm.Decimal\" Scale=\"variable\" AppliesTo=\"Property Parameter Term\">\r\n        <Annotation Term=\"Core.Description\" String=\"Maximum value that a property, parameter, or term can have.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Exclusive\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Annotation\">\r\n        <Annotation Term=\"Core.Description\" String=\"Tags a Minimum or Maximum as exclusive, i.e. an open interval boundary.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AllowedValues\" Type=\"Collection(Validation.AllowedValue)\" AppliesTo=\"Property Parameter TypeDefinition\">\r\n        <Annotation Term=\"Core.Description\" String=\"A collection of valid values for the annotated property, parameter, or type definition\" />\r\n      </Term>\r\n      <ComplexType Name=\"AllowedValue\">\r\n        <Property Name=\"Value\" Type=\"Edm.PrimitiveType\">\r\n          <Annotation Term=\"Core.Description\" String=\"An allowed value for the property, parameter, or type definition\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"MultipleOf\" Type=\"Edm.Decimal\" Scale=\"variable\" AppliesTo=\"Property Parameter Term\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The value of the annotated property, parameter, or term must be an integer multiple of this positive value. For temporal types, the value is measured in seconds.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Constraint\" Type=\"Validation.ConstraintType\" AppliesTo=\"Property EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Condition that the annotation target has to fulfill\" />\r\n      </Term>\r\n      <ComplexType Name=\"ConstraintType\">\r\n        <Property Name=\"FailureMessage\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Human-readable message that can be shown to end users if the constraint is not fulfilled\" />\r\n        </Property>\r\n        <Property Name=\"Condition\" Type=\"Edm.Boolean\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Value MUST be a dynamic expression that evaluates to true if and only if the constraint is fulfilled\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"ItemsOf\" Type=\"Collection(Validation.ItemsOfType)\" AppliesTo=\"EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A list of constraints describing that entities related via one navigation property MUST also be related via another, collection-valued navigation property. The same `path` value MUST NOT occur more than once.\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Example: entity type `Customer` has navigation properties `AllOrders`, `OpenOrders`, and `ClosedOrders`. \r\nThe term allows to express that items of `OpenOrders` and `ClosedOrders` are also items of the `AllOrders` navigation property,\r\neven though they are defined in an `Orders` entity set.</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"ItemsOfType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Entities related via the single- or collection-valued navigation property identified by `path` are also related via the collection-valued navigation property identified by `target`.\" />\r\n        <Property Name=\"path\" Type=\"Edm.NavigationPropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"A path to a single- or collection-valued navigation property\" />\r\n        </Property>\r\n        <Property Name=\"target\" Type=\"Edm.NavigationPropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"A path to a collection-valued navigation property\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"OpenPropertyTypeConstraint\" Type=\"Collection(Core.QualifiedTypeName)\" AppliesTo=\"ComplexType EntityType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Dynamic properties added to the annotated open structured type are restricted to the listed types\" />\r\n      </Term>\r\n\r\n      <Term Name=\"DerivedTypeConstraint\" Type=\"Collection(Core.QualifiedTypeName)\" AppliesTo=\"Property TypeDefinition\">\r\n        <Annotation Term=\"Core.Description\" String=\"Values are restricted to types derived from the declared type and listed in this collection\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Types listed in this collection that are not derived form the declared type of the annotated model element are ignored\" />\r\n      </Term>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_SAP_VOCABULARY_1 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggregation.V1.xml\">\r\n    <edmx:Include Alias=\"Aggregation\" Namespace=\"Org.OData.Aggregation.V1\" />\r\n  </edmx:Reference>\r\n\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"com.sap.vocabularies.Analytics.v1\" Alias=\"Analytics\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms for annotating analytical resources</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Description\" Qualifier=\"Published\">\r\n        <String>2017-02-15 © Copyright 2013 SAP AG. All rights reserved</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/download/attachments/462030211/Analytics.xml?api=v2\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/x/gwWKGw\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"Dimension\" Type=\"Core.Tag\" BaseTerm=\"Aggregation.Groupable\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"A property holding the key of a dimension in an analytical context\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Measure\" Type=\"Core.Tag\" BaseTerm=\"Aggregation.Aggregatable\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"A property holding the numeric value of a measure in an analytical context\" />\r\n      </Term>\r\n\r\n      <Term Name=\"RolledUpPropertyCount\" Type=\"Edm.Int16\"> <!-- instance annotation -->\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Number of properties in the entity instance that have been aggregated away\" />\r\n      </Term>\r\n\r\n      <Term Name=\"DrillURL\" Type=\"Edm.String\" AppliesTo=\"EntityType\"> <!-- metadata annotation that can also appear as instance annotation -->\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>\r\n            URL to retrieve more detailed data related to a node of a recursive hierarchy. \r\n            Annotations with this term MUST include a qualifier to select the hierarchy for which the drill URL is provided.  \r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.IsURL\" />\r\n      </Term>\r\n\r\n      <Term Name=\"PlanningAction\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"ActionImport\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String> Processes or generates plan data. Its logic may have side-effects on entity sets.\r\n          </String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_SAP_VOCABULARY_2 @"﻿<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml\">\r\n    <edmx:Include Alias=\"Validation\" Namespace=\"Org.OData.Validation.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggregation.V1.xml\">\r\n    <edmx:Include Alias=\"Aggregation\" Namespace=\"Org.OData.Aggregation.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"com.sap.vocabularies.Common.v1\" Alias=\"Common\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Common terms for all SAP vocabularies</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Description\" Qualifier=\"Published\">\r\n        <String>2017-02-15 © Copyright 2013 SAP SE. All rights reserved.</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://wiki.scn.sap.com/wiki/download/attachments/448470974/Common.xml?api=v2\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/x/vh_7Gg\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"Experimental\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Terms, types, and properties annotated with this term are experimental and can be changed or removed any time without prior warning</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <!-- Section: Versioning -->\r\n      <Term Name=\"ServiceVersion\" Type=\"Edm.Int32\" AppliesTo=\"Schema\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"1 for first version of a service, incremented when schema changes incompatibly and service is published with a different URI\" />\r\n      </Term>\r\n      <Term Name=\"ServiceSchemaVersion\" Type=\"Edm.Int32\" AppliesTo=\"Schema\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"0 for first schema version within a service version, incremented when schema changes compatibly\" />\r\n      </Term>\r\n\r\n      <!-- Section: General Semantics -->\r\n      <Term Name=\"Label\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"A short, human-readable text suitable for labels and captions in UIs\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Heading\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"A short, human-readable text suitable for column headings in UIs\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n      </Term>\r\n\r\n      <Term Name=\"QuickInfo\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"A short, human-readable text suitable for tool tips in UIs\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Text\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A descriptive text for values of the annotated property. Value MUST be a dynamic expression when used as metadata annotation.\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n      </Term>\r\n\r\n      <Term Name=\"TextFor\" Type=\"Edm.PropertyPath\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The annotated property contains a descriptive text for values of the referenced property.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsLanguageIdentifier\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"An identifier to distinguish multiple texts in different languages for the same entity\" />\r\n      </Term>\r\n\r\n      <Term Name=\"TextFormat\" Type=\"Common.TextFormatType\" AppliesTo=\"Property Parameter ReturnType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Human-readable text that may contain formatting information\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n      <EnumType Name=\"TextFormatType\">\r\n        <Member Name=\"plain\">\r\n          <Annotation Term=\"Core.Description\" String=\"Plain text, line breaks represented as the character 0x0A\" />\r\n        </Member>\r\n        <Member Name=\"html\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Plain text with markup that can validly appear directly within an HTML DIV element\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <!-- under discussion\r\n        <Term Name=\"ValidationConstraint\" Type=\"Common.ValidationConstraintType\" AppliesTo=\"Property EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Condition that the annotation target has to fulfill\" />\r\n        </Term>\r\n        <ComplexType Name=\"ValidationConstraintType\">\r\n        <Property Name=\"FailureMessage\" Type=\"Edm.String\" Nullable=\"true\">\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"Condition\" Type=\"Edm.Boolean\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\"\r\n        String=\"Value MUST be a dynamic expression that evaluates to true if and only if the constraint is fulfilled\" />\r\n        </Property>\r\n        </ComplexType>\r\n      -->\r\n      <!-- Examples:\r\n        <Annotation Term=\"Common.ValidationConstraint\" Qualifier=\"Comparison\">\r\n        <Record>\r\n        <PropertyValue Property=\"FailureMessage\" String=\"Start date cannot be after end date\" />\r\n        <PropertyValue Property=\"Condition\">\r\n        <Le>\r\n        <Path>StartDate</Path>\r\n        <Path>EndDate</Path>\r\n        </Le>\r\n        </PropertyValue>\r\n        </Record>\r\n        </Annotation>\r\n\r\n        <Annotation Term=\"Common.ValidationConstraint\" Qualifier=\"Minimum\">\r\n        <Record>\r\n        <PropertyValue Property=\"FailureMessage\" String=\"Value cannot be negative\" />\r\n        <PropertyValue Property=\"Condition\">\r\n        <Ge>\r\n        <Path>Amount</Path>\r\n        <Decimal>0</Decimal>\r\n        </Ge>\r\n        </PropertyValue>\r\n        </Record>\r\n        </Annotation>\r\n      -->\r\n      <!--\r\n        could later be combined with a client-side function sap.matchRegularExpression\r\n        Two arguments of type string, second argument MUST evaluate to a JavaScript regular expression, see e.g.\r\n        https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions\r\n        Function returns true if and only if the whole first argument matches the regular expression in the second argumentReturns\r\n      -->\r\n\r\n      <Term Name=\"IsDigitSequence\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Core.Description\" String=\"Contains only digits\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsUpperCase\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Core.Description\" String=\"Contains just uppercase characters\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsCurrencyCode\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Contains a currency code\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsUnitOfMeasure\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Contains a unit of measure\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"UnitSpecificScale\" Type=\"Edm.Byte\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The number of fractional decimal digits of a currency amount or measured quantity\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The annotated property contains a currency code or unit of measure, and the annotation value specifies the default scale of numeric values with that currency code or unit of measure. Can be used in e.g. a list of available currency codes or units of measure, or a list of measuring devices to specify the number of fractional digits captured by that device.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"UnitSpecificPrecision\" Type=\"Edm.Byte\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The number of significant decimal digits of a currency amount or measured quantity\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The annotated property contains a currency code or unit of measure, and the annotation value specifies the default precision of numeric values with that currency code or unit of measure. Can be used in e.g. a list of available currency codes or units of measure, or a list of measuring devices to specify the number of significant digits captured by that device.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"SecondaryKey\" AppliesTo=\"EntityType\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The listed properties form a secondary key. Multiple secondary keys are possible using different qualifiers.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"MinOccurs\" AppliesTo=\"NavigationProperty Property EntitySet Term Parameter\" Type=\"Edm.Int64\">\r\n        <Annotation Term=\"Core.Description\" String=\"The annotated set or collection contains at least this number of items\" />\r\n      </Term>\r\n\r\n      <Term Name=\"MaxOccurs\" AppliesTo=\"NavigationProperty Property EntitySet Term Parameter\" Type=\"Edm.Int64\">\r\n        <Annotation Term=\"Core.Description\" String=\"The annotated set or collection contains at most this number of items\" />\r\n      </Term>\r\n\r\n      <Term Name=\"AssociationEntity\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Entity representing an n:m association with attributes</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Common.MinOccurs\" Int=\"2\" />\r\n      </Term>\r\n\r\n      <Term Name=\"DerivedNavigation\" Type=\"Edm.NavigationPropertyPath\" AppliesTo=\"NavigationProperty\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Shortcut for a multi-segment navigation, contains the long path with all its segments</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"Masked\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Revisions\">\r\n          <Annotation Term=\"Common.Experimental\" String=\"https://sapjira.wdf.sap.corp/browse/FIORITECHE1-951\" />\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n              <PropertyValue Property=\"Description\" String=\"Use terms `MaskedValue` and `MaskedAlways` instead\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property contains sensitive data that should by default be masked on a UI and clear-text visible only upon user interaction</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"Masking\" Type=\"Common.MaskingType\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://sapjira.wdf.sap.corp/browse/FIORITECHE1-951\" />\r\n        <Annotation Term=\"Core.Revisions\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n              <PropertyValue Property=\"Description\" String=\"Use terms `MaskedValue` and `MaskedAlways` instead\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains sensitive data that should be masked on UIs\" />\r\n      </Term>\r\n      <ComplexType Name=\"MaskingType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes masking behavior for sensitive data\" />\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Property Name=\"Value\" Type=\"Edm.PrimitiveType\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Replacement value that should be visible on a UI instead of the actual value of the masked property\" />\r\n        </Property>\r\n        <Property Name=\"Always\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"If false, the property value is initially masked and can be unmasked on user interaction\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"MaskedValue\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/TGSxdQ\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains sensitive data that is by default not transferred\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>By default a masked property is excluded from responses and instead an instance annotation with this term is sent, containing a masked value that can be rendered by user interfaces.</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"MaskedAlways\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/TGSxdQ\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains sensitive data that is by default not transferred\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>If the annotation evaluates to true, the unmasked property value is never transferred in responses.\r\n\r\nIf the annotation evaluates to false, the unmasked property value can be requested with the custom query option `masked-values=false`.</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"SemanticObject\" Type=\"Edm.String\" AppliesTo=\"EntitySet EntityType Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Name of the Semantic Object represented as this entity type or identified by this property\" />\r\n      </Term>\r\n      <Term Name=\"SemanticObjectMapping\" BaseTerm=\"Common.SemanticObject\" Type=\"Collection(Common.SemanticObjectMappingType)\"\r\n        Nullable=\"false\" AppliesTo=\"EntitySet EntityType Property\"\r\n      >\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Maps properties of the annotated entity type or sibling properties of the annotated property to properties of the Semantic Object\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"This allows &quot;renaming&quot; of properties in the current context to match property names of the Semantic Object, e.g. `SenderPartyID` to `PartyID`. Only properties explicitly listed in the mapping are renamed, all other properties are available for intent-based navigation with their &quot;local&quot; name.\" />\r\n      </Term>\r\n      <ComplexType Name=\"SemanticObjectMappingType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Maps a property of the annotated entity type or a sibling property of the annotated property to a property of the Semantic Object\" />\r\n        <Property Name=\"LocalProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Path to a local property that provides the value for the Semantic Object property\" />\r\n        </Property>\r\n        <Property Name=\"SemanticObjectProperty\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the Semantic Object property\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <Term Name=\"SemanticObjectUnavailableActions\" BaseTerm=\"Common.SemanticObject\" Type=\"Collection(Edm.String)\" Nullable=\"false\"\r\n        AppliesTo=\"EntitySet EntityType Property\"\r\n      >\r\n        <Annotation Term=\"Common.Experimental\" String=\"See https://sapjira.wdf.sap.corp/browse/FIORITECHP1-4243\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"List of actions that are not available in the current state of the instance of the Semantic Object\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsInstanceAnnotation\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Term\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Term can also be used as instance annotation; AppliesTo of this term specifies where it can be applied\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Insertable\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"NavigationProperty\">\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Specifies whether the service allows to create an entity by sending a POST request to the navigation link URL (in this case the created entity is automatically linked to the entity containing the navigation link)</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"Updatable\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Specifies whether the annotated entity can be updated</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"Deletable\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Specifies whether the annotated entity can be deleted</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"FilterExpressionRestrictions\" Type=\"Collection(Common.FilterExpressionRestrictionType)\" Nullable=\"false\"\r\n        AppliesTo=\"EntitySet\"\r\n      >\r\n        <Annotation Term=\"Core.Description\" String=\"These properties only allow a subset of expressions\" />\r\n        <Annotation Term=\"Core.Revisions\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n              <PropertyValue Property=\"Description\" String=\"Use term Capabilities.FilterRestrictions instead\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"FilterExpressionRestrictionType\">\r\n        <Property Name=\"Property\" Type=\"Edm.PropertyPath\" />\r\n        <Property Name=\"AllowedExpressions\" Type=\"Common.FilterExpressionType\" />\r\n      </ComplexType>\r\n      <EnumType Name=\"FilterExpressionType\">\r\n        <Member Name=\"SingleValue\">\r\n          <Annotation Term=\"Core.Description\" String=\"a single 'eq' clause\" />\r\n        </Member>\r\n        <Member Name=\"MultiValue\">\r\n          <Annotation Term=\"Core.Description\" String=\"one or more 'eq' clauses, separated by 'or'\" />\r\n        </Member>\r\n        <Member Name=\"SingleInterval\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"at most one 'ge' and one 'le' clause, separated by 'and', alternatively a single 'eq' clause\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"FieldControl\" Type=\"Common.FieldControlType\" DefaultValue=\"Optional\" AppliesTo=\"Property Record\">\r\n        <Annotation Term=\"Core.Description\" String=\"Control state of a property\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"This term can be used for static field control, providing an enumeration member value in $metadata, as well as dynamically, providing a `Path` expression.&#x0A;&#x0A;In the dynamic case the property referenced by the `Path` expression MUST be of type `Edm.Byte` to accommodate OData V2 services as well as V4 infrastructures that don't support enumeration types.\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <EnumType Name=\"FieldControlType\" UnderlyingType=\"Edm.Byte\">\r\n        <Annotation Term=\"Core.Description\" String=\"Control state of a property\" />\r\n        <Annotation Term=\"Core.LongDescription\" String=\"Control state of a property\" />\r\n        <Member Name=\"Mandatory\" Value=\"7\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property must have a non-null value\" />\r\n        </Member>\r\n        <Member Name=\"Optional\" Value=\"3\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property may have a value or be null\" />\r\n        </Member>\r\n        <Member Name=\"ReadOnly\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property value cannot be changed\" />\r\n        </Member>\r\n        <Member Name=\"Inapplicable\" Value=\"0\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property has no meaning in the current entity state\" />\r\n        </Member>\r\n        <Member Name=\"Hidden\" Value=\"0\">\r\n          <Annotation Term=\"Core.Description\" String=\"Deprecated synonymn for Inapplicable, do not use\" />\r\n          <Annotation Term=\"Core.LongDescription\" String=\"To statically hide a property on a UI use `UI.Hidden` instead\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"ExceptionCategory\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"A machine-readable exception category\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <Term Name=\"Application\" Type=\"Common.ApplicationType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"...\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <ComplexType Name=\"ApplicationType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Property Name=\"Component\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Software component of service implementation\" />\r\n        </Property>\r\n        <Property Name=\"ServiceRepository\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"...\" />\r\n        </Property>\r\n        <Property Name=\"ServiceId\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"...\" />\r\n        </Property>\r\n        <Property Name=\"ServiceVersion\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"...\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <Term Name=\"Timestamp\" Type=\"Edm.DateTimeOffset\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"...\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <Term Name=\"TransactionId\" Type=\"Edm.String\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"...\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <Term Name=\"ErrorResolution\" Type=\"Common.ErrorResolutionType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Hints for resolving this error\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <ComplexType Name=\"ErrorResolutionType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Property Name=\"Analysis\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Short hint on how to analyze this error\" />\r\n        </Property>\r\n        <Property Name=\"Note\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Note for error resolution\" />\r\n        </Property>\r\n        <Property Name=\"AdditionalNote\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Additional note for error resolution\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Messages\" Type=\"Collection(Edm.ComplexType)\" Nullable=\"false\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of end-user messages\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>The name of the message type is service-specific, its structure components are identified by naming convention, following the names of the OData error response structure.\r\n\r\nThe minimum structure is  \r\n\r\n- code: Edm.String \r\n\r\n- message: Edm.String \r\n\r\n- target: Edm.String nullable  \r\n\r\n- transition: Edm.Boolean\r\n\r\n- numericSeverity: Edm.Byte\r\n\r\n- longtextUrl: Edm.String nullable  \r\n          </String>\r\n        </Annotation>\r\n      </Term>\r\n      <Term Name=\"longtextUrl\" Type=\"Edm.String\" Nullable=\"false\" AppliesTo=\"Record\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.IsURL\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Location of the message long text\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"This instance annotation can be applied to the `error` object of an OData error response\" />\r\n      </Term>\r\n      <Term Name=\"numericSeverity\" Type=\"Common.NumericMessageSeverityType\" Nullable=\"false\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Classifies an end-user message as info, success, warning, or error\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"This instance annotation can be applied to the `error` object of an OData error response\" />\r\n      </Term>\r\n      <Term Name=\"MaximumNumericMessageSeverity\" Type=\"Common.NumericMessageSeverityType\" BaseTerm=\"Common.Messages\" Nullable=\"true\"\r\n        AppliesTo=\"EntityType\"\r\n      >\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The maximum severity of all end-user messages attached to an entity, null if no messages are attached\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"This metadata annotation can be applied to entity types that are also annotated with term [`Common.Messages`](#Messages)\" />\r\n      </Term>\r\n      <TypeDefinition Name=\"NumericMessageSeverityType\" UnderlyingType=\"Edm.Byte\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Classifies an end-user message as info, success, warning, or error\" />\r\n        <Annotation Term=\"Validation.AllowedValues\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"1\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Success - no action required\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"2\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Information - no action required\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"3\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Warning - action may be required\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"4\" />\r\n              <Annotation Term=\"Core.Description\" String=\"Error - action is required\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"IsActionCritical\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\"\r\n        AppliesTo=\"Action Function ActionImport FunctionImport\"\r\n      >\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Criticality of the function or action to enforce a warning or similar before it's executed\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Attributes\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Attributes related to this property, which may occur in denormalized entity types\" />\r\n      </Term>\r\n\r\n      <Term Name=\"RelatedRecursiveHierarchy\" Type=\"Edm.AnnotationPath\" AppliesTo=\"Property \">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A recursive hierarchy related to this property. The annotation path must end in Aggregation.RecursiveHierarchy.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Interval\" Type=\"Common.IntervalType\" AppliesTo=\"EntityType ComplexType\">\r\n        <Annotation Term=\"Core.Description\" String=\"An interval with lower and upper boundaries described by two properties\" />\r\n      </Term>\r\n      <ComplexType Name=\"IntervalType\">\r\n        <Property Name=\"LowerBoundary\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the lower interval boundary\" />\r\n        </Property>\r\n        <Property Name=\"LowerBoundaryIncluded\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"The lower boundary value is included in the interval\" />\r\n        </Property>\r\n        <Property Name=\"UpperBoundary\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the upper interval boundary\" />\r\n        </Property>\r\n        <Property Name=\"UpperBoundaryIncluded\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"The upper boundary value is included in the interval\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"ResultContext\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>The annotated entity type has one or more containment navigation properties.\r\n            An instance of the annotated entity type provides the context required for determining\r\n            the target entity sets reached by these containment navigation properties.</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n\r\n      <!-- Section: Value Help -->\r\n      <Term Name=\"ValueList\" Type=\"Common.ValueListType\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Core.Description\" String=\"Specifies how to get a list of acceptable values for a property or parameter\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The value list can be based on user input that is passed in the value list request. The value list can be used for type-ahead and classical pick lists.\" />\r\n      </Term>\r\n      <ComplexType Name=\"ValueListType\">\r\n        <!--\r\n          Example: Value list for currency code using entity set Currencies with properties Code, Text, Symbol and more\r\n          that are not needed in the value list\r\n          - CollectionPath: Currencies\r\n          - SearchSupported: true\r\n          - Parameters:\r\n          - - InOut: LocalDataProperty = CurrencyCode, ValueListPropert = Code\r\n\r\n          Example: Region within Country using entity set Regions with properties Code, Name, CountryCode\r\n          - CollectionPath: Regions\r\n          - SearchSupported: false\r\n          - Parameters:\r\n          - - InOut: LocalDataProperty = CountryCode, ValueListProperty = CountryCode\r\n          - - InOut: LocalDataProperty = RegionCode, ValueListProperty = Code\r\n        -->\r\n        <Property Name=\"Label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Headline for value list, fallback is the label of the property or parameter\" />\r\n        </Property>\r\n        <Property Name=\"CollectionPath\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Resource path of an OData collection with possible values, relative to CollectionRoot\" />\r\n        </Property>\r\n        <Property Name=\"CollectionRoot\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Service root of the value list collection; not specified means local to the document containing the annotation\" />\r\n        </Property>\r\n        <Property Name=\"SearchSupported\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value list supports the $search query option\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"The value of the target property is used as the search expression instead of in $filter\" />\r\n        </Property>\r\n        <Property Name=\"PresentationVariantQualifier\" Type=\"Common.SimpleIdentifier\">\r\n          <Annotation Term=\"Core.Description\" String=\"Alternative representation of a value help, e.g. as a bar chart\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Qualifier for annotation with term com.sap.vocabularies.UI.v1.PresentationVariant on the entity set identified via CollectionPath\" />\r\n        </Property>\r\n        <Property Name=\"SelectionVariantQualifier\" Type=\"Common.SimpleIdentifier\">\r\n          <Annotation Term=\"Common.Experimental\" String=\"Requested by Markus Königstein\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Optional combination of parameters and filters to query the value help entity set\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Qualifier for annotation with term com.sap.vocabularies.UI.v1.SelectionVariant on the entity set identified via CollectionPath\" />\r\n        </Property>\r\n        <Property Name=\"Parameters\" Type=\"Collection(Common.ValueListParameter)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Instructions on how to construct the value list request and consume response properties\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"ValueListWithFixedValues\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"If specified as true, there's only one value list mapping and its value list consists of a small number of fixed values\" />\r\n      </Term>\r\n\r\n      <Term Name=\"ValueListReferences\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Core.IsURL\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A list of URLs of CSDL documents containing value list mappings for this parameter or property\" />\r\n      </Term>\r\n\r\n      <Term Name=\"ValueListMapping\" Type=\"Common.ValueListMappingType\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Specifies the mapping between data service properties and value list properties\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The value list can be filtered based on user input. It can be used for type-ahead and classical pick lists. There may be many alternative mappings with different qualifiers.\" />\r\n      </Term>\r\n      <ComplexType Name=\"ValueListMappingType\">\r\n        <Property Name=\"Label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Headline for value list, fallback is the label of the property or parameter\" />\r\n        </Property>\r\n        <Property Name=\"CollectionPath\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Resource path of an OData collection with possible values, relative to the document containing the value list mapping\" />\r\n        </Property>\r\n        <Property Name=\"PresentationVariantQualifier\" Type=\"Common.SimpleIdentifier\">\r\n          <Annotation Term=\"Core.Description\" String=\"Alternative representation of a value help, e.g. as a bar chart\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Qualifier for annotation with term com.sap.vocabularies.UI.v1.PresentationVariant on the value list entity set identified via CollectionPath in the ValueListReference annotation\" />\r\n        </Property>\r\n        <Property Name=\"SelectionVariantQualifier\" Type=\"Common.SimpleIdentifier\">\r\n          <Annotation Term=\"Common.Experimental\" String=\"Requested by Markus Königstein\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Optional combination of parameters and filters to query the value help entity set\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Qualifier for annotation with term com.sap.vocabularies.UI.v1.SelectionVariant on the entity set identified via CollectionPath\" />\r\n        </Property>\r\n        <Property Name=\"Parameters\" Type=\"Collection(Common.ValueListParameter)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Instructions on how to construct the value list request and consume response properties\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"ValueListParameter\" Abstract=\"true\">\r\n        <Property Name=\"ValueListProperty\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Path to property in response structure. Format is identical to PropertyPath annotations.\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ValueListParameterIn\" BaseType=\"Common.ValueListParameter\">\r\n        <Property Name=\"LocalDataProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to property that is used to filter/search the value list\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ValueListParameterInOut\" BaseType=\"Common.ValueListParameter\">\r\n        <Property Name=\"LocalDataProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Path to property that is used to filter/search the value list or filled from response\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ValueListParameterOut\" BaseType=\"Common.ValueListParameter\">\r\n        <Property Name=\"LocalDataProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to property that is filled from response\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ValueListParameterDisplayOnly\" BaseType=\"Common.ValueListParameter\">\r\n        <Annotation Term=\"Core.Description\" String=\"Value list property that is not used to fill the edited entity\" />\r\n      </ComplexType>\r\n      <ComplexType Name=\"ValueListParameterFilterOnly\" BaseType=\"Common.ValueListParameter\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Value list property that is used to filter the value list, not connected to the edited entity\" />\r\n        <Annotation Term=\"Core.Revisions\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n              <PropertyValue Property=\"Description\" String=\"All filterable properties of the value list can be used to filter\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </ComplexType>\r\n\r\n      <!-- Section: Calendar Points in Time -->\r\n      <Term Name=\"IsCalendarYear\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a year number as string following the logical pattern (-?)YYYY(Y*) consisting of an optional\r\n            minus sign for years B.C. followed by at least four digits. The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarHalfyear\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a halfyear number as string following the logical pattern H consisting of a single digit.\r\n            The string matches the regex pattern [1-2]\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarQuarter\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar quarter number as string following the logical pattern Q consisting of a single digit.\r\n            The string matches the regex pattern [1-4]\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarMonth\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar month number as string following the logical pattern MM consisting of two digits.\r\n            The string matches the regex pattern 0[1-9]|1[0-2]\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarWeek\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar week number as string following the logical pattern WW consisting of two digits.\r\n            The string matches the regex pattern 0[1-9]|[1-4][0-9]|5[0-3]\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsDayOfCalendarMonth\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Day number relative to a calendar month. Valid values are between 1 and 31.\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.SByte\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsDayOfCalendarYear\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Day number relative to a calendar year. Valid values are between 1 and 366.\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.Int16\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarYearHalfyear\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar year and halfyear as string following the logical pattern (-?)YYYY(Y*)H consisting\r\n            of an optional minus sign for years B.C. followed by at least five digits, where the last digit represents the halfyear.\r\n            The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})[1-2]\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarYearQuarter\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar year and quarter as string following the logical pattern (-?)YYYY(Y*)Q consisting\r\n            of an optional minus sign for years B.C. followed by at least five digits, where the last digit represents the quarter.\r\n            The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})[1-4]\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarYearMonth\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar year and month as string following the logical pattern (-?)YYYY(Y*)MM consisting\r\n            of an optional minus sign for years B.C. followed by at least six digits, where the last two digits represent the months January to\r\n            December.\r\n            The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})(0[1-9]|1[0-2])\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarYearWeek\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar year and week as string following the logical pattern (-?)YYYY(Y*)WW consisting \r\n          of an optional minus sign for years B.C. followed by at least six digits, where the last two digits represent week number in the year.\r\n          The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})(0[1-9]|[1-4][0-9]|5[0-3]) \r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsCalendarDate\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a calendar date: year, month and day as string following the logical pattern (-?)YYYY(Y*)MMDD consisting \r\n          of an optional minus sign for years B.C. followed by at least eight digits, where the last four digits represent \r\n          the months January to December (MM) and the day of the month (DD).\r\n          The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])\r\n          The regex pattern does not reflect the additional constraint for \"Day-of-month Values\":\r\n          The day value must be no more than 30 if month is one of 04, 06, 09, or 11, no more than 28 if month is 02 and year is not divisible by 4, \r\n          or is divisible by 100 but not by 400, and no more than 29 if month is 02 and year is divisible by 400, or by 4 but not by 100.          \r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n\r\n\r\n      <!-- Section: Fiscal Points in Time -->\r\n      <Term Name=\"IsFiscalYear\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal year number as string following the logical pattern YYYY(Y*) consisting of at least four digits. \r\n          The string matches the regex pattern [1-9][0-9]{3,}\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalPeriod\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal period as string following the logical pattern PPP consisting of three digits. \r\n          The string matches the regex pattern [0-9]{3}\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalYearPeriod\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal year and period as string following the logical pattern YYYY(Y*)PPP consisting \r\n          of at least seven digits, where the last three digits represent the fiscal period in the year.\r\n          The string matches the regex pattern ([1-9][0-9]{3,})([0-9]{3})\r\n          </String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalQuarter\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/rsZCdg\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal quarter number as string following the logical pattern Q consisting of a single digit. \r\n          The string matches the regex pattern [1-4]</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalYearQuarter\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/rsZCdg\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal year and quarter as string following the logical pattern (-?)YYYY(Y*)Q consisting of\r\n          an optional minus sign for years B.C. followed by at least five digits, where the last digit represents the quarter. \r\n          The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})[1-4]</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalWeek\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/rsZCdg\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal week number as string following the logical pattern WW consisting of two digits. \r\n          The string matches the regex pattern 0[1-9]|[1-4][0-9]|5[0-3]</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalYearWeek\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/rsZCdg\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Property encodes a fiscal year and week as string following the logical pattern (-?)YYYY(Y*)WW consisting of an\r\n          optional minus sign for years B.C. followed by at least six digits, where the last two digits represent week number in the year. \r\n          The string matches the regex pattern -?([1-9][0-9]{3,}|0[0-9]{3})(0[1-9]|[1-4][0-9]|5[0-3])</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsDayOfFiscalYear\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"https://wiki.wdf.sap.corp/wiki/x/rsZCdg\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Day number relative to a fiscal year. Valid values are between 1 and 371.</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n      <Term Name=\"IsFiscalYearVariant\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"Property encodes a fiscal year variant\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n        <Annotation Term=\"Common.MutuallyExclusiveTerm\" Qualifier=\"DatePart\" />\r\n      </Term>\r\n\r\n\r\n      <!-- Section: Term Constraints -->\r\n      <Term Name=\"MutuallyExclusiveTerm\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Term\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Only one term of the group identified with the Qualifier attribute can be applied\" />\r\n      </Term>\r\n\r\n\r\n      <!-- Section: Draft Handling -->\r\n      <Term Name=\"DraftRoot\" Type=\"Common.DraftRootType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Root entities of business documents that support the draft pattern</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"DraftRootType\" BaseType=\"Common.DraftNodeType\">\r\n        <Property Name=\"ActivationAction\" Type=\"Common.QualifiedName\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Action that activates a draft document\" />\r\n        </Property>\r\n        <Property Name=\"EditAction\" Type=\"Common.QualifiedName\">\r\n          <Annotation Term=\"Core.Description\" String=\"Action that creates an edit draft\" />\r\n        </Property>\r\n        <Property Name=\"NewAction\" Type=\"Common.QualifiedName\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Action that creates a new draft. It may have overloads that allow referencing other business documents that are used to pre-fill the new draft\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"New drafts may also be created by POSTing an empty entity without any properties to the entity set.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"DraftNode\" Type=\"Common.DraftNodeType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Entities in this set are parts of business documents that support the draft pattern</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"DraftNodeType\">\r\n        <Property Name=\"PreparationAction\" Type=\"Common.QualifiedName\">\r\n          <Annotation Term=\"Core.Description\" String=\"Action that prepares a draft document for later activation\" />\r\n        </Property>\r\n        <Property Name=\"ValidationFunction\" Type=\"Common.QualifiedName\">\r\n          <Annotation Term=\"Core.Revisions\">\r\n            <Annotation Term=\"Common.Experimental\" />\r\n            <Collection>\r\n              <Record>\r\n                <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n                <PropertyValue Property=\"Description\"\r\n                  String=\"Use `PreparationAction` instead which can as a side-effect auto-fill missing information\" />\r\n              </Record>\r\n            </Collection>\r\n          </Annotation>\r\n          <Annotation Term=\"Core.Description\" String=\"Function that validates whether a draft document is ready for activation\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"DraftActivationVia\" Type=\"Collection(Common.SimpleIdentifier)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Draft entities in this set are indirectly activated via draft entities in the referenced entity sets\" />\r\n      </Term>\r\n\r\n      <TypeDefinition Name=\"SimpleIdentifier\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"The SimpleIdentifier of an OData construct in scope\" />\r\n      </TypeDefinition>\r\n\r\n      <TypeDefinition Name=\"QualifiedName\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"The QualifiedName of an OData construct in scope\" />\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"SemanticKey\" AppliesTo=\"EntityType\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The listed properties form the semantic key, i.e. they are unique modulo IsActiveEntity\" />\r\n      </Term>\r\n\r\n      <Term Name=\"SideEffects\" Type=\"Common.SideEffectsType\" AppliesTo=\"EntitySet EntityType ComplexType Action\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes side-effects of modification operations\" />\r\n      </Term>\r\n      <ComplexType Name=\"SideEffectsType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Changes to the source properties or source entities may have side-effects on the target properties or entities.\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>If neither TargetProperties nor TargetEntities are specified, a change to the source property values may have unforeseeable side-effects.\r\nAn empty NavigationPropertyPath may be used in TargetEntities to specify that any property of the annotated entity type may be affected.\r\n            \r\nSpecial case \"Actions\": here the change trigger is the action invocation, so SourceProperties and SourceEntities have no meaning, \r\nonly TargetProperties and TargetEntities are relevant. They are addressed via the binding parameter of the action.</String>\r\n        </Annotation>\r\n        <Property Name=\"SourceProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Changes to the values of one or more of these properties will affect the targets\" />\r\n        </Property>\r\n        <Property Name=\"SourceEntities\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Changes to one or more of these entities will affect the targets. An empty path means the annotation target.\" />\r\n        </Property>\r\n        <Property Name=\"TargetProperties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"These properties will be affected if the value of one of the sources changes\" />\r\n        </Property>\r\n        <Property Name=\"TargetEntities\" Type=\"Collection(Edm.NavigationPropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"These entities will be affected if the value of one of the sources changes. An empty path means the annotation target.\" />\r\n        </Property>\r\n        <Property Name=\"EffectTypes\" Type=\"Common.EffectType\">\r\n          <Annotation Term=\"Core.Revisions\">\r\n            <Annotation Term=\"Common.Experimental\" />\r\n            <Collection>\r\n              <Record>\r\n                <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n                <PropertyValue Property=\"Description\"\r\n                  String=\"All side effects are essentially value changes, differentiation not needed. Do not use together with `OnPreparation`.\" />\r\n              </Record>\r\n            </Collection>\r\n          </Annotation>\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"One or more of the targets may show these effects. If not specified, any effect is possible.\" />\r\n        </Property>\r\n        <Property Name=\"OnPreparation\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"true\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\" String=\"This side effect is deferred until invoking the Preparation action\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <EnumType Name=\"EffectType\" IsFlags=\"true\">\r\n        <Annotation Term=\"Core.Revisions\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n              <PropertyValue Property=\"Description\" String=\"`ValueChange` is the only surviving member\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n        <Member Name=\"ValidationMessage\" Value=\"1\">\r\n          <Annotation Term=\"Core.Revisions\">\r\n            <Annotation Term=\"Common.Experimental\" />\r\n            <Collection>\r\n              <Record>\r\n                <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n                <PropertyValue Property=\"Description\" String=\"Use `ValueChange` instead\" />\r\n              </Record>\r\n            </Collection>\r\n          </Annotation>\r\n          <Annotation Term=\"Core.Description\" String=\"Validation messages are assigned to a target\" />\r\n          <Annotation Term=\"Core.LongDescription\">\r\n            <String>This side effect type indicates that validation messages may result from changes of source properties or entities.  \r\nThus, a validation request can be sent either in conjunction with or separately after a modifying request. \r\nValidation messages shall be persisted with the draft and immediately available in a subsequent request without repeating the validation logic.</String>\r\n          </Annotation>\r\n        </Member>\r\n        <Member Name=\"ValueChange\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"The value of a target changes\" />\r\n          <Annotation Term=\"Core.LongDescription\">\r\n            <String>This side effect type declares that changes to source properties or entities may impact the values of any, one or multiple target properties or entities.  \r\nUpon modification preparation logic is performed that determines additional values to be stored in the draft document.</String>\r\n          </Annotation>\r\n        </Member>\r\n        <Member Name=\"FieldControlChange\" Value=\"4\">\r\n          <Annotation Term=\"Core.Revisions\">\r\n            <Annotation Term=\"Common.Experimental\" />\r\n            <Collection>\r\n              <Record>\r\n                <PropertyValue Property=\"Kind\" EnumMember=\"Core.RevisionKind/Deprecated\" />\r\n                <PropertyValue Property=\"Description\" String=\"Use `ValueChange` instead\" />\r\n              </Record>\r\n            </Collection>\r\n          </Annotation>\r\n          <Annotation Term=\"Core.Description\" String=\"The value of the Common.FieldControl annotation of a target changes\" />\r\n          <Annotation Term=\"Core.LongDescription\">\r\n            <String>This side effect type specifies that source properties or entities may impact the dynamic field control state of any, one or multiple target properties or entities.  \r\nUpon modification field control logic is invoked so that meta-information like hidden or read-only is determined.</String>\r\n          </Annotation>\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <!-- Section: Default Values -->\r\n      <Term Name=\"DerivedDefaultValue\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <!-- <Annotation Term=\"Common.IsFunctionImport\" /> -->\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Function import to derive a default value for the property from a given context.</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>\r\n            Function import has two parameters of complex types:\r\n\r\n            - `parameters`, a structure resembling the entity type the parameter entity set related to the entity set of the annotated property\r\n\r\n            - `properties`, a structure resembling the type of the entity set of the annotated property\r\n\r\n            The return type must be of the same type as the annotated property.\r\n\r\n            Arguments passed to the function import are used as context for deriving the default value. \r\n            The function import returns this default value, or null in case such a value could not be determined.\r\n          </String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"FilterDefaultValue\" Type=\"Edm.PrimitiveType\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"A default value for the property to be used in filter expressions.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"FilterDefaultValueHigh\" Type=\"Edm.PrimitiveType\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\"\r\n          String=\"Requested by Roland Trapp as a counterpart to CDS annotation @Consumption.filter.defaultValueHigh\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"A default upper limit for the property to be used in 'less than or equal' filter expressions.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"DerivedFilterDefaultValue\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n        <!-- <Annotation Term=\"Common.IsFunctionImport\" /> -->\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Function import to derive a default value for the property from a given context in order to use it in filter expressions.</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>\r\n            Function import has two parameters of complex types:\r\n\r\n            - `parameters`, a structure resembling the entity type the parameter\r\n            entity set related to the entity set of the annotated property\r\n\r\n            - `properties`, a structure resembling the\r\n            type of the entity set of the annotated property\r\n\r\n            The return type must be of the same type as the annotated\r\n            property.\r\n\r\n            Arguments passed to the function import are used as context for deriving the default value.\r\n            The function import returns this default value, or null in case such a value could not be determined.\r\n          </String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"SortOrder\" Type=\"Collection(Common.SortOrderType)\" Nullable=\"false\" AppliesTo=\"EntitySet EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"List of sort criteria\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>The items of the annotated entity set or the items of the \r\n          collection of the annotated entity type are sorted by the first entry of the SortOrder collection. \r\n          Items with same value for this first sort criteria are sorted by the second entry of the SortOrder collection, and so on. </String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"SortOrderType\">\r\n        <Property Name=\"Property\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Sort property\" />\r\n        </Property>\r\n        <Property Name=\"Descending\" Type=\"Edm.Boolean\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Sort direction, ascending if not specified otherwise\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <!-- under discussion with Heiko Theissen, Heiko Gerwens, Christoph Glania, and Ralf Dentzer\r\n        <Term Name=\"CacheControlProposal\" Type=\"Common.CacheControlProposalType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Core.Description\">\r\n        <String>Proposed values for the Cache-Control request header when accessing this entity set, see https://tools.ietf.org/html/rfc7234#section-5.2.1</String>\r\n        </Annotation>\r\n        </Term>\r\n        <ComplexType Name=\"CacheControlProposalType\">\r\n        <Property Name=\"MaxAge\" Type=\"Edm.Int32\">\r\n        <Annotation Term=\"Core.Description\"\r\n        String=\"Maximum acceptable age of the response in seconds, see https://tools.ietf.org/html/rfc7234#section-5.2.1.1\"\r\n        />\r\n        </Property>\r\n        </ComplexType>\r\n      -->\r\n\r\n      <Term Name=\"RecursiveHierarchy\" BaseTerm=\"Aggregation.RecursiveHierarchy\" Type=\"Common.RecursiveHierarchyType\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Defines a recursive hierarchy.</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"RecursiveHierarchyType\">\r\n        <Property Name=\"ExternalNodeKeyProperty\" Type=\"Edm.PropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the external human-readable key identifying the node\" />\r\n        </Property>\r\n        <Property Name=\"NodeDescendantCountProperty\" Type=\"Edm.PropertyPath\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Property holding the descendant count for a hierarchy node. \r\n            The descendant count of a node is the number of its descendants in the hierarchy structure of the result considering \r\n            only those nodes matching any specified $filter and $search. A property holding descendant counts has an integer \r\n            data type.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"NodeDrillStateProperty\" Type=\"Edm.PropertyPath\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Property holding the drill state of a hierarchy node. The drill state is indicated \r\n            by one of the following string values: collapsed, expanded, or leaf. For an expanded node, its \r\n            children are included in the result collection. For a collapsed node, the children are included in the entity set, but \r\n            they are not part of the result collection. Retrieving them requires a relaxed filter expression or a separate request \r\n            filtering on the parent node ID with the ID of the collapsed node. A leaf does not have any child in the entity set.\r\n            </String>\r\n          </Annotation>\r\n        </Property>\r\n      </ComplexType>\r\n\r\n\r\n      <!-- Metadata annotations that can also appear as instance annotations -->\r\n\r\n      <Term Name=\"CreatedAt\" Type=\"Edm.DateTimeOffset\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Creation timestamp\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <Term Name=\"CreatedBy\" Type=\"Common.UserID\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"First editor\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <Term Name=\"ChangedAt\" Type=\"Edm.DateTimeOffset\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Last modification timestamp\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <Term Name=\"ChangedBy\" Type=\"Common.UserID\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Last editor\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </Term>\r\n      <TypeDefinition Name=\"UserID\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Core.Description\" String=\"User ID\" />\r\n        <Annotation Term=\"Common.IsInstanceAnnotation\" />\r\n      </TypeDefinition>\r\n\r\n\r\n      <!-- Metadata annotations for converters -->\r\n\r\n      <Term Name=\"OriginalProtocolVersion\" Type=\"Edm.String\" AppliesTo=\"Schema\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Original protocol version of a converted (V4) CSDL document, allowed values `2.0` and `3.0`\" />\r\n      </Term>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_SAP_VOCABULARY_3 @"﻿<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"com.sap.vocabularies.Communication.v1\" Alias=\"Communication\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms for annotating communication-relevant information</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.LongDescription\">\r\n        <String>\r\nThese terms are inspired by\r\n- RFC6350 vCard (http://tools.ietf.org/html/rfc6350)\r\n- RFC5545 iCalendar (http://tools.ietf.org/html/rfc5545)\r\n- RFC5322 Internet Message Format (http://tools.ietf.org/html/rfc5322)\r\n- RFC6351 xCard: vCard XML Representation (https://tools.ietf.org/html/rfc6351)\r\n        </String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Description\" Qualifier=\"Published\">\r\n        <String>2017-02-15 © Copyright 2013 SAP AG. All rights reserved</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://wiki.scn.sap.com/wiki/download/attachments/448470971/Communication.xml?api=v2\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/x/ux_7Gg\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"Contact\" Type=\"Communication.ContactType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Address book entry\" />\r\n      </Term>\r\n      <ComplexType Name=\"ContactType\">\r\n        <Property Name=\"fn\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Full name\" />\r\n        </Property>\r\n        <Property Name=\"n\" Type=\"Communication.NameType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Name\" />\r\n        </Property>\r\n        <Property Name=\"nickname\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Nickname\" />\r\n        </Property>\r\n        <Property Name=\"photo\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Image or photograph\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"bday\" Type=\"Edm.Date\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Birthday\" />\r\n        </Property>\r\n        <Property Name=\"anniversary\" Type=\"Edm.Date\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Date of marriage, or equivalent\" />\r\n        </Property>\r\n        <Property Name=\"gender\" Type=\"Communication.GenderType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Sex and gender identity\" />\r\n        </Property>\r\n\r\n        <Property Name=\"title\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Position or job title\" />\r\n        </Property>\r\n        <Property Name=\"role\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Function or part played in a particular situation\" />\r\n        </Property>\r\n        <Property Name=\"org\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Organization Name defined by X.520\" />\r\n        </Property>\r\n        <Property Name=\"orgunit\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Organization Unit defined by X.520\" />\r\n        </Property>\r\n\r\n        <Property Name=\"kind\" Type=\"Communication.KindType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Kind of contact\" />\r\n        </Property>\r\n\r\n        <Property Name=\"note\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Supplemental information or a comment associated with the contact\" />\r\n        </Property>\r\n\r\n        <Property Name=\"adr\" Type=\"Collection(Communication.AddressType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Addresses\" />\r\n        </Property>\r\n        <Property Name=\"tel\" Type=\"Collection(Communication.PhoneNumberType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Phone numbers\" />\r\n        </Property>\r\n        <Property Name=\"email\" Type=\"Collection(Communication.EmailAddressType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Email addresses\" />\r\n        </Property>\r\n        <Property Name=\"geo\" Type=\"Collection(Communication.GeoDataType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Geographic locations\" />\r\n        </Property>\r\n        <Property Name=\"url\" Type=\"Collection(Communication.UrlType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"URLs\" />\r\n        </Property>\r\n        <!-- TODO: social networks - yet reflected in VCARD? -->\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"NameType\">\r\n        <Property Name=\"surname\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Surname or family name\" />\r\n        </Property>\r\n        <Property Name=\"given\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Given name\" />\r\n        </Property>\r\n        <Property Name=\"additional\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Additional names\" />\r\n        </Property>\r\n        <Property Name=\"prefix\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Honorific prefix(es)\" />\r\n        </Property>\r\n        <Property Name=\"suffix\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Honorific suffix(es)\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Address\" Type=\"Communication.AddressType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Address\" />\r\n      </Term>\r\n      <ComplexType Name=\"AddressType\">\r\n        <Property Name=\"building\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Building identifier\" />\r\n        </Property>\r\n        <Property Name=\"street\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Street address\" />\r\n        </Property>\r\n        <Property Name=\"district\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Territorial administrative organization in a large city\" />\r\n        </Property>\r\n        <Property Name=\"locality\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"City or similar\" />\r\n        </Property>\r\n        <Property Name=\"region\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"State, province, or similar\" />\r\n        </Property>\r\n        <Property Name=\"code\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Postal code\" />\r\n        </Property>\r\n        <Property Name=\"country\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Country name\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"pobox\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Post office box\" />\r\n        </Property>\r\n        <Property Name=\"ext\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Extended address (e.g., apartment or suite number)\" />\r\n        </Property>\r\n        <Property Name=\"careof\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"An intermediary who is responsible for transferring a piece of mail between the postal system and the final addressee\" />\r\n        </Property>\r\n        <Property Name=\"label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Delivery address label; plain-text string representing the formatted address, may contain line breaks\" />\r\n        </Property>\r\n        <Property Name=\"type\" Type=\"Communication.ContactInformationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Address type\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"PhoneNumberType\">\r\n        <Property Name=\"uri\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"This SHOULD use the tel: URL schema defined in RFC3966\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"type\" Type=\"Communication.PhoneType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Telephone type\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"EmailAddressType\">\r\n        <Property Name=\"address\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Email address\" />\r\n        </Property>\r\n        <Property Name=\"type\" Type=\"Communication.ContactInformationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Address type\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"GeoDataType\">\r\n        <Property Name=\"uri\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"This SHOULD use the geo: URL schema defined in RFC5870 which encodes the same information as an Edm.GeographyPoint\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"type\" Type=\"Communication.ContactInformationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Address type\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"UrlType\">\r\n        <Property Name=\"uri\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"This MUST use the URL schema defined in RFC3986\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"type\" Type=\"Communication.ContactInformationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"URL type\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"KindType\">\r\n        <Member Name=\"individual\">\r\n          <Annotation Term=\"Core.Description\" String=\"A single person or entity\" />\r\n        </Member>\r\n        <Member Name=\"group\">\r\n          <Annotation Term=\"Core.Description\" String=\"A group of persons or entities\" />\r\n        </Member>\r\n        <Member Name=\"org\">\r\n          <Annotation Term=\"Core.Description\" String=\"An organization\" />\r\n        </Member>\r\n        <Member Name=\"location\">\r\n          <Annotation Term=\"Core.Description\" String=\"A named geographical place\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <EnumType Name=\"ContactInformationType\" IsFlags=\"true\">\r\n        <Member Name=\"work\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Related to an individual's work place\" />\r\n        </Member>\r\n        <Member Name=\"home\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Related to an indivdual's personal life\" />\r\n        </Member>\r\n        <Member Name=\"preferred\" Value=\"4\">\r\n          <Annotation Term=\"Core.Description\" String=\"Preferred-use contact information\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <EnumType Name=\"PhoneType\" IsFlags=\"true\">\r\n        <Member Name=\"work\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Work telephone number\" />\r\n        </Member>\r\n        <Member Name=\"home\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Private telephone number\" />\r\n        </Member>\r\n        <Member Name=\"preferred\" Value=\"4\">\r\n          <Annotation Term=\"Core.Description\" String=\"Preferred-use telephone number\" />\r\n        </Member>\r\n        <Member Name=\"voice\" Value=\"8\">\r\n          <Annotation Term=\"Core.Description\" String=\"Voice telephone number\" />\r\n        </Member>\r\n        <Member Name=\"cell\" Value=\"16\">\r\n          <Annotation Term=\"Core.Description\" String=\"Cellular or mobile telephone number\" />\r\n        </Member>\r\n        <Member Name=\"fax\" Value=\"32\">\r\n          <Annotation Term=\"Core.Description\" String=\"Facsimile telephone number\" />\r\n        </Member>\r\n        <Member Name=\"video\" Value=\"64\">\r\n          <Annotation Term=\"Core.Description\" String=\"Video conferencing telephone number\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <EnumType Name=\"GenderType\">\r\n        <Member Name=\"M\">\r\n          <Annotation Term=\"Core.Description\" String=\"male\" />\r\n        </Member>\r\n        <Member Name=\"F\">\r\n          <Annotation Term=\"Core.Description\" String=\"female\" />\r\n        </Member>\r\n        <Member Name=\"O\">\r\n          <Annotation Term=\"Core.Description\" String=\"other\" />\r\n        </Member>\r\n        <Member Name=\"N\">\r\n          <Annotation Term=\"Core.Description\" String=\"not applicable\" />\r\n        </Member>\r\n        <Member Name=\"U\">\r\n          <Annotation Term=\"Core.Description\" String=\"unknown\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"IsEmailAddress\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains an email address\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsPhoneNumber\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains a phone number\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Event\" Type=\"Communication.EventData\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Calendar entry\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"EventData\">\r\n        <Property Name=\"summary\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Short description of the event\" />\r\n        </Property>\r\n        <Property Name=\"description\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"More complete description\" />\r\n        </Property>\r\n        <Property Name=\"categories\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Categories or subtypes of the event\" />\r\n        </Property>\r\n        <Property Name=\"dtstart\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Start date and time of the event\" />\r\n        </Property>\r\n        <Property Name=\"dtend\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Date and time by which the event ends, alternative to duration\" />\r\n        </Property>\r\n        <Property Name=\"duration\" Type=\"Edm.Duration\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Duration of the event, alternative to dtend\" />\r\n        </Property>\r\n        <Property Name=\"class\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Access classification, e.g. PUBLIC, PRIVATE, CONFIDENTIAL\" />\r\n        </Property>\r\n        <Property Name=\"status\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Confirmation status, e.g. CONFIRMED, TENTATIVE, CANCELLED\" />\r\n        </Property>\r\n        <Property Name=\"location\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Intended venue of the event\" />\r\n        </Property>\r\n        <Property Name=\"transp\" Type=\"Edm.Boolean\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Time transparency for busy time searches, true = free, false = blocked\" />\r\n        </Property>\r\n        <Property Name=\"wholeday\" Type=\"Edm.Boolean\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Wholeday event\" />\r\n        </Property>\r\n        <Property Name=\"fbtype\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Free or busy time type, e.g. FREE, BUSY, BUSY-TENTATIVE\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Task\" Type=\"Communication.TaskData\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Task list entry\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"TaskData\">\r\n        <Property Name=\"summary\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Short description of the task\" />\r\n        </Property>\r\n        <Property Name=\"description\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"More complete description of the task\" />\r\n        </Property>\r\n        <Property Name=\"due\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Date and time that a to-do is expected to be completed\" />\r\n        </Property>\r\n        <Property Name=\"completed\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Date and time that a to-do was actually completed\" />\r\n        </Property>\r\n        <Property Name=\"percentcomplete\" Type=\"Edm.Byte\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Percent completion of a to-do, e.g. 50 for half done\" />\r\n        </Property>\r\n        <Property Name=\"priority\" Type=\"Edm.Byte\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Relative priority, 0 = undefined, 1 = highest, 9 = lowest\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Message\" Type=\"Communication.MessageData\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Email message\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"MessageData\">\r\n        <Property Name=\"from\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Author(s) of the message\" />\r\n        </Property>\r\n        <Property Name=\"sender\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Agent responsible for the actual transmission of the message, e.g. a secretary\" />\r\n        </Property>\r\n        <Property Name=\"to\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of primary recipients\" />\r\n        </Property>\r\n        <Property Name=\"cc\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of other recipients (carbon copy)\" />\r\n        </Property>\r\n        <Property Name=\"bcc\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"List of recipients whose addresses are not to be revealed (blind carbon copy)\" />\r\n        </Property>\r\n        <Property Name=\"subject\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Topic of the message\" />\r\n        </Property>\r\n        <Property Name=\"body\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Main part of the message\" />\r\n        </Property>\r\n        <Property Name=\"keywords\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of important words and phrases that might be useful for the recipient\" />\r\n        </Property>\r\n        <Property Name=\"received\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Date and time the message was received\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_SAP_VOCABULARY_4 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Aggregation.V1.xml\">\r\n    <edmx:Include Alias=\"Aggregation\" Namespace=\"Org.OData.Aggregation.V1\" />\r\n  </edmx:Reference>\r\n\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"com.sap.vocabularies.Hierarchy.v1\" Alias=\"Hierarchy\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms for Hierarchies</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Description\" Qualifier=\"Published\">\r\n        <String>2018-01-31 © Copyright 2018 SAP SE. All rights reserved</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <!-- TODO: replace with SCN link once published -->\r\n            <PropertyValue Property=\"href\" String=\"https://github.wdf.sap.corp/pages/odata/vocabularies/Hierarchy.xml\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <!-- TODO: replace with SCN link once published -->\r\n            <PropertyValue Property=\"href\" String=\"https://github.wdf.sap.corp/odata/vocabularies/blob/master/Hierarchy.md\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <Term Name=\"RecursiveHierarchy\" Type=\"Hierarchy.RecursiveHierarchyType\" BaseTerm=\"Aggregation.RecursiveHierarchy\" AppliesTo=\"EntityType ComplexType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Defines a recursive hierarchy.\" />\r\n      </Term>\r\n      <ComplexType Name=\"RecursiveHierarchyType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Property Name=\"ParentNodeProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the parent hierarchy node value\" />\r\n        </Property>\r\n        <Property Name=\"ExternalKeyProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the external key value for a node\" />\r\n        </Property>\r\n        <Property Name=\"ValueProperty\" Type=\"Edm.PropertyPath\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property for whose values the hierarchy is defined\" />\r\n        </Property>\r\n        <Property Name=\"DescendantCountProperty\" Type=\"Edm.PropertyPath\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the number of descendants of a node\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"The descendant count of a node is the number of its descendants in the hierarchy structure of the result considering only those nodes matching any specified $filter and $search. A property holding descendant counts has an integer data type.\" />\r\n        </Property>\r\n        <Property Name=\"DrillStateProperty\" Type=\"Edm.PropertyPath\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the drill state of a node\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"The drill state is indicated by one of the following string values: `collapsed`, `expanded`, `leaf`. For an expanded node, its children are included in the result collection. For a collapsed node, the children are included in the entity set, but they are not part of the result collection. Retrieving them requires a relaxed filter expression or a separate request filtering on the parent node ID with the ID of the collapsed node. A leaf does not have any child in the entity set.\" />\r\n        </Property>\r\n        <Property Name=\"SiblingRankProperty\" Type=\"Edm.PropertyPath\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the sibling rank of a node\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"The sibling rank of a node is the index of the node in the sequence of all nodes with the same parent created by preorder traversal of the hierarchy structure after evaluating the $filter expression in the request excluding any conditions on key properties. The first sibling is at position 0.\" />\r\n        </Property>\r\n        <Property Name=\"PreorderRankProperty\" Type=\"Edm.PropertyPath\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Property holding the preorder rank of a node\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"The preorder rank of a node expresses its position in the sequence of nodes created from preorder traversal of the hierarchy structure after evaluating the $filter expression in the request excluding any conditions on key properties. The first node in preorder traversal has rank 0.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_SAP_VOCABULARY_5 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Alias=\"Core\" Namespace=\"Org.OData.Core.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml\">\r\n    <edmx:Include Alias=\"Validation\" Namespace=\"Org.OData.Validation.V1\" />\r\n  </edmx:Reference>\r\n\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"com.sap.vocabularies.PersonalData.v1\" Alias=\"PersonalData\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms for annotating Personal Data</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Description\" Qualifier=\"Published\">\r\n        <String>2018-01-24 © Copyright 2018 SAP SE. All rights reserved</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\"\r\n              String=\"https://wiki.scn.sap.com/wiki/download/attachments/496435637/PersonalData.xml?api=v2\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/x/tQGXHQ\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.LongDescription\">\r\n        <String>\r\n## Definition\r\n\r\nPersonal Data is any information relating to an identified or identifiable natural person (\"data subject\"). \r\n\r\nAn identifiable natural person is one who can be identified, directly or indirectly, in particular by reference to an identifier such as a name, an identification number, location data, an online identifier, or to one or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.\r\n\r\nPersonal data can only be processed under certain legal grounds, e.g. explicit consent of the data subject or a contractual obligation.\r\n\r\nThis vocabulary defines terms specific to the European [General Data Protection Regulation (GDPR)](https://ec.europa.eu/info/law/law-topic/data-protection_en).\r\n\r\nTerms for contact and address information are defined in the [Communication vocabulary](Communication.md#).\r\n\r\n### References\r\n- [European Commission: Reform of EU data protection rules](https://ec.europa.eu/info/law/law-topic/data-protection/reform_en)\r\n- [European Commission: Rules for business and organisations](https://ec.europa.eu/info/law/law-topic/data-protection/reform/rules-business-and-organisations_en)\r\n- [European Commission: Legal grounds for processing data](https://ec.europa.eu/info/law/law-topic/data-protection/reform/rules-business-and-organisations/legal-grounds-processing-data_en).\r\n       </String>\r\n      </Annotation>\r\n\r\n      <Term Name=\"EntitySemantics\" Type=\"PersonalData.EntitySemanticsType\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Primary meaning of the entities in the annotated entity set\" />\r\n      </Term>\r\n      <Term Name=\"DataSubjectRole\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Role of the data subjects in this set (e.g. employee, customer)\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Values are application-specific.         \r\n          Can be a static value or a `Path` expression If the role varies per entity</String>\r\n        </Annotation>\r\n      </Term>\r\n      <Term Name=\"DataSubjectRoleDescription\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Language-dependent description of the role of the data subjects in this set (e.g. employee, customer)\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Values are application-specific.         \r\n          Can be a static value or a `Path` expression If the role varies per entity</String>\r\n        </Annotation>\r\n      </Term>\r\n      <TypeDefinition Name=\"EntitySemanticsType\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Primary meaning of the data contained in the annotated entity set\" />\r\n        <Annotation Term=\"Validation.AllowedValues\">\r\n          <Collection>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"DataSubject\" />\r\n              <Annotation Term=\"Core.Description\">\r\n                <String>The entities of this set describe a data subject (an identified or identifiable natural person), e.g. Customer, Vendor</String>\r\n              </Annotation>\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>These entities are relevant for audit logging. There are no restrictions on their structure. The properties should be annotated suitably with [FieldSemantics](#FieldSemantics).</String>\r\n              </Annotation>\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"DataSubjectDetails\" />\r\n              <Annotation Term=\"Core.Description\">\r\n                <String>The entities of this set contain details to a data subject (an identified or identifiable natural person) but do not by themselves identify/describe a data subject, e.g. CustomerAddress</String>\r\n              </Annotation>\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>These entities are relevant for audit logging. There are no restrictions on their structure. The properties should be annotated suitably with [FieldSemantics](#FieldSemantics).</String>\r\n              </Annotation>\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"Consent\" />\r\n              <Annotation Term=\"Core.Description\" String=\"The entities of this set represent a consent\" />\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>A consent is the action of the data subject confirming that \r\n                the usage of his or her personal data shall be allowed for a given purpose. \r\n                A consent functionality allows the storage of a consent record in relation \r\n                to a specific purpose and shows if a data subject has granted, withdrawn, \r\n                or denied consent.\r\n                \r\n                A purpose is the information that specifies the reason and the goal for the\r\n                processing of a specific set of personal data. As a rule, the purpose\r\n                references the relevant legal basis for the processing of personal data.</String>\r\n              </Annotation>\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"ConsentRelated\" />\r\n              <Annotation Term=\"Core.Description\"\r\n                String=\"The entities of this set represent data whose processing is related to an explicit consent\" />\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"ContractRelated\" />\r\n              <Annotation Term=\"Core.Description\" String=\"The entities of this set represent data that is related to a contract\" />\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>A contract is a long-term agreement with customers that allows them to buy goods or services at special conditions, such as lower prices, based on specific terms that have been negotiated beforehand. Products or services are released (ordered, or called off) from a contract over a certain timeframe.  \r\n\r\nTypes of contracts include:\r\n\r\n- Sales contracts\r\n\r\n- Lease contracts\r\n\r\n- Service contracts\r\n              </String>\r\n              </Annotation>\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"FieldSemantics\" Type=\"PersonalData.FieldSemanticsType\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Primary meaning of the personal data contained in the annotated property\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Changes to values of annotated properties are tracked in the audit log.&#xA;&#xA;*TODO: cross-check with Wolfgang Koch: this annotation SHOULD NOT be necessary on fields that are already marked as being contact data (name, phone number, email address, birthday, ...) or address data (street, city, ...)*\" />\r\n      </Term>\r\n      <TypeDefinition Name=\"FieldSemanticsType\" UnderlyingType=\"Edm.String\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Primary meaning of a data field\" />\r\n        <Annotation Term=\"Validation.AllowedValues\">\r\n          <Collection>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"DataSubjectID\" />\r\n              <Annotation Term=\"Core.Description\" String=\"The unique identifier for a data subject\" />\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"DataSubjectIDType\" />\r\n              <Annotation Term=\"Core.Description\"\r\n                String=\"The type of ID identifying the data subject and which is allocated when creating a consent record, e.g. an e-mail address or a phone number.\" />\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"ConsentID\" />\r\n              <Annotation Term=\"Core.Description\" String=\"The unique identifier for a consent\" />\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>A consent is the action of the data subject confirming that \r\n                the usage of his or her personal data shall be allowed for a given purpose. \r\n                A consent functionality allows the storage of a consent record in relation \r\n                to a specific purpose and shows if a data subject has granted, withdrawn, \r\n                or denied consent.</String>\r\n              </Annotation>\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"ConsentPurposeID\" />\r\n              <Annotation Term=\"Core.Description\" String=\"The unique identifier for the purpose of a consent\" />\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>The purpose of a consent is the information that specifies the reason and the goal for\r\n                the processing of a specific set of personal data. As a rule, the purpose\r\n                references the relevant legal basis for the processing of personal data.</String>\r\n              </Annotation>\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"ContractRelatedID\" />\r\n              <Annotation Term=\"Core.Description\"\r\n                String=\"The unique identifier for transactional data that is related to a contract that requires processing of personal data\" />\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>Examples:\r\n\r\n                - Sales Contract ID\r\n\r\n                - Purchase Contract ID\r\n\r\n                - Service Contract ID\r\n                </String>\r\n              </Annotation>\r\n            </Record>\r\n            <Record>\r\n              <Annotation Term=\"Common.Experimental\" />\r\n              <PropertyValue Property=\"Value\" String=\"LegalEntityID\" />\r\n              <Annotation Term=\"Core.Description\" String=\"The unique identifier of a legal entity\" />\r\n              <Annotation Term=\"Core.LongDescription\">\r\n                <String>A legal entity is a corporation, an association, or any other organization of legal capacity, which has statutory rights and responsibilities.</String>\r\n              </Annotation>\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"IsPotentiallyPersonal\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains potentially personal data\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Personal data is information relating to an identified or identifiable natural person (data subject).\r\n\r\nNote: properties annotated with [`FieldSemantics`](#FieldSemantics) need not be additionally annotated with this term.\r\n\r\nSee also: [What is personal data?](https://ec.europa.eu/info/law/law-topic/data-protection/reform/what-personal-data_en)</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"IsPotentiallySensitive\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains potentially sensitive personal data\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Sensitive data is a colloquial term usually including the following data:\r\n\r\n-  Special categories of personal data such as data revealing racial or ethnic origin, political opinions, religious or philosophical beliefs, or trade union membership, and the processing of genetic data, biometric data, data concerning health or sex life or sexual orientation\r\n\r\n-  Personal data subject to professional secrecy\r\n\r\n-  Personal data relating to criminal or administrative offences\r\n\r\n-  Personal data concerning bank or credit card accounts\r\n\r\nSee also: [What personal data is considered sensitive?](https://ec.europa.eu/info/law/law-topic/data-protection/reform/rules-business-and-organisations/legal-grounds-processing-data/sensitive-data/what-personal-data-considered-sensitive_en)</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <Term Name=\"IsUserID\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Property contains a user id\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"A user id is a unique identifier for an individual who interacts with the services supplied by a system\" />\r\n      </Term>\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>"
#define SODataV4_CsdlParser_SAP_VOCABULARY_6 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx Version=\"4.0\" xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\">\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n    <edmx:Include Namespace=\"Org.OData.Core.V1\" Alias=\"Core\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Validation.V1.xml\">\r\n    <edmx:Include Alias=\"Validation\" Namespace=\"Org.OData.Validation.V1\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://wiki.scn.sap.com/wiki/download/attachments/448470971/Communication.xml?api=v2\">\r\n    <edmx:Include Namespace=\"com.sap.vocabularies.Communication.v1\" Alias=\"Communication\" />\r\n  </edmx:Reference>\r\n  <edmx:Reference Uri=\"https://wiki.scn.sap.com/wiki/download/attachments/448470974/Common.xml?api=v2\">\r\n    <edmx:Include Namespace=\"com.sap.vocabularies.Common.v1\" Alias=\"Common\" />\r\n  </edmx:Reference>\r\n  <edmx:DataServices>\r\n    <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Alias=\"UI\" Namespace=\"com.sap.vocabularies.UI.v1\">\r\n      <Annotation Term=\"Core.Description\">\r\n        <String>Terms for presenting data in user interfaces</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Description\" Qualifier=\"Published\">\r\n        <String>2017-02-15 © Copyright 2013 SAP AG. All rights reserved</String>\r\n      </Annotation>\r\n      <Annotation Term=\"Core.Links\">\r\n        <Collection>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"latest-version\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/download/attachments/448470968/UI.xml?api=v2\" />\r\n          </Record>\r\n          <Record>\r\n            <PropertyValue Property=\"rel\" String=\"describedby\" />\r\n            <PropertyValue Property=\"href\" String=\"https://wiki.scn.sap.com/wiki/x/uB_7Gg\" />\r\n          </Record>\r\n        </Collection>\r\n      </Annotation>\r\n\r\n      <!-- Semantic Views / Perspectives -->\r\n\r\n      <Term Name=\"HeaderInfo\" Type=\"UI.HeaderInfoType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Information for the header area of an entity representation. HeaderInfo is mandatory for main entity types of the model\" />\r\n      </Term>\r\n      <ComplexType Name=\"HeaderInfoType\">\r\n        <Property Name=\"TypeName\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the main entity type\" />\r\n        </Property>\r\n        <Property Name=\"TypeNamePlural\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Plural form of the name of the main entity type\" />\r\n        </Property>\r\n        <Property Name=\"Title\" Type=\"UI.DataField\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Title, e.g. for overview pages\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"UI.DataField\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Description, e.g. for overview pages\" />\r\n        </Property>\r\n        <Property Name=\"ImageUrl\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsURL\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Image URL for an instance of the entity type. If the property ImageUrl has a valid value, it can be used for the visualization of the instance. If it is not available or not valid the property TypeImageUrl can be used instead.\" />\r\n        </Property>\r\n        <Property Name=\"TypeImageUrl\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsURL\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Image URL for the entity type\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Identification\" Type=\"Collection(UI.DataFieldAbstract)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of fields identifying the object\" />\r\n      </Term>\r\n\r\n      <Term Name=\"Badge\" Type=\"UI.BadgeType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Information usually displayed in the form of a business card\" />\r\n      </Term>\r\n      <ComplexType Name=\"BadgeType\">\r\n        <Property Name=\"HeadLine\" Type=\"UI.DataField\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Headline\" />\r\n        </Property>\r\n        <Property Name=\"Title\" Type=\"UI.DataField\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Title\" />\r\n        </Property>\r\n        <Property Name=\"ImageUrl\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsURL\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Image URL for an instance of the entity type. If the property ImageUrl has a valid value, it can be used for the visualization of the instance. If it is not available or not valid the property TypeImageUrl can be used instead.\" />\r\n        </Property>\r\n        <Property Name=\"TypeImageUrl\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsURL\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Image URL for the entity type\" />\r\n        </Property>\r\n        <Property Name=\"MainInfo\" Type=\"UI.DataField\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Main information on the business card\" />\r\n        </Property>\r\n        <Property Name=\"SecondaryInfo\" Type=\"UI.DataField\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Additional information on the business card\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"LineItem\" Type=\"Collection(UI.DataFieldAbstract)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of data fields for representation in a table or list\" />\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n      </Term>\r\n\r\n      <Term Name=\"StatusInfo\" Type=\"Collection(UI.DataFieldAbstract)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of data fields describing the status of an entity\" />\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n      </Term>\r\n\r\n      <Term Name=\"FieldGroup\" Type=\"UI.FieldGroupType\" AppliesTo=\"EntityType Action Function FunctionImport\">\r\n        <Annotation Term=\"Core.Description\" String=\"Group of fields with an optional label\" />\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n      </Term>\r\n      <ComplexType Name=\"FieldGroupType\">\r\n        <Property Name=\"Label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Label for the field group\" />\r\n        </Property>\r\n        <Property Name=\"Data\" Type=\"Collection(UI.DataFieldAbstract)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Collection of data fields\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"ConnectedFields\" Type=\"UI.ConnectedFieldsType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Group of semantically connected fields with a representation template and an optional label\" />\r\n        <!-- TODO: adapt to final resolution of https://issues.oasis-open.org/browse/ODATA-1194\r\n          <Annotation Term=\"Core.Example\">\r\n          <Record>\r\n          <Annotation Term=\"com.sap.vocabularies.UI.v1.ConnectedFields\" Qualifier=\"Material\">\r\n          <Record>\r\n          <PropertyValue Property=\"Label\" String=\"Material\" />\r\n          <PropertyValue Property=\"Template\" String=\"{MaterialName} - {MaterialClassName}\" />\r\n          <PropertyValue Property=\"Data\">\r\n          <Record>\r\n          <PropertyValue Property=\"MaterialName\">\r\n          <Record Type=\"com.sap.vocabularies.UI.v1.DataField\">\r\n          <PropertyValue Property=\"Value\" Path=\"Material\" />\r\n          </Record>\r\n          </PropertyValue>\r\n          <PropertyValue Property=\"MaterialClassName\">\r\n          <Record Type=\"com.sap.vocabularies.UI.v1.DataField\">\r\n          <PropertyValue Property=\"Value\" Path=\"MaterialClass\" />\r\n          </Record>\r\n          </PropertyValue>\r\n          </Record>\r\n          </PropertyValue>\r\n          </Record>\r\n          </Annotation>\r\n          </Record>\r\n          </Annotation>\r\n        -->\r\n      </Term>\r\n      <ComplexType Name=\"ConnectedFieldsType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Group of semantically connected fields with a representation template and an optional label\" />\r\n        <Property Name=\"Label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Label for the connected fields\" />\r\n        </Property>\r\n        <Property Name=\"Template\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Template for representing the connected fields\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Template variables are identifiers enclosed in curly braces, e.g. `{MaterialName} - {MaterialClassName}`. The `Data` collection assigns values to the template variables.\" />\r\n        </Property>\r\n        <Property Name=\"Data\" Type=\"Core.Dictionary\" Nullable=\"false\">\r\n          <Annotation Term=\"Validation.OpenPropertyTypeConstraint\">\r\n            <Collection>\r\n              <String>UI.DataFieldAbstract</String>\r\n            </Collection>\r\n          </Annotation>\r\n          <Annotation Term=\"Core.Description\" String=\"Dictionary of template variables\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Each template variable used in `Template` must be assigned a value here. The value must be of type [`UI.DataFieldAbstract`](#DataFieldAbstract)\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <!-- Under Discussion\r\n        <Term Name=\"GeoPoints\" Type=\"Collection(Edm.AnnotationPath)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\">\r\n        <String>\r\n        Each collection element MUST reference an annotation of a\r\n        - Communication.Contact or\r\n        - collection of Communication.ContactData or\r\n        - UI.Contacts or\r\n        - UI.GeoLocation or\r\n        - collection of UI.GeoLocationType\r\n        </String>\r\n        </Annotation>\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        </Term>\r\n      -->\r\n\r\n      <Term Name=\"GeoLocations\" Type=\"Collection(UI.GeoLocationType)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of geographic locations\" />\r\n      </Term>\r\n      <Term Name=\"GeoLocation\" Type=\"UI.GeoLocationType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Geographic location\" />\r\n      </Term>\r\n      <ComplexType Name=\"GeoLocationType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Properties that define a geographic location\" />\r\n        <Property Name=\"Latitude\" Type=\"Edm.Double\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Geographic latitude\" />\r\n        </Property>\r\n        <Property Name=\"Longitude\" Type=\"Edm.Double\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Geographic longitude\" />\r\n        </Property>\r\n        <Property Name=\"Location\" Type=\"Edm.GeographyPoint\" SRID=\"variable\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"A point in a round-earth coordinate system\" />\r\n        </Property>\r\n        <Property Name=\"Address\" Type=\"Communication.AddressType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"vCard-style address\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Contacts\" Type=\"Collection(Edm.AnnotationPath)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of contacts\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Each collection item MUST reference an annotation of a Communication.Contact\" />\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n      </Term>\r\n\r\n      <Term Name=\"MediaResource\" Type=\"UI.MediaResourceType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Properties that describe a media resource\" />\r\n      </Term>\r\n      <ComplexType Name=\"MediaResourceType\">\r\n        <Property Name=\"Url\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"URL of media resource\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"ContentType\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Content type, such as application/pdf, video/x-flv, image/jpeg\" />\r\n          <Annotation Term=\"Core.IsMediaType\" />\r\n        </Property>\r\n        <Property Name=\"ByteSize\" Type=\"Edm.Int64\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Resource size in bytes\" />\r\n        </Property>\r\n        <Property Name=\"ChangedAt\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Date of last change\" />\r\n        </Property>\r\n        <Property Name=\"Thumbnail\" Type=\"UI.ImageType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Thumbnail image\" />\r\n        </Property>\r\n        <Property Name=\"Title\" Type=\"UI.DataField\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Resource title\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"UI.DataField\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Resource description\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ImageType\">\r\n        <Property Name=\"Url\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"URL of image\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"Width\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Width of image\" />\r\n        </Property>\r\n        <Property Name=\"Height\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Height of image\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <!-- Under discussion\r\n        <Term Name=\"AdditionalInfo\" Type=\"Edm.AnnotationPath\" AppliesTo=\"Annotation\">\r\n        <Annotation Term=\"Core.Description\">\r\n        <String>\r\n        Applies to UI.GeoLocation and Communication.Contact annotations only\r\n        Provides additional related information for a UI.GeoLocation or Communication.Contact\r\n        Reference to UI.HeaderInfo, UI.Badge, a qualified UI.FieldGroup, or a dedicated property tagged with Core.IsURL\r\n        </String>\r\n        </Annotation>\r\n        </Term>\r\n      -->\r\n\r\n      <Term Name=\"DataPoint\" Type=\"UI.DataPointType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Visualization of a single point of data, typically a number; may also be textual, e.g. a status value\" />\r\n      </Term>\r\n      <ComplexType Name=\"DataPointType\">\r\n        <Property Name=\"Title\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Title of the data point\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Short description\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"LongDescription\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Full description\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"Value\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Numeric value\" />\r\n          <Annotation Term=\"Core.LongDescription\">\r\n            <String>\r\n              It could be annotated with either `UoM.ISOCurrency` or `UoM.Unit`.\r\n              Percentage values are annotated with `UoM.Unit = '%'`.\r\n              A renderer should take an optional `Common.Text` annotation into consideration.\r\n            </String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"TargetValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Target value\" />\r\n        </Property>\r\n        <Property Name=\"ForecastValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Forecast value\" />\r\n        </Property>\r\n        <Property Name=\"MinimumValue\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Minimum value (for output rendering)\" />\r\n        </Property>\r\n        <Property Name=\"MaximumValue\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Maximum value (for output rendering)\" />\r\n        </Property>\r\n        <Property Name=\"ValueFormat\" Type=\"UI.NumberFormat\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Number format\" />\r\n        </Property>\r\n        <Property Name=\"Visualization\" Type=\"UI.VisualizationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Preferred visualization\" />\r\n        </Property>\r\n        <Property Name=\"SampleSize\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>\r\n           \t  Sample size used for the determination of the data point; should contain just integer value as Edm.Byte, Edm.SByte, Edm.Intxx, and Edm.Decimal with scale 0.\r\n           \t</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"ReferencePeriod\" Type=\"UI.ReferencePeriod\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Reference period\" />\r\n        </Property>\r\n        <Property Name=\"Criticality\" Type=\"UI.CriticalityType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service-calculated criticality, alternative to CriticalityCalculation\" />\r\n        </Property>\r\n        <Property Name=\"CriticalityRepresentation\" Type=\"UI.CriticalityRepresentationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Decides if criticality is visualized in addition by means of an icon\" />\r\n        </Property>\r\n        <Property Name=\"CriticalityCalculation\" Type=\"UI.CriticalityCalculationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Parameters for client-calculated criticality, alternative to Criticality\" />\r\n        </Property>\r\n        <Property Name=\"Trend\" Type=\"UI.TrendType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Service-calculated trend, alternative to TrendCalculation\" />\r\n        </Property>\r\n        <Property Name=\"TrendCalculation\" Type=\"UI.TrendCalculationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Parameters for client-calculated trend, alternative to Trend\" />\r\n        </Property>\r\n        <Property Name=\"Responsible\" Type=\"Communication.ContactType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Contact person\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"NumberFormat\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes how to visualise a number\" />\r\n        <Property Name=\"ScaleFactor\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Display value in *ScaleFactor* units, e.g. 1000 for k (kilo), 1e6 for M (Mega)\" />\r\n        </Property>\r\n        <Property Name=\"NumberOfFractionalDigits\" Type=\"Edm.Byte\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Number of fractional digits of the scaled value to be visualized\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"VisualizationType\">\r\n        <Member Name=\"Number\">\r\n          <Annotation Term=\"Core.Description\" String=\"Visualize as a number\" />\r\n        </Member>\r\n        <Member Name=\"BulletChart\">\r\n          <Annotation Term=\"Core.Description\" String=\"Visualize as bullet chart - requires TargetValue\" />\r\n        </Member>\r\n        <Member Name=\"Progress\">\r\n          <Annotation Term=\"Core.Description\" String=\"Visualize as progress indicator - requires TargetValue\" />\r\n        </Member>\r\n        <Member Name=\"Rating\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Visualize as partially or completely filled stars/hearts/... - requires TargetValue\" />\r\n        </Member>\r\n        <Member Name=\"Donut\">\r\n          <Annotation Term=\"Core.Description\" String=\"Visualize as donut, optionally with missing segment - requires TargetValue\" />\r\n        </Member>\r\n        <Member Name=\"DeltaBulletChart\">\r\n          <Annotation Term=\"Core.Description\" String=\"Visualize as delta bullet chart - requires TargetValue\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"ReferencePeriod\">\r\n        <Annotation Term=\"Core.Description\" String=\"Reference period\" />\r\n        <Property Name=\"Description\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Short description of the reference period\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"Start\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Start of the reference period\" />\r\n        </Property>\r\n        <Property Name=\"End\" Type=\"Edm.DateTimeOffset\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"End of the reference period\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"CriticalityType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Criticality of a value or status, represented e.g. via semantic colors (https://experience.sap.com/fiori-design-web/foundation/colors/#semantic-colors)\" />\r\n        <Member Name=\"VeryNegative\" Value=\"-1\">\r\n          <Annotation Term=\"Common.Experimental\" String=\"https://sapjira.wdf.sap.corp/browse/FIORITECHP1-7898\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Very negative / dark-red status - risk - out of stock - late\" />\r\n        </Member>\r\n        <Member Name=\"Neutral\" Value=\"0\">\r\n          <Annotation Term=\"Core.Description\" String=\"Neutral / grey status - inactive - open - in progress\" />\r\n        </Member>\r\n        <Member Name=\"Negative\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Negative / red status - attention - overload - alert\" />\r\n        </Member>\r\n        <Member Name=\"Critical\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Critical / orange status - warning\" />\r\n        </Member>\r\n        <Member Name=\"Positive\" Value=\"3\">\r\n          <Annotation Term=\"Core.Description\" String=\"Positive / green status - completed - available - on track - acceptable\" />\r\n        </Member>\r\n        <Member Name=\"VeryPositive\" Value=\"4\">\r\n          <Annotation Term=\"Common.Experimental\" String=\"https://sapjira.wdf.sap.corp/browse/FIORITECHP1-7898\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Very positive / blue status - above max stock - excess\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"CriticalityCalculationType\" BaseType=\"UI.CriticalityThresholdsType\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Describes how to calculate the criticality of a value depending on the improvement direction\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>\r\nThe calculation is done by comparing a value to the threshold values relevant for the specified improvement direction.\r\n\r\nFor improvement direction `Target`, the criticality is calculated using both low and high threshold values. It will be\r\n  - Positive if the value is greater than or equal to AcceptanceRangeLowValue and lower than or equal to AcceptanceRangeHighValue\r\n  - Neutral if the value is greater than or equal to ToleranceRangeLowValue and lower than AcceptanceRangeLowValue OR greater than AcceptanceRangeHighValue and lower than or equal to ToleranceRangeHighValue\r\n  - Critical if the value is greater than or equal to DeviationRangeLowValue and lower than ToleranceRangeLowValue OR greater than ToleranceRangeHighValue  and lower than or equal to DeviationRangeHighValue\r\n  - Negative if the value is lower than DeviationRangeLowValue or greater than DeviationRangeHighValue\r\n\r\nFor improvement direction `Minimize`, the criticality is calculated using the high threshold values. It is\r\n  - Positive if the value is lower than or equal to AcceptanceRangeHighValue\r\n  - Neutral if the value is  greater than AcceptanceRangeHighValue and lower than or equal to ToleranceRangeHighValue\r\n  - Critical if the value is greater than ToleranceRangeHighValue and lower than or equal to DeviationRangeHighValue\r\n  - Negative if the value is greater than DeviationRangeHighValue\r\n\r\nFor improvement direction `Maximize`, the criticality is calculated using the low threshold values. It is\r\n  - Positive if the value is greater than or equal to AcceptanceRangeLowValue\r\n  - Neutral if the value is less than AcceptanceRangeLowValue and greater than or equal to ToleranceRangeLowValue\r\n  - Critical if the value is lower than ToleranceRangeLowValue and greater than or equal to DeviationRangeLowValue\r\n  - Negative if the value is lower than DeviationRangeLowValue\r\n             \r\nThresholds are optional. For unassigned values, defaults are determined in this order:\r\n  - For DeviationRange, an omitted LowValue translates into the smallest possible number (-INF), an omitted HighValue translates into the largest possible number (+INF)\r\n  - For ToleranceRange, an omitted LowValue will be initialized with DeviationRangeLowValue, an omitted HighValue will be initialized with DeviationRangeHighValue\r\n  - For AcceptanceRange, an omitted LowValue will be initialized with ToleranceRangeLowValue, an omitted HighValue will be initialized with ToleranceRangeHighValue\r\n          </String>\r\n        </Annotation>\r\n        <Property Name=\"ImprovementDirection\" Type=\"UI.ImprovementDirectionType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Describes in which direction the value improves\" />\r\n        </Property>\r\n        <Property Name=\"ConstantThresholds\" Type=\"Collection(UI.LevelThresholdsType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"List of thresholds depending on the aggregation level as a set of constant values\" />\r\n          <Annotation Term=\"Core.LongDescription\"\r\n            String=\"Constant thresholds shall only be used in order to refine constant values given for the data point overall (aggregation level with empty collection of property paths), but not if the thresholds are based on other measure elements.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"CriticalityThresholdsType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Thresholds for calculating the criticality of a value\" />\r\n        <Property Name=\"AcceptanceRangeLowValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Lowest value that is considered positive\" />\r\n        </Property>\r\n        <Property Name=\"AcceptanceRangeHighValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Highest value that is considered positive\" />\r\n        </Property>\r\n        <Property Name=\"ToleranceRangeLowValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Lowest value that is considered neutral\" />\r\n        </Property>\r\n        <Property Name=\"ToleranceRangeHighValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Highest value that is considered neutral\" />\r\n        </Property>\r\n        <Property Name=\"DeviationRangeLowValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Lowest value that is considered critical\" />\r\n        </Property>\r\n        <Property Name=\"DeviationRangeHighValue\" Type=\"Edm.PrimitiveType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Highest value that is considered critical\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"ImprovementDirectionType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes which direction of a value change is seen as an improvement\" />\r\n        <Member Name=\"Minimize\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Lower is better\" />\r\n        </Member>\r\n        <Member Name=\"Target\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Closer to the target is better\" />\r\n        </Member>\r\n        <Member Name=\"Maximize\" Value=\"3\">\r\n          <Annotation Term=\"Core.Description\" String=\"Higher is better\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"LevelThresholdsType\" BaseType=\"UI.CriticalityThresholdsType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Thresholds for an aggregation level\" />\r\n        <Property Name=\"AggregationLevel\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"An unordered tuple of dimensions, i.e. properties which are intended to be used for grouping in aggregating requests. In analytical UIs, e.g. an analytical chart, the aggregation level typically corresponds to the visible dimensions.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"TrendType\">\r\n        <Annotation Term=\"Core.Description\" String=\"The trend of a value\" />\r\n        <Member Name=\"StrongUp\" Value=\"1\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value grows strongly\" />\r\n        </Member>\r\n        <Member Name=\"Up\" Value=\"2\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value grows\" />\r\n        </Member>\r\n        <Member Name=\"Sideways\" Value=\"3\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value does not significantly grow or shrink\" />\r\n        </Member>\r\n        <Member Name=\"Down\" Value=\"4\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value shrinks\" />\r\n        </Member>\r\n        <Member Name=\"StrongDown\" Value=\"5\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value shrinks strongly\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"TrendCalculationType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes how to calculate the trend of a value\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>\r\nBy default, the calculation is done by comparing the difference between Value and ReferenceValue to the threshold values. \r\nIf IsRelativeDifference is set, the difference of Value and ReferenceValue is divided by ReferenceValue and the relative difference is compared.\r\n\r\nThe trend is \r\n  - StrongUp if the difference is greater than or equal to StrongUpDifference\r\n  - Up if the difference is less than StrongUpDifference and greater than or equal to UpDifference\r\n  - Sideways if the difference  is less than UpDifference and greater than DownDifference\r\n  - Down if the difference is greater than StrongDownDifference and lower than or equal to DownDifference\r\n  - StrongDown if the difference is lower than or equal to StrongDownDifference</String>\r\n        </Annotation>\r\n        <Property Name=\"ReferenceValue\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Reference value for the calculation, e.g. number of sales for the last year\" />\r\n        </Property>\r\n        <Property Name=\"IsRelativeDifference\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Calculate with a relative difference\" />\r\n        </Property>\r\n        <Property Name=\"UpDifference\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Threshold for Up\" />\r\n        </Property>\r\n        <Property Name=\"StrongUpDifference\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Threshold for StrongUp\" />\r\n        </Property>\r\n        <Property Name=\"DownDifference\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Threshold for Down\" />\r\n        </Property>\r\n        <Property Name=\"StrongDownDifference\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Threshold for StrongDown\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"KPI\" Type=\"UI.KPIType\" AppliesTo=\"EntitySet EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>A Key Performance Indicator (KPI) bundles a SelectionVariant and a DataPoint, and provides details for progressive disclosure</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"KPIType\">\r\n        <Property Name=\"ID\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Optional identifier to reference this instance from an external context</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"ShortDescription\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Very short description\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"SelectionVariant\" Type=\"UI.SelectionVariantType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Selection variant, either specified inline or referencing another annotation via Path\" />\r\n        </Property>\r\n        <Property Name=\"DataPoint\" Type=\"UI.DataPointType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Data point, either specified inline or referencing another annotation via Path\" />\r\n        </Property>\r\n        <Property Name=\"Detail\" Type=\"UI.KPIDetailType\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Contains information about KPI details, especially drill-down presentations\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"KPIDetailType\">\r\n        <Property Name=\"DefaultPresentationVariant\" Type=\"UI.PresentationVariantType\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Presentation variant, either specified inline or referencing another annotation via Path\" />\r\n        </Property>\r\n        <Property Name=\"AlternativePresentationVariants\" Type=\"Collection(UI.PresentationVariantType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"A list of alternative presentation variants, either specified inline or referencing another annotation via Path\" />\r\n        </Property>\r\n        <Property Name=\"SemanticObject\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Name of the Semantic Object. If not specified, use Semantic Object annotated at the property referenced in KPI/DataPoint/Value\" />\r\n        </Property>\r\n        <Property Name=\"Action\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Name of the Action on the Semantic Object. If not specified, let user choose which of the available actions to trigger.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Chart\" Type=\"UI.ChartDefinitionType\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Visualization of multiple data points\" />\r\n      </Term>\r\n      <ComplexType Name=\"ChartDefinitionType\">\r\n        <Property Name=\"Title\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Title of the chart\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"Description\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Short description\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"ChartType\" Type=\"UI.ChartType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Chart type\" />\r\n        </Property>\r\n        <Property Name=\"AxisScaling\" Type=\"UI.ChartAxisScalingType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Describes the scale of the chart value axes\" />\r\n        </Property>\r\n        <Property Name=\"Measures\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Measures of the chart, e.g. size and color in a bubble chart\" />\r\n        </Property>\r\n        <Property Name=\"MeasureAttributes\" Type=\"Collection(UI.ChartMeasureAttributeType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Describes Attributes for Measures. All Measures used in this collection must also be part of the Measures Property.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"Dimensions\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Dimensions of the chart, e.g. x- and y-axis of a bubble chart\" />\r\n        </Property>\r\n        <Property Name=\"DimensionAttributes\" Type=\"Collection(UI.ChartDimensionAttributeType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Describes Attributes for Dimensions. All Dimensions used in this collection must also be part of the Dimensions Property.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"Actions\" Type=\"Collection(UI.DataFieldForActionAbstract)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Available actions\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"ChartType\">\r\n        <Member Name=\"Column\" />\r\n        <Member Name=\"ColumnStacked\" />\r\n        <Member Name=\"ColumnDual\" />\r\n        <Member Name=\"ColumnStackedDual\" />\r\n        <Member Name=\"ColumnStacked100\" />\r\n        <Member Name=\"ColumnStackedDual100\" />\r\n        <Member Name=\"Bar\" />\r\n        <Member Name=\"BarStacked\" />\r\n        <Member Name=\"BarDual\" />\r\n        <Member Name=\"BarStackedDual\" />\r\n        <Member Name=\"BarStacked100\" />\r\n        <Member Name=\"BarStackedDual100\" />\r\n        <Member Name=\"Area\" />\r\n        <Member Name=\"AreaStacked\" />\r\n        <Member Name=\"AreaStacked100\" />\r\n        <Member Name=\"HorizontalArea\" />\r\n        <Member Name=\"HorizontalAreaStacked\" />\r\n        <Member Name=\"HorizontalAreaStacked100\" />\r\n        <Member Name=\"Line\" />\r\n        <Member Name=\"LineDual\" />\r\n        <Member Name=\"Combination\" />\r\n        <Member Name=\"CombinationStacked\" />\r\n        <Member Name=\"CombinationDual\" />\r\n        <Member Name=\"CombinationStackedDual\" />\r\n        <Member Name=\"HorizontalCombinationStacked\" />\r\n        <Member Name=\"Pie\" />\r\n        <Member Name=\"Donut\" />\r\n        <Member Name=\"Scatter\" />\r\n        <Member Name=\"Bubble\" />\r\n        <Member Name=\"Radar\" />\r\n        <Member Name=\"HeatMap\" />\r\n        <Member Name=\"TreeMap\" />\r\n        <Member Name=\"Waterfall\" />\r\n        <Member Name=\"Bullet\" />\r\n        <Member Name=\"VerticalBullet\" />\r\n        <Member Name=\"HorizontalWaterfall\" />\r\n        <Member Name=\"HorizontalCombinationDual\" />\r\n        <Member Name=\"HorizontalCombinationStackedDual\" />\r\n        <!-- Future: GeoPie, GeoBubble, ChoroplethMap -->\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"ChartAxisScalingType\">\r\n        <Property Name=\"ScaleBehavior\" Type=\"UI.ChartAxisScaleBehaviorType\" DefaultValue=\"AutoScale\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Scale is fixed or adapts automatically to rendered values\" />\r\n        </Property>\r\n        <Property Name=\"AutoScaleBehavior\" Type=\"UI.ChartAxisAutoScaleBehaviorType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Settings for automatic scaling\" />\r\n        </Property>\r\n        <Property Name=\"FixedScaleMultipleStackedMeasuresBoundaryValues\"\r\n          Type=\"UI.FixedScaleMultipleStackedMeasuresBoundaryValuesType\"\r\n        >\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Boundary values for fixed scaling of a stacking chart type with multiple measures\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"ChartAxisScaleBehaviorType\">\r\n        <Member Name=\"AutoScale\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value axes scale automatically\" />\r\n        </Member>\r\n        <Member Name=\"FixedScale\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Fixed minimum and maximum values are applied, which are derived from the @UI.MeasureAttributes.DataPoint/MinimumValue and .../MaximumValue annotation by default. \r\n        For stacking chart types with multiple measures, they are taken from ChartAxisScalingType/FixedScaleMultipleStackedMeasuresBoundaryValues.\r\n            </String>\r\n          </Annotation>\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"ChartAxisAutoScaleBehaviorType\">\r\n        <Property Name=\"ZeroAlwaysVisible\" Type=\"Edm.Boolean\" DefaultValue=\"true\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Forces the value axis to always display the zero value\" />\r\n        </Property>\r\n        <Property Name=\"DataScope\" Type=\"UI.ChartAxisAutoScaleDataScopeType\" DefaultValue=\"DataSet\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Determines the automatic scaling\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"ChartAxisAutoScaleDataScopeType\">\r\n        <Member Name=\"DataSet\">\r\n          <Annotation Term=\"Core.Description\" String=\"Minimum and maximum axes values are determined from the entire data set\" />\r\n        </Member>\r\n        <Member Name=\"VisibleData\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Minimum and maximum axes values are determined from the currently visible data. Scrolling will change the scale.\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"FixedScaleMultipleStackedMeasuresBoundaryValuesType\">\r\n        <Property Name=\"MinimumValue\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Minimum value on value axes\" />\r\n        </Property>\r\n        <Property Name=\"MaximumValue\" Type=\"Edm.Decimal\" Scale=\"variable\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Maximum value on value axes\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"ChartDimensionAttributeType\">\r\n        <Property Name=\"Dimension\" Type=\"Edm.PropertyPath\" />\r\n        <Property Name=\"Role\" Type=\"UI.ChartDimensionRoleType\" />\r\n        <Property Name=\"HierarchyLevel\" Type=\"Edm.Int32\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"For a dimension with a hierarchy, members are selected from this level. The root node of the hierarchy is at level 0.\" />\r\n        </Property>\r\n        <Property Name=\"ValuesForSequentialColorLevels\" Type=\"Collection(Edm.PrimitiveType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"All values in this collection should be assigned to levels of the same color.\" />\r\n        </Property>\r\n        <Property Name=\"EmphasizedValues\" Type=\"Collection(Edm.PrimitiveType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\" String=\"All values in this collection should be emphasized.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"ChartMeasureAttributeType\">\r\n        <Property Name=\"Measure\" Type=\"Edm.PropertyPath\" />\r\n        <Property Name=\"Role\" Type=\"UI.ChartMeasureRoleType\" />\r\n        <Property Name=\"DataPoint\" Type=\"Edm.AnnotationPath\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Annotation path MUST end in UI.DataPoint and the DataPoint Value must be the same property as in Measure\" />\r\n        </Property>\r\n        <Property Name=\"UseSequentialColorLevels\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"All measures for which this setting is true should be assigned to levels of the same color.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"ChartDimensionRoleType\">\r\n        <Member Name=\"Category\" />\r\n        <Member Name=\"Series\" />\r\n        <Member Name=\"Category2\" />\r\n      </EnumType>\r\n\r\n      <EnumType Name=\"ChartMeasureRoleType\">\r\n        <Member Name=\"Axis1\" />\r\n        <Member Name=\"Axis2\" />\r\n        <Member Name=\"Axis3\" />\r\n      </EnumType>\r\n\r\n      <Term Name=\"ValueCriticality\" Type=\"Collection(UI.ValueCriticalityType)\" Nullable=\"false\" AppliesTo=\"Property TypeDefinition\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Assign criticalities to primitive values. This information can be used for semantic coloring.\" />\r\n      </Term>\r\n      <ComplexType Name=\"ValueCriticalityType\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Assigns a fixed criticality to a primitive value. This information can be used for semantic coloring.\" />\r\n        <Property Name=\"Value\" Type=\"Edm.PrimitiveType\" />\r\n        <Property Name=\"Criticality\" Type=\"UI.CriticalityType\" />\r\n      </ComplexType>\r\n\r\n      <Term Name=\"SelectionFields\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Properties that might be relevant for filtering a collection of entities of this type\" />\r\n      </Term>\r\n\r\n\r\n      <!-- Segmentation of content according to facets of the Object -->\r\n\r\n      <Term Name=\"Facets\" Type=\"Collection(UI.Facet)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of facets\" />\r\n      </Term>\r\n\r\n      <Term Name=\"HeaderFacets\" Type=\"Collection(UI.Facet)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Facets for additional object header information\" />\r\n      </Term>\r\n\r\n      <Term Name=\"QuickViewFacets\" Type=\"Collection(UI.Facet)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Facets that may be used for a quick overview of the object\" />\r\n      </Term>\r\n\r\n      <Term Name=\"QuickCreateFacets\" Type=\"Collection(UI.Facet)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Facets that may be used for a (quick) create of the object\" />\r\n      </Term>\r\n\r\n      <Term Name=\"FilterFacets\" Type=\"Collection(UI.ReferenceFacet)\" Nullable=\"false\" AppliesTo=\"EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Facets that reference UI.FieldGroup annotations to group filterable fields\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"Facet\" Abstract=\"true\">\r\n        <Annotation Term=\"Core.Description\" String=\"Abstract base type for facets\" />\r\n        <Property Name=\"Label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Facet label\" />\r\n        </Property>\r\n        <Property Name=\"ID\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Unique identifier of a facet. ID should be stable, as long as the perceived semantics of the facet is unchanged.\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"CollectionFacet\" BaseType=\"UI.Facet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Collection of facets\" />\r\n        <Property Name=\"Facets\" Type=\"Collection(UI.Facet)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Nested facets. An empty collection may be used as a placeholder for content added via extension points.\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ReferenceFacet\" BaseType=\"UI.Facet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Facet that refers to a thing perspective, e.g. LineItem\" />\r\n        <Property Name=\"Target\" Type=\"Edm.AnnotationPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Referenced information: Communication.Contact, Communication.Address, or a term that is tagged with UI.ThingPerspective, e.g. UI.StatusInfo, UI.LineItem, UI.Identification, UI.FieldGroup, UI.Badge\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"ReferenceURLFacet\" BaseType=\"UI.Facet\">\r\n        <Annotation Term=\"Core.Description\" String=\"Facet that refers to a URL\" />\r\n        <Property Name=\"Url\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.IsURL\" />\r\n          <Annotation Term=\"Core.Description\" String=\"URL of referenced information\" />\r\n        </Property>\r\n        <Property Name=\"UrlContentType\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsMediaType\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Media type of referenced information\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n\r\n      <Term Name=\"SelectionPresentationVariant\" Type=\"UI.SelectionPresentationVariantType\" AppliesTo=\"EntitySet EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>A SelectionPresentationVariant bundles a Selection Variant and a Presentation Variant</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"SelectionPresentationVariantType\">\r\n        <Property Name=\"ID\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Optional identifier to reference this variant from an external context</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"Text\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the bundling variant\" />\r\n        </Property>\r\n        <Property Name=\"SelectionVariant\" Type=\"UI.SelectionVariantType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Selection variant, either specified inline or referencing another annotation via Path\" />\r\n        </Property>\r\n        <Property Name=\"PresentationVariant\" Type=\"UI.PresentationVariantType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Presentation variant, either specified inline or referencing another annotation via Path\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"PresentationVariant\" Type=\"UI.PresentationVariantType\" AppliesTo=\"EntitySet EntityType\">\r\n        <Annotation Term=\"UI.ThingPerspective\" />\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Defines how the result of a queried collection of entities is shaped and how this result is displayed</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"PresentationVariantType\">\r\n        <Property Name=\"ID\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\" String=\"Optional identifier to reference this variant from an external context\" />\r\n        </Property>\r\n        <Property Name=\"Text\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the presentation variant\" />\r\n        </Property>\r\n        <Property Name=\"MaxItems\" Type=\"Edm.Int32\">\r\n          <Annotation Term=\"Core.Description\" String=\"Maximum number of items that should be included in the result\" />\r\n        </Property>\r\n        <Property Name=\"SortOrder\" Type=\"Collection(Common.SortOrderType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Collection can be provided inline or as a reference to a Common.SortOrder annotation via Path\" />\r\n        </Property>\r\n        <Property Name=\"GroupBy\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Sequence of groupable properties p1, p2, ... defining how the result is composed of instances representing groups, \r\n            one for each combination of value properties in the queried collection. The sequence specifies a certain level\r\n            of aggregation for the queried collection, and every group instance will provide aggregated values for\r\n            properties that are aggregatable. Moreover, the series of sub-sequences (p1), (p1, p2), ... forms a leveled hierarchy,\r\n            which may become relevant in combination with `InitialExpansionLevel`.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"TotalBy\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Sub-sequence q1, q2, ... of properties p1, p2, ... specified in GroupBy. With this, additional levels of aggregation \r\n            are requested in addition to the most granular level defined by GroupBy: Every element in the series of sub-sequences \r\n            (q1), (q1, q2), ... introduces an additional aggregation level included in the result.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"Total\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Aggregatable properties for which aggregated values should be provided for the additional aggregation levels specified in TotalBy.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"IncludeGrandTotal\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Result should include a grand total for the properties specified in Total\" />\r\n        </Property>\r\n        <Property Name=\"InitialExpansionLevel\" Type=\"Edm.Int32\" Nullable=\"false\" DefaultValue=\"1\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Level up to which the hierarchy defined for the queried collection should be expanded initially.\r\n            The hierarchy may be implicitly imposed by the sequence of the GroupBy, or by an explicit hierarchy annotation.</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"Visualizations\" Type=\"Collection(Edm.AnnotationPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Lists available visualization types. Currently supported types are `UI.LineItem`, `UI.Chart`, and `UI.DataPoint`.\r\n              For each type, no more than a single annotation is meaningful. Multiple instances of the same visualization type\r\n              shall be modeled with different presentation variants. \r\n              A reference to `UI.Lineitem` should always be part of collection (least common denominator for renderers).\r\n              The first entry of the collection is the default visualization.\r\n            </String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"RequestAtLeast\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Properties that should always be included in the result of the queried collection\" />\r\n        </Property>\r\n        <Property Name=\"SelectionFields\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n          <Annotation Term=\"Common.Experimental\" />\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Properties that should be presented for filtering a collection of entities. \r\n            Can be provided inline or as a reference to a `UI.SelectionFields` annotation via Path.</String>\r\n          </Annotation>\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"SelectionVariant\" Type=\"UI.SelectionVariantType\" AppliesTo=\"EntitySet EntityType\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>A SelectionVariant denotes a combination of parameters and filters to query the annotated entity set</String>\r\n        </Annotation>\r\n      </Term>\r\n      <ComplexType Name=\"SelectionVariantType\">\r\n        <Property Name=\"ID\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String> May contain identifier to reference this instance from an external context</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"Text\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the selection variant\" />\r\n        </Property>\r\n        <Property Name=\"Parameters\" Type=\"Collection(UI.ParameterAbstract)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Parameters of the selection variant\" />\r\n        </Property>\r\n        <Property Name=\"FilterExpression\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Filter string for query part of URL, without `$filter=`</String>\r\n          </Annotation>\r\n        </Property>\r\n        <Property Name=\"SelectOptions\" Type=\"Collection(UI.SelectOptionType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>ABAP Select Options Pattern</String>\r\n          </Annotation>\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"ParameterAbstract\" Abstract=\"true\">\r\n        <Annotation Term=\"Core.Description\" String=\"Key property of a parameter entity type\" />\r\n      </ComplexType>\r\n      <ComplexType Name=\"Parameter\" BaseType=\"UI.ParameterAbstract\">\r\n        <Annotation Term=\"Core.Description\" String=\"Single-valued parameter\" />\r\n        <Property Name=\"PropertyName\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to a key property of a parameter entity type\" />\r\n        </Property>\r\n        <Property Name=\"PropertyValue\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value for the key property\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <ComplexType Name=\"IntervalParameter\" BaseType=\"UI.ParameterAbstract\">\r\n        <Annotation Term=\"Core.Description\" String=\"Interval parameter formed with a 'from' and a 'to' property\" />\r\n        <Property Name=\"PropertyNameFrom\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to the 'from' property of a parameter entity type\" />\r\n        </Property>\r\n        <Property Name=\"PropertyValueFrom\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value for the 'from' property\" />\r\n        </Property>\r\n        <Property Name=\"PropertyNameTo\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to the 'to' property of a parameter entity type\" />\r\n        </Property>\r\n        <Property Name=\"PropertyValueTo\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Value for the 'to' property\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"SelectOptionType\">\r\n        <Annotation Term=\"Core.Description\" String=\"List of value ranges for a single property\" />\r\n        <Property Name=\"PropertyName\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to the property\" />\r\n        </Property>\r\n        <Property Name=\"Ranges\" Type=\"Collection(UI.SelectionRangeType)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of value ranges\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"SelectionRangeType\">\r\n        <Annotation Term=\"Core.Description\">\r\n          <String>Value range. If the range option only requires a single value, the value must be in the property Low</String>\r\n        </Annotation>\r\n        <Property Name=\"Sign\" Type=\"UI.SelectionRangeSignType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Include or exclude values\" />\r\n        </Property>\r\n        <Property Name=\"Option\" Type=\"UI.SelectionRangeOptionType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Comparison operator\" />\r\n        </Property>\r\n        <Property Name=\"Low\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Single value or lower interval boundary\" />\r\n        </Property>\r\n        <Property Name=\"High\" Type=\"Edm.PrimitiveType\">\r\n          <Annotation Term=\"Core.Description\" String=\"Upper interval boundary\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"SelectionRangeSignType\">\r\n        <Member Name=\"I\">\r\n          <Annotation Term=\"Core.Description\" String=\"Inclusive\" />\r\n        </Member>\r\n        <Member Name=\"E\">\r\n          <Annotation Term=\"Core.Description\" String=\"Exclusive\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <EnumType Name=\"SelectionRangeOptionType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Comparison operator\" />\r\n        <Member Name=\"EQ\">\r\n          <Annotation Term=\"Core.Description\" String=\"Equal to\" />\r\n        </Member>\r\n        <Member Name=\"BT\">\r\n          <Annotation Term=\"Core.Description\" String=\"Between\" />\r\n        </Member>\r\n        <Member Name=\"CP\">\r\n          <Annotation Term=\"Core.Description\" String=\"Contains pattern\" />\r\n        </Member>\r\n        <Member Name=\"LE\">\r\n          <Annotation Term=\"Core.Description\" String=\"Less than or equal to\" />\r\n        </Member>\r\n        <Member Name=\"GE\">\r\n          <Annotation Term=\"Core.Description\" String=\"Greater than or equal to\" />\r\n        </Member>\r\n        <Member Name=\"NE\">\r\n          <Annotation Term=\"Core.Description\" String=\"Not equal to\" />\r\n        </Member>\r\n        <Member Name=\"NB\">\r\n          <Annotation Term=\"Core.Description\" String=\"Not between\" />\r\n        </Member>\r\n        <Member Name=\"NP\">\r\n          <Annotation Term=\"Core.Description\" String=\"Does not contain pattern\" />\r\n        </Member>\r\n        <Member Name=\"GT\">\r\n          <Annotation Term=\"Core.Description\" String=\"Greater than\" />\r\n        </Member>\r\n        <Member Name=\"LT\">\r\n          <Annotation Term=\"Core.Description\" String=\"Less than\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n\r\n      <!-- basic type definitions for reuse -->\r\n\r\n      <Term Name=\"ThingPerspective\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Term\">\r\n        <Annotation Term=\"Core.Description\" String=\"This term is a Thing Perspective\" />\r\n      </Term>\r\n      <Term Name=\"IsSummary\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Record\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"This Facet and all included Facets are the summary of the thing. At most one Facet of a thing can be tagged with this term\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"UI.Facet\" />\r\n      </Term>\r\n      <Term Name=\"PartOfPreview\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Record\">\r\n        <Annotation Term=\"Core.Description\" String=\"This Facet and all included Facets are part of the Thing preview\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"UI.Facet\" />\r\n      </Term>\r\n      <Term Name=\"Map\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Record\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Target MUST reference a UI.GeoLocation, Communication.Address or a collection of these\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"UI.ReferenceFacet\" />\r\n      </Term>\r\n      <Term Name=\"Gallery\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Record\">\r\n        <Annotation Term=\"Core.Description\" String=\"Target MUST reference a UI.MediaResource\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"UI.ReferenceFacet\" />\r\n      </Term>\r\n\r\n      <Term Name=\"IsImageURL\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Term\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Properties and terms annotated with this term MUST contain a valid URL referencing an resource with a MIME type image\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"MultiLineText\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property PropertyValue\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Properties annotated with this annotation should be rendered as multi-line text (e.g. text area)\" />\r\n        <Annotation Term=\"Core.RequiresType\" String=\"Edm.String\" />\r\n      </Term>\r\n\r\n      <Term Name=\"TextArrangement\" Type=\"UI.TextArrangementType\" AppliesTo=\"Annotation EntityType\">\r\n        <Annotation Term=\"Core.Description\" String=\"Describes the arrangement of a code or ID value and its text\" />\r\n        <Annotation Term=\"Core.LongDescription\" String=\"If used for a single property the Common.Text annotation is annotated\" />\r\n      </Term>\r\n      <EnumType Name=\"TextArrangementType\">\r\n        <Member Name=\"TextFirst\">\r\n          <Annotation Term=\"Core.Description\" String=\"Text is first, followed by the code/ID (e.g. in parentheses)\" />\r\n        </Member>\r\n        <Member Name=\"TextLast\">\r\n          <Annotation Term=\"Core.Description\" String=\"Code/ID is first, followed by the text (e.g. separated by a dash)\" />\r\n        </Member>\r\n        <Member Name=\"TextSeparate\">\r\n          <Annotation Term=\"Core.Description\" String=\"Code/ID and text are represented separately\" />\r\n        </Member>\r\n        <Member Name=\"TextOnly\">\r\n          <Annotation Term=\"Core.Description\" String=\"Only text is represented, code/ID is hidden (e.g. for UUIDs)\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <!-- Under discussion\r\n        <Term Name=\"DisplayTimeZone\" Type=\"?Edm.Int32?\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\">\r\n        <String>Contains information for time- or date-time-fields in which time zone the time value should be displayed.</String>\r\n        </Annotation>\r\n        </Term>\r\n      -->\r\n\r\n      <Term Name=\"Importance\" Type=\"UI.ImportanceType\" AppliesTo=\"Annotation Record\">\r\n        <Annotation Term=\"Core.Description\" String=\"Expresses the importance of e.g. a DataField or an annotation\" />\r\n      </Term>\r\n      <EnumType Name=\"ImportanceType\">\r\n        <Member Name=\"High\">\r\n          <Annotation Term=\"Core.Description\" String=\"High importance\" />\r\n        </Member>\r\n        <Member Name=\"Medium\">\r\n          <Annotation Term=\"Core.Description\" String=\"Medium importance\" />\r\n        </Member>\r\n        <Member Name=\"Low\">\r\n          <Annotation Term=\"Core.Description\" String=\"Low importance\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <Term Name=\"Hidden\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property Record\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Properties or facets (see UI.Facet) annotated with this term will not be rendered if the annotation evaluates to true.\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Hidden properties usually carry technical information that is used for application control and is of no direct interest to end users. The annotation value may be an expression to dynamically hide or render the annotated feature.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"HiddenFilter\" Type=\"Core.Tag\" Nullable=\"false\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Properties annotated with this term will not be rendered as filter criteria if the annotation evaluates to true.\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Properties annotated with `HiddenFilter` are intended as parts of a `$filter` expression that cannot be directly influenced by end users. The properties will be rendered in all other places, e.g. table columns or form fields. This is in contrast to properties annotated with [`UI.Hidden`](#Hidden) that are not rendered at all.\" />\r\n      </Term>\r\n\r\n      <Term Name=\"DataFieldDefault\" Type=\"UI.DataFieldAbstract\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Default representation of a property as a datafield, e.g. when the property is added as a table column or form field via personalization\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Only concrete subtypes of DataFieldAbstract can be used for a DataFieldDefault. For type `DataField` and its subtypes the annotation target SHOULD be the same property that is referenced via a path expression in the `Value` of the datafield.\" />\r\n      </Term>\r\n\r\n      <ComplexType Name=\"DataFieldAbstract\" Abstract=\"true\">\r\n        <Property Name=\"Label\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"A short, human-readable text suitable for labels and captions in UIs\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n        <Property Name=\"Criticality\" Type=\"UI.CriticalityType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Criticality of the data field value\" />\r\n        </Property>\r\n        <Property Name=\"CriticalityRepresentation\" Type=\"UI.CriticalityRepresentationType\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Decides if criticality is visualized in addition by means of an icon\" />\r\n        </Property>\r\n        <Property Name=\"IconUrl\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Optional icon to decorate the value\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <EnumType Name=\"CriticalityRepresentationType\">\r\n        <Member Name=\"WithIcon\">\r\n          <Annotation Term=\"Core.Description\" String=\"Criticality is represented with an icon\" />\r\n        </Member>\r\n        <Member Name=\"WithoutIcon\">\r\n          <Annotation Term=\"Core.Description\" String=\"Criticality is represented without icon, e.g. only via text color\" />\r\n        </Member>\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"DataFieldForAnnotation\" BaseType=\"UI.DataFieldAbstract\">\r\n        <Property Name=\"Target\" Type=\"Edm.AnnotationPath\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Target MUST reference an annotation of terms Communication.Contact, Communication.Address, UI.DataPoint, UI.Chart, UI.FieldGroup, or UI.ConnectedFields\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataFieldForActionAbstract\" BaseType=\"UI.DataFieldAbstract\" Abstract=\"true\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Abstract type to bundle DataFieldForAction and DataFieldForIntentBasedNavigation\" />\r\n        <Property Name=\"Inline\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Action should be placed close to (or even inside) the visualized term\" />\r\n        </Property>\r\n        <Property Name=\"Determining\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Determines whether the action completes a process step (e.g. approve, reject).\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataFieldForAction\" BaseType=\"UI.DataFieldForActionAbstract\">\r\n        <Annotation Term=\"Core.Description\" String=\"The action is NOT tied to a data value (in contrast to DataFieldWithAction)\" />\r\n        <Property Name=\"Action\" Type=\"Common.QualifiedName\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Qualified name of an Action, Function, ActionImport or FunctionImport in scope\" />\r\n        </Property>\r\n        <Property Name=\"InvocationGrouping\" Type=\"UI.OperationGroupingType\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Expresses how invocations of this action on multiple instances should be grouped\" />\r\n        </Property>\r\n      </ComplexType>\r\n      <EnumType Name=\"OperationGroupingType\">\r\n        <Member Name=\"Isolated\" />\r\n        <Member Name=\"ChangeSet\" />\r\n      </EnumType>\r\n\r\n      <ComplexType Name=\"DataFieldForIntentBasedNavigation\" BaseType=\"UI.DataFieldForActionAbstract\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The navigation intent is is expressed as a Semantic Object and optionally an Action on that object\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The navigation intent is NOT tied to a data value (in contrast to DataFieldWithIntentBasedNavigation), the data field represents a navigation trigger.\" />\r\n        <Property Name=\"SemanticObject\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the Semantic Object\" />\r\n        </Property>\r\n        <Property Name=\"Action\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Name of the Action on the Semantic Object. If not specified, let user choose which of the available actions to trigger.\" />\r\n        </Property>\r\n        <Property Name=\"RequiresContext\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Determines whether  a context needs to be passed to the target of this navigation.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataField\" BaseType=\"UI.DataFieldAbstract\">\r\n        <Property Name=\"Value\" Type=\"Edm.PrimitiveType\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"The data field's value\" />\r\n          <Annotation Term=\"Core.IsLanguageDependent\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataFieldWithAction\" BaseType=\"UI.DataField\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The action is tied to a data value which could be render as a button or link that triggers the action. This is in contrast to DataFieldForAction which is not tied to a specific data value.\" />\r\n        <Property Name=\"Action\" Type=\"Common.QualifiedName\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Qualified name of an Action, Function, ActionImport or FunctionImport in scope\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataFieldWithIntentBasedNavigation\" BaseType=\"UI.DataField\">\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"The navigation intent is is expressed as a Semantic Object and optionally an Action on that object\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"The navigation intent is tied to a data value which should be rendered as a hyperlink. This is in contrast to DataFieldForIntentBasedNavigation which is not tied to a specific data value.\" />\r\n        <Property Name=\"SemanticObject\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Name of the Semantic Object\" />\r\n        </Property>\r\n        <Property Name=\"Action\" Type=\"Edm.String\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Name of the Action on the Semantic Object. If not specified, let user choose which of the available actions to trigger.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataFieldWithNavigationPath\" BaseType=\"UI.DataField\">\r\n        <Property Name=\"Target\" Type=\"Edm.NavigationPropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\">\r\n            <String>Contains either a navigation property or a term cast, where term is of type Edm.EntityType or a concrete entity type or a collection of these types</String>\r\n          </Annotation>\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"DataFieldWithUrl\" BaseType=\"UI.DataField\">\r\n        <Property Name=\"Url\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Target of the hyperlink\" />\r\n          <Annotation Term=\"Core.IsURL\" />\r\n        </Property>\r\n        <Property Name=\"UrlContentType\" Type=\"Edm.String\" Nullable=\"true\">\r\n          <Annotation Term=\"Core.Description\" String=\"Media type of the hyperlink target, e.g. `video/mp4`\" />\r\n          <Annotation Term=\"Core.IsMediaType\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <Term Name=\"Criticality\" Type=\"UI.CriticalityType\" AppliesTo=\"Annotation\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\" Service-calculated criticality, alternative to UI.CriticalityCalculation\" />\r\n      </Term>\r\n\r\n      <Term Name=\"CriticalityCalculation\" Type=\"UI.CriticalityCalculationType\" AppliesTo=\"Annotation\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Parameters for client-calculated criticality, alternative to UI.Criticality\" />\r\n      </Term>\r\n\r\n      <Term Name=\"OrderBy\" Type=\"Edm.PropertyPath\" AppliesTo=\"Property\">\r\n        <Annotation Term=\"Common.Experimental\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Sort by the referenced property instead of by the annotated property\" />\r\n        <Annotation Term=\"Core.LongDescription\"\r\n          String=\"Example: annotated property `SizeCode` has string values XS, S, M, L, XL, referenced property SizeOrder has numeric values -2, -1, 0, 1, 2. Numeric ordering by SizeOrder will be more understandable than lexicographic ordering by SizeCode.\" />\r\n      </Term>\r\n\r\n\r\n      <Term Name=\"RecommendationState\" Type=\"UI.RecommendationStateType\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"See https://wiki.wdf.sap.corp/wiki/x/a7Ate\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Indicates whether a field contains or has a recommended value\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Intelligent systems can help users by recommending input the user may \"prefer\".</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <TypeDefinition Name=\"RecommendationStateType\" UnderlyingType=\"Edm.Byte\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"See https://wiki.wdf.sap.corp/wiki/x/a7Ate\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Indicates whether a field contains or has a recommended value\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Editable fields for which a recommendation has been pre-filled or that have recommendations that differ from existing human input need to be highlighted.</String>\r\n        </Annotation>\r\n        <Annotation Term=\"Validation.AllowedValues\">\r\n          <Collection>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"0\" />\r\n              <Annotation Term=\"Core.Description\" String=\"regular - with human or default input, no recommendation\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"1\" />\r\n              <Annotation Term=\"Core.Description\" String=\"highlighted - without human input and with recommendation\" />\r\n            </Record>\r\n            <Record>\r\n              <PropertyValue Property=\"Value\" Int=\"2\" />\r\n              <Annotation Term=\"Core.Description\" String=\"warning - with human or default input and with recommendation\" />\r\n            </Record>\r\n          </Collection>\r\n        </Annotation>\r\n      </TypeDefinition>\r\n\r\n      <Term Name=\"RecommendationList\" Type=\"UI.RecommendationListType\" AppliesTo=\"Property Parameter\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"See https://wiki.wdf.sap.corp/wiki/x/a7Ate\" />\r\n        <Annotation Term=\"Core.Description\"\r\n          String=\"Specifies how to get a list of recommended values for a property or parameter\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>Intelligent systems can help users by recommending input the user may \"prefer\".</String>\r\n        </Annotation>\r\n      </Term>\r\n\r\n      <ComplexType Name=\"RecommendationListType\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"See https://wiki.wdf.sap.corp/wiki/x/a7Ate\" />\r\n        <Annotation Term=\"Core.Description\" String=\"Reference to a recommendation list\" />\r\n        <Annotation Term=\"Core.LongDescription\">\r\n          <String>A recommendation consists of one or more values for editable fields plus a rank between 0.0 and 9.9, with 9.9 being the best recommendation.</String>\r\n        </Annotation>\r\n        <Property Name=\"CollectionPath\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Resource path of a collection of recommended values\" />\r\n        </Property>\r\n        <Property Name=\"RankProperty\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Name of the property within the collection of recommended values that describes the rank of the recommendation\" />\r\n        </Property>\r\n        <Property Name=\"Binding\" Type=\"Collection(UI.RecommendationBinding)\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"List of pairs of a local property and recommended value property\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n      <ComplexType Name=\"RecommendationBinding\">\r\n        <Annotation Term=\"Common.Experimental\" String=\"See https://wiki.wdf.sap.corp/wiki/x/a7Ate\" />\r\n        <Property Name=\"LocalDataProperty\" Type=\"Edm.PropertyPath\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\" String=\"Path to editable property for which recommended values exist\" />\r\n        </Property>\r\n        <Property Name=\"ValueListProperty\" Type=\"Edm.String\" Nullable=\"false\">\r\n          <Annotation Term=\"Core.Description\"\r\n            String=\"Path to property in the collection of recommended values. Format is identical to PropertyPath annotations.\" />\r\n        </Property>\r\n      </ComplexType>\r\n\r\n    </Schema>\r\n  </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_SERVER_VOCABULARY_1 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n    <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n        <edmx:Include Namespace=\"Org.OData.Core.V1\" Alias=\"Core\"/>\r\n    </edmx:Reference>\r\n    <edmx:DataServices>\r\n        <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"com.sap.cloud.server.odata.security.v1\">\r\n            <Term Name=\"Roles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    Use this annotation to declare roles that may be referenced in application code,\r\n                    but not specified in other annotations.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"ServiceUserRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to access the OData service.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"ViewMetricsRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntityContainer\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to access the OData metrics.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"ReadWriteRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to access (read or write) entities in the entity set.\r\n                    Can be overridden by the more specific ReadRoles, WriteRoles, CreateRoles, UpdateRoles and DeleteRoles.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"ReadRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to read entities from the entity set.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"WriteRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to write (create, update, or delete) entities in the entity set.\r\n                    Can be overridden by the more specific CreateRoles, UpdateRoles and DeleteRoles.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"CreateRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to create entities in the entity set.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"UpdateRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to update entities in the entity set.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"DeleteRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to delete entities from the entity set.\r\n                </Annotation>\r\n            </Term>\r\n            <Term Name=\"InvokeRoles\" Type=\"Collection(Edm.String)\" Nullable=\"false\" AppliesTo=\"Action ActionImport Function FunctionImport\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    User must belong to one or more of these roles to be permitted to invoke this action or function.\r\n                </Annotation>\r\n            </Term>\r\n        </Schema>\r\n    </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
#define SODataV4_CsdlParser_SERVER_VOCABULARY_2 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">\r\n    <edmx:Reference Uri=\"https://oasis-tcs.github.io/odata-vocabularies/vocabularies/Org.OData.Core.V1.xml\">\r\n        <edmx:Include Namespace=\"Org.OData.Core.V1\" Alias=\"Core\"/>\r\n    </edmx:Reference>\r\n    <edmx:DataServices>\r\n        <Schema Namespace=\"com.sap.cloud.server.odata.sql.v1\" Alias=\"SQL\" xmlns=\"http://docs.oasis-open.org/odata/ns/edm\">\r\n            <Annotation Term=\"Core.Description\" String=\"This schema defines terms and types for OData/SQL mapping.\"/>\r\n            <Term Name=\"ServerOnly\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Annotation EntitySet EntityType NavigationProperty NavigationPropertyBinding \">\r\n                <Annotation Term=\"Core.Description\" String=\"This annotation indicates that the containing CSDL element and it's child elements must not be displayed for the client when it is querying the metadata\"/>\r\n            </Term>\r\n            <Term Name=\"Column\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL column name for a property.\"/>\r\n            </Term>\r\n            <Term Name=\"ColumnType\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL column type for a property.\"/>\r\n            </Term>\r\n            <Term Name=\"ColumnDefault\" Type=\"Edm.String\" AppliesTo=\"Property\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies a SQL column default for a property.\"/>\r\n            </Term>\r\n            <Term Name=\"HasColumnDefault\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"Property\">\r\n                <Annotation Term=\"Core.Description\" String=\"A value for this property can be provided by the client on insert. If no value is provided by the client, a default value is generated by the database.\"/>\r\n            </Term>\r\n            <Term Name=\"Schema\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL schema name for an entity set.\"/>\r\n            </Term>\r\n            <Term Name=\"Table\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL table name for an entity set.\"/>\r\n            </Term>\r\n            <Term Name=\"TableType\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL table type (e.g. 'row', 'column') for an entity set.\"/>\r\n            </Term>\r\n            <Term Name=\"KeySequence\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL key sequence for an entity set. A key sequence is used for the generation of primary keys.\"/>\r\n            </Term>\r\n            <Term Name=\"JoinUsing\" Type=\"Edm.NavigationPropertyPath\" AppliesTo=\"NavigationProperty\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies additional NavigationProperty which provides navigation to the AssociationSet.\"/>\r\n            </Term>\r\n            <Term Name=\"TrackChanges\" Type=\"Core.Tag\" DefaultValue=\"true\" AppliesTo=\"EntityContainer EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Enables OData change tracking for all entity sets within an entity container or for a particular entity set.\"/>\r\n            </Term>\r\n            <Term Name=\"DeltaView\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL delta view for an entity set. A delta view is used instead of the table for delta queries.\"/>\r\n            </Term>\r\n            <Term Name=\"TrackingTable\" Type=\"Edm.String\" AppliesTo=\"EntitySet\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL tracking table for an entity set. A tracking table tracks creates, updates and deletes.\"/>\r\n            </Term>\r\n            <Term Name=\"DeltaFilters\" Type=\"Collection(SQL.DeltaFilter)\" AppliesTo=\"Schema\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL delta filters for a schema.\"/>\r\n            </Term>\r\n            <Term Name=\"RecursiveJoins\" Type=\"Collection(SQL.RecursiveJoin)\" AppliesTo=\"Schema\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the SQL recursive joins for a schema.\"/>\r\n            </Term>\r\n            <Term Name=\"Indexes\" Type=\"Collection(SQL.Index)\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies the secondary indexes for an entity set.\"/>\r\n            </Term>\r\n            <ComplexType Name=\"Index\">\r\n                <Annotation Term=\"Core.Description\" String=\"Specifies a secondary index for an entity set.\"/>\r\n                <Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"A name for the index, unique among indexes for the entity set.\"/>\r\n                </Property>\r\n                <Property Name=\"Properties\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"One or more property paths for the indexed properties.\"/>\r\n                </Property>\r\n                <Property Name=\"Descending\" Type=\"Collection(Edm.PropertyPath)\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Subset of Properties that should be indexed in descending sequence.\"/>\r\n                </Property>\r\n                <Property Name=\"Unique\" Type=\"Edm.Boolean\" Nullable=\"false\" DefaultValue=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"True if only one entity instance can exist in the entity set corresponding to each index entry.\"/>\r\n                </Property>\r\n            </ComplexType>\r\n            <ComplexType Name=\"DeltaFilter\">\r\n                <Annotation Term=\"Core.Description\">\r\n                    <String>\r\n                        A delta filter is used for association-based filtering, by the materialization and change tracking\r\n                        of a mapping from a source entity set to a target entity set.\r\n                        The source entity set often represents a 'user'.\r\n                        The target entity set often represents an entity associated (possibly indirectly) with the user, e.g. a 'shop'.\r\n                        Through defined navigation properties in the schema, all possible paths from the source entity set to the target entity set are automatically determined\r\n                        (as modified by MappingVia, PrunePaths, and RecursiveJoins).\r\n                        Through the generation of appropriate database triggers and views, change tracking of entities that this mapping is applied to (see ApplyTo) is achieved.\r\n                    </String>\r\n                </Annotation>\r\n                <Property Name=\"FilterName\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"A schema-unique name for this filter. Used in the generation of SQL artifact names.\"/>\r\n                </Property>\r\n                <Property Name=\"MappingFrom\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Source entity set for the mapping, e.g. 'UserSet'.\"/>\r\n                </Property>\r\n                <Property Name=\"MappingVia\" Type=\"Edm.String\" Nullable=\"true\">\r\n                    <Annotation Term=\"Core.Description\" String=\"An entity set which must exist on the path from source to target for the path to be considered.\"/>\r\n                </Property>\r\n                <Property Name=\"MappingTo\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Target entity set for the mapping, e.g. 'ShopSet'.\"/>\r\n                </Property>\r\n                <Property Name=\"PrunePaths\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Paths which should be excluded from consideration. For example, 'GroupSet' would exclude mappings passing through groups, and 'UserSet->GroupSet' would exclude mappings involving navigation from users to groups.\"/>\r\n                </Property>\r\n                <Property Name=\"ApplyTo\" Type=\"Collection(Edm.String)\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Final entity sets which this delta filter should be applied to for change tracking. The apply-to entity sets should be reachable by navigation from the target entity set. For example, an entity set 'ItemInventorySet' storing item inventory for shops. Navigation from the target entity set to the apply-to entity sets should be only via immutable associations. Navigation to the apply-to entity sets via mutable associations should be achieved using a delta filter where all mutable associations occur on the path between 'MappingFrom' and 'MappingTo'. Note that 'ApplyTo' can include the 'MappingTo' entity set.\"/>\r\n                </Property>\r\n                <Property Name=\"ExtraColumns\" Type=\"Collection(Edm.String)\" Nullable=\"true\">\r\n                    <Annotation Term=\"Core.Description\" String=\"TBD - may be removed\"/>\r\n                </Property>\r\n                <Property Name=\"ExtraJoins\" Type=\"Collection(Edm.String)\" Nullable=\"true\">\r\n                    <Annotation Term=\"Core.Description\" String=\"TBD - may be removed\"/>\r\n                </Property>\r\n                <Property Name=\"IsDeleted\" Type=\"Edm.String\" Nullable=\"true\">\r\n                    <Annotation Term=\"Core.Description\" String=\"TBD - may be removed\"/>\r\n                </Property>\r\n                <Property Name=\"LastModified\" Type=\"Edm.String\" Nullable=\"true\">\r\n                    <Annotation Term=\"Core.Description\" String=\"TBD - may be removed\"/>\r\n                </Property>\r\n            </ComplexType>\r\n            <ComplexType Name=\"RecursiveJoin\">\r\n                <Annotation Term=\"Core.Description\" String=\"Recursive joins are materialized to flatten recursive hierarchies, in support of delta filters.\"/>\r\n                <Property Name=\"From\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Source entity set involved in a recursive hierarchy, e.g. 'UserSet'.\"/>\r\n                </Property>\r\n                <Property Name=\"Join\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"An entity set that has a navigation property for its own entity type, e.g. 'OrganisationSet'.\"/>\r\n                </Property>\r\n                <Property Name=\"With\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"The name of the navigation property that joins an entity to its parent, e.g. 'ParentOrganisation'.\"/>\r\n                </Property>\r\n                <Property Name=\"Into\" Type=\"Edm.String\" Nullable=\"false\">\r\n                    <Annotation Term=\"Core.Description\" String=\"Target entity set into which the flattened hierarchy should be materialized, e.g. 'UserOrganisationSet'.\"/>\r\n                </Property>\r\n            </ComplexType>\r\n        </Schema>\r\n    </edmx:DataServices>\r\n</edmx:Edmx>\r\n"
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_TypeFacets* DEFAULT_FACETS;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_StringMap* aliasToNamespace;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_StringSet* alreadyLoaded;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlAssociationMap* csdlAssociations;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataSchema* currentSchema;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlDocument* document;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_ComplexTypeMap* finalComplex;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_EntityContainerMap* finalContainer;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_EntityTypeMap* finalEntity;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_Logger* logger;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlElement* rootElement;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_Logger* staticLogger;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlParser_internal
#ifndef imported_SODataV4__CsdlParser_internal
#define imported_SODataV4__CsdlParser_internal
@interface SODataV4_CsdlParser (internal)
- (nonnull SODataV4_CsdlException*) errorWithCause :(nonnull NSException*)cause;
- (nonnull SODataV4_CsdlException*) errorWithElement :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)message;
- (nonnull SODataV4_CsdlException*) errorWithMessage :(nonnull NSString*)message;
- (nullable NSString*) getAliasForVocabulary :(nonnull NSString*)vocabulary :(nonnull SODataV4_XmlElement*)root;
/// @brief Supplementary edmx:Reference elements. Defaults to an empty list.
///
///
/// @see `SODataV4_CsdlParser`.`includeNamespace`, `SODataV4_CsdlParser`.`includeReference`.
- (nonnull SODataV4_XmlElementList*) includeReferences;
/// @brief Pre-parsed schemas. Defaults to an empty list.
///
///
/// @see `SODataV4_CsdlParser`.`includeSchema`.
- (nonnull SODataV4_DataSchemaList*) includeSchemas;
/// @brief Supplementary edmx:Reference elements. Defaults to an empty list.
///
///
/// @see `SODataV4_CsdlParser`.`includeNamespace`, `SODataV4_CsdlParser`.`includeReference`.
- (void) setIncludeReferences :(nonnull SODataV4_XmlElementList*)value;
/// @brief Pre-parsed schemas. Defaults to an empty list.
///
///
/// @see `SODataV4_CsdlParser`.`includeSchema`.
- (void) setIncludeSchemas :(nonnull SODataV4_DataSchemaList*)value;
- (nullable NSString*) urlForMessage;
/// @internal
///
- (void) warn :(nonnull NSString*)message;
- (void) warn :(nonnull NSString*)message :(nullable NSException*)cause;
- (void) warnWithElement :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)message;
/// @brief Supplementary edmx:Reference elements. Defaults to an empty list.
///
///
/// @see `SODataV4_CsdlParser`.`includeNamespace`, `SODataV4_CsdlParser`.`includeReference`.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_XmlElementList* includeReferences;
/// @brief Pre-parsed schemas. Defaults to an empty list.
///
///
/// @see `SODataV4_CsdlParser`.`includeSchema`.
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataSchemaList* includeSchemas;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlReference_public
#define imported_SODataV4__CsdlReference_public
/// @brief Encapsulates an Open Data Protocol ([OData](http://odata.org/)) metadata reference.
///
///
@interface SODataV4_CsdlReference : SODataV4_ObjectBase
{
    @private SODataV4_int version_;
    @private NSString* _Nonnull uri_;
    @private SODataV4_CsdlReference_IncludeList* _Nonnull includes_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlReference*) new;
/// @internal
///
- (void) _init;
/// @brief List of included schema namespaces with corresponding aliases.
///
///
- (nonnull SODataV4_CsdlReference_IncludeList*) includes;
/// @brief List of included schema namespaces with corresponding aliases.
///
///
- (void) setIncludes :(nonnull SODataV4_CsdlReference_IncludeList*)value;
/// @brief Uniform Resource Identifier for this reference.
///
/// It should not be assumed that the URI is a URL, i.e. it might not be HTTP-accessible.
- (void) setUri :(nonnull NSString*)value;
/// @brief OData version for this reference.
///
///
/// @see `SODataV4_DataVersion`.
- (void) setVersion :(SODataV4_int)value;
/// @brief Uniform Resource Identifier for this reference.
///
/// It should not be assumed that the URI is a URL, i.e. it might not be HTTP-accessible.
- (nonnull NSString*) uri;
/// @brief OData version for this reference.
///
///
/// @see `SODataV4_DataVersion`.
- (SODataV4_int) version;
/// @brief List of included schema namespaces with corresponding aliases.
///
///
@property (nonatomic, readwrite, strong, nonnull) SODataV4_CsdlReference_IncludeList* includes;
/// @brief Uniform Resource Identifier for this reference.
///
/// It should not be assumed that the URI is a URL, i.e. it might not be HTTP-accessible.
@property (nonatomic, readwrite, strong, nonnull) NSString* uri;
/// @brief OData version for this reference.
///
///
/// @see `SODataV4_DataVersion`.
@property (nonatomic, readwrite) SODataV4_int version;
@end
#endif

#ifndef imported_SODataV4__CsdlReference_Include_public
#define imported_SODataV4__CsdlReference_Include_public
/// @brief Representa an OData reference "include" element.
///
///
@interface SODataV4_CsdlReference_Include : SODataV4_ObjectBase
{
    @private NSString* _Nonnull namespace_;
    @private NSString* _Nullable alias_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlReference_Include*) new;
/// @internal
///
- (void) _init;
/// @brief OData schema alias.
///
///
- (nullable NSString*) alias;
/// @brief OData schema namespace.
///
///
- (nonnull NSString*) namespace;
/// @brief OData schema alias.
///
///
- (void) setAlias :(nullable NSString*)value;
/// @brief OData schema namespace.
///
///
- (void) setNamespace :(nonnull NSString*)value;
/// @brief OData schema alias.
///
///
@property (nonatomic, readwrite, strong, nullable) NSString* alias;
/// @brief OData schema namespace.
///
///
@property (nonatomic, readwrite, strong, nonnull) NSString* namespace;
@end
#endif

#ifdef import_SODataV4__CsdlAssociationMap_internal
#ifndef imported_SODataV4__CsdlAssociationMap_internal
#define imported_SODataV4__CsdlAssociationMap_public
/* internal */
/// @brief A map from key type `string` to value type `SODataV4_CsdlAssociation`.
///
///
@interface SODataV4_CsdlAssociationMap : SODataV4_MapBase
{
    @private SODataV4_MapFromString* _Nonnull _untyped_;
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new map with `SODataV4_CsdlAssociationMap`.`size` of zero and optional initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
+ (nonnull SODataV4_CsdlAssociationMap*) new;
/// @brief Construct a new map with `SODataV4_CsdlAssociationMap`.`size` of zero and optional initial `capacity`.
///
/// A map can expand in size beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the map's maximum size.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_CsdlAssociationMap*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Delete the entry with the specified `key` (if found).
///
///
/// @return `true` if an entry with the specified `key` was found (and deleted).
/// @param key Entry key.
- (SODataV4_boolean) delete_ :(nonnull NSString*)key;
/// @brief An immutable empty `SODataV4_CsdlAssociationMap`.
///
///
+ (nonnull SODataV4_CsdlAssociationMap*) empty;
/// @return A list of the entries (key/value pairs) in this map.
///
- (nonnull SODataV4_CsdlAssociationMap_EntryList*) entries;
/// @return The value from the entry with the specified `key` (if found), otherwise `nil`.
/// @param key Entry key.
- (nullable SODataV4_CsdlAssociation*) get :(nonnull NSString*)key;
/// @return The value from the entry with the specified `key` (if found).
/// @throw `SODataV4_MissingEntryException` if no entry is found for the specified key.
/// @param key Entry key.
- (nonnull SODataV4_CsdlAssociation*) getRequired :(nonnull NSString*)key;
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
- (void) set :(nonnull NSString*)key :(nonnull SODataV4_CsdlAssociation*)value;
/// @brief Add or replace an entry with the specified `key` and `value`.
///
///
/// @return This map.
/// @param key Entry key.
/// @param value Entry value.
- (nonnull SODataV4_CsdlAssociationMap*) setThis :(nonnull NSString*)key :(nonnull SODataV4_CsdlAssociation*)value;
/// @brief The underlying untyped map of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
- (nonnull SODataV4_UntypedMap*) untypedMap;
/// @return A list of the entry values in this map.
///
- (nonnull SODataV4_CsdlAssociationList*) values;
/// @brief An immutable empty `SODataV4_CsdlAssociationMap`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlAssociationMap* empty;
/// @brief The underlying untyped map of objects. Use with care, avoiding the addition of objects with an incorrect item type.
///
///
@property (nonatomic, readonly, strong, nonnull) SODataV4_UntypedMap* untypedMap;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlAssociationMap_private
#ifndef imported_SODataV4__CsdlAssociationMap_private
#define imported_SODataV4__CsdlAssociationMap_private
@interface SODataV4_CsdlAssociationMap (private)
- (nonnull SODataV4_MapFromString*) _untyped;
- (void) set_untyped :(nonnull SODataV4_MapFromString*)value;
+ (nonnull SODataV4_CsdlAssociationMap_Entry*) _new1 :(nonnull SODataV4_CsdlAssociation*)p1 :(nonnull NSString*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_MapFromString* _untyped;
@end
#endif
#endif

#ifdef import_SODataV4__AnnotationToResolveList_internal
#ifndef imported_SODataV4__AnnotationToResolveList_internal
#define imported_SODataV4__AnnotationToResolveList_public
/* internal */
/// @brief A list of item type `SODataV4_AnnotationToResolve`.
///
///
@interface SODataV4_AnnotationToResolveList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_AnnotationToResolveList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_AnnotationToResolveList*) new;
/// @brief Construct a new list with `SODataV4_AnnotationToResolveList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_AnnotationToResolveList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_AnnotationToResolve*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_AnnotationToResolveList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_AnnotationToResolveList*) addThis :(nonnull SODataV4_AnnotationToResolve*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_AnnotationToResolveList*) copy;
/// @brief An immutable empty `SODataV4_AnnotationToResolveList`.
///
///
+ (nonnull SODataV4_AnnotationToResolveList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_AnnotationToResolve*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_AnnotationToResolveList`.`length` - 1).
- (nonnull SODataV4_AnnotationToResolve*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_AnnotationToResolveList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_AnnotationToResolve`.
- (SODataV4_boolean) includes :(nonnull SODataV4_AnnotationToResolve*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_AnnotationToResolve*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_AnnotationToResolveList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_AnnotationToResolve`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_AnnotationToResolve*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_AnnotationToResolveList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_AnnotationToResolveList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_AnnotationToResolveList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_AnnotationToResolve*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_AnnotationToResolve*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_AnnotationToResolve*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_AnnotationToResolveList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_AnnotationToResolve`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_AnnotationToResolve*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_AnnotationToResolve*)item;
/// @brief Return a new `SODataV4_AnnotationToResolveList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_AnnotationToResolve` will be removed.
///
/// @return A new list of item type `SODataV4_AnnotationToResolve`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_AnnotationToResolveList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_AnnotationToResolve*) single;
/// @internal
///
- (nonnull SODataV4_AnnotationToResolveList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_AnnotationToResolveList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_AnnotationToResolveList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_AnnotationToResolveList* empty;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlAssociationList_internal
#ifndef imported_SODataV4__CsdlAssociationList_internal
#define imported_SODataV4__CsdlAssociationList_public
/* internal */
/// @brief A list of item type `SODataV4_CsdlAssociation`.
///
///
@interface SODataV4_CsdlAssociationList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_CsdlAssociationList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_CsdlAssociationList*) new;
/// @brief Construct a new list with `SODataV4_CsdlAssociationList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_CsdlAssociationList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_CsdlAssociation*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_CsdlAssociationList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_CsdlAssociationList*) addThis :(nonnull SODataV4_CsdlAssociation*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_CsdlAssociationList*) copy;
/// @brief An immutable empty `SODataV4_CsdlAssociationList`.
///
///
+ (nonnull SODataV4_CsdlAssociationList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlAssociation*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlAssociationList`.`length` - 1).
- (nonnull SODataV4_CsdlAssociation*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlAssociationList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlAssociation`.
- (SODataV4_boolean) includes :(nonnull SODataV4_CsdlAssociation*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlAssociation*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlAssociationList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlAssociation`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlAssociation*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlAssociationList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_CsdlAssociationList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlAssociationList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_CsdlAssociation*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlAssociation*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlAssociation*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlAssociationList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlAssociation`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlAssociation*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_CsdlAssociation*)item;
/// @brief Return a new `SODataV4_CsdlAssociationList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_CsdlAssociation` will be removed.
///
/// @return A new list of item type `SODataV4_CsdlAssociation`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_CsdlAssociationList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_CsdlAssociation*) single;
/// @internal
///
- (nonnull SODataV4_CsdlAssociationList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_CsdlAssociationList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_CsdlAssociationList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlAssociationList* empty;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlAssociationMap_EntryList_internal
#ifndef imported_SODataV4__CsdlAssociationMap_EntryList_internal
#define imported_SODataV4__CsdlAssociationMap_EntryList_public
/* internal */
/// @brief A list of item type `SODataV4_CsdlAssociationMap_Entry`.
///
///
@interface SODataV4_CsdlAssociationMap_EntryList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_CsdlAssociationMap_EntryList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_CsdlAssociationMap_EntryList*) new;
/// @brief Construct a new list with `SODataV4_CsdlAssociationMap_EntryList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_CsdlAssociationMap_EntryList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_CsdlAssociationMap_EntryList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_CsdlAssociationMap_EntryList*) addThis :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_CsdlAssociationMap_EntryList*) copy;
/// @brief An immutable empty `SODataV4_CsdlAssociationMap_EntryList`.
///
///
+ (nonnull SODataV4_CsdlAssociationMap_EntryList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlAssociationMap_Entry*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlAssociationMap_EntryList`.`length` - 1).
- (nonnull SODataV4_CsdlAssociationMap_Entry*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlAssociationMap_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlAssociationMap_Entry`.
- (SODataV4_boolean) includes :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlAssociationMap_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlAssociationMap_Entry`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlAssociationMap_Entry*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlAssociationMap_EntryList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_CsdlAssociationMap_EntryList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlAssociationMap_EntryList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlAssociationMap_Entry*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlAssociationMap_EntryList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlAssociationMap_Entry`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlAssociationMap_Entry*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_CsdlAssociationMap_Entry*)item;
/// @brief Return a new `SODataV4_CsdlAssociationMap_EntryList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_CsdlAssociationMap_Entry` will be removed.
///
/// @return A new list of item type `SODataV4_CsdlAssociationMap_Entry`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_CsdlAssociationMap_EntryList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_CsdlAssociationMap_Entry*) single;
/// @internal
///
- (nonnull SODataV4_CsdlAssociationMap_EntryList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_CsdlAssociationMap_EntryList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_CsdlAssociationMap_EntryList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlAssociationMap_EntryList* empty;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlOwnerList_internal
#ifndef imported_SODataV4__CsdlOwnerList_internal
#define imported_SODataV4__CsdlOwnerList_public
/* internal */
/// @brief A list of item type `SODataV4_CsdlOwner`.
///
///
@interface SODataV4_CsdlOwnerList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_CsdlOwnerList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_CsdlOwnerList*) new;
/// @brief Construct a new list with `SODataV4_CsdlOwnerList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_CsdlOwnerList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_CsdlOwner*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_CsdlOwnerList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_CsdlOwnerList*) addThis :(nonnull SODataV4_CsdlOwner*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_CsdlOwnerList*) copy;
/// @brief An immutable empty `SODataV4_CsdlOwnerList`.
///
///
+ (nonnull SODataV4_CsdlOwnerList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlOwner*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlOwnerList`.`length` - 1).
- (nonnull SODataV4_CsdlOwner*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlOwnerList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlOwner`.
- (SODataV4_boolean) includes :(nonnull SODataV4_CsdlOwner*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlOwner*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlOwnerList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlOwner`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlOwner*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlOwnerList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_CsdlOwnerList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlOwnerList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_CsdlOwner*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlOwner*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlOwner*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlOwnerList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlOwner`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlOwner*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_CsdlOwner*)item;
/// @brief Return a new `SODataV4_CsdlOwnerList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_CsdlOwner` will be removed.
///
/// @return A new list of item type `SODataV4_CsdlOwner`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_CsdlOwnerList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_CsdlOwner*) single;
/// @internal
///
- (nonnull SODataV4_CsdlOwnerList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_CsdlOwnerList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_CsdlOwnerList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlOwnerList* empty;
@end
#endif
#endif

#ifndef imported_SODataV4__CsdlReferenceList_public
#define imported_SODataV4__CsdlReferenceList_public
/// @brief A list of item type `SODataV4_CsdlReference`.
///
///
@interface SODataV4_CsdlReferenceList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_CsdlReferenceList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_CsdlReferenceList*) new;
/// @brief Construct a new list with `SODataV4_CsdlReferenceList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_CsdlReferenceList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_CsdlReference*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_CsdlReferenceList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_CsdlReferenceList*) addThis :(nonnull SODataV4_CsdlReference*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_CsdlReferenceList*) copy;
/// @brief An immutable empty `SODataV4_CsdlReferenceList`.
///
///
+ (nonnull SODataV4_CsdlReferenceList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlReference*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlReferenceList`.`length` - 1).
- (nonnull SODataV4_CsdlReference*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlReferenceList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlReference`.
- (SODataV4_boolean) includes :(nonnull SODataV4_CsdlReference*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlReference*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlReferenceList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlReference`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlReference*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlReferenceList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_CsdlReferenceList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlReferenceList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_CsdlReference*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlReference*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlReference*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlReferenceList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlReference`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlReference*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_CsdlReference*)item;
/// @brief Return a new `SODataV4_CsdlReferenceList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_CsdlReference` will be removed.
///
/// @return A new list of item type `SODataV4_CsdlReference`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_CsdlReferenceList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_CsdlReference*) single;
/// @internal
///
- (nonnull SODataV4_CsdlReferenceList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_CsdlReferenceList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_CsdlReferenceList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlReferenceList* empty;
@end
#endif

#ifndef imported_SODataV4__CsdlReference_IncludeList_public
#define imported_SODataV4__CsdlReference_IncludeList_public
/// @brief A list of item type `SODataV4_CsdlReference_Include`.
///
///
@interface SODataV4_CsdlReference_IncludeList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `SODataV4_CsdlReference_IncludeList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull SODataV4_CsdlReference_IncludeList*) new;
/// @brief Construct a new list with `SODataV4_CsdlReference_IncludeList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull SODataV4_CsdlReference_IncludeList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull SODataV4_CsdlReference_Include*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull SODataV4_CsdlReference_IncludeList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull SODataV4_CsdlReference_IncludeList*) addThis :(nonnull SODataV4_CsdlReference_Include*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull SODataV4_CsdlReference_IncludeList*) copy;
/// @brief An immutable empty `SODataV4_CsdlReference_IncludeList`.
///
///
+ (nonnull SODataV4_CsdlReference_IncludeList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlReference_Include*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlReference_IncludeList`.`length` - 1).
- (nonnull SODataV4_CsdlReference_Include*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlReference_IncludeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlReference_Include`.
- (SODataV4_boolean) includes :(nonnull SODataV4_CsdlReference_Include*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlReference_Include*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlReference_IncludeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlReference_Include`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull SODataV4_CsdlReference_Include*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlReference_IncludeList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull SODataV4_CsdlReference_IncludeList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `SODataV4_CsdlReference_IncludeList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull SODataV4_CsdlReference_Include*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull SODataV4_CsdlReference_Include*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlReference_Include*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `SODataV4_CsdlReference_IncludeList`.`equality` property, which would usually be expected to match the `==` operator for item type `SODataV4_CsdlReference_Include`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull SODataV4_CsdlReference_Include*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull SODataV4_CsdlReference_Include*)item;
/// @brief Return a new `SODataV4_CsdlReference_IncludeList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `SODataV4_CsdlReference_Include` will be removed.
///
/// @return A new list of item type `SODataV4_CsdlReference_Include`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull SODataV4_CsdlReference_IncludeList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull SODataV4_CsdlReference_Include*) single;
/// @internal
///
- (nonnull SODataV4_CsdlReference_IncludeList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull SODataV4_CsdlReference_IncludeList*) slice :(SODataV4_int)start :(SODataV4_int)end;
/// @brief An immutable empty `SODataV4_CsdlReference_IncludeList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlReference_IncludeList* empty;
@end
#endif

#ifndef imported_SODataV4__CsdlException_public
#define imported_SODataV4__CsdlException_public
/// @brief Exception thrown when an error occurs during the parsing of an Open Data Protocol ([OData](http://odata.org/)) service metadata ([CSDL](http://docs.oasis-open.org/odata/odata/v4.0/os/part3-csdl/odata-v4.0-os-part3-csdl.html)) document.
///
///
/// @see `SODataV4_CsdlParser`.
@interface SODataV4_CsdlException : SODataV4_DataSchemaException
{
    @private SODataV4_XmlElement* _Nullable element_;
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlException*) new;
/// @internal
///
- (void) _init;
/// @brief Construct a CSDL exception which indicates the metadata document at a particular `url` cannot be fetched.
///
///
/// @param url Metadata URL.
+ (nonnull SODataV4_CsdlException*) cannotFetch :(nonnull NSString*)url;
/// @brief CSDL XML element related to this exception.
///
///
- (nullable SODataV4_XmlElement*) element;
/// @brief CSDL XML element related to this exception.
///
///
- (void) setElement :(nullable SODataV4_XmlElement*)value;
/// @brief Construct a CSDL exception which indicates the metadata document at a particular `url` references an unknown schema.
///
///
/// @param ns Schema namespace.
+ (nonnull SODataV4_CsdlException*) unknownSchema :(nonnull NSString*)ns;
/// @return A new exception with the specified root cause.
/// @param cause Root cause.
+ (nonnull SODataV4_CsdlException*) withCause :(nullable NSException*)cause;
/// @return A new exception with the specified root cause and message text.
/// @param cause Root cause.
/// @param message Message text.
+ (nonnull SODataV4_CsdlException*) withCauseAndMessage :(nullable NSException*)cause :(nullable NSString*)message;
/// @brief Construct a CSDL exception which indicates a problem related to a particular CSDL XML element.
///
///
/// @param element XML element.
/// @param message Message text.
+ (nonnull SODataV4_CsdlException*) withElement :(nonnull SODataV4_XmlElement*)element :(nonnull NSString*)message;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_CsdlException*) withMessage :(nullable NSString*)message;
/// @brief CSDL XML element related to this exception.
///
///
@property (nonatomic, readwrite, strong, nullable) SODataV4_XmlElement* element;
@end
#endif

#ifdef import_SODataV4__CsdlException_private
#ifndef imported_SODataV4__CsdlException_private
#define imported_SODataV4__CsdlException_private
@interface SODataV4_CsdlException (private)
+ (nonnull SODataV4_CsdlException*) _new1 :(nullable NSException*)p1;
+ (nonnull SODataV4_CsdlException*) _new2 :(nullable NSException*)p1 :(nullable NSString*)p2;
+ (nonnull SODataV4_CsdlException*) _new3 :(nullable NSString*)p1 :(nullable SODataV4_XmlElement*)p2;
+ (nonnull SODataV4_CsdlException*) _new4 :(nullable NSString*)p1;
@end
#endif
#endif

#ifdef import_SODataV4__CsdlNavigation_internal
#ifndef imported_SODataV4__CsdlNavigation_internal
#define imported_SODataV4__CsdlNavigation_public
/* internal */
@interface SODataV4_CsdlNavigation : SODataV4_NavigationProperty
{
    @private NSString* _Nonnull relName_;
    @private NSString* _Nonnull fromRole_;
    @private NSString* _Nonnull toRole_;
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_CsdlNavigation*) new;
/// @internal
///
- (void) _init;
- (nonnull NSString*) fromRole;
- (nonnull NSString*) relName;
- (void) setFromRole :(nonnull NSString*)value;
- (void) setRelName :(nonnull NSString*)value;
- (void) setToRole :(nonnull NSString*)value;
- (nonnull NSString*) toRole;
@property (nonatomic, readwrite, strong, nonnull) NSString* fromRole;
@property (nonatomic, readwrite, strong, nonnull) NSString* relName;
@property (nonatomic, readwrite, strong, nonnull) NSString* toRole;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_core_MapFromString_in_csdl_internal
#ifndef imported_SODataV4__Any_as_core_MapFromString_in_csdl_internal
#define imported_SODataV4__Any_as_core_MapFromString_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_core_MapFromString_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_MapFromString*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_AnnotationToResolve_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_AnnotationToResolve_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_AnnotationToResolve_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_AnnotationToResolve_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_AnnotationToResolve*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_CsdlAssociationMap_Entry_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_CsdlAssociationMap_Entry_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_CsdlAssociationMap_Entry_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_CsdlAssociationMap_Entry_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_CsdlAssociationMap_Entry*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_CsdlAssociation_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_CsdlAssociation_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_CsdlAssociation_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_CsdlAssociation_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_CsdlAssociation*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_CsdlNavigation_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_CsdlNavigation_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_CsdlNavigation_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_CsdlNavigation_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_CsdlNavigation*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_CsdlOwner_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_CsdlOwner_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_CsdlOwner_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_CsdlOwner_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_CsdlOwner*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_CsdlReference_Include_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_CsdlReference_Include_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_CsdlReference_Include_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_CsdlReference_Include_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_CsdlReference_Include*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_csdl_CsdlReference_in_csdl_internal
#ifndef imported_SODataV4__Any_as_csdl_CsdlReference_in_csdl_internal
#define imported_SODataV4__Any_as_csdl_CsdlReference_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_csdl_CsdlReference_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_CsdlReference*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_ComplexType_in_csdl_internal
#ifndef imported_SODataV4__Any_as_data_ComplexType_in_csdl_internal
#define imported_SODataV4__Any_as_data_ComplexType_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_ComplexType_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_ComplexType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_DataType_in_csdl_internal
#ifndef imported_SODataV4__Any_as_data_DataType_in_csdl_internal
#define imported_SODataV4__Any_as_data_DataType_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_DataType_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_DataType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EntityType_in_csdl_internal
#ifndef imported_SODataV4__Any_as_data_EntityType_in_csdl_internal
#define imported_SODataV4__Any_as_data_EntityType_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EntityType_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EntityType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_as_data_EnumType_in_csdl_internal
#ifndef imported_SODataV4__Any_as_data_EnumType_in_csdl_internal
#define imported_SODataV4__Any_as_data_EnumType_in_csdl_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface SODataV4_Any_as_data_EnumType_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull SODataV4_EnumType*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_isNullable_data_ComplexValue_in_csdl_internal
#ifndef imported_SODataV4__Any_isNullable_data_ComplexValue_in_csdl_internal
#define imported_SODataV4__Any_isNullable_data_ComplexValue_in_csdl_public
/* internal */
/// @brief Utility class for instanceof checking with nullable target type.
///
///
@interface SODataV4_Any_isNullable_data_ComplexValue_in_csdl : SODataV4_ObjectBase
{
}
/// @return `true` if `value` is `nil` or is an instance of `SODataV4_ComplexValue`.
///
+ (SODataV4_boolean) check :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__Any_isNullable_data_EntityValue_in_csdl_internal
#ifndef imported_SODataV4__Any_isNullable_data_EntityValue_in_csdl_internal
#define imported_SODataV4__Any_isNullable_data_EntityValue_in_csdl_public
/* internal */
/// @brief Utility class for instanceof checking with nullable target type.
///
///
@interface SODataV4_Any_isNullable_data_EntityValue_in_csdl : SODataV4_ObjectBase
{
}
/// @return `true` if `value` is `nil` or is an instance of `SODataV4_EntityValue`.
///
+ (SODataV4_boolean) check :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_SODataV4__ApplyDefault_TypeFacets_in_csdl_internal
#ifndef imported_SODataV4__ApplyDefault_TypeFacets_in_csdl_internal
#define imported_SODataV4__ApplyDefault_TypeFacets_in_csdl_public
/* internal */
/// @brief Static functions to apply default values of type `SODataV4_TypeFacets`.
///
///
@interface SODataV4_ApplyDefault_TypeFacets_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (nonnull SODataV4_TypeFacets*) ifNull :(nullable SODataV4_TypeFacets*)value :(nonnull SODataV4_TypeFacets*)defaultValue;
@end
#endif
#endif

#ifdef import_SODataV4__ApplyDefault_boolean_in_csdl_internal
#ifndef imported_SODataV4__ApplyDefault_boolean_in_csdl_internal
#define imported_SODataV4__ApplyDefault_boolean_in_csdl_public
/* internal */
/// @brief Static functions to apply default values of type `boolean`.
///
///
@interface SODataV4_ApplyDefault_boolean_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_boolean) ifNull :(SODataV4_nullable_boolean)value :(SODataV4_boolean)defaultValue;
@end
#endif
#endif

#ifdef import_SODataV4__ApplyDefault_int_in_csdl_internal
#ifndef imported_SODataV4__ApplyDefault_int_in_csdl_internal
#define imported_SODataV4__ApplyDefault_int_in_csdl_public
/* internal */
/// @brief Static functions to apply default values of type `int`.
///
///
@interface SODataV4_ApplyDefault_int_in_csdl : SODataV4_ObjectBase
{
}
/// @return `value` if it is not `nil`, otherwise return `defaultValue`.
/// @param value Nullable value.
/// @param defaultValue Default value.
+ (SODataV4_int) ifNull :(SODataV4_nullable_int)value :(SODataV4_int)defaultValue;
@end
#endif
#endif

#ifdef import_SODataV4__List_count_EntitySetList_in_csdl_internal
#ifndef imported_SODataV4__List_count_EntitySetList_in_csdl_internal
#define imported_SODataV4__List_count_EntitySetList_in_csdl_public
/* internal */
@interface SODataV4_List_count_EntitySetList_in_csdl : SODataV4_ObjectBase
{
}
/// @brief Count items in a list matching a predicate.
///
///
/// @return Matching count.
/// @param value List to be processed.
/// @param fun Item predicate.
+ (SODataV4_int) call :(nonnull SODataV4_EntitySetList*)value :(SODataV4_boolean(^ _Nonnull)(SODataV4_EntitySet* _Nonnull))fun;
@end
#endif
#endif

#ifdef import_SODataV4__List_map_PropertyList_StringList_in_csdl_internal
#ifndef imported_SODataV4__List_map_PropertyList_StringList_in_csdl_internal
#define imported_SODataV4__List_map_PropertyList_StringList_in_csdl_public
/* internal */
@interface SODataV4_List_map_PropertyList_StringList_in_csdl : SODataV4_ObjectBase
{
}
/// @brief Map a list using an arrow function for item conversion.
///
///
/// @return New converted list.
/// @param value List to be converted.
/// @param fun Arrow function for item conversion.
+ (nonnull SODataV4_StringList*) call :(nonnull SODataV4_PropertyList*)value :(NSString* _Nonnull(^ _Nonnull)(SODataV4_Property* _Nonnull))fun;
@end
#endif
#endif

#endif
