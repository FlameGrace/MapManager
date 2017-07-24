//
//  MapSearchKeywords.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/4/20.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
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
    if(self.returnType == MapSearchKeywordsReturnLocalCity)
    {
        if(response.count > 0 || (response.count ==0 && self.city.length<1))
        {
            [self mapSearchKeywords:self result:response.pois returnType:self.returnType];
            return;
        }
        self.returnType = MapSearchKeywordsReturnLocalCountry;
        [self startSearchInContry];
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


- (void)startSearchInContry
{
    __weak typeof(self) weakSelf = self;
    [self.search searchKeywords:self.keywords city:nil cityLimit:NO offset:self.offset currentPage:1 types:nil callback:^(MapSearchObject *search, BOOL isNewest) {
        if(!isNewest)
        {
            return ;
        }
        __strong typeof(weakSelf) self = weakSelf;
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


- (void)startSearch
{
    self.returnType = MapSearchKeywordsReturnLocalCity;
    __weak typeof(self) weakSelf = self;
    [self.search searchKeywords:self.keywords city:self.city cityLimit:NO offset:self.offset currentPage:self.page types:nil callback:^(MapSearchObject *search, BOOL isNewest) {
        if(!isNewest)
        {
            return ;
        }
        __strong typeof(weakSelf) self = weakSelf;
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
