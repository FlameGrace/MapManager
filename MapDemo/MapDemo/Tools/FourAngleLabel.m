//
//  FourAngleLabel.m
//  MapDemo
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "FourAngleLabel.h"

@implementation FourAngleLabel

// 当 要改变填充颜色 可以进行调用改变
-(void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setStokeColor:(UIColor *)stokeColor
{
    _stokeColor = stokeColor;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    
    // 默认圆角角度
    float r = 4;
    // 居中偏移量(箭头高度)
    float offset = 5;
    // 设置 箭头位置
    float positionNum = 20;
    
    
    // 定义坐标点 移动量
    float changeNum = r + offset;
    // 设置画线 长 宽
    float w = self.frame.size.width ;
    float h = self.frame.size.height;
    
    
    // 获取文本
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置 边线宽度
    CGContextSetLineWidth(context, 0.2);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, self.stokeColor.CGColor);
    //矩形填充颜色
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    
    CGContextMoveToPoint(context, r, offset); // 开始坐标左边开始
    CGContextAddArcToPoint(context, w, offset, w, changeNum, r); // 右上角角度
    CGContextAddArcToPoint(context, w , h - offset, w - changeNum, h - offset, r); // 右下角角度
    
    CGContextAddLineToPoint(context, positionNum + 10, h - offset); // 向左划线
    CGContextAddLineToPoint(context, positionNum + 5, h); // 向下斜线
    CGContextAddLineToPoint(context, positionNum, h - offset); // 向上斜线
    
    CGContextAddArcToPoint(context, 0, h - offset, 0, h - changeNum, r); // 左下角角度
    CGContextAddArcToPoint(context, 0, offset, r, offset, r); // 左上角角度
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    /** 父类调用 放在画完边线 后. 不然 设置的文字会被覆盖 */
    [super drawRect:rect];
    
}

@end
