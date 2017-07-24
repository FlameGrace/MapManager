//
//  MapWalkNaviView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/19.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>

@interface WalkNaviView : AMapNaviWalkView <AMapNaviWalkDataRepresentable>

- (void)startNavi;

- (void)stopNavi;

@end
