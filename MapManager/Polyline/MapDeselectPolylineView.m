//
//  MapDeselectPolylineView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/4.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDeselectPolylineView.h"

@implementation MapDeselectPolylineView

- (instancetype)initWithPolyline:(MAPolyline *)polyline
{
    if(self = [super initWithPolyline:polyline])
    {
        self.strokeColor = Map_UIColor_HexA(0x55ACEE,0.5);
    }
    return self;
}

@end
