//
//  MapSearchMapLocation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "SearchMapLocation.h"

@implementation SearchMapLocation
@synthesize annotation = _annotation;

- (Class)annotationClass
{
    return [SearchMapAnnotation class];
}

@end
