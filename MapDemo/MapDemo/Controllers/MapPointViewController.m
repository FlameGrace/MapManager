//
//  AMapPointViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapPointViewController.h"
#import "MapDrawPoint.h"
#import "TextMapAnnotationView.h"

@interface MapPointViewController ()



@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *removeButton;
@property (strong, nonatomic) UIButton *selectButton;

@property (strong, nonatomic) MapDrawPoint *draw;
@property (assign, nonatomic) double longitude;

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation MapPointViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addButton = [self buttonWithFrame:CGRectMake(0, 100, 50, 30) title:@"添加" selector:@selector(add)];
    self.removeButton = [self buttonWithFrame:CGRectMake(0, 150, 50, 30) title:@"移除" selector:@selector(remove)];
    self.selectButton = [self buttonWithFrame:CGRectMake(0, 200, 50, 30) title:@"选择" selector:@selector(select)];
    self.draw = [[MapDrawPoint alloc]init];
    self.array = [[NSMutableArray alloc]init];
    self.longitude = 112.001;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:MainScreenBounds];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
}


- (void)add
{
    self.longitude += 0.001;
    TextMapAnnotation *anotation = [[TextMapAnnotation alloc]init];
    anotation.identifier = @"AMapPoint";
    anotation.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.array.count+1];
    anotation.title = @"测试";
    anotation.size = CGSizeMake(40, 40);
    anotation.selectedSize = CGSizeMake(50, 50);
    anotation.selectedCenterOffset = CGPointMake(0, -5);
    anotation.subtitle = @"测试一下";
    anotation.canShowCallout = YES;
    anotation.backGroundColor = [UIColor grayColor];
    anotation.selectBackGroundColor = [UIColor redColor];
    anotation.coordinate = CLLocationCoordinate2DMake(30.001, self.longitude);
    __weak typeof(anotation) weakAnotation = anotation;
    anotation.didSelectBlock = ^(BOOL byUser) {
        if(byUser)
        {
            weakAnotation.setSelect = YES;
        }
    };
    anotation.deSelectBlock = ^{
    };
    [self.array addObject:anotation];
    [self.draw addMapAnnotations:self.array];
    [self.draw showInMapCenter];
}

- (void)remove
{
    [self.array removeAllObjects];
    [self.draw clear];
}

- (void)select
{
    MapAnnotation *anotation = [self.array firstObject];
    anotation.setSelect = !anotation.setSelect;
}

@end
