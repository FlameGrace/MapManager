//
//  UIViewController+Alert.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)alertText:(NSString *_Nullable)text
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:text message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
    
}

- (UIButton*_Nullable)layoutRightItemWithTitle:(NSString*_Nullable)title target:(nullable id)target action:(nullable SEL)action
{
    // 右侧“完成”按钮
    UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextStep setTitle:title forState:UIControlStateNormal];
    [nextStep setTitleColor:(UIColor_HexA(0x409CF9,1)) forState:UIControlStateNormal];
    nextStep.titleLabel.font = [UIFont systemFontOfSize:16.0];
    nextStep.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [nextStep sizeToFit];
    
    nextStep.frame = CGRectMake(0, 0, nextStep.frame.size.width+15, 16.0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextStep];
    [nextStep addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return nextStep;
}

- (UIButton *_Nullable)buttonWithFrame:(CGRect)frame title:(NSString *_Nullable)title selector:(SEL _Nullable )selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [self.view addSubview: button];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
