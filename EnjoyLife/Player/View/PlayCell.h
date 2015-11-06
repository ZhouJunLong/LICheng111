//
//  PlayCell.h
//  EnjoyLife
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayDetailModel.h"
@interface PlayCell : UITableViewCell
@property (nonatomic,strong)UIImageView *imageLagerV;



@property (nonatomic,strong)PlayDetailModel *playDetailModel;
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)UIButton *favourB;//赞
@property (nonatomic,strong)UIButton *collectB;//收藏
@property (nonatomic,strong)UIButton *shareB;//分享
@property (nonatomic,strong)UIButton *timeB;//定时关闭

@property (nonatomic,strong)UILabel *favourL;//赞
@property (nonatomic,strong)UILabel *collectL;//收藏
@property (nonatomic,strong)UILabel *shareL;//分享
@property (nonatomic,strong)UILabel *timeL;//定时关闭


@property (nonatomic,strong)UILabel *currentL;//滚动当前时间
@property (nonatomic,strong)UILabel *endL;//总时间

@property (nonatomic,strong)UISlider *slider;//滚动条
@property (nonatomic,strong)UIButton *listB;//播放列表
@property (nonatomic,strong)UIButton *upB;//上一首
@property (nonatomic,strong)UIButton *playB;//播放
@property (nonatomic,strong)UIButton *pauseB;//暂停;
@property (nonatomic,strong)UIButton *nextB;//下一首










@end
