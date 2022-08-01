//
//  SODataMetadataDefault.h
//  ODataAPI
//
//  Copyright (c) 2014 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODataMetadata.h"

/**
 Represents an OData Metadata.
 */
@interface SODataMetadataDefault : NSObject<SODataMetadata>

/**
 * Custom initializer
 * @param metadata the metadata in String format
 * @param metaNamespaces namespaces of the metadata
 * @param resourcePath the actual resourcePath
 * @param latestResourcePath the latest resourcepath
 * @param metaEntities the entities of the metadata
 * @param metaComplex the complex types of the metadata
 * @param metaEntityContainers the entity containers
 */
- (instancetype) initWithMetadataXML:(NSString*)metadata
             namespaces:(NSArray*)metaNamespaces
                 resourcePath:(NSString*)resourcePath
           latestResourcePath:(NSString*)latestResourcePath
                 metaEntities:(NSDictionary*)metaEntities
             metaComplexTypes:(NSDictionary*)metaComplex
         metaEntityContainers:(NSDictionary*)metaEntityContainers;

@end
