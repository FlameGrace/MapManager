//
//  MapWalkNaviView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/19.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "WalkNaviView.h"

@interface WalkNaviView()  <AMapNaviWalkViewDelegate>


@end


@implementation WalkNaviView

- (instancetype)init
{
    if(self = [super init])
    {
        [self layoutView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self layoutView];
    }
    return self;
}

- (void)layoutView
{
    self.showMoreButton = NO;
    self.showUIElements = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}

- (void)startNavi
{
    [[MapManager sharedManager].mapNaviWalk addDataRepresentative:self];
    [[MapManager sharedManager].mapNaviWalk startGPSNavi];
}

- (void)stopNavi
{
    [[MapManager sharedManager].mapNaviWalk stopNavi];
    [[MapManager sharedManager].mapNaviWalk removeDataRepresentative:self];
}


@end
