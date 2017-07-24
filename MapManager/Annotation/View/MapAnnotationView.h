//
//  MapAnnotationView.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapAnnotation.h"
#import "MapAnnotationViewProtocol.h"

@interface MapAnnotationView : MAAnnotationView <MapAnnotationViewProtocol>

@property (strong, nonatomic) MapAnnotation *annotation;

@end
