//
//  NewsDetailModel.h
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong)NSString *digest;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSArray *img;

@property (nonatomic, strong) NSString *replyBoard;
@property (nonatomic, strong) NSString *docid;

@end
