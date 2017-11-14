//
//  MapManager+Location.m
//  MapDemo
//
//  Created by 李嘉军 on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "MapManager+Location.h"

@implementation MapManager (Location)

- (UserLocationManager *)user
{
    return [UserLocationManager sharedUser];
}

- (void)setUser:(UserLocationManager *)user
{
    
}

- (CarLocationManager *)car
{
    return [CarLocationManager sharedCar];
}

- (void)setCar:(CarLocationManager *)car
{
    
}

@end
