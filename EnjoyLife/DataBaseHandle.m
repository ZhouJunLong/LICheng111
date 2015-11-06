//
//  DataBaseHandle.m
//  EnjoyLife
//
//  Created by LiCheng on 15/11/4.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "DataBaseHandle.h"
#import "SortDetailList.h"

// 数据库指针对象 (单例), 访问的都是这一个 db
static sqlite3 *db = nil;

@implementation DataBaseHandle


// 打开数据库
+ (sqlite3 *)open
{
    @synchronized(self)
    {
        if (db != nil) {
            
            return db;
            
        }else{
            
            NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *dbPath = [documents stringByAppendingPathComponent:@"Radio.sqliet"];
            
            int result = sqlite3_open(dbPath.UTF8String, &db);
            
            if (result == SQLITE_OK) {
                
                NSString *sqlStr = @"create table 'RadioInfo' (trackId text primary key not null, title text, playerURL text, playtimes text ,data BLOB) ";
                
                int result = sqlite3_exec(db, sqlStr.UTF8String, nil, nil, nil);
                if (result == SQLITE_OK)
                {
                    NSLog(@"表创建成功");
                }
            }
            return db;
        }
    }
}

// 关闭数据库
+ (void)close
{
    sqlite3_close(db);
    
    // 关闭数据时, 要将 数据库指针 置为 空
    db = nil;
    
}

// ---------- radio ------------
#pragma mark--- 电台 数据库操作

// 添加 某个电台
+ (BOOL)insertNewRadio:(SortDetailList *)detalModel
{
    BOOL isSuccess = NO;
    // 1. 打开数据库
    sqlite3 *db =  [self open];
    
    // 2. 创建 sql语句对象 stmt
    sqlite3_stmt *stmt = nil;
    
    // 3. 创建sql语句
    NSString *sqlString = [NSString stringWithFormat:@"insert into RadioInfo values('%ld','%@','%@','%ld', '%@')", detalModel.trackId, detalModel.title, detalModel.playUrl64, detalModel.playtimes,detalModel.coverMiddle];
    
    // 4. 预编译  预执行  prepare
    int result = sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, nil);
    
    // 如果预编译成功
    if (result == SQLITE_OK) {
        
        // 5. 归档key 标识
        NSString *achiverKey = [NSString stringWithFormat:@"Radio_%ld",detalModel.trackId];
        NSLog(@"+++%@",achiverKey);
        
        
        // 将对象进行归档 转化为data
        NSMutableData * data = [NSMutableData data];
        
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:detalModel forKey:achiverKey];
        [archiver finishEncoding];
        
                // 7.  执行 sql 对象tsmt   step
        sqlite3_step(stmt);
        
        isSuccess = YES;
    }
    // 8.  释放 sql 对象 stmt
    sqlite3_finalize(stmt);
    
    return isSuccess;

}

//// 查询 某个电台
//+ (SortDetailList *)selectRadioWithID:(NSString *)ID
//{
//    SortDetailList *detailModel = nil;
//    
//    // 1. 打开数据库 db
//    sqlite3 *db = [self open];
//    
//    // 2. sql对象  stmt
//    sqlite3_stmt *stmt  = nil;
//    // sql 语句
//    NSString *sqlString = [NSString stringWithFormat:@"select data from ActivityInfo where trackId = '%@'", ID];
//    
//    // 3. 预编译  prepare
//    int result = sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, nil);
//    
//    // 4.判断 预编译是否成功
//    if (result == SQLITE_OK) {
//        
//        // 5. 如果成功
//        // 执行 sql 返回 SQLITE_ROW  当前行,并指向下一行, 直到没有值, 返回 SQLITE_DOWN
//        if (sqlite3_step(stmt) == SQLITE_ROW) {
//            
//            
//            // 6. 将 bytes 转化为 data类型
//            //dataWithBytes:blob   legth:bytes
//            //            sqlite3_column_text(sqlite3_stmt *, int iCol)
//            
//            // bytes -> oc Data
//            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
//            
//            
//            // 7. 反归档
//            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//            NSString *key = [NSString stringWithFormat:@"%@%@", kActivityArchiverKey,ID];
//            activity =  [unarchiver decodeObjectForKey:key];
//            [unarchiver finishDecoding];
//            [unarchiver release];
//        }
//    }
//    // 8 .释放
//    sqlite3_finalize(stmt);
//    
//    //安全判断
//    if (activity != nil) {
//        NSLog(@"从数据库中取数据反归档成功");
//        NSLog(@"%@", activity);
//        return activity;
//    }  else{
//        NSLog(@"取数据出错");
//        NSLog(@"%@", activity);
//        return nil;
//    }
//
//}
//
//// 查询 所有电台
//+ (NSArray *)selectAllRadios
//{
//    
//}
//
//// 判断电台是否被收藏
//+ (BOOL)isFavoriteRadioWithID:(NSString *)ID
//{
//    
//}
//


@end
