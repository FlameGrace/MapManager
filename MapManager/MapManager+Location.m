//
//  MapManager+Location.m
//  MapDemo
//
//  Created by Flame Grace on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "MapManager+Location.h"

@implementation MapManager (Location)

- (UserLocationManager *)user
{
    return [UserLocationManager sharedUser];
}

- (CarLocationManager *)car
{
    return [CarLocationManager sharedCar];
}

- (void)setCar:(CarLocationManager *)car
{
    
}

- (void)setUser:(UserLocationManager *)user
{
    
}

@end
