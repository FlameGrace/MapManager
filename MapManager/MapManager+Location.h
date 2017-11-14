//
//  MapManager+Location.h
//  MapDemo
//
//  Created by Flame Grace on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "MapManager.h"
#import "UserLocationManager.h"
#import "CarLocationManager.h"

@interface MapManager (Location)

@property (weak, nonatomic) UserLocationManager *user;

@property (weak, nonatomic) CarLocationManager *car;

@end
