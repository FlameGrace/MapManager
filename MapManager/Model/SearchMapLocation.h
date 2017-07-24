//
//  MapSearchMapLocation.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapLocationModel.h"
#import "SearchMapAnnotation.h"

@interface SearchMapLocation : MapLocationModel

@property (strong, nonatomic) SearchMapAnnotation *annotation;

@end
