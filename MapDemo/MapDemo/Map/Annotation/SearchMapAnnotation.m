//
//  SearchMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "SearchMapAnnotation.h"

@implementation SearchMapAnnotation

- (instancetype)init
{
    if(self = [super init])
    {
        self.canShowCallout = NO;
        self.text = @"点";
        self.backGroundColor = UIColor_HexA(0x45e344, 1);
        self.size = CGSizeMake(44, 44);
        self.selectedSize = CGSizeMake(80, 80);
        self.centerOffset = CGPointMake(0, -20);
        self.selectedCenterOffset = CGPointMake(0, -35);
    }
    return self;
}

@end
