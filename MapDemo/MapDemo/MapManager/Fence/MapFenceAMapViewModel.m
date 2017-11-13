//
//  MapFence_MapModel.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/5/22.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapFenceAMapViewModel.h"
#import "MapDrawLine.h"

@interface MapFenceAMapViewModel() <MapFenceAMapViewModelDelegate>

@property (readwrite, strong, nonatomic) MapFenceModel *model;
@property (strong, nonatomic) AMapLocationPolygonRegion *region;
@property (strong, nonatomic) MapDrawLine *drawLine;
@property (strong, nonatomic) MapPolyLineObject *line;
@property (nonatomic, strong) MAPolyline *polyline;

@end


@implementation MapFenceAMapViewModel


- (instancetype)initWithModel:(MapFenceModel *)model
{
    if(self = [super init])
    {
        [[MapManager sharedManager]addMultiDelegate:self];
        self.drawLine = [[MapDrawLine alloc]init];
        self.status = MapFenceStatusUnknown;
        self.model = model;
        if(self.model.points.count >0)
        {
            NSString *identifier = [[NSUUID UUID]UUIDString];
            self.region = [[AMapLocationPolygonRegion alloc]initWithCoordinates:[MapManager coordinatesFromPointsArray:self.model.points] count:self.model.points.count identifier:identifier];
            NSMutableArray *points = [NSMutableArray arrayWithArray:self.model.points];
            [points addObject:self.model.points.firstObject];
            self.line = [[MapPolyLineObject alloc]initWithPoints:points identifier:identifier];
            [self.drawLine addLine:self.line];
        }
    }
    return self;
}

- (void)dealloc
{
    [self.drawLine clear];
}

- (void)mapFenceMonitorStatusChanged:(MapFenceAMapViewModel *)fence newStatus:(MapFenceStatus)newStatus oldStatus:(MapFenceStatus)oldStatus
{
    if([self.delegate respondsToSelector:@selector(mapFenceMonitorStatusChanged:newStatus:oldStatus:)])
    {
        [self.delegate mapFenceMonitorStatusChanged:self newStatus:newStatus oldStatus:oldStatus];
    }
}

- (void)showFenceInMapCenter
{
    if(self.polyline)
    {
        [[MapManager sharedManager].mapView showOverlays:self.line.polylines animated:NO];
    }
}


- (void)setStatus:(MapFenceStatus)status
{
    MapFenceStatus oldStatus = _status;
    _status = status;
    if(status != oldStatus)
    {
        [self mapFenceMonitorStatusChanged:self newStatus:status oldStatus:oldStatus];
    }
}

- (void)updateMonitorLocation:(NSValue *)coordinate
{
    
    if(self.region == nil||!coordinate)
    {
        self.status = MapFenceStatusUnknown;
        return;
    }
    CGPoint point = coordinate.CGPointValue;
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(point.y, point.x);
    BOOL contain = [self.region containsCoordinate:coordinate2D];
    self.status = contain;
}


- (void)setShowPolyline:(BOOL)showPolyline
{
    if(_showPolyline == showPolyline)
    {
        return;
    }
    _showPolyline = showPolyline;
    if(showPolyline)
    {
        [self.drawLine addLine:self.line];
    }
    else
    {
        [self.drawLine removeLine:self.line];
    }
}

@end
