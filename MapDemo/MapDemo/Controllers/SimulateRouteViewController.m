//
//  SimulateRouteViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "SimulateRouteViewController.h"
#import "AnCar.h"
#import "CarSimulator.h"

@interface SimulateRouteViewController ()



@end

@implementation SimulateRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CarSimulator sharedSimulator].simulating = YES;
    [AnCar sharedCar].showCar = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:MainScreenBounds];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
    [[MapManager sharedManager].mapView setZoomLevel:16];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(showCar) withObject:nil afterDelay:2];
}

- (void)showCar
{
    [[AnCar sharedCar]switchCarInMapCenter];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [CarSimulator sharedSimulator].simulating = NO;
    [AnCar sharedCar].showCar = NO;
}


@end
