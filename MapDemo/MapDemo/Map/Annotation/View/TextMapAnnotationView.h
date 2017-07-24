//
//  TextMapAnnotationView.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapAnnotationView.h"
#import "AngleLabel.h"
#import "TextMapAnnotation.h"

@interface TextMapAnnotationView : MapAnnotationView

@property (strong, nonatomic) UILabel *textLabel;

@property (strong, nonatomic) UIColor *fillColor;

@property (strong, nonatomic) TextMapAnnotation *annotation;

@end
