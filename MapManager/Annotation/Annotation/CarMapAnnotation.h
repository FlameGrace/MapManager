//
//  CarMapAnnotation.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace. All rights reserved.
//

#import "MapAnnotation.h"

@class CarMapAnnotationView; //此类大头针的viewClass已被限定为CarMapAnnotationView及其子类

@interface CarMapAnnotation : MapAnnotation

@property (assign, nonatomic) BOOL supportRolation;

@end
