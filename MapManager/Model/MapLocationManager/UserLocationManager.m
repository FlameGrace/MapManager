//
//  MapLocationManager.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "UserLocationManager.h"
#import "MapLocationModel+RegeoSearch.h"


@interface UserLocationManager()

@end;

@implementation UserLocationManager
@synthesize show = _show;

static UserLocationManager *shareManager = nil;


+ (instancetype)sharedUser
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc]init];
    });
    return shareManager;
}


- (instancetype)init
{
    if(self = [super init])
    {
        self.show = YES;
        [self.mapManager.mapLocationManager startUpdatingLocation];
    }
    return self;
}

- (void)setShow:(BOOL)show
{
    _show = show;
    self.mapManager.mapView.showsUserLocation = show;
}

- (NSString *)reGeocodeNotificationName
{
    return UserLocationReGeocodeSearchDoneNotification;
}

- (NSString *)locationChangeNotificationName
{
    return UserLocationChangedNotification;
}


- (void)updateLocationByLatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    
}


- (void)updateLocationByCoordinate:(CLLocationCoordinate2D)coordinate
{
    if(!self.location)
    {
        self.location = [MapLocationModel modelByCoordinate:coordinate];
        self.location.coordinate2D = coordinate;
        [self reGeocode];
        return;
    }
    self.location.coordinate2D = coordinate;
    [self postNotificationByName:[self locationChangeNotificationName]];
    
}

- (void)drawLocationInMap
{
    
}


#pragma AMapLocationManagerDelegate
//定位框架获取到定位权限变动时回调
- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.mapManager.mapLocationManager startUpdatingLocation];
    }
}

//定位框架获取到定位失败回调
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
//定位框架获取到位置更新回调
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    [self.mapManager.mapLocationManager stopUpdatingLocation];
    self.mapManager.mapView.userLocation.coordinate = location.coordinate;
    [self updateLocationByCoordinate:location.coordinate];
    //定位结果
        NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
}



#pragma MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    [self updateLocationByCoordinate:userLocation.coordinate];
}


- (NSString *)currentCity
{
    NSString *city = self.location.city;
    if(!city||[city isEqualToString:@"CURRENT_CITY"])
    {
        city = @"杭州市";
    }
    return city;
}

@end
