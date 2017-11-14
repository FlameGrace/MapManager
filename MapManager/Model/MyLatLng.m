//
//  MyLatLng.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/11/25.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MyLatLng.h"
#define RC 6378137
#define RJ 6356725

@implementation MyLatLng
@synthesize m_LoDeg;
@synthesize m_LoMin;
@synthesize m_LoSec;
@synthesize m_LaDeg;
@synthesize m_LaMin;
@synthesize m_LaSec;
@synthesize m_Longitude;
@synthesize m_Latitude;
@synthesize m_RadLa;
@synthesize m_RadLo;
@synthesize Ec;
@synthesize Ed;

- (id)init:(double)longitude latitude:(double)latitude{
    self = [super init];
    
    if (self) {
        m_LoDeg=(int)longitude;
        m_LoMin=(int)((longitude-m_LoDeg)*60);
        m_LoSec=(longitude-m_LoDeg-m_LoMin/60.)*3600;
        
        m_LaDeg=(int)latitude;
        m_LaMin=(int)((latitude-m_LaDeg)*60);
        m_LaSec=(latitude-m_LaDeg-m_LaMin/60.)*3600;
        
        m_Longitude=longitude;
        m_Latitude=latitude;
        m_RadLo=longitude*M_PI/180.;
        m_RadLa=latitude*M_PI/180.;
        Ec=RJ+(RC-RJ)*(90.-m_Latitude)/90.;
        Ed=Ec*cos(m_RadLa);
    }
    
    return self;
}



+ (double)getAngle:(MyLatLng *)A B:(MyLatLng *)B
{
    double dx=(B.m_RadLo-A.m_RadLo)*A.Ed;
    double dy=(B.m_RadLa-A.m_RadLa)*A.Ec;
    double angle=0.0;
    angle = atan(fabs(dx/dy))*180./M_PI;
    double dLo=B.m_Longitude-A.m_Longitude;
    double dLa=B.m_Latitude-A.m_Latitude;
    if(dLo>0&&dLa<=0){
        angle=(90.-angle)+90;
    }
    else if(dLo<=0&&dLa<0){
        angle=angle+180.;
    }else if(dLo<0&&dLa>=0){
        angle= (90.-angle)+270;
    }
    return angle;
}



@end
