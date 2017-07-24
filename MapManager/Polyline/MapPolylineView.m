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
        self.strokeColor = [UIColor blueColor];
    }
    return self;
}


@end
