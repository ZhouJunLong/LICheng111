//
//  FocusCell.h
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//



//焦点轮播图
#import <UIKit/UIKit.h>

@class FocusModel;
@interface FocusCell : UITableViewCell
@property (nonatomic,strong)FocusModel *focusModel;

@property (nonatomic,strong) UITapGestureRecognizer *tap;

//轮播图
//@property (nonatomic,strong)UIImageView *imagev;

@property (nonatomic,strong)NSMutableArray *imageArray;

@property (nonatomic,strong)NSMutableArray *focusModelArray;

@property (nonatomic,strong)UIImageView
*imageV;

@end
