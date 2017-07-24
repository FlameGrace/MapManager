//
//  MapPlanningRoute.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/31.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapPlanningRouteProtocol.h"
#import "MapPlanningRouteDelegate.h"
#import "MapManagerHeader.h"


@interface MapPlanningRoute : NSObject<MapPlanningRouteProtocol>

@property (weak, nonatomic) id <MapPlanningRouteDelegate> delegate;

- (void)startPlanningRouteByStartPoint:(CLLocationCoordinate2D)start endPoint:(CLLocationCoordinate2D)end;

- (void)playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType;
//停止导航语音播报
- (void)showInMapCenter;

- (void)stopVoiceNavi;

@end
