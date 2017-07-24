//
//  MapPlanningRouteProtocol.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/31.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapManagerHeader.h"
#import "MapDrawRoute.h"

@protocol MapPlanningRouteProtocol <NSObject>

@property (strong, nonatomic) MapDrawRoute *draw;
@property (nonatomic, strong) NSArray  *routes; //记录当前的导航路线数组

- (void)showInMapCenter;
//画路线
- (void)drawRoute;
//移除路线
- (void)clear;


@end





