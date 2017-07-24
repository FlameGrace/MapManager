//
//  LeftSettingModel.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/10.
//  Copyright © 2016年 flamegrace@hotmail.com. Map rights reserved.
// 主要用来作为普通UITableViewCell的model, 带有标题，图片，将要跳转的UIViewController的class

#import <Foundation/Foundation.h>

@class UITableView,NSIndexPath,UIViewController;

typedef void(^TableViewCellDidSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface TableViewCellModel : NSObject
/**
 cell标题
  */
@property (strong, nonatomic) NSString *title;
/**
 cell副标题
  */
@property (strong, nonatomic) NSString *detailTitle;
/**
 cell图片
  */
@property (strong, nonatomic) NSString *imageName;
/**
 点击后的回调函数
 */
@property (strong, nonatomic) TableViewCellDidSelectBlock didSelectBlock;
/**
 cell要跳转的UIViewController的class
  */
@property (strong, nonatomic) Class controllerClass;
/**
 model的标志符，辅助判断
  */
@property (strong, nonatomic) NSString *identifer;

+ (instancetype)model;


@end
