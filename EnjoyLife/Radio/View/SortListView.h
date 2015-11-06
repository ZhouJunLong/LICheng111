//
//  SortListView.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//


/**
 *  某一电台分类下的某一seg下 视图
 */
#import <UIKit/UIKit.h>

@interface SortListView : UIView

// tableView
@property (nonatomic, strong)UITableView *tableV;

// 模型数组, 用于接收解析的数据
@property (nonatomic, strong)NSMutableArray *array;
@end
