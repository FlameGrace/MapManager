//
//  MapDrawRoute.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDrawRoute.h"
#import "EndPointMapAnnotation.h"
#import "StartPointMapAnnotation.h"

@interface MapDrawRoute()

@property (strong, nonatomic) NSMutableArray *endpoints;//端点，包含起点和终点的annotation

@end

@implementation MapDrawRoute

@synthesize lineView = _lineView;
@synthesize selectedLineView = _selectedLineView;

- (instancetype)init
{
    if(self = [super init])
    {
        self.showStartPoint = YES;
        self.showEndPoint = YES;
        self.drawLine = [[MapDrawLine alloc]init];
        self.drawPoint = [[MapDrawPoint alloc]init];
        self.endpoints = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)setRoutes:(NSArray<MapRouteObject *> *)routes
{
    _routes = routes;
    [self drawRoutes];
}


- (void)setlineView:(Class)lineView
{
    _lineView = lineView;
    [self updateLineView];
}

- (void)setSelectedLineView:(Class)selectedLineView
{
    _selectedLineView = selectedLineView;
    [self updateLineView];
}

- (Class)selectedLineView
{
    if(!_selectedLineView)
    {
        return _lineView;
    }
    return _selectedLineView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if(_selectedIndex == selectedIndex || selectedIndex >= self.routes.count)
    {
        return;
    }
    _selectedIndex = selectedIndex;
    [self updateLineView];
}

- (void)setShowEndPoint:(BOOL)showEndPoint
{
    if(showEndPoint == _showEndPoint)
    {
        return;
    }
    _showEndPoint = showEndPoint;
    MapAnnotation *startAnno = [self.endpoints lastObject];
    if(_showEndPoint)
    {
        [self.drawPoint addMapAnnotation:startAnno];
    }
    else
    {
        [self.drawPoint removeMapAnnotation:startAnno];
    }
}

- (void)setShowStartPoint:(BOOL)showStartPoint
{
    if(showStartPoint == _showStartPoint)
    {
        return;
    }
    _showStartPoint = showStartPoint;
    MapAnnotation *endAnno = [self.endpoints firstObject];
    if(_showStartPoint)
    {
        [self.drawPoint addMapAnnotation:endAnno];
    }
    else
    {
        [self.drawPoint removeMapAnnotation:endAnno];
    }
}

- (void)drawRoute:(MapRouteObject *)route
{
    if(!route)return;
    [self drawRoutes:@[route]];
}

- (void)drawRoutes:(NSArray<MapRouteObject *> *)routes
{
    self.routes = routes;
}


- (void)drawRoutes
{
    [self clear];
    self.selectedIndex = 0;
    if(!self.routes||self.routes.count <1)
    {
        return;
    }
    MapRouteObject *firstRoute = [self.routes firstObject];
    //只有一个点不画
    if(firstRoute.points.count <2)
    {
        return;
    }
    //先画起点
    NSValue *start = [firstRoute.points firstObject];
    MapAnnotation *startAnno = [MapAnnotation annotationByPoint:start annotationClass:[StartPointMapAnnotation class]];
    [self.endpoints addObject:startAnno];
    if(self.showStartPoint)
    {
        [self.drawPoint addMapAnnotation:startAnno];
    }
    //再画终点
    NSValue *end = [firstRoute.points lastObject];
    MapAnnotation *endAnno = [MapAnnotation annotationByPoint:end annotationClass:[EndPointMapAnnotation class]];
    [self.endpoints addObject:endAnno];
    if(self.showEndPoint)
    {
        [self.drawPoint addMapAnnotation:endAnno];
    }
    
    
    //再画线路
    for (int i = 0; i< self.routes.count; i++)
    {
        MapRouteObject *route = self.routes[i];
        MapPolyLineObject *line = [[MapPolyLineObject alloc]initWithPoints:route.points identifier:@"polyline"];
        if (i == self.selectedIndex)
        {
            line.viewClass = self.selectedLineView;
        }
        else
        {
            line.viewClass = self.lineView;
        }
        [self.drawLine addLine:line];
    }
}



- (void)updateLineView
{
    for (int i = 0; i< self.drawLine.lines.count; i++)
    {
        MapPolyLineObject *line = self.drawLine.lines[i];
        if (i == self.selectedIndex)
        {
            line.viewClass = self.selectedLineView;
        }
        else
        {
            line.viewClass = self.lineView;
        }
        [self.drawLine updateLine:line];
    }
}


- (void)showInMapCenter
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager].mapView showAnnotations:self.endpoints animated:NO];
        [[MapManager sharedManager].mapView setZoomLevel:[MapManager sharedManager].mapView.zoomLevel-1 animated:YES];
    });
}

- (void)clear
{
    [self.drawPoint removeMapAnnotations:self.endpoints];
    [self.drawPoint clear];
    [self.drawLine clear];
    self.endpoints = [[NSMutableArray alloc]init];
}

-(void)dealloc
{
    [self clear];
}

@end
