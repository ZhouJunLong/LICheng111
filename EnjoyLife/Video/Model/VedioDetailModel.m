//
//  VedioDetailModel.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "VedioDetailModel.h"

@implementation VedioDetailModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"102"]) {
        _mediaUrl = [value objectForKey:@"mediaUrl"];

    }
    
    
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



@end
