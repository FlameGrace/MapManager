//
//  MapPolyLineObject.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapPolyLineObject.h"

@interface MapPolyLineObject()

@property (readwrite, strong, nonatomic) NSArray <MAPolyline *> *polylines;
@property (readwrite, strong, nonatomic) NSArray <NSValue *> *points;
@property (readwrite, strong, nonatomic) NSString *identifier;


@end

@implementation MapPolyLineObject

@synthesize viewClass = _viewClass;

-(Class)viewClass
{
    if(_viewClass)
    {
        return _viewClass;
    }
    return [MapPolylineView class];
}

- (void)setViewClass:(Class)viewClass
{
    
    if(viewClass &&[viewClass isSubclassOfClass:[MapPolylineView class]])
    {
        _viewClass = viewClass;
        return;
    }
    _viewClass = nil;
}

- (instancetype)initWithPoints:(NSArray <NSValue *> *)points identifier:(NSString *)identifier
{
    if(self = [super init])
    {
        self.identifier = identifier;
        self.points = points;
        MAPolyline *polyline = [MapManager polylineForPoints:points];
        [[MapManager sharedManager].mapView addOverlay:polyline];
        self.polylines = @[polyline];
        
    }
    return self;
}

- (instancetype)initWithPolylines:(NSArray<MAPolyline *>*)polylines identifier:(NSString *)identifier
{
    if(self = [super init])
    {
        self.identifier = identifier;
        self.polylines = polylines;
    }
    return self;
}

@end
