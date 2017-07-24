//
//  LPMapManager.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/8.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//


#import "MapManager.h"

@interface MapManager()

@end



@implementation MapManager

static MapManager *sharedManager = nil;

+ (instancetype)sharedManager
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    return sharedManager;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [super allocWithZone:zone];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _mapView = [[MAMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mapView.tag = MAPVIEW_TAG;
        _mapView.delegate = self;
        
        _mapView.showsScale = NO;
        _mapView.showsCompass = NO;
        //不支持旋转
        _mapView.rotateEnabled = NO;
        
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setZoomLevel:MAPVIEW_DEFAULT_ZOOMLEVEL];
        
        _mapView.pausesLocationUpdatesAutomatically = NO;
//        _mapView.MapowsBackgroundLocationUpdates = YES;
        
        _mapSearch = [[AMapSearchAPI alloc]init];
        _mapSearch.delegate = self;
        
        
        _mapNaviDrive = [[AMapNaviDriveManager alloc]init];
        
        _mapNaviWalk = [[AMapNaviWalkManager alloc]init];
        
        //启动定位服务
        self.mapLocationManager = [[AMapLocationManager alloc] init];
        self.mapLocationManager.delegate = self;
        
        [self.mapLocationManager setPausesLocationUpdatesAutomatically:YES];
        [self.mapLocationManager setAllowsBackgroundLocationUpdates:NO];
    }
    return self;
}

- (BOOL)addMapViewToView:(UIView *)view
{
    UIView *subView = [view viewWithTag:MAPVIEW_TAG];
    if(subView && ![subView isKindOfClass:[self.mapView class]])
    {
        return NO;
    }
    if(!subView)
    {
        [view addSubview:self.mapView];
    }
    return YES;
}

- (BOOL)addMapViewToView:(UIView *)view withFrame:(CGRect)frame
{
    self.mapView.frame = frame;
    return [self addMapViewToView:view];
}

- (void)refreshMapView
{
    [self.mapView setZoomLevel:self.mapView.zoomLevel+0.01 animated:YES];
    [self.mapView setZoomLevel:self.mapView.zoomLevel-0.01 animated:YES];
}




@end
