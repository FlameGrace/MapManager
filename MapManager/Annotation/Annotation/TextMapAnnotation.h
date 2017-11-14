//
//  TextMapAnnotation.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapAnnotation.h"

@interface TextMapAnnotation : MapAnnotation

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIColor *selectBackGroundColor;
@property (strong, nonatomic) UIColor *backGroundColor;

@end
