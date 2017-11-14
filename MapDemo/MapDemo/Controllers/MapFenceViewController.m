//
//  MapFenceViewController.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/5/19.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapFenceViewController.h"
#import "MapManagerHeader.h"
#import "MapDrawFenceView.h"
#import "CarLocationManager.h"
#import "CarSimulator.h"

typedef NS_ENUM(NSInteger, MapFenceDrawType) {
    MapFenceDrawTypeNormal = 0,
    MapFenceDrawTypeDistrict,
};


@interface MapFenceViewController ()<MapDrawFenceViewDelegate,MapFenceAMapViewModelDelegate,UIAlertViewDelegate>


@property (strong, nonatomic) MapDrawFenceView *fenceView;
@property (assign, nonatomic) MapFenceDrawType drawType;
@property (strong, nonatomic) UIButton *districtButton;
@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UIButton *reDrawButton;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIView *buttomView;
@property (strong, nonatomic) UIView *splitView;
@property (strong, nonatomic) UISegmentedControl *switchSegment;

@end

@implementation MapFenceViewController

static MapFenceAMapViewModel *fenced = nil;


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self observeNotification];
    [CarSimulator sharedSimulator].simulating = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCarLocations) name:CarLocationChangedNotification object:nil];
    [MapManager sharedManager].car.show = YES;
    self.fenceView = [[MapDrawFenceView alloc]initWithFrame:self.view.frame];
    self.fenceView.delegate = self;
    [self.view addSubview:self.fenceView];
    [self switchSegment];
    [self switchDrawType];
    self.splitView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, 0.5, 60)];
    self.splitView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    [self.buttomView addSubview:self.splitView];
    
}


#pragma NSNotification

- (void)updateCarLocations
{
    if(fenced && [MapManager sharedManager].car.location)
    {
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake([MapManager sharedManager].car.location.coordinate2D.longitude, [MapManager sharedManager].car.location.coordinate2D.latitude)];
        [fenced updateMonitorLocation:value];
    }
}

//显示tabbar，添加mapView
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    [[MapManager sharedManager].mapView setZoomLevel:16];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(showCar) withObject:nil afterDelay:2];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MapManager sharedManager].car.show = NO;
}

- (void)showCar
{
    [[MapManager sharedManager].car switchLocationInMapCenter];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [CarSimulator sharedSimulator].simulating = NO;
}


- (void)mapFenceView:(MapDrawFenceView *)fenceView drawAnNewFence:(MapFenceAMapViewModel *)fence
{
    fenced = fence;
    fenced.showPolyline = YES;
    fenced.delegate = self;
    [fenceView showInMapCenter];
    
}

- (void)mapFenceMonitorStatusChanged:(MapFenceAMapViewModel *)fence newStatus:(MapFenceStatus)newStatus oldStatus:(MapFenceStatus)oldStatus
{

    NSString *message = nil;
    
    if(oldStatus == MapFenceStatusUnknown)
    {
        if(newStatus == MapFenceStatusInside)
        {
            message = @"车辆现在在电子围栏中";
        }
        if(newStatus == MapFenceStatusOutside)
        {
            message = @"车辆现在在电子围栏外";
        }
    }
    if(oldStatus == MapFenceStatusInside)
    {
        if(newStatus == MapFenceStatusOutside)
        {
            message = @"车辆驶出电子围栏";
        }
    }
    if(oldStatus == MapFenceStatusOutside)
    {
        if(newStatus == MapFenceStatusInside)
        {
            message = @"车辆驶入电子围栏";
        }
    }
    
    if(message != nil)
    {
        if(fence.model.district.length >0&&fence.model.district)
        {
            message = [message stringByReplacingOccurrencesOfString:@"电子围栏" withString:fence.model.district];
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
    }
}


- (void)mapFenceViewDrawDistrict:(MapDrawFenceView *)fenceView failToError:(NSError *)error
{
    [self alertText:@"行政区域查询失败"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        UITextField *field = [alertView textFieldAtIndex:0];
        if(field.text.length>0)
        {
            [self.fenceView drawDistrict:field.text];
        }
    }
}


- (void)switchDrawType
{
    self.startButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 60);
    self.reDrawButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 60);
    if(self.drawType == MapFenceDrawTypeDistrict)
    {
        self.splitView.hidden = YES;
        self.startButton.hidden = YES;
        self.reDrawButton.hidden = YES;
        self.saveButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
        [self layoutRightItemWithTitle:@"编辑区域" target:self action:@selector(district)];
    }
    if(self.drawType == MapFenceDrawTypeNormal)
    {
        self.navigationItem.rightBarButtonItem = nil;
        self.splitView.hidden = NO;
        self.startButton.hidden = NO;
        self.reDrawButton.hidden = YES;
        [self reDraw];
        self.saveButton.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 60);
    }
}

