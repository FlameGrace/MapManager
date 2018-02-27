//
//  CarMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace. All rights reserved.
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
        self.image = [UIImage imageNamed:@"map_ic_carLocation80"];
        self.selectedImage = [UIImage imageNamed:@"map_ic_carLocation80_sel"];
        self.size = CGSizeMake(20, 40);
        self.viewClass = [CarMapAnnotationView class];
        self.supportRolation = YES;
        self.centerOffset = CGPointMake(0, 0);
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
