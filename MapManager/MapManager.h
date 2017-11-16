//
//  LPMapManager.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/8.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//  提供基于高德地图服务的单例类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "MapLocationModel.h"
#import "NSObject+MultiDelegate.h"

#define MAPVIEW_TAG (NSInteger)(201609021132)
#define MAPVIEW_DEFAULT_ZOOMLEVEL (16.5)



@interface MapManager : NSObject <MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

//高德地图View
@property (strong,nonatomic) MAMapView *mapView;
//高德定位
@property (strong, nonatomic) AMapLocationManager *mapLocationManager;
//高德地图搜索API
@property (strong,nonatomic) AMapSearchAPI *mapSearch;
//高德地图驾车导航Manager
@property (strong,nonatomic) AMapNaviDriveManager *mapNaviDrive;
//高德地图步行导航Manager
@property (strong,nonatomic) AMapNaviWalkManager *mapNaviWalk;
//高德地图定位权限状态
@property (assign, nonatomic) CLAuthorizationStatus locationAuthorizationStatus;


//单例模式,默认初始化mapView屏幕大小，不显示罗盘比例尺，显示用户位置，模式为跟踪用户位置，后台持续定位
+ (instancetype)sharedManager;

- (BOOL)isResourceReleased;

/*!
 @brief 添加地图到指定的视图上，并指定地图的大小.
 @param view:父视图.
 @return 是否添加成功
 */
- (BOOL)addMapViewToView:(UIView *)view;
/*!
 @brief 添加地图到指定的视图上，并指定地图的大小.
 @param view:父视图.
 @param frame:地图视图的大小.
 @return 是否添加成功
 */
- (BOOL)addMapViewToView:(UIView *)view withFrame:(CGRect)frame;

//刷新地图显示，防止有些大头针未及时显示
- (void)refreshMapView;
//不用时释放不需要用的资源
- (void)releaseMapResourse;

@end
