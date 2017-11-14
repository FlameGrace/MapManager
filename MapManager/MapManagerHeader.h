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

#define WeakObj(o)  __weak typeof(o) weak##o = o; //获取弱引用对象
#define StrongObj(o)  __strong typeof(o) o = weak##o;

#import "MapManager.h"
#import "MapManager+Tools.h"
#import "MapManager+Location.h"
#endif /* MapapManagerHeader_h */
