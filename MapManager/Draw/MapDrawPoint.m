//
//  MapDrawPoint.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDrawPoint.h"

@interface MapDrawPoint() <MAMapViewDelegate>

@property (readwrite,strong, nonatomic) NSMutableArray <MapAnnotation *> *annotations;

@end

@implementation MapDrawPoint

- (instancetype)init
{
    if(self = [super init])
    {
        [[MapManager sharedManager]addMultiDelegate:self];
        self.showAnnotations = YES;
    }
    return self;
}

- (void)setShowAnnotations:(BOOL)showAnnotations
{
    if(_showAnnotations == showAnnotations)
    {
        return;
    }
    _showAnnotations = showAnnotations;
    if(self.annotations.count < 1)
    {
        return;
    }
    if(_showAnnotations)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MapManager sharedManager].mapView addAnnotations:self.annotations];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MapManager sharedManager].mapView removeAnnotations:self.annotations];
        });
    }
    
}

- (void)addMapAnnotations:(NSArray <MapAnnotation *> *)annotations
{
    if(!annotations || annotations.count < 1)
    {
        return;
    }
    
    @synchronized (self) {
        NSMutableArray *copy = [NSMutableArray arrayWithArray:self.annotations];
        NSMutableArray *newArray = [NSMutableArray array];
        for (MapAnnotation *an in annotations) {
            if(![copy containsObject:an])
            {
                [newArray addObject:an];
            }
        }
        if(newArray.count < 1)
        {
            return;
        }
        [self.annotations addObjectsFromArray:newArray];
        
        if(self.showAnnotations)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[MapManager sharedManager].mapView addAnnotations:newArray];
            });
        }
    }
    
}

- (void)addMapAnnotation:(MapAnnotation *)annotation
{
    if(!annotation)return;
    [self addMapAnnotations:@[annotation]];
}

- (void)removeMapAnnotations:(NSArray <MapAnnotation *> *)annotations
{
    if(!annotations || annotations.count < 1)
    {
        return;
    }
    [self.annotations removeObjectsInArray:annotations];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager].mapView removeAnnotations:annotations];
    });
}

- (void)removeMapAnnotation:(MapAnnotation *)annotation
{
    if(!annotation)return;
    [self removeMapAnnotations:@[annotation]];
}

- (void)showInMapCenter
{
    if(self.annotations&&self.showAnnotations)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MapManager sharedManager].mapView showAnnotations:self.annotations animated:NO];
        });
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if(![self.annotations containsObject:annotation])
    {
        return nil;
    }
    
    MapAnnotation *an = annotation;
    MapAnnotationView *annotationView = [an dequeueReusableAnnotationView];
    
    return annotationView;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    MapAnnotation *annotation = view.annotation;
    if(![self.annotations containsObject:annotation])
    {
        return;
    }
    BOOL byUser = NO;
    if(annotation.setSelect == NO)
    {
        byUser = YES;
    }
    if(annotation.didSelectBlock)
    {
        annotation.didSelectBlock(byUser);
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    MapAnnotation *annotation = view.annotation;
    if(![self.annotations containsObject:annotation])
    {
        return;
    }
    if(annotation.deSelectBlock)
    {
        annotation.deSelectBlock();
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MapManager sharedManager] refreshMapView];
    });
    for (MAAnnotationView *view in views) {
        MapAnnotation *annotation = view.annotation;
        if([self.annotations containsObject:annotation])
        {
            if(annotation.didAddBlock)
            {
                annotation.didAddBlock();
            }
        }
    }
}


- (void)clear
{
    NSArray *annotations = [NSArray arrayWithArray:self.annotations];
    [self removeMapAnnotations:annotations];
    [self.annotations removeAllObjects];
    
}

- (void)dealloc
{
    [self clear];
    [[MapManager sharedManager]removeMultiDelegate:self];
}

- (NSMutableArray<MapAnnotation *> *)annotations
{
    if(!_annotations)
    {
        _annotations = [[NSMutableArray alloc]init];
    }
    return _annotations;
}

@end
