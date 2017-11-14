//
//  AnCar.h
//  MapDemo
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapManager.h"
#import "MapManager+Tools.h"
#import "CarMapLocation.h"
#import "CacheMapLocationManager.h"

#define CarLocationReGeocodeSearchDoneNotification @"CarLocationReGeocodeSearchDoneNotification"
#define CarLocationChangedNotification @"CarLocationChangedNotification"

@interface CarLocationManager : CacheMapLocationManager

@property (strong, nonatomic) CarMapLocation *location;

+ (instancetype)sharedCar;

@end
