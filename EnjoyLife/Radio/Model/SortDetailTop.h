//
//  SortDetailTop.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortDetailTop : NSObject

@property (nonatomic,assign)NSInteger albumId;
@property (nonatomic,assign)NSInteger categoryId;
@property (nonatomic,strong)NSString *categoryName;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *coverOrigin;
@property (nonatomic,strong)NSString *coverSmall;
@property (nonatomic,assign)NSInteger uid;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *avatarPath;
@property (nonatomic,strong)NSString *intro;
@property (nonatomic,assign)NSInteger playTimes;


@end
