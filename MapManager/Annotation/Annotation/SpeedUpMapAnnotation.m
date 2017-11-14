//
//  SpeedUpMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace. All rights reserved.
//

#import "SpeedUpMapAnnotation.h"

@implementation SpeedUpMapAnnotation

- (instancetype)init
{
    if(self = [super init])
    {
        self.canShowCallout = YES;
        self.title = @"急加速";
        self.text = @"加";
        self.backGroundColor = [UIColor redColor];
        self.size = CGSizeMake(22, 22);
        self.centerOffset = CGPointMake(0, -10);
    }
    return self;
}

@end
