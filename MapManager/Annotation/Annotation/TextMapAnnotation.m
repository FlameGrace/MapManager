//
//  TextMapAnnotation.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "TextMapAnnotation.h"
#import "TextMapAnnotationView.h"

@implementation TextMapAnnotation

@synthesize viewClass = _viewClass;

- (Class)viewClass
{
    if(!_viewClass)
    {
        _viewClass = [TextMapAnnotationView class];
    }
    return _viewClass;
}

- (void)setViewClass:(Class)viewClass
{
    if([viewClass isSubclassOfClass:[TextMapAnnotationView class]])
    {
        _viewClass = viewClass;
    }
    else
    {
        _viewClass = [TextMapAnnotationView class];
    }
}
- (TextMapAnnotationView *)dequeueReusableAnnotationView
{
    TextMapAnnotationView *annotationView = (TextMapAnnotationView *)[super dequeueReusableAnnotationView];
    annotationView.backgroundColor = [UIColor clearColor];
    annotationView.fillColor = self.backGroundColor;
    annotationView.textLabel.text = self.text;
    return annotationView;
}

@end
