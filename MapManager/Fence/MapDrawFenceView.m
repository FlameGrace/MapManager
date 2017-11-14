//
//  MapFenceView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/5/19.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDrawFenceView.h"
#import "MapManagerHeader.h"
#import "MapSearch.h"
#import "MapDrawLine.h"

@interface MapDrawFenceView() <UIGestureRecognizerDelegate,MapDrawFenceViewDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *drawGesture;
@property (strong, nonatomic) UIPinchGestureRecognizer *zoomGesture;
@property (assign, nonatomic) BOOL isDrawing;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) MapSearch *search;
@property (strong, nonatomic) MapDrawLine *drawLine;
@property (strong, nonatomic) MapPolyLineObject *tempLine;

@end

@implementation MapDrawFenceView

- (id)init
{
    if(self = [super init])
    {
        [self start];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self start];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [MapManager sharedManager].mapView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)start
{
    [[MapManager sharedManager] addMapViewToView:self];
    self.search = [[MapSearch alloc]init];
    self.drawLine = [[MapDrawLine alloc]init];
    self.drawGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleDrawGesture:)];
    [self addGestureRecognizer:self.drawGesture];
    self.drawGesture.delegate = self;
    self.zoomGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinchGesture:)];
    [self addGestureRecognizer:self.zoomGesture];
    self.zoomGesture.delegate = self;
    
    
}

- (void)showInMapCenter
{
    if(self.drawLine.lines.count > 0)
    {
        MapPolyLineObject *line = [self.drawLine.lines firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MapManager sharedManager].mapView showOverlays:line.polylines animated:NO];
        });
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return YES;
}


- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        self.drawGesture.enabled = NO;
    }
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        self.drawGesture.enabled = YES;
    }
}

- (void)handleDrawGesture:(UIPanGestureRecognizer *)sender
{
    if(!self.isDrawing)
    {
        return;
    }
    CGPoint point = [sender locationInView:self];
    CLLocationCoordinate2D coordinate = [[MapManager sharedManager].mapView convertPoint:point toCoordinateFromView:self];
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(coordinate.longitude, coordinate.latitude)];
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        [self removeMapFence];
        self.tempLine = [[MapPolyLineObject alloc]initWithPoints:@[value] identifier:@"fence"];
    }
    if(sender.state == UIGestureRecognizerStateChanged)
    {
        [self.drawLine clear];
        NSMutableArray *points = [NSMutableArray arrayWithArray:self.tempLine.points];
        [points addObject:value];
        MapPolyLineObject *tempLine = [[MapPolyLineObject alloc]initWithPoints:points identifier:@"fence"];
        [self.drawLine addLine:tempLine];
        self.tempLine = tempLine;
    }
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [self stopDrawing];
        [self.drawLine clear];
        NSMutableArray *points = [NSMutableArray arrayWithArray:self.tempLine.points];
        [points addObject:value];
        [points addObject:[points firstObject]];
        MapPolyLineObject *tempLine = [[MapPolyLineObject alloc]initWithPoints:points identifier:@"fence"];
        [self.drawLine addLine:tempLine];
        self.tempLine = tempLine;
        MapFenceModel *model = [[MapFenceModel alloc]init];
        model.points = [NSArray arrayWithArray:points];
        MapFenceAMapViewModel *fence = [[MapFenceAMapViewModel alloc]initWithModel:model];
        [self mapFenceView:self drawAnNewFence:fence];
    }
}

- (void)mapFenceView:(MapDrawFenceView *)fenceView drawAnNewFence:(MapFenceAMapViewModel *)fence
{
    if([self.delegate respondsToSelector:@selector(mapFenceView:drawAnNewFence:)])
    {
        [self.delegate mapFenceView:fenceView drawAnNewFence:fence];
    }
}

- (void)mapFenceViewDrawDistrict:(MapDrawFenceView *)fenceView failToError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(mapFenceViewDrawDistrict:failToError:)])
    {
        [self.delegate mapFenceViewDrawDistrict:fenceView failToError:error];
    }
}


- (void)clean
{
    [self stopDrawing];
    [self removeMapFence];
}

- (void)draw
{
    [MapManager sharedManager].mapView.scrollEnabled = NO;
    self.isDrawing = YES;
}

- (void)drawDistrict:(NSString *)district
{
    [self clean];
    self.district = district;
    Map_WeakObj(self)
    [self.search searchDistrictForKeywords:district regionPoints:YES callback:^(MapSearchObject *search, BOOL isNewest) {
        //不是最新一次的请求则不响应
        if(!isNewest)
        {
            return ;
        }
        Map_StrongObj(self)
        if(search.error)
        {
            [self mapFenceViewDrawDistrict:self failToError:search.error];
        }
        else
        {
            [self onDistrictSearchDoneResponse:(AMapDistrictSearchResponse *)search.response];
        }
    }];
}


- (void)stopDrawing
{
    self.isDrawing = NO;
    [MapManager sharedManager].mapView.scrollEnabled = YES;
}

- (BOOL)isDrawing
{
    return _isDrawing;
}


- (void)onDistrictSearchDoneResponse:(AMapDistrictSearchResponse *)response
{
    if(response.count < 1)
    {
        [self mapFenceViewDrawDistrict:[self.district copy] failToError:nil];
        return;
    }
    if(response.count < 1)
    {
        [self mapFenceViewDrawDistrict:[self.district copy] failToError:nil];
        return;
    }
    NSString *pointPolys = @"";
    AMapDistrict *dis = [response.districts firstObject];
    for (NSString *poly in dis.polylines) {
        pointPolys = [pointPolys stringByAppendingString:[NSString stringWithFormat:@"%@;",poly]];
    }
    NSUInteger count = 0;
    CLLocationCoordinate2D *coordinates = [MapManager coordinatesForString:pointPolys coordinateCount:&count parseToken:@";"];
    NSMutableArray *points = [NSMutableArray arrayWithArray:[MapManager pointsArrayFromCoordinates:coordinates count:count]];
    coordinates[count] = coordinates[0];
    [points addObject:points.firstObject];
    MapPolyLineObject *tempLine = [[MapPolyLineObject alloc]initWithPoints:points identifier:@"fence"];
    [self.drawLine addLine:tempLine];
    self.tempLine = tempLine;
    MapFenceModel *model = [[MapFenceModel alloc]init];
    model.district = [self.district copy];
    model.points = [NSArray arrayWithArray:points];
    MapFenceAMapViewModel *fence = [[MapFenceAMapViewModel alloc]initWithModel:model];
    [self mapFenceView:self drawAnNewFence:fence];
    
}


- (void)removeMapFence
{
    [self.drawLine clear];
    self.district = nil;
}

- (void)dealloc
{
    [self clean];
}


@end
