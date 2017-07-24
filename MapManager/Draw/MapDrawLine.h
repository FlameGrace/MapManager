//
//  MapMapDrawRouteView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/22.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//  给定GPS点，在地图上画出路线

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MapManagerHeader.h"
#import "MapPolyLineObject.h"

@interface MapDrawLine : NSObject

@property (readonly, strong, nonatomic) NSMutableArray <MapPolyLineObject *> *lines;

- (void)addLine:(MapPolyLineObject *)line;

- (MapPolyLineObject *)selectLineByIdentifier:(NSString *)identifier;

- (void)removeLine:(MapPolyLineObject *)line;

- (void)removeLineByIdentifier:(NSString *)identifier;

- (void)updateLine:(MapPolyLineObject *)line;

- (void)showLineInMapCenter:(MapPolyLineObject *)line;

- (void)clear;

@end
