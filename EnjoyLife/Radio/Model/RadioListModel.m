//
//  RadioListModel.m
//  EnjoyLife
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "RadioListModel.h"

@implementation RadioListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
