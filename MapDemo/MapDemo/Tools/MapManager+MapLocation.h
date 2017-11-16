//
//  MapManager+Location.h
//  leapmotor
//
//  Created by 李嘉军 on 2017/11/14.
//  Copyright © 2017年 Leapmotor. All rights reserved.
//

#import "MapManager.h"
#import "CarLocationManager.h"
#import "UserLocationManager.h"

@interface MapManager (MapLocation)

@property (weak, nonatomic) UserLocationManager *user;
@property (weak, nonatomic) CarLocationManager *car;

@end
