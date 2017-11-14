//
//  StartPointMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace. All rights reserved.
//

#import "StartPointMapAnnotation.h"

@implementation StartPointMapAnnotation

- (instancetype)init
{
    if(self = [super init])
    {
        self.canShowCallout = NO;
        self.image = [UIImage imageNamed:@"map_ic_pathStart"];
        self.size = CGSizeMake(44, 44);
        self.centerOffset = CGPointMake(0, -20);
    }
    return self;
}

@end
