//
//  SearchResult.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/3.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapLocationModel.h"

@implementation MapLocationModel



+ (id)model
{
    return [[self alloc]init];
}

+ (id)modelByCoordinate:(CLLocationCoordinate2D)coordinate
{
    MapLocationModel *model = [[[self class] alloc]init];
    model.coordinate2D = coordinate;
    return model;
}







@end
