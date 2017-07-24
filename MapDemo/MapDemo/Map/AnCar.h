//
//  AnCar.h
//  MapDemo
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapManager.h"
#import "MapManager+Search.h"
#import "MapManager+Tools.h"
#import "CarMapLocation.h"

#define MapCarLocationChangdeNotification @"MapCarLocationChangdeNotification"

@interface AnCar : NSObject


//是否显示车辆图标
@property (assign, nonatomic) BOOL showCar;
//车辆位置
@property (strong, nonatomic) CarMapLocation *car;
//设置为YES后，每次车辆位置有更新，自动将车辆图标切换到地图中心
@property (assign, nonatomic) BOOL showCarInMapCenter;


+ (instancetype)sharedCar;

- (void)updateCarLocationLongitude:(NSString *)longitude latitude:(NSString *)latitude;

- (void)switchCarInMapCenter;

@end
