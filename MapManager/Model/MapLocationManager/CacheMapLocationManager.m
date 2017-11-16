//
//  CacheMapLocationManager.m
//  MapDemo
//
//  Created by Flame Grace on 2017/11/14.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "CacheMapLocationManager.h"

@interface CacheMapLocationManager() <MAMapViewDelegate>

@end

@implementation CacheMapLocationManager

- (void)updateLocationByLatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    [super updateLocationByLatitude:latitude longitude:longitude];
    @synchronized(self)
    {
        if(!longitude||!latitude)
        {
            _pointCaches = nil;
            return;
        }
        NSValue *point = [NSValue valueWithCGPoint:CGPointMake(latitude.floatValue, longitude.floatValue)];
        [self.pointCaches addObject:point];
        if([self.pointCaches count]>2)
        {
            [self.pointCaches removeObjectAtIndex:0];
        }
    }

}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (MapAnnotationView *view in views) {
        if(![view isKindOfClass:[MapAnnotationView class]])
        {
            continue;
        }
        if([self.drawPoint.annotations containsObject:view.annotation]&&self.pointCaches.count)
        {
            NSArray *pointCaches = [NSMutableArray arrayWithArray:self.pointCaches];
            for (NSValue *point  in pointCaches) {
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(point.CGPointValue.x, point.CGPointValue.y);
                [view updateLocation:coordinate];
            }
        }
    }
}
- (NSMutableArray *)pointCaches
{
    if(!_pointCaches)
    {
        _pointCaches = [[NSMutableArray alloc]init];
    }
    return _pointCaches;
}

@end
