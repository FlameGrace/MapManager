//
//  MapLocationManager.m
//  MapDemo
//
//  Created by Flame Grace on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "MapLocationManager.h"
#import "MapLocationModel+RegeoSearch.h"

@interface MapLocationManager()

@end

@implementation MapLocationManager


- (instancetype)init
{
    if(self = [super init])
    {
        self.show = YES;
        [self.mapManager addMultiDelegate:self];
    }
    return self;
}

- (void)setShow:(BOOL)show
{
    _show = show;
    
    self.drawPoint.showAnnotations = show;
}

- (Class)locationClass
{
    return [MapLocationModel class];
}


- (void)updateLocationByLatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    if([latitude length]<1||[longitude length]<1)
    {
        if(![self.mapManager isResourceReleased])
        {
            [self.drawPoint clear];
        }
        [self postNotificationByName:[self locationChangeNotificationName]];
        self.location = nil;
        return;
    }
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
    if(!self.location)
    {
        //创建车机位置数据模型
        self.location = [[self locationClass] modelByCoordinate:coordinate];
        MapAnnotation *annotation = [[[self.location annotationClass] alloc]init];
        annotation.coordinate = coordinate;
        self.location.annotation = annotation;
    }
    self.location.coordinate2D = coordinate;
    //开始对位置逆地理编码
    if(!self.location.name||self.isAutoReGeocode)
    {
        [self reGeocode];
    }
    [self postNotificationByName:[self locationChangeNotificationName]];;
    //地图资源被释放不更新车辆地图图标
    if([self.mapManager isResourceReleased])
    {
        return;
    }
    [self drawLocationInMap];
    
}


- (void)drawLocationInMap
{
    @synchronized (self)
    {
        if(!self.location || !self.show)
        {
            return;
        }
        MapAnnotationView *view = (MapAnnotationView *)[self.mapManager.mapView viewForAnnotation:self.location.annotation];
        self.location.annotation.coordinate = self.location.coordinate2D;
        if(view)
        {
            [view updateLocation:self.location.coordinate2D];
        }
        else
        {
            [self.drawPoint addMapAnnotations:@[self.location.annotation]];
        }
        if(self.showLocationInMapCenter)
        {
            [self switchLocationInMapCenter];
        }
    }
}
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView
{
    [self drawLocationInMap];
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
}



#pragma private function

- (void)switchLocationInMapCenter
{
    if(self.location)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapManager.mapView setCenterCoordinate:self.location.coordinate2D animated:YES];
        });
    }
}


- (void)reGeocode
{
    WeakObj(self)
    [self.location searchRegeoWithCallback:^(NSError *error) {
        if(!error)
        {
            StrongObj(self)
            [self postNotificationByName:[self reGeocodeNotificationName]];
        }
    }];
}

- (NSString *)locationChangeNotificationName
{
    return nil;
}

- (NSString *)reGeocodeNotificationName
{
    return nil;
}


- (void)postNotificationByName:(NSString *)name
{
    if(!name)
    {
        return;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:nil];
}


- (NSString *)distanceWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if(!self.location)
    {
        return nil;
    }
    CGFloat distance = [MapManager getDistanceBetweenOrigin:coordinate andDestination:self.location.coordinate2D];
    return [MapManager getDistanceFromMetres:distance];
}


- (MapManager *)mapManager
{
    return [MapManager sharedManager];
}

- (MapDrawPoint *)drawPoint
{
    if(!_drawPoint)
    {
        _drawPoint = [[MapDrawPoint alloc]init];
    }
    return _drawPoint;
}

@end
