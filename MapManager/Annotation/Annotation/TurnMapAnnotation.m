//
//  TurnMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace. All rights reserved.
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
        self.size = CGSizeMake(22, 22);
        self.centerOffset = CGPointMake(0, -10);
    }
    return self;
}

@end
