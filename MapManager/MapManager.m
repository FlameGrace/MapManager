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

- (NSString *)getTheMapAPIKey
{
    return @"042a57a173c812f8e8a7e0bf9d4b1589";
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [AMapServices sharedServices].apiKey = [self getTheMapAPIKey];
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


- (BOOL)isResourceReleased
{
    if(_mapView)
    {
        return NO;
    }
    return YES;
}



- (void)releaseMapResourse
{
    _mapView.delegate = nil;
    _mapView = nil;
    _mapSearch.delegate = nil;
    _mapSearch = nil;
    _mapLocationManager.delegate = nil;
    _mapLocationManager = nil;
    _mapNaviWalk.delegate = nil;
    _mapNaviWalk = nil;
    _mapNaviDrive.delegate = nil;
    _mapNaviDrive = nil;
    
}


- (MAMapView *)mapView
{
    if(!_mapView)
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
        _mapView.allowsBackgroundLocationUpdates = NO;
        [self mapViewWillStartLoadingMap:_mapView];
    }
    return _mapView;
}

- (AMapSearchAPI *)mapSearch
{
    if(!_mapSearch)
    {
        _mapSearch = [[AMapSearchAPI alloc]init];
        _mapSearch.delegate = self;
        _mapSearch.timeout = 5;
    }
    return _mapSearch;
}

- (AMapNaviDriveManager *)mapNaviDrive
{
    if(!_mapNaviDrive)
    {
        _mapNaviDrive = [[AMapNaviDriveManager alloc]init];
    }
    return _mapNaviDrive;
}

- (AMapNaviWalkManager *)mapNaviWalk
{
    if(!_mapNaviWalk)
    {
        _mapNaviWalk = [[AMapNaviWalkManager alloc]init];
    }
    return _mapNaviWalk;
}

- (AMapLocationManager *)mapLocationManager
{
    if(!_mapLocationManager)
    {
        //启动定位服务
        _mapLocationManager = [[AMapLocationManager alloc] init];
        _mapLocationManager.delegate = self;
        
        [_mapLocationManager setPausesLocationUpdatesAutomatically:YES];
        [_mapLocationManager setAllowsBackgroundLocationUpdates:NO];
    }
    return _mapLocationManager;
}




@end
