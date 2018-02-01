//
//  MapSearch.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearch.h"


@interface MapSearch()

@property (readwrite ,strong, nonatomic) NSMutableDictionary <NSString *, MapSearchObject *> *searchs;

@end

@implementation MapSearch


- (instancetype)init
{
    if(self =[super init])
    {
        [[MapManager sharedManager]addMultiDelegate:self];
    }
    return self;
}


- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [self failureAfterSearchByRequest:request error:error];
}


- (void)searchForSearchObject:(MapSearchObject *)searchObject
{
    if(searchObject.searchSelector == NULL || searchObject.callback == NULL || searchObject.request == NULL)
    {
        return;
    }
    self.newestSearch = searchObject;
    searchObject.response = nil;
    searchObject.error = nil;
    if([[MapManager sharedManager].mapSearch respondsToSelector:searchObject.searchSelector])
    {
        [self.searchs setObject:searchObject forKey:[NSString stringWithFormat:@"%p",searchObject.request]];
        [[MapManager sharedManager].mapSearch performSelector:searchObject.searchSelector withObject:searchObject.request];
    }
    return;
}

- (void)successAfterSearchByRequest:(AMapSearchObject *)request response:(AMapSearchObject *)response
{
    NSString *identifier = [NSString stringWithFormat:@"%p",request];
    MapSearchObject *object = [self.searchs objectForKey:identifier];
    if(!object)
    {
        return;
    }
    [self.searchs removeObjectForKey:identifier];
    object.response = response;
    MapSearchcallback callback = object.callback;
    
    if(callback)
    {
        BOOL isNewest = [object isEqual:self.newestSearch]&&self.newestSearch;
        callback(object,isNewest);
    }
    
}

- (void)failureAfterSearchByRequest:(AMapSearchObject *)request error:(NSError *)error
{
    NSString *identifier = [NSString stringWithFormat:@"%p",request];
    MapSearchObject *object = [self.searchs objectForKey:identifier];
    if(!object)
    {
        return;
    }
    [self.searchs removeObjectForKey:identifier];
    object.error = error;
    MapSearchcallback callback = object.callback;
    if(callback)
    {
        BOOL isNewest = [object isEqual:self.newestSearch]&&self.newestSearch;
        callback(object,isNewest);
    }
    
}



- (NSMutableDictionary<NSString *,MapSearchObject *> *)searchs
{
    if(!_searchs)
    {
        _searchs = [[NSMutableDictionary alloc]init];
    }
    return _searchs;
}

- (void)dealloc
{
    [[MapManager sharedManager]removeMultiDelegate:self];
}

@end
