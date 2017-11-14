//
//  AngleLabel.m
//  MapDemo
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "AngleLabel.h"

@implementation AngleLabel

// 当 要改变填充颜色 可以进行调用改变
-(void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = frame.size.width + 7;
    [super setFrame:frame];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat r = self.frame.size.width/2;
    CGPoint center = CGPointMake(r, r);
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    // 获取文本
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置 边线宽度
    CGContextSetLineWidth(context, 0.2);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    //矩形填充颜色
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextMoveToPoint(context, center.x, center.y); // 开始坐标左边开始
    CGContextAddArc(context, center.x, center.y, r, 0, 2*M_PI, 0);
    CGContextMoveToPoint(context, width, center.y); // 开始坐标左边开始
    CGContextAddLineToPoint(context, center.x, height); // 向左划线
    CGContextAddLineToPoint(context, 0, center.y); // 开始坐标左边开始
    
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    /** 父类调用 放在画完边线 后. 不然 设置的文字会被覆盖 */
    [super drawRect:rect];
    
}



@end
