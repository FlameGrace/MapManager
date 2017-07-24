//
//  MapSearchInputTip.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearchInputTips.h"
#import "MapSearch.h"

@interface MapSearchInputTips()

@property (strong, nonatomic) MapSearch *search;

@end

@implementation MapSearchInputTips


- (instancetype)init
{
    if(self = [super init])
    {
        self.search = [[MapSearch alloc]init];
    }
    return self;
}


- (void)mapSearchInputTips:(MapSearchInputTips *)search didFailToError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(mapSearchInputTips:didFailToError:)])
    {
        [self.delegate mapSearchInputTips:search didFailToError:error];
    }
}

- (void)mapSearchInputTips:(MapSearchInputTips *)search result:(NSArray <MapSearchInputTipModel *> *)result
{
    if([self.delegate respondsToSelector:@selector(mapSearchInputTips:result:)])
    {
        [self.delegate mapSearchInputTips:search result:result];
    }
}



- (void)onInputTipsSearchResponse:(AMapInputTipsSearchResponse *)response
{
    if(response.count < 1)
    {
        [self mapSearchInputTips:self result:nil];
        return;
    }
    NSMutableArray *tips = [NSMutableArray array];
    for (AMapTip *tip in response.tips) {
        MapSearchInputTipModel *model = [MapSearchInputTipModel model];
        if(!tip.uid||(tip.uid&&tip.uid.length<1))
        {
            model.keyword = self.keyword;
            model.tipKeyword = self.keyword;
            model.inputType = MapSearchInputKeyword;
        }
        else
        {
            if(!tip.address || tip.address.length<1 || !tip.location || !tip.name || tip.name.length < 1)
            {
                continue;
            }
            model.keyword = self.keyword;
            model.inputType = MapSearchInputLocation;
            model.poiUid = tip.uid;
            model.name = tip.name;
            model.address = tip.address;
            model.location = [NSString stringWithFormat:@"%f,%f",tip.location.longitude,tip.location.latitude];
        }
        [tips addObject:model];
    }
    [self mapSearchInputTips:self result:tips];
}


- (void)startSearch
{
    WeakObj(self)
    [self.search searchInputTips:self.keyword city:self.city cityLimit:self.cityLimit types:self.types location:self.location callback:^(MapSearchObject *search, BOOL isNewest)
    {
        if(!isNewest)
        {
            return ;
        }
        StrongObj(self)
        if(search.error)
        {
            [self mapSearchInputTips:self didFailToError:search.error];
        }
        else
        {
            [self onInputTipsSearchResponse:(AMapInputTipsSearchResponse *)search.response];
        }
    }];
    
}

@end
