//
//  SortListViewController.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright © 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SortListView;
@class SegView;

@interface SortListViewController : UIViewController
@property (nonatomic,strong)NSMutableArray *segArr;
@property (nonatomic,strong)SortListView *sortListView;
@property (nonatomic, strong)SegView *segView;
@property (nonatomic, strong)NSString *string;


@property (nonatomic,strong)UIView *contentView;
@end
