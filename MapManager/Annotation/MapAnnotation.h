//
//  MapAnnotation.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMapkit/MAAnnotation.h"

@class MapAnnotation;
@class MapAnnotationView;

typedef void(^MapBlock)(void);
typedef void(^MapByUserBlock)(BOOL byUser);


@interface MapAnnotation : NSObject<MAAnnotation>

@property (assign,nonatomic) CLLocationCoordinate2D coordinate;
//唯一标志符
@property (strong, nonatomic) NSString *identifier;
///annotation标题
@property (nonatomic, copy) NSString *title;
///annotation副标题
@property (nonatomic, copy) NSString *subtitle;
//是否可以显示CMapoutView
@property (nonatomic) BOOL canShowCallout;


//当前对应的大头针视图的选择情况
@property (assign, nonatomic) BOOL viewSelected;
//此属性用来设置大头针视图的选择情况，设置后更新大头针视图
@property (assign, nonatomic) BOOL setSelect;
//大头针视图被选择后调用
@property (copy, nonatomic) MapByUserBlock didSelectBlock;
//大头针视图取消选择后调用
@property (copy, nonatomic) MapBlock deSelectBlock;

//大头针视图被添加后调用
@property (copy, nonatomic) MapBlock didAddBlock;

//根据self.setSelect的值来更新大头针视图
- (void)updateAnnotationViewSelected;



//设置对应的AnnotationView的类
@property (strong, nonatomic) Class viewClass;
//设置大头针视图的image
@property (strong, nonatomic) UIImage *image;
//设置大头针视图被选择后的image
@property (strong, nonatomic) UIImage *selectedImage;
//设置大头针视图大小
@property (assign, nonatomic) CGSize size;
//设置大头针视图被选择后的大小
@property (assign, nonatomic) CGSize selectedSize;
//设置大头针视图的浮动
@property (assign, nonatomic) CGPoint centerOffset;
//设置大头针视图被选择后的浮动
@property (assign, nonatomic) CGPoint selectedCenterOffset;

//初始化可复用的大头针视图
- (MapAnnotationView *)dequeueReusableAnnotationView;
//获取当前对应的大头针视图
- (MapAnnotationView *)annotationView;

+ (MapAnnotation *)annotationByPoint:(NSValue *)value annotationClass:(Class)annotationClass;

@end;




