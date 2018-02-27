//
//  MapManager+Tools.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapManager+Tools.h"
#import "MyLatLng.h"

@implementation MapManager (Tools)

+ (void)updateMapLocation:(MapLocationModel *)mapLocation byReGeocode:(AMapReGeocode *)reGeocode
{
    AMapPOI *poi = reGeocode.pois.firstObject;
    mapLocation.poiUid = poi.uid;
    mapLocation.province = reGeocode.addressComponent.province;
    mapLocation.city = reGeocode.addressComponent.city;
    mapLocation.district = reGeocode.addressComponent.district;
    mapLocation.town = reGeocode.addressComponent.township;
    mapLocation.street = reGeocode.addressComponent.streetNumber.street;
    mapLocation.fullAddress = [reGeocode.formattedAddress mutableCopy];
    NSString *name = [reGeocode.formattedAddress mutableCopy];
    name = [name stringByReplacingOccurrencesOfString:mapLocation.province withString:@""];
    name = [name stringByReplacingOccurrencesOfString:mapLocation.city withString:@""];
    if(name.length <1)
    {
        name = mapLocation.city;
    }
    name = [name stringByReplacingOccurrencesOfString:mapLocation.district withString:@""];
    if(name.length <1)
    {
        name = mapLocation.district;
    }
    //地址去除省市区
    mapLocation.address = [name mutableCopy];
    name = [name stringByReplacingOccurrencesOfString:mapLocation.town withString:@""];
    if(name.length <1)
    {
        name = mapLocation.town;
    }
    name = [name stringByReplacingOccurrencesOfString:mapLocation.street withString:@""];
    if(name.length <1)
    {
        name = mapLocation.street;
    }
    mapLocation.name = name;
}


+ (void)updateMapLocation:(MapLocationModel *)mapLocation byPlacemark:(CLPlacemark*)placeMark
{
    NSDictionary *addressDic=placeMark.addressDictionary;
    mapLocation.province=[addressDic objectForKey:@"State"];
    mapLocation.city=[addressDic objectForKey:@"City"];
    mapLocation.street=[addressDic objectForKey:@"Street"];
    mapLocation.address = @"";
    NSArray *array = [addressDic objectForKey:@"FormattedAddressLines"];
    for (NSString *line in array) {
        mapLocation.address = [mapLocation.address stringByAppendingString:line];
    }
    mapLocation.fullAddress = mapLocation.address;
    mapLocation.name = [addressDic objectForKey:@"Name"];
    NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
    mapLocation.district = subLocality;
}


+ (void)updateMapLocation:(MapLocationModel *)mapLocation byAMapPOI:(AMapPOI*)poi
{
    mapLocation.poiUid = poi.uid;
    if(poi.tel.length>0)
    {
       mapLocation.contact = [poi.tel componentsSeparatedByString:@";"];
    }
    mapLocation.name = poi.name;
    mapLocation.address = poi.address;
    mapLocation.fullAddress = poi.address;
    mapLocation.province = poi.province;
    mapLocation.city = poi.city;
    mapLocation.district = poi.district;
    mapLocation.street = poi.address;
    NSArray *types = [poi.type componentsSeparatedByString:@";"];
    mapLocation.mapType = [types lastObject];
    mapLocation.coordinate2D = [MapManager transformAMapGeoPoint:poi.location];
}

+ (CLLocationCoordinate2D *)coordinatesFromPointsArray:(NSArray <NSValue*> *)points
{
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(points.count * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < points.count; i++)
    {
        NSValue *value = points[i];
        CGPoint point = value.CGPointValue;
        
        coordinates[i].longitude = point.x;
        coordinates[i].latitude  = point.y;
    }
    return coordinates;
}
+ (NSArray <NSValue*> *)pointsArrayFromCoordinates:(CLLocationCoordinate2D *)coordinates count:(NSUInteger)count
{
    
    NSMutableArray *ar = [[NSMutableArray alloc]init];
    for (int i = 0; i < count; i++)
    {
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(coordinates[i].longitude, coordinates[i].latitude)];
        [ar addObject:value];
    }
    return [NSArray arrayWithArray:ar];
}

