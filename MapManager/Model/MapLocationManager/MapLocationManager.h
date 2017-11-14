//
//  MapLocationManager.h
//  MapDemo
//
//  Created by Flame Grace on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapLocationModel.h"
#import "MapDrawPoint.h"

@interface MapLocationManager : NSObject

@property (weak, nonatomic) MapManager *mapManager;
//是否显示图标
@property (assign, nonatomic) BOOL show;
//位置
@property (strong, nonatomic) MapLocationModel *location;

@property (strong, nonatomic) MapDrawPoint *drawPoint;

//设置为YES后，每次位置有更新，自动将图标切换到地图中心
@property (assign, nonatomic) BOOL showLocationInMapCenter;

//设置为YES后，每次位置有更新，自动将其地理逆编码
@property (assign, nonatomic) BOOL isAutoReGeocode;

- (Class)locationClass;

- (NSString *)distanceWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)switchLocationInMapCenter;

- (void)updateLocationByLatitude:(NSString *)latitude longitude:(NSString *)longitude;

- (void)reGeocode;

- (void)drawLocationInMap;

- (NSString *)reGeocodeNotificationName;

- (NSString *)locationChangeNotificationName;

- (void)postNotificationByName:(NSString *)name;



@end
