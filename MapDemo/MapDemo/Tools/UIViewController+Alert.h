//
//  UIViewController+Alert.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (UIButton *_Nullable)buttonWithFrame:(CGRect)frame title:(NSString *_Nullable)title selector:(SEL _Nullable )selector;

- (void)alertText:(NSString *_Nullable)text;

- (UIButton*_Nullable)layoutRightItemWithTitle:(NSString*_Nullable)title target:(nullable id)target action:(nullable SEL)action;

@end
