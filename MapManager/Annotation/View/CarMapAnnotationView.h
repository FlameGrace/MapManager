//
//  CarMapAnnotationView.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace. All rights reserved.
//

#import "MovingAnnotationView.h"
#import "CarMapAnnotation.h"

@interface CarMapAnnotationView : MovingAnnotationView

@property (strong, nonatomic) CarMapAnnotation *annotation;

@end
