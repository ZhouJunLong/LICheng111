//
//  DataBaseHandle.h
//  EnjoyLife
//
//  Created by LiCheng on 15/11/4.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class SortDetailList;

@interface DataBaseHandle : NSObject

// 打开数据库
+ (sqlite3 *)open;

// 关闭数据库
+ (void)close;

// ---------- radio ------------
#pragma mark--- 电台 数据库操作

// 添加 某个电台
+ (BOOL)insertNewRadio:(SortDetailList *)detalModel;

// 查询 某个电台
+ (SortDetailList *)selectRadioWithID:(NSString *)trackId;

// 查询 所有电台
+ (NSArray *)selectAllRadios;

// 判断电台是否被收藏
+ (BOOL)isFavoriteRadioWithID:(NSString *)ID;

@end
