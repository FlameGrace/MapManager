//
//  MapDrawRecord.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapDriveRecordObject.h"
#import "MapDrawRoute.h"


@interface MapDrawDriveRecord : MapDrawRoute
//显示急转弯，默认不显示
@property (assign, nonatomic) BOOL showTurn;
//显示急刹车，默认不显示
@property (assign, nonatomic) BOOL showBrake;
//显示急加速，默认不显示
@property (assign, nonatomic) BOOL showSpeedUp;

@property (strong, nonatomic) MapDriveRecordObject *route;

- (void)drawRoute:(MapDriveRecordObject *)route;

@end
