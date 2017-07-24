//
//  MapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapAnnotation.h"
#import "MapAnnotationView.h"

@implementation MapAnnotation

@synthesize viewClass = _viewClass;

- (void)select:(BOOL)animated
{
    [[MapManager sharedManager].mapView selectAnnotation:self animated:animated];
}

- (void)deselect:(BOOL)animated
{
    [[MapManager sharedManager].mapView deselectAnnotation:self animated:animated];
}

- (void)updateAnnotationViewSelected
{
    if(self.setSelect)
    {
        [self select:NO];
        return;
    }
    [self deselect:NO];
}

- (Class)viewClass
{
    if(!_viewClass)
    {
        _viewClass = [MapAnnotationView class];
    }
    return _viewClass;
}

- (void)setViewClass:(Class)viewClass
{
    if([viewClass isSubclassOfClass:[MapAnnotationView class]])
    {
        _viewClass = viewClass;
    }
    else
    {
        _viewClass = [MapAnnotationView class];
    }
}

- (void)setSetSelect:(BOOL)setSelect
{
    if(_setSelect == setSelect && self.viewSelected == _setSelect)
    {
        return;
    }
    _setSelect = setSelect;
    [self updateAnnotationViewSelected];
}


- (MapAnnotationView *)annotationView
{
    MapAnnotationView *view = (MapAnnotationView *)[[MapManager sharedManager].mapView viewForAnnotation:self];
    return view;
}

- (MapAnnotationView *)dequeueReusableAnnotationView
{
    MapAnnotationView *annotationView = (MapAnnotationView *)[[MapManager sharedManager].mapView dequeueReusableAnnotationViewWithIdentifier:self.identifier];
    if(!annotationView)
    {
        annotationView = [[self.viewClass alloc]initWithAnnotation:self reuseIdentifier:self.identifier];
    }
    annotationView.canShowCallout = self.canShowCallout;
    [annotationView updateUIByIsSelected];
//    //主要为了防止由于地图复用导致的大头针被移除后重新添加,因此在被添加后再更新一下视图，一般情况下被选择的大头针好像不会出现被复用的情况
//    __weak typeof(self) weakSelf = self;
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.01*NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        __strong typeof(weakSelf) self = weakSelf;
//        self.setSelect = self.viewSelected;
//    });
    return annotationView;
}


+ (MapAnnotation *)annotationByPoint:(NSValue *)value annotationClass:(Class)annotationClass
{
    if(!annotationClass || (annotationClass && ![annotationClass isSubclassOfClass:[MapAnnotation class]]))
    {
        annotationClass = [MapAnnotation class];
    }
    
    CGPoint point = value.CGPointValue;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(point.y, point.x);
    MapAnnotation *annotation = [[annotationClass alloc]init];
    annotation.coordinate = coordinate;
    return annotation;
}
@end
