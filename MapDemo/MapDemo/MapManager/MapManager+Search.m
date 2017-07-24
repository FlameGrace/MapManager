//
//  MapManager+Search.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapManager+Search.h"


@implementation MapManager (Search)


#pragma AMapSearchDelegate

/**
 * @brief 当请求发生错误时，会调用代理的此方法.
 * @param request 发生错误的请求.
 * @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(AMapSearchRequest:didFailWithError:)])
        {
            [delegate AMapSearchRequest:request didFailWithError:error];
        }
    }];
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onPOISearchDone:response:)])
        {
            [delegate onPOISearchDone:request response:response];
        }
    }];
    
}

/**
 * @brief 沿途查询回调函数 (since v4.3.0)
 * @param request  发起的请求，具体字段参考 MapRoutePOISearchRequest 及其子类。
 * @param response 响应结果，具体字段参考 MapRoutePOISearchResponse 。
 */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onRouteSearchDone:response:)])
        {
            [delegate onRouteSearchDone:request response:response];
        }
    }];
}

/**
 * @brief 地理编码查询回调函数
 * @param request  发起的请求，具体字段参考 MapGeocodeSearchRequest 。
 * @param response 响应结果，具体字段参考 MapGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onReGeocodeSearchDone:response:)])
        {
            [delegate onReGeocodeSearchDone:request response:response];
        }
    }];
}


/**
 * @brief 输入提示查询回调函数
 * @param request  发起的请求，具体字段参考 AMapInputTipsSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapInputTipsSearchResponse 。
 */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onInputTipsSearchDone:response:)])
        {
            [delegate onInputTipsSearchDone:request response:response];
        }
    }];
}

/**
 * @brief 公交站查询回调函数
 * @param request  发起的请求，具体字段参考 AMapBusStopSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapBusStopSearchResponse 。
 */
- (void)onBusStopSearchDone:(AMapBusStopSearchRequest *)request response:(AMapBusStopSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onBusStopSearchDone:response:)])
        {
            [delegate onBusStopSearchDone:request response:response];
        }
    }];
}

/**
 * @brief 公交线路关键字查询回调
 * @param request  发起的请求，具体字段参考 MapBusLineSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapBusLineSearchResponse 。
 */
- (void)onBusLineSearchDone:(AMapBusLineBaseSearchRequest *)request response:(AMapBusLineSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onBusLineSearchDone:response:)])
        {
            [delegate onBusLineSearchDone:request response:response];
        }
    }];
}

/**
 * @brief 行政区域查询回调函数
 * @param request  发起的请求，具体字段参考 AMapDistrictSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapDistrictSearchResponse 。
 */
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onDistrictSearchDone:response:)])
        {
            [delegate onDistrictSearchDone:request response:response];
        }
    }];
}


/**
 * @brief 天气查询回调
 * @param request  发起的请求，具体字段参考 AMapWeatherSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapWeatherSearchResponse 。
 */
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onWeatherSearchDone:response:)])
        {
            [delegate onWeatherSearchDone:request response:response];
        }
    }];
}


/**
 * @brief 道路路况查询回调 since 5.1.0
 * @param request  发起的请求，具体字段参考 AMapRoadTrafficSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapRoadTrafficSearchResponse 。
 */
- (void)onRoadTrafficSearchDone:(AMapRoadTrafficSearchRequest *)request response:(AMapRoadTrafficSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onRoadTrafficSearchDone:response:)])
        {
            [delegate onRoadTrafficSearchDone:request response:response];
        }
    }];
}
#pragma mark - 附近搜索回调

/**
 * @brief 附近搜索回调
 * @param request  发起的请求，具体字段参考 AMapNearbySearchRequest 。
 * @param response 响应结果，具体字段参考 AMapNearbySearchResponse 。
 */
- (void)onNearbySearchDone:(AMapNearbySearchRequest *)request response:(AMapNearbySearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onNearbySearchDone:response:)])
        {
            [delegate onNearbySearchDone:request response:response];
        }
    }];
}

#pragma mark - 云图搜索回调

/**
 * @brief  云图查询回调函数
 * @param request 发起的请求，具体字段参考 AMapCloudSearchBaseRequest 。
 * @param response 响应结果，具体字段参考 AMapCloudPOISearchResponse 。
 */
- (void)onCloudSearchDone:(AMapCloudSearchBaseRequest *)request response:(AMapCloudPOISearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onCloudSearchDone:response:)])
        {
            [delegate onCloudSearchDone:request response:response];
        }
    }];
}

#pragma mark - 短串分享搜索回调

/**
 * @brief 短串分享搜索回调
 * @param request  发起的请求
 * @param response 相应结果，具体字段参考 AMapShareSearchResponse。
 */
- (void)onShareSearchDone:(AMapShareSearchBaseRequest *)request response:(AMapShareSearchResponse *)response
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(onShareSearchDone:response:)])
        {
            [delegate onShareSearchDone:request response:response];
        }
    }];
}



@end
