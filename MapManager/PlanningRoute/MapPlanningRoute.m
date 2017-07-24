//
//  MapPlanningRoute.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/31.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#import "MapPlanningRoute.h"
#import<AVFoundation/AVFoundation.h>

@interface MapPlanningRoute() <AVSpeechSynthesizerDelegate>


@property (strong, nonatomic) AVSpeechSynthesizer *av;

@end

@implementation MapPlanningRoute

@synthesize draw = _draw;
@synthesize routes = _routes;


- (instancetype)init
{
    if(self = [super init])
    {
        self.draw = [[MapDrawRoute alloc]init];
    }
    
    return self;
}

- (void)showInMapCenter
{
    [self.draw showInMapCenter];
}

- (void)startPlanningRouteByStartPoint:(CLLocationCoordinate2D)start endPoint:(CLLocationCoordinate2D)end
{
    
}

- (void)playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    self.av= [[AVSpeechSynthesizer alloc]init];
    self.av.delegate=self;//挂上代理
    
    AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:soundString];//需要转换的文字
    utterance.rate=0.5;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
    AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
    utterance.voice= voice;
    [self.av speakUtterance:utterance];//开始
}


- (void)stopVoiceNavi
{
    [self.av stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}



- (void)dealloc
{
    [self clear];
    [self stopVoiceNavi];
}
/**
 *  画路线
 */
- (void)drawRoute
{
    
}

//移除路线
- (void)clear
{
    [self.draw clear];
    self.routes = nil;
}


@end
