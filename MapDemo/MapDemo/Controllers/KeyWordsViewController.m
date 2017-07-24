//
//  MapSearchViewController.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "KeyWordsViewController.h"
#import "MapSearchKeywords_MapView.h"


@interface KeyWordsViewController ()<MapSearchKeywords_MapViewDelegate>

@property (strong, nonatomic) MapSearchKeywords_MapView *keyWordsSearch;

@end

@implementation KeyWordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.keyWordsSearch = [[MapSearchKeywords_MapView alloc]init];
    self.keyWordsSearch.delegate = self;
    self.keyWordsSearch.keywords = @"体育馆";
    self.keyWordsSearch.city = [[MapLocationManager sharedManager]currentCity];
    
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
    [self.keyWordsSearch startSearch];
}


-(void)mapSearchKeywords:(MapSearchKeywords *)search result:(NSArray *)result returnType:(MapSearchKeywordsReturnType)type
{
    [self.keyWordsSearch showInMapCenter];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search didFailToError:(NSError *)error
{
    [self alertText:@"didFailToError"];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search didSelectMapLocation:(SearchMapLocation *)mapLocation byUser:(BOOL)byUser
{
    [self alertText:@"didSelect"];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search deselectMapLocation:(SearchMapLocation *)mapLocation
{
    [self alertText:@"deselect"];
}

@end
