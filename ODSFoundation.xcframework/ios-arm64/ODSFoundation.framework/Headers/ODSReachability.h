//
//  AppData.h
//  GeoTrack
//
//  Created by Pratik Patel on 10/1/16.
//  Copyright © 2016 XML App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ODSReachability : NSObject{
    
    Reachability *internetReachability;
}

+ (instancetype)sharedInstance;
@property (nonatomic, readwrite) BOOL isConnected;
-(NSString *)checkInternetConnection ;
-(NSString *)checkInternetConnectionwithServerDetails:serverAddress;
@property (atomic, readwrite) NSString *serverPingURL;
@end

