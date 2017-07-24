//
//  MapPolyLineObject.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapPolylineView.h"

@interface MapPolyLineObject : NSObject

@property (readonly, strong, nonatomic) NSArray <NSValue *> *points;
@property (readonly, strong, nonatomic) NSArray <MAPolyline *> *polylines;
@property (readonly, strong, nonatomic) NSString *identifier;
//定义线的外观，只需继承MapPolylineView类，在初始化方法赋相应的值即可，默认为MapPolylineView
@property (strong, nonatomic) Class viewClass;
@property (assign, nonatomic) MAOverlayLevel overlayLevel;


- (instancetype)initWithPoints:(NSArray <NSValue *> *)points identifier:(NSString *)identifier;

- (instancetype)initWithPolylines:(NSArray <MAPolyline *>*)polylines identifier:(NSString *)identifier;

@end
