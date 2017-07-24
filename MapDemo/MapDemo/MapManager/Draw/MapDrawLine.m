//
//  MapMapDrawRouteView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/22.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDrawLine.h"


@interface MapDrawLine()<MAMapViewDelegate>

@property (readwrite, strong, nonatomic) NSMutableArray <MapPolyLineObject *> *lines;


@end

@implementation MapDrawLine

- (id)init
{
    if(self = [super init])
    {
        self.lines = [[NSMutableArray alloc]init];
        [[MapManager sharedManager]addMultiDelegate:self];
    }
    return self;
}

- (void)updateLine:(MapPolyLineObject *)line
{
    if(!line.polylines)
    {
        return;
    }
    if(![self.lines containsObject:line])
    {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager].mapView removeOverlays:line.polylines];
        [[MapManager sharedManager].mapView addOverlays:line.polylines level:line.overlayLevel];
    });
}

- (void)showLineInMapCenter:(MapPolyLineObject *)line
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager].mapView showOverlays:line.polylines animated:YES];
    });
}

- (void)addLine:(MapPolyLineObject *)line
{
    if(!line.polylines)
    {
        return;
    }
    [self removeLine:line];
    [self.lines addObject:line];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager].mapView addOverlays:line.polylines level:line.overlayLevel];
    });
    
}

- (MapPolyLineObject *)selectLineByIdentifier:(NSString *)identifier
{
    if(!identifier || (identifier && identifier.length <1))
    {
        return nil;
    }
    
    NSArray *lines = [NSArray arrayWithArray:self.lines];
    
    __block MapPolyLineObject *selectLine = nil;
    
    [lines enumerateObjectsUsingBlock:^(MapPolyLineObject * line, NSUInteger idx, BOOL * _Nonnull stop) {
        if(line.identifier&&[line.identifier isEqualToString:identifier])
        {
            selectLine = line;
            *stop = YES;
        }
    }];
    return selectLine;
}

- (void)removeLineByIdentifier:(NSString *)identifier
{
    MapPolyLineObject *line = [self selectLineByIdentifier:identifier];
    [self removeLine:line];
}

- (void)removeLine:(MapPolyLineObject *)line
{
    if(!line.polylines)
    {
        return;
    }
    if(![self.lines containsObject:line])
    {
        return;
    }
    [self.lines removeObject:line];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager].mapView removeOverlays:line.polylines];
    });
}

- (void)clear
{
    NSArray *lines = [NSArray arrayWithArray:self.lines];
    for (MapPolyLineObject *line in lines) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MapManager sharedManager].mapView removeOverlays:line.polylines];
        });
    }
    [self.lines removeAllObjects];
}


- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    for (MapPolyLineObject *line in self.lines) {
        if([line.polylines containsObject:overlay])
        {
            MapPolylineView * polylineView = [[line.viewClass alloc]initWithPolyline:overlay];
            return polylineView;
        }
    }
    return nil;
}


- (void)dealloc
{
    [self clear];
}



@end
