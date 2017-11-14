//
//  MapMapLocationManager.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
// 管理用户位置和车辆位置的单例类

#import <Foundation/Foundation.h>
#import "MapManager.h"
#import "MapManager+Tools.h"
#import "MapLocationManager.h"

#define UserLocationReGeocodeSearchDoneNotification @"UserLocationReGeocodeSearchDoneNotification"
#define UserLocationChangedNotification @"UserLocationChangedNotification"

@interface UserLocationManager : MapLocationManager

+ (instancetype)sharedUser;

- (NSString *)currentCity;




@end
