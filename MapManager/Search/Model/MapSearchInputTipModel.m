//
//  MapSearchInputTipModel.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/1.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearchInputTipModel.h"

@implementation MapSearchInputTipModel

@synthesize name = _name;
@synthesize inputType = _inputType;
@synthesize address = _address;
@synthesize poiUid = _poiUid;
@synthesize city = _city;
@synthesize keyword = _keyword;
@synthesize tipKeyword = _tipKeyword;
@synthesize location = _location;

+ (instancetype)model
{
    return [[self alloc]init];
}

@end
