//
//  MapDrawPoint.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapAnnotation.h"
#import "MapAnnotationView.h"

@interface MapDrawPoint : NSObject

@property (readonly, nonatomic) NSMutableArray <MapAnnotation *> *annotations;

@property (assign, nonatomic) BOOL showAnnotations;

- (void)addMapAnnotations:(NSArray <MapAnnotation *> *)annotations;

- (void)addMapAnnotation:(MapAnnotation *)annotation;

- (void)removeMapAnnotations:(NSArray <MapAnnotation *> *)annotations;

- (void)removeMapAnnotation:(MapAnnotation *)annotation;

- (void)showInMapCenter;

- (void)clear;

@end
