//
//  ScrollModel.m
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "ScrollModel.h"

@implementation ScrollModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    
    if ([key isEqualToString:@"memberItem"]) {
        NSDictionary *dic = value;
        _guid = [dic objectForKey:@"guid"];
    }
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
