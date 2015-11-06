//
//  Model2.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright © 2015年 Drop. All rights reserved.
//

#import "Model2.h"

@implementation Model2



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
