//
//  MovingAnnotationView.h
//  test
//
//  Created by yi chen on 14-9-3.
//  Copyright (c) 2014年 yi chen. All rights reserved.
//

#import "MapAnnotationView.h"
//平滑移动动画的大头针

@interface MovingAnnotationView : MapAnnotationView

//是否支持旋转角度
@property (assign, nonatomic) BOOL supportRolation;

/*!
 @brief 添加动画
 @param points 轨迹点串，每个轨迹点为AMapGeoPoint类型
 @param duration 动画时长，包括从上一个动画的终止点过渡到新增动画起始点的时间
 */
- (void)addTrackingAnimationForPoints:(NSArray <AMapGeoPoint*> *)points duration:(CFTimeInterval)duration;

- (void)updateLocation:(CLLocationCoordinate2D)coordinate;

@end
