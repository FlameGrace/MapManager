//
//  MapSearchObject.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearchObject.h"

@implementation MapSearchObject


- (instancetype)initWithRequest:(AMapSearchObject *)request callback:(MapSearchcallback)callback searchSelector:(SEL)searchSelector
{
    if(self = [super init])
    {
        self.request = request;
        self.callback = callback;
        self.searchSelector = searchSelector;
    }
    return self;
}

@end
