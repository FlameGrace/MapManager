//
//  MapCarLocationSimulator.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "CarSimulator.h"
#import "CarLocationManager.h"
#import "MapSearch.h"

@interface CarSimulator()

@property (strong, nonatomic) MapSearch *search;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *simulateRoutes;

@end

@implementation CarSimulator

static CarSimulator *simulator = nil;

+ (instancetype)sharedSimulator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        simulator = [[self alloc]init];
    });
    return simulator;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.search = [[MapSearch alloc]init];
    }
    return self;
}

- (void)setSimulating:(BOOL)simulating
{
    _simulating = simulating;
    if(_simulating)
    {
        [self startTimer];
        return;
    }
    [self endTimer];
}

- (void)startTimer
{
    [self endTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(simulateRoute) userInfo:nil repeats:YES];
    [timer fire];
    self.timer = timer;
}

- (void)endTimer
{
    if(self.timer.isValid)
    {
        [self.timer invalidate];
    }
    self.timer = nil;
}

- (void)simulateRoute
{
    if(!self.simulateRoutes)
    {
        Map_WeakObj(self)
        [self.search searchDrivingRouteBetweenOrigin:CLLocationCoordinate2DMake(30.2089750000,120.2228930000) andDestination:CLLocationCoordinate2DMake(30.2511750000,120.1773960000) strategy:10 requireExtension:NO callback:^(MapSearchObject *search, BOOL isNewest) {
            Map_StrongObj(self)
            
            if(!search.error)
            {
                [self onRouteSearchDoneResponse:(AMapRouteSearchResponse *)search.response];
            }
        }];
        return;
    }
    AMapGeoPoint *point = [self.simulateRoutes firstObject];
    if(point)
    {
        [self.simulateRoutes removeObject:point];
        [[MapManager sharedManager].car updateLocationByLatitude:[NSString stringWithFormat:@"%f",point.latitude] longitude:[NSString stringWithFormat:@"%f",point.longitude]];
    }
    
}


- (void)onRouteSearchDoneResponse:(AMapRouteSearchResponse *)response
{
    if(response.count < 1)
    {
        return;
    }
    self.simulateRoutes = [[NSMutableArray alloc]init];
    AMapPath *path = [response.route.paths firstObject];
    for (AMapStep *step in path.steps) {
        NSUInteger count =0;
        CLLocationCoordinate2D *coors = [MapManager coordinatesForString:step.polyline coordinateCount:&count parseToken:@";"];
        for (int i =0; i<count; i++) {
            CLLocationCoordinate2D coordinate = coors[i];
            [self.simulateRoutes addObject:[MapManager transformCLLocationCoordinate2D:coordinate]];
        }
        if(coors)
        {
            free(coors);
        }
    }
    return;
    
}

@end
