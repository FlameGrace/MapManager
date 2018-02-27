
//
//  MovingAnnotationView.m
//  test
//
//  Created by yi chen on 14-9-3.
//  Copyright (c) 2014年 yi chen. All rights reserved.
//

#import "MovingAnnotationView.h"
#import "CACoordLayer.h"
#import "TracingPoint.h"


#define TurnAnimationDuration 0.1
#define RadToDeg 57.2957795130823228646477218717336654663086 //180.f / M_PI
#define DegToRad 0.0174532925199432954743716805978692718782 // M_PI / 180.f

#define MapXAnimationKey @"mapx"
#define MapYAnimationKey @"mapy"
#define RotationAnimationKey @"transform.rotation.z"

@interface MovingAnnotationView() <CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray * animationList;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate2D;

@property (strong, nonatomic) NSMutableArray *locationCache;

@end

@implementation MovingAnnotationView
{
    MAMapPoint currDestination;
    MAMapPoint lastDestination;
    
    CLLocationDirection lastDirection;
    
    BOOL isAnimatingX, isAnimatingY;
}

- (void)updateLocation:(CLLocationCoordinate2D)coordinate
{
    @synchronized (self) {
        CLLocationCoordinate2D lastCoordinate = self.coordinate2D;
        self.coordinate2D = coordinate;
        CGFloat distance = [MapManager getDistanceBetweenOrigin:lastCoordinate andDestination:coordinate];
        //如果两点距离已超过5公里，则不再使用动画
        if(distance >= 5000)
        {
            [self.locationCache removeAllObjects];
            self.annotation.coordinate = coordinate;
        }
        else
        {
            AMapGeoPoint *point = [MapManager transformCLLocationCoordinate2D:coordinate];
            [self.locationCache addObject:point];
            if(self.locationCache.count >= 2)
            {
                NSArray *points = [NSArray arrayWithArray:self.locationCache];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addTrackingAnimationForPoints:points duration:0.8];
                });
                [self.locationCache removeAllObjects];
                [self.locationCache addObject:point];
                return;
            }
        }
    }
}


#pragma mark - Animation
+ (Class)layerClass
{
    return [CACoordLayer class];
}

- (NSMutableArray *)trackPointWithPoints:(NSArray <AMapGeoPoint*> *)points
{
    NSMutableArray *tracking = [NSMutableArray array];
    for (int i = 0; i<points.count - 1; i++)
    {
        AMapGeoPoint *point = points[i];
        AMapGeoPoint *nextPoint = points[i+1];
        TracingPoint * tp = [TracingPoint point];
        tp.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
        tp.course = [MapManager calculateCourseFromCoordinate:tp.coordinate to:CLLocationCoordinate2DMake(nextPoint.latitude, nextPoint.longitude)];
        [tracking addObject:tp];
    }
    AMapGeoPoint *point = points[points.count - 1];
    TracingPoint * tp = [TracingPoint point];
    tp.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    tp.course = ((TracingPoint *)[tracking lastObject]).course;
    [tracking addObject:tp];
    return tracking;
    
}

