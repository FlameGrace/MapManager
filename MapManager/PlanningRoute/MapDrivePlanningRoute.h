//
//  MapDrivePlanningRouteView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/5.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//
#import "MapPlanningRoute.h"

@interface MapDrivePlanningRoute :MapPlanningRoute

@property (assign, nonatomic) AMapNaviDrivingStrategy strategy;//记录当前的导航偏好

- (void)startPlanningRouteByStartPoint:(CLLocationCoordinate2D)start endPoint:(CLLocationCoordinate2D)end wayPoints:(NSArray *)wayPoints;

+ (NSString *)transformStrategy:(AMapNaviDrivingStrategy)strategy;




@end
