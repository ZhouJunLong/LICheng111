//
//  TitleCell.h
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleModel;
@interface TitleCell : UITableViewCell

@property (nonatomic,strong)TitleModel *titleModel;


@property (nonatomic,strong)UIImageView * iconView;//三角图标
@property (nonatomic,strong)UILabel *titleLabel;//标题

@property (nonatomic,strong)UILabel *moreLabel;//更多

@property (nonatomic,strong)UIImageView *arrowsV ;//箭头
@end
