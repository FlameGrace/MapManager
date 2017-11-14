//
//  MapDriveRecordObject.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//  单条行车记录

#import <Foundation/Foundation.h>
#import "MapRouteObject.h"

@interface MapDriveRecordObject : MapRouteObject
//急刹车
@property (strong, nonatomic) NSArray <NSValue *> *brakePoints;
//急加速
@property (strong, nonatomic) NSArray <NSValue *> *speedingUpPoints;
//急转弯
@property (strong, nonatomic) NSArray <NSValue *> *turnPoints;

@end
