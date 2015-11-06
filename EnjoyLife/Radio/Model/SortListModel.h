//
//  SortListModel.h
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//



/**
 *  电台分类下 list model
 */
#import <Foundation/Foundation.h>

@interface SortListModel : NSObject

@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, assign)NSInteger albumId;
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, strong)NSString *intro;
@property (nonatomic, strong)NSString *nickname;
@property (nonatomic, strong)NSString *albumCoverUrl290;
@property (nonatomic, strong)NSString *coverMiddle;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *tags;
@property (nonatomic, assign)NSInteger tracks;
@property (nonatomic, assign)NSInteger tracksCounts;
@property (nonatomic, assign)NSInteger playsCounts;
@property (nonatomic, assign)NSInteger lastUptrackId;
@property (nonatomic, strong)NSString *lastUptrackTitle;
@property (nonatomic, assign)NSInteger lastUptrackAt;
@property (nonatomic, assign)NSInteger isFinished;
@property (nonatomic, assign)NSInteger serialState;



- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
