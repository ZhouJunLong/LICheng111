//
//  SortDetailViewController.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SortDetailList;
@interface SortDetailViewController : UIViewController

@property (nonatomic, strong)SortDetailList *sortListModel;
@property (nonatomic,assign)NSInteger albumId;
@end
