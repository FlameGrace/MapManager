//
//  MapManager+Tools.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapManager.h"

@interface MapManager (Tools)
//根据逆地理编码信息更新地点信息
+ (void)updateMapLocation:(MapLocationModel *)mapLocation byReGeocode:(AMapReGeocode *)reGeocode;

//根据搜索结果更新地点信息
+ (void)updateMapLocation:(MapLocationModel *)mapLocation byPlacemark:(CLPlacemark*)placeMark;

//根据搜索结果更新地点信息
+ (void)updateMapLocation:(MapLocationModel *)mapLocation byAMapPOI:(AMapPOI*)poi;


/**
 将一个包含多个经纬度点的NSValue数组转换为CLLocationCoordinate2D数组
 @param points NSValue *value = [NSValue valueWithCGPoint:CGPointMake(longitude, latitude)];
 @return CLLocationCoordinate2D数组
 */
+ (CLLocationCoordinate2D *)coordinatesFromPointsArray:(NSArray <NSValue*> *)points;


/**
 将一个包含多个经纬度点的CLLocationCoordinate2D数组转换为NSValue数组转换为

 @param coordinates CLLocationCoordinate2D数组
 @param count 数量
 @return NSValue *value = [NSValue valueWithCGPoint:CGPointMake(longitude, latitude)];
 */
+ (NSArray <NSValue*> *)pointsArrayFromCoordinates:(CLLocationCoordinate2D *)coordinates count:(NSUInteger)count;
//导航路线解析
+ (NSArray <NSValue*> *)pointsArrayFromNaviRoute:(AMapNaviRoute *)naviRoute;
//解析经纬度
+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string  coordinateCount:(NSUInteger *)coordinateCount  parseToken:(NSString *)token;
/**
 AMapPath 路径解析
 */
+ (CLLocationCoordinate2D *)coordinatesForPath:(AMapPath *)path  coordinateCount:(NSUInteger *)count;
/**
 AMapPath 路径解析
 */
+ (MAPolyline *)polylineForPath:(AMapPath *)path;

//导航路线解析
+ (MAPolyline *)polylineForNaviRoute:(AMapNaviRoute *)naviRoute;

//对一系列的点进行解析转换为覆盖物模型
+ (MAPolyline *)polylineForPoints:(NSArray <NSValue *> *)points;

/**
 *  将秒数转换为以xx小时xx分钟的时间
 *
 *  @param seconds 秒数
 *
 *  @return xx小时xx分钟
 */
+ (NSString *)getTimeFromSeconds:(NSInteger)seconds;

/**
 *  将米数转换，未超过一公里以米为单位，一公里及以上以公里为单位
 *
 *  @param metres 米数
 */
+ (NSString *)getDistanceFromMetres:(NSInteger)metres;

/**
 *  转换CLLocationCoordinate2D为AMapGeoPoint(id类型）
 */
+ (AMapGeoPoint *)transformCLLocationCoordinate2D:(CLLocationCoordinate2D)coordinate;

/**
 转换@"long,lat"的经纬度坐标为CLLocationCoordinate2D
 */
+ (CLLocationCoordinate2D)transformLocation:(NSString *)location;
/**
 *  转换AMapGeoPoint为CLLocationCoordinate2D
 */
+ (CLLocationCoordinate2D)transformAMapGeoPoint:(AMapGeoPoint *)AMapGeoPoint;


+ (AMapNaviPoint*)transformAMapNaviPointCLLocationCoordinate2D:(CLLocationCoordinate2D)coordinate;

//导航动作描述转换
+ (NSString *)getNaviActionDescriptionByAMapNaviIconType:(AMapNaviIconType)iconType;

/**
 *  获取一条导航路径中途径最长的一条道路名
 */
+ (NSString *)getTheMaxLengthRoadNameInAMapNaviRoute:(AMapNaviRoute *)route;

/**
 *  根据两个地点的经纬度计算距离
 *
 *  @param origin      初始地
 *  @param destination 目的地
 *
 *  @return 距离，单位：m
 */
+ (CLLocationDistance)getDistanceBetweenOrigin:(CLLocationCoordinate2D)origin andDestination:(CLLocationCoordinate2D)destination;



/**
 
 * @method 根据两点经纬度，计算与正北方夹角
 
 *
 
 * @param longitude1
 
 * @param latitude1
 
 * @param longitude2
 
 * @param latitude2 // 目标点
 
 */

+ (double)getAngleOnBasisOfNorthBetweenLocation:(CLLocationCoordinate2D)coordinate1 andLocation:(CLLocationCoordinate2D)coordinate2;

+ (CLLocationDirection)calculateCourseFroMAMapPoint:(MAMapPoint)point1 to:(MAMapPoint)point2;

+ (CLLocationDirection)calculateCourseFromCoordinate:(CLLocationCoordinate2D)coord1 to:(CLLocationCoordinate2D)coord2;
+ (CLLocationDirection)fixNewDirection:(CLLocationDirection)newDir basedOnOldDirection:(CLLocationDirection)oldDir;

@end
