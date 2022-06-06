//# xsc 19.1.1-0d1263-20190301

#ifndef APPLICATIONS_H
#define APPLICATIONS_H

#import "SODataV4_runtime.h"

@class ApplicationsFactory; /* internal */
@class ApplicationsMetadata;
@class ApplicationsMetadataChanges; /* internal */
@class ApplicationsMetadataParser; /* internal */
@class ApplicationsMetadataText; /* internal */
@class ApplicationsMetadata_EntitySets;
@class ApplicationsMetadata_EntityTypes;
@class ApplicationsStaticResolver; /* internal */
@class Applications;
@class ApplicationsFactory_CreateCapability; /* internal */
@class ApplicationsFactory_CreateConnection; /* internal */
@class ApplicationsFactory_CreateEndpoint; /* internal */
@class ApplicationsFactory_CreateFeatureVectorPolicy; /* internal */
@class CapabilityList;
@class ConnectionList;
@class EndpointList;
@class FeatureVectorPolicyList;
@class Capability;
@class Connection;
@class Endpoint;
@class FeatureVectorPolicy;
@class Any_as_applications_Capability_in_applications; /* internal */
@class Any_as_applications_Connection_in_applications; /* internal */
@class Any_as_applications_Endpoint_in_applications; /* internal */
@class Any_as_applications_FeatureVectorPolicy_in_applications; /* internal */

#ifdef import_ApplicationsFactory_internal
#ifndef imported_ApplicationsFactory_internal
#define imported_ApplicationsFactory_public
/* internal */
@interface ApplicationsFactory : SODataV4_ObjectBase
{
}
+ (void) registerAll;
@end
#endif
#endif

#ifndef imported_ApplicationsMetadata_public
#define imported_ApplicationsMetadata_public
@interface ApplicationsMetadata : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (nonnull SODataV4_CsdlDocument*) document;
+ (void) setDocument :(nonnull SODataV4_CsdlDocument*)value;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_CsdlDocument* document;
@end
#endif

#ifdef import_ApplicationsMetadata_private
#ifndef imported_ApplicationsMetadata_private
#define imported_ApplicationsMetadata_private
@interface ApplicationsMetadata (private)
+ (nonnull SODataV4_CsdlDocument*) resolve;
@end
#endif
#endif

#ifdef import_ApplicationsMetadataChanges_internal
#ifndef imported_ApplicationsMetadataChanges_internal
#define imported_ApplicationsMetadataChanges_public
/* internal */
@interface ApplicationsMetadataChanges : SODataV4_ObjectBase
{
}
+ (void) merge :(nonnull SODataV4_CsdlDocument*)metadata;
@end
#endif
#endif

#ifdef import_ApplicationsMetadataChanges_private
#ifndef imported_ApplicationsMetadataChanges_private
#define imported_ApplicationsMetadataChanges_private
@interface ApplicationsMetadataChanges (private)
+ (void) merge1 :(nonnull SODataV4_CsdlDocument*)metadata;
@end
#endif
#endif

#ifdef import_ApplicationsMetadataParser_internal
#ifndef imported_ApplicationsMetadataParser_internal
#define imported_ApplicationsMetadataParser_public
/* internal */
@interface ApplicationsMetadataParser : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (SODataV4_int) options;
+ (nonnull SODataV4_CsdlDocument*) parse;
+ (nonnull SODataV4_CsdlDocument*) parsed;
@property (nonatomic, readonly, class) SODataV4_int options;
@property (nonatomic, readonly, class, strong, nonnull) SODataV4_CsdlDocument* parsed;
@end
#endif
#endif

#ifdef import_ApplicationsMetadataText_internal
#ifndef imported_ApplicationsMetadataText_internal
#define imported_ApplicationsMetadataText_public
/* internal */
@interface ApplicationsMetadataText : SODataV4_ObjectBase
{
}
#define ApplicationsMetadataText_XML @"<?xml version=\"1.0\" encoding=\"utf-8\"?><edmx:Edmx Version=\"1.0\" xmlns:edmx=\"http://schemas.microsoft.com/ado/2007/06/edmx\" xmlns:sup=\"http://www.sybase.com/sup/odata\"><edmx:DataServices m:DataServiceVersion=\"2.0\" xmlns:m=\"http://schemas.microsoft.com/ado/2007/08/dataservices/metadata\"><Schema Namespace=\"applications\" xmlns=\"http://schemas.microsoft.com/ado/2008/09/edm\"><EntityType Name=\"Endpoint\"><Key><PropertyRef Name=\"EndpointName\"></PropertyRef></Key><Property Name=\"RemoteURL\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"EndpointName\" Type=\"Edm.String\" Nullable=\"false\" sup:ReadOnly=\"true\"></Property><Property Name=\"AnonymousAccess\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property></EntityType><EntityType Name=\"Capability\"><Key><PropertyRef Name=\"ApplicationConnectionId\"></PropertyRef><PropertyRef Name=\"Category\"></PropertyRef><PropertyRef Name=\"CapabilityName\"></PropertyRef></Key><Property Name=\"Category\" Type=\"Edm.String\" Nullable=\"false\"></Property><Property Name=\"ApplicationConnectionId\" Type=\"Edm.String\" Nullable=\"false\" sup:ReadOnly=\"true\"></Property><Property Name=\"CapabilityValue\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"CapabilityName\" Type=\"Edm.String\" Nullable=\"false\"></Property></EntityType><EntityType Name=\"Connection\"><Key><PropertyRef Name=\"ApplicationConnectionId\"></PropertyRef></Key><Property Name=\"ETag\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"ApplicationConnectionId\" Type=\"Edm.String\" Nullable=\"false\" sup:ReadOnly=\"true\"></Property><Property Name=\"UserName\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"AndroidGcmPushEnabled\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"AndroidGcmRegistrationId\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"AndroidGcmSenderId\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"ApnsPushEnable\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"ApnsDeviceToken\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"ApplicationVersion\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"BlackberryPushEnabled\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"BlackberryDevicePin\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"BlackberryBESListenerPort\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"BlackberryPushAppID\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"BlackberryPushBaseURL\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"BlackberryPushListenerPort\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"BlackberryListenerType\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"CollectClientUsageReports\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"ConnectionLogLevel\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"CustomizationBundleId\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"CustomCustom1\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"CustomCustom2\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"CustomCustom3\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"CustomCustom4\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"DeviceModel\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"DeviceType\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"DeviceSubType\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"DevicePhoneNumber\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"DeviceIMSI\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"E2ETraceLevel\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"EnableAppSpecificClientUsageKeys\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"FeatureVectorPolicyAllEnabled\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"FormFactor\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"LogEntryExpiry\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"MaxConnectionWaitTimeForClientUsage\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"MpnsChannelURI\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"MpnsPushEnable\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"PasswordPolicyEnabled\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyDefaultPasswordAllowed\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyMinLength\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyDigitRequired\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyUpperRequired\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyLowerRequired\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicySpecialRequired\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyExpiresInNDays\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyMinUniqueChars\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyLockTimeout\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyRetryLimit\" Type=\"Edm.Int32\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PasswordPolicyFingerprintEnabled\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"ProxyApplicationEndpoint\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"ProxyPushEndpoint\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PublishedToMobilePlace\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"UploadLogs\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"WnsChannelURI\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"WnsPushEnable\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"InAppMessaging\" Type=\"Edm.Boolean\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"UserLocale\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"TimeZone\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"LastKnownLocation\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"CreatedAt\" Type=\"Edm.DateTime\" Nullable=\"true\" sup:ReadOnly=\"true\"></Property><Property Name=\"PushGroup\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><Property Name=\"Email\" Type=\"Edm.String\" Nullable=\"true\" sup:ReadOnly=\"false\"></Property><NavigationProperty Name=\"Capability\" Relationship=\"applications.FK_Connection_Capability\" FromRole=\"Connection\" ToRole=\"Capability\"></NavigationProperty><NavigationProperty Name=\"FeatureVectorPolicy\" Relationship=\"applications.FK_Connection_FeatureVectorPolicy\" FromRole=\"Connection\" ToRole=\"FeatureVectorPolicy\"></NavigationProperty></EntityType><EntityType Name=\"FeatureVectorPolicy\"><Key><PropertyRef Name=\"Id\"></PropertyRef></Key><Property Name=\"Description\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"PluginName\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"Version\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"DisplayName\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"JSModule\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"Whitelist\" Type=\"Edm.String\" Nullable=\"true\"></Property><Property Name=\"Id\" Type=\"Edm.String\" Nullable=\"false\"></Property><Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"true\"></Property></EntityType><Association Name=\"FK_Connection_Capability\"><End Type=\"applications.Connection\" Multiplicity=\"0..1\" Role=\"Connection\"></End><End Type=\"applications.Capability\" Multiplicity=\"*\" Role=\"Capability\"></End></Association><Association Name=\"FK_Connection_FeatureVectorPolicy\"><End Type=\"applications.Connection\" Multiplicity=\"0..1\" Role=\"Connection\"></End><End Type=\"applications.FeatureVectorPolicy\" Multiplicity=\"*\" Role=\"FeatureVectorPolicy\"></End></Association><EntityContainer Name=\"Container\" m:IsDefaultEntityContainer=\"true\"><EntitySet Name=\"Endpoints\" EntityType=\"applications.Endpoint\"></EntitySet><EntitySet Name=\"Connections\" EntityType=\"applications.Connection\"></EntitySet><EntitySet Name=\"FeatureVectorPolicies\" EntityType=\"applications.FeatureVectorPolicy\"></EntitySet><EntitySet Name=\"Capabilities\" EntityType=\"applications.Capability\"></EntitySet><AssociationSet Name=\"FK_Connection_Capability\" Association=\"applications.FK_Connection_Capability\"><End EntitySet=\"Connections\" Role=\"Connection\"></End><End EntitySet=\"Capabilities\" Role=\"Capability\"></End></AssociationSet><AssociationSet Name=\"FK_Connection_FeatureVectorPolicy\" Association=\"applications.FK_Connection_FeatureVectorPolicy\"><End EntitySet=\"Connections\" Role=\"Connection\"></End><End EntitySet=\"FeatureVectorPolicies\" Role=\"FeatureVectorPolicy\"></End></AssociationSet></EntityContainer></Schema></edmx:DataServices></edmx:Edmx>\n"
@end
#endif
#endif

