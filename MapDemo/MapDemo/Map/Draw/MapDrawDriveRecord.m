//
//  MapDrawRecord.m
//  SimpleProject
//
//  Created by Flame Grace on 2017/6/29.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapDrawDriveRecord.h"
#import "TurnMapAnnotation.h"
#import "BrakeMapAnnotation.h"
#import "SpeedUpMapAnnotation.h"


@interface MapDrawDriveRecord()

@property (strong, nonatomic) NSMutableArray *turns;
@property (strong, nonatomic) NSMutableArray *brakes;
@property (strong, nonatomic) NSMutableArray *speedUps;

@end

@implementation MapDrawDriveRecord


- (instancetype)init
{
    if(self = [super init])
    {
        self.speedUps = [[NSMutableArray alloc]init];
        self.brakes = [[NSMutableArray alloc]init];
        self.turns = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)setRoute:(MapDriveRecordObject *)route
{
    [self drawRoute:route];
}

- (void)setShowBrake:(BOOL)showBrake
{
    if(showBrake == _showBrake)
    {
        return;
    }
    _showBrake = showBrake;
    if(_showBrake)
    {
        [self.drawPoint addMapAnnotations:self.brakes];
    }
    else
    {
        [self.drawPoint removeMapAnnotations:self.brakes];
    }
}

- (void)setShowTurn:(BOOL)showTurn
{
    if(showTurn == _showTurn)
    {
        return;
    }
    _showTurn = showTurn;
    if(_showTurn)
    {
        [self.drawPoint addMapAnnotations:self.turns];
    }
    else
    {
        [self.drawPoint removeMapAnnotations:self.turns];
    }
}


- (void)setShowSpeedUp:(BOOL)showSpeedUp
{
    if(showSpeedUp == _showSpeedUp)
    {
        return;
    }
    _showSpeedUp = showSpeedUp;
    if(_showSpeedUp)
    {
        [self.drawPoint addMapAnnotations:self.speedUps];
    }
    else
    {
        [self.drawPoint removeMapAnnotations:self.speedUps];
    }
}


- (void)drawRoute:(MapDriveRecordObject *)route
{
    [super drawRoute:route];
    
    //画急刹车
    for (NSValue *point in route.brakePoints) {
        MapAnnotation *anno = [MapAnnotation annotationByPoint:point annotationClass:[BrakeMapAnnotation class]];
        [self.brakes addObject:anno];
    }
    if(self.showBrake)
    {
        [self.drawPoint addMapAnnotations:self.brakes];
    }
    
    //画急转弯
    for (NSValue *point in route.turnPoints) {
        MapAnnotation *anno = [MapAnnotation annotationByPoint:point annotationClass:[TurnMapAnnotation class]];
        [self.turns addObject:anno];
    }
    if(self.showTurn)
    {
        [self.drawPoint addMapAnnotations:self.turns];
    }
    
    //画急加速
    for (NSValue *point in route.speedingUpPoints) {
        MapAnnotation *anno = [MapAnnotation annotationByPoint:point annotationClass:[SpeedUpMapAnnotation class]];
        [self.speedUps addObject:anno];
    }
    if(self.showSpeedUp)
    {
        [self.drawPoint addMapAnnotations:self.speedUps];
    }
    
}


- (void)clear
{
    [super clear];
    self.brakes = [[NSMutableArray alloc]init];
    self.turns = [[NSMutableArray alloc]init];
    self.speedUps = [[NSMutableArray alloc]init];
}

@end
