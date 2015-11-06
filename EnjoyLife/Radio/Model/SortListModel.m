//
//  SortListModel.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortListModel.h"

@implementation SortListModel


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.sid = [value intValue];
    }
}
@end
