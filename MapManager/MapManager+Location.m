//
//  MapManager+Location.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapManager+Location.h"

@implementation MapManager (Location)

#pragma MapLocationManagerDelegate
//定位框架获取到定位权限变动时回调
- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    self.locationAuthorizationStatus = status;
    
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(amapLocationManager:didChangeAuthorizationStatus:)])
        {
            [delegate amapLocationManager:manager didChangeAuthorizationStatus:status];
        }
    }];
}

//定位框架获取到定位失败回调
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    if(error.code == 1)
    {
        self.locationAuthorizationStatus = kCLAuthorizationStatusDenied;
    }
    
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(amapLocationManager:didFailWithError:)])
        {
            [delegate amapLocationManager:manager didFailWithError:error];
        }
    }];
}
//定位框架获取到位置更新回调
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(amapLocationManager:didUpdateLocation:)])
        {
            [delegate amapLocationManager:manager didUpdateLocation:location];
        }
    }];
    
}

@end
