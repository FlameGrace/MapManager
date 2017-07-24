//
//  MapSearchInputProtocol.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/7/1.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MapSearchInputType)
{
    MapSearchInputKeyword = 0,
    MapSearchInputLocation = 1,
};


@protocol MapSearchInputProtocol <NSObject>

@property (nonatomic, assign) MapSearchInputType inputType;
@property (nullable, nonatomic, strong) NSString *tipKeyword;
@property (nullable, nonatomic, strong) NSString *keyword;
@property (nullable, nonatomic, strong) NSString *city;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *address;
@property (nullable, nonatomic, strong) NSString *location; //"120.0,20" (long,lat)
@property (nullable, nonatomic, strong) NSString *poiUid;

@end
