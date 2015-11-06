//
//  SortDetailList.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortDetailList : NSObject


@property (nonatomic, assign)NSInteger trackId;
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, strong)NSString *playUrl64;
@property (nonatomic, strong)NSString *playUrl32;
@property (nonatomic, strong)NSString *playPathAacv164;
@property (nonatomic, strong)NSString *playPathAacv224;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)NSInteger duration;
@property (nonatomic, strong)NSString *coverSmall;
@property (nonatomic, strong)NSString *coverMiddle;
@property (nonatomic, assign)NSInteger playtimes;
@property (nonatomic, strong)NSString *nickname;


@end
