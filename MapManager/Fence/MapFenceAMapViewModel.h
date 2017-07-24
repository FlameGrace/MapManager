//
//  MapFence_MapModel.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/5/22.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//  管理单个电子高德地图显示，及监控状态的类

#import <Foundation/Foundation.h>
#import "MapManagerHeader.h"
#import "MapFenceModel.h"


typedef NS_ENUM(NSInteger, MapFenceStatus)
{
    MapFenceStatusUnknown  = -1,       ///< 未知
    MapFenceStatusOutside  = 0,       ///< 在范围外
    MapFenceStatusInside   = 1,       ///< 在范围内
};

@class MapFenceAMapViewModel;

@protocol MapFenceAMapViewModelDelegate <NSObject>
/**
 * @brief 地理围栏状态改变时回调，当某个围栏状态的值发生改变
 * @param fence 地理围栏管理类
 * @param newStatus 新状态
 * @param oldStatus 旧状态
 */
- (void)mapFenceMonitorStatusChanged:(MapFenceAMapViewModel *)fence newStatus:(MapFenceStatus)newStatus oldStatus:(MapFenceStatus)oldStatus;

@end



@interface MapFenceAMapViewModel : NSObject

@property (readonly, nonatomic) MapFenceModel *model;
//是否在地图上显示
@property (nonatomic, assign) BOOL showPolyline;
@property (assign, nonatomic) MapFenceStatus status;
@property (weak,nonatomic) id<MapFenceAMapViewModelDelegate>delegate;


- (instancetype)initWithModel:(MapFenceModel *)model;

//[NSValue valueWithCGPoint:CGPointMake(longitude, latitude)]
- (void)updateMonitorLocation:(NSValue *)coordinate;
//将电子围栏显示地图中心
- (void)showFenceInMapCenter;

@end
