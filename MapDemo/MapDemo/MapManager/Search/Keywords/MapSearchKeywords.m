//
//  MapSearchKeywords.m
//  leapmotor
//
//  Created by 李嘉军 on 2017/4/20.
//  Copyright © 2017年 Leapmotor. All rights reserved.
//

#import "MapSearchKeywords.h"
#import "MapSearch.h"

@interface MapSearchKeywords()

@property (strong, nonatomic) MapSearch *search;
@property (assign, nonatomic) MapSearchKeywordsReturnType returnType;

@end

@implementation MapSearchKeywords

- (instancetype)init
{
    if(self = [super init])
    {
        self.search = [[MapSearch alloc]init];
        self.offset = 10;
        self.page = 1;
    }
    return self;
}


- (void)setPage:(NSInteger)page
{
    if(page <1)
    {
        page = 1;
    }
    _page = page;
}

- (void)setOffset:(NSInteger)offset
{
    if(offset <1)
    {
        offset = 20;
    }
    _offset = offset;
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search didFailToError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(mapSearchKeywords:didFailToError:)])
    {
        [self.delegate mapSearchKeywords:search didFailToError:error];
    }
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search result:(NSArray *)result returnType:(MapSearchKeywordsReturnType)type
{
    if([self.delegate respondsToSelector:@selector(mapSearchKeywords:result:returnType:)])
    {
        [self.delegate mapSearchKeywords:search result:result returnType:type];
    }
}


- (void)onPOISearchResponse:(AMapPOISearchResponse *)response
{
    self.count = response.count;
    if(self.returnType == MapSearchKeywordsReturnAround)
    {
        /*策略：当使用关键字搜索的总数大于使用周边的总数的3倍，即采用关键字搜索的结果
         测试示例1：天安门，只用周边有结果但是是杭州的地点
         测试示例2：北京火车站，只用周边有结果但是是杭州的地点
        */
        if(response.count > 0 || (response.count ==0 && self.city.length<1))
        {
            [self.search searchKeywords:self.keywords city:self.city cityLimit:NO offset:self.offset currentPage:self.page types:nil callback:^(MapSearchObject *search, BOOL isNewest) {
                
                if(!search.error)
                {
                    AMapPOISearchResponse *res = (AMapPOISearchResponse *)(search.response);
                    if(res.count>0&&response.count>0&&res.count>=response.count*3)
                    {
                        self.returnType = MapSearchKeywordsReturnLocalCity;
                        [self onPOISearchResponse:(AMapPOISearchResponse *)search.response];
                        return ;
                    }
                }
                [self mapSearchKeywords:self result:response.pois returnType:self.returnType];
                return;
            }];
            return;
        }
        self.returnType = MapSearchKeywordsReturnLocalCity;
        [self startSearchInLocalCity];
        return;
    }
    if(self.returnType == MapSearchKeywordsReturnLocalCity)
    {
        if(response.count > 0 || (response.count ==0 && self.city.length<1))
        {
            [self mapSearchKeywords:self result:response.pois returnType:self.returnType];
            return;
        }
        self.returnType = MapSearchKeywordsReturnLocalCountry;
        [self startSearchInCountry];
        return;
    }
    if(self.returnType == MapSearchKeywordsReturnLocalCountry)
    {
        self.count = response.count;
        if(response.suggestion&&response.suggestion.cities.count && response.count <1)
        {
            self.returnType = MapSearchKeywordsReturnSuggestCitys;
            [self mapSearchKeywords:self result:response.suggestion.cities returnType:self.returnType];
            return;
        }
        
        [self mapSearchKeywords:self result:response.pois returnType:self.returnType];
        return;
    }
}

- (void)restartSearch:(NSString *)keyword city:(NSString *)city
{
    self.keywords = keyword;
    self.page = 1;
    self.city = city;
    [self startCurrentPageSearch];
}


- (void)startCurrentPageSearch
{
    self.returnType = MapSearchKeywordsReturnAround;
    WeakObj(self)
    [self.search searchAroundByLocation:self.center keyWords:self.keywords radius:30000 sortrule:1 types:nil offset:self.offset currentPage:self.page callback:^(MapSearchObject *search, BOOL isNewest) {
        StrongObj(self)
        
        if(search.error)
        {
            [self mapSearchKeywords:self didFailToError:search.error];
        }
        else
        {
            [self onPOISearchResponse:(AMapPOISearchResponse *)search.response];
        }
    }];
}


- (void)startSearchInLocalCity
{
    self.returnType = MapSearchKeywordsReturnLocalCity;
    WeakObj(self)
    [self.search searchKeywords:self.keywords city:self.city cityLimit:NO offset:self.offset currentPage:self.page types:nil callback:^(MapSearchObject *search, BOOL isNewest) {
        StrongObj(self)
        if(search.error)
        {
            [self mapSearchKeywords:self didFailToError:search.error];
        }
        else
        {
            [self onPOISearchResponse:(AMapPOISearchResponse *)search.response];
        }
    }];
}

- (void)startSearchInCountry
{
    WeakObj(self)
    [self.search searchKeywords:self.keywords city:nil cityLimit:NO offset:self.offset currentPage:0 types:nil callback:^(MapSearchObject *search, BOOL isNewest) {
        StrongObj(self)
        if(search.error)
        {
            [self mapSearchKeywords:self didFailToError:search.error];
        }
        else
        {
            [self onPOISearchResponse:(AMapPOISearchResponse *)search.response];
        }
    }];
}



@end
