//
//  MapWalkPlanningRoute.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/5.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapWalkPlanningRoute.h"


@interface MapWalkPlanningRoute() <AMapNaviWalkManagerDelegate>


@end

@implementation MapWalkPlanningRoute

- (instancetype)init
{
    if(self = [super init])
    {
        [MapManager sharedManager].mapNaviWalk.delegate = self;
    }
    
    return self;
}


- (void)startPlanningRouteByStartPoint:(CLLocationCoordinate2D)start endPoint:(CLLocationCoordinate2D)end
{
    [self clear];
    AMapNaviPoint *startPoint =[MapManager transformAMapNaviPointCLLocationCoordinate2D:start];
    AMapNaviPoint *endPoint =[MapManager transformAMapNaviPointCLLocationCoordinate2D:end];
    [[MapManager sharedManager].mapNaviWalk calculateWalkRouteWithStartPoints:@[startPoint]
                                                                        endPoints:@[endPoint]];
}
- (void)drawRoute
{
    MapRouteObject *route = [[MapRouteObject alloc]init];
    route.points = [MapManager pointsArrayFromNaviRoute:[MapManager sharedManager].mapNaviWalk.naviRoute];
    [self.draw drawRoute:route];
    self.routes = @[[MapManager sharedManager].mapNaviWalk.naviRoute];
}


#pragma MapNaviWalkManagerDelegate
//驾车导航
- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager
{
    [self drawRoute];
    
    if([self.delegate respondsToSelector:@selector(planningRouteOnCalculateRouteSuccess:)])
    {
        [self.delegate planningRouteOnCalculateRouteSuccess:self];
    }
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager onCalculateRouteFailure:(nonnull NSError *)error
{
    if([self.delegate respondsToSelector:@selector(planningRoute:onCalculateRouteFailure:)])
    {
        [self.delegate planningRoute:self onCalculateRouteFailure:error];
    }
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    [self playNaviSoundString:soundString soundStringType:soundStringType];
}

-(void)dealloc
{
    [self.draw clear];
}

@end;