+ (NSArray <NSValue*> *)pointsArrayFromNaviRoute:(AMapNaviRoute *)naviRoute
{
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++)
    {
        AMapNaviPoint *aCoordinate = [naviRoute.routeCoordinates objectAtIndex:i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    return [self pointsArrayFromCoordinates:coordinates count:coordianteCount];
}
//解析经纬度
+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string  coordinateCount:(NSUInteger *)coordinateCount  parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}


+ (CLLocationCoordinate2D *)coordinatesForPath:(AMapPath *)path  coordinateCount:(NSUInteger *)count
{
    if (path == nil || path.steps.count == 0)
    {
        return NULL;
    }
    AMapStep *step = [path.steps firstObject];
    NSString *polylines  = step.polyline;
    if(path.steps.count >1)
    {
        for (int i = 1; i<path.steps.count; i++)
        {
            AMapStep *temp = path.steps[i];
            polylines = [polylines stringByAppendingString:[NSString stringWithFormat:@";%@",temp.polyline]];
        }
    }
    CLLocationCoordinate2D *coordinates = [[self class] coordinatesForString:polylines
                                                             coordinateCount:count
                                                                  parseToken:@";"];
    return coordinates;
}

//路线解析
+ (MAPolyline *)polylineForPath:(AMapPath *)path
{
    NSUInteger count = 0;
    CLLocationCoordinate2D *coordinates = [[self class] coordinatesForPath:path coordinateCount:&count];
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
    return polyline;
    
}


+ (MAPolyline *)polylineForNaviRoute:(AMapNaviRoute *)naviRoute
{
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++)
    {
        AMapNaviPoint *aCoordinate = [naviRoute.routeCoordinates objectAtIndex:i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    return [MAPolyline polylineWithCoordinates:coordinates count:coordianteCount];
}


+ (MAPolyline *)polylineForPoints:(NSArray <NSValue *> *)points
{
    CLLocationCoordinate2D *coordinates = [self coordinatesFromPointsArray:points];
    return [MAPolyline polylineWithCoordinates:coordinates count:points.count];
}


+ (CLLocationDistance)getDistanceBetweenOrigin:(CLLocationCoordinate2D)origin andDestination:(CLLocationCoordinate2D)destination
{
    
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:origin.latitude  longitude:origin.longitude];
    CLLocation *dist=[[CLLocation alloc] initWithLatitude:destination.latitude  longitude:destination.longitude];
    
    return [orig distanceFromLocation:dist];
}


/**
 
 * @method 根据两点经纬度，计算与正北方夹角
 
 *
 
 * @param longitude1
 
 * @param latitude1
 
 * @param longitude2
 
 * @param latitude2 // 目标点
 
 */

+ (double)getAngleOnBasisOfNorthBetweenLocation:(CLLocationCoordinate2D)coordinate1 andLocation:(CLLocationCoordinate2D)coordinate2
{
    
    MyLatLng *l1 = [[MyLatLng alloc]init:coordinate1.longitude latitude:coordinate1.latitude];
    MyLatLng *l2 = [[MyLatLng alloc]init:coordinate2.longitude latitude:coordinate2.latitude];
    
    return [MyLatLng getAngle:l1 B:l2];
    
}

+ (NSString *)getTimeFromSeconds:(NSInteger)seconds
{
    NSInteger m = seconds/60;
    NSInteger h = m/60;
    
    if(h > 0)
    {
        m = m - h*60;
        return [NSString stringWithFormat:@"%ld小时%ld分",(long)h,(long)m];
    }
    return [NSString stringWithFormat:@"%ld分",(long)m];
    
}

+ (NSString *)getDistanceFromMetres:(NSInteger)metres
{
    if(metres<1000)return [NSString stringWithFormat:@"%ld米",(long)metres];
    CGFloat km = metres/1000;
    return [NSString stringWithFormat:@"%.1f公里",km];
    
}


