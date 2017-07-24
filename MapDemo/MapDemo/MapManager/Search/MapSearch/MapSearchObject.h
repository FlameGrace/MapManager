//
//  MapSearchObject.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/27.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapManagerHeader.h"

@class MapSearchObject;

typedef void(^MapSearchcallback)(MapSearchObject *search, BOOL isNewest);

@interface MapSearchObject : NSObject
@property (strong, nonatomic)  AMapSearchObject *request;
@property (strong, nonatomic)  AMapSearchObject *response;
@property (strong, nonatomic)  NSError *error;
@property (copy, nonatomic)  MapSearchcallback callback;
@property (assign, nonatomic) SEL searchSelector;

- (instancetype)initWithRequest:(AMapSearchObject *)request callback:(MapSearchcallback)callback searchSelector:(SEL)searchSelector;


@end
