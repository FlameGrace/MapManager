//
//  MapSearch.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapSearchObject.h"



@interface MapSearch : NSObject <AMapSearchDelegate>

@property (readonly, nonatomic) NSMutableDictionary <NSString *, MapSearchObject *> *searchs;
//最新一次的请求
@property (weak, nonatomic) MapSearchObject *newestSearch;

- (void)searchForSearchObject:(MapSearchObject *)searchObject;

- (void)successAfterSearchByRequest:(AMapSearchObject *)request response:(AMapSearchObject *)response;

- (void)failureAfterSearchByRequest:(AMapSearchObject *)request error:(NSError *)error;

@end

#import "MapSearch+Search.h"
