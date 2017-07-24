//
//  MapPlanningRouteDelegate.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/31.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapPlanningRouteProtocol.h"

@protocol MapPlanningRouteDelegate <NSObject>

@optional
//规划导航路线成功
- (void)planningRouteOnCalculateRouteSuccess:(id<MapPlanningRouteProtocol>)planningRoute;

- (void)planningRoute:(id<MapPlanningRouteProtocol>)planningRoute onCalculateRouteFailure:(NSError *)error;


@end
