//
//  AnCar.m
//  MapDemo
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "AnCar.h"
#import "CarMapAnnotationView.h"
#import "MapDrawPoint.h"

@interface AnCar()

@property (weak, nonatomic) MapManager *mapManager;
//画大头针
@property (strong, nonatomic) MapDrawPoint *drawPoint;
@end


@implementation AnCar

static AnCar *shareCar = nil;

+ (instancetype)sharedCar
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCar = [[self alloc]init];
    });
    return shareCar;
}


- (instancetype)init
{
    if(self = [super init])
    {
        self.showCar = YES;
        self.drawPoint = [[MapDrawPoint alloc]init];
        [self.mapManager addMultiDelegate:self];
    }
    return self;
}

- (void)setShowCar:(BOOL)showCar
{
    _showCar = showCar;
    self.drawPoint.showAnnotations = _showCar;
}

- (void)updateCarLocationLongitude:(NSString *)longitude latitude:(NSString *)latitude
{
    if([latitude length]<1||[longitude length]<1)
    {
        [self.drawPoint clear];
        [self postCarLocationChangedNotification];
        self.car = nil;
        return;
    }
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
    if(!self.car)
    {
        CarMapAnnotation *carAnnotation = [[CarMapAnnotation alloc]init];
        carAnnotation.coordinate = coordinate;
        //创建车机位置数据模型
        self.car = [CarMapLocation modelByCoordinate:coordinate];
        self.car.annotaion = carAnnotation;
        [self.drawPoint addMapAnnotations:@[carAnnotation]];
    }
    else
    {   self.car.coordinate2D = coordinate;
        CarMapAnnotationView *view = (CarMapAnnotationView *)[self.mapManager.mapView viewForAnnotation:self.car.annotaion];
        if(!view)
        {
            self.car.annotaion.coordinate = coordinate;
        }
        else
        {
            [view updateLocation:coordinate];
        }
    }
    
    [self postCarLocationChangedNotification];
    if(self.showCarInMapCenter)
    {
        [self switchCarInMapCenter];
    }
    
}



- (void)postCarLocationChangedNotification
{
    [[NSNotificationCenter defaultCenter]postNotificationName:MapCarLocationChangdeNotification object:nil];
}




- (void)switchCarInMapCenter
{
    
    if(self.car)
    {
        dispatch_async(dispatch_get_main_queue(),^{
            [[MapManager sharedManager].mapView setCenterCoordinate:self.car.coordinate2D animated:YES];
            [self.mapManager refreshMapView];
        });
    }
}



- (MapManager *)mapManager
{
    return [MapManager sharedManager];
}


@end
