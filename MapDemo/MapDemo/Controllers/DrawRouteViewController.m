//
//  DrawRouteViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "DrawRouteViewController.h"
#import "MapDrawRoute.h"
#import "MapSearch.h"
#import "CarSimulator.h"

@interface DrawRouteViewController () <MAMapViewDelegate>

@property (strong, nonatomic) MapDrawRoute *drawRoute;
@property (strong, nonatomic) MapSearch *search;

@property (strong, nonatomic) UIButton *endButton;

@end

@implementation DrawRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.endButton = [self buttonWithFrame:CGRectMake(0, 150, 150, 30) title:@"终点" selector:@selector(selectEnd)];
    [[MapManager sharedManager]addMultiDelegate:self];
    
    self.drawRoute = [[MapDrawRoute alloc]init];
    self.drawRoute.showStartPoint = NO;
    self.search = [[MapSearch alloc]init];
    
    [CarSimulator sharedSimulator].simulating = YES;
    [MapManager sharedManager].car.showLocationInMapCenter = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(carLocationChanged:) name:CarLocationChangedNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:self.view.frame];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [CarSimulator sharedSimulator].simulating = NO;
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    if(wasUserAction)
    {
        [MapManager sharedManager].car.showLocationInMapCenter = NO;
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)carLocationChanged:(NSNotification *)noti
{
    [self planningRoute];
}

- (void)planningRoute
{
    Map_WeakObj(self)
    [self.search searchDrivingRouteBetweenOrigin:[MapManager sharedManager].car.location.coordinate2D andDestination:CLLocationCoordinate2DMake(30.2511750000,120.1773960000) strategy:10 requireExtension:NO callback:^(MapSearchObject *search, BOOL isNewest) {
        Map_StrongObj(self)
        if(!search.error)
        {
            [self onRouteSearchDoneResponse:(AMapRouteSearchResponse *)search.response];
        }
    }];
}


- (void)selectEnd
{
    self.drawRoute.showEndPoint = !self.drawRoute.showEndPoint;
}


- (void)onRouteSearchDoneResponse:(AMapRouteSearchResponse *)response
{
    if(response.count < 1)
    {
        return;
    }
    AMapPath *path = [response.route.paths firstObject];
    NSUInteger count = 0;
    CLLocationCoordinate2D *coordinate = [MapManager coordinatesForPath:path coordinateCount:&count];
    NSArray *points = [MapManager pointsArrayFromCoordinates:coordinate count:count];
    if(coordinate)
    {
        free(coordinate);
    }
    MapRouteObject *object = [[MapRouteObject alloc]init];
    object.points = points;
    [self.drawRoute drawRoute:object];
    if(self.drawRoute.isAutoShowInMapCenter)
    {
        self.drawRoute.isAutoShowInMapCenter = NO;
    }
}



@end
