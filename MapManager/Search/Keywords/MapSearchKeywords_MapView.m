//
//  MapSearchKeywords_MapView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/4/20.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapSearchKeywords_MapView.h"
#import "MapManagerHeader.h"
#import "MapDrawPoint.h"

@interface MapSearchKeywords_MapView()

@property (strong,nonatomic)  MapDrawPoint *draw;
@property (readwrite,strong,nonatomic)  NSMutableArray *results;
@property (strong, nonatomic) NSString *annotationViewIdentifier;

@end

@implementation MapSearchKeywords_MapView

@synthesize delegate = _delegate;

- (instancetype)init
{
    if(self = [super init])
    {
        self.draw = [[MapDrawPoint alloc]init];
        self.annotationViewIdentifier = [[NSUUID UUID] UUIDString];
        [[MapManager sharedManager]addMultiDelegate:self];
    }
    return self;
}

- (void)setShowAnnotaions:(BOOL)showAnnotaions
{
    _showAnnotaions = showAnnotaions;
    self.draw.showAnnotations = showAnnotaions;
}

- (void)showInMapCenter
{
    if(self.results)
    [self.draw showInMapCenter];
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search didSelectMapLocation:(SearchMapLocation *)mapLocation byUser:(BOOL)byUser
{
    if([self.delegate respondsToSelector:@selector(mapSearchKeywords:didSelectMapLocation:byUser:)])
    {
        [self.delegate mapSearchKeywords:search didSelectMapLocation:mapLocation byUser:byUser];
    }
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search deselectMapLocation:(SearchMapLocation *)mapLocation
{
    if([self.delegate respondsToSelector:@selector(mapSearchKeywords:deselectMapLocation:)])
    {
        [self.delegate mapSearchKeywords:search deselectMapLocation:mapLocation];
    }
}

- (void)mapSearchKeywords:(MapSearchKeywords *)search result:(NSArray *)result returnType:(MapSearchKeywordsReturnType)type
{
    if(!self.results)
    {
        self.results = [[NSMutableArray alloc]init];
    }
    
    if(type != MapSearchKeywordsReturnSuggestCitys)
    {
        NSMutableArray *annotations = [[NSMutableArray alloc]init];
        for (AMapPOI *poi in result) {
            
            SearchMapLocation *mapLocation = [SearchMapLocation modelByCoordinate:[MapManager transformAMapGeoPoint:poi.location]];
            [MapManager updateMapLocation:mapLocation byAMapPOI:poi];
            [self.results addObject:mapLocation];

            SearchMapAnnotation *annotation = [[SearchMapAnnotation alloc]init];
            annotation.coordinate = [MapManager transformAMapGeoPoint:poi.location];
            annotation.identifier = self.annotationViewIdentifier;
            WeakObj(self)
            annotation.didSelectBlock = ^(BOOL byUser) {
                StrongObj(self)
                [self mapSearchKeywords:self didSelectMapLocation:mapLocation byUser:byUser];
            };
            annotation.deSelectBlock = ^{
                StrongObj(self)
                [self mapSearchKeywords:self deselectMapLocation:mapLocation];
            };
            mapLocation.annotation = annotation;
            [annotations addObject:annotation];
        }
        [self.draw addMapAnnotations:annotations];
        [self.draw showInMapCenter];
        result = [NSArray arrayWithArray:self.results];
    }
    
    if([self.delegate respondsToSelector:@selector(mapSearchKeywords:result:returnType:)])
    {
        [self.delegate mapSearchKeywords:search result:result returnType:type];
    }
    
}

- (void)clear
{
    self.results = nil;
    [self.draw clear];
}

- (void)dealloc
{
    [self clear];
}


- (NSMutableArray *)annotations
{
    return self.draw.annotations;
}

@end