+ (AMapGeoPoint *)transformCLLocationCoordinate2D:(CLLocationCoordinate2D)coordinate
{
    return [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

+ (AMapNaviPoint*)transformAMapNaviPointCLLocationCoordinate2D:(CLLocationCoordinate2D)coordinate
{
    return [AMapNaviPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}


+ (NSString *)getNaviActionDescriptionByAMapNaviIconType:(AMapNaviIconType)iconType
{

    NSString *description = @"";
    switch (iconType) {
        case AMapNaviIconTypeLeft:
            description = @"左转";
            break;
        case AMapNaviIconTypeRight:
            description = @"右转";
            break;
        case AMapNaviIconTypeLeftFront:
            description = @"左前方";
            break;
        case AMapNaviIconTypeRightFront:
            description = @"右前方";
            break;
        case AMapNaviIconTypeLeftBack:
            description = @"左后方";
            break;
        case AMapNaviIconTypeRightBack:
            description = @"右后方";
            break;
        case AMapNaviIconTypeLeftAndAround:
            description = @"左转掉头";
            break;
        case AMapNaviIconTypeStraight:
            description = @"直行";
            break;
//        case AMapNaviIconTypeArrivedWayPoint:
//            description = @"到达途经点";
//            break;
//        case AMapNaviIconTypeEnterRoundabout:
//            description = @"进入环岛";
//            break;
//        case AMapNaviIconTypeOutRoundabout:
//            description = @"驶出环岛";
//            break;
//        case AMapNaviIconTypeArrivedServiceArea:
//            description = @"到达服务区";
//            break;
//        case AMapNaviIconTypeArrivedTollGate:
//            description = @"到达收费站";
//            break;
//        case AMapNaviIconTypeArrivedDestination:
//            description = @"到达目的地";
//            break;
//        case AMapNaviIconTypeArrivedTunnel:
//            description = @"进入隧道";
//            break;
//        case AMapNaviIconTypeCrosswalk:
//            description = @"通过人行横道";
//            break;
//        case AMapNaviIconTypeFlyover:
//            description = @"通过过街天桥";
//            break;
//        case AMapNaviIconTypeUnderpass:
//            description = @"通过地下通道";
//            break;
        default:
            description = @"前行";
            break;
    }
    return description;
}


+ (NSString *)getTheMaxLengthRoadNameInAMapNaviRoute:(AMapNaviRoute *)route
{
    NSString *maxName = @"";
    NSInteger maxLength = 0;
    for (AMapNaviSegment *segment in route.routeSegments)
    {
        if(segment.length >= maxLength)
        {
            maxLength = segment.length;
            AMapNaviLink *link = [segment.links lastObject];
            maxName = link.roadName;
        }
        
    }
    if(!maxName) maxName = @"";
    
    return maxName;
}

+ (CLLocationCoordinate2D)transformLocation:(NSString *)location
{
    NSArray *ar = [location componentsSeparatedByString:@","];
    if(ar.count <2)
    {
        return CLLocationCoordinate2DMake(0, 0);
    }
    NSString *lon = ar[0];
     NSString *la = ar[1];
    return CLLocationCoordinate2DMake(la.floatValue, lon.floatValue);
}

+ (CLLocationCoordinate2D)transformAMapGeoPoint:(AMapGeoPoint *)AMapGeoPoint
{
    return CLLocationCoordinate2DMake(AMapGeoPoint.latitude, AMapGeoPoint.longitude);
}

+ (CLLocationDirection)calculateCourseFroMAMapPoint:(MAMapPoint)p1 to:(MAMapPoint)p2
{
    //20级坐标y轴向下，需要反过来。
    MAMapPoint dp = MAMapPointMake(p2.x - p1.x, p1.y - p2.y);
    
    if (dp.y == 0)
    {
        return dp.x < 0? 270.f:0.f;
    }
    
    double dir = atan(dp.x/dp.y) * 180.f / M_PI;
    
    if (dp.y > 0)
    {
        if (dp.x < 0)
        {
            dir = dir + 360.f;
        }
        
    }else
    {
        dir = dir + 180.f;
    }
    
    return dir;
}

+ (CLLocationDirection)calculateCourseFromCoordinate:(CLLocationCoordinate2D)coord1 to:(CLLocationCoordinate2D)coord2
{
    MAMapPoint p1 = MAMapPointForCoordinate(coord1);
    MAMapPoint p2 = MAMapPointForCoordinate(coord2);
    
    return [self calculateCourseFroMAMapPoint:p1 to:p2];
}

+ (CLLocationDirection)fixNewDirection:(CLLocationDirection)newDir basedOnOldDirection:(CLLocationDirection)oldDir
{
    //the gap between newDir and oldDir would not exceed 180.f degrees
    CLLocationDirection turn = newDir - oldDir;
    if(turn > 180.f)
    {
        return newDir - 360.f;
    }
    else if (turn < -180.f)
    {
        return newDir + 360.f;
    }
    else
    {
        return newDir;
    }
    
}

@end
