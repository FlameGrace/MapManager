//
//  MyLatLng.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/11/25.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//  用于计算两个地理坐标点的夹角

#import <Foundation/Foundation.h>

@interface MyLatLng : NSObject {
    double m_LoDeg,m_LoMin,m_LoSec;
    double m_LaDeg,m_LaMin,m_LaSec;
    double m_Longitude,m_Latitude;
    double m_RadLo,m_RadLa;
    double Ec;
    double Ed;
}


@property (assign, nonatomic) double m_LoDeg;
@property (assign, nonatomic) double m_LoMin;
@property (assign, nonatomic) double m_LoSec;
@property (assign, nonatomic) double m_LaDeg;
@property (assign, nonatomic) double m_LaMin;
@property (assign, nonatomic) double m_LaSec;
@property (assign, nonatomic) double m_Longitude;
@property (assign, nonatomic) double m_Latitude;
@property (assign, nonatomic) double m_RadLo;
@property (assign, nonatomic) double m_RadLa;
@property (assign, nonatomic) double Ec;
@property (assign, nonatomic) double Ed;


- (id)init:(double)longitude latitude:(double)latitude;
//获取两个点之间与正北方向的夹角
+ (double)getAngle:(MyLatLng *)A B:(MyLatLng *)B;


@end