#ifndef imported_ApplicationsMetadata_EntitySets_public
#define imported_ApplicationsMetadata_EntitySets_public
@interface ApplicationsMetadata_EntitySets : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (nonnull SODataV4_EntitySet*) capabilities;
+ (nonnull SODataV4_EntitySet*) connections;
+ (nonnull SODataV4_EntitySet*) endpoints;
+ (nonnull SODataV4_EntitySet*) featureVectorPolicies;
+ (void) setCapabilities :(nonnull SODataV4_EntitySet*)value;
+ (void) setConnections :(nonnull SODataV4_EntitySet*)value;
+ (void) setEndpoints :(nonnull SODataV4_EntitySet*)value;
+ (void) setFeatureVectorPolicies :(nonnull SODataV4_EntitySet*)value;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntitySet* capabilities;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntitySet* connections;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntitySet* endpoints;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntitySet* featureVectorPolicies;
@end
#endif

#ifndef imported_ApplicationsMetadata_EntityTypes_public
#define imported_ApplicationsMetadata_EntityTypes_public
@interface ApplicationsMetadata_EntityTypes : SODataV4_ObjectBase
{
}
+ (void) initialize;
+ (nonnull SODataV4_EntityType*) capability;
+ (nonnull SODataV4_EntityType*) connection;
+ (nonnull SODataV4_EntityType*) endpoint;
+ (nonnull SODataV4_EntityType*) featureVectorPolicy;
+ (void) setCapability :(nonnull SODataV4_EntityType*)value;
+ (void) setConnection :(nonnull SODataV4_EntityType*)value;
+ (void) setEndpoint :(nonnull SODataV4_EntityType*)value;
+ (void) setFeatureVectorPolicy :(nonnull SODataV4_EntityType*)value;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntityType* capability;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntityType* connection;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntityType* endpoint;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_EntityType* featureVectorPolicy;
@end
#endif

#ifdef import_ApplicationsStaticResolver_internal
#ifndef imported_ApplicationsStaticResolver_internal
#define imported_ApplicationsStaticResolver_public
/* internal */
@interface ApplicationsStaticResolver : SODataV4_ObjectBase
{
}
+ (void) resolve;
@end
#endif
#endif

#ifdef import_ApplicationsStaticResolver_private
#ifndef imported_ApplicationsStaticResolver_private
#define imported_ApplicationsStaticResolver_private
@interface ApplicationsStaticResolver (private)
+ (void) resolve1;
@end
#endif
#endif

#ifndef imported_Applications_public
#define imported_Applications_public
@interface Applications : SODataV4_DataService
{
}
- (nonnull id) init;
+ (nonnull Applications*) new :(nonnull id<SODataV4_DataServiceProvider>)provider;
/// @internal
///
- (void) _init :(nonnull id<SODataV4_DataServiceProvider>)provider;
/// @internal
///
- (nonnull CapabilityList*) getCapabilities;
/// @internal
///
- (nonnull CapabilityList*) getCapabilities :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull CapabilityList*) getCapabilities :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull CapabilityList*) getCapabilities :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull Capability*) getCapability :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull Capability*) getCapability :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull Capability*) getCapability :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull Capability*) getCapabilityWithKey :(nonnull NSString*)applicationConnectionID :(nonnull NSString*)category :(nonnull NSString*)capabilityName;
/// @internal
///
- (nonnull Capability*) getCapabilityWithKey :(nonnull NSString*)applicationConnectionID :(nonnull NSString*)category :(nonnull NSString*)capabilityName :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull Capability*) getCapabilityWithKey :(nonnull NSString*)applicationConnectionID :(nonnull NSString*)category :(nonnull NSString*)capabilityName :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull Capability*) getCapabilityWithKey :(nonnull NSString*)applicationConnectionID :(nonnull NSString*)category :(nonnull NSString*)capabilityName :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull Connection*) getConnection :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull Connection*) getConnection :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull Connection*) getConnection :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull Connection*) getConnectionWithKey :(nonnull NSString*)applicationConnectionID;
/// @internal
///
- (nonnull Connection*) getConnectionWithKey :(nonnull NSString*)applicationConnectionID :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull Connection*) getConnectionWithKey :(nonnull NSString*)applicationConnectionID :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull Connection*) getConnectionWithKey :(nonnull NSString*)applicationConnectionID :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull ConnectionList*) getConnections;
/// @internal
///
- (nonnull ConnectionList*) getConnections :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull ConnectionList*) getConnections :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull ConnectionList*) getConnections :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull Endpoint*) getEndpoint :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull Endpoint*) getEndpoint :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull Endpoint*) getEndpoint :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull Endpoint*) getEndpointWithKey :(nonnull NSString*)endpointName;
/// @internal
///
- (nonnull Endpoint*) getEndpointWithKey :(nonnull NSString*)endpointName :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull Endpoint*) getEndpointWithKey :(nonnull NSString*)endpointName :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull Endpoint*) getEndpointWithKey :(nonnull NSString*)endpointName :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull EndpointList*) getEndpoints;
/// @internal
///
- (nonnull EndpointList*) getEndpoints :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull EndpointList*) getEndpoints :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull EndpointList*) getEndpoints :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull FeatureVectorPolicyList*) getFeatureVectorPolicies;
/// @internal
///
- (nonnull FeatureVectorPolicyList*) getFeatureVectorPolicies :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull FeatureVectorPolicyList*) getFeatureVectorPolicies :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull FeatureVectorPolicyList*) getFeatureVectorPolicies :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicy :(nonnull SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicy :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicy :(nonnull SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
/// @internal
///
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicyWithKey :(nonnull NSString*)id_;
/// @internal
///
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicyWithKey :(nonnull NSString*)id_ :(nullable SODataV4_DataQuery*)query;
/// @internal
///
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicyWithKey :(nonnull NSString*)id_ :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers;
- (nonnull FeatureVectorPolicy*) getFeatureVectorPolicyWithKey :(nonnull NSString*)id_ :(nullable SODataV4_DataQuery*)query :(nullable SODataV4_HttpHeaders*)headers :(nullable SODataV4_RequestOptions*)options;
- (void) refreshMetadata;
@end
#endif

#ifdef import_ApplicationsFactory_CreateCapability_internal
#ifndef imported_ApplicationsFactory_CreateCapability_internal
#define imported_ApplicationsFactory_CreateCapability_public
/* internal */
@interface ApplicationsFactory_CreateCapability : SODataV4_ObjectFactory
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull ApplicationsFactory_CreateCapability*) new;
/// @internal
///
- (void) _init;
- (nonnull NSObject*) create;
@end
#endif
#endif

#ifdef import_ApplicationsFactory_CreateConnection_internal
#ifndef imported_ApplicationsFactory_CreateConnection_internal
#define imported_ApplicationsFactory_CreateConnection_public
/* internal */
@interface ApplicationsFactory_CreateConnection : SODataV4_ObjectFactory
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull ApplicationsFactory_CreateConnection*) new;
/// @internal
///
- (void) _init;
- (nonnull NSObject*) create;
@end
#endif
#endif

