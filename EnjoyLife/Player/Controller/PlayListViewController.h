//
//  PlayListViewController.h
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
//播放列表界面
@interface PlayListViewController : UIViewController

@property (nonatomic,strong)UITableView *tableView;




//用于接收播放列表的数组
@property (nonatomic,strong)NSMutableArray *sortDetailListModelArray;
@end
