//
//  SortDetailTopView.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SortDetailTop;

@interface SortDetailTopView : UIView
@property (nonatomic, strong)SortDetailTop *detailTop; // 数据模型

@property (nonatomic,strong)UIImageView *bgImageV; // 背景图片
@property (nonatomic,strong)UIImageView *bgImageVV; // 挡板

@property (nonatomic, strong)UIImageView *play; // 返回按钮

@property (nonatomic, strong)UILabel *titleL; // 标题

@property (nonatomic,strong)UIImageView *sideV; // 方块图片
@property (nonatomic,strong)UIImageView *sideVV; // 方块图片
@property (nonatomic, strong)UILabel *playCountL; // 播放次数

@property (nonatomic,strong)UIImageView *circleV; // 圆图片
@property (nonatomic, strong)UILabel *nameL; // 广播者


@property (nonatomic, strong)UILabel *desL; // 描述
@property (nonatomic, strong)UIImageView *des;


@property (nonatomic, strong)UIButton *desB;

@end
