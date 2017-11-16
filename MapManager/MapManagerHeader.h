//
//  MapManagerHeader.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/28.
//  Copyright © 2017年 flamegrace@hotmail.com. Map rights reserved.
//

#ifndef MapapManagerHeader_h
#define MapapManagerHeader_h

typedef void(^MapVoidBlock)(void);

#define Map_WeakObj(o)  __weak typeof(o) weak##o = o; //获取弱引用对象
#define Map_StrongObj(o)  __strong typeof(o) o = weak##o;
#define Map_UIColor_HexA(rgb,a)   ([UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0f green:((float)((rgb & 0xFF00) >> 8))/255.0f blue:((float)(rgb & 0xFF))/255.0f alpha:a])

#import "MapManager.h"
#import "MapManager+Tools.h"
#import "MapManager+MapView.h"
#import "MapManager+Search.h"
#import "MapManager+Location.h"
#import "UserLocationManager.h"
#import "CarLocationManager.h"
#endif /* MapapManagerHeader_h */
