
//
//  RelatedModel.m
//  EnjoyLife
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "RelatedModel.h"

@implementation RelatedModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"files"]) {
        NSArray *arr = value;
        for (NSDictionary *dic in arr) {
            NSString *str = [dic objectForKey:@"mediaUrl"];
            if ([[str substringFromIndex:str.length - 3]isEqualToString:@"jpg"]) {
                self.mediaUrl = str;
            }
        }
    } 
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
