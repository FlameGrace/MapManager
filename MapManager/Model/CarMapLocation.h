//
//  MapCarMapLocation.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/3.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapLocationModel.h"
#import "CarMapAnnotation.h"

@interface CarMapLocation : MapLocationModel

@property (strong, nonatomic) CarMapAnnotation *annotation;


@end
