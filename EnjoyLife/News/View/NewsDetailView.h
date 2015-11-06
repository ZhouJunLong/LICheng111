//
//  NewsDetailView.h
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsDetailViewCell;
@class NewsDetailModel;

@interface NewsDetailView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NewsDetailModel *newsDetailModel;
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NewsDetailViewCell *cell;

@property (nonatomic, strong) NSString *str;

@end
