//
//  SODataEntity.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"
#import "SODataAnnotationName.h"

@protocol SODataNavigationProperty;
@protocol SODataAssociationLink;
@protocol SODataComplexProperty;

/**
 Payload type representing an OData entry. This is the main abstraction through which business entities mapped using OData can be read and modified.
 */
@protocol SODataEntity <SODataPayload>

/**
 * The type of the entity in it's fully-qualified form which includes the namespace prefix.
 */
@property (readonly, nonatomic, copy) NSString* typeName;

/**
 * The path from which this entity has been obtained.
 */
@property (readonly, nonatomic, copy) NSString* resourcePath;

/**
 * EditResourcePath of the ODataEntity
 */
@property (readonly, nonatomic, copy) NSString* editResourcePath;

/**
 * Set the resourcePath for reading and the resourcePath for editing
 * @param resourcePath resourcePath of the ODataEntity
 * @param editResourcePath resourcePath of the ODataEntity for editing
 */
- (void) setResourcePath:(NSString *)resourcePath editResourcePath:(NSString*) editResourcePath;

/**
 * Convenience method telling whether this entity is a media entry.
 */
@property (readonly, nonatomic) BOOL isMediaEntry;

/**
 * MediaContentType of the ODataEntity
 */
@property (readonly, nonatomic, copy) NSString* mediaContentType;

/**
 * MediaLink of the ODataEntity
 */
@property (readonly, nonatomic) NSURL* mediaLink;

/**
 * EditMediaLink of the ODataEntity
 */
@property (readonly, nonatomic) NSURL* editMediaLink;

/**
 * Sets the media links and the media content type of this entity.
 * @param mediaLink MediaLink of the ODataEntity
 * @param editMediaLink EditMediaLink of the ODataEntity
 * @param mediaContentType MediaContentType of the ODataEntity
 */
- (void) setMediaLink:(NSURL*)mediaLink editMediaLink:(NSURL*)editMediaLink mediaContentType:(NSString*)mediaContentType;

/**
 *  The set containing the names of navigation properties.
 */
@property (readonly, nonatomic) NSSet* navigationPropertyNames;

/**
 * Returns the navigation property associated with the given key.
 * @param relationIdentifier - relation identifier of the NavigationProperty
 */
- (id<SODataNavigationProperty>)navigationPropertyForRelationIdentifier:(NSString*)relationIdentifier;

/**
 * Associates the specified key with the specified navigation property.
 * @param link - the NavigationLink for the identifier
 * @param relationIdentifier - relation identifier of the NavigationLink
 */
- (id<SODataNavigationProperty>)setNavigationProperty:(id<SODataNavigationProperty>)link forRelationIdentifier:(NSString*)relationIdentifier;

/**
 * Returns the current dictionary containing the data properties of this entity.
 */
@property (readonly, nonatomic) NSMutableDictionary* properties;

/**
 Returns a set of fully qualified local annotation names.
 */
@property (readonly, nonatomic, strong) NSArray* annotationNames;

/**
 Returns the annotation value specified by the given fully qualified local annotation name.
 @param annotationName the name of the annotation
 @return NSString
 */
- (NSString*)annotationForAnnotationName:(id<SODataAnnotationName>)annotationName;

/**
 Returns the annotation value specified by the given local annotation namespace and localname.
 @param name the name of the annotation
 @param aNamespace the namespace of the annotation
 @return NSString
 */
- (NSString*)annotationForName:(NSString*)name namespace:(NSString*)aNamespace;

/**
 * The ETag of the entry backing this entity.
 */
@property (nonatomic, copy) NSString* etag;

/**
 * The mediaEtag of the entry.
 */
@property (nonatomic, copy) NSString* mediaEtag;


@end
