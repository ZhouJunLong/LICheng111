//
//  PlayDetailModel.h
//  EnjoyLife
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayDetailModel : NSObject
@property (nonatomic,assign)NSInteger uid;
@property (nonatomic,assign)NSInteger downloadSize;
@property (nonatomic,strong)NSString *downloadUrl;//下载的网址
@property (nonatomic,strong)NSString *albumTitle;//专辑名
@property (nonatomic,strong)NSString *playUrl32;//播放的网址


@property (nonatomic,strong)NSDictionary *userInfo;//用户信息

@property (nonatomic,assign)NSInteger activityId;

@property (nonatomic,strong)NSString *categoryName;//分类名称

@property (nonatomic,strong)NSString * richIntro;//简介

@property (nonatomic,assign)NSInteger  processState;

@property (nonatomic,strong)NSString * coverSmall;

@property (nonatomic,strong)NSString * playUrl64;//播放的网址

@property (nonatomic,assign)NSInteger  albumId;

@property (nonatomic,assign)NSInteger  status;

@property (nonatomic,strong)NSString * categoryId;//分类id

@property (nonatomic,strong)NSString * msg;

@property (nonatomic,strong)NSString * shares;

@property (nonatomic,strong)NSString * refSmallLogo;//作者头像

@property (nonatomic,strong)NSString * likes;

@property (nonatomic,strong)NSArray * images;//图片

@property (nonatomic,strong)NSString * ret;

@property (nonatomic,strong)NSString * userSource;

@property (nonatomic,assign)NSInteger  playtimes;//bof时常

@property (nonatomic,strong)NSString * coverLarge;//图片

@property (nonatomic,strong)NSString * title;//标题

@property (nonatomic,strong)NSString * createdAt;

@property (nonatomic,strong)NSString * downloadAacSize;

@property (nonatomic,strong)NSString * albumImage;

@property (nonatomic,strong)NSString * trackBlocks;

@property (nonatomic,strong)NSString * tags;//标签

@property (nonatomic,strong)NSString * trackId;

@property (nonatomic,strong)NSString * coverMiddle;

@property (nonatomic,strong)NSString * isPublic;

@property (nonatomic,strong)NSString * intro;//简介

@property (nonatomic,assign)NSInteger  duration;//持续时间

@property (nonatomic,strong)NSString * lyric;

@property (nonatomic,strong)NSString * downloadAacUrl;

@property (nonatomic,strong)NSString * playPathAacv164;

@property (nonatomic,strong)NSString * playPathAacv224;

@property (nonatomic,strong)NSString * comments;






@end
