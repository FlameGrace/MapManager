//
//  MapDrivePlanningRouteView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/5.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDrivePlanningRoute.h"
#import<AVFoundation/AVFoundation.h>

@interface MapDrivePlanningRoute() <AMapNaviDriveManagerDelegate>


@end

@implementation MapDrivePlanningRoute

- (instancetype)init
{
    if(self = [super init])
    {
        [MapManager sharedManager].mapNaviDrive.delegate = self;
    }
    
    return self;
}


- (void)startPlanningRouteByStartPoint:(CLLocationCoordinate2D)start endPoint:(CLLocationCoordinate2D)end
{
    [self startPlanningRouteByStartPoint:start endPoint:end wayPoints:nil];
}


- (void)startPlanningRouteByStartPoint:(CLLocationCoordinate2D)start endPoint:(CLLocationCoordinate2D)end wayPoints:(NSArray *)wayPoints
{
    [self clear];
    AMapNaviPoint *startPoint =[MapManager transformAMapNaviPointCLLocationCoordinate2D:start];
    AMapNaviPoint *endPoint =[MapManager transformAMapNaviPointCLLocationCoordinate2D:end];
    [[MapManager sharedManager].mapNaviDrive calculateDriveRouteWithStartPoints:@[startPoint]
                                                                        endPoints:@[endPoint] wayPoints:nil drivingStrategy:self.strategy];
}

- (void)drawRoute
{
    NSMutableArray *routes = [[NSMutableArray alloc]init];
    for (AMapNaviRoute *route in [MapManager sharedManager].mapNaviDrive.naviRoutes.allValues)
    {
        MapRouteObject *routeObject = [[MapRouteObject alloc]init];
        routeObject.points = [MapManager pointsArrayFromNaviRoute:route];
        [routes addObject:routeObject];
    }
    [self.draw drawRoutes:routes];
    [self.draw showInMapCenter];
    self.routes = [NSArray arrayWithArray:[MapManager sharedManager].mapNaviDrive.naviRoutes.allValues];
}


#pragma MapNaviDriveManagerDelegate
//驾车导航
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    [self drawRoute];
    
    if([self.delegate respondsToSelector:@selector(planningRouteOnCalculateRouteSuccess:)])
    {
        [self.delegate planningRouteOnCalculateRouteSuccess:self];
    }
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(planningRoute:onCalculateRouteFailure:)])
    {
        [self.delegate planningRoute:self onCalculateRouteFailure:error];
    }
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    [self playNaviSoundString:soundString soundStringType:soundStringType];
}



//重新设置偏好
- (void)setStrategy:(AMapNaviDrivingStrategy)strategy
{
    
    if(strategy == _strategy) return;
    _strategy = strategy;
    NSString *lastStrategy = [NSString stringWithFormat:@"%ld",(long)_strategy];
    [[NSUserDefaults standardUserDefaults]setObject:lastStrategy forKey:@"lastStrategy"];
}

+ (NSString *)transformStrategy:(AMapNaviDrivingStrategy)strategy
{
    //避免拥堵
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidCongestion)
        return @"1000";
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidHighway)
        return @"0100";
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidCost)
        return @"0010";
    if(strategy == AMapNaviDrivingStrategyMultiplePrioritiseHighway)
        return @"0001";
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidHighwayAndCongestion)
        return @"1100";
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidHighwayAndCost)
        return @"0110";
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidCostAndCongestion)
        return @"1010";
    if(strategy == AMapNaviDrivingStrategyMultipleAvoidHighwayAndCostAndCongestion)
        return @"1110";
    if(strategy == AMapNaviDrivingStrategyMultiplePrioritiseHighwayAvoidCongestion)
        return @"1001";
    else return @"0000";
}


-(void)dealloc
{
    [self.draw clear];
}

@end
