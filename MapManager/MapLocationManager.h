//
//  MapMapLocationManager.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
// 管理用户位置和车辆位置的单例类

#import <Foundation/Foundation.h>
#import "MapManager.h"
#import "MapManager+Search.h"
#import "MapManager+Tools.h"


@interface MapLocationManager : NSObject

+ (instancetype)sharedManager;
//是否显示车辆乘客图标
@property (assign, nonatomic) BOOL showUser;
//用户位置
@property (strong, nonatomic) MapLocationModel *user;

- (void)reGeocodeForUser;

- (NSString *)currentCity;

- (void)switchUserInMapCenter;



@end
