//
//  MapFenceModel.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/5/20.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
// 电子围栏数据存储


@interface MapFenceModel : NSObject

 //points NSValue *value = [NSValue valueWithCGPoint:CGPointMake(longitude, latitude)];
@property (strong ,nonatomic) NSArray <NSValue *> *points; //经纬度点
@property (strong, nonatomic) NSString *district;

@end
