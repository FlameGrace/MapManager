//
//  MapManager+Location.m
//  leapmotor
//
//  Created by 李嘉军 on 2017/11/14.
//  Copyright © 2017年 Leapmotor. All rights reserved.
//

#import "MapManager+MapLocation.h"

@implementation MapManager (MapLocation)

- (CarLocationManager *)car
{
    return [CarLocationManager sharedCar];
}

- (void)setCar:(CarLocationManager *)car
{
    
}

- (UserLocationManager *)user
{
    return [UserLocationManager sharedUser];
}

- (void)setUser:(UserLocationManager *)user
{
    
}

@end
