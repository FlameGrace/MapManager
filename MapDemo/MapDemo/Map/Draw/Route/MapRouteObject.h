//
//  MapRouteObject.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//  路径规划的一条线路

#import <Foundation/Foundation.h>

@interface MapRouteObject : NSObject

//途经点
@property (strong, nonatomic) NSArray <NSValue *> *points;

@end
