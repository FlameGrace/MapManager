//
//  DrawDriveRecordViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "DrawDriveRecordViewController.h"
#import "MapDrawDriveRecord.h"
#import "MapSearch.h"

@interface DrawDriveRecordViewController ()

@property (strong, nonatomic) MapDrawDriveRecord *drawRoute;
@property (strong, nonatomic) MapSearch *search;

@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UIButton *endButton;

@property (strong, nonatomic) UIButton *turnButton;
@property (strong, nonatomic) UIButton *brakeButton;
@property (strong, nonatomic) UIButton *speedUpButton;

@end

@implementation DrawDriveRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.drawRoute = [[MapDrawDriveRecord alloc]init];
    self.search = [[MapSearch alloc]init];
    
    self.startButton = [self buttonWithFrame:CGRectMake(0, 140, 150, 30) title:@"起点" selector:@selector(selectStart)];
    self.endButton = [self buttonWithFrame:CGRectMake(0, 180, 150, 30) title:@"终点" selector:@selector(selectEnd)];
    self.turnButton = [self buttonWithFrame:CGRectMake(0, 240, 150, 30) title:@"急转弯" selector:@selector(selectTurn)];
    self.brakeButton = [self buttonWithFrame:CGRectMake(0, 280, 150, 30) title:@"急刹车" selector:@selector(selectBrake)];
    self.speedUpButton = [self buttonWithFrame:CGRectMake(0, 320, 150, 30) title:@"急加速" selector:@selector(selectSpeedUp)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:MainScreenBounds];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WeakObj(self)
    [self.search searchDrivingRouteBetweenOrigin:CLLocationCoordinate2DMake(31.2315350000, 121.4756170000) andDestination:CLLocationCoordinate2DMake(30.2090310000, 120.2241600000) strategy:10 requireExtension:NO callback:^(MapSearchObject *search, BOOL isNewest) {
        StrongObj(self)
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

- (void)selectTurn
{
    self.drawRoute.showTurn = !self.drawRoute.showTurn;
}

- (void)selectBrake
{
    self.drawRoute.showBrake = !self.drawRoute.showBrake;
}

- (void)selectSpeedUp
{
    self.drawRoute.showSpeedUp = !self.drawRoute.showSpeedUp;
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
    MapDriveRecordObject *object = [[MapDriveRecordObject alloc]init];
    object.points = points;
    object.turnPoints = [NSArray arrayWithObjects:points[400],points[600],points[950], nil];
    object.speedingUpPoints = [NSArray arrayWithObjects:points[750],points[1000],points[250], nil];
    object.brakePoints = [NSArray arrayWithObjects:points[900],points[500],points[830], nil];
    [self.drawRoute drawRoute:object];
    [self.drawRoute showInMapCenter];
}



@end
