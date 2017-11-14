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

@interface DrawRouteViewController ()

@property (strong, nonatomic) MapDrawRoute *drawRoute;
@property (strong, nonatomic) MapSearch *search;

@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UIButton *endButton;

@end

@implementation DrawRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.drawRoute = [[MapDrawRoute alloc]init];
    self.search = [[MapSearch alloc]init];
    
    self.startButton = [self buttonWithFrame:CGRectMake(0, 100, 150, 30) title:@"起点" selector:@selector(selectStart)];
    self.endButton = [self buttonWithFrame:CGRectMake(0, 150, 150, 30) title:@"终点" selector:@selector(selectEnd)];
    
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Map_WeakObj(self)
    [self.search searchDrivingRouteBetweenOrigin:CLLocationCoordinate2DMake(31.2315350000, 121.4756170000) andDestination:CLLocationCoordinate2DMake(30.2090310000, 120.2241600000) strategy:10 requireExtension:NO callback:^(MapSearchObject *search, BOOL isNewest) {
        Map_StrongObj(self)
        if(!search.error)
        {
            [self onRouteSearchDoneResponse:(AMapRouteSearchResponse *)search.response];
        }
    }];
}



- (void)selectStart
{
    self.drawRoute.showStartPoint = !self.drawRoute.showStartPoint;
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
    [self.drawRoute showInMapCenter];
}



@end
