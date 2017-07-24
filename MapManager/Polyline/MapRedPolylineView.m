//
//  MapRedPolylineView.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapRedPolylineView.h"

@implementation MapRedPolylineView

- (instancetype)initWithPolyline:(MAPolyline *)polyline
{
    if(self = [super initWithPolyline:polyline])
    {
        self.strokeColor = [UIColor redColor];
    }
    return self;
}

@end
