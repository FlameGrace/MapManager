//
//  MapSearch+Search.h
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearch.h"

@interface MapSearch (Search)

- (void)searchKeywords:(NSString *)keywords
                  city:(NSString *)city
             cityLimit:(BOOL)cityLimit
                offset:(NSInteger)offset
           currentPage:(NSInteger)currentPage
                 types:(NSString *)types
              callback:(MapSearchcallback)callback;


- (void)searchInputTips:(NSString *)keywords
                  city:(NSString *)city
             cityLimit:(BOOL)cityLimit
                  types:(NSString *)types
              location:(NSString *)location
              callback:(MapSearchcallback)callback;

- (void)searchAroundByLocation:(CLLocationCoordinate2D)coordinate
                   keyWords:(NSString *)keywords
                        radius:(CGFloat)radius
                      sortrule:(NSInteger)sortrule
                         types:(NSString *)types
                        offset:(NSInteger)offset
                   currentPage:(NSInteger)currentPage
                      callback:(MapSearchcallback)callback;

- (void)searchUid:(NSString *)uid callback:(MapSearchcallback)callback;

- (void)searchSharedUid:(NSString *)uid
             coordinate:(CLLocationCoordinate2D)coordinate
                   name:(NSString *)name
                address:(NSString *)address
               callback:(MapSearchcallback)callback;

- (void)searchDistrictForKeywords:(NSString *)keywords regionPoints:(BOOL)regionPoints callback:(MapSearchcallback)callback;

- (void)searchRegeocodeForLocation:(CLLocationCoordinate2D)coordinate radius:(CGFloat)radius requireExtension:(BOOL)requireExtension callback:(MapSearchcallback)callback;

- (void)searchDrivingRouteBetweenOrigin:(CLLocationCoordinate2D)origin
                           andDestination:(CLLocationCoordinate2D)destination
                                 strategy:(NSInteger)strategy
                         requireExtension:(BOOL)requireExtension
                                 callback:(MapSearchcallback)callback;

@end
