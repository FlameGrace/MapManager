//
//  MapSearchInputTip.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapSearchInputTipModel.h"

@class MapSearchInputTips;

@protocol MapSearchInputTipsDelegate <NSObject>

- (void)mapSearchInputTips:(MapSearchInputTips *)search result:(NSArray <MapSearchInputTipModel *> *)result;

- (void)mapSearchInputTips:(MapSearchInputTips *)search didFailToError:(NSError *)error;

@end


@interface MapSearchInputTips : NSObject <MapSearchInputTipsDelegate>

@property (weak, nonatomic) id<MapSearchInputTipsDelegate> delegate;

@property (copy, nonatomic) NSString *keyword;

@property (copy, nonatomic) NSString *city;

@property (copy, nonatomic) NSString *types;

@property (assign, nonatomic) BOOL *cityLimit;

@property (copy, nonatomic) NSString *location;



- (void)startSearch;

@end
