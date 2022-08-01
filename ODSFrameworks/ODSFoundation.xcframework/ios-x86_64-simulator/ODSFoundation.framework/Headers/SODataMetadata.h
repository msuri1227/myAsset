//
//  SODataMetadata.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import "SODataPayload.h"

@protocol SODataMetaEntityType;
@protocol SODataMetaComplexType;
@protocol SODataMetaEntityContainer;

/**
 Metadata representation describing an OData service's metadata. OData services are described by an Entity Data Model (EDM). Common Schema Definition Language (CSDL) defines an XML-based representation of
 the entity model exposed by an OData service. CSDL is based on standards defined in [XML 1.1] and [XML Schema]. An OData service SHOULD provide a CSDL description of its entity model when a client 
 requests a description of the entity model by sending a GET request to /$metadata. $metadata MUST wrap the CSDL document in an EDMX wrapper. This interface represents the CSDL description of its entity 
 model.
 */
@protocol SODataMetadata <SODataPayload>

/**
 The resource path of the metadata.
 */
@property (readonly, nonatomic, copy) NSString* resourcePath;

/**
 The last resource path of the metadata.
 */
@property (readonly, nonatomic, copy) NSString* latestResourcePath;

/**
 The Namespaces of the metadata.
 */
@property (readonly, nonatomic, strong) NSArray* metaNamespaces;

/**
 The set of fully qualified names of metadata entity types.
 */
@property (readonly, nonatomic, strong) NSArray* metaEntityNames;

/**
 The set of fully qualified names of the complex types.
 */
@property (readonly, nonatomic, strong) NSArray* metaComplexNames;

/**
 The set of fully qualified names of metadata entity containers.
 */
@property (readonly, nonatomic, strong) NSArray* metaEntityContainerNames;

/**
 Retrieves the xml raw format of the metadata as a String.
 */
@property (readonly, nonatomic, strong) NSString* xml;

/**
 Retrieves the metadata for an OData Entity Type specified by the given fully qualified name of the entity type.
 @param fqName the name of the Entity
 @return SODataMetaEntityType
 */
- (id<SODataMetaEntityType>)metaEntityForName:(NSString*)fqName;

/**
 Retrieves the metadata representation of a complex type specified by its fully qualified name.
 @param fqName the name of the Compley Type
 @return SODataMetaComplexType
 */
- (id<SODataMetaComplexType>)metaComplexForName:(NSString*)fqName;

/**
 Retrieves an entity container specified by its fully qualified name.
 @param fqName the name of the Entity Container
 @return SODataMetaEntityContainer
 */
-(id<SODataMetaEntityContainer>)metaEntityContainerForName:(NSString*)fqName;

@end
