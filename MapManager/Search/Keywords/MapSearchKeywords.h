//
//  MapSearchKeywords.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/4/20.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//  使用关键字搜索地点，先使用当前城市搜索，当前城市搜索无结果，会进行全国搜索，全国搜索的结果如果有建议搜索城市的返回搜素列表

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MapSearchKeywordsReturnType)
{
    MapSearchKeywordsReturnLocalCity = 0,  //返回在本地城市下的搜索结果
    MapSearchKeywordsReturnLocalCountry = 1, //返回在全国下的搜索结果
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

@property (copy, nonatomic) NSString *city;

@property (assign, nonatomic) BOOL *cityLimit;

@property (copy, nonatomic) NSString *types;

@property (assign, nonatomic) NSInteger count;
///当前页数, 范围1-100, [default = 1]
@property (assign, nonatomic) NSInteger page;
///每页记录数, 范围1-50, [default = 20]
@property (assign, nonatomic) NSInteger offset;

- (void)startSearch;


@end
