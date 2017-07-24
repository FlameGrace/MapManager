//
//  MapSearch+Search.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearch+Search.h"

@implementation MapSearch (Search)

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self successAfterSearchByRequest:request response:response];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    [self successAfterSearchByRequest:request response:response];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    [self successAfterSearchByRequest:request response:response];
}

- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response
{
    [self successAfterSearchByRequest:request response:response];
}


- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self successAfterSearchByRequest:request response:response];
}

- (void)onShareSearchDone:(AMapShareSearchBaseRequest *)request response:(AMapShareSearchResponse *)response
{
    [self successAfterSearchByRequest:request response:response];
}

- (void)searchKeywords:(NSString *)keywords
                  city:(NSString *)city cityLimit:(BOOL)cityLimit
                offset:(NSInteger)offset
           currentPage:(NSInteger)currentPage
                 types:(NSString *)types
              callback:(MapSearchcallback)callback
{
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = keywords;
    request.city = city;
    request.cityLimit = cityLimit;
    request.sortrule = 1;
    request.offset = offset;
    request.page = currentPage;
    if(types == nil)
    {
        types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    }
    request.types = types;
    //发起周边搜索
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapPOIKeywordsSearch:)];
    [self searchForSearchObject:obejct];
    
    return;
}

- (void)searchInputTips:(NSString *)keywords
                   city:(NSString *)city
              cityLimit:(BOOL)cityLimit
                  types:(NSString *)types
               location:(NSString *)location
               callback:(MapSearchcallback)callback
{
    AMapInputTipsSearchRequest *request = [[AMapInputTipsSearchRequest alloc] init];
    request.keywords = keywords;
    request.city = city;
    request.cityLimit = cityLimit;
    request.location =  location;
    if(types == nil)
    {
        types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    }
    request.types = types;
    //发起周边搜索
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapInputTipsSearch:)];
    [self searchForSearchObject:obejct];
}

- (void)searchAroundByLocation:(CLLocationCoordinate2D)coordinate
                      keyWords:(NSString *)keywords
                        radius:(CGFloat)radius
                      sortrule:(NSInteger)sortrule
                         types:(NSString *)types
                        offset:(NSInteger)offset
                   currentPage:(NSInteger)currentPage
                      callback:(MapSearchcallback)callback
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [MapManager transformCLLocationCoordinate2D:coordinate];
    request.keywords = keywords;
    if(types == nil)
    {
        types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    }
    request.types = types;
    request.sortrule = sortrule;
    request.requireExtension = YES;
    request.radius = radius;
    request.offset = offset;
    request.page = currentPage;
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapPOIAroundSearch:)];
    [self searchForSearchObject:obejct];
}

- (void)searchUid:(NSString *)uid callback:(MapSearchcallback)callback
{
    AMapPOIIDSearchRequest *request = [[AMapPOIIDSearchRequest alloc] init];
    request.uid = uid;
    //发起周边搜索
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapPOIIDSearch:)];
    [self searchForSearchObject:obejct];
    
}

- (void)searchSharedUid:(NSString *)uid
             coordinate:(CLLocationCoordinate2D)coordinate
                   name:(NSString *)name
                address:(NSString *)address
               callback:(MapSearchcallback)callback
{
    AMapPOIShareSearchRequest *request = [[AMapPOIShareSearchRequest alloc]init];
    request.location = [MapManager transformCLLocationCoordinate2D:coordinate];
    request.name = name;
    request.address = request.address;
    request.uid = uid;
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapPOIShareSearch:)];
    [self searchForSearchObject:obejct];
}


- (void)searchDistrictForKeywords:(NSString *)keywords regionPoints:(BOOL)regionPoints callback:(MapSearchcallback)callback
{
    AMapDistrictSearchRequest *request = [[AMapDistrictSearchRequest alloc]init];
    request.keywords = keywords;
    request.requireExtension = regionPoints;
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapDistrictSearch:)];
    [self searchForSearchObject:obejct];
}



- (void)searchRegeocodeForLocation:(CLLocationCoordinate2D)coordinate radius:(CGFloat)radius requireExtension:(BOOL)requireExtension callback:(MapSearchcallback)callback
{
    
    //构造AMapReGeocodeSearchRequest对象
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    request.location = [MapManager transformCLLocationCoordinate2D:coordinate];
    request.radius = radius;
    request.requireExtension = requireExtension;
    //发起逆地理编码
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapReGoecodeSearch:)];
    [self searchForSearchObject:obejct];
}

- (void)searchDrivingRouteBetweenOrigin:(CLLocationCoordinate2D)origin
                         andDestination:(CLLocationCoordinate2D)destination
                               strategy:(NSInteger)strategy
                       requireExtension:(BOOL)requireExtension
                               callback:(MapSearchcallback)callback
{
    //构造MapMapDrivingRouteSearchRequest对象，设置驾车路径规划请求参数
    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    request.origin = [MapManager transformCLLocationCoordinate2D:origin];
    request.destination = [MapManager transformCLLocationCoordinate2D:destination];
    request.strategy = strategy;//距离优先
    request.requireExtension = requireExtension;
    //发起路径搜索
    MapSearchObject *obejct = [[MapSearchObject alloc]initWithRequest:request callback:callback searchSelector:@selector(AMapDrivingRouteSearch:)];
    [self searchForSearchObject:obejct];
}

@end
