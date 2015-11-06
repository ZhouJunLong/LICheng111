//
//  NewsDetailModel.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"title"]) {
        self.Title = value;
    }
}

@end
