//
//  MapSearchKeywords_MapView.h
//  leapmotor
//
//  Created by 李嘉军 on 2017/4/20.
//  Copyright © 2017年 Leapmotor. All rights reserved.
// 使用关键字搜索地点，并根据搜索结果直接在地图上显示大头针,每次搜索，以前的大头针清空

#import <Foundation/Foundation.h>
#import "MapSearchKeywords.h"
#import "SearchMapLocation.h"


@class MapSearchKeywords_MapView;

@protocol MapSearchKeywords_MapViewDelegate <MapSearchKeywordsDelegate>

-(void)mapSearchKeywords:(MapSearchKeywords *)search result:(NSArray *)result returnType:(MapSearchKeywordsReturnType)type;

- (void)mapSearchKeywords:(MapSearchKeywords *)search didSelectMapLocation:(SearchMapLocation *)mapLocation byUser:(BOOL)byUser;

- (void)mapSearchKeywords:(MapSearchKeywords *)search deselectMapLocation:(SearchMapLocation *)mapLocation;

@end

@interface MapSearchKeywords_MapView : MapSearchKeywords<MapSearchKeywords_MapViewDelegate>

@property (readonly,nonatomic)  NSMutableArray *results;
@property (readonly, nonatomic) NSMutableArray *annotations;

@property (assign,nonatomic)  BOOL showAnnotaions;

@property (weak, nonatomic) id <MapSearchKeywords_MapViewDelegate> delegate;

- (void)showInMapCenter;

- (void)clear;

@end
