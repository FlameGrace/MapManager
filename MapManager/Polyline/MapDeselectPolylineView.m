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
        self.strokeColor = [UIColor blueColor];
    }
    return self;
}

@end
