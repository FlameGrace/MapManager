//
//  MapSearchViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "KeyWordsViewController.h"
#import "MapSearchKeywords_MapView.h"

@interface KeyWordsViewController ()<MapSearchKeywords_MapViewDelegate,UISearchBarDelegate>

@property (strong, nonatomic) MapSearchKeywords_MapView *keyWordsSearch;

@end

@implementation KeyWordsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    self.keyWordsSearch = [[MapSearchKeywords_MapView alloc]init];
    self.keyWordsSearch.delegate = self;

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MapManager sharedManager]addMapViewToView:self.view withFrame:MainScreenBounds];
    [self.view sendSubviewToBack:[MapManager sharedManager].mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[MapLocationManager sharedManager]switchUserInMapCenter];
    
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
    self.keyWordsSearch.center = [MapLocationManager sharedManager].user.coordinate2D;
    [self.keyWordsSearch restartSearch:searchBar.text city:[[MapLocationManager sharedManager]currentCity]];
    [searchBar resignFirstResponder];
}


-(void)mapSearchKeywords:(MapSearchKeywords *)search result:(NSArray *)result returnType:(MapSearchKeywordsReturnType)type
{
    if(result.count == 0)
    {
        [self alertText:@"没有结果"];
    }
    [self.keyWordsSearch showInMapCenter];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search didFailToError:(NSError *)error
{
    [self alertText:[NSString stringWithFormat:@"error :%@",error]];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search didSelectMapLocation:(SearchMapLocation *)mapLocation byUser:(BOOL)byUser
{
    [self alertText:[NSString stringWithFormat:@"didSelect:%@",mapLocation.address]];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search deselectMapLocation:(SearchMapLocation *)mapLocation
{
    [self alertText:[NSString stringWithFormat:@"deselect:%@",mapLocation.address]];
}



@end
