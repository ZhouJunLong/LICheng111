//
//  SortDetailListCell.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.

#import <UIKit/UIKit.h>

@class SortDetailList;
@interface SortDetailListCell : UITableViewCell

@property (nonatomic, strong)SortDetailList *detailList;

@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UIImageView *playV;

@property (nonatomic, strong)UILabel *titleV;
@property (nonatomic, strong)UILabel *desL;
@property (nonatomic, strong)UIImageView *playCV;
@property (nonatomic, strong)UILabel *playCountL;
@property (nonatomic, strong)UILabel *durationL;
@property (nonatomic, strong)UIImageView *shijianV;

@end
