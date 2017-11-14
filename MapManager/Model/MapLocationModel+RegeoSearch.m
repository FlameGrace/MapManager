//
//  MapLocationModel+RegeoSearch.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/4.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapLocationModel+RegeoSearch.h"
#import "MapSearch.h"


@implementation MapLocationModel (RegeoSearch)

static MapSearch *regeoSearch = nil;

- (void)searchRegeoWithCallback:(MapLocationSearchRegeocallback)callback
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regeoSearch = [[MapSearch alloc]init];
    });
    
    [regeoSearch searchRegeocodeForLocation:self.coordinate2D radius:100 requireExtension:NO callback:^(MapSearchObject *search, BOOL isNewest) {
        if(!search.error)
        {
            AMapReGeocodeSearchResponse *response = (AMapReGeocodeSearchResponse *)search.response;
            [MapManager updateMapLocation:self byReGeocode:response.regeocode];
            callback(nil);
            return ;
        }
        callback(search.error);
    }];
}

@end
