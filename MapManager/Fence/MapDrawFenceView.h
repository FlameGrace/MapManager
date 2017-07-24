//
//  MapFenceView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/5/19.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//  在在地图上画电子围栏

#import <Foundation/Foundation.h>
#import "MapFenceAMapViewModel.h"

@class MapDrawFenceView;

@protocol MapDrawFenceViewDelegate <NSObject>

- (void)mapFenceView:(MapDrawFenceView *)fenceView drawAnNewFence:(MapFenceAMapViewModel *)fence;

- (void)mapFenceViewDrawDistrict:(MapDrawFenceView *)fenceView failToError:(NSError *)error;

@end


@interface MapDrawFenceView : UIView

@property (weak, nonatomic) id <MapDrawFenceViewDelegate>delegate;

//画普通区域
- (void)draw;
//画行政区域
- (void)drawDistrict:(NSString *)district;
//重置画布
- (void)clean;
//
- (BOOL)isDrawing;

- (void)showInMapCenter;


@end
