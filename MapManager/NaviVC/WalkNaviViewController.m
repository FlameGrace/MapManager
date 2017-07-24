//
//  MapWalkNaviViewController.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/4/12.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "WalkNaviViewController.h"
#import "MapManagerHeader.h"



@interface WalkNaviViewController () <AMapNaviWalkViewDelegate>


@property (strong, nonatomic)AMapNaviWalkView *walkView;


@end

@implementation WalkNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[MapManager sharedManager].mapNaviWalk addDataRepresentative:self.walkView];
    [[MapManager sharedManager].mapNaviWalk startGPSNavi];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[MapManager sharedManager].mapNaviWalk removeDataRepresentative:self.walkView];
}



- (void)walkViewCloseButtonClicked:(AMapNaviWalkView *)walkView
{
    [[MapManager sharedManager].mapNaviWalk stopNavi];
    if(self.backBlock)
    {
       self.backBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (AMapNaviWalkView *)walkView
{
    if (!_walkView)
    {
        _walkView = [[AMapNaviWalkView alloc] initWithFrame:CGRectMake(0, 20, MainScreenWidth, MainScreenHeight-20)];
        _walkView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_walkView setDelegate:self];
        _walkView.showMoreButton = NO;
        [self.view addSubview:_walkView];
    }
    return _walkView;
}


@end
