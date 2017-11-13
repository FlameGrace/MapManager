//
//  MapInputTipsViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapInputTipsViewController.h"
#import "MapSearchInputTips.h"
#import "TableViewCellModel.h"

@interface MapInputTipsViewController () <MapSearchInputTipsDelegate, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (strong, nonatomic) MapSearchInputTips *inputTipsSearch;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tips;

@end

@implementation MapInputTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTipsSearch = [[MapSearchInputTips alloc]init];
    self.inputTipsSearch.delegate = self;
    self.tableView = [[UITableView alloc]initWithFrame:MainScreenBounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tips = [[NSMutableArray alloc]init];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.tips = [[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self startSeachrBar:searchBar];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self startSeachrBar:searchBar];
}

- (void)startSeachrBar:(UISearchBar *)searchBar
{
    self.tips = [[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    if(searchBar.text.length <1)
    {
        return;
    }
    self.inputTipsSearch.city = [[MapLocationManager sharedManager]currentCity];
    self.inputTipsSearch.keyword = searchBar.text;
    [self.inputTipsSearch startSearch];
}


- (void)mapSearchInputTips:(MapSearchInputTips *)search result:(NSArray *)result
{
    if(!result)
    {
        [self alertText:@"没有结果"];
        return;
    }
    
    for (MapSearchInputTipModel *tip in result) {
        TableViewCellModel *model = [TableViewCellModel model];
        model.title = [tip.name copy];
        if(tip.inputType == MapSearchInputKeyword)
        {
            model.title = [tip.tipKeyword copy];
        }
        [self.tips addObject:model];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}
- (void)mapSearchInputTips:(MapSearchInputTips *)search didFailToError:(NSError *)error
{
    [self alertText:[NSString stringWithFormat:@"error :%@",error]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCellModel *model = self.tips[indexPath.row];
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
    
    TableViewCellModel *model = self.tips[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tips.count;
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
