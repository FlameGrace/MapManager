//
//  SimulateRouteViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "SimulateRouteViewController.h"
#import "CarLocationManager.h"
#import "CarSimulator.h"

@interface SimulateRouteViewController ()



@end

@implementation SimulateRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CarSimulator sharedSimulator].simulating = YES;
    [MapManager sharedManager].car.show = YES;
    [[MapManager sharedManager].car switchLocationInMapCenter];
    [MapManager sharedManager].car.showLocationInMapCenter = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:self.view.frame];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
    [[MapManager sharedManager].mapView setZoomLevel:16];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [CarSimulator sharedSimulator].simulating = NO;
    [MapManager sharedManager].car.show = NO;
     [MapManager sharedManager].car.showLocationInMapCenter = NO;
}


@end