#ifdef import_ApplicationsFactory_CreateEndpoint_internal
#ifndef imported_ApplicationsFactory_CreateEndpoint_internal
#define imported_ApplicationsFactory_CreateEndpoint_public
/* internal */
@interface ApplicationsFactory_CreateEndpoint : SODataV4_ObjectFactory
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull ApplicationsFactory_CreateEndpoint*) new;
/// @internal
///
- (void) _init;
- (nonnull NSObject*) create;
@end
#endif
#endif

#ifdef import_ApplicationsFactory_CreateFeatureVectorPolicy_internal
#ifndef imported_ApplicationsFactory_CreateFeatureVectorPolicy_internal
#define imported_ApplicationsFactory_CreateFeatureVectorPolicy_public
/* internal */
@interface ApplicationsFactory_CreateFeatureVectorPolicy : SODataV4_ObjectFactory
{
}
- (nonnull id) init;
/// @brief Default initializer.
///
///
+ (nonnull ApplicationsFactory_CreateFeatureVectorPolicy*) new;
/// @internal
///
- (void) _init;
- (nonnull NSObject*) create;
@end
#endif
#endif

#ifndef imported_CapabilityList_public
#define imported_CapabilityList_public
/// @brief A list of item type `Capability`.
///
///
@interface CapabilityList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `CapabilityList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull CapabilityList*) new;
/// @brief Construct a new list with `CapabilityList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull CapabilityList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull Capability*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull CapabilityList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull CapabilityList*) addThis :(nonnull Capability*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull CapabilityList*) copy;
/// @brief An immutable empty `CapabilityList`.
///
///
+ (nonnull CapabilityList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull Capability*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `CapabilityList`.`length` - 1).
- (nonnull Capability*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `CapabilityList`.`equality` property, which would usually be expected to match the `==` operator for item type `Capability`.
- (SODataV4_boolean) includes :(nonnull Capability*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull Capability*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `CapabilityList`.`equality` property, which would usually be expected to match the `==` operator for item type `Capability`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull Capability*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `CapabilityList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull CapabilityList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `CapabilityList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull Capability*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull Capability*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull Capability*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `CapabilityList`.`equality` property, which would usually be expected to match the `==` operator for item type `Capability`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull Capability*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull Capability*)item;
/// @brief Return a new `CapabilityList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `Capability` will be removed.
///
/// @return A new list of item type `Capability`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull CapabilityList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull Capability*) single;
/// @internal
///
- (nonnull CapabilityList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull CapabilityList*) slice :(SODataV4_int)start :(SODataV4_int)end;
- (nullable SODataV4_ListBase*) toDynamic;
- (nonnull SODataV4_EntityValueList*) toEntityList;
/// @brief An immutable empty `CapabilityList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) CapabilityList* empty;
@end
#endif

#ifndef imported_ConnectionList_public
#define imported_ConnectionList_public
/// @brief A list of item type `Connection`.
///
///
@interface ConnectionList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `ConnectionList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull ConnectionList*) new;
/// @brief Construct a new list with `ConnectionList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull ConnectionList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull Connection*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull ConnectionList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull ConnectionList*) addThis :(nonnull Connection*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull ConnectionList*) copy;
/// @brief An immutable empty `ConnectionList`.
///
///
+ (nonnull ConnectionList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull Connection*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `ConnectionList`.`length` - 1).
- (nonnull Connection*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `ConnectionList`.`equality` property, which would usually be expected to match the `==` operator for item type `Connection`.
- (SODataV4_boolean) includes :(nonnull Connection*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull Connection*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `ConnectionList`.`equality` property, which would usually be expected to match the `==` operator for item type `Connection`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull Connection*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `ConnectionList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull ConnectionList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `ConnectionList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull Connection*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull Connection*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull Connection*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `ConnectionList`.`equality` property, which would usually be expected to match the `==` operator for item type `Connection`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull Connection*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull Connection*)item;
/// @brief Return a new `ConnectionList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `Connection` will be removed.
///
/// @return A new list of item type `Connection`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull ConnectionList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull Connection*) single;
/// @internal
///
- (nonnull ConnectionList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull ConnectionList*) slice :(SODataV4_int)start :(SODataV4_int)end;
- (nullable SODataV4_ListBase*) toDynamic;
- (nonnull SODataV4_EntityValueList*) toEntityList;
/// @brief An immutable empty `ConnectionList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) ConnectionList* empty;
@end
#endif

#ifndef imported_EndpointList_public
#define imported_EndpointList_public
/// @brief A list of item type `Endpoint`.
///
///
@interface EndpointList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `EndpointList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull EndpointList*) new;
/// @brief Construct a new list with `EndpointList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull EndpointList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull Endpoint*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull EndpointList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull EndpointList*) addThis :(nonnull Endpoint*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull EndpointList*) copy;
/// @brief An immutable empty `EndpointList`.
///
///
+ (nonnull EndpointList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull Endpoint*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `EndpointList`.`length` - 1).
- (nonnull Endpoint*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `EndpointList`.`equality` property, which would usually be expected to match the `==` operator for item type `Endpoint`.
- (SODataV4_boolean) includes :(nonnull Endpoint*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull Endpoint*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `EndpointList`.`equality` property, which would usually be expected to match the `==` operator for item type `Endpoint`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull Endpoint*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `EndpointList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull EndpointList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `EndpointList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull Endpoint*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull Endpoint*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull Endpoint*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `EndpointList`.`equality` property, which would usually be expected to match the `==` operator for item type `Endpoint`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull Endpoint*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull Endpoint*)item;
/// @brief Return a new `EndpointList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `Endpoint` will be removed.
///
/// @return A new list of item type `Endpoint`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull EndpointList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull Endpoint*) single;
/// @internal
///
- (nonnull EndpointList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull EndpointList*) slice :(SODataV4_int)start :(SODataV4_int)end;
- (nullable SODataV4_ListBase*) toDynamic;
- (nonnull SODataV4_EntityValueList*) toEntityList;
/// @brief An immutable empty `EndpointList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) EndpointList* empty;
@end
#endif

#ifndef imported_FeatureVectorPolicyList_public
#define imported_FeatureVectorPolicyList_public
/// @brief A list of item type `FeatureVectorPolicy`.
///
///
@interface FeatureVectorPolicyList : SODataV4_ListBase
{
}
+ (void) initialize;
- (nonnull id) init;
/// @brief Construct a new list with `FeatureVectorPolicyList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
+ (nonnull FeatureVectorPolicyList*) new;
/// @brief Construct a new list with `FeatureVectorPolicyList`.`length` of zero and optional initial `capacity`.
///
/// A list can expand in length beyond its initial capacity, but best performance
/// will be obtained if the initial capacity is close to the list's maximum length.
///
/// @param capacity Optional initial capacity.
+ (nonnull FeatureVectorPolicyList*) new :(SODataV4_int)capacity;
/// @internal
///
- (void) _init :(SODataV4_int)capacity;
/// @brief Add `item` to the end of this list.
///
///
/// @param item Item to be added.
- (void) add :(nonnull FeatureVectorPolicy*)item;
/// @brief Add all the items of `list` to the end of this list.
///
///
/// @param list Items to be added.
- (void) addAll :(nonnull FeatureVectorPolicyList*)list;
/// @brief Add `item` to the end of this list.
///
///
/// @return This list.
/// @param item Item to be added.
- (nonnull FeatureVectorPolicyList*) addThis :(nonnull FeatureVectorPolicy*)item;
/// @return A [shallow copy](https://en.wikipedia.org/wiki/Object_copying#Shallow_copy) of this list.
///
- (nonnull FeatureVectorPolicyList*) copy;
/// @brief An immutable empty `FeatureVectorPolicyList`.
///
///
+ (nonnull FeatureVectorPolicyList*) empty;
/// @return The first item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull FeatureVectorPolicy*) first;
/// @return The item in this list at the specified `index`.
/// @param index Zero-based index.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `FeatureVectorPolicyList`.`length` - 1).
- (nonnull FeatureVectorPolicy*) get :(SODataV4_int)index;
/// @return `true` if this list contains `item`.
/// @param item Item for comparison. Comparison uses the `FeatureVectorPolicyList`.`equality` property, which would usually be expected to match the `==` operator for item type `FeatureVectorPolicy`.
- (SODataV4_boolean) includes :(nonnull FeatureVectorPolicy*)item;
/// @internal
///
- (SODataV4_int) indexOf :(nonnull FeatureVectorPolicy*)item;
/// @return First index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `FeatureVectorPolicyList`.`equality` property, which would usually be expected to match the `==` operator for item type `FeatureVectorPolicy`.
/// @param start (optional) Zero-based starting index (search moves forwards from this index).
- (SODataV4_int) indexOf :(nonnull FeatureVectorPolicy*)item :(SODataV4_int)start;
/// @brief Insert all items of `list` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param list List of items to be inserted.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `FeatureVectorPolicyList`.`length`).
- (void) insertAll :(SODataV4_int)index :(nonnull FeatureVectorPolicyList*)list;
/// @brief Insert `item` into this list, before the item (if any) at `index`.
///
///
/// @param index Zero-based index.
/// @param item Item to be added.
/// @throw `SODataV4_ListIndexException` if `index` is out of range (0 to `FeatureVectorPolicyList`.`length`).
- (void) insertAt :(SODataV4_int)index :(nonnull FeatureVectorPolicy*)item;
/// @return The last item in this list.
/// @throw `SODataV4_EmptyListException` if the list is empty.
- (nonnull FeatureVectorPolicy*) last;
/// @internal
///
- (SODataV4_int) lastIndexOf :(nonnull FeatureVectorPolicy*)item;
/// @return Last index in this list of `item`, or `-1` if not found.
/// @param item Item for comparison. Comparison uses the `FeatureVectorPolicyList`.`equality` property, which would usually be expected to match the `==` operator for item type `FeatureVectorPolicy`.
/// @param start (optional) Zero-based starting index (search moves backwards from this index).
- (SODataV4_int) lastIndexOf :(nonnull FeatureVectorPolicy*)item :(SODataV4_int)start;
/// @brief Set the item in this list at the specified `index`.
///
///
/// @param index Zero-based index.
/// @param item Item value.
- (void) set :(SODataV4_int)index :(nonnull FeatureVectorPolicy*)item;
/// @brief Return a new `FeatureVectorPolicyList` that shares the `SODataV4_ListBase`.`untypedList` as the `list` parameter.
///
/// To ensure type safety, items in `list` that do not have the item type `FeatureVectorPolicy` will be removed.
///
/// @return A new list of item type `FeatureVectorPolicy`, sharing the same items as `list`.
/// @param list List whose items will be shared by the resulting list.
+ (nonnull FeatureVectorPolicyList*) share :(nonnull SODataV4_ListBase*)list;
/// @return A single item from this list.
/// @throw `SODataV4_EmptyListException` if the list has no items, `SODataV4_NotUniqueException` if the list has multiple items.
- (nonnull FeatureVectorPolicy*) single;
/// @internal
///
- (nonnull FeatureVectorPolicyList*) slice :(SODataV4_int)start;
/// @return A slice of this list from index `start` (inclusive) to index `end` (exclusive).
/// @param start Zero-based starting index (inclusive), or negative for starting index relative to the end of this list.
/// @param end (optional) Zero-based ending index (exclusive), or negative for ending index relative to the end of this list.
- (nonnull FeatureVectorPolicyList*) slice :(SODataV4_int)start :(SODataV4_int)end;
- (nullable SODataV4_ListBase*) toDynamic;
- (nonnull SODataV4_EntityValueList*) toEntityList;
/// @brief An immutable empty `FeatureVectorPolicyList`.
///
///
@property (nonatomic, readonly, class, strong, nonnull) FeatureVectorPolicyList* empty;
@end
#endif

#ifndef imported_Capability_public
#define imported_Capability_public
@interface Capability : SODataV4_EntityValue
{
}
+ (void) initialize;
- (nonnull id) init;
+ (nonnull Capability*) new;
+ (nonnull Capability*) new :(SODataV4_boolean)withDefaults;
/// @internal
///
- (void) _init :(SODataV4_boolean)withDefaults;
+ (nonnull SODataV4_Property*) applicationConnectionID;
- (nonnull NSString*) applicationConnectionID;
+ (nonnull SODataV4_Property*) capabilityName;
- (nonnull NSString*) capabilityName;
+ (nonnull SODataV4_Property*) capabilityValue;
- (nullable NSString*) capabilityValue;
+ (nonnull SODataV4_Property*) category;
- (nonnull NSString*) category;
- (nonnull Capability*) copy;
- (SODataV4_boolean) isProxy;
+ (nonnull SODataV4_EntityKey*) key :(nonnull NSString*)applicationConnectionID :(nonnull NSString*)category :(nonnull NSString*)capabilityName;
+ (nonnull CapabilityList*) list :(nonnull SODataV4_EntityValueList*)from;
- (nonnull Capability*) old;
+ (void) setApplicationConnectionID :(nonnull SODataV4_Property*)value;
- (void) setApplicationConnectionID :(nonnull NSString*)value;
+ (void) setCapabilityName :(nonnull SODataV4_Property*)value;
- (void) setCapabilityName :(nonnull NSString*)value;
+ (void) setCapabilityValue :(nonnull SODataV4_Property*)value;
- (void) setCapabilityValue :(nullable NSString*)value;
+ (void) setCategory :(nonnull SODataV4_Property*)value;
- (void) setCategory :(nonnull NSString*)value;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* applicationConnectionID;
@property (nonatomic, readwrite, strong, nonnull) NSString* applicationConnectionID;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* capabilityName;
@property (nonatomic, readwrite, strong, nonnull) NSString* capabilityName;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* capabilityValue;
@property (nonatomic, readwrite, strong, nullable) NSString* capabilityValue;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* category;
@property (nonatomic, readwrite, strong, nonnull) NSString* category;
@property (nonatomic, readonly) SODataV4_boolean isProxy;
@property (nonatomic, readonly, strong, nonnull) Capability* old;
@end
#endif

#ifndef imported_Connection_public
#define imported_Connection_public
@interface Connection : SODataV4_EntityValue
{
}
+ (void) initialize;
- (nonnull id) init;
+ (nonnull Connection*) new;
+ (nonnull Connection*) new :(SODataV4_boolean)withDefaults;
/// @internal
///
- (void) _init :(SODataV4_boolean)withDefaults;
+ (nonnull SODataV4_Property*) androidGcmPushEnabled;
- (SODataV4_nullable_boolean) androidGcmPushEnabled;
+ (nonnull SODataV4_Property*) androidGcmRegistrationID;
- (nullable NSString*) androidGcmRegistrationID;
+ (nonnull SODataV4_Property*) androidGcmSenderID;
- (nullable NSString*) androidGcmSenderID;
+ (nonnull SODataV4_Property*) apnsDeviceToken;
- (nullable NSString*) apnsDeviceToken;
+ (nonnull SODataV4_Property*) apnsPushEnable;
- (SODataV4_nullable_boolean) apnsPushEnable;
+ (nonnull SODataV4_Property*) applicationConnectionID;
- (nonnull NSString*) applicationConnectionID;
+ (nonnull SODataV4_Property*) applicationVersion;
- (nullable NSString*) applicationVersion;
+ (nonnull SODataV4_Property*) blackberryBESListenerPort;
- (SODataV4_nullable_int) blackberryBESListenerPort;
+ (nonnull SODataV4_Property*) blackberryDevicePin;
- (nullable NSString*) blackberryDevicePin;
+ (nonnull SODataV4_Property*) blackberryListenerType;
- (SODataV4_nullable_int) blackberryListenerType;
+ (nonnull SODataV4_Property*) blackberryPushAppID;
- (nullable NSString*) blackberryPushAppID;
+ (nonnull SODataV4_Property*) blackberryPushBaseURL;
- (nullable NSString*) blackberryPushBaseURL;
+ (nonnull SODataV4_Property*) blackberryPushEnabled;
- (SODataV4_nullable_boolean) blackberryPushEnabled;
+ (nonnull SODataV4_Property*) blackberryPushListenerPort;
- (SODataV4_nullable_int) blackberryPushListenerPort;
+ (nonnull SODataV4_Property*) capability;
- (nonnull CapabilityList*) capability;
+ (nonnull SODataV4_Property*) collectClientUsageReports;
- (SODataV4_nullable_boolean) collectClientUsageReports;
+ (nonnull SODataV4_Property*) connectionLogLevel;
- (nullable NSString*) connectionLogLevel;
- (nonnull Connection*) copy;
+ (nonnull SODataV4_Property*) createdAt;
- (nullable SODataV4_LocalDateTime*) createdAt;
+ (nonnull SODataV4_Property*) customCustom1;
- (nullable NSString*) customCustom1;
+ (nonnull SODataV4_Property*) customCustom2;
- (nullable NSString*) customCustom2;
+ (nonnull SODataV4_Property*) customCustom3;
- (nullable NSString*) customCustom3;
+ (nonnull SODataV4_Property*) customCustom4;
- (nullable NSString*) customCustom4;
+ (nonnull SODataV4_Property*) customizationBundleID;
- (nullable NSString*) customizationBundleID;
+ (nonnull SODataV4_Property*) deviceIMSI;
- (nullable NSString*) deviceIMSI;
+ (nonnull SODataV4_Property*) deviceModel;
- (nullable NSString*) deviceModel;
+ (nonnull SODataV4_Property*) devicePhoneNumber;
- (nullable NSString*) devicePhoneNumber;
+ (nonnull SODataV4_Property*) deviceSubType;
- (nullable NSString*) deviceSubType;
+ (nonnull SODataV4_Property*) deviceType;
- (nullable NSString*) deviceType;
+ (nonnull SODataV4_Property*) e2ETraceLevel;
- (nullable NSString*) e2ETraceLevel;
+ (nonnull SODataV4_Property*) eTag;
- (nullable NSString*) eTag;
+ (nonnull SODataV4_Property*) email;
- (nullable NSString*) email;
+ (nonnull SODataV4_Property*) enableAppSpecificClientUsageKeys;
- (SODataV4_nullable_boolean) enableAppSpecificClientUsageKeys;
+ (nonnull SODataV4_Property*) featureVectorPolicy;
- (nonnull FeatureVectorPolicyList*) featureVectorPolicy;
+ (nonnull SODataV4_Property*) featureVectorPolicyAllEnabled;
- (SODataV4_nullable_boolean) featureVectorPolicyAllEnabled;
+ (nonnull SODataV4_Property*) formFactor;
- (nullable NSString*) formFactor;
+ (nonnull SODataV4_Property*) inAppMessaging;
- (SODataV4_nullable_boolean) inAppMessaging;
- (SODataV4_boolean) isProxy;
+ (nonnull SODataV4_EntityKey*) key :(nonnull NSString*)applicationConnectionID;
+ (nonnull SODataV4_Property*) lastKnownLocation;
- (nullable NSString*) lastKnownLocation;
+ (nonnull ConnectionList*) list :(nonnull SODataV4_EntityValueList*)from;
+ (nonnull SODataV4_Property*) logEntryExpiry;
- (SODataV4_nullable_int) logEntryExpiry;
+ (nonnull SODataV4_Property*) maxConnectionWaitTimeForClientUsage;
- (SODataV4_nullable_int) maxConnectionWaitTimeForClientUsage;
+ (nonnull SODataV4_Property*) mpnsChannelURI;
- (nullable NSString*) mpnsChannelURI;
+ (nonnull SODataV4_Property*) mpnsPushEnable;
- (SODataV4_nullable_boolean) mpnsPushEnable;
- (nonnull Connection*) old;
+ (nonnull SODataV4_Property*) passwordPolicyDefaultPasswordAllowed;
- (SODataV4_nullable_boolean) passwordPolicyDefaultPasswordAllowed;
+ (nonnull SODataV4_Property*) passwordPolicyDigitRequired;
- (SODataV4_nullable_boolean) passwordPolicyDigitRequired;
+ (nonnull SODataV4_Property*) passwordPolicyEnabled;
- (SODataV4_nullable_boolean) passwordPolicyEnabled;
+ (nonnull SODataV4_Property*) passwordPolicyExpiresInNDays;
- (SODataV4_nullable_int) passwordPolicyExpiresInNDays;
+ (nonnull SODataV4_Property*) passwordPolicyFingerprintEnabled;
- (SODataV4_nullable_boolean) passwordPolicyFingerprintEnabled;
+ (nonnull SODataV4_Property*) passwordPolicyLockTimeout;
- (SODataV4_nullable_int) passwordPolicyLockTimeout;
+ (nonnull SODataV4_Property*) passwordPolicyLowerRequired;
- (SODataV4_nullable_boolean) passwordPolicyLowerRequired;
+ (nonnull SODataV4_Property*) passwordPolicyMinLength;
- (SODataV4_nullable_int) passwordPolicyMinLength;
+ (nonnull SODataV4_Property*) passwordPolicyMinUniqueChars;
- (SODataV4_nullable_int) passwordPolicyMinUniqueChars;
+ (nonnull SODataV4_Property*) passwordPolicyRetryLimit;
- (SODataV4_nullable_int) passwordPolicyRetryLimit;
+ (nonnull SODataV4_Property*) passwordPolicySpecialRequired;
- (SODataV4_nullable_boolean) passwordPolicySpecialRequired;
+ (nonnull SODataV4_Property*) passwordPolicyUpperRequired;
- (SODataV4_nullable_boolean) passwordPolicyUpperRequired;
+ (nonnull SODataV4_Property*) proxyApplicationEndpoint;
- (nullable NSString*) proxyApplicationEndpoint;
+ (nonnull SODataV4_Property*) proxyPushEndpoint;
- (nullable NSString*) proxyPushEndpoint;
+ (nonnull SODataV4_Property*) publishedToMobilePlace;
- (SODataV4_nullable_boolean) publishedToMobilePlace;
+ (nonnull SODataV4_Property*) pushGroup;
- (nullable NSString*) pushGroup;
+ (void) setAndroidGcmPushEnabled :(nonnull SODataV4_Property*)value;
- (void) setAndroidGcmPushEnabled :(SODataV4_nullable_boolean)value;
+ (void) setAndroidGcmRegistrationID :(nonnull SODataV4_Property*)value;
- (void) setAndroidGcmRegistrationID :(nullable NSString*)value;
+ (void) setAndroidGcmSenderID :(nonnull SODataV4_Property*)value;
- (void) setAndroidGcmSenderID :(nullable NSString*)value;
+ (void) setApnsDeviceToken :(nonnull SODataV4_Property*)value;
- (void) setApnsDeviceToken :(nullable NSString*)value;
+ (void) setApnsPushEnable :(nonnull SODataV4_Property*)value;
- (void) setApnsPushEnable :(SODataV4_nullable_boolean)value;
+ (void) setApplicationConnectionID :(nonnull SODataV4_Property*)value;
- (void) setApplicationConnectionID :(nonnull NSString*)value;
+ (void) setApplicationVersion :(nonnull SODataV4_Property*)value;
- (void) setApplicationVersion :(nullable NSString*)value;
+ (void) setBlackberryBESListenerPort :(nonnull SODataV4_Property*)value;
- (void) setBlackberryBESListenerPort :(SODataV4_nullable_int)value;
+ (void) setBlackberryDevicePin :(nonnull SODataV4_Property*)value;
- (void) setBlackberryDevicePin :(nullable NSString*)value;
+ (void) setBlackberryListenerType :(nonnull SODataV4_Property*)value;
- (void) setBlackberryListenerType :(SODataV4_nullable_int)value;
+ (void) setBlackberryPushAppID :(nonnull SODataV4_Property*)value;
- (void) setBlackberryPushAppID :(nullable NSString*)value;
+ (void) setBlackberryPushBaseURL :(nonnull SODataV4_Property*)value;
- (void) setBlackberryPushBaseURL :(nullable NSString*)value;
+ (void) setBlackberryPushEnabled :(nonnull SODataV4_Property*)value;
- (void) setBlackberryPushEnabled :(SODataV4_nullable_boolean)value;
+ (void) setBlackberryPushListenerPort :(nonnull SODataV4_Property*)value;
- (void) setBlackberryPushListenerPort :(SODataV4_nullable_int)value;
+ (void) setCapability :(nonnull SODataV4_Property*)value;
- (void) setCapability :(nonnull CapabilityList*)value;
+ (void) setCollectClientUsageReports :(nonnull SODataV4_Property*)value;
- (void) setCollectClientUsageReports :(SODataV4_nullable_boolean)value;
+ (void) setConnectionLogLevel :(nonnull SODataV4_Property*)value;
- (void) setConnectionLogLevel :(nullable NSString*)value;
+ (void) setCreatedAt :(nonnull SODataV4_Property*)value;
- (void) setCreatedAt :(nullable SODataV4_LocalDateTime*)value;
+ (void) setCustomCustom1 :(nonnull SODataV4_Property*)value;
- (void) setCustomCustom1 :(nullable NSString*)value;
+ (void) setCustomCustom2 :(nonnull SODataV4_Property*)value;
- (void) setCustomCustom2 :(nullable NSString*)value;
+ (void) setCustomCustom3 :(nonnull SODataV4_Property*)value;
- (void) setCustomCustom3 :(nullable NSString*)value;
+ (void) setCustomCustom4 :(nonnull SODataV4_Property*)value;
- (void) setCustomCustom4 :(nullable NSString*)value;
+ (void) setCustomizationBundleID :(nonnull SODataV4_Property*)value;
- (void) setCustomizationBundleID :(nullable NSString*)value;
+ (void) setDeviceIMSI :(nonnull SODataV4_Property*)value;
- (void) setDeviceIMSI :(nullable NSString*)value;
+ (void) setDeviceModel :(nonnull SODataV4_Property*)value;
- (void) setDeviceModel :(nullable NSString*)value;
+ (void) setDevicePhoneNumber :(nonnull SODataV4_Property*)value;
- (void) setDevicePhoneNumber :(nullable NSString*)value;
+ (void) setDeviceSubType :(nonnull SODataV4_Property*)value;
- (void) setDeviceSubType :(nullable NSString*)value;
+ (void) setDeviceType :(nonnull SODataV4_Property*)value;
- (void) setDeviceType :(nullable NSString*)value;
+ (void) setE2ETraceLevel :(nonnull SODataV4_Property*)value;
- (void) setE2ETraceLevel :(nullable NSString*)value;
+ (void) setETag :(nonnull SODataV4_Property*)value;
- (void) setETag :(nullable NSString*)value;
+ (void) setEmail :(nonnull SODataV4_Property*)value;
- (void) setEmail :(nullable NSString*)value;
+ (void) setEnableAppSpecificClientUsageKeys :(nonnull SODataV4_Property*)value;
- (void) setEnableAppSpecificClientUsageKeys :(SODataV4_nullable_boolean)value;
+ (void) setFeatureVectorPolicy :(nonnull SODataV4_Property*)value;
- (void) setFeatureVectorPolicy :(nonnull FeatureVectorPolicyList*)value;
+ (void) setFeatureVectorPolicyAllEnabled :(nonnull SODataV4_Property*)value;
- (void) setFeatureVectorPolicyAllEnabled :(SODataV4_nullable_boolean)value;
+ (void) setFormFactor :(nonnull SODataV4_Property*)value;
- (void) setFormFactor :(nullable NSString*)value;
+ (void) setInAppMessaging :(nonnull SODataV4_Property*)value;
- (void) setInAppMessaging :(SODataV4_nullable_boolean)value;
+ (void) setLastKnownLocation :(nonnull SODataV4_Property*)value;
- (void) setLastKnownLocation :(nullable NSString*)value;
+ (void) setLogEntryExpiry :(nonnull SODataV4_Property*)value;
- (void) setLogEntryExpiry :(SODataV4_nullable_int)value;
+ (void) setMaxConnectionWaitTimeForClientUsage :(nonnull SODataV4_Property*)value;
- (void) setMaxConnectionWaitTimeForClientUsage :(SODataV4_nullable_int)value;
+ (void) setMpnsChannelURI :(nonnull SODataV4_Property*)value;
- (void) setMpnsChannelURI :(nullable NSString*)value;
+ (void) setMpnsPushEnable :(nonnull SODataV4_Property*)value;
- (void) setMpnsPushEnable :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyDefaultPasswordAllowed :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyDefaultPasswordAllowed :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyDigitRequired :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyDigitRequired :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyEnabled :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyEnabled :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyExpiresInNDays :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyExpiresInNDays :(SODataV4_nullable_int)value;
+ (void) setPasswordPolicyFingerprintEnabled :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyFingerprintEnabled :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyLockTimeout :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyLockTimeout :(SODataV4_nullable_int)value;
+ (void) setPasswordPolicyLowerRequired :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyLowerRequired :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyMinLength :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyMinLength :(SODataV4_nullable_int)value;
+ (void) setPasswordPolicyMinUniqueChars :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyMinUniqueChars :(SODataV4_nullable_int)value;
+ (void) setPasswordPolicyRetryLimit :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyRetryLimit :(SODataV4_nullable_int)value;
+ (void) setPasswordPolicySpecialRequired :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicySpecialRequired :(SODataV4_nullable_boolean)value;
+ (void) setPasswordPolicyUpperRequired :(nonnull SODataV4_Property*)value;
- (void) setPasswordPolicyUpperRequired :(SODataV4_nullable_boolean)value;
+ (void) setProxyApplicationEndpoint :(nonnull SODataV4_Property*)value;
- (void) setProxyApplicationEndpoint :(nullable NSString*)value;
+ (void) setProxyPushEndpoint :(nonnull SODataV4_Property*)value;
- (void) setProxyPushEndpoint :(nullable NSString*)value;
+ (void) setPublishedToMobilePlace :(nonnull SODataV4_Property*)value;
- (void) setPublishedToMobilePlace :(SODataV4_nullable_boolean)value;
+ (void) setPushGroup :(nonnull SODataV4_Property*)value;
- (void) setPushGroup :(nullable NSString*)value;
+ (void) setTimeZone :(nonnull SODataV4_Property*)value;
- (void) setTimeZone :(nullable NSString*)value;
+ (void) setUploadLogs :(nonnull SODataV4_Property*)value;
- (void) setUploadLogs :(SODataV4_nullable_boolean)value;
+ (void) setUserLocale :(nonnull SODataV4_Property*)value;
- (void) setUserLocale :(nullable NSString*)value;
+ (void) setUserName :(nonnull SODataV4_Property*)value;
- (void) setUserName :(nullable NSString*)value;
+ (void) setWnsChannelURI :(nonnull SODataV4_Property*)value;
- (void) setWnsChannelURI :(nullable NSString*)value;
+ (void) setWnsPushEnable :(nonnull SODataV4_Property*)value;
- (void) setWnsPushEnable :(SODataV4_nullable_boolean)value;
+ (nonnull SODataV4_Property*) timeZone;
- (nullable NSString*) timeZone;
+ (nonnull SODataV4_Property*) uploadLogs;
- (SODataV4_nullable_boolean) uploadLogs;
+ (nonnull SODataV4_Property*) userLocale;
- (nullable NSString*) userLocale;
+ (nonnull SODataV4_Property*) userName;
- (nullable NSString*) userName;
+ (nonnull SODataV4_Property*) wnsChannelURI;
- (nullable NSString*) wnsChannelURI;
+ (nonnull SODataV4_Property*) wnsPushEnable;
- (SODataV4_nullable_boolean) wnsPushEnable;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* androidGcmPushEnabled;
@property (nonatomic, readwrite) SODataV4_nullable_boolean androidGcmPushEnabled;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* androidGcmRegistrationID;
@property (nonatomic, readwrite, strong, nullable) NSString* androidGcmRegistrationID;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* androidGcmSenderID;
@property (nonatomic, readwrite, strong, nullable) NSString* androidGcmSenderID;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* apnsDeviceToken;
@property (nonatomic, readwrite, strong, nullable) NSString* apnsDeviceToken;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* apnsPushEnable;
@property (nonatomic, readwrite) SODataV4_nullable_boolean apnsPushEnable;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* applicationConnectionID;
@property (nonatomic, readwrite, strong, nonnull) NSString* applicationConnectionID;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* applicationVersion;
@property (nonatomic, readwrite, strong, nullable) NSString* applicationVersion;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryBESListenerPort;
@property (nonatomic, readwrite) SODataV4_nullable_int blackberryBESListenerPort;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryDevicePin;
@property (nonatomic, readwrite, strong, nullable) NSString* blackberryDevicePin;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryListenerType;
@property (nonatomic, readwrite) SODataV4_nullable_int blackberryListenerType;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryPushAppID;
@property (nonatomic, readwrite, strong, nullable) NSString* blackberryPushAppID;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryPushBaseURL;
@property (nonatomic, readwrite, strong, nullable) NSString* blackberryPushBaseURL;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryPushEnabled;
@property (nonatomic, readwrite) SODataV4_nullable_boolean blackberryPushEnabled;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* blackberryPushListenerPort;
@property (nonatomic, readwrite) SODataV4_nullable_int blackberryPushListenerPort;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* capability;
@property (nonatomic, readwrite, strong, nonnull) CapabilityList* capability;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* collectClientUsageReports;
@property (nonatomic, readwrite) SODataV4_nullable_boolean collectClientUsageReports;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* connectionLogLevel;
@property (nonatomic, readwrite, strong, nullable) NSString* connectionLogLevel;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* createdAt;
@property (nonatomic, readwrite, strong, nullable) SODataV4_LocalDateTime* createdAt;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* customCustom1;
@property (nonatomic, readwrite, strong, nullable) NSString* customCustom1;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* customCustom2;
@property (nonatomic, readwrite, strong, nullable) NSString* customCustom2;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* customCustom3;
@property (nonatomic, readwrite, strong, nullable) NSString* customCustom3;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* customCustom4;
@property (nonatomic, readwrite, strong, nullable) NSString* customCustom4;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* customizationBundleID;
@property (nonatomic, readwrite, strong, nullable) NSString* customizationBundleID;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* deviceIMSI;
@property (nonatomic, readwrite, strong, nullable) NSString* deviceIMSI;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* deviceModel;
@property (nonatomic, readwrite, strong, nullable) NSString* deviceModel;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* devicePhoneNumber;
@property (nonatomic, readwrite, strong, nullable) NSString* devicePhoneNumber;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* deviceSubType;
@property (nonatomic, readwrite, strong, nullable) NSString* deviceSubType;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* deviceType;
@property (nonatomic, readwrite, strong, nullable) NSString* deviceType;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* e2ETraceLevel;
@property (nonatomic, readwrite, strong, nullable) NSString* e2ETraceLevel;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* eTag;
@property (nonatomic, readwrite, strong, nullable) NSString* eTag;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* email;
@property (nonatomic, readwrite, strong, nullable) NSString* email;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* enableAppSpecificClientUsageKeys;
@property (nonatomic, readwrite) SODataV4_nullable_boolean enableAppSpecificClientUsageKeys;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* featureVectorPolicy;
@property (nonatomic, readwrite, strong, nonnull) FeatureVectorPolicyList* featureVectorPolicy;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* featureVectorPolicyAllEnabled;
@property (nonatomic, readwrite) SODataV4_nullable_boolean featureVectorPolicyAllEnabled;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* formFactor;
@property (nonatomic, readwrite, strong, nullable) NSString* formFactor;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* inAppMessaging;
@property (nonatomic, readwrite) SODataV4_nullable_boolean inAppMessaging;
@property (nonatomic, readonly) SODataV4_boolean isProxy;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* lastKnownLocation;
@property (nonatomic, readwrite, strong, nullable) NSString* lastKnownLocation;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* logEntryExpiry;
@property (nonatomic, readwrite) SODataV4_nullable_int logEntryExpiry;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* maxConnectionWaitTimeForClientUsage;
@property (nonatomic, readwrite) SODataV4_nullable_int maxConnectionWaitTimeForClientUsage;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* mpnsChannelURI;
@property (nonatomic, readwrite, strong, nullable) NSString* mpnsChannelURI;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* mpnsPushEnable;
@property (nonatomic, readwrite) SODataV4_nullable_boolean mpnsPushEnable;
@property (nonatomic, readonly, strong, nonnull) Connection* old;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyDefaultPasswordAllowed;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicyDefaultPasswordAllowed;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyDigitRequired;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicyDigitRequired;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyEnabled;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicyEnabled;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyExpiresInNDays;
@property (nonatomic, readwrite) SODataV4_nullable_int passwordPolicyExpiresInNDays;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyFingerprintEnabled;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicyFingerprintEnabled;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyLockTimeout;
@property (nonatomic, readwrite) SODataV4_nullable_int passwordPolicyLockTimeout;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyLowerRequired;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicyLowerRequired;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyMinLength;
@property (nonatomic, readwrite) SODataV4_nullable_int passwordPolicyMinLength;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyMinUniqueChars;
@property (nonatomic, readwrite) SODataV4_nullable_int passwordPolicyMinUniqueChars;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyRetryLimit;
@property (nonatomic, readwrite) SODataV4_nullable_int passwordPolicyRetryLimit;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicySpecialRequired;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicySpecialRequired;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* passwordPolicyUpperRequired;
@property (nonatomic, readwrite) SODataV4_nullable_boolean passwordPolicyUpperRequired;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* proxyApplicationEndpoint;
@property (nonatomic, readwrite, strong, nullable) NSString* proxyApplicationEndpoint;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* proxyPushEndpoint;
@property (nonatomic, readwrite, strong, nullable) NSString* proxyPushEndpoint;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* publishedToMobilePlace;
@property (nonatomic, readwrite) SODataV4_nullable_boolean publishedToMobilePlace;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* pushGroup;
@property (nonatomic, readwrite, strong, nullable) NSString* pushGroup;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* timeZone;
@property (nonatomic, readwrite, strong, nullable) NSString* timeZone;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* uploadLogs;
@property (nonatomic, readwrite) SODataV4_nullable_boolean uploadLogs;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* userLocale;
@property (nonatomic, readwrite, strong, nullable) NSString* userLocale;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* userName;
@property (nonatomic, readwrite, strong, nullable) NSString* userName;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* wnsChannelURI;
@property (nonatomic, readwrite, strong, nullable) NSString* wnsChannelURI;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* wnsPushEnable;
@property (nonatomic, readwrite) SODataV4_nullable_boolean wnsPushEnable;
@end
#endif

#ifndef imported_Endpoint_public
#define imported_Endpoint_public
@interface Endpoint : SODataV4_EntityValue
{
}
+ (void) initialize;
- (nonnull id) init;
+ (nonnull Endpoint*) new;
+ (nonnull Endpoint*) new :(SODataV4_boolean)withDefaults;
/// @internal
///
- (void) _init :(SODataV4_boolean)withDefaults;
+ (nonnull SODataV4_Property*) anonymousAccess;
- (SODataV4_nullable_boolean) anonymousAccess;
- (nonnull Endpoint*) copy;
+ (nonnull SODataV4_Property*) endpointName;
- (nonnull NSString*) endpointName;
- (SODataV4_boolean) isProxy;
+ (nonnull SODataV4_EntityKey*) key :(nonnull NSString*)endpointName;
+ (nonnull EndpointList*) list :(nonnull SODataV4_EntityValueList*)from;
- (nonnull Endpoint*) old;
+ (nonnull SODataV4_Property*) remoteURL;
- (nullable NSString*) remoteURL;
+ (void) setAnonymousAccess :(nonnull SODataV4_Property*)value;
- (void) setAnonymousAccess :(SODataV4_nullable_boolean)value;
+ (void) setEndpointName :(nonnull SODataV4_Property*)value;
- (void) setEndpointName :(nonnull NSString*)value;
+ (void) setRemoteURL :(nonnull SODataV4_Property*)value;
- (void) setRemoteURL :(nullable NSString*)value;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* anonymousAccess;
@property (nonatomic, readwrite) SODataV4_nullable_boolean anonymousAccess;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* endpointName;
@property (nonatomic, readwrite, strong, nonnull) NSString* endpointName;
@property (nonatomic, readonly) SODataV4_boolean isProxy;
@property (nonatomic, readonly, strong, nonnull) Endpoint* old;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* remoteURL;
@property (nonatomic, readwrite, strong, nullable) NSString* remoteURL;
@end
#endif

#ifndef imported_FeatureVectorPolicy_public
#define imported_FeatureVectorPolicy_public
@interface FeatureVectorPolicy : SODataV4_EntityValue
{
}
+ (void) initialize;
- (nonnull id) init;
+ (nonnull FeatureVectorPolicy*) new;
+ (nonnull FeatureVectorPolicy*) new :(SODataV4_boolean)withDefaults;
/// @internal
///
- (void) _init :(SODataV4_boolean)withDefaults;
- (nonnull FeatureVectorPolicy*) copy;
+ (nonnull SODataV4_Property*) description;
- (nullable NSString*) description;
+ (nonnull SODataV4_Property*) displayName;
- (nullable NSString*) displayName;
+ (nonnull SODataV4_Property*) id_;
- (nonnull NSString*) id_;
- (SODataV4_boolean) isProxy;
+ (nonnull SODataV4_Property*) jsModule;
- (nullable NSString*) jsModule;
+ (nonnull SODataV4_EntityKey*) key :(nonnull NSString*)id_;
+ (nonnull FeatureVectorPolicyList*) list :(nonnull SODataV4_EntityValueList*)from;
+ (nonnull SODataV4_Property*) name;
- (nullable NSString*) name;
- (nonnull FeatureVectorPolicy*) old;
+ (nonnull SODataV4_Property*) pluginName;
- (nullable NSString*) pluginName;
+ (void) setDescription :(nonnull SODataV4_Property*)value;
- (void) setDescription :(nullable NSString*)value;
+ (void) setDisplayName :(nonnull SODataV4_Property*)value;
- (void) setDisplayName :(nullable NSString*)value;
+ (void) setId_ :(nonnull SODataV4_Property*)value;
- (void) setId_ :(nonnull NSString*)value;
+ (void) setJsModule :(nonnull SODataV4_Property*)value;
- (void) setJsModule :(nullable NSString*)value;
+ (void) setName :(nonnull SODataV4_Property*)value;
- (void) setName :(nullable NSString*)value;
+ (void) setPluginName :(nonnull SODataV4_Property*)value;
- (void) setPluginName :(nullable NSString*)value;
+ (void) setVersion :(nonnull SODataV4_Property*)value;
- (void) setVersion :(nullable NSString*)value;
+ (void) setWhitelist :(nonnull SODataV4_Property*)value;
- (void) setWhitelist :(nullable NSString*)value;
+ (nonnull SODataV4_Property*) version;
- (nullable NSString*) version;
+ (nonnull SODataV4_Property*) whitelist;
- (nullable NSString*) whitelist;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* description;
@property (nonatomic, readwrite, strong, nullable) NSString* description;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* displayName;
@property (nonatomic, readwrite, strong, nullable) NSString* displayName;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* id_;
@property (nonatomic, readwrite, strong, nonnull) NSString* id_;
@property (nonatomic, readonly) SODataV4_boolean isProxy;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* jsModule;
@property (nonatomic, readwrite, strong, nullable) NSString* jsModule;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* name;
@property (nonatomic, readwrite, strong, nullable) NSString* name;
@property (nonatomic, readonly, strong, nonnull) FeatureVectorPolicy* old;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* pluginName;
@property (nonatomic, readwrite, strong, nullable) NSString* pluginName;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* version;
@property (nonatomic, readwrite, strong, nullable) NSString* version;
@property (nonatomic, readwrite, class, strong, nonnull) SODataV4_Property* whitelist;
@property (nonatomic, readwrite, strong, nullable) NSString* whitelist;
@end
#endif

#ifdef import_Any_as_applications_Capability_in_applications_internal
#ifndef imported_Any_as_applications_Capability_in_applications_internal
#define imported_Any_as_applications_Capability_in_applications_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface Any_as_applications_Capability_in_applications : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull Capability*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_Any_as_applications_Connection_in_applications_internal
#ifndef imported_Any_as_applications_Connection_in_applications_internal
#define imported_Any_as_applications_Connection_in_applications_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface Any_as_applications_Connection_in_applications : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull Connection*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_Any_as_applications_Endpoint_in_applications_internal
#ifndef imported_Any_as_applications_Endpoint_in_applications_internal
#define imported_Any_as_applications_Endpoint_in_applications_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface Any_as_applications_Endpoint_in_applications : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull Endpoint*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#ifdef import_Any_as_applications_FeatureVectorPolicy_in_applications_internal
#ifndef imported_Any_as_applications_FeatureVectorPolicy_in_applications_internal
#define imported_Any_as_applications_FeatureVectorPolicy_in_applications_public
/* internal */
/// @brief Utility class for unsafe type casting to non-nullable target type.
///
///
@interface Any_as_applications_FeatureVectorPolicy_in_applications : SODataV4_ObjectBase
{
}
/// @return `value` cast to AnyType.
/// @throw `SODataV4_CastException` if `value` is not of type `AnyType`.
+ (nonnull FeatureVectorPolicy*) cast :(nullable NSObject*)value;
@end
#endif
#endif

#endif
