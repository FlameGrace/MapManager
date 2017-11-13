//
//  MapLocationManager.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapLocationManager.h"
#import "MapLocationModel+RegeoSearch.h"


@interface MapLocationManager()

@property (weak, nonatomic) MapManager *mapManager;

@end;

@implementation MapLocationManager

static MapLocationManager *shareManager = nil;

+ (instancetype)sharedManager
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
        self.showUser = YES;
        [self.mapManager addMultiDelegate:self];
        [self.mapManager.mapLocationManager startUpdatingLocation];
    }
    return self;
}


- (void)setShowUser:(BOOL)showUser
{
    _showUser = showUser;
    self.mapManager.mapView.showsUserLocation = showUser;
}



- (void)updateUserLocation:(CLLocationCoordinate2D)coordinate
{
    if(!self.user)
    {
        self.user = [MapLocationModel modelByCoordinate:coordinate];
        self.user.coordinate2D = coordinate;
        [self reGeocodeForUser];
    }
    self.user.coordinate2D = coordinate;
}


#pragma MapLocationManagerDelegate
//定位框架获取到定位权限变动时回调
- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.mapManager.mapLocationManager startUpdatingLocation];
    }
}

//定位框架获取到定位失败回调
- (void)amapLocationManager:(MapLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
//定位框架获取到位置更新回调
- (void)amapLocationManager:(MapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    [self.mapManager.mapLocationManager stopUpdatingLocation];
    self.mapManager.mapView.userLocation.coordinate = location.coordinate;
    [self updateUserLocation:location.coordinate];
    //定位结果
//    MapLog(UnKnow,@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);

}

#pragma MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    [self updateUserLocation:userLocation.coordinate];
}

#pragma private function

- (void)switchUserInMapCenter
{
    if(self.user)
    {
        
        dispatch_async(dispatch_get_main_queue(),^{
            [[MapManager sharedManager].mapView setCenterCoordinate:self.user.coordinate2D animated:YES];
        });
    }
}



- (void)reGeocodeForUser
{
    [self.user searchRegeoWithcallback:^(NSError *error) {
    }];
}



- (NSString *)currentCity
{
    NSString *city = self.user.city;
    if(!city)
    {
        city = @"杭州";
    }
    return city;
}



- (MapManager *)mapManager
{
    return [MapManager sharedManager];
}



@end
