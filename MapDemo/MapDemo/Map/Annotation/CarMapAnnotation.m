//
//  CarMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "CarMapAnnotation.h"
#import "CarMapAnnotationView.h"

@implementation CarMapAnnotation

@synthesize viewClass = _viewClass;

- (Class)viewClass
{
    if(!_viewClass)
    {
        _viewClass = [CarMapAnnotationView class];
    }
    return _viewClass;
}

- (void)setViewClass:(Class)viewClass
{
    if([viewClass isSubclassOfClass:[CarMapAnnotationView class]])
    {
        _viewClass = viewClass;
    }
    else
    {
        _viewClass = [CarMapAnnotationView class];
    }
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.canShowCallout = NO;
        self.image = [UIImage imageNamed:@"car"];
        self.size = CGSizeMake(80, 90);
        self.viewClass = [CarMapAnnotationView class];
        self.supportRolation = NO;
        self.centerOffset = CGPointMake(0, -40);
    }
    return self;
}

- (CarMapAnnotationView *)dequeueReusableAnnotationView
{
    CarMapAnnotationView *annotationView = (CarMapAnnotationView *)[super dequeueReusableAnnotationView];
    annotationView.supportRolation = self.supportRolation;
    return annotationView;
}

@end
