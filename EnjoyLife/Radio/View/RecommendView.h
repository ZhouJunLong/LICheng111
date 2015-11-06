//
//  RecommendView.h
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusModel;
@interface RecommendView : UIView

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *titleModelArray;

@property (nonatomic,strong)NSMutableArray *focusModelArray;

@property (nonatomic,strong)NSMutableArray *imageArray;


@property (nonatomic,strong)FocusModel *focusModel;
@end
