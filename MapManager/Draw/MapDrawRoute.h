//
//  MapDrawRoute.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//  地图画路径规划，多条路线的起点终点一样

#import <Foundation/Foundation.h>
#import "MapRouteObject.h"
#import "MapDrawLine.h"
#import "MapDrawPoint.h"

@interface MapDrawRoute : NSObject
//画线的工具
@property (strong, nonatomic) MapDrawLine *drawLine;
//画点的工具
@property (strong, nonatomic) MapDrawPoint *drawPoint;
//更改线的外观，只需继承MapPolylineView类，在初始化方法赋相应的值即可，默认为MapPolylineView
@property (strong, nonatomic) Class lineView;
//被选择的线路外观,默认与lineView相同
@property (strong, nonatomic) Class selectedLineView;
//在地图上显示起点，默认显示
@property (assign, nonatomic) BOOL showStartPoint;
//在地图上显示终点，默认显示
@property (assign, nonatomic) BOOL showEndPoint;
//路线数组
@property (strong, nonatomic) NSArray <MapRouteObject *>*routes;
//当前选择的某条线路
@property (assign, nonatomic) NSInteger selectedIndex;

@property (assign, nonatomic) BOOL isAutoShowInMapCenter;

- (void)drawRoute:(MapRouteObject *)route;

- (void)drawRoutes:(NSArray <MapRouteObject *>*)routes;

- (void)showInMapCenter;

- (void)clear;


@end
