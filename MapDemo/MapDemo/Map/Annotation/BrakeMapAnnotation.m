//
//  BrokeMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "BrakeMapAnnotation.h"

@implementation BrakeMapAnnotation

- (instancetype)init
{
    if(self = [super init])
    {
        self.canShowCallout = YES;
        self.title = @"急刹车";
        self.text = @"刹";
        self.backGroundColor = [UIColor grayColor];
        self.size = CGSizeMake(44, 44);
        self.centerOffset = CGPointMake(0, -22);
    }
    return self;
}

@end
