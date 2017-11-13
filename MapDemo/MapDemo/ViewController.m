//
//  ViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/26.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "ViewController.h"
#import "TableViewCellModel.h"
#import "MapPointViewController.h"
#import "SimulateRouteViewController.h"
#import "KeyWordsViewController.h"
#import "MapInputTipsViewController.h"
#import "DrawLineViewController.h"
#import "DrawRouteViewController.h"
#import "DrawDriveRecordViewController.h"
#import "MapFenceViewController.h"
#import <NetworkExtension/NEHotspotConfigurationManager.h>

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *vcs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typicMapy from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadDataSource];
}

- (void)loadDataSource
{
    self.vcs = [[NSMutableArray alloc]init];
    TableViewCellModel *point = [TableViewCellModel model];
    point.title = @"标注点";
    point.controllerClass = [MapPointViewController class];
    [self.vcs addObject:point];
    
    TableViewCellModel *drawLine = [TableViewCellModel model];
    drawLine.title = @"画线";
    drawLine.controllerClass = [DrawLineViewController class];
    [self.vcs addObject:drawLine];
    
    TableViewCellModel *drawRoute = [TableViewCellModel model];
    drawRoute.title = @"画路径规划";
    drawRoute.controllerClass = [DrawRouteViewController class];
    [self.vcs addObject:drawRoute];
    
    TableViewCellModel *drawRecord = [TableViewCellModel model];
    drawRecord.title = @"画行车轨迹";
    drawRecord.controllerClass = [DrawDriveRecordViewController class];
    [self.vcs addObject:drawRecord];
    
    
    TableViewCellModel *searchKeywords = [TableViewCellModel model];
    searchKeywords.title = @"关键字搜索";
    searchKeywords.controllerClass = [KeyWordsViewController class];
    [self.vcs addObject:searchKeywords];
    
    TableViewCellModel *inputTips = [TableViewCellModel model];
    inputTips.title = @"关键字提示";
    inputTips.controllerClass = [MapInputTipsViewController class];
    [self.vcs addObject:inputTips];
    
    
    TableViewCellModel *route = [TableViewCellModel model];
    route.title = @"车辆移动";
    route.controllerClass = [SimulateRouteViewController class];
    [self.vcs addObject:route];

    
    TableViewCellModel *drawFence = [TableViewCellModel model];
    drawFence.title = @"画电子围栏";
    drawFence.controllerClass = [MapFenceViewController class];
    [self.vcs addObject:drawFence];
    
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCellModel *model = self.vcs[indexPath.row];
    if(model.controllerClass)
    {
        UIViewController *vc = [[model.controllerClass alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if(model.didSelectBlock)
    {
        model.didSelectBlock(tableView,indexPath);
        return;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseIdentifier"];
    TableViewCellModel *model = self.vcs[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vcs.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}




@end
