//
//  MapCarLocationSimulator.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSimulator : NSObject


+ (instancetype)sharedSimulator;

//设置开启或停止模拟
@property (assign, nonatomic) BOOL simulating;

@end
