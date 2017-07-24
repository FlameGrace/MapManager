//
//  SearchResult.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/3.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

/*!
 @brief 地图位置的数据模型
 */
@interface MapLocationModel : NSObject

/**
 高德地图POI Id, 唯一标志id
 */
@property (strong, nonatomic) NSString *poiUid;

/*!
 @brief 位置名称
 */
@property (strong,nonatomic)  NSString *name;

/**
 *  位置详细地址信息
 */
@property (strong, nonatomic) NSString *address;

/**
 *  省
 */
@property (strong, nonatomic) NSString *province;
/**
 *  城市
 */
@property (strong, nonatomic) NSString *city;
/**
 *  区
 */
@property (strong, nonatomic) NSString *district;
/**
 *  镇
 */
@property (strong, nonatomic) NSString *town;
/**
 *  街道
 */
@property (strong, nonatomic) NSString *street;
/**
 *  地点的高德类型
 */
@property (strong, nonatomic) NSString *Maptype;
/**
 *  联系方式
 */
@property (strong, nonatomic) NSArray *contact;

/**
 *  poi分享短串
 */
@property (strong, nonatomic) NSString *AMapPOIShareUrl;

/*!
 @brief 位置标注
 */
@property (strong,nonatomic)  NSString *note;
/*!
 @brief 位置经纬度
 */
@property (assign, nonatomic) CLLocationCoordinate2D coordinate2D;


+ (id)modelByCoordinate:(CLLocationCoordinate2D)coordinate;

+ (id)model;



@end
