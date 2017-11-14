//
//  DrawLineViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "DrawLineViewController.h"
#import "MapDrawLine.h"
#import "MapSearch.h"
#import "MapSearchKeywords.h"
#import "MapRedPolylineView.h"

@interface DrawLineViewController () 

@property (strong, nonatomic) MapDrawLine *drawLine;
@property (strong, nonatomic) MapSearch *search;

@property (strong, nonatomic) UIButton *selectFirstButton;
@property (strong, nonatomic) UIButton *deselectFirstButton;

@end

@implementation DrawLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.drawLine = [[MapDrawLine alloc]init];
    self.search = [[MapSearch alloc]init];
    [self startPlanningRoute];
    self.selectFirstButton = [self buttonWithFrame:CGRectMake(0, 100, 150, 30) title:@"选择第一条" selector:@selector(selectFirst)];
    self.deselectFirstButton = [self buttonWithFrame:CGRectMake(0, 150, 150, 30) title:@"取消选择" selector:@selector(deselectFirst)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:self.view.frame];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
    
}

- (void)selectFirst
{
    if(self.drawLine.lines.count < 1)
    {
        return;
    }
    MapPolyLineObject *line = [self.drawLine.lines firstObject];
    line.viewClass = [MapRedPolylineView class];
    [self.drawLine updateLine:line];
    
}

- (void)deselectFirst
{
    if(self.drawLine.lines.count < 1)
    {
        return;
    }
    MapPolyLineObject *line = [self.drawLine.lines firstObject];
    line.viewClass = nil;
    [self.drawLine updateLine:line];
}


- (void)startPlanningRoute
{
    Map_WeakObj(self)
    [self.search searchDrivingRouteBetweenOrigin:CLLocationCoordinate2DMake(30.1, 112.0) andDestination:CLLocationCoordinate2DMake(31.1, 120.01) strategy:10 requireExtension:NO callback:^(MapSearchObject *search, BOOL isNewest) {
        if(!isNewest)
        {
            return ;
        }
        
        Map_StrongObj(self)
        if(!search.error)
        {
            [self onRouteSearchDoneResponse:(AMapRouteSearchResponse *)search.response];
        }
    }];
}


- (void)onRouteSearchDoneResponse:(AMapRouteSearchResponse *)response
{
    if(response.count < 1)
    {
        return;
    }
    
    for (int i = 0; i< response.route.paths.count; i++) {
        AMapPath *path = response.route.paths[i];
        MAPolyline *poline = [MapManager polylineForPath:path];
        MapPolyLineObject *object = [[MapPolyLineObject alloc]initWithPolylines:@[poline] identifier:[NSString stringWithFormat:@"%d",i]];
        [self.drawLine addLine:object];
        [self.drawLine showLineInMapCenter:object];
    }
    return;
    
}



@end