- (void)addTrackingAnimationForPoints:(NSArray <AMapGeoPoint*> *)points duration:(CFTimeInterval)duration
{
    if (![points count])
    {
        return;
    }
    NSMutableArray *trackPoint = [self trackPointWithPoints:points];

    
    CACoordLayer * mylayer = ((CACoordLayer *)self.layer);
    //preparing
    NSUInteger num = 2*[trackPoint count] + 1;
    NSMutableArray * xvalues = [NSMutableArray arrayWithCapacity:num];
    NSMutableArray *yvalues = [NSMutableArray arrayWithCapacity:num];
    NSMutableArray *rvalues = [NSMutableArray arrayWithCapacity:num];
    
    NSMutableArray * times = [NSMutableArray arrayWithCapacity:num];
    NSMutableArray * rtimes = [NSMutableArray arrayWithCapacity:num];
    
    double sumOfDistance = 0.f;
    double * dis = malloc(([trackPoint count]) * sizeof(double));
    
    //the first point is set by the destination of last animation.
    MAMapPoint preLoc;
    CLLocationDirection preDir;
    if (!([self.animationList count] > 0 || isAnimatingX || isAnimatingY))
    {
        lastDestination = MAMapPointMake(mylayer.mapx, mylayer.mapy);
    }
    preLoc = lastDestination;
    
    MAMapPoint firstPoint = MAMapPointForCoordinate(((TracingPoint *)[trackPoint firstObject]).coordinate);
    double transitDir = [MapManager calculateCourseFroMAMapPoint:preLoc to:firstPoint];
    preDir = [MapManager fixNewDirection:transitDir basedOnOldDirection:lastDirection];
    
    [xvalues addObject:@(preLoc.x)];
    [yvalues addObject:@(preLoc.y)];
    [times addObject:@(0.f)];
    
    [rvalues addObject:@(preDir * DegToRad)];
    [rtimes addObject:@(0.f)];
    
    //set the animation points.
    for (int i = 0; i<[trackPoint count]; i++)
    {
        TracingPoint * tp = trackPoint[i];
        
        //position
        MAMapPoint p = MAMapPointForCoordinate(tp.coordinate);
        [xvalues addObjectsFromArray:@[@(p.x), @(p.x)]];//stop for turn
        [yvalues addObjectsFromArray:@[@(p.y), @(p.y)]];
        
        //angle
        double currDir = [MapManager fixNewDirection:tp.course basedOnOldDirection:preDir];
        [rvalues addObjectsFromArray:@[@(preDir * DegToRad), @(currDir * DegToRad)]];
        
        //distance
        dis[i] = MAMetersBetweenMapPoints(p, preLoc);
        sumOfDistance = sumOfDistance + dis[i];
        dis[i] = sumOfDistance;
        
        //record pre
        preLoc = p;
        preDir = currDir;
    }
    
    //set the animation times.
    double preTime = 0.f;
    double turnDuration = TurnAnimationDuration/duration;
    for (int i = 0; i<[trackPoint count]; i++)
    {
        double turnEnd = dis[i]/sumOfDistance;
        double turnStart = (preTime > turnEnd - turnDuration) ? (turnEnd + preTime) * 0.5 : turnEnd - turnDuration;
        
        [times addObjectsFromArray:@[@(turnStart), @(turnEnd)]];
        [rtimes addObjectsFromArray:@[@(turnStart), @(turnEnd)]];
        
        preTime = turnEnd;
    }
    
    //record the destination.
    TracingPoint * last = [trackPoint lastObject];
    lastDestination = MAMapPointForCoordinate(last.coordinate);
    lastDirection = last.course;
    
    free(dis);
    
    // add animation.
    CAKeyframeAnimation *xanimation = [CAKeyframeAnimation animationWithKeyPath:MapXAnimationKey];
    xanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    xanimation.values   = xvalues;
    xanimation.keyTimes = times;
    xanimation.duration = duration;
    xanimation.delegate = self;
    xanimation.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *yanimation = [CAKeyframeAnimation animationWithKeyPath:MapYAnimationKey];
    yanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    yanimation.values   = yvalues;
    yanimation.keyTimes = times;
    yanimation.duration = duration;
    yanimation.delegate = self;
    yanimation.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *ranimation = [CAKeyframeAnimation animationWithKeyPath:RotationAnimationKey];
    ranimation.values = rvalues;
    ranimation.keyTimes = rtimes;
    ranimation.duration = duration;
    ranimation.delegate = self;
    ranimation.fillMode = kCAFillModeForwards;
    
    [self pushBackAnimation:xanimation];
    [self pushBackAnimation:yanimation];
    if(self.supportRolation)
    {
        [self pushBackAnimation:ranimation];
    }
    mylayer.mapView = [self mapView];
    
}

