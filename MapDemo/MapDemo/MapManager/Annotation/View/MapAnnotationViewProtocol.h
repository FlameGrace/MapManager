//
//  MapAnnotationViewProtocol.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MapAnnotationViewProtocol <NSObject>

- (void)selectedStyle;

- (void)normalStyle;

- (void)updateUIByIsSelected;


@end
