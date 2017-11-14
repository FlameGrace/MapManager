//
//  AnCar.m
//  MapDemo
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "CarLocationManager.h"
#import "CarMapAnnotationView.h"
#import "MapDrawPoint.h"

@interface CarLocationManager()

@end


@implementation CarLocationManager
@synthesize location = _location;

static CarLocationManager *shareCar = nil;

+ (instancetype)sharedCar
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCar = [[self alloc]init];
    });
    return shareCar;
}

- (Class)locationClass
{
    return [CarMapLocation class];
}

- (NSString *)locationChangeNotificationName
{
    return CarLocationChangedNotification;
}

- (NSString *)reGeocodeNotificationName
{
    return CarLocationReGeocodeSearchDoneNotification;
}

@end
