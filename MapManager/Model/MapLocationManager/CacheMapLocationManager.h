//
//  CacheMapLocationManager.h
//  MapDemo
//
//  Created by 李嘉军 on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "MapLocationManager.h"

@interface CacheMapLocationManager : MapLocationManager 

@property (strong, nonatomic)  NSMutableArray *pointCaches;

@end