- (void)replayLastState
{
    
}

- (void)pushBackAnimation:(CAPropertyAnimation *)anim
{
    [self.animationList addObject:anim];
    
    if ([self.layer animationForKey:anim.keyPath] == nil)
    {
        [self popFrontAnimationForKey:anim.keyPath];
    }
}

- (void)popFrontAnimationForKey:(NSString *)key
{
    [self.animationList enumerateObjectsUsingBlock:^(CAKeyframeAnimation * obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj.keyPath isEqualToString:key])
         {
             [self.layer addAnimation:obj forKey:obj.keyPath];
             [self.animationList removeObject:obj];
             
             if ([key isEqualToString:MapXAnimationKey])
             {
                 isAnimatingX = YES;
             }
             else if([key isEqualToString:MapYAnimationKey])
             {
                 isAnimatingY = YES;
             }
             else if([key isEqualToString:RotationAnimationKey])
             {
                 double endDir = ((NSNumber *)[obj.values lastObject]).doubleValue;
                 self.layer.transform = CATransform3DMakeRotation(endDir, 0, 0, 1);
                 //动画结束时状态不会恢复到起始状态。
             }
             *stop = YES;
         }
     }];
}



#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isKindOfClass:[CAKeyframeAnimation class]])
    {
        CAKeyframeAnimation * keyAnim = ((CAKeyframeAnimation *)anim);
        if ([keyAnim.keyPath isEqualToString:MapXAnimationKey])
        {
            isAnimatingX = NO;
            
            CACoordLayer * mylayer = ((CACoordLayer *)self.layer);
            mylayer.mapx = ((NSNumber *)[keyAnim.values lastObject]).doubleValue;
            currDestination.x = mylayer.mapx;
            
            [self updateAnnotationCoordinate];
            
            [self popFrontAnimationForKey:MapXAnimationKey];
        }
        else if ([keyAnim.keyPath isEqualToString:MapYAnimationKey])
        {
            isAnimatingY = NO;
            
            CACoordLayer * mylayer = ((CACoordLayer *)self.layer);
            mylayer.mapy = ((NSNumber *)[keyAnim.values lastObject]).doubleValue;
            currDestination.y = mylayer.mapy;
            [self updateAnnotationCoordinate];
            
            [self popFrontAnimationForKey:MapYAnimationKey];
        }
        else if([keyAnim.keyPath isEqualToString:RotationAnimationKey])
        {
            [self popFrontAnimationForKey:RotationAnimationKey];
        }
        
    }
}

- (void)updateAnnotationCoordinate
{
    if (! (isAnimatingX || isAnimatingY) )
    {
        self.annotation.coordinate = MACoordinateForMapPoint(currDestination);
    }
}

#pragma mark - Property

- (NSMutableArray *)animationList
{
    if (_animationList == nil)
    {
        _animationList = [NSMutableArray array];
    }
    return _animationList;
}

- (MAMapView *)mapView
{
    return (MAMapView*)(self.superview.superview);
}

#pragma mark - Override

- (void)setCenterOffset:(CGPoint)centerOffset
{
    CACoordLayer * mylayer = ((CACoordLayer *)self.layer);
    mylayer.centerOffset = centerOffset;
    [super setCenterOffset:centerOffset];
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.coordinate2D = annotation.coordinate;
        self.supportRolation = YES;
        CACoordLayer * mylayer = ((CACoordLayer *)self.layer);
        MAMapPoint mapPoint = MAMapPointForCoordinate(annotation.coordinate);
        mylayer.mapx = mapPoint.x;
        mylayer.mapy = mapPoint.y;
        mylayer.centerOffset = self.centerOffset;
        isAnimatingX = NO;
        isAnimatingY = NO;
        
    }
    return self;
}

- (NSMutableArray *)locationCache
{
    if(!_locationCache)
    {
        _locationCache = [[NSMutableArray alloc]init];
    }
    return _locationCache;
}

@end
