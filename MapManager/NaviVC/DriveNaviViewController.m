//
//  MapDriveNaviViewController.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/4/12.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//


#import "DriveNaviViewController.h"
#import "MapManagerHeader.h"

@interface MapDriveNaviViewController () <AMapNaviDriveViewDelegate>

@property (strong, nonatomic) AMapNaviDriveView *driveView;

@end

@implementation MapDriveNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    [[MapManager sharedManager].mapNaviDrive stopNavi];
    if(self.backBlock)
    {
        self.backBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[MapManager sharedManager].mapNaviDrive addDataRepresentative:self.driveView];
    [[MapManager sharedManager].mapNaviDrive startGPSNavi];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[MapManager sharedManager].mapNaviDrive removeDataRepresentative:self.driveView];
}


- (AMapNaviDriveView *)driveView
{
    if (!_driveView)
    {
        _driveView = [[AMapNaviDriveView alloc] initWithFrame:MainScreenBounds];
        _driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_driveView setDelegate:self];
        _driveView.showMoreButton = NO;
        [self.view addSubview:_driveView];
    }
    return _driveView;
}

@end
