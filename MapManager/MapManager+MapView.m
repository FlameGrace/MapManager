//
//  MapManager+MapView.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace. All rights reserved.
//

#import "MapManager+MapView.h"

@implementation MapManager (MapView)

/**
 * @brief 地图区域改变过程中会调用此接口 since 4.6.0
 * @param mapView 地图View
 */
- (void)mapViewRegionChanged:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapViewRegionChanged:)])
        {
            [delegate mapViewRegionChanged:mapView];
        }
    }];
}

/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:regionWillChangeAnimated:)])
        {
            [delegate mapView:mapView regionWillChangeAnimated:animated];
        }
    }];
}

/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:regionDidChangeAnimated:)])
        {
            [delegate mapView:mapView regionDidChangeAnimated:animated];
        }
    }];
}

/**
 * @brief 地图将要发生移动时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:mapWillMoveByUser:)])
        {
            [delegate mapView:mapView mapWillMoveByUser:wasUserAction];
        }
    }];
}

/**
 * @brief 地图移动结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:mapDidMoveByUser:)])
        {
            [delegate mapView:mapView mapDidMoveByUser:wasUserAction];
        }
    }];
}

/**
 * @brief 地图将要发生缩放时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:mapWillZoomByUser:)])
        {
            [delegate mapView:mapView mapWillZoomByUser:wasUserAction];
        }
    }];
}

/**
 * @brief 地图缩放结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:mapDidZoomByUser:)])
        {
            [delegate mapView:mapView mapDidZoomByUser:wasUserAction];
        }
    }];
}

/**
 * @brief 地图开始加载
 * @param mapView 地图View
 */
- (void)mapViewWillStartLoadingMap:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapViewWillStartLoadingMap:)])
        {
            [delegate mapViewWillStartLoadingMap:mapView];
        }
    }];
}

/**
 * @brief 地图加载成功
 * @param mapView 地图View
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapViewDidFinishLoadingMap:)])
        {
            [delegate mapViewDidFinishLoadingMap:mapView];
        }
    }];
}

/**
 * @brief 地图加载失败
 * @param mapView 地图View
 * @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error;
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapViewDidFailLoadingMap:withError:)])
        {
            [delegate mapViewDidFailLoadingMap:mapView withError:error];
        }
    }];
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    __block MAAnnotationView *view;
    
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:viewForAnnotation:)])
        {
            MAAnnotationView *singleView = [delegate mapView:mapView viewForAnnotation:annotation];
            if(singleView)
            {
                view =  singleView;
            }
        }
    }];
    
    return view;
}

/**
 * @brief 当mapView新添加annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didAddAnnotationViews:)])
        {
            [delegate mapView:mapView didAddAnnotationViews:views];
        }
    }];
}

/**
 * @brief 当选中一个annotation view时，调用此接口. 注意如果已经是选中状态，再次点击不会触发此回调。取消选中需调用-(void)deselectAnnotation:animated:
 * @param mapView 地图View
 * @param view 选中的annotation view
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didSelectAnnotationView:)])
        {
            [delegate mapView:mapView didSelectAnnotationView:view];
        }
    }];
}

/**
 * @brief 当取消选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation view
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didDeselectAnnotationView:)])
        {
            [delegate mapView:mapView didDeselectAnnotationView:view];
        }
    }];
}

/**
 * @brief 在地图View将要启动定位时，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapViewWillStartLocatingUser:)])
        {
            [delegate mapViewWillStartLocatingUser:mapView];
        }
    }];
}

/**
 * @brief 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapViewDidStopLocatingUser:)])
        {
            [delegate mapViewDidStopLocatingUser:mapView];
        }
    }];
}

/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didUpdateUserLocation:updatingLocation:)])
        {
            [delegate mapView:mapView didUpdateUserLocation:userLocation updatingLocation:updatingLocation];
        }
    }];
}

/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error;
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didFailToLocateUserWithError:)])
        {
            [delegate mapView:mapView didFailToLocateUserWithError:error];
        }
    }];
}

/**
 * @brief 拖动annotation view时view的状态变化
 * @param mapView 地图View
 * @param view annotation view
 * @param newState 新状态
 * @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState
   fromOldState:(MAAnnotationViewDragState)oldState
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:annotationView:didChangeDragState:fromOldState:)])
        {
            [delegate mapView:mapView annotationView:view didChangeDragState:newState fromOldState:oldState];
        }
    }];
}

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    __block MAOverlayRenderer *view;
    
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:rendererForOverlay:)])
        {
            MAOverlayRenderer *singleView = [delegate mapView:mapView rendererForOverlay:overlay];
            if(singleView)
            {
                view =  singleView;
            }
        }
    }];
    
    return view;
}

/**
 * @brief 当mapView新添加overlay renderers时，调用此接口
 * @param mapView 地图View
 * @param overlayRenderers 新添加的overlay renderers
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)overlayRenderers
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didAddOverlayRenderers:)])
        {
            [delegate mapView:mapView didAddOverlayRenderers:overlayRenderers];
        }
    }];
}

/**
 * @brief 标注view的accessory view(必须继承自UIControl)被点击时，触发该回调
 * @param mapView 地图View
 * @param view callout所属的标注view
 * @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)])
        {
            [delegate mapView:mapView annotationView:view calloutAccessoryControlTapped:control];
        }
    }];
}

/**
 * @brief 标注view的calloutview整体点击时，触发改回调。
 * @param mapView 地图的view
 * @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didAnnotationViewCalloutTapped:)])
        {
            [delegate mapView:mapView didAnnotationViewCalloutTapped:view];
        }
    }];
}

/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didChangeUserTrackingMode:animated:)])
        {
            [delegate mapView:mapView didChangeUserTrackingMode:mode animated:animated];
        }
    }];
}

/**
 * @brief 当openGLESDisabled变量改变时，调用此接口
 * @param mapView 地图View
 * @param openGLESDisabled 改变后的openGLESDisabled
 */
