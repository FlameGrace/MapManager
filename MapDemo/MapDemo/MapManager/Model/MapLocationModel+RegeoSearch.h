//
//  MapLocationModel+RegeoSearch.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/4.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapLocationModel.h"
typedef void(^MapLocationSearchRegeocallback)(NSError *error);

@interface MapLocationModel (RegeoSearch)

- (void)searchRegeoWithcallback:(MapLocationSearchRegeocallback)callback;

@end
