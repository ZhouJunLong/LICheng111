//
//  NewsDetailViewCell.h
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsDetailModel;
@interface NewsDetailViewCell : UITableViewCell




@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *digestLabel;

@property (nonatomic, strong) UIImageView *imagePic;

@property (nonatomic, strong) UILabel *imageLabel;
@property (nonatomic, strong) UILabel *BodyLabel;


@property (nonatomic, strong) NewsDetailModel *newsDetailModel;
@property (nonatomic, strong) NSString *str;

@property (nonatomic, assign) NSInteger imageHeight;
@end
