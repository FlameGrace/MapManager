//
//  TurnMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "TurnMapAnnotation.h"

@implementation TurnMapAnnotation

- (instancetype)init
{
    if(self = [super init])
    {
        self.canShowCallout = YES;
        self.title = @"急转弯";
        self.text = @"转";
        self.backGroundColor = [UIColor blueColor];
        self.size = CGSizeMake(44, 44);
        self.centerOffset = CGPointMake(0, -22);
    }
    return self;
}

@end
