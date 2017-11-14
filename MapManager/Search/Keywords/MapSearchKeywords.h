//
//  MapSearchKeywords.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/4/20.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//  先使用周边搜索，周边搜索无结果再使用关键字搜索
//  关键字搜索地点: 先使用当前城市搜索，当前城市搜索无结果，会进行全国搜索，全国搜索的结果如果有建议搜索城市的返回搜素列表

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MapSearchKeywordsReturnType)
{
    MapSearchKeywordsReturnAround = 0,  //返回周边的搜索结果,默认先进行周边搜索
    MapSearchKeywordsReturnLocalCity,  //返回在本地城市下的搜索结果
    MapSearchKeywordsReturnLocalCountry, //返回在全国下的搜索结果
    MapSearchKeywordsReturnSuggestCitys,  //全国下搜索无结果，但是有建议搜索的城市，可以在这些城市中搜索到结果
};

@class MapSearchKeywords;

@protocol MapSearchKeywordsDelegate <NSObject>

- (void)mapSearchKeywords:(MapSearchKeywords *)search result:(NSArray *)result returnType:(MapSearchKeywordsReturnType)type;

- (void)mapSearchKeywords:(MapSearchKeywords *)search didFailToError:(NSError *)error;

@end


@interface MapSearchKeywords : NSObject <MapSearchKeywordsDelegate>

@property (weak, nonatomic) id<MapSearchKeywordsDelegate> delegate;

@property (copy, nonatomic) NSString *keywords;

@property (assign, nonatomic) CLLocationCoordinate2D center;

@property (copy, nonatomic) NSString *city;

@property (assign, nonatomic) BOOL *cityLimit;

@property (copy, nonatomic) NSString *types;

@property (assign, nonatomic) NSInteger count;
///当前页数, 范围1-100, [default = 1]
@property (assign, nonatomic) NSInteger page;
///每页记录数, 范围1-50, [default = 20]
@property (assign, nonatomic) NSInteger offset;

- (void)startCurrentPageSearch;

- (void)restartSearch:(NSString *)keyword city:(NSString *)city;


@end
