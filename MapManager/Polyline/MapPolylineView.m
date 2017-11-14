//
//  MapPolyline.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapPolylineView.h"

@implementation MapPolylineView

- (instancetype)initWithPolyline:(MAPolyline *)polyline
{
    if(self = [super initWithPolyline:polyline])
    {
        self.lineWidth = 6.f;
        self.strokeColor = Map_UIColor_HexA(0x55ACEE,1.0);
    }
    return self;
}


@end