- (void)start
{
    fenced = nil;
    [self.fenceView clean];
    self.startButton.hidden = YES;
    self.reDrawButton.hidden = NO;
    [self.fenceView draw];
}

- (void)reDraw
{
    fenced = nil;
    [self.fenceView clean];
    self.startButton.hidden = NO;
    self.reDrawButton.hidden = YES;
}

- (void)save
{
    self.startButton.hidden = NO;
    self.reDrawButton.hidden = YES;
}

- (void)back
{
    [self.fenceView clean];
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)district
{
    [self.fenceView clean];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"输入行政区域" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *field = [alertView textFieldAtIndex:0];
    field.text = nil;
    [alertView show];
}

- (void)handleSegementControlAction
{
    self.drawType = self.switchSegment.selectedSegmentIndex;
    [self switchDrawType];
}

- (UIButton *)saveButton
{
    if(!_saveButton)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _saveButton.backgroundColor = [UIColor whiteColor];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [self.buttomView addSubview:_saveButton];
    }
    return _saveButton;
}

- (UIButton *)reDrawButton
{
    if(!_reDrawButton)
    {
        _reDrawButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _reDrawButton.backgroundColor = [UIColor whiteColor];
        [_reDrawButton setTitle:@"撤销" forState:UIControlStateNormal];
        [_reDrawButton addTarget:self action:@selector(reDraw) forControlEvents:UIControlEventTouchUpInside];
        [self.buttomView addSubview:_reDrawButton];
    }
    return _reDrawButton;
}

- (UIButton *)startButton
{
    if(!_startButton)
    {
        _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _startButton.backgroundColor = [UIColor whiteColor];
        [_startButton setTitle:@"开始" forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.buttomView addSubview:_startButton];
    }
    return _startButton;
}

- (UIView *)buttomView
{
    if(!_buttomView)
    {
        _buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
        [self.view addSubview:_buttomView];
        _buttomView.layer.shadowColor = [UIColor blackColor].CGColor;
        _buttomView.layer.shadowOffset = CGSizeZero;
        _buttomView.layer.shadowOpacity = 0.5;
        _buttomView.layer.shadowRadius = 4;
    }
    return _buttomView;
}

- (UISegmentedControl *)switchSegment
{
    if(!_switchSegment)
    {
        _switchSegment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0,0,100, 35)];
        [_switchSegment insertSegmentWithTitle:@"普通围栏" atIndex:0 animated:NO];
        [_switchSegment insertSegmentWithTitle:@"区域围栏" atIndex:1 animated:NO];
        self.navigationItem.titleView = _switchSegment;
        _switchSegment.selectedSegmentIndex =0;//选择按下标
        _switchSegment.momentary =NO;//点完以后会起来,按钮(瞬间选中离开)默认为NO
//        _switchSegment.tintColor=[UIColor redColor];
        //[dubai]分度添加响应方式
        [_switchSegment addTarget:self action:@selector(handleSegementControlAction)forControlEvents:(UIControlEventValueChanged)];
    }
    return _switchSegment;
}



@end
