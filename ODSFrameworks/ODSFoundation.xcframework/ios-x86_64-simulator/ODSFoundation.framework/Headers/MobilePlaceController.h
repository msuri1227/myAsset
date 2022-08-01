//
//  MobilePlaceController.h
//  MobilePlace
//
//  Copyright (c) 2014 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kConfigParameterHost @"host"
#define kConfigParameterPort @"port"
#define kConfigParameterProtocol @"protocol"
#define kConfigParameterAuth @"auth"

@interface MobilePlaceController : NSObject

/**
 Can be used to download configuration from Mobile Place server.
 Will present viewcontroller to get e-mail address.
 @param appID Application ID
 @param versionNumber Version number of the application
 @param parentVC Parent view controller
 @return NSDictionary containing parsed content of returned json configuration. Or error.
 */
-(void)configurationParametersWithAppID:(NSString*)appID versionNumber:(NSString*)versionNumber parentVC:(UIViewController*)parentVC completionBlock:(void (^)(NSDictionary *configurationParameters, NSError *error))completionBlock;

/**
 Can be used to download configuration from Mobile Place server.
 @param email E-mail address
 @param appID Application ID
 @param versionNumber Version number of the application
 @param parentVC Parent view controller
 @return NSDictionary containing parsed content of returned json configuration. Or error.
 */
-(void)configurationParametersWithEmail:(NSString*)email appID:(NSString*)appID versionNumber:(NSString*)versionNumber parentVC:(UIViewController*)parentVC completionBlock:(void (^)(NSDictionary *configurationParameters, NSError *error))completionBlock;

@end
