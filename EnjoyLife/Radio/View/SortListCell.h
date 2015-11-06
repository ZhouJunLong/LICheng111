//
//  SortListCell.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//


/**
 *  自定义 某一电台分类下的某一seg下 单元格
 */
#import <UIKit/UIKit.h>
@class SortListModel;

@interface SortListCell : UITableViewCell

// model
@property (nonatomic, strong)SortListModel *sortModel;

@property (nonatomic, strong)UIImageView *imageV; // 图片
@property (nonatomic, strong)UILabel *titleL; // 标题
@property (nonatomic, strong)UILabel *introL; // 描述
@property (nonatomic, strong)UILabel *playCountL; // 播放次数
@property (nonatomic, strong)UILabel *trackCountL; // 集数


@property (nonatomic, strong)UIImageView *playV;
@property (nonatomic, strong)UIImageView *trackV;
@property (nonatomic, strong)UIImageView *nextV;
@end
