//
//  MapAnnotationView.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapAnnotationView.h"
#import "MapAnnotation.h"

@implementation MapAnnotationView

@synthesize annotation = _annotation;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self updateUIByIsSelected];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateUIByIsSelected];
}

- (void)updateUIByIsSelected
{
    if(self.isSelected)
    {
        [self selectedStyle];
    }
    else
    {
        [self normalStyle];
    }
    self.annotation.viewSelected = self.isSelected;
}

- (void)updateUIByViewSelected
{
    if(self.annotation.viewSelected)
    {
        [self selectedStyle];
    }
    else
    {
        [self normalStyle];
    }
}

- (void)normalStyle
{
    if([self.annotation isKindOfClass:[MapAnnotation class]])
    {
        self.image = self.annotation.image;
        CGRect frame = self.frame;
        frame.size = self.annotation.size;
        self.frame  = frame;
        self.centerOffset = self.annotation.centerOffset;
    }
}


- (void)selectedStyle
{
    if([self.annotation isKindOfClass:[MapAnnotation class]])
    {
        UIImage *image = self.annotation.selectedImage;
        if(!image)
        {
            image = self.annotation.image;
        }
        self.image = image;
        CGSize size = self.annotation.selectedSize;
        if(CGSizeEqualToSize(size, CGSizeZero))
        {
            size = self.annotation.size;
        }
        CGPoint centerOffset = self.annotation.selectedCenterOffset;
        if(CGPointEqualToPoint(centerOffset, CGPointZero))
        {
            centerOffset = self.annotation.centerOffset;
        }
        self.image = image;
        CGRect frame = self.frame;
        frame.size = size;
        self.frame  = frame;
        self.centerOffset = centerOffset;
    }
}


- (void)updateLocation:(CLLocationCoordinate2D)coordinate
{
    self.annotation.coordinate = coordinate;
}

@end
