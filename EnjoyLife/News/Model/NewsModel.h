//
//  NewsModel.h
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * digest;

@property (nonatomic, retain) NSNumber * replyCount;

@property (nonatomic, retain) NSString * docid;

@property (nonatomic, retain) NSString * imgsrc;

@property (nonatomic, retain) NSString * skipType;

@property (nonatomic, retain) NSArray * imgextra;

@property (nonatomic, assign) BOOL hasHead;

@property (nonatomic, retain) NSString * tname;

@property (nonatomic, retain) NSString * photosetID;

@property (nonatomic, retain) NSString * skipID;

@end