- (void)mapView:(MAMapView *)mapView didChangeOpenGLESDisabled:(BOOL)openGLESDisabled
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didChangeOpenGLESDisabled:)])
        {
            [delegate mapView:mapView didChangeOpenGLESDisabled:openGLESDisabled];
        }
    }];
}

/**
 * @brief 当touchPOIEnabled == YES时，单击地图使用该回调获取POI信息
 * @param mapView 地图View
 * @param pois 获取到的poi数组(由MATouchPoi组成)
 */
- (void)mapView:(MAMapView *)mapView didTouchPois:(NSArray *)pois
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didTouchPois:)])
        {
            [delegate mapView:mapView didTouchPois:pois];
        }
    }];
}

/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didSingleTappedAtCoordinate:)])
        {
            [delegate mapView:mapView didSingleTappedAtCoordinate:coordinate];
        }
    }];
}

/**
 * @brief 长按地图，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didLongPressedAtCoordinate:)])
        {
            [delegate mapView:mapView didLongPressedAtCoordinate:coordinate];
        }
    }];
}

/**
 * @brief 地图初始化完成（在此之后，可以进行坐标计算）
 * @param mapView 地图View
 */
- (void)mapInitComplete:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapInitComplete:)])
        {
            [delegate mapInitComplete:mapView];
        }
    }];
}

#if MA_INCLUDE_INDOOR
/**
 * @brief  室内地图出现,返回室内地图信息
 *
 *  @param mapView        地图View
 *  @param indoorInfo     室内地图信息
 */
- (void)mapView:(MAMapView *)mapView didIndoorMapShowed:(MAIndoorInfo *)indoorInfo
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didIndoorMapShowed:)])
        {
            [delegate mapView:mapView didIndoorMapShowed:indoorInfo];
        }
    }];
}

/**
 * @brief  室内地图楼层发生变化,返回变化的楼层
 *
 *  @param mapView        地图View
 *  @param indoorInfo     变化的楼层
 */
- (void)mapView:(MAMapView *)mapView didIndoorMapFloorIndexChanged:(MAIndoorInfo *)indoorInfo
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didIndoorMapFloorIndexChanged:)])
        {
            [delegate mapView:mapView didIndoorMapFloorIndexChanged:indoorInfo];
        }
    }];
}

/**
 * @brief  室内地图消失后,返回室内地图信息
 *
 *  @param mapView        地图View
 *  @param indoorInfo     室内地图信息
 */
- (void)mapView:(MAMapView *)mapView didIndoorMapHidden:(MAIndoorInfo *)indoorInfo;
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(mapView:didIndoorMapHidden:)])
        {
            [delegate mapView:mapView didIndoorMapHidden:indoorInfo];
        }
    }];
}
#endif //end of MA_INCLUDE_INDOOR

/**
 * @brief 离线地图数据将要被加载, 调用reloadMap会触发该回调，离线数据生效前的回调.
 * @param mapView 地图View
 */
- (void)offlineDataWillReload:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(offlineDataWillReload:)])
        {
            [delegate offlineDataWillReload:mapView];
        }
    }];
}

/**
 * @brief 离线地图数据加载完成, 调用reloadMap会触发该回调，离线数据生效后的回调.
 * @param mapView 地图View
 */
- (void)offlineDataDidReload:(MAMapView *)mapView
{
    [self operateMultiDelegates:^(id delegate) {
        if([delegate respondsToSelector:@selector(offlineDataDidReload:)])
        {
            [delegate offlineDataDidReload:mapView];
        }
    }];
}

@end
